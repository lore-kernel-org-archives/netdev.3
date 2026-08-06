Received: from outbound-ip173b.ess.barracuda.com (outbound-ip173b.ess.barracuda.com [209.222.82.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A5E47FB01;
	Thu,  6 Aug 2026 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031638; cv=fail; b=ENlVpIg0MjYekSXjwtCHb3XwM/d0PX88N6CdV+mf6bOrhkqarPpK7D83Osps98yaNH/mYxlCfdfAo8o4kB7rerQ1diFFc91/zEyEh0l5wdc2rV4fyfJSrYqiUZ7TsWSV0XDwozLGuiWcwBVb6XHZXj1WXF2mB/1fbI9dNnWpkbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031638; c=relaxed/simple;
	bh=6DwSuEUcc6D/epz9hpgBkmFQifwZfJP7DTbVcYohXH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NKo2SX8y8NZs+4u/M2HklAcRsobMPv9m6uIkCfgdVFVlkAnkygNsqFhgc38P7qM0dJGXFFuXbXrwxFEZUwLZ0mKQDaT2s52q55sPB/+Vs7vFJVs2Ro9MZhAtI0gO4aKr1P1HjuQIkKwRCX13P1CfUhoa3VjBoE7I4Z/j7+kqR+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=PD5w2cBC; arc=fail smtp.client-ip=209.222.82.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="PD5w2cBC"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021115.outbound.protection.outlook.com [52.101.52.115]) by mx-outbound42-229.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 06 Aug 2026 15:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sl8PHUk0YQAPzQ93vP2j3EhSvYRh+bs/T7jgtRdGrntvj8Ce0kb2YdafqBjmyiATxpZCjQIpXFpFE/jeDUXIHOarlaG4hmXjJOUsIBnytHOt4AHxN23lPII/y+6c3h3EW6hpJzE6BZ0//z81/o7jcWJfgNiFsEGJ76gwSjxkmBsY8G2OnOyHrJHVPv1kFzmjiq3iheWT7mO3kNgY2CDVdaqA9KqcdsWSo63JXZJkMCcGiNRGMSKgQ/Rk5bdv/ZOHwRoHKV9jA8zNBDJGDHJ9xzUBSz/E0nRUnffK3agvqLLfChO25gYN6ioOk67mQCtwDakjnMisH9kfMfWEMzfP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlICyOGc4MInRat4xsn5W3hLBpGkdBnDqhnpxxhRKnY=;
 b=qr3bVd6EO3UlNkZWN+SNBGIt7CY66NYHyFdJxI5ngDaPwkoaLT0aGNsRJoJu/EyfzMR9dENV5oUsTXJHtUtRDworvqy+R6h50McNNIaZpx7TsKdCxPV44ag0gFiFKrhSdP64RFnYFpHBK6FUREqgwGw+ffHTGG8D3tcW0YKiW3HuHaJ7U3JPmfDgjx+AuL6rSZ5QQs28Il8u3ggvf08Ag/MH8ns2R3gkRbHftweL1bV6ReIBpjtO0pM8D4hji/tc4ch5ctRtGjjO2LDkdssEYERd6PBPrjuANRM8jypoWjvlZ1+3nVPMVfkLMu9xB7WC9xv43F9ihIeGsi0lc0EV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlICyOGc4MInRat4xsn5W3hLBpGkdBnDqhnpxxhRKnY=;
 b=PD5w2cBCtJUb66QX6ba66oQEkHOL0zC/FBim/eXk1P1zlaooMGwKP2juBl8GL6LK/BHIayy/lVA3XgY6a8DUIhD5knLgBzwAu5CfUv5G8R32bMJSGYDvn/DpL0zqIkME5PbfL70/MThptNnEOuty6vY/BTvDETdu6sMkgfFefBkg/UJ4n6fXX5e1F9rZiJPt5+3A19aPGqlqQO6jiQMS/AO0aECARX7c0oMh+UszitfAJMX5igNWotRngMVIX0OXFA4SIYGa1Ao3BodhcJC3zNyas68PL5oh/M5XCLpcypVD6lRPVoYelpblylRVYrMrUcyKUmjsclv1Bd2FNDvqgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Thu, 6 Aug
 2026 15:53:04 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 15:53:04 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: mani@kernel.org,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com
Cc: johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next v2 2/3] bus: mhi: host: pci_generic: enumerate IP_CTRL channel for Sierra EM919x/EM929x
Date: Thu,  6 Aug 2026 09:52:52 -0600
Message-ID: <20260806155253.3378294-3-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806155253.3378294-1-peter.hunt@opengear.com>
References: <20260806155253.3378294-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::17) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: c81edad1-8954-452a-d085-08def3d2cbad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Lz1Og1Glx+txen6P25ZjQT8SPpw11DPrB1IfHG1u2yiRsTs5zkgfxfTRkabJSwyOw+JRIVEa+ScnDupfpGvi/0VPbqLhus2/IRWnDES9YI5/EaeLpd0hXplDqevDk7G0eeDVen47GYPQAJoT85Cp4JHIzH8lDS3KBNDtObBOTCHEpXYlwtpoL0SBbr2P3bAccmdCGWqzH9SgDRPQ9mlj/RgZ7D32boDtyi+Wvcg8XD4LHUhcPlyRSQR1H3LADX7j6EGGtYdMLG/Ly0ZOTGnRBD/jQuHexkdC1YQLLfg21Z/VA+0OXrwI9o2fbr2oDhZ2GRUFEOTt8QrSDjdamT40Ygq3O7MdDVGGZHEhnN/NMUm4KsiX2mRJxK+/iMyZk2cDGnofI3DNzVNybaaOjmeO0I6+zfqzqOC0n+IM0JpzVXA4nuG+1vu/yMTAQLJf6f8Kr/kGR4pBBeb41yI8TegI0sv2Jb5FjJc81rexdjBWBvfUIFToEx0oZSs6WvAGqfmWFeSHZTtyvjBCq4aLzxQoV7Qv+Ps3+FQKMW8EsF2La2UOp7aQkXzf6iosQmgcVhUOrm6QL+dR4kZ9T9Qw/Ff5wiOPpGS4aqWedsqvoLkWn/HGJwoIc394p4ZYQTG0/PJDk7qdwVYrg3nL5R89FMGGbdLkwSm+f45pK/WnydZ5JhM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+JS+cGN2DMaFTUC4rKwdGi68vElO/hgKQa+cT3vOIbGk0FgBrjcF7iaviyeJ?=
 =?us-ascii?Q?0RwiRPKJ72p1w/bnCCUU64KFeRDIQfcxOe6RBee9zi6ae8WZPsdXU8JS7tCL?=
 =?us-ascii?Q?IHHByWEHVUuRIBaPMC50tQfqq0qvQcCP/U7Rc6uKN1dvoAY7y2qHTitezSbF?=
 =?us-ascii?Q?pw1JyaPOx2wTG7UT2J49nTOiGT6+oHkHFqyNls1fKGGURDSRH2rpVQi48UjB?=
 =?us-ascii?Q?MXAXw0aVp7UuPtCHhl7w4lPvpIEygVEE/9sXsiHGum4RD/1hHs8Nm5wtjp+l?=
 =?us-ascii?Q?hTQ5e4GOyuISUistAhe7sf0wGZlDvNw8DTgPj1SKJoIoSqlFhxP/jpeAUhj2?=
 =?us-ascii?Q?EWc8DH7fjGnupDOYI90F/HQKMy5kob6j2r/jKzqqrc0UqHQrgWgGqKgE+P0v?=
 =?us-ascii?Q?v6n5t+oOYJ4DgEDi0xwpzWwAlyoHqUAJcvImBSl5WF/xoqs340GELXHLe1LW?=
 =?us-ascii?Q?Inz9P5SZMOCfTMyVk0Ra3apxM4FMYxmGVswqg3j8nNiMzZ2Q7aSfD3CKC95q?=
 =?us-ascii?Q?Ni16bcUKuJyIoXDOvt2KMXkQoejmIqpVtlzMEW4vPiicONm+ELC39ckFGsdP?=
 =?us-ascii?Q?nTFkbg+ybTa4YHo6TB7+vS/+nf7EKuSu1fH4e3llNG0vLvs3q0Rhqz4ybQjf?=
 =?us-ascii?Q?/4tii/zBhOT/zwlLv8L3E2JosJx3GiEyP4+NLeJP/QyOJngilFeO08h8sLZ5?=
 =?us-ascii?Q?s0XYwo/rxCm+0KKsoyaR/2QInT8pUl/qtMbPD40LCAPx7oL52yHSawkPwL3/?=
 =?us-ascii?Q?W/K0j5U+HbikYvdzzbfDc4vHrW3OtlBh6VOU2eP6hPstKTzX02NteoTK4Awt?=
 =?us-ascii?Q?ibaonDMA/4Sm9ypg32S10nq+SWddRb2FWTxxdXLqq+XhduxWxGGq10v9HEUx?=
 =?us-ascii?Q?BT6srXvL6ptwgQHAL4zZ0zbBRDsAGRzG0cDIxUltY4/TWbY2Dv0XS8peUtIZ?=
 =?us-ascii?Q?yXY5PruvGNaPzRve0yZ5HFhrcyWwrWy6BRwkN6TA2gXk97aL0YSorr+JWqWK?=
 =?us-ascii?Q?P2hTSMnSq8SOtemuzk1DyGPOM8N7ILbgVGnHT33Om/oA/5Sku9YGeek7TubJ?=
 =?us-ascii?Q?uJfpRxmMhzUr5+wCDPwvNiebzLOtdzqND3UP18tQ51yzQ3ixjXRpDPPTZN2d?=
 =?us-ascii?Q?y23QKhx0x5jIz4NQxoXJJunf/LTrmmQTiNbhABimyCu5UwRMEaZfA/lc4xeT?=
 =?us-ascii?Q?twmUUuLzKAODIDuOIJcftvoWJAuaqL+c39ZW4zTpF25nlD9aqkKknFwauVDu?=
 =?us-ascii?Q?uY48E5rX4x56lhbZuuHrMM5k1qRq8kZ6M/UpnLXUTkH6+lS4LR4Nki/fjuFn?=
 =?us-ascii?Q?ANrfEy9Cd0l5mIwMRiNbV6aIAl2DEfzxNl2Rk59N0L8Jswqt7jV7ZYj/Ut3M?=
 =?us-ascii?Q?bmudTjWwx1lUx8h9UY8d/fxgvBMVu/OnmxAQ4DT91msEHbLNcg80Ep1LMq7n?=
 =?us-ascii?Q?edUbKdXN62c4bVe00dhI6rayMK9mS0MTD6B2tyg+4W5juk5AV/f7SYLB9Ox9?=
 =?us-ascii?Q?Nnt0LAq3xIQZ6QQlgjTYLZuzv9pbmTWmLi/Jmsb3UvIHyi7J15vcGB+xc9/o?=
 =?us-ascii?Q?HpRkvMVGgUeMLAA/4S31KhM2nESiyzX9tW+c2oIiRureYVpWWQhpc6xf5zI7?=
 =?us-ascii?Q?HZsyh3XFVU6Cx+cNm05M0+H22JLxEZvd4Ay43arNTLJ0OSWOyIsDGGYvoQJ2?=
 =?us-ascii?Q?qd8j7G+jtxf5lcCk6HJLS3/uHkzZnI62bBjLkjpgIg3vkLJq?=
X-Exchange-RoutingPolicyChecked:
	ZZm9wr/R/j2CGjyJTV5DGtmeQLpu/a8oLnGCi4oNTMPBr26aGxcX6bZm+Q3+k7/nHs0agLLTnsTv12JJavN/BfhlRV/O3BwNSONDzAGJv/L3mt/ySWMJ0A/ayy0yTOEWz3FqLF4bB5XMafxr/s06K5yhJQhLsMlkAc973yz/BwcF5Ef9LfEPVS/ZUu4HH5fBfjSTxD1cHYkMadWWxZC3iB4pv716pB4kAwHmdvmEtm36xebOrwjT+NLNsWklcBb/x0JTh8c36S1+Ppj+CrNiGcFjMz75voEidG2aSTJqBRs6fJ3OHCdkvvK4Hb7ADSnnGpMI2hMkNR8TW68DJJzFww==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81edad1-8954-452a-d085-08def3d2cbad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 15:53:02.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuMWTIgUMBB/kW+ADaG1lqTKfRt6BNFHql1/BtK1HfygtjV54OMaarSvLoSUwx42
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-BESS-ID: 1786031589-110981-15308-2975-1
X-BESS-VER: 2019.1_20260804.2006
X-BESS-Apparent-Source-IP: 52.101.52.115
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmhmZAVgZQ0MTQ3CIpxTTJKD
	nZyCg1McXI2DIt0cjI1MDM2NAgJdlQqTYWAD8yPqZBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275189 [from 
	cloudscan18-7.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

IP_CTRL is a standard Qualcomm MHI control channel (channels 18/19) that
carries the host serial control lines (DTR/RTS) to the modem; it is not
Sierra-specific. It was not enumerated for any device in pci_generic, so
the host had no way to drive those signals.

Enumerate it in the Sierra em919x channel config (shared by the EM919x
and EM929x) using the control event ring. This is the device the change
was tested against; other Qualcomm modem configs that expose IP_CTRL can
enable it the same way, since the mhi_wwan_ctrl DTR support that consumes
it is device-agnostic and binds purely by channel name.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
 drivers/bus/mhi/host/pci_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 0d0d9c7ffa4b..ba47dd153837 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -728,6 +728,8 @@ static const struct mhi_channel_config mhi_sierra_em919x_channels[] = {
 	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 128, 0),
 	MHI_CHANNEL_CONFIG_UL(14, "QMI", 32, 0),
 	MHI_CHANNEL_CONFIG_DL(15, "QMI", 32, 0),
+	MHI_CHANNEL_CONFIG_UL(18, "IP_CTRL", 32, 0),
+	MHI_CHANNEL_CONFIG_DL(19, "IP_CTRL", 32, 0),
 	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
 	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
 	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 512, 1),
-- 
2.43.0

