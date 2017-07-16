function main()

switch getenv('ENV')
case 'IUHPC'
	disp('loading paths (HPC)')
	addpath(genpath('/N/u/hayashis/BigRed2/git/jsonlab'))
    addpath(genpath('/N/u/hayashis/BigRed2/git/afq-master'))
    addpath(genpath('/N/u/hayashis/BigRed2/git/vistasoft'))
    addpath(genpath('/N/u/hayashis/BigRed2/git/mba'))
case 'VM'
	disp('loading paths (VM)')
	addpath(genpath('/usr/local/jsonlab'))
    addpath(genpath('/usr/local/afq-master'))
    addpath(genpath('/usr/local/vistasoft'))
    addpath(genpath('/usr/local/mba'))
end

% load config.json
config = loadjson('config.json');

%load afq output
load(config.AFQ)

view = config.view;
%camera view options: axial, sagittal, coronal
% axial is default

set(0, 'DefaultFigureVisible', 'off')

nifti = readFileNifti(config.t1);
mkdir('images')
for i = 1:length(fg_classified)
    figname = strcat('images/', fg_classified(i).name, '.png');
    figname = strrep(figname, ' ', '_');
    AFQ_RenderFibers(fg_classified(i), 'camera', view, 'color', [0 1 1])
    switch view
        case 'axial'
            mbaDisplayBrainSlice(nifti, [0 0 -10])
        case 'sagittal'
            mbaDisplayBrainSlice(nifti, [1 0 0])
        case 'coronal'
            mbaDisplayBrainSlice(nifti, [0 5 0])
    end
    saveas(gcf, figname)
	print(gcf, figname, '-dpng')
    close
end

% 
% for i = 1:1%length(fg_classified)
%     figname = strcat(fg_classified(i).name, '.png');
%     figname = strrep(figname, ' ', '_');
%     AFQ_RenderFibers(fg_classified(i), 'camera', 'axial', 'color', [0 1 1], 'subplot', [1, 3, 1])
%     mbaDisplayBrainSlice(nifti, [0 0 -10])
%     
%     AFQ_RenderFibers(fg_classified(i), 'camera', 'sagittal', 'color', [0 1 1], 'subplot', [1, 3, 2])
%     mbaDisplayBrainSlice(nifti, [1 0 0])
%     
%     AFQ_RenderFibers(fg_classified(i), 'camera', 'coronal', 'color', [0 1 1], 'subplot', [1, 3, 3])
%     mbaDisplayBrainSlice(nifti, [0 5 0])
% 
%     saveas(gcf, figname)
%     close
% end
