Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBEC43B483
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751557; cv=none; b=bNEgchlaESF7PSuTx2Pbpx1k7Kn3muu/Wdh7ElvCumLZciBzH5sJUV6K8j5VizJVH0o1qzWAF0FQ0Vx6/xwR8iTGPevK7jF9iLLplp4hXGUr3L4360KTYCSp/gwvqPrFbvMT90aZEflrM80Piyn/Cpn+5L3zHxHGUyHJUzN5JsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751557; c=relaxed/simple;
	bh=tK+c0krWHh6O73tw31MVp5gyMALoBSTzTvtq8Lm++2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YninCZO78nd5NSxRWTqUmlSXu5X4zkQQn0+LztVndc9im0qn2q5xQgpQ0p/jz3OSbM6T+ApUbRtrAy9R4Pb5MR8lZjryiBq0FdIupGWlDJopm0juEJO1P/GkKOAdkf1XQ8H0TAzjrv8ipDk9noqSFI4gyYzau6I9XiUEw4njz/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnupSoWJ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnupSoWJ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso51981735e9.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 23:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790751547; x=1791356347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3hIjYJMajezV+sDqkSmD0y2RNrwAHxMDlFZcFTj1lfM=;
        b=ZnupSoWJY8xdG5tGT/DqFeH9/8TusXpD4YSg+WUF0P0VtFXDU2w1YBN5SbqQhkClLC
         eDfqPMpZpa44gblXPcNZOZ+zqfhw42uSlNJHt0qVsc6c2Sv+pNc5A/Uqf/7oBKfN6D19
         BAmsTxJQT+BG59qz1SciniE1AANBRgWUf/zxlxCIGuAtEHm3UJNXGjscM4oYU0TB5vmK
         IyLhAEY1CtpEKa1DxZkkNNA5WoXIBAocpL0/nxR/tHmgpmbSkUf9hhIR+GBnuPDev34M
         VPT0Q9TTGD0W7ZAqHc2bZ6OE2PpWffoirSEXg3ze8Lu817wOugjZLEbtp4JDtFOpgZb1
         UBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790751547; x=1791356347;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3hIjYJMajezV+sDqkSmD0y2RNrwAHxMDlFZcFTj1lfM=;
        b=Izyic5dqnCfmYuxNutxXT0f9WG3ZX+waJxMxZ+UE+cbbDkS35fxw3FtZIy+S4dXzfU
         +kS3Lo4RoIWq47RxVHYcRX7HqXNzFtO+0PmZAMyhWFvuX5vLylsZ7MH0ZFV0rUEmL+iF
         SwlYZlxtl4gr4qnZEC3iSPYF8MjDU3JkE7SEZqqRRyby/uTjLVHJAoKM1qksms5XZI18
         i9RdGxYRUYc7xp48ZMwhWlTEdk/vLN2C8BhjFJ2Yp7GzJCzx7EQkrQSrhqgTvbqFbCK5
         DpK1xogJ1iF4j4moUWXwisi/ENIIYoHdZbCqDPqSgfFA0MCOxgvzy1Vcj6nlpy3O+iJF
         1FqA==
X-Forwarded-Encrypted: i=1; AKwUvByvf/RRSQgRS3KwFS9S22u/XRF7IVG3ulWqWNuvyJlOit3IJfH7OgwNulpp9kAF/ZrL8avKnu4=@vger.kernel.org
X-Gm-Message-State: AFuF++n0vW8Qc73XwwhsRWso1Aa4aJxzTkPUc8G+efS132EutHyk+nuc
	iixTF9yG8GDEeddCJGNsoAdYpvF1YnU/fyiz4/mhuNcJI//5gc22FbjB
X-Gm-Gg: AYBFou04Z3NPz6FP7vaW3lqxWO4HqlOB8j8sLvIWM0LlROv2WJtGLFF4JwOXpf3nBKG
	kKb9PU2E0UUs3IiRgmE3zOxWouo7ImQDdzmi7rQh2MP4C+sLnbU+C+XM+I7BSB/I2UdqKrDFtvR
	G3uskE0bthx10UxT346DVexhxn1Hydm8mkLlpkMRPX7BHhiEM9s0iNvYoQQlLxYUYlrwufWncGn
	3Rn4dGsq+aITCfWMr0uT2TDYNgyBQdwyTPHJB+1l7Zr9MPTUe5j/MVmDnUM32aNPi/gJOB1kUOU
	rxuGgoOet9OVpaO94uADTUV14RcsVPB9+KqSKmLDPa7/8npL8PwauRw1QsKBfiWJ4bgFbB0BUm8
	g1UihaS/FYFqfqaacedt0sLy6px9HLjoy+ph0srG1l4llAU512W8KgGdTND/mdv8+eXsosLqD6D
	ap4aBeAbbskvEFkm8aXXCPy9VF/G206KI9uR+UGAgvB3z/kl0YfxQNRQ4H5No+lIDAKn/7nuoTZ
	Xh8Q4uC4/Q4aKrJBz77RXNMcWNBaqXBdetByEVn+568uEi+lnvYxft49KgMeqVh
X-Received: by 2002:a05:600c:1f8b:b0:4a0:108:3b48 with SMTP id 5b1f17b1804b1-4a01addee56mr5091765e9.7.1790751546607;
        Tue, 29 Sep 2026 23:59:06 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-82-57-191-234.retail.telecomitalia.it. [82.57.191.234])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a0174fb304sm27802115e9.11.2026.09.29.23.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 23:59:06 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Leto=20Liu=20=28=E5=88=98=E6=B6=9B=29?= <Leto.Liu@airoha.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH net v6] net: airoha: Add retry mechanism to airoha_qdma_set_trtcm_param()
Date: Wed, 30 Sep 2026 08:58:48 +0200
Message-ID: <20260930065855.46171-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Leto Liu (刘涛) <Leto.Liu@airoha.com>

CPU accesses QDMA via the bus. When multiple modules are using the bus
simultaneously, CPU access to QDMA may encounter bus timeouts and fails,
resulting in QDMA configuration failures and potentially causing packet
transmission issues. In order to mitigate the issue, introduce a retry
mechanism to airoha_qdma_set_trtcm_param routine in order to ensure the
configuration is correctly applied to the hardware.

It's enough to try a second time for the TRTCM config to be actually
applied to make sure we are not in the middle of bucket handling as it does
operate on fixed time slot internally.

Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
Signed-off-by: Leto Liu (刘涛) <Leto.Liu@airoha.com>
[ improve commit description, drop memory block, apply better loop logic]
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v6:
- Out of RFC
- Fix to correct Author (confirmed by Airoha)
Changes v5:
- Drop memory block (not needed)
- Loop only 2 times
- Improve description
Changes v4:
- Rebase on top of net
Changes v3:
- Init data
- Use continue instead of negative error for poll
- Add memobry block after CFG_PARAM

 drivers/net/ethernet/airoha/airoha_eth.c | 32 +++++++++++++++++++-----
 drivers/net/ethernet/airoha/airoha_eth.h |  2 ++
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 21ac80bdd084..b164a78ddac9 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -3120,14 +3120,34 @@ static int airoha_qdma_set_trtcm_param(struct airoha_qdma *qdma, int channel,
 		     FIELD_PREP(TRTCM_METER_GROUP_MASK, group) |
 		     FIELD_PREP(TRTCM_PARAM_INDEX_MASK, idx) |
 		     FIELD_PREP(TRTCM_PARAM_RATE_TYPE_MASK, mode);
+	int i;
 
-	airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
-	airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
+	/*
+	 * HW might be in the middle of bucket handling and might
+	 * require an additional try to actually apply the new TRTCM
+	 * config.
+	 */
+	for (i = 0; i < TRTCM_CONFIG_RETRY_MAX; i++) {
+		u32 data = 0;
 
-	return read_poll_timeout(airoha_qdma_rr, val,
-				 val & TRTCM_PARAM_RW_DONE_MASK,
-				 USEC_PER_MSEC, 10 * USEC_PER_MSEC, true,
-				 qdma, REG_TRTCM_CFG_PARAM(addr));
+		airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
+		airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
+
+		if (read_poll_timeout(airoha_qdma_rr, data,
+				      data & TRTCM_PARAM_RW_DONE_MASK,
+				      USEC_PER_MSEC, 10 * USEC_PER_MSEC,
+				      true, qdma, REG_TRTCM_CFG_PARAM(addr)))
+			continue;
+
+		if (airoha_qdma_get_trtcm_param(qdma, channel, addr, param,
+						mode, &data, NULL))
+			continue;
+
+		if (data == val)
+			return 0;
+	}
+
+	return -EBUSY;
 }
 
 static int airoha_qdma_set_trtcm_config(struct airoha_qdma *qdma, int channel,
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 286f73e2e1e0..d270729e22ff 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -184,6 +184,8 @@ enum trtcm_param {
 #define TRTCM_TOKEN_RATE_MASK			GENMASK(23, 6)
 #define TRTCM_TOKEN_RATE_FRACTION_MASK		GENMASK(5, 0)
 
+#define TRTCM_CONFIG_RETRY_MAX			2
+
 enum airoha_dma_map_type {
 	AIROHA_DMA_UNMAPPED,
 	AIROHA_DMA_MAP_SINGLE,
-- 
2.55.0

