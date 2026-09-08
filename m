Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B71495046;
	Tue,  8 Sep 2026 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856595; cv=none; b=RujrlGlmTD6O+8m3T42RyqexwqphStZ3XWyJYediOlmoStbTg5Btjxzu+txXDLqsZfDhM7iHyssELU/qaLTIk7CUvse2LfwbLYOLXy+/Z1v2RwJcidYfdkMr179aH1wWg9YWrJRyjlOFeckR91KDBgIBHEAVy4hb5iPE3xEN8QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856595; c=relaxed/simple;
	bh=qDRthiXIj6Buvrb0O5Ta7+2sHS2FEyxgO9fN4JSmAL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nkGn/bnC++0sdWaUNugQaVbDfvCflBuD8Q9wWIkbwUZ8J4rXgf4Ij4gjRdYCXUIhdk81YMGDztBnFIVUREYKP9v05WrxqN/gN+iwCdWzJQv0XNFWhrGy2NJv5w7YQDXcZgGdgNZOg5Gn4OozeGK65NiQ7KVvKeCveNfac+7CTi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2362439|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.073554-0.000903522-0.925542;FP=12066018959093710481|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.j8Z17c4_1788856574;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j8Z17c4_1788856574 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Sep 2026 16:36:28 +0800
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
Subject: [PATCH net-next v6 0/6] net: dsa: motorcomm: add support yt922x driver
Date: Tue,  8 Sep 2026 16:36:08 +0800
Message-Id: <20260908083614.2210505-1-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for Motorcomm YT9224 dsa
driver. The YT9224 is a member of the YT922x family, featuring a
flexible port configuration with four 2.5G UTP and two serdes.

changes in v6:
patch 1: remove compatible info and fix variable naming issues.
patch 4: move mib stop from remove() to teardown()
patch 5: modify the way dst port is filled in the tag to handle
multi-port scenario.

Kyle Switch (6):
  net: dsa: motorcomm: initialize dsa_switch based on chipid
  net: dsa: motorcomm: use max_ports in series for port bounds checking
  net: dsa: motorcomm: move mib start from probe() to dsa_setup()
  net: dsa: motorcomm: move mib stop from remove() to teardown()
  net: dsa: tag_yt922x: add support for Motorcomm YT922x tags
  net: dsa: motorcomm: Add support for Motorcomm YT922x

 drivers/net/dsa/motorcomm/Kconfig |   1 +
 drivers/net/dsa/motorcomm/chip.c  | 968 +++++++++++++++++++++++++++++-
 drivers/net/dsa/motorcomm/chip.h  | 123 ++++
 include/net/dsa.h                 |   2 +
 net/dsa/Kconfig                   |   6 +
 net/dsa/Makefile                  |   1 +
 net/dsa/tag_yt922x.c              | 111 ++++
 7 files changed, 1183 insertions(+), 29 deletions(-)
 create mode 100644 net/dsa/tag_yt922x.c

-- 
2.25.1

