Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832328;
	b=wcBYlGHm3KzKtzNYMhOHgFZ1SMk1MAmOvYqqmDqWFd0OHNIJrafNsh9FhvlvIDpYTRkF
	 yiPfNulqhvmkhLMzziGOz3Oc7Z7G/Pt8cOCxdSslL3g3FAasffr+t75lmmWakuJ+ofyjV
	 ehc0c71hpvsharF89ntKBCfxTxow5VGaCuwpnBTiaRBBQQLnFVVkfqkkwCAOtpYk9SmO3
	 +EaknExjtCQn7p0GMS+++Atb3DXJHib8iwWTKV5i4q+phl28UWef0oJHOv5aR6L+5h4YN
	 z8HSzsPPFuwbcz0cu0P+UYU8ro3NCEUZ1Cy2Lkj9Raog/4IQ5CbWKUH3nepY3ILVB/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vXzSnQSBhScjRAuHAYyV+9vkRSwMaTQiRDFUanXa/AA=;
	b=CFnoTxQCP3DCetF4ivjdOXuPdhAeMvEwyNweDrNjwuxvFt24OJgHP5fMEkg78+bU1LDh
	 HgbuEIlHL/n5SpCpaEGU7YnEqCGAHF/SqRWdmF1L3jozW2Vt5hJQBnY7bVqMFO3ck1cwC
	 Kn2koXV0gcxukw1YDQsyazxmtgmh0loGKh4mqfSo1FrWUKmyNuLcyPWaYI6mQTkNcG+ts
	 Jl2AHM3jUJdpRlh50Tm5FUUN+ZUevMDdRneiU495QLWoTefhvJH+nxdpuqYurBUxagVrN
	 zGJ267olRdhsUCG8UHOIE3a+TwlyYiOEsrM/uKQafPNhMRPy3U54zbbGMx1GQzOf1Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rQLqJa/V";
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C7606D811
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 22:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 481C7606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rQLqJa/V
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a215e64962so11723175e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 14:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793832326; x=1794437126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vXzSnQSBhScjRAuHAYyV+9vkRSwMaTQiRDFUanXa/AA=;
        b=rQLqJa/V076c4etHA42/L3ovl3uqdyjXEiA1yhh5E8IjnuGayPn6rhpnZgzCfxS5vN
         lSnCo0ESmI3HIw9aRWFvws/RJwXdALiPeBCFDPlz9GfrfVw54IGPFHwZqxHMlHJMcIpk
         LMWR7hPIh6hz0mqjErXfxgNbzCjHJCkcwb5Ehtr+NqZc5FMyiVpXuBfLkT1KOba8xZBT
         2FLUcjgbzcy08WT+CmH3V55hHt3WScX3iL7Pfq2dGT7aDLH70LztYmnkQnOh9NHqQTv5
         XqfSeUPb7bOrbJbyHRTknKwGt5QLcW5NSunUzDqv5AURjmukVwESfOIN3YG/dPnpqabb
         XtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793832326; x=1794437126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vXzSnQSBhScjRAuHAYyV+9vkRSwMaTQiRDFUanXa/AA=;
        b=M7YaGic9HKzEVVqSqgHff0IWtGxAjaQNSfFAZzYM8s484aW0z6dsqa/XZP7THTJOtF
         sAyRWYNHl7GIJcMq7bkohBlVIS8EoNv8t4mOUvhgGN2Yq1xF3Gjt6IYV/+flom0MNwm4
         Isl6hdOFXKi+hNfg6/Qe3eET2viTCq66UMq2PDR2siUXwAeHjjbLcANPF6lfCasfjWgP
         fHB4kCli43dmapPht73Ks/+yVpmmxqCyAGIBK4KHRyjViuLfQY4ZbrDChQh+ffJt5nEk
         X/XcRwLpA2j/K1PtX6s1P/VCiIr6+84EtG3JBbZh9vUegJJAVYFboXOanbjiNCZCqka0
         BGbQ==
X-Gm-Message-State: APuU4Z+In3SlOdTUP00lRt8shQrAtSVw2OU+5SLOA11nxzF4Doj8XaOF
	laqeVabdnDq19zELLGWJQ8pQ9TgyoHrIXlsC3hX+n6Gc7ClQg+v8CZUxLzWFt4Lm
X-Gm-Gg: AYBFou2VjwmcYPNjWfZlDSi46vKyi4/Xb7hMKazr+ZAdPWXajYh883yJgJbnK9bVPUf
	qotdxqkBTJCHQpQ/qcStEsNYMB/pkG4SjdfaJSMKBg20ySp8ACsIn7bhWpKIazdwaDuRkmXelLt
	fyYeMW5ibiSZ3EZRgE1Zz9NWMHTDRkGpXBWoOvDcAnz7HvxCAnefSEhyaWC3Df06yIlBG4fY7HE
	rDFWkcyn+ZW7ea0jqq9tR3aTfIa0RUZ/bdVYGyZJ6sWWU4XRx7cKNwmgJb9Ve2UDdNpAfAJ1bM8
	B1Hwj0JkCXudhVwaWWFVOvQfk+SPQdXunAjo3NdnpPN/v+5/M6TOCuuiN1hmSHyME8MBU47RKNM
	PZbttCPofpQt9IFEmqV1HEjb1H4JdPZ4LnBlo8IkFP+eW8jPYPfoFk5NIZB+Fcfb5ypInPxCa7q
	w+rDRk1DyQHclcXlqvf/DF4t46sR7PDNYFsQyteM5uACSitrNacVwh9g4D4i/vUxK8/kpIBTHCA
	SIiKvT1QNn47CUdGigp98wOq/6Qcgc9WnzBLE6x2zHJjVEay6Rwi2l3kB/Q7pxCfIKIRWc+KRkN
	999JPZRGwyT30FuUsTi/8UtdSncy3w54EDx0LVe71eXns3cbwHlJiRnIr6dOCZT1Md7v5amo0Rm
	SfoYDiitIn4Fs45qj68mYt5c5BnRyMDE7AYO7scTTjPpFdsi556H0IUr+eA4cHCmBvM/fe0lwkR
	HQOI4goatAu4d0CyOofEigHikUNpb6dliw7rSdLHTN8vvcHvthPvz0axs=
X-Received: by 2002:a05:600c:a012:b0:4a2:150f:1609 with SMTP id 5b1f17b1804b1-4ac17b2cdffmr380874325e9.8.1793832326526;
        Wed, 04 Nov 2026 14:45:26 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-947d-5f15-1dc3-a8b4.ipv6.o2.cz. [2a00:1028:8388:a84e:947d:5f15:1dc3:a8b4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4320efc7csm36604235e9.2.2026.11.04.14.45.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 14:45:25 -0800 (PST)
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
Subject: [PATCH net v3 2/5] net: mvneta: fix the removal of the mqprio offload
Date: Wed,  4 Nov 2026 23:45:15 +0100
Message-ID: <20261104224518.66487-3-pepe.schlehofer@gmail.com>
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

Deleting an offloaded mqprio qdisc leaves its traffic classes and
per-queue rate limits in place.

mqprio_disable_offload() passes an all-zero configuration, so qopt.hw
is 0 and mvneta_setup_mqprio() returns before it reaches the teardown
code.

Check qopt.hw only when traffic classes are set up.

A replacement qdisc is set up before the old one is torn down.
Replacing an offloaded mqprio qdisc under a new handle with another
qdisc that sets traffic classes therefore loses them, as with software
mqprio. A taprio qdisc left without traffic classes sends nothing.

Tested on a Turris Omnia (Armada 385) with 10 Mbit/s limits on a
100 Mbit/s link. After the qdisc was deleted, only TX queues 0-3 were
used and the link carried 19 Mbit/s. With this patch and the previous
one, the queues above 3 are used again and the link reaches 94 Mbit/s.

Fixes: e7ca75fe6662 ("net: mvneta: Don't force-set the offloading flag")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 9b9efac2846e..79711a117c39 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5251,11 +5251,12 @@ static int mvneta_setup_mqprio(struct net_device *dev,
 	int rxq, txq, tc, ret;
 	u8 num_tc;
 
-	if (mqprio->qopt.hw != TC_MQPRIO_HW_OFFLOAD_TCS)
-		return 0;
-
 	num_tc = mqprio->qopt.num_tc;
 
+	/* On removal the qdisc passes an all-zero qopt, with hw 0 */
+	if (num_tc && mqprio->qopt.hw != TC_MQPRIO_HW_OFFLOAD_TCS)
+		return 0;
+
 	if (num_tc > rxq_number)
 		return -EINVAL;
 
-- 
2.54.0 (Apple Git-157)

