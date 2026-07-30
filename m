Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C2820468E;
	Thu, 30 Jul 2026 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450648; cv=none; b=MDHfQaaJLhJ/b3jnzM0fbGvSZBhP2iCY3qpdSHf4dvP70k+PkRf9KvBh3YGaLc/zzgOLkzlp0B9r3b24qEkr/t0kt7SsTN1ty1/jKq/p0QV+4vYoE/ou2YMfII/evtvW8RBdZekH6TUtpSBWALdGjFMxfm74OpKMNCRVDz+ppg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450648; c=relaxed/simple;
	bh=dl7QYDb+iJxoq7qcQEidkqCIKi7uFKGc13w4OvzYN4U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RxwbG1b8Ai1LezratwIgo//bqQIvY9+PLDvJc4LldDnUnU31Db8RXcPAq5tBuxCsibDqAJm8XdmoFNDSELhe9Nk11yUAiINAZ/u/vQq2C8BndHi427evQSOf2GmwsfwH37UJd+TGm8Xnx+X3on9F8ehA18udiym8787ZmBEKupE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lkw9Qtxq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lkw9Qtxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E68C1F000E9;
	Thu, 30 Jul 2026 22:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785450647;
	bh=KGjwv/yBwHluhXdpVom7Bgww/hkrGmQN2SusWgQLtFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Lkw9QtxqKs9NkXv6NIDc8N7egYlLecfYFBoH2tE5d7YvDcZ0NLASof3p9sLzB3nLc
	 WFEV3Xtt/YT95P4EYy00+vKhgBt6uyNNhKVSuL2vJn1dYugEW8Fh59+VPfP+OFWVxl
	 Cyv11gUuqn2lTDtgKmOkkP346Pmq4DeDJ64rwVKv6gsLWHFMx03G375mB95eIoWgsR
	 +BRtph/9yw8SA6lSV57DiPVLf9JwrBunoQn6jvhIjg7DUjERTbM35XwenpMymZ7G5x
	 xxgiSWPKP4xKcu3jdGfRCxxLdg56cVM7fHmEt1qNhMjnPDGinLZoByk0CiXl4od3ay
	 Oxmt0TgzTiq3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B043924459;
	Thu, 30 Jul 2026 22:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3 net] net: hns3: fix speed configuration residue after
 driver reload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178545061038.16570.5352887103304551718.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 22:30:10 +0000
References: <20260724093036.426631-1-shaojijie@huawei.com>
In-Reply-To: <20260724093036.426631-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 yangshuaisong@h-partners.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Jul 2026 17:30:36 +0800 you wrote:
> After setting a 100G optical port to 40G via ethtool and reloading
> the driver, the port remains at 40G instead of reverting to the
> firmware default speed of 100G.
> 
> The commit referenced in Fixes: added two overwrites in
> hclge_init_ae_dev() for non-copper media, so that optical ports
> connected to forced-mode remotes inherit the firmware-preset
> autoneg and speed instead of the hardcoded defaults:
> 
> [...]

Here is the summary with links:
  - [V3,net] net: hns3: fix speed configuration residue after driver reload
    https://git.kernel.org/netdev/net/c/3860d8748af3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


