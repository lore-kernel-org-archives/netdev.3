Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848501;
	b=HHgpVOOHnkETPoqdKJL311f6GCKnzDMZ9gly3Uo7/nOvNy/r3XaEjliRVPoFJ5+od7Pt
	 iYsvim3y32XG+6967OaYTcCm6k6nJxAKZjMKd2IUJHG8kZ0kfCTZYb/W7F7NYb8E/cEsa
	 uK2Cgwsf4sVS7wHV+1Zzq082XfhLHFojxGb/N+9tN6qO7u+uPmXfKvIP+27f386AlAsBD
	 zyaT60Fugp6nJL43Qc+C7Ns4oSj1uZXc+ObeqL0p8dC8lLueNmn8Grhaol2Kj8LsJ45Ta
	 0PizFdHqELjRIs6F/pWuWZEmGly4V6gd7NbznIR+kmmPmS45PB5trYjpWW96ODvsWaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848501;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=M/SfpF3HDIvyW2M0KU+oQ9yiuU5GYFiSnkULsXyOULc=;
	b=VqNvL/PFrTsQ5LNW+kkOF1Y1V/Ahg9KabOEauGFLjyA6rPvku+jBNWsxAaC/izyyH76y
	 Z5gW/ZN216lwBoaJUcDnNaQqYW276kyKvr+KTrm/ipNRd/v93fInoEN4hTqhF9UqtSEf5
	 aXoQgLBjrZe3Gnt/KmN+WlQ42a15KDfumcr+lBLSkGUQq0pXmLjXRCpspnJJHJ9l+k2dA
	 jN7SwdkATU9Id84VdBVfAzSMuCtKeaHiG6ZuKLYfNgnXRI4Ao1BH5O+xvUDDnvp50sqou
	 eybp2tBvOHgWsOhniScvXf/4u13rEu3cN1Mj8iyjFnQlqlZ1nlB78eeovmyLMWgv8wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=motor-comm.com;
	spf=pass smtp.mailfrom=motor-comm.com;
	arc=none smtp.remote-ip=115.124.28.98
Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB3606A332;
	Thu,  5 Nov 2026 03:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24AB3606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07448677|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.048354-0.00145881-0.950187;FP=16713164124569767092|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033025068124;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jx7-htO_1793848482;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jx7-htO_1793848482 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 11:14:50 +0800
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
Subject: [PATCH net-next v17 0/5] net: dsa: motorcomm: add support yt922x driver
Date: Thu,  5 Nov 2026 11:14:37 +0800
Message-Id: <20261105031442.4164960-1-kyle.switch@motor-comm.com>
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

This patchset mainly adds support for the yt922x series to the dsa driver.
Currently, only the yt9224 in the yt922x series is supported, and the
corresponding tag handling for yt922x is added.

At the same time, it optimizes the max ports boundary check in the
existing code, and initializes the dsa switch based on the chipid.

changes in v17:
1) Rebase.

changes in v16:
1) Add missing break in switch case to prevent fall-through in
   yt922x_port_config()

changes in v15:
1) Revert the use of GENMASK_U16() to replace GENMASK(), so as to
   facilitate adaptation to scenarios with more ports in the future.
2) Group functions with the same functionality together in mdio_bus.c.
3) Remove meaningless code comments.
4) Renaming parameters in yt922x_pcs_get_state().
5) Add neg_mode and advertising handle.

changes in v14:
1) Replace the goto-based skip_extmode_check path with an early
   conditional in yt921x_chip_detect().

changes in v13:
1) Fix a compilation error in patch1 only.
   The change is limited to the yt92xx_register_switch function:
   - Replace yt921x_priv with dsa_to_yt921x_priv
   - Replace to_device with yt921x_priv_to_device

changes in v12:
1) Rebase the code.
2) Delete origin patch4 and patch5 about MIB init and remove operation.
3) Optimize error message logging.
4) Add documents about yt922x tag.

changes in v11:
1) Initialize ctrl variable inside yt922x_port_up().
2) Update maitainer for new file.

changes in v10:
1) Rebase the code.

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

Kyle Switch (5):
  net: dsa: motorcomm: initialize dsa_switch based on chipid
  net: dsa: motorcomm: use max_ports in series for port bounds checking
  net: dsa: motorcomm: use fixed-width GENMASK_U*() helpers
  net: dsa: tag_yt922x: add support for Motorcomm YT922x tags
  net: dsa: motorcomm: Add support for Motorcomm YT922x

 MAINTAINERS                          |   2 +
 drivers/net/dsa/motorcomm/Kconfig    |   7 +-
 drivers/net/dsa/motorcomm/Makefile   |   1 +
 drivers/net/dsa/motorcomm/chip.c     | 575 ++++++++++++++++++++++++++-
 drivers/net/dsa/motorcomm/chip.h     | 101 +++++
 drivers/net/dsa/motorcomm/mdio_bus.c |  48 ++-
 drivers/net/dsa/motorcomm/mdio_bus.h |   4 +
 drivers/net/dsa/motorcomm/pcs-922x.c | 282 +++++++++++++
 drivers/net/dsa/motorcomm/pcs.h      |   1 +
 include/net/dsa.h                    |   2 +
 net/dsa/Kconfig                      |   6 +
 net/dsa/Makefile                     |   1 +
 net/dsa/tag_yt922x.c                 | 122 ++++++
 13 files changed, 1135 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/pcs-922x.c
 create mode 100644 net/dsa/tag_yt922x.c

-- 
2.25.1

