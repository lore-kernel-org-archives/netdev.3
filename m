Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231567;
	b=OSs5pvUbm9+EZqAxIXzsuD+SHSykk15gwp50+pq1A8yG2enOoT3kOhL29iPE6mav90R4
	 hiN2sTSLyRkY+kkOk2Vr9oB4R4u2eZippXyRprydDjN/MJLck6A3piIOqnFvMDccef5dP
	 67V0gUlW/RijRjDJHVow/Hb6FzHaTlUpsx07Iu1F8/1F2XKGkQduZZMw+YGJ45HzY0lGW
	 JmQ3sJKmdE46zWmunCwZIYbDaZm5nFPe0q3AhOM/Sh/UE9EBfQFSXCXaxMwzjNv3S0sTc
	 L8o1lalg7nihQ6rV8E4nBRoBNYK/rySQbc9xSUsLEGpa6tASlB8J38/53lYQ0qPRtbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231567;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=n+XZFDnWaWCh7AANBxuS0C+FqovJyNGIftTEuPUSsjc=;
	b=MavLp6bljF/4IbBMJNEh07W0GLFP2UlD4VyPpj1eZ2mhXUK7wYRDrcyeDqSflcBFUfUi
	 neJ8aN9w5AXTPJRUPJpRRNiY3RFJHuWNMiLZtLAJERYMi8xUN9uhwBgjOBW5sb13esza0
	 HpAToLgy5TwMZ7Dj5VRGoK93l7/94WjoLKZ5s1c3xtee0lKWSlSLi1a1XU4a6iusOrPDy
	 ZdnM4DfZ4FwrChv6EPhopxSX6htjT5RHTPYWRCjKJDyVeymEvq8v8sujocQRT0szG08iT
	 a7JcFrHPf5iXol/C2PUd2GSodM1Kx63MFPeRyHRYVVNJN3IOYQQEV33R9kJEh1R7AHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ap9ZEKmN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227A606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ap9ZEKmN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E952C1F01828;
	Wed, 28 Oct 2026 23:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793231566;
	bh=n+XZFDnWaWCh7AANBxuS0C+FqovJyNGIftTEuPUSsjc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ap9ZEKmNeearLiVHoqgIxYme9zNDsLO/M1b8fYzL0pPdSyuGEJ701VG9k4Ilvw2v4
	 zzFT5CgGNa1BCY61MKNid4pe3VnC4NGdPw9MNuZNHAGjxDDBr8wyzW5eBgjjXeaGlD
	 xWBYegrzGOnMdCTfgc+BXZtCaqP/2pGT3CSvDWo+KjEA+nMYLwpqLkq2e6bS0LAhdt
	 PReieaJ2ed0deLkjKTFO5LBNivmeo232rLyJC+0t+O8GP3YxY70vDVizI5A5CPjz+K
	 zHRRsuTbU14y1OwKsPdIVf8krFnFsiXg6wxhDmmESyjqlZclwz3X2UMpMGbKgMYDJ4
	 Kizl8CipaCV5A==
Subject: Re: [PATCH net 2/5] eth: bnxt: resize Rx head buffers when
 rx-copybreak changes
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, eddie.wai@broadcom.com,
 prashant@broadcom.com, huangjw@broadcom.com, gospo@broadcom.com,
 brett.creeley@amd.com, ap420073@gmail.com, joe@dama.to
Date: Wed, 28 Oct 2026 23:52:45 +0000
Message-ID: <179323156552.3134.8258354110964306785@kernel.org>
In-Reply-To: <20261027234940.1267225-3-kuba@kernel.org>
References: <20261027234940.1267225-3-kuba@kernel.org>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  bnxt_copy_data() (drivers/net/ethernet/broadcom/bnxt/bnxt.c) syncs…

--

eth: bnxt: resize Rx head buffers when rx-copybreak changes

This patch makes bnxt_set_tunable() call bnxt_set_ring_params() after it
changes bp->rx_copybreak, so the Rx head buffers are resized before the
next open. The goal is to stop bnxt_copy_data() from syncing rx_copybreak
bytes past the end of head buffers that are too small.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 622e89587e5db..ef4bea4a0f8cc 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -4601,6 +4601,7 @@ static int bnxt_set_tunable(struct net_device *dev,
>  			if (netif_running(dev))
>  				return -EBUSY;
>  			bp->rx_copybreak = rx_copybreak;
> +			bnxt_set_ring_params(bp);

[Severity: High]

Does this cover the case where no aggregation ring is in use?

The commit message says bnxt_set_ring_params() sizes the head buffers to
fit at least rx_copybreak bytes. The rx_copybreak floor only exists inside
the agg_factor branch, though:

drivers/net/ethernet/broadcom/bnxt/bnxt.c:bnxt_set_ring_params() {
    ...
	if (agg_factor) {
		...
		if (BNXT_RX_PAGE_MODE(bp)) {
			...
		} else {
			rx_size = max3(BNXT_MIN_RX_HDR_BUF,
				       bp->rx_copybreak,
				       bp->dev->cfg_pending->hds_thresh);
			...
		}
	}

	bp->rx_buf_use_size = rx_size;
	bp->rx_buf_size = rx_space;
    ...
}

agg_factor is 0 when TPA is off, HDS is off and rx_space <= PAGE_SIZE.
That happens after ethtool -K gro-hw/lro off, in a kdump kernel, or with
BNXT_FLAG_NO_AGG_RINGS. In that case the sizes come only from the MTU:

	rx_size = SKB_DATA_ALIGN(bp->dev->mtu + ETH_HLEN + NET_IP_ALIGN + 8);

	rx_space = rx_size + ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8) +
		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));

bnxt_set_tunable() still accepts any rx_copybreak up to
BNXT_MAX_RX_HDR_BUF. bnxt_copy_data() still syncs a fixed
bp->rx_copybreak bytes:

	dma_sync_single_for_cpu(&pdev->dev, mapping, bp->rx_copybreak,
				bp->rx_dir);
	...
	dma_sync_single_for_device(&pdev->dev, mapping, bp->rx_copybreak,
				   bp->rx_dir);

__bnxt_alloc_rx_frag() packs rx_buf_size fragments into one head_pool
page, and each mapping starts NET_SKB_PAD bytes into its fragment. Two
examples on x86-64 with rx-copybreak set to 1024:

- MTU 60: rx_buf_size is 704, so each sync runs 384 bytes into the next
  fragment.
- MTU 400: rx_buf_size is 1024, with four fragments per page. The sync
  for the last fragment ends 64 bytes past the page and outside its DMA
  mapping.

The BD length here is rx_buf_use_size, which is <= rx_copybreak, so every
received packet goes through bnxt_rx_pkt()->bnxt_copy_skb()->
bnxt_copy_data().

Isn't the oversized sync from the commit message still reachable on this
path? With swiotlb or non-coherent DMA it could still corrupt neighbouring
buffers. The later patches in the series don't seem to touch
bnxt_set_ring_params() or the sync length in bnxt_copy_data().

Would any of these be a more complete fix?

- bound the sync to len + NET_IP_ALIGN
- apply the rx_copybreak floor on the non-agg path as well
- reject rx_copybreak values larger than the current head buffer

[Severity: Medium]

This is a pre-existing issue, not introduced by this patch. In
bnxt_copy_data() the CPU sync looks shorter than the memcpy that follows
it:

	dma_sync_single_for_cpu(&pdev->dev, mapping, bp->rx_copybreak,
				bp->rx_dir);

	memcpy(skb->data - NET_IP_ALIGN, data - NET_IP_ALIGN,
	       len + NET_IP_ALIGN);

bp->rx_offset - bp->rx_dma_offset == NET_IP_ALIGN, so data - NET_IP_ALIGN
is rx_buf->mapping. When NET_IP_ALIGN == 2, bnxt_init_one_rx_ring_rxbd()
sets RX_BD_FLAGS_SOP, and the hardware places the packet at mapping + 2.

Take a copybreak packet whose len is rx_copybreak or rx_copybreak - 1. The
memcpy reads up to rx_copybreak + 2 bytes from the mapping, so the last 1-2
bytes of the packet were never synced.

Could those bytes come from the stale original buffer with swiotlb, or from
a stale cache line with non-coherent DMA? bnxt reports
CHECKSUM_UNNECESSARY for these packets, so the stack would not catch the
corrupted tail.

This only affects architectures that keep NET_IP_ALIGN at 2. x86, arm64 and
powerpc define it as 0.

A sync length of len + NET_IP_ALIGN would fix this and would also bound the
overrun described above.

>  		}
>  		return 0;
>  	case ETHTOOL_PFC_PREVENTION_TOUT:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027234940.1267225-1-kuba%40kernel.org
