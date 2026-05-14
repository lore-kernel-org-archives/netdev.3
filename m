Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF89374722
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778754868; cv=none; b=UkxHxJ5lMqiT9uPAQjXN5u+by5TzVeU9U93hT/2rbXBm2RHCqdQMVQeW3WTeEE7RS0qKDQ7hGvo+cJ9mCfOBkCKhx4yI7We6XLv/hm+31xoA1IeJx6goEiRhwQESC+bAic0Hk/llDkNf2TZ6uLQVQviGDYwDEBG7JAlAfF+MEpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778754868; c=relaxed/simple;
	bh=zu2aFCkg6khl2BatTAJcL0q+7/03t9rjhT9Wjfi9r8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pQYYG5cezfUQ3PJo+ihdhAgHatFc6L1ZKsJvP3TuPYCJHg8FfqO0lDmgmQE44OEZv/XF9ygQilSdSJYhGy5I1J00bT1rbmZEJ8PVxkjP/vhlz58fPZZvW3PdMFbQq+IqtbgSjrboc//MCbPzLCbb6HfKVqeAhZURVfT59j58AZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz12t1778754851tcebb5b92
X-QQ-Originating-IP: CHsYnUc86d88TEEI43ts3fJtBo0W+NJy0Mgz43sCeXU=
Received: from localhost.localdomain ( [115.227.149.194])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 May 2026 18:34:09 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15072289865051823410
EX-QQ-RecipientCnt: 4
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 0/3] net: libwx: improve VF ethtool support
Date: Thu, 14 May 2026 18:34:02 +0800
Message-Id: <20260514103405.42175-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Nj5kRNzaiqTLuQ93MLhUTLzKbOxIeT1PqOdTIWSJ4qtk/mgsLMTd4+Wm
	ZgWdSBPqsIujtAnCN+fbHt+cRfOhRnvxnLzTguI0l2sv0lUD+j6jDY1UHr4ciQtfVvgUpB0
	B1G4TOc7ZqanciV35U9Pba1tVG38CVtTbbdPK13t1PBd3KIarBEmhgpZ2WQsfhAtXcIYOR9
	hp74Ml1xyMDvbxaQ0dOlE14rR5uUxTDi5Uz1QQW37xSfjYwvbFYUJEcukYJfDi2x06eG7N3
	ynbboizHwjsSgTm4vkCKaKGjJOiwExBgdddJrFlroQHN+ExTpwaShXFHxxoXqfhS7dQX+Cn
	R1IF10KKHP0gDqaEm9xGf9+Mo72fr2cEiEBYpf5wFw4yhm7pEcngY0jlgf/EuNpW9Z1OTmK
	fH7gbdJvZ99IznmkQ2V+bEz9wdbaVxKo1K5fH+5sKmkq64CuFFLAvIMLIjoZhGNuNdEkB3l
	EskQQeWvKtrqCTZqeWLX2f0JXdeoiu6ylp1E3FBfncRgL2t2FsEMBPcaoJaUC7OkNlAfwUl
	rMS8yDclOYffwKx9djF72GSDD9QBEVkAn48OuLwLoL5SE0X+Lr74oOmAf0Bqx1UsvyWV2pI
	wUDZ6YmtjRDW3R2vtH2VEXDhYwLBC5e11WbKzppO5TymO829ZHhKxt28juw207STY41o4nU
	wyr36JDJ7khw6beDuW+SQMdAqNt1jpBndxs8FZ+z252p9Mo6TcFulGiKLPZ5IzQADi4zAMT
	vOrnc5RCIeI9TU+dzzffDW01SqrBqI+zNuP3B+w9zWpn/Fr1hX7giJEcTMK4svc3Wo/uDsP
	qcOvlgv31P6aDn0aIhXCtloIDMAApk1TwWzgqy0zHruAQPr3zCIHa+/sf10peaW4ct+Cbkq
	hJ6ArS9Pmry1gUYdg+tb3S8OWY0PH5YitnpNPo/6UYIsfaltOzmvBd01HGfAAx+Y48MD1Vr
	pHHxogEzdRR6A0pbU9zIBetV/s0acEdoeHW9G87FX5dtBRu/6pRW71jSIF77M7tSHUx/DFo
	V2j0E1yUxoGBY26Sk0oFsjHt/S8FzDNjnXrjK7eawnB66q8tPrWVvl6audQ03WB7EJuJIT4
	WRaYC6jsBTlVveqWRBR+duDG4JgLYowtmxbMe+EArU+8k0NROS//vgRY8+SR0qC3oEblUH0
	U1bbkCPacc4al9cT9jGWnOKb8w==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

This series improves ethtool support for Wangxun VF drivers
(ngbevf and txgbevf) in libwx.

This series extends VF support by enabling:
ring parameter configuration via ethtool -G
interrupt coalescing configuration via ethtool -C
hardware statistics reporting via ethtool -S

Patch 1 adds support for set_ringparam in wx_ethtool_ops_vf,
allowing VF users to adjust TX/RX descriptor ring sizes.
Patch 2 enables set_coalesce support for VF devices and updates
EITR programming to use the VF-specific register access helper.
Patch 3 adds VF hardware statistics support so ethtool -S can
report useful runtime counters for VF interfaces.

Mengyuan Lou (3):
  net: libwx: add support for set_ringparam in wx_ethtool_ops_vf
  net: libwx: add support for set_coalesce in wx_ethtool_ops_vf
  net: libwx: support vf hardware statistics

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 102 ++++++++++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  75 ++++++-------
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |   7 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |   2 +
 4 files changed, 140 insertions(+), 46 deletions(-)

-- 
2.50.1 (Apple Git-155)

