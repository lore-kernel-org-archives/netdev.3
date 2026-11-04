Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832331;
	b=tkoxwUG7fFQWxFjtK3Lf8x7zSjMm/7o2VNRNygROKePmjagHLZ9ZrPVOsekgZY8MxmP/
	 Mjp3evm58SGKXVqjoa2AfMsrC5Q4i1V7g9JQDipYOMFaFPLziu0KAmdFJEckUhjnyNYUL
	 dmffBR1lV9hSDN4X3pEnYTpRdgHVXbcY5mvjuSU5ee/3P7p8f6rMCjSa8cNauMGyaoLVE
	 6S8YyJiVcvFH/Ox60X3Kbc8Lybw/6yikH+P54sHNMPCjbWwoh4hN5HwifN1/w4ocOAWKY
	 NbS8QFWJW4l1vzAlv+NdhK5gfOhPiDqOy98JItgr7GzTlYox6Hl6Ukws7VcC+pFN67Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hzFtPj3V3YwVm22wvSL4bFfz+Nym6wX6N9afFXh5Zmw=;
	b=knSJfPdsvtY7ZqiQBp2QZgcWc8ayJc4qqDAsWsTlOdFl9ZpIxn6NiMottYguT0RxN9tV
	 JZ7h2F2rxN2HeXTFXAmLjOjJ988Wgjrv2kbd2JFsVueRdfmz4KAIp4RIOheiSx73inLk6
	 O4Oq/3bm77ZtRGwDYE1YqWIGyWBUmEaoSZumf/NZnzBSlrr1ndXVSJxTM0PaXNPtLxf96
	 9YdaOAOZjWF+/PJwqhaMa8X8H73bpExOteb8hvS4PdtWRHUpm3ZnwhvTIujFwZlvsOeFE
	 jBfI5gfb8j6LgIMKXD47nrIFKT7YV5pdIGTV9APjHXXa+rCK8S3AnKr1wTxrzr1HGug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gcleRhrR;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABA2606D81F
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 22:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ABA2606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gcleRhrR
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so13398625e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 14:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793832328; x=1794437128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hzFtPj3V3YwVm22wvSL4bFfz+Nym6wX6N9afFXh5Zmw=;
        b=gcleRhrRtXnyp4zrzenEDYdVuGdQEOgrDxZfxv2J2agJH6IuZ+4pudUfcpS30Mqq6m
         +nhnHWp+q9sG+7FwRuy4b9wA3f11b5ouU2MBd79ETIWGvJ6ZJDknPJcHm9+3oCg+ssVP
         tbZM8fZ952ARRee33t/aZWuNQyZSDeDTMT7zTVRLVd0gND34qijxelCyIf+AwiePfDLe
         NfQI6PuAM3Biof9KzoaEFlllis6Lq7OMLxKCp3YVT2mBP6P5cgZY54c45mUhAqPEjnWv
         mh4woTky+oYT04Jd4UN24XzCKIYIAm1OiScHhGsASCSJOiZ80w+ylKnPHR2KmDVtUBAD
         7Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793832328; x=1794437128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hzFtPj3V3YwVm22wvSL4bFfz+Nym6wX6N9afFXh5Zmw=;
        b=f2RHnOS4Q17aCuQpEfDQlKBppYsLyxkVQgd4DfpdGnZ9i+uTEV58gwGLhtyCmrQbor
         0Bo2efDZHYOGwVjOe/c4Xk1kwMH1HoyxZAPhKfWOeC2sITngddg8g8EE0zTYnKoln7uA
         OIseDDiM4H6si9Pi11LHIv7PlfCo544RzrI25VJqmlf6tu1mqf3ffRjkhG5tCFrIZ727
         zoo4dncgvTSo4SDE30w3VKWHyiUzrrNNCcoKqXcFBz0WgngJA+BN5ov5XGln7Ez+KT7L
         A3DADpiRtsJHBpOqug0tMny4T0NEXE9a+5rQdG2xMTrZm1khEV8wh6VwR2Nb43hQgWur
         fxMA==
X-Gm-Message-State: APuU4Z8/pVBm4yhV+azC/jkMSG8Qgut++SH6gat6ULSxs3w196kln+kg
	1Nr9rR/ebHCHf3kjAneoZIuCTmojY2uHNQi4sgOcgsdwT2Drw7aXUkZidoCDIN6e
X-Gm-Gg: AYBFou1PuyT7w0uquNUPcS0tuEHP6T2eGjezubSFDXSexjl7o6a0yYmV2UdEp02NeMX
	Bqt5tZtHr29NrNYHZT84NxDeDvcg0wQTQEQqLdfbsj0xIqq5QitazfLTC79CXtLEmEuKY1SJUu7
	bVqf5qT0cBRqttNynAMyurYnCEMu6NXFB0ncZXIAkE9kuuSU6jrWHiZDP2KUrkVMup6cawTsgjA
	6IKI4UIJpT+PVBMcNojVTS5stFq5duSxRVyvEhqRjOwNb4bNSK4a+RjSYnxaqhU1EgJWsLhupKG
	m/XTHLBdOCrkdDZkRHhHl8FY90IO/lCQYjDtFrTmRE2LOJkiWlyP48F0CxvxrVykPFPifn08Hce
	w1od3/ORd2xg+JmD82xOdniUBgGpl7jXEYV6jDmB6lAqCeT0xwj3+1IVnRDL7A/g9Xn7UsSRJJo
	2tQNLYv3SYgwhXiVu5Z0aNNOmmdF82wWVuCW4mTFNIHPkTIel9A0BDkO5bDQQzzGeAclVIhU7UX
	wxAuOLbRT1p5pudUv+kYEiGH23tewVyxrpXW8BY4jPSZyx/KdFdkwxd1JkpuIZHQWtQeo7e0qxH
	KNdJ8FbiuqEIjmVQtkcHntS3ojOt81gMc2TJDb4xQyIocnuRViggrnAcSMoIUBtKLUsdE8Wbfog
	d8ZBaKoz2Rs+Evr+ZTN5+jSDoVcU0gaW1PeHwGgf2urlPPlDKfWOxF5MDq/pEfvoUsMhaJIzRCZ
	3zcAATepU8ugpu+UEVVJEwV7fkJG1cnrCrT6v2NLGUSuYjoNegnOztDw==
X-Received: by 2002:a05:600c:4f8b:b0:4a3:5d64:df91 with SMTP id 5b1f17b1804b1-4ac17ffaf95mr392832135e9.18.1793832328499;
        Wed, 04 Nov 2026 14:45:28 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-947d-5f15-1dc3-a8b4.ipv6.o2.cz. [2a00:1028:8388:a84e:947d:5f15:1dc3:a8b4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4320efc7csm36604235e9.2.2026.11.04.14.45.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 14:45:28 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: netdev@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	w@1wt.eu,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 3/5] net: mvneta: unwind a failed mqprio setup
Date: Wed,  4 Nov 2026 23:45:16 +0100
Message-ID: <20261104224518.66487-4-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104224518.66487-1-pepe.schlehofer@gmail.com>
References: <20261104224518.66487-1-pepe.schlehofer@gmail.com>
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

A failed mqprio offload setup leaves part of its configuration in the
hardware. For example, when one max_rate is not a multiple of
10 kbit/s, the command fails but the TX queues set up before it stay
rate limited.

mvneta_setup_mqprio() returns on an invalid queue range or rate after
it has already mapped RX queues, switched the rate limit mode and set
the rates of some TX queues. The qdisc then fails to attach and the
driver is not called again, so nothing removes them.

Undo the RX queue mapping, the rate limits and the traffic classes
when the setup fails.

Tested on a Turris Omnia (Armada 385). After mqprio failed on a
max_rate of 10001kbit, TX queues 0-3 stayed limited to 10 Mbit/s and
the VLAN priority map stayed set. With this patch neither is left
behind.

Fixes: e9f7099d0730 ("net: mvneta: Allow having more than one queue per TC")
Fixes: 2551dc9e398c ("net: mvneta: Add TC traffic shaping offload")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 28 +++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 79711a117c39..171111d7fe57 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5277,8 +5277,10 @@ static int mvneta_setup_mqprio(struct net_device *dev,
 		for (rxq = mqprio->qopt.offset[tc];
 		     rxq < mqprio->qopt.count[tc] + mqprio->qopt.offset[tc];
 		     rxq++) {
-			if (rxq >= rxq_number)
-				return -EINVAL;
+			if (rxq >= rxq_number) {
+				ret = -EINVAL;
+				goto err;
+			}
 
 			mvneta_map_vlan_prio_to_rxq(pp, tc, rxq);
 		}
@@ -5289,29 +5291,39 @@ static int mvneta_setup_mqprio(struct net_device *dev,
 		return 0;
 	}
 
-	if (mqprio->qopt.num_tc > txq_number)
-		return -EINVAL;
+	if (mqprio->qopt.num_tc > txq_number) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	ret = mvneta_enable_per_queue_rate_limit(pp);
 	if (ret)
-		return ret;
+		goto err;
 
 	for (tc = 0; tc < mqprio->qopt.num_tc; tc++) {
 		for (txq = mqprio->qopt.offset[tc];
 		     txq < mqprio->qopt.count[tc] + mqprio->qopt.offset[tc];
 		     txq++) {
-			if (txq >= txq_number)
-				return -EINVAL;
+			if (txq >= txq_number) {
+				ret = -EINVAL;
+				goto err;
+			}
 
 			ret = mvneta_setup_queue_rates(pp, txq,
 						       mqprio->min_rate[tc],
 						       mqprio->max_rate[tc]);
 			if (ret)
-				return ret;
+				goto err;
 		}
 	}
 
 	return 0;
+
+err:
+	mvneta_clear_rx_prio_map(pp);
+	mvneta_disable_per_queue_rate_limit(pp);
+	netdev_reset_tc(dev);
+	return ret;
 }
 
 static int mvneta_setup_tc(struct net_device *dev, enum tc_setup_type type,
-- 
2.54.0 (Apple Git-157)

