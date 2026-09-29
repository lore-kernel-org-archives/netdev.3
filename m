Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797DE531612
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693919; cv=none; b=UN6cmUz8bBjr/UiwbPxytpB/uuTgek55k+ShaAWlzhJLXo8Htv7aOLAY6ENebp3pFAnjBbLeL8k5JIldTpOA28XcsJV2BY5NgtHRBqgLpAmrHMJiwaIWuWJLt6b/MFEZMpWVDX2CN3/j/xN9LfiYVvPgGpR9EgxtUMEJ8OVAeQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693919; c=relaxed/simple;
	bh=+Nae+VQCeZSmSPqR0LLrqa4yrCW4mwWubd2DoSBMmm4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NR747ApSMCAEOWsjb5GPvQNauYplIQuVAnwJVc71cj8gv9f+W+WGtb6ju6XJHz3F9uSmuDNnPvyIsu8wDxJ/e/GeCg1uWCG4P+F80ThKpnk97ingYVqcLMbqV/5dk3YY+g9XyM/tCI71hChpwEKuYOJjVTrCCw6EF4zsSh5Zfhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rSeO5Rtb; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSeO5Rtb"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8aa75b33a26so23835247b3.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790693886; x=1791298686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iS0vI6VPFheNRyG7TeQ5h4c/DL9d1CbeqeEtao3CvUY=;
        b=rSeO5Rtb4rpBcgalBZME4CzwkFx/cHcUp0pnWTFuvBvuATOZxAqH3QH6niCkqsXk9g
         /AtGQvGgh3s+nmfVrAamu3+jqmi6YpxtAz646NJhpYkNHfB4liSfKwKXLMO2P+h5eINh
         3dz3ZBMG8JkrkquaV8rcCUYqOZkpvizKG1TjhtGhunoZIAfhEbrZi4HYW1CkWL5sBW2G
         wFdLRvymoreXAJtxof1T8M3O0PzjmWiU+eHUH8uiejRVePAAVWm1a/4C5VOWqpt2kU7r
         jfCoYvyO+A801Zntyd/0oV5ZP4AFedPwB0HNilBmjvZ0VskCut8Lm/Ja5FYe/Fm2uVMN
         6tMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790693886; x=1791298686;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iS0vI6VPFheNRyG7TeQ5h4c/DL9d1CbeqeEtao3CvUY=;
        b=NI0rhx726KPxZJaLnrQTNwB38lgEjdO/Zmw5lagIKT8P6+zIuFvFJnNnMbRrLwUjw3
         tf7G6BkGjltSJQHvMn+TkK2ymctgInjpzEPXI2CNv8kXzJVZbupmxkr84IwMKWEySTSa
         YiCm8bwBGMxnk1PU8WKiR52aFQGFWeIwJEXxPPE77Ri+K2noik1F5s6CsXCyhobSvG2u
         amzTHX3egwCfL6tt07sMkUYDPfQh0K5MdIzQ260V9iEGy/TENGSZNWbYhO9EBNlMV+te
         HL0QpMw7ydvWDd2AF+talnOh/bMQ5mNL7Xo+YuApW0GPb7Y0lU1Gjk7op/c6RJ6i1/Zh
         KYhg==
X-Forwarded-Encrypted: i=1; AKwUvBzwH30zqdLhM39bh8bWruXBaXyZrz6wgLBLuJaXe/Jc7a+sYdSABXQUaAvDa7cyWyT3WLfpapA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcJn04Vh3m7NgqBrcKh+n+SiVo/FMxhfGBMDAXhViuLPxwLamu
	g7NLSJFUHiR05ZgrqrbttBvFV3TqDhqtMYcpcPU2stSkmsdOtW5p6XDQ
X-Gm-Gg: AYBFou2dh0hWRViFrhDyn5Xl8+Cefwb55QtuQbVNlRYJfedpMAtFsVVWI1GF/00fVD/
	Hb1I1H6YW/xpsCz2iBnUcIbUCEU5cQKyqYsSJNA8Ya4K7MK1FquSdNT05Rl2mJ311myj06VwAtX
	8V+OWKNiM9RErc2BTgcXZB+mZUOuYGwubKdu+sesbJfxPzi8jmOvsZJZZCtz3Jt7K9CfSOdT9WK
	biypjTwUDgR93RV3rjtPWMfyqDJ5G6+oBRszSDakXYzWnxKA4LrzRvmcwes8N52v9ODD/dFRNBY
	1i4IhrSrEax8MBzFyH2hCl8wIVb99QpCtSeZRwwE4mU5/quRM6zFBYtRkcQsElrP4JZ57dNqG/2
	Cxqeg6nlTHfUeu4hSsV2OAb68AATVgjnB4NyzSMwPZLS3XQ7GcSJKv+4HjhrXLegxWTMkBzgBiK
	pg48dwgua58e+Q5+s+mQEO+tjmO4XZ/ycLlLKXaDGfystRfY4t3t1601PtmV2trp/bfJ2WKegAW
	7bA/8PDJGXI2xoyrrwv/qIXGXpvkfpAVbIFzTLUU0usK8GX3E5L
X-Received: by 2002:a05:690c:e68d:20b0:8ab:318f:1b61 with SMTP id 00721157ae682-8ab9588cbf2mr959057b3.41.1790693885914;
        Tue, 29 Sep 2026 07:58:05 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ab46e3d02bsm6381477b3.29.2026.09.29.07.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:58:05 -0700 (PDT)
Date: Tue, 29 Sep 2026 10:58:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Quchaosheng <quchaosheng000406@163.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Quchaosheng <quchaosheng000406@163.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.24f9b153d245a@gmail.com>
In-Reply-To: <20260928113108.2127215-1-quchaosheng000406@163.com>
References: <20260928113108.2127215-1-quchaosheng000406@163.com>
Subject: Re: [PATCH v3 net] net/packet: guard the ll header push in
 packet_rcv_spkt()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Quchaosheng wrote:
> packet_rcv_spkt() restores the link layer header with
> 
> 	skb_push(skb, skb->data - skb_mac_header(skb));
> 
> That subtraction is only meaningful when the device actually has a link
> layer header.  packet_rcv() and tpacket_rcv() both wrap it in
> dev_has_header(), which is also the predicate the block comment at the
> top of the file states the restore in terms of; packet_rcv_spkt() does
> not.  commit d549699048b4 ("net/packet: fix packet receive on L3
> devices without visible hard header") introduced the helper and changed
> the two call sites, and this one stayed behind.
> 
> A device without a visible ll header can leave skb->mac_header at the
> 0xFFFF sentinel that __alloc_skb() initialises it to.  A CAN skb does:
> init_can_skb() sets pkt_type and ip_summed but does not reset the
> headers, and commit 9f10374bb024 ("can: remove private CAN skb
> headroom infrastructure") dropped the skb_reset_*_header() calls that
> used to be there.  skb_mac_header() is then 0xFFFF, the length becomes
> a large negative number and skb_push() reports it through
> skb_under_panic() -- from softirq context, so it is a full system panic
> even with panic_on_oops=0:
> 
>   skbuff: skb_under_panic: text:ffffffff8bd21bc1 len:-65455 put:-65471 head:... data:... tail:0x50 end:0x180 dev:can0
>   kernel BUG at net/core/skbuff.c:214!
>   RIP: 0010:skb_panic+0x50/0x60
>   Call Trace:
>    <IRQ>
>    skb_push+0x38/0x40
>    packet_rcv_spkt+0xe1/0x170
>    __netif_receive_skb_core.constprop.0+0x7e8/0xd30
>    ...
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> The socket type is reachable: packet_create() accepts SOCK_PACKET
> alongside SOCK_RAW and SOCK_DGRAM behind the same CAP_NET_RAW check,
> and neither the socket length nor a capability check keeps it away
> from a CAN interface.
> 
> The missing skb_reset_*_header() calls in init_can_skb() are a
> regression in their own right and are being fixed separately, but a
> packet socket should not turn a link layer that did not initialise its
> mac header into a kernel panic.  Guard the push the way the other two
> receive paths do.
> 
> Tested on v7.3-rc5 under QEMU with a slcan device on a pty, which is
> the driver RX path: vcan does not reproduce it, because can_send()
> resets the headers on the way out.  One SOCK_PACKET socket bound to
> can0 and one frame written into the line discipline panics an
> unpatched kernel with the trace above; the same image with this patch
> prints no panic and powers off normally.  Both kernels are this tree,
> defconfig plus CONFIG_CAN_SLCAN=y, differing only in this hunk.
> 
> Fixes: d549699048b4 ("net/packet: fix packet receive on L3 devices without visible hard header")
> Assisted-by: LLM
> Cc: stable@vger.kernel.org
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
