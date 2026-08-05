Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8131E846
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912983; cv=none; b=MbDQ5XNo1Ctnr3VkO8ijwIqbo301tyXsmqeJy+TlFxJ2eZlKSzAEZR86mkbyrxcC+DcWhA2+LdasP8mCHIMMXTwBpCmSKXKFGF5bUeVtbahC6+lNI6YSe7t2QXJ1e/rHWc/Go8DG3HjfX//Ts+H9BGwlInWvSLLirVpgJH3rFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912983; c=relaxed/simple;
	bh=M/SunkTtc+TH2cQ0Gyi9NDFJoMPUscPt7OUseMyx0mw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E/9+wH9pf3E8rQqLLA0uXj76m/wWoetrzePOlgi4ExWBZyA0fQdNIATUoYqcF/Q/IOfoxwMVnjOcpo8KtP4dYjCTMMvxL/kqHlq3loDNMwR5gi+xjfT2ptHxaCEhfvq23y12jwOzbXZ2Uu4Z58YejS6HKVqUJesFnMgmHM4Vnho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DwNnnuD8; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DwNnnuD8"
Message-ID: <12f927af-4fd1-40fe-9abd-559d14e833e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785912971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zvDle/lCKcOusPHIQ4M6DhX/BBhD62GYhSX80jnqOo=;
	b=DwNnnuD8QrVKWLNN68bjgX/Hq20OAilBiVpvvGln2Fuo6eMTDRB02xt+pcLXsmKvxvtmch
	6/KSTo80xm+92mulxDZ6+W7kyPgbDfz7j6KfXpry4puKJYE29K/IoaaoldDtogXG2BNZ7Q
	a577xqm/Fv8nVIYnDBXok8h40KPb4qc=
Date: Wed, 5 Aug 2026 14:55:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
Subject: Re: [PATCH iwl-net v1] i40e: fix races in PTP external timestamp work
 handling
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, richardcochran@gmail.com,
 piotr.kwapulinski@intel.com, arkadiusz.kubalewski@intel.com,
 aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260724093448.63154-1-xuanqiang.luo@linux.dev>
 <20260730122550.GA51943@horms.kernel.org>
In-Reply-To: <20260730122550.GA51943@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Thanks Simon for the review and Sashiko for the detailed findings!

I have posted v2 addressing these concerns as follows.

在 2026/7/30 20:25, Simon Horman 写道:

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at:https://sashiko.dev/#/patchset/20260724093448.63154-1-xuanqiang.luo@linux.dev?part=1
> ---
> --- Patch [1]: [PATCH iwl-net v1] i40e: fix races in PTP external timestamp work handling ---
> commit 4359cf206cb2602e153fdeac3151f8d4bacf9195
> Author: Xuanqiang Luo<luoxuanqiang@kylinos.cn>
>
> i40e: fix races in PTP external timestamp work handling
>
> This commit disables external timestamp events and drains the work
> queue before unregistering the PHC to fix a use-after-free, and
> moves the work initialization to device init instead of reset. It also
> excludes reset recovery during teardown to avoid concurrent rebuilds.
>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> index a04683004a567..2909a58d57562 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> [ ... ]
>> @@ -16157,14 +16158,6 @@ static void i40e_remove(struct pci_dev *pdev)
>>   
>>   	i40e_devlink_unregister(pf);
>>   
>> -	i40e_dbg_pf_exit(pf);
>> -
>> -	i40e_ptp_stop(pf);
>> -
>> -	/* Disable RSS in hw */
>> -	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(0), 0);
>> -	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(1), 0);
>> -
>>   	/* Grab __I40E_RESET_RECOVERY_PENDING and set __I40E_IN_REMOVE
>>   	 * flags, once they are set, i40e_rebuild should not be called as
>>   	 * i40e_prep_for_reset always returns early.
>> @@ -16173,6 +16166,14 @@ static void i40e_remove(struct pci_dev *pdev)
>>   		usleep_range(1000, 2000);
> Simon says: I think the issue flagged below is somewhat orthogonal to
>              this patch and can be considered in the context of possible
> 	    follow-up.
>
> [Severity: High]
> This is a pre-existing issue, but does this ad-hoc polling loop violate core
> networking synchronization rules?
>
> The subsystem guidelines state that using retry/poll loops on flags to guard
> code sections is a bug, as it evades lockdep deadlock detection and lacks
> proper memory ordering guarantees.
>
> i40e_remove() spins on __I40E_RESET_RECOVERY_PENDING with a sleep instead of
> using a standard lock or workqueue synchronization, which exposes the teardown
> path to races during hotplug or PCIe AER unbinds.

For this pre-existing issue, I included a wait-bit based fix in v2
as Patch 4.

>>   	set_bit(__I40E_IN_REMOVE, pf->state);
>>   
>> +	i40e_dbg_pf_exit(pf);
>> +
>> +	i40e_ptp_stop(pf);
> [ ... ]
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
>> index ff62b5f2c8150..fd51ab8c10c20 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> [ ... ]
>> @@ -1541,6 +1550,13 @@ void i40e_ptp_stop(struct i40e_pf *pf)
>>   	struct i40e_hw *hw = &pf->hw;
>>   	u32 regval;
>>   
>> +	/* Stop external timestamp events before unregistering the clock. */
>> +	regval = rd32(hw, I40E_PRTTSYN_CTL0);
>> +	regval &= ~I40E_PRTTSYN_CTL0_EVENT_INT_ENA_MASK;
>> +	wr32(hw, I40E_PRTTSYN_CTL0, regval);
>> +
>> +	disable_work_sync(&pf->ptp_extts0_work);
>> +
> [Severity: Medium]
> Does this reordering introduce a TOCTOU race condition with the PTP ioctl?
>
> The flag I40E_FLAG_PTP_ENA is still set here while we disable the workqueue.
> Because i40e_remove() does not hold the rtnl_lock(), a concurrent
> SIOCSHWTSTAMP ioctl could execute i40e_ptp_hwtstamp_set().
>
> Since the ioctl checks I40E_FLAG_PTP_ENA, it might observe it as still set
> and call i40e_ptp_set_timestamp_mode(). This would overwrite I40E_PRTTSYN_CTL0
> and re-enable hardware interrupts immediately after i40e_ptp_stop() just
> disabled them, leaving the device generating events for a disabled workqueue.

I agree. Patch 2 serializes timestamp configuration and PTP teardown
with ptp_config_lock.

>>   	clear_bit(I40E_FLAG_PTP_ENA, pf->flags);
>>   	pf->ptp_tx = false;
>>   	pf->ptp_rx = false;
>>   
>>   	if (pf->ptp_tx_skb) {
>>   		struct sk_buff *skb = pf->ptp_tx_skb;
>>   
>>   		pf->ptp_tx_skb = NULL;
>>   		clear_bit_unlock(__I40E_PTP_TX_IN_PROGRESS, pf->state);
>>   		dev_kfree_skb_any(skb);
>>   	}
> Simon says: Although the issue flagged below is flagged as pre-existing
>              I am concerned that it is exacerbated by this patch.
>
> [Severity: High]
> This is a pre-existing issue, but could this freeing pattern result in a
> double-free or use-after-free?
>
> A user configuring PTP and transmitting a packet sets pf->ptp_tx_skb.
> The watchdog task in i40e_ptp_tx_hang() checks the timeout and reads
> pf->ptp_tx_skb without an atomic test-and-set claim.
>
> If a hardware interrupt arrives at this exact time, i40e_ptp_tx_hwtstamp()
> can preempt the watchdog, read the exact same pointer, set it to NULL,
> call skb_tstamp_tx() and then dev_kfree_skb_any().
>
> When the interrupt returns, the watchdog task resumes and frees the exact
> same SKB pointer again. This teardown path in i40e_ptp_stop() also forcibly
> frees ptp_tx_skb without atomic protections against the interrupt handler,
> compounding the race.
>
> [ ... ]

I agree. Patch 1 adds ptp_tx_lock to protect the Tx timestamp slot
across transmit, watchdog, interrupt, error, and stop paths.

The lock uses spin_lock_irqsave() for the hard IRQ path and is only
taken for SKBTX_HW_TSTAMP packets.

Thanks,
Xuanqiang

