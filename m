Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B34229A4
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206993; cv=none; b=Un4MhgQDS0INU7I3Ms1Pj81mWbQ9JsWpXOj0reDqzdwVEWnTMTRd9g61m/C9+145NgRkRzYsGSOA1/4ZGjt/95x5hMmeSwaUtPCf5vvnxcPuYmtm+bHSUWitDwGL4B0mujsaaNfAH8GFZZQoE5cWTr7bRAMYdhpQL52jS41vPdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206993; c=relaxed/simple;
	bh=bVcJNezkCO7Vf5msDmX7WFZxQ6U0X6TsyLR6nzLaWq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=je99cOPaltkcwUBLab5dqvwi9d/tuCnmtLcPkUZzxNn0LrMhl12ZiB2EurIfY/VJ4fwGaRJBuQKK4bdd1AnPyOY/gpLBIFTKelIAZsjbv6AtYr69ty8XCqB6T3ioH+zzb4xdlJ6XBjZEEHZQeVL6e/kx+iWXu+zDJAc71QjJyFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdMwkirZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdMwkirZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EA11F00A3A;
	Thu, 16 Jul 2026 13:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784206991;
	bh=O9aVvhnwq9WKul5Dkcq9CyjN9SBNgRa/ma0xPwkkGkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JdMwkirZk3C46KYBxGoYkNhody/IT9qCqvP+ckPuTxsUxopWdv6ySzDjk128eXzwT
	 R93Ao5AbCA2/zT+7F7OJkOnAdaJjkkRSfzksWAFO4FV3FXsqVdiZgnIhcgCiooe+Xb
	 79tzIsFheA+UWrk2b2DdcNzZ1L4NH6Hbmq1iyPSLopkkYLVU4bHtc4mkefReAEhvQL
	 h21OkZaSrUOVQZh1cx3Mf/sYVg0A/EPV5zIQIopJ8ob+TOkZdeXoMebC7Kd9NzC01J
	 jG33hAJVkyJj5xZiSKuobny6xg2ptBOQcRAGnl06FzFE8lNZqsHM2U3Q9k9HUrAVaA
	 uxixwtiv7gC0w==
From: Simon Horman <horms@kernel.org>
To: sergey.temerkhanov@intel.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v1 1/2] ixgbe: Refactor device operations to check whether netdev is available
Date: Thu, 16 Jul 2026 14:02:55 +0100
Message-ID: <20260716130254.309674-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710105403.1050025-2-sergey.temerkhanov@intel.com>
References: <20260710105403.1050025-2-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://netdev-ai.bots.linux.dev/sashiko/
---
ixgbe: Refactor device operations to check whether netdev is available

This commit refactors several ixgbe driver operations to check whether
the netdev they operate on is enabled by introducing an ixgbe_netif_running()
helper and adding netif_device_present() guards across the ethtool, DCB,
FCoE and XDP code paths.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 8873a8cc4a18..12361ed58a0f 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

[ ... ]

> @@ -10954,8 +10958,10 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
>  			synchronize_rcu();
>  		err = ixgbe_setup_tc(dev, adapter->hw_tcs);
>  
> -		if (err)
> +		if (err) {
> +			xchg(&adapter->xdp_prog, old_prog);
>  			return -EINVAL;
> +		}
>  		if (!prog)
>  			xdp_features_clear_redirect_target(dev);
>  	} else {

[Medium]
The xchg(&adapter->xdp_prog, old_prog) rollback on the ixgbe_setup_tc()
error path looks like a semantic fix rather than a refactor.

Before this patch the error path left adapter->xdp_prog pointing at prog:

    old_prog = xchg(&adapter->xdp_prog, prog);
    ...
    err = ixgbe_setup_tc(dev, adapter->hw_tcs);
    if (err)
        return -EINVAL;

while the ndo_bpf caller dev_xdp_install() drops its reference on prog
when the driver returns an error:

    if (err) {
        if (prog)
            bpf_prog_put(prog);
        return err;
    }

Can this leave adapter->xdp_prog as a dangling pointer to a freed
bpf_prog on the pre-patch code, which is what the new xchg() restores?

The commit message describes only a refactor and does not mention this
change.

Should the xdp_prog rollback be split into its own patch with a Fixes:
tag pointing at the commit that introduced the missing rollback, per
Documentation/process/submitting-patches.rst which asks for one logical
change per patch?

The new behavior also skips the subsequent if (old_prog) bpf_prog_put(old_prog)
in the failure path, which is a separate semantic worth calling out in the
commit log.
