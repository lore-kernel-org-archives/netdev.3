Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDAB4119E0;
	Thu, 24 Sep 2026 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242927; cv=none; b=EPsMM7o+kFnNI0JWUTjudkcL9vKvVhLT9111cXLoFGUO8baiXHgsEAHEW2d0qyivSjKkriSrxHnGPrwuRPpwiE2gV7pzCIs5lZeWDDj8QHOVlydTStKe3HKcoWGnQ3Qff8z0IkdM1yxIMBfLyRBbwtq5vcDWvGr/R9AdBPfM6Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242927; c=relaxed/simple;
	bh=RPCSq3I8jreOxp9DFxNUU6TWSUOD3qyifi469YC7jiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CgPCpu3eqVgH1asZqZ+Yo7/TxOc2kXg9Z+3aOvFicXiOYooEyZ4eQWEnHQcYg+hI2HGmCh1ZjAb9P7NSDdzlnkfNsHlcEhbv+t3pgu06dzd3CS1OFowgwOqbmM7FJk8xbnJLUfxmULwW0exh8zcDIlWm1Os8bNnFWx7taJhOAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09723996|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0421627-0.00027612-0.957561;FP=16713160018247590928|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jM7KJS7_1790242906;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jM7KJS7_1790242906 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 17:41:52 +0800
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
Subject: [PATCH net-next v9 0/7] net: dsa: motorcomm: add support yt922x driver
Date: Thu, 24 Sep 2026 17:41:39 +0800
Message-Id: <20260924094146.4128703-1-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset mainly adds support for the yt922x series to the dsa driver.
Currently, only the yt9224 in the yt922x series is supported, and the
corresponding tag handling for yt922x is added.

At the same time, it optimizes the max ports boundary check in the
existing code, and initializes the dsa switch based on the chipid.

changes in v9:
patch 1: 1) Add a dev_err() when chipid mismatch.
patch 3: 1) Using GENMASK_U* to replace GENMASK

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


Kyle Switch (7):
  net: dsa: motorcomm: initialize dsa_switch based on chipid
  net: dsa: motorcomm: use max_ports in series for port bounds checking
  net: dsa: motorcomm: use fixed-width GENMASK_U*() helpers
  net: dsa: motorcomm: move mib start from probe() to dsa_setup()
  net: dsa: motorcomm: move mib stop from remove() to teardown()
  net: dsa: tag_yt922x: add support for Motorcomm YT922x tags
  net: dsa: motorcomm: Add support for Motorcomm YT922x

 drivers/net/dsa/motorcomm/Kconfig |   3 +-
 drivers/net/dsa/motorcomm/chip.c  | 798 ++++++++++++++++++++++++++++--
 drivers/net/dsa/motorcomm/chip.h  | 113 +++++
 include/net/dsa.h                 |   2 +
 net/dsa/Kconfig                   |   6 +
 net/dsa/Makefile                  |   1 +
 net/dsa/tag_yt922x.c              | 110 ++++
 7 files changed, 1002 insertions(+), 31 deletions(-)
 create mode 100644 net/dsa/tag_yt922x.c

-- 
2.25.1

