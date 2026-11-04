Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815162;
	b=PR9xVGBmdtHkAcggYTKcYcF7dH5NnBmB9OrAnbVjbpIw39w+Q8LCmvJWV41mXKc5Xo6P
	 KeJXwvdyow6Hym0hNpwxR9a0UMOsX6HPeIL/Je+PnnHC6W/AajBovom9QYxJyoVqijl/S
	 TbWw06kAd0/la93Hu/J5INPtadzgzEMbgGFmMDiwhfafFgoltF50IQ0fGNaUIQoP9Z2X8
	 KfitpmlznYI3O1jE7DAFxSWhRyq5GiWNm+aCGEMDmYKP76Un4CWCStuEUerZl1lrB7stG
	 xvPEn3GfR8vu1itec5dIPx6thRW3q2CMdm8wxWT4fhS20rJEWmnXeIL5GcX0JhINgpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=alxRdOw0ifgGw6E4KPI/BCLiVFQxg6B2Q0J4yj2r7CY=;
	b=NIBDQIQVnyBs817c91GuRQl1JQjbTN9onYFJxssi8Ht4CCDwQrA8UooFKTJeQMM4CuAv
	 LIBtj3rXuQzfTvxNgmX0e04vrzgxzzcjJc5PFvfo/ilxENFZ0cVUEXvlJXKuZ0XBTpSP1
	 xK+JpbpoigOC3QW6vkG+67vGGZf/EVjTe8csZwbpQH2+0H/USIM6CK3qHezAzU2lOkfHz
	 4Ywq9ecQt8wJal48E+74s42zNPcYvPgHJqFGEUlxfgvtY/a9GbL/VtrZLfynPoh4AtC1z
	 fIHQ2/2hVmuDFbfZ+hYULGvEMlX9hVDi39i6XBZRvXBEBbF7+3jGJvT0SdtD7SnsYpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KSdi1Tvz;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE60606B084
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 17:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EE60606B084
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KSdi1Tvz
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9ae391a05so6158335ad.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 09:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793815161; x=1794419961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=alxRdOw0ifgGw6E4KPI/BCLiVFQxg6B2Q0J4yj2r7CY=;
        b=KSdi1TvzgevhF1rwqZI4dA5KBQMqzFDcfeMf3wzF4yoOsBeGrtC8Rg5ovpJNVCGQN3
         03ZzQxvDEV3Rs3vujEvyK9XhExo+zh+m4dWtJhVDlOBk4bz1fMxMlVIFAWMw8JhFvLrR
         sQXZhyfTl3icbBOAEtaKiYV2hF8qqmpsobJ5bYNG+4FnbVKqb7bwEQqbyvPs7taxT9iC
         J4Nw7ODX6LI4svZUMUbjXBeHgczL2vKPAlSy9r8a2AvpR4ijQzaUw2GUwcikccEveQBG
         zWYqUenxiQdTAu+8LcH/PfljEgUxO79lZVWFFDKxsiGlntMk3VG2fMa5WGUoCCRp9f3V
         gFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815161; x=1794419961;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=alxRdOw0ifgGw6E4KPI/BCLiVFQxg6B2Q0J4yj2r7CY=;
        b=HnQ5Jh0jgAUaC5BzFQexSKjmjjMONqfCPiKWuA3GhHG7I5tl+vvo8X2refLIuiEqJN
         OJJha9Qk/jfQ2J70byzsVu+YVBeYlpc7c4NNrnnuO+HJk/YJ9l/lpbveK9DwsZAmq39V
         dZU8ZQ7dM61xcAzXyqV6qENg8AO/rDrgn7XPyaJXDTjD6jBFHo5fIWjM/wCJ0JGDGzUo
         CNNHopQ6ms+fje3+F96Wx1cC1ZmYqDxIvjyEEAulaDTe5cl/m9cH63IlvNLAk+U7Z4s/
         VNS2C7FWYSwuV9FTpk3PWqAPDDP1IqrlqAaevSPtxZpLsiBnW1ZhnZ1qT6OI3KfbkAhs
         vcVQ==
X-Gm-Message-State: APuU4Z/78TXl2Fq5hZfHuKkGn8ypOzQAtnVA2iAhNDDfuQlsSZMSizHi
	VXhE9WWMnVCE/bSEXNOhYAtZ4GZwu7XB9xCcRvHodck9xnkOcuj2pF9rHTP3Qg==
X-Gm-Gg: AYBFou3uevfwPc6UEKf1G10P4TMZXUWmmionPSxDlcgSu0Z57ZhO0bOrdUp2bth2aaQ
	ddoPW/o3qVIH8PWR8yAH8I77noD/Koy/n04nxteX8PJMXxW6EOScf7PJC2VABumH2f/WljPEztl
	6sjSFUeLrOkVzg5P32Wcw6E5WUV5YSymjHEh8g6CvWcPYrzETQvBlyzCWFKcv9aoD1pLWXMOlkr
	d4wOoRSxkfJt+Q4DjEaBRigl/4oPdm5mU/OgNCnuaNe6r/+HOdtxmLdWuVFNcLXYPJ1Or+Cwjy1
	15ZKu+BW7iN8bRy7mYIjIVW3eAxwjb+sgOdCOYAyv0yPesbRiP8VAS3wEKCRTfQTHEdtTUHY3Pk
	rBbryKfPeP0p+GtmrY/lmRQZ9TJKt32N7nDyMsqmF5iIswbiDC/zyDs1VPASIYI3KDxzCVax6Qw
	TzjLMA148g5Ap417V5wq+vBbppwFJrfmrhfBn6XrdWOE7zJLdd/jwrFjoX4QaClMcsLUF99T5vq
	BNAaT1TOeAktda0Mngxkvgt7eoKe/0KgHh6jSBud4TuLUgrdo4fn5t1F7ebreAZ4ZIN3eQTpXxn
	6KGGfQx5NtWk4fZuW8/po3FunHVWQeTKph/c5K77anpXOMnhq0/Rz8i07EFGKIEkBw3Czm2AfOV
	jZ/KMKcsIO9flcU/6cFaffUzuRrslK7uOSgf6ic5nwltcMQ==
X-Received: by 2002:a17:903:2f8b:b0:2e9:528c:b9ea with SMTP id d9443c01a7336-2ed23ed9521mr1202465ad.11.1793815161275;
        Wed, 04 Nov 2026 09:59:21 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed08fe3238sm10586305ad.17.2026.11.04.09.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:59:20 -0800 (PST)
Subject: [net PATCH 3/5] fbnic: Disable PTP completions during the Tx
 force-flush
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 04 Nov 2026 09:59:19 -0800
Message-ID: 
 <179381515954.9644.10831265959574467679.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179381496288.9644.9775319757787890210.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179381496288.9644.9775319757787890210.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

When the Tx queues fail to go idle, fbnic_wait_all_queues_idle() falls
back to fbnic_tx_flush(), which sets FBNIC_TMI_DROP_CTRL_EN. That bit
only drops packets at the Tx MAC Interface start of packet protection FIFO.

The PTP completion path is governed by a separate bit in the same
register. With only the drop enable set, a timestamped frame has its
packet discarded while the matching completion is still forwarded to
the host. fbnic_clean_tsq() then walks the ring with no packet left to
match it against and reports "Tx timestamp without matching packet".
The drop does not retire the completion either, as the completion FIFO
is only drained when the completion disable is set.

Set FBNIC_TMI_DROP_CTRL_CMPL_DIS together with the drop enable so the
completions are drained rather than leaked to the host, and clear both
bits again when the flush is turned off.

Fixes: ad3d9f8bc66c ("eth: fbnic: add TX packets timestamping support")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h  |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c |   10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index cbb25d11638c..414871a94104 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -441,6 +441,7 @@ enum {
 #define FBNIC_TMI_SOP_PROT_CTRL		0x04400		/* 0x11000 */
 #define FBNIC_TMI_DROP_CTRL		0x04401		/* 0x11004 */
 #define FBNIC_TMI_DROP_CTRL_EN			CSR_BIT(0)
+#define FBNIC_TMI_DROP_CTRL_CMPL_DIS		CSR_BIT(1)
 #define FBNIC_TMI_DROP_PKTS		0x04402		/* 0x11008 */
 #define FBNIC_TMI_DROP_BYTE_L		0x04403		/* 0x1100c */
 #define FBNIC_TMI_ILLEGAL_PTP_REQS	0x04409		/* 0x11024 */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 0bcee152d47c..07d4b2e92362 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2349,15 +2349,19 @@ void fbnic_disable(struct fbnic_net *fbn)
 
 static void fbnic_tx_flush(struct fbnic_dev *fbd)
 {
+	u32 drop_ctrl = FBNIC_TMI_DROP_CTRL_EN | FBNIC_TMI_DROP_CTRL_CMPL_DIS;
+
 	netdev_warn(fbd->netdev, "triggering Tx flush\n");
 
-	fbnic_rmw32(fbd, FBNIC_TMI_DROP_CTRL, FBNIC_TMI_DROP_CTRL_EN,
-		    FBNIC_TMI_DROP_CTRL_EN);
+	/* Drop packets and retire their PTP completions */
+	fbnic_rmw32(fbd, FBNIC_TMI_DROP_CTRL, drop_ctrl, drop_ctrl);
 }
 
 static void fbnic_tx_flush_off(struct fbnic_dev *fbd)
 {
-	fbnic_rmw32(fbd, FBNIC_TMI_DROP_CTRL, FBNIC_TMI_DROP_CTRL_EN, 0);
+	u32 drop_ctrl = FBNIC_TMI_DROP_CTRL_EN | FBNIC_TMI_DROP_CTRL_CMPL_DIS;
+
+	fbnic_rmw32(fbd, FBNIC_TMI_DROP_CTRL, drop_ctrl, 0);
 }
 
 struct fbnic_idle_regs {


