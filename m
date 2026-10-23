Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792718733;
	b=4MOUTYq/R58oQXFHsXzENLLebKDkSblo+I6B4BgOr9mPprLQFENO1nMh5rNu8rSwjTeU
	 7Nsi1I4twr5CgnUk0N80URYXNf2g1eOU08XE1WyH+uvdIvomABUdmVtCUV1zZ3mC61j7L
	 VmrrQRf28fs2PC2DURWkUNO1FW7Da3TEtrGMLZzGdOlL6bkETTDCUbjVBUVg85iSXdo50
	 WISs0iW6T3THzY+EhhP9vua3QTNHUkam+vJEIwlRiusp4mQSbV4ntQWARQUD02afKZ6Qp
	 vO9sKM/uKoKtyjT5fQ15tkS+keEEdBCUu81jlkDFKRkGAbMdfd2nl4Ng4VCjmf3DPog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792718733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=878n1kPFZyn6l+lPXMorB20ZQQzPY4CDTN2Iv2wh0f0=;
	b=Lvy2UgKKWxocMercgocEjbU3zLxqSqnxTCK7GCE4dhXbIpdSJlpWTuUfFuQCBki9Yu9r
	 mtBR7IfxKlwXlneuWJgCvnqUQK7sEjHPfMMQKERCA1IlCPKosSOj4OPbBBqpP9VdsjRhB
	 GlLxuW9dumw1LUdOUoAaQb7PbYEK/5A/YxrqBCsfwnWq7P0kYpVxECdcHGRhZ9oNjwnKC
	 uoLaigb4yWlFuo3XvwjV1XmSzKYN+EAhJGd9w4TEAXLEADGOJuWlrni1mPU7fZBl1BEXa
	 DXcxym1GHAExxs4AeN1YQLfWtVqL22xF6SWlsyemO7/IVrI6yUx8PUperSxG96aq4Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodkind.io;
	spf=pass smtp.mailfrom=goodkind.io;
	dkim=pass header.d=goodkind.io header.i=@goodkind.io header.a=rsa-sha256 header.s=google header.b=KVk19zxc;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8926606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8926606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goodkind.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodkind.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goodkind.io header.i=@goodkind.io header.a=rsa-sha256 header.s=google header.b=KVk19zxc
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1931ff67a29so953510c88.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=goodkind.io; s=google; t=1792718732; x=1793323532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=878n1kPFZyn6l+lPXMorB20ZQQzPY4CDTN2Iv2wh0f0=;
        b=KVk19zxciABArCXimHgBMqGUWtwLbgCA4yGNqcliBbI30HfHRkKshFOT7iG15Yug+b
         7sWjEqkuEghVpVpBgVVzZKSn1IkYmZ/2f63FVo0gc+t+/6GNGZXur6iour6p3to1Q/cd
         fHpnHC4QYq3ZjXFPXgqC1eF/CQqiD0vtAAUcQcEKl7rfww7ueWcAmKG3/7ikAM26i87s
         KlBWFpN4hYV4aEvW8UlYbMhamP5B0Am5i4sdAHXXbSpNyqkxKR9YQ70IQ5DdPyW1c2Rf
         sgBR/1e+dJRcBObUNxVD0NU4l7QfEYEasFV1I78krMEy90I7nid8qWPsoVMqDudEjWB8
         eRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792718732; x=1793323532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=878n1kPFZyn6l+lPXMorB20ZQQzPY4CDTN2Iv2wh0f0=;
        b=pPOwhcXGkyCVLQeX3bI4hi2XHZj7zHEHbhY+3ONvLfmqCHyZAKVtDXMcv9bD0/olaO
         amEVk5VltOUl9lvv4pKmJw+0r75q1Ab1rvtn1Kw+JkQ2mtONgB/47+SXHic0LakteILv
         AIUUdVbfwpjKFkT6Z29cwVebV2GoJXDQMoWn9K9VLpnick+gG/GC2uVC+jiFo6I6MALT
         0Bc79xADG70wxxrDBBhWCASgqOsP+bzmuKIMJTrJTItD+Xqtn7ka/1Aa2WZ/qORfdP9L
         BYDcw+OioAyKiYNk0GtYH47A5S2OUZTlP7HnOJK+VOFIVm3pgTdfPuTr/B5570QpNNQu
         GchQ==
X-Forwarded-Encrypted: i=1; AKwUvBym5VNG8dA7UVYpvs8z2qHOtIlvtfGfzUS6nIPXYmueVrEbGaLfICug3Y2tIuJ3+9TadX1e3+Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHFcAGRlCHJyUBtW0YP9xW2V/i2EQkErnbzVMWy6bkuS42FXUI
	pYHn92wcwTGeX/8WQZHtdth+L/VNYRtoSMJFocZP9lTq95HAv3a3IfdKIGxgOm5oFQQ=
X-Gm-Gg: AYBFou1fb0s3zn0XhJnl2BZTDEbX55JB0XfFlPCG2uMFXPDIBk7fYmavBgtL36Q8Tt4
	JEB+rk+sZGYCYPnQQ8PBkw1lXNEZGVbJVgLSKudDWlpsJVdFa1jbA3Zmh9OOauMiqqLc4YsGJmr
	ZyI63THtYX7WPsKtRHSKEfgFSPsJiebJRYKU12MsziRx28eOlfap5SPWF0yLMl8jSv+r6o2nApi
	slLwbkEN9ZRYZfzHIOFySVocHuFwkv3+tWwkSGDEGBmYQxD5QKLnM8lF6olpA+qoD6XytK8hZ/W
	J+O6wdgdHDD8/6D4BGfA6wYb26j8uwax2uTgMBMlbInZKZGjWmGACeLB4RHk7h2nSxtopkqnt5b
	Z7O+bKxX/38k6vcp6luTjO34Pzc0DWxdG8RTs1z7SIbccd8NSBeT65INgLZjyh+X9q4jVvZFWz4
	NhPtcRboTufpad1ISylifCnBFtL5YuZPJMkna8cz27NZ20WwwPotR8ucYCqNd2Uha2gxNx5fWvb
	v5CIyCaY2VD5T43SpRGXfvbMWzoSzu+AjlIMBc7L7gG2OU74ZmHSl4Qgb4MmZhmr/L/9oI=
X-Received: by 2002:a05:701b:42cc:20b0:176:d885:4e94 with SMTP id a92af1059eb24-1959f9df88bmr1360589c88.26.1792718731771;
        Thu, 22 Oct 2026 18:25:31 -0700 (PDT)
Received: from localhost ([2001:5a8:4296:4f00:7134:385:b14:41ff])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-369d9d89b1fsm1703137eec.11.2026.10.22.18.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 18:25:31 -0700 (PDT)
From: Alexander Goodkind <alex@goodkind.io>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexander Goodkind <alex@goodkind.io>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Tarick Bedeir <tarick@bedeir.com>
Subject: [PATCH net] net: ethernet: mediatek: preserve sibling PPE bindings
Date: Thu, 22 Oct 2026 18:25:29 -0700
Message-ID: <20261023012529.5994-1-alex@goodkind.io>
X-Mailer: git-send-email 2.54.0
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

__mtk_ppe_check_skb() clears entry->hash for flows bound to other
hardware slots in the same software hash bucket. This makes
mtk_flow_offload_stats() skip their hardware counter updates.

In the regular flow branch, clear entry->hash only when it matches
the slot being checked.

Fixes: c4f033d9e03e ("net: ethernet: mtk_eth_soc: rework hardware flow table management")
Link: https://github.com/openwrt/openwrt/pull/26107
Assisted-by: LLM
Signed-off-by: Alexander Goodkind <alex@goodkind.io>
---
The MediaTek Ethernet driver stores forwarding rules for active
connections in hardware slots. For a bound flow entry, entry->hash
stores the hardware slot index. Flow entries for different hardware
slots can share the same software hash bucket.

OpenWrt's driver maintains cumulative packet and byte totals. During
each statistics update, mtk_flow_offload_stats() subtracts the previous
reading from the current total to calculate newly transferred traffic.

Losing a hardware slot association lowers the current total used in
that calculation and causes unsigned underflow. Conversion to 32 bits
produces a false increase of about 4 GiB. Subsequent calls to
mtk_foe_entry_get_stats() return only the unchanged prev_packets and
prev_bytes values, and mtk_flow_offload_stats() subtracts identical
readings and reports zero increments while traffic continues.

Two UDP trials reproduced this failure on a GL-MT3000 with MT7981
running OpenWrt 25.12.5 and Linux 6.12.94.

ARM64 allmodconfig and allyesconfig builds passed on net ffdf678dd166
with GCC 14.2.0, W=1 and CONFIG_WERROR=n. Patched builds did not add
warnings. Existing -Woverride-init warnings fail the unmodified build
with CONFIG_WERROR=y.

Codex assisted with investigating the counters and preparing the patch.

 drivers/net/ethernet/mediatek/mtk_ppe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -764,7 +764,7 @@ void __mtk_ppe_check_skb(struct mtk_ppe *ppe, struct sk_buff *skb, u16 hash)
 		}
 
 		if (found || !mtk_flow_entry_match(ppe->eth, entry, hwe)) {
-			if (entry->hash != 0xffff)
+			if (entry->hash == hash)
 				entry->hash = 0xffff;
 			continue;
 		}

base-commit: ffdf678dd16610e3f006dac904bd37c09684673c
