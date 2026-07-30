Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DFA429CF1
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414356; cv=none; b=Bi+mS+vhgMfY9dYrypbfNETCv05tVPeCApgntN9/+KzL2fjkd579aFqsLxtaUaQW60PyTR34tp3UUSjSyHSPFijBXDcm4SzW5azdOnn7+zMSqUdGLQJut8S6RFHdm8ZznOkaZwGLTk1k9+BHyvfl2TabfJOkSEu5btzYfPqg0sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414356; c=relaxed/simple;
	bh=Gk0bV909phwAAQyPuzzkl2+swX8iAsEG07sZ8Wj0+KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U04uzP3b1/ZQOI296dTQw0OP7AD2NjBbHbCP0odGk8R/McyNfEIjCeeKY1vZeWNEEwCCM/3H3Kiv+ayEQCA0RzLwFIgNBYmE4EuwWSXJNTA7lYOJ7FDNPfgiTWuY+fZP4lfx1hVK7x+CPM9+6mfpgrYgeIs2Lz92845NNTqAbqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8dWPKDc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8dWPKDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905E91F00A3A;
	Thu, 30 Jul 2026 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785414355;
	bh=lpMA6Y8SQpR03HLgMbb8mUFVl3OtsfazuoBzzZEHBNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g8dWPKDchVoDtm0hgvHiiCLG9EevebFIkn48QcwXerpU7KXCHpM0Pz9rIHj5cWL8I
	 FtfOGVO0YC0S14Ae8nAK7AX8d6QNdPd/6ax0xW4bTmR9i1IBWV4YkosWsSw1efNXLf
	 orYY9RWnhO9B78ibYlm5xUdMpOtg/rJkZdcQIVlFHEXGAdBOOMVkTVrgSK5HMPV9gi
	 PsSqAw0wxdSOUf9ScDfwJSbGQe7vJHyk5GdZcZMPI0K4/DDSEnkplkcfnxzBvvY2Dp
	 gug0km7vG5tip9SRWt2LLyvTcHo1Gc0ms02PGY55sKs+D16xN0iYBkWXh/H4gtB5bO
	 WTJuf5bpZezwQ==
Date: Thu, 30 Jul 2026 13:25:50 +0100
From: Simon Horman <horms@kernel.org>
To: xuanqiang.luo@linux.dev
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, richardcochran@gmail.com,
	piotr.kwapulinski@intel.com, arkadiusz.kubalewski@intel.com,
	aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH iwl-net v1] i40e: fix races in PTP external timestamp
 work handling
Message-ID: <20260730122550.GA51943@horms.kernel.org>
References: <20260724093448.63154-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724093448.63154-1-xuanqiang.luo@linux.dev>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260724093448.63154-1-xuanqiang.luo@linux.dev?part=1
---
--- Patch [1]: [PATCH iwl-net v1] i40e: fix races in PTP external timestamp work handling ---
commit 4359cf206cb2602e153fdeac3151f8d4bacf9195
Author: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

i40e: fix races in PTP external timestamp work handling

This commit disables external timestamp events and drains the work
queue before unregistering the PHC to fix a use-after-free, and
moves the work initialization to device init instead of reset. It also
excludes reset recovery during teardown to avoid concurrent rebuilds.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index a04683004a567..2909a58d57562 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
[ ... ]
> @@ -16157,14 +16158,6 @@ static void i40e_remove(struct pci_dev *pdev)
>  
>  	i40e_devlink_unregister(pf);
>  
> -	i40e_dbg_pf_exit(pf);
> -
> -	i40e_ptp_stop(pf);
> -
> -	/* Disable RSS in hw */
> -	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(0), 0);
> -	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(1), 0);
> -
>  	/* Grab __I40E_RESET_RECOVERY_PENDING and set __I40E_IN_REMOVE
>  	 * flags, once they are set, i40e_rebuild should not be called as
>  	 * i40e_prep_for_reset always returns early.
> @@ -16173,6 +16166,14 @@ static void i40e_remove(struct pci_dev *pdev)
>  		usleep_range(1000, 2000);

Simon says: I think the issue flagged below is somewhat orthogonal to
            this patch and can be considered in the context of possible
	    follow-up.

[Severity: High]
This is a pre-existing issue, but does this ad-hoc polling loop violate core
networking synchronization rules?

The subsystem guidelines state that using retry/poll loops on flags to guard
code sections is a bug, as it evades lockdep deadlock detection and lacks
proper memory ordering guarantees. 

i40e_remove() spins on __I40E_RESET_RECOVERY_PENDING with a sleep instead of
using a standard lock or workqueue synchronization, which exposes the teardown
path to races during hotplug or PCIe AER unbinds.

>  	set_bit(__I40E_IN_REMOVE, pf->state);
>  
> +	i40e_dbg_pf_exit(pf);
> +
> +	i40e_ptp_stop(pf);

[ ... ]
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index ff62b5f2c8150..fd51ab8c10c20 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
[ ... ]
> @@ -1541,6 +1550,13 @@ void i40e_ptp_stop(struct i40e_pf *pf)
>  	struct i40e_hw *hw = &pf->hw;
>  	u32 regval;
>  
> +	/* Stop external timestamp events before unregistering the clock. */
> +	regval = rd32(hw, I40E_PRTTSYN_CTL0);
> +	regval &= ~I40E_PRTTSYN_CTL0_EVENT_INT_ENA_MASK;
> +	wr32(hw, I40E_PRTTSYN_CTL0, regval);
> +
> +	disable_work_sync(&pf->ptp_extts0_work);
> +

[Severity: Medium]
Does this reordering introduce a TOCTOU race condition with the PTP ioctl?

The flag I40E_FLAG_PTP_ENA is still set here while we disable the workqueue.
Because i40e_remove() does not hold the rtnl_lock(), a concurrent
SIOCSHWTSTAMP ioctl could execute i40e_ptp_hwtstamp_set().

Since the ioctl checks I40E_FLAG_PTP_ENA, it might observe it as still set
and call i40e_ptp_set_timestamp_mode(). This would overwrite I40E_PRTTSYN_CTL0
and re-enable hardware interrupts immediately after i40e_ptp_stop() just
disabled them, leaving the device generating events for a disabled workqueue.

>  	clear_bit(I40E_FLAG_PTP_ENA, pf->flags);
>  	pf->ptp_tx = false;
>  	pf->ptp_rx = false;
>  
>  	if (pf->ptp_tx_skb) {
>  		struct sk_buff *skb = pf->ptp_tx_skb;
>  
>  		pf->ptp_tx_skb = NULL;
>  		clear_bit_unlock(__I40E_PTP_TX_IN_PROGRESS, pf->state);
>  		dev_kfree_skb_any(skb);
>  	}

Simon says: Although the issue flagged below is flagged as pre-existing
            I am concerned that it is exacerbated by this patch.

[Severity: High]
This is a pre-existing issue, but could this freeing pattern result in a
double-free or use-after-free?

A user configuring PTP and transmitting a packet sets pf->ptp_tx_skb.
The watchdog task in i40e_ptp_tx_hang() checks the timeout and reads
pf->ptp_tx_skb without an atomic test-and-set claim.

If a hardware interrupt arrives at this exact time, i40e_ptp_tx_hwtstamp()
can preempt the watchdog, read the exact same pointer, set it to NULL,
call skb_tstamp_tx() and then dev_kfree_skb_any().

When the interrupt returns, the watchdog task resumes and frees the exact
same SKB pointer again. This teardown path in i40e_ptp_stop() also forcibly
frees ptp_tx_skb without atomic protections against the interrupt handler,
compounding the race.

[ ... ]
