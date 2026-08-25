Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754AC351C25
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675197; cv=none; b=cXS6qrEvy7ezqyQpbjpZxGvFNdpeZ33EW7Z4FLgQvHg3GyXY+NNLXoiNRv4jaLUsW4JQswQJOTOCkT0yETD3/z81LJGV2UiHb/VxWaFxR6O2wQkmOKASkCVZ2bwfZ5W1lqD5wmWcYe3dZ/uScL20GwSKGIlfMtvuHKW77AE+XKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675197; c=relaxed/simple;
	bh=hUVt5X1WwR9vSGlMHdu9iOHRAOi/uatXuwsdCkP5nFc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Hbyp66R84dhM2tZaJNIzO1mAvSqwsGF/qPDtHMWgnbgJzUAoGWfns/QyJfeAi5LPqrSFfnhDa2L65w67jpW6rkbOPK/naGW1HJqMAhmIJoRmzyVnxrnuXsTIdlU6YaYn0cf/LueKAm3DBnCfGaL8rw7VgeNNLkEx00iM5xd3Seo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCRxvFwx; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCRxvFwx"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66d14734b9fso1670038d50.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787675195; x=1788279995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=abwfvPGDYkGjwGbBLKqedUFOZOoEMQvzYxlYlmb7AD8=;
        b=WCRxvFwxXA+869wD5/kPzG4KGlxhdFYPD47zbCjaqH6k57MJMj5Z3pbErznSPkb2fE
         qoLsomtegSpFMzrLSV9S/kDLdyRDXeediCruiGr24w7UpTkp2z17zlzBGjHqvMj4pvj/
         jxFH/9Lmafky7HEF1UgjDueBuu2vz7ylTzT0NYq/Lirdog+2d0QiEhTmXp1c9caVv4hA
         tU5IvsUY57SDolZ8gKdViAKvSxz6/26QkMLy/tmQbNv+F7VRGtsMlVV/f7ZXOfekOF5U
         htnj3FI+eCWxk0noUDfILDHU0hZjFlLLhG/ir0ChU4z9I7bXiR/5VNaEJ+FNUlrr2sfI
         YqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787675195; x=1788279995;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=abwfvPGDYkGjwGbBLKqedUFOZOoEMQvzYxlYlmb7AD8=;
        b=gtkm5M2O2kVqDNOiiZRbxtuqM40g2ZgKRY0zZQge4a6ZnXUQPHp63FbdK2VKXAmenS
         On8QCj4ykNcG7xbEJOyRdhwgj3/w/rOQe2f5Kvp45AbdCCl28W/iyzDblzWL+o6/tU0s
         Yp7v2KQleDlNWwlCC9Ck0/uVNl6DV0dNJsWwq0QbugdxKEJ9swrUnWRcIgBALGMOOCtV
         eqJfRF91j8jJT5VN8lO5otnd0dqc5VtUxzEN+wV4d46Ec6ceattpE+KC2fn/Yrm+CmEz
         VY8XEEq5hzVNJqYCDZL/ahOgn2JGOusagtL96hMsbPEH80S99sEep+1qeoV2xLLEpSBo
         J1KQ==
X-Forwarded-Encrypted: i=1; AHgh+RqM6ltAcXt9K/BJ5u5ZgpWMzG/bUPpMjV/u0yOgoMRGbvz8ZfkTm57e99Yq2z33abMDR6eYYKQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nUVrOTCe193odqj8YbyiAPaJ4bG7cCINIwsz4WGufUkIygnCqE
	3+WYQLz/GMkjQE4GO7HcAD2LdQCLlZvl4D5Q0dNZimK5gSTTFVCGUcTJ
X-Gm-Gg: AR+sD11+WRpss3FEM5c8L8ChN6Z2LqGr6OIJbRdu/+yAaIB6isBlA3EwgujNsO8IMho
	v8F0IL3WOmq2T8hV4M0nCGYDZ+Lbr+r2RjWExnVan4QFl/xR5jZmF6c7byQZNqpSbkS6lYgMyoq
	lhm2qYtFIksorWK6/K5TSJQ8mRfpHkVW0rMQoCBRUU/itRxvdJ0l45JRQKTfpGDDaaGgjXK6N+9
	q/845pKxhJCSZ5E0iX44FlQJGWN9A8BdRUKYrBKQJwH/9Fo2B2AOu1VX9wXWgVYewtukxtk9EvR
	gXO1zZIwKmqvwPIJN91ljnGEfGG8UZNHTp04r8Umy4Tp6F2bkC1yDhByow2Gu4CMrJLERVhtQu3
	iAyj5jldvG2cnjydnS0Cei6TWoPzObuBc9PpCqVsbae/k732uK7kWPaxWkuvhgc9VfLpm9iiEFn
	cNof06pb7IYPW7X6pKOCD4nme8BSQXltn76WJGCbTeS3AWBI2exQcg5FMhYlNvEwEkisRQ3swOW
	ylcsyHaipkDIWMGmMMIVVZirbk7cmEjoXDWeFHJgw==
X-Received: by 2002:a53:d00a:0:b0:66c:7ea5:ef34 with SMTP id 956f58d0204a3-66d250efa0fmr79329d50.9.1787675195238;
        Tue, 25 Aug 2026 09:26:35 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d2454d92asm236158d50.3.2026.08.25.09.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 09:26:34 -0700 (PDT)
Date: Tue, 25 Aug 2026 12:26:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Junnan Zhang <zhangjn_dev@163.com>, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 horms@kernel.org, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 liuhangbin@gmail.com, 
 mst@redhat.com, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 sunshx@chinatelecom.cn, 
 zhangjn11@chinatelecom.cn, 
 zhangjn_dev@163.com
Message-ID: <willemdebruijn.kernel.388b632cadf16@gmail.com>
In-Reply-To: <20260824173745.16757-1-zhangjn_dev@163.com>
References: <willemdebruijn.kernel.2d3e4407199d8@gmail.com>
 <20260824173745.16757-1-zhangjn_dev@163.com>
Subject: Re: [PATCH] net/packet: fix network header offset-VLAN raw packets on
 VLAN subinterfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Junnan Zhang wrote:
> Hi Willem,
> 
> Thank you for the review.
> 
> > > AF_PACKET SOCK_RAW reserves dev->hard_header_len bytes of headroom. For
> > > VLAN subinterfaces, hard_header_len VLAN tag space (18 bytes)
> >
> > Does it?
> >
> > vlan_dev_init:
> >
> >         dev->hard_header_len = real_dev->hard_header_len;
> 
> You are right that this is only true when VLAN hardware offloading is
> available, i.e. vlan_hw_offload_capable() returns true and vlan_dev_init()
> takes the first branch. The bug I am fixing only happens in the else
> branch:
> 
>         dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
> 
> I observed it on a virtio_net device, which advertises
> NETIF_F_HW_VLAN_CTAG_FILTER but not IF_F_HW_VLAN_CTAG_TX. So any VLAN
> subinterface created on top of it uses software VLAN tag insertion and
> has hard_header_len = 18 while min_header_len stays at 14.
> 
> > > while min_header_len is the real Ethernet header length (14 bytes). When
> >
> > Which device did you observe this with?
> 
> virtio_net (in a KVM/QEMU guest).
> 
> > > userspace sends a standard untagged Ethernet frame through a VLAN
> > > subinterface, packet_parse_headers() only correct_header for
> > > VLAN-tagged frames. For non-VLAN frames it leaves network_header at
> > > hard_header_len, so the IP header is found 4 bytes too late and
> > > inet_gso_segment() fails with -EINVAL.
> >
> > Which path did you observe generating these untagged packets through
> > a VLAN interface?
> 
> The reproducer is an AF_PACKET SOCK_RAW socket bound to the VLAN
> subinterface, with PACKET_VNET_HDR enabled. Userspace sends a large
> IPv4/TCP frame that exceeds the path MTU; the virtio-net header in the
> packet sets gso_type, so the skb goes through GSO. The userspace frame
> contains a plain Ethernet + IP + TCP layout, without a VLAN tag. The VLAN
> sub inserts the 802.1Q tag in vlan_dev_hard_start_xmit().
> 
> Before the fix, packet_snd() leaves network_header at base +
> hard_header_len (18), while the real IP header starts at base + 14 + 14 =
> base + 28. network_header points 4 bytes past the IP header, so
> inet_gso_segment() gets a misaligned ip_hdr(skb) and returns -EINVAL.

Why is the real length 14 + 14 == 28?
Where does the second 14 come from?

> > > +	bool has_vlan;
> >
> > nit: confusing variable, combining test on packet and device.
> 
> Ag. In v2 I will restructure the function to test dev->type once and
> use a clearly packet-only variable. For example:
> 
>         if (likely(skb->dev->type == ARPHRD_ETHER)) {
>                 bool is_vlan = eth_type_vlan(skb->protocol);
> 
>                 if (!is_vlan && sock->type == SOCK_RAW &&
>                     skb->dev->min_header_len < skb->dev->hard_header_len)

This is the hint that this is a vlan device with software VLAN tag
insertion? Technically, it might apply to other variable length
header devices too.
>                         skb_set_network_header(skb, skb->dev->min_header_len);
> 
>                 skb_probe_transport_header(skb);
> 
>                 if (is_vlan &&
>                     vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
>                         skb_set_network_header(skb, depth);
>         } else {
>                 skb_probe_transport_header(skb);
>         }
> 
> > > +	    likely(skb->dev->type == ARPHRD_ETHER) &&
> >
