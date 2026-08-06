Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC723D75AD
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008081; cv=none; b=VeUnGTctF00gKyR8iVDb2J+cpHL6DLAI3shWkyjQ5UJXHnCGKp8NFhE0QqPcybGIQ7ZBvtu9YDQeeBdUxRQxSDLkWQRDtp+ljuS1tuorRXzummnfLY5511IzsQOg0Y8G6sEpC8L3JSZdoYcazIpyomPAIJGJ+LCropnVNY8ja1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008081; c=relaxed/simple;
	bh=fGmYpTEiNk+JO+wfhI0oFajoqQKT9IciIdMI69xLKrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXeVm4DBrTHbZlQaC539zYjOMP0O9R0zW9PhfU/0XySf2oaL4+2op30uDz/d8MOBrprjBPpO67tJFvotVcc3Yxqmjq+fxawV4CpT414+FaMJX5mj2ftZXuD8p02FEJl/Oj86jNy06gjCQ5ct2GCYvxt8sTd3i9y6D3wG0lswVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDY4xEHJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDY4xEHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786008078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddcDaGWQnP3DHovKK3FR6OSlFiL10dOGuvB5d+yT2cY=;
	b=eDY4xEHJCbNAW35HIukZGCfcGSwaWCS9oNYXpUrSiExHbWkLM+sKP++s7yesdT5iImO22f
	nGZVlLbF8CRgys4DH0GMCNWGHWheTWgFOiP+p48+cthz4+N4/bQPTI2kvKe3UxTCFcKR9g
	iZAF9wrxlCumWMbrfEXWvqBs7Tzfffk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-EqR5JKJBNJySRScg-vI5Hg-1; Thu,
 06 Aug 2026 05:21:15 -0400
X-MC-Unique: EqR5JKJBNJySRScg-vI5Hg-1
X-Mimecast-MFC-AGG-ID: EqR5JKJBNJySRScg-vI5Hg_1786008073
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7131419560AB;
	Thu,  6 Aug 2026 09:21:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.123])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C48DB422;
	Thu,  6 Aug 2026 09:21:09 +0000 (UTC)
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
Subject: Re: [PATCH net v5 1/4] net: ethernet: oa_tc6: Protect skb pointer used by two different kernel instances
Date: Thu,  6 Aug 2026 11:20:55 +0200
Message-ID: <20260806092055.101202-1-pabeni@redhat.com>
In-Reply-To: <20260729-fix-race-condition-and-crash-v5-1-3906bc485daf@onsemi.com>
References: <20260729-fix-race-condition-and-crash-v5-1-3906bc485daf@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
--- Patch [1]: [PATCH net v5 1/4] net: ethernet: oa_tc6: Protect skb pointer used by two different kernel instances ---
commit e4a0f5cf54cb40242b52216e184b30bf2c9fff57
Author: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

net: ethernet: oa_tc6: Protect skb pointer used by two different kernel instances

This patch puts tc6->waiting_tx_skb accesses under the existing
tx_skb_lock, adds the helpers oa_tc6_drop_tx_skb() and
oa_tc6_detach_waiting_tx_skb(), and also brings tc6->disable_traffic
under the same lock in oa_tc6_disable_traffic(), oa_tc6_exit() and the
threaded IRQ handler.  A few questions below.

>     net: ethernet: oa_tc6: Protect skb pointer used by two different kernel instances
>
>     Threaded IRQ uses waiting_tx_skb. Transmit path also uses
>     this pointer without any mutual exclusion protection. As a
>     result, it might leak skb buffer, particularly threaded IRQ
>     runs in the middle of transmit path, near skb_linearize.

[Severity: Medium]
[Finding: main-1-1]
[Sources: opus-5]
Should the changelog mention the other behavioural changes that come with
this fix?  The message only describes adding mutual exclusion for
waiting_tx_skb, but the patch also:

 - changes oa_tc6_start_xmit() so the disable_traffic case drops the frame
   and returns NETDEV_TX_OK instead of netif_stop_queue() plus
   NETDEV_TX_BUSY,
 - moves skb_linearize() ahead of the busy/disabled checks,
 - brings disable_traffic under tx_skb_lock in oa_tc6_exit() and in
   oa_tc6_macphy_threaded_irq(),
 - converts the tx skb free from kfree_skb() to dev_kfree_skb_any() in the
   new oa_tc6_drop_tx_skb().

The exact interleaving that leaks the skb is also not spelled out.  Since
this carries a Fixes: tag and will be picked up for stable, could the
message describe the leaking sequence and the return-code change?  The
disable_traffic locking is only mentioned in the v3 changelog below the
cut, which is dropped when the patch is applied.

> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 0727d53345a33..5b24cce4f9b56 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c
> @@ -652,6 +652,26 @@ static int oa_tc6_enable_data_transfer(struct oa_tc6 *tc6)
>  	return oa_tc6_write_register(tc6, OA_TC6_REG_CONFIG0, value);
>  }
>  
> +/* Called when a frame that is meant to be transmitted, is dropped. */
> +static void oa_tc6_drop_tx_skb(struct oa_tc6 *tc6, struct sk_buff *skb)
> +{
> +	if (skb) {
> +		tc6->netdev->stats.tx_dropped++;
> +		dev_kfree_skb_any(skb);
> +	}
> +}
> +
> +static struct sk_buff *oa_tc6_detach_waiting_tx_skb(struct oa_tc6 *tc6)
> +{
> +	struct sk_buff *skb;
> +
> +	lockdep_assert_held(&tc6->tx_skb_lock);
> +	skb = tc6->waiting_tx_skb;
> +	tc6->waiting_tx_skb = NULL;
> +
> +	return skb;
> +}
> +
>  static void oa_tc6_cleanup_ongoing_rx_skb(struct oa_tc6 *tc6)
>  {
>  	if (tc6->rx_skb) {

[ ... ]

> @@ -693,9 +717,15 @@ static void oa_tc6_free_pending_skbs(struct oa_tc6 *tc6)
>  static void oa_tc6_disable_traffic(struct oa_tc6 *tc6)
>  {
>  	u32 regval = INT_MASK0_ALL_INTERRUPTS;
> +	struct sk_buff *skb;
>  
> +	spin_lock_bh(&tc6->tx_skb_lock);
>  	tc6->disable_traffic = true;
> -	oa_tc6_free_pending_skbs(tc6);
> +	skb = oa_tc6_detach_waiting_tx_skb(tc6);
> +	spin_unlock_bh(&tc6->tx_skb_lock);
> +
> +	oa_tc6_drop_tx_skb(tc6, skb);
> +	oa_tc6_free_ongoing_skbs(tc6);
>  	oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);
>  	oa_tc6_read_register(tc6, OA_TC6_REG_STATUS0, &regval);
>  	oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, regval);

[ ... ]

> @@ -1159,15 +1188,20 @@ static irqreturn_t oa_tc6_macphy_threaded_irq(int irq, void *data)
>  	 * no need to attempt spi transfer, once it fails. Pending skbs
>  	 * are already freed.
>  	 */
> -	if (!tc6->disable_traffic) {
> -		while (tc6->int_flag ||
> -		       (tc6->waiting_tx_skb && tc6->tx_credits)) {
> -			ret = oa_tc6_try_spi_transfer(tc6);
> -			if (ret) {
> -				disable_irq_nosync(tc6->spi->irq);
> -				oa_tc6_disable_traffic(tc6);
> -				break;
> -			}
> +	spin_lock_bh(&tc6->tx_skb_lock);
> +	if (tc6->disable_traffic) {
> +		spin_unlock_bh(&tc6->tx_skb_lock);
> +		return IRQ_HANDLED;
> +	}
> +	spin_unlock_bh(&tc6->tx_skb_lock);

[Severity: Low]
[Finding: fable-5-5-19]
[Sources: fable-5, opus-5]
Is tx_skb_lock the right lock for tc6->disable_traffic?

The writers in oa_tc6_disable_traffic() and oa_tc6_exit() and this reader
now take a spin_lock_bh() lock, but the primary hard IRQ handler still
reads the same bool with a plain load and cannot take a BH lock:

drivers/net/ethernet/oa_tc6.c:oa_tc6_macphy_isr() {
	...
	if (tc6->disable_traffic)
		disable_irq_nosync(tc6->spi->irq);
	else
		tc6->int_flag = true;
	...
}

In oa_tc6_exit() the store happens under the lock and disable_irq() only
runs afterwards:

	spin_lock_bh(&tc6->tx_skb_lock);
	tc6->disable_traffic = true;
	spin_unlock_bh(&tc6->tx_skb_lock);
	disable_irq(tc6->spi->irq);

Can a level triggered interrupt in that window make oa_tc6_macphy_isr()
observe a stale false, set int_flag and wake the thread, which then takes
the early return above without doing the data chunk transfer that
deasserts INT?

Also, is taking the lock here worth it when it is dropped again before the
value is used?  Would READ_ONCE()/WRITE_ONCE() on the flag (or an
IRQ-safe lock) express the actual access rules more accurately than a BH
lock that the hardirq reader can never hold?

>  
> +	while (tc6->int_flag ||
> +	       (tc6->waiting_tx_skb && tc6->tx_credits)) {
> +		ret = oa_tc6_try_spi_transfer(tc6);
> +		if (ret) {
> +			disable_irq_nosync(tc6->spi->irq);
> +			oa_tc6_disable_traffic(tc6);
> +			break;
>  		}
>  	}
>  
> @@ -1250,18 +1284,22 @@ EXPORT_SYMBOL_GPL(oa_tc6_zero_align_receive_frame_enable);
>   */
>  netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb)
>  {
> -	if (tc6->disable_traffic || tc6->waiting_tx_skb) {
> -		netif_stop_queue(tc6->netdev);
> -		return NETDEV_TX_BUSY;
> -	}
> -
>  	if (skb_linearize(skb)) {
> -		dev_kfree_skb_any(skb);
> -		tc6->netdev->stats.tx_dropped++;
> +		oa_tc6_drop_tx_skb(tc6, skb);
>  		return NETDEV_TX_OK;
>  	}
>  
>  	spin_lock_bh(&tc6->tx_skb_lock);
> +	if (tc6->waiting_tx_skb) {
> +		netif_stop_queue(tc6->netdev);
> +		spin_unlock_bh(&tc6->tx_skb_lock);
> +		return NETDEV_TX_BUSY;
> +	}

[Severity: Low]
[Finding: fable-5-1-5]
[Sources: fable-5, opus-5]
Does moving skb_linearize() in front of the waiting_tx_skb check change the
back-pressure policy?

Previously an xmit that hit the busy case returned NETDEV_TX_BUSY without
touching the skb.  Now every xmit linearizes first, so a transient
skb_linearize() -ENOMEM during a busy period frees the frame and returns
NETDEV_TX_OK, where before it would have been requeued and retried.

The kernel-doc above oa_tc6_start_xmit() still says:

 * Return: NETDEV_TX_OK if the transmit ethernet frame skb added in the tx_skb_q
 * otherwise returns NETDEV_TX_BUSY.

which no longer covers the drop cases.  Should that be refreshed too?

> +	if (tc6->disable_traffic) {
> +		spin_unlock_bh(&tc6->tx_skb_lock);
> +		oa_tc6_drop_tx_skb(tc6, skb);
> +		return NETDEV_TX_OK;
> +	}
>  	tc6->waiting_tx_skb = skb;
>  	spin_unlock_bh(&tc6->tx_skb_lock);
>  
> @@ -1393,7 +1431,9 @@ EXPORT_SYMBOL_GPL(oa_tc6_init);
>   */
>  void oa_tc6_exit(struct oa_tc6 *tc6)
>  {
> +	spin_lock_bh(&tc6->tx_skb_lock);
>  	tc6->disable_traffic = true;
> +	spin_unlock_bh(&tc6->tx_skb_lock);
>  	disable_irq(tc6->spi->irq);
>  	oa_tc6_phy_exit(tc6);
>  	oa_tc6_free_pending_skbs(tc6);
-- 
This is an AI-generated review.

