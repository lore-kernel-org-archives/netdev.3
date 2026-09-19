Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF4940B38A;
	Sat, 19 Sep 2026 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789822765; cv=none; b=tefDAMCcJ0EUgxsQ74wVnR5qbAesg6uN3//aR2lukUxhy/KjpsZsrDxT4Sp4DNZZcZVE2Xpdsb6U3G21ITd6oMUjwzhMaC6HRRII3IghQYLLgGLVnlYua44QrBFh8e0Y2azSnyPK93NVRuneFRW5E9t9xVJVoOoYJTp6/c6SgQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789822765; c=relaxed/simple;
	bh=4NrAV44zdZr/Zyrro+oi2hqS+C2P/SLRcv40koMnAOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1hXP7AzciHR8QwnIRkesWASCUewuuEt1D8sRyDKkCS1NVM1k+kCeOpskJ7QYFYtmlp1m3GSgCM6+9OJ2+w5svztbK5w6FazCyCn+7ea1j/Qd0xVL/sHxdWWjC3+eKKIi+VYGu8cqe44yH1E+DhmCCgq8P8BUjlOa12VkspKVMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NG7zgMDP; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NG7zgMDP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mw
	gFbXEPvXREtvKOdLyewIIxAEW+prXX8zPZmbR1mw4=; b=NG7zgMDPNqYk7Pf+hR
	W9fb/+Ur6GzReJqWvPCzbTSb/x7lnkdeU1Ez95jGTM3us70QXo+KpaHPMwEh7Eb4
	8jAVtkiGzt+Amm6hLCVtT/Kpi72FmDmD+DlwvXe+A5jLOj2XyAaHsUPA5YP3wz8U
	MK6T7O6J806wnz0cZXXjoAE2E=
Received: from hpl-VMware-Virtual-Platform.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wA3Rprlhq5qpMqHBg--.54511S2;
	Sat, 19 Sep 2026 20:58:14 +0800 (CST)
From: peilinhe2020@163.com
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peilin He <he.peilin@zte.com.cn>
Subject: [PATCH net v8 0/2] net: stmmac: remove software VLAN tag stripping
Date: Sat, 19 Sep 2026 20:54:11 +0800
Message-ID: <20260919125413.18058-1-peilinhe2020@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3Rprlhq5qpMqHBg--.54511S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF18XF15ZFy3uF1fAr1kKrg_yoWDKrXE9F
	W7tF93Ja1UJF4Y9Fy2krnxZ34fuasrGryxKw4DAFZF9ryxWFZ5GanYvrZxuFyxWFWrXF98
	A34vvFyIyw1fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbPC7UUUUUU==
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/xtbC8gYh0mquhub-0gAA3O

From: Peilin He <he.peilin@zte.com.cn>

This series removes the driver-level software VLAN stripping in stmmac.

Patch 1 is a prerequisite selftests fix from Maxime Chevallier to keep
the ethtool selftests working on platforms where NETIF_F_VLAN_FEATURES
may be empty after patch 2.

Patch 2 removes stmmac_rx_vlan() and the related VLAN RX feature
advertisement.

Changes in v8:
- Patch 1: fix inverted true/false description in commit log and mention
  CONFIG_VLAN_8021Q=n builds.
- Patch 2: drop Fixes tag, fix trailers, document user-visible feature
  changes and EEE side effect, tolerate in-payload VLAN tag in
  stmmac_has_ip_ethertype(), and gate NETIF_F_HW_VLAN_CTAG_RX on the
  presence of VLAN ops callbacks.

Maxime Chevallier (1):
  net: stmmac: selftests: Prevent RXC from being disabled in LPI

Peilin He (1):
  net: stmmac: remove software VLAN tag stripping

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 38 +++++--------------
 .../stmicro/stmmac/stmmac_selftests.c         |  2 +
 2 files changed, 12 insertions(+), 28 deletions(-)

-- 
2.43.0

