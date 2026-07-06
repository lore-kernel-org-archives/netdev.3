Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF11B1A9FB0
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783375227; cv=none; b=kh+8V7RL8tWBqT21UPFEFHlK7Joq03GySL8nORWqXcVO4u0U0SRoNWdcozVNYQywEAdOLn6Bxw0hqluUF1+FJPHF8VTKkG5EaVwySfR6tpgq9SvsRZty9pZZyvjSf55vSADS7KLDOgoh6dQSxFKYEKj4UHEwXgXIAXjt2KitYik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783375227; c=relaxed/simple;
	bh=r0JK7xaiF19k/tDxV4+raUI0cKiYgeChTrYADNUxJ/8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ip6injDM2ujxqbbdRiXA5JlN5tT4nfmm63ZHr3gFfNB7gXKJ41ZGWWaLUC03jXGdbwaO5MWPbQMgUfy/bXiJHJiEbebAYg7kbvXB640po0fdg1cTltaZpE28Lixbsaw6yUzSK93+9eiuds9AB+nZZHmzPnFRFgmWrjnRpiAXUto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuADPFGL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuADPFGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB051F000E9;
	Mon,  6 Jul 2026 22:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783375226;
	bh=DjMqWMd+5h6THtBBW/vMmvengJ17wWvk89tUuMxvISc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TuADPFGLGncNshnOM1vsq6fZJzfeeXpuLaLoZ2DzndYPIhDfSIySZ4iEvv+V/BG/S
	 PWb8MFzTlppV8jdnXNbVIk81l+fWaEnGUW0UizsfnJ7uM4wxQckUjnC0djfhLixMi8
	 Z5NBiiTOKMSJ3orL5SXZAuMBv7PC5MqzQTILiiE/9Kitmq8F3C6dpkm4tPadPe78Xx
	 itxnh6YirKqRnEHIshQsPEGxJ8KXvCQBJmSpStv4HzWg8eBrjZqEDi62FWSwK9H/Yj
	 YXpTWyGoUWq1E2acHs1QfjyveR2J25TXOUV1pchkhJoGcHbkWFP/Gb6xZF+DsXdmkm
	 XLWsLSEwxm+NA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B273925F71;
	Mon,  6 Jul 2026 22:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 ethtool] man: ethtool: link 10000baseCR to SFF-8431,
 Appendix-E SFP+ DA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178337520638.1223576.17680136243635201029.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 22:00:06 +0000
References: <20260703102004.1111597-1-siddaraju.dh@intel.com>
In-Reply-To: <20260703102004.1111597-1-siddaraju.dh@intel.com>
To: D@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	H@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Siddaraju <siddaraju.dh@intel.com>
Cc: mkubecek@suse.cz, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, Shubham.Das@intel.com,
 balaji.chintalapalle@intel.com, vijay.srinivasan@intel.com,
 magnus.k.lindberg@ericsson.com, niklas.damberg@ericsson.com,
 jonas.wirandi@ericsson.com, siddarajudh@gmail.com

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Fri,  3 Jul 2026 15:50:04 +0530 you wrote:
> Annotate the 10000baseCR entry in the advertise mask table so users
> understand what physical media this mode it actually represents.
> 
> 10000baseCR does not correspond to any IEEE 802.3 *base-CR PMD.
> It has no autonegotiation, no link training, and no mandatory FEC.
> The industry standard for this media type is SFF-8431 Appendix-E
> Direct Attach cable, also known as 10G_SFI_DA.
> 
> [...]

Here is the summary with links:
  - [v2,ethtool] man: ethtool: link 10000baseCR to SFF-8431, Appendix-E SFP+ DA
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=b0d4a0d60471

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


