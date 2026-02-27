Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C036C36B05F
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177782; cv=none; b=isVDNljXsqS/cIddMmYy8v/CWUL485OHJmoy0PXbg8MkYGqiJffdgGC9B1N2HZCGKO3N12dPGpiqkjtlNudA8SvaViIzAIQCQsd2LCsi19m7Fd9SH2Pz85PK5/c27vyN7o77nzp5wV/Aozh5CtYuLsrm68kpE5mhAB8n9gBzukU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177782; c=relaxed/simple;
	bh=Jw1XhYLDNSR0Nr4+NP1PlcH/5iPdGP0nIkbPwhSssHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V591YK0HOFoSB5b4ncKNUxO+4ydkL3q2IxDfeGI3wcFqIhVDZadIWYC9RIardAlEKehATvpebVL/tcynu9Wp2VJr/Y2Ibh/rAYJIPC8AqL8xpxj94Dh9ONvBj6JHh+fLCVqo2Lu3ix8HBPx1UR0AM8SwQehAsatlOP1IuOkBIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz16t1772177701tcb41d4f0
X-QQ-Originating-IP: MazJCrCZ79JcyyV90dvtLqJDNb+jL8fBFdgZKsaIJZU=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.96.164])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Feb 2026 15:34:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 673454652899439808
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 0/8] Wangxun improvement and new support
Date: Fri, 27 Feb 2026 15:34:42 +0800
Message-Id: <20260227073450.23680-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ODcDgdcDagQKV6d75oh7KZ0m3+Qt96zkdEJhtEdppKTuD9n4LNzsrMoD
	Sg1MbnCLljJgpJFON5tLVv4A1x9jxhGuHi/qef48hxuf8upVdn1rx/Ol6jmGBzu0EBHuv8x
	gu/dHivugY9VG4Um1EWyTIT+qvMNodzc5GM//I5AeCqrWtIYFbFgSeJpKTLpfh9Ib2KFFKK
	87NDY9SQD5MKOMeGBLoRGD79U8+91/KJLo5e565ipxz5QzsyfCRftJcQjU2Jq4oQ1ks2VjR
	Sbp9rgSj9ime7tNT408TpMDYkod9wA8R4pEbpS1QUZoZL8GwpPlCpoz/UrGBftuCwxlDXOd
	C6CUD6GwgMrpvcSvuKa4agLJ4qrNsFtMbvS4lT/iHMkIynz6a8nMrZgoPJuDxC2unqVrwON
	g6JOSbuggM9x+FF807NZuIxQTK5hIDcQQ0fPGzzNvFmtIMwrLZINR70+HQkzZeB+IAX8PGg
	uAsMrEbogj4CxTkSZNQbcjt78hCvecsjC3dzdNZGBaQ3aUn8QercmIHGav+gq3jL3/k8wW5
	ZfBv06pQAw5erCJ5DP2SYn6/4HaGqB5itfVEKFo84pqNoYkLGIYfGCf2WF0vzhihTR+ASlh
	TrPomQkV3nsIzSUnvii65EHeLdXcGfKkCa7obtaQQQ3mex2XgncapQj4fX5PAlNqdeSE5Ez
	AR3tWxfBZXptjN6hLPELLrXJNdJ5CrnFsZpOkSQSd+5bfuYE5G2Nng9QMKyuk0IQW4ihUmt
	p1vH9kfA4gFL9tSN9mws012euJuHJbHcw1ItPEXlPZO4Ffn7bf+/3f3aHIa5tEMI/fJ1c2e
	H/AE8tEkOATjPc6+UVebKlX28mBEB2vkklUHL8zfNjsLvBVpToN8oINWPqKMK8OIO2aqJJp
	1rz2AT5a8YbcSsmHVJSOUPVDBkBPITHAnIknplq54h6dBp/cPeh0oSYQxY/gFo9XCv+o8OV
	vnvC7s+iN7Ca/Lr0eTOgYSsnWIiPwDcBHUZ43lGEcuZlbO/WP6OVzjvHJCvCiAT9bc9sRe5
	Te/7Rfj5cE14bYvl+s5tiDA70gWFlF5bhtIcEI34HUxjlqMO8av7wGUhDBm0cos/sJB9Qt5
	Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Implement power management function for txgbe. Clean up the same code in
the two drivers, to make more use of lib functions.

Add Tx timeout process and pci_error_handlers ops, to recover the devices.

v2:
- Split NCSI changes from the WOL patch.
- Properly return and handle error codes.
- Fix the typos.
- Remove the check for PCIe errors and subsequent error handling, because
  aer_recover_queue() does not want to be called by the ethernet driver.
  The discussion link:
  https://lore.kernel.org/linux-acpi/001c01dc9740$c7722540$56566fc0$@trustnetic.com/T/

v1: https://lore.kernel.org/all/20260203075759.5852-1-jiawenwu@trustnetic.com

Jiawen Wu (8):
  net: ngbe: move the WOL functions to libwx
  net: ngbe: remove redundant macros
  net: ngbe: improve the reset flow
  net: wangxun: move reusable PCI driver ops functions into libwx
  net: txgbe: add power management support
  net: wangxun: move ethtool_ops.set_channels into libwx
  net: wangxun: add Tx timeout process
  net: wangxun: implement pci_error_handlers ops

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 224 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  16 ++
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  38 ++-
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   4 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 139 ++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  16 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  52 +---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 198 ++++++++--------
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  19 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  17 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  74 +++---
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   3 +-
 15 files changed, 583 insertions(+), 227 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.48.1

