Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48E3E1236;
	Fri, 17 Jul 2026 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285434; cv=none; b=cnvl90c2QOhmfFvIfF2YzJLXuOn58I0AigEmyoRMn/3YFJx5Rtv/EXxSh2U8554JxNrIZqmCSZELZaiCkKVbhGLHiYXAAqeW5Uvf9AOk9oGLzdbhbixkE5zUXeIIvuxyxHF9nE/cQ0amNFCrwXWj6RqkOdwTKNPf+GQi+DgmkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285434; c=relaxed/simple;
	bh=/dsXR9Kq719Y3YmNUk0EoSlNefFFBHXwCQumgiFktSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ww03e+tiECyehvhtJlmcmMSrxvDuSkmArebLJwJ68sttkK19wvBmb37gwGG64qipdfKk/XnaeE7YhMo0Ij+KVtDec+VQN+r6udl2Z6po2kX+/XCLB1w2yjt4oHtB6sS03iNh0DSBGn2B2ROx3+KuEtXmOpg+lcUPlDh9XUI+qEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPR8JzYz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPR8JzYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B911F000E9;
	Fri, 17 Jul 2026 10:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784285433;
	bh=A0bxu/o2SswnD4qhFYFHM25sKlzUx/o52n3AlRvEcE0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bPR8JzYzDcNpPV4EAijVMqUP+kt5Hg70mpV/QrkRglc5LWVkGN8I0+le/FOoEycL1
	 zTuRYZ/NqvQxH5z0k0I5lbqo/2tq2LeHqZehE2x+eCR+gWmK35cz8vQPNYsjQSdPyF
	 4CGmPli1NF+oayIu/4wyc7yHJnAgcj1lvIs+dibccRHosMsBuFDJydHMt30CqBZMF9
	 +vnLHCQkEh5A+XKXCMx0+0rqd3NDzQ5hN9+UxloelzAjRWEh/w467vLA4X/zfI7GT2
	 CRNdbt+F+Y9GCyypRnMGSHM2cSow2jIPtI7bhcMcBHP1Dza6FKdBZm5kWPxoLuIf7j
	 6vnfS9EYHNRDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AB3380CED4;
	Fri, 17 Jul 2026 10:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bnxt_en: Handle partially initialized auxiliary
 devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178428540564.1661554.8204506406006848841.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jul 2026 10:50:05 +0000
References: <20260711163716.3996929-1-ruoyuw560@gmail.com>
In-Reply-To: <20260711163716.3996929-1-ruoyuw560@gmail.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com,
 andrew.gospodarek@broadcom.com, vikas.gupta@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 12 Jul 2026 00:37:16 +0800 you wrote:
> bnxt_aux_devices_init() calls auxiliary_device_init() before all fields
> used by bnxt_aux_dev_release() are initialized.  After
> auxiliary_device_init() succeeds, later errors must unwind with
> auxiliary_device_uninit(), which invokes the release callback.
> 
> The release callback assumes that aux_priv->id, aux_priv->edev,
> edev->net and edev->ulp_tbl are all populated.  If allocation fails
> after auxiliary_device_init(), the release path can otherwise dereference
> or clear partially initialized state.
> 
> [...]

Here is the summary with links:
  - [net,v2] bnxt_en: Handle partially initialized auxiliary devices
    https://git.kernel.org/netdev/net/c/1cb8553c02e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


