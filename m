Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011014.outbound.protection.outlook.com [52.101.125.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAC6250BF2;
	Sun, 20 Sep 2026 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789918560; cv=fail; b=EiS4x4J6il06DVNPBnEZsmfRk+SSpIAevTroPw5A84hKUzKEm6XYs310C4wWCG+e3DcXDD1E+yFrAzFHxBQdK3LiFXGe9vSAPuXIBpYGDxgYUtKdj6mCOxwNLqNCMuatb39ada0Bv00eWcy+5dD0gZnBiX0GnNmtZD9Kq3AzUhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789918560; c=relaxed/simple;
	bh=PmCIeWXMqvMT+DiBe3bdUeo+JHFNaossmOpnBx7fgVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NqV18/R3ZxadijoKORI6ISyTgW3/uvGZveV65kBONk05IwQSmjksaHxnDoGfhb7/of+9flbQHE9U9rcSdEk9kvU7QIo1QPdeGbdVCfJAKCl9AtPKHhdz5QeMp4anlZ5rseBZDB9W+eQeJxS6PSj2xAj2dqRVGswYxIMsuSMcf68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=N9Te4Awq; arc=fail smtp.client-ip=52.101.125.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="N9Te4Awq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTUvgUP6iGkwaBVNRpf+Npv9a2xWMbpANYtquwj0SVt6ljvADVbJRKYOvrqNZ59si/jza3Z0bUS73zDiAR/uddgeGEDgZDBAn7HrRWXe6BSuK/LCcfzX6tY4HehDQXmzWVQ/EY7iU8xuR4V0sC3bLF6QQ9KJuchAHOWHntH63Hjvq+Dlj8jMalRf7UXfQuNZ0dIa7LkZOKwCdyfOVMRv6XPdcFaviwH3yLRu2h/7Ui6GO8tda3of8yMc2EYGWrW2UH7rXnDpEcBOBy2ZgoILWwajKLqCmX+IlAXvhGDF7P3G59MtC7MoDOV6IVIZ/J8Mj6SzhXzAMEYURyX/Nq0YdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH55VEjQfnK0abO54FHfx6XEPd/WhB2whHMqj5OTeOw=;
 b=crxcrQ+nvhxMZfTc3kQEv8e8U6HC2aVALXrIlRFmeMJMRw1qCVJB5xG51MNq5C1jkV/k2mPsQddRrnKvRlf/ciQAU1OU1k5+9jKhRaY/btcJKX9aH+qfmvgQuukZL2ggsN5iro5O/SCtsZkeWOaxvG6ALvE06b23FXV1aJn3dbQE/yLxBIQ3mmsn+yu6s3Ry5QkxV7wUCSHApaPAaWvrLuWEB0FznwjfdSRLFcRkElqiC/3+nFKGFunETcczxWXulbWD3Ewv8PGlsC7mhWxAqHd7O1i9PQ0at2slfa3/2gl3S6KGE2+bMpusscIDbOpa/cho+bFaELLv2hJ+Z3gPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH55VEjQfnK0abO54FHfx6XEPd/WhB2whHMqj5OTeOw=;
 b=N9Te4Awqmop70jnskRDMkyIne95ypz5fDN5kNbJ+/zAI3uUK081ysE6SA1P1uoeNp25oYSUyGw96E6cTqmN8aq1Z64BO5ZhKONtXmYAv4Akp2JRwgo2MdNTdsxUIisMkCxuGIfMmbEWidAf12beSj+9pXrrhEi3gUXipBeKF7Ug=
Received: from TYCP286CA0117.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:29c::15)
 by TYRPR01MB16359.jpnprd01.prod.outlook.com (2603:1096:405:13c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 15:35:55 +0000
Received: from TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c:cafe::3) by TYCP286CA0117.outlook.office365.com
 (2603:1096:400:29c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Sun,
 20 Sep 2026 15:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005022.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Sun, 20 Sep 2026 15:35:53 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.22])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 7C2D730000BA;
	Mon, 21 Sep 2026 00:35:48 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: maxime.chevallier@bootlin.com,
	recv.jo@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	jun.ann.lai@intel.com,
	yi.fang.gan@intel.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH net v5 0/5] net: stmmac: Fix double VLAN 802.1ad tag handling
Date: Sun, 20 Sep 2026 15:35:11 +0000
Message-ID: <20260920153516.103461-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005022:EE_|TYRPR01MB16359:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 57f54db0-6b58-4a99-930c-08df172cdb7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|1800799024|36860700016|921020|6133799003|13003099007|18002099003|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	xAIhMLCt2qwWjDlNMUl8yiO30q0iVnyE+FHOFJFCPtvULvln6spSg0MiK+5j+FwxN9O2RHBxU7y5VY3SIY64De4vaJUqFLXDH7s26CEiHTbeXuvQXxsAQmaubgo+QazL7bAR1gaZ/zoa4kSwP55p2Khqx2ji9c/AbZo0obIuwI+35AjnINzdzFjnkn3riafOU48c1Bl2jClfpg5mKiddjKsbDFejx/rpFjPvosVcAiNSRD2y8Eu7zMzVw3mRxKnsPPwKdQwmyldnr9L4U9EWZHOIRhIbiRRYbYIVYICohJq0OVoDdgP9ZezdSxvgpA/EYNhtF2AUs5pTY0ThGTi9GIYdlUuo7pGvHbALxxNLxDyAs1nHskKeaF+GUU4GCC1ThjmovI1ulLda3/JM8DuMjCfvtX1Q9F0daPGNbQUNNiOcdkhWR0U3uc6lsgieNerXy4AvjIVE7hgn1cdfFx00ZXNlm9jLVNdqWceWp+1TPyEUX9bvTiZDkPW9f4wIOID61ThGDKBrCkaQxZ5p6pO12cjGv40B34VoeBBOGiHfw5lKuPcxQb2Ash5SGG+SVanKv/gc4ajVEy1u/i+pHUdDHI48tYQUClZnaRpV+NVemBxiU46L2qyFZTQ7b1BR+ErT2qKH+kcAjPpd+3uM60PvX7YSxdFGEBzzdWDYx56krbKJSbVGJtBRaEypNCMBeyzxmXLbW4m5GTyHdmxY7+Hy8qlgD4epUYPRWTRogcDksrHNYhI0QYio7gQc5T0xH6pe
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(921020)(6133799003)(13003099007)(18002099003)(56012099006)(11063799006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pTpwPOCsDsTcSUfmJ0HtOE/nIBJo2c9xUfjxG57aw4/MkKXJOK2pCEXOEdeJvgKAIK9HEB4lsS3rbZpFFxbWhaEVPFqOW89MD9AUZqboM04EqmOYi0+wShw3+JwdoHlJ92bH2ip9dt6l0yB+eYunfRsmUDa1f2BmHqFkb1Yr9OqSh494mBbcX5YEvj3fPvpbI9tB31iFx/j5EBNPyRMHtzgQzS2ImGl447pckFW8w5LZ9RDf/icRuZZd2MArza6OxBsGgynpSkj/WVWIy2FYtistDsk6OLbR6wfhCUcU0ZtOLCiT8EasHMwqhw/WZZPJ1b9U9VRE8JLtvL8/ZUkPaKhw5PQHNsTlW0ClGvuIgm7yvkTMNTgDKTlvXDvxPC10JOghDpEYPf7UsJpCeEO5sehXTrouMqal1bEb/w3NRGj0jcx3sBYNtYYhcsGikFMk
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 15:35:53.7845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f54db0-6b58-4a99-930c-08df172cdb7d
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16359

Currently, hardware VLAN stripping is broken for 802.1ad tags. vlan_rx_hw()
hardcodes ETH_P_8021Q when putting the hardware tag into the skb, rather
than using the actual protocol from the packet. Because of this, packets
that contain an 802.1ad outer tag are incorrectly passed up the stack as
having an 802.1Q tag.

This issue was observed on the Renesas RZ/V2H platform (which has a dwmac4
IP), when testing QinQ ping:

  # DUT
  ip link add link end0 name end0.100 type vlan proto 802.1ad id 100
  ip link add link end0.100 name end0.100.200 type vlan proto 802.1q id 200
  ip addr add 172.16.3.2/24 dev end0.100.200
  ip link set end0 up
  ip link set end0.100 up
  ip link set end0.100.200 up

  # Peer
  ip link add link eth0 name eth0.100 type vlan proto 802.1ad id 100
  ip link add link eth0.100 name eth0.100.200 type vlan proto 802.1q id 200
  ip addr add 172.16.3.1/24 dev eth0.100.200
  ip link set eth0 up
  ip link set eth0.100 up
  ip link set eth0.100.200 up
  ping 172.16.3.2
    -- FAIL --

Note that this series only fixes the issue on dwmac4. dwxgmac2 has the same
issue but I do not have access to hw to test on.

Since dwmac4 does not expose the tag type in the RDES3 descriptor, it
cannot support hardware S-Tag stripping correctly. This series
disables S-tag stripping for it, so the 802.1ad tags are left in
place and are handled by the software VLAN path.

v5:
- Split out the selftest part and sent it separately for net-next:
  https://lore.kernel.org/all/20260918112529.96039-1-ovidiu.panait.rb@renesas.com/
- Dropped the S-VLAN rework patch and replaced it with a plain
  double -> svlan rename. Rebased the patches that depended on it.
- Added Reviewed-by tag from Maxime on patch 5/5.

v4: https://lore.kernel.org/all/20260908164309.59282-1-ovidiu.panait.rb@renesas.com/
- Reworked the S-VLAN patches based on Joseph's feedback: EDVLP is no
  longer toggled, the "double VLAN" naming was dropped from everywhere
  along with the is_double implementation, and ESVL/DOVLTC now
  follow the advertised NETIF_F_HW_VLAN_STAG_* features.
- Added a patch to stop advertising S-VLAN stripping when
  rx-vlan-offload is disabled.
- The VLAN selftest now also toggles rx-vlan-stag-hw-parse for the
  802.1ad variants.

Ovidiu Panait (5):
  net: stmmac: Remove VLAN perfect matching dead code
  net: stmmac: Stop toggling the EDVLP bit
  net: stmmac: Rename double VLAN references to svlan
  net: stmmac: Do not advertise S-VLAN stripping when it is disabled
  net: stmmac: Disable S-Tag processing on dwmac4

 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 60 ++++++++---------
 .../stmicro/stmmac/stmmac_selftests.c         | 30 ++++-----
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 65 +++++--------------
 5 files changed, 63 insertions(+), 96 deletions(-)

-- 
2.34.1

