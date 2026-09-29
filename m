Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A111E357CF1
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790690649; cv=none; b=Cw7SXLOV2VvSJSJ50sCU8hO33595062tTrlyvDBdUdIMGvAZph8/YGHqwCsz8MHEfzD4ekKU307vihPvOjeTHGUnig8GUMkDZvBHEn1VXw3aAduTgkXNM17ASnNvSmNL9v2zAXRm640ZFOTrnD3Wdt55C0jO01pqXzekTYZmJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790690649; c=relaxed/simple;
	bh=AFBndkKtlzbJe6okMlqHUt26gdhJw6FTSSf24SLFyzU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PrMUn3soJ7LJixWixIGU0raZPzQGkh9Uwuoue8WfSnNXvzs5zZ9l86f+KcIWiCbhdpcPmQ4uN8nWSQ66tLXNRpnfK9dfIDWF3nl0mfs+ljk9dfVsV516sHEhnJOI+LoGPkzoGTeL/yU1lRgFfSjSH92FCrx5iTh7qIWNBTUccts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkG7wXTK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkG7wXTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B109C1F000FF;
	Tue, 29 Sep 2026 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790690648;
	bh=EGsrXk7mGPt8OvlDTwMjjbzt9XQbBGa8qMAsdFFi09g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WkG7wXTK163jlAeBufXNohj0lTB6edtdoRmw3w66jXjNsFE/zY6X4NMLs4k/eXd8I
	 BOmXSO6he1e9HLrl/c/1hVxzOeXPOJ4cXAV4aol14L3LdauHFjx/aDBKJSE7p3ofGi
	 FkXTEcIQJmsWstJexRXvXoOH0S0lSw4VOuNwSneyK6aJdDs207JnSUZto1c9n/B5vY
	 /qlB3K/42o8eH+4IsnCl1/sm/Lt5nBFeu6yYt/Q5WDMpuuJTo1qX/MFdIUY1dmCmmk
	 5pwVEBSuYARfR4MtY0zibnAEsGiU2TkA6PBWm9t+QyACVtkjyR5WDw2EGCf1Vgw2Ul
	 LHe7V9l26B8KA==
Subject:
 Re: [PATCH net v5 1/6] ice: skip stats handling for channel VSIs on rebuild
From: netdev-bot+sashiko@kernel.org
To: przemyslaw.kitszel@intel.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com, mschmidt@redhat.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Date: Tue, 29 Sep 2026 14:04:07 +0000
Message-ID: <179069064725.434549.10623558636835220604@kernel.org>
In-Reply-To: <20260925132636.123300-2-przemyslaw.kitszel@intel.com>
References: <20260925132636.123300-2-przemyslaw.kitszel@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In ice_vsi_realloc_stat_arrays()
  (drivers/net/ethernet/intel/ice/ice_lib.c), the new guard skips only…

--

ice: skip stats handling for channel VSIs on rebuild

This patch makes ice_vsi_realloc_stat_arrays() return early for
ICE_VSI_CHNL VSIs. Those VSIs never get an entry in pf->vsi_stats[], so
this avoids a NULL dereference when a PF reset rebuilds channel VSIs
while an mqprio hardware offload is active.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 9e08db376d3d0..31af378aa0e7a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -3031,6 +3031,10 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>  	u16 prev_rxq = vsi->alloc_rxq;
>  	int i;
>  
> +	/* channel VSIs have no entry in pf->vsi_stats[] */
> +	if (vsi->type == ICE_VSI_CHNL)
> +		return 0;
> +
>  	vsi_stat = pf->vsi_stats[vsi->idx];
>  
>  	if (req_txq < prev_txq) {

[Severity: Medium]

This guard only checks the VSI type. Can pf->vsi_stats[vsi->idx] also be
NULL here for a PF, VF or other non-channel VSI?

If an earlier ice_vsi_rebuild() failed inside ice_vsi_cfg_def(), the
unroll path frees the entry:

ice_vsi_cfg_def() {
    ...
unroll_vsi_alloc_stat:
	ice_vsi_free_stats(vsi);
    ...
}

and ice_vsi_free_stats() ends with:

	pf->vsi_stats[vsi->idx] = NULL;

ice_vsi_alloc_ring_stats() does the same on its err_out path.
ice_vsi_rebuild() then returns through goto unlock without restoring the
entry, and the VSI stays in pf->vsi[].

Some callers then call ice_vsi_rebuild() on the same VSI again. One
example is the fallback in ice_setup_tc_mqprio_qdisc():

	ret = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
	if (ret) {
		...
		if (ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT)) {

The same thing can happen through the unroll path in
ice_sriov_set_msix_vec_count(), when userspace retries ethtool -L or -G
through ice_vsi_recfg_qs(), or on a later PF or VF reset.

On that second call vsi_stat is NULL and the type check does not catch
it. If req_txq < prev_txq, the oops happens at
vsi_stat->tx_ring_stats[i]. Otherwise it happens at:

	tx_ring_stats = vsi_stat->tx_ring_stats;

ice_vsi_free_stats() and ice_qp_reset_stats() already handle a NULL
entry. Would a !vsi_stat check here cover both the channel VSI case and
this one?

The new comment, "channel VSIs have no entry in pf->vsi_stats[]", also
implies that only channel VSIs can be missing an entry.

A later patch in this series, "ice: rebuild ring stats arrays instead of
reallocating them in place", appears to fix this. It replaces the
function with ice_vsi_resize_stat_arrays() -> ice_vsi_install_stat_arrays(),
and ice_vsi_set_stat_arrays() handles a NULL entry with:

	if (!vsi_stat)
		return;

Should this patch check for a NULL vsi_stat as well, so that it is a
complete fix on its own?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925132636.123300-1-przemyslaw.kitszel%40intel.com
