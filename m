Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCBB56855A;
	Wed,  9 Sep 2026 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966116; cv=none; b=O9yunECzFn4avJ5wYbLzfoX1bHaQjwPc2VqJGoH5yAu60OM7YQVpu8wMbj8+45YBxmOb7HJK2pXJwI2eYHnt5Ief7z1SEy9+wu+neEXsXrF4T4M+zqqg2os1xSkTeJM3U5cGnGgimoJdPjmAQHFaD4ap1b16DA7Pe/DWI09X06U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966116; c=relaxed/simple;
	bh=8o5IuNPcS4vEpWEH/wC9QtYUpgdzhYHhnfWvIaXixW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EdLNf0M1lxEdTVml4SPK+tYF1hyoVDNYMQ/wQVUNwpwPlkUjGxQbTGG0zqgHU4qx9kQDuHx1hERYeKlESUN73OyqzWUYmhkUhlbhZ3u9aEm1J311rKQQqnYRmdfMtsIjUFkITzYWD3EbusqeodWm9dMTnzIlywiKzcWAiVVAblA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=qYwErq8s; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="qYwErq8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788966088; x=1789570888;
	i=markus.stockhausen@gmx.de;
	bh=ZpcG7zjlf/4nl5aweyEgcjrpv5KNCfHN0hpqtQE5y/c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qYwErq8sulW95EfXcEP7+L/Crj+ZuEarc3Q/+gOLtomwPGr2MmclvJeRFuYRiXpM
	 OqHLoLQQScXhzINhVeko+o86GT3E7WQEjeB0t56hrsD03VgfNBqAT39eNgPEuCyVm
	 TxEed5dJTlTmYqdAyCwGCBDLKqu51XUlh7M4y+oYhpu2CaZcS9l8xAmLGFmTyFAIb
	 mWgPYVnquOsfKUBON6XaBFS0pR4vHlFN0a7cIwnDDcps5tPgAsmWJinzWo5BMBeQz
	 ofwlyAwvXWweaynC2oMsusLTKTqhtA22IkUi5WIRQ1Jo7T3KyLWWsSebwoGlPqqCX
	 f/lfOFLh98V44ebuJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79yQ-1wldlr3dEK-015HsT; Wed, 09
 Sep 2026 17:01:28 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v3 0/4] net: mdio: realtek-rtl9300: add bus frequency handling
Date: Wed,  9 Sep 2026 17:01:03 +0200
Message-ID: <20260909150107.3602067-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bYu7NeoQv0yEnAsvGoQn/2UHcxubrzo412pa5+uWWMqVYcLuosF
 SvCSFfDDYj3lOMSEi0kTSH0MIf8YK50YgBgXEVZutNiAxXGMpzlwDZJ40Ffgk2zr1eSYsF+
 4bC4lOG384XoktCv9NL8izOahnehDR9ya8E0llxFRBJC2ypVx0t2ZhS5L4PcLNMrslnzVCr
 6j8ApsFDNBWogGdWhZ9Mw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wptUCQrtDMo=;Xuf+ADgdkZNzNAWbvRTVgShqHQh
 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
 ytRRWcgx4Vi7gmhroNYig6w5pw==

The Realtek Otto switch platform consists of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

All of them support changing the bus frequency of their one to four
Ethernet MDIO buses, although the available settings differ between
the series. Extend the driver to support this feature.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
v2 -> v3:
  - Add Acked-by for devicetree patch. (Conor)
  - Andrews Reviewed-by not added because of Sashiko findings. (Markus)
  - Add patch "Reject duplicate MDIO bus" to harden the bus detection
    and as preparation for the RTL839x frequency setup. (Markus)
  - Rework RTL839x frequency setup to better handle missing/default
    frequencies. (Sashiko)
  - Use for_each_available_child_of_node_scoped(). (Sashiko)
v2: https://lore.kernel.org/netdev/20260906081946.3499898-1-markus.stockha=
usen@gmx.de/
v2 Sashiko 1: https://sashiko.dev/#/patchset/20260906081946.3499898-1-mark=
us.stockhausen%40gmx.de
v2 Sashiko 2: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906=
081946.3499898-1-markus.stockhausen%40gmx.de


v1 -> v2:
  - Describe per-device frequencies in devicetree. (Andrew)
  - Add proper per-device frequency checks. (Andrew)
  - Use the initialized parent device for dev_warn(). (Sashiko)
  - Make clear that otto_emdio_probe_one() currently has an
    indentation issue that will be fixed by this series. (Andrew)
  - Throw error if RTL839x devicetree has different speeds set
    for first and second bus.

v1: https://lore.kernel.org/netdev/20260903122119.2638354-1-markus.stockha=
usen@gmx.de/
v1 Sashiko: https://sashiko.dev/#/patchset/20260903122119.2638354-1-markus=
.stockhausen%40gmx.de



Markus Stockhausen (4):
  dt-bindings: net: realtek,rtl9301-mdio: Add clock-frequency
  net: mdio: realtek-rtl9300: Convert "fwnode" left-overs to "of"
  net: mdio: realtek-rtl9300: Reject duplicate MDIO bus IDs
  net: mdio: realtek-rtl9300: Support non-default clock frequency

 .../bindings/net/realtek,rtl9301-mdio.yaml    |  40 +++++++
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 110 +++++++++++++++++-
 2 files changed, 145 insertions(+), 5 deletions(-)

=2D-=20
2.55.0

