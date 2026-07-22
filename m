Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E604B42B318;
	Wed, 22 Jul 2026 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751072; cv=none; b=uicOSUibDXn+LywwOGBZfT4EDEOhod8A+4JYszpCYrACVM6MsjGRePj4ZxISqFHD1cHxaJ39qLXoqwO75gNBDGiV+TktZ6uX5DE+Y4kipIhYiQ45L0p5fL3/sO2xkMzRowQouQyvfiFQACZLf0D4cjmNAFis3XWSjmtjPgpHKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751072; c=relaxed/simple;
	bh=G6sLxSQ/7lX5CsOh95Xi6TimGjmlPTQ73TOfqIaImvE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sbp0qBBG+MgLpWMjEau1eRJEWOEl6RC32YypJv767WMMI15Oeqrl8FZ4jsb7FPmbBgPFEUlXc+MCpau9Gjvu1aPY8S1WW4RFs+TnzgP7L5jC5nN2/5f/dSN5bzjwYMpbyZrsgLCcdKI6yXg3XaDhZ2TRcBvNcnErRDuJQf1zMs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mmx6U+zp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mmx6U+zp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BB61F00A3A;
	Wed, 22 Jul 2026 20:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784751070;
	bh=fKEu2F8gUObBt/LSqfdmkZo7IVYgMxi8XazvdBSR/Ko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Mmx6U+zpJUnAbYi6BT2amL5PQ/+skyYc6sEx6DLyPCUFR2I4cLQJWk5Be1Zc3St7J
	 IXBNNn0FHKyk96C4KKOEFUovWN8aPbsYbjbBadiA6YfoLivd3LVJWXVD1r7dXSXrNx
	 0TRAgu3mLRl1cQlpq+rVQiR6f9BNi9XS8uwMSUXaW09v8v20heFpGjSLeqfbqPeurf
	 DZpjULbEhYMxF3o44YHQgKl1ZyKLoA4os2SLP0CZVvUk0HXbQ98cqc+Q6DfgpQfiwz
	 zwv1C2bDzvBVHivBTnmuUoMWqFbuk/1CSXZBUtFPh9ucoThIPAKPj9MMV3RbCfjtVj
	 HNwXmtcMhpNFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A8B380CECF;
	Wed, 22 Jul 2026 20:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: dpaa: fix mode setting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178475103914.2005094.3496357796852461442.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 20:10:39 +0000
References: <20260717132401.2653252-1-mwalle@kernel.org>
In-Reply-To: <20260717132401.2653252-1-mwalle@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: madalin.bucur@nxp.com, sean.anderson@linux.dev, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jul 2026 15:20:29 +0200 you wrote:
> Before converting to the phylink interface, the init function would have
> set a non-reserved I/F mode in the maccfg2 register. After converting to
> phylink, 0 is written as mode, which is a reserved value (although it's
> the hardware default). Without a valid mode, a SGMII link is never
> established between the MAC and the PHY and thus .link_up() is never
> called which could set the correct mode according to the actual speed.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: dpaa: fix mode setting
    https://git.kernel.org/netdev/net/c/da2c6bcc5e30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


