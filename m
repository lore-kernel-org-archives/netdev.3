Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524856;
	b=XAes14d5e8XHAiHfmdGDBpyqI8lfgn6AogTG7q5aOBob4RbKBbQdtkBX12lV1XYBVYQ3
	 by45kehyoKEgCGlybNB4SCu3IR5u3p0Tg7MX0p3ud8pOlpJ9uQnkgFCMV3P/ppBbw8zm5
	 5MhzRkiEVw5NhcxowsYRkqIHFWXIqm35Zlts4QIlpmH89eKQ7IDKnZK4yD77np1ZA366a
	 VGtQYsUKfdtoGk82KkmIVP952HaL2y1fjTZOamMerOH51OoKqrien2fn2atlVTPJHwTX+
	 0pMJRaPZfj1uqBa6n+iz7QPhRvzfzPeM339nImg/ItRXFavYlloKIIlvlla0yaEvmXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524856;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/yMyrhOnL3uoduRRKOFIxjRfaEPBDZTlWwhOBGe+W9A=;
	b=Nkm4ARGEXLoojkY625AMoqN15ThXAZUnRowznClvM2COjd1I6a2sgbzi6UmO8t6MTdFE
	 Qp01uoATXk5u6Rw4yL0Jrss7BOJyL/RaOiB2MM0K2ppNupSuXBHuPnHP/Q44Q8GYqsner
	 ZMjPwHT+h2m0m/QB9kEymNCuQCulMPyVuEK87mbuj0hpnfIvkasVBfsXCvoPYewCO0mbN
	 d3OT47IsXLAepdOYcXu0A0wHs+WK23VvnLeuxMizY11aA7jK28VrCoTYjT2+W1D6wNeDz
	 KGwiFZlIxJUuNPuVML6umJj+wnTmEtonwEHTt73ui7qAjGAzc6jnEeHdig5PGwjQ3zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MGQgd7+4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8E606A32A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MGQgd7+4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1201F000C7;
	Thu, 12 Nov 2026 23:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524856;
	bh=/yMyrhOnL3uoduRRKOFIxjRfaEPBDZTlWwhOBGe+W9A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MGQgd7+4NKfs7cAYBZ80lSGxcyxGyMqaMD/W7jdz4/ZjO0Jo0QOGR/GMubAdRvjBj
	 dw3oPk6RF7EIuHnOzAmrMXoklnAsnCKjZDgJAT6jWICunNMpsHERWN7AV5RYyPOVCo
	 cRi1BMfGkcjdNispilE9/6EEp1hY5KXZj6eRqpdUN3vmzPjvMjIhWPd1CnFrydZLtF
	 pnr+qrb0DDhA3QIdAfo7nNvPqfQCAQkgf9BdZbmiT5aQi88PloqOkGh49F/5Wcdn7k
	 iAg1WqagJtBBd616biFIEyNzIqapSABDVEhstlVlDpZGmwAtFFxyKHctfGIKacnAmy
	 P26K3W0hNUKvw==
Subject: Re: [PATCH net-next v5 07/15] iavf: extend iavf_configure_queues() to
 support more queues
From: netdev-bot+sashiko@kernel.org
To: przemyslaw.kitszel@intel.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com, mschmidt@redhat.com, edumazet@kernel.org,
 horms@kernel.org, pabeni@redhat.com, davem@davemloft.net, jiri@resnulli.us,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 andrew+netdev@lunn.ch, saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
 mbloch@nvidia.com, jacob.e.keller@intel.com, jedrzej.jagielski@intel.com,
 anzaki@gmail.com, brett.creeley@amd.com, ohartoov@nvidia.com,
 poros@redhat.com
Date: Thu, 12 Nov 2026 23:07:34 +0000
Message-ID: <179452485428.2199510.11578630824061191353@kernel.org>
In-Reply-To: <20261110141534.95614-8-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-8-przemyslaw.kitszel@intel.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] iavf_suspend() can let the multi-message CONFIG_VSI_QUEUES
  sequence carry on after DISABLE_QUEUES, then dereference a freed Rx…
- [Low] The kernel-doc of iavf_configure_queues()
  (drivers/net/ethernet/intel/iavf/iavf_virtchnl.c) still says "Request…

--

iavf: extend iavf_configure_queues() to support more queues

This patch changes iavf_configure_queues() to send, on each call, only
as many queue pairs as fit into one virtchnl message. It tracks how far
it got in adapter->cfg_qps_sent and keeps IAVF_FLAG_AQ_CONFIGURE_QUEUES
set until every pair has been sent. A PF NACK clears the flag so the
remaining pairs are not sent.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index e6b7e8f82c7c1..356565aa41c8c 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c

[ ... ]

> @@ -375,11 +380,12 @@ int iavf_get_vf_ptp_caps(struct iavf_adapter *adapter)
>  void iavf_configure_queues(struct iavf_adapter *adapter)
>  {
>  	struct virtchnl_vsi_queue_config_info *vqci;
> -	int pairs = adapter->num_active_queues;
>  	struct virtchnl_queue_pair_info *vqpi;
> +	int first = adapter->cfg_qps_sent;

[Severity: Low]
This isn't a bug, but the kernel-doc above this function still reads:

 * Request that the PF set up our (previously allocated) queues.

The function now has a different contract:

- Each call sends one chunk, starting at cfg_qps_sent.
- It depends on iavf_process_aq_command() calling it again until
  cfg_qps_sent == num_active_queues.
- The caller has to zero cfg_qps_sent before setting
  IAVF_FLAG_AQ_CONFIGURE_QUEUES. Today only iavf_configure() does that.

Could the kernel-doc be updated to describe this?

>  	u32 i, max_frame;
>  	u8 rx_flags = 0;
>  	size_t len;
> +	int pairs;
>  
>  	max_frame = LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp->p.offset);

[ ... ]

> @@ -425,7 +430,9 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
>  		vqpi++;
>  	}
>  
> -	adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
> +	adapter->cfg_qps_sent += pairs;
> +	if (adapter->cfg_qps_sent == adapter->num_active_queues)
> +		adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;

[Severity: Medium]
IAVF_FLAG_AQ_CONFIGURE_QUEUES now stays set across several watchdog runs.
What happens if iavf_suspend() runs while some chunks are still pending?

iavf_close() masks aq_required down to IAVF_FLAG_AQ_GET_CONFIG before it
calls iavf_down(). iavf_reset_step() masks it down to
IAVF_FLAG_AQ_REQUEST_QUEUES. Both of those drop the leftover flag.

iavf_suspend() calls iavf_down() directly:

iavf_suspend()
  iavf_down()
    adapter->current_op = VIRTCHNL_OP_UNKNOWN;
    ...
    iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DISABLE_QUEUES);

On this path neither IAVF_FLAG_AQ_CONFIGURE_QUEUES nor cfg_qps_sent is
cleared, and the state stays __IAVF_RUNNING.

The watchdog sends DISABLE_QUEUES first. The late reply to the cancelled
CONFIG chunk goes through the default branch of
iavf_virtchnl_completion(). That clears current_op while DISABLE is
still outstanding, so the next CONFIG chunk can reach the PF after
DISABLE.

On the PF side, ice_vc_cfg_qs_msg() programs the Tx/Rx queue contexts
from each message independently. It uses ring DMA addresses that iavf
frees with dma_free_coherent() when the DISABLE reply arrives.

Once that reply has run iavf_free_all_rx_resources(), rx_ring->pp is
NULL. If the flag is still set, the next watchdog run calls
iavf_configure_queues(), which dereferences pp before any check:

	max_frame = LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp->p.offset);

Could this leave the PF holding queue contexts that point at freed DMA
memory, and then oops on the NULL rx_rings->pp?

This needs more than 62 queue pairs, which becomes possible later in the
series with IAVF_MAX_REQ_QUEUES = 256. Before this patch the flag was
cleared when the single message went out, so the window only lasted
until the first watchdog send.

Should iavf_down() or iavf_suspend() clear IAVF_FLAG_AQ_CONFIGURE_QUEUES
and cfg_qps_sent?

>  	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_VSI_QUEUES,
>  			 (u8 *)vqci, len);
>  	kfree(vqci);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110141534.95614-1-przemyslaw.kitszel%40intel.com
