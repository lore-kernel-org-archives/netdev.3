Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822AD4137A2
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879244; cv=none; b=NsfqvFN466/u1+43fp8uwUskzNaTbE64jarCI1hjOYSBgaEgKtf23jENEoPav8Eflpt+UySf/blegyb6sr4kGveGi5tRXMcZwVOcURa8CjHyRpidOx3NrC3o8Oi85yWRehfNqtyXoL3y3dSOI2cVuOGWXMvGFqSp0dYUDP89Yg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879244; c=relaxed/simple;
	bh=9ZB+H4YLyi1/619ZPw4zBQKsoH11bS2QYhEJdWBqlE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBtS/lgR6vo94KWOY2vbx8WjDVVzw+9G/8inRdnJ2fBwYH7SBUR2DGD/Y0fy791/jlNwoNGUGRQ0iZq54BqeCdp7YDNJRGUz3clzvYZKDVjfwqWoE4ocz5XdGll39ocqfjed0z7EuvqYgV+OyA6QShLRuMbupQOt4elDv+PV2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f1CG7/8T; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f1CG7/8T"
Message-ID: <dce23bb6-138b-4a53-9447-26e81c86c292@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785879239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/YdfITwA2i5MXUEvTL9egSEPZBECQ60NxmAon/pChQ=;
	b=f1CG7/8TCMnSiDNWVJMl17/vQSwYBLADVFt/u9bg7lanyoo0mO/1WUAhuQMgAV0tRH2mgM
	La7qWZRyisA5xunqxbdZPKurkPTOILucvVXVw8BRDBcQVEZbdqaRpDCMRoBjAwr2g0Ho1L
	cnDxFkOhDtwaIMJaeP0vrLFK4WEI6wA=
Date: Tue, 4 Aug 2026 22:33:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-net v1] i40e: fix races in PTP external timestamp work
 handling
To: xuanqiang.luo@linux.dev, intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 richardcochran@gmail.com, piotr.kwapulinski@intel.com,
 arkadiusz.kubalewski@intel.com, aleksandr.loktionov@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260724093448.63154-1-xuanqiang.luo@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260724093448.63154-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/07/2026 10:34, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> The time sync interrupt queues ptp_extts0_work, which reads device
> registers and reports events through pf->ptp_clock.
> 
> i40e_ptp_stop() unregisters the PHC without first disabling the event
> source or draining the work. The worker can therefore access the clock or
> PF after either has been freed, causing a use-after-free. Disable external
> timestamp events and call disable_work_sync() before unregistering the PHC.
> Disabling the work also prevents an interrupt already in progress from
> queuing it after the drain.
> 
> INIT_WORK() is called from i40e_ptp_set_timestamp_mode(), which runs on
> reset and whenever timestamping is reconfigured. Reinitializing pending or
> running work can corrupt its workqueue state. Initialize the work once from
> i40e_sw_init() instead.
> 
> Also exclude reset recovery before stopping PTP so a concurrent rebuild
> cannot re-enable timestamp events or recreate the PHC during removal.
> 
> Fixes: 1050713026a0 ("i40e: add support for PTP external synchronization clock")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>   drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 17 +++++++-------
>   drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 25 +++++++++++++++------
>   3 files changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index 83e780919ac97..e2ae61bc38786 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -1315,6 +1315,7 @@ int i40e_ptp_hwtstamp_set(struct net_device *netdev,
>   			  struct netlink_ext_ack *extack);
>   void i40e_ptp_save_hw_time(struct i40e_pf *pf);
>   void i40e_ptp_restore_hw_time(struct i40e_pf *pf);
> +void i40e_ptp_init_work(struct i40e_pf *pf);
>   void i40e_ptp_init(struct i40e_pf *pf);
>   void i40e_ptp_stop(struct i40e_pf *pf);
>   int i40e_ptp_alloc_pins(struct i40e_pf *pf);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index a04683004a567..2909a58d57562 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -12819,6 +12819,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
>   			 "total-port-shutdown was enabled, link-down-on-close is forced on\n");
>   	}
>   	mutex_init(&pf->switch_mutex);
> +	i40e_ptp_init_work(pf);
>   
>   sw_init_done:
>   	return err;
> @@ -16157,14 +16158,6 @@ static void i40e_remove(struct pci_dev *pdev)
>   
>   	i40e_devlink_unregister(pf);
>   
> -	i40e_dbg_pf_exit(pf);
> -
> -	i40e_ptp_stop(pf);
> -
> -	/* Disable RSS in hw */
> -	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(0), 0);
> -	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(1), 0);
> -
>   	/* Grab __I40E_RESET_RECOVERY_PENDING and set __I40E_IN_REMOVE
>   	 * flags, once they are set, i40e_rebuild should not be called as
>   	 * i40e_prep_for_reset always returns early.
> @@ -16173,6 +16166,14 @@ static void i40e_remove(struct pci_dev *pdev)
>   		usleep_range(1000, 2000);
>   	set_bit(__I40E_IN_REMOVE, pf->state);
>   
> +	i40e_dbg_pf_exit(pf);
> +
> +	i40e_ptp_stop(pf);
> +
> +	/* Disable RSS in hw */
> +	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(0), 0);
> +	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(1), 0);
> +
>   	if (test_bit(I40E_FLAG_SRIOV_ENA, pf->flags)) {
>   		set_bit(__I40E_VF_RESETS_DISABLED, pf->state);
>   		i40e_free_vfs(pf);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index ff62b5f2c8150..fd51ab8c10c20 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -169,6 +169,17 @@ static void i40e_ptp_extts0_work(struct work_struct *work)
>   	ptp_clock_event(pf->ptp_clock, &event);
>   }
>   
> +/**
> + * i40e_ptp_init_work - Initialize PTP work for a PF
> + * @pf: Board private structure
> + *
> + * Initialize work which must remain valid for the lifetime of the PF.
> + */
> +void i40e_ptp_init_work(struct i40e_pf *pf)
> +{
> +	INIT_WORK(&pf->ptp_extts0_work, i40e_ptp_extts0_work);
> +}
> +

why do you need extra function for a single line of code? why cannot you 
put it into i40e_ptp_init?

>   /**
>    * i40e_is_ptp_pin_dev - check if device supports PTP pins
>    * @hw: pointer to the hardware structure
> @@ -1186,8 +1197,6 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
>   	regval |= 1 << I40E_PRTTSYN_CTL0_EVENT_INT_ENA_SHIFT;
>   	wr32(hw, I40E_PRTTSYN_CTL0, regval);
>   
> -	INIT_WORK(&pf->ptp_extts0_work, i40e_ptp_extts0_work);
> -
>   	switch (config->tx_type) {
>   	case HWTSTAMP_TX_OFF:
>   		pf->ptp_tx = false;

