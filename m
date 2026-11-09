Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259102;
	b=3kSkxvhwy2bQ/LBdULN6ndgCgGVK7quW+2bBDGlV0lfWY71iLMcBraWqTGbtEN9LGV6J
	 XWTvTBEDfJyJFrtpjhdGr22XmVB9OslSz/ipMa9qs8zvCjsQq/RW2foNBj63Vm9TT8k4d
	 8BU2RUYHARz+niwJQgTCG1eQbRBBtIm8VsgFwQAudTjgyoRe4sd/nuQpAdiJXDdP30IVa
	 gGqKubWmWf2mZ43AgqivxQFbTruFdvKHSXFrGaD+Vk8t1JrfvaB/MvSDCC7W7727Nzm4D
	 +CV+gmkm78lB2EAPWkygz5W2mM1HzWLofaPQncaNGnEqpDfASEtRzIc4u0ene3bx2uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8lBhKYFeg6aAHVjAOQSFRX40Gvs+gVti0Kp8iM28F3s=;
	b=oRvgM/0SSbO3PzFN8cjj2CGojr030mQurMBmdzAJKV0BwMWPGUOWtgHh8chlDnyIYmuv
	 TXTrKwONesrwaakw+cddJg5L2vod5g9oASoYlauCeaa/vFug7oULt0Oj50LO+drRSGLWF
	 D8F+bhiqeNyiboa+Zl7t8cR5JZKKxsWPVIO0pixncVCGkNcU7dZUZ67/TtrVDRlhPgvsh
	 RRDuHgaMPXcWzVldOVzGuhpjqpDjhdLnW/v4kj5SjCI4HJh1lnj6Ohkoy2tksaE9Mucmx
	 Ei5Gnyp9Ue0WP34lKJdJL0iACvI5URN5uzvoBNN1I2+vEo6UG/vw/gFmrwti7ZV+wWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=feTrB5pl;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9AF606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D9AF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=feTrB5pl
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b244fb7fffso1703019c88.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794259101; x=1794863901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8lBhKYFeg6aAHVjAOQSFRX40Gvs+gVti0Kp8iM28F3s=;
        b=feTrB5pl8uvfrQD2DziygFknBKqSoIaoRvI9uMZ0UwuweTvgspf3sRTsIdVOXOX0Hc
         r8F0dqSTnCQ+Y9XRcDNPB4+Nrn6iWp/K7wcEL7rm/6/oYl0Ygrvq9nU6XeCzv/9MDlsQ
         jZeOTrGy1nD3GSJWZSzGV/bcxlMp9h5qUOy3+zvokzgPYllAYuyTYYa7Tf5zqHCTaLR5
         mfS1ZDNQwzMSlEbU8YNOYCc+hsakPZezFnCvwkvsXlaEq7Kf+JyWrwIePQM5fRidyEwv
         vH3V19Rnnu0+9CfqPAaDyCOzZOHtIhsebTgjJeRQKtM9m1jrEJvCiUCFXGrR51DEv6j/
         ZkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259101; x=1794863901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8lBhKYFeg6aAHVjAOQSFRX40Gvs+gVti0Kp8iM28F3s=;
        b=FOTphsbmVGCqPyp5xOEP7Z/cdbObTLU0ubRDgFLhZTfQHuUV+r2s/SxWwW8SJnuH3s
         evg9+f1+wgoQydQg1TWiqoaOSJE5HLpkRJM98bMF2RnxTaxqHYu0OoCUz+/EtAAelSzJ
         yYJqN1qjXdejx2/SGnnjGSQBkqf6rYuP7tPy6p+dRwC2fL4/t4bs4hLTiTSj3YjxeBPE
         dUcR9fRjyPnzW23NJLCYpJjrt71Ms9Z8pcQKlY7fptVshhldHCxXmPr6nNxdCHJAEuu9
         01X1GpBEj3/z5IDPjEuqoUMGywDVbyjEURLSGeErKWqPz8pe8K8b4rm4xSnuTRbGoUYw
         bMiQ==
X-Gm-Message-State: APuU4Z+mDa0quyMD/xm+wdRmAfmySr4Xg/xUyBHFcpswyRQQXlcNtiGv
	6BaotM55LFxjB+fceK9lzTVPZ6DZujQRK8lsyjhLYQKpg+VOJ+iImwICaDUOsg==
X-Gm-Gg: AYBFou1ZR+R5XbSYHGtzxJyehqh1Ye7YEH3zZ0pQKeGWGk6TL/h93gNset07D85y8jP
	U4mH2mdbkJgG2ZxLzIz4MagBTcSTrcLyp62dW4pkgzPTqKHnZMYDI+yeFYbfSHn7r/4aGP4lx7y
	xFdeJQi1NH0Z6/TZt/nqasYW1V5ERoHc90ZBgI8TVspX+3J1mJoPqAeKM7isy2N+ZVyCLwIEngx
	m7uxKFJutAL6jDRczluDHjXeag0TQU7lfweC0BfmaUBxjZTnnu9tIUab29zrTtY0Bs0hlGyHjyh
	QICfXhdvPb6eyEGar91if/nH5YVUuqSeP4FDT+wOxr72nmiPbBrTK4AV5LzrZND8uEP2/7lhdCp
	cMfKSVNUN5iIL1HNmZMkNNmRMlPDKiZ/OGRidbo70nvn0hNrTPADwWft2fHZFfhmdgg93fQDmBU
	SeqWa437JvWo5vu8y5deAe2Ux2TE2mN09zbhrWVo5R9tBuXG4ru7k9knqE7z/H8pQlIlnzMZJ3R
	xv/1cIhcjjzXSQEkTQrNiUHr58mXlxzreGVA/++B+1+6X74EJmxST5xjK7obR/3YVd5KrZnX96c
	wOgZ1vDeYn6OpUyv
X-Received: by 2002:a05:7022:b047:20b0:1b2:6855:997b with SMTP id a92af1059eb24-1b3b5ff8c21mr921698c88.25.1794259100980;
        Mon, 09 Nov 2026 13:18:20 -0800 (PST)
Received: from evangelion-g ([2a09:bac5:40e1:11cd::1c6:7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b85d22sm1371094c88.19.2026.11.09.13.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:18:20 -0800 (PST)
From: Ayush Yaduvanshi <ayush37735@gmail.com>
To: netdev@vger.kernel.org
Cc: skalluru@marvell.com,
	manishc@marvell.com,
	Ayush Yaduvanshi <ayush37735@gmail.com>
Subject: [PATCH net-next] bnx2x: fix kernel-doc for bnx2x_rss()
Date: Tue, 10 Nov 2026 02:47:19 +0530
Message-ID: <20261109211719.114004-1-ayush37735@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The kernel-doc comment above bnx2x_rss() still refers to
bnx2x_config_rss_pf() and documents an @ind_table parameter
that is not part of the function prototype.

Update the function name and remove the stale parameter.

Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index 0bc1367fd649..28ce580bd1ff 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -95,11 +95,10 @@ u32 bnx2x_send_unload_req(struct bnx2x *bp, int unload_mode);
 void bnx2x_send_unload_done(struct bnx2x *bp, bool keep_link);
 
 /**
- * bnx2x_config_rss_pf - configure RSS parameters in a PF.
+ * bnx2x_rss() - configure RSS parameters.
  *
  * @bp:			driver handle
  * @rss_obj:		RSS object to use
- * @ind_table:		indirection table to configure
  * @config_hash:	re-configure RSS hash keys configuration
  * @enable:		enabled or disabled configuration
  */
-- 
2.53.0

