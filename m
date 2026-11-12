Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524864;
	b=DHtQYm0LXfB0uSLsKz3fFNTAr+D1QFxdhjrWUOM6wwwyAY7DIDyxPxyGhOw1i8psUGH4
	 noTMtFs4AKWrj1YC8JSCpe/6CQ/PTkJwKlj6B0J5ssz0Tcu55SnVmoeSirju9zJ24PlXW
	 sT56i64Hz9us8Y0MvQdFKG47AwDHCRgoVobeDSvk+M2UJyhOJKBs6vw02tPdjmpDtmwp0
	 RIkEK+E3dr1KVpg0Ab30W88JLj3vtbrPfQjRBZCPBmLN2O0CZimO2LSnMcVZmrtZbONu1
	 9ZYa9lHT3/veqlehhMcOb0sGzdvHrQZgHsHU722l0jCLhs870bkaMljVIHQ27SHu5+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524864;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PyfSSz5rR9bQ85O48Pf/03W+y08tI/ftXiZfOHX8+ig=;
	b=5df9eiZ2g1hzUyFMy/0NcJIK2obP6S+Y4cOYf4BDKBZZGl9Cx065xyeO1Rt9Ev1aXhJJ
	 2Oy+BWH6eNLNvK9/NcNYQEQBU236NoTCSNQbz+RF4b+vY7HtYabQqYeDmxdqHK2ulO2sO
	 YdEENOYSxljv0jVLBMOPCJQtmfPGvYkApZIk0oOnq7X7j0uUKHSyrRgIPC8o3E6MuezR/
	 YvA+K442rvTWmS9x+rvzuiBWNIOkd2I21gK1DNusviCZyE5FGRZXUY1B5jP39eTQ0sHLS
	 gb1qfZpjZB41mLO5Lxxf4XzwYkAi647WzRxDNC+HgI/+PH2/eUkH/c4WPRDrFdm+tsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFL5YmiS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BECA606A896
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFL5YmiS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44711F000C4;
	Thu, 12 Nov 2026 23:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524864;
	bh=PyfSSz5rR9bQ85O48Pf/03W+y08tI/ftXiZfOHX8+ig=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FFL5YmiSWA70Jj4nZvu1/2ifn+Ks4bf0LGxHVTBJhRkSKQrycyAk8/1nMlaOrBRUn
	 eNIoTxw6bWCyZb59zGN9U8ntkhJR3k+oRqn2EPVIOlWZGFG6FNmunQ/r3JaGrCPVxc
	 akuazo7vPEqEeVBPZA6q9TK5OBar7qIrHyGevuIMJddmGbmEMo7JyDjLtS20SUqC6U
	 3xXvDFBG31uQb0p44pf+X3OxOPq/dYQDks6MWvJ/RYKDbQfC5uIpLIQJDbA4QYteGY
	 ozDsenLfV+Yg9QXbIqB0KMbjU/BIyp0u/fAFQrFnVq5dWINSLu9XqaPVl8A4/D6rBG
	 d48g2AcVaehUQ==
Subject:
 Re: [PATCH net-next v5 13/15] ice: represent RSS LUTs as devlink resources
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
Date: Thu, 12 Nov 2026 23:07:42 +0000
Message-ID: <179452486238.2199510.7715963031061550197@kernel.org>
In-Reply-To: <20261110141534.95614-14-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-14-przemyslaw.kitszel@intel.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ice: ABBA deadlock on PF devl_lock and rtnl_mutex in
  ice_rss_lut_pf_occ_set()
- [Medium] Global RSS LUT IDs come from a FW pool per NAC, and the driver
  tracks them in one table on the shared ice_adapter.
- [Medium] ice: missing ICE_FLAG_RSS_ENA checks in devlink RSS LUT paths
- [Low] The commit body describes only the devlink RSS LUT feature.
- [Low] Documentation/networking/devlink/ice.rst says the whole-device
  resources are read-only and that "setting them fails with ``EPERM``".
- [Low] The per-PF devlink resources rss/lut_512 and rss/lut_2048 are
  registered once in ice_probe() via ice_devl_pf_resources_register()…

Pre-existing issues:
- [High] ABBA deadlock between `devlink resource set` on a PF and the
  mqprio channel offload on the same PF.

--

ice: represent RSS LUTs as devlink resources

This commit exposes the E800 global (512 entry) and PF (2048 entry) RSS
LUTs as devlink resources, both on each PF devlink instance and on the
whole-device devlink instance. A PF can switch between its PF LUT and a
global LUT at runtime, which resets its RSS indirection table. The
default assignment is restored after reset.

> diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
> index 792e9f8c846ab..6e34c107b28d2 100644
> --- a/Documentation/networking/devlink/ice.rst
> +++ b/Documentation/networking/devlink/ice.rst
> @@ -485,3 +485,61 @@ and arbitration among them is based on assigned weights.

[ ... ]

> +The resources are registered on two kinds of devlink instances:
> +
> +- The devlink instance of each PF, where ``lut_512`` and ``lut_2048`` are
> +  either 0 or 1. They are changed with ``devlink resource set``, and the
> +  change applies immediately.
> +- The whole device devlink instance, shared by all PFs of the device, which
> +  reports the total usage. Its resources are read-only, setting them fails
> +  with ``EPERM``.

[Severity: Low]
Does userspace always get EPERM here? devlink_nl_resource_set_doit()
checks the size before it calls occ_set:

net/devlink/resource.c:devlink_nl_resource_set_doit() {
    ...
	err = devlink_resource_validate_size(resource, size, info->extack);
	if (err)
		return err;
    ...
}

So a size outside [size_min, size_max] returns EINVAL, and
ice_devl_resource_deny_occ_set() never runs. One example is size 100 on
the whole-device lut_512. Another is size 3 on the PF rss resource.

Could the text drop the errno, or mention EINVAL for out-of-range sizes?

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/devlink/resource.c b/drivers/net/ethernet/intel/ice/devlink/resource.c
> new file mode 100644
> index 0000000000000..de9c13e928fae
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/devlink/resource.c
> @@ -0,0 +1,663 @@

[ ... ]

> +static int ice_devl_res_change(bool take, enum ice_devl_resource_id res_id,
> +			       struct ice_pf *pf, void *owner, int slot,
> +			       struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	/* reset rebuilds the table and the VSIs, see ice_rebuild_rss_luts(),
> +	 * pairs with adapter devl taken in ice_prepare_rss_luts_for_reset()
> +	 */
> +	if (ice_is_reset_in_progress(pf->state)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "reset in progress, try again later");
> +		return -EBUSY;
> +	}

[Severity: Medium]
Is checking only the calling PF's state enough for the global LUT pool?

Global LUT IDs come from a per-NAC FW pool and are tracked in the shared
adapter table. A PF's stale entries are dropped only when its own
service task reaches
ice_prepare_for_reset()->ice_prepare_rss_luts_for_reset().

On a device-wide reset (CORER/GLOBR/EMPR), FW frees the global LUTs of
all PFs at once. Consider this sequence:

PF A owns global LUT N
CORER/GLOBR happens
PF B prepares, rebuilds, and clears its reset bits
PF A's service task has not yet run ice_prepare_rss_luts_for_reset(),
  so owner[N] still points to PF A
devlink resource set on PF B, rss/lut_512 size 1
  ice_devl_res_change()
    ice_is_reset_in_progress(pf->state) is false for PF B
    ice_devl_res_take()
      ice_alloc_rss_global_lut() returns N

ice_devl_res_take() then finds owner[N] still in use:

	if (new_id == ICE_ANY_SLOT) {
		if (WARN_ON(res_id == ICE_RSS_LUT_GLOBAL))
			ice_free_rss_global_lut(&pf->hw, lut_id);

		return -ENOSPC;
	}

Would this hit the WARN_ON and return a spurious -ENOSPC? The v4
changelog says the cleanup moved into ice_prepare_for_reset() to avoid
this WARN. Still, nothing seems to make PF B's allocation wait for
PF A's table cleanup.

[ ... ]

> +static int ice_rss_lut_pf_occ_set(u64 size, enum ice_devl_resource_id res_id,
> +				  struct ice_pf *pf, int slot,
> +				  struct netlink_ext_ack *extack)
> +{
> +	int err;
> +
> +	rtnl_lock();
> +	scoped_guard(ice_adapter_devl, pf->adapter)
> +		err = ice_devl_res_change(size, res_id, pf, pf, slot, extack);
> +	rtnl_unlock();
> +
> +	return err;
> +}

[Severity: High]
ice_setup_tc_mqprio_qdisc() runs from ndo_setup_tc with rtnl held.
A few lines above this check it calls ice_tear_down_devlink_rate_tree(),
which takes devl_lock(priv_to_devlink(pf)). The new occ_set callback
takes these two locks in the opposite order. devlink_nl_pre_doit()
already holds the PF devlink lock when ice_rss_lut_pf_occ_set() calls
rtnl_lock():

CPU1 (devlink resource set ... path rss/lut_2048 size 0)
devlink_nl_pre_doit()
  devl_lock(pf devlink)
ice_rss_lut_pf_occ_set()
  rtnl_lock()                        <- waits for CPU2

CPU2 (tc qdisc add ... mqprio hw 1 mode channel, rtnl held)
ice_setup_tc_mqprio_qdisc()
  ice_tear_down_devlink_rate_tree()
    devl_lock(pf devlink)            <- waits for CPU1

The DCB path has the same order, since ice_dcbnl_setets() reaches
ice_tear_down_devlink_rate_tree() through ice_pf_dcb_cfg() under rtnl.
Lockdep should report a circular dependency here. A real hit would hang
with rtnl_mutex held, which stalls all network configuration.

The ice_rss_lut_is_reassigned() check also comes after
ice_tear_down_devlink_rate_tree(). When the PF LUTs are reassigned, the
request fails with -EOPNOTSUPP, but the devlink rate tree the user
configured has already been destroyed. Could an early check go before
the teardown, keeping the one under the adapter devl that pairs with
set_bit()?

For the lock order, can the occ_set callback avoid taking rtnl? If not,
should the rate tree teardown move out from under rtnl?

[Severity: High]
This is a pre-existing lock ordering issue, but this callback adds an
easy runtime way to hit it. occ_set runs with the PF devlink instance
lock already held by devlink_nl_pre_doit(), and then takes rtnl here.

The mqprio channel offload on the same PF takes the locks in the
opposite order:

CPU1 (devlink resource set ... rss/lut_2048)
devlink_nl_pre_doit()
  devl_lock(pf devlink)
devlink_nl_resource_set_doit()
  ice_rss_lut_pf_occ_set()
    rtnl_lock()                     <- waits for CPU2

CPU2 (tc qdisc add ... mqprio hw 1 mode channel, rtnl held)
ice_setup_tc_mqprio_qdisc()
  ice_tear_down_devlink_rate_tree()
    devl_lock(priv_to_devlink(pf))  <- waits for CPU1

Can this deadlock while holding rtnl_mutex, which would hang all
networking configuration?

The rtnl -> PF devl order in ice_tear_down_devlink_rate_tree() predates
this patch. It already conflicts with probe and with
ice_devlink_reinit_down(). This new path sits right next to the ADQ
interlock: ice_devl_res_change() checks ICE_FLAG_TC_MQPRIO, and mqprio
checks ice_rss_lut_is_reassigned().

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 04633103e3e61..2ea2d36e6d94f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c

[ ... ]

> @@ -3219,6 +3220,7 @@ void ice_set_safe_mode_caps(struct ice_hw *hw)
>  	/* cache some dev_caps values that should be restored after memset */
>  	cached_caps = dev_caps->common_cap;
>  	num_funcs = dev_caps->num_funcs;
> +	nac_topo = dev_caps->nac_topo;
>  
>  	/* unset dev capabilities */
>  	memset(dev_caps, 0, sizeof(*dev_caps));
> @@ -3237,6 +3239,7 @@ void ice_set_safe_mode_caps(struct ice_hw *hw)
>  	ICE_RESTORE_DEV_CAP(nvm_update_pending_orom);
>  	ICE_RESTORE_DEV_CAP(nvm_update_pending_netlist);
>  	dev_caps->num_funcs = num_funcs;
> +	dev_caps->nac_topo = nac_topo;
>  
>  	/* one Tx and one Rx queue per function in safe mode */
>  	dev_caps->common_cap.num_rxq = num_funcs;

[Severity: Low]
This isn't a bug, but the commit message does not mention this change
or the ice_cfg_rdma_fltr() change. Both are explained only in the v5/v4
changelog below the --- line, which won't end up in git history.

Before this patch, safe mode zeroed nac_topo, so ice_is_dual() returned
false and ice_is_primary() returned true. Now, a secondary-NAC PF on a
dual-NAC E825 in safe mode behaves differently in:

- ice_get_phy_lane_number(), which now does lane += ICE_PORTS_PER_QUAD
- ice_get_dest_cgu(), which now picks ice_sbq_dev_cgu_peer
- the ice_is_dual()/ice_is_primary() users in ice_cpi.c and
  ice_ptp_hw.c

Also, ice_cfg_rdma_fltr() now takes a new info argument. It builds the
Q_OPT section from vsi->info instead of the cached VSI context.

Could the commit message describe these behaviour changes, or could they
go in separate patches?

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 6373cd5ac2884..1ed6f31865adf 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c

[ ... ]

> @@ -3873,6 +3876,9 @@ void ice_deinit_pf(struct ice_pf *pf)
>  {
>  	/* note that we unroll also on ice_init_pf() failure here */
>  
> +	/* ice_vsi_decfg() skips it if the last VSI rebuild was NO_INIT */
> +	ice_free_rss_lut_flr(pf);
> +	mutex_destroy(&pf->rss_lut_lock);
>  	mutex_destroy(&pf->lag_mutex);
>  	mutex_destroy(&pf->adev_mutex);
>  	mutex_destroy(&pf->sw_mutex);

[Severity: Low]
ice_probe() registers the PF devlink resources once, through
ice_devl_pf_resources_register(). They are unregistered only in
ice_deinit_devlink() at remove. Meanwhile, ice_devlink_reinit_down()
reaches ice_deinit_pf() and ice_deinit_hw() during a devlink reload.

ice_devlink_reinit_up() can then fail in ice_init_hw(), ice_init_dev(),
ice_init_pf() or ice_vsi_cfg(). In that case the devlink core only sets
reload_failed and still accepts DEVLINK_CMD_RESOURCE_SET. A later
"devlink resource set ... path rss/lut_2048 size 1" would do:

ice_rss_lut_pf_occ_set()
  ice_devl_res_change()          state is ICE_HAS_NO_LUT, table cleared
    ice_devl_res_take()          succeeds
    ice_maybe_change_rss_lut()
      mutex_lock(&pf->rss_lut_lock)   on the destroyed mutex
      ice_aq_set_rss_lut()            on torn-down control queues

lut_512 goes the same way through ice_alloc_rss_global_lut().

The AQ call should fail and the take is undone. Should these callbacks
still check that the PF is initialized? Alternatively, could the
resources follow the init_pf/deinit_pf lifetime instead of
probe/remove?

[ ... ]

> @@ -0,0 +1,663 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026, Intel Corporation. */
> +
> +#include "resource.h"
> +#include "ice_adapter.h"
> +#include "ice.h"
> +#include "ice_lib.h"
> +
> +#define ICE_NUM_GLOBAL_LUTS	16
> +#define ICE_ANY_SLOT		-1
> +
> +/* each NAC numbers its PFs from 0, secondary NAC ones go after primary ones */
> +static int ice_devl_pf_id(struct ice_pf *pf)
> +{
> +	struct ice_hw *hw = &pf->hw;
> +
> +	if (ice_is_primary(hw))
> +		return hw->logical_pf_id;
> +
> +	return hw->logical_pf_id + ICE_PORTS_PER_QUAD;
> +}
> +
> +/* each NAC has its own global LUTs, with IDs given by its FW */
> +static struct ice_devl_resource *
> +ice_devl_res_tbl(struct ice_pf *pf, enum ice_devl_resource_id res_id)
> +{
> +	if (res_id == ICE_RSS_LUT_GLOBAL && !ice_is_primary(&pf->hw))
> +		return &pf->adapter->sec_nac_global_luts;
> +
> +	return &pf->adapter->resources[res_id];
> +}
> +
> +static u32 ice_devl_res_cnt(const struct ice_devl_resource *res)
> +{
> +	u32 sum = 0;
> +
> +	for (int i = 0; i < ARRAY_SIZE(res->owner); i++)
> +		sum += res->owner[i] != NULL;
> +
> +	return sum;
> +}
> +
> +static int ice_devl_res_take(struct ice_pf *pf,
> +			     enum ice_devl_resource_id res_id, int slot,
> +			     void *owner)
> +{
> +	struct ice_devl_resource *res = ice_devl_res_tbl(pf, res_id);
> +	int beg, end, new_id = ICE_ANY_SLOT;
> +	u16 lut_id;
> +
> +	if (res_id == ICE_RSS_LUT_GLOBAL) {
> +		int err;
> +
> +		WARN_ON_ONCE(slot != ICE_ANY_SLOT);
> +
> +		err = ice_alloc_rss_global_lut(&pf->hw, &lut_id);
> +		if (err)
> +			return err;
> +
> +		slot = lut_id;
> +	}
> +
> +	end = slot == ICE_ANY_SLOT ? ARRAY_SIZE(res->owner) : slot + 1;
> +	beg = slot == ICE_ANY_SLOT ? 0 : slot;
> +	for (int id = beg; id < end; id++) {
> +		if (!res->owner[id]) {
> +			new_id = id;
> +			break;
> +		}
> +	}
> +	if (new_id == ICE_ANY_SLOT) {
> +		if (WARN_ON(res_id == ICE_RSS_LUT_GLOBAL))
> +			ice_free_rss_global_lut(&pf->hw, lut_id);
> +
> +		return -ENOSPC;
> +	}
> +
> +	res->owner[new_id] = owner;
> +	res->pf_id[new_id] = ice_devl_pf_id(pf);
> +	return new_id;
> +}
> +
> +static int ice_devl_res_free(struct ice_pf *pf,
> +			     enum ice_devl_resource_id res_id, void *owner)
> +{
> +	struct ice_devl_resource *res = ice_devl_res_tbl(pf, res_id);
> +	int err = 0, id_to_free = ICE_ANY_SLOT;
> +
> +	for (int i = 0; i < ARRAY_SIZE(res->owner); i++) {
> +		if (res->owner[i] == owner) {
> +			id_to_free = i;
> +			break;
> +		}
> +	}
> +	if (id_to_free == ICE_ANY_SLOT)
> +		return 0;
> +
> +	if (res_id == ICE_RSS_LUT_GLOBAL) {
> +		err = ice_free_rss_global_lut(&pf->hw, id_to_free);
> +		if (err)
> +			dev_warn(ice_pf_to_dev(pf), "failed to free global RSS LUT %d, leaked until PF reset: %d\n",
> +				 id_to_free, err);
> +	}
> +
> +	res->owner[id_to_free] = NULL;
> +	return err;
> +}
> +
> +static void ice_free_rss_lut_flr_locked(struct ice_pf *pf)
> +{
> +	struct ice_devl_resource *res, *resources = pf->adapter->resources;
> +	int pf_id = ice_devl_pf_id(pf);
> +
> +	devl_assert_locked(pf->adapter->devlink);
> +	resources[ICE_RSS_LUT_PF].owner[pf_id] = NULL;
> +
> +	res = ice_devl_res_tbl(pf, ICE_RSS_LUT_GLOBAL);
> +	for (int i = 0; i < ARRAY_SIZE(res->owner); i++) {
> +		/* On FLR/PFR resources assigned to PF are cleared by FW,
> +		 * reflect that in the SW table.
> +		 * VFs on given PF must be de-programmed too.
> +		 */
> +		if (res->pf_id[i] == pf_id)
> +			res->owner[i] = NULL;
> +	}
> +}
> +
> +void ice_free_rss_lut_flr(struct ice_pf *pf)
> +{
> +	scoped_guard(ice_adapter_devl, pf->adapter)
> +		ice_free_rss_lut_flr_locked(pf);
> +}
> +
> +static int ice_devl_res_owned_idx(struct ice_pf *pf,
> +				  enum ice_devl_resource_id res_id, void *owner)
> +{
> +	const struct ice_devl_resource *res = ice_devl_res_tbl(pf, res_id);
> +
> +	for (int i = 0; i < ARRAY_SIZE(res->owner); i++) {
> +		if (res->owner[i] == owner)
> +			return i;
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static bool ice_is_devl_res_owned_by(struct ice_pf *pf,
> +				     enum ice_devl_resource_id res_id,
> +				     void *owner)
> +{
> +	return ice_devl_res_owned_idx(pf, res_id, owner) >= 0;
> +}
> +
> +static u64 ice_rss_lut_whole_dev_occ_get_global(void *priv)
> +{
> +	struct ice_adapter *adapter = priv;
> +
> +	return ice_devl_res_cnt(&adapter->resources[ICE_RSS_LUT_GLOBAL]) +
> +	       ice_devl_res_cnt(&adapter->sec_nac_global_luts);
> +}
> +
> +static u64 ice_rss_lut_whole_dev_occ_get_pf(void *priv)
> +{
> +	struct ice_adapter *adapter = priv;
> +
> +	return ice_devl_res_cnt(&adapter->resources[ICE_RSS_LUT_PF]);
> +}
> +
> +static u64 ice_rss_lut_whole_dev_occ_get_both(void *priv)
> +{
> +	return ice_rss_lut_whole_dev_occ_get_global(priv) +
> +	       ice_rss_lut_whole_dev_occ_get_pf(priv);
> +}
> +
> +static u64 ice_rss_lut_pf_occ_get_global(void *priv)
> +{
> +	struct ice_pf *pf = priv;
> +
> +	scoped_guard(ice_adapter_devl, pf->adapter)
> +		return ice_is_devl_res_owned_by(pf, ICE_RSS_LUT_GLOBAL, pf);
> +}
> +
> +static u64 ice_rss_lut_pf_occ_get_pf(void *priv)
> +{
> +	struct ice_pf *pf = priv;
> +
> +	scoped_guard(ice_adapter_devl, pf->adapter)
> +		return ice_is_devl_res_owned_by(pf, ICE_RSS_LUT_PF, pf);
> +}
> +
> +static u64 ice_rss_lut_pf_occ_get_both(void *priv)
> +{
> +	struct ice_pf *pf = priv;
> +
> +	scoped_guard(ice_adapter_devl, pf->adapter)
> +		return ice_is_devl_res_owned_by(pf, ICE_RSS_LUT_PF, pf) +
> +		       ice_is_devl_res_owned_by(pf, ICE_RSS_LUT_GLOBAL, pf);
> +}
> +
> +static int ice_devl_resource_deny_occ_set(u64 size,
> +					  struct netlink_ext_ack *extack,
> +					  void *priv)
> +{
> +	NL_SET_ERR_MSG_MOD(extack,
> +		"can not change directly, parent/aggregate resource just adds up children data");
> +	return -EPERM;
> +}
> +
> +enum ice_rss_lut_resource_state {
> +	ICE_HAS_NO_LUT = 0,
> +	ICE_HAS_GLOBAL_LUT = BIT(ICE_RSS_LUT_GLOBAL),
> +	ICE_HAS_PF_LUT = BIT(ICE_RSS_LUT_PF),
> +	ICE_HAS_BOTH_LUTS = ICE_HAS_GLOBAL_LUT | ICE_HAS_PF_LUT,
> +};
> +
> +/**
> + * ice_rss_lut_resource_state - compute opaque resource state for given owner
> + * @pf: the PF the @owner is on
> + * @owner: the entity to compute state of resources for
> + *
> + * Return: computed current state of the RSS resources the @owner has.
> + */
> +static enum ice_rss_lut_resource_state
> +ice_rss_lut_resource_state(struct ice_pf *pf, void *owner)
> +{
> +	enum ice_rss_lut_resource_state ret = ICE_HAS_NO_LUT;
> +
> +	if (ice_is_devl_res_owned_by(pf, ICE_RSS_LUT_GLOBAL, owner))
> +		ret |= ICE_HAS_GLOBAL_LUT;
> +	if (ice_is_devl_res_owned_by(pf, ICE_RSS_LUT_PF, owner))
> +		ret |= ICE_HAS_PF_LUT;
> +
> +	return ret;
> +}
> +
> +static int ice_maybe_change_rss_lut(struct ice_pf *pf, void *owner,
> +				    enum ice_rss_lut_resource_state old,
> +				    enum ice_rss_lut_resource_state new,
> +				    struct netlink_ext_ack *extack)
> +{
> +	struct ice_aq_get_set_rss_lut_params params = {};
> +	struct ice_hw *hw = &pf->hw;
> +	enum ice_lut_type lut_type;
> +	int err, lut_size, lut_id;
> +	struct ice_vsi *vsi;
> +	u8 *lut;
> +
> +	if (old & new & ICE_HAS_PF_LUT)
> +		return 0;
> +
> +	if (new & ICE_HAS_PF_LUT) {
> +		lut_type = ICE_LUT_PF;
> +	} else if (new & ICE_HAS_GLOBAL_LUT) {
> +		lut_id = ice_devl_res_owned_idx(pf, ICE_RSS_LUT_GLOBAL, owner);
> +		if (lut_id < 0)
> +			return lut_id;
> +
> +		lut_type = ICE_LUT_GLOBAL;
> +		params.global_lut_id = lut_id;
> +	} else {
> +		lut_type = ICE_LUT_VSI;
> +		if (owner == pf) {
> +			NL_SET_ERR_MSG_FMT(extack, "cannot change PF to use LUT_VSI (sized 64)");
> +			return -EDOM;
> +		}
> +	}
> +
> +	if (pf == owner) {
> +		vsi = ice_get_main_vsi(pf);
> +	} else {
> +		return -EOPNOTSUPP;
> +	}
> +
> +	lut_size = ice_lut_type_to_size(lut_type);
> +	lut = kzalloc(lut_size, GFP_KERNEL);
> +	if (!lut)
> +		return -ENOMEM;
> +	params.lut = lut;
> +	params.lut_size = lut_size;
> +	params.lut_type = lut_type;
> +	params.vsi_handle = vsi->idx;
> +	mutex_lock(&pf->rss_lut_lock);
> +	/* PF with RXHASH disabled keeps its LUT zeroed */
> +	if (!vsi->netdev || vsi->netdev->features & NETIF_F_RXHASH)
> +		ice_fill_rss_lut(lut, lut_size, vsi->rss_size);
> +	err = ice_aq_set_rss_lut(hw, &params);
> +	if (err) {
> +		NL_SET_ERR_MSG_FMT(extack, "AQ failed: %s", libie_aq_str(hw->adminq.sq_last_status));
> +		goto out;
> +	}
> +
> +	err = ice_vsi_update_rss_lut(vsi, lut_type, params.global_lut_id);
> +	if (err)
> +		goto out;
> +
> +	devm_kfree(ice_pf_to_dev(pf), vsi->rss_lut_user);
> +	vsi->rss_lut_user = NULL;
> +	if (lut_type == ICE_LUT_GLOBAL)
> +		vsi->global_lut_id = params.global_lut_id;
> +	vsi->rss_table_size = lut_size;
> +	vsi->rss_lut_type = lut_type;
> +out:
> +	mutex_unlock(&pf->rss_lut_lock);
> +	kfree(lut);
> +	/* the user RSS LUT was dropped above, rtnl is held for the PF */
> +	if (!err && vsi->netdev && netif_is_rxfh_configured(vsi->netdev))
> +		ethtool_rxfh_indir_lost(vsi->netdev);
> +	return err;
> +}
> +
> +static int ice_devl_res_change(bool take, enum ice_devl_resource_id res_id,
> +			       struct ice_pf *pf, void *owner, int slot,
> +			       struct netlink_ext_ack *extack)
> +{
> +	enum ice_rss_lut_resource_state old, new, change;
> +	int err, rel_err;
> +
> +	change = BIT(res_id);
> +	old = ice_rss_lut_resource_state(pf, owner);
> +	new = old;
> +	if (take)
> +		new |= change;
> +	else
> +		new &= ~change;
> +	if (new == old)
> +		return 0;
> +
> +	/* reset rebuilds the table and the VSIs, see ice_rebuild_rss_luts(),
> +	 * pairs with adapter devl taken in ice_prepare_rss_luts_for_reset()
> +	 */
> +	if (ice_is_reset_in_progress(pf->state)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "reset in progress, try again later");
> +		return -EBUSY;
> +	}
> +
> +	/* pairs with set_bit() under adapter devl in ice_setup_tc_mqprio_qdisc() */
> +	if (test_bit(ICE_FLAG_TC_MQPRIO, pf->flags)) {
> +		NL_SET_ERR_MSG_MOD(extack, "ADQ configured, can't change RSS LUTs");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (pf == owner && !take && old != ICE_HAS_BOTH_LUTS) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +			"at least one of 512+ sized LUTs must be assigned to PF device at all times");
> +		return -EDOM;
> +	}
> +
> +	if (take) {
> +		int slot_id;
> +
> +		slot_id = ice_devl_res_take(pf, res_id, slot, owner);
> +		if (slot_id < 0)
> +			return slot_id;
> +	}
> +
> +	err = ice_maybe_change_rss_lut(pf, owner, old, new, extack);
> +	if (err) {
> +		NL_SET_ERR_MSG_WEAK_MOD(extack, "failed to change RSS LUT");
> +		if (!take)
> +			/* We have not released the resource, so we don't free
> +			 * it, to avoid freeing LUT still in use or assigning it
> +			 * to other entity.
> +			 */
> +			return err;
> +
> +		goto undo_res_take;
> +	}
> +
> +	if (!take) {
> +undo_res_take:
> +		rel_err = ice_devl_res_free(pf, res_id, owner);
> +		if (rel_err) {
> +			NL_SET_ERR_MSG_FMT(extack,
> +				"could not free resource, err: %d", rel_err);
> +			if (!err)
> +				err = rel_err;
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +/* ethtool core sizes RSS buffers by rss_table_size under rtnl, and the new
> + * LUT is filled based on NETIF_F_RXHASH, which is also changed under rtnl
> + */
> +static int ice_rss_lut_pf_occ_set(u64 size, enum ice_devl_resource_id res_id,
> +				  struct ice_pf *pf, int slot,
> +				  struct netlink_ext_ack *extack)
> +{
> +	int err;
> +
> +	rtnl_lock();
> +	scoped_guard(ice_adapter_devl, pf->adapter)
> +		err = ice_devl_res_change(size, res_id, pf, pf, slot, extack);
> +	rtnl_unlock();
> +
> +	return err;
> +}
> +
> +static int ice_rss_lut_pf_occ_set_pf(u64 size, struct netlink_ext_ack *extack,
> +				     void *priv)
> +{
> +	struct ice_pf *pf = priv;
> +
> +	return ice_rss_lut_pf_occ_set(size, ICE_RSS_LUT_PF, pf,
> +				      ice_devl_pf_id(pf), extack);
> +}
> +
> +static int ice_rss_lut_pf_occ_set_global(u64 size,
> +					 struct netlink_ext_ack *extack,
> +					 void *priv)
> +{
> +	return ice_rss_lut_pf_occ_set(size, ICE_RSS_LUT_GLOBAL, priv,
> +				      ICE_ANY_SLOT, extack);
> +}
> +
> +/**
> + * ice_rss_lut_is_reassigned - check if RSS LUTs of PF are in non-default state
> + * @pf: the PF to check
> + *
> + * Return: true if @pf lost its PF LUT, or @pf or any of its VFs owns a
> + * global LUT. Caller must hold the adapter devlink lock.
> + */
> +bool ice_rss_lut_is_reassigned(struct ice_pf *pf)
> +{
> +	struct ice_devl_resource *res, *resources = pf->adapter->resources;
> +	int pf_id = ice_devl_pf_id(pf);
> +
> +	devl_assert_locked(pf->adapter->devlink);
> +	if (resources[ICE_RSS_LUT_PF].owner[pf_id] != pf)
> +		return true;
> +
> +	res = ice_devl_res_tbl(pf, ICE_RSS_LUT_GLOBAL);
> +	for (int i = 0; i < ARRAY_SIZE(res->owner); i++)
> +		if (res->owner[i] && res->pf_id[i] == pf_id)
> +			return true;
> +
> +	return false;
> +}
> +
> +/**
> + * ice_take_rss_lut_pf - allocate PF RSS LUT for PF
> + * @pf: the PF device that PF LUT is physically on, and to allocate it for
> + *
> + * Acquire PF RSS LUT for the caller.
> + *
> + * Return: 0 on success, negative on error.
> + */
> +int ice_take_rss_lut_pf(struct ice_pf *pf)
> +{
> +	int ret, pf_id = ice_devl_pf_id(pf);
> +
> +	scoped_guard(ice_adapter_devl, pf->adapter) {
> +		ret = ice_devl_res_take(pf, ICE_RSS_LUT_PF, pf_id, pf);
> +		if (ret >= 0)
> +			return 0;
> +
> +		return ret;
> +	}
> +}
> +
> +/**
> + * ice_release_rss_lut_pf - release PF RSS LUT of PF
> + * @pf: the PF device that PF LUT is physically on, and to release it from
> + *
> + * Release PF RSS LUT for the caller.
> + *
> + * No need to call this function in normal operation, provided for error path.
> + */
> +void ice_release_rss_lut_pf(struct ice_pf *pf)
> +{
> +	scoped_guard(ice_adapter_devl, pf->adapter)
> +		ice_devl_res_free(pf, ICE_RSS_LUT_PF, pf);
> +}
> +
> +/**
> + * ice_prepare_rss_luts_for_reset - drop global RSS LUTs of PF from the table
> + * @pf: the PF that is about to be reset
> + *
> + * FW frees global RSS LUTs of the PF and its VFs on reset, and other PFs may
> + * get them from FW before ice_rebuild_rss_luts() of @pf, so drop them from
> + * the table now. Taking the lock also waits for RSS LUT changes that checked
> + * for reset just before it was requested.
> + */
> +void ice_prepare_rss_luts_for_reset(struct ice_pf *pf)
> +{
> +	int pf_id = ice_devl_pf_id(pf);
> +	struct ice_devl_resource *res;
> +
> +	scoped_guard(ice_adapter_devl, pf->adapter) {
> +		if (ice_rss_lut_is_reassigned(pf))
> +			dev_info(ice_pf_to_dev(pf),
> +				 "reset restores the default RSS LUT assignment\n");
> +
> +		res = ice_devl_res_tbl(pf, ICE_RSS_LUT_GLOBAL);
> +		for (int i = 0; i < ARRAY_SIZE(res->owner); i++)
> +			if (res->pf_id[i] == pf_id)
> +				res->owner[i] = NULL;
> +	}
> +}
> +
> +/**
> + * ice_rebuild_rss_lut_pf - restore default RSS LUT assignment after reset
> + * @pf: the PF that was reset
> + *
> + * FW drops RSS LUT assignments of the PF on reset, so give the PF LUT back to
> + * the PF, and make the PF VSI use it.
> + * Must be called before the VSIs are rebuilt.
> + *
> + * Return: 0 on success, negative on error.
> + */
> +static int ice_rebuild_rss_lut_pf(struct ice_pf *pf)
> +{
> +	struct ice_vsi *vsi = ice_get_main_vsi(pf);
> +	struct ice_adapter *adapter = pf->adapter;
> +	int err;
> +
> +	devl_lock(adapter->devlink);
> +	ice_free_rss_lut_flr_locked(pf);
> +	err = ice_devl_res_take(pf, ICE_RSS_LUT_PF, ice_devl_pf_id(pf), pf);
> +	if (err < 0)
> +		goto unlock;
> +
> +	mutex_lock(&pf->rss_lut_lock);
> +	if (vsi && vsi->rss_lut_type != ICE_LUT_PF) {
> +		devm_kfree(ice_pf_to_dev(pf), vsi->rss_lut_user);
> +		vsi->rss_lut_user = NULL;
> +		vsi->rss_table_size = ice_lut_type_to_size(ICE_LUT_PF);
> +		vsi->rss_lut_type = ICE_LUT_PF;
> +	}
> +	mutex_unlock(&pf->rss_lut_lock);
> +	err = 0;
> +unlock:
> +	devl_unlock(adapter->devlink);
> +
> +	return err;
> +}
> +
> +/**
> + * ice_rebuild_rss_luts - restore default RSS LUT assignment after reset
> + * @pf: the PF that was reset
> + *
> + * Wrapper of ice_rebuild_rss_lut_pf() that also tells the ethtool core when
> + * the user RSS LUT was dropped. Must be called without rtnl held.
> + *
> + * Return: 0 on success, negative on error.
> + */
> +int ice_rebuild_rss_luts(struct ice_pf *pf)
> +{
> +	struct ice_vsi *vsi = ice_get_main_vsi(pf);
> +	int err;
> +
> +	/* ethtool core sizes RSS buffers by rss_table_size under rtnl */
> +	rtnl_lock();
> +	err = ice_rebuild_rss_lut_pf(pf);
> +	/* the user RSS LUT is dropped when the PF goes back to the PF LUT */
> +	if (vsi && vsi->netdev && !vsi->rss_lut_user &&
> +	    netif_is_rxfh_configured(vsi->netdev))
> +		ethtool_rxfh_indir_lost(vsi->netdev);
> +	rtnl_unlock();
> +
> +	return err;
> +}
> +
> +static void ice_devl_res_register(struct devlink *devlink,
> +				  struct ice_devl_resource *resources,
> +				  void *occ_priv)
> +{
> +	struct devlink_resource_size_params size_params;
> +
> +	devlink_resource_size_params_init(&size_params, 0, 0, 1,
> +					  DEVLINK_RESOURCE_UNIT_ENTRY);
> +	for (int i = 0; i < ICE_DEVL_RESOURCES_COUNT; i++) {
> +		struct ice_devl_resource *res = &resources[i];
> +		int err, resource_id = i;
> +
> +		if (!res->name)
> +			continue; /* skip empty entries in config table */
> +
> +		size_params.size_max = res->max_size;
> +		err = devl_resource_register(devlink, res->name,
> +					     res->start_size, resource_id,
> +					     res->parent_id, &size_params);
> +		if (WARN_ONCE(err, "not all resource handlers registered, err: %d, resname: %s\n",
> +			      err, res->name))
> +			break;
> +
> +		devl_resource_occ_set_get_register(devlink, resource_id,
> +						   res->set, res->get, occ_priv);
> +	}
> +}
> +
> +void ice_devl_whole_dev_resources_register(const struct ice_hw *hw,
> +					   struct ice_adapter *adapter)
> +{
> +	struct devlink *devlink = adapter->devlink;
> +	int global_lut_cnt = ICE_NUM_GLOBAL_LUTS;
> +	int pf_lut_cnt = hw->dev_caps.num_funcs;
> +
> +	devl_assert_locked(devlink);
> +	/* see ice_devl_pf_id() and ice_devl_res_tbl() */
> +	if (ice_is_dual(hw)) {
> +		global_lut_cnt = 2 * ICE_NUM_GLOBAL_LUTS;
> +		pf_lut_cnt = 2 * ICE_PORTS_PER_QUAD;
> +	}
> +
> +	adapter->resources[ICE_RSS_LUT_GLOBAL] = (struct ice_devl_resource) {
> +		.name = "lut_512",
> +		.parent_id = ICE_RSS_LUT_BOTH,
> +		.max_size = global_lut_cnt,
> +		.get = ice_rss_lut_whole_dev_occ_get_global,
> +		.set = ice_devl_resource_deny_occ_set,
> +	};
> +	adapter->resources[ICE_RSS_LUT_PF] = (struct ice_devl_resource) {
> +		.name = "lut_2048",
> +		.parent_id = ICE_RSS_LUT_BOTH,
> +		.max_size = pf_lut_cnt,
> +		.get = ice_rss_lut_whole_dev_occ_get_pf,
> +		.set = ice_devl_resource_deny_occ_set,
> +	};
> +	adapter->resources[ICE_RSS_LUT_BOTH] = (struct ice_devl_resource) {
> +		.name = "rss",
> +		.parent_id = ICE_TOP_RESOURCE,
> +		.max_size = pf_lut_cnt + global_lut_cnt,
> +		.get = ice_rss_lut_whole_dev_occ_get_both,
> +		.set = ice_devl_resource_deny_occ_set,
> +	};
> +
> +	ice_devl_res_register(devlink, adapter->resources, adapter);
> +}
> +
> +void ice_devl_pf_resources_register(struct ice_pf *pf)
> +{
> +	struct ice_devl_resource pf_resources[ICE_DEVL_RESOURCES_COUNT] = {
> +		[ICE_RSS_LUT_GLOBAL] = {
> +			.name = "lut_512",
> +			.parent_id = ICE_RSS_LUT_BOTH,
> +			.max_size = 1,
> +			.get = ice_rss_lut_pf_occ_get_global,
> +			.set = ice_rss_lut_pf_occ_set_global,
> +		},
> +		[ICE_RSS_LUT_PF] = {
> +			.name = "lut_2048",
> +			.parent_id = ICE_RSS_LUT_BOTH,
> +			.max_size = 1,
> +			.get = ice_rss_lut_pf_occ_get_pf,
> +			.set = ice_rss_lut_pf_occ_set_pf,
> +			.start_size = 1,
> +		},
> +		[ICE_RSS_LUT_BOTH] = {
> +			.name = "rss",
> +			.parent_id = ICE_TOP_RESOURCE,
> +			.max_size = 2,
> +			.get = ice_rss_lut_pf_occ_get_both,
> +			.set = ice_devl_resource_deny_occ_set,
> +		},
> +	};
> +	struct devlink *devlink = priv_to_devlink(pf);
> +
> +	devl_assert_locked(devlink);
> +	ice_devl_res_register(devlink, pf_resources, pf);
> +}

[Severity: Medium]
What happens here when ICE_FLAG_RSS_ENA is clear? That is the case in
safe mode, since ice_set_safe_mode_caps() zeroes
func_caps->common_cap.rss_table_size and ice_set_pf_caps() then leaves
the flag unset.

In that mode ice_vsi_set_dflt_rss_lut_type() returns early. The PF VSI
keeps rss_table_size == 0 and rss_lut_type == ICE_LUT_VSI (0). The VSI
RSS context and the LUT/key setup in ice_vsi_cfg_def() are skipped for
the same reason.

On the next PFR/CORER/GLOBR, ice_rebuild() runs:

ice_rebuild_rss_luts()
  ice_rebuild_rss_lut_pf()
    vsi->rss_lut_type != ICE_LUT_PF     true, it is ICE_LUT_VSI
    vsi->rss_table_size = 2048
    vsi->rss_lut_type = ICE_LUT_PF

The following VSI rebuild does not undo this, because
ice_vsi_set_dflt_rss_lut_type() bails out on the same flag test. After
any reset, a PF without RSS claims a 2048 entry PF LUT that was never
programmed. Later users of rss_table_size and rss_lut_type would act
on that state.

The devlink side has the same gap. ice_devl_pf_resources_register()
also runs in safe mode, and ice_devl_res_change() never tests
ICE_FLAG_RSS_ENA. Setting rss/lut_512 to 1 allocates a global LUT from
FW through ice_alloc_rss_global_lut(). Then setting rss/lut_2048 to 0
reaches ice_maybe_change_rss_lut(), which calls ice_aq_set_rss_lut()
and ice_vsi_update_rss_lut() on a VSI whose RSS context was never set
up.

Should ice_devl_res_change() reject the change when RSS is not
enabled? Should ice_rebuild_rss_lut_pf() also leave the VSI fields
alone in that case? Or should the PF resources not be registered at
all when RSS is disabled?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110141534.95614-1-przemyslaw.kitszel%40intel.com
