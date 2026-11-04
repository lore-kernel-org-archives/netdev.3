Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806622;
	b=X10PDddRZuPb5/sl/LtlCKwByH4gAc4tI6bX94w9fT/ZmwbzkXn2KOcoTpQ0Tyq07Ftd
	 GvFcJybPoBhqFQ4omI0tkVI7CK8e1g09ZDopobA8Z/SJZuabJY210lHAQF/B0xjBayoPM
	 td0j5nWSmXkkUe6lD485NWfxbcnNRDOon4HHnHETNwiNqlKRM0vuR6XMuMJZSTZtIERw2
	 lONq77lIc/oT9PAMEaU8uM76hgRQ05Pc0y3JfsjI3koOWP4U6uDwJhJbvGfUqhWZWyu4F
	 XNgj1MZVOPqyOSmzCH7VEg/R0hd/E2MxbrTs75ARdCQ+qDIqA18X4J4TIaGDy3w1qpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hVIa3swhsbmrrYjC4G+lOwvdapL/nqbZUw7IU7FT/vo=;
	b=u1OYXnHIfMwHWiKFW8PipDplb4XA7+8I5hh6T+9wiO/BqmfzRaALowMVGfeZStMcC+sL
	 RqGX7sdruM4bUcW7liWvpCcubCSEhC2aRN7oJh3coLkL7Vtp8LiFYgX15/AgmRWJAv0mg
	 JBO+G3AWmxtELBNdD2BUPHLhEbtg8ZiB6MHsAsMfv3x5A85bz31/vxuOzz3v7pwv4iAvw
	 Ip0uKZZ5ERqFv8Nh7NelTaXQhCxMzn2W1WB/gD/0US7PaFKw/lGRAyjTr1X72Mu6TiS6h
	 VlvlQnLAlp5WO0Qq/JVYo9mDMVXqbWdoZqBxGZV7CCuK3YdcDgdpk3eI6IgTa37Ju4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TETlKGWw;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244E606D832
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A244E606D832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TETlKGWw
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5ec6f271883so556920e0c.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 07:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793806620; x=1794411420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hVIa3swhsbmrrYjC4G+lOwvdapL/nqbZUw7IU7FT/vo=;
        b=TETlKGWwXd26BqRSjtY4Kqiz2NmWqu1rnB1Mn8XDlZ/rNsd0uDIm/ZiddlC/txO7Yz
         gc/ai3HsxXq7sT+Znf52SFnPg6TTN2+sUsN08ENAdZTrqcVBtxqlFgjn5VIJ0Km/HoM6
         wMqd+8q50ughxtSqJxnqzGLIrgj1zjMMmu6XtYH+udk7CieiLb2y4ChJ4X+IWzOVWgYV
         xmokiRyif5pSpwLRiDPIsoJsqUV+h69RiurOqr3TN7qHEwg7THksFSjdJ37X99htugBZ
         us60Cw2SDm7Uki/NVz7PLbK+oWVKpYZrRTdMGmF0LFGnnlz0Us7UI9iz3HtdVirnRGbX
         qpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806620; x=1794411420;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hVIa3swhsbmrrYjC4G+lOwvdapL/nqbZUw7IU7FT/vo=;
        b=FRhT0f4mI+1H/Fkytg3zgLTqzwxA1qRNkAExkp6DXCP1VKvsvsf7tOzYsJFzMBRm4r
         4H7OwZ7f2pmUszgQQqghOpt7BR3uVFYDwTiEbP9Mc3wxsNqPC6cRq8aW/PPkBIOR8I9w
         7TYj4xv46p/RZQ+Y8aYMFhBtRDHfXZ+m1QnuL0ju3r9HnmD0/lK2KduPE+DldL5T5K9c
         HYopkEx0sIkzqD25ZgFzIeMv2bgNobd1f8waYFf8DuJt+edEwatW95m1ld2uqiQEwW2M
         L4xmKZoV70g8T4ZM2/Ldah341j6W7eb4/0E8RBcPddHM1bq3CwERfrTAbrXzEFX3EzNX
         +9Ug==
X-Forwarded-Encrypted: i=1; AKwUvBz5Ii8cBsPBUkJYx/D0wIspA7KtWooYx/hlSXaLe44Zw2Kcb0tBwQC2B62F9uuIQDeKmmVjIL0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iz0zIE+9w+jXBzWz0a2/9CbpHEU0EGbzdn0iCBFZmWuxqcLdk
	0PwJjxFPznirO/uK8f4tY4MVF7jf1s4I7xr9vnNL2jBzchs3GSDlu/2Z
X-Gm-Gg: AYBFou12f1BL7lo8+dy2Wnnv6P65l9iwBVs5W3VjgvmuoPc+C/ZazZ3+xsODhuZh9fl
	4aP9hSYOIQvs6SEt6w8qUqsLgqE9w4r2ote4yKwnKI/n/8uJEKBXUBuH0C3m9T8/EeBruizuyQe
	ppTrIAjhSHPTMUNdKZ2wNLl2zacLuHPORCVlXW6oVBIR88auuH2S2lK0AZrW/ov5jRfzhg0eTGG
	ek0c/TMwU4ZFSCCsPVbYr6+eU5Zz2vhtdliVgaa7GzcUlh+T+ntJZ6dprYx9h4v9hYCGyke8XHj
	PU/CBnfiNKdJWdIrxER+xpfCuluS/I51krz6XeWmOoHBCqGKtHe1i1WULaoq5mkh5hKT6qH7XMl
	9kQ/p4Be/CWIOhVq55Ryxv8PnaOzdLZUhzLDqf2uA61XM3FWT20XW8eL1rrtMjkwPLTZn/6//Mn
	7Uo7UREC6MJzUJKiPCKz+BYx/gQtmfs3bx8FAjs/lYmiitzQ86dDGpXYQ0/kpy5NnwB88UykJIK
	mjfTQFmXgnDq47G5neg+EDQvbMnl/aLLCMmCde4lClHkBrrhdvqVVhFvlXnnIRI7XFTEQvZcjcS
	RAhZ6lIo4JFEHiEY0fnrXDwxoFDBsApEOOFRUouZ9cYOe/OUg4/GLcdWozXRNAxM4MLz2fMII5s
	kiDvwwVRzoSMLgZhjQrRqVPbQ1uESVS8D6k9jcxNvoVahTCFpzEIlqwC10evPeR1JrXbJEb+OnQ
	WswpRuopK+CB7KVi9/Pw==
X-Received: by 2002:a05:6122:4d86:b0:5ea:aedd:6087 with SMTP id 71dfb90a1353d-5ec6871d3d2mr7672956e0c.4.1793806620530;
        Wed, 04 Nov 2026 07:37:00 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d774dcsm1927819e0c.5.2026.11.04.07.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:36:59 -0800 (PST)
Date: Wed, 04 Nov 2026 10:36:58 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Hassan Sultan <hassansultan@google.com>, 
 virtualization@lists.linux.dev
Message-ID: <willemdebruijn.kernel.394adf46ec48d@gmail.com>
In-Reply-To: <20261104050131.629967-4-edumazet@kernel.org>
References: <20261104050131.629967-1-edumazet@kernel.org>
 <20261104050131.629967-4-edumazet@kernel.org>
Subject: Re: [PATCH net v2 3/3] selftests: net: tun: test outer protocol of
 UDP tunnel GSO packets
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Add tests writing single 4in4 Geneve GSO frames to tun devices with
> UDP tunnel offloads enabled.
> 
> tun_vnet_udptnl_proto uses a tap device:
> 
> - outer_proto_ok: an outer IPv4 header, with or without an 802.1Q tag,
>   is accepted.
> - outer_proto_bad: an outer ethertype that does not match the declared
>   tunnel type (IPv6 on an IPv4 tunnel, or NSH, with or without a VLAN
>   tag) is rejected with EINVAL.
> 
> tun_vnet_udptnl_proto_l3 uses an IFF_TUN device with a tun_pi header,
> so skb->protocol comes from userspace and there is no Ethernet header.
> The outer IPv4 header carries options, as virtio_net_hdr_tnl_to_skb()
> expects room for an Ethernet header before the outer transport header.
> 
> - outer_proto_ok: tun_pi and the frame agree on IPv4, accepted.
> - outer_proto_bad: tun_pi claims IPv6, or the IP version of the frame
>   is not 4 while tun_pi claims IPv4: rejected with EINVAL.
> 
> Without the first patch of this series, both outer_proto_bad tests fail
> because the kernel accepts the frames.
> 
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
