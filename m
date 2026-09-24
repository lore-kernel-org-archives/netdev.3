Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1964A3CF030
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215330; cv=none; b=Kgm7dfIDg9Xw2rsVSNCmaVZbv2MGG8uC93a1L98RbONBEZvNSLbuGiCKLljNdxTM1V91ZTWX1KPUPVxeoBMXm3x9i67cGPNTemdQNH+bi3yZoDVLlROI+0GhFKgFL/UJryxfG2w0tj68LX8gONIRKuzOnlou7njW1PE2yOlZ6lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215330; c=relaxed/simple;
	bh=CfVdQ4f5lZmJhBApR2HdDs9BGZ+X6H4vTMGWbGd8DAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UhqYfVOeyH0WnxCbrlfjbW4UsuHx+3O4V/Wb4SnoVt5mPOjOEm1MMemKng6Lv8/9AkAEkiF4s1+RIlaiKhTEXpiGWXfA7wjVX2b9oov/XIUUoQSX6xgKYtzCNmtJlOZvrOd/NrwVMgezEpKbQGu1Wu9GY6hWgtkc+UMfmgjyQwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1790215316t0b1ee11e
X-QQ-Originating-IP: 4G12p9RcKb2G0SOs/UhO1q+H0aK5yQsuns6bbtM8Gkc=
Received: from lap-jiawenwu.trustnetic.com ( [115.205.193.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 24 Sep 2026 10:01:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3466351345858236387
EX-QQ-RecipientCnt: 14
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 0/3] net: wangxun: keep MAC enabled for specific
Date: Thu, 24 Sep 2026 10:01:46 +0800
Message-Id: <20260924020149.30800-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mutteg8H72qDa2LIQowIaAMpERUd7ru75RLKufug8pGAzcoyM/JwrXC9
	zktyFdNxW+tutpFXU7w4g/TfiyAnTyTy1x1bfClvFUruwZ0RAEhTRw3bR+i2tp/rreEgUbb
	3oJxrPfEpMYJAU7NU2BPIrowkjN7ZAOvnlF5BXDgFk7hGTMLbQLSdWZ/SaouL/OWBJ9DAl7
	Ea3VKykuA3t9jv/g5SmaRfWEsr2hFqyWnjryZcE6tm6HrDqmeS23hYOjLOHhyUs8itNokVw
	j1X8RxEtP3axsvrVL6EfcVxf38agZWWvkw/OxwsXTjjqzNzGL0EjzgvNA3j+fAZsCJ0BKIh
	1suFhs04NxjD5qTKcb+MGD+mJD+d2nr0s18F0CaUN7S9rlm/prYYQTlDbr3JtvV2DaMS+sF
	6GceLjK2RL36zD5Pf6HPvWQjDQCzb5jpmbosAm+o1evdXw3zUP9RLtpcbW8XkD+9ciRQC7f
	sxeLyFLszpQEYcQOvTxDALz39InCLt05O1fLkD8xj70ZLuLxGmIcdRcmrOB3cEiqxhG3d2c
	Vm/Mni80jKjNFE9I5kZP1HrDBj5YkDFULQdShVl5hqetKbD0/9KAQSoYmrhJ7S2iAFl6soW
	1la+4Q5vDQ3sem2edPDGwUQsjjSilgkxBH1KBVD6CtiYdgTd4h8Ib84Denqy5/1C3Qg/4Zs
	QGsqbnu6oDYZaJIEetmsW/zg58bLb0BtWHWc5ze/F0oLtdkbVpZIoHUpCrR1+aXZ5DB5kvi
	JmC50Gyi1Wy6Tvt4MkEMpbOFfxiE9ccR2fpvgex/82OUTj5R6b0jjyLukfRDvWiqh4S3JYy
	mdLVumH9jstfAuZQX44gAZ/zk1FYsSYrF0OIrkkLezQXRsa3rXyChzNadET37vh6RqxESxB
	jCraCouOlDZPLpI88/3p92s1XfHnTqUFg9AZ+cBAvfQbkfrKwTT9pkEaRQoz2iSPRXij0Qm
	o0yy4PmFr9IBmTO3wwc9Paaro+DepwHBMK3CCshb7Eo0x0oZ0WHK/gXTRLmqf/I1+q7nbfc
	NL+cPouvSNyAEmLGRsp7NJRq5euV7z9uqCQZGyTTIMxT9CZlw+0ELJmjoruFfJXsEotrlkO
	cTMGAS+s3T084dv9KSNC+M=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

For ngbe OCP devices and txgbe NCSI devices, MAC should be kept enabled.
Fix it by referring to the subsystem device ID to detect NCSI capable
devices, and skip disabling the MAC on link down for them.

---
Changes Log:

v2:
- Remove WoL related changes.

v1: https://lore.kernel.org/all/7DBD5726DAA21342+20260920085114.1062503-1-jiawenwu@trustnetic.com
---

Jiawen Wu (3):
  net: libwx: keep NGBE OCP cards MAC enabled
  net: txgbe: keep MAC enabled for SP devices that support NCSI
  net: txgbe: keep MAC enabled for AML devices that support NCSI

 drivers/net/ethernet/wangxun/libwx/wx_hw.c     | 3 ++-
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 6 ++++--
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.51.0

