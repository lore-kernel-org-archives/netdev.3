Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7133D9522;
	Thu, 17 Sep 2026 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633369; cv=none; b=Me2LxfLD4i6Xm0dvb83Ls+ps/6PPKRNa+oWsmq2+ZtFwIeOT1TX0kytoT6XzxBglyYXH6lJ2U3cy/IY/TQ925CNLFxM7FmhGVRjfA8rgH30cZEEBW1u3pI69vVwf3gLIYGwhv29VmFmrpW2vKFOYN/fRhgAa2PaPeNZ/+I2QNsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633369; c=relaxed/simple;
	bh=AehZju0C5K85YW6VLj+noISlmWLVDnPY5FA3oO4s1x4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mqa61xv/sg3SR+ZSekh/94jrOpk0lHdFr6+q1D3RlK8JoA9pp7N+KdUq+pjxKKO+seei575K2pBGvX7xKD/aneSEaG8XaSZyjAqsuC/UGfad15ND75jx3bPIT5eEjAmdocDk9z5Hi54n0VXsqQuI8npUy3dDkQT6jPdm4adtL8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1073797|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0571732-0.000184863-0.942642;FP=16713168814399335568|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jFhn5pa_1789633356;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jFhn5pa_1789633356 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 16:22:42 +0800
From: Kyle Switch <kyle.switch@motor-comm.com>
To: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mmyangfl@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com,
	sijia.huang@gl-inet.com
Subject: [PATCH net-next v8 0/6] net: dsa: motorcomm: add support yt922x driver
Date: Thu, 17 Sep 2026 16:22:30 +0800
Message-Id: <20260917082236.3427168-1-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes in v8:
patch 1: 1) Add a lock operation to acquire the chip ID during the probe()
         stage.
         2) Remove meaningless changes.
patch 3: Modify the changelog description.
patch 6: 1) Remove sds_init() in this patch.
         2) Code refactoring, including yt922x_sds_phyaddr_get() and
            yt921x_needs_extmode_check()
         3) In yt921x_intif_ext_write() and yt921x_intif_ext_read(),
            add a boundary check for phyaddr. The reason is that the
            phyaddr of the top ext register is 9, so max_ports should
            be used for the check to include it.
         4) In the yt922x driver, added initialization of yt921x_port
	    for exporting priv.

changes in v7:
patch 1: Fix the series_lookup() redundancy issue.
         Fix the dsa->priv initialization and the code style issue.
patch 6: Move psc definition to yt921x_port
         Fix psc_get_state() and an_restart().
         Use the existing yt921x driver interface for the duplicated
         logic for chip_reset().
         Move the yt922x_cpu_port_set() to chip_setup_dsa() to align
         with yt921x function.

Kyle Switch (6):
  net: dsa: motorcomm: initialize dsa_switch based on chipid
  net: dsa: motorcomm: use max_ports in series for port bounds checking
  net: dsa: motorcomm: move mib start from probe() to dsa_setup()
  net: dsa: motorcomm: move mib stop from remove() to teardown()
  net: dsa: tag_yt922x: add support for Motorcomm YT922x tags
  net: dsa: motorcomm: Add support for Motorcomm YT922x

 drivers/net/dsa/motorcomm/Kconfig |   3 +-
 drivers/net/dsa/motorcomm/chip.c  | 789 ++++++++++++++++++++++++++++--
 drivers/net/dsa/motorcomm/chip.h  | 113 +++++
 include/net/dsa.h                 |   2 +
 net/dsa/Kconfig                   |   6 +
 net/dsa/Makefile                  |   1 +
 net/dsa/tag_yt922x.c              | 111 +++++
 7 files changed, 996 insertions(+), 29 deletions(-)
 create mode 100644 net/dsa/tag_yt922x.c

-- 
2.25.1

