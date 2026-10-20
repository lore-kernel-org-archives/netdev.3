Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462789;
	b=ofIDy9NBsqz/DJEsBV7R79eCL2LtjHZt0sfQZOG+9H84moa2A5JAQK3amtIc3Dm2CsLa
	 R4U7SOGnH+B2+EfTFEMMGJaDOu1AS4h3WV9Bmm5UWDTEEvR0L0CfK0DmTqOALqX5pErTF
	 U6FrlS/nKFFyCnYihId4D19+YYZ8rjZSnnbHDCUwU5zQElfqYRHUmWLJES3WKLqkHlJAR
	 b7XvOUwVmJiZa63tEz/D/MPVUbzNpq8A2deo0i70u1xvHUMuKuXGpdE/CLyz0WlaGUvC4
	 IXxh1odeKfAMi0mD4kDZdZZBAYIgywutCYLZ6Lld0zrLbLU5NLGgQ9NMeOSSMG45YEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462789;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kbBpOiPmLDlURhyBoY0KgQ9tJvWcEN5Zw0fFoDbSFwA=;
	b=k1L0sdyDvrTIQRQBV9SrjJIOiIL/gpT2pCbeEZQvnKfnGXCCYJyO8NwMU/+cZ3Q2/3QX
	 K7ZwEy9w9ddXqdbeL7nEGWqoOi7YZa7Z0K8c7U98+OonFYek14kIPO/T4CPcFl5UuQMnA
	 aCrdSpkjXbiigowK7BTBfgMjcyOcjIeQgXlyOnwTmoXeNk1D4Pldw8BxWfzuq2n09wXem
	 yo0NdQM8fpfk/cXvuaelzWyUF6zMRPW8UX+j+tUF/QGFGMTkPn2hlPeX3zHPFvTl5dAU1
	 9a7MrBaZrEL0YsUBoxoI6XaoeGno23Xq9goalpmJ46fjj8Sf4Eu1WcY58HeDGVP/Eiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=motor-comm.com;
	spf=pass smtp.mailfrom=motor-comm.com;
	arc=none smtp.remote-ip=115.124.28.218
Received: from out28-218.mail.aliyun.com (out28-218.mail.aliyun.com [115.124.28.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20561606A319;
	Tue, 20 Oct 2026 02:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20561606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06713244|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0160344-0.000260513-0.983705;FP=16929337455097241330|1|1|10|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.jlJBlyz_1792462769;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jlJBlyz_1792462769 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 10:19:36 +0800
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
	jianmin.wang@motor-comm.com
Subject: [PATCH net-next v27 0/3] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
Date: Tue, 20 Oct 2026 10:19:26 +0800
Message-Id: <20261020021929.3028490-1-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
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

This patchset mainly implements the phy8824 driver. The phy8824 is
an Ethernet PHY that provides one 10G SerDes output to four 2.5G ports.
The driver mainly covers two application scenarios:
 1. external PHY8824
 2. PHY8824 embedded in a switch.
The patchset mainly consists of three parts:
 1. the DTS for the phy8824
 2. a generic template testmode configuration api.
 3. the phy8824 functional functions.

changes in v27:
1) Remove unuse macros and "," after yt8824_read_page() and
   yt8824_write_page().
2) Modify the function description for yt8824_restore_working_status()
   and yt8824_config_init().
3) Add UTP power up operation after init success in yt8824_config_init().
4) Set sds_initialized to 1 in resume.

changes in v26:
1) Rebase

changes in v25:
1) Correct the naming of some register name macro definitions used for
phy8824 initialization to follow the conventional naming style.

No functional change.

changes in v24:
1) Fix the typo during sds init.
2) Add priv->sds_initialized to indicate whether the SDS extended
registers shared by the four channels have been initialized.

changes in v23:
1) Remove meaningless comments in driver.
2) Using #define to replace magic numbers during PHY8824 init.

changes in v22:
1) Using motorcomm,package-mode to replace phy-mode in DTS.
2) The corresponding parsing has also been updated, using
   "motorcomm,package-mode".

changes in v21:
patch 1: 1) Add maintainer for motorcomm,yt8824.yaml.
    2) Using 10g-qxgmii instead of usxgmii.
patch 3: 1) Change the usxgmii space to serdes space.
         2) Add lock operation during phy-package init in probe()
         3) Add check for whether auto-negotiation is enabled
         when updating the link status in read_status().

changes in v20:
patch 1: Add phy-mode description in properties in motorcomm,yt8824.yaml

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

 .../bindings/net/motorcomm,yt8824.yaml        |   78 +
 MAINTAINERS                                   |    2 +
 drivers/net/phy/Kconfig                       |    4 +-
 drivers/net/phy/motorcomm.c                   | 1926 ++++++++++++++++-
 drivers/net/phy/phy-c45.c                     |   23 +
 include/linux/phy.h                           |    1 +
 include/uapi/linux/mdio.h                     |   12 +
 7 files changed, 2043 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml

-- 
2.25.1

