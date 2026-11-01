Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793545127;
	b=WznsZmV9JezbeWh+jKFD5Kb8JJIYDpL7DxbQzGbj+wU6D2q8bvxI87MzP4uwjLaNiwUs
	 BK1N+SOXM3z3k6NWtbt7Af3Ffdp0I0YQ+LTLh6ZNLOrXnRLQTV6tdt3MsbMGEV6vUFAnY
	 svEkyIIOZ1MZiODMTo2+RFsVFgXdz1rtVJjjwI7qzDeAN7xZIH/xU8A1VisKE68rF48tO
	 2LC38Q6EN5ovh4YkIUlqoSqWUV0UFIsIBqraDHjbvf7MH5c7UNS94rrB3dNDjB8qNaGZZ
	 pau6+1LnLcp60QZynCbDC5Oibn+wkouR5sphTv7erPpcQHnQ/+JREcsTd5GybN+orBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793545127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7fwCP5WiERcu+uoo4sVa26KzOzhIOdBQE6cn+WBX1uw=;
	b=thAOQP246MIaInIug0Bw5k7mDsL5hPSi5y58hTQlmmWQ/ei3KmZNr6Y1reiGHy695xbU
	 p4fKAm11pMRitF0oveDMLmEs0NcPtAGkkTUjizs/9nHRFC0JAFR9bYn610cthCi7bfga1
	 /ZHfw/3ywDtLy/OC0EidFH2rbj0HSFzjcTDT+FXAp0J+GpU1QCfRB4Y34ob+gp+JVNsEO
	 kQdh2ZsvdAK/7Zpu/+oWRs14QS3y5InZmP5uF1QB6IAuIbsubfe8MYXGZDV5CB1Hbz3VX
	 +n+h7JhDMlEanH9z8D4MX3GXeWtZU3wworVLaeoh8BWRr6hRTVp0kokN9JYm3Vk2BAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mnpyeGRd;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC31606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 14:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCC31606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mnpyeGRd
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so18676405e9.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 06:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793545125; x=1794149925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7fwCP5WiERcu+uoo4sVa26KzOzhIOdBQE6cn+WBX1uw=;
        b=mnpyeGRdFNhhWjgw+oG5a5Kdr4/rsnSfmY8Ve/XeIV/4nf5PKKB4p2i27bS4JFxZu/
         f6AysxzfzGa/66fp816CL/qO1CGdMl+VrV3PSgkBUGgoWArtISCXADd12Lq5yVfkI36C
         WtfkJnKd9metzcrDxWwDL20xHHCc1JxMAY3UPypOXtRiyAfSuB1BsUlUKEGxJRYpIqMX
         VDpDwrEvlSKXB/10iQYNprR5+Dc0Y/G2j2sT99F07g8WlZKsrTpKexybaunoC/K27Gju
         AaKWiAsaexDzeOEEvgz0a+p4SnVluaQw/C3c3+d0XHy7/QyTwm54u3lgJxaU0a32CLNk
         xyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793545125; x=1794149925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7fwCP5WiERcu+uoo4sVa26KzOzhIOdBQE6cn+WBX1uw=;
        b=T7MCevOdw1Azkm44REEGjxSo5dfNJ7K79VHZt2TpkBF+XKXULiKw2JmPqGawpPuwg9
         5PPovbEsSaferjfWMOOqysPDP4UKeaOmLVI/blVRnyNN8dOp6evgkr41eWanJ9tAxD8D
         boNUjxnRod2IN/1WDJ6MYE0gwF8QJeMVPksAu6SoAyWMDt1sgFDExOgRqqGDV1YuENQd
         +LD7NywnyNPC8ucle7BFxFSsABUE8nJve+r8CNAdwueOjfBbdDFKVLTNjyQ2ki+ptTkd
         Y8HP+DzofssIHF5/8QCAEDpk6Pc4kfM/SC1eXeiGGcDV0O9b9tFAOIIlPA7k6RxvLwvG
         G8xg==
X-Gm-Message-State: AFq9FYKJbfAEmgg0QKvKAq8JzfDPeNsAnssFjk+UNBiuxgecFgWADeFN
	zw0DG9QyBtGjsJu0VSyPp+g+J1eU7B0SPaFM6hVWr2DbJhYiBU7H0Cz8CV21KA==
X-Gm-Gg: AYBFou2mFjabMy9A73oZyl0cY2l23VMFgFzrdZxZIkRSj12CNR/ktwBbWGTm5bW3PJ0
	aoBB97TGuZBwc3zKReHDSF70I2x8ba/m39g1ksINiTpWA4IgRB+bRM6jO8dhQeOhTHf+yzVtEGS
	0ydG6va8yo6z2bh+Z0U3cSObL12TOZDRa58asQ47uhyNTzn4T/gHIoeuxMw+X+WaDLoqGmZ90rJ
	WlqzyKBTFM5Ac7BwaZLM2gg+cXLkYyBkcLcr+jBFPaS0A0silTSVatjm9XZ/gh2ciBVYJo/pP33
	qVNX5uC8fAMGb7Gq6ZDHlTDMr93gaojdGvbAAr97vVZbBkzutAxjArYfaeYozEpQysWr4ADxfFZ
	8GX/k7kO0LxZIsCiQo2h8q7NKjuNorqwRD9EjvtkeUG+8qY6ZCBWX5eq4hr6NqFB/wh8OdGHCuZ
	p1ZiRySawe8CIxOZcz1fXl26k7qbo5ts/gUIhywuN9wRZLCrlqI0fZke/i/0ILpkETSD31n5/SA
	jwujilGlkFTkmTXYaMvt1Ka5wkn8d3mRFH3fLVxFD4TZTEYGyWfprt8EBdJmgu9nCNfvwsZtYbL
	+OCPVSQezFL3tESa3pbhLUJHQdYcTpcpe9ge
X-Received: by 2002:a05:600c:a00b:b0:4a7:b304:253e with SMTP id 5b1f17b1804b1-4ac1765d8abmr182141725e9.22.1793545125214;
        Sun, 01 Nov 2026 06:58:45 -0800 (PST)
Received: from LAPTOP-AVI.lan ([2a06:c701:4773:6f00:9c55:89d4:b00d:2bbe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm314811015e9.11.2026.11.01.06.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:58:44 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	toke@toke.dk,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH net v2] net: parse the eighth nested VLAN tag
Date: Sun,  1 Nov 2026 16:58:42 +0200
Message-ID: <20261101145841.687905-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

__vlan_get_protocol_offset() starts with VLAN_MAX_DEPTH (8) but
pre-decrements parse_depth before checking it. This rejects the eighth
VLAN header and returns protocol 0 instead of the encapsulated EtherType.

When skb->mac_len is ETH_HLEN, the first iteration rereads the outer
EtherType, so eight VLAN tags require nine iterations. Check the counter
before decrementing it and allow one extra iteration in this case.

Fixes: 469aceddfa3e ("vlan: consolidate VLAN parsing code and limit max parsing depth")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
v2:
  - account for the extra iteration when mac_len is ETH_HLEN
  - validated the 7/8/9-tag cases with mac_len 0, 14 and 18
v1: https://lists.openwall.net/netdev/2026/10/31/78

 net/core/skbuff.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48f676411724..8eb5cf532d00 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7687,6 +7687,9 @@ struct vlan_type_depth __vlan_get_protocol_offset(const struct sk_buff *skb,
 {
 	unsigned int vlan_depth = skb->mac_len, parse_depth = VLAN_MAX_DEPTH;
 
+	if (vlan_depth == ETH_HLEN)
+		parse_depth++;
+
 	/* if type is 802.1Q/AD then the header should already be
 	 * present at mac_len - VLAN_HLEN (if mac_len > 0), or at
 	 * ETH_HLEN otherwise
@@ -7703,7 +7706,7 @@ struct vlan_type_depth __vlan_get_protocol_offset(const struct sk_buff *skb,
 
 		vh = skb_header_pointer(skb, mac_offset + vlan_depth,
 					sizeof(vhdr), &vhdr);
-		if (unlikely(!vh || !--parse_depth))
+		if (unlikely(!vh || !parse_depth--))
 			return (struct vlan_type_depth) { 0 };
 
 		type = vh->h_vlan_encapsulated_proto;

base-commit: cb284914e749388eef402938bdb3115fe1f6d337
-- 
2.43.0

