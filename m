Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527827;
	b=YUxlcrH0h+Y/mZdP8f9gm7SOBQjSwvFvA1kh6TjMOyTO8LIrVh1PWR9m4wJ7NbgHEA12
	 VjM3VqxsZBy7+OO0fv5FCWeZY5sdIC0oKOv2fIk4/HxH0jJlOvE/Fe2GYRg85plBjIeys
	 y4ZBruJnjAgEFGyIBvB6lD/HUWatasblwY/ZGS3S2m29mYP49cGwTQbQx+BqMakFCKjId
	 ZQL4uNMygKBfaAQBmNqbXJz+EUwqVMXyLqwlWiOL5mcrqSRTtsiNLY6kJACUKtF5QncYw
	 l+beLcYwyndwK61JA2sN2axleBHWM+QIzF5o+SfHB4YFMYWrCmOS9vW3USdHsv84Ndw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527827;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=j5a2fyilhzypJaXUupxgR2TbudWZ2Q6TeBpDzC8i4TY=;
	b=jQGuLhwf8jAWRUzFryT3US9F80mLyFsflIXNakn4OLR/8ALXSC+hnliPBTUKyzY93cNC
	 hC04ql0MWXyU/cX7cuZvm5dR946nzhSzGW+R7RK2n1gTmSo38iVAv4LGPmnBJtBBiZ9yu
	 2bYrwEAlF0ea4aQI/bJJsO93KH/LBRoM0QgIqSbrV4CjLomW0wAhyA/ltYSGRm5DAoL7P
	 CJA2G/2ly+H3XvA4ydrBQQmXxTsdIKHEd8dPjW1iaJcR/eK5mh6MXD4NhOqlHpz97fF2i
	 AJfR22A5ncqPL1gqwneb/GnAXJBOF3/m2ezm2h0M0r9qYieB/j6fn0Fi7VYCXWUOkyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QaHb6HQB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8B2606A8AA
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QaHb6HQB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C1E1F000C5;
	Thu, 12 Nov 2026 23:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527827;
	bh=j5a2fyilhzypJaXUupxgR2TbudWZ2Q6TeBpDzC8i4TY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QaHb6HQBGUvNVYAAJjVbh8PXBRY8Y0UlqbQXBlQH4W8X5Rz/GoLxMX6vCVZP1gay3
	 84lAPHdPdCZk0TSEiE3ZaucrWCFfbx/20wxjVgOSjrOWmsi7Ifz1S8svJXqsEV7v9n
	 r5X1CjtPlqVujjvvGwWeKch26V18cjJ/9v2GiWFtLEk9quxTEs89fLx3zHRBZ5Yz+f
	 FTI18d7LE3LaIcyPqNwaqi0HDgQO26A7TSuczuxm8Y6tswv1YOhSuvhewBMfxHohZ+
	 lVLNcrgHNaa5a/WzuzoXArAvC6V/dxR8+cGe4Pr6h/yjhT3GyCLBTnWRXoKIRJieS7
	 Ugi9lL1itnaJg==
Subject: Re: [PATCH net-next v8 08/15] ibmveth: Add queue-aware RX buffer
 submit helper for MQ
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
 bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Date: Thu, 12 Nov 2026 23:57:06 +0000
Message-ID: <179452782614.2199510.1440637845040356587@kernel.org>
In-Reply-To: <20261109235556.60604-9-mmc@linux.ibm.com>
References: <20261109235556.60604-9-mmc@linux.ibm.com>
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

- [Low] This patch raises IBMVETH_MAX_RX_PER_HCALL to 12, so
  descs[]/correlators[] in ibmveth_replenish_buffer_pool() now hold 12…
- [Low] The subject, "Add queue-aware RX buffer submit helper for MQ",
  reads like a prep-only patch, but the patch also changes behaviour on…
- [Low] This patch makes ibmveth_rxq_correlator_valid() check
  `!bpool->active || !bpool->skbuff || !bpool->free_map`, with the…
- [Low] When multi_queue is set, an H_FUNCTION from
  H_ADD_LOGICAL_LAN_BUFFERS_QUEUE yields IBMVETH_REPLENISH_RESET_MQ, and…

--

ibmveth: Add queue-aware RX buffer submit helper for MQ

This patch passes a queue index through the RX accessors, the replenish
path and buffer pool access. It also adds ibmveth_add_logical_lan_buffers(),
which uses H_ADD_LOGICAL_LAN_BUFFERS_QUEUE in multi-queue mode and the
legacy hcalls otherwise. It adds a per-queue replenish_lock, gives the
replenish code return values so logging happens after unlock, and raises
IBMVETH_MAX_RX_PER_HCALL to 12.

> ibmveth: Add queue-aware RX buffer submit helper for MQ

[Severity: Low]
This isn't a bug, but the subject reads like a prep-only change. The patch
also changes behaviour on the existing single-queue path:

  - a per-queue spin_lock_bh() around harvest/remove and replenish
  - IBM_VETH_INVALID_MAP handling (no WARN, the partial batch is dropped,
    a reset is scheduled)
  - DMA_ATTR_NO_WARN on the RX maps
  - reworked hcall-failure, fallback and IRQ-enable logging
  - pool->available cleared in ibmveth_free_buffer_pool()
  - a stricter ibmveth_rxq_correlator_valid() that now also requires an
    active pool and a free_map

The body does document these ("The correlator and locking changes do take
effect immediately, on the single queue").

Would bisecting or reverting be easier if the single-queue behaviour
changes were split out from the MQ plumbing?

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index e2aa108655676..a1f286b37effa 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -726,11 +728,103 @@ static inline void ibmveth_flush_buffer(void *addr, unsigned long length)

[ ... ]

> +	} else if (filled == 1) {
> +		rc = h_add_logical_lan_buffer(vdev->unit_address,
> +					      descs[0].desc);
> +	} else {
> +		/* Legacy 8-desc hcall; probe/mq_fallback keep batch <=
> +		 * IBMVETH_MAX_RX_REGULAR.
> +		 */
> +		rc = h_add_logical_lan_buffers(vdev->unit_address,
> +					       descs[0].desc, descs[1].desc,
> +					       descs[2].desc, descs[3].desc,
> +					       descs[4].desc, descs[5].desc,
> +					       descs[6].desc, descs[7].desc);
> +	}

[Severity: Low]
This legacy branch always passes descs[0] through descs[7] and never looks
at filled. Because IBMVETH_MAX_RX_PER_HCALL is now 12, descs[] in
ibmveth_replenish_buffer_pool() holds 12 entries.

The comment says "probe/mq_fallback keep batch <= IBMVETH_MAX_RX_REGULAR".
There is no mq_fallback anywhere in the driver at this commit. Is the
comment describing a guard that only arrives later in the series?

Nothing appears to trigger this today. At this commit probe sets
multi_queue = 0, and it sets rx_buffers_per_hcall to either
IBMVETH_MAX_RX_REGULAR or 1. Later in the series,
ibmveth_apply_mq_fallback() clears multi_queue and clamps
rx_buffers_per_hcall to IBMVETH_MAX_RX_REGULAR at the start of open, so
the limit seems to hold across the series.

Suppose rx_buffers_per_hcall did go above 8 with multi_queue false.
Descriptors 8 to 11 would never be posted. The success path in
ibmveth_replenish_buffer_pool() would still set every filled free_map slot
to IBM_VETH_INVALID_MAP and add filled to pool->available.

Would a WARN_ON_ONCE(filled > IBMVETH_MAX_RX_REGULAR) here be worth adding,
or a comment that does not mention mq_fallback?

[ ... ]

> @@ -917,21 +1014,91 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)

[ ... ]

> +	/* Log and schedule reset only after dropping replenish_lock. */
> +	if (need_reset == IBMVETH_REPLENISH_RESET_MAP) {
> +		netdev_info(adapter->netdev,
> +			    "Invalid RX free_map entry on queue %d, reset\n",
> +			    queue_index);
> +		schedule_work(&adapter->work);
> +	} else if (need_reset == IBMVETH_REPLENISH_RESET_MQ) {
> +		dev_err_ratelimited(&adapter->netdev->dev,
> +				    "MQ buffer add H_FUNCTION (q=%d, batch=%u), reset\n",
> +				    queue_index, fail.batch);
> +		schedule_work(&adapter->work);
> +	}

[Severity: Low]
In multi-queue mode, when H_ADD_LOGICAL_LAN_BUFFERS_QUEUE returns
H_FUNCTION, ibmveth_replenish_buffer_pool() returns
IBMVETH_REPLENISH_RESET_MQ. ibmveth_replenish_task() then only logs and
calls schedule_work().

At this commit nothing records a fallback to single-queue mode. Wouldn't
the reset reopen in MQ mode, get H_FUNCTION from the same hcall again, and
loop?

This arm can't be reached here, because probe hard-codes multi_queue = 0.
The commit message says so too. Later in the series ("ibmveth: Complete
set_channels down-path"), this arm calls
WRITE_ONCE(adapter->mq_fallback, true) before schedule_work(), and
ibmveth_open() calls ibmveth_apply_mq_fallback(), which clears multi_queue.

Could the commit message say that recovery for this arm depends on those
later patches?

[ ... ]

> @@ -1133,33 +1298,77 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)

[ ... ]

> +	bpool = &adapter->rx_buff_pool[queue_index][pool];
> +
> +	/* Require a live pool with allocated arrays before indexing.
> +	 * Inactive pools still have size from init; free clears skbuff.
> +	 */
> +	if (!bpool->active || !bpool->skbuff || !bpool->free_map)
> +		return false;

[ ... ]

> @@ -3146,26 +3401,41 @@ static void ibmveth_remove_buffer_from_pool_test(struct kunit *test)

[ ... ]

>  	/* Pool 2 is in range but has no skbuff array, like an inactive pool. */
>  	correlator = ((u64)2 << 32) | 0;
> -	ret = ibmveth_remove_buffer_from_pool(adapter, correlator, false);
> +	ret = ibmveth_remove_buffer_from_pool(adapter, correlator, 0, false);
>  	KUNIT_EXPECT_EQ(test, -EINVAL, ret);
> -	ret = ibmveth_remove_buffer_from_pool(adapter, correlator, true);
> +	ret = ibmveth_remove_buffer_from_pool(adapter, correlator, 0, true);
>  	KUNIT_EXPECT_EQ(test, -EINVAL, ret);

[Severity: Low]
Does this case still reach the !bpool->skbuff check in
ibmveth_rxq_correlator_valid()?

pool_active[] in ibmveth.h is { 1, 1, 0, 0, 1 }, so pool 2 is inactive. The
new !bpool->active test comes first, so this case is rejected there before
the skbuff check runs. Before this patch it did exercise the skbuff check.
The pool 2 case in ibmveth_rxq_get_buffer_test() has the same problem.

No case covers an active pool with skbuff set and free_map NULL, so the new
!bpool->free_map check is not tested at all. If either the skbuff check or
the free_map check were deleted, every KUnit case would still pass.

These tests are unchanged at the end of the series. Would it make sense to
add cases for an active pool with a NULL skbuff and an active pool with a
NULL free_map?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109235556.60604-1-mmc%40linux.ibm.com
