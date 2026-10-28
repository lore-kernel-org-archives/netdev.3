Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793230808;
	b=1pIm+W7VNoabr3Pbn8Vm999BuMDY5SUPtiyt3hmGfy9dRXFkoiaiJKf1/q9GTmM2T/mU
	 FCLSGTHsWTqfyz5wLfYnFh059MPpUV0RiJMeucI8pTxw9bQpRZagKITmkcDVBB+RUBoxD
	 eglBhzgi8pGiGiS/ymf7jtK7XDRFDpiy8DBV11S4w8TkM6w832YPzgH5x86ut1zfexycj
	 yqQEdx7r9e1RrJkXk1V5/7fQS/rvihxFGT8PsgMWzPUyuFn//d1lrLSe4nfDbbQDWP1pb
	 5aGaorD/DeHykO6RsxAGKPFb72wy4Gs9fujgDi9mMHxpJlGkxCZGQKWBls1lcZKon+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793230808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=eSBje7ne27VllfT95Jt8SmIZ4PCn+iHIMvYclQHKX28=;
	b=bf1NHprsD7iVOdZ92oVw2uO9wl6xoaMhOhNqhPgaCAyAEzlxm2GnEKNVNw7zUB5eREI6
	 6Rav6/JHLl3CJJBFuzQVrNsJBrOX2P4OKHdkv0TjDBKH9NUs5rftZvUGObFn+HOyP3Wo9
	 b2xsmOBHSSoFX/s252yBwnAZUA/rjeOhKjkgbqRhHw7RfbrkAHpoBoVaP6uIYbNerdFGC
	 sBv9PbzfU2EHrti2Q0MOm9lj8LRBrK3GjD9FBmQSr3n28ffskyOAiYr+1Atr9YLhHdos3
	 qP83KNs9Zh4NsqY1MYy4KtIUudVNwEvDWegBxIvgJkaQicej0QNDCjPfX42E4xxirrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYda7JoK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3032D606A325;
	Wed, 28 Oct 2026 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYda7JoK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B921F01828;
	Wed, 28 Oct 2026 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793230807;
	bh=eSBje7ne27VllfT95Jt8SmIZ4PCn+iHIMvYclQHKX28=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TYda7JoKvtil9ssL1fslNDIQ5ntctsBf/lt8a7R+CnlDMBd1CMWXShIZSI+liyXw8
	 EUu9IR2T7NJzBG/ScEcdkjFXLsA2HZ22qx0WCf6cWIAufbCv1Ttv/w8V9Glb0ZrDuc
	 M3JqT5dwuuA+d+4c7pN2KSGIbLowNxBRJESVu055SBqAjQftrNkrVqCA22/wngNeDH
	 qzL3obrRVIZavsGHeZ940y7n+M5E6K++1YYD0QEs5UwqGq9XiQGfXdFjhxagU9d/UT
	 EyXFfTh++3Z1TEYWwqLCdbJopHqQrX+Jii/YIFz1PCzE0z6teKT7tq20jATNveps6j
	 79VcOV1xULSXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE6953AAFC4C;
	Wed, 28 Oct 2026 23:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dcb: initialize PFC value before calling
 getpfccfg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179323080631.1480461.17695620852598790529.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 23:40:06 +0000
References: <179289284460.50470.572724041164324949@gmail.com>
In-Reply-To: <179289284460.50470.572724041164324949@gmail.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Oct 2026 22:47:24 -0300 you wrote:
> dcbnl_getpfccfg() and dcbnl_cee_fill() pass the address of an
> uninitialized stack u8 to the driver's getpfccfg() op and then put it
> into the netlink reply unconditionally.  The op returns void, so the
> core cannot tell whether the driver wrote the value.
> 
> i40e_dcbnl_get_pfc_cfg() and ice_dcbnl_get_pfc_cfg() return without
> writing *setting unless the DCBX agent is host managed and in CEE mode.
> Both drivers normally run with firmware managed DCBX
> (DCB_CAP_DCBX_LLD_MANAGED), and i40e with FW LLDP disabled runs host
> managed in IEEE mode, so on a DCB capable i40e/ice port the PFC values
> in DCB_CMD_PFC_GCFG and DCB_CMD_CEE_GET replies, and in the CEE part of
> RTNLGRP_DCB notifications, come from uninitialized stack.  The same u8
> is reused for all eight priorities, so this is one byte per reply.
> 
> [...]

Here is the summary with links:
  - [net] net: dcb: initialize PFC value before calling getpfccfg
    https://git.kernel.org/netdev/net/c/ca87a2dffbb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


