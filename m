Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9F424D45
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208255; cv=none; b=FIRG8sEdJjn+TTDlXfgSPfyeVJt4ZyU4Y03bjhd91pEPLMhYxR5tb/dg7zv/3O5Wv8nmD2HjKUjWs2AMDeYo0y4VK0krYBYDebGIwvX0OHme1stQk93vRyOBSSycnMqKWdzgVShNlwRA89hqiPsjVs1abf/2xXOCDzpplbI7ETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208255; c=relaxed/simple;
	bh=AlWKq+WCpJ6jqrd7bHxM+xUmQDKopJjD0aSNOnzQ77Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWyoxt1QnMYOXNlhqTm7H7V8px87KJwzVqz8tTpCeSp2x5bmJ0pnQC4kH5YLaN1slJBKuy5Wvr/BZOZ39dtQk1caC4sBOU53+ryYCkccvulVSXWcm/y8e/F/52tidsDMx4dedflpnkHeBvotwgOQ4QYSJ+8PrZp1t9j7RimWlVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=aK/xlwyR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="aK/xlwyR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so25079125e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784208252; x=1784813052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1DAcALuj6CLiGGxg2YU+zPjUKqyxKHB8HUr7MGOtyF0=;
        b=aK/xlwyRcYirN7ICoBf0lJ027CM8hLttQV81AjLGsIcIvSiFSbxiuSeEibSuobxumW
         /wviY8uNpD24UvLTiblcGrn8+4Lptnn87Ed4oze9bPV5/ICJPRu5sbdk3OiBPuiaspjU
         B7UcJm+YR1hwsooB3YAzdEgrNEVuh9AS3EVMCT4BuEhGrzfwMhov7uD/A26NC/R4xLii
         v8BHPbIwt+ZkO9QTlwOrd7UWxlBrj5QOJAMxOIqz+JHEzSZHloswLzzKpzkieZY9cprx
         xtHwp7KgSnWLJcOnu7Q8ZfA7sCuR1b/8bqYwsMQFwgdDbAUMIm3WT0lwl8RGcX5X213E
         XqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208252; x=1784813052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1DAcALuj6CLiGGxg2YU+zPjUKqyxKHB8HUr7MGOtyF0=;
        b=YftVxbI8eMiwMNu2+Au6Ww2xOR85Iwi8yhcDMPebwhjKP4C7msxGnM/+5Sm1mwS1ak
         7lc/RWDSypJC3wuuTmoaTy48XOAMjq1LAmXzrC41zTZW09SOzUaY4Z+kOiVQT5+jnse0
         a20tSpS1x1Xvhb9I6iB73B1GLD5Td4t4xjTFcbrNHVU5RlojW5ciR0klaNUKkBY1yebQ
         LX2Rnka00IWeF2NjkoOTCjprKmxF8uFqeBaMMVWNwUg821TmA2BMh7fMcUnFk05kQZ4r
         D9jZWDlTr04Co9tZUXxvk9d76w1lv1acAAe244QMHDO8HOldOyd7L0fXQQjJb7zg2O19
         wkaA==
X-Forwarded-Encrypted: i=1; AHgh+RqviQKLYwCQYjCPglZDgbGfyu9EzPl7DqZkoGTm3LvIrvLN1vgTCqDDEIwv4IT5oYcqro3+Rgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUxXi73zU98Rse0GkPF6l9gNfVkzMo+RJ+VlPaFYe4DpxJKehs
	q3bsTgChD0KBAQbjK3y0B4WnkLyGy/lWKvFYoBehw7w1tH8tBqQCkc4/XXzUX92RvOs=
X-Gm-Gg: AfdE7ck0OwCQVW5y0FuVm5kVHSYEm/IQHK+ZNvGeMHnYq8Vq/XxxdhI/X1uzOsbCNQp
	CaoWV77Hh7uwpynSgwL9OTbuiVn28m+UlvoJ89MhPVM0f4rWpqq6BnlYMh0bPaw5U9gK+eFZRsV
	fK1X55W1f01EH/cnuUoRF54PAn9GR6xVP1/lkun8MmRP7cB7bOLeTKe+mHVAGgLgCS2L0Mcbl9D
	tsjxqy0xQOXELzguJPUKU7w7qn8n+xCRdHal9Etk05mZjG+V9FsCm9b0ZF9TQwFAK8ZwXtIawIN
	UX4iEIVp2/AGtsXKCgXzN4IytABxDXRFCIrjyAuQI/vZeRPg/f8wRk0TiPa6pXmcCczYYKlEAa2
	knk1iny/04dpNFGBAjgInJ2ORh3n5wICsdhOJUNb0SUAgTSq9CTQYluqO52zvkhoBlll7t9l1yG
	/1ZTak4kBGJuJFxEdzDD0ejw==
X-Received: by 2002:a05:600c:6287:b0:495:4749:16a7 with SMTP id 5b1f17b1804b1-495474916eemr1028195e9.14.1784208252423;
        Thu, 16 Jul 2026 06:24:12 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a5d7sm23813896f8f.10.2026.07.16.06.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:24:11 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	yanjun.zhu@linux.dev,
	cui.tao@linux.dev
Subject: [PATCH rdma-next v3 13/14] RDMA/rxe: Implement disassociate_ucontext callback
Date: Thu, 16 Jul 2026 15:23:14 +0200
Message-ID: <20260716132316.1495242-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716132316.1495242-1-jiri@resnulli.us>
References: <20260716132316.1495242-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Implement an empty disassociate_ucontext() callback so the RDMA core
can move rxe devices between net namespaces. The core requires this
callback to reset user contexts without waiting for userspace.

rxe needs no teardown here: its user-mapped queues live in
reference-counted vmalloc memory (see rxe_mmap.c) that stays valid
while userspace holds the mappings.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 1ec130fee8ea..6eb10d2f0653 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -240,6 +240,10 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 		rxe_err_uc(uc, "cleanup failed, err = %d\n", err);
 }
 
+static void rxe_disassociate_ucontext(struct ib_ucontext *ibuc)
+{
+}
+
 /* pd */
 static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
@@ -1478,6 +1482,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.destroy_srq = rxe_destroy_srq,
 	.detach_mcast = rxe_detach_mcast,
 	.device_group = &rxe_attr_group,
+	.disassociate_ucontext = rxe_disassociate_ucontext,
 	.enable_driver = rxe_enable_driver,
 	.get_dma_mr = rxe_get_dma_mr,
 	.get_hw_stats = rxe_ib_get_hw_stats,
-- 
2.54.0

