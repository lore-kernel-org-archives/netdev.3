Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B2255D886
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092361; cv=none; b=OC6+SrzwtctLbxxW4jOhJWW28VGtOmlfAcS1ZDOcQB4UNUnG60ZBCEw0r7G+leQ50r/ZMMY2xfNOI4Wc1YeMKpWnnNXvNW6Bdo/nwrhDqhQ/dmbgdyGG8TZMtSYeaaC17H7oSvWfsid39uIQW5svETgcCvwkRWq++TLgbOp7cho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092361; c=relaxed/simple;
	bh=nCTXi0QrphbUuOg5+DmqnjVX+1Bepe6BZKUN+z7NmgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJrVOipisSi0jhxweQzW/ByvN9y0Mj/8WrLQzrte1c6qgGSI/3XZR4rBq0FecEdkrSeCYpZ2gyCMLN9tWIe/DX9ov9wsFopI/tybx/Ry8MvR7FSGmb+5iPV7dEsBHR/AVZwA6TG/pLq7MOzqNUxlMP2HyvM1NjhK8c8cN2rpMdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLK9aiDX; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLK9aiDX"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a985e8fcddso5503584a12.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790092358; x=1790697158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nsDs23DcdYwkDSFn0tiJfOUbVshOv/zFLmietT3ibk8=;
        b=GLK9aiDXA+0QuzEEzArRbvzHjk0rGx2bB+AbPf2yu5AKjmaNRZP13+bfvPVCuCEitQ
         NenSCgDjfbBWS7nMYBAoga0hwYWmEj13GQuN2Ia5hvV8P2acHHhwSPItW+SOARhHYUTl
         7MKt2WTFGOTHPYzFzonkPvSJjhU5eYlAkohpROKay/Vm51OV9mG/SI29lKRNSrO8T+ZN
         HGReicMNATHPbwOUyR1xhT5kTQglpEDL3jqgH3lYc9FlJfvMwGw7sXs70Ej6tu6yGvoP
         Re9P4AaQHss/SIvA3sp1M2f89/oXBUzZIKpS1lQZ8YeHGPz8x3mHjIJ9WRxiGSEik3S4
         Dj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092358; x=1790697158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nsDs23DcdYwkDSFn0tiJfOUbVshOv/zFLmietT3ibk8=;
        b=GprUCusyFQCMKxhFiZPCsATTPY0LGTdvMU/XnNXeuHW4Hyv4THIo0b9yvjyKojuxnQ
         1KPoBS9qgc+PptUS4iCsDyTm0tBxfEY8s5yHTaZRwlglNaFjUQlXGMZycoE2N1waHGyo
         /Jp2vY640/rQ+Ruh37zzpStVdODS0mUTdasxVuFYkxWT4JvsJsJTzb7XXe86j2fLFLPz
         H6deiIucwlkAhidezW0T+9NMDNZxkT5PKO8MbFBCnfyci+kGQvWEUm7ZS8KhX+UEEFub
         7JiObiCYY2Znvgi1HVggo7drOxX18dSw1IrFh+iVLzw/T8keOBuRagX2sLKvuUPobuV5
         idkw==
X-Forwarded-Encrypted: i=1; AKwUvBzMHtEy1reS9oApg3e/KgP1BrLqZbyi+gs/Br7I1OYZZP1AXcNWjK5kpBlSnwU+LfB/2r/WH/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lfww7x0QwKH/80yv+cN70dIGOk27VcnfoRaKLOfWDIUSGx8nS0
	XgHYkhXnBblZwON3S3Go7swoUjnZ6nfSyRdyCBxMPeU+Y6YS71C0wk4b
X-Gm-Gg: AYBFou1UhbAwW6U/IFnEOtsJN5q2/ducOJ3cFHxAoIheS2jrirhkPR6Q9Omkl6YswWt
	xQCcIQuh0/XFvj43SitLiV3lGj/ueEqP1uvZIGpE1B9JUFzKKUfiCkMBhimYz/+PQAYeU39ty80
	2i0sV64Iugg7YzkawAJpQWiX3AZZUvyZsbmF1oFS7yONk7WUKVvuOrtlK07Dm6XBFj0DYwJ+vnL
	Q6HUjNFXRYBiU9ykKLWymOR8N/Ep2eJD+1x5HjMQ76hynS8I74fqiHNNPxJz7Mv4bNBRnC0YCFD
	lWI5/Y6jKuIWMtM0ba10Gv0Ml6r9AaJ4TbCdExqMNE6UQYXUTNJCpPLDTfp5i3Uv+GPQ1bC+KFO
	KnwQab5fwiMqVuUafgOU93yTuPeFG7HJ7cR5+q3NVUYkskIIDtPxMEzj2lrbMBjsHvvntzAXCmt
	V6z4FwwbX7JZPafMHxHf2aYlxiUsRgiAMwjkINgyGZTu80SfTK+spcXZLjj6o30BBcWzf1tlDXS
	59g+p+lbI6DUbUc
X-Received: by 2002:a05:6402:274e:b0:6aa:9f93:e991 with SMTP id 4fb4d7f45d1cf-6aa9f93ece3mr3291043a12.3.1790092357607;
        Tue, 22 Sep 2026 08:52:37 -0700 (PDT)
Received: from localhost.localdomain ([94.240.182.136])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaa44e6262sm1347326a12.11.2026.09.22.08.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:52:35 -0700 (PDT)
From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	ffainelli@freebox.fr,
	auke-jan.h.kok@intel.com,
	jgarzik@redhat.com,
	joe@perches.com,
	aleksandr.loktionov@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com,
	Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
Subject: [PATCH net v2] net: e1000: fix warning in iounmap on probe failure
Date: Tue, 22 Sep 2026 18:51:39 +0300
Message-ID: <20260922155139.67364-1-nsvatoslav515@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During a probe failure, the e1000 driver error handling path calls
iounmap() on hw->ce4100_gbe_mdio_base_virt and hw->hw_addr without
checking if they were previously mapped. This triggers a kernel warning
(WARN) rather than a fatal crash when passed an uninitialized pointer.

This issue was found by Syzbot. The exact kernel configuration (.config)
and the C reproducer used to trigger this warning are available on the
Syzbot dashboard.

Fix this by adding NULL checks before calling iounmap().

Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Fixes: 13acde8fffc0a ("e1000: cleanup CE4100 MDIO registers access")
Fixes: 1dc329180fe22 ("e1000: Use hw, er32, and ew32")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
---
v2:
  - Expanded commit message to answer reviewer questions (reproduction details)
  - Added appropriate Fixes tags
  - Added Reviewed-by tag from Aleksandr Loktionov

 drivers/net/ethernet/intel/e1000/e1000_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7f5c6f16142..156903089fa6 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1227,8 +1227,10 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(adapter->rx_ring);
 err_dma:
 err_sw_init:
-	iounmap(hw->ce4100_gbe_mdio_base_virt);
-	iounmap(hw->hw_addr);
+	if (hw->ce4100_gbe_mdio_base_virt)
+		iounmap(hw->ce4100_gbe_mdio_base_virt);
+	if (hw->hw_addr)
+		iounmap(hw->hw_addr);
 err_ioremap:
 	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
 	free_netdev(netdev);
-- 
2.47.3

