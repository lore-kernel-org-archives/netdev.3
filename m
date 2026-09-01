Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC0480DF5
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280422; cv=none; b=m9vtvEjbUIeiocls/B5LZc91MAmGG1SMWMzuE91GnnFbwMAAbsDc4kbEPnetwlvNkmSRbcLxcwxGNPxVrMan5v1e2/VeT4+DdPjtnhqw+7Xz6mCc9JvSh0kohbFKl1HxEPzck4Yqoq8UFXDQYb5NJ3yyLks3hjFRDc3C76AxSh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280422; c=relaxed/simple;
	bh=HkHzt3ZwUXXr8ahJIwDVgHcwAO0rAKRD8jm7cGTsBcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fU5O1B2O0Bj6O+paUq8Ai8rUul7X6LHv5irmvasMbUZeKbMYIgFNZ8uhUzWp8sCWnuc5bY9avsBmF4HavakbNN6LV1ZpYcw+WDJ0YW9oaGmylvIZ+w+AFGgHgmnGatByMClZ0W1CePnp6tnPnpA1capTCOOFz3IDViJGrDtJYSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyEC7HDy; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyEC7HDy"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a2b4743936so180101fa.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788280417; x=1788885217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8SPDGoSTl4FqMo3J2GRF/g+R9eIi+flZl02DefvrWrw=;
        b=RyEC7HDyKUNjeOkOFrBDsB3j8tqS1OXXOdSka6LiHnLyJaWVb2l/Gsm7jxfWF0lZde
         PseWB2UDTw8PQJcKUV17nJELnP+xD2pWxfpL7PA1EzgRiX1CtLdZzFo/sDdBq8vKin6j
         nhwWToDwCPzTA5Ga9jB8ebV6lIdrYBLNTNdk4mP2nwZ/tvb4A3afUk6tENJxkoFkKQTv
         FXAmg26TeCi39twr//p2GoRxx/73lYqK7zqTR3TkRIoN0kg5wAapIV5gdshfFUrzgTm8
         O8YHYImJgijtaQiXgtrVJ5JC6n0AUCoo6wS55ow4KSdww/iy7/t1Y3MrI55VJWQuM2pm
         4Ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280417; x=1788885217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8SPDGoSTl4FqMo3J2GRF/g+R9eIi+flZl02DefvrWrw=;
        b=IVA4G7PJf1gc5I41/sNerLGCj3RGyZsoDxCsylXfAC3w6S/kAsA1qv/rBBGjYzHwju
         CsbHwjN4FwgLqWg/7lew2N58oIiZbWuXFfcFr+vQc1tb7ivkAlM4H4mmeGXT99QgD3te
         xMdf8YVFxnfFn5rjawiiUrQfpx041lvMn6hNmeD7LQwVBe0ilk5as/jg3FB001KoHSW9
         Zcgq14uDDn0xVv2iSCM0rzYi6D2PETflp8o84SRWbBvqYYlg6sOxeYgCZoWlCCXa4S/h
         BPKFdTLn8M22oV/OsdipGe5q56HcpVeO0uTeYOXf/wL9juiWOq5nnZ0a38rxdCT2XuOD
         g5xg==
X-Forwarded-Encrypted: i=1; AKwUvBwR4CFTRd5PGizFW//q70rl6HnQUXDDaCcQyk92PpdxKL+NvG9/lGpCSywuEBLkJ8lIR+fOPng=@vger.kernel.org
X-Gm-Message-State: AFuF++nh1drns89sD8WsADAKojbl7rCNGCX+ORyG5xVoPBBeeeE6YDGP
	On2mcvSD0hkieJvhqa0s/4ZREc2W0CpxsG4ZcxIWIVChXy6EsXayRf8=
X-Gm-Gg: AYBFou2pCyjSQm0A2eEAQ3MhktHYRvhEpdkGlYgDRN7yumIhrKrmXyhCyDA76ce5Lw8
	MV9x4KFiNoAim3aLBNsysrVJdRLhrR16N/yjQxohM/hYU4TD4rMugRplm8wXjRhW3tAlECCmjvi
	14LF9V2L+OyYEZ4mG/7HakN/ej0r5qq/cNrdHOFty2g/jWWgRLPHRcsdSZRxfpO6M3+q4IpLgAh
	rPpo84bup3N3Fyc+7PQc1/wHrVIAQMeIPT2F+mrzF/wTy7yooB2kZAwszJGx9HLLtElmVtkW4vq
	5KHk+ig1rxGb5B4jtUbv1BRT/HWoipUH4ZKK9ZGoZxqZGc70iNj1lhswhm2HbGQ3oeKPdHjMBLK
	JeIqBBH8JNOmWKV3/Kj8J6Ctj5vOlrAy0ORgIgQ5WM+hrVOJ9ORtxY3C8mvpQleQMudW0QA6KDW
	dR8bsHjSxR87nV+WcteDbLPJcfB6iXfgUkZeEvAZ5H65+euEKYVQEe
X-Received: by 2002:a05:651c:2224:b0:3a3:368:fb9f with SMTP id 38308e7fff4ca-3a30368fbfemr67836761fa.13.1788280417031;
        Tue, 01 Sep 2026 09:33:37 -0700 (PDT)
Received: from fedora ([92.36.3.203])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a34a8ed967sm678251fa.7.2026.09.01.09.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:33:36 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org
Cc: upstream@airoha.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH net v3 2/2] net: airoha: grow the small RX rings
Date: Tue,  1 Sep 2026 19:32:54 +0100
Message-ID: <978fe95e4c5ddb05ceb7d8c4d00ea2d2203b79d0.1788286284.git.sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788286284.git.sochnev.v.74@gmail.com>
References: <20260831234701.206021-1-sochnev.v.74@gmail.com> <cover.1788286284.git.sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Raise the RX_DSCP_NUM() fallback from 16 to 32, the vendor SDK default,
and give ring 4 the 128 descriptors already used for rings 2/11/15.

Ring 4 is the shared "force to CPU" ring that airoha_fe_vip_setup()
routes BOOTP, PPPoE Discovery, PPP LCP/IPCP/CHAP/PAP/IPv6CP, ISAKMP,
DHCPv6, SIP and LLDP onto, so it sees the same bursty non-hashed traffic
as the rings already on 128 while sitting on the smallest allowance.
Both CDMs forward to it: REG_CDM_FWD_CFG(1) and (2) each set
CDM_VIP_QSEL_MASK to 4.

The NO_CPU_DSCP fix does not cover this. With it in place, at 16
descriptors the ring still dies during PPPoE negotiation on a Nokia
XG-040G-MF: over 6455 devmem samples in 60 s, REG_RX_DMA_IDX advanced
0x2c -> 0x52 while REG_RX_CPU_IDX stayed at 15, descriptor 15 had DONE
set on a 60-byte frame, descriptors 0-14 were empty, and q->tail was 0.
Hw had completed a descriptor the strictly sequential consumer in
airoha_qdma_rx_process() cannot reach, and negotiation never completes.
At 16 DHCP still works while PPPoE does not: a dial-up bursts Discovery,
LCP, IPCP and CHAP where DHCP sends one packet every ~150 s. With this
series, 508 forced reconnects over 20 h saw no recurrence.

RX_DONE_INT_MASK covers all 32 rings on both QDMA instances, so this
costs 544 more descriptors per instance, 1088 in total: 2.1 MiB of RX
buffers at PAGE_SIZE/2 each, plus 34 KiB of coherent descriptor memory.

Ring 4 and the VIP classification feeding it are shared driver-wide, with
no DT or hardware property distinguishing one variant's ring 4 from
another's, so this is not scoped to a particular SoC.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index fa9a8edce22f..7fc37f159d2b 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -41,9 +41,10 @@
 #define TX_DSCP_NUM			1024
 #define RX_DSCP_NUM(_n)			\
 	((_n) ==  2 ? 128 :		\
+	 (_n) ==  4 ? 128 :		\
 	 (_n) == 11 ? 128 :		\
 	 (_n) == 15 ? 128 :		\
-	 (_n) ==  0 ? 1024 : 16)
+	 (_n) ==  0 ? 1024 : 32)
 
 #define PSE_RSV_PAGES			128
 #define PSE_QUEUE_RSV_PAGES		64
-- 
2.55.0

