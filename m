Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E393101D4
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902608; cv=none; b=Ekdq5xvd37O3zkR+3/YRtJssc13a0g4Y3J2G/efMPa2ESPnkBp/1ZtkmSgr30yY3vpYHDcisLRf9dLbyrPfW5zxhkpzZU8yQd41yd7HEkvC10jXDfQWevQ2I/+c604NY/bH0Sz4q0UrurNXDpAu84hAdAt07DLONsaYcUwWpmFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902608; c=relaxed/simple;
	bh=PdkVTA4F/ER9GzUAoSUZBzYX4sYHbjYEgTH5soza+vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rc2kpIAji9ST/xOLmMsyIRTJ+WrGHuZT7t9wXzy7gWdcjSXYWm3C4X6kWBu1a6OdIBjg1VQwZS+hh7cBvKR10LxFsFEwpFBRpR4XpZLJfcm+Ls0ecglzfG3y9OrStPuse9jDWRSQXX52RCsRghERi0LHVhbgd3e/tJzr4ZgVGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz13t1780902541t95cae5f8
X-QQ-Originating-IP: RV4J7uDkvmjSzeawDdbAYuKoiYgFYgNbRLwyX+slZY8=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.184.84])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Jun 2026 15:08:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6857336265194045610
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 2/3] net: txgbe: distinguish module types by checking identifier
Date: Mon,  8 Jun 2026 15:08:41 +0800
Message-Id: <20260608070842.36504-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260608070842.36504-1-jiawenwu@trustnetic.com>
References: <20260608070842.36504-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NiWQQk7XjMbnLX6sZIb3uFuD4SN2+uLAiqAij/+zZ2DkRzq+Wjeu/TkV
	a834SRTyfAictrx4N1ovqgWp40BtJ7pHa3hHVL52iX2qCUX5/sg52aT3lAanDFEX3l3csSj
	d2Y+HmCYnjpR7+aU//mt6PTv0Xq5hGSIZWEMv1t2r/9IDM3DO7fSkQ3/t6t3PL/T9VsjYu8
	1eWUQVAx8VAehhEwaPrrrTCU02t7oVgQvmtiB7ER+apPmobp1DFfLhEDDI6UJ0eLg0ynzB4
	I1v7gnUxEkBYWJAcYj/0HYiJgymkkOPa/NPhcMCR4JTG4x7aaNgTv+L+ffo/45XKIi7eVAX
	VYoZa5EBnEQsSal3xOHBApMO2LqXvcbjethnJ3eLYXARc9owTG/DiPfbVgZLPyang0hhK47
	bUU46eklLyeSmaR3irKLFAwPsuxAPhxZcoKyaWm2YUh8LS6n8KiVlZsVtoaYo3JPVOnRHeS
	a/Wo5QxghQgiuYEoltKQbngG4lS/fC7tp6ZScl9sh4etNT/5RO2aX2bWfYlAU6POGqO4fZH
	s4SXbGYac/hAP3AlJorwCvF30Kzqe+BZ+lUyCqUBVjF1lfzXqmF7cOU2ycnUwQ375Ygy7zg
	uSNtCgeQDsmlg8ahHZ0XmcU28gxygT9/JPfww+5KvfXdJy/FdYU81OnlKVvkt1k/ydUaNDD
	QAyf73YPQRZ3H6aUHZLG5NMRj/dbtBvJOjhnzUXK+XeVmd1Xm9uDt0EEDOWbNHXJRtW+hFz
	Ox2YdvutnEeBzROxBs9P7gR8H92FrMtEs6winssv5KVAUM9IRMMb0WT546reGJBVTegByhX
	DVfnAbEcLaFfqcn7tqm3Zt4tCGl9eXhBpuadRObOqs0wrL2MHoy2LPFehPSM0Ipg2mJbSI0
	c+juGeb3bIjbdfpUobbQP3+gXAuJ2XcG1w6SyEnfccTvj/dgSKz4L7qD5XCm7WNxnXqhrH0
	3hA8qOV5iHLBeI4ry1Lfg9IVQ7DeeI6Huvbc9I03676n75y9hy5FiGA2i+9D7JCKDbcLzOx
	Jug9BgSqMuxNz50axw5pMjGUF1JeC5u3zH0r7AbGfXwmk6jzwVcqNooCeQ6Un/wLiEtmIDu
	HdXTtPXpFdBTEa+arWDZPnpiK8rXt1LoBT3fQA4jCuO
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Rework txgbe_identify_module() to validate module identifiers through
explicit type checks instead of relying on transceiver_type heuristics.
When using the SFP module, transceiver_type could be a random value,
because it was read from an invalid register.

Fixes: 57d39faed4c9 ("net: txgbe: improve functions of AML 40G devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index a7e81f9e1be1..bdac654a2364 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -357,18 +357,16 @@ int txgbe_identify_module(struct wx *wx)
 	}
 
 	id = &buffer.id;
-	if (id->identifier != TXGBE_SFF_IDENTIFIER_SFP &&
-	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP &&
-	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP_PLUS &&
-	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP28) {
-		wx_err(wx, "Invalid module\n");
-		return -ENODEV;
-	}
-
-	if (id->transceiver_type == 0xFF)
+	if (id->identifier == TXGBE_SFF_IDENTIFIER_SFP)
 		return txgbe_sfp_to_linkmodes(wx, id);
 
-	return txgbe_qsfp_to_linkmodes(wx, id);
+	if (id->identifier == TXGBE_SFF_IDENTIFIER_QSFP ||
+	    id->identifier == TXGBE_SFF_IDENTIFIER_QSFP_PLUS ||
+	    id->identifier == TXGBE_SFF_IDENTIFIER_QSFP28)
+		return txgbe_qsfp_to_linkmodes(wx, id);
+
+	wx_err(wx, "Invalid module\n");
+	return -EINVAL;
 }
 
 void txgbe_setup_link(struct wx *wx)
-- 
2.51.0

