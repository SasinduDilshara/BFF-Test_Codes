import React from 'react';
import CustomButton from '../../components/CustomButton/CustomButton';
import { useAuthContext } from "@asgardeo/auth-react";

export default function HomePage() {
  const { state, signIn, signOut } = useAuthContext();
  
  return (
    <React.Fragment>
        <CustomButton color="primary" onClick={() => signIn()} disabled={false} label={"Log In"} size={'large'}/>
        <CustomButton color="primary" onClick={() => signIn()} disabled={false} label={"Register"} size={'large'}/>
    </React.Fragment>
  );
}