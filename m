Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A6D3F410D
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025527; cv=none; b=fHnILnCq9Vo2kOcPzyzc5H/iTjHFCqc51xVB8txLvZVIa4WtZMfPIF5HuU69PgHy84SXn15YX8/Cyq2MgnGoJ5pdykLAwJ5nGcDMRrdQ+htEtCyjROLdLdsI3SykiF2tY/KmSYIl/aIMnLjMISSCQ39p61BnlwrXp/ZDGLGxJsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025527; c=relaxed/simple;
	bh=oIFZLgKvVdWRb4naDCDvsBD7Te5I9qLr1vHo4bzNbqQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EeCUwMIeVQLcMF0vVHl/9SC/4NbItShQBB9KzTfdDHVUy7Drgyi2cLCgX6KFVpu+NtONnHQf32JYjNo3b6fJuap5XDRbrKfOuTaBJigTzq5sYiMiOrBuLeqsc05ie2kw+Piz1K/wVkOHfk+3Noa+l41aQlEAOpXFTNB6OwEu7Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLSqNdkn; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLSqNdkn"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81f3b227a4aso36136467b3.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786025524; x=1786630324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aSW82hn/Az1oQv4R5HnyuZcVGEyW1WS4dZZfeeZQW+g=;
        b=LLSqNdknQYvoevWk3ubCODLLvb7052isEN/xWDyBu8fh0P9xOWuejCs12NrffcX/+7
         CB9OVajxVUo6rsLD3MnkMT4qY/YfJK3RIkWIYvSW1/A6pUuvSgSBIMuKbBiF7NBgSYgj
         YUJl4M0AVr1O5B0lkeI+xVlGcyG7HXEWPHsVWeCawKNLV7pH01wJ/N1sPpaH9YNb14s1
         GX1GAgjevYV7fxsvXcKduWHFyio/Mu/nMjdCX6/rMk2zSYsRFClO3n45+/KpgkVcXgmk
         TwGNXYmjl2yETnj6zrIh9vogzDt10vm8aKL1ximvte3NMP4wTdtowPgquR9gVRwM+41H
         mnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786025524; x=1786630324;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSW82hn/Az1oQv4R5HnyuZcVGEyW1WS4dZZfeeZQW+g=;
        b=MujMTwH5hEFoGs/Ca+LIGYKRi1oOdVzdmf3PN+pEouCgqjFTPBRCSRBegKgDkPSU0J
         TBl13tx26GhM/xkWuhP58rSb5OK7npbxP8W1x/fprEn08hl5nmTV4tD142UjpoEqH5aw
         0Tg4MeS43sR4JXq8ncwtx0MoHCUK4806J6csb9Ymq+YzUS00EDdXDd/cKBnh1GIBMbRE
         IikYDhhYlbnnKGfaohzX9viUxe/eIvlaNMv7uHwteDD8qNHriSTfHlJFwtgr3ZMe/6N4
         PNUtYEpgplbyki6IiF22UJ9oPvUcwry99ocApow3qRIjZzal3MKCjTVBBLYJqb7mNcfb
         xOrQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLQDGC7hwE6kU4mHjPCj3yiXhQ+b+vFUDFKYKfiFoD9OKVGnwdJx0p0VMXPrWG9NauuWjdj00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIlFuMGTnuAe49LvoGAK7Wk7PMpooTGL4RxCpJIu9hxS76rxMb
	YiAS3ZvJomEd10DuEetNdSWJeyy1oyOX+4xKYWqFKh4upYFsJqVOTD+E
X-Gm-Gg: AR+sD12/74LHBl/fGpN+5p8pofq7onGnNDFGoFtjibIi5nuQIR08JKafqX2VgN7xAd/
	TN81sodOsfqcBhar/mZgOJAZx14Fq9S2ydtZR8yODpeaoLvjjUXDIZFhT2g8NVIIVwXwBHhN/nK
	WAduH1lHToNQbBnaoz2fB6+Wvn1Y0UN6rgUnWOZgbAmL0JWi+WHlhaeCHDVj+YxnALgCzZom52M
	/jJc/jOnrCZhaFWulPcRlzN4WdmG2xxM0bjbQpk+FcJqLZGt4tvgEeY5SgPDqtFbaxmGbm16POJ
	V9DZ0Up5/k7iGRFpAri298Tcxp1T+hwY5H0PmFCGUWEdnjrKcHkCM5g4fvndGT891XcrVM1AdFW
	0aXqr7rxeDdI06K+HIwnI97c3YZhuCh7u40cUrxv1J7ZZXS0I+f/udvGO9f3XEv9+jvRrRwrG57
	ErBSRJB3Gf2ZkhlFyb1K41Uql1585SKwMh5cEzl6MiM0W2K99+oELRkI6KMrbrtAEEEVCdh8vY1
	9hoOmgrTf2So+fG3a0K3h8yRPOesjs/xiS5
X-Received: by 2002:a05:690c:c04:b0:804:a2d5:1e04 with SMTP id 00721157ae682-820222e54d2mr90939827b3.16.1786025523580;
        Thu, 06 Aug 2026 07:12:03 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820131db335sm39579797b3.3.2026.08.06.07.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:12:02 -0700 (PDT)
Date: Thu, 06 Aug 2026 10:12:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wei Fang <wei.fang@nxp.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "Wei Fang (OSS)" <wei.fang@oss.nxp.com>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "horms@kernel.org" <horms@kernel.org>, 
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>, 
 "mst@redhat.com" <mst@redhat.com>, 
 "jasowangio@gmail.com" <jasowangio@gmail.com>, 
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
 "ast@kernel.org" <ast@kernel.org>, 
 "daniel@iogearbox.net" <daniel@iogearbox.net>, 
 "hawk@kernel.org" <hawk@kernel.org>, 
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, 
 "sdf@fomichev.me" <sdf@fomichev.me>
Message-ID: <willemdebruijn.kernel.1f5ad76837fbe@gmail.com>
In-Reply-To: <GV2PR04MB1173961FAF524C3A3FB49204888D22@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260805105314.3882595-1-wei.fang@oss.nxp.com>
 <20260805105314.3882595-3-wei.fang@oss.nxp.com>
 <willemdebruijn.kernel.4a69732dc0a4@gmail.com>
 <GV2PR04MB11739F20D97C6507DB388951388D22@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <GV2PR04MB1173961FAF524C3A3FB49204888D22@GV2PR04MB11739.eurprd04.prod.outlook.com>
Subject: RE: [PATCH net 2/2] net: tap: fix skb->protocol not updated after
 VLAN network header adjustment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wei Fang wrote:
> > > > --- a/drivers/net/tap.c
> > > > +++ b/drivers/net/tap.c
> > > > @@ -1081,9 +1081,15 @@ static int tap_get_user_xdp(struct tap_queue
> > *q,
> > > struct xdp_buff *xdp)
> > > >  	}
> > > >
> > > >  	/* Move network header to the right position for VLAN tagged
> > packets */
> > > > -	if (eth_type_vlan(skb->protocol) &&
> > > > -	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
> > > > -		skb_set_network_header(skb, depth);
> > > > +	if (eth_type_vlan(skb->protocol)) {
> > > > +		__be16 proto = vlan_get_protocol_and_depth(skb,
> > skb->protocol,
> > > > +							   &depth);
> > > > +
> > > > +		if (proto != 0) {
> > > > +			skb_set_network_header(skb, depth);
> > > > +			skb->protocol = proto;
> > > > +		}
> > > > +	}
> > >
> > > Does the same apply to the same call in tap_get_user?
> > 
> > The situation of tap_get_user() is different, skb_probe_transport_header()
> > is called before the VLAN adjustment block. So I think transport_header
> > should be correct. The only concern is whether skb->protocol needs to be
> > updated after calling skb_set_network_header().
> > 
> > I'm not sure as I am not fairly familiar with the tap driver. I added this patch
> > because Sashiko reported that the tap driver has the same issue as af_packet.
> > 
> > >
> > > And in general to other callers of vlan_get_protocol_and_depth,
> > > including through wrapper skb_network_protocol?
> > 
> > I don't think this issue exists elsewhere. The issue arises because
> > skb_probe_transport_header() is called after skb_set_network_header(), and
> > at this point, skb->protocol and network_header are not synchronized ( In
> > __skb_flow_dissect(), nhoff = skb_network_offset(skb) but proto is
> > ETH_P_8021Q or ETH_P_8021AD)), causing skb_probe_transport_header() to
> > fail to set transport_header correctly.
> > 
> > Perhaps the correct approach would be to restore the original `skb->protocol`
> > value after `skb_probe_transport_header()`, maintaining consistency with the
> > previous behavior; otherwise, it might introduce new issues.
> 
> For AF_PACKET, it has been confirmed that skb->protocol does not need to be
> restored to its initial value; otherwise, the egress tc flower for protocol ip will
> not match the packet. A known issue is that the packets cannot match the egress
> TC flower rules for protocol 802.1Q, but this issue exists before this series. This
> is likely a limitation of using AF_PACKET to send packets.

Actually this update of network header to start of the IP header may
have been a mistake. If userspace inserts a VLAN packet, that is what
should enter the stack.

But for this specific issue: would it make sense to just move
skb_probe_transport_header before that adjustment?
