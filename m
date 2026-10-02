Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6399488235
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971409; cv=none; b=fEoAM9QcB2OeQ+J8ZxcZwwD0c/ylhEXanXtWUkR8Ia0zwlOZjXjLL3XQz1AQm/xc4+9Hu2jtGFJHgHP0vnR1Qi5qSq0+TtrJKpB25jovfYMko1cn5Sbgmeq675CWK/JRFN5guRHkWXf/IuBzUqIBOmZWC33r8jJuFVpQkYOolPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971409; c=relaxed/simple;
	bh=nr9sLnVslFNJdbsxgMgR9Kb+VytsDpfDpXltSW6ijzU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hjNdG08ZpI4t9Ya4Jay9dgyHMoU9jbvU9yw5r6lojaA7DdmHw6/TjpD2i8l4Ps7CHCPp13ait7eUs6r0T5miYOtu7RYmhvrYdzx9yjbrgzRGzi2bRqcZbLFkcJ9OtGmn26noDz3lqS594VIp8gZQleu12xBXDzpq9pVFvC05UD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8HuOeeD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8HuOeeD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F921F00893;
	Fri,  2 Oct 2026 20:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790971407;
	bh=10yxYJdFxZBGlwpuzeqzWy2wXsAwZQagmo4DufjLlTY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B8HuOeeDBAw5BN25HYroAvrBYcg6nF+PmSEWTZt014xLoukJPH7ycnWFJ/GR7KolW
	 Nrv3n8omV4+ah9o0lCXpF+kCliAZH+dyeFcSAmTf4EA3aOGTIjJfCvyQz3NXFczBVg
	 L3M1XKqY5AM7889iL1dPDcklriXZA+X6cAIf16VjhMbQJIUkMQpObJneDD6+N6dXwS
	 0LbHZx3Sb72pwW2qb7+WEmfKcR9CglXPrzBBARLYvU7YL+SqEXgWLrtpVRFNlbD+Gz
	 f+YDQLiMl8o9vEW6UR8a1XHUEftehg8T/hNyFVaK+RJNYj5EUCfZJ2E9hSPKRx0Cr3
	 EVV+ggDP/fV/Q==
Subject: Re: [PATCH net-next 10/10] ice: simplify ice_vc_dis_qs_msg() a little
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, marcin.szycik@intel.com,
 jacob.e.keller@intel.com, przemyslaw.korba@intel.com, xiongwm2026@163.com,
 ynorov@nvidia.com, horms@kernel.org
Date: Fri, 02 Oct 2026 20:03:26 +0000
Message-ID: <179097140622.434549.1888059992750741846@kernel.org>
In-Reply-To: <20260929224153.1455466-11-anthony.l.nguyen@intel.com>
References: <20260929224153.1455466-11-anthony.l.nguyen@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message misdescribes the code it removes.

--

ice: simplify ice_vc_dis_qs_msg() a little

This commit removes a special case in ice_vc_dis_qs_msg(). When the
requested rx_queues bitmap matched vf->rxq_ena, that case disabled all Rx
queues as a batch through ice_vsi_stop_all_rx_rings(). All Rx queues now go
through the per-queue ice_vsi_ctrl_one_rx_ring() path.

> diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
> index 431c9c546b04f..ac7f98479b130 100644
> --- a/drivers/net/ethernet/intel/ice/virt/queues.c
> +++ b/drivers/net/ethernet/intel/ice/virt/queues.c

[ ... ]

> @@ -424,20 +426,7 @@ int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
>  	}
>  
>  	q_map = vqs->rx_queues;
> -	/* speed up Rx queue disable by batching them if possible */
> -	if (q_map &&
> -	    bitmap_equal(&q_map, vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF)) {
> -		if (ice_vsi_stop_all_rx_rings(vsi)) {
> -			dev_err(ice_pf_to_dev(vsi->back), "Failed to stop all Rx rings on VSI %d\n",
> -				vsi->vsi_num);
> -			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
> -			goto error_param;
> -		}
> -
> -		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF)
> -			ice_vf_dis_rxq_interrupt(vsi, vf_q_id);
> -		bitmap_zero(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF);
> -	} else if (q_map) {
> +	if (q_map) {

[Severity: Low]
Does the commit message describe the removed path correctly? It says:

  There were no actual speedup from it, the only difference was in saved
  bitmap checks, but the HW operations take the majority of time anyway.
  ice_vsi_stop_all_rx_rings() used (in the removed code) loops over rings
  anyway.

ice_vsi_stop_all_rx_rings() ends up in ice_vsi_ctrl_all_rx_rings(). That
function sends the disable request to every ring without waiting, flushes
once, and only then polls each ring:

drivers/net/ethernet/intel/ice/ice_lib.c:ice_vsi_ctrl_all_rx_rings() {
    ...
	ice_for_each_rxq(vsi, i)
		ice_vsi_ctrl_one_rx_ring(vsi, ena, i, false);

	ice_flush(&vsi->back->hw);

	ice_for_each_rxq(vsi, i) {
		ret = ice_vsi_wait_one_rx_ring(vsi, ena, i);
    ...
}

Its kernel-doc says this is on purpose: "This will let all of the register
writes complete when enabling/disabling the Rx rings before waiting for
the change in hardware to complete."

The path that remains calls ice_vsi_ctrl_one_rx_ring() with wait set to
true for each queue. Each call does its own ice_flush() and
ice_pf_rxq_wait() poll before the next queue starts:

drivers/net/ethernet/intel/ice/ice_base.c:ice_vsi_ctrl_one_rx_ring() {
    ...
	if (!wait)
		return 0;

	ice_flush(hw);
	return ice_pf_rxq_wait(pf, pf_q, ena);
}

So the removed code seems to have saved overlapped hardware wait time, not
bitmap checks.

ICE_MAX_RSS_QS_PER_VF is 16, and ice_pf_rxq_wait() is bounded by
ICE_Q_WAIT_MAX_RETRY polls of usleep_range(20, 40). That puts the worst
case at about 32ms instead of about 2ms. This is small and fits the
measurement in the commit message.

Could the justification be reworded to match what the code does?

The commit message also leaves out two small behaviour differences:

- The old path stopped every ring the VSI owns through ice_for_each_rxq(),
  not only the bits set in vf->rxq_ena.

- On a partial failure, the old path left vf->rxq_ena and the queue
  interrupts untouched. The per-queue path will already have cleared the
  rxq_ena bits and called ice_vf_dis_rxq_interrupt() for every queue it
  finished before the one that failed.

Should these be mentioned?

>  		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
>  			if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
>  				v_ret = VIRTCHNL_STATUS_ERR_PARAM;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929224153.1455466-1-anthony.l.nguyen%40intel.com
