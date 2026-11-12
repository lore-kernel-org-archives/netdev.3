Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524860;
	b=LPG3CD8ZMPqj0ZW3/Zyxucmd6y3yNJdnjPlI0ctyjEySfP6x5KBx3jgVmwpwetnkynuk
	 iPXmuQgwCtoayoH4KV+WTz0u7FTfxaTq5YF8kZc89kvEQ0N1W7mHku1oR9ctq5rzTr5mA
	 eafJkTmsrthAxVFpR+BzUrjyETggin+gvLbSsChipUxLT7/JPQd+b2Bt3cBSG06c7mI0d
	 iZcbY7HPb3sbay+3ElZch3fc+rZLMHfmJnMhzmED6GEHWSqzvyMwq2GWnIEK1i7N8JPaN
	 Yja6Q+RMgeGF8ofURMsT1bWQ4YVWXWrQ9ZMmSdzGlyTLo2GpWhgygwX/ROurrm2mmUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524860;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QMhzklzS2UP3j/3kok/P+osDm7Y1IYWtshgOctJd328=;
	b=B37LGJ74fSTQKZT5mhp2nINdsE/RU9aHf5yHGWt7SeMZrUGyeb7aUhTk8tmmY3zavwr+
	 46OfYbmTFoWEU0izkJxWx0RT7Idv9AmIIORLcCYeel34ytYtkUknUMPNQxncbDSwZ7jmV
	 GUpxqtx9Es3qreRZHNS9sm8ihGHPl9DxVGguBZFzcp0mPa6n/DGekkkv2Nzc85gBSBfta
	 9bTzxttZObsARaZiSu/niQq34l6BknX9ZJ22saWXQzqVSnHJI2u7xy5rKCxGXeRH5nsSZ
	 Z1M8MWAPcOErrwEVmPoK05FsEqcVYY1aEBe+jTf8cAX81jxdkPvIViVDVhTud8Eihuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWVbzQFV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A2606A32A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWVbzQFV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E348A1F000C6;
	Thu, 12 Nov 2026 23:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524860;
	bh=QMhzklzS2UP3j/3kok/P+osDm7Y1IYWtshgOctJd328=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HWVbzQFVlmpTF6Ynow0MKGjF/UeGo8FCXknugMSue9RBG5C7j4cEWLt52+WCWuS20
	 mMMopm6vCeuBF1hFmt5tH0K2ByWUz5Dk20V6Eypl1+742K4G9G8+qCp27bSGGn+AM8
	 vIucuigbqqezksvb/YnBtBIk7QNj5PW3fX/8AYDXMMzIwPqQZyq8SoF/78cfHPG3lc
	 fYUHcavDkIlIUPwE0RKWVjSAq/cZd18Wuxl5z7FPGveRiLg7lVICUEsv5OptnY1V8L
	 HZoHFVXo3VsD1KpMC32T1lSl2jsW6ZzDad40D2V0Uj1Je3KQ5nubRVbllg5hC/Fq27
	 U3qI+JgvIqSkA==
Subject: Re: [PATCH net-next v5 10/15] iavf: use new opcodes to request more
 than 16 queues
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
Date: Thu, 12 Nov 2026 23:07:38 +0000
Message-ID: <179452485851.2199510.7573255752786362662@kernel.org>
In-Reply-To: <20261110141534.95614-11-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-11-przemyslaw.kitszel@intel.com>
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

Thank you for your contribution! Sashiko AI review found 14 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 7 · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Divide-by-zero in iavf_fill_rss_lut(), reached from the new RSS
  reallocation path in iavf_parse_vf_resource_msg() while…
- [Medium] The commit message says that 'when the RSS key or LUT size
  changes across a reset, reallocate both and fill them again'.
- [Medium] iavf_get_rx_ring_count(), iavf_max_channels() (called from
  iavf_get_channels()/iavf_set_channels()) and iavf_set_rxfh() now…
- [Medium] In LARGE mode, iavf_set_channels() only stores
  num_req_queues_next, schedules IAVF_FLAG_AQ_REQUEST_QUEUES and returns…
- [Medium] qregion_width comes from the PF as a u16.
- [Medium] This patch quietly changes iavf_validate_num_queues() to cap a
  PF without VIRTCHNL_VF_LARGE_NUM_QPAIRS at IAVF_MAX_VSI_QP (16).
- [Medium] The commit message does not describe the init-time automatic
  queue request.
- [Medium] iavf: IAVF_FLAG_REINIT_MSIX_NEEDED not cleared in
  iavf_reset_step() when down
- [Low] Fixes for existing bugs that affect every PF are bundled into the
  feature commit 'iavf: use new opcodes to request more than 16 queues'…
- [Low] The ethtool channel limits disagree in LARGE mode.
- [Low] A queued-but-unsent (or in-flight) LARGE-mode queue request
  cannot be cancelled.
- [Low] The runtime handler for the VIRTCHNL_OP_GET_MAX_RSS_QREGION reply
  in iavf_virtchnl_completion() copies sizeof(adapter->max_rss_qregion)…
- [Low] iavf_send_max_rss_qregion() ignores the return value of
  iavf_send_pf_msg() and always returns 0 once LARGE is negotiated.
- [Low] The virtchnl.h ABI comment for VIRTCHNL_OP_ENABLE_QUEUES_V2 /
  VIRTCHNL_OP_DISABLE_QUEUES_V2 says 'VF sends virtchnl_ena_dis_queues…

--

iavf: use new opcodes to request more than 16 queues

This commit adds the VIRTCHNL_VF_LARGE_NUM_QPAIRS capability and the
GET_MAX_RSS_QREGION, ENABLE/DISABLE_QUEUES_V2 and MAP_QUEUE_VECTOR
opcodes, so the VF can use more than 16 queues. In LARGE mode, ethtool -L
becomes an asynchronous VIRTCHNL_OP_REQUEST_QUEUES that the watchdog sends.
For every PF, it also changes iavf_parse_vf_resource_msg() to reinit when
the PF lowers the queue count or changes the RSS key/LUT size, and it
resets aq_wait_count on recovery.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index e7cf12eaa2689..2a5ecee49b717 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -1643,6 +1643,11 @@ static int iavf_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
>  static u32 iavf_get_rx_ring_count(struct net_device *netdev)
>  {
>  	struct iavf_adapter *adapter = netdev_priv(netdev);
> +	u16 width = adapter->max_rss_qregion.qregion_width;
> +
> +	/* RSS can use only the PF RSS region, see iavf_fill_rss_lut() */
> +	if (LARGE_NUM_QPAIRS_SUPPORT(adapter) && width)
> +		return min_t(u32, adapter->num_active_queues, BIT(width));

[Severity: Medium]
Can adapter->vf_res be NULL here? LARGE_NUM_QPAIRS_SUPPORT() dereferences
adapter->vf_res->vf_cap_flags. Before this patch, iavf_get_rx_ring_count()
only read num_active_queues.

After a failed reset, iavf_disable_vf() leaves the netdev registered, and
the watchdog re-inits through __IAVF_STARTUP. Suppose
iavf_init_get_resources() then takes its error path:

err_alloc:
	kfree(adapter->vf_res);
	adapter->vf_res = NULL;
	adapter->vsi_res = NULL;
err:
	iavf_change_state(adapter, __IAVF_INIT_FAILED);

The adapter then stays in __IAVF_INIT_FAILED for about a second between
retries. This patch adds two new ways into err_alloc: the -ENOMEM return
from the RSS reallocation, and a send failure from the init-time
iavf_request_queues().

Would an unprivileged ethtool -x or ethtool -l in that window oops here?
iavf_max_channels() below has the same problem. It reads vf_res before
falling back to vsi_res, and vsi_res is now cleared as well.

>  
>  	return adapter->num_active_queues;
>  }
> @@ -1683,6 +1688,18 @@ static int iavf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
>  
>  	return ret;
>  }
> +
> +/* in LARGE mode PF gives us up to its RSS region once it has told us that */
> +static u32 iavf_max_channels(struct iavf_adapter *adapter)
> +{
> +	u16 width = adapter->max_rss_qregion.qregion_width;
> +
> +	if (LARGE_NUM_QPAIRS_SUPPORT(adapter) && width)
> +		return BIT(width);

[Severity: Low]
The virtchnl.h text this patch adds for VIRTCHNL_OP_GET_MAX_RSS_QREGION
allows a VF with 64 queues and a 16-queue region. iavf_fill_rss_lut() and
iavf_get_rx_ring_count() both use min(num_active_queues, BIT(width)), so
the code expects num_active_queues > BIT(width) to happen.

With such a PF, wouldn't iavf_get_channels() report a combined_count
larger than max_combined?

The init-time request in iavf_parse_vf_resource_msg() asks for
min(num_online_cpus(), IAVF_MAX_REQ_QUEUES) and does not look at the
region. Once the user lowers the count, can the count set up at init ever
be requested again? iavf_set_channels() and the ethtool core reject
num_req > max_combined.

> +
> +	return adapter->vsi_res->num_queue_pairs;
> +}

[ ... ]

> @@ -1730,14 +1747,25 @@ static int iavf_set_channels(struct net_device *netdev,
>  	/* All of these should have already been checked by ethtool before this
>  	 * even gets to us, but just to be sure.
>  	 */
> -	if (num_req == 0 || num_req > adapter->vsi_res->num_queue_pairs)
> +	if (num_req == 0 || num_req > iavf_max_channels(adapter))
> +		return -EINVAL;
> +
> +	if (ch->rx_count || ch->tx_count || ch->other_count != NONQ_VECS)
>  		return -EINVAL;
>  
> +	/* PF has not answered our previous request yet */
> +	if (adapter->current_op == VIRTCHNL_OP_REQUEST_QUEUES)
> +		return -EBUSY;
> +
>  	if (num_req == adapter->num_active_queues)
>  		return 0;

[Severity: Low]
Suppose an earlier ethtool -L combined N has set
IAVF_FLAG_AQ_REQUEST_QUEUES and the request has not been sent yet. What
happens when the user then asks for the current count again? The ethtool
core sees no change against get_channels() and does not call the driver.
Even if it did, this early return leaves the flag set.

iavf_watchdog_step() and iavf_reset_step() now keep the flag:

	adapter->aq_required &= IAVF_FLAG_AQ_REQUEST_QUEUES;

So wouldn't the old request still go out later and change the queue
count, even though the user's last command asked to keep it?

>  
> -	if (ch->rx_count || ch->tx_count || ch->other_count != NONQ_VECS)
> -		return -EINVAL;
> +	if (LARGE_NUM_QPAIRS_SUPPORT(adapter)) {
> +		/* the watchdog sends it once no other op is in flight */
> +		adapter->num_req_queues_next = num_req;
> +		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_REQUEST_QUEUES);
> +		return 0;
> +	}

[Severity: Medium]
Does returning 0 here fit the set_channels contract? ethnl_set_channels()
takes 0 to mean the change was applied:

	ret = dev->ethtool_ops->set_channels(dev, &channels);
	return ret < 0 ? ret : 1;

It then sends ETHTOOL_MSG_CHANNELS_NTF built from iavf_get_channels(),
which still reports the old num_active_queues.

If the PF later denies or NACKs the request, iavf_virtchnl_completion()
only logs it and clears num_req_queues. Userspace gets a success return
and a notification with the old values, and nothing tells it the change
was dropped.

The commit message says this is intended. Is there a way to report the
outcome to the user?

[ ... ]

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index db769eead68f3..6feab0dd7f27c 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c

[ ... ]

> @@ -1783,12 +1784,17 @@ int iavf_config_rss(struct iavf_adapter *adapter)
>   * iavf_fill_rss_lut - Fill the lut with default values
>   * @adapter: board private structure
>   **/
> -static void iavf_fill_rss_lut(struct iavf_adapter *adapter)
> +void iavf_fill_rss_lut(struct iavf_adapter *adapter)
>  {
> -	u16 i;
> +	struct virtchnl_max_rss_qregion *qregion = &adapter->max_rss_qregion;
> +	int max = adapter->num_active_queues;
> +
> +	/* width == 0: PF has not told us the region yet */
> +	if (LARGE_NUM_QPAIRS_SUPPORT(adapter) && qregion->qregion_width)
> +		max = min(max, (int)BIT(qregion->qregion_width));
>  
> -	for (i = 0; i < adapter->rss_lut_size; i++)
> -		adapter->rss_lut[i] = i % adapter->num_active_queues;
> +	for (int i = 0; i < adapter->rss_lut_size; i++)
> +		adapter->rss_lut[i] = i % max;
>  }

[Severity: Medium]
qregion_width is a u16 that comes from the PF. It is copied into
adapter->max_rss_qregion with no range check, both in
iavf_get_max_rss_qregion() and in the GET_MAX_RSS_QREGION case of
iavf_virtchnl_completion(). What happens here for large widths?

For width 31, (int)BIT(31) is INT_MIN, so i % max fills the LUT with
out-of-range queue indices.

For width 32..63 on 64-bit, (int)BIT(width) truncates to 0, and this
divides by zero. In the same case iavf_get_rx_ring_count() returns 0,
and the ethtool core then divides by that in ethtool_rxfh_indir_default().

For width 9..31, iavf_max_channels() advertises and accepts a
max_combined above IAVF_MAX_REQ_QUEUES.

There is a related gap: iavf_init_recv_req_queues() asks again for the
count the PF offered without clamping it to IAVF_MAX_REQ_QUEUES, while
the first request is clamped.

The driver already clamps other PF-provided values, in
iavf_validate_num_queues() and in the max_mtu check in
iavf_init_config_adapter(). Should qregion_width larger than
ilog2(IAVF_MAX_REQ_QUEUES) be clamped or rejected when the reply arrives?

[ ... ]

> @@ -2504,13 +2540,54 @@ int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter)
>  	vsi->netdev = adapter->netdev;
>  	vsi->qs_handle = adapter->vsi_res->qset_handle;
>  	if (adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RSS_PF) {
> -		adapter->rss_key_size = adapter->vf_res->rss_key_size;
> -		adapter->rss_lut_size = adapter->vf_res->rss_lut_size;
> +		if ((adapter->rss_key &&
> +		     adapter->rss_key_size != adapter->vf_res->rss_key_size) ||
> +		    (adapter->rss_lut &&
> +		     adapter->rss_lut_size != adapter->vf_res->rss_lut_size)) {
> +			reconfig_rss = true;
> +		} else {
> +			adapter->rss_key_size = adapter->vf_res->rss_key_size;
> +			adapter->rss_lut_size = adapter->vf_res->rss_lut_size;
> +		}
>  	} else {
>  		adapter->rss_key_size = IAVF_HKEY_ARRAY_SIZE;
>  		adapter->rss_lut_size = IAVF_HLUT_ARRAY_SIZE;
>  	}

[Severity: Medium]
This else branch assumes both REINIT flags are clear once a reset that
needed them has finished. Does that hold when the VF is down?

iavf_reinit_interrupt_scheme() runs whether or not running is set.
However, iavf_reset_step() clears IAVF_FLAG_REINIT_MSIX_NEEDED in only
one place: inside the if (running) block, after
iavf_request_traffic_irqs(). IAVF_FLAG_REINIT_ITR_NEEDED, by contrast,
is cleared unconditionally at the end of the function.

This patch adds a new place that sets REINIT_MSIX_NEEDED, in
iavf_parse_vf_resource_msg(), whenever num_active_queues is above the
PF's vsi_res->num_queue_pairs. The VF is down after probe and after
dev_close(), so a PF lowering the limit while the VF is down is an
ordinary case. After that reset the flag stays set. Every later reset
while the VF is down then goes through iavf_reinit_interrupt_scheme()
again and never reaches the new else branch that clears num_req_queues.

Doesn't this also lose an ethtool -L setting in legacy mode? Once the
reset for ethtool -L completes, iavf_parse_vf_resource_msg() has set
num_req_queues back to 0. With REINIT_MSIX_NEEDED still set, the next
reset while down reallocates the queues. iavf_alloc_queues() then picks
min(vsi_res->num_queue_pairs, num_online_cpus()) instead of the count
the user asked for.

The flag handling predates this patch, but the new else branch relies
on it. Should REINIT_MSIX_NEEDED be cleared alongside REINIT_ITR_NEEDED
when not running? Or does something on the iavf_open() path need to
see it still set?

[Severity: Medium]
The commit message says:

  when the RSS key or LUT size changes across a reset, reallocate both
  and fill them again

The size check only exists in the VIRTCHNL_VF_OFFLOAD_RSS_PF branch,
though. Doesn't the else branch still change the sizes without
reallocating the existing buffers?

Say an earlier negotiation had RSS_PF with an rss_key_size below 52 or
an rss_lut_size below 64, and a later reset negotiates without RSS_PF.
The sizes then grow while rss_key and rss_lut keep their old, smaller
allocations.

Wouldn't iavf_init_rss(), iavf_set_rxfh() and the GET_MAX_RSS_QREGION
completion then write past the end of those buffers?

In-tree i40e and ice always report sizes at least this large, so this
needs a PF that reports smaller sizes and later drops RSS_PF.

> +
> +	if (reconfig_rss) {
> +		u8 *rss_key, *rss_lut;
> +
> +		rss_key = kzalloc(adapter->vf_res->rss_key_size, GFP_KERNEL);
> +		rss_lut = kzalloc(adapter->vf_res->rss_lut_size, GFP_KERNEL);

[ ... ]

> +		adapter->rss_key_size = adapter->vf_res->rss_key_size;
> +		adapter->rss_lut_size = adapter->vf_res->rss_lut_size;
> +		iavf_init_rss(adapter);
> +	}

[Severity: High]
Can this call divide by zero in iavf_fill_rss_lut()?

When a VF reset fails (for example "Reset never finished", or any
reset_err path in iavf_reset_step()), iavf_disable_vf() calls
iavf_free_interrupt_scheme() -> iavf_free_queues(), which sets
num_active_queues to 0. iavf_disable_vf() does not call iavf_free_rss(),
so rss_key and rss_lut stay allocated with their old sizes.

Recovery then goes through:

__IAVF_COMM_FAILED -> __IAVF_STARTUP -> ... -> iavf_init_get_resources()
  iavf_parse_vf_resource_msg()
    reconfig_rss = true;   /* PF now reports a different size */
    iavf_init_rss()
      iavf_fill_rss_lut()
        max = adapter->num_active_queues;   /* 0 */
        adapter->rss_lut[i] = i % max;

In-tree ice can trigger this. Before the reset the VF has a GLOBAL or PF
LUT (rss_lut_size 512 or 2048 in LARGE mode). After a PF reset,
ice_rebuild_rss_luts() puts it back on the VSI LUT (64).

Before this patch, iavf_parse_vf_resource_msg() never called
iavf_init_rss(), and queues are only allocated later, in
iavf_init_config_adapter().

> +
> +	if (init_req) {
> +		qnum = min_t(int, num_online_cpus(), IAVF_MAX_REQ_QUEUES);

[Severity: Medium]
This isn't a bug, but the commit message does not describe this
init-time request. When VIRTCHNL_VF_LARGE_NUM_QPAIRS and
VIRTCHNL_VF_OFFLOAD_REQ_QUEUES are both negotiated, every probe sends
VIRTCHNL_OP_REQUEST_QUEUES for up to one queue per CPU.

The new IAVF_EXTENDED_CAP_RECV_REQ_QUEUES step, iavf_init_recv_req_queues(),
then waits for the outcome. A grant arrives as a PF-initiated reset; on a
denial, the VF asks again for the count the PF offered. This changes the
default queue count and adds an extra VF reset to probe against a
LARGE-capable PF.

Several other user-visible changes appear only in the v3-v5 changelog,
which will not be part of the commit:

- ethtool -X now rejects indirection entries outside the PF RSS region.
- get_rx_ring_count reports a smaller count in LARGE mode.
- For every PF, the GET_VF_RESOURCES completion now stops when
  iavf_parse_vf_resource_msg() fails.

Could the commit message describe these changes?

> +		/* granted, or we have enough */
> +		if (num_req_queues || qnum <= adapter->vsi_res->num_queue_pairs)
> +			return 0;

[ ... ]

> @@ -2977,6 +3176,9 @@ static int iavf_watchdog_step(struct iavf_adapter *adapter)
>  			 */
>  			iavf_change_state(adapter, __IAVF_STARTUP);
>  			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
> +			/* fresh retry budget, and init asks for queues again */
> +			adapter->aq_wait_count = 0;
> +			adapter->num_req_queues = 0;
>  		}

[Severity: Low]
This isn't a bug, but two fixes here change existing behaviour for every
PF and do not depend on the new opcodes:

- the aq_wait_count reset
- the "PF could cut our queues on reset" reinit in
  iavf_parse_vf_resource_msg()

Could they be split into separate patches with Fixes: tags, so stable
can pick them up? The aq_wait_count increment with no matching reset
comes from commit 898ef1cb1cb2 ("iavf: Combine init and watchdog state
machines").

[ ... ]

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index 1296ea0f1716a..6437fd4681be7 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c

[ ... ]

> @@ -251,6 +252,18 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
>  				(u8 *)&hw_caps, sizeof(hw_caps));
>  }
>  
> +int iavf_send_max_rss_qregion(struct iavf_adapter *adapter)
> +{
> +	adapter->aq_required &= ~IAVF_FLAG_AQ_GET_MAX_RSS_QREGION;
> +
> +	if (!LARGE_NUM_QPAIRS_SUPPORT(adapter))
> +		return -EOPNOTSUPP;
> +
> +	adapter->current_op = VIRTCHNL_OP_GET_MAX_RSS_QREGION;
> +	iavf_send_pf_msg(adapter, VIRTCHNL_OP_GET_MAX_RSS_QREGION, NULL, 0);
> +	return 0;
> +}

[Severity: Low]
Should this return the result of iavf_send_pf_msg(), as
iavf_send_vf_ptp_caps_msg() and iavf_send_vf_offload_vlan_v2_msg() do?

The comment on iavf_init_send_max_rss_qregion() says it "Must clear
IAVF_EXTENDED_CAP_RECV_RSS_QREGION if the message is not sent". Because
the send status is dropped here, a failed send leaves RECV set and
current_op set to VIRTCHNL_OP_GET_MAX_RSS_QREGION. Init then polls for a
reply that never comes. On the runtime path through
iavf_process_aq_command(), current_op stays set with no reply pending.

Also, that comment opens with /* rather than /**, so kernel-doc will not
parse it the way it parses the sibling helpers.

>  
>  /**
>   * iavf_validate_num_queues
>   * @adapter: adapter structure
> @@ -260,19 +273,24 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
>   **/
>  static void iavf_validate_num_queues(struct iavf_adapter *adapter)
>  {
> -	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES) {
> +	u32 max_req_queues = IAVF_MAX_REQ_QUEUES;
> +
> +	if (!LARGE_NUM_QPAIRS_SUPPORT(adapter))
> +		max_req_queues = IAVF_MAX_VSI_QP;

[Severity: Medium]
This brings back the 16-queue cap for PFs without
VIRTCHNL_VF_LARGE_NUM_QPAIRS, and the commit message does not mention it.
Without this hunk, does the previous commit in the series, "iavf:
increase max number of queues to 256", break bisection?

At that commit the cap is IAVF_MAX_REQ_QUEUES (256). However,
iavf_enable_queues() and iavf_disable_queues() still build a
BIT(min(n, IAVF_MAX_REQ_QUEUES_VCV1)) - 1 bitmap, and iavf_map_queues()
reads only 16 bits of ring_mask.

After "ice: bump to 256qs for VF", ice reports more than 16 queues
whether or not LARGE was negotiated (for example 64 with
ICE_NUM_VF_MSIX_MAX). So queues 16 and above would be configured but
never enabled or mapped.

Should this hunk move into the earlier commit?

[ ... ]

> @@ -2709,6 +2932,20 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
>  			aq_required;
>  		}
>  		break;
> +	case VIRTCHNL_OP_GET_MAX_RSS_QREGION: {
> +		u16 width = adapter->max_rss_qregion.qregion_width;
> +
> +		if (v_retval)
> +			break;
> +		memcpy(&adapter->max_rss_qregion, msg,
> +		       sizeof(adapter->max_rss_qregion));

[Severity: Low]
Should msglen be checked here? iavf_get_max_rss_qregion() limits its copy
of the same reply to min(event.msg_len, len). The neighbouring
GET_SUPPORTED_RXDIDS, 1588_PTP_GET_CAPS and GET_RSS_HASHCFG_CAPS cases
reject an unexpected msglen.

The adminq buffer is the full IAVF_MAX_AQ_BUF_SIZE and is zeroed, so
this does not read out of bounds. However, a short reply with
v_retval == 0 turns into qregion_width = 0. That refills the LUT and
removes the RSS region limit from ethtool -X, ethtool -L and
iavf_fill_rss_lut().

> +		/* LUT was filled before this reply, for the old region */
> +		if (adapter->max_rss_qregion.qregion_width != width) {
> +			iavf_fill_rss_lut(adapter);
> +			iavf_config_rss(adapter);
> +		}
> +		break;
> +	}

[ ... ]

> diff --git a/include/linux/net/intel/virtchnl.h b/include/linux/net/intel/virtchnl.h
> index 11bdab5522fd5..ffb7d3c213348 100644
> --- a/include/linux/net/intel/virtchnl.h
> +++ b/include/linux/net/intel/virtchnl.h

[ ... ]

> @@ -1663,6 +1696,70 @@ struct virtchnl_queue_chunk {
>  
>  VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_queue_chunk);
>  
> +/* VIRTCHNL_OP_ENABLE_QUEUES_V2
> + * VIRTCHNL_OP_DISABLE_QUEUES_V2
> + *
> + * These opcodes can be used if VIRTCHNL_VF_LARGE_NUM_QPAIRS was negotiated in
> + * VIRTCHNL_OP_GET_VF_RESOURCES
> + *
> + * VF sends virtchnl_ena_dis_queues struct to specify the queues to be
> + * enabled/disabled in chunks. Also applicable to single queue RX or
> + * TX. PF performs requested action and returns status.
> + */
> +struct virtchnl_del_ena_dis_queues {

[Severity: Low]
This isn't a bug, but the comment says virtchnl_ena_dis_queues, while the
struct defined here is virtchnl_del_ena_dis_queues. Is the "del" in the
name intended? This header does not define a delete-queues operation.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110141534.95614-1-przemyslaw.kitszel%40intel.com
