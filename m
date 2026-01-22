Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9023817F;
	Thu, 22 Jan 2026 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085009; cv=none; b=E5KORU8ERtccj7MnjCDF4oIy9U5NS9iQRXZY+qCDTRZ/ICSHSxuTTJTACmEMlwSsZAdpadKslQwC0suXUap1JTFDzwVJt+wML4fAGGVMjiSO5ZfdnGvjkBPyYPtP4CiOvDgbit4jmK3yqqpFI2sB6j2avEQPubgy4uuwnlAMxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085009; c=relaxed/simple;
	bh=/hjcCNFeMj8oOox0c8QBGx9VeHubGikBZuPrKcoaGY0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j5llba2HnzTE2BtFRHkt24+v8LeSp0inXUVwddqqeKXmMSiM0huOR965yRlhQFukZJw9/P25wvvulyyCKKEqdhL7p5UBA7ZnqRNU9AprCxGWVHuMcI+OyIHL2YzMzffO/IAtD8hkny8OgNKG9hb8nX0UI4UpyvRZgrVBgAqDqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V42jBl+5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V42jBl+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FDDC116C6;
	Thu, 22 Jan 2026 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769085008;
	bh=/hjcCNFeMj8oOox0c8QBGx9VeHubGikBZuPrKcoaGY0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V42jBl+5C2uRu41AQq7U4l2G7smrE2+KJE/11pzMwkx7PuuDemSytCunsO8QtXN4C
	 nI2BEvmUwCSOJWNWOtvmgjgYkb1vtN4iULjXvxFmjtOQulWVilzaIPwb9wXYmqC4og
	 6jD4M1HAPwqsP/XB4uKXfOaAA/bmfLrhrh+5PqmNVDpdWPodxtt5qgPgWqJOeffsoU
	 w1gVKcEaIFcl++Ng4RRPzISOdPjgw+9A28Fi6v2wM5av+Igwm+xC2RInwB18LG8vum
	 sQLiH2xU24DD34eIOYXIkCUcbJUxuOpxswiZg0aY9IoH3rO+NrBOHh54nh+/ODAp1C
	 yIrHHjlFRnylQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BAE33808200;
	Thu, 22 Jan 2026 12:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: fec: account for VLAN header in frame length
 calculations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176908500535.1702959.10720487953177513534.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 12:30:05 +0000
References: <20260121083751.66997-1-mail@clemensgruber.at>
In-Reply-To: <20260121083751.66997-1-mail@clemensgruber.at>
To: Clemens Gruber <mail@clemensgruber.at>
Cc: wei.fang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shenwei.wang@nxp.com, xiaoning.wang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, stable@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Jan 2026 09:37:51 +0100 you wrote:
> The MAX_FL (maximum frame length) and related calculations used ETH_HLEN,
> which does not account for the 4-byte VLAN tag in tagged frames. This
> caused the hardware to reject valid VLAN frames as oversized, resulting
> in RX errors and dropped packets.
> 
> Use VLAN_ETH_HLEN instead of ETH_HLEN in the MAX_FL register setup,
> cut-through mode threshold, buffer allocation, and max_mtu calculation.
> 
> [...]

Here is the summary with links:
  - [v2] net: fec: account for VLAN header in frame length calculations
    https://git.kernel.org/netdev/net/c/ca1bb3fedf26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


