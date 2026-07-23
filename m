Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B7D43712D
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817183; cv=none; b=Fi5K5vgyyQX5aJjGAEJ5RGwNzre0+50133XoZ6xa/wfJsx8ANSSUqopQgG1AGxpU2TRM4euhWMWEPwV80GlKdyLIweslfWnjJRuYEnTGgtmvmbKqSxIVVjl4VrE+/bNRBFTudlbpWAK7Fu+09qsBCeh1jWdmYuk2RGmVgdNBnxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817183; c=relaxed/simple;
	bh=3ciT2iQBIKV2cQWwLYAzUk0nnZwMRpNw3mTPkXMVx1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJ8GYnNsSVg9yDFAqRShgPK6FxlNpRgMO1EEA/eaZlHC2xWU2mRl942kyCyft3Zh72DpOX0A6tc13NoLQEkYwR2eXev8H/HYFSTs2fZJ4g1p3UXWGz06daQO3ovP9hocWoQSG2BeyLWJUyo0cOyOqBLXt6Wrsx9L6EA4nvhkHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLbm5Fec; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLbm5Fec"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e55b62640so55375485a.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784817181; x=1785421981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8eZOrDkfFzZV51wzeOrRtM+W278Z95zHgxxPs68seo=;
        b=lLbm5Fec/kiMk2JbHCY3T6DJUNTFnZNUo9ttmY+ujrpbScajD4VoNKRYeMsG8b+Cf+
         JdFoC8TLkz22R7Dj7gfXX5KqHaktrvSFqCOuYq0NCAW9OETKN8Oknba5JQqKUp9cq+Yp
         lbspApZLQjq3T4vys1wRsl1yaSt3KtpWICEix1VsRSL8J/D79B8j0byTiq9u7L7DXK5s
         vv7V1xwD/rqX+UTi8YQWeC9YkSNBuTQ1zT4u80Q/qDtkyEOnSIju0fDwI4P4JSbiSXsy
         zF9Kfr5aVZRm2w64KYVfiZm6AgQRaYXF3+8Mwrg4sQUUkR3jnwGn3ehmwUallniT5TMe
         T/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784817181; x=1785421981;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8eZOrDkfFzZV51wzeOrRtM+W278Z95zHgxxPs68seo=;
        b=RlKDQts6FA352ph3AaBSlk2OAdKMbxTEoKYEvHf3BksiVpOZT/o7oVIjGWVz2pC2Av
         rjhV6FezLqLdrZEGeBOjhKt4Evw7+QLIe4cGiIGV/Vty+AIRWMfADF8d9cktRgCbJLFR
         ZUT5OY8xAPNZnc5IK2Z1qznQwsKr/9pQmut+RD1oXeTVTmzTaslFDE/d9Hn0zdyrXOXM
         hIVV0Rb6B2Qg/eBlKoRLQcq7BOmSJYpBL2Yf7P6f/FlUiDZGyg9+3vskTk9qO/CybOJi
         gyfW4ti6A8cCuxK2CLVaXgyrx9MjK5+gNwx1zkPuXhbaq/wrmz0Fu0u2CzO1bTR8S7Un
         tF0w==
X-Forwarded-Encrypted: i=1; AHgh+RqXXkQhEriGJTU0dub55FSt+bRwnpcqJHV1WW0RJzSrV3CDRprTZ3VBvHNA2OWpmYIWnhBQUeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgrayASXUc2IsyDe3CJXFWLmwsj6bmUMhDLEZm8kMZqUbfOv34
	qq3hjPCfGh/JoeabLRHtm1EUhyBLAqQyuF41KcHrn5mNb7Rs6ne1UxZZ
X-Gm-Gg: AR+sD101ntrE/QcY/ttJ4kod6vtZuQmzUHBch+5fS/88ncM8NXWadqaKKR8jdJOgdUM
	u8FjptEuJcKFXS4jnQmBDqZUOsql5RrqMbfrhlclZzTb/dIaqnmWiMP67MAFbqaHmI2ua8cXyjs
	G4jtEIFuxL/lzbXlMlrJBok7Yb8PvpSabr42Un/9+shEwXz6QmFxtqkDTyIfz30pZZh4bQyyI3i
	UCnwmoQWrvnNrYk+CSJq1LDlRnuYBJtbzM4adUXVazeZFCffsdO8cqv7FNd0U38DG4CGQ1h5BQw
	1w/2n4YFW2g3bzigtqcytCEenqsUymB+N/5SA3sE8avX8O/2GtZKmbEjZ1gRuLsHKr3qbCGAQpH
	iKSJXFI2Tisbl9BoLMnVvsgVZ/LItmxfrBeKNFe1NOzJmLkvkU8TYTkMo8387sChq9t2n8/m20F
	RfNXXYdgHZ2UwUQqsEHSYMvPd5wZZtFsC2xCJ7u+Q=
X-Received: by 2002:a05:620a:44d3:b0:931:1d6:8a98 with SMTP id af79cd13be357-931038c7f92mr362147585a.41.1784817180476;
        Thu, 23 Jul 2026 07:33:00 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::10db? ([2620:10d:c090:400::5:1ca2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f687a6aasm429781685a.9.2026.07.23.07.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 07:32:59 -0700 (PDT)
Message-ID: <d9a1d0c3-c097-42a1-a26d-7291a762390b@gmail.com>
Date: Thu, 23 Jul 2026 07:32:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/7] idpf: support pacing offload
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 Willem de Bruijn <willemb@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Joshua A Hay <joshua.a.hay@intel.com>
References: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
 <20260722204454.3234605-4-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260722204454.3234605-4-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/26 1:43 PM, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> If skb->tstamp is in the future, program this future delivery txtime
> in the transmit descriptor.
> 
> TCP pacing offload is only offloaded if SK_PACING_FQ is negotiated and
> the FQ offload_horizon is configured.
> 
> But device support for pacing offload must be more robust. It can also
> be reached through SO_TXTIME.
> 
> Bound check txtime. Only packets with timestamp between now and the
> horizon (max_pacing_offload_horizon) are offloaded.
> 
> Support only in splitq mode, where tx and tx completion queues are
> separate and so completions can be returned out of order.
> 
> Assume that the NIC clock is PTP synchronized to CLOCK_TAI. This
> can later be refined, e.g., to a custom CLOCK_AUX.
> 
> Disable if in netpoll. It does not need the feature, and the ktime
> functions are not safe to call in this context.
> 
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Joshua A Hay <joshua.a.hay@intel.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> 
> Changes
>    v1 -> v2
>      - move special zero case up and return early
>    v1: https://lore.kernel.org/netdev/20260706133433.3142805-4-willemdebruijn.kernel@gmail.com/
> 
> Sashiko, ignore pre-existing issues.
> 
> Sashiko, ignore that idpf_tx_splitq_set_txtime may have a benign race
> by calling ktime_mono_to_any twice to get TAI to REALTIME offset.
> 
> fixup idpf
> ---
>   .../net/ethernet/intel/idpf/idpf_ethtool.c    |  3 +-
>   drivers/net/ethernet/intel/idpf/idpf_lib.c    |  5 ++
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 65 ++++++++++++++++++-
>   drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +
>   4 files changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> index bb99d9e7c65d..5ddf347927dc 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> @@ -1801,7 +1801,8 @@ static void idpf_get_ts_stats(struct net_device *netdev,
>   static const struct ethtool_ops idpf_ethtool_ops = {
>   	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>   				     ETHTOOL_COALESCE_USE_ADAPTIVE,
> -	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT,
> +	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
> +				  ETHTOOL_RING_USE_PACING_OFFLOAD_HORIZON,
>   	.get_msglevel		= idpf_get_msglevel,
>   	.set_msglevel		= idpf_set_msglevel,
>   	.get_link		= ethtool_op_get_link,
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index cf966fe6c759..de4170c2aa3b 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -888,6 +888,11 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
>   	netdev->min_mtu = ETH_MIN_MTU;
>   	netdev->max_mtu = vport->max_mtu;
>   
> +	if (idpf_is_queue_model_split(vport->dflt_qv_rsrc.txq_model) &&
> +	    !idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS,
> +			    VIRTCHNL2_CAP_SPLITQ_QSCHED))
> +		netdev->max_pacing_offload_horizon = 128000;
> +
>   	dflt_features = NETIF_F_SG	|
>   			NETIF_F_HIGHDMA;
>   
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 566b08ca3a6c..1ccfaeb35193 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -1,6 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright (C) 2023 Intel Corporation */
>   
> +#include <linux/netpoll.h>
> +
>   #include "idpf.h"
>   #include "idpf_ptp.h"
>   #include "idpf_virtchnl.h"
> @@ -2408,9 +2410,13 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
>   				    struct idpf_tx_splitq_params *params,
>   				    u16 td_cmd, u16 size)
>   {
> -	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
> +	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));

Looks like an independent change (potentially a fix)?

>   	desc->flow.qw1.rxr_bufsize = cpu_to_le16((u16)size);
>   	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
> +
> +	desc->flow.qw1.ts[0] = params->offload.desc_ts[0];
> +	desc->flow.qw1.ts[1] = params->offload.desc_ts[1];
> +	desc->flow.qw1.ts[2] = params->offload.desc_ts[2];
>   }
>   
>   /**
> @@ -3011,6 +3017,59 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
>   	return gap >= IDPF_TX_SPLITQ_RE_MIN_GAP;
>   }
>   
> +static void idpf_tx_splitq_set_txtime(const struct idpf_tx_queue *tx_q,
> +				      const struct sk_buff *skb,
> +				      struct idpf_tx_splitq_params *tx_params)
> +{
> +	const int ts_gran_pow2 = 9;
> +	u64 ts, now;
> +
> +	/* Skip if netpoll: not needed and not safe to call ktime helpers */
> +	if (netpoll_tx_running(skb->dev))
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
> +
> +	/* beyond offload horizon? set overflow bit only */
> +	if (ts > now + ((u64)skb->dev->pacing_offload_horizon * NSEC_PER_USEC)) {
> +		tx_params->offload.desc_ts[2] = 1 << 7;
> +		return;
> +	}
> +
> +	ts >>= ts_gran_pow2;
> +
> +	/* 0 is valid 24b timestamp, but also means field unset.
> +	 * Add 512 ns (ts_gran_pow2) to avoid this case
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
>   /**
>    * idpf_tx_splitq_frame - Sends buffer on Tx ring using flex descriptors
>    * @skb: send buffer
> @@ -3097,6 +3156,10 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
>   
>   		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
>   		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
> +
> +		if (skb->tstamp && skb->dev->pacing_offload_horizon)
> +			idpf_tx_splitq_set_txtime(tx_q, skb, &tx_params);
> +
>   		/* Set the RE bit to periodically "clean" the descriptor ring.
>   		 * MIN_GAP is set to MIN_RING size to ensure it will be set at
>   		 * least once each time around the ring.
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> index 4be5b3b6d3ed..865408b57b0d 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> @@ -161,6 +161,7 @@ union idpf_tx_flex_desc {
>    * @tso_segs: Number of segments to be sent
>    * @tso_hdr_len: Length of headers to be duplicated
>    * @td_cmd: Command field to be inserted into descriptor
> + * @desc_ts: Flow scheduling offload timestamp
>    */
>   struct idpf_tx_offload_params {
>   	u32 tx_flags;
> @@ -174,6 +175,7 @@ struct idpf_tx_offload_params {
>   	u16 tso_hdr_len;
>   
>   	u16 td_cmd;
> +	u8 desc_ts[3];
>   };
>   
>   /**

