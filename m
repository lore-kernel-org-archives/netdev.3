Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1767128DB55
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790441657; cv=none; b=dPNLA1ZgvPYBwyR4ORgde/4OumhkK4Y53B1xYqa28DdWCgs8IMcZsuhhk3FrNiCgbRYWtjrGYHouVdw0YJyWstN5WV7Js3UHsndq1ecPtVXxhmhPI0unOH7okXBqZx7JBEWaZoS38385lUXmRvwI5NVq9jx9nIERLrZlXRFDgyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790441657; c=relaxed/simple;
	bh=Gw7QnZKpBAInhCbrAFF2+t/4WB9RHd2d4KQYsebetzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FL3VnoySxc7zVt5SjVcarwfrskB+tUaTcW9V7WdvwJa6IwKQD0CATamqgq5o12/FLWmWpWIop1rITBwDnK9TOQkN19ojBbnHYfeR0olmbP/MKqaXTPxAqsXrDtvPHszMXvTRNBT1EyAUOXay0Z+SPCa8QEylIRT71G51XBJWtH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT4RCa26; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT4RCa26"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso10554645e9.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 09:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790441654; x=1791046454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=43SfXFeCUVog3VRlWez7W16wV/mBtSGE4lD//NBDZ+8=;
        b=GT4RCa26plRxKHtwVEjs6k12q9/4C6CYUQI4dBvdYMV+RCvLunO7RUO49kxNXQUzPv
         Qm1CpEJGzsukNcfuRJ0p/B7UslP38/NBYsdBO9nzZj9/WuWSA8MSAQbaEbsrlU0aBPs0
         4S6IzS+4E9ZL1tJRKuBpyHZI645KpR7jD3uaekdcCcuwXSoqrjUSiZBUWn9KuT1TTwa7
         nT1otMfGSEAeE+D5uxe7D1/2jfO37PsU5bmWjecI9VQZMUbNwA2t6llrMwct6edDjz3M
         YG1u6p0091uRHpwJ0EVdg68dacKkuw9LZoeYhrxEkaiPD3AJS5QPkvmZVKXB0N85K5yf
         CNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790441654; x=1791046454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=43SfXFeCUVog3VRlWez7W16wV/mBtSGE4lD//NBDZ+8=;
        b=iRtbjnCoKc6C81P7KUUwBYD/kSvPIzDXReJa2yvGE3H6bLwL2I9WiX4QBmUh6+i7Wj
         mcxoyK6MjAXV07nb4g7HCf4w1HQpQdCf1+jJTa/FH2u89PocVSm1X3fRGneGdc7LkkoU
         RrzRB32w01kLppmIRpg/0N/xmfOcVI0M5TwaAa7zC1xLcQmYOijHfNEErYc8Zkvy2WFy
         EOow9FMpl5RAMDwxIM+ymOzYpuBXaWYqvOhl7uXlekbKl0w4lLqdNDbMB0MLQHP6LH70
         uFWrChkzwZg1DKmStsmeNFmon0vqe+0YrH5OmDlK+7eFB523yDSV/PxhFcrMYMiGZ/NP
         pTcA==
X-Forwarded-Encrypted: i=1; AKwUvBxbMjKcC8DK+nyjFTzGH1YJWKF9i7p0J4WTHaTwGInWnHK6VgoHYQzp1U9rXNALOeJtCk8PkDY=@vger.kernel.org
X-Gm-Message-State: AFuF++mfaYbAyRspGjOakmNhXf1KkEZGaUtUP17UgaTEoeOMYjzrMstd
	PSwpwB2stV+EJa60fkC3620dZ08HBUIaYlAZDXVa1YCTPLui4i/bV1sdqx6a2zfh
X-Gm-Gg: AYBFou0RIGyQH4NWTbtr6JjRvS0XYXOxN2r10dJcV/HNC8bXQE95FJazUTA2oO0SIz2
	/UVr0CpZcVQvMvnP40AkfTpmz485FBpIDCQkkfs6TiNB9rHNcthMht8vppZtjUYSfSh2PBzIXkK
	IvTQmJ6eie8tfIWICxmQbfd2FjyKALCQ8J/uI4NJe/1Ee5wy1Bvsx0czpMLwcclwialvs8WR+Vm
	GAvE9Av13vyqGbHQaj0QPr3jJK9ZgmLCdhapWHRiJzC5R4xsMwkS+Yfxld1Zr9hmITdgpnLV9Dg
	pcTUxGzfe79FToU40wEQgE0XRXDU0bxMnBfJIp3v1DKT+TN8sH4W4q7A4RjA0ysc1ZJrW2NAvRF
	DKwMkURpxphaBR/iSHg+OcgJo+ra/1UaY3BbWTZ1j0GZDKuUh4NWqs6fkC/P+Up6N/WTy3cAPRO
	OkY2yPnaYrEzc2vQYEwps5kSHjvx0dUoUgOGcJ249AtIR596GOIAqwHZBHzfSms6Ajn3T/fjNZh
	MZ9a8PxOBKsR/ogb5rJEhUD/90gKyzCMvMG8h2WLze5NYsLA17VI7HBVkqxf2MoxTv4HVFsfVq6
	5XR/9jEca8UQh/ErOQ==
X-Received: by 2002:a05:600c:83c3:b0:49f:fdca:c348 with SMTP id 5b1f17b1804b1-49ffdcac594mr24845445e9.10.1790441654240;
        Sat, 26 Sep 2026 09:54:14 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff98666e8sm83974445e9.2.2026.09.26.09.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:54:12 -0700 (PDT)
From: prathameshdeshpande7@gmail.com
To: tariqt@nvidia.com
Cc: saeedm@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH net] net/mlx5e: Fix AF_XDP TX timestamp teardown NULL dereference
Date: Sat, 26 Sep 2026 17:53:57 +0100
Message-ID: <20260926165402.5902-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>

During XSK TX queue teardown, outstanding descriptors are completed
without a CQE. If one requested a TX timestamp, the completion path
passes that NULL CQE to mlx5e_xsk_fill_timestamp(), which dereferences
it.

Return zero when no CQE is available, indicating that teardown did not
produce a TX timestamp.

Fixes: ec706a860eba ("net/mlx5e: Implement AF_XDP TX timestamp and checksum offload")

Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 77ea51bfbaae..2cca20e1b9b7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -293,6 +293,9 @@ static u64 mlx5e_xsk_fill_timestamp(void *_priv)
 	struct mlx5e_xsk_tx_complete *priv = _priv;
 	u64 ts;
 
+	if (!priv->cqe)
+		return 0;
+
 	ts = get_cqe_ts(priv->cqe);
 
 	if (mlx5_is_real_time_rq(priv->cq->mdev) || mlx5_is_real_time_sq(priv->cq->mdev))
-- 
2.43.0

