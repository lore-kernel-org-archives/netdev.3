Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013054.outbound.protection.outlook.com [52.101.83.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6B545D5E7;
	Wed, 16 Sep 2026 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789590356; cv=fail; b=gjVY8cmrSFB7tLYBlQpzpBJJ0uoTGhy7JgDiYz8FxPZ0zHapDyB02Q205fhl7HVmONHaLT+dr/C2Itx36hy8yh7cb5M0htgRHYVK2hD/VCsS/sEJ/I2INyJzJ1luCwGuxS4TAxG+aXOEo+Sj0JoMSiT+a7cfCl1xb09PhHQ8AJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789590356; c=relaxed/simple;
	bh=p843uKKxJwH19ejcnydUSVVv9Radw9u974pRf3N0Pgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G9rgsho2lBIsjEq2Mn5pdqyH9eMbo7vkCl151tmSbmj66TB6UDqqUHnCzzfrn8gB1npJA9Zp2N23l8h/TckY/dh3lQUcSH9H5XgYaa0Y/jJ6ve3LtiWscirXKf0JCx1/LV5UdjiO5DI3eLdxic3A3pPzKSyNawtKbnN2nvWrXxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ElqfABCb; arc=fail smtp.client-ip=52.101.83.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ElqfABCb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poZ+3fEwtQi6DkAKatQKUNkQAVsqkZTvT6fzdmok7jS6m5dgPw428iFJg2eXF7QTgAUlucxSGfjOvZuJDJLQz4Djx+zPOFPAXubESvz0p/3rWRK6hVTH2OKojhGVvxsTBeUNsTw5mN6WeiAyGrSRnu6YK23fziYU1TIEbMR1qlQcjXthbdFNdBFvt1IDvUJx1JA3RjOgl5HA64ZGqH9MqNQAvs0UO5Xb6McJi8wJOQLhC9xJ0ajGbJ2udgMrWQZ8ehdtOcIqOecyVf6C6E5r17PHYLV2bp+DdwVi1Sff5fW+RHkeK5nNmQKhp7s6r1T5fhytJ9brJ7vlqDajSprrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xbpj4bz6AyXGWnxm7HeyTmgav9RAh5QqptIjZOiBJQQ=;
 b=ICHgCcgr4oqXAWpzWNcDDTrGpYUF8NiBqT68pxBqNFtC2mwLP2TDYxnhQHmYmfh4yPhzs6Wr0kKRm8qc4jaWUEkOpDHFdB5XNxBT788ZjpM5RAeCd/FLJmCeapmDzmj+8NmL1EzlYsKhVKy7kv4MLtplImL3ydqr358GYfqp398PwwDaHIwdkQjPEwuH7RshUs57dNYQ5hyvreGXb01nVcJ+e0gvMby5J80gKBrYxyMN6qJJFei7NaeOCUQC7ZSorIKTDhfpLN4rqmeIHVtIG+BJapKLCzdHOXg9khaHsdZF2OMPKuDil1U8ZmrWrrXcdUXleRjeuhdijx1kn6RaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbpj4bz6AyXGWnxm7HeyTmgav9RAh5QqptIjZOiBJQQ=;
 b=ElqfABCbrTqGgtBgjI7GeHqhnmV49EKFQeqrNCa/OsYeYtoAnI5eTNDoRF1T2/OnqwNV5roSyyK//cfN43EXMjuc781MqVP+fH3C6B7sEtRUvJMX+Kh0SCqcRmI0x03U5b8Y+9GN5zFP3xuMdYBf940hkiQQj3meuduwkcwaaBI8qmo/EBBeSgCud+cqBZjOxu2X7SARiJ58xRYxNWsm0upIkLyjSBsvRgx15LFtAHHJfGZe9DRA4Tpw2kZV7RNDbVRjzAm7H4SuyY73vFIygW4oZaSJPX/Lfjv13j3qXBmQgQhcI0+RFc9S5MRkbndoyzr4CJvdYVz3fjbrKnelRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 20:25:30 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 20:25:30 +0000
Date: Wed, 16 Sep 2026 15:25:17 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: bestcomm: Enable compile testing
Message-ID: <aqr7Lfji97j_0nVd@SMW015318>
References: <20260915181709.11323-1-rosenp@gmail.com>
 <aqrxFTWEsJmFIrel@SMW015318>
 <CAKxU2N_zEA1NxAp6H6J6COjTwUv8NK909m3OZ2kcyVCpCby18A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N_zEA1NxAp6H6J6COjTwUv8NK909m3OZ2kcyVCpCby18A@mail.gmail.com>
X-ClientProxiedBy: PH8PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fca85d2-5e04-4213-5027-08df1430a6c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|19092799006|23010399003|6133799003|18002099003|22082099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	k5cQ2QXkwy6yNen7fCh0vDjsOq01fiM8uIePy4TPesz9naaBRzVlrmZzvbfs4XuelOJQOy26VzXCniMnvzeoZAbXy/SMzNMmfbcUQkzxVmz/PTCu0Fad61DHmBgZYyC5Y0Atu1R3ulYZy6aR8/eRBpe6zV6VvrNfP8uvBUOqTBA4suXXJs9EAyVgToIFyopVy7i6qrhAx/UiBIIPimvMtDCTH0H27K6hExu5KcyqNGbOGXvrlAi56OoVuVaIdDlxENWinuzB2WJi/niGR55fRVRIoONx9MtdsN/wmAFCFtp2KBk0J79aqESMsyUP6XmgMQZqaP18LUJ9Y5XYTDknuiwTKb5hBbRcIj/L14SCPdY3l2gAQvY/xO4jS+bbqx7pcrr9wp/Ve9n6rNCV7/LfSm5vF70pe2nzfs0M+3hbS03s1HzPzM3axuwunxdWLnv7Yf92t1IP1yj/ck7lnw4/twGI98Yidu82m9w5dIepx76agUaGhB3eZEN4dUa/WyVwKGnHKoAWb+GsjQip5APX0U/dUn27nldqd9V0DNgHonoGartoBGPY6jS3pYtVCn17t4zvvED8lyPyD8wyRlkdQUYVhsLfkrTz2tG3kpyuAJ/WqC8SKPH7XArw5FN8Dws+6pXvqqSlAgyFR66jD4LKuK3mrwrFgISXu+ClpYQ/Pgs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(19092799006)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dksxZFhZQkQ2Kyt4bjNzc09DRmQ2NVhEeXRxU1htNjhhVCtySWIxbGh0SVF5?=
 =?utf-8?B?OGVkVUp0OU9uRElqbVVWSENxY2I0WlBUKzNYQnplRCtxQjNRVGFvUjdMbVF4?=
 =?utf-8?B?NTh3WFRoS2RyYzU0anloc1NsOGZwUmZyb3RQSzVHQTB1STg2d09zbVhtS1du?=
 =?utf-8?B?Y2tQUUtSUmRnYjRJVmJLQTF1dnhpQjRjcXdZUnZGMVI1NHVUTHRxaWg5RVRI?=
 =?utf-8?B?ZEN3eHFqaWFYeWFRN0F4TlU1TWFZTjJ1ejd0ak1paFpwcWFGSmllblFrbzAv?=
 =?utf-8?B?Ynk4bk5KaEMxZ29xd000WG9WMnoxdXNJdmJkTjh3VVBsejVZVGRuN09rcmpo?=
 =?utf-8?B?MDdRbVk3SGgrLy9BT0JvODFBYStiQmYzVmNsaFVjK3NZazMyTk9GWDdvdEFF?=
 =?utf-8?B?eDBXUTd1OG96c09lZkdiYzhoRWlKbGpKTUxXb2hXV29TeC9oUGh1ZUEvbzRT?=
 =?utf-8?B?V29rNnNzdW5zc00yWmhGby9pZnhrNWl4MkpUR2JlQkp4NXozSlFOZ1hkRUV3?=
 =?utf-8?B?aVhSNFEwR3JGdU14Z1cramcrRXBjVjhzOWlzbC96SVFWeFM5UGRKSHB0VzFq?=
 =?utf-8?B?Nm5qT0ZBTE9HTGoxUHpjZ2VFTUl4Y3FPeFVSRHBKbW9YNDh1dXEzQXM4NnE2?=
 =?utf-8?B?a1lHVjd3VDNkeUdKZ0R0QUpGUTl6djduL055YkFiKzNkVk91NGZDbVM1MXRx?=
 =?utf-8?B?YUhpbXJSNXVsVFpFLzlUMXNxaFdTTUtRd05aY3BvNm1jUzlsaURZRm1aMmY2?=
 =?utf-8?B?ajk2dTR5M0xyOEVObVZyRUp3KzVEdUsrc0hCSTVuTkRqRjh2RkZ6THF0NDk0?=
 =?utf-8?B?VXI3YVZtR05lYnlUbFhRRUlCZS85RlUxcTByRUhacVBJTkpwNWQ2UHgzVjUw?=
 =?utf-8?B?THN0S2x3RDRNMFUvcEMrVVBQc1d2ZStLeGM0S21Xa25YYUhNTWtVTUhtTW1L?=
 =?utf-8?B?RVhEZklQRkgzYSsvTGlIdWZ4aXNqS25UTFlDTjY1TEoyMVRxVHZER1NZdUR3?=
 =?utf-8?B?em9wdzBJL0JhMENpczRBTXlMOW95cEpjZTVYRUpiNVh2UnVLeFREamRTeWdx?=
 =?utf-8?B?ZTdkZVFWaEpLT2NsYTZRT1B3eXorWDFzYmVqVCsxUERTUXh6OHRHUnFFSXc4?=
 =?utf-8?B?aUkwdzNxSmpBTm5tc2pKaDI5SkpZN0FZVFZGYXNieDV6MWp3N0t5eEo5V1lW?=
 =?utf-8?B?M2g4YVJTRFlzNllEekpUcDB1b2Zzbm1GRlJ2aEV0dzZHYWZwaXlud2pLbVd1?=
 =?utf-8?B?WXJiNkp4TXdQTkZ2UHc3L2trWnB6bk1lOUFLVjZ0bTdXdWVUYWw1ZkJ2VmZn?=
 =?utf-8?B?eHdzcnJzR2s2Z0JrOE5ka25vb1pmUjdTSHhzbHd6KzNYdGFKczVTaUJDSTBv?=
 =?utf-8?B?dDdhcGFRUGpoMVFNeUFtTG53VDhhdDlnOWg4SVlxcm85WVZ5YkZLTVVZK2hV?=
 =?utf-8?B?Yk1WV2pzSk5mRDZGTW1nWWlPRzE4NGoxV1ZGL2p4S0R2cjNsRTUwSDFSbmIv?=
 =?utf-8?B?eXZmam1IL0twY1dTYzloRHVvanNKRGlpdVQvTGJpQWZZeEJmNmozbFdiaDBj?=
 =?utf-8?B?dTE2elAxa3N1b3ZHODB0bzBVK1YrQ3ZEMkZEdkMyOUdPZEMrV3RjWldNTkpU?=
 =?utf-8?B?RHBvZXJkbW8yalpoZFFGQ2wxVnJMY3Q4Mmw1bjNYdlhIOVd6NE44d1NrRnNm?=
 =?utf-8?B?cm9GZEI4TzEzQitoNndxYW9pdFhBcmxONmJYMUtqWVkrUllNdHozRkhwbnJT?=
 =?utf-8?B?U0ZVYnZubG1hZDJBTUltZ2VvNjJiN0ZwdEozd0NRY2s0R2NWSDVPTElySDIx?=
 =?utf-8?B?TElvL21GS3B5Z0x5QzI5T3piNTRrWkZaM2JnaS8wK0pQWlR2K0RQZnh6dm9J?=
 =?utf-8?B?SlJWL252U1R0czJPZFFxdEI2NzVHZm1Ockd5UTlpcHU4N0UwOURtcFRYRTNO?=
 =?utf-8?B?TEJ1ZGtORHJiK3kwcUxvaExpVE8zZlZ3ZG1LWXNHRm5VZnpFNTF4Z085cy9n?=
 =?utf-8?B?MEJKSGlwNGJKc1dLaUdqdjNoc3FORDhSM1BxQXdtZXpTM0x2cFYvcmRSMmxH?=
 =?utf-8?B?RTJ0RzhCbk1CR24va2x0UDhEeUtWV0ZtNncycGIxc0NPd0NIVEVFa2ZDTHM2?=
 =?utf-8?B?dzhlK2RiblZoNDlLQ0Y1QWtQdnJvUmRqYms1RkNHbVc2eEhCOUFYNEVDVVJX?=
 =?utf-8?B?MnpIRlFMUFZvb1VXdkN3R0lMdFVxZzFtT3V6bkdiNU5MV3M5bDJCd3dPWjQz?=
 =?utf-8?B?MGFkeitoZTFYYUwyd1pMVjBOWmxJc21IMWkxWXYzUXdRTWY0RVQ2QjBScEx1?=
 =?utf-8?B?YWh6bHdPZUJhUUJCR0QrVWJrQmgvTkdORE01bjVPUE5sNlIvUm56d3h2Zith?=
 =?utf-8?Q?Jsf6dgd4Gn4SXfu3LPMiudwZvBT5bjux9gm6y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fca85d2-5e04-4213-5027-08df1430a6c4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 20:25:30.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbKGxkjj3PNPxXEd+UMepW5IUcgux+5jbYxPYvvYQw0wQLfvxt9ZAMYwqyTtSkskFXKltv17vFH0ymOtX4J0QxxcdZ+VrTO21BzMDfSoL6TXOg1tcTtFGKA+bCYEyma3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7630

On Wed, Sep 16, 2026 at 12:47:52PM -0700, Rosen Penev wrote:
> On Wed, Sep 16, 2026 at 12:42 PM Frank Li <Frank.li@oss.nxp.com> wrote:
> >
> > On Tue, Sep 15, 2026 at 11:17:09AM -0700, Rosen Penev wrote:
> > > Allow the BestComm DMA engine to be selected for PowerPC
> > > compile-test builds.
> > >
> > > The freescale ethernet and sound drivers now need a dependency on
> > > PPC_MPC52xx as they use headers/functions from that platform.
> > >
> > > Assisted-by: LLM
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  drivers/dma/bestcomm/Kconfig           | 3 +--
> > >  drivers/net/ethernet/freescale/Kconfig | 2 +-
> > >  sound/soc/fsl/Kconfig                  | 2 +-
> > >  3 files changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/dma/bestcomm/Kconfig b/drivers/dma/bestcomm/Kconfig
> > > index 5dd437295964..153b5492c93c 100644
> > > --- a/drivers/dma/bestcomm/Kconfig
> > > +++ b/drivers/dma/bestcomm/Kconfig
> > > @@ -5,7 +5,7 @@
> > >
> > >  config PPC_BESTCOMM
> > >       tristate "Bestcomm DMA engine support"
> > > -     depends on PPC_MPC52xx
> > > +     depends on PPC_MPC52xx || (PPC && COMPILE_TEST)
> > >       default n
> > >       select PPC_LIB_RHEAP
> > >       help
> > > @@ -34,4 +34,3 @@ config PPC_BESTCOMM_GEN_BD
> > >       depends on PPC_BESTCOMM
> > >       help
> > >         This option enables the support for the GenBD tasks.
> > > -
> > > diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
> > > index b34c0fcfddea..d81984fcec64 100644
> > > --- a/drivers/net/ethernet/freescale/Kconfig
> > > +++ b/drivers/net/ethernet/freescale/Kconfig
> > > @@ -38,7 +38,7 @@ config FEC
> > >
> > >  config FEC_MPC52xx
> > >       tristate "FEC MPC52xx driver"
> > > -     depends on PPC_BESTCOMM
> > > +     depends on PPC_BESTCOMM && PPC_MPC52xx
> >
> > use seperate patch for difference subsystem.
> The issue is this patch exposes the issue. It's also extremely
> difficult to get anything into net without the maintainers claiming
> this is pointless churn.

Maybe you try enable COMPILE_TEST for FEC_MPC52xx also

Frank

>
> >
> > Frank
> >
> > >       select CRC32
> > >       select PHYLIB
> > >       select PPC_BESTCOMM_FEC
> > > diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> > > index 04940879dfd8..101bc952aa14 100644
> > > --- a/sound/soc/fsl/Kconfig
> > > +++ b/sound/soc/fsl/Kconfig
> > > @@ -234,7 +234,7 @@ config SND_SOC_MPC5200_I2S
> > >
> > >  config SND_SOC_MPC5200_AC97
> > >       tristate "Freescale MPC5200 PSC in AC97 mode driver"
> > > -     depends on PPC_BESTCOMM
> > > +     depends on PPC_BESTCOMM && PPC_MPC52xx
> > >       select SND_SOC_AC97_BUS
> > >       select SND_MPC52xx_DMA
> > >       select PPC_BESTCOMM_GEN_BD
> > > --
> > > 2.55.0
> > >
