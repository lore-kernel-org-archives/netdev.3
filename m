Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214183;
	b=wWKo8tnnxbh+vvEdr+jEDFmdzmae4ZppOcNanDcNXa7c15zz3CDgaU8DN9T/Il8z+SZV
	 reG4JNku3DZDvIeOyT4P30GIttz1cKQct5xVj3V+ERw7VLf5L5uKpmA0t9VPhsY7aEsia
	 mI0gG2VaSf2p2G8H4kd4jElhv8ZAhODQDsxLSLrQEQ6wIr1oOusbhWZfi2ic1LogmiCOb
	 pyTF7QxGqvvz8pZM/gXMqMmS05IrMoqI2hkf8DjKFpW11EQx1ajEQVmf5ckQGSrlR+ydU
	 V/n4Ot/BCFDNvOgOEBbw6vpIzeUcDx+p//gtg0fCy7xvo63jmcnGbxfA53GlNz8ux4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ul631NrDXm8+b/gieJT7IgLimLORIYpLdIRbSMQpXno=;
	b=FLJ5JFlEXbEzCcHionQoFMTCRoZgorQF4A/bhoyeyfxTw+zL2fxATCu5pvKvAHGtsMgr
	 QG4z+B+Zc/P+FwV3HtFqRe0h5BjXbvU8+wxwLNaEaDTggBs1NMTC/EfcZJcXiKiL7ccsZ
	 HSDIu1ZPq5z9KiS+sfPziVpIJthW89kqa/H5QyE26XfQ/TyHUGJoNP3uwuW43TvC+toOf
	 cySyeyv1rPLzRjykTvL/LfQIqDyOcgOmZKDbeE95WRkotd1mxN4PDyF5tt3f8ocTSTb96
	 8v5zGyyfixkPAHtFY31i8xmaOJMwbpdgJenAcBPsd8lw62rw9zthG1S0vwMBySlHmhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="P6JZT88/";
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178C7606A32D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 19:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 178C7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P6JZT88/
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ab432273c5so13775477b3.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793214182; x=1793818982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ul631NrDXm8+b/gieJT7IgLimLORIYpLdIRbSMQpXno=;
        b=P6JZT88/SvnGvQPtUYU6UYlfLX0q019sjrIEFKXRwFbsQw+KAiuKQdU5r1bbUN97rD
         tl395zpBurBx4wfQ33p/4MfqlxqcFJ4Ue2pozGmZzM6cGt/UCCedAk5ij99spcO2lEsv
         D4eahRFDjtT0mrgCoLhG+wxi6SYqSVkGqxNG909A+rcnIXGDKnr2IOwnu9NKq0nYVR9V
         UWnWJWVxekfhehQel2JYoUPYtJKHmd6YpQLjKu9H6wwr+5tu5e5DNLaGHCcKy40W4+Wh
         lKDPsayxaWM5R03wB+At9/SXueH9yPRNS66DJDeAFKTRQr0Bv1+zzH3kSQLc0IjygZHA
         g4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214182; x=1793818982;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ul631NrDXm8+b/gieJT7IgLimLORIYpLdIRbSMQpXno=;
        b=DPbRNow0OXoxuZEX7QJyg7WaXRmhmqm2cuxK/HvQSWu0zW6tRVe1U4Rc7Ge9aYKE5b
         NRGWfFyrSZZPKp3kaZLoKpZ7AvAGT0wNSKxhRNxaKua5JlU3v7P6yhf7FhQ5/pPSu3Rj
         s5ar+JCYtha8adR9DtWBIxmpXAlX4wHpmMgBgqw4icAcvctruZLjLn4QcYz9mbZLSLzV
         EMkppgsmFaHbMU8z6ZxJmPqNcnH89AiilwhpDzz+MwGCnstzBEVFYdNWiVoP3C2Kgplc
         Xg8KHEE/97mfv3vzyqGP/ggD/O8KuEsMyYJKGsEYGBm7ggifj89GhAYnEt5MXEHWMT6c
         anUw==
X-Forwarded-Encrypted: i=1; AKwUvBwZo+VeEs14vkjDyQzSeD9okpc9L9LLmujqUSMwtrQRrTNZs5ZlbDBU2K6rB69KTMbG5GHSNdQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkuCVnYHqf+p8YmWarvRVLs0FWevtJTTXk23jM/aNyi3kirKP+
	Bm5sl19clE+4Rh2lhvN5l3z8hcIgERAYy6oLxhIfpcEUfd5ZiI1GtetG
X-Gm-Gg: AYBFou1SCEbUHjX/6k4qEmi4dKPn/USKND0OiWz+J0e+LCjmQPBMfGV9X2QUrSXFi0P
	dEFmlWZ9TCJUPFMgNLH9tfvKePDvG59PI40p065EAWzefPsKsq9WWIOyu5WwaoT0pbOUM+hf2Td
	yPEFYEZ5cK91tvJBijDjsVc38orJkZjBGxIK4QtfrVFiRmfuBM2cvWb8uafe6v81TIV7F+hD0IK
	gYO9swVKO1VM4wXd4DW5x8Yw6zaHMLZ65efXhaInnol3qr/jellYJqYun2XdJ/3Nd6mRDzrM8uV
	rH/xfxqEokMMGtgY0ZLofcKWtRuuehWkNZCaJxIWnCTvHo8EffhxQF9yMVAjFLW0hsIZP8I5H43
	ySn1Iacq8ng2+GkBG7V02FX46CGHvwSPx1sz+ZskMtD4RE/bUwSrpKGfHVyhLplXl5uPwgSgjVV
	6v/ZU4akXjEhWbMqOkfU21i1ZGk373NmUxxdvTn79pcISH7nyRDsDMFkZRy8yv/nyxVUYaTq7Rf
	5aktKjdRnjNb1wth1mJG9n5ChkrGuX23cqFHEKypcaEMTfuuqGJvXZZ6DymLqKPZIQ82hWglhDs
	WChl/nORgYFGCd/E71fSZUFXXmP5wZMA7W1TSfATlEEjXDmT1oCfCjXuDJd1QhfIbDVpR4TBW+6
	oPL58KDPy0GCL/M1miOfAvW2uYcRX6R0GvnhqzawY7tXOF0lgXP1IbaY+jMZYxhrA2Yyf
X-Received: by 2002:a05:690c:34c9:b0:8b0:76e5:ecf0 with SMTP id 00721157ae682-8b1b59e36e3mr25394687b3.4.1793214182076;
        Wed, 28 Oct 2026 12:03:02 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e539e34sm33510157b3.9.2026.10.28.12.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:03:01 -0700 (PDT)
Date: Wed, 28 Oct 2026 15:03:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 dev@openvswitch.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Ren Wei <weir@nebusec.ai>
Message-ID: <willemdebruijn.kernel.2a72e3d2bb313@gmail.com>
In-Reply-To: <20261028122703.2093730-4-edumazet@kernel.org>
References: <20261028122703.2093730-1-edumazet@kernel.org>
 <20261028122703.2093730-4-edumazet@kernel.org>
Subject: Re: [PATCH net v2 3/5] net: use eth_type_trans_careful() in
 __dev_forward_skb2()
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
> A tc egress BPF program can push a tiny link-layer header with
> bpf_skb_change_head() on an skb whose head is almost empty, then
> redirect it to an Ethernet device ingress. __bpf_redirect_common()
> only checks mac_header < network_header, and __dev_forward_skb2()
> crashes in eth_type_trans():
> 
>   tc filter add dev lo egress pref 1 matchall action vlan pop_eth continue
>   tc filter add dev lo egress pref 2 bpf da obj prog.o
>   # prog: bpf_skb_change_head(skb, 1, 0);
>   #       return bpf_redirect(veth1_ifindex, BPF_F_INGRESS);
>   # AF_PACKET SOCK_RAW on lo: eth / eth / 8192 bytes of payload
> 
>   kernel BUG at include/linux/skbuff.h:2839!
>   RIP: 0010:eth_type_trans (include/linux/etherdevice.h:635 net/ethernet/eth.c:163)
>   Call Trace:
>    __dev_forward_skb2 (net/core/dev.c:2507)
>    dev_forward_skb_nomtu (net/core/dev.c:2546)
>    __dev_queue_xmit (net/core/dev.c:4738 net/core/dev.c:4998)
>    packet_sendmsg (net/packet/af_packet.c:3157 net/packet/af_packet.c:3189)
> 
> Use eth_type_trans_careful(), and drop the packet if the Ethernet
> header can not be pulled. This also covers other dev_forward_skb()
> users (veth, macvlan, ipvlan, netdevsim, l2tp_eth).
> 
> Update the empty_skb BPF selftest: at lwt_xmit, BPF_PROG_TEST_RUN
> strips the Ethernet header, so the "veth ETH_HLEN+1" packet is a 1-byte
> skb. Redirecting it to veth ingress used to read the Ethernet header
> past skb->tail and deliver a 1-byte frame; it is now dropped with
> NET_RX_DROP, as veth_xmit() already does at egress.
> 
> Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
