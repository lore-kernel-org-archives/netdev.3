Received: from outbound-ip199a.ess.barracuda.com (outbound-ip199a.ess.barracuda.com [209.222.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77128531AE2;
	Tue, 13 Oct 2026 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916121; cv=fail; b=JWEN+izCvY8DkjMUuddr3gzjSaqxs+h6l6O7pGQifunEQuYs2WZSKZUJ7w99oaNcaeZJUq+taNSl4wfLv/CdpJ/B0N5IhuBuX24xyNnGNUUH9tio7YSRHd+apSM33W6HIgPdD/ZAi7QKNJ6s5+CBBEvLuEj1iFJhuS7I7xAmvJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916121; c=relaxed/simple;
	bh=kd3SHG9CaaF0dFE064vGn+yQ9xemAs+Shi0W+Sfd+P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LEcOI84mTC68InLeHNKZn7ESnPynAnyu8u/d0EUgbG7xBVYMsma++Ael4mrLc7lqizDAwxu7GGJ0TKNQlAr2/EcPl+G65yBaQtpVeBmv/dNPZZ8wMfyu1D53LskwP5DJGQA8dSkBc+5g3J6McMpx2lamX6ynnh1ImUwYfYjedLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=OK2lBbSW; arc=fail smtp.client-ip=209.222.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="OK2lBbSW"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021099.outbound.protection.outlook.com [52.101.57.99]) by mx-outbound11-242.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 13 Oct 2026 18:28:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCUIHzTQK9mh0NWyP1clouOsE8XHP2WJVmhKJ9IEOt1VB2GFf/iu+yEWfDqeBU4VFIkin3NN7QOaeieK16hxZ09d7PZEmHLKXUK6Rf5+pT4P3Yx8jHTjoXgB7egDqoqlXCzBz5LWTS6tZcLh3hU6VVQuvWj9au2vG7tMlBXNZoJNz6VMYsfXcHGHrl13YcnW/zNP6914XAMC/ho9cRTNalzdTRfeIMEKwRqxkNAbLaPKhKsMDu83+Mg8WabISluW8SRzhHpWXtN9lRw+Kf38Ylm2nxV0mVI4es2E+q13JWN3BaabfWlyZNHPDp1lmOxIFu9DplPHC3cCxAoom/f7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kd3SHG9CaaF0dFE064vGn+yQ9xemAs+Shi0W+Sfd+P0=;
 b=DpeeIKdL1mkmPnZdRlZzUEft38C4kY1mMEscPYzPPQm/yQk/7GuQepwihVCKcAGl5eMRl2rElD9sbRelBovaMd87aIzXV9AgdkjxKQ24mRvQFDB8PjZfPWRkNXdD6XKlgIyxJ+GypwlK7XtFGdxKFr3wiLt8cSZHzB7dsOQpXNjlZvdVFpAMGP8rMbGc94loZlrS2P32MGrM0xn69qxUKNTifBCpH3e2t+J3MARgqhmCa2y0NVtkitcEePIOkfq6lP+bQgYyzeFWLB+785IEr8ps7LqLFYsnSFKIgM7AFEtNitPd1aGUfi4Jh/qDLIQUu1J9GKBTTQx7QzwIq+VsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kd3SHG9CaaF0dFE064vGn+yQ9xemAs+Shi0W+Sfd+P0=;
 b=OK2lBbSWXWRe8vof0FRcjxeUim4GDa6idzdmzDDNt6iy0oMNotm5PShc5t2D/Lo5Krwcm8y+YVi6X/BMlHhfwgdgd71M7wIBF6J4eDkSyZQ6a8SToW7wB/GBneWzBTE27zJBF7IJcONy0nfCbVkkoeKjv4WAAWcQOqachD4YIW1wLfxRQIogzHfxuyobJua8ZPHqNRnH2EpsAPWxi6lgJIVbuHlnGTyP1MbDF12vyYoXsLPLHfburwj9NqHzWMpRjjHajM4hAyREqlUmYqc37SeC0pZMoE0PuSSQNBQNbx4IgxhErU1KFZyl33/Bg9UyDK5wrrf1fNhBrdfyqUAWcA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by DS4PPF0FF25AAD9.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d09) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 18:28:03 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0522.006; Tue, 13 Oct 2026
 18:28:03 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: netdev-bot+sashiko@kernel.org
Cc: loic.poulain@oss.qualcomm.com,
	Daniele Palmas <dnlplm@gmail.com>,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	mani@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 1/2] net: wwan: core: propagate modem control signals to port drivers
Date: Tue, 13 Oct 2026 12:28:01 -0600
Message-ID: <20261013182801.256067-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179191222962.434549.5982381221454218948@kernel.org>
References: <20261012172219.3668624-2-peter.hunt@opengear.com> <179191222962.434549.5982381221454218948@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0043.namprd06.prod.outlook.com
 (2603:10b6:8:54::25) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|DS4PPF0FF25AAD9:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d23ca9-8054-47dd-3817-08df2957b798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/qIHcowpMeuKj2Ed5L+SUW5WCMINJLDRpZFSYkJSdctQPeaT8vmE/SmNa3Do6mTpO07C+u3gRRlc4NjwtkkRSwfJsPq717vBDAejrMvdhYKVb4vy36wLZ8npx6sa4HC6d8a7r5JgNw4Ap1QGjFL+0AlEp2l0R/X/1vjvVm8ZtqXPakcE+MaOT2XRFZNK+wkwD+uUHIiZcHIaYlsJtzo/S3YngmcWtc3QcgT4HOmnPQNXBHb3YRpqN1GREDR0re7yRjhpody6+3S0/cB/+05+ugPlZcp5NdG3bq+EXaRRXmNvzyY0nifdxJo8QECVCnIRIz4bAvCpw9blOK2cOi1z+fmOftKw9P40pO69485GM286aEgll1zH1Q3rtYFluBrCbSPE6oyMAD5jnLsJ/YzSFx22KIt6uoMMjmEEdN3v9AiGeZiZmBvavcB9nbxye9Uy1ZPja8lVgrdSi9bJBg5ikKn4I37iDR3EENvnE05rP/Z8DyAYdnkH31QwZ1rYoNhU0hAlPa1ZwKKnxPyVaq6dYZTp0Vhe5hOA3cpJEyx13Sb3t3ZJPV80pFAxF+cBBKqt3B0gc5ZFu2w8ddHwuRBTE4RULaQSw5HuQfFxHQ/MaS5rhDCKQxCTfxc23wDcPjHrr69ByBOgIns8f0BQK8hJLa/AQKC6hYUF6Thi9LN9Wvw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3XtMeBEa1folyPNPQC8QQ75STn3yaY5ymoC9OBUf46q7nGdXii01gbYZDQlM?=
 =?us-ascii?Q?1h63N1wrEh1cwY05sch2pA3RUxIdfDNXT/QHnUBdmUKt4wbyjNxmJhW9gsyK?=
 =?us-ascii?Q?ZnIn3fqtJ1J8lwgorJd2oUh5cawwilvQLMVDs1U5qMp7XeINMH0B/x0CwdN1?=
 =?us-ascii?Q?peFt3w5DGdO3ds5gSw9XKMSjHP4AKNGwC0450jsZltZOHK12WeDNaAkbidza?=
 =?us-ascii?Q?zG3BAXGvur3Bubcw5DxChvX5ubN9Xg+dR55NDjznRhYf5ej/HA1rpLCgbF5t?=
 =?us-ascii?Q?gxAycrPeu/IKlWgQaKgrFLIVPYhLKJeOdhL+nE4iQZSn9Y+AbzAWwhv2U/bY?=
 =?us-ascii?Q?Wtuld0QJ5TlA9CTciRrXdHn9elv+z7eaVbZVppDN/Co5kAeISzbgq6kQk3Nq?=
 =?us-ascii?Q?yonsj8cuCETE+hDhH53kDX5BpODUR41ZkQ34WfMEpAuBOrRI9CzHtUzPL758?=
 =?us-ascii?Q?ko1w57wgDQXmVUclpPXcWfdzwgQOVDsRhsMC0l2YYlzqZGQHQoU9paQppWQo?=
 =?us-ascii?Q?OpBID5cq+4uPQ+eWKgLm/EAqL4hlbbg8XIZx6UcMZl38UJlOGehi/dGHgUJV?=
 =?us-ascii?Q?0pgDP4dZ9QcZJ5okVPIegTCfdC570L+y/fawnqMcQyHnAZ1Mo63FcM86wS5L?=
 =?us-ascii?Q?95hS7Oi7ENI8mis4RzGmjwYuk1HdlX57ilto6tR7XRKvbr2CrrUhwOhVvQ8B?=
 =?us-ascii?Q?FBWVulso+AsUnGJxRnvM5UFe2lPb7+BhFQrnz3/9xl5/g39Tuba3G1hFeYyi?=
 =?us-ascii?Q?BWSZ/khqCgmxJHdwaO6b0M6VKQDzzrDSGbwlIMSLs6ezXCLsqYjuTG4Dbmzt?=
 =?us-ascii?Q?LKrrBQMbCVtp15uy13zfs39vRUotPTC2eY68N3ZQMqBaOSavBiDrLJwDSVDG?=
 =?us-ascii?Q?4Xw+02hCnCyolZy0Bfji4BGUu0BfclA7vYgLSdPnAuPj1IVQjzrJ958H0q4C?=
 =?us-ascii?Q?bKwLEu6Zash5sl6vfnBA6E5bNknyrETZHfFwftCnfC4p8THyIr0WWSFF7/sO?=
 =?us-ascii?Q?xMbjnTNVr+ax9Oy1JvAqOh1XyL32KaqNOdzxyHLQ5vVfg4D9fjZzM+OLZMoU?=
 =?us-ascii?Q?4z1a+vl1yyPIPOMGjo2/Vz8t40pxfI4ToNv7cLPQtLuvFI01ntNcyU2Tyj2C?=
 =?us-ascii?Q?aEDmYi5Hv5bZw7n4Pzl5y1blgfodcjHDkb5FP4MeQrzHZ3T0EsbS39vguzGJ?=
 =?us-ascii?Q?eIbLdIYIKrjF9/O8mGrOCZjTl55Dc701CH1nCu3LBG84nXvq+2HPylzmMDIo?=
 =?us-ascii?Q?sPbxE3RhyFCC6KDkJRfUrqM/utHSj5dG1P+lZjLkxo8VQoOrFLJOcCQrBPZ8?=
 =?us-ascii?Q?2gHpNcsZA//tB2G5BUYvfr4RYYp4OBbgLeeqwPhd1HwFm1gWmkcTlp1fDm5l?=
 =?us-ascii?Q?JsPhefmh2RvzCdhsG5hUHfX8NdvGO9pn9ReBIcB/BewVImXXJzvxDCq2PQRd?=
 =?us-ascii?Q?bGu6TzA9V23x4nhCEIH4mf/XAvdocucmWiTsF1qRlq8reFPgE6gL0jULyVsc?=
 =?us-ascii?Q?TUcfNeKXmmt5QyRibOZ9ePNXXcI/UiSeJX1If8ZgdxdiWpDuWK0bJbW3AEni?=
 =?us-ascii?Q?ee3oxGQSHb9evtAED7rHv8HXTcAFMCatQuSbL/2uyRUPVqJ9+IIFDtMktNIb?=
 =?us-ascii?Q?coyyIVvw/PQNDhC3UXcOZTvKyFJA5oaCsKdcSWKdIhC3TVBQ9PqbmQefk2Ik?=
 =?us-ascii?Q?SAWW088iDbkfHx5M/hcNg8dWUNc2o49DkzSUbHO+6B5z1NlJ?=
X-Exchange-RoutingPolicyChecked:
	XxgaN6bHUY4nn86yUhL++CxBH7/gbwxCTg+l8IKxaSFu5Z17QqtNa/IN9TavAD/mHp181RTcHrIpMCMcymTLv80wx7uJNpNOU6M0SC3lF2qVn/F7uZJOIs6Z0SI7P9ivN0Pk9ACnvivtKr1AJJGE/HivMr1jfYEpeqobjcA776c3T8t3+L19kMYpWnXoYvZY+O6dqSbs2iIw0GJypA3/DMM3NCdZn8vaSbbQrOuIpU7T/mJWWPrYiOriCF5oiZD4fe3IUaE04IhBRHBol9+eyrBc2zF1ufSoYM2WJP01uUa9nX0EEv0XcgcfeIg+w3PlH8eM88o06sQU64pLfgUeaw==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d23ca9-8054-47dd-3817-08df2957b798
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:28:03.0295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PV5mdG8f+P+QrT6HcB6tN74uB0090OYzF6XzPQZViaIHFfy1jL/ifWClWBhOJbM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0FF25AAD9
X-BESS-ID: 1791916087-103058-7755-25314-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 52.101.57.99
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGRkZAVgZQMC3RMsnQ3CI5Nc
	0i1TQ10cgkxTjZzCTF1MAw2dDIIjlZqTYWAK6+GIBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276817 [from 
	cloudscan19-105.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Thanks for the review, I'll send a v10.

[Medium] user memory accessed with ops_lock held: agreed. v10 copies
the argument in before taking ops_lock and copies results out after
dropping it, as the TTY core does, so ops_lock is never held across a
user-memory access and a stalled copy can't block port removal.

[Medium] every AT/QCDM ioctl waits on ops_lock: agreed for the ioctls
that don't touch the termios/TIOCM state. In v10 TCFLSH,
TIOCEXCL/TIOCNXCL/TIOCGEXCL and unknown commands, and so the FIONREAD
fallback, don't take ops_lock at all, and the rest return -ERESTARTSYS
when interrupted. The termios/TIOCM ioctls still take ops_lock, as
agreed with Loic for now, so on rpmsg ports they can wait behind a
blocking write.

[Low] TTY comparisons and the baud rate: v10 words the comments,
kernel-doc and commit message more precisely and says the baud rate is
not used. I've kept the existing termios defaults.

[Low] "on port removal": fixed, the comment and kernel-doc now say the
lines are dropped when a port is removed while still open, and that the
open-time raise only happens once ->start() has succeeded.
