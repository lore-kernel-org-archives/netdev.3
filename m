Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527831;
	b=cfI09ZoiUeraJ/w76u9WvM4Ruv6auFgSSv7nihJKDTTyu2Mg5b00FJIxYszQFJv2uc6O
	 Tt/8woBfYmUwgf+E29MbYOMtfJ3XlP8rHaT1Bd34qfPfle3r9xIDnlKsQ3rpHzF5myKTZ
	 c4n0iSCWkyns5tyhdJOaenNHLJ07ERz3sDq/Rhl8NvnVDUp9VrvXifO86ebW6IZ83SGO2
	 X3LdOOWRmDK0rkWaXlBG1aX16iQU0LQB83ogNYdmscFPEnmXHE1z8YUlwuhshFXCO6pCt
	 fDGhanfjtgSUyU8l4jYScpLXvcVUM0e/2lj5TIZQEK6wdHpWUzLYhrCxaYlXvbST9KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527831;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RyjzhzKMJ54LO47b8hj9G6AeITbfXRNhKF+4Refxl1s=;
	b=LDILSGoWAEqRpckO4EQ1NRBhKsYeykAzTJqOXbAhouwbeeaq59h42TYXtzF18qs4AfbO
	 2TE0gUh+Tj3CM0MZ0DjJYLHDLpiJo5cAjAG28/Km+YBUccqPkKwjXRvnACgrvrpUfB3DU
	 FjHbPe6a4GzzAoqHcwE3O032jHX/jcfAwhc5xA03ngAeazcC5f7/TGb0AyHYgU+Res7x/
	 Jf0JGBq5i3tUD8my7aS3LSqh4aP7wpL+N3we/9umOSfJnO8DYN6QhcfM9PkLcZLmn97fN
	 20GsPpVn6NpFB0JVD4xSgYPBSMx7e9IqfMhakEBI53645viEZP8QPMYgz3bEhIdQeYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blbwHczw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA8606A8B1
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blbwHczw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8191F000C4;
	Thu, 12 Nov 2026 23:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527831;
	bh=RyjzhzKMJ54LO47b8hj9G6AeITbfXRNhKF+4Refxl1s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=blbwHczwvaWRLorErllgB0iHTQIGhPBx1zDgTgurSWxN4XaD5BLcSOFYxP0Ei0gv6
	 lbTIHu7/bgIHQxxxAWsHtHLdBPIt3kXjIl6bKXEtVTdYFGFg92Qe/DyatPJYUNGPdA
	 pW8vwwsjGe2v6R3cCy+t5ZlYzt18+fSCYehQsuSK63klq3CQc3lq58xBMw9QN5U9Iz
	 NTq5ATwosdkXsq0m59L9rzjT5PnFv6k2KOFrG/UiuMl4BfxKtpAswdXoHvaUzCwdIP
	 D7hizDYyp0ubQIZmg6YqVTR65z4UjD9JMdLkSYLBpxx5uQotsDlh1r2b1MaaARLpZN
	 mlUIYMANSM+UA==
Subject:
 Re: [PATCH net-next v8 10/15] ibmveth: Enable multi-queue RX receive path
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
 bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Date: Thu, 12 Nov 2026 23:57:09 +0000
Message-ID: <179452782954.2199510.3698776944774316685@kernel.org>
In-Reply-To: <20261109235556.60604-11-mmc@linux.ibm.com>
References: <20261109235556.60604-11-mmc@linux.ibm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The MQ teardown design is only safe if CMO and MQ firmware
  never run on the same partition, and the code never checks this.

--

ibmveth: Enable multi-queue RX receive path

This commit turns on multi-queue RX when firmware advertises
IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT in H_ILLAN_ATTRIBUTES. Each
subordinate queue 1..N gets its own IRQ, NAPI instance and buffer pools.
It also changes teardown: in multi-queue mode, a hard H_FREE_LOGICAL_LAN
failure now leaves the LAN memory mapped, and open() and remove() retry
the free later.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index b12bfa1e485eb..a0c3c06d2b9d9 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1630,17 +1864,25 @@ static long ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,

[ ... ]

> + * Retries only H_BUSY and H_IS_LONG_BUSY. Other failures are logged.
> + * In multi-queue mode a failure other than H_PARAMETER (already free)
> + * is fail-before-start: PHYP may still DMA into the LAN memory, so
> + * return -EIO with the slots still registered. The caller skips the
> + * unmap, and the next open() or remove() retries. Single-queue mode
> + * keeps what close() always did, log and let the caller unmap; one
> + * reason it cannot simply keep the memory mapped is that on a CMO
> + * partition vio_cmo_bus_remove() BUG()s on an outstanding entitlement.

[ ... ]

> @@ -1654,29 +1896,45 @@ static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
>  	if (lpar_rc != H_SUCCESS) {
>  		netdev_err(adapter->netdev,
>  			   "h_free_logical_lan failed: %ld\n", lpar_rc);
> +		if (lpar_rc != H_PARAMETER && adapter->multi_queue)
> +			return -EIO;
>  	}

[ ... ]

> @@ -3131,16 +3527,30 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  		netdev->features |= NETIF_F_FRAGLIST;
>  	}
>  
> -	/* Initialize queue count - always 1 for now */
> -	adapter->multi_queue = 0;
> -	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
> +	if (ret == H_SUCCESS &&
> +	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT)) {
> +		adapter->multi_queue = true;

[Severity: Medium]

The new -EIO path in ibmveth_free_all_queues() is only safe if CMO and
multi-queue are never active on the same partition. The kernel-doc above
uses the CMO BUG() to explain why single-queue must still unmap, and the
commit message says:

  CMO (Power9 and earlier) and MQ firmware (Power11+) do not coexist

Does anything in the driver enforce that? Here multi_queue is set from
the IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT bit alone. Yet ibmveth_probe()
checks FW_FEATURE_CMO a few lines further down to pick pool_count_cmo:

	if (firmware_has_feature(FW_FEATURE_CMO))
		memcpy(pool_count, pool_count_cmo, sizeof(pool_count));

Suppose firmware does report the MQ bit on a CMO partition and
H_FREE_LOGICAL_LAN hard-fails. ibmveth_remove() then returns with the
DMA mappings still live:

	if (ibmveth_lan_resources_live(adapter)) {
		if (ibmveth_free_all_queues(adapter))
			dev_err(&dev->dev,
				"h_free_logical_lan still failing at remove; leaking LAN buffers\n");
		...
	}

Would the bus remove path then hit this BUG()?

arch/powerpc/platforms/pseries/vio.c:vio_cmo_bus_remove() {
    ...
	if (viodev->cmo.allocated) {
		dev_err(&viodev->dev, "%s: device had %lu bytes of IO "
		        "allocated after remove operation.\n",
		        __func__, viodev->cmo.allocated);
		BUG();
	}
    ...
}

The entitlement is also mismatched. vio_cmo_bus_probe() computes the
CMO desired entitlement before the driver probes, so it covers one
queue. Probe does not refresh it, but MQ maps up to 8 times the RX
buffers.

Could multi_queue be gated on !firmware_has_feature(FW_FEATURE_CMO)
here, so the driver checks this instead of assuming it? At the end of
the series, probe still enables MQ the same way, and remove() still has
the "leaking LAN buffers" path.

> +		ibmveth_publish_num_rx_queues(adapter,
> +					      min(num_online_cpus(),
> +						  IBMVETH_DEFAULT_QUEUES));

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109235556.60604-1-mmc%40linux.ibm.com
