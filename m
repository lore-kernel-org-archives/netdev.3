Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116132765E2
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781394041; cv=none; b=bTibcCPGXC8IKVUALDxoqWfc7J8QtrzTgsZnxc5WBRGzjYvkzuvkf9pqQHoeapZvR0EXR0M/DuTev4wVAXCnTVvYDu2srptNT2UA/I6UVeDpXpBlrvqSJ1qZWUZQRLAqq6/jRVZzkxf2JO5AoDD9fYTkuw/LFAs8MseSRVpwro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781394041; c=relaxed/simple;
	bh=mbzYecVxFjC/urnNXhEpSp2dElTgGvLjiAtuBTjgWNA=;
	h=Message-ID:From:Date:Subject:To:Cc; b=MDWSM1r5Dz6RbKdbiuOxQXXcBMb45ZjfQXgoICziT2csts8KebOyq5iVDGNFfvCtgO0f4ziJ7hnxzi7hsuzs8SlrNC4vTdFNox39pSbk2H4Mrrm306NaIJxkZV35ZtgZ7Sl099qES/wMX2KtP28kBgLASnTXxB2t5e8b7dij7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mabCK8h2; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mabCK8h2"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c85b2139015so622346a12.2
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 16:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781394039; x=1781998839; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZeHPaYgjAc0cmERq1W7zmI0HdZsP4dzCZuF2djjKP8=;
        b=mabCK8h2smjPZt4CKwoEVOT2qoE/oMJKfTKedNQsEULWZUFT+XW5n5i9OR8NB3zu6k
         YTyEExUUhGztyweihKRdH1Gtp1JBJQVN29IopMOt6hQ+uwE8hDsiVYmm8E5281yG+45a
         yXWkE8WZgLR14xpFdO6W2prnvwW7HlabiBP8re2xUTrGzFdOXpk0dJqOYK8CxYNDdRdF
         RnK3XRGo+Eq89z+CCOj0mgFM/jHRZB4PVNPGK2mq/zr9Ct2qbrkeEYZlNmBfE+AjxeXi
         JHf0TLv7Re/MZKrMwPLUMuSkplEeO7kTqRv5jUeeRUrSEWCuJGSveYv2JkADiU+1sQJU
         SyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781394039; x=1781998839;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZeHPaYgjAc0cmERq1W7zmI0HdZsP4dzCZuF2djjKP8=;
        b=iTkUFsDzuH+NVcIqBkKG2UGkY8oCh3ugdDf616STis0Ub+mdFB45DH4t0uNgDhUArt
         h5Mzgubr5ssk4p6CbQJ0OuTxHeAlAkMluj5SDqCYhy+z4Cjpyemk/lB0t0VqyI7jvP0U
         6+vohiYrY7YPmeEnkhjEk+scxxsycu4PJG0pDiW/zn0GM5emnoHF9R0yhU+/ai+ic2wu
         kpk5m1SrMtIzy5/LLsvbe9Ae/l/DPDX5NkCA/mrM5uEL+56MmTHxHR6uDTn+l3L3GrmQ
         S4wFeUty+0loAsleFH5eU9EJESc2SEButYePZPGqwe6kWSamR1PzVwtBcCIyjn+/uXry
         tW5g==
X-Gm-Message-State: AOJu0YzDQYBzfANW1hGSu8v5fuAALdrDd/GH/YocgHv3I9Bd6kzgKIRR
	grIu9MGIJY/EGl/f1eah/NaSXgNS7MlXSmLzapJD1zEujir7YdmFCNtRZ/uAYLED9ok=
X-Gm-Gg: Acq92OG6bIRFuStjC2xOfmzuhUi2MCspw7HELSpSY5KMxArVwvBjn+5bGLbmCsjguI9
	/Bo0wQXfkGP/TiR69rze7JbxxuHe0GZT5SnVpCpFo1iXgvsKa++rh0FNeb7kcnjFly2Z+d4XmZu
	61CGYYFVG71kXSlrZKzIuuGY57qEpPtIrhFSuSMMFq6vkZbTGOegs5gXOCCySisJ8ok29IUnYLT
	lzWJKw4vROkUyYKU5NdQZDE4aNTyOMDLPMeeLMV+gOx/jowvjYRl63Z3gFvMb2sFqRNRW9hTWg/
	stB5wASLrloWPrbBVSepOOzTW0fxFlMYO0XJNF+OCrwpUQaXBSHPkl6dJ3NaWOAf89iGoY9awQ/
	udiZ9aXMOvAm4sEsGKFZvlmTNrHt3S/4H8tm87c/TZTgfQ4cl6wt5qo1UqyE+THLCFqdH3HkYYr
	h2e4ThdDCL5ZvWb09ohQ/x1cTULfc=
X-Received: by 2002:a05:6a20:d818:b0:398:bda8:d8cd with SMTP id adf61e73a8af0-3b783b3e3e4mr9852452637.7.1781394039406;
        Sat, 13 Jun 2026 16:40:39 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434aca3041sm6041307b3a.5.2026.06.13.16.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 16:40:39 -0700 (PDT)
Message-ID: <6a2dea77.01c4f138.336eeb.a256@mx.google.com>
From: "Wayen.Yan" <win847@gmail.com>
Date: Sun, 14 Jun 2026 07:40:19 +0800
Subject: [PATCH] net: airoha: Remove dead MT7996 NPU firmware declarations
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Remove the NPU_EN7581_7996_FIRMWARE_DATA/RV32 #define macros and
their corresponding MODULE_FIRMWARE() declarations. Neither the
en7581_npu_soc_data nor the an7583_npu_soc_data references these
firmware names, and no firmware loading path in the driver ever
requests them. The only references are the #define lines themselves
and the MODULE_FIRMWARE() declarations below.

Keeping dead MODULE_FIRMWARE entries causes modprobe/udev to attempt
pre-loading non-existent firmware files, generating kernel log noise
and misleading distributors about which firmware files to package.

Fixes: 23290c7bc190 ("net: airoha: Introduce Airoha NPU support")
Signed-off-by: Wayen <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 17dbdc8325..93095f3894 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -16,8 +16,6 @@
 
 #define NPU_EN7581_FIRMWARE_DATA		"airoha/en7581_npu_data.bin"
 #define NPU_EN7581_FIRMWARE_RV32		"airoha/en7581_npu_rv32.bin"
-#define NPU_EN7581_7996_FIRMWARE_DATA		"airoha/en7581_MT7996_npu_data.bin"
-#define NPU_EN7581_7996_FIRMWARE_RV32		"airoha/en7581_MT7996_npu_rv32.bin"
 #define NPU_AN7583_FIRMWARE_DATA		"airoha/an7583_npu_data.bin"
 #define NPU_AN7583_FIRMWARE_RV32		"airoha/an7583_npu_rv32.bin"
 #define NPU_EN7581_FIRMWARE_RV32_MAX_SIZE	0x200000
@@ -822,8 +820,6 @@ module_platform_driver(airoha_npu_driver);
 
 MODULE_FIRMWARE(NPU_EN7581_FIRMWARE_DATA);
 MODULE_FIRMWARE(NPU_EN7581_FIRMWARE_RV32);
-MODULE_FIRMWARE(NPU_EN7581_7996_FIRMWARE_DATA);
-MODULE_FIRMWARE(NPU_EN7581_7996_FIRMWARE_RV32);
 MODULE_FIRMWARE(NPU_AN7583_FIRMWARE_DATA);
 MODULE_FIRMWARE(NPU_AN7583_FIRMWARE_RV32);
 MODULE_LICENSE("GPL");
-- 
2.51.0


