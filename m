Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671376;
	b=yRA/Wvr49WQyTjMmIWmLI8KfSYHP9MpP3Zu07WDRgs4OmMsGQLXvbDj0htRLUt6eDHvH
	 YylVgp2+dGC2f4g3EogyxzdZRjs0+153xXj3ilxDo7jkh4DTkrOclDJss8UucpXsaLALC
	 /ImwV0YHjKAvWDbm3N3wIRa8SbEL2Xs+UtEuegQ6RO1TTl3rHWxHFG50zdXMFRl63E99C
	 nMhcgVDDVEizz0LJnh0I4gf5YxWivVTTu7NRBdz0zyBP3q3/RlmAkv+en5OpvNbCDhuCn
	 MgH8suf1/DxrYfqsOOHFT9nrN5f5i/pSilN9L3/+K2MJFbpSZb6WthhUye3cZlFNv2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QghGPR/3/DIEb8GdekTUB3M7O4FFtkChEXbGiR5SBcc=;
	b=2bTdDyQWgHeur30PJS/aIwxFZIu8RzE/tTJxrqFGIBfCL8jqOu4bLp2e4bvArSPQVy0U
	 S0IHZJGqxzIsTXjxClwxzPKQRkoKQl/HT2Bh+zF11yQa7g5QRNpXcu9IX9qmNf83BMwSx
	 pd9SXNM/mfchM1pn1hycF376wpHIbEDtOfiutNh3lUn54DXEeTvaIaQGnNbIwh8yFqkEW
	 zig+jxsWPl5ut+XzA2orZOUiy2QG/zU10Q1EmgUJZA7e3Gn4McOngP4p9ftYgSbACQsDz
	 q7lvYh9rfur79wV0AD/UlIkpe0BwMorLi9A14DPd7iylC4B8ruqED9yk/6NS6gzE40A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WZRsGfJU;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B96F606A322
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B96F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WZRsGfJU
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so13151085e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1792671375; x=1793276175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QghGPR/3/DIEb8GdekTUB3M7O4FFtkChEXbGiR5SBcc=;
        b=WZRsGfJUpVNXBGMQWbCXdQKadk3+tpNPppya8zsIk99jHrr9mSbpsUhQO25vbasO0f
         j/zIXXS2ds1QiQ+atXOOVWa+gCYakhWCtmCz/bT7NBTqDXiuq69+rVkjMtxAFxR9+ft1
         LDc9C0WH8XPVXxXL1bLagY8vq8ZEla/Ol8wJJW3A36RcjnbVAa9nSkMcR9j/VyeC8MXf
         xjqz9Maz8lbmMDW/b3zxHpV1tZHBNSzf+F5eBTh2U1cxMLJKEy9eu4bZ6UqCpLw5nfq4
         mtO4Ko9R7nnS45bDqOFtXSullXx2dv1Sp9BJIAd7OYK2ir3HxGERszYa2/kK037RXRpS
         uJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671375; x=1793276175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QghGPR/3/DIEb8GdekTUB3M7O4FFtkChEXbGiR5SBcc=;
        b=Ya+xhTfKFxJ+NA4/5A2cPc+zCs6vvIolhefq302R6PYIwc7MgvwdDWFrajssx+pYYi
         4Q7QIRVyw5noqbnLapQ8UuY/NWPmz1FrAGvdAIVfceaRpMD0oslaGKCIVOmSaz96eznc
         +rWSloPul6WYgypJ4xwW97a7Ad9/hPw66+74IWUQrGb8fLHqB8cPNzIr9+hGYqk3hiCW
         vwnDSE/1LgT1CovENDGOaEh5tLrtn+t6s0APCqOkbSA8dP1ghjkZEZlBafaYqzVRQ6lx
         vkxtrvRRNEz80O9J4O7yLuzQ4srOU0aGMfRKew4Gp36zDlmqz+tjMeu+BBVLmyOAT/+d
         J5lQ==
X-Gm-Message-State: AFq9FYI6ZmVb/pRJWtc4zuS0m7jaeaWYSwegnwV6mzaev+pVA9c3Axb9
	6pw8oW4Umfhs3h0+AQbawancOUN7Wvhn5W4wzlY54DFGh3QtPS4eLvoQLREiSVJxe8pEmVPwto3
	BtiJUgi3S80iFnWG74jDgOz+h97JVJ2r/uakImK5Gm6RO4BIb+Tar6z0VK/lM//apE/4=
X-Gm-Gg: AYBFou31M1wd4ZnCo9R2OLVEVseFWryLNaDvyh9MneMKNKtI/Gln2kgNaWsOor1ImKk
	jdl1qnWiYeE8u6iGo51XXN43X83qqJN9AC/T9aIvjz3I0PBH10gWIJCD5Ic3HOaiSagNEyTQNUH
	Ve6I1rSBIcuapZlcsW0cpz5FOi0hT0DMBdUXGN1jXfirHriCBAg/iWR/OzkXS7UZZgrjpLqa31o
	bpR+kXNNcj5nEq2MQA51+qUkff6yGblDLXptwBcjTOz+686/8gtgqwjPwB6J1qvGnPdk+k9Lpbf
	fuzPkXeP1UX+ApHIsv0pTd3Wktt6AubjdbYf5AqU7n9ocqnOlcXD6vUbAAMh7fs6h7KvCS2wzHI
	GjgvbZbwheSb0Ix6RMfVUjzEZJOCLh1t9t6+xBL7AFF5fTWy9GRjb7pwXGLY1VqiuETmkEVDYT0
	Ysk+5XfUiqThV4/Lk2T/CI/oGKC1ypSS6/wCFs8ypsamtqvZxOfDzPuRijVM9Dps/+c/Pb4PDEm
	1U/N/iQ3bmY0UE06UFL/M4oeMHl0S3pw9P26pFBRYrBvVF2qNoAzuBxGEooWVtu9c4=
X-Received: by 2002:a05:600c:1d1e:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4a20677bb15mr39679045e9.34.1792671374680;
        Thu, 22 Oct 2026 05:16:14 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:8826:77b9:4cd:7631])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm112485135e9.3.2026.10.22.05.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:16:14 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 5/7] ovpn: fix UDP TX byte accounting
Date: Thu, 22 Oct 2026 14:15:48 +0200
Message-ID: <20261022121606.732029-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022121606.732029-1-antonio@openvpn.net>
References: <20261022121606.732029-1-antonio@openvpn.net>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

ovpn hands encrypted data packets to udp_tunnel_xmit_skb for UDP
transport transmission. At that point skb->data points at the encrypted
OpenVPN packet, but the skb may still carry inner-header metadata
inherited from the plaintext packet.

The UDP tunnel output path uses skb_inner_network_offset to compute the
packet length passed to iptunnel_xmit_stats. If the inner network header
still points at the pre-encryption payload, the ovpn netdev TX byte
counter does not account the OpenVPN data-channel header and
authentication tag.

Reset the inner network header before handing the skb to the UDP tunnel
helpers, so the encrypted OpenVPN packet is accounted as the UDP tunnel
payload.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Cc: stable@vger.kernel.org
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 7672094a6766..05e10a2ed179 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -495,6 +495,9 @@ int ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 		return -EADDRNOTAVAIL;
 	}
 
+	/* the encrypted openvpn packet is the UDP tunnel payload */
+	skb_reset_inner_network_header(skb);
+
 	skb->dev = peer->ovpn->dev;
 	skb->mark = key.mark;
 	/* no checksum performed at this layer */
