Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99F134DCCD
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421613; cv=none; b=cr5N4K8XbmXnZwDI2+KMmdQ5PkK5Poi0i56o47j/dAL0oOdDG8VHMScTkXf2w8xxINOu4hRvmljwIaNfRRPDfMHHyRYHja8kMHzAQWXwqtnj6CE0ZObTnQt5Pt3HsXDeO/J11pxfSW2uVN7Jwzl9ox7CqJR+9h2/E9dbsXBrLho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421613; c=relaxed/simple;
	bh=ERP8aMixBISGoQkd88g9WXK3waX3DgHuj1l3pft8+F8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f25nl16/hT3fZ9Ue6hd3HS9kpTJMV+ks3VN9/KGRmewmmYy0lDRSw5/pbphJXWOR9Lh0XMtbhu1v4q3l+TQ68tVBVr+i3s9Ytm5P+qBMd2T93361zmMcwrY1CAW+HYdFSDItA4238tMsIGxHfVsWv2yoycGNvXopLu8aaASs7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBdbPbLg; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBdbPbLg"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc439bfb2d8so683933a12.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 00:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788421611; x=1789026411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yk7M6QWeNfPTqVmroV2JxHOvmGW6NOpOKei4EsE+LhY=;
        b=tBdbPbLgS20+EYsOtKJUG9vNxwsb/pA0U0vPRqmgEOUuhlZ22YPhWv7y5HtEOgv+ou
         7YTxCYfJtL5W4DTs92JXGD/o4TcU4ebKuorIiJ6zyvk9wsCkMXDeaoPwgPho5ajpqrHK
         Zb7Z2K7a/U8g4OCCMo8zpfzYNatWZ1CKHyVWEO68x2KnRfYrzTLKZ/vQeI56U1Trq355
         F+HVUXx3zZALH+VyhGZULMgIX9VyPQ0Vxh7c2IUQK6Sv/pLGe2ryKD+/nZOW1CvZ8glu
         9vunwjQ9rMkTfStyiXlUJkeDac7/nL1knB1qRB19UloHmvs1YVxkQRhwU/2sxL/BUh07
         dDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788421611; x=1789026411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yk7M6QWeNfPTqVmroV2JxHOvmGW6NOpOKei4EsE+LhY=;
        b=PwcTI99RP4uwGvnCl4frFHhFZh7PRFEJgvgakHPYdx149n2sQdRBh4IrBbJ5ipx/Ny
         7wLKxv2IqPRm9gibvpk9DBmys5VVMHYlkgLc2ixNrBoSsSAmbwYQ2fqe/bY1hh6V1L3W
         9+glE9F5/v+Ku9n5VgSOkLDLRN+kVQhxqU0BJTt1thB5Q55XQD/xgG79n6zCbiXBhFc3
         SK1I3nBJD/olBNoa+Kkyz2mKltNVocRq/xil3cqU3kQh+2WXsZ734+H06I+FL4Z5a3JW
         +q8LEv5ioanK9TemGuPYYdXUf0wLyKKybFS6N0CakbuiA0AOyz3iSsCwIho3vE09yL/g
         Gv3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwZUmPrZAqwLIg5jA8wKp/3xofjNGHi8aS97IkYyQFvZSibUGIucwHI3hrLHqbhdEHtLdGu5AU=@vger.kernel.org
X-Gm-Message-State: AFuF++kHrIjWVMtbTYm4cyTCuoWGaLTGszIwnmsBu05fHXsoAvs5GOW3
	cJPQi5QiJS1QFvxmwpOnybI0LONAh6CbH2FblMotFAuty/1ExnFPPXu1
X-Gm-Gg: AYBFou1OirY6wztWZXqU71eesr1nSwqvnj+p3hKjfx6zOiPa/h0KxeBLNa1Plc7B5h0
	+dKUjcqmyXKCnOp4DzGNFljLvkstYeWazUlctPHwnRqFYfP02uk28Z6iV20Y0mXNIBjfbVWa4Pf
	03XWQxW+n97sKiFnvsc6OpoyskhC09QCBQxruLkYvqRVpugsym50umsJJ3dN/K7qiCnQcR5DGFj
	s4vPwkeB6LRGM6wb1gk5eB2qCcDaoQPOgkSd9W2ymIkDU2VIuTr0AU/Hq5Lv1kNDuZAt8AacUfr
	68GsnLmaUyjc7AdCF6nL4xni4FSeVaclYOQIuWiroASXMzn6AzHNNg5ghQ2KbgzFYJOKVHc/O+8
	oPbKcnWkizBlsVcROsyJthbvDFFJw0eoYXi1KLtn75fO30SRbVfxWeaLp4ut5UqnoQ9C5EF1SjY
	EtE+dE+y8nKHA0qzF3r4k51bAidMPQCOsjDWfkHL7Ad7AwhluaCt8gRcfuKT8sAvV5WUYnf6DQc
	Z+0IPctTX4faiJIQnEFCAN9HdjxMl3+JNl6FycGGvVoZCzTHj/vsL5F6KiJ1IJujOEaNvfs6Afz
	upJZJtCmdkbAaEyw
X-Received: by 2002:a17:90a:1602:b0:398:a2a3:b631 with SMTP id 98e67ed59e1d1-39b19bbbd90mr441821a91.19.1788421610920;
        Thu, 03 Sep 2026 00:46:50 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacba5sm3832735a91.12.2026.09.03.00.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:46:50 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	u.kleine-koenig@baylibre.com,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net-next v2] net: marvell: mvmdio: Handle errors from optional IRQ lookup
Date: Thu,  3 Sep 2026 14:46:38 +0700
Message-ID: <20260903074638.345952-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no optional IRQ is available. Other errors should be propagated so
that the caller can handle them appropriately.

The existing code propagates -EPROBE_DEFER, but ignores other negative
errors. Propagate negative errors other than -ENXIO.

Found by manual code inspection.

Fixes: e1f550dc44a4 ("net: mvmdio: avoid error message for optional IRQ")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v2:
 - Add a Fixes tag.
 - Add net-next to the --subject-prefix.


 drivers/net/ethernet/marvell/mvmdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 2ccb8c8f5feb..d59cf332d1ec 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -373,8 +373,8 @@ static int orion_mdio_probe(struct platform_device *pdev)
 		writel(MVMDIO_ERR_INT_SMI_DONE,
 			dev->regs + MVMDIO_ERR_INT_MASK);
 
-	} else if (dev->err_interrupt == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
+	} else if (dev->err_interrupt < 0 && dev->err_interrupt != -ENXIO) {
+		ret = dev->err_interrupt;
 		goto out_mdio;
 	}
 
-- 
2.43.0

