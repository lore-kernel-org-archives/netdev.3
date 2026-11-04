Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758257;
	b=Y6MQrGy5ZVFxb3sGkMqzj6ntyT+Yy+vPBsQ1X99083MittiCbMthNQgPUGc/ABaYy66b
	 yYpps65bhXZHmlDKz3dhbJPPjG2JqQTtBbmM5Hh+2tkbHITkYXp9u9X+o9pC765fesxLm
	 Ro1H3G2+Tknz6Sh0d4+qleoAlBsj/kuy3kBk/4EZ6aQ64CVAN2/sg7QiU5GgLzpWKE13c
	 Kdbj8NT1Ir9wT0GxbmhmW8I4E2VT1Xzm10Pe7/t6W6VdIQVU0squT9DCe/YgGFfXk3ras
	 gmeklbwPSk3id6m4+LWXVNqEovKzxJiGWtmA4CE2FX1ztxunlo/a1+RvNcznXG5upsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cU876HDDCHMexU03ZAhAifA645G7RjUz/Egex4hmXuI=;
	b=iKko4HpIdzFtcga+ctmRolAjqL1QgcoRfkm4t0Kp6N7WJe2iPLrtyMLSfBbGqCI0G6eA
	 MX3KnhX/tnc41tsqhfZdOaYpzyaHCbg2GodW4uuEdIQOrS1Xn/6rbJmLTPc7t2RempRA7
	 Bjllyx4wiiywTx5GNreH8N2S+T+hgr88Md1IK5BDBxBeVXOy+1xxJuyRnDF3ecLO6pkSw
	 z2kOjsRW2tjvt6CChhALe3TlKBvFJuZf2vg7J9+Y5ObjA++MwIIvA1EMwc/pgbRF3N595
	 VlCZQvIsbyNQdV684FZlDq3nR+HMUJzPUMSrE1KIePZIgblFtJYpNQgT/eQnECDYYqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vAgke006;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B927606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 02:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B927606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vAgke006
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91e7c847aceso2380596d6.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 18:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793758256; x=1794363056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cU876HDDCHMexU03ZAhAifA645G7RjUz/Egex4hmXuI=;
        b=vAgke006Ec3ktT817FXZata6HPLZzc8OLDzQBLfOSq5OFrxUEUgEw0PieS4DXE9Hq7
         0bjk2uZCu6wJ3pZq1ADM8JlkUemr3qu808nLPS7K519Ey1PmiTlgHE/cGaHlNXhReSeS
         9HLaZl1NZGEFMl5wP2W5oAgaMyxSWZf1GGUdIymzmkxRxqSQyQfrITc/GFvVHHz3lOZA
         P8sTL3Gu+eA9lOLafSXwj6Ca8gDP3InTmC+o/66LjLxMy+JYUm0igR3Vus8YxKfW6HMW
         JneyNWHoQdc9ZVgsjXkM1UCyYMdyOKCaTo6m+PPOyr7w28bZfCy9ogBM8GfWndG+2v3v
         NGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793758256; x=1794363056;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cU876HDDCHMexU03ZAhAifA645G7RjUz/Egex4hmXuI=;
        b=p0e1sjtwOvqxTtL4G8e1Cn77dvDcgOn7HetiCJmWJxo4+NIHIR2/X6mblAVEluDJVR
         fuy3Sp841xS08Uki1LE/wnyWo0R8OS8Fm3AxR6mBXRVw2aNwujginkMtwrUlFTlKgPpG
         0n/N//8kc/5gqUSqqdpcx6LPtQuA9SiuwS7jRs3pjMmV3qHN0TRkXxyNWvjx3T4WKU0T
         FVKHB8YL15OuTQxzYsaMiVm98AhLvbsI9L9xt+XB+MgrfrSb7z2WGjGjeZ4jxatbG8QF
         +jJRoeBk0iHo5VvQfC8sbdp9PYbIu/RVVtbZNHLCcrnsRkb0AZapnTeHNF3JdvaN/Ap6
         eFTw==
X-Forwarded-Encrypted: i=1; AKwUvByX4WgZiU1edw9L1VK3PrZ+v/F2R97Rrixi6gvT9dtwWG/TBpkH2WV981jjx8rte9Bt+oX15+0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wy+eswJ+PIGWadDydnUow+ixo5vceXjWPl18CUHHBOyQCDPqV
	XSXYagspIEuOIlqdgVvVFT5fX+GcOy/m+r23ZvDlAbTuB1EFiivIQ1aB
X-Gm-Gg: AYBFou2G2uY81nRNf1qiOGQe1UYfVCWluNZTg5CazZNW1GRW+gSlftQqE7IFJFF5hwu
	mum3irURy2O++PF1YJRK9+sOuBDhB1uJtcN0KVwlFuwB3mH6xrDiLocmWUISfnrZit1mjJUH+yR
	omTRsn0rDRhuegkPLNHshbuKb03J11Sa1VJuFV/viA8zYlQB2g58OFraoJj0XFNR9NPmZKIbPDI
	7fguPrmgRGusNephtnAFCXlz6D3sZPuXlqPF5ELqYEk2+tZ5mqA6Fcl/kLW54pVkv18QZosN3cf
	AW9MoVBP1kfy4h5GKUjHXCpE85T/iiC+BCHqcZlGLcAqX4Hc1Zglq4G0LkPrWbnED/ttMfNNSGB
	zVPHKxbhYLZa9S8poKyzPOTQXKgryqFKoUydGkWNDwDV7obk1EOJJOp75cahak2OY98J+PKFLid
	EeJSOZFspYYwEeLt6A3DZV/vF/o3FBAyTOBV76fuVQRUVh32mvOAhBCWSNZmBSj+BQAfjkt+vGe
	hhanr6ICe/dOH3mVp4tWxmWqY7F8lcJ9e60XZfmp/wvx8emSP5pBB1i4yk7JpO/B55QCSUaWiar
	VnYOFA3HCnUL0M/pTP8O7WnQm3gCr3657Zm+T2qF8TjNz/z2t8x0dXZT/sbSGYwvms2+b3//NmH
	mngDtBdtpCUtcaFEBs/iWJf7yyhPA1rgZ8mQ0HTRVuM9Pm4xrn0apj8BM2962bgZwx3NIJy8=
X-Received: by 2002:a05:6214:310f:b0:91c:61e9:7b68 with SMTP id 6a1803df08f44-91ca4b7ad25mr211563366d6.21.1793758256179;
        Tue, 03 Nov 2026 18:10:56 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfdfb5fsm6279506d6.16.2026.11.03.18.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:10:55 -0800 (PST)
Date: Tue, 03 Nov 2026 21:10:54 -0500
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
Message-ID: <willemdebruijn.kernel.316a1799578d9@gmail.com>
In-Reply-To: <20261103203113.550604-3-edumazet@kernel.org>
References: <20261103203113.550604-1-edumazet@kernel.org>
 <20261103203113.550604-3-edumazet@kernel.org>
Subject: Re: [PATCH net 2/3] selftests: net: tuntap: fix UDP checksum length
 in build_udp_packet_csum()
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
> build_udp_packet_csum() passes udph->len, which is in network byte
> order, as the number of bytes to checksum. On little-endian hosts this
> reads up to 64KB past the UDP header and computes a wrong checksum.
> 
> Existing callers did not crash only because they use packet buffers
> of MAX_VNET_TUNNEL_PACKET_SZ bytes.
> 
> Use ntohs(udph->len), as tap.c does in its own build_udp_packet().
> 
> Fixes: a942fcd72e97 ("selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  tools/testing/selftests/net/tuntap_helpers.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/tuntap_helpers.h b/tools/testing/selftests/net/tuntap_helpers.h
> index d6c0437136ec..ac9b2da57a6d 100644
> --- a/tools/testing/selftests/net/tuntap_helpers.h
> +++ b/tools/testing/selftests/net/tuntap_helpers.h
> @@ -335,7 +335,7 @@ static inline void build_udp_packet_csum(uint8_t *buf, int family,
>  	sum += htons(IPPROTO_UDP) + udph->len;
>  
>  	if (!csum_off)
> -		sum += add_csum(buf, udph->len);
> +		sum += add_csum(buf, ntohs(udph->len));
>  
>  	udph->check = finish_ip_csum(sum);

If respinning: we probably should also do CSUM_MANGLED_0 conversion here.

And to zero udph->check first. All existing callers do. But the calloc in
patch 3/3 does not.

>  }
> -- 
> 2.53.0
> 


