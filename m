Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52DF4E1C97
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400102; cv=none; b=FzjMHRMJn50utpCfQ/uvkFT16z/n9vCYNRyCmdlCi6gB1lXPh1XDFgvwptWqqQO3xYPvOfhKCiWUtf0skHfFKibaByINGk0KMIG87OYtRm8NH80MxC7L52DRM1PQpfH1GTgyWrkapkloTn9hu6WSO/lNLa84I8KHs8VVBrL4WM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400102; c=relaxed/simple;
	bh=xqfqbDlWyjEUt+J4MuMzpYTTu/xhE6dkb2NdzHkM570=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdUgWqwogbXSGTVIToVq2xhbeexjKvCZyQwkLTNcN0BBghXesxljIMrqEvdOkEqK4MHLOEPwfPKWpcqH7BDRtDzMVmhJREDSTdNo5Tt6HpkFMMuWCI4fbkj5Wlp5Vof6jntElsuSknDKHqalWasIHaONRujP7ZNQUBU7rh5s+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnW/S9uK; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnW/S9uK"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c998d93153so1839303e0c.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 12:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791400099; x=1792004899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2o70JU+4HRiJtQsruboTEAdrONVErRsszw8Ro4PDNGA=;
        b=RnW/S9uK7K4z6tnEk5g1mBln6KsJF62yS1sqIXJt/XngT2S+RWi5QY9tf+0rojy6co
         vdW129qmd5rHB4KWUB+0igpeYdDzkjqmNYS6Wd6u6uAiUzgXIcDtofHXSbFkwJz9WIrG
         4DytJ/VRTg4PzRq8VCIbnCC4dBcQ+RGKhx9zhPb4h4fhrR5mCnW0NNzUQ7fkWZy5EKDw
         4gkXZp6LVNNljhpqjmtYVVltzpwQ4nO94BnN0lihRjso8a27HftilZg5Fm6a3gEczXCK
         rzw6HLu+GhQ6fsuzfOt9mMxJKhQ6gXf5EqVetX7a+34DpHA0PDBMWBravBObhSvF+AQX
         wjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791400099; x=1792004899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2o70JU+4HRiJtQsruboTEAdrONVErRsszw8Ro4PDNGA=;
        b=gS1QmbVrHgMbbvGD4OsTiigO77oV2QN7cBFxgjvdPHro7r37aQF4zff9+xPuRlljkX
         yDrqlUV1iEGgrp/7WqRLtngg5LV2okE6SEMdDR6fLvQ9X2JfJxP+hfbKIjl5xq8QFTYy
         x81B2HCCG0BRrMkk4lAgNgU+2ZmwdhQnbTbkfNOLYmcpk7/IiQX/Fy4Wlbi/0wIg1DRX
         Av7QWqmQ2QhOLpOB09OgQDblbWFnAqGfyS5l2tSqudZ/b6l3JG8ypA8M10T9SrZe10f8
         y5+pkQ+Bptiig71gZOm3Lj87WXwvaCqJo39vD6E27GtuU+huMgNKEnbRL5gG0THY/pQS
         aQUA==
X-Forwarded-Encrypted: i=1; AKwUvBydY9q/ScaFe0IGls0KVB/PuvkrC8eYd5D/Omq1XRsvlF0rl4l6M7xV9Z3nwjDKK+eRwvCGTbY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTnREX9NdQfQxgD0Tlt41HoJ57YYE9nMqZTGy9MaNr75fg9t8y
	VZk6X5vIPCkut98tJZ0YFKZvSmVfMQNh4NObQVZZn1BeRisGDHPw537h
X-Gm-Gg: AYBFou01Blz37yM855om/8Q2WEwS6HQE9Ff60qektUsVkkmTfcfazApaShhqIA1tPf+
	5SzZ4OKMcfw4PMLTejzchURCQCI90BzgJ/n1dDtnXqN8Vgwp9Y3voJzezd8mnhv27xHApA9bKkE
	Uwkm+JsoYUz20jC65YXgT6BCYZIUoOJQc7ikibHYehFcSZ4/sROpY32+gqE8yjltR5r1NEiEfl2
	TObts3NvrYZg2CcRNLk8XWBv4ScdIm7dPVLtt3lw/LNUmY5NkahTacBgth2Gd9hE8uQ8TDm35lE
	+Zb/g78A04vdkMs+D+weiJ0wuuSSwkWvoy4qltQG3vlALx8pEquiUSKL58dLuq3M4lI93J4sJJP
	46EwQD7609wTiuyv3Mc9Ewe4FTBT/OFT7MOHn+xOHuagivHks7nmiJDMTZ0hMflVACQEYNRxxw2
	MRbjxjuRCRQqA/BFA96AlzXHZX1nHjmSBXqmG2TDb/OB/lXkV51FlMtwLroyUZbjK/FUWAeWTtN
	BrvIzjLmj5blW99DAImmy5MpexifA==
X-Received: by 2002:a05:6102:6cc:b0:7b2:b04f:f42b with SMTP id ada2fe7eead31-7ca38b5879fmr998674137.18.1791400099567;
        Wed, 07 Oct 2026 12:08:19 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([74.244.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ca218138c6sm2456787137.12.2026.10.07.12.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:08:18 -0700 (PDT)
From: Emerson Busson <emersonbusson@gmail.com>
To: mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 03/14] uio: hv_generic: describe buffers for owned allocation
Date: Wed,  7 Oct 2026 16:07:41 -0300
Message-ID: <20261007190752.336426-4-emersonbusson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007190752.336426-1-emersonbusson@gmail.com>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Group receive and send backing in VMBus descriptors before adopting the
owned allocation and release APIs. Keep the existing vzalloc and
ordinary GPADL path until the lifetime prerequisites land.

Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
---
 drivers/uio/uio_hv_generic.c | 70 +++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 38 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index b3f41ffc74f8..2cb95b4786ca 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -56,12 +56,10 @@ struct hv_uio_private_data {
 	struct hv_device *device;
 	atomic_t refcnt;
 
-	void	*recv_buf;
-	struct vmbus_gpadl recv_gpadl;
+	struct vmbus_buffer recv_buffer;
 	char	recv_name[32];	/* "recv_4294967295" */
 
-	void	*send_buf;
-	struct vmbus_gpadl send_gpadl;
+	struct vmbus_buffer send_buffer;
 	char	send_name[32];
 };
 
@@ -197,19 +195,13 @@ hv_uio_new_channel(struct vmbus_channel *new_sc)
 static void
 hv_uio_cleanup(struct hv_device *dev, struct hv_uio_private_data *pdata)
 {
-	if (pdata->send_gpadl.gpadl_handle) {
-		if (vmbus_teardown_gpadl(dev->channel, &pdata->send_gpadl))
-			pdata->send_gpadl.leak = true;
-		if (!pdata->send_gpadl.leak && !pdata->send_gpadl.decrypted)
-			vfree(pdata->send_buf);
-	}
+	if (pdata->send_buffer.gpadl.gpadl_handle)
+		vmbus_teardown_gpadl(dev->channel, &pdata->send_buffer.gpadl);
+	vmbus_release_buffer(&pdata->send_buffer);
 
-	if (pdata->recv_gpadl.gpadl_handle) {
-		if (vmbus_teardown_gpadl(dev->channel, &pdata->recv_gpadl))
-			pdata->recv_gpadl.leak = true;
-		if (!pdata->recv_gpadl.leak && !pdata->recv_gpadl.decrypted)
-			vfree(pdata->recv_buf);
-	}
+	if (pdata->recv_buffer.gpadl.gpadl_handle)
+		vmbus_teardown_gpadl(dev->channel, &pdata->recv_buffer.gpadl);
+	vmbus_release_buffer(&pdata->recv_buffer);
 }
 
 /* VMBus primary channel is opened on first use */
@@ -306,48 +298,50 @@ hv_uio_probe(struct hv_device *dev,
 	pdata->info.mem[MON_PAGE_MAP].memtype = UIO_MEM_LOGICAL;
 
 	if (channel->device_id == HV_NIC) {
-		pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
-		if (!pdata->recv_buf) {
+		pdata->recv_buffer.addr =
+			vzalloc(RECV_BUFFER_SIZE);
+		if (!pdata->recv_buffer.addr) {
 			ret = -ENOMEM;
 			goto fail_free_ring;
 		}
 
-		ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
-					    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
-		if (ret) {
-			if (!pdata->recv_gpadl.leak &&
-			    !pdata->recv_gpadl.decrypted)
-				vfree(pdata->recv_buf);
+		ret = vmbus_establish_gpadl(channel,
+					    pdata->recv_buffer.addr,
+					    RECV_BUFFER_SIZE,
+					    &pdata->recv_buffer.gpadl);
+		pdata->recv_buffer.leak |= pdata->recv_buffer.gpadl.leak;
+		if (ret)
 			goto fail_close;
-		}
 
 		/* put Global Physical Address Label in name */
 		snprintf(pdata->recv_name, sizeof(pdata->recv_name),
-			 "recv:%u", pdata->recv_gpadl.gpadl_handle);
+			 "recv:%u", pdata->recv_buffer.gpadl.gpadl_handle);
 		pdata->info.mem[RECV_BUF_MAP].name = pdata->recv_name;
-		pdata->info.mem[RECV_BUF_MAP].addr = (uintptr_t)pdata->recv_buf;
+		pdata->info.mem[RECV_BUF_MAP].addr =
+			(uintptr_t)pdata->recv_buffer.addr;
 		pdata->info.mem[RECV_BUF_MAP].size = RECV_BUFFER_SIZE;
 		pdata->info.mem[RECV_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
 
-		pdata->send_buf = vzalloc(SEND_BUFFER_SIZE);
-		if (!pdata->send_buf) {
+		pdata->send_buffer.addr =
+			vzalloc(SEND_BUFFER_SIZE);
+		if (!pdata->send_buffer.addr) {
 			ret = -ENOMEM;
 			goto fail_close;
 		}
 
-		ret = vmbus_establish_gpadl(channel, pdata->send_buf,
-					    SEND_BUFFER_SIZE, &pdata->send_gpadl);
-		if (ret) {
-			if (!pdata->send_gpadl.leak &&
-			    !pdata->send_gpadl.decrypted)
-				vfree(pdata->send_buf);
+		ret = vmbus_establish_gpadl(channel,
+					    pdata->send_buffer.addr,
+					    SEND_BUFFER_SIZE,
+					    &pdata->send_buffer.gpadl);
+		pdata->send_buffer.leak |= pdata->send_buffer.gpadl.leak;
+		if (ret)
 			goto fail_close;
-		}
 
 		snprintf(pdata->send_name, sizeof(pdata->send_name),
-			 "send:%u", pdata->send_gpadl.gpadl_handle);
+			 "send:%u", pdata->send_buffer.gpadl.gpadl_handle);
 		pdata->info.mem[SEND_BUF_MAP].name = pdata->send_name;
-		pdata->info.mem[SEND_BUF_MAP].addr = (uintptr_t)pdata->send_buf;
+		pdata->info.mem[SEND_BUF_MAP].addr =
+			(uintptr_t)pdata->send_buffer.addr;
 		pdata->info.mem[SEND_BUF_MAP].size = SEND_BUFFER_SIZE;
 		pdata->info.mem[SEND_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
 	}
-- 
2.43.0

