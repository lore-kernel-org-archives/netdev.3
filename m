Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC43D25A6
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500119; cv=none; b=BydndHZ36aA0YhkliTeHAkh0b6H363PNQSRxHb6Zbfi339+NokZH67zxPBLv1FTNkmAh9MIm7TUm6IiqE9TvlhdUgBCfecAL7URARCkIj5KQgLmBK93Ylq6VaPjhPnRVKspcT2U3iGUgPuiVUCnBPBBp5ol+HyyXD9pCSI6d8Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500119; c=relaxed/simple;
	bh=xdfchxsR7Wq41rgm/Ya7ShMgL3xqmz4oufZvGj+Z50Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hli+QbnI0KBsWY9EvWNmc7ts1VX1MvtYba2t1njz2CT/32BVsie/n8+rYZYO/8jcijjHYvipEtnOwPX5X/6sAOoWU0JmcQOsbk/U8Ab3cRVGpRNu02t+Djg4/JZ/jtlwSaeF8ZY7OvWS7EbiJjmwQvU3UXa9zId+et5F/RGGeoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5iC7VvT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5iC7VvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596391F00893;
	Wed,  3 Jun 2026 15:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780500118;
	bh=9R827GKCMT4uRVqlmqvyLrBj4ZSfpdcT1JCHjCLnGws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A5iC7VvTknVKMTfu8YI1035IGTjku24P44g6o7KvXuVag66fqn2TIcMZaRre3M92y
	 HK0f/dM9uSwlGSGHHnermifZgOlv2PNslrLhnl/vFR+H7w2vu2/mAV4ExqJCfs/eaT
	 21nHJpgSVG7YEZWVlnGq2u35c/OgtKLw/lXOV/yurdNQcWRabaA6gIszBt6keJ0u64
	 JzOE4a7Dony1TOSSmeSwW5Nrb/oEys3PDiOPWg+YO5Z2ojE+c7F7ViApti13VLzxao
	 bq6WOV1cWmup+qbjkGVRSEQ5wA8Yc8Psx02rAKgBzyORqQRCQ02/ChcKBz6dbHdKLe
	 XaJIpbexbXpaA==
From: Simon Horman <horms@kernel.org>
To: mengyuanlou@net-swift.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v3 2/3] net: libwx: add support for set_coalesce in wx_ethtool_ops_vf
Date: Wed,  3 Jun 2026 16:21:53 +0100
Message-ID: <20260603152153.3795063-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529075147.88398-3-mengyuanlou@net-swift.com>
References: <20260529075147.88398-3-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: libwx: add support for set_coalesce in wx_ethtool_ops_vf

Add support for set_coalesce in wx_ethtool_ops_vf, which is used to set
interrupt coalescing parameters.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
[ ... ]
> @@ -488,7 +489,10 @@ int wx_set_coalesce(struct net_device *netdev,
>  		else
>  			/* rx only or mixed */
>  			q_vector->itr = rx_itr_param;
> -		wx_write_eitr(q_vector);
> +		if (wx->pdev->is_virtfn)
> +			wx_write_eitr_vf(q_vector);
> +		else
> +			wx_write_eitr(q_vector);
>  	}

[Severity: Medium]
Does this cause hardware register wrap-around for VFs when coalesce values
exceed 127 usecs?

The validation at the top of wx_set_coalesce() uses PF limits:

    max_eitr = WX_SP_MAX_EITR; // 0xFF8
    ...
    if (ec->rx_coalesce_usecs > (max_eitr >> 2))
        return -EINVAL;

For a VF, wx_write_eitr_vf() masks the interval against WX_VXITR_MASK
(0x1FF). Since the user-provided rx_coalesce_usecs is shifted left by 2
before writing:

    wx->rx_itr_setting = ec->rx_coalesce_usecs << 2;

Any value greater than 127 will pass the PF-specific validation limit but
silently wrap around when bitwise-ANDed with 0x1FF in wx_write_eitr_vf().

Could the validation logic be updated to check against the correct VF
limits before writing?

> [ ... ]
> @@ -844,6 +848,7 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
>  	.set_ringparam		= wx_set_ringparam_vf,
>  	.get_msglevel		= wx_get_msglevel,
>  	.get_coalesce		= wx_get_coalesce,
> +	.set_coalesce		= wx_set_coalesce,

[Severity: High]
This isn't a bug introduced by this patch, but does enabling this callback
for VFs expose a potential NULL pointer dereference?

wx_set_coalesce() unconditionally accesses wx->q_vector[0]:

    if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count) {
        ...

If wx->num_q_vectors is 0 (for example, if wx_init_interrupt_scheme() failed
during resume or setup, but the netdev is still registered), this will
dereference a NULL pointer. 

Should there be a check to ensure hardware queues are allocated
(wx->num_q_vectors > 0) before accessing the q_vector array?

>  	.get_ts_info		= ethtool_op_get_ts_info,
>  	.get_link_ksettings	= wx_get_link_ksettings_vf,
>  };
