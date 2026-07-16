Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5659C14F112
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207079; cv=none; b=VOt/fCWGdHOr8LiiWkXNIyWoO4//wdoH9YGIGslrBlpLaB4RnXI4vYzAyJlFq1wtq2b3otcOe0zq+CeKXsu5bpsDXmQDCA/xGfQZOnqcawbbblTpL35/Z2LIqYn/sFDc80cyMn6JxlyyePr/YWFmuF5ie50Hpe8kD/MrPzy28qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207079; c=relaxed/simple;
	bh=E3oPFTra9vNOrEO3YDImFcKp7suqWQ1gyw0PYvvLuiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2otEMBZ2snNq2STCS+UF5b6ES05M0ob5bfM4CW4s74Eloo81sumPBKq2XUnT7PU5fp/qCXr+GSX67OsWWK1EF7G/InB9BOQrTjq/uYcC+xm/IMCwrPBa2CYPW25/u/OzKo8sJyOTVFIjCb2vb734w4Lbx976i41FGUuu6llk58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zs3qrtsJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zs3qrtsJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327D51F000E9;
	Thu, 16 Jul 2026 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784207078;
	bh=HmGA/l7R5DgUHEUedngx1KpcsIvGqxoQmK+APT2PTsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zs3qrtsJlip3dMi4X/wbqw64/UK6XMf54E46LQ/sltiK1EUY8CAjVZAqFOF/+bGfI
	 dKI3mFZSf/twwY6HIVGItSOzqhDlG7loc+ufbCxV162Kx+VLmW4urhqOg4cjYATBv2
	 XQTQzn+hET1/WWVf9H0Ib661f7Wr3S3rVtaYCo5Pe8iXKGA1ZYcqoecIu7KZI/37X6
	 4rzw6myOuwjsKJhcC5C68vxrvuIeWWLyFmNs/AX0AuNj3R23tUXrzpxX1SB3al8vNF
	 z6/a02InhUcpT6jUCj0o4a6LMfDixOfcQD/8E72Cto7nFg030cg4CEllgUhNy8AhwW
	 aJzw6LK3F003w==
From: Simon Horman <horms@kernel.org>
To: sergey.temerkhanov@intel.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v1 1/2] ixgbe: Refactor device operations to check whether netdev is available
Date: Thu, 16 Jul 2026 14:03:28 +0100
Message-ID: <20260716130327.311494-2-horms@kernel.org>
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
Full review at: https://sashiko.dev
---
--- Patch [1]: [PATCH iwl-next v1 1/2] ixgbe: Refactor device operations to check whether netdev is available ---
commit f7037ec91fe4185b79d89bd64ec8042f9f9b1904
Author: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

ixgbe: Refactor device operations to check whether netdev is available

Refactor several ixgbe driver operations to check whether the
netdev they operate on is enabled. This will allow the system
to get synchronized, for example, during the PCI resets.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> index 011fda9c61939..e4cd4673f21c2 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> @@ -836,6 +836,10 @@ int ixgbe_fcoe_enable(struct net_device *netdev)
>  {
>  	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
>  	struct ixgbe_fcoe *fcoe = &adapter->fcoe;
> +	bool running;
> +
> +	if (!netif_device_present(netdev))
> +		return -ENETDOWN;
>  
>  	atomic_inc(&fcoe->refcnt);
>  
> @@ -845,12 +849,14 @@ int ixgbe_fcoe_enable(struct net_device *netdev)
>  	if (adapter->flags & IXGBE_FLAG_FCOE_ENABLED)
>  		return -EINVAL;

[Severity: High]
This is a pre-existing issue, but does this leak the FCoE reference count?

If ixgbe_fcoe_enable() is called when FCoE is already enabled or the adapter
is not FCoE capable, the function returns early without decrementing the
freshly incremented fcoe->refcnt.

Later, when ixgbe_fcoe_disable() is called, atomic_dec_and_test() will not
reach zero, causing it to return -EINVAL without freeing the FCoE DDP pool or
clearing the FCoE flags.

[ ... ]
> @@ -882,6 +888,10 @@ int ixgbe_fcoe_enable(struct net_device *netdev)
>  int ixgbe_fcoe_disable(struct net_device *netdev)
>  {
>  	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
> +	bool running;
> +
> +	if (!netif_device_present(netdev))
> +		return -ENETDOWN;

[Severity: High]
Does this early return cause a memory leak of the FCoE DDP pool?

During a hardware error or device hot-unplug, ixgbe_io_error_detected() calls
netif_device_detach(), which clears the device present state. When the
driver is subsequently removed, the FCoE stack catches the unregister event
and calls ndo_fcoe_disable().

Because the device is already detached, this new early return triggers,
causing the function to skip calling ixgbe_fcoe_ddp_disable(). Will this
abandon the per-CPU DDP pool so it is never freed?

>  
>  	if (!atomic_dec_and_test(&adapter->fcoe.refcnt))
>  		return -EINVAL;
[ ... ]
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 8873a8cc4a185..12361ed58a0ff 100644
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

[Severity: Critical]
This is a pre-existing issue, but does this error path leave a freed BPF
program installed in the active Rx rings?

If DCB is enabled on the interface, ixgbe_setup_tc() returns -EINVAL.
However, before returning, it calls ixgbe_open() to restart the interface:

ixgbe_setup_tc() {
        ...
        if (running)
                return ixgbe_open(dev);
}

During this restart, the Rx rings are initialized and assigned the new BPF
program currently stored in adapter->xdp_prog.

When ixgbe_xdp_setup() sees the error, it restores old_prog and returns
-EINVAL to the network stack, which then frees the new program. The
rx_ring[i]->xdp_prog pointers still reference the freed program. Can this
lead to a use-after-free?
