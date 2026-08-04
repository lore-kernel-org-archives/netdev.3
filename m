Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FE21A9F96
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 01:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785807053; cv=none; b=CkoX5p5qd/BD/OLmYQYRT55KknylN/TaPZq2LQ0bEFvuSvIcW5bD9qBca1qA8vLwakg+DdDAX2luwMECqE7Lod59/EjTyAx2k3o6RCNq5VW5ZJQ/xjaphtstMKM8/4CpCCAqnwX6Z0O8uJzob6ErsFSEN/eegNYQyXqttfJnF38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785807053; c=relaxed/simple;
	bh=g0v9NXIKWqQKy+6a+gEG/S1QPe4F7VqxjtEKp5fe9vI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fCbp/Dta0o64R4KFVfOBGf7Usnbd/kJgjPZcaY2kGQKKtKAIl38u2FTzy+5n4E7NG207oqY6qMfFbqMTBhy4Qa2kDRW/1Ej1ixqaYmaEWDxmQ976tf+0Siz2IUQqdqfj6A/e1kQZEoEbcF093vVXywI7+Ezr3wIeZAP+3FPiiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ha6Y6G5c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha6Y6G5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DB61F000E9;
	Tue,  4 Aug 2026 01:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785807052;
	bh=xa/i1Nl6QYa4kouMFYH7lfMvUhqa6o2+/ViRg11Zqls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ha6Y6G5c4aK1vI2GFcn+3A2htztZ0tOqIK7Fpq3gQ+rh/F8TKQ1ecWljOitYBWHxH
	 laL7VyuaIgwe2iCGBslb1eZkPzdXqKeHNXmUH4kTD6PLgYUdtlWNLm+iuqVOccjACV
	 hMjPDEugvDidvi3oA/rDJIZrqmECELNyf1OdnJ4bCu41BIIp36qpxtZ9FnkI9+Uup9
	 wdnaiSY95ANFwd+nXeMNxNjhtiaxMuydbs2nuQBZGc1+cKv8noJY0akN+3YH7Cdavg
	 KZLi9U14EShSSF0nDLu3zcx34BB5pbfH15MedNDZ2WdQF4QwMafWwOkvKtUd3fjDoL
	 7IAyLR4L4USXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198E93924467;
	Tue,  4 Aug 2026 01:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnge: Fix NULL pointer dereference in aux device
 release
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178580701264.2908636.1557114995164267360.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 01:30:12 +0000
References: <20260731192301.1427645-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260731192301.1427645-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: leon@kernel.org, siva.kallam@broadcom.com, vikas.gupta@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 alok.a.tiwarilinux@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jul 2026 12:22:59 -0700 you wrote:
> If allocation of auxr_dev fails during auxiliary device setup, the error
> path calls auxiliary_device_uninit(), which eventually invokes
> bnge_aux_dev_release().
> 
> The release callback unconditionally dereferences aux_priv->auxr_dev->pdev
> to retrieve the parent bnge_dev. Since auxr_dev has not yet been allocated
> on this failure path, the dereference results in a NULL pointer exception
> 
> [...]

Here is the summary with links:
  - [net] bnge: Fix NULL pointer dereference in aux device release
    https://git.kernel.org/netdev/net/c/1cb4298810e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


