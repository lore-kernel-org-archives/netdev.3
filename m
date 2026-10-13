Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B6B5293F5;
	Tue, 13 Oct 2026 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791920966; cv=none; b=JqqGzckvKW69+lDzutroHnAyXT+KV9PWMdQzcdCdcGBcKcZ/Mi63xHSJ2oaBl50xic/6iiKmibcXFnOBHSIgpXtovTczV0MnykWdnoXitk+DZBRcViRmtYvRl84KTdcv2dxBissPddIQ9X7Ow3i8H0kzjaDGy7peIs8L5HKA0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791920966; c=relaxed/simple;
	bh=Es6cdmM6hV23YJSWwen0pAr0a1+Qz1UUN7NsfZVb5U4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmkR/6qvq4AGnPwrLqkgGKd8J+32kNftu+5AJAzw7C2JWAbY+Wg5PG95BAHKgvd/9ov30f5ReKSKrNxdx/qw6d1YjOwTR6HUp3o39yuS8aLgKOus9lX6c09AV4PzKGfY6sTXtBrQ5PE7UpRY4A1635BlMBxGrxG2eB4cR7asx/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FXpe+cvh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FXpe+cvh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791920971; x=1823456971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Es6cdmM6hV23YJSWwen0pAr0a1+Qz1UUN7NsfZVb5U4=;
  b=FXpe+cvhniEC57RQjZp45wh/z60r5B0sPBqyyI6hbxrMnCm+wCz54X58
   qgfpbj7j9Mv8G48TVEXKXwwN2jaJF6sQB1qe0+db2IsYWiAb/fPVqdyK/
   1bPoastGWlb9XId+21lZ/2dwrEBcmaOrdX9AZUk2XHenX9XRWu4nm3LwJ
   m3KoahesoGAwSTinBa8ZEEsvsftYKdVmGVu0uh8jHqEg/OrammfR4Zq3Y
   VWb4/u3tq2/Gv5tSyaekDBG9M+6uAhzRXS7YVJXAcwsKuwcUWCBMzeIv3
   Wpuy6yStKKlUyIL3Ak5Au1k143ERV/JuD1LkXYbv1wObZSzB1t+pQsgnf
   g==;
X-CSE-ConnectionGUID: UVmiyirnQrKGsgzYHdQOyg==
X-CSE-MsgGUID: y7DqraEARLiqHc4saHKz4g==
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="64984376"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 12:49:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 13 Oct 2026 12:49:23 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 13 Oct 2026 12:49:21 -0700
Date: Tue, 13 Oct 2026 21:49:20 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Anirudh Virdi <avirdi@redhat.com>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<kees@kernel.org>, <horms@kernel.org>, <ast@fiberby.net>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: qede: initialize extack in
 qede_flow_spec_to_rule()
Message-ID: <20261013194920.unq2yye3qnntl5yr@DEN-DL-M70577>
References: <20261013105451.201211-1-avirdi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261013105451.201211-1-avirdi@redhat.com>

> qede_flow_spec_to_rule() declares a netlink_ext_ack on the stack
> without initializing it. qede_parse_flow_attr() and
> qede_flow_spec_validate() only set extack._msg on error paths via
> NL_SET_ERR_MSG_MOD(), so on a successful parse the err_out block
> reads an uninitialized pointer. If that garbage happens to be
> non-NULL, DP_NOTICE("%s", extack._msg) dereferences it inside
> vsnprintf, causing a page fault and kernel panic.
> 
> This manifests when configuring ethtool ntuple flow rules (ethtool -U
> flow-type tcp4/udp4) on kernels built with CONFIG_INIT_STACK_NONE=y.
> With CONFIG_INIT_STACK_ALL_ZERO=y the bug is masked because the
> compiler zero-initializes extack, making _msg NULL.
> 
> Reproduced on RHEL 9.8 (kernel-5.14.0-687.47.1.el9_8) and mainline
> (v7.3-rc6) with the following reproducer:
> 
>   IFACE=ens2f0
>   ip link set $IFACE up
>   ethtool -K $IFACE ntuple on
>   for i in $(seq 1 100); do
>     ethtool -U $IFACE flow-type udp4 src-ip 192.168.2.$i action -1
>   done
> 
> The loop panics reliably after 10-15 iterations with:
> 
>   BUG: unable to handle page fault
>   RIP: string+0x49/0xd0
>   Call Trace:
>    vsnprintf
>    qede_flow_spec_to_rule+0x2b6/0x4b0 [qede]
>    qede_add_cls_rule
>    ethtool_set_rxnfc
> 
> Zero-initialize extack so _msg is NULL unless explicitly set by an
> error path.
> 
> Fixes: eb705d734525 ("net: qede: use faked extack in qede_flow_spec_to_rule()")
> Signed-off-by: Anirudh Virdi <avirdi@redhat.com>
> ---
>  drivers/net/ethernet/qlogic/qede/qede_filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
> index ab8b818588e2..e63422c945f9 100644
> --- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
> +++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
> @@ -1992,7 +1992,7 @@ static int qede_flow_spec_to_rule(struct qede_dev *edev,
>  {
>  	struct ethtool_rx_flow_spec_input input = {};
>  	struct ethtool_rx_flow_rule *flow;
> -	struct netlink_ext_ack extack;
> +	struct netlink_ext_ack extack = {};

nit: the fix breaks RXT.

>  	__be16 proto;
>  	int err;
>  
> -- 
> 2.55.0
> 

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
