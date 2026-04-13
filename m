Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3D2D3EC7;
	Mon, 13 Apr 2026 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776121836; cv=none; b=ZF42JX1IQHnbWKMGvMJ72yZ1oJ1zy5iTi2h/g0ZtF4yEDFLmjLpTO5oByNLxqCDj0Xb33DRR5vDIDY/5sjl9xWujMKkU/0R6KO39iQQM6jEyQT4pf60Lc8WEMIWq69GaUrVYB508B5epKelJKaFj7AZRjzLKzA2l5ipGW63u8Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776121836; c=relaxed/simple;
	bh=tFAybFpPcfRFzNjyNQPvmGPHLnwmK7WAc8Kxdf1/7tU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EMe7LgB1axMC8Z7q54lOcUITnuDwF42nvrMkD3cQC2b0dznnCLswf9JEuE3s7MGG/3mBdcjYo5rIeqn2CqKMJQgp8wiU1EWL3j0a0kkOuz1azzvIavFa7dEZf9mpbLl9AgNrzHjPmdZbYUpbV9mxepMwHja3+XO4opAOPNrSbyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/r6Ziey; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/r6Ziey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16994C2BCAF;
	Mon, 13 Apr 2026 23:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776121836;
	bh=tFAybFpPcfRFzNjyNQPvmGPHLnwmK7WAc8Kxdf1/7tU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a/r6ZieylRR8BnuvoHDMCC24YWSENR1Z4oL5K58EhvYRwknFo+Z9qSgemCgj5vSeX
	 o7K4r5g3sZ52bp5O2A3HFI4aMmrYMEtdCMKLJS5PwLB5gcrQai4Vl/NhJTiQG5BXZe
	 mxjq363qc/w0yjCtbPSbfbgQq4nbCwgF9cey6LgXO7ugV43vXZSCL9NyaDfuVAMsru
	 5+RWbebP9g3qj8PwUUD/Nh9PYAfGKC3k9y+WHgX2I7nj4BtJWO/w7zcT6SmbnqSyqK
	 cifMl553VEPTcb+ecmL6dlUa4YczcDlYDuKYnafUYBayMvHBEJw9WtiTkqMbbZ9oGJ
	 MD2Vj33GWAaRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD463809A0B;
	Mon, 13 Apr 2026 23:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnge: return after auxiliary_device_uninit() in error
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177612180730.593344.1154925383981627112.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 23:10:07 +0000
References: <2026041124-banshee-molecular-0f70@gregkh>
In-Reply-To: <2026041124-banshee-molecular-0f70@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 vikas.gupta@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, stable@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 11 Apr 2026 12:45:25 +0200 you wrote:
> When auxiliary_device_add() fails, the error block calls
> auxiliary_device_uninit() but does not return.  The uninit drops the
> last reference and synchronously runs bnge_aux_dev_release(), which sets
> bd->auxr_dev = NULL and frees the underlying object.  The subsequent
> bd->auxr_dev->net = bd->netdev then dereferences NULL, which is not a
> good thing to have happen when trying to clean up from an error.
> 
> [...]

Here is the summary with links:
  - [net] bnge: return after auxiliary_device_uninit() in error path
    https://git.kernel.org/netdev/net/c/8b0c25528cb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


