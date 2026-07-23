Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED04F7994
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832391; cv=none; b=IrLw/YKAo+1S7eIJuRixd44Sj1sEECDh993frPpuH8EKt886cuSDF/100T4Oas6QjK9t2JFdsKyjy4aGJsMayiu0MPMWcqRt6P34fbEB00KIz4t525orjt10vYuN+B9teXpnlsFH498cuUTyxoaXiW6gaqBCEzGVWZxbk25RSn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832391; c=relaxed/simple;
	bh=urFPXC2bDGFRb3YEWf5ToWXnZVSrmuUPwVRzUD+dqlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9/J0I8/1oymBnnHA5/jR//jIngzXUlVxD800yQvCNDJJHhQFKhltue6OYl3TXltAGZZ/Vd7ktTzOOY7gKRfJt0G4JM4wG6ETDXk15vBXdwxUyMVa7fpHnTVDnjusYx9n2J6r0yiiv/kb889ugQgwKDtYhU4J17ydEBswagVVhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZysxmINY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZysxmINY"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381216921aaso940968a91.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832382; x=1785437182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kxRvmx1wxGvV8pBQOXsif8sDMDGk8D/ZvwH0veNhWow=;
        b=ZysxmINYypslLelTrq15Hxa7Cplwyi0Q2Wp5PFsML9nEo67/mprZWkssYVXYRM5uE8
         b1Ygrr6BoX15S5asvEd1dKqykBZ9feWjescyheGSz8+UyYB6FMmlNtqK7IFI6gsENX9J
         JE8ZOojtcEw9fsMFse7RB++GAIISb4Mm8w1Kf1x+GkVZ3xCqQiKBIAy3VddECBQRaujD
         F1DrXRzMVu9lIZXaq/f20C7VUeLtB0w6bX42RKee0dDqZ4hHH5HOt8NBFbKbZwY0uwcd
         eiaztjbBZfBJsYpWy85CSXF8dQ6ooancGhX0m0Vg4BbY2U1ypZ3Ap4JPbaT1bI5gF1n8
         5qXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832382; x=1785437182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kxRvmx1wxGvV8pBQOXsif8sDMDGk8D/ZvwH0veNhWow=;
        b=dKBPL1+J5BGEj5hk+Zgx5YjGUXMjeGy7ynbUnSqVkhuTnb8QJpw7BIzRb9ivY3GEwq
         3BsKKFrirpDs7FQdU5D7R0tLuq9Cj4bvoR2zw6bt/4v1/PFHCJCxzpujrNenmXY3O9pB
         cqOx7oTXnDle6UV9jQ7heTLVS8J2Lx7PH6rIGl/d6l2kswvP/zHSDBlU1HnDRNPt+Flm
         O2+Rw23HZkI9HFXJGh6KrShR2DVelkVa5VUsj3GE81FKueHXa0lcAbgIHhHFH8h0cT2b
         3/z8Q02/u1+I6jPP6pp25CQD/8O+Bff1d8ITCNl2tFoteiDBhJTovjDb7SfQS9DnZ5qH
         Q/nA==
X-Forwarded-Encrypted: i=1; AHgh+RrLRldQN5eu4pkG5pMcsTXWtSqmDB2XzVAOGDjbhOTZFB7w0WAYUJH2cWZjV9db8dtNE4k6tgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgH+oyl0M40gaJQem3v7QAvdR/ut+Mrrmxpehl0GDSho23GwD6
	6HZO2HhAB4CqsQSwT/vhiioukuwYd7Rfy5xeNG3tA0k4GRcku2gEZZas
X-Gm-Gg: AR+sD10gwA3UmVR8ioXEYet99m/EbaV+Y2uVgbyHWJXnOGe1cHtsOTIHjJDq4mo7GcJ
	gFIxiSEjiyRFnv7N6nxTKRY+b1oPTR3kIIGWIHIbPbAV5qQ945cLrf1X6+j1Viz+J5NCz5LIllP
	bcvkQwpohtMD4O50mKAIRm2gkGL0dTJ5OCeKVIdnwvulG6CV/+3SvLe8Ls+qT55rn+0+dwRyTTe
	uku+wu1kutYhcIVci51p7zJte0jqonyQuxcs9wML2o6a4hlfQTz/YuqSr4oJUAGBYoIAXNFnXqQ
	khroOq6rA6IKykOAD4zCbQGJHD1dKwvjS/l3MkoXCN0X+/hRWkS7DrAP3ecpcjpTLem/zOoT1bE
	aCJ2WkKQbXn7vYS5/Zdm+icU9OgrUP8Do38YRiL1gUUC+2G9wUz/nvxizbZM3Y/bi+akSC0HIYQ
	9VLyhsH2w=
X-Received: by 2002:a17:90b:53c4:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-38ec64f3415mr4603537a91.14.1784832381937;
        Thu, 23 Jul 2026 11:46:21 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:21 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: cocci@inria.fr,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 09/36] net: intel: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:11 +0900
Message-ID: <20260723184538.3888637-10-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +-------
 drivers/net/ethernet/intel/igb/e1000_i210.c | 6 +-----
 drivers/net/ethernet/intel/igc/igc_phy.c    | 6 +-----
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a04683004a56..0cd0e5597c90 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4864,16 +4864,10 @@ static void i40e_control_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
  **/
 int i40e_control_wait_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
 {
-	int ret = 0;
-
 	i40e_control_rx_q(pf, pf_q, enable);
 
 	/* wait for the change to finish */
-	ret = i40e_pf_rxq_wait(pf, pf_q, enable);
-	if (ret)
-		return ret;
-
-	return ret;
+	return i40e_pf_rxq_wait(pf, pf_q, enable);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index 9db29b231d6a..784f9a7bcbed 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -756,11 +756,7 @@ static s32 __igb_access_xmdio_reg(struct e1000_hw *hw, u16 address,
 		return ret_val;
 
 	/* Recalibrate the device back to 0 */
-	ret_val = hw->phy.ops.write_reg(hw, E1000_MMDAC, 0);
-	if (ret_val)
-		return ret_val;
-
-	return ret_val;
+	return hw->phy.ops.write_reg(hw, E1000_MMDAC, 0);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 4cf737fb3b21..b758a7e0f013 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -675,11 +675,7 @@ static s32 __igc_access_xmdio_reg(struct igc_hw *hw, u16 address,
 		return ret_val;
 
 	/* Recalibrate the device back to 0 */
-	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
-	if (ret_val)
-		return ret_val;
-
-	return ret_val;
+	return hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
 }
 
 /**
-- 
2.43.0

