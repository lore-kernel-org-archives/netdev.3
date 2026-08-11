Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7291E5B70
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408516; cv=none; b=KUW/7dHw7tSnCjOh/Ds1G0lz+bCpHHvr8WlZoJb5t7ppJ/2G82ThaJRzxYBgSpL5r3zdeD0Hrliconqg8ItJW7QUHYTxokfVhAlfjkH80jS1bh/BaqIuU/9DOfZrY9HDV9nCzqnOpth4es0FFubFw4bfafQ/kwYaQXBdUeGakP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408516; c=relaxed/simple;
	bh=lSpZXqsDG1/4DOQVW7VZkM5huH5Psl+Vp2V+8c9e5k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLMJibQ2+nEpttyd3CreTGise59hbxnp85JBy/reQzF2Z8HOiXHkaqgzzYtB9BHxi570pCjxur7bYTGNf9/HGOcrCqJWGtEvJbHkBjBmP7H5OcPPgkvZPvf7uUiQkapFYKTK6dfCnE3dsjbiqMx/UFJklKzn/IaTf17DoGNCHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu/3ohEt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu/3ohEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5F51F000E9;
	Tue, 11 Aug 2026 00:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786408514;
	bh=dgG4SyEZRgYr4XOpaEHYyUQ5+sKkjFwkem/lwv0bheU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gu/3ohEthmOCAksZqxObMA5tcXGP0gqv56XDOFTvAnEVnnf8aorddTaf0Sl6Y7aEt
	 C0XJo9kPtzqYENlnyDpnAPWfJD+gmJhPuVr/6Kctr391crCCxrivod2vyKyDgnliOH
	 iRxqjTX1SpaLl3YpZdVOz55ztgciHukmaPhviyKvq0+N3C7HfNoAGJSwLbUd383Vvz
	 L4C3bFIKQPAZJkTfFQmJSO7U50thuwE9N0ZbTRo+Ehw0SwHOfLk5AaVWYE+RBNW9s3
	 QOetSyRVCYamDQg4rGGaRo+mEMaiD0/DB+ZWdEqHHgpuwtHaAPlyCDp96+0zNnBxHk
	 Q6GrO2302li7Q==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	tactii@gmail.com,
	dima.ruinskiy@intel.com,
	aleksandr.loktionov@intel.com,
	pmenzel@molgen.mpg.de,
	michalx.cohen@intel.com
Subject: Re: [PATCH net-next 01/15] ice: add support for unmanaged DPLL on E830 NIC
Date: Mon, 10 Aug 2026 17:33:46 -0700
Message-ID: <20260811003346.1055481-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805213541.2281287-2-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ice: add support for unmanaged DPLL on E830 NIC

This adds support for E830 variants with an unmanaged DPLL, where the
configuration lives in hardware/firmware and userspace can only read the
lock status through the DPLL and devlink health subsystems. Detection is
based on firmware advertising the 'loss of lock' health status code plus a
ZL80640 clock-control node in the netlist, after which a single PPS DPLL
device with read-only pins is registered.

A few questions below about the new detection, notification and teardown
paths.

The commit message says:

  "Availability of 'loss of lock' health status code determines if such
  support is available, if true, register single DPLL device with 1 input
  and 1 output"

[Severity: Low]
Should this say 1 input and 2 outputs? ice_e830_unmanaged_outputs[] added
in ice_ptp_hw.c contains both "MAC-PHY-CLK" and "1588-TIME_REF", and
ice_dpll_init_info_unmanaged() takes d->num_outputs straight from
ice_cgu_get_pin_num(&pf->hw, false), i.e. ARRAY_SIZE() = 2. The ice.rst
dump added by the same patch also lists three pins (ids 13, 14, 15), so
the documentation and the code agree with each other but not with the
changelog.

> diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
> index 8e9a8a8178d48..a83eb9f104c83 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/health.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/health.c

[ ... ]

> @@ -242,6 +244,10 @@ void ice_process_health_status_event(struct ice_pf *pf, struct ice_rq_event_info
>  				pf->health_reporters.fw_status = *health_info;
>  				devlink_health_report(pf->health_reporters.fw,
>  						      "FW syndrome reported", NULL);
> +				if (status_code == ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK &&
> +				    test_bit(ICE_FLAG_DPLL, pf->flags) &&
> +				    pf->dplls.unmanaged)
> +					ice_dpll_lock_state_set_unmanaged(pf, health_info, true);
>  				break;

[Severity: High]
Can this race with ice_dpll_deinit()?

ICE_FLAG_DPLL and pf->dplls.unmanaged are tested here with no lock held
and without taking any reference that keeps the DPLL objects alive.
ice_process_health_status_event() runs from the service task
(__ice_clean_ctrlq()), and ice_remove() -> ice_unload() ->
ice_deinit_features() -> ice_dpll_deinit() runs before
ice_deinit_dev() -> ice_service_task_stop(), so the service task is still
live while the DPLL objects are being torn down:

CPU0 (service task)                     CPU1 (ice_remove)
ice_process_health_status_event()
  test_bit(ICE_FLAG_DPLL) -> true
  pf->dplls.unmanaged -> true
  ice_dpll_lock_state_set_unmanaged()
    mutex_lock(&pf->dplls.lock)  <- blocks
                                        ice_dpll_deinit()
                                          clear_bit(ICE_FLAG_DPLL)
                                          ice_dpll_deinit_dpll(pps)
                                            dpll_device_put()
                                          mutex_destroy(&dplls.lock)
    ... writes d->dpll_state
    mutex_unlock()
    dpll_device_change_ntf(d->dpll)

Two things look problematic in that window: pf->dplls.lock is taken (and
then destroyed underneath), and d->dpll is dereferenced after the device
was put. ice_dpll_deinit_dpll() calls dpll_device_put() but never sets
d->dpll = NULL, so the "if (notify && d->dpll)" guard in
ice_dpll_lock_state_set_unmanaged() cannot detect the freed device.

The driver already has the pattern for the analogous txclk notifier: the
flag is re-checked under pf->dplls.lock and in-flight notifiers are drained
with down_write()/up_write() on pf->dplls.txclk_notify_rwsem in
ice_dpll_deinit(). Note that drain is gated on
pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825, so it would not cover the E830
unmanaged case even if the new path used the rwsem. Would re-checking
ICE_FLAG_DPLL under pf->dplls.lock, clearing d->dpll in
ice_dpll_deinit_dpll(), and adding an unconditional drain be enough here?

> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index 42878abac9eb1..848ac58342979 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h

[ ... ]

> @@ -2483,11 +2484,14 @@ enum ice_aqc_health_status {
>  	ICE_AQC_HEALTH_STATUS_ERR_BMC_RESET			= 0x50B,
>  	ICE_AQC_HEALTH_STATUS_ERR_LAST_MNG_FAIL			= 0x50C,
>  	ICE_AQC_HEALTH_STATUS_ERR_RESOURCE_ALLOC_FAIL		= 0x50D,
> +	ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK			= 0x601,
>  	ICE_AQC_HEALTH_STATUS_ERR_FW_LOOP			= 0x1000,
>  	ICE_AQC_HEALTH_STATUS_ERR_FW_PFR_FAIL			= 0x1001,
>  	ICE_AQC_HEALTH_STATUS_ERR_LAST_FAIL_AQ			= 0x1002,
>  };
>  
> +#define ICE_AQC_HEALTH_STATUS_CODE_NUM				64
> +
>  /* Get Health Status (indirect 0xFF22) */
>  struct ice_aqc_get_health_status {
>  	__le16 health_status_count;

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index ef1ce106f81b5..2c72ed18695c5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -3048,6 +3048,29 @@ bool ice_is_cgu_in_netlist(struct ice_hw *hw)
>  	return false;
>  }
>  
> +/**
> + * ice_is_unmanaged_cgu_in_netlist - check for unmanaged CGU presence
> + * @hw: pointer to the hw struct
> + *
> + * Check if the unmanaged Clock Generation Unit (CGU) device is present in the netlist.
> + * Save the CGU part number in the hw structure for later use.
> + * Return:
> + * * true - unmanaged cgu is present
> + * * false - unmanaged cgu is not present
> + */
> +bool ice_is_unmanaged_cgu_in_netlist(struct ice_hw *hw)
> +{
> +	if (!ice_find_netlist_node(hw, ICE_AQC_LINK_TOPO_NODE_TYPE_CLK_CTRL,
> +				   ICE_AQC_LINK_TOPO_NODE_CTX_GLOBAL,
> +				   ICE_AQC_GET_LINK_TOPO_NODE_NR_ZL80640,
> +				   NULL)) {
> +		hw->cgu_part_number = ICE_AQC_GET_LINK_TOPO_NODE_NR_ZL80640;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  /**
>   * ice_is_gps_in_netlist
>   * @hw: pointer to the hw struct

[ ... ]

> @@ -6312,6 +6335,119 @@ bool ice_is_fw_health_report_supported(struct ice_hw *hw)

[ ... ]

> +int ice_is_health_status_code_supported(struct ice_hw *hw, u16 code,
> +					bool *supported)
> +{
> +	const int BUFF_SIZE = ICE_AQC_HEALTH_STATUS_CODE_NUM;
> +	struct ice_aqc_health_status_supp_elem *buff;
> +	int ret;
> +
> +	*supported = false;
> +	buff = kzalloc_objs(*buff, BUFF_SIZE);
> +	if (!buff)
> +		return -ENOMEM;
> +	ret = ice_aq_get_health_status_supported(hw, buff, BUFF_SIZE);
> +	if (ret)
> +		goto free_buff;
> +	for (int i = 0; i < BUFF_SIZE && buff[i].health_status_code; i++)
> +		if (le16_to_cpu(buff[i].health_status_code) == code) {
> +			*supported = true;
> +			break;
> +		}
> +
> +free_buff:
> +	kfree(buff);
> +	return ret;
> +}

[Severity: Low]
Both new helpers scan a fixed 64-element buffer up to the first zero
health_status_code and never look at the element count firmware returns in
struct ice_aqc_get_health_status.health_status_count, so truncation cannot
be distinguished from a complete read. The driver's own event path treats
that count as authoritative:

drivers/net/ethernet/intel/ice/devlink/health.c:
	count = le16_to_cpu(cmd->health_status_count);

If firmware ever reports more than ICE_AQC_HEALTH_STATUS_CODE_NUM supported
codes, would ice_is_health_status_code_supported() miss 0x601 and silently
disable the whole unmanaged DPLL feature? Would using the returned count,
or at least detecting a full buffer, be better here?

> +
> +/**
> + * ice_get_last_health_status_code - get last health status for given code
> + * @hw: pointer to the hardware structure
> + * @out: pointer to the health status struct to be filled
> + * @code: health status code to check
> + *
> + * Return: 0 on success, negative error code otherwise
> + */
> +int ice_get_last_health_status_code(struct ice_hw *hw,
> +				    struct ice_aqc_health_status_elem *out,
> +				    u16 code)
> +{
> +	const int BUFF_SIZE = ICE_AQC_HEALTH_STATUS_CODE_NUM;
> +	struct ice_aqc_health_status_elem *buff;
> +	int ret, last_status = -1;
> +
> +	buff = kzalloc_objs(*buff, BUFF_SIZE);
> +	if (!buff)
> +		return -ENOMEM;
> +	ret = ice_aq_get_health_status(hw, buff, BUFF_SIZE);
> +	if (ret)
> +		goto free_buff;
> +	for (int i = 0; i < BUFF_SIZE && buff[i].health_status_code; i++)
> +		if (le16_to_cpu(buff[i].health_status_code) == code)
> +			last_status = i;
> +
> +	if (last_status >= 0)
> +		memcpy(out, &buff[last_status], sizeof(*out));
> +	else
> +		memset(out, 0, sizeof(*out));
> +
> +free_buff:
> +	kfree(buff);
> +	return ret;
> +}

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
> index 9f53442121955..51036188cd396 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.h
> +++ b/drivers/net/ethernet/intel/ice/ice_common.h

[ ... ]

> @@ -188,6 +189,13 @@ ice_get_link_default_override(struct ice_link_default_override_tlv *ldo,
>  			      struct ice_port_info *pi);
>  bool ice_is_phy_caps_an_enabled(struct ice_aqc_get_phy_caps_data *caps);
>  bool ice_is_fw_health_report_supported(struct ice_hw *hw);
> +int ice_aq_get_health_status(struct ice_hw *hw,
> +			     struct ice_aqc_health_status_elem *buff, int num);
> +int ice_is_health_status_code_supported(struct ice_hw *hw, u16 code,
> +					bool *supported);
> +int ice_get_last_health_status_code(struct ice_hw *hw,
> +				    struct ice_aqc_health_status_elem *out,
> +				    u16 code);

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 85a74cd6ea1f3..1ca137f67dd48 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -19,6 +19,8 @@
>  #define ICE_DPLL_SW_PIN_INPUT_BASE_SFP		4
>  #define ICE_DPLL_SW_PIN_INPUT_BASE_QSFP		6
>  #define ICE_DPLL_SW_PIN_OUTPUT_BASE		0
> +#define ICE_DPLL_HEALTH_STATUS_LOCKED		1
> +#define ICE_DPLL_HEALTH_STATUS_UNLOCKED		0

[ ... ]

> @@ -4206,12 +4256,13 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
>  		return ret;
>  	}
>  	d->pf = pf;
> -	if (cgu || pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
> +	if (cgu || pf->dplls.unmanaged ||
> +	    pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
>  		const struct dpll_device_ops *ops = &ice_dpll_ops;
>  
>  		if (type == DPLL_TYPE_PPS && ice_dpll_is_pps_phase_monitor(pf))
>  			ops =  &ice_dpll_pom_ops;
> -		if (cgu)
> +		if (cgu && !pf->dplls.unmanaged)
>  			ice_dpll_update_state(pf, d, true);

[Severity: Medium]
Should the pom_ops selection above also exclude the unmanaged case, the
way the ice_dpll_update_state() call immediately below it does?

ice_dpll_init_unmanaged() calls
ice_dpll_init_dpll(pf, &pf->dplls.pps, true, DPLL_TYPE_PPS), so the
DPLL_TYPE_PPS branch is reachable, and ice_dpll_is_pps_phase_monitor()
returns true for every admin queue failure except LIBIE_AQ_RC_ESRCH:

	if (ret && pf->hw.adminq.sq_last_status == LIBIE_AQ_RC_ESRCH)
		return false;

	return true;

If E830 firmware rejects ice_aq_get_cgu_input_pin_measure() with any other
error code, the device is registered with the settable ice_dpll_pom_ops,
exposing phase-offset-monitor set on a device the changelog and the new
ice.rst section describe as non-configurable. Also,
ice_dpll_phase_offset_monitor_set() only stores
d->phase_offset_monitor_period, and ice_dpll_init_unmanaged() never calls
ice_dpll_init_worker(), so nothing would ever consume it. Would adding
"&& !pf->dplls.unmanaged" to the pom_ops condition be correct here?

> @@ -4428,10 +4529,13 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
>  		pins[i].prop.freq_supported_num = freq_supp_num;
>  		pins[i].pf = pf;
>  	}
> -	if (input)
> +	if (input && !pf->dplls.unmanaged) {
>  		ret = ice_dpll_init_ref_sync_inputs(pf);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	return ret;
> +	return 0;
>  }

[ ... ]

> @@ -4712,6 +4816,82 @@ static int ice_dpll_init_info_e825c(struct ice_pf *pf)
>  	return ret;
>  }
>  
> +/**
> + * ice_dpll_lock_state_init_unmanaged - initialize lock state for unmanaged dpll
> + * @pf: board private structure
> + *
> + * Initialize the lock state for unmanaged DPLL by checking health status.
> + * For unmanaged DPLL, we rely on hardware autonomous operation.
> + *
> + * Return:
> + * * 0 - success
> + * * negative - init failure reason
> + */
> +static int ice_dpll_lock_state_init_unmanaged(struct ice_pf *pf)
> +{
> +	u16 code = ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK;
> +	struct ice_aqc_health_status_elem buff;
> +	int ret;
> +
> +	ret = ice_get_last_health_status_code(&pf->hw, &buff, code);
> +	if (ret)
> +		return ret;
> +	ice_dpll_lock_state_set_unmanaged(pf, &buff, false);
> +
> +	return ret;
> +}

[ ... ]

> +static int ice_dpll_init_info_unmanaged(struct ice_pf *pf)
> +{
> +	struct ice_dplls *d = &pf->dplls;
> +	int ret;
> +
> +	d->clock_id = ice_generate_clock_id(pf);
> +	d->num_inputs = ice_cgu_get_pin_num(&pf->hw, true);
> +	d->num_outputs = ice_cgu_get_pin_num(&pf->hw, false);
> +	ret = ice_dpll_lock_state_init_unmanaged(pf);
> +	if (ret)
> +		return ret;
> +	d->inputs = kzalloc_objs(*d->inputs, d->num_inputs);
> +	if (!d->inputs)
> +		return -ENOMEM;

[Severity: Medium]
Should the pin counts be validated here? ice_cgu_get_pin_num() resolves to
ice_cgu_get_pin_desc(), whose new cases only cover E830 device IDs, so on
any other device that reaches this function both counts are 0.
kzalloc_objs(*d->inputs, 0) returns ZERO_SIZE_PTR, which is non-NULL, so
the check above does not fire, and with the
ice_dpll_init_info_direct_pins() tail now returning an unconditional 0
(pre-patch it returned the initial ret = -EINVAL when the pin loop never
executed) a pin-less DPLL device would be registered instead of the init
failing.

Related: pf->dplls.unmanaged is derived only from the firmware health-code
probe and the ZL80640 netlist search, neither of which looks at
pf->hw.mac_type or device_id, and ice_dpll_init() then returns before the
mac_type switch (see below). Would gating the detection on E830, or
rejecting num_inputs == 0, be worth adding?

[ ... ]

> @@ -4815,6 +4995,42 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
>  	return ret;
>  }
>  
> +/**
> + * ice_dpll_lock_state_set_unmanaged - determine lock state from health status
> + * @pf: board private structure
> + * @buff: health status buffer
> + * @notify: if true, notify dpll device
> + *
> + * Set unmanaged dpll lock state based on health status code and internal data.
> + * Context: Acquires and releases pf->dplls.lock (must release before notify
> + * if called).
> + */
> +void ice_dpll_lock_state_set_unmanaged(struct ice_pf *pf,
> +				       const struct ice_aqc_health_status_elem *buff,
> +				       bool notify)
> +{
> +	u32 internal_data = le32_to_cpu(buff->internal_data1);
> +	struct ice_dpll *d = &pf->dplls.pps;
> +
> +	if (!ice_pf_src_tmr_owned(pf))
> +		return;
> +
> +	mutex_lock(&pf->dplls.lock);
> +	if (buff->health_status_code == 0 ||
> +	    internal_data == ICE_DPLL_HEALTH_STATUS_LOCKED)
> +		d->dpll_state = DPLL_LOCK_STATUS_LOCKED;
> +	else
> +		d->dpll_state = DPLL_LOCK_STATUS_UNLOCKED;

[Severity: Medium]
Is treating health_status_code == 0 as DPLL_LOCK_STATUS_LOCKED intended?

ice_get_last_health_status_code() signals "no matching record found" by
zeroing the element and still returning 0:

	if (last_status >= 0)
		memcpy(out, &buff[last_status], sizeof(*out));
	else
		memset(out, 0, sizeof(*out));

so the caller cannot tell "firmware reported nothing" apart from
"firmware reported locked". The 0x601 record can legitimately be absent
(firmware has not posted it yet, the log was cleared by a preceding reset,
or it fell outside the 64-element window), and absence of the record is
not evidence of lock. Would reporting DPLL_LOCK_STATUS_UNLOCKED (or
returning -ENOENT from ice_get_last_health_status_code()) be safer for a
clock device?

> +
> +	if (d->prev_dpll_state == d->dpll_state)
> +		notify = false;
> +	else
> +		d->prev_dpll_state = d->dpll_state;
> +	mutex_unlock(&pf->dplls.lock);
> +	if (notify && d->dpll)
> +		dpll_device_change_ntf(d->dpll);
> +}
> +
>  /**
>   * ice_dpll_deinit - Disable the driver/HW support for dpll subsystem
>   * the dpll device.
> @@ -4854,9 +5070,10 @@ void ice_dpll_deinit(struct ice_pf *pf)
>  	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)
>  		cancel_work_sync(&pf->dplls.txclk_work);
>  
> -	ice_dpll_deinit_pins(pf, cgu);
> +	ice_dpll_deinit_pins(pf, cgu || pf->dplls.unmanaged);
>  	if (!IS_ERR_OR_NULL(pf->dplls.pps.dpll))
> -		ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
> +		ice_dpll_deinit_dpll(pf, &pf->dplls.pps,
> +				     cgu || pf->dplls.unmanaged);
>  	if (!IS_ERR_OR_NULL(pf->dplls.eec.dpll))
>  		ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
>  	if (!IS_ERR_OR_NULL(pf->dplls.txc.dpll))
> @@ -4866,6 +5083,45 @@ void ice_dpll_deinit(struct ice_pf *pf)
>  	mutex_destroy(&pf->dplls.lock);
>  }
>  
> +/**
> + * ice_dpll_init_unmanaged - initialize support for unmanaged dpll subsystem
> + * @pf: board private structure
> + *
> + * Set up the device dplls for unmanaged mode, register them and pins connected
> + * within Linux dpll subsystem. Allow userspace to obtain state of DPLL.
> + *
> + * Context: Initializes pf->dplls.lock mutex.
> + */
> +static void ice_dpll_init_unmanaged(struct ice_pf *pf)
> +{
> +	struct ice_dplls *d = &pf->dplls;
> +	int err;
> +
> +	if (!ice_pf_src_tmr_owned(pf))
> +		return;
> +	mutex_init(&d->lock);
> +	err = ice_dpll_init_info_unmanaged(pf);
> +	if (err)
> +		goto err_exit;
> +	err = ice_dpll_init_dpll(pf, &pf->dplls.pps, true, DPLL_TYPE_PPS);
> +	if (err)
> +		goto deinit_info;
> +	err = ice_dpll_init_pins(pf, true);
> +	if (err)
> +		goto deinit_pps;
> +	set_bit(ICE_FLAG_DPLL, pf->flags);

[Severity: Medium]
How is the reported lock status resynchronized with hardware after init?

For the unmanaged path d->dpll_state is a pure software cache: it is seeded
once here via ice_dpll_lock_state_init_unmanaged() and afterwards only
updated by asynchronous 0x601 health events. No periodic worker is started
(unlike the managed paths), ice_dpll_lock_status_get() just returns the
cached value:

	mutex_lock(&pf->dplls.lock);
	*status = d->dpll_state;
	mutex_unlock(&pf->dplls.lock);

and ice_dpll_init() is only called from ice_init_features(), i.e. probe,
with no re-seed after PFR/CORER/GLOBR when the control queues are torn
down and events can be missed. Would a single lost or reset-window event
leave the netlink lock-status permanently diverged from the hardware for
the rest of the driver load?

> +
> +	return;
> +
> +deinit_pps:
> +	ice_dpll_deinit_dpll(pf, &pf->dplls.pps, true);
> +deinit_info:
> +	ice_dpll_deinit_info(pf);
> +err_exit:
> +	mutex_destroy(&d->lock);
> +	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n", err);
> +}
> +

[ ... ]

> @@ -4975,8 +5231,23 @@ static void ice_dpll_init_e810(struct ice_pf *pf)
>  	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n", err);
>  }
>  
> +/**
> + * ice_dpll_init - initialize support for dpll subsystem
> + * @pf: board private structure
> + *
> + * Set up the device dplls, register them and pins connected within Linux dpll
> + * subsystem. Allow userspace to obtain state of DPLL and handling of DPLL
> + * configuration requests.
> + *
> + * Context: Initializes pf->dplls.lock mutex.
> + */
>  void ice_dpll_init(struct ice_pf *pf)
>  {
> +	if (pf->dplls.unmanaged) {
> +		ice_dpll_init_unmanaged(pf);
> +		return;
> +	}
> +
>  	switch (pf->hw.mac_type) {
>  	case ICE_MAC_GENERIC_3K_E825:
>  		ice_dpll_init_e825(pf);

[Severity: Medium]
Continuing the earlier point: this returns before the mac_type switch, so
if pf->dplls.unmanaged is ever true on an E825 part, ice_dpll_init_e825()
and its INIT_WORK(&d->txclk_work), init_rwsem(&d->txclk_notify_rwsem) and
init_completion(&d->dpll_init) are skipped, while ice_dpll_deinit() still
branches on mac_type:

	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
		down_write(&pf->dplls.txclk_notify_rwsem);
		up_write(&pf->dplls.txclk_notify_rwsem);
	}
	...
	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)
		cancel_work_sync(&pf->dplls.txclk_work);

Would that operate on a never-initialized rw_semaphore and work_struct?
Since pf->dplls.unmanaged is computed purely from the firmware health-code
probe and the generic ZL80640 netlist search, nothing structurally
prevents that combination today.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
> index 103ba3e490682..c59d746a85671 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.h
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
> @@ -26,6 +26,8 @@
>  #define ICE_CGU_R11_SYNCE_S_BYP_CLK	GENMASK(6, 1)
>  
>  #define ICE_CGU_BYPASS_MUX_OFFSET_E825C	3
> +#define ICE_DPLL_UNMANAGED_PIN_NUM	4
> +#define ICE_DPLL_IN_ESYNC_ENABLED	ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN

[Severity: Low]
These aren't bugs, but a few of the new definitions look unused or
duplicated:

ICE_DPLL_UNMANAGED_PIN_NUM has no reference anywhere in the tree, and its
value 4 also disagrees with the 3 pins the new tables define (1 input plus
2 outputs).

ICE_DPLL_HEALTH_STATUS_UNLOCKED in ice_dpll.c is never compared against;
ice_dpll_lock_state_set_unmanaged() only tests
ICE_DPLL_HEALTH_STATUS_LOCKED.

ice_cgu_get_pin_num() in ice_ptp_hw.c is a verbatim
"return ice_cgu_get_num_pins(hw, input);" wrapper with a near-identical
name, and both are now declared in ice_ptp_hw.h and used interchangeably
in ice_dpll.c (ice_cgu_get_num_pins() in
ice_dpll_init_info_direct_pins(), ice_cgu_get_pin_num() in
ice_dpll_init_info_unmanaged()) for counts that must stay consistent.

ice_aq_get_health_status() is declared in ice_common.h although its only
caller, ice_get_last_health_status_code(), is in the same C file, so it
could be static.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3aa..cc30d8c73a41c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4732,8 +4734,15 @@ static void ice_init_features(struct ice_pf *pf)
>  	if (ice_is_feature_supported(pf, ICE_F_GNSS))
>  		ice_gnss_init(pf);
>  
> +	/* Initialize unmanaged DPLL detection */
> +	err = ice_is_health_status_code_supported(&pf->hw, code,
> +						  &pf->dplls.unmanaged);
> +	if (err || !ice_is_unmanaged_cgu_in_netlist(&pf->hw))
> +		pf->dplls.unmanaged = false;
> +
>  	if (ice_is_feature_supported(pf, ICE_F_CGU) ||
> -	    ice_is_feature_supported(pf, ICE_F_PHY_RCLK))
> +	    ice_is_feature_supported(pf, ICE_F_PHY_RCLK) ||
> +	    pf->dplls.unmanaged)
>  		ice_dpll_init(pf);

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 8e5f97835954c..f905104f95d88 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c

[ ... ]

> @@ -131,6 +135,18 @@ static const struct ice_cgu_pin_desc ice_e823_zl_cgu_outputs[] = {
>  	{ "NONE",	   ZL_OUT5, 0, 0 },
>  };
>  
> +static const struct ice_cgu_pin_desc ice_e830_unmanaged_inputs[] = {
> +	{ "1588-TIME_SYNC", 0, DPLL_PIN_TYPE_EXT,
> +	  ARRAY_SIZE(ice_cgu_pin_freq_10_mhz), ice_cgu_pin_freq_10_mhz },
> +};
> +
> +static const struct ice_cgu_pin_desc ice_e830_unmanaged_outputs[] = {
> +	{ "MAC-PHY-CLK", 0, DPLL_PIN_TYPE_SYNCE_ETH_PORT,
> +	  ARRAY_SIZE(ice_cgu_pin_freq_156_25mhz), ice_cgu_pin_freq_156_25mhz },
> +	{ "1588-TIME_REF", 1, DPLL_PIN_TYPE_INT_OSCILLATOR,
> +	  ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz},
> +};

[ ... ]

> @@ -6005,6 +6039,18 @@ int ice_cgu_get_num_pins(struct ice_hw *hw, bool input)
>  	return 0;
>  }
>  
> +/**
> + * ice_cgu_get_pin_num - get pin description array size
> + * @hw: pointer to the hw struct
> + * @input: if request is done against input or output pins
> + *
> + * Return: size of pin description array for given hw.
> + */
> +int ice_cgu_get_pin_num(struct ice_hw *hw, bool input)
> +{
> +	return ice_cgu_get_num_pins(hw, input);
> +}
> +

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> index 16b1988e993d2..fa1e908cebac6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> @@ -364,6 +364,7 @@ int ice_read_sma_ctrl(struct ice_hw *hw, u8 *data);
>  int ice_write_sma_ctrl(struct ice_hw *hw, u8 data);
>  int ice_ptp_read_sdp_ac(struct ice_hw *hw, __le16 *entries, uint *num_entries);
>  int ice_cgu_get_num_pins(struct ice_hw *hw, bool input);
> +int ice_cgu_get_pin_num(struct ice_hw *hw, bool input);
-- 
pw-bot: cr
