import Checkbox, { CheckboxProps } from 'expo-checkbox';
import { Container } from 'expo-stories/components';
import * as React from 'react';

interface ExampleProps {
  label?: string;
}

function CheckboxExample(props: CheckboxProps & ExampleProps) {
  const [value, setValue] = React.useState(false);

  return (
    <Container labelTop={props.label}>
      <Checkbox value={value} onValueChange={setValue} {...props} />
    </Container>
  );
}

export const Basic = () => <CheckboxExample label="Basic Example" />;

export const CustomColor = () => <CheckboxExample color="#4630EB" label="Custom Color" />;

CustomColor.storyConfig = {
  name: 'Rendering Custom Colors',
};

export const Disabled = () => <CheckboxExample disabled label="Disabled" />;

export const Styled = () => (
  <CheckboxExample style={{ height: 32, width: 32 }} label="Custom Style" />
);

export default {
  title: 'Checkbox',
};
