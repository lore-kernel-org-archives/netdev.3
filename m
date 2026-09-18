Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011031.outbound.protection.outlook.com [52.103.14.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC67F3F822F;
	Fri, 18 Sep 2026 04:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707086; cv=fail; b=Kd2A22/W032zyuDyGIoZs1QGGRV40XaDduZ12xlOy4hR/CeKUwU2Obd1vQDds2mOrYrxg4qfxfY0IftGyQrxe3WhzB+TSa7FY6rgrbTv4XCt+Xnng5BlST2vCvTwwKiSjLl9s88i2i7B+FbCd+KXGqu4RfSR452xzTDF2Hqtsg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707086; c=relaxed/simple;
	bh=60UCVtho7V7fpxZl2s/jCEeLLZRxDzZ7qWLxPqXVWCY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=asYl6AUeFgmAnZ3zBSD+03yBhLLMhC2XBmLzo+701cIcZNIqqLpynlWIiBm0N/I4SRZInEYrVp/dRNE7LAflfWUuP3qtJ41eewyJWesm0og74Nn8NFUSnyB1nXqWUGqkbNm4vX+/I8pbpLhKxcrmB0qL0W/VJFBCpZS+/bIiNwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sK8D/Xua; arc=fail smtp.client-ip=52.103.14.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sK8D/Xua"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epHOahm6dAFsiOhIap/nyTWOQE2bdqXYHJCUsmhopmcZKx6ljsAaR52nrAat31NAqYWrKRtDgujHiVLB8myKGXnGGfzGRR9BYbSZuA/xKuOCa9TQikjLMYIxYSF39XGQFMwIpijMlSW/Ag5nHkxPNz8fL6Kx/xE2lpWRgi28OJcR9WV23d/JRaIEPhE1vzZbWsOwQd/8UfCDOWn7RM/BARZFQnGioRewGQMz63teuqjeAlGonM+sf3cvkYU7xnez9aOCtBVKgQ5h6KMRwoU4Js2COCZXeP3coECc5/zXlW79jmvtjNPwAx0jwJUZqyIi4g2u3esWESYbsOeH5chOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0ZTHwbMK/7r4hBA9ju7FJt89GnaVF/MzfQl91pS5B0=;
 b=smlPWEKSNEtO/hXJEabtYxjdApKyY8cxC047R3KioMfJ8B5zk5ZeF76YtErfwsyMZ2W06a+rZwkLy4Ejjbgq5F9xBuakYvjvk9odj1wNCJ4AAeb/e43vES5HeoclM69r0I3y2Ky5Rdi1UvnYMZEfeiKo3mRm4t2w9UOdS5nFVPnIAJrv8ZMQ+RSHLgibwSXtso9PnaCK1dZdsgyvK49hyKvu0XtJIK9VVTMNgfNf2f1Mh5YunwVjleSz6oXoO1e6iEFNiEX+QeEyAICaVCtqhsadrw62CVwZ4iy3v1ac3b61D303281TINpv2cYvoSNDlsH6RYpsjK8gdNvMJPx60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0ZTHwbMK/7r4hBA9ju7FJt89GnaVF/MzfQl91pS5B0=;
 b=sK8D/Xuap3I35gXmiWsXxOeFcuVa/bgMya1tqbxVHatw3R0sQFz2PSQfSMhr6jqScWQUibKQWbycVRanLeaScA2J3Q7ilsIYc08FvCHaGNHjSi43Qwct430bwZoiZCdaTlYanyQhyzO0SJCJzTn7JkoIJmwrqYN/aIShNNer4yQfa69vNbI5CEzGwbYMOC+na1hvGpEjW1MM7h029dK/+VWZZv0F2Qfi8+YTRCIYq69Ldp+F6/izh1FYxitKhhN8v+/MzJbAH0QgQojTPL8Xxee8J16rNI9soe66bFlCa8zADSNt3zcDFfp8Ixljyu4aKzz/zNeZ/t7bp5ntqk2Siw==
Received: from SJ2PR11MB8401.namprd11.prod.outlook.com (2603:10b6:a03:539::19)
 by SJ5PPF2FCF00E1F.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 04:51:22 +0000
Received: from SJ2PR11MB8401.namprd11.prod.outlook.com
 ([fe80::ccc8:68f:2e82:ab65]) by SJ2PR11MB8401.namprd11.prod.outlook.com
 ([fe80::ccc8:68f:2e82:ab65%5]) with mapi id 15.21.0406.014; Fri, 18 Sep 2026
 04:51:22 +0000
From: Thomas Karpiniec <tom.karpiniec@outlook.com>
To: netdev@vger.kernel.org
Cc: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Coia Prant <coiaprant@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/3] stmmac: fix ETHQOS SerDes interface handling
Date: Fri, 18 Sep 2026 14:50:53 +1000
Message-ID:
 <SJ2PR11MB8401F5C3A075DE2A0013E063E4872@SJ2PR11MB8401.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MEWP282CA0188.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1d6::16) To SJ2PR11MB8401.namprd11.prod.outlook.com
 (2603:10b6:a03:539::19)
X-Microsoft-Original-Message-ID:
 <20260918045056.4294-1-tom.karpiniec@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8401:EE_|SJ5PPF2FCF00E1F:EE_
X-MS-Office365-Filtering-Correlation-Id: 2037a7ae-0bea-4012-814a-08df15407c1d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|37011999003|15080799012|23021999003|5072599009|25010399006|4140399003|24021099003|19110799012|8060799015|5062599005|40105399003|30101999006|2607281247196008|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MJU2Sg6jfNWN4iNF7aDPrlc+RrHpUW4jYtnYNZs1C7toLJ7S9KleVxQJS9Nf?=
 =?us-ascii?Q?jN7b++pdkYH+nof4+4AIrMw3tm0s0rgAs8B3iNzemoDaS3tmJpMKq6lrRUZS?=
 =?us-ascii?Q?bLbnL3jTt0PA/XXCGv77/jgi4JcASeAo24FhLJcYr6bgVJA+jY37PHO7a2BQ?=
 =?us-ascii?Q?Bh3YSSU5X/IpXIEmze+clcWpn33q2BMEg5riu1dhXYzn1GtKf337CaWMtNqP?=
 =?us-ascii?Q?+kvOxJzpitT4BwpVh3od80ApOF94nVpmXSyWopTXtrek9FlXsIBC89X5fxAj?=
 =?us-ascii?Q?RjIraqzJ2CyUGRWJ8tlOK74cDFh6khvb9nx99djHpvesPIzFE4p8ICayqgJr?=
 =?us-ascii?Q?WjSurOvyq4C/FnB1tpP9D4m/h82mk7quXtXJ4l6QNbaVvTU+eFNcL80CShL6?=
 =?us-ascii?Q?K1nT6cBpJWgqyRlvnRKwpCl3cUPKF1DwsgOqR31DlELKcvoB9UV0tcS+cBQ/?=
 =?us-ascii?Q?G6GjsmKXuZQs6hJ5byo32viupK9TBuJgnOqAdY0lNacwaL5TLhE99tdmMrM+?=
 =?us-ascii?Q?nDbMpQCfmnhQKOOTnXwt8WrJp8+qUE0Rqx3DRorU7qDi/QUHeGpxMAE8MJBY?=
 =?us-ascii?Q?MHnqitkdQXEWuDrGQ9Fdm+g6+IpfP8S8T6AHcNjb4hLM6YqqQejcJaIkY4lm?=
 =?us-ascii?Q?hKwWmP71cT1YKxbG5uLCVpstE/HaUQ7kKtga4r7Oa8+3oSP2BrMAKE/1Yc13?=
 =?us-ascii?Q?cNi0AMkI57vzA0ob90CtX7G+fk/VhjWJoHwLO6v5zxCZbd9w3wFGn8kvrwpk?=
 =?us-ascii?Q?/Hfc1/G5L6yBgcrF3QJSD9LYGM79TQRV8ApHRYWIQMwkm4S3NqUnMk9ajEN3?=
 =?us-ascii?Q?3boqy7lMLjJPFliqggyiNGSvvXx9aRGEvG0SONLNGzxYMie2kI5zQgK0ia74?=
 =?us-ascii?Q?cytyXWYkMD73uDCj4HNPTz508nA2JdtwkdMs5cejCJLyycH4H+WsbfM2JJeO?=
 =?us-ascii?Q?aSQv57rmXRSQF2vF7qolWrs1F6bW9/D6EAZdXiBDGQb2o4KHIdW05vEHBo71?=
 =?us-ascii?Q?TYFoECdHIxmZyoCVXJakiEf32w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mmTD24vNgYcqya98u9dYn3raUYm/yXFlgeZAPvZ9oL8qf7NsRYTZ6gXcMVk+?=
 =?us-ascii?Q?DaWiAvRU0bf0bge8Tn1Zs7V6vi5VjKfw1d3nsaWNoL7YqXtFlE+OYCaCnQPi?=
 =?us-ascii?Q?D2HzMk6NYhUoQTjjheEQ86uNQXhgSQG1XJmoQpPIRSp/bTDVOQAN4U5vLuRN?=
 =?us-ascii?Q?7/UjOhMe2d9kjhsVNWQGJHHjYX1EmXixp4uMyUaGMEctjwSKKBAMOfL2F0qe?=
 =?us-ascii?Q?rxtZv7CR9M7n6UGSU7yDxu4Y/Y+XYO3isw6q7NZZHx6sQqXWXQLYWzp1uOfU?=
 =?us-ascii?Q?PxWR9FqVgTWXBP2owYGLhtNk2A0G4v79iWZMMWYkGxKiqzB6jJlqQEytg4tl?=
 =?us-ascii?Q?8xc5aYaD80hqAeV7iqNfpQm8QkmtbgsDaJjdMmJLZDl+4Z19T5ny/5K4SJEh?=
 =?us-ascii?Q?kfGA1AQA/Qc9zblSRMPwumCjK3d1Z70iIZMB+z2Qcq2pB29ockPhg6+lvusJ?=
 =?us-ascii?Q?BhUV8dOR5rM4xDEQESxSy0g33pv9nyXQCgpMm5eBufqDwqTZLOLOvXGvw3g8?=
 =?us-ascii?Q?Dv9K8aMSyYShRjnVuHP6OxGUhJOs53vaVuQlrGMBfBFqBC4aoJ+NgquWEZ9K?=
 =?us-ascii?Q?JVQNoMoMFL142KJtXJ4PwneeZGbQUjzTfX+N1j3X1EwUfJRjYdoYYs1ucJRW?=
 =?us-ascii?Q?0athmSqEE+zwFk4WK54ERsxTMTaI55nbkaMb0h60T4B1vYfsNWg9LHm/jVX/?=
 =?us-ascii?Q?UvNk0wT8mtF5VQ9+w2RLfKVwp8PeDEL5t1oYdcNazVXue8YK1RJg0kHh1eCG?=
 =?us-ascii?Q?qakAtvdp0tq44aday3oteEjY+tzMyd+ithhLoITxI9cD8840Q39v6Z0bWx9t?=
 =?us-ascii?Q?4d1JYsOkJNr2qMFanLmR3AZ+kO0zisW0F2ISBILrUXHUS0fLIJtdRiEMdBqz?=
 =?us-ascii?Q?o5YgKMSazHShGi8wGm9gZ4tBgoTBYvNVWYC3l57gDzlAzjwlPA/1aFXHfZoA?=
 =?us-ascii?Q?zda4x6bReQWKbTaIfbjpiA18PL44URKUem8uV7R9HYHgnh9FDO/pQ2ZgrSMZ?=
 =?us-ascii?Q?kmwFZ4Ilq8ecgL9K1kNTAD3+LUa441uxhkh5hirOzaOv7r3pr6TGwAQkSI2A?=
 =?us-ascii?Q?HBz8RP5LsN5+jsp2+/0hMCbHjUCl716QY8sWf7ePbwBv27MG+ph9MUKr6kME?=
 =?us-ascii?Q?lj3PpwCpp5MWEGi8mLqG6wHSVQgao5LyUXjTDvkzcchFaV+F2peGd7q+636r?=
 =?us-ascii?Q?T99FCDsFxoo+KFju/KQrW16LiMGXo2BNuOkWyYn8NyGNMexnlkUw12Nkks7V?=
 =?us-ascii?Q?eE5gE4NUvgkcBJxraZ4UA21xeXuGW7UVLDojsAoUjkDlT/z7hUjDYYyOMykT?=
 =?us-ascii?Q?l/JLct2W3uj4RqZOILkmupC1vkm4JGsEZRdH0azf7PH92+xfmINoTCVQ2CRw?=
 =?us-ascii?Q?73gaQZp4gJA/LYzBdRYpNW6CzFqDa9XP3B3I+wJ/5GXHORDqOPcqemt7W6rn?=
 =?us-ascii?Q?GQ3RHY00fZZQSv2qJbtKUG63eCkO+KQo?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2037a7ae-0bea-4012-814a-08df15407c1d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8401.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 04:51:21.9083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2FCF00E1F

From: Thomas Karpiniec <tom@wendy.sh>

With a QCA8081 PHY and phy-mode = "2500base-x", stmmac reports only
2500BASE-X in phylink's supported interface bitmap. Phylink consequently
removes the PHY's lower-speed copper modes, preventing a link with a
gigabit switch.

The QCA8081 uses SGMII for lower copper speeds and 2500BASE-X for 2.5Gbps.
ETHQOS already switches the SerDes accordingly. Add the integrated PCS
interface bitmap to phylink's supported interfaces and mark the Qualcomm
SerDes as supporting 2500BASE-X. Also propagate platform mac_finish()
errors instead of reporting a successfully configured link.

The existing Qualcomm PCS ANE handling is unchanged. Physical cable swaps
produced transient PCS events during the unplug interval, but carrier and
PCS counters remained unchanged for 60 seconds after each final link.

This exact series was tested on an IQ-8275 EVK with cold boots and
physical cable swaps at 1Gbps and 2.5Gbps. Two 100-packet tests at 1Gbps
had no loss. Injecting -ETIMEDOUT from mac_finish() held carrier down at
both speeds, and both recovered after disabling injection and restarting
the interface. The test did not cover a speed transition with the cable
remaining connected or traffic at 2.5Gbps.

The tests used regulator_ignore_unused: without it, the upstream board
tree loses PCS link because it lacks the vendor REFGEN always-on
workaround. No other kernel or device-tree patches were applied.

Changes in v2:
- Replace the qcom-ethqos get_interfaces() callback with integrated PCS
  interface propagation and the 2500BASE-X capability flag.

Thomas Karpiniec (3):
  net: stmmac: propagate platform mac_finish errors
  net: stmmac: advertise integrated PCS interfaces to phylink
  net: stmmac: qcom-ethqos: enable 2500BASE-X in integrated PCS

 .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c      | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)


base-commit: 46bc52d13594848023e681860df8700c8db14354
-- 
2.54.0 (Apple Git-157)
