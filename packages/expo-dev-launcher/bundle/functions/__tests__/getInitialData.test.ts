import { getBuildInfoAsync } from '../../native-modules/DevLauncherInternal';
import { getSettingsAsync } from '../../native-modules/DevMenuInternal';
import { getDevSessionsAsync } from '../getDevSessionsAsync';
import { getInitialData } from '../getInitialData';
import { restoreUserAsync } from '../restoreUserAsync';

jest.mock('../getDevSessionsAsync');
jest.mock('../restoreUserAsync');

describe('getInitialData()', () => {
  test('calls all the fns we need', async () => {
    expect(getDevSessionsAsync).not.toHaveBeenCalled();
    expect(getBuildInfoAsync).not.toHaveBeenCalled();
    expect(getSettingsAsync).not.toHaveBeenCalled();
    expect(restoreUserAsync).not.toHaveBeenCalled();

    await getInitialData();

    expect(getDevSessionsAsync).toHaveBeenCalled();
    expect(getBuildInfoAsync).toHaveBeenCalled();
    expect(getSettingsAsync).toHaveBeenCalled();
    expect(restoreUserAsync).toHaveBeenCalled();
  });
});
