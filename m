Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208886;
	b=FqcfO4xIuLAWAHtah1kMQY3xQDV8ilQcgjAj9gyzAYMb2DwmUWUlBeeFN0xmliQqKE0j
	 Q8USMwcV/inojcEpV6i9Qflrh8eLn9mMrfA7buiXLxvQHhG6eUcSlCefNLiKX52cnkARf
	 UlbmxqpzGamaeHFjlpHeuF/n21af1DlJgy9yX2NZzPEU7zuCicf+MTmANSi6e5u/2mIga
	 YV6DivZdKHdHyuvAYOnqFMLELZiQUEzdyycDBRyXgpoYtuweHuVzYDVonay5d+d047uNP
	 HXY5RZy6y4ysubDkgM7a7R+oE2L1DjrDOMTDNKrF5CDncykZuuSN8PHbsvxzYAeVM6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=neK5tVmH8BJN6Iaz3+r0fZXi0ughyglHJUA1SeN9g+0=;
	b=mT2FKyGcUmR9jAtPAbmDUG1A14pGD92JBb0HIfekwKGzA9LgQumzS2Oecb6m58h5WAzy
	 FNzJ/4mLTPuRjMaJwAZjmisTjcoJIb5e48MCq9BX6hJhOo5PqDCwUYzfYLPK/hxCeJALk
	 JQmgIRBgytRaDbBsDm9ksBWI00WP86K3jaBpxB3CDFpqxEwRyoh7MYQeowaqkH/nL8ILh
	 25iQqK7vI9dbiF/Vz2LoXsWqcIMSHllVxfJIDLiz4YUGDW9TG44epNvzCjmUTNjuhi3kX
	 mozJDHrk9PcRAyWKhdSKTNUJv7bn+OQ8FFZFWVBgaMYmQmgF8the1hA/HIch5Eggo4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IcBAz/Tq";
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA02D606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 17:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA02D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IcBAz/Tq
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a0673d9bd2so765747b3a.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793208885; x=1793813685; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=neK5tVmH8BJN6Iaz3+r0fZXi0ughyglHJUA1SeN9g+0=;
        b=IcBAz/TquQVqZ2oOB72uUSGmRjQN9MLnoiMyqRSAvhZEQLTmITo3ZcJFBIBpBjrtum
         CZLHlBF0I25fGpD7uDTM/OrLAXW1rOgesr59MfgfEr7vA3Y0B6wT7WJ+wHZ32r9X43Nd
         05Gk67L5MQY4a2ijzAXTMT4SFQkiTbNZOrtXPk9TrNkKQhs0pTizDssbHAMriXwp8hGJ
         eHz0Ej1DtE8scFKVD+K/XA4n76S19tExhKLAaLdrc672kUi4eW4hPpL/TWn/vY33e/LR
         KOEjMvdHb6k3+w3PzeGnv9yB48eRekekgRn1MI7lp3guuENZq7ZuQi5XGR7WhDucUENi
         e6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208885; x=1793813685;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=neK5tVmH8BJN6Iaz3+r0fZXi0ughyglHJUA1SeN9g+0=;
        b=Y5uRjUply1TvHc2tley/jxgX7+LXiPK7ZxL4AS+FpOYp+J+KtxD7i84YVHsDmmp/Pm
         pFKu5T6QmVviT8xuThLLJHZRsqJqIibbvJtf4uzsyD1/JTsi8Fj2lELzUeqBReyAHQ+c
         qw2KothUJol3rIeZCqDbRH4fu121Z3danUHnhDZIpSjVXjNhLPQwb1DOVRS6APv6GqiO
         VDmgn55+rFaKNVJfqDgrQAXtbw3IU5/TN6YLREjYB8/8xRgF+qJSiV3O8uiGldrWLFya
         kiAwbBkhi8jvuQ0ZpWd05mt1vBmvbyafhRVM6V7qcjjGCvFuj79NYnnTKuy5p8acgi9f
         lYYA==
X-Forwarded-Encrypted: i=1; AKwUvBzn7TCuuKMqsBkjUMnRJmOenxEblXfY+ukT4VYcv/gTKTFHPRpKwukkvVUiF7iBRYPCqBGp8GE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIih4+bSmP8GvGBR2f6BLLGSr5cyajGgQuxp0oLNGt5XvmNsHBU
	cRj9l0Ap5q9WAG+wWdkc5NIs4Rgk0ootmfIAQ9zwVRxSvamNSWvg5qZn
X-Gm-Gg: AYBFou1ctepENy5o2obs9+VJj4yBts/RLyx1DVxnydHtuR4sAUvLETUpzxBzenO+ptS
	JeP3yzK4JcsxhReoUJsCoNVzz1M7TzVg8yTjeOuKCrD6it0HT9heSgkuq3XoGeFbJQHdm1u3ab3
	M7lEUCTtq6QcK6pOcfA5ouFlW+xZQ1sdwTmphAguS0AOFFa09YXisHqsIPRO025cRA3lA5c6K4p
	PZdY/YxWve8m7labjIWmLIJvFb4VIESWHyw/hMlbwwOoZzQ1zDyeP3TZM4dREekyr4SERsa5R2a
	6y2zCYXxB5ggxTX+L1YX0ZLy+SLYS0NFRU0IgSbhs0vkb5WE+nzPpWlKWLamNxv/ZMCVB8SBzhX
	h+VNtWGVWUiBD9iHB/ebquU9VnX3v3F4fNXDRCbVcspLZE0ECh8O7BU7posrT2gMEzSEf8POTpX
	Oe1ihFHKzUXlKICG44huAdockquoUfwKHxJWBOREQ/KMXPILQMSQWOKvBLJAmDHBvb590SbRVDw
	FhyCNu5jZsjYKA8EctEZu6lF0nZVbPP2gbpTTf+TId+k/RWNuYsSyyjd/QSTznpBSUZ+QBC7Tj1
	aLjqnDTIQKm3JgWY5OfewYC/m5NvSYwgmeiO4n1VI9RQM0qWeMNNFLPNZ+ulSJ3OYi5wUSY2hLV
	YnDc6W6DKvclvXa96XuRlsXtRrPvT5LRq6MeQf2ndxAh6Z06o4BKmwRY=
X-Received: by 2002:a05:6a20:918e:b0:3e2:99ef:ae90 with SMTP id adf61e73a8af0-3e90241ebe0mr2592968637.53.1793208884997;
        Wed, 28 Oct 2026 10:34:44 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc212f9sm4521917a12.9.2026.10.28.10.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 10:34:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 17:34:44 +0000
Message-Id: <DMGNHWT5M153.3C6CZBKTPNBAY@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eric Dumazet" <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>
Cc: "Willem de Bruijn" <willemb@google.com>, "Simon Horman"
 <horms@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "Aaron Conole" <aconole@redhat.com>,
 "Eelco Chaudron" <echaudro@redhat.com>, "Ilya Maximets"
 <i.maximets@ovn.org>, "Jamal Hadi Salim" <jhs@mojatatu.com>, "Jiri Pirko"
 <jiri@resnulli.us>, <dev@openvswitch.org>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>, "Ren Wei" <weir@nebusec.ai>
Subject: Re: [PATCH net v2 0/5] net: fix eth_type_trans() crashes on skbs
 coming from the stack
In-Reply-To: <20261028122703.2093730-1-edumazet@kernel.org>
References: <20261028122703.2093730-1-edumazet@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 28, 2026 at 05:26 AM Eric Dumazet <edumazet@kernel.org> wrote:
> Other eth_type_trans() users already pull the header or never see
> such skbs:

netkit_xmit() has the same problem, I think.
It calls eth_skb_pull_mac() directly, not eth_type_trans().
It pulls ETH_HLEN before netkit_run(). The prog can shrink the linear
part after that:

  AF_PACKET SOCK_RAW on nk0          eth (ETH_P_IP) / eth / 8192 bytes
  tc egress on nk0
    vlan pop_eth                     skb_headlen() == 0
                                     skb_mac_header_len() == 0
  netkit_xmit()
    pskb_may_pull(skb, ETH_HLEN)     skb_headlen() == 14
    netkit_run()
      bpf_skb_adjust_room(skb, -1, BPF_ADJ_ROOM_MAC, 0)
        bpf_skb_generic_pop()        off == 0, skb_headlen() == 13
    eth_skb_pull_mac()               BUG() in __skb_pull()

It's an old bug and it doesn't block this series.
It can be a follow up.

Something like this (compile tested only):

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 82e608e..f093103 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -116,6 +116,9 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 	switch (ret) {
 	case NETKIT_NEXT:
 	case NETKIT_PASS:
+		/* The prog may have shrunk the linear part */
+		if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
+			goto drop;
 		eth_skb_pull_mac(skb);
 		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 		if (likely(__netif_rx(skb) == NET_RX_SUCCESS)) {

For the series:
Acked-by: Alexei Starovoitov <ast@kernel.org>
