Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063786;
	b=x05y61tGT5aZgLTMso7n/W4TYxX+t3lEFiCcTUxUhH03bhyhwnzhIvibm8Pd0ZKiqKa6
	 BJVHbqu9rOoqJIIdGfynD+0ZfeECiMiP8kuiTPFrMYCChMK77GW/wJ9TcNIYqx0qBJa++
	 gXBaVFJ7KvKd+Fusyyx55dDs/LNdfftSkhPHGMy4umuK8cXF6/yQ23eXQIcjDX4MUJwLD
	 u+G9RIEZvlqLJFqw5Nu1offk3qhTBbFEWe3OLXNSyi5OIMjwsphdz0Aef1R5W74Lus2Ou
	 mfa24Xsv8vNjbX44vFYiUOC8fSdusMOqpJs5RpzVeNaH9SQyMhjRt5ILPR2jf4hnsjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063786;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rkgeuZd7YSntSvwVnN4dhPGBeSaQtAsMcpcJkxt4xs0=;
	b=GmiAVHU2kQTaC9UK5SQ4B0CUQP3dZd2rVvZCuw2x5xl5W57hvcqDU5ZxEu9ckXEvPtSZ
	 Q2mgEIpRh+HZKl82w7A1+ek+FrvDRieIYATLnE6ba81JmfCPtI1YDKshHka2dGzrRFHT/
	 yISstWXt01D+wNAZ2oYqZl7cyf9DekmZ4QK0kBeHcZ4Rg7HW5Ri9KmNkg2dFk7d5rzB+C
	 KFLwcEpFkHlBJNs4iXpwaQfSiZfQwSBdtlITpQ6bpDP+SZl2Ph2A0ygf3Mfmnv2vYbf9B
	 Y9+yMiOhtqVV8aaD6o54KqksFfp5N2oWa2Y3ERuIxykFyNGwVYc3hiLRWZaMV44ZODQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fH2y3xRQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96F606EE98
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fH2y3xRQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3031F008A1;
	Sat,  7 Nov 2026 15:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794063786;
	bh=rkgeuZd7YSntSvwVnN4dhPGBeSaQtAsMcpcJkxt4xs0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fH2y3xRQH0fF91zO1fDfe2ZCrVYtKlA0h31OYY8bwUelBLayGvRvmvR+FSHl5XWAY
	 OZTy4tMp49IAFa7lKtEQmOJKjyg51JvztdjkjPnxHecN+odcGUtNng9m8DNRutU/BH
	 OZv6GDVATCc8d+Ky5A6im7hk7kvcBUb3kiM2nGUGfugSEYXZHHtMEsG2u1zDyWCIZl
	 +A0CuaphwaMKao2UxAaqf0YQuolHchKneSFNcMeQB256n5L8nKX5Bv+z3KG+Aqg60O
	 mJnvL6VWcDtXOKTGJKBbk4D7EZnVdeR0Cf1uTiV71ZBDZqaRhHnxqC2DhfXfIsRM4q
	 fHtML97fhppJg==
Subject:
 Re: [PATCH net v5 1/2] enic: retain admin-channel DMA until queues stop
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: netdev@vger.kernel.org, sebaddel@cisco.com, aradhana@cisco.com,
 rfaucett@cisco.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Date: Sat, 07 Nov 2026 15:03:05 +0000
Message-ID: <179406378503.994134.16615988654708205370@kernel.org>
In-Reply-To: <20261103-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v5-1-2501d1223eff@cisco.com>
References: <20261103-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v5-1-2501d1223eff@cisco.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The comments above the admin channel close in enic_reset() and
  enic_tx_hang_reset() (drivers/net/ethernet/cisco/enic/enic_main.c)…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  edits the exact lines involved.

--

enic: retain admin-channel DMA until queues stop

This commit tracks the SR-IOV admin channel as DOWN, LIVE or QUARANTINED.
If the admin queues cannot be shown to have stopped, the admin WQ/RQ/CQ
allocation is kept instead of freed. The reset workers refuse to reset or
reopen a quarantined channel, and when a final recheck fails, probe unwind
and removal keep the inert resources and the PCI reservation until reboot.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 6b5824f45a14c..4d616c3732dae 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c

[ ... ]

> @@ -2273,8 +2288,17 @@ static void enic_reset(struct work_struct *work)
>  	 * DMAs from the about-to-be-reset rings) and frees the admin resources
>  	 * so they are cleanly re-allocated afterwards.
>  	 */
> -	if (enic_has_admin_chan(enic))
> +	if (enic_has_admin_chan(enic)) {
>  		enic_admin_channel_close(enic);

[Severity: Low]
This isn't a bug, but is this comment still accurate? After this patch,
enic_admin_channel_close() frees the admin resources only when both
enic_admin_wq_disable() and enic_admin_rq_disable() succeed:

	if (wq_err || rq_err) {
		WRITE_ONCE(enic->admin_chan_state, ENIC_ADMIN_CHAN_QUARANTINED);
		mutex_unlock(&enic->mbox_lock);
		...
		return wq_err ?: rq_err;
	}

	enic_admin_channel_release(enic);

Otherwise the WQ/RQ/CQ allocation is kept and the channel is quarantined.
The new quarantine branch just below depends on that.

enic_tx_hang_reset() has the same wording ("stop the admin QP and free
the admin resources before the hardware queues are wiped").

Should both comments mention the quarantine case?

> +		/* Channel close has drained registration replies. */
> +		if (enic_is_sriov_vf_v2(enic))
> +			WRITE_ONCE(enic->vf_registered, false);
> +	}
> +	if (enic_admin_channel_is_quarantined(enic)) {
> +		/* Core close excludes netpoll and clears __LINK_STATE_START first. */
> +		dev_close(enic->netdev);
> +		goto reset_out;
> +	}
>  
>  	enic_stop(enic->netdev);
>  	if (enic_is_sriov_vf_v2(enic))
> @@ -2287,7 +2311,8 @@ static void enic_reset(struct work_struct *work)
>  	enic_dev_set_ig_vlan_rewrite_mode(enic);
>  	enic_ext_cq(enic);
>  
> -	enic_open(enic->netdev);
> +	if (enic_open(enic->netdev))
> +		goto reset_out;

[Severity: High]
This is a pre-existing issue, since the old code also ignored the return
value of enic_open(). These lines are being changed here, though, so: what
state is the netdev left in when this internal enic_open() fails?

enic_stop() above has already disabled every RQ/WQ NAPI and released the
datapath resources.

If enic_open() fails early, it never reaches napi_enable(). That covers
enic_request_intr(), enic_dev_notify_set(), page_pool_create(), and an RQ
fill that posts no buffers. If it fails in enic_dev_enable(), the
err_out_dev_enable path disables the NAPIs again.

In both cases the device is still marked IFF_UP and __LINK_STATE_START.
Nothing calls dev_close() here, unlike the quarantine branches above.

A later ip link set down, dev_close() or unregister_netdev() (including
from enic_remove()) would run enic_stop() a second time:

enic_stop()
    for (i = 0; i < enic->rq_count; i++)
        napi_disable(&enic->napi[i]);

napi_disable_locked() would then wait on a NAPI that is already disabled:

    while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
        usleep_range(20, 200);
        val = READ_ONCE(n->state);
    }

Can this loop forever while holding RTNL?

A possible trigger: an RQ/WQ error interrupt schedules enic->reset, or
ndo_tx_timeout schedules tx_hang_reset. Then an allocation or
request_irq() call fails inside enic_open().

enic_tx_hang_reset() has the same goto reset_out pattern. Should this
failure path call dev_close() too?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v5-0-2501d1223eff%40cisco.com
