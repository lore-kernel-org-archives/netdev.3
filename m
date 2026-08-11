Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C76631E830
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 01:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786410771; cv=none; b=eKO6w0w3JdBvdu31H1gOdnkHmRkGlwnDOCa2uDrbV1a1Y0UC7zskilXzYFqr8jMb2kZxEpOdbcObP5PCWjuK8h45hUbQs1DwpEDKUP3uHvw0GU5yrGEv6iMaEBxpjGaccnEub0rTNUZhJDR7OabUeLfJvZe+cY/XTRICFsUazsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786410771; c=relaxed/simple;
	bh=s0e5Y1WIXA0TGzRo/X0fxnVMwTalxngvAjADU+4ncwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMK19b/5NN9Hzk72wtyfr1a1oVpJpoxQhMSoYFAyfF3FWV9PTLCN4wQ3gurhd0HtLfJqnkrVFHYGzqdI0JJRqj7hEzbZKqqeinnmkbNy38DlpI1IUaOpXsjhe3ZajlPu9yE9Q/m+1gPKc0cxdLf+I8ivDECOg0Zdru4NXEh4/LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byNOLa+w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byNOLa+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F8B1F00A3A;
	Tue, 11 Aug 2026 01:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786410770;
	bh=tbmf1EiVIqcD4yT2+gkX7DdlRJdNHmx498cyz8kq7PM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=byNOLa+w7QJw3/XYdQdXvgbTiqnkcAHS7YrHj+cWvyH3nF1Uyx9jyx8YiPsr+MiBh
	 Chfcr1xfOVCPC7uqUdRx9K3I4CtQRjk6a9h1G8ZOhBZJOPOsan4yxeSIg/TblLsBeJ
	 rbzWE5JTZW9TEbLq12xxOs8Kz3K8YJ7mX7+gJGA5hDOogxA0nXfw3Ln+Gx8GKfi4Oq
	 OjjMSabFN+HoH4D63Jb9hEvunGam+YG8F217uueRX8j94G6SRKMUiw3qysS5TqmdyV
	 O9Y2PdEmSonZGrjTP2yjgy6IUfpiBPAWr9yXerA6Zdt0x91B/oZw3pTbNjiZ3fefix
	 xCexfti4kKqjA==
Date: Mon, 10 Aug 2026 18:12:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch, Willem de Bruijn
 <willemb@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joshua A Hay
 <joshua.a.hay@intel.com>
Subject: Re: [PATCH net-next v5 3/6] idpf: support pacing offload
Message-ID: <20260810181248.7b05c051@kernel.org>
In-Reply-To: <20260808155217.885299-4-willemdebruijn.kernel@gmail.com>
References: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
	<20260808155217.885299-4-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  8 Aug 2026 11:51:41 -0400 Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> If skb->tstamp is in the future, program this future delivery txtime
> in the transmit descriptor.
> 
> TCP pacing offload is only offloaded if SK_PACING_FQ is negotiated and
> the FQ offload_horizon is configured. But device support for pacing
> offload must be more robust: it can also be reached through SO_TXTIME.
> 
> Bounds check txtime. Only packets with timestamp between now and the
> horizon (pacing_offload_horizon) are offloaded.
> 
> Negotiate the feature with the device using virtchnl. Support is
> conditional on
> - splitq mode, where tx and tx completion queues are separate, so
>   completions can be returned out of order.
> - flow scheduling mode, where completions can arrive out of order.
> - PTP to ensure the NIC clock is synced to CLOCK_TAI.
> 
> Do not explicitly check for these preconditions. Trust the firmware to
> only advertise EDT when they are met. These features are negotiated
> per adapter, but expect all vports to uniformly request splitq
> (req_[rt]x_splitq) and flow scheduling (flow_sch_en) when available.
> 
> Disable if in netpoll. It does not need the feature, and the ktime
> functions are not safe to call in this context.
> 
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Joshua A Hay <joshua.a.hay@intel.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Sorry I said it looks good to human eye but *shiko brings up some
extra good points.

> +static void idpf_tx_splitq_set_txtime(const struct sk_buff *skb,
> +				      struct idpf_tx_splitq_params *tx_params)
> +{
> +	struct idpf_netdev_priv *np = netdev_priv(skb->dev);
> +	u64 ts, now, horizon;
> +
> +	horizon = READ_ONCE(skb->dev->pacing_offload_horizon);

Per *shiko, the max_pacing.. and pacing.. don't behave like the user
may expect them to behave. FQ looks at max_pacing.. to decide whether 
to allow configuring pacing offload. Driver looks at pacing..

Why are we letting the user create an obviously invalid configuration
where the FQ is configured to offload but the driver is not respecting
the requests? Since no upstream driver ever set max_pacing.. we can
still adjust its semantics.

What do you expect the driver to use pacing_.. for?
Currently you use it purely as a boolean but even in this case the
semantics are unclear - is it purely a user configuration handshake
between the driver and the qdisc to respect timestamps?

> +	if (!horizon)
> +		return;
> +
> +	/* Skip if netpoll: not needed and not safe to call ktime helpers */
> +	if (netpoll_tx_running(skb->dev))

Is this due to Gemini's complaint? netpoll sending packets with
timestamp in the future seems unreasonable to me, no?

> +		return;
> +
> +	switch (skb->tstamp_type) {
> +	case SKB_CLOCK_REALTIME:
> +		ts = ktime_to_ns(ktime_add(skb->tstamp,
> +					   ktime_mono_to_any(0, TK_OFFS_TAI) -
> +					   ktime_mono_to_any(0, TK_OFFS_REAL)));
> +		break;
> +	case SKB_CLOCK_MONOTONIC:
> +		ts = ktime_to_ns(ktime_mono_to_any(skb->tstamp, TK_OFFS_TAI));
> +		break;
> +	case SKB_CLOCK_TAI:
> +		ts = ktime_to_ns(skb->tstamp);
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return;
> +	}
> +
> +	now = ktime_get_clocktai_ns();
> +	if (ts < now)
> +		return;

makes me wonder if FQ should clear the timestamps for e.g. now + 100ns ?
IOW I wonder how often we end up taking this exit?

> +	/* beyond offload horizon? set overflow bit only */
> +	if (ts > now + horizon) {
> +		tx_params->offload.desc_ts[2] =
> +			IDPF_TXD_FLOW_SCH_HORIZON_OVERFLOW_M;
> +		return;
> +	}
> +
> +	ts >>= np->adapter->edt_caps.tstamp_granularity_pow2;
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
>  /**
>   * idpf_tx_splitq_frame - Sends buffer on Tx ring using flex descriptors
>   * @skb: send buffer
> @@ -3097,6 +3161,10 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
>  
>  		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
>  		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
> +
> +		if (skb->tstamp)
> +			idpf_tx_splitq_set_txtime(skb, &tx_params);
> +
>  		/* Set the RE bit periodically to "clean" the descriptor ring */
>  		if (idpf_tx_splitq_need_re(tx_q)) {
>  			tx_params.eop_cmd |= IDPF_TXD_FLEX_FLOW_CMD_RE;
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> index 908dfa28674e..86e881c697cc 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> @@ -161,6 +161,7 @@ union idpf_tx_flex_desc {
>   * @tso_segs: Number of segments to be sent
>   * @tso_hdr_len: Length of headers to be duplicated
>   * @td_cmd: Command field to be inserted into descriptor
> + * @desc_ts: Flow scheduling offload timestamp
>   */
>  struct idpf_tx_offload_params {
>  	u32 tx_flags;
> @@ -174,6 +175,7 @@ struct idpf_tx_offload_params {
>  	u16 tso_hdr_len;
>  
>  	u16 td_cmd;
> +	u8 desc_ts[3];
>  };
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 8bd6cca64c9b..964eb8aa283f 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -2,6 +2,7 @@
>  /* Copyright (C) 2023 Intel Corporation */
>  
>  #include <linux/export.h>
> +#include <linux/log2.h>
>  #include <net/libeth/rx.h>
>  
>  #include "idpf.h"
> @@ -1001,7 +1002,8 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
>  			    VIRTCHNL2_CAP_SPLITQ_QSCHED		|
>  			    VIRTCHNL2_CAP_PROMISC		|
>  			    VIRTCHNL2_CAP_LOOPBACK		|
> -			    VIRTCHNL2_CAP_PTP);
> +			    VIRTCHNL2_CAP_PTP			|
> +			    VIRTCHNL2_CAP_EDT);
>  
>  	xn_params.vc_op = VIRTCHNL2_OP_GET_CAPS;
>  	xn_params.send_buf.iov_base = &caps;
> @@ -1019,6 +1021,49 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
>  	return 0;
>  }
>  
> +/**
> + * idpf_send_get_edt_caps_msg - Send virtchnl get EDT caps msg
> + * @adapter: Driver specific private struct
> + *
> + * Return: 0 on success or error code on failure.
> + */
> +static int idpf_send_get_edt_caps_msg(struct idpf_adapter *adapter)
> +{
> +	struct virtchnl2_edt_caps caps = {};
> +	struct idpf_vc_xn_params xn_params = {
> +		.vc_op = VIRTCHNL2_OP_GET_EDT_CAPS,
> +		.send_buf = {
> +			.iov_base = &caps,
> +			.iov_len = sizeof(caps),
> +		},
> +		.recv_buf = {
> +			.iov_base = &caps,
> +			.iov_len = sizeof(caps),
> +		},
> +		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
> +	};
> +	ssize_t reply_sz;
> +	u64 gran_ns, horizon_ns;
> +
> +	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
> +	if (reply_sz < 0)
> +		return reply_sz;
> +	if (reply_sz < sizeof(caps))
> +		return -EIO;
> +
> +	horizon_ns = le64_to_cpu(caps.time_horizon_ns);
> +	if (horizon_ns > U32_MAX) {
> +		dev_warn(&adapter->pdev->dev, "EDT horizon exceeds U32\n");
> +		return 0;
> +	}
> +
> +	adapter->edt_caps.time_horizon_ns = horizon_ns;
> +	gran_ns = le64_to_cpu(caps.tstamp_granularity_ns);
> +	adapter->edt_caps.tstamp_granularity_pow2 = gran_ns ? ilog2(gran_ns) : 9;
> +
> +	return 0;
> +}
> +
>  /**
>   * idpf_send_get_lan_memory_regions - Send virtchnl get LAN memory regions msg
>   * @adapter: Driver specific private struct
> @@ -3547,6 +3592,15 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
>  		}
>  	}
>  
> +	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_EDT)) {
> +		err = idpf_send_get_edt_caps_msg(adapter);
> +		if (err) {
> +			dev_err(&adapter->pdev->dev, "Failed to get EDT caps: %d\n",
> +				err);
> +			return -EINVAL;
> +		}
> +	}
> +
>  	err = idpf_map_lan_mmio_regs(adapter);
>  	if (err) {
>  		dev_err(&adapter->pdev->dev, "Failed to map BAR0 region(s): %d\n",
> diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> index 39fea65c075c..7525146491cd 100644
> --- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
> +++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> @@ -457,6 +457,16 @@ struct virtchnl2_edt_caps {
>  };
>  VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_edt_caps);
>  
> +/**
> + * struct virtchnl2_edt_caps_ilog2 - Host parsed EDT caps.
> + * @time_horizon_ns: Total time window in nanoseconds.
> + * @tstamp_granularity_pow2: Log2 of timestamp granularity in nanoseconds.
> + */
> +struct virtchnl2_edt_caps_ilog2 {
> +	u32 time_horizon_ns;
> +	u8 tstamp_granularity_pow2;
> +};

*shiko:

This isn't a bug, but this struct is host internal state: native u32/u8
fields, no __le types, no VIRTCHNL2_CHECK_STRUCT_LEN assertion, and its only
user is the edt_caps member of struct idpf_adapter. Every other struct in
virtchnl2.h mirrors the control plane wire layout and carries a size
assertion, as the neighbouring virtchnl2_edt_caps does.

Would idpf.h be a better home for it, with a name that does not carry the
virtchnl2_ prefix, so a future firmware spec sync does not mistake it for a
message struct?
