Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939162;
	b=Z9le4TMFtBXr/wCmqroe6DFfAt8Zs2GmQLeauTgxGT1I0NwfXfovMoYMZCdeedAqyRzB
	 TEHQTPxYSRBpcfJIfDCdqZbTIeFtCjiOhK7+PSWVutTWjGy6XkYip/EMr47z94e4JY5ib
	 Zk2V+mxXRbMLnwKnCMp3xJST0NKqB+3zD3dFNiVSpvG3Gzj1LlOQlSHn30nyaw24OE/03
	 +YL8prbVQO0uJUaDeUlol3IdQGK9TQD+Tm2j6RwgKPNvSYSreYmF403QnZ60dDy8GvmUb
	 qbPmn5pJ45E8lJRIRm31S4Ut4/1P3pYMoyi8O+EKz5XPmbA4BeGkmv9M5jrlhZcIhxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qqKPGKgxzCnJl5Zf6W6XFm1IHi1NIK5zysMn+xDZUsU=;
	b=MQ0Jns6+x+L8t/fPjpGmPWPwCOw/Ye8qnk9ikfG98ImX1/Q8a2xpkNiQsvynoeMFcxLa
	 clISuORk4pdRQkmcYomj/yLuSV2Jl/kbi+LQXKpBtMkysVo5F4rS8liI4KaCe0HEJpcxm
	 oXfpUOJGL42HEzF+D6bYhsTbMJQP1ZdZRIfNMounTdS5TvCwPL6jTqUERH33V7AUX1jnW
	 UV9/sRifPEDkg32QEBcqLgEbrBAp1qOAia/ZbbtBsdmwNF+fDAj387bkTawURuMCsEKgf
	 CQTSGiprlYasxENik8KJEAQ6K01R44DCzGfTM+P9Ct2MKqlVG6u0EJBJLsfHP7jhStg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43764606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 04:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43764606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eaaa9b1591so185291e0c.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 20:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793939152; x=1794543952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qqKPGKgxzCnJl5Zf6W6XFm1IHi1NIK5zysMn+xDZUsU=;
        b=ld17VLBtzs6SqS7N+cRKUdQ7qbgqEWoYkrRl/H3GQpIbLXSTP3MaSpZ4GmH0aMySJs
         wjVNVzlJdEC16D7dRIycLlG/2gS14zSi3fiz4vCMlrsPTGEbmFzxFxDIPxIo5KyTmurZ
         4A+VwRyaQsmQHh1XlTCRyv7OAQxXRScHyJtVK5d1qrviymLsyDrMCp1MLShAvkfqqUgb
         YGEMoTcex0tulvlcOGK4Nc4NvmfyogHZ8n8HVecJpLrshoP1xEyjeMC1VjjAv7tMVbf+
         OAfXM109tx/k916+XiU3X5TZ2EqNhLV+/J+CasYQ1kI4OOcBMMZ4K5g3+LOKqL/234FF
         Mu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939152; x=1794543952;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qqKPGKgxzCnJl5Zf6W6XFm1IHi1NIK5zysMn+xDZUsU=;
        b=q72/gwvatCVTpnvIfC18I1T60z9/W1lOj7WxIFp4gHQPtfi8kVWCC2E5Ybo/2luHti
         KxexnO++DUxGGYFIDjcvIyD+jB0pJ8Dx0eGvAihDnv6LKZBGXcp+kgdYHv7Rnw4chHKf
         JMxMxIpeiteLKvprN8tUX2fDkwHhrRSAOVyNOgvfHEeqVXdzx6yE9wiEzaxIin+LJeJy
         /iU+CBcA2kVRUH5ra65u+1p/MZ8KXmDBKeTiXqFiQT73Il3frqXgBA3ZOAQ34EooOHVS
         vrz/dJY7pGIfGvQav5niFP+6DrqczG+A1EKYpnN1CkDwDswO3EBFsqKP+UrAMRab71sJ
         pz+w==
X-Forwarded-Encrypted: i=1; AKwUvBxSynOO2N9b7x+HVVqNKcTIaE6VXY0wiU3y1M+MZDSPRqVThikCOmEIqPZSfKsGV3LGZ2owuFM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9E0CWtvonPoo7pGxG9VSNrTzmogf/17anspmMVEya7sc51NpQ0
	H8Pvg4RJ5oS9R+fYAO8zjZ5yLEXFXvhKK9N8ubZywVF10omG69fZrjqJ
X-Gm-Gg: AYBFou3jB8EWKVYMSNdJH+EVT+BXK3mdvZyUr1kAt77f31rMZIbcof9ro8haNDDsSN2
	RpL2TjBz6qoE3/if8FaWTPWpviL/zv81Cal00upjHcEznK0JoJpdosQ85kLjlPmTqhOPjDA1Vez
	1teG053uJHq80MUStMOoJCntEJH/WiRzhlSJXabhLEMWEwl2M6lB12LHmHQYxrIp7m+ScUpVl/R
	RiG47/3LEVJUXgyfKVKwczWh31EsyZAoofEy67nZm5Bqm88egYWXiLzUjcqrB975HiJXbDs4mqH
	h9EgPO5+ICzHAajLS8aBabV1poFRwAiO8d3HJqTklyGVgiS/ejdxah/dkod2sfr1aFpkvqL5ZFl
	Wttb0AR4fMEzlRRYO32r9P9Vj8jU+7UMn2Pc/+7YSjlm0/bi2xQxlG/3BguBm3mWhcmUO8ngyaJ
	vFO4NI1wrcU04BOE0adnsQsZSDrnl/OmWwrfRarrolOuIB6UHBXmItG+a7I9+SzfBB8ELaoDLu6
	6wsyWHT0ILVH5jqqacfX1R5p4Y/RKgqkij+JWXxUQdBy+0egeDFmqFsGth7VXaV0h2XzsVL0HvT
	EFdiEB4QScO7u3Heim5yoIb+LijfE+k9lyjSti4Dh2shVCcW7DG1OfvceM9LnrzEVBA13J7XUcJ
	ov0EY974xgJihbrLRMWR1laFKQ2+z3oXBoMVihG2BLEanUERvCiaRRaR0saH6RMLZ1zNadPc=
X-Received: by 2002:a05:6122:1d07:b0:5ea:c37b:450 with SMTP id 71dfb90a1353d-5ecc4428992mr843406e0c.20.1793939152230;
        Thu, 05 Nov 2026 20:25:52 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a6774sm576387e0c.3.2026.11.05.20.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:25:51 -0800 (PST)
Date: Thu, 05 Nov 2026 23:25:51 -0500
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
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Hassan Sultan <hassansultan@google.com>, 
 virtualization@lists.linux.dev
Message-ID: <willemdebruijn.kernel.1374b4bb37bc5@gmail.com>
In-Reply-To: <20261105115715.1466924-7-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
 <20261105115715.1466924-7-edumazet@kernel.org>
Subject: Re: [PATCH net v3 6/8] selftests: net: tun: test UDP tunnel GSO on
 retyped devices
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
> Use TUNSETLINK to make the device type disagree with the tun/tap
> framing, and check that the outer headers of UDP tunnel GSO frames are
> still validated according to the framing:
> 
> - tun_vnet_udptnl_proto.outer_proto_link_type: tap device set to
>   ARPHRD_NONE. Frames with an NSH outer ethertype, with or without a
>   VLAN tag, are rejected. A valid outer IPv4 frame is accepted.
> - tun_vnet_udptnl_proto_l3.outer_proto_link_type: IFF_TUN device set
>   to ARPHRD_ETHER. An Ethernet frame behind the tun_pi header is
>   rejected.
> 
> Without the patch "net: virtio: do not use dev->type to find the outer
> L3 header", the frames expected to be rejected are accepted.
> 
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

This TUNSETLINK ioctl is so odd. Changing dev->type but not really
changing the underlying link layer expectations, such as eth_type_trans.
