Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010036.outbound.protection.outlook.com [52.101.84.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26983D0BED;
	Wed, 26 Aug 2026 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775600; cv=fail; b=NaQIGG56g7RnIvcYbJQB9hxO/CO8cjaG9/lb/oHwLPLJkdQYpvQxRx0cuMuSuDYzcQuFHCOteDaT9t54lFXeFELgl9kaxbBP+FQfaY4K2Vhh0Cvv2/1CIeHpivZRoFhpOFJewnxHphN5A8ZijLPG0RQFhEOIdTm5JChEZ0Lm9yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775600; c=relaxed/simple;
	bh=6759dPkQoLHPszAo/ujb6OUM2iiQCl8Y6vo3wAalPYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HdL8X2qPhSDOS+2NiSZeEvM6e/0k9s64gRJH6RPAbkRJDSQKuCJcE4ZnZufNKLqTVRsRyDZMkC6bVzbppiGLVyCjDfkLJ3z9l0cckJGmjh6Nh6b/hSqvZUXyRWpqQ62JrR3Hd1rIfjTsBsDABdD0z1JYFFnsfn4OA/An7gCAa6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GIxRQcdM; arc=fail smtp.client-ip=52.101.84.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GIxRQcdM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYHr6+ImY+ZiGuhhaimSGvOW4NfvvUqa+U5Jc4ExzolSCj1So7+UqlpGSGfjHM1Tlw+Df9/a22eRqCxcv+EqUA4LmN6eUGLK/GFchIOwtply+p90aRFgS9V5M9q+Ji0gpBfqDofaxopGc081rU0cYMUYo1m9cCQFCg3UKFowR6jywb9iSD2DD7sCfcImxhtVfPYwP2HLGfEcL8pG1FyaToCJObIyZmBCsOtCuq4e/nA1CGlgrDS7miosUWH5/tuISviLUF6qInGfwItM6qDY+/zqht6HecNNeSVVWN4NqOUj0yelcXP0vH25Cq0ohyRuEpkzDNRQyWLYVKv4UoTtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA9wuWm0IvRxrSyP2np/X3gwnYONNC+j3OkOGLdiEKo=;
 b=yWR2GMod03eeIr3d8TOXjn0QRNlyOUgpHbxEiC4A9b2l+8jH4HOtjCigVBWVmist81BJkSY17RNtfNwK+zB54Tm+3E6bRde7+V4SgwEKClkMyOzaEvhJXm9LoiKUxlxX1wuBZvPjctNwToutk7vAKMOwRdOQWjhyQrBOhSz3VI22lWRIGKbb9GbhFs+03MPA+2TWrSQODyPwwzbe3dJG9CPJw3hb3TTdazLYwYv7VN5zCmBI8bNK7KoUltbVfjwQ+ykQtWCfHalign0K4tZaVf1oLF6Hb3oEGu8j1CXcXh2hwYy5Ylq9QVZmB4CBeLfsfpS2JL0jHeVmMGfKhwp6Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA9wuWm0IvRxrSyP2np/X3gwnYONNC+j3OkOGLdiEKo=;
 b=GIxRQcdMXxa5VwcNwsst7/2OpHWcOJqywSmpOB1dQAHb9Ni6If29LaDbE+zp/3NQAFtJ1itznnfuRwOFzhBU29XnSjLBzWVdRKzCCpOlI5w4qu3yZOtO9kbjVwpBgenFp025LwV4xYriwGEJyhY64gFirvEntwe4W6jaWaILiMYvSNOo5zjlVmt7E1I2swycUZX4ORApvbNpx14rjukgrJC55hbMye2F/OTPHGlhkLxrwiQwl958KuM2aSS0EI78uWn67aNYz5bfeQExrjsOXAKLfhhEZDF3vEqojM5pRkG9PS5AGOd4e4fosTnRFhqZgGiwz7I78djJiV6fuOdBdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB10760.eurprd04.prod.outlook.com (2603:10a6:800:25e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 20:19:55 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 20:19:55 +0000
Date: Wed, 26 Aug 2026 23:19:52 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Patryk Biel <pbiel7@gmail.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: pcs: enable autonegotiation for 10g-usxgmii
Message-ID: <20260826201952.pmvweuqb3awr7vay@skbuf>
References: <20260820-b4-fix-pcs-lynx-an-v1-1-62d66391eaff@gmail.com>
 <xjhcgn2ki6a4vlmo5cbn4oagw3jyn6zkomjcva5w7gnugzbloy@odub7owqu5pa>
 <CA+DkFDZzFLHxgBv5Z260gwk4UbYAONxtTewFHPV2vV2M6z0Q+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+DkFDZzFLHxgBv5Z260gwk4UbYAONxtTewFHPV2vV2M6z0Q+g@mail.gmail.com>
X-ClientProxiedBy: VI1PR0102CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::22) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB10760:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f14a114-e538-4e98-94d5-08df03af64b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|366016|23010399003|10070799003|1800799024|10067099003|56012099006|4143699003|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YpeMaSdxbpevocaQyH4xF/kHXg2BBJr0XGGWciKCOmbx3/o09zOs1FUz9j+qbRCh7vyr4kI1U4h7IDikHQWSr5ikbTWL7z+uOKqvjDbcQs4WGA4nN6TJHgdAJ07WVa3mNKg0HQ4cDoYvS1+jfERHKdQz1pPOiuM6TYB+Pxy/26+o1ThtLCc6vJCl/e3s+OJAdrcylOH9//9IGnlUXkFv+HpVxOmrCQq/A74/JlFKGv/cJKX8vb9m/A6BD23alt6l5RSyR759M1iCuB7u0YuTnnfOZwFo4CWpGqU5kU81GXVYL0/yJRRMoXMIhFZnQ9aRY4kGepyI9uGd3x39t+2WsAX+zQq8apYUYPE8ELGjer1sZ+D4qSj2CWj0rrucdhgYoIMN6E2ksgTvps/GU7h6iF6eok0Jt7DPSmVmwVgZTAYpLgDaM+k2PjapfdwnFkOrUnpXboimgxfIjVeNI3BTWdcY0cV7V3OwsVsYqjnPg5U6nBGFDWiiOeZxRa6spoxGJ6SMOTOkbW21atpTUCElLWTYxEhvmaGvNqYke8J3icxHSa6wIbwyecPUUHTkNDpHl0eK62sA5ZhsOeKGjFR32iI2L5vhDdy+6gCJP8/qGqpAJmOSmo0CpdvjnbQdA0IGHOfWBEjx4d3WeQ2coKrLSFh7JY3WiUed6w6Pd10k3DY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(23010399003)(10070799003)(1800799024)(10067099003)(56012099006)(4143699003)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjRDUWY1QnJTb2NnYW9VZXpaWE1yZHhRL2tBUXhHeUF4UlZJMWNEM21kSld2?=
 =?utf-8?B?NDZ2NWpYdlUweitOczNJcUZJdkRVT3k4aGRKbGhmRzhDNFdaTFdLRjRUVFdN?=
 =?utf-8?B?TGNvL2xoVHNPcDNWclQ5ZjdJOXZiNWh5V3Z0S045UWRNbVdYWXpPUm1rS2Vo?=
 =?utf-8?B?ZUY1T1Bic3hXQVV2bWtZa3VHSU1aakNkVElIMnp3cW9INTdQU1Qyejc3T3da?=
 =?utf-8?B?b1lpQS9jeWYrSWIvRkdjWXkrNmhXNXovd3lWUmMvVzN1SGE2emxhdWpJODBI?=
 =?utf-8?B?UnlTZ2tzaTVCM3kxU084a0dhVUpUcGl6MGR3RWtVeVlKcTlzRE84WTFsSG93?=
 =?utf-8?B?YUF1eVJ1YXJOVEZseEtHY3R4QUUzV254RWpZN3JwVlN1aGhIdUE0UTZJVjRo?=
 =?utf-8?B?MVo1cWhCVkJ2aFJUbjQ0d0RCOURRdDFSTjdERk1GVjk5TUYvTDhWaWdUNFRm?=
 =?utf-8?B?UGZTaHVZOWJqbWVPYUhOeGl2NVlkN3hpQWRibTh4S3g5a3RMNjJXQlQrdG9H?=
 =?utf-8?B?eHdJVVFmSUtoUk1TN2RFcDgyQXNxclorWUpSc3lGRFZpSTVaTE5YV0JJMVFR?=
 =?utf-8?B?L2lOSVF3ODdLUDYyMXNjcTcvWk9IUldQcENEajJQMnpJK2ZINU05WHhZUEFL?=
 =?utf-8?B?NmwxSmh0S2syWWN4YVJ5cC9GbzRaZWdFa3picHI0QStBWHNCaFBLNVdQdDh0?=
 =?utf-8?B?TE9RWW83Z09lSUdDRHlrVldyTHFlejQva0xuL1VNNTRLZlc0MG5xVGxJNjQ3?=
 =?utf-8?B?SU5RazdQdld3RHg0WFlSZHE4YTM3eUVYclljaXdGbWxwMHlZL3gzVVNGaVB3?=
 =?utf-8?B?SHVPSkNSUGpEVGMyazRMZld2VWxtbkRTSXdSckRvWk5jOFpFYlFtem44RnhN?=
 =?utf-8?B?OE1ORGp5VnhMMmZURUhTWUZnOXZ2cnM1OUsvYVE3OVg5UzhINVAwZHM1ZWtQ?=
 =?utf-8?B?UWU0SjZIZ01sWkowb0pFdWlSbEc4Z1FBTEpVYjFESVpxaHZ2NmZ1K2hWb3FT?=
 =?utf-8?B?SWZyVmV2cXduRlh1aHRXcWk0QklDTTBhcWtCKy9VcEZIRTM2OFJOVlRnSkpM?=
 =?utf-8?B?Z0FxZ2MwQlVXUkZXaGo2RkxiaWpidUVJZnFXUFdlMUFldEVubEs2REkvblph?=
 =?utf-8?B?KzJFZXRUVEpUZDQ4VS84OFl1TFovTFlIOHhxaUFqb2xzVjZTZk9SSGFTcmQ3?=
 =?utf-8?B?aGU1UldRcTk3ODRhV2Z4SVNKaVFNM3NSZlVFR0NKazNVekpRejFERjVIUktI?=
 =?utf-8?B?Wk1aQi9Gd2lSclE3dkpYQzdSMmxnSHBNbEhGbmd6dnhlTm1IWk5zUEtSQzda?=
 =?utf-8?B?QkpKcWpmWi9IT3ZmSDFubFhpSUpyNTQ1TjNCMkErUFdTSDF0R1dWZFE4M0Jn?=
 =?utf-8?B?SlVrTFQvY0FuMTFXZ0VkQXM2czhPRXAwNjZDU0JVWHN6Qnh0Y2RnVUo5U1Yw?=
 =?utf-8?B?akQ4bTU3L1hqcEE1TDlhSFRTZ2dHMzk4emJZemRJSFZ3dWNJTnpYUFUvZHl2?=
 =?utf-8?B?RXptdmtKN1JuOUJHRkZjQnkvWVBFa1h6dlluaExacFI0SDB1N1A4c01Ia2lv?=
 =?utf-8?B?eGQzNVZGNFpET2hDTEhqRksrdENTdkZrNG1reHpub2MvL1FLbzlIL0t4RlBN?=
 =?utf-8?B?cUVnZ3p1ODYwbnJmV3R6NlJmLzFLS3VnODU0cXNBRlhOOWtMbFpNL3lzWkdx?=
 =?utf-8?B?NFJDK2RUcmxldDJITVA1d1pnY3F4Y3AyZ1BLbElNSHlnY1VtV2xvYTlXaWVa?=
 =?utf-8?B?YWVWbndkRk13bmdwZEIxNmtLMGJDMndhbXVIb2lpenFVTnRtNFU3L0crbzY2?=
 =?utf-8?B?RThwdWNmcm9zNFZ4T05SNmVIcnljQVZ1NUxGb2w3MHprWVYwSjczWmxEeUFO?=
 =?utf-8?B?NnBqSXZtS1h3SWRYOFBaMkQwYWluOEtVU0lzUm1paEpBdVg3S28xNnEwQWdG?=
 =?utf-8?B?cDZDbEVRNHZOSnAvLzNNa3Q0STM5NE5Qb01pbDZlRitSR1hpdmlWNG1tNndT?=
 =?utf-8?B?TnlReFp2dWhjbVVCbWtRZnJDeVhCMGZJdjlGREdkUGRzMUd1M09WeXdBUldq?=
 =?utf-8?B?dk81YVhaT3UrQWxGelJMd1QrN2J6OWFyUHI5NCtMajFhMUttWE4xV3Y0K0JD?=
 =?utf-8?B?QkpvKzVQNytteHZyVkx2RGZqUk1rc1JUejRoVHBkZkFMY0J6dU9SbGd6Tnl1?=
 =?utf-8?B?QzNOL29GcEp4VTJEcFhvRklRSHBpMU9Vanl6Tmc0VnZRMFpIUFkzTXBOVVZF?=
 =?utf-8?B?SjQ0TmJMMm1nL0lpS2FoV29qTXpFNit0K1ZQZnJYZTd1TEhpQjM5L2NsMUhz?=
 =?utf-8?B?Kzh6RUZPMk53UTBuQnRoc0JrazRCUlEvM2JvaXBPUjBDeFF6YlZlcFRnbllW?=
 =?utf-8?Q?XXzkypaTkr1rrJGL88FAeamV8A5SuxVdl/WdYlZwtbFun?=
X-MS-Exchange-AntiSpam-MessageData-1: zoPrKGsBilhvAu9xZLLotMrru6UtTnrT5Vs=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f14a114-e538-4e98-94d5-08df03af64b3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 20:19:55.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEvRDQLneBs6UbopNO+ntNrjLkV/H9YR9DwoAIcIhRgd7qiK9VBvQvokiWV5+r+TTNoYw17EBkjQKCAClWTn9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10760

On Mon, Aug 24, 2026 at 02:54:54PM +0200, Patryk Biel wrote:
> Hi,
> pt., 21 sie 2026 o 12:00 Ioana Ciornei <ioana.ciornei@nxp.com> napisaÅ‚(a):
> 
> > For v2 please explicitly target the net tree by changing the subject
> > prefix to "PATCH net ".
> 
> Applied all requested changes, however, according to this suggestion
> ("PATCH net") I also rebased my changes and changed target to net
> instead of net-next, and I now see that on patchwork one check is
> failing, namely "netdev/fixes_present". May I ask how I should proceed
> with this - should I add a Fixes tag, or change the base back to
> net-next?
> 
> Best regards
> Patryk

I discussed this with Ioana, and we now think it would be better to
retarget v3 for net-next, given:
- the fact that you are effectively removing a bootloader dependency
  (which can be seen as further developing the driver), not fixing a
  breakage (which will be backported to stable kernels)
- the risk for introducing regressions in said stable kernels

But yes, patches targeted for 'net' should have a Fixes: tag.
