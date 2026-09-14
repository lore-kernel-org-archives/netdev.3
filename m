Received: from out28-218.mail.aliyun.com (out28-218.mail.aliyun.com [115.124.28.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DDF438037;
	Mon, 14 Sep 2026 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381826; cv=none; b=sDDTcnj9WOBbfZUzxZeNmbsICe1Elmlx+LloVy5VodIfTRcGDqfX1pBeC6HASc/AXGFL8qCJ+hUMet5gXvTnUsiuLzdg9B0Jm/Ix1mVi+7WdRotl3G2flqL53fYBgOgpv1vE7nol6dw1JF1Lu8zyKhE/XRz0r126SO30JgYwDAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381826; c=relaxed/simple;
	bh=4UuApqlKtBEL1JXESiIfiDNRJn8P2nagtXYQ6TavpHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rXhKC+L85OSbiMBb1sb+/BtX9p/V+A8xHxO163bbFY8tLEUBNdh8CieKu61OLThwyCrevX1sOFSMWaKwgkQUhXUcchAlg/ID3p5NcVDg4CVqHxy81pkWkmoXRknraNCimvJDSqbnsKHLfkvEK9yYViRUb0gWIrpiILuxjbVOWyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1995657|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0438086-0.000338173-0.955853;FP=16677702967333792912|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jDMP.az_1789381809;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jDMP.az_1789381809 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 18:30:14 +0800
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
Subject: [PATCH net-next v7 0/6] net: dsa: motorcomm: add support yt922x driver
Date: Mon, 14 Sep 2026 18:30:03 +0800
Message-Id: <20260914103009.3007019-1-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes in v7:
patch 1: Fix the series_lookup() redundancy issue.
         Fix the dsa->priv initialization and the code style issue.
patch 6: Move psc definition to yt921x_port
         Fix psc_get_state() and an_restart().
         Use the existing yt921x driver interface for the duplicated logic for
         chip_reset().
         Move the yt922x_cpu_port_set() to chip_setup_dsa() to align
         with yt921x function.

Kyle Switch (6):
  net: dsa: motorcomm: initialize dsa_switch based on chipid
  net: dsa: motorcomm: use max_ports in series for port bounds checking
  net: dsa: motorcomm: move mib start from probe() to dsa_setup()
  net: dsa: motorcomm: move mib stop from remove() to teardown()
  net: dsa: tag_yt922x: add support for Motorcomm YT922x tags
  net: dsa: motorcomm: Add support for Motorcomm YT922x

 drivers/net/dsa/motorcomm/Kconfig |   1 +
 drivers/net/dsa/motorcomm/chip.c  | 979 +++++++++++++++++++++++++++++-
 drivers/net/dsa/motorcomm/chip.h  | 119 ++++
 include/net/dsa.h                 |   2 +
 net/dsa/Kconfig                   |   6 +
 net/dsa/Makefile                  |   1 +
 net/dsa/tag_yt922x.c              | 111 ++++
 7 files changed, 1191 insertions(+), 28 deletions(-)
 create mode 100644 net/dsa/tag_yt922x.c

-- 
2.25.1

