Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0D83242B8
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786203130; cv=none; b=offYic/VFV8eN+epnJ1UYvynkec4Qj7a6L9Eo56SYMvIKYprPKN41fSZvfg4mPVu6+WEdTVMNvLNOy0uQ8QfvJ8dYw1yJtahFH8iIGydYDblFu7YnWYJK9+Z7f3UReBCPpkXEGv0UYgUKivAoDyYd/JZ/N6Fxr5IS+gl39iFMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786203130; c=relaxed/simple;
	bh=avg/jQxBOIQlx57U/8c51C+uOom6aQtP9E7HIUCJewM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HlevO4L2NpSToCIT9MMWp3WZq9D9ybq6RVFdyXdlVrRptkW0gd6bTbyM3YdpnJV8k1mJk1jm6lS66U1SSpHiUSIBwkfImnUGr9dLusZUsqpQqWs3wW3QAarLn34LpCHz5pQ7h8nl/eeFvfA+y6USwnrKTv/7mh/VttFgVQTqhpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON+Hyay1; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON+Hyay1"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66807ba2f0fso739182d50.3
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786203127; x=1786807927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v+UUcaMhlc8IxxN5aJcZYdqNcrd7TqnKbW0pUSKDh7E=;
        b=ON+Hyay1LSWS59W3l+mnz5HGcULEhNAehZMtVyWc/VKWPtHvIOE25pPZrHlFFiYYdZ
         xCFxsth68pQ8hdvO0ALrs8Tz9AdkFm4gm2tGCjMBh0sMXjHVhpvCOQ3OZo7bMWHP4Yd7
         O2Gw6hLQpYKePWbpZMMFALE751Bo5oJ7pew2u2OLaJrRXCszMDsU1TOnch3wK5iiVRLF
         Rw9Q80E+qR0F0m3LYDfAt6ROghL9YlhiHLKYb42gL6zdZIZKCzr1pyKBd1VLzy4kgDGt
         ofYVDpufdui7HBtlSY0lRAgkuiY0OuvMT+/17lAB9u46GeszmmI7waFy+3ER27LRgU0h
         7QTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786203127; x=1786807927;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+UUcaMhlc8IxxN5aJcZYdqNcrd7TqnKbW0pUSKDh7E=;
        b=iPxUd5TldUr87r0jOPnzydoHFc5b5gvpVaGFumpwUoFgQufHYvdXXA2vdtjlSHibNc
         yCQrgIvQLqoq+vfZ3uE+zG/Ie61zRqTR/mbDGGszlrNAfcaWedIozT+Oy3n8xDdJrCXC
         djkFQnBz2tIohJe1dn1pN+veKBOy31m6ZxUE/abdkQhrZ4CjV+00OtRankvWbSyxEEEd
         VoI8BQsBHtPhTFBKQVJib/50nEeFZRpFqsO55j7udx7EAfEDK1HiSlbW1fE3Z4Fu5yEA
         l6jHDD4l6IP1u4e3mIqKzkvgSrBnXSVcpjr2JG57/PeR/E8a6B2Q03ffMoN9aJFonu6Q
         0VuQ==
X-Forwarded-Encrypted: i=1; AHgh+RrLpckO/OeZ2WbJAYtflKd92dcSKwBRId2n3N1MYMoUgMCUH5yrYkDVDNdTbspJgTD0aV38vYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgoTU2odXCRfL0/hG41wPsMuV4D/E7kfDtr4gcGMqq3S2FsPVT
	BfV9bTfuLwGKxdH98MOA/1BdzD0V9qguNeo3lpcbX4N8OeKGozmrNRSK
X-Gm-Gg: AR+sD137JNjUxxTDgmu4rNvee9bT3QL9zcESsmMe66NkrS6HE0I+O9dFaJp/B2ZaLVz
	n+mTxpfwXqc1gFvmKpEieY5iDAzy+b32V4LiuSi1ODD26C1FRNiIBBEKSTvoZh/KecxW8xmOwjz
	O/Gd2e/In7cyDNMdIm1F1mWq7lH7JXRQhJu371YJo7G8uDuV5byEDGhzv/XCswvgmQJ/YiKvOEZ
	+IfYEMqBwI8CGnYRBnGnob6fM3p/up3M0SG4QwEs36BFy32n2QYR3vVGXv79fVWR1fCYNmAuhWb
	gvaMmItetJtpUQuv31yPB19RhpKIQYyHAVVAbXfz43Dr02Ep/9YFFNL0k3HQ3IAmzMPnO+jwGMy
	bgPo7WHE+w4jNqrF0jwRhBXQpRDXepWqosqlT5GggSfhRsZaWHsSmfJuSe2Tikw3G1FRHhNBGur
	RVqmdlatQ6k7RL/0vtosmTnVY2/gRFo6dItdDx1ZsDBndiWRy2hmbLZ3ppMqJ6fAAz6IN+FeIAE
	qt5aXDKDKAiV5+2U/MC4GqcAK5KqANbW28/c9DbfVsKpm0=
X-Received: by 2002:a05:690e:1504:b0:667:c3f6:3810 with SMTP id 956f58d0204a3-66ad73a7c6amr4278650d50.49.1786203126984;
        Sat, 08 Aug 2026 08:32:06 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acad51b8csm3171220d50.8.2026.08.08.08.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:32:05 -0700 (PDT)
Date: Sat, 08 Aug 2026 11:32:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: wei.fang@oss.nxp.com, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 liuhangbin@gmail.com, 
 mst@redhat.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 sdf@fomichev.me, 
 liuhangbin@gmail.com
Cc: wei.fang@nxp.com, 
 imx@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <willemdebruijn.kernel.7f71161e0a6b@gmail.com>
In-Reply-To: <20260807063405.688780-2-wei.fang@oss.nxp.com>
References: <20260807063405.688780-1-wei.fang@oss.nxp.com>
 <20260807063405.688780-2-wei.fang@oss.nxp.com>
Subject: Re: [PATCH v2 net 1/2] net: packet: fix wrong transport_header when
 sending VLAN-tagged frame
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

wei.fang@ wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> In packet_parse_headers(), when processing a VLAN-tagged frame,
> skb_set_network_header() is called to advance network_header past the
> VLAN tag to the inner protocol header. skb_probe_transport_header() is
> then called with skb->protocol still set to the outer VLAN EtherType
> (e.g. ETH_P_8021Q), while nhoff (derived from skb_network_offset())
> already points past the VLAN tag to the inner protocol header.
> 
> In __skb_flow_dissect(), proto is initialized to ETH_P_8021Q and nhoff
> points past the VLAN tag. When the dissector hits case ETH_P_8021Q, it
> reads a struct vlan_hdr at nhoff via __skb_header_pointer(), but that
> offset contains the inner protocol header (e.g. an IP header). The bytes
> are misinterpreted as a VLAN header, yielding a garbage encapsulated
> EtherType that matches no known protocol. The dissector returns false,
> so skb_probe_transport_header() never calls skb_set_transport_header(),
> leaving transport_header at its uninitialized sentinel value (~0U).

Not for this patch, but: having a mismatched skb->protocol and
network header offset is asking for trouble anyway.

The blamed commit states that this block is here for GSO packets, and
the mismatch will by fixed up when skb->protocol is updated in
virtio_net_hdr_set_proto. But that only updates GSO packets, while
this block affects all VLAN tagged packets. Both GSO and non-GSO
should be treated similarly throughout the stack. One approach is
setting skb->protocol here. But that does mess with anything matching
VLAN packets. There does not seem to be a perfect solution..

> Move skb_probe_transport_header() to before skb_set_network_header(). At
> the time skb_probe_transport_header() is called, network_header still
> points to the VLAN header, so nhoff correctly points to the VLAN header.
> The flow dissector can then parse the VLAN header, extract the inner
> EtherType, and advance nhoff to the inner protocol header, allowing
> transport_header to be set correctly.
> 
> Fixes: dfed913e8b55 ("net/af_packet: add VLAN support for AF_PACKET SOCK_RAW GSO")
> Assisted-by: WChat:claude-opus-4-8
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
