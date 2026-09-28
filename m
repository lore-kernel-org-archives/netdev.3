Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561E3CFF49
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 23:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790639998; cv=none; b=MmgskLfV7p1FF7u+L+eaYrjtaCNtU/trp1VctpnRrwAbReor4FvoKf4bsZzipNj6h7DnrwdEWrvcVfDh9RQKhdmEty2017D3+pM1IxLzE6kVdiEKXoRLz1tcs+mHOKRpgd+PS3MJE2abF5VQRXeWK0db8lqYs/Amm1poFNS3Wok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790639998; c=relaxed/simple;
	bh=0McVIF+957NznDcxr6YE1XinPsyk21F2ddwRcHBLNPY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=onPgoTWnMZGGTfO0a8Syg8MUePQeSeJRJGuG4QytFUA61TE6oRyMlQJ/oLhn6ske7KbC7eOrL7TCNDDTSPjalc/7n0g+jFfufELKWcsHTCgXthNmBDvuUk39RTgxoNipduv7hdG4ViqiMcnDfk+8J/7IOne29E8krBsPLo6dbGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qeVz78F1; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeVz78F1"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8a8f3f7ff7cso28125377b3.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790639996; x=1791244796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bPam/rNOgWfNzKvIbPiu5X36dfYWg6BSNZ+Rj2PyNEs=;
        b=qeVz78F1Pc9uLpCJVEBBCATnmLB31n0Z27t95gz5pi+N/Vz+KSvXtKMzz8Uyop7MQ9
         180wS7y0ZBbvdQkb//YKg8aRALY2ayQlGvyG/cs/W0URq4p8ut9Q8e0XdG+hUaZ6K4Ed
         1N7HU3J44EzAaTMFpb4wOgcBC0fNLhjM91ssl8gYVVPWKE2BPVW2ppuUDRaS1NnI+7pe
         tYNZhGrez5fxHykXbHKhD2UxhB2O3JKTDANg9R7Y4r7hvWys0KL7MOJ2JwPxqoSFap2E
         SrbOF9sKAcM33KiGDEXsgBe8OQ+BAhhqErWedD1LyM3/MM+SQITKFGtoezSWEwZrJjL7
         /CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790639996; x=1791244796;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bPam/rNOgWfNzKvIbPiu5X36dfYWg6BSNZ+Rj2PyNEs=;
        b=gtajaUyMJauD7xY05JGbDSMOpnFZrJFsMfQv08MpSC5McJZDz6ugGI2OkrlBpDVMiR
         uIuVpdqRFBZb/cUqvzSuBMuc4R80ykN8I6vJ8AVYxn8hRNLA6JsWPwfrORmZRfvzl2fY
         RYrNbs+KwMRtEhyYnBO2RefYL9C8v6g+aZH28W87Vh4EU2UI6zj3Qy1IfvpGILjuSj5C
         d9o125lqCEQZhtKkOrwKYlyMO/4k1PJTL0DWMzrRbMDCZvj5q/5dnZu97JDTcKSCDVhW
         3mLtIKtbEnLp6Uhs/YxM3gMIOq0lhVvggAZDvA69fGFcLJEMyFIUoqOF/ohUH0qw5jE7
         KWIw==
X-Forwarded-Encrypted: i=1; AKwUvBwITMwA1ll88Zl8o637FbryqNjPVTxdtJPnbHvfyCljl1ueFewmpqQotW5W0ZtzsUMUV2hbnDk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYJ8ylMMYM3PMdwas5S+uZmU1tTEliB5nT5UPgXsiZwoL2y08v
	u/kRzKJ8NDrj8XsNvnYPpprQeFfFgEkDySSBbvyJiw/YKzuXL9efpSSr
X-Gm-Gg: AYBFou0Nmf78QYPystjG5LtmsCfWFpLpPZCAhgBkVDOy8h5am8sDvPTxGct7oIdlodf
	f5kTxDayeqOUQuOzoqjpk4tc82uo9zjTxj+re372pqfnZeiVR2Jm0YNef9VZzPWBrk3aMIWnCOj
	/9scgisRJ5V2ksK/bUJ8RWki+SO+of+PjLeIICpKFzzOW3ssyE52fHKR/XeiIuBBEzS/Fzwpb5V
	uR496exme9M58drgUdjQ/m17iCQyQEEHCwsR1FDk6xB7tuye/rSGm31ynNBIG70RhqNabsQFIeZ
	LkTvMAL724J59f9Vcr/jUE+eGxxoUnUg8xdDUn9v5mha/LBjjDVaqAwNv6IZkvqK5HY5A49A9Vs
	T50pAzPvEBQ/VTIIo9O4bWxLwfN8EF1kzO/WGZ3RjZIesb6GUjrOd/zHe5MMztSNWn3bSMbt1up
	tut8JtUd2/3B7tgShPcr1X/DLw92IZii8KId0gJG1v32eYgENvJPiTJFn70iRpKEWat2KrYGDxV
	XEHRDOJY4kgLcJ2oM106qydGm8BkSYacnx5adxiE+pW0i437TVw
X-Received: by 2002:a05:690c:c4e8:b0:8ab:3dc2:a4b4 with SMTP id 00721157ae682-8ab3dc2a965mr4005777b3.22.1790639996000;
        Mon, 28 Sep 2026 16:59:56 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a86104911csm52086127b3.44.2026.09.28.16.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 16:59:55 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:59:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 keyong.sun@smartx.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 dev@openvswitch.org, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>, 
 David Laight <david.laight.linux@gmail.com>, 
 Wang Zhan <wang.zhan@smartx.com>
Message-ID: <willemdebruijn.kernel.3638f2d1c29b1@gmail.com>
In-Reply-To: <20260928044102.1004310-6-wang.zhan@smartx.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
 <20260928044102.1004310-6-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v3 5/5] net: net_test: add tests for bounded GSO
 segmentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wang Zhan wrote:
> The GSO engine can now be asked to bound the number of MSS segments which
> go into each output skb.  Add KUnit coverage for it.
> 
> The parameterized GSO test gains a max_segs input and three cases: two
> bounds which cut the input into two and three output skbs, and a bound of
> one MSS, which must leave the ungrouped output of the unbounded path
> alone.  It drives skb_segment() directly, because the synthetic protocol
> it uses has no gso_segment callback, and stores the bound in the GSO
> control block itself.
> 
> The TCP test drives __skb_gso_segment() with a bound of two MSS and checks
> that every output skb stays GSO, keeps its gso_size, and stays within the
> bound.  The length test runs a 200 KiB TCP skb through
> validate_xmit_skb_list(), the caller which sets the bound, and checks that
> the length declared by every output matches the L3 length of that output.
> The limit test checks that the GSO size limit which netif_skb_features()
> applies follows the packet's L3 protocol, for an IPv4 and an IPv6 skb,
> also with the tag inside the frame.
> 
> Assisted-by: LLM
> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
> 
> ---
> v3:
> - add cases for the length a bounded output declares and for a bound of one
>   MSS, which must leave the output ungrouped
> - cover the IPv4 half of the limit test, checking the protocol's own bit
> - skip the TCP cases without CONFIG_INET and bound the expected index in
>   the parameterized loop
> - free the skb and the device on the failure paths
> - reserve headroom so the VLAN step needs no atomic allocation
> - drop NETIF_F_TSO: the transmit path passes the features without it
> v2: https://lore.kernel.org/20260918084651.3022878-5-wang.zhan@smartx.com/
> v1: https://lore.kernel.org/20260917063854.2011613-5-wang.zhan@smartx.com/
> ---
>  net/core/net_test.c | 347 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 347 insertions(+)
> 
> diff --git a/net/core/net_test.c b/net/core/net_test.c
> index 9c3a590865d26..a4f61398a90ab 100644
> --- a/net/core/net_test.c
> +++ b/net/core/net_test.c
> @@ -4,7 +4,14 @@
>  
>  /* GSO */
>  
> +#include <linux/if_ether.h>
> +#include <linux/if_vlan.h>
> +#include <linux/ip.h>
> +#include <linux/ipv6.h>
> +#include <linux/netdevice.h>
>  #include <linux/skbuff.h>
> +#include <linux/tcp.h>
> +#include <net/gso.h>
>  
>  static const char hdr[] = "abcdefgh";
>  #define GSO_TEST_SIZE 1000
> @@ -34,6 +41,9 @@ enum gso_test_nr {
>  	GSO_TEST_FRAG_LIST_PURE,
>  	GSO_TEST_FRAG_LIST_NON_UNIFORM,
>  	GSO_TEST_GSO_BY_FRAGS,
> +	GSO_TEST_BOUNDED,
> +	GSO_TEST_BOUNDED_MULTI,
> +	GSO_TEST_BOUNDED_ONE_MSS,

nit: bound is not a helpful name for this feature.

The default segments to a stream of skbs of MSS 1, so segmenting to
a stream of skbs larger MSS to me is not bounding. Quite the opposite.

Not a comment only about this test patch.

Perhaps partial or re-segmentation better captures it.

> +	{
> +		/*
> +		 * One MSS per skb is what the unbounded path produces, so a
> +		 * bound of a single segment must not change the output.
> +		 */

so setting max_segs = 0 is equivalent to setting max_segs = 1.
