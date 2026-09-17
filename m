Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB4A514757;
	Thu, 17 Sep 2026 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650900; cv=none; b=Kf6YvgX+xErGQksOLZWNJ2Bxthy+kmaSlYdpVg0kyaPDjEqc8hQIEwEGPQQIIEl5RjS/3tIA6qm/wEoFb7Cx+O0xkP/2aazUGTx5TCGHSosRQNF/+CN6tu7/6BHtywMWYopbucLEMkQG7FTk+vIithULzqiELZNIs8Rbw01TQ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650900; c=relaxed/simple;
	bh=6KejPPSanQMJvKVM9s9fmU76bWLXLWoWbO895diSvXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tp3gUfD4269y7kqf+/RkOg1r9vC1XkJhmEgml6sO/KtElLz6IhO8krpJ6Y96xGrxorFvL3B9rXVIhBj/lmTtJ1LNUnfceN4BOPesXMEMx4GYyGhJ7ZNGs+CPYe69TttFfmLQ98yDWxf4ksIOQP8ktmQhwr46/5fzh0B0hdgus6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06727381|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0371212-0.000463823-0.962415;FP=16778537236326603986|15|2|17|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=19;RT=19;SR=0;TI=SMTPD_---.jG4HK.K_1789650881;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jG4HK.K_1789650881 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 21:14:46 +0800
From: Kyle Switch <kyle.switch@motor-comm.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Frank.Sae@motor-comm.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: [PATCH net-next v20 0/3] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
Date: Thu, 17 Sep 2026 21:14:38 +0800
Message-Id: <20260917131441.3428554-1-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes in v20:
patch 1: Add phy-mode description in properties in
	 motorcomm,yt8824.yaml

changes in v19:
patch 2: Replace the int type with the u16 type for test_mode.
patch 3: 1) Merge yt8824_utp_normal_test_mode_paged() and
         yt8824_utp_invalid_test_mode_paged() into 
         yt8824_utp_set_template_test_mode().
  2) Add a fatal error return when phy-mode is missing in
         the DTS.

changes in v18:
1. Split the template_testmode() into a small patch 
   and optimize the implementation.
2. Optimize the definition and initialization of 
   interface_mode by adopting the existing approach.

changes in v17:
patch 1: Remove redundant description.
         Use phy-mode instead of motorcomm,interface to describe the
         interface.
         Add the required checks.
patch 2: Use phy-mode to get interface mode.
         Need return after init configuration is done to avoid falling
         into the error path.

changes in v16:
1. Add DTS documentation.
2. Fix redundant initialization.

changes in v14:
1. Refactor the error return path to preserve and return the initial error,
   rather than letting later errors mask it.

changes in v13:
1. Fix the lock release issue on the error path to prevent potential
   deadlock or resource leak.
2. Add a func yt8824_restore_defaults() to restore configuration on
   the error path,ensuring the hardware/device is left in a known
   good state upon failure.

changes in v12:
1. Refactor the yt8824_read_status() function to ensure proper state
   synchronization between hardware registers and the phy_device structure.

changes in v11:
1. Clean build_clang warning.

changes in v10:
1. Within the interface that swaps to the USXGMII reg space,the lock
   include shared_lock and mdio mutex must remain held throughout 
   the entire operation and should only be released after all steps
   have completed.
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
  In all cases of swapping to the USXGMII side interface, lock the MDIO bus
  at the beginning, switch to the UTP address space after the operation is
  completed, and then release the lock.The purpose of doing this is to
  ensure that it will not affect other UTPs operating in the UTP address
  space.
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
5. Rename function based on its approximate functionality.

changes in v2:
1. Remove duplicate code and replace it with existing api.

Kyle Switch (3):
  dt-bindings: net: Document Motorcomm YT8824 PHY package
  net: phy: Add support for Template Control register for PMA
  net: phy: Add driver for Motorcomm Quad 2.5GbE phy

 .../bindings/net/motorcomm,yt8824.yaml        |   62 +
 drivers/net/phy/Kconfig                       |    3 +-
 drivers/net/phy/motorcomm.c                   | 1575 ++++++++++++++++-
 drivers/net/phy/phy-c45.c                     |   23 +
 include/linux/phy.h                           |    1 +
 include/uapi/linux/mdio.h                     |   12 +
 6 files changed, 1673 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml

-- 
2.25.1

