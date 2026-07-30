Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B4D3F12DE
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404447; cv=none; b=grfdkfGEmpEMHkrKpr0hpcSIJLDH8fBbrDk0kYlCc6l5SkCQl6hsivFp3FoSooPmka2E1T9vFep86/QR2nCgsd1lcCSyd2bK0txZ2Yl2QREDUpr68+MMpKKKfgS55A6ZNlsTWnrozLKrmnkbbb6PNGUpHgkU19StkQws/Dg36S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404447; c=relaxed/simple;
	bh=huAHy+Vk2/svi9vukNJTiOxrMVhUJ2ePmSAGmamzZSY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GNuiDIEDmpoqrTGB9qVnHAf13PfQbdLz+y04x+DkOx5a5/gsP1Zlnj+ctRZOsaB/S0Myi6jJHWSTZ251WQdsD4Wf1/sej76MrcpLt6fzjrFCVuPjNb18dgI3D2uybB8ah2//dNM6VZsOPs/PuOVmTVPQSb2JAKISkQ6CxBnr6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpAD/fqQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpAD/fqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D3D1F000E9;
	Thu, 30 Jul 2026 09:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785404446;
	bh=hemAsC+GgWzK8ju2JFRty0vJvvDKGJuoS4mAtdbzBnY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CpAD/fqQp5+fwYTP+rTUobicY48/2ZPwJGIiNVuS9rrbZENPZTVicWvhlu2L05z4i
	 YxPTOsNLxu/2g60Blj3j2Cy3O50iYAY4wPjpxBlF87F3m+LAS4lEzTV8YqrzvJHmyk
	 aj9W0/lUTlXR2Xds+Ftkq41EBytivUSbrae1uumIAPgzAmBjbWbIfOAqG1KsCAwkdh
	 f/9Jd+1TAp04rMGNUJMcSt09z9ZiCYbLErMgBwvy/14nJTMuXKMu9aqsaful6o5nrc
	 dRrtyOndrr8YcSGRR655D2mU+Dq8IyaKQe4dVLbX7dGDnvlx6qlxuad8MivVb2DD/f
	 hcxUaFoRz/rXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568FE381195C;
	Thu, 30 Jul 2026 09:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 0/3] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178540441014.3466425.18007620255226733913.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 09:40:10 +0000
References: <20260725-airoha-ethtool-priv_flags-v12-0-5136a30b2157@kernel.org>
In-Reply-To: 
 <20260725-airoha-ethtool-priv_flags-v12-0-5136a30b2157@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 aleksander.lobakin@intel.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 jacob.e.keller@intel.com, madhur.agrawal@airoha.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 25 Jul 2026 22:41:39 +0200 you wrote:
> Add the capability to configure GDM3/GDM4 as WAN/LAN on demand when QoS
> offload is created or destroyed.
> Make dev->qdma an RCU pointer so the TX path can safely dereference it
> without holding RTNL.
> Introduce airoha_qdma_start() and airoha_qdma_stop() helpers.
> 
> 
> [...]

Here is the summary with links:
  - [net-next,v12,1/3] net: airoha: rename airoha_priv_flags to airoha_dev_flags
    https://git.kernel.org/netdev/net-next/c/0040ff44cd5b
  - [net-next,v12,2/3] net: airoha: fix ETS QoS stats counter underflow and cross-channel corruption
    https://git.kernel.org/netdev/net-next/c/8b9a50881988
  - [net-next,v12,3/3] net: airoha: defer GDM3/GDM4 WAN mode and GDM2 loopback to QoS offload
    https://git.kernel.org/netdev/net-next/c/78a35725e533

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


