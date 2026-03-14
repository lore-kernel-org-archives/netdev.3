Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4C82BE7DC
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773503112; cv=none; b=FUAy+kJTSNgURKtnM7+6KoL+Dkft8YLOfyTF4/e1qP6+W0ZMMGpDCanaRg2pQ4cKJxJgsVMcsLBTDFcG4YsS9nkVTp2MK0DbG+dZysH0y2Tf9ESmE9yVzTlGiHmsqaGYYa5xOJNP8ZltjojSADYqE9aEvSXKCyq8hG2U7gOvYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773503112; c=relaxed/simple;
	bh=ZIAI/j8BRn8YfpT/MlnHMtmzHz3iqWVWenZUSwnGPy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I36gNN49Rk89qFIDVdh3QpAtjNVmBcWDj/9gL8aSpx6egBLd8YCBC88JBwuaeTNQqRMeIgGULTHEZuzCW0VdTxGc7+YB4fuC10VN9iXge0vMzAJoOZqK6c+D1I8yRTfVP/9rTZ7Ivp7ievjBxhzhMEu59UdxXP11nNRTD4D8RDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qcbv+oMG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qcbv+oMG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDF1C116C6;
	Sat, 14 Mar 2026 15:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773503112;
	bh=ZIAI/j8BRn8YfpT/MlnHMtmzHz3iqWVWenZUSwnGPy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qcbv+oMGFA1WK2HXkTAxtC1bj+1YxF+oPigVoZ6RVeOJ3IvnzN0Wh/nwp0DXvzkGD
	 Ps6u8T2fVoxBxKhg5N0xT8W9EQ26V22KsNb7ZzO+9c2FXr/nwbuUgQY1i3RBLEow/1
	 Avcq06l2vATonk1ho/22SwwO4qtRKXsYNIO1pkGX2HQ/cq6ZokeFv7VyciTgXd6WxH
	 Sv/fVIv0GSozoUuA1nD8EeTwtoN4FCb/YL3URptVYgNYtIarOzZjV8lV0N7S0hbzfx
	 umMbXTAFV9Xu966qPXPsNAqHtx+SCZLqNr056niVjpWcGQAlsdoh/ELYJLavDW3RZy
	 Y9KUovQ7UWooQ==
Date: Sat, 14 Mar 2026 08:45:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 florian.fainelli@broadcom.com
Subject: Re: [PATCH net] net: bcmasp: fix double frees during remove
Message-ID: <20260314084510.14f17e59@kernel.org>
In-Reply-To: <02ddee5f-260d-47bc-a842-8938cddc55f5@broadcom.com>
References: <20260312200814.1977164-1-justin.chen@broadcom.com>
	<20260313165533.GA1368619@kernel.org>
	<02ddee5f-260d-47bc-a842-8938cddc55f5@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 13:21:13 -0700 Justin Chen wrote:
> >> - Switch to devm_clk_get_optional() instead of
> >>    devm_clk_get_optional_enabled() so we can manage the clock ourselves.  
> > 
> > But it is unclear to me what problem this is solving.
> > Or how it relates to the first point - usually the aim
> > is to have one fix per patch.
> > 
> > Could you elaborate?
> >   
> The double free happens because we double disable the clock. Guess it is 
> not exactly a double free. We manage the clock at the driver level so we 
> disable it when it is unneeded. The default state is clock disabled when
> no interfaces are up. After we bring down the interfaces, the clock is 
> disabled, then when we unbind the driver, it hits a double disable.

AI points out we're not missing a bunch of disable calls if we fail
further down in .probe

> Sure I can turn this into two fixes.

Yes, please
-- 
pw-bot: cr
