Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CCF4457B0
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 22:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758449; cv=none; b=TKi0qjMwEk7tc7w1rdQBoPVfue8DbTv9ENAmMpnuiyiniXwnc9q2gAZqErGgCSquEZ+Ho4LPd5Eg14eAxTmPTNEbgtekw8omtEb39sH2Ox78rW3Jhl5WTSvCTJK0hv/WwaMqBtpCpnGI1wHVI481lEekoVMg3R18qB9m91ho8tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758449; c=relaxed/simple;
	bh=4MWmqYtcJHL8db0gIvCrIbFI17xtmN2PCmyeexouyF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCIXoYO1ARFswTEhu7t8pmQZqbjcjgzIppveQEDNyysSkv5Nsf/pvx5y3qL+uYHcqkx3a0qn0UUPGfTD3mw87JFkftDRZL6eMS/YCZZUNTI0H5NcO5HYgMV1buPN8MNYYuHynooMVgCDl/w7T2N1Q6/kWBrMewVFoYXNqTXV07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fl+v43sk; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fl+v43sk"
Message-ID: <dacc20a0-0ddf-459d-98dc-d3d49c6510d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784758438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04ndFLKSeHltx5UbPiZhQv/m+uTtp7cQzLb2Okpi8ZE=;
	b=Fl+v43skG13dfklRJPSLgkDewokNqi0YeV7sNW6JtaVmgyiSOaTL5WnWPsur3Za3m9NtnL
	9UZdoQ5ETLVuZqATooSXtH9EJ5ijoCOOVhxIAWiUGu4sYxH6cRDAU4aQEO1oA8pC7nns/T
	yDW9bH+B74fAKESwP0lP47HRKchbtBE=
Date: Wed, 22 Jul 2026 23:13:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] dpll: use pin owner's dpll ref for pin-level
 attribute reporting
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260714125945.1823269-1-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260714125945.1823269-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 14/07/2026 13:59, Ivan Vecera wrote:
> Commit c191b319f208 ("dpll: allow registering FW-identified pin with a
> different DPLL") relaxed dpll_pin_register() to let fwnode-identified pins
> register with DPLLs from a different driver. This allows, for example, the
> ICE driver to register a zl3073x-created pin with its TXC DPLL using
> ice_dpll_txclk_ops, which lack frequency_get and phase_adjust_get
> callbacks.
> 
> After such cross-driver registration, the pin's dpll_refs xarray contains
> refs from both drivers. dpll_cmd_pin_get_one() calls
> dpll_xa_ref_dpll_first() which returns the ref with the lowest DPLL id.
> When the foreign DPLL (e.g. ICE TXC) has a lower id than the owner DPLL
> (e.g. zl3073x), the foreign ops are used for reporting. Since those ops
> lack callbacks like frequency_get, pin-level attributes are silently
> omitted from the netlink response.
> 
> For example, a zl3073x output pin that should report frequency and
> phase-adjust shows neither:
> 
> Before:
>    # dpll pin show id 45
>    pin id 45:
>      module-name: zl3073x
>      clock-id: 3427468959636104019
>      board-label: 156M25_NAC0_CLKREF_SYNC
>      package-label: OUT3
>      type: synce-eth-port
>      capabilities: 0x0
>      phase-adjust-min: -2147483648
>      phase-adjust-max: 2147483647
>      phase-adjust-gran: 800
>      parent-device:
>        ...
> 
> After:
>    # dpll pin show id 19
>    pin id 19:
>      module-name: zl3073x
>      clock-id: 15964355450360090479
>      board-label: 156M25_NAC0_CLKREF_SYNC
>      package-label: OUT3
>      type: synce-eth-port
>      frequency: 156250000 Hz
>      frequency-supported:
>        156250000 Hz
>      capabilities: 0x0
>      phase-adjust-min: -2147483648
>      phase-adjust-max: 2147483647
>      phase-adjust-gran: 800
>      phase-adjust: 0
>      parent-device:
>        ...
> 
> Fix this by:
> 
> 1. Adding dpll_pin_own_dpll_ref_first() helper that returns the first ref
>     whose DPLL matches the pin's (module, clock_id) tuple — i.e. the DPLL
>     from the driver that created the pin and has the complete set of ops.
>     Return NULL if no owner ref is found.
> 
> 2. Using dpll_pin_own_dpll_ref_first() in dpll_cmd_pin_get_one() with a
>     fallback to dpll_xa_ref_dpll_first() for pin-on-pin child pins whose
>     dpll_refs all point to a different driver's DPLLs.
> 
> 3. Using dpll_pin_own_dpll_ref_first() in SET operations
>     (dpll_pin_freq_set, dpll_pin_esync_set, dpll_pin_ref_sync_state_set,
>     dpll_pin_phase_adj_set) returning -ENODEV if no owner ref exists.
>     Replacing the validation loops that rejected the entire operation when
>     any ref's ops lacked the required callback — instead validate only the
>     owner refs so that foreign DPLLs with incomplete ops no longer block
>     SET operations.
> 
> 4. Guarding all SET and rollback xa_for_each loops against NULL set
>     callbacks so that foreign refs without the operation are safely skipped
>     instead of causing a NULL pointer dereference.
> 
> Fixes: c191b319f208 ("dpll: allow registering FW-identified pin with a different DPLL")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/dpll_core.c    | 27 +++++++++++++++++
>   drivers/dpll/dpll_core.h    |  1 +
>   drivers/dpll/dpll_netlink.c | 60 ++++++++++++++++++++++++++++++-------
>   3 files changed, 78 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index bb1e8650c9d59..245f625f4b3b4 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -1146,6 +1146,33 @@ void *dpll_pin_on_pin_priv(struct dpll_pin *parent,
>   	return reg->priv;
>   }
>   
> +/**
> + * dpll_pin_own_dpll_ref_first - find the first owner dpll ref of a pin
> + * @pin: pointer to a dpll pin
> + *
> + * Search pin's dpll_refs for a ref whose dpll matches the pin's
> + * (module, clock_id) tuple, i.e. the dpll registered by the driver
> + * that created the pin. This ensures pin-level attributes are
> + * reported and modified using the owner's ops even when the pin is
> + * also registered with dplls from other drivers.
> + *
> + * Return: pointer to the owner's dpll_pin_ref, or NULL if no
> + * owner ref is found.
> + */
> +struct dpll_pin_ref *dpll_pin_own_dpll_ref_first(struct dpll_pin *pin)
> +{
> +	struct dpll_pin_ref *ref;
> +	unsigned long i;
> +
> +	xa_for_each(&pin->dpll_refs, i, ref) {
> +		if (ref->dpll->module == pin->module &&
> +		    ref->dpll->clock_id == pin->clock_id)
> +			return ref;
> +	}
> +
> +	return NULL;
> +}
> +
>   const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref)
>   {
>   	struct dpll_pin_registration *reg;
> diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
> index e245771134317..da8a369556ed1 100644
> --- a/drivers/dpll/dpll_core.h
> +++ b/drivers/dpll/dpll_core.h
> @@ -93,6 +93,7 @@ void *dpll_pin_on_pin_priv(struct dpll_pin *parent, struct dpll_pin *pin);
>   
>   const struct dpll_device_ops *dpll_device_ops(struct dpll_device *dpll);
>   struct dpll_device *dpll_device_get_by_id(int id);
> +struct dpll_pin_ref *dpll_pin_own_dpll_ref_first(struct dpll_pin *pin);
>   const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref);
>   struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct xarray *xa_refs);
>   extern struct xarray dpll_device_xa;
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index bf729cde796a7..b3f0cb7d3d349 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -696,7 +696,9 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
>   	struct dpll_pin_ref *ref;
>   	int ret;
>   
> -	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
> +	ref = dpll_pin_own_dpll_ref_first(pin);
> +	if (!ref)
> +		ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
>   	ASSERT_NOT_NULL(ref);
>   
>   	ret = dpll_msg_add_pin_handle(msg, pin);
> @@ -1087,12 +1089,19 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
>   
>   	xa_for_each(&pin->dpll_refs, i, ref) {
>   		ops = dpll_pin_ops(ref);
> -		if (!ops->frequency_set || !ops->frequency_get) {
> -			NL_SET_ERR_MSG(extack, "frequency set not supported by the device");
> +		if ((!ops->frequency_set || !ops->frequency_get) &&
> +		    ref->dpll->module == pin->module &&
> +		    ref->dpll->clock_id == pin->clock_id) {

ref->dpll->module == pin->module && ref->dpll->clock_id == pin->clock_id
is repeated multiple times in the patch, maybe it's better to make a
helper with some self-explaining name?

Apart from that patch looks reasonable, but I would like to have
explicit tag from Jiri.

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

> +			NL_SET_ERR_MSG(extack,
> +				       "frequency set not supported by the device");
>   			return -EOPNOTSUPP;
>   		}
>   	}
> -	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
> +	ref = dpll_pin_own_dpll_ref_first(pin);
> +	if (!ref) {
> +		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
> +		return -ENODEV;
> +	}
>   	ops = dpll_pin_ops(ref);
>   	dpll = ref->dpll;
>   	ret = ops->frequency_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
> @@ -1106,6 +1115,8 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
>   
>   	xa_for_each(&pin->dpll_refs, i, ref) {
>   		ops = dpll_pin_ops(ref);
> +		if (!ops->frequency_set)
> +			continue;
>   		dpll = ref->dpll;
>   		ret = ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
>   					 dpll, dpll_priv(dpll), freq, extack);
> @@ -1125,6 +1136,8 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
>   		if (ref == failed)
>   			break;
>   		ops = dpll_pin_ops(ref);
> +		if (!ops->frequency_set)
> +			continue;
>   		dpll = ref->dpll;
>   		if (ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
>   				       dpll, dpll_priv(dpll), old_freq, extack))
> @@ -1148,13 +1161,19 @@ dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
>   
>   	xa_for_each(&pin->dpll_refs, i, ref) {
>   		ops = dpll_pin_ops(ref);
> -		if (!ops->esync_set || !ops->esync_get) {
> +		if ((!ops->esync_set || !ops->esync_get) &&
> +		    ref->dpll->module == pin->module &&
> +		    ref->dpll->clock_id == pin->clock_id) {
>   			NL_SET_ERR_MSG(extack,
>   				       "embedded sync feature is not supported by this device");
>   			return -EOPNOTSUPP;
>   		}
>   	}
> -	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
> +	ref = dpll_pin_own_dpll_ref_first(pin);
> +	if (!ref) {
> +		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
> +		return -ENODEV;
> +	}
>   	ops = dpll_pin_ops(ref);
>   	dpll = ref->dpll;
>   	ret = ops->esync_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
> @@ -1178,6 +1197,8 @@ dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
>   		void *pin_dpll_priv;
>   
>   		ops = dpll_pin_ops(ref);
> +		if (!ops->esync_set)
> +			continue;
>   		dpll = ref->dpll;
>   		pin_dpll_priv = dpll_pin_on_dpll_priv(dpll, pin);
>   		ret = ops->esync_set(pin, pin_dpll_priv, dpll, dpll_priv(dpll),
> @@ -1201,6 +1222,8 @@ dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
>   		if (ref == failed)
>   			break;
>   		ops = dpll_pin_ops(ref);
> +		if (!ops->esync_set)
> +			continue;
>   		dpll = ref->dpll;
>   		pin_dpll_priv = dpll_pin_on_dpll_priv(dpll, pin);
>   		if (ops->esync_set(pin, pin_dpll_priv, dpll, dpll_priv(dpll),
> @@ -1235,8 +1258,11 @@ dpll_pin_ref_sync_state_set(struct dpll_pin *pin,
>   		NL_SET_ERR_MSG(extack, "reference sync pin not available");
>   		return -EINVAL;
>   	}
> -	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
> -	ASSERT_NOT_NULL(ref);
> +	ref = dpll_pin_own_dpll_ref_first(pin);
> +	if (!ref) {
> +		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
> +		return -ENODEV;
> +	}
>   	ops = dpll_pin_ops(ref);
>   	if (!ops->ref_sync_set || !ops->ref_sync_get) {
>   		NL_SET_ERR_MSG(extack, "reference sync not supported by this pin");
> @@ -1255,6 +1281,8 @@ dpll_pin_ref_sync_state_set(struct dpll_pin *pin,
>   		return 0;
>   	xa_for_each(&pin->dpll_refs, i, ref) {
>   		ops = dpll_pin_ops(ref);
> +		if (!ops->ref_sync_set)
> +			continue;
>   		dpll = ref->dpll;
>   		ret = ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
>   					ref_sync_pin,
> @@ -1277,6 +1305,8 @@ dpll_pin_ref_sync_state_set(struct dpll_pin *pin,
>   		if (ref == failed)
>   			break;
>   		ops = dpll_pin_ops(ref);
> +		if (!ops->ref_sync_set)
> +			continue;
>   		dpll = ref->dpll;
>   		if (ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
>   				      ref_sync_pin,
> @@ -1468,12 +1498,18 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
>   
>   	xa_for_each(&pin->dpll_refs, i, ref) {
>   		ops = dpll_pin_ops(ref);
> -		if (!ops->phase_adjust_set || !ops->phase_adjust_get) {
> +		if ((!ops->phase_adjust_set || !ops->phase_adjust_get) &&
> +		    ref->dpll->module == pin->module &&
> +		    ref->dpll->clock_id == pin->clock_id) {
>   			NL_SET_ERR_MSG(extack, "phase adjust not supported");
>   			return -EOPNOTSUPP;
>   		}
>   	}
> -	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
> +	ref = dpll_pin_own_dpll_ref_first(pin);
> +	if (!ref) {
> +		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
> +		return -ENODEV;
> +	}
>   	ops = dpll_pin_ops(ref);
>   	dpll = ref->dpll;
>   	ret = ops->phase_adjust_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
> @@ -1488,6 +1524,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
>   
>   	xa_for_each(&pin->dpll_refs, i, ref) {
>   		ops = dpll_pin_ops(ref);
> +		if (!ops->phase_adjust_set)
> +			continue;
>   		dpll = ref->dpll;
>   		ret = ops->phase_adjust_set(pin,
>   					    dpll_pin_on_dpll_priv(dpll, pin),
> @@ -1510,6 +1548,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
>   		if (ref == failed)
>   			break;
>   		ops = dpll_pin_ops(ref);
> +		if (!ops->phase_adjust_set)
> +			continue;
>   		dpll = ref->dpll;
>   		if (ops->phase_adjust_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
>   					  dpll, dpll_priv(dpll), old_phase_adj,
