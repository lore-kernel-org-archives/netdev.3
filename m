Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4F04AF16F;
	Thu,  3 Sep 2026 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441666; cv=fail; b=TJB49o6psdMIB+7utlYvkT8b7VNJRcZh9kIEl1NEGAlr/OKQlTC518qkrVAzPO6+AV5O58bEEWZ36d+ABTcQZ4dEhMte2eOesako9v1G6RUGVIVOqoiVlG2akzACPL7v9w9yvfb2RqTkU5FEAEIPHM+8RSPvOce2bGbeszoYbDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441666; c=relaxed/simple;
	bh=Rv0r94crJulVrjTs9H//nLi+1tZJ+kL4cEg2T/WnioM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XKHGWiG2p3Nq8Cy96RAK7tnmTllOoAzyQVS2AjHVV9GGlJBPxdIGVHd94dcG/erBrDAB9iC2Ydp6RQKEw4KjINW/Ji/9fKMkTkkp/w9X93gaVXbsE4zGYzqaXqdCYtF3gzWnBq8MyLBC11dnqJpNqhlqyPxTZKwO99GH+Jl5RW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oQj5IbeL; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oQj5IbeL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYCggVYzNMG48sAnQ+/CygEdBU3uLSUEEJqzouOAFKpWPR73yH77BY/qcVMDGJ9xli11zkcfSVsyJFKFJ7hxR2oImLJSQF+aMxnFL8IB7rkKJocuOFlZpDCxH61r4P2tDiagfEEsnQus9/UUNM7/Fx/kkIIhvitMd067QPMtR1FEKjq1m2/NUVRgsyVj2lk4GUbV9wFBeHNmSX0cqWgALNZhv+7il4jfVr+O+Sbc731QASnGvqHlhMJBi1SwM2Qp8cv8sm/5KkhWVFPIGpAku7C2ocb/4WvL57mMf4/z/NBsz4fssuEX6SGefKDc8DJZUd+L8jErV8EHH+yeO83TSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvW4+atUwYgeYRBN4Gre8fX75/VpsZqk4hMyBrg7Igk=;
 b=ELUEVf95H+I9vXsP9wihmVy7BRB/gVzjL2yuKtLEbgRw1Tzqfr5R+vT35oTHJg3CF2SbKTvpZ/iIGNMPoeXmIslgGqB2Ds7++4Mzu8i9jItbF/KEjFFk+OZiOsH7V5sbgjWQ4fHreVEceDUsLBM32jn2qZbqSe/AkbaizwCQ3zkdAZNz5bDW6D7rRegtfiNtaRNLjhlC/7bZ2Fb8H6ee7q0g6TWphEF5mw1O8BAyb8a9b5aQbrJF0qSyXIQdXwD9rgPycxy6wPB7P7ypu04wfNfPPXdJR80J9hS1k9ve1ELAeHwdStgyFaXB2nj9sHQzm2szR4QxA2Ua8QNCiq8qyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvW4+atUwYgeYRBN4Gre8fX75/VpsZqk4hMyBrg7Igk=;
 b=oQj5IbeL7D06u3lWpxkIATxNUP1QZbS7lxtxWa/xmE8MirdbguZNP2PKnelEoZeyZk+OWoRTk5PLMTV/zHZscJkkwUVCki2KcnNVcwvaQKoQ7ZAHyctWty/CcFFgp5OrMCywNpW/zeFVIMqVE/Wusmj0IOnjhQb51ocf78G7q5s0i2H8Qt1bJlh8BcSBajenjreT29LcDRkMRUCkjpkmmvqlu425pf+GdFgkhoKxdMQ7hXKk3O24UbIGPesn+dgnc5TXt7Zw1qA7c2YaBe4ZwtwS41eyaKsj/OAGhmcf8kH2JKwUDho8lJq9fxzGlmVZnM+ecVSDomI6TB6SvZZeIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:20:41 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:20:41 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org (open list)
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 1/2] ice: simplify ice_pf_state_is_nominal()
Date: Thu,  3 Sep 2026 09:20:35 -0400
Message-ID: <20260903132037.81346-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903132037.81346-1-ynorov@nvidia.com>
References: <20260903132037.81346-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0064.namprd16.prod.outlook.com
 (2603:10b6:208:234::33) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 8967014d-dbc7-4bb7-df36-08df09be26ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	TS300r5OreCTCWrjHMxP12EgoNagGKs6Ox1u1gla8rvdnHkcMpWO3fJS1sUPdbGnaGaQPSvZohL2m2oiSw66wamHFHl+nU+v0wa6f+24ewY5W37/pkiF5ZqIEDHZfGRSK8o0rMUSV7s3cRooU9CKG9Wcde23bJ9o8jlrgpCFWNUjRRGcS1A8RLDeMFr4JLjEZ/6oFvvr9q948WhYYNAXkacPZk8uwt2W3vOrSZenpGpsdW0BWJaKuAXRmWw89ROOxH6zV+mhWJXAHT3VRVnpoOcRr6hP+CpbmdIbB5yaNoBXoN0JKVeBGc39grYNpmEYmsBH1WZn1YsO5z4SEoBYeIm/vwAwZ77AcIF/8UvhybWYg5Kje8LnDI4R5AyKkpU7fnBMC1ITfg3ilYLxx2oU1S6E9ypaIVpZVA2Dex1CXfZxIR6ItpZPSzfMQLar+530fUFNnHIbnCyVYPjeVctHE0j29QemFBORSIPcojEXm3UfpIdHJk07tOtTBu0wAUae8QE/pM2ZEKcxT7nMpFHYLuizjtOXYEuVePHlopwWKUHRef+tN1+C3CjcHTAFW53KyvPKNWFQA2q033x2wcv+76On9wQpWlspDOy1EIxH9L937WRKzQ2BrFvf4GUlLIwmLcu2HUuJeqzzP6GOl412MG2cIAKRJk75OuJ8TXHSyKfzsL7DX+GKN0CTepMopV4lLRahhWSPKrQr9KElXg/LUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JFkmdn/vEm50+idjt1QAPmpjnrJ3W7/KcRrr44+qFr65/ljPav19cU/38ds2?=
 =?us-ascii?Q?xbMIgQauBmI8p7M80a8TnNMYuF1Z/g4D9WokhcBh1ZE8v34VuikFMvsJbYeM?=
 =?us-ascii?Q?9aaTZQPGs6l3Vt6XhN9GsqkIEMHSNUcluI3bKB2YmjqoVv/YokULmWK/d2KR?=
 =?us-ascii?Q?M40JgQhIsrl+pe+aGDXuCP6lbFUC6I9s+PbkaTHRWJ4c25KiPYOOhpB8EjXt?=
 =?us-ascii?Q?U3678q8YPJWKT8RTR6FxhyfTGJbm/0OZe7OcFpaZUC1P2fQqEG0JXCYO92JL?=
 =?us-ascii?Q?2apklg7Z4p0Bhjl/azXEIy5tUK6GiDdgRH/SGy7SS3HyRkcX1x5dKMUPDYmF?=
 =?us-ascii?Q?y6YrP3ewW9e2fy961P5xRabxq/0Dr7iCpsFYP1oxIIF7c7A1dLOY5x/FYiE1?=
 =?us-ascii?Q?LWt6FgNBk/QmayshynS7NM/zICyDqVZSgYrpT0vOq0WTfQKcHwvXFO+J9e6/?=
 =?us-ascii?Q?WZkubabHjx1Veu45pQHLAQG7xgav3nIP/mf+KSvN95+jHvXmAnxUhF7pYnto?=
 =?us-ascii?Q?/5Xkm19C/5yl/XuY8Vuul3quDLK7hMcS2x1c3zULSCxfuewVPY+YG3oJv5d4?=
 =?us-ascii?Q?ZItHv/NcjcdnHcbxCiHf+PRD8msFA6KNIwyyNWqkyZrk874pqDcKqOc1R9P7?=
 =?us-ascii?Q?SNGXt0Csloq4Bbt7IM+Q7IfDPe0lLDyL9QF4GfOAb+lN9n54gLY3Iom9FIGw?=
 =?us-ascii?Q?EavQrmJ18LJjtL8bArW7VJ0WXXe+JSERpNNmgfrW6UebsnVJjjJBb1gCpdAR?=
 =?us-ascii?Q?LV4YdJzpQcUySGy+paCIsGLShu58HGb/wZJEXD1KE/UZEydFsuPNfKAAGE0u?=
 =?us-ascii?Q?zwSvsCI5AWAd6r6GFQWFYU4lmRJKai0MEvSQ0qrdcNkMTWgFDEHJcIka86p1?=
 =?us-ascii?Q?h4X4XWZ8JiFnogIxUai3zWI7OaVIhXKt7hZnT8L11SkW9+MiBTmqF//d7mIV?=
 =?us-ascii?Q?eHSxHsqXF6Pvlt0rZaUcaLXOTvAfE1wLaQlXPP1lIQ6WY5DNsI42LsvOiCAe?=
 =?us-ascii?Q?GApBXTSfVFHvMX3nBOgKW4AHsVkiskR0WK7A4+zb6VhXx1ICaXKBKvb3OUtH?=
 =?us-ascii?Q?Qpt7Y4xgoMXvLFZCozTH7VFQqk2J/qOA13e7YXLCgOxTU7KZnZPJsEOdlxEF?=
 =?us-ascii?Q?YfB71c64O0+xTik+sAtz637ZCakzMdCSN5NDP4rFYex57kI5tFMOAsN5PYPY?=
 =?us-ascii?Q?7ZkHQ26ko4QnCvXCiz0qIVl/zqMWJ9qBvj6WUQ8bkH/AGBNc+syoa8mLap5i?=
 =?us-ascii?Q?fsYKD2kudZQSCirsw1jAvt12GlBdh0rwdLiYzfKXmPjQhDZiu4NKDXm/B3Zl?=
 =?us-ascii?Q?It4xmigD3536d3xVgGbM5PlpuOvgNQaAq82i/oyGEilkwQUH3YawWGPvCTcy?=
 =?us-ascii?Q?skPZSDfzFyrYezS6QQlqj6RYx98+zbRSZvXdcvB1pFqrzExDMG3jkYGczRjJ?=
 =?us-ascii?Q?3m1v9pviMoSuKngg2hg7jWw/sIKE0FeN3LNtSwBNQwG7WIodKm+2NOVPHUh7?=
 =?us-ascii?Q?bhdPmhWy+cUAA9joNTRCwiTVI3+9ErfHjxz96qnHTnYv9G+r63TjWVeeZXGs?=
 =?us-ascii?Q?qet/lVCtFO7WXmAEvcxiPiI1JE2Zcv/k3Fb/kjIrgxcRbASwEx1I/Ije5jjO?=
 =?us-ascii?Q?Inmvi1cqDHllUmuPUp2CkMyaViXshIhMz/eyXM7CjRFGU0YHpb9ec1AsA/4o?=
 =?us-ascii?Q?pgJvL6gqqUaO/phoTxIq3WXXgAXbIvw3OUmMqUA+mTyc7bt1mfx0OXBt9Ace?=
 =?us-ascii?Q?38uAbMemtA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8967014d-dbc7-4bb7-df36-08df09be26ec
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:20:41.3374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiRXgMvzRgh0IGmWRn2hhDd0etgBlIKG2cOlOph11iICSTxQvroFu/t7Qe3kqbTdA0kPM1F1hmkU6PIXNI8mZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811

The function creates a temporary mask on stack just to check that
first ICE_STATE_NOMINAL_CHECK_BITS is empty. Simplify it by using
the ice_pf_state_is_nominal().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9e08db376d3d..73996e3022ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1705,16 +1705,10 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
  */
 bool ice_pf_state_is_nominal(struct ice_pf *pf)
 {
-	DECLARE_BITMAP(check_bits, ICE_STATE_NBITS) = { 0 };
-
 	if (!pf)
 		return false;
 
-	bitmap_set(check_bits, 0, ICE_STATE_NOMINAL_CHECK_BITS);
-	if (bitmap_intersects(pf->state, check_bits, ICE_STATE_NBITS))
-		return false;
-
-	return true;
+	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
 }
 
 #define ICE_FW_MODE_REC_M BIT(1)
-- 
2.53.0

