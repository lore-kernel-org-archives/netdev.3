Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B928850E;
	Tue, 18 Aug 2026 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058736; cv=none; b=QphsTxVwkgUeGTVQPRpjjvrlPNpBdfxK7P/koi3KwNIgnUPWoB7Hw3fRd/dNyUqi3N03gLVhv+6bTM6hghUjYV4ABQuP5hmOgw7cMAk23Z8pa6sYjRMd1OinojFkI4PpfHesmm9W5GFS4b4VscvSZrbL6ZOK5kYRGCVUw1QXt7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058736; c=relaxed/simple;
	bh=XglGT+YosrLLOFbWwJugqaNdWX+ujiSLF4O5z9V1Zpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3fCD4+bP8v+ud/Z4j9sJfW/SUDUmPQq1ZMNScX33KIsgDqfeeJPrXDUecFEDaHLKMRK0Z3gYW9a9AqU7Yg7OuH0Xx2/MZU7XrMixHTcDZSEL3rCr3w0InLo+8KwQ1Tzb8HkQCMj/1F6pfqpX7Gvn0vHVbZKEqVgqxYVXbQKvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa48fIY+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa48fIY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1731F00A3F;
	Tue, 18 Aug 2026 13:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787058734;
	bh=CIsHML44jzI2o/7DY3deZ6/e+n8793ld6U8CK2wSIRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qa48fIY+YidWANy1pjo6J/RY0wzDyb46iIIfMla5qjZ3eiVsN9x7jP732Hm4fsPxC
	 GZCHWfr0BMQsJBbp3Kn0gBsa9DpvZxaZM6gq9XYbfDvkcTwb7GZUH/BN7IROQv3lag
	 cH400VEZtWW+ssSWMcbRKaEjV614xTkdmgRWV/IS2uC1fLxNm/WtZl1STN7CWQ8tsB
	 6anvNqvcDRO5Fs8rohStumo8XqMP+4KhgGchviKaOI3FLmv7kLKKMHh0vMsZ2GZpCl
	 RQ1D4roYBE4UPJGguqPUtYxF2lueebEFP2LgTFcJsKJxUvScndwxhkq+tgxV4WZx+N
	 A3UMxL1SvADHg==
From: Simon Horman <horms@kernel.org>
To: shivani07g@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	jacob.e.keller@intel.com,
	matthew.vick@intel.com,
	vinicius.gomes@intel.com,
	kurt@linutronix.de,
	aleksandr.loktionov@intel.com
Subject: Re: [PATCH iwl-net 1/2] igb: Fix race condition in PTP tx code
Date: Tue, 18 Aug 2026 14:11:53 +0100
Message-ID: <20260818131153.622527-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815010827.91912-2-shivani07g@gmail.com>
References: <20260815010827.91912-2-shivani07g@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260815010827.91912-2-shivani07g@gmail.com?part=1
---
--- Patch [1]: [PATCH iwl-net 1/2] igb: Fix race condition in PTP tx code ---
commit fe4808a653156f9a6aff1ed75f8c696e88ed8a49
Author: Shivani Gupta <shivani07g@gmail.com>

igb: Fix race condition in PTP tx code

This adds a new adapter->ptp_tx_lock spinlock covering ptp_tx_skb and
ptp_tx_start, removes the __IGB_PTP_TX_IN_PROGRESS state bit so that the
pointer itself provides admission control, and factors the timeout handling
used by the worker and the watchdog into igb_ptp_tx_timeout().  It follows
the model already used by igc, plus the 82576 polling and transmit-error
paths specific to igb.

A few questions below.

> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 0fff1df81b7bd..ecd284f51d3e3 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -625,6 +625,8 @@ struct igb_adapter {
>  	struct ptp_clock_info ptp_caps;
>  	struct delayed_work ptp_overflow_work;
>  	struct work_struct ptp_tx_work;
> +	/* Access to ptp_tx_skb and ptp_tx_start is protected by ptp_tx_lock. */
> +	spinlock_t ptp_tx_lock;
>  	struct sk_buff *ptp_tx_skb;
>  	struct kernel_hwtstamp_config tstamp_config;
>  	unsigned long ptp_tx_start;

[Severity: Low]
[Finding: gpt-5-6-sol-5-11]
[Sources: gpt-5-6-sol, opus-5]
This isn't a bug introduced by this patch, but should the lock scope comment
also mention tstamp_config?

igb_xmit_frame_ring() now reads tstamp_config.tx_type inside the new
ptp_tx_lock section, while with this patch alone the writers,
igb_ptp_hwtstamp_set() and igb_ptp_init(), still update tstamp_config
without the lock.

The follow-up patch in the series, "igb: Clear pending Tx timestamping
requests when disabling Tx timestamping", publishes adapter->tstamp_config
under ptp_tx_lock and drops an already admitted request through
igb_ptp_clear_tx_tstamp(adapter, true), so the functional part is handled
there; only the comment here still lists just ptp_tx_skb and ptp_tx_start.

igb_ptp_hwtstamp_get() also copies the shadow config without the lock, which
looks fine since it is rtnl serialized against the setter.

> @@ -714,7 +716,6 @@ enum e1000_state_t {
>  	__IGB_TESTING,
>  	__IGB_RESETTING,
>  	__IGB_DOWN,
> -	__IGB_PTP_TX_IN_PROGRESS,
>  };
>  
>  enum igb_boards {
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index a1e89a375744c..fc70f7aa4ce05 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c

[ ... ]

> @@ -6561,10 +6563,11 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
>  
>  	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
>  		struct igb_adapter *adapter = netdev_priv(tx_ring->netdev);
> +		unsigned long flags;
>  
> +		spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
>  		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
> -		    !test_and_set_bit_lock(__IGB_PTP_TX_IN_PROGRESS,
> -					   &adapter->state)) {
> +		    !adapter->ptp_tx_skb) {
>  			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
>  			tx_flags |= IGB_TX_FLAGS_TSTAMP;
>  

[ ... ]

> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
> index 638d8242b66bb..3cc05f9198f85 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> @@ -796,6 +796,21 @@ static int igb_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
>  	return 0;
>  }
>  
> +/* Requires adapter->ptp_tx_lock held by caller. */
> +static void igb_ptp_tx_timeout(struct igb_adapter *adapter)
> +{
> +	struct e1000_hw *hw = &adapter->hw;
> +
> +	dev_kfree_skb_any(adapter->ptp_tx_skb);
> +	adapter->ptp_tx_skb = NULL;
> +	adapter->tx_hwtstamp_timeouts++;
> +	/* Clear the tx valid bit in TSYNCTXCTL register to enable
> +	 * interrupt
> +	 */
> +	rd32(E1000_TXSTMPH);
> +	dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
> +}
> +
>  /**
>   * igb_ptp_tx_work
>   * @work: pointer to work struct
> @@ -808,23 +823,18 @@ static void igb_ptp_tx_work(struct work_struct *work)
>  	struct igb_adapter *adapter = container_of(work, struct igb_adapter,
>  						   ptp_tx_work);
>  	struct e1000_hw *hw = &adapter->hw;
> +	unsigned long flags;
>  	u32 tsynctxctl;
>  
> +	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
> +
>  	if (!adapter->ptp_tx_skb)
> -		return;
> +		goto unlock;
>  
>  	if (time_is_before_jiffies(adapter->ptp_tx_start +
>  				   IGB_PTP_TX_TIMEOUT)) {
> -		dev_kfree_skb_any(adapter->ptp_tx_skb);
> -		adapter->ptp_tx_skb = NULL;
> -		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
> -		adapter->tx_hwtstamp_timeouts++;
> -		/* Clear the tx valid bit in TSYNCTXCTL register to enable
> -		 * interrupt
> -		 */
> -		rd32(E1000_TXSTMPH);
> -		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
> -		return;
> +		igb_ptp_tx_timeout(adapter);
> +		goto unlock;
>  	}
>  
>  	tsynctxctl = rd32(E1000_TSYNCTXCTL);
> @@ -833,6 +843,9 @@ static void igb_ptp_tx_work(struct work_struct *work)
>  	else
>  		/* reschedule to check later */
>  		schedule_work(&adapter->ptp_tx_work);
> +
> +unlock:
> +	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
>  }
>  
>  static void igb_ptp_overflow_check(struct work_struct *work)
> @@ -897,32 +910,45 @@ void igb_ptp_rx_hang(struct igb_adapter *adapter)
>   */
>  void igb_ptp_tx_hang(struct igb_adapter *adapter)
>  {
> -	struct e1000_hw *hw = &adapter->hw;
> -	bool timeout = time_is_before_jiffies(adapter->ptp_tx_start +
> -					      IGB_PTP_TX_TIMEOUT);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
>  
>  	if (!adapter->ptp_tx_skb)
> -		return;
> +		goto unlock;
>  
> -	if (!test_bit(__IGB_PTP_TX_IN_PROGRESS, &adapter->state))
> -		return;
> +	if (time_is_after_jiffies(adapter->ptp_tx_start + IGB_PTP_TX_TIMEOUT))
> +		goto unlock;
>  
>  	/* If we haven't received a timestamp within the timeout, it is
>  	 * reasonable to assume that it will never occur, so we can unlock the
>  	 * timestamp bit when this occurs.
>  	 */
                       ^^^^^^^^^^^^^^^^^

[Severity: Low]
[Finding: gpt-5-6-sol-2-3]
[Sources: gpt-5-6-sol]
This isn't a bug, but the retained sentence in igb_ptp_tx_hang() still talks
about unlocking "the timestamp bit", and this patch deletes
__IGB_PTP_TX_IN_PROGRESS from enum e1000_state_t.  The timeout path now
releases admission in igb_ptp_tx_timeout() with:

	dev_kfree_skb_any(adapter->ptp_tx_skb);
	adapter->ptp_tx_skb = NULL;

Would it read better as clearing the pending timestamp request?
igc_ptp_tx_hang() dropped this sentence when the same locking model landed
there.  The phrase can also be read as the hardware Tx valid bit, which
igb_ptp_tx_timeout() still clears via rd32(E1000_TXSTMPH), so the wording is
ambiguous either way.

> -	if (timeout) {
> -		cancel_work_sync(&adapter->ptp_tx_work);
> -		dev_kfree_skb_any(adapter->ptp_tx_skb);
> -		adapter->ptp_tx_skb = NULL;
> -		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
> -		adapter->tx_hwtstamp_timeouts++;
> -		/* Clear the tx valid bit in TSYNCTXCTL register to enable
> -		 * interrupt
> -		 */
> -		rd32(E1000_TXSTMPH);
> -		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
> -	}
> +	igb_ptp_tx_timeout(adapter);
> +
> +unlock:
> +	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
> +}
> +
> +/**
> + * igb_ptp_clear_tx_tstamp - drop a pending Tx timestamp request
> + * @adapter: private network adapter structure
> + *
> + * Cancel the timestamp retrieval work and free a pending timestamp skb.
> + *
> + * Context: Must be called in sleepable context with ptp_tx_lock not held;
> + *          cancel_work_sync() waits for igb_ptp_tx_work() which takes it.
> + */
> +static void igb_ptp_clear_tx_tstamp(struct igb_adapter *adapter)
> +{
> +	unsigned long flags;
> +
> +	cancel_work_sync(&adapter->ptp_tx_work);
> +
> +	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
> +	dev_kfree_skb_any(adapter->ptp_tx_skb);
> +	adapter->ptp_tx_skb = NULL;
> +	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
>  }

[Severity: High]
[Finding: gpt-5-6-sol-4-6]
[Sources: gpt-5-6-sol, opus-5]
This isn't a bug introduced by this patch, but the new kernel-doc presents
this cancel_work_sync() as the teardown guarantee, and it remains the only
synchronous cancellation of ptp_tx_work in the driver.  Can ptp_tx_work be
queued again after it has run?

igb_remove() reaches it early:

igb_remove()
    igb_ptp_stop() -> igb_ptp_suspend() -> igb_ptp_clear_tx_tstamp()
    ...
    unregister_netdev(netdev);
    ...
    pci_iounmap(pdev, adapter->io_addr);
    ...
    free_netdev(netdev);

The netdev stays registered until unregister_netdev(), tstamp_config.tx_type
is left at HWTSTAMP_TX_ON by this path, and igb_xmit_frame_ring() has no
__IGB_DOWN gate (only igb_maybe_stop_tx() and IGB_RING_FLAG_TX_DISABLED), so
a timestamped frame in that window still does:

	adapter->ptp_tx_skb = skb_get(skb);
	adapter->ptp_tx_start = jiffies;
	if (adapter->hw.mac.type == e1000_82576)
		schedule_work(&adapter->ptp_tx_work);

and for the other parts igb_tsync_interrupt() does the same:

	if (tsicr & E1000_TSICR_TXTS) {
		/* retrieve hardware timestamp */
		schedule_work(&adapter->ptp_tx_work);
	}

Once queued with a pending request, igb_ptp_tx_work() re-arms itself while
TSYNCTXCTL.VALID is clear, for up to IGB_PTP_TX_TIMEOUT (15 * HZ):

	tsynctxctl = rd32(E1000_TSYNCTXCTL);
	if (tsynctxctl & E1000_TSYNCTXCTL_VALID)
		igb_ptp_tx_hwtstamp(adapter);
	else
		/* reschedule to check later */
		schedule_work(&adapter->ptp_tx_work);

Nothing in the rest of igb_remove() cancels or flushes ptp_tx_work, so can
the worker end up doing rd32(E1000_TSYNCTXCTL) after pci_iounmap(), and
taking spin_lock_irqsave(&adapter->ptp_tx_lock) plus reading
adapter->ptp_tx_skb after free_netdev() freed the adapter that contains both
the work_struct and the lock?

The pre-patch code has the same window, and the later patches in the series
do not appear to close it either, since igb_ptp_suspend() leaves
tstamp_config.tx_type untouched and no extra cancel or flush is added.

>  
>  /**
> @@ -932,6 +958,8 @@ void igb_ptp_tx_hang(struct igb_adapter *adapter)
>   * If we were asked to do hardware stamping and such a time stamp is
>   * available, then it must have been for this skb here because we only
>   * allow only one such packet into the queue.
> + *
> + * Context: Expects adapter->ptp_tx_lock to be held by caller.
>   **/
>  static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter)
>  {
> @@ -963,15 +991,14 @@ static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter)
>  	shhwtstamps.hwtstamp =
>  		ktime_add_ns(shhwtstamps.hwtstamp, adjust);
>  
> -	/* Clear the lock early before calling skb_tstamp_tx so that
> -	 * applications are not woken up before the lock bit is clear. We use
> -	 * a copy of the skb pointer to ensure other threads can't change it
> -	 * while we're notifying the stack.
> +	/* Clear the pending request before calling skb_tstamp_tx so that
> +	 * a new timestamp request can be accepted. We use a copy of the skb
> +	 * pointer to ensure other threads can't change it while we're
> +	 * notifying the stack.
>  	 */
>  	adapter->ptp_tx_skb = NULL;

[Severity: Low]
[Finding: main-1-0]
[Sources: opus-5]
This isn't a bug, but does this comment still match the new locking model?
It sits under the Context line added just above the function, which says
ptp_tx_lock is held by the caller.

The only caller is igb_ptp_tx_work(), which holds ptp_tx_lock with interrupts
disabled across igb_ptp_tx_hwtstamp(), so also across skb_tstamp_tx() and
dev_kfree_skb_any().  igb_xmit_frame_ring() has to take the same lock to
install a new ptp_tx_skb.

That means no new request can be accepted here, and no other thread can
change the pointer, until the caller unlocks.  Would it be clearer to drop
both of those rationales?

>  
> -	/* Notify the stack and free the skb after we've unlocked */
> +	/* Notify the stack and free the skb */
>  	skb_tstamp_tx(skb, &shhwtstamps);
>  	dev_kfree_skb_any(skb);
>  }
> @@ -1434,12 +1461,7 @@ void igb_ptp_suspend(struct igb_adapter *adapter)
>  	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
>  		cancel_delayed_work_sync(&adapter->ptp_overflow_work);
>  
> -	cancel_work_sync(&adapter->ptp_tx_work);
> -	if (adapter->ptp_tx_skb) {
> -		dev_kfree_skb_any(adapter->ptp_tx_skb);
> -		adapter->ptp_tx_skb = NULL;
> -		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
> -	}
> +	igb_ptp_clear_tx_tstamp(adapter);
>  }
