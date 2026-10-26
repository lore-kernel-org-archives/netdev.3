Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999966;
	b=sswNGVLRs1nvcXklYmju9u0AsGVkSPVe/qTDUxb+et5CDS6FGDUUdLObbkWGlUH6sGDT
	 tC61D9Bh2lQQT/Od/4EUiTuhkdk8zrPOd4ybZGu/BPmcQP/cZa+U7brHtrSfDV5liQymb
	 45Qy136gohh55UaoQAso6ZmyygepRSDHLSZtVJCYPhFbC+c6omKeogyV9Zwdkf2G0RNMx
	 mwi1+z/ujQ3It94+fEtLg83z0pVQ98ovi7vpEwWvzS63sJBqj80y+qLG/FhL4FOlvwOmG
	 CPVL5N113Nc0sUQo0eQHeO/4Zt37tAkNRqVlBWJWwUjR+KdthcpU7fELZYPAnbWW+9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999966;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=W+cxyww2TucNEepNfRrQ0ekDRXr+LHAHYoofn3JixiI=;
	b=1STtIzrxeQrgm1uDUjfHWp/uAdjjbS4ERHUe2mx2ziAHPX6ybu+OS7NrhI05kVKFlRuJ
	 d+sDe9XVJh8DjFmACVmMID59mvHvihaDL3wiqA1MC/USYeCfihCzbArUkkWZjkijOtrhE
	 9had0OLTqg7OX8nxEpAjEF8cwnbSy2GqXlHTtm4dCSgfe5tBlTfwAglNWRqN5zEN4juu0
	 4Keh5j1jN4MlbQspdUlPjFCdIKbk8NNIKPyq5kfggiFdLgx8Mu/thny+6+imJJrIwm0Dl
	 5+Wqu9CDyHcz1jA8wT85FfrhiwU57gKJDPe7dboAsF4DatefFcF7OsQdfr4m2FIFCBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=puZ9RAZF;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC4606A31A;
	Mon, 26 Oct 2026 07:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31FC4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=puZ9RAZF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792999966; x=1824535966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7xCx4d3ZGL9TKpbq2riWZWJdYVevoxdH+V0DwFIpJy0=;
  b=puZ9RAZFKyGBVQtFhlj+WLHMB4Z6vBxAdASC3LmccygbwTw2wh5CtdZY
   ntnPXeirPd4dah3tAM43XOcYUe4ftwl5Xyau8yUQFsXn6JggxhBdnB7TW
   ScEaISnzEF91nnJyNdGtrrB/+SYMo+U+KJR0vKDKlSdnjtoWCkhD1dqA0
   QACjsqmDoxmoJSQ9SBqCtuZNBuF00RW3kQdmPMTf0IcmI6NS9XJ0vmPnK
   PijS/fF+xTcb8NuoBvUyKtWERI8QgJ2iBbf9wkt6KtsQeA6ngQ0+Ba3YN
   fY26vALTFjOmvaMD5fO0CBIHTH7/HO702IpQnkTR697ROB4zH1g0990tq
   Q==;
X-CSE-ConnectionGUID: lx7BMXXCT0Kk/SReMKYRFA==
X-CSE-MsgGUID: z6QjRkdEQLmY3DY7Pm5BNg==
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="296974928"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2026 00:32:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 26 Oct 2026 00:32:38 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 26 Oct 2026 00:32:36 -0700
Date: Mon, 26 Oct 2026 08:32:35 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: dcb: initialize PFC value before calling
 getpfccfg
Message-ID: <20261026073235.3huvz6o5h6psyv76@DEN-DL-M70577>
References: <179289284460.50470.572724041164324949@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <179289284460.50470.572724041164324949@gmail.com>

> dcbnl_getpfccfg() and dcbnl_cee_fill() pass the address of an
> uninitialized stack u8 to the driver's getpfccfg() op and then put it
> into the netlink reply unconditionally.  The op returns void, so the
> core cannot tell whether the driver wrote the value.
> 
> i40e_dcbnl_get_pfc_cfg() and ice_dcbnl_get_pfc_cfg() return without
> writing *setting unless the DCBX agent is host managed and in CEE mode.
> Both drivers normally run with firmware managed DCBX
> (DCB_CAP_DCBX_LLD_MANAGED), and i40e with FW LLDP disabled runs host
> managed in IEEE mode, so on a DCB capable i40e/ice port the PFC values
> in DCB_CMD_PFC_GCFG and DCB_CMD_CEE_GET replies, and in the CEE part of
> RTNLGRP_DCB notifications, come from uninitialized stack.  The same u8
> is reused for all eight priorities, so this is one byte per reply.
> 
> dcb_doit() only requires CAP_NET_ADMIN for RTM_SETDCB, so the GET
> commands are available to unprivileged users.
> 
> Set the value to 0 before each call, like the PG config path already
> presets its outputs to DCB_ATTR_VALUE_UNDEFINED.  0 is also what the
> reply contains today on kernels built with CONFIG_INIT_STACK_ALL_ZERO,
> so nothing changes for those.
> 
> Fixes: b94b013eb626 ("ice: Implement DCBNL support")
> Fixes: 5effa78e7c94 ("i40e: Add netlink callbacks support for software based DCB")

I am not entirely sure, but should this patch add a fixes tag for a driver, when
the change is only in the API?

Also, if this dates back to the introduction of DCBNL then I guess its not a
regression and maybe a fix for net-next?

> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
> ---
> Found by code inspection, compile-tested only (W=1).  I don't have
> i40e/ice hardware to check the reply.  On kernels built with
> CONFIG_INIT_STACK_ALL_ZERO the byte is already zero, so in practice
> it only leaks on builds without stack auto-initialization.
> 
>  net/dcb/dcbnl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
> index ab71f53128..ad0aebe0ad 100644
> --- a/net/dcb/dcbnl.c
> +++ b/net/dcb/dcbnl.c
> @@ -281,6 +281,7 @@ static int dcbnl_getpfccfg(struct net_device *netdev, struct nlmsghdr *nlh,
>  		if (!getall && !data[i])
>  			continue;
>  
> +		value = 0;

Why noy initialize this at the declaration, like getall is?

>  		netdev->dcbnl_ops->getpfccfg(netdev, i - DCB_PFC_UP_ATTR_0,
>  		                             &value);
>  		ret = nla_put_u8(skb, i, value);
> @@ -1395,6 +1396,7 @@ static int dcbnl_cee_fill(struct sk_buff *skb, struct net_device *netdev)
>  			goto nla_put_failure;
>  
>  		for (i = DCB_PFC_UP_ATTR_0; i <= DCB_PFC_UP_ATTR_7; i++) {
> +			value = 0;

Same.

>  			ops->getpfccfg(netdev, i - DCB_PFC_UP_ATTR_0, &value);
>  			if (nla_put_u8(skb, i, value))
>  				goto nla_put_failure;

/Daniel
