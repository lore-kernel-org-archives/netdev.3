Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B85442B16
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013036; cv=none; b=RyjcQ9zJyczRIc48r6wf1Z728ehImuBNULW7Vm3s9Lai7TyGb0mnuzgv20t3uoBlYNo2onXOXxoBI0wG/uXs5Safn4z3xxDVvWIgsKMpwdkLOaJ8+astkP9erp+tMYYARk4A/FIEqYriLLcNqVH+mTK/O7OaDGVbOHn7lep8Vcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013036; c=relaxed/simple;
	bh=mJ+RN8ePvhVJF5AlsN3C0MS6Tw0qV6ACVMQ3C83OyuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXcrpCwJnPuc4OAG0V1NFIeN4Xzkj5Fga4OUQSHuYgBHL3deIEnkmasPgGqmsHQmz/OfTj1VmXe/sP6PsSsK/U+cIxDMiIUX4FfCyqyyEjeCxfpVS/bw3rc9hExvc5pah7S54UfGwPMBC6d8v+zLaPU2wF7VrwDERObBmUfIz3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAwiTyjj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAwiTyjj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786013031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBjMr6cegFyxVHZZAtwE1vAY/RYiMu3UJwSU7HdYUVo=;
	b=UAwiTyjjP//s1Zn7wUTH3JeGqDVErlHtGZEe3pTkkeZMEgJZ4/DBwf33AUNwDzwR3HCptw
	SeZQsKAvO9N9EQN+aXnUXsF5JmloRKezIYxeFVtauBpvG2lgb7Cx6gUbiSpam5b/6m78U/
	5vCk8nanB9OBFtBnz1ntFvkFpoIA5OI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-MijakqcQOcCv4YlXzWa8vg-1; Thu,
 06 Aug 2026 06:43:42 -0400
X-MC-Unique: MijakqcQOcCv4YlXzWa8vg-1
X-Mimecast-MFC-AGG-ID: MijakqcQOcCv4YlXzWa8vg_1786013020
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3295018007E9;
	Thu,  6 Aug 2026 10:43:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.123])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7FD86180034C;
	Thu,  6 Aug 2026 10:43:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: Selvamani.Rajagopal@onsemi.com
Cc: parthiban.veerasooran@microchip.com,
	andrew+netdev@lunn.ch,
	pier.beruto@onsemi.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrew@lunn.ch,
	Parthiban.Veerasooran@microchip.com
Subject: Re: [PATCH net v5 2/4] net: ethernet: oa_tc6: Improve the error recovery
Date: Thu,  6 Aug 2026 12:43:23 +0200
Message-ID: <20260806104323.151154-1-pabeni@redhat.com>
In-Reply-To: <20260729-fix-race-condition-and-crash-v5-2-3906bc485daf@onsemi.com>
References: <20260729-fix-race-condition-and-crash-v5-2-3906bc485daf@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
--- Patch [2]: [PATCH net v5 2/4] net: ethernet: oa_tc6: Improve the error recovery ---
commit f8f47e53b81fcb2cf25c3e00de04be99437717cf
Author: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

net: ethernet: oa_tc6: Improve the error recovery

This patch adds a tailroom check before skb_put() in the oa_tc6 receive
path, turns the rx skb update helpers into functions returning an error
code, and makes oa_tc6_process_spi_data_rx_buf() continue over
recoverable (-EAGAIN/-ENOMEM) errors instead of bailing out on the first
one.  A new helper oa_tc6_look_for_new_frame() bundles setting
rx_buf_overflow with dropping the in-progress rx skb.

No Link: tags present in the commit header.

> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 5b24cce4f9b56..421f72e6f71e3 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c
> @@ -710,6 +710,12 @@ static void oa_tc6_free_pending_skbs(struct oa_tc6 *tc6)
>  	oa_tc6_cleanup_waiting_tx_skb(tc6);
>  }
>  
> +static void oa_tc6_look_for_new_frame(struct oa_tc6 *tc6)
> +{
> +	tc6->rx_buf_overflow = true;
> +	oa_tc6_cleanup_ongoing_rx_skb(tc6);
> +}
> +

[Severity: Low]
[Finding: main-1-2]
[Sources: opus-5]
Should the rx_buf_overflow field keep that name after this change?

The flag is now also set for conditions that are not MAC-PHY receive
buffer overflows: exhausted skb tailroom and rx_skb == NULL in
oa_tc6_update_rx_skb(), plus the blanket per-buffer retry at the end of
oa_tc6_process_spi_data_rx_buf(), which also covers -ENOMEM from
netdev_alloc_skb_ip_align().

Would a rename (something like rx_resync or skip_until_frame_start), or a
second flag, keep the two conditions distinguishable when debugging?

[ ... ]

> @@ -835,13 +844,35 @@ static void oa_tc6_submit_rx_skb(struct oa_tc6 *tc6)
>  	tc6->rx_skb = NULL;
>  }
>  
> -static void oa_tc6_update_rx_skb(struct oa_tc6 *tc6, u8 *payload, u8 length)
> +/* On oversubscribed traffic condition, particularly with overwhelming rx
> + * buffer overflow errors, there could be data chunk loss. If tail + length
> + * goes beyond end pointer, that is an indication that the data chunk with
> + * end_valid bit is lost. Time to look for a data chunk with start_valid bit.
> + *
> + * If rx_skb is NULL, it is time to start looking for data chunk with
> + * start_bit.
> + */
> +static int oa_tc6_update_rx_skb(struct oa_tc6 *tc6, u8 *payload, u8 length)
>  {
> +	if (!tc6->rx_skb ||
> +	    (tc6->rx_skb->tail + length) > tc6->rx_skb->end) {
> +		oa_tc6_look_for_new_frame(tc6);
> +		return -EAGAIN;
> +	}
> +
>  	memcpy(skb_put(tc6->rx_skb, length), payload, length);
> +	return 0;
>  }

[Severity: Low]
[Finding: main-1-1]
[Sources: opus-5]
This isn't a bug, but could this use the documented accessor instead of
reaching into the sk_buff layout fields?

	if (!tc6->rx_skb || skb_tailroom(tc6->rx_skb) < length)

The arithmetic here does match the overflow test inside skb_put() for both
representations selected by NET_SKBUFF_DATA_USES_OFFSET, but skb->tail and
skb->end are internal fields, and skb_tailroom() in
include/linux/skbuff.h additionally returns 0 for non-linear skbs.

[ ... ]

> @@ -946,6 +980,15 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
>  		if (tc6->rx_skb) {
>  			size = end_byte_offset + 1;
>  			oa_tc6_prcs_rx_frame_end(tc6, data, size);
> +
> +			/* Return value from oa_tc6_prcs_rx_frame_end is not
> +			 * checked. If it returned an error, it is to make
> +			 * the code to look for new frame. At this stage,
> +			 * code below is going to process a new frame. So,
> +			 * error condition is set to false, in case it is
> +			 * set before proceeding.
> +			 */
> +			tc6->rx_buf_overflow = false;
>  		}
>  		size = OA_TC6_CHUNK_PAYLOAD_SIZE - start_byte_offset;
>  		return oa_tc6_prcs_rx_frame_start(tc6,

[ ... ]

> @@ -972,8 +1013,9 @@ static u32 oa_tc6_get_rx_chunk_footer(struct oa_tc6 *tc6, u16 footer_offset)
>  static int oa_tc6_process_spi_data_rx_buf(struct oa_tc6 *tc6, u16 length)
>  {
>  	u16 no_of_rx_chunks = length / OA_TC6_CHUNK_SIZE;
> +	bool retry = false;
> +	int ret = 0;
>  	u32 footer;
> -	int ret;
>  
>  	/* All the rx chunks in the receive SPI data buffer are examined here */
>  	for (int i = 0; i < no_of_rx_chunks; i++) {
> @@ -982,8 +1024,11 @@ static int oa_tc6_process_spi_data_rx_buf(struct oa_tc6 *tc6, u16 length)
>  						    OA_TC6_CHUNK_PAYLOAD_SIZE);
>  
>  		ret = oa_tc6_process_rx_chunk_footer(tc6, footer);
> -		if (ret)
> -			return ret;
> +		if (ret) {
> +			if (ret != -EAGAIN)
> +				return ret;
> +			retry = true;
> +		}

[Severity: Medium]
[Finding: main-2-5]
[Sources: opus-5]
Since the loop no longer returns on the first -EAGAIN, how many STATUS0
control transfers does one buffer now cost?

Every remaining footer in the same buffer that has
OA_TC6_DATA_FOOTER_EXTENDED_STS set re-enters
oa_tc6_process_extended_status(), which does a blocking
oa_tc6_read_register(OA_TC6_REG_STATUS0) plus an
oa_tc6_write_register() write-back, each taking spi_ctrl_lock, even
though the first invocation already latched and cleared the error.

All footers of one buffer are sampled on the wire before any of them is
processed, so a single overflow event tends to leave the extended status
bit set in most footers of that buffer.  With OA_TC6_MAX_TX_CHUNKS = 48
that turns one read/write pair into up to 48 pairs of control transfers
in the SPI IRQ thread, before the received frames are handed to the
stack.

Does that delay the next data transfer that drains the MAC-PHY receive
buffer, and could it aggravate the overflow condition being recovered
from?  The commit message does not mention this side effect.

>  
>  		/* If there is a data valid chunks then process it for the
>  		 * information needed to determine the validity and the location
> @@ -995,12 +1040,35 @@ static int oa_tc6_process_spi_data_rx_buf(struct oa_tc6 *tc6, u16 length)
>  
>  			ret = oa_tc6_prcs_rx_chunk_payload(tc6, payload,
>  							   footer);
> -			if (ret)
> -				return ret;
> +			if (ret) {
> +				if (ret != -ENOMEM && ret != -EAGAIN)
> +					return ret;
> +				retry = true;
> +			}
>  		}
>  	}
>  
> -	return 0;
> +	/* Not bailing out on recoverable error codes, -EAGAIN and
> +	 * -ENOMEM. If subsequent loop iterations, if any, succeeds,
> +	 * error code would be overwritten. retry flag helps to
> +	 * make the caller to continue and retry. Since recovery
> +	 * action for -ENOMEM and -EAGAIN are same, we are returning
> +	 * one of the error codes, that is -EAGAIN.
> +	 *
> +	 * Successful recovery depends on how small the frames are,
> +	 * how many chunks, among the received chunks triggered the
> +	 * error, whether data is intact even with error conditions.
> +	 * As a result, there is no single, best method to recover
> +	 * most data when error conditions hit. We do our best by
> +	 * processing all the chunks with good "footer header" and
> +	 * "data valid" bit set.
> +	 */
> +	if (retry) {
> +		ret = -EAGAIN;
> +		oa_tc6_look_for_new_frame(tc6);
> +	}
> +
> +	return ret;
>  }

[Severity: Medium]
[Finding: main-1-0]
[Sources: opus-5]
Can this drop a frame that was already successfully re-synchronized
inside the same buffer?

The retry flag is sticky, so oa_tc6_look_for_new_frame() runs at loop exit
even when a later chunk recovered.  Sequence:

  chunk i:  extended status set, STATUS0 reports rx buffer overflow
            oa_tc6_process_extended_status()
               oa_tc6_look_for_new_frame()   /* rx_skb freed,
                                                rx_buf_overflow = true */
               return -EAGAIN
            loop sets retry = true and keeps going

  chunk j:  start_valid, so oa_tc6_prcs_rx_chunk_payload() does
               if (start_valid && tc6->rx_buf_overflow)
                       tc6->rx_buf_overflow = false;
            oa_tc6_prcs_rx_frame_start() -> oa_tc6_allocate_rx_skb()
            allocates a fresh rx_skb, later "ongoing" chunks append fine

  loop exit: retry is still true
               ret = -EAGAIN;
               oa_tc6_look_for_new_frame(tc6);   /* frees the good
                                                    rx_skb, rx_dropped++,
                                                    rx_buf_overflow = true */

On the next SPI transfer the continuation and end chunks of that frame are
then discarded by:

	if (tc6->rx_buf_overflow)
		return 0;

until another start_valid chunk arrives.  rx_chunks_available is 5 bits
(max 31) while a 1514-byte frame needs roughly 24 chunks of 64 payload
bytes, so a frame still in progress at buffer end is a normal occurrence.

This also appears to undo the tc6->rx_buf_overflow = false added in the
end-plus-start-in-one-chunk branch of oa_tc6_prcs_rx_chunk_payload().

Is the trailing call needed for state consistency at all?  The overflow
path already sets the flag in oa_tc6_process_extended_status(), the
tailroom and NULL paths set it in oa_tc6_update_rx_skb(), and the only
remaining case, -ENOMEM from oa_tc6_allocate_rx_skb(), leaves rx_skb NULL
so the next mid-frame chunk hits the !tc6->rx_skb branch and sets the
flag anyway.

[ ... ]

> @@ -1162,10 +1230,12 @@ static int oa_tc6_try_spi_transfer(struct oa_tc6 *tc6)
>  		}
>  
>  		ret = oa_tc6_process_spi_data_rx_buf(tc6, spi_len);
> -		if (ret) {
> -			if (ret == -EAGAIN)
> -				continue;
>  
> +		/* Not continuing with the next iteration to give
> +		 * waiting_tx_skb a chance to get drained, if
> +		 * needed.
> +		 */
> +		if (ret && ret != -EAGAIN) {
>  			oa_tc6_free_ongoing_skbs(tc6);
>  			netdev_err(tc6->netdev, "Device error: %d\n", ret);
>  			return ret;

[Severity: Low]
[Finding: main-3-7]
[Sources: opus-5]
Does this comment match the resulting control flow?  The while (true) loop
does proceed to the next iteration on -EAGAIN.

What changed is that the continue was removed, so the tail of the loop
body is now reached on the recoverable-error path:

	if (!tc6->waiting_tx_skb && netif_queue_stopped(tc6->netdev))
		netif_wake_queue(tc6->netdev);

That code wakes the tx queue, which lets the stack queue new skbs, rather
than draining waiting_tx_skb.  Could the comment be reworded to describe
the wake-queue check being reached?
-- 
This is an AI-generated review.

