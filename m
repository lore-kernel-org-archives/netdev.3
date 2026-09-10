Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED948372B26;
	Thu, 10 Sep 2026 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026406; cv=none; b=uXIHDtuMk+Uex9GBNZe7SPFZcJrhMSncYguAZeHVJcDdpQNqqb7f01KlQCLjI2aFnntjpHYqnqXdtzz756O7szH7BsMk32hgl72J4h2wMXV7M+unNQ52v8nRDn2+AC5FiTGbkJLcqOm0fFszwaxR66flLaYtIhzD6/mPrKyCP0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026406; c=relaxed/simple;
	bh=Z3+wfUH3sve1Y47LFokaW6TusPI1tbb3M8pjkpJk2xw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BCmlhDH4cFYTms6ix8Hat7G8M+q/UbuhSxYi9nwHJMiF4y4ZD4/r82zCyZPJqhmeqxooW6keqPwNhSPoeSNb0c09LiwaGC9iC/0ArlqAFs6bUM34shxi0aJEjARZ+51dyzKzCBvTLGkbVov546nYR+zYzrpvcCTlRz7G8DVcSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06974443|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0441842-0.000461598-0.955354;FP=16931804759156415222|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.jAJ7Jys_1789026385;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jAJ7Jys_1789026385 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 10 Sep 2026 15:46:32 +0800
From: Kyle Switch <kyle.switch@motor-comm.com>
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com,
	wei.zhang@gl-inet.com,
	sijia.huang@gl-inet.com
Subject: [PATCH v16 0/2] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
Date: Thu, 10 Sep 2026 15:46:22 +0800
Message-Id: <20260910074624.2426899-1-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Motorcomm YT8824 quad-port 2.5G PHY to the existing
motorcomm driver, using the phy_package helpers for the shared top
extended register space.

changes in v16:
1. Add DTS documentation.
2. Fix redundant initialization.

changes in v14:
1. Refactor the error return path to preserve and return the initial error,
   rather than letting later errors mask it.

changes in v13:
1. Fix the lock release issue on the error path to prevent potential deadlock or resource leak.
2. Add a func yt8824_restore_defaults() to restore configuration on the error path,
   ensuring the hardware/device is left in a known good state upon failure.

changes in v12:
1. Refactor the yt8824_read_status() function to ensure proper state
   synchronization between hardware registers and the phy_device structure.

changes in v11:
1. Clean build_clang warning.

changes in v10:
1. Within the interface that swaps to the USXGMII reg space,the lock include 
   shared_lock and mdio mutex must remain held throughout the entire operation 
   and should only be released after all steps have completed.
2. Improve the template interface in phy-c45.c
3. Fix the handling of some failure paths.

changes in v9:
1. Add shared_lock mutex prevents UTPs from interfering with each other 
   due to swapping reg space.

change in v8:
1. Clean up format warning.
2. Fix exception handling code logic based on Sashiko/Gemini.
3. Remove interrupt/handle function

changes in v7:
1. Refactor the using of mdio lock
  In all cases of swapping to the USXGMII side interface, lock the MDIO bus at the 
  beginning, switch to the UTP address space after the operation is completed, and 
  then release the lock.The purpose of doing this is to ensure that it will not affect 
  other UTPs operating in the UTP address space.
2. Rename YT8824_RSSR_FIBER_SPACE to YT8824_RSSR_USXGMII_SPACE.

changes in v6:
1. Add  test mode helper in phy-c45.c
2. Refactor the using of swapping paged for utp and fiber

changes in v5:
1. Fix diffs issue which caused by unexpected whitespace.
2. Fix "exceeding 80 columns" warning.

changes in v4:
1. Remove motorcomm,yt8xxx.yaml, will update in other patch thread
2. Fix locking issue. Since every interface requires switching of space, 
   the bus is already locked during the space switching process in
   phy_select_page(), other operations within the interface cannot 
   be locked again before unlock in phy_restore_page().
3. Fix warning log identified during the inspection process using
   checkpatch.pl.
4. Fix the way of using common api in phy_package.c


changes in v3:
1. Using common apis defined in phy_package.c to handle shared top
extend register space.
2. Add dts demo in motorcomm,yt8xxx.yaml.
3. Fix unnecessary redundant judgments.
4. Fix BMCR registers operation using magic number.
5. Rename funtion based on its approximate functionality.

changes in v2:
1. Remove duplicate code and replace it with existing api.

Kyle Switch (2):
  net: phy: Add driver for Motorcomm Quad 2.5GbE phy
  dt-bindings: net: Document Motorcomm YT8824 PHY package

 .../bindings/net/motorcomm,yt8824.yaml        |   63 +
 drivers/net/phy/Kconfig                       |    3 +-
 drivers/net/phy/motorcomm.c                   | 1585 ++++++++++++++++-
 drivers/net/phy/phy-c45.c                     |   55 +
 include/linux/phy.h                           |    1 +
 include/uapi/linux/mdio.h                     |   12 +
 6 files changed, 1716 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml

-- 
2.25.1

