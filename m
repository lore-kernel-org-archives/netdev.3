Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B0502546
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016587; cv=none; b=ERh2gsKkJIJWN+yOoataUNTwk7uBGwVsN4OSgLTwUBYxMmWWW6X3A9xRw4P3bj1UAgvrJXUnkpJbvx4e9hYnjiCFvKbqXiswK4Xolycm9Ua5YVr5eOiqhKbiROErfPsak3R6BCVmBjxFuPawKL9NBoaUQBzUZ2VmSPAZrpdcNOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016587; c=relaxed/simple;
	bh=eH7Hm1uMrlwa/7LDj8dOOc8xLeAvOtQc1CnaM/GQf4U=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=HTgW6haf40q2eeo66VRw0v2XyJTJrcqV18MS494hwIldu12HZOuST3LXF1Ga3dOBuHRA6KB8/MKjMVVm/aVwI8aUp21/v9yPHmAWI0sNuam/mpKWqoGcgn+rtSwiWFQpSB2PXbmJ1GmqTdY4/DRVQgA2S01VRSuYtu8jIbNTEt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjxdgSOT; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjxdgSOT"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso2304658a91.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790016586; x=1790621386; darn=vger.kernel.org;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPNI3EKcdTmIIayCEDJy76QjloEjzqwyuvf/Q6PUASQ=;
        b=FjxdgSOTW6pG3/1XVjqWfiK3j3CaBKoa93RkuLLcEDHumcvZGFBv4vpzHQFN4cSzFU
         CWCl+/T0S7Fisu3WmTZJv2eoOPkQFG6QTcGtMjuVqK3YT1H0T7b2kW6n68NAJzKZtW8b
         qLNBsGmeFJfDNCMlrViBW4FsL92YaOdmLiXjtJspKvK8zjXgqd4ns1TheFcwsPuWrbu2
         mRdUgP7TlfssyRU4fTYWT92tex/WkQEyHbt1Q2eC5lffNNslijuxsX3INQfb4Q7VTVuD
         ZshFAz9b/1KX93u5UTF1x1584SSozwy5PIY90GF0VexidQAD3o89FsCJDVqQlHHv+iQP
         uQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790016586; x=1790621386;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cPNI3EKcdTmIIayCEDJy76QjloEjzqwyuvf/Q6PUASQ=;
        b=zrVb09Nu2005JWHoplulnROFmiNd8rAZn3xFFOyod2dFFkC+Fp2RLhcgbyL1vHmzPu
         WkL03QWKpKlG2nb/FlYNgRBA2/2Fm+IzcPg/oGGoX55aRKTI4JYcJkM4Fd8RsToixQ+B
         ZIJsf/coKwf4iy13FxVCVrJ/r+a3olsrnAhgKAZUCZPRCyKCce/d6Hro94sp+YRGMKZK
         /BXeVzCCLWZPv0M6u+XO3FR9PeMI92vddreNcKu8Fr09tt3PGTfxrWsK60rgQDmm6gN6
         HIspZZYohTo+VKpMAANl/GzYVXk1/IUs8K+dD097g2ZIqUX1mEqY45l77ynD+zrguOx8
         dkSQ==
X-Gm-Message-State: AFuF++kZ7Z1yQAy8wDIgGoFmBQJCbu0w0cCVd6Jlgvrfn6pItN4FqvSB
	6Bh/mr/1WwwBKPygxX9ouC7E60+NlHyOTGMo2TFXei9MEl1WfPFW96GQf42SFSlL
X-Gm-Gg: AYBFou2GMtpzKYSCBI2qrRuQPU3d31BkvTHyMj2y6vZwADKH9pWQcOHZC5dksKe0SgN
	s7EyjaGRcYTGPE7JXiVUWf/BooWPJoPxhsfMtX8+KF+iAQvw4XouJMQDGO38QQdE3XfFSh507//
	tClr2z2AVO0SsGW+Ql86EJHTsO6a1XvxV/OtQ/YFKs75nLAToOha+JNIAzRegFRRT0JwVjHA8Ql
	sj3HgbuxIb4sMN06P745vJHaKyk8+A6O4IfGMSCJYrRyUN1sWPuwctKLqkdhEQsVlwepmwyOzEZ
	gEHodxAFI7VkXlOh//5hGaxBS5Q/frKxKRBH3pUKeOsKGcEY3Vd5Vn+qQc2xZ0da9ccZcI04mpA
	W5sYk+rcKp3jHkhi/qSdD2BSh8T2g+/pCv1yVNJ++OOocxAhR22v8LBbIxljFqhRnaAzAa178+a
	ZSYP6xmkbB3GHTgW3V7XZ6PgU0UrBDjJ3JZYcTu0m5XiHtMASly6CV0RBTxeSxXCdhFxJckniRA
	xKxdlRu+QqBkbWDe9Cqjdw=
X-Received: by 2002:a17:90b:4e85:b0:39e:21a7:5df5 with SMTP id 98e67ed59e1d1-39e54d5ca4fmr16112066a91.24.1790016585605;
        Mon, 21 Sep 2026 11:49:45 -0700 (PDT)
Received: from SANGHOON. ([1.220.132.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e52d5adc1sm8579800a91.0.2026.09.21.11.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:49:44 -0700 (PDT)
From: Sang-Hoon Choi <csh0052@gmail.com>
To: Fan Gong <gongfan1@huawei.com>
Cc: netdev@vger.kernel.org,
    Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH net] hinic3: handle auxiliary device ID allocation failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Sep 2026 03:49:28 +0900
Message-ID: <179001656835.91284.3719235813225229273.idr-bug-81@gmail.com>

hinic3_init_hwdev() stores the result of hinic3_adev_idx_alloc() in
hwdev->dev_id without checking for an error. If ID allocation fails but
the remaining initialization succeeds, hinic3_add_one_adev() uses the
negative error code as the auxiliary device ID instead of a reserved ID.

Return the allocation error before initializing the hardware. Add an
unwind label that clears pci_adapter->hwdev and frees the allocation
without attempting to release an ID that was never allocated.

Fixes: 8133788d023f ("hinic3: Nic_io initialization")
Reported-by: Changyul Lee <lcy8047@gmail.com>
Assisted-by: LLM
Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
---
Found during source review at mainline
5dd1818b15d98d4a20806cd00b1b40320b06004f. The affected source is unchanged
at f0100363d8c374bd8e9ea7c9ba02744f0b802ca4.

The modified hinic3_hwdev.o compiled with x86 allmodconfig and W=1.
I have not tested this on hinic3 hardware or injected ID allocation
failures.

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index f44b3064a..830bf9aad 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -545,6 +545,10 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
 	hwdev->dev = &pci_adapter->pdev->dev;
 	hwdev->func_state = 0;
 	hwdev->dev_id = hinic3_adev_idx_alloc();
+	if (hwdev->dev_id < 0) {
+		err = hwdev->dev_id;
+		goto err_free_hwdev_no_id;
+	}
 	spin_lock_init(&hwdev->channel_lock);
 
 	err = hinic3_init_hwif(hwdev);
@@ -602,8 +606,9 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
 err_free_hwif:
 	hinic3_free_hwif(hwdev);
 err_free_hwdev:
-	pci_adapter->hwdev = NULL;
 	hinic3_adev_idx_free(hwdev->dev_id);
+err_free_hwdev_no_id:
+	pci_adapter->hwdev = NULL;
 	kfree(hwdev);
 
 	return err;
