Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334170;
	b=zBav0OHZpEZahxBN+Ei4hnT9mOn1r3A5PtSMS4LIWEVP88GovZG1gFaJv/yzZqghL5bA
	 Cx2A/z3SBHfuq44ES37xJ1T3qXnM3cDtX1IiwQQ/RzfYdS6UOh4FpCyeFwQ6IzHIhgjL8
	 CSui5IqguyHOcJP28RBPYG1P4EWS13aoXzwx/bZGsS59s/O4l8dzIZqD7gJs01FhlID8C
	 nqidpUfm0fyUwDU9Xc8qrKau1mpXplbTdLyrovlJM0xbU778x0f6palQSsqTT5oXy5Re/
	 mO6JcqCsGSOtdN/SYP8VYHPQLQNfFANYiWD54BEIW7NMWkweHgAmyWPWoUC5byW7HQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oPIl+2oEPHabOjWk4tVLNrKPICyr6qT8RKDg7WJU7ek=;
	b=BKWubCgkQptbZm3ApITjrKbRU8ywqmym7a87xBpR1qzoOS6ZRXHuw7Yo2wxjEmVTmnVu
	 vjmpOk984y011GCL9yrndsb0zqYmy9l4vDNJKduFq8+OxAhKiHT+ZjKyVSDx1I48Z34BC
	 UbVXG7UY/jiZFHVDicdjFK/FHD+zrcmhSK5muz6QPWNZKXteZ3MNvGZIHeThHB+U6O29Q
	 hBDthI/ve3KU2iUUIflmmMg21Z06NzmyjaTqhjQvz+fnpLxeDdxgi4c13V4ZrbjEPZTit
	 YN+N2VpI4hWlMVjXc/jhOo/VMQe1E1WT0Jyxn8LcEZbgayfSKrO98j5IDmtTG8uX2Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Set+tV4o;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D56606A31D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8D56606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Set+tV4o
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6df0b02fe91so1079860eaf.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334169; x=1793938969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oPIl+2oEPHabOjWk4tVLNrKPICyr6qT8RKDg7WJU7ek=;
        b=Set+tV4obQ7M7+4r9gKQeiwhgOCufLMNr2KdJwsQTj9HuSGBAA6de41f359kIORSUg
         0F6ccfZDW0xSvbKtVK6dp1TMou/jhe4DDYq9dM5YJBxk4fj435JuJhEwq09ORWmZEc1g
         9XkHelDcwfnmoRJT6CC6birnv/uRC1W6h1SlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334169; x=1793938969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPIl+2oEPHabOjWk4tVLNrKPICyr6qT8RKDg7WJU7ek=;
        b=21/SceoXE/jkkYrGer7kbR+GPWMa4P7tVhx3hhObJKWJFSPwGPKU8gIL+pZDZ15Zh0
         tVTLAy+EhTHVr3Xp1uNkeJtnRbSnUWeP8t+mhKTbKTtTE2lvdNqczsMQM3QKKni05alv
         wpNLPtWpPOCly8S9rjf+wFfHA1S5vncSn179Nev7iTggLcGKlbrBTxVdKprJu/CtlTjt
         tSGbsojIGBLC9d8DjC9eocuKsdVk6p8MzhJ0gQ+uTg9DbR1w/KF/kOmY/bWgmB+41HUV
         rdUh0ooZcjg2485nYJ514CItZbJOhFa6BocFq+vgWy92ST1drPSxJ1bfGQcWJaD/tj9r
         8DGw==
X-Gm-Message-State: AFq9FYILY2VBaBf0OfLh2bXTxwFbikG2vyhKaYOskQoiB6tLhQ4CFRgv
	mHpi2XKYSesCbXWfYvX0SCdLBorUZUnuRDY6poFkoRy/ZT/109zH+vH5M4EJZm4ldh3ZEpKhpQq
	9xZPk99k=
X-Gm-Gg: AYBFou3PoGFJHscdIMEYfIlYnuJ8PA/9jpHdDe6GZQ8rNuoixSOAvglksmWchye5dxV
	slEKjlj/NpKq7ASNkEno/Y8ODQK3BPvAGbyOba/0jlauSALnkb7ua9pX1zcvwc9V27t0toAagJk
	mJsJeGiNBijCsMXNg/f8vwD5nm1Qsqa82Emb9u04u/NuxuAmCuidCBNhAmVffY4fCIl2YXLOXDb
	DjfRQX8tCrRj0j904AC0/GFy3TXDuw33dpOQUG2Uzfcu4ToMYuJCzDptlr+Gg7y1w9ScdgFli4b
	H+qZHoK3ImXOJkKe4tTNmILbmUdLr/hvJU0sLgHf2rXqU13ji/rsm036dHZDVpLLgFiAtqWJSsj
	dEAY/EkdR+/zUWauD8go1YHcELyDSase6r4tl27vmb29pvMRnyUU1Szb2aUQrFhdQO2tjmkjyge
	Hm27eQreP7ZqbNZNWph1HnYYZSY9pS+vaygJwVNCluFvtC8E4urYAcJcBVDNnQWr7ALDqLMg7aO
	WUVwT4sAdNYQRhCuO8N2q+FtEmJGx37Y4JtzBcJMYh0TypErR/ubC0YXWcv3TYXnlpGlQrDv4qj
	vIusBNC2vwTi4hbLfsMzAGQjwHJ6sERQ5fdfYlEoa4tr0FdciLXKg4DauATaMufVBGWdIspuD9r
	nIjuM5iORfr0zN7o6omgSmdrLdJlRrA==
X-Received: by 2002:a05:6808:bd4:b0:4e7:f052:460c with SMTP id 5614622812f47-5640df5a6c2mr657364b6e.23.1793334168751;
        Thu, 29 Oct 2026 21:22:48 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe0fc77sm691718b6e.12.2026.10.29.21.22.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:22:48 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] mpls: reject headroom that overflows skb header offsets
Date: Thu, 29 Oct 2026 21:22:46 -0700
Message-ID: <20261030042246.74144-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

MPLS output reserves LL_RESERVED_SPACE(out_dev) plus the size of the
new label stack with skb_cow_head() or skb_cow(). The aligned expansion
can leave skb->data more than U16_MAX bytes past skb->head. Resetting
the network header then truncates the offset, so mpls_hdr() addresses
the wrong location. The subsequent neighbour output passes the negative
skb_network_offset() to __skb_pull() as an unsigned length and can write
an Ethernet header outside the skb allocation.

For example, a netkit device with needed_headroom 65488 gives an initial
network offset of 65504. Pushing one MPLS label requests 65508 bytes of
headroom, but with NET_SKB_PAD=64 the COW adds 64 bytes. The new network
offset is 65564 and truncates to 28. This can be reached with an ordinary
non-GSO IPv4 packet in a user-owned network namespace.

Check the actual headroom after COW, including its alignment slack,
before installing the inner header or pushing labels. Apply the same
check to native MPLS forwarding, including its penultimate-hop popping
path. Use the existing transmit-error and skb disposal paths.

Fixes: e3e4712ec096 ("mpls: ip tunnel support")
Fixes: 0189197f4416 ("mpls: Basic routing support")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 net/mpls/af_mpls.c       | 4 ++++
 net/mpls/mpls_iptunnel.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index ad4ad6f2001a..4bfdb7c81f04 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -453,6 +453,10 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 	if (skb_cow(skb, hh_len + new_header_size))
 		goto tx_err;
 
+	/* The aligned expansion must still fit the u16 header offsets. */
+	if (unlikely(skb_headroom(skb) > U16_MAX))
+		goto tx_err;
+
 	skb->dev = out_dev;
 	skb->protocol = htons(ETH_P_MPLS_UC);
 
diff --git a/net/mpls/mpls_iptunnel.c b/net/mpls/mpls_iptunnel.c
index 1a1a0eb5b787..4eccbd911fe1 100644
--- a/net/mpls/mpls_iptunnel.c
+++ b/net/mpls/mpls_iptunnel.c
@@ -109,6 +109,10 @@ static int mpls_xmit(struct sk_buff *skb)
 	if (skb_cow_head(skb, hh_len + new_header_size))
 		goto drop;
 
+	/* The aligned expansion must still fit the u16 header offsets. */
+	if (unlikely(skb_headroom(skb) > U16_MAX))
+		goto drop;
+
 	skb_set_inner_protocol(skb, skb->protocol);
 	skb_reset_inner_network_header(skb);
 

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
