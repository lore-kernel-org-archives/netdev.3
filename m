Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF5949DBB6
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142011; cv=none; b=IB9u0HIcHhbF7gxYczQ4hEkyHptX751kLPQMEjn9CN2O/0l6Jo6JPvGx+HgdH+lror+ew44tNoB9T8fjXODQ9xGDpnEpuvgwpBuJpnWpuC/doLi49IiEulfeo6QPKKVwri94gRpG29B0MpURAdRmu7Y/T9DgFioeAPvBRRh4GHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142011; c=relaxed/simple;
	bh=A4mNJss7r8+QPwLUxRmAnLRSF7/BOBXN3ZTsgkISMUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gXVbSiW71rBetZ6/gImTbL+bz5rPZuJ5vTK/UPqLf300z5mzMIXwdIGeIYvp/Httxc7PqtDMYZaAt0o9xcymL95rN8WTmlDKZkeW29T2y0ZEZI0vO4yrTMHdODazw0eZyaNdOr6jAzu36Z/duXjNLrol3OG9ri3myDIWc40QKhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CM+z1PSg; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CM+z1PSg"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-782df51b4c1so764569137.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789142008; x=1789746808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3r3GetI2bTShh7zQsecV1+PSL1nkUSycIYXk9LbNz7Y=;
        b=CM+z1PSg4p05aZBkFWcjFOzpzvg6CgoDIeSUWU3tmEgf53qqYH+dcBDnB/LFv6A+Cu
         AorQ/ss1Anp36naiK4pkYVuBkKEBbLU3rZhyVKdU16jBz+Y6ZhKHbhernujkO9h+RB2F
         LgzNtXcMsuE7asFhcKFs9HRioUkZEwAco3hf5TSjissALaaHVqxJ4AeLzSBXDsmDujdN
         QaSylw0DpRyGl3NLSwxrMLS04LQjbKL3dvSOlRq6+Gccs3whYiOPAFse60rE77Zt5aAM
         +lOe6TLA00OwU3nh/kPdIvlcljoBZ7iTNbSp5gHwqNdBay8gJPwVZbg/B1e0vi0KgWZ4
         +PHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142008; x=1789746808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3r3GetI2bTShh7zQsecV1+PSL1nkUSycIYXk9LbNz7Y=;
        b=GNHOVmb51HKx45/D84CpOmhrUIlmwteq4vaEn2K3acIdvxP4RaEbllJPCicb3CQQK6
         cLETEcx3HuOPKPQdeQ8RIYHY4UfNr7V5yrcjjttZb2cRWOKBcYPXNNezNMhTOvHs//b7
         os9Zhz4kVSfReQLJnHB00g2L4l5XsEgoAwvpYjqZs0wDqQBw2ldaoC1K1PF8vTLHH9uL
         YvVmSyqL7yo0hHy9+aDWre4SjSMaHaM9FRK1erHbZzimrD5a0W32B/4vVDlLSwmk/eum
         tQw62VC2uxWha8XBmTdhmo6ppyzW6RzabbUgljXYJjZOuMLLN5ZKFmgnEEtcDQhP5QJF
         UeBQ==
X-Forwarded-Encrypted: i=1; AKwUvByhYaRnjXO8/uF8Rf8CSi3yhh8qpOAdRPA0bQj/b8CMnJOD2X0hiUzPmlGt6wyM8XRq0TMELSA=@vger.kernel.org
X-Gm-Message-State: AFuF++n1J+JRhwibqTGGTFKsr2y00MEBnkpVAl4uXAsE0jgn/9Q/mGfY
	bRGIu7gnrHLHpjA9rb6v/28k2TWtsQRUuD0kKUfdqB+vFd2/vf8LaTg=
X-Gm-Gg: AYBFou1WujVqZiOOxzlSJsr0E6rMj/bZQM6xSQ786VZg8aGjAjErJfo3aT4Isq8Z7i6
	mBaJS4x+3ZwKsIT+/BLggw/6WSncqDe6nvezXh22l49IsPdqMoGwGzphACtvZBKU2040OL4xFjl
	YP+RjWe5/NbdbZMR+Hv5RtP7DMRdKxkLhEDPKALO7hs5mT2hx5J29Xc94gFHGMstw2Oq/AQe3w6
	MQ3HURrCX64ZB8f9wwY8Ca08Upw++9ouxizK8QNQQ2QOr+OeMROu7FBF7j8LZHEa/Qr128Qz3sm
	UJgr830uVTZ2bPKg85tkMx7j4cuce4jbOjkxWEqwtyuDCmCQ4iS1tdsWUF92Rm2EbMfsAnNUaNr
	FGgRIsOFwycYD25OTW3ZuHvYTdQGzMDmM39gN6S812UAPYeQYliTdsI+pdMZgzM9PW4yS1+kjnI
	ZkucguSjxASv1U/vKolmAutnSffcomBa5Tn45eJ0C2bo9gBHYGuPUI4IHlDQTQVMxy328u32aVI
	kyB6J88N8KfsEGujuc0o7MCuwJzw15bVaVTJaCwIxHLRc49OKXprGvQPUETgehLYvkN4lAZ5AUm
	9WgZgzWKVNFsSn+TJWYCCw/JxQRYJ4OxMQ==
X-Received: by 2002:a05:6102:3a13:b0:789:100e:3d0c with SMTP id ada2fe7eead31-792aad54589mr5833763137.8.1789142008061;
        Fri, 11 Sep 2026 08:53:28 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d389esm23300896d6.42.2026.09.11.08.53.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 08:53:27 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ae878000@gmail.com
Subject: [PATCH net] net: txgbe: free the fixed-rate clock on cleanup
Date: Fri, 11 Sep 2026 11:53:18 -0400
Message-ID: <20260911155318.88857-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fixed-rate clock is registered with clk_register_fixed_rate(), but
its error and removal paths use clk_unregister(). That unregisters the
clock without freeing the fixed-rate provider allocation.

Use clk_unregister_fixed_rate() on lookup creation failure, later PHY
initialization failure and removal to release the provider allocation as
well. Keep the existing clock registration and lookup cleanup ordering.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: b63f20485e43 ("net: txgbe: Register fixed rate clock")
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index dc9f243146580b477a2ae958ddba66a1ac8fc822..c81d485221d56dc1d8d66f5a01ce05c76966830e 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -434,7 +434,7 @@ static int txgbe_clock_register(struct txgbe *txgbe)
 
 	clock = clkdev_create(clk, NULL, "%s", clk_name);
 	if (!clock) {
-		clk_unregister(clk);
+		clk_unregister_fixed_rate(clk);
 		return -ENOMEM;
 	}
 
@@ -637,7 +637,7 @@ err_unregister_i2c:
 	platform_device_unregister(txgbe->i2c_dev);
 err_unregister_clk:
 	clkdev_drop(txgbe->clock);
-	clk_unregister(txgbe->clk);
+	clk_unregister_fixed_rate(txgbe->clk);
 err_destroy_phylink:
 	phylink_destroy(wx->phylink);
 err_destroy_xpcs:
@@ -671,7 +671,7 @@ void txgbe_remove_phy(struct txgbe *txgbe)
 	platform_device_unregister(txgbe->sfp_dev);
 	platform_device_unregister(txgbe->i2c_dev);
 	clkdev_drop(txgbe->clock);
-	clk_unregister(txgbe->clk);
+	clk_unregister_fixed_rate(txgbe->clk);
 	phylink_destroy(txgbe->wx->phylink);
 	xpcs_destroy_pcs(txgbe->pcs);
 	software_node_unregister_node_group(txgbe->nodes.group);
-- 
2.53.0
