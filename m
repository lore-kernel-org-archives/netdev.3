Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E158314A8E
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471166; cv=none; b=R4GQNWJbF1bj6TfHhKvkA+8GnH8fVQHRxphHauNMmwkFieM64pK1FNg0fx9bTGskatUDQQQMYYBm82zTINwZi7p+AKdsknDDN8t+SKVFnRPkyw/aiVidNeyT/CTfeQm/sStQ7Sz6oIou+N4zgxuz7LU9K1XKJNjIccKwfyvcYQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471166; c=relaxed/simple;
	bh=JgJwkZtnsbHh2zN7kMHW5CB6rzeUkQHmvzBHdfdb3uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=enj2WucSuyHYaveGXJxfWKCdh3xeh7qwqi7aL4FS2+cArshdVrHYaOAXJ78uO1I3WZsf/oCfiQU/ZUCGvRVmRI2ZL24sGvbdNqugLdlhzTrnpS0yaLgwww9tF3k/cQXMQ20SYLKRJQSmN1T68oVOO+mjhsNGLvXiHlGAbiSGF5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWVHQvX7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWVHQvX7"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d91ff7d9acso3237425ad.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 14:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788471164; x=1789075964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1jpsWQtqNEl1O8ST2vTlmcJR/phkOG8gheLQGm0LM9M=;
        b=rWVHQvX7pXkPl6Z6vn/eHVCxCxFJDL/uxTDhiM0qUwo9mnyYMTTncxqc5OsfTSUIhg
         hurc83/FQTGvMRdsPSK8/HGRf47gPQKDB+pXE/OZVo4sV0OLscaKdAIw0lQ4aVvVOUeJ
         Y4adIn56E/QPAEzuOjB+Q02yQ6sBSn6D4iR0gGuCXN838ZuaTNofQe+XlRs28W1kQ10+
         rvWwI1RPuitWWRcMWN4D3da6/4vmQzvewurbOWyACOIVaVJfVQN+kuRshC5vNmOAinzY
         BJL0m14DFEWz3X0FQBhsJPopuylQEQThmPFSFtyrpzz1vXfMlVnsW8H4g2d/9sCbOBuK
         Oe8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788471164; x=1789075964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1jpsWQtqNEl1O8ST2vTlmcJR/phkOG8gheLQGm0LM9M=;
        b=mgorU5+WwsmvkfYJArtqYcWTiSFI+nbNUpql/uuDyPBwDz/ajpTjMRPERLU4lfoIGD
         jyPobtbnvynDwocfldFtHKD6sPB6RSzDS/52JuBBo1p2K5UPP/3JyD46acYnPZRDvOnH
         ke3LCo4tOlIykK7miJ3Ws99BQ7AiPVOxNpifJqqlspgAiPxDF4ygDkNv1bG7BNRj5fP4
         a+nPXVIbtqseoRp8NtL+iIA92mzaXNrK+CBoL8rUcGTKm7zEsgOwKIr8r2abgPxgzZ4P
         +cL/MDw0AbVAj5RaDsduvOGQ3/Ze5IvbOPx7w+h/6w745fnZH1M0EZJSDezfXYsMSCwa
         6CNw==
X-Gm-Message-State: AFuF++kJxF0l/LBPTWgqENfGvfwsIZT2qaggScgv3qA9YXK78bGH8msZ
	n9TSu4gSfZodsLPzSRUk70UzL6vCTclKgv7WYDf+5KRN9ptVVcMTAJpmrpAqdA==
X-Gm-Gg: AYBFou1QIcvaykPHxgHXP6JY6VCVXjXMMcaWpfh1q2OggUxXEr5lzzrv+HEh1ACP0eD
	kAan/4GevJxRgaO0sG3fKm0gNGnr9CzM22Qg9sAvL13e2JI6x2S1Uc3MS5B6UYqk0Sz8UOMveyQ
	qcJ1Ie+r+qTwWBUAzhB8R6y/ap5vqXOHWE8+LJUf2/IX6V1sARkG8+Srl/glKTKg71E8dtxVwgn
	Vp4EpMu8CL0dwmgeCXSQBoPMQBk/zLkX/fupwlLUnK6v/y/c5bs5jQOjw8n81avR3fICUYsHrWQ
	mbx6lO3Vp/IEhyV8pDFSHNDA+Epf+VaSkRre6HIOfpuqgNqlRXSqCGFDxxBvTx2ySkEruEVTz53
	1o6mCRCWfTnQZQOoYLv2EzaKXSCbx1htj5+VlGfDzhFKv/5DsVFwQTyzsKPzkvQJI/5uJcrQsNb
	Q21RhYLV3lty8b8Aob+7fJivnoCm/LWpunvgnwUspvksEHSo0/bVFn2cXEmnYU+Mums3wvKIUhL
	BCQJEdYQA+g2yBQM4q41zc8e1LwpdzgqlLQPYrJrO8OG1soMmEqDSWhmxOq2anwgNaBlGdPIvHd
	EaPKTcWuqKMayQJOkv0dybOzLgAErnYuibcSfw==
X-Received: by 2002:a17:903:3c64:b0:2d5:2f49:b3de with SMTP id d9443c01a7336-2db1212f15amr28987405ad.0.1788471164358;
        Thu, 03 Sep 2026 14:32:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14845142sm1296195ad.5.2026.09.03.14.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:32:43 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Esben Haabendal <esben@geanix.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 net] net: ll_temac: Return actual error from of_get_mac_address()
Date: Thu,  3 Sep 2026 14:32:41 -0700
Message-ID: <20260903213241.1040204-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When of_get_mac_address() fails, return the actual error code (rc)
instead of the hardcoded -ENODEV. This preserves the original error
information, which may be more specific (e.g., -EINVAL, -EPROBE_DEFER)
and helps callers handle the failure appropriately.

Use dev_err_probe() to avoid printing an extra error message in case of
-EPROBE_DEFER.

Fixes: 8425c41d1ef7 ("net: ll_temac: Extend support to non-device-tree platforms")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: actually use dev_err_probe()
 v2: use dev_err_probe()
 drivers/net/ethernet/xilinx/ll_temac_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 711ed9c2631b..ea0f54e4df27 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1579,10 +1579,8 @@ static int temac_probe(struct platform_device *pdev)
 	if (temac_np) {
 		/* Retrieve the MAC address */
 		rc = of_get_mac_address(temac_np, addr);
-		if (rc) {
-			dev_err(&pdev->dev, "could not find MAC address\n");
-			return -ENODEV;
-		}
+		if (rc)
+			return dev_err_probe(&pdev->dev, rc, "could not find MAC address\n");
 		temac_init_mac_address(ndev, addr);
 	} else if (pdata) {
 		temac_init_mac_address(ndev, pdata->mac_addr);
-- 
2.55.0

