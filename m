Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918106;
	b=P1u3SaTvFTbYV4NM8KEczhn1vvdNetY34nHxf3I9+ZaSa6B0wMn2JtBmdzPuQs097Xxn
	 ixWKvNqyMRtKZB5nA4AX2pMU70gdXe8GaeQc2PKYGi78JbSr6OTENzoD2MjwjL6N86RUd
	 MEJdUI9jAJZn6FgQyuZwJvz6579M1Ov4Kfywqc841pzcGL9PBzy4aMFofB74ga2wH3WEp
	 +7wWOikb/MDnRCfj7fqbGQzRNo/YevYRi6tlFYqlE9kLUJQA1YDadv/cg1o+64uNvWAAv
	 TvsjK6xTlf6W64qxXUuTll86jq24CXI4VKT+eGeCDocKy3541kBzSmwm6wjmX+P2b1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918106;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VYePqSp3UHZ8+a1rLTFcfsl5VnQOJdoKRfC16FrxkCo=;
	b=yosC+KMPkpV2rEQl6IfqZN/5O11xXYwI0eq4VQbpHFNvrzv5DbkQDO5P4OBo/b9ihWAG
	 mYYIsdID5jiYrywtpMq7RpycrrpLEdN6vqfOhyFCgmxFWfgHQLJ48fJLa1p3JVVWYoWxN
	 LeQDlxmHdqFOmE5i0XhpSstbcEqAx5STjWpHyJXyW+D+1sb/cFmCuROS9wa9HlQp/AxT7
	 EN30PGA8UKbo54lQOEOkToEi715ieE5X/BV3QYBk0xtmc4nLzGEM1tg36+TtusAsHTrEY
	 AjYFUOs3pSQeiSnCmBas/ginWjD3s/p5hXLHhWASkOYsLKU9YM4goVoz3dVaCjWQFcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqjbNSAj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF43606A326;
	Thu,  5 Nov 2026 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqjbNSAj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABBB1F0089F;
	Thu,  5 Nov 2026 22:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793918106;
	bh=VYePqSp3UHZ8+a1rLTFcfsl5VnQOJdoKRfC16FrxkCo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LqjbNSAjFywzD5hkDrGcCGO6wgckAjZGGqllHyUa6Tz4oDQJKN1fVCNdkJzzBzlwn
	 CsX8ExpgXWcTjyLs8tXcar0SbyIfUuToMHkF60S3/75Ez6sGyJEnjTMWFz8YOObR6P
	 vtJd/ehQssXZxn6bEyPrOS3R3q20WwJcBL0kCvxHl+u05bEucSY/1azBsVq/9h3V5X
	 Fgu7FJk+0D3ArSINLdAA4bTOwYZsA9YqQ7puz8JooH/xCFtnCElXfYBB0anRgxPsbP
	 MpEriObvN8EFp0+YTHwxioRhhTFVe4P/kvDQs7ZpI/zoLhb5guwmr2p4c5nFL9kL1S
	 rsGm6kWJxYecQ==
Subject: Re: [PATCH net] cxgb4: clear the sge maps and bitmaps freed on
 adap_init0()  failure
From: netdev-bot+sashiko@kernel.org
To: fourier.thomas@gmail.com
Cc: bharat@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 hariprasad@chelsio.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Nov 2026 22:35:05 +0000
Message-ID: <179391810514.994134.16852328785487927041@kernel.org>
In-Reply-To: <20261104103309.24360-2-fourier.thomas@gmail.com>
References: <20261104103309.24360-2-fourier.thomas@gmail.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not fully fix the scenario it targets:
  remove_one() after adap_init0() fails in eeh_reset_done() still…

Pre-existing issues:
- [High] When adap_init0(adapter, 1) fails from eeh_reset_done(), the
  adapter is left registered and usable while its SGE maps are gone.
- [Medium] adap_init0() allocates adap->sge.egr_map, ingr_map,
  starving_fl, txq_maperr and (under CONFIG_DEBUG_FS) blocked_fl…
- [Medium] The debugfs 'blocked_fl' handlers read adap->sge.blocked_fl
  and adap->sge.egr_sz without any lock.

--

cxgb4: clear the sge maps and bitmaps freed on adap_init0() failure

This patch sets sge.egr_map, sge.ingr_map, sge.starving_fl, sge.txq_maperr
and sge.blocked_fl to NULL after the bye: label of adap_init0() frees them.
The goal is to avoid a second free in free_some_resources() from
remove_one() after adap_init0() fails when called from eeh_reset_done().

> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> index 1ced6df6eac8c..d4fe6aa185399 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> @@ -5402,11 +5402,16 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
>  bye:
>  	adap_free_hma_mem(adap);
>  	kfree(adap->sge.egr_map);
> +	adap->sge.egr_map = NULL;
>  	kfree(adap->sge.ingr_map);
> +	adap->sge.ingr_map = NULL;

[Severity: High]
Does this fully close the remove_one() case described in the commit
message?

eeh_reset_prepare() doesn't free the ULD rx queues. It calls cxgb_down(),
and t4_free_sge_resources() only frees the ethernet, ctrl, fw_evtq, intrq
and ptp queues. After the reset, the ULD queues still have rspq.desc set
and adap->uld[type].handle is still set.

If adap_init0(adapter, 1) then fails in eeh_reset_done(), ingr_map is now
NULL. remove_one() calls t4_uld_clean_up() before it reaches
free_some_resources():

remove_one()
  detach_ulds()
  t4_uld_clean_up()
    cxgb4_shutdown_uld_adapter()
      free_sge_queues_uld()
        t4_free_uld_rxqs()
          free_rspq_fl()

drivers/net/ethernet/chelsio/cxgb4/sge.c:free_rspq_fl() {
    ...
	adap->sge.ingr_map[rq->cntxt_id - adap->sge.ingr_start] = NULL;
    ...
}

Wouldn't this write through a NULL ingr_map and oops whenever a ULD such
as iw_cxgb4, chcr, cxgbit or cxgb4i has rx queues allocated? ULD rx queues
get allocated whenever a ULD registers, because setup_sge_queues_uld() is
not gated on CXGB4_FULL_INIT_DONE.

Before this patch the same store was a use-after-free write, followed later
by the double free. So it looks like only the failure mode changes.

Would it be better to keep the maps valid on the EEH re-init path, instead
of freeing and clearing the live adapter's maps in bye:?

>  	bitmap_free(adap->sge.starving_fl);
> +	adap->sge.starving_fl = NULL;
>  	bitmap_free(adap->sge.txq_maperr);
> +	adap->sge.txq_maperr = NULL;

[Severity: High]
This is a pre-existing issue, but when adap_init0() fails from
eeh_reset_done(), the adapter stays registered with these maps gone.
sge.egr_sz and sge.ingr_sz keep their old non-zero values.

eeh_reset_done() just returns:

	err = adap_init0(adapter, 1);
	if (err) {
		dev_err(adapter->pdev_dev,
			"Adapter init failed, err %d", err);
		return;
	}

The netdevs, the debugfs files and the ULD registration all stay
reachable. Several users index the maps using only the sizes.

cxgb_open() only checks CXGB4_FULL_INIT_DONE, and eeh_reset_prepare()
cleared that flag through cxgb_down():

	if (!(adapter->flags & CXGB4_FULL_INIT_DONE)) {
		err = cxgb_up(adapter);

So bringing the interface up again goes into
cxgb_up()->setup_sge_queues(). If that succeeds, t4_sge_alloc_rxq() stores
into the maps:

	adap->sge.ingr_map[iq->cntxt_id - adap->sge.ingr_start] = iq;

If it fails, the freeout: path calls t4_free_sge_resources(), which does:

	memset(adap->sge.egr_map, 0,
	       adap->sge.egr_sz * sizeof(*adap->sge.egr_map));

A later ULD registration runs cxgb4_uld_alloc_resources()->
setup_sge_queues_uld()->t4_sge_alloc_rxq() and writes the same maps.

The debugfs blocked_fl_write() in cxgb4_debugfs.c also does:

	bitmap_copy(adap->sge.blocked_fl, t, adap->sge.egr_sz);

Before this patch these were use-after-free writes, and with it they
become NULL pointer dereferences.

Should a failed re-init in eeh_reset_done() leave the adapter in a state
where these paths can still run?

>  #ifdef CONFIG_DEBUG_FS
>  	bitmap_free(adap->sge.blocked_fl);
> +	adap->sge.blocked_fl = NULL;

[Severity: Medium]
This is a pre-existing issue, but does anything serialize the debugfs
blocked_fl handlers against this free?

blocked_fl_read() and blocked_fl_write() in cxgb4_debugfs.c use
adap->sge.blocked_fl and adap->sge.egr_sz without a lock. At the same time,
eeh_reset_done()->adap_init0() can reassign egr_sz, reallocate blocked_fl,
or free it here:

CPU1: blocked_fl_write()
        uses adap->sge.blocked_fl (old pointer)
CPU0: eeh_reset_done()->adap_init0()
        bye: bitmap_free(adap->sge.blocked_fl)
CPU1:   bitmap_copy(adap->sge.blocked_fl, t, adap->sge.egr_sz)

Can a blocked_fl_write() that runs at the same time as a failing re-init
write into the bitmap that bye: has just freed?

>  #endif
>  	if (ret != -ETIMEDOUT && ret != -EIO)
>  		t4_fw_bye(adap, adap->mbox);

[Severity: Medium]
This isn't a bug introduced by this patch, but does adap_init0() leak the
probe-time egr_map, ingr_map, starving_fl, txq_maperr and blocked_fl
buffers on every EEH/FLR reset?

adap_init0() allocates them unconditionally, without checking whether the
pointers are already set:

	adap->sge.egr_map = kzalloc_objs(*adap->sge.egr_map, adap->sge.egr_sz);

eeh_reset_prepare() only frees the HMA memory:

	adap_free_hma_mem(adapter);

So when eeh_reset_done() calls adap_init0(adapter, 1), the pointers from
probe are overwritten.

If the re-init fails partway through, for example if the ingr_map
allocation fails after egr_map was reallocated, bye: frees only the new
buffers. The overwritten probe-time buffers are still leaked.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104103309.24360-2-fourier.thomas%40gmail.com
