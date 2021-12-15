import {
  View,
  Heading,
  Text,
  Row,
  XIcon,
  Spacer,
  Button,
  StatusIndicator,
  ChevronRightIcon,
  Divider,
} from 'expo-dev-client-components';
import * as React from 'react';
import { Alert, ScrollView } from 'react-native';

import { useDevSessions } from '../../hooks/useDevSessions';
import { useRecentlyOpenedApps } from '../../hooks/useRecentlyOpenedApps';
import { loadApp } from '../../native-modules/DevLauncherInternal';

export function DeepLinkModal({ onClosePress, pendingDeepLink }) {
  const { data: devSessions = [], isFetching: isFetchingDevSessions } = useDevSessions();
  const { data: apps = [], isFetching: isFetchingApps } = useRecentlyOpenedApps();

  const onDevSessionPress = ({ url }: { url: string }) => {
    loadApp(url).catch((error) => {
      Alert.alert('Oops', error.message);
    });
  };

  const isFetching = isFetchingDevSessions || isFetchingApps;
  const items = [...devSessions, ...apps];

  return (
    <View padding="large" style={{ flex: 1, justifyContent: 'center' }}>
      <View py="medium" rounded="large" bg="default" shadow="small">
        <Row px="medium" align="center">
          <Heading size="small">Deep link received:</Heading>
          <Spacer.Horizontal size="flex" />
          <Button.ScaleOnPressContainer
            bg="default"
            rounded="full"
            onPress={onClosePress}
            accessibilityHint="Close modal">
            <View padding="tiny">
              <XIcon />
            </View>
          </Button.ScaleOnPressContainer>
        </Row>

        <Spacer.Vertical size="small" />
        <View py="small" bg="secondary" rounded="medium" px="medium" mx="small">
          <Text type="mono" numberOfLines={3}>
            {pendingDeepLink}
          </Text>
        </View>

        <Spacer.Vertical size="large" />
        <View px="medium">
          {items.length > 0 ? (
            <ScrollView style={{ maxHeight: 300 }}>
              <Text size="large">Select an app to open it:</Text>

              <Spacer.Vertical size="medium" />
              {devSessions.length > 0 && (
                <View>
                  {devSessions.map((devSession, index, arr) => {
                    return (
                      <View key={devSession.url} rounded="medium">
                        <Button.Container onPress={() => onDevSessionPress(devSession)}>
                          <Row align="center" py="medium" px="small">
                            <StatusIndicator size="small" status="success" />
                            <Spacer.Horizontal size="small" />
                            <Text style={{ flexShrink: 1 }} numberOfLines={1}>
                              {devSession.description}
                            </Text>
                            <Spacer.Horizontal size="flex" />
                            <ChevronRightIcon />
                          </Row>
                        </Button.Container>
                        <Divider />
                      </View>
                    );
                  })}
                </View>
              )}

              {apps.length > 0 && (
                <View>
                  {apps.map((app, index, arr) => {
                    return (
                      <View key={app.url} rounded="medium">
                        <Button.Container onPress={() => onDevSessionPress(app)}>
                          <Row align="center" py="medium" px="small">
                            <StatusIndicator size="small" status="success" />
                            <Spacer.Horizontal size="small" />
                            <Text>{app.name}</Text>
                            <Spacer.Horizontal size="flex" />
                            <ChevronRightIcon />
                          </Row>
                        </Button.Container>
                        <Divider />
                      </View>
                    );
                  })}
                </View>
              )}
            </ScrollView>
          ) : (
            !isFetching && (
              <>
                <Text size="large" weight="medium">
                  Can't find any packagers
                </Text>

                <Spacer.Vertical size="medium" />

                <Text>The next app launched will receive the deep link above</Text>

                <Spacer.Vertical size="large" />
              </>
            )
          )}
        </View>

        <Spacer.Vertical size="large" />

        <View px="medium">
          <Text weight="bold">Note:</Text>
          <Text>The next app you open will receive this link</Text>

          <Spacer.Vertical size="medium" />

          <Button.ScaleOnPressContainer
            bg="ghost"
            rounded="medium"
            border="ghost"
            onPress={onClosePress}>
            <View py="small" px="medium">
              <Button.Text size="large" align="center" weight="semibold" color="ghost">
                Go back
              </Button.Text>
            </View>
          </Button.ScaleOnPressContainer>
        </View>
      </View>
    </View>
  );
}
