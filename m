Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEF722E3E9
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 04:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783832004; cv=none; b=pJ4BzulSoW6SR4V8ka1NxQFLVE2E/qNf9mrmXLX7iCqor4RXZRMO3qGZOWFblHQRtAJH4lFLpiJsdOyMFI3ymJJPCbDwhN7pfbTJAaGcaEXzCi7vxnBZZxN6TMhHkGDbSskrO+DpJ6lK/e4vqfrIGvL6X5R58nQw6fDreh9tJNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783832004; c=relaxed/simple;
	bh=shhBzf8yexRu7jj90QvU8W+4YZ4WazeRu+Yf64bVNvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lsEvBRoR/sMcCQrw1y1sxYSyjfvMGehpmhSJzNMe2h71y0imsfruPZLW7BbzLRi9T4IBSkVgWuq/Es35n9E/IwNgtHzTcEhNz6vzek4SFlVEUeJ94YlVqycxJjFv/LNJ8o/SWJLh2ZZbipWvq99F2opD4G24eudS/IVk86Gr0Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRtEn0hr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRtEn0hr"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so34850665ad.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 21:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783832003; x=1784436803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vtqux2brqZY3L9xWBvozGrzsW9R7W5/4mbtliRjhCrk=;
        b=ZRtEn0hrZWiDP0SrY9SHWUQSF8WKuOnuFRGMqp7dAQf80hcPXgGf0hSz3xk5VFdWuF
         p0zJ56IK0/2CKH2YVgBGdjURnvjI8pbFYwqxoQlMU2qUelO61llzCIDgorTd7DDoCAPN
         YiVbOmkrvDt+E4XuDHZ05jD0U6YNFCB1CX3/kYVwS1HLJZ1gp7nuG3u5A0/V3TCklnkV
         1Un9LRv2B99g2XkR7g4JCNkU8ySiGOjI4yhSeCCSiFFxcVncZ6HK7J+mXJGn3v10uKYP
         hRRMetG0cdjG/QubbCpBPFJdSvXeP0U7Wd1H6C5clgZCAEl0R3tqpRQa3HQSXbEt+3Uk
         4RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783832003; x=1784436803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vtqux2brqZY3L9xWBvozGrzsW9R7W5/4mbtliRjhCrk=;
        b=hnovwvqwRB10MX+1yHqTwxXso5DbgEOq+2aAs5y79zSX7yi/bJ02BjmQkN/B+sYSZf
         HsdL7t6rgRfzzKw1rAFeKoDF7yiOSWaTCfWp3pMyKX9s0Z3FNTwQja05BMZXkbncQtdt
         zJ0DbVF9L0s9Hp1CjLbrgtJ0TolZJ4bpSZROdPlD+YwyDrZXd4Yu3sNYmBgelr9AGp25
         kASSHgVhYBaBQDkzlK6Xv4gb28wm52E+9hYdDgw7mEXwAz/X0W3d+I8+U/BMCt9elrBN
         6e0gp5BxViH0K17sWGqXHOvMubUZPJwNeTkA00LZLskjV91tGV6CzXPx+S6u6zW+794B
         T8Bw==
X-Gm-Message-State: AOJu0YyLZp5LrzbEv/+2u8xgGgziKz2WT+0VN1bjSCmuk8UvNkaxC5/X
	mWDhhZLczsN/vLKRNk+Ql1w3nc3h1AFLz0aL0o0KPiaDE4Xu2RA24tHK
X-Gm-Gg: AfdE7ck93C5MGdEq9jtTyPs6dN8CEEc7smpw1TbyfQiE0tsXr7OBURt5+8MK9DzefSA
	MMTafmcK9GgXWkdbFqsZNcyZC6cZqwKs3qpIPDBmfbfZE7NBNklV92dYMWNhD1TbFbQIASEB5cK
	JCBH1sbHZC/AOjcFclJ0baTJMXXqQv/hqFrinRoUDg/1sGo+DbLWskXigiIq1rzNjjeM2sy+7/6
	qgIkkv2um/IYdGEC4Ds4+y+or6uAL/dv3XVDO87hAORj2d3bIBt3VXhzTDd2C/ck3B8/Ezrn5ky
	zZdiCMXX/QlaMWqMRwdt3d2ek2zXC2phT4kCX3hhjaEmB9qSy7ZG+D/sIW1F8PYCvYJxP5tZ5em
	oxkhyDAQm2hiGlh4/hSGWXffjtb7C8x++GINHAIAJmasxZC7Xj+L1lOxA6ByKivdKDMnbRKcdDW
	w=
X-Received: by 2002:a17:902:f68b:b0:2ca:1eef:5096 with SMTP id d9443c01a7336-2ce9f15ccacmr45287845ad.36.1783832002767;
        Sat, 11 Jul 2026 21:53:22 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3da55sm81624355ad.71.2026.07.11.21.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 21:53:22 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	E Shattow <e@freeshell.de>,
	Han Gao <gaohan@iscas.ac.cn>
Subject: Failed to reinit phy of spacemit-dwmac when reset-gpio is present
Date: Sun, 12 Jul 2026 12:52:33 +0800
Message-ID: <20260712045233.800748-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR:

The DWMAC on Spacemit K3 is failled to register phy after the reload
the driver module (rmmod then insmod). Because the reset-gpio is
asserted while unloading the driver and is not desserted before reading
the c22 id, which leads to a fault.

Description

In a few days ago, E Shattow reports he has sufferred the a weird issue,
when unloading the spacemit-dwmac driver and then reloading it, he got
the following error:

[   60.713071] mdio_bus stmmac-0: MDIO device at address 1 is missing.

This only occurs when reloading the driver but the first initialization
successed. After some function tracking, I found it is failed at reading
c22 id. The call graph is as the follows:

stmmac_mdio_register
	mdiobus_alloc
	of_mdiobus_register
		__of_mdiobus_register
		__mdiobus_register
		__of_mdiobus_parse_phys
			of_mdiobus_child_is_phy
			of_mdiobus_register_phy
				fwnode_mdiobus_register_phy
					get_phy_device
						get_phy_c22_id

By checking the difference between the initialization process and the
reloading process, I found the reset gpio is asserted in the function
mdiobus_unregister(). And there is no any function desserted this reset
gpio in the loading stage. And in the initialization process, the reset
goio is deasserted.

This bug report is sent as I found it is hard to solve this problem
and ask for help to fix this issue as it is related to the framework
instead of a specific driver.

The possible workaround I found is as the following, just use the phy
id in the compatible string (Confirmed by dlan):
---
--- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
+++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
@@ -196,7 +196,8 @@ &eth0 {

 	mdio {
 		phy0: phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
+			compatible = "ethernet-phy-id001c.c916",
+				     "ethernet-phy-ieee802.3-c22";
 			reg = <1>;
 			reset-gpios = <&gpio 0 15 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
---
An interesting thing is, moving the reset-gpio to the MDIO bus level
does not solve this problem. Only setting the right phy id can mitigate
the problem.

Regards,
Inochi
