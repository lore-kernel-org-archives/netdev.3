Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C06948F849;
	Mon, 14 Sep 2026 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398439; cv=none; b=b6qSyNGglxaNY67J9ZHvL+wYlcr5d5B3hrCFiIXC38Syisk6ULbZoHMywu4RbaRmQSqUlcJD5NIs43tY7w6JYoZx0REnTMv/m7ebMjxNeVb/5QyrdEPv5md4miXA0s6lKg8sAh5el1DUyhy25A255cBgKSC2e5Hx9HPeylmtfU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398439; c=relaxed/simple;
	bh=8jjIYgaS6s/BC2zL1DbK1rwpuwGyUgQGtinkphztSg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJPshD9t/gj7MBVsn4vZN4PGLhGCgPNIj8i8qbxJ38NCd7FIQOP/Y+AWgG3/T5qfFfC75F51S0wZ6jk+5YMYFS09z3Qq/zIEpVz1u3QLMPxI3Ak8K7jjiZzwv3JpPh6heN2wrk15rnO60S2lKy6GsTC0CJcNSrFtU4P2kr96Zmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RbnH6QdF; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RbnH6QdF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=RT
	v/7kXr0e2/E0RIcc6p/oBQdEnq0quh3XSx4UVp1tI=; b=RbnH6QdFF5tbxJHKSp
	jRkEsUXit8fS82NbFj5dLwLisPzb9ps2PeICOxNtsrwO67AKSNOwxq0jDVC8Tc91
	XMG5vPC8Z4i3vhTnf/oaBT5jXZnEnui1QLTCetEwQlim9hC2k0bz2RKy4noTf7Sh
	JtRafm7ii/Fe5tdWDkC40DMt0=
Received: from hpl-VMware-Virtual-Platform.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDn_3pkDahqCSeIAg--.42971S2;
	Mon, 14 Sep 2026 23:06:13 +0800 (CST)
From: peilinhe2020@163.com
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	he.peilin@zte.com.cn,
	jiang.kun2@zte.com.cn,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	pabeni@redhat.com,
	vbridgers2013@gmail.com,
	xu.xin16@zte.com.cn
Subject: [PATCH net v7 0/2] net: stmmac: remove software VLAN tag stripping
Date: Mon, 14 Sep 2026 23:06:10 +0800
Message-ID: <20260914150612.9798-1-peilinhe2020@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn_3pkDahqCSeIAg--.42971S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF18XF15ZFy3uF1fAr1kKrg_yoWfXFX_uF
	W7ZF97Jw4DAF4jkry7KrnxZryrZasrGr1xtr1DtFZI9r1xWrs8GFs5WrZxuFy8WF9YvFyr
	Aw1vvFy0kw17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjNzV5UUUUU==
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/xtbC0AUh0mqoDWWQjgAA3S

From: Peilin He <he.peilin@zte.com.cn>

This series removes the driver-level software VLAN stripping in stmmac.

Patch 1 is a prerequisite selftests fix from Maxime Chevallier to keep
the ethtool selftests working on platforms where NETIF_F_VLAN_FEATURES
may be empty after patch 2.

Patch 2 removes stmmac_rx_vlan() and the related VLAN RX feature
advertisement.

Changes in v7:
- Send as a new series, not as a reply to v6.
- Include Maxime's selftests fix as patch 1/2.
- Keep the software VLAN stripping removal as patch 2/2.

Maxime Chevallier (1):
  net: stmmac: selftests: Prevent RXC from being disabled in LPI

Peilin He (1):
  net: stmmac: remove software VLAN tag stripping

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 28 ++-----------------
 .../stmicro/stmmac/stmmac_selftests.c         |  2 ++
 2 files changed, 4 insertions(+), 26 deletions(-)

-- 
2.43.0

