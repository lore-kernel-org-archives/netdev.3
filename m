Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB7E43A7FF
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785426892; cv=none; b=QeX7SaTKovYCIeMQeP/2GWO+KUOSKlQ5cHZUThgb9Jf0c0kb3YLdUpLxiUYV4Csd0ZZE+V/q87CxyhsITt2uXBmqDuqeLViigUSS5beHdZAHIgA6Mni53tW8bQhRsDHkHGSd0pVj8Z0hy9ttxiCAH9o2wjcRQwZ17Jb/lXiJS60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785426892; c=relaxed/simple;
	bh=6RUJbJCJmcOgmBVoIfacETmzluT4jCS47ZikeWc4G18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qF89F37PRPstds1E/W7yrl+TaEqFOVFAU1OwG3ru4wfATluK0nJvQ6SvXxk3iRFEo9uGDB0h7p3QNNTiaisHD/EV6L7bU95ojJ3Ry7cLp3Ql+EuLgEgr74A0R3LdiN94SMmeRTTsD5J3k+UDL3rHkx1f5ATNadUW5W7QhBpGkc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=S1qxlM8b; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="S1qxlM8b"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so18173a91.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 08:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785426890; x=1786031690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ffWa1sUD0fV7EQhpv7D4SRQ+QnX1CHB/1+CmFyAsMhI=;
        b=S1qxlM8badubcVu+2zpnNR9vP5APe33QEemGuVqcmIIVsTyOWeXQNIrkFVGB1OUPgw
         8AwGXhCPXL1jxOY7i5dwV77y7TJMWn9XBuHUMPpSg/oHMqJCaBc5tPSbAbBR1fKoTc9p
         nAqIn+NL5WfZ1rUxYRn0WtLR4j2m+jgQrTYsSUL04xxxihMe5PWSjvWnSpfoovhtfxpx
         9bw/mL2y6DsR33MiffSsQtcywRCdlu7LpbuC0hQ739TFTpg/LespTWQiLtrJugHSlHqY
         T/ogjw72GZvhT3rKpRet8SQp4zgh5ZC1eYkH3Y70S0ruCTy8/qysIDYRNxp7MGRvLQfd
         17PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785426890; x=1786031690;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ffWa1sUD0fV7EQhpv7D4SRQ+QnX1CHB/1+CmFyAsMhI=;
        b=kv4SbweXTPMGqxNHAuAEDc5+dVPK4MbpVF8zsqxaO2CnxuJTZ+bL1KQpp3nAI7ZbBN
         U0AyMP2Gd4AEJHvytOcK52QyWdeYAgB+di1wJVgcLzYngU8YN16ftYTtPmYoPJPWHW/4
         MesXT9yMtdWOL7M5f3LnmWzO6CGEZ20NW22Rz/QCd1rc8GwCXDfZ4f8yjpyu5qnR9er9
         7vZN1qpiACyizwk3pwk5El1MmcDNdqkiBDFkxMLz1EguOIg/Akn3JBMgdZHSmhpkhmSx
         JvuXdlh06xqAldkGrJMuF3dH+4oLq+zvmMgrfnM3l4nYsOMT4Dib0FXNfI6aqqFUtb6Y
         QrOA==
X-Forwarded-Encrypted: i=1; AHgh+RqJw4jo+l2p/6fW3yr7J86BrH6j515K9o6s18qjs9tc9vWKV4RxcCouw/8R+tl9TLGikSP8PNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgYj4FVzZmWzsA64ovY24EtJob+udj1sTz18GmN2vZ1Zx4X+OF
	ag7neK7SNXq5f6wVZT1+PtoaBewMcAhdewlQFOzKXiQ39J8TS/5ahVFBlyIDrmKbs/c=
X-Gm-Gg: AR+sD10OsSQ/c7RhWnzdSMPFbC7kkcEhBSMVGmJlqvOWgOZXBz2sAOHG0TtGr1mg3Ka
	aZTswzAiDKsulV52Yik/tA4ISpzYsa0SlWBYmczhoVkmWhPj0DK+TSGrATzq+PGYuZyb17DpFkq
	UAmWqH674co9GQkttWQf9onR4Qp+DivoSt6XlVri/zQWDq2MGszlKateWgLQgu1FDu3ibzGiy8H
	V17+fqzfXKqCH+6SzQrClt4uFHoT/0JSglRA17IljOP6qKM7oN3l/cljxH3qFJC+lipScMy5QfI
	sxizuYfwgN3wll/oGHts8gNUSpeVe8kwkIlqwKZ5Iv6NRTJuhCkqhgAvl4bMhOC32VEXmQLGNuY
	qc7PT6TRkic6gu/fsLbbR6bXqH29FRvFGu0A4T6kARmiSEQ/ijHPn6rL4zfVkV+aY0Lutsp/GNH
	iFa/brY1lYajIR3LEV3gaQXR0Vas6CiOYZ2qTSC6iR8Q==
X-Received: by 2002:a17:90b:3b86:b0:381:bc4c:da56 with SMTP id 98e67ed59e1d1-38f9bde74d1mr2714794a91.19.1785426889854;
        Thu, 30 Jul 2026 08:54:49 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b99bda7sm1282895a91.12.2026.07.30.08.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:54:49 -0700 (PDT)
Date: Thu, 30 Jul 2026 08:54:48 -0700
From: Joe Damato <joe@dama.to>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, paulros@microsoft.com
Subject: Re: [PATCH net-next] net: mana: Extend RX CQE coalescing up to 8
 packets
Message-ID: <amtzyNmcIIYy6/bK@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Haiyang Zhang <haiyangz@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, paulros@microsoft.com
References: <20260729225235.3573786-1-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729225235.3573786-1-haiyangz@linux.microsoft.com>

On Wed, Jul 29, 2026 at 03:52:22PM -0700, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> To support up to 8 packets per CQE, put two packet lengths and
> hash values into one PPI entry by using the reserved fields.
> Update ethtool handlers to set this feature.
> Update per queue stat to show the coalesced CQE counters.
> This feature is supported on NIC hardware showing the relevant
> PF flag.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 137 ++++++++++++------
>  .../ethernet/microsoft/mana/mana_ethtool.c    |  30 +++-
>  include/net/mana/gdma.h                       |   4 +
>  include/net/mana/mana.h                       |  43 ++++--
>  4 files changed, 150 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index a8c329bdbacf..720d22e6aea9 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1241,6 +1241,9 @@ int mana_gd_query_device_cfg(struct gdma_context *gc, u32 proto_major_ver,

[...]

>  
> +static void mana_process_one_rx_pkt(struct device *dev, struct mana_rxq *rxq,
> +				    struct mana_rxcomp_oob *oob,
> +				    u32 pktlen, u32 pkt_hash)
> +{
> +	struct mana_recv_buf_oob *rxbuf_oob;
> +	struct net_device *ndev = rxq->ndev;
> +	void *old_buf = NULL;
> +	bool old_fp;
> +
> +	rxbuf_oob = &rxq->rx_oobs[rxq->buf_index];
> +	WARN_ON_ONCE(rxbuf_oob->wqe_inf.wqe_size_in_bu != 1);
> +
> +	if (unlikely(pktlen > rxq->datasize)) {
> +		/* Increase it even if mana_rx_skb() isn't called. */
> +		rxq->rx_cq.work_done++;
> +
> +		++ndev->stats.rx_dropped;

It looks like this code was moved from mana_process_rx_cqe, so this is prob
out of scope, but I saw this and was wondering if maybe rx_length_errors is more
appropriate?

from if_link.h:

 * @rx_length_errors: Number of packets dropped due to invalid length.
 *   Part of aggregate "frame" errors in `/proc/net/dev`.
