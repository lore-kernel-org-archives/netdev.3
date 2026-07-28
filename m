Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BED30B517
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251063; cv=none; b=k9RnxzYAHbk9hDcc/ngZBZDxioewF3oC24QJ8kurSMiuZuw4FoUP1IZmonjLRgc0ecA5RrINSVG8PbcZMJaOKDJex5+aK3z67dfkXFDvXVRrzGtU6VbHv5wlYHgx9kQVh5Lcss0ESFXEJmps1PhOsYCvi6bj2iEDrHIx9UIBpd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251063; c=relaxed/simple;
	bh=uwFNBO5plAQ6TYVP6zRWAUmHzeTe+/bSG6aJo+QnX0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=auoSI4EpZ1Wcg18vHzpgSprpUIm0OFOoe6AWkF/UeboMNly7SSStIfJ52BcQk50H6GJRVtXANjxim8Ya+4FFMWq/ydT1AuKElI7KNwadAa/gr5xuz+iIKVN9VXyQTAHZ3C2h8ZpOT10xPySbTPwM/EeCC/6Oeou/plns+KwYHHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvPFsYhJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvPFsYhJ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc97653887so49539235ad.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785251062; x=1785855862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VcRIXFSv5ttp/HxYu0D1j+UlNKDEDKf8QZ0AxC638Ow=;
        b=mvPFsYhJZuRfJYjOQO/SaQvI8XipJv7ED8tdntpEtrnhi/bPK1c78HmfiXUHT71n+u
         H59oxS3kS30km2oi4DPxm1aMSG1NkCGJT+WbHdxGCj9JlQvvZgjadRzuvf4k64QCeFQW
         rTM4UDfEtJnooLn5kNH513TN8nUcQyZ+K7wUGH6Y3x89xEUF9+uSlOV/Nw0ngPlOTPKO
         TttVTO+Pmb3h7pFqp7yV6FyrtwgG3hGiZYMdsyyIHZjhvsYsTfxDcZu4s9LTX/v30T3q
         zsRG2ZbvyEMEOE6hh57LHb1Lktv5O1v5Uc4ib6p/mrrsYrTeT333WYX1bW9Hu0bcD6GP
         fF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785251062; x=1785855862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VcRIXFSv5ttp/HxYu0D1j+UlNKDEDKf8QZ0AxC638Ow=;
        b=A3A/wrPjIsd3o7HqWIYXfZJj6f0RrslOjNz2+sPDDrk5KJ8Rk8aBXJxympsIlNqeK3
         xXCbLFxP30izHyRHCWfaAt66EUGZbgtaAVWh8fprNQ5CVRXTfHI11KhSs/bc7lNRktK9
         Pf41ZCHmzb08hOHUHviRR6cziNa4zj3lothEZaF3wMy6b5fv4s4YnVFe5F38AlO8cxe5
         TbOSAhclI5egBINHmvCdLWcd1rL+/fzpJjtBQek7x1ef3ncJXL9pjFrhxBNTGD0Qt2zR
         D6m1Cy++sDqdHzdbQ9b2KPh3xjxh0NCzksOPfSN4RHhUEl845+zvfObcGYaoYKs+SxPL
         VC2g==
X-Gm-Message-State: AOJu0Yz3z8R7Q4nqkz+ugzfJ/oi9IA1EyIsxDz5IshLEbftR2oum66oA
	03B/2zcMIcinQu00urCrQfcmUT8DGj3gF3n/YiPKyxQdBtrpFPq1vXBl4d11OU9QX6ZTHw==
X-Gm-Gg: AR+sD13Zgj6PIGEef52avdz/4LmbiTh2oGx+W5pfhGR+7ociOcBoVTn6MS2WMP4bsan
	drewTaJCPfNvi41rQP8Td2ts/mHSdiXazp128YoCICoRWxeL5tz2MtSOcvCvY+Cf81rM7E2HyAN
	rtcBqammCeH4vwkj9CJQu4mPMVbuU2jlLfOHcOUM75X4GotzCp00VA6uftKA700UPnTfiwUUjDi
	r5oo0HB2Tpfa8WWu5dOYkTKaGcVlziHyG6EiWptjYHMgMzM1x1SpFNOXAltKnFNqFcklz+j774k
	4emVf+/zTeRXC0pW4M738h83ueccWKuSge2xr6J4j16rlyqcQtQaT3fa1UFiaTcwWKVzgAsY7gg
	RZsCZTe62OC/pxH08QbQlUjOFcSwwXY1EeO7q91TACdrbK4UVW5LF7DZ8LqP/fKF3Gjqnkttixd
	udeJoLC6moqdBxJKwo/g==
X-Received: by 2002:a17:902:ce05:b0:2ce:9c48:22d3 with SMTP id d9443c01a7336-2d015c3e0bbmr34874305ad.11.1785251061710;
        Tue, 28 Jul 2026 08:04:21 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7fdfb0sm53919365ad.74.2026.07.28.08.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:04:21 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vega@nebusec.ai,
	bronzed_45_vested@icloud.com,
	enjou1224z@gmail.com
Subject: [PATCH net v3] net: loopback: ensure Ethernet header is linear before eth_type_trans
Date: Tue, 28 Jul 2026 23:04:14 +0800
Message-ID: <2d4e79d252a57bdad83435999dddf2c4b708dcfa.1785049236.git.bronzed_45_vested@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wyatt Feng <bronzed_45_vested@icloud.com>

loopback_xmit() passes skbs to eth_type_trans(), which expects a
complete Ethernet header in linear data before consuming ETH_HLEN
bytes.

If an earlier path stripped or shortened the Ethernet header, a
non-linear skb can reach loopback with skb->len >= ETH_HLEN but fewer
than ETH_HLEN bytes in the linear area. eth_type_trans() then triggers
a BUG in __skb_pull(), causing a short-packet handling crash.

Check pskb_may_pull(skb, ETH_HLEN) before calling
eth_type_trans(). This also rejects packets whose total length is
shorter than ETH_HLEN. Account rejected packets as tx drops instead of
crashing.

The analogous VRF path is already protected because its IPv4 and IPv6
callers pull the Ethernet and network headers before calling
vrf_local_xmit().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Closes: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
Changes since v2:
v2: https://lore.kernel.org/r/cover.1784709375.git.bronzed_45_vested@icloud.com

- Moved the root-cause fix from the tc actions to loopback_xmit().
- Dropped the VRF change because both callers of vrf_local_xmit()
  already validate a full Ethernet and IP header.
- Left any additional act_vlan and act_skbmod hardening for a separate
  follow-up.

 drivers/net/loopback.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 1fb6ce6843ad..54b83a988f0b 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -72,6 +72,12 @@ static netdev_tx_t loopback_xmit(struct sk_buff *skb,
 {
 	int len;
 
+	if (unlikely(!pskb_may_pull(skb, ETH_HLEN))) {
+		kfree_skb(skb);
+		dev_core_stats_tx_dropped_inc(dev);
+		return NETDEV_TX_OK;
+	}
+
 	skb_tx_timestamp(skb);
 
 	/* do not fool net_timestamp_check() with various clock bases */
-- 
2.47.3
