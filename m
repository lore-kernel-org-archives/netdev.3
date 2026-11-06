Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934731;
	b=zlv5Ii2wtkLmGlHQ0gzppV3fdVwzauiv+mk51K9cN06kI1vZLtVXOzFQq9kGae111OwO
	 TBrVpmxfPQLSNqdV2gF+28TRjcEJZt5C3OzC850GOC9PCXIueXjPiDy0rfwBN++ouMpZZ
	 HLfrcpCFlPLqsWYVB3Am0z+maKNjboAISa2zaxIim/IfoKZTWi5VkygJVVsRvsyYAEOoA
	 BfivnQUz4D1cP6oRtfCT8iNXRM3SU0+Qckm9qnfy+7SjLDD1VTk8dTBjm5naxFwOMCreu
	 Rp2MjqiHxla+gedqjCMuuwSJXAWEheoWfTnSitGo9V2Y1eWTEe4CT0k8u0tvRf4eHWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gknlzQq0R7F7G4AIC4I46wCXFjxiDQKYdQQMUz971M8=;
	b=YqEzQ1DxvLu6efCIMWIvYYZMSCVSzuprGu7NgZiuctY5Glu4Sy8N/hadKP1klHhggetw
	 QzPJAYnBZc9hJ0tRfMiKn7IxmKS4483mpNjR3hLqvWWpVh8+l1DrBO4RidCvKTQ+mqi/C
	 c8BadoeSLx3AQrKURiKebpySSOiCC079hBimBPwebnENPKPelWrAarA84/QOUikppbxBo
	 O2cPVyZttk8rneUCtC0clUcCL9HT+E3YBX+F8YGV+ovQ49T1NhiTccYY/hEJwzQ3/eEEH
	 WDLcIZnXleQ96W3NWmq3dWB3hOEdP2oAAMe8MXN5oh81jR0C6zzcPGopCyxyqwzFe/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SgpgnfeO;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36455606A32C
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 03:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36455606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SgpgnfeO
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb684859cbso121917a12.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 19:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793934730; x=1794539530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gknlzQq0R7F7G4AIC4I46wCXFjxiDQKYdQQMUz971M8=;
        b=SgpgnfeO2Km29jkv/FteCLEkqwxnlAagcgbGW2Ka7eAwW4TkIQ4tcG1paunibURJuW
         aZoXhNCVt0kNk2149CyYoeWgUs5EmRVcWhuZRN4U/D6Jsnqe01vomFwiu7Bqdf9kLhBD
         knBMfPF1InoHdyUtOK3VAvDI2dewYWgJjRewdoeLkzNOZPJpQ3SiBs74YxkbN7dam2pk
         gNx4mpSrvDfokfNPI7NkZoalABxykMwjhQVS9CaYPRDC8nT7WvjlTVlnq7GJ6r4xPnB3
         /h25Lh0sA8p64Md3P5uaZr1m7UUf8bldmJIzRYh+RjxWySFBi0taxjtPNmipy2D/AqsY
         BkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793934731; x=1794539531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gknlzQq0R7F7G4AIC4I46wCXFjxiDQKYdQQMUz971M8=;
        b=1ksdktag2XM3MYCRKc/ppXhXdxOnlvbfPYAl6vN5AsXE2NHPXKBbQlGOAeZtxuVsOH
         z0VHGwkVqqq0qAiPLeUM6QC01m2cKHzuFSife5fW3KgZ+m+ZAc/TVDEJJNMsrR8vBiT+
         piyrdSdB4Xs5ldKvRttTAZe6gVKoRkkvAq5qU1j2uvOj/5jibCZcbC9UR+7fUJcbtYGA
         FTptdkHXy1S3kiwZ0rtZixx+UsRMtSvBJVKLbZMrl2hJlT4Zx+4+lrv/S7cpllAQ1cr5
         V5uFqDVJyYZD1nzbLscpz3YotVCCd/Qh3+FP0oCdFADZjmFFo44taK1AEiQz9K+/uq+p
         IUCQ==
X-Forwarded-Encrypted: i=1; AL+hErG+VyWAQwFL/rz72KmdQgT3oIRDNzu+CfgQQsdR+3NNbNE43R4eq/FOu00dnhH4q/uMIefbWH8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Mx+RjIOnJjVcIvx/QriKEZRrucqPr4KAdbpfWrExPvCVe7CJY
	phG7IfnK+KW1WxKFSP4WXCLlKEiyWR5mifXHr5GIPDfCVJMcNcYmU8BS
X-Gm-Gg: AYBFou3ZFhdnUE5nn0r8ZCOKY6qJNM8FaoUZAphu8PcT7SZakawUyOLAqflT+oJFEAE
	arGf4nCPfFScg7mF6Xc2kSH6hCNL/QLCzI0fEVSWQnu1+m+LKdiIdkxc3AyA5VA2FWkInuFrTgb
	u97ncRKuoBoRj0n1/AQsPi+I9zAj5pFWsayjT/0kyipleFtxFAz4b61dVVzG6mUdV8IH27N5W10
	6g+3zS5LSPDQp9HsKKvKEV+rRka9mB31VCLJ7gEjJDnCUzkzpHp/gGzOXrmJnaSekEg7wKTxjoo
	tXzr5yQj74ZPHwSimFrq4cDtSCuMHe6KFVfFjtZd7TqcnWduNPTguw398sOOqTlx8RXGaF2iVEl
	SVSi3sdlGdpexuhzOqWKdcVnYePHFtq3thu66IUl1F5Tj+IxxF8ISAdX8LHfzfFeoxafMo78IZ9
	5AIcCB4dpm487lPnd1vxZth47yB2PdYqaf4UIOkPMT+agHFctd6C1in8+gKzO+bx67/FbQgk3yJ
	/qBmOEqM83peeR5IXZQxgsk2FBvz7kQZYbnzM+rPEdfFwsdulN8wtYF2MQAAKCqs+CLz2W+pvJ0
	WnYexr8aPCrV+CFPSl+TYgxyn+zGkA0W0jU=
X-Received: by 2002:a17:90b:4ecc:b0:3ad:ce34:f63c with SMTP id 98e67ed59e1d1-3b0db6c38b5mr1071366a91.30.1793934730548;
        Thu, 05 Nov 2026 19:12:10 -0800 (PST)
Received: from localhost ([2a03:2880:7ff:42::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b326add7sm5819211a91.8.2026.11.05.19.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:12:10 -0800 (PST)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Subject: [PATCH net-next 1/3] selftests: drv-net: hds: always restore tcp-data-split to auto
Date: Thu,  5 Nov 2026 19:12:06 -0800
Message-ID: <20261106031208.465456-2-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261106031208.465456-1-dimitri.daskalakis1@gmail.com>
References: <20261106031208.465456-1-dimitri.daskalakis1@gmail.com>
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

From: Dimitri Daskalakis <daskald@meta.com>

_hds_reset() only restores tcp-data-split if the reported value
changed. Drivers may report the current HDS state rather than the
configured value, so an explicit setting made by a test can be
indistinguishable from the original "unknown" config.

bnxt reports enabled or disabled based on whether aggregation rings
are in use. mlx5 will report enabled or disabled based on whether
SHAMPO is active, and an explicit "disabled" keeps HW-GRO off. After
set_hds_disable on a default mlx5 device the reset is skipped, leaving
tcp-data-split disabled and HW-GRO unable to be enabled.

Always reset tcp-data-split to "unknown" when it was reported.

Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 tools/testing/selftests/drivers/net/hds.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
index 606e26d75951..af34dc9ce749 100755
--- a/tools/testing/selftests/drivers/net/hds.py
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -65,13 +65,13 @@ def _hds_reset(cfg, netnl, rings) -> None:
     cur = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
 
     arg = {'header': {'dev-index': cfg.ifindex}}
-    if cur.get('tcp-data-split') != rings.get('tcp-data-split'):
+    if 'tcp-data-split' in rings:
         # Try to reset to "unknown" first, we don't know if the setting
         # was the default or user chose it. Default seems more likely.
         arg['tcp-data-split'] = "unknown"
         netnl.rings_set(arg)
         cur = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
-        if cur['tcp-data-split'] == rings['tcp-data-split']:
+        if cur.get('tcp-data-split') == rings['tcp-data-split']:
             del arg['tcp-data-split']
         else:
             # Try the explicit setting
-- 
2.52.0

