Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528B843B3E2
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122438; cv=none; b=kHl/UkUs5TdKOADiY/BIl0Tk7qwdttVcz/N+aBu4fnV8ykvUJdEYvS20p6jfMAhS16UK8VpoYZs5A7pNQVvpFD89ksygGum7sYpJRdFFjNTM2OwxtnISXf+uQ37arLMiEgRB6F474EwnOFeDoHWevsvVSKNANkfkCiL/A3M2vqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122438; c=relaxed/simple;
	bh=k/D9NzUpUdz/YOudS1ieCkK88C8TvYESG/o345Ip3F0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O0xTziIp2xln6z54KDKvS6lI48S5d04zYOhzMupQhUFYvVBRuRyUjSwrYyotKHTh9mQsgDJnQ7/C6SWXDNfo9wO9M7THWHf6WUklxctNBfTaA38lOkwV/j6X3rF3Yb6PUId1K/E+q1OnVVchRXqcg/5NuuIGnfgGYGwkoFIYS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXEUeRHE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXEUeRHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826F41F0089A;
	Fri, 11 Sep 2026 10:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789122431;
	bh=1Y33lLTXavN5sFHtaA6agtWu/CV+oVVV1U4P2TA15l0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iXEUeRHErxEt7tXbaPfFGkrIvsi4Xmf3fnFNfLoFKGjp95uRtYzO1HiJylwGbMkQg
	 EuBHPKNqr/8BDlDSHXapt5OfEyzN4MqBHI54RCXYVKHj3qWbjMvLZCTrz1XipVDhX7
	 32lqfgYpNlE0d/v8PePmz3Pcd+yM7KBKRWMxjyuSsflhuhIfW+B1TppECNydaFqUTf
	 jqBeX1CZvkJ8ECi4kZRqPdpcjhuLCmrryWoqUnXq/Z7Jjb569udGLV72rsm9uEm2mE
	 r7GHC9kC8hydX/sEMxBgEgD9s257Amggoqk6JuIY0xzAnTGj/6bR8jSbT8JUkwY0LB
	 7CIMLztKOAPJA==
Subject: Re: [PATCH net-next 3/3] ice: use per-interface clock_id for E825
 generic DPLLs
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 grzegorz.nitka@intel.com, arkadiusz.kubalewski@intel.com,
 przemyslaw.korba@intel.com, richardcochran@gmail.com,
 alexander.nowlin@intel.com
Date: Fri, 11 Sep 2026 10:27:10 +0000
Message-ID: <178912243008.219967.7455851936472254253@kernel.org>
In-Reply-To: <20260908222428.872254-4-anthony.l.nguyen@intel.com>
References: <20260908222428.872254-4-anthony.l.nguyen@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 0

- [Medium] In ice_dpll_init_txclk_pins()
  (drivers/net/ethernet/intel/ice/ice_dpll.c:4279-4282) the board-level…
- [Medium] ice_dpll_pin_notify()
  (drivers/net/ethernet/intel/ice/ice_dpll.c:3928) replaces the board-…
- [Medium] ice_generate_dpll_clock_id()
  (drivers/net/ethernet/intel/ice/ice_dpll.c:3086-3092) feeds…

--

ice: use per-interface clock_id for E825 generic DPLLs

On E825 the TX-CLK and TSPLL generic DPLL devices no longer take their
clock_id from the board-level PCIe DSN, but from the permanent port MAC
(TSPLL adds BIT_ULL(63) as a tag).  The notifier self-suppression check in
ice_dpll_pin_notify() is extended with a new helper that compares the
incoming src_clock_id against this PF's board, TXC and TSPLL clock_ids.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 00e3f7de7810..0109fc34307c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -3059,6 +3059,68 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
>  	return pci_get_dsn(pf->pdev);
>  }
>  
> +/**
> + * ice_generate_dpll_clock_id - generate clock_id for a specific dpll device
> + * @pf: board private structure
> + * @d: dpll device context
> + * @type: dpll type being registered
> + *
> + * For E825 generic DPLLs, use per-interface permanent MAC as the clock_id
> + * basis so userspace can unambiguously map DPLL devices to interfaces.
> + * TX-CLK keeps plain MAC-derived ID, while TSPLL uses the same basis with
> + * a dedicated tag bit to remain distinct on source-timer owner PFs.
> + * Other DPLL objects keep board-level DSN-derived clock_id.
> + *
> + * Return: generated clock id for a dpll device
> + */
> +static u64 ice_generate_dpll_clock_id(struct ice_pf *pf, struct ice_dpll *d,
> +				      enum dpll_type type)
> +{
> +	struct ice_hw *hw = &pf->hw;
> +	u64 mac_clock_id;
> +
> +	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
> +	    type == DPLL_TYPE_GENERIC &&
> +	    hw->port_info &&
> +	    is_valid_ether_addr(hw->port_info->mac.perm_addr)) {
> +		mac_clock_id = ether_addr_to_u64(hw->port_info->mac.perm_addr);
> +
> +		if (d->dpll_idx >= E825_DPLL_TXCLK_BASE_IDX)
> +			return mac_clock_id;
> +
> +		if (d->dpll_idx == E825_DPLL_TSPLL_BASE_IDX)
> +			return mac_clock_id | BIT_ULL(63);
> +	}
> +
> +	return pf->dplls.clock_id;
> +}

[Severity: Medium]
Are these two values still valid clock identifiers as far as the dpll uAPI
is concerned?  Documentation/driver-api/dpll.rst describes the field as:

  ``DPLL_A_CLOCK_ID``                attr Unique Clock Identifier
                                         (EUI-64), as defined by the
                                         IEEE 1588 standard

and dpll_msg_add_dev_handle() exports the driver value verbatim with
nla_put_64bit(msg, DPLL_A_CLOCK_ID, ...), so whatever is stored here
becomes uAPI.

ether_addr_to_u64() packs the six MAC bytes into the low 48 bits and leaves
bits 48-63 zero, which is not the MAC-48 to EUI-64 mapping IEEE 1588 asks
for (OUI[0..2] || FF FE || NIC[3..5]).  The same driver keeps feeding the
same attribute a genuine EUI-64 for the EEC/PPS and non-E825 objects:

	static u64 ice_generate_clock_id(struct ice_pf *pf)
	{
		return pci_get_dsn(pf->pdev);
	}

Should the MAC be expanded into a proper EUI-64 so both producers in this
driver use one format?

For the TSPLL variant, mac_clock_id | BIT_ULL(63) sets a bit inside what
would be the first octet of the OUI, so it can collide with a real clock
identifier starting 80:00, and the exported value no longer visibly matches
the interface MAC that the commit message wants userspace to key on.

Is the tag bit needed at all?  dpll_device_get() matches on (clock_id,
device_idx, module):

	if (dpll->clock_id == clock_id &&
	    dpll->device_idx == device_idx &&
	    dpll->module == module) {

and TSPLL uses E825_DPLL_TSPLL_BASE_IDX while TX-CLK uses
E825_DPLL_TXCLK_BASE_IDX and above, so the device_idx already separates the
two objects.

> +
> +/**
> + * ice_dpll_is_own_dpll_clock_id - check if clock_id belongs to this pf's DPLLs
> + * @pf: board private structure
> + * @clock_id: clock_id from a DPLL notification
> + *
> + * Match info->src_clock_id from a DPLL pin notification against any DPLL
> + * device this PF has registered. Used to suppress self-notifications
> + * generated as a side effect of our own dpll_pin_register() and
> + * dpll_pin_unregister() calls on the fwnode-backed SYNCE and TIME_REF pins,
> + * whose DPLLs (TXC and TSPLL) use MAC-derived clock_ids on E825.
> + *
> + * Return: true if clock_id matches one of this PF's registered DPLL devices.
> + */
> +static bool ice_dpll_is_own_dpll_clock_id(struct ice_pf *pf, u64 clock_id)
> +{
> +	if (clock_id == pf->dplls.clock_id)
> +		return true;
> +	if (pf->hw.mac_type != ICE_MAC_GENERIC_3K_E825)
> +		return false;
> +	if (clock_id == ice_generate_dpll_clock_id(pf, &pf->dplls.txc,
> +						   DPLL_TYPE_GENERIC))
> +		return true;
> +	return clock_id == ice_generate_dpll_clock_id(pf, &pf->dplls.tspll,
> +						      DPLL_TYPE_GENERIC);
> +}

[Severity: Medium]
Does this helper still cover notifications generated by a sibling PF of the
same NAC?

The old test compared src_clock_id against pf->dplls.clock_id, which is
pci_get_dsn() and, as the commit message says, "identical for all interfaces
sharing the same NAC/quad".  It therefore matched register/unregister events
raised by any PF on the board.  The new helper only matches this PF's three
values: board DSN, MAC(self) and MAC(self) | BIT(63).

The notification carries the target DPLL device's clock_id.  In
__dpll_pin_unregister():

	dpll_pin_delete_ntf(pin, dpll->clock_id);

so for the shared fwnode SYNCE pin the value is now MAC(sibling PF), which
ice_dpll_is_own_dpll_clock_id() rejects.

If PF-A is unbound:

  ice_dpll_deinit() -> ice_dpll_deinit_txclk_pins() ->
  ice_dpll_unregister_pins() -> dpll_pin_unregister(PF-A txc dpll, synce pin)
  -> __dpll_pin_unregister() -> dpll_pin_delete_ntf(pin, MAC(PF-A))

PF-B's ice_dpll_pin_notify() passes the fwnode test (it is the same shared
pin), the new clock_id test returns false, work gets queued, and
ice_dpll_pin_notify_work() takes the DPLL_PIN_DELETED branch:

	} else if (is_tx_synce_parent) {
		/* Unregister TX-CLK SYNCE pin from TXC DPLL */
		pin = &pf->dplls.txclks[E825_EXT_SYNCE_PIN_IDX];
		dpll_pin_unregister(pf->dplls.txc.dpll, pin->pin,
				    &ice_dpll_txclk_ops, pin);

Can this tear down PF-B's own still-valid SYNCE registration, so that after
unbinding one PF the surviving ports of the same NAC can no longer select
SyncE as TX reference?

This depends on both PFs' clk_ref_synce reference resolving to the same
fwnode object, which is what ice_dpll_pin_node_get() looks up and what
ice_txclk_enable_peer() suggests when it notes that SyncE must be enabled on
both PHY complexes.  If that is how the platform description is expected to
look, should the helper also accept clock_ids belonging to other PFs of the
same board, or should the suppression be keyed on something other than the
clock_id?

> @@ -3858,10 +3920,12 @@ static int ice_dpll_pin_notify(struct notifier_block *nb, unsigned long action,
>  	if (pin->fwnode != info->fwnode)
>  		return NOTIFY_DONE; /* Not this pin */
>  
> -	/* Ignore notification which are the outcome of internal pin
> -	 * registration/unregistration calls - synce pin case.
> +	/* Ignore notifications that are a side effect of internal pin
> +	 * registration/unregistration calls. E825 uses per-device
> +	 * MAC-derived clock_ids for the TXC and TSPLL generic DPLLs, so
> +	 * info->src_clock_id may not equal pf->dplls.clock_id.
>  	 */
> -	if (info->src_clock_id == pin->pf->dplls.clock_id)
> +	if (ice_dpll_is_own_dpll_clock_id(pin->pf, info->src_clock_id))
>  		return NOTIFY_DONE;
>  
>  	work = kzalloc_obj(*work);
> @@ -4206,10 +4270,16 @@ static int ice_dpll_init_txclk_pins(struct ice_pf *pf, int start_idx)
>  {
>  	struct ice_dpll_pin *ref_pin = pf->dplls.txclks;
>  	struct ice_dpll *txc = &pf->dplls.txc;
> +	u64 clock_id;
>  	int ret;
>  
> +	/* EXT_EREF0 is a non-fwnode pin; its clock_id must match the TX-CLK
> +	 * DPLL device clock_id (see dpll_pin_register()).
> +	 */
> +	clock_id = ice_generate_dpll_clock_id(pf, txc, DPLL_TYPE_GENERIC);
> +
>  	/* Configure EXT_EREF0 pin */
> -	ret = ice_dpll_get_pins(pf, ref_pin, start_idx, 1, pf->dplls.clock_id);
> +	ret = ice_dpll_get_pins(pf, ref_pin, start_idx, 1, clock_id);
>  	if (ret)
>  		return ret;
>  	ret = dpll_pin_register(txc->dpll, ref_pin->pin, &ice_dpll_txclk_ops,

[Severity: Medium]
Does this change how many pin objects the single physical EXT_EREF0
connector produces?

dpll_pin_get() keys pin identity on (clock_id, pin_idx, module):

	if (pos->clock_id == clock_id &&
	    pos->pin_idx == pin_idx &&
	    pos->module == module) {

Every PF reaches here with the same start_idx, so with the board DSN all
PFs of a NAC obtained the same dpll_pin object for EREF0 and each registered
it on its own TX-CLK DPLL device, i.e. one pin with several parent DPLLs.
With the MAC-derived clock_id the lookup can no longer match a sibling PF's
pin, so each PF allocates a private pin object.

EREF0 is described as a board-level signal in
ice_dpll_init_info_txclk_pins_e825c():

	tx_pin->prop.board_label = ice_dpll_ext_eref_pin;
	tx_pin->tx_ref_src = ICE_REF_CLK_EREF0;

Does userspace then see N pins all labelled "EXT_EREF0" with no indication
that they are the same input?  The sibling input of the same TX-CLK DPLL
(EXT_SYNCE, fwnode-backed) stays a single shared pin with several parent
DPLLs, so the two external TX reference inputs of one DPLL device end up
modelled differently.

The commit message only talks about DPLL devices:

  "Since these DPLLs are per-interface, use the permanent port MAC as
   the clock_id basis for E825 generic DPLLs"

Could it also mention that DPLL_A_PIN_CLOCK_ID and the number of exported
EREF0 pin objects change, since that is userspace-visible as well?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908222428.872254-1-anthony.l.nguyen%40intel.com
