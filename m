Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19564A4984
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146800; cv=none; b=f/MIwlVGmnfJtan5zJO0Au9PoSAv3zSPaX5c4L37c4w7/qsYMnsOT7MAVJAJOZa6uS4+7HC9TzRL24hYV9HNaw9JvZmC4mow2SHIS9B/reQDHbig6UQk0Pl/EIkM+gZktSH5xD18UJnTiFvRqKH+b8QYfYghRNvicz38c6f86xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146800; c=relaxed/simple;
	bh=yCOqz1KVdn1nYma1pnvLTHPEVZY1IZ94IrvJXtS0eJk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uHyUx2bHupjCHMLZm3wNuSYtb84iQDmVNHgR6q643X4FycYox07N837W8XVaCR1dnbp/DtwwrJu+Yo5KzlCdS8sBCkxIzhbJu2gN+GdyLMBTye7zcgA6LCtCzXiTsTTpTHBZrFhAm6N3UnOEpzf0LFwgynUOAO9QBRK5txhp8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXVVpTgw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXVVpTgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EB01F000FF;
	Fri, 11 Sep 2026 17:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146798;
	bh=keDdM7EGPb3KUqiXlaS7/OWnlI9UeCSF1pGZAHV9K+w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RXVVpTgwlJ2gLGXA4tA49a40lCMvvrvzycHYgb7UlgHUpvn3o98OupqdFcQSiYKlR
	 5GmwhgOWWtvc0EuDd/GC6F/Xecfzm7A0AACsUhDknRKcYl+Lyfxo37PSEoiiFqfgyf
	 Pn8noTp4/GhPOb2GoImVFBbfnfBY8NmJncFXTWkwt8aAtD00V9E2r19Fv75j4FOqNg
	 YJJcY8i+PaoznVgWmHRUOOH8uappV5cO3fL1Spw+ufYGIhKlQs0LiheD5Brk9DiDZz
	 DUPLJhlGDyaOyLwTkJC4mwbVVhMuUi7IRAwvB5ierNc5jZDjk7P8cUsCAeIk1E6SGN
	 oBDiO0t4sJwMQ==
Subject: Re: [PATCH net-next v9 4/7] idpf: support pacing offload
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com
Date: Fri, 11 Sep 2026 17:13:17 +0000
Message-ID: <178914679743.219967.4781990764758262872@kernel.org>
In-Reply-To: <20260910171131.2532487-5-willemdebruijn.kernel@gmail.com>
References: <20260910171131.2532487-5-willemdebruijn.kernel@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 2

- [High] idpf advertises a non-zero netdev->max_pacing_offload_horizon
  (and therefore programs absolute CLOCK_TAI departure times into the…
- [Medium] The EDT horizon advertised to the networking core is taken
  verbatim from firmware and only bounds-checked against U32_MAX, while…
- [Low] idpf_vport_set_pacing_offload() writes
  netdev->max_pacing_offload_horizon (idpf_lib.c:832) from the…
- [Low] In idpf_send_get_edt_caps_msg() the firmware-supplied granularity
  is a u64 (gran_ns = le64_to_cpu(caps.tstamp_granularity_ns)) but is…

--

idpf: support pacing offload

This adds EDT (earliest departure time) support to idpf: EDT capabilities
are negotiated over virtchnl, the negotiated horizon is published as
netdev->max_pacing_offload_horizon, and skb->tstamp is programmed into the
23-bit timestamp field of the flow scheduling Tx descriptor.

A few questions below on the capability gating and on the horizon
encoding.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 827c795afcb62..cd1b173e3b276 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -817,6 +817,21 @@ static void idpf_attach_and_open(struct idpf_adapter *adapter)
>  	}
>  }
>  
> +static void idpf_vport_set_pacing_offload(struct idpf_vport *vport,
> +					  struct net_device *netdev)
> +{
> +	struct idpf_adapter *adapter = vport->adapter;
> +	u32 max_horizon = 0;
> +
> +	if (adapter->edt_caps.time_horizon_ns &&
> +	    idpf_is_queue_model_split(vport->dflt_qv_rsrc.txq_model) &&
> +	    !idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS,
> +			     VIRTCHNL2_CAP_SPLITQ_QSCHED))
> +		max_horizon = adapter->edt_caps.time_horizon_ns;
> +

[Severity: High]
The commit message says:

    Negotiate the feature with the device using virtchnl. Support is
    conditional on
    ...
    - PTP to ensure the NIC clock is synced to CLOCK_TAI.

Where is that PTP condition implemented?  idpf_vport_set_pacing_offload()
gates only on adapter->edt_caps.time_horizon_ns, split txq model and flow
scheduling.  It does not consult VIRTCHNL2_CAP_PTP, adapter->ptp, or the
result of idpf_ptp_init().

In idpf_vc_core_init() the EDT negotiation is gated only on
VIRTCHNL2_CAP_EDT and runs before idpf_ptp_init(), whose failure is
deliberately non-fatal:

	err = idpf_ptp_init(adapter);
	if (err)
		pci_err(adapter->pdev, "PTP init failed, err=%pe\n",
			ERR_PTR(err));

So with a control plane that advertises EDT but not PTP, or when
idpf_ptp_get_caps()/clock creation fails, edt_caps.time_horizon_ns stays
non-zero and the horizon is still published.

With CONFIG_PTP_1588_CLOCK=n the stub in idpf_ptp.h returns success while
leaving adapter->ptp NULL:

	static inline int idpf_ptp_init(struct idpf_adapter *adapter)
	{
		return 0;
	}

In that build there is no PHC at all and no way for userspace to steer the
device clock, yet pacing offload remains advertised and
idpf_tx_splitq_set_txtime() keeps writing host CLOCK_TAI values into the
descriptor.  Should the helper also require a working PTP clock, or should
the commit message drop the PTP claim?

Related: the device clock is seeded from CLOCK_REALTIME in
idpf_ptp_init():

		ts = ktime_to_timespec64(ktime_get_real());
		err = idpf_ptp_settime64(&adapter->ptp->info, &ts);

while the new Tx path converts everything to CLOCK_TAI.  Is the epoch
assumed by the descriptor only correct after an external synchronizer has
corrected the PHC?

> +	WRITE_ONCE(netdev->max_pacing_offload_horizon, max_horizon);
> +}
> +

[Severity: Low]
Should this write be done under rtnl_lock()?  The RTNL side reads the same
field with a plain load in validate_linkmsg() before do_setlink() sets
dev->pacing_offload:

	net/core/rtnetlink.c:validate_linkmsg() {
		if (nla_get_u32(tb[IFLA_PACING_OFFLOAD]) &&
		    !dev->max_pacing_offload_horizon) {
	...
	}

idpf_cfg_netdev() is reached from idpf_init_task with no RTNL held, and on
the reset path it re-runs the helper on an already registered netdev, so an
"ip link set dev X pacing_offload on" validated against a non-zero horizon
can be followed immediately by the driver zeroing it.

That also leaves dev->pacing_offload set with
max_pacing_offload_horizon == 0, which is then dumped to userspace as
IFLA_PACING_OFFLOAD=1 together with IFLA_MAX_PACING_OFFLOAD_HORIZON=0.
Should the driver clear dev->pacing_offload when the horizon drops to 0?

>  /**
>   * idpf_cfg_netdev - Allocate, configure and register a netdev
>   * @vport: main vport structure
> @@ -850,6 +865,8 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
>  		np->max_tx_hdr_size = idpf_get_max_tx_hdr_size(adapter);
>  		vport->netdev = netdev;
>  
> +		idpf_vport_set_pacing_offload(vport, netdev);
> +
>  		return idpf_init_mac_addr(vport, netdev);
>  	}
>  

[ ... ]

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 4311ffa30bb18..215a62161a049 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c

[ ... ]

> @@ -3011,6 +3017,63 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
>  	return gap >= IDPF_TX_SPLITQ_RE_MIN_GAP;
>  }
>  
> +static void idpf_tx_splitq_set_txtime(const struct sk_buff *skb,
> +				      const struct idpf_tx_queue *tx_q,
> +				      struct idpf_tx_splitq_params *tx_params)
> +{

[ ... ]

> +	/* beyond offload horizon? set overflow bit only */
> +	if (ts > now + horizon) {
> +		tx_params->offload.desc_ts[2] =
> +			IDPF_TXD_FLOW_SCH_HORIZON_OVERFLOW_M;
> +		return;
> +	}
> +
> +	ts >>= tx_q->ts_gran_pow2;

[Severity: Medium]
Can the advertised horizon exceed what the descriptor can encode?  The
hardware field is 23 bits of granularity units:

	drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h:
		/* [23:23] Horizon Overflow bit, [22:0] timestamp */
		u8 ts[3];

idpf_send_get_edt_caps_msg() checks time_horizon_ns only against U32_MAX
and never cross-checks it against (1 << 23) << ilog2(tstamp_granularity_ns).
For a control plane reporting tstamp_granularity_ns = 1 (passes both
checks) with time_horizon_ns = 1000000000, the encodable window is only
about 8.39 ms, but 1 s is published as netdev->max_pacing_offload_horizon
and accepted by sch_fq and SO_TXTIME.

Anything at or below the advertised horizon takes the non-overflow branch
here and gets truncated:

	tx_params->offload.desc_ts[2] = ((ts >> 16) & 0x7f);

so the departure time aliases back into the current window instead of being
flagged as overflow.  Would clamping help, e.g.
max_horizon = min(time_horizon_ns, (1ULL << 23) << tstamp_granularity_pow2)?

Separately, is the boundary test off by one even for self-consistent caps?
With horizon == (1 << 23) << gran, a timestamp exactly at now + horizon
passes the strict "ts > now + horizon" test, and after the shift it differs
from the scaled value of now by exactly 2^23, which masks to the same 23-bit
value, so the device would see "now" and release the packet a whole horizon
early.  Should the comparison be >= ?

> +
> +	/* 0 is valid 23b timestamp, but also means field unset.
> +	 * Increase by one to avoid this case
> +	 */
> +	if ((ts & 0x7fffff) == 0) {
> +		tx_params->offload.desc_ts[0] = 1;
> +		return;
> +	}
> +
> +	tx_params->offload.desc_ts[0] = ts & 0xff;
> +	tx_params->offload.desc_ts[1] = (ts >> 8) & 0xff;
> +	tx_params->offload.desc_ts[2] = ((ts >> 16) & 0x7f);
> +}
> +

[ ... ]

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 1caf527069737..928de868fa624 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c

[ ... ]

> @@ -573,6 +575,54 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
>  	return err;
>  }
>  

[ ... ]

> +	memcpy(&caps, xn_params.recv_mem.iov_base, sizeof(caps));
> +	horizon_ns = le64_to_cpu(caps.time_horizon_ns);
> +	gran_ns = le64_to_cpu(caps.tstamp_granularity_ns);
> +	if (horizon_ns > U32_MAX) {
> +		dev_warn(&adapter->pdev->dev, "EDT horizon exceeds U32\n");
> +		err = -EINVAL;
> +		goto free_rx_buf;
> +	}
> +	if (!gran_ns || !is_power_of_2(gran_ns)) {
> +		dev_warn(&adapter->pdev->dev, "Invalid EDT granularity\n");
> +		err = -EINVAL;
> +		goto free_rx_buf;
> +	}
> +
> +	adapter->edt_caps.time_horizon_ns = horizon_ns;
> +	adapter->edt_caps.tstamp_granularity_pow2 = ilog2(gran_ns);

[Severity: Low]
Does this validate a different value than the one it then uses?  gran_ns is
a u64, but is_power_of_2() takes unsigned long:

	include/linux/log2.h:
	static __always_inline __attribute__((const))
	bool is_power_of_2(unsigned long n)
	{
		return n - 1 < (n ^ (n - 1));
	}

IDPF has no "depends on 64BIT" in its Kconfig, so on 32-bit builds the
upper 32 bits are dropped for the check while ilog2(gran_ns) takes the
__ilog2_u64 path on the full value.  A response of 0x100000001 truncates to
1, passes the check, and yields tstamp_granularity_pow2 = 32, which is
copied into idpf_tx_queue.ts_gran_pow2 and used as the shift in
idpf_tx_splitq_set_txtime().  The same truncation rejects a legitimate
granularity of 2^32 on 32-bit.  Would testing the u64 directly, e.g.
gran_ns & (gran_ns - 1), plus an upper bound, be better here?

> +
> +free_rx_buf:
> +	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
> +
> +	return err;
> +}
> +

[ ... ]

> @@ -3085,6 +3135,14 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
>  		}
>  	}
>  
> +	memset(&adapter->edt_caps, 0, sizeof(adapter->edt_caps));
> +	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_EDT)) {
> +		err = idpf_send_get_edt_caps_msg(adapter);
> +		if (err)
> +			dev_err(&adapter->pdev->dev,
> +				"EDT init failed, err=%d\n", err);
> +	}
> +

[Severity: High]
This is the other half of the PTP question above: EDT caps are fetched here
gated only on VIRTCHNL2_CAP_EDT, and this runs before the idpf_ptp_init()
call further down whose error is only logged.  Should the EDT negotiation
either be gated on VIRTCHNL2_CAP_PTP, or moved after idpf_ptp_init() so the
caps can be zeroed when there is no usable PHC?

>  	pci_sriov_set_totalvfs(adapter->pdev, idpf_get_max_vfs(adapter));
>  	num_max_vports = idpf_get_max_vports(adapter);
>  	adapter->vports = kzalloc_objs(*adapter->vports, num_max_vports);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910171131.2532487-1-willemdebruijn.kernel%40gmail.com
