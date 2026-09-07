Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011028.outbound.protection.outlook.com [52.103.39.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9C723D297
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788820808; cv=fail; b=a22qXoxXubr/3HP2800DpujDJU/NnBwlqBWc2PvyXBt+a97V+uE40co5ybNuyAQyr9TzL9a/TtwYWr4ZxxbCO+jVmH9cwQcXvyfJaB3GFbvkDZ0SyHu70NjRbvpqkVMOeyrmiCw0KIoAYSA/wyVoiqKyo0Qj+28iZD5EIuf9b/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788820808; c=relaxed/simple;
	bh=JVfhCwpntiqIXgBRV0c9a9gnUmFLHGCnwl6hMwCTl6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lCqkaNDjaa52+rsFHqpAdlVq89vEHbVM+Xw3QzCdnKuDurBaBZjYZLtwMS2sJqN/dr7jyPi6S/3WLiZpfycvFSrbdE45RZxl8cwWGL733AIt2bKEb8KTWCP/39NQnFemovV3XlI61k/VR/PuPiVPmZ33F1hxSJbWUurfHdnkIlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=q81IL4R1; arc=fail smtp.client-ip=52.103.39.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="q81IL4R1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOHkVXUyOK3Rzt2ZFi//FIHhXj0FveW/umQ3HbtHNxuZtecsgwiG8zQ/fUPMDr9ygJogcOCASyU5CJPN9OLkH7JvuzgDaGMnIs77UXQu0TijTze33Jb0BdNpIqI14xpkVLAVG9igSy0Eigsfq1mOXsR77+B7nSHyP0Lx9RWMprdb+xziua8SV7rbyYHobPqjdo21XMDENT8x1j6SUZzUbAep0SKTqhPW9XgKaL9peBAiZe0/5Bl28csXIjJUZnRsEoX4IMTvsLPcQmptTSskgCGIr4Ho0URuDfQVMEZnzayx8S5rEDYsAjwB6U8H6dc5eBqYOlT5/0inhZQDHkNdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVfhCwpntiqIXgBRV0c9a9gnUmFLHGCnwl6hMwCTl6I=;
 b=gTYQ6Pg6qlBxvARAVy+lhvRjk9TuIGA6uYyGrl5Ra1bm+uaiHQGW3yaGursr4MpJV3tfoN+9qjTA6RARqzBM15gveVByVQfmc2XNCiJtZ3mfvkfebVdiZiik4TTVx61U/Uy92vuBJFxWy4PqYLLAx3Gox43K5waVMkXj4XCG6p5w4DzHGDp/qHpUHq43BH/kWSA5sSzzdJgKWoZXCaIrVMvYRzZLZaz2U/bxlo/C5Rie5AJYja8EosEhOU7PXQ6XyDhoChM0hDmaKm4b0Mm+vJHTqQZwSlL7lACl5uCacOAoaP7yzOwHBidkEqd+1hE40iGoY+ONblpthOf7cbSi7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVfhCwpntiqIXgBRV0c9a9gnUmFLHGCnwl6hMwCTl6I=;
 b=q81IL4R1uXkkIns9aEgX1fmDCYdY2urB7HyaqqeEr17IlR2hzP70MWiF7f0/rR9cC7vkY+MZB/OCa6C1i8EX65v2npEgEXAJn2HwMXgUNITZInH8BCzubp+nmcJm8UhMGnlheKYw48EWGE7hFry7OsDWVz83/BM1cW7C2lNQX+uObEBHkSMJWC/f4KOgYLocqHqNn8MtYudQyrSGiNWCEEGQoS1XotyZAAR0U+uYVoHuV+YfWddSxNplOjEfb27FyW4KN0arNm1nyn4w1tVmCa9coKIdIa1+7Qymqn4D1oSduchf/fc/wTBJ9m0iOQC5BhCAUTEDL+YtySsiOzQhrQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by DB9P251MB0029.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:2c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 22:40:03 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 22:40:03 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	enachman@marvell.com,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: Re: [PATCH] net: prestera: validate num_counters in counter response
Date: Mon,  7 Sep 2026 23:39:58 +0100
Message-ID:
 <AS8P251MB0001B264DFE6DBEF30DC45D3C8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <f52b173f-79f6-407a-b7a3-f3b94f34003a@redhat.com>
References: <f52b173f-79f6-407a-b7a3-f3b94f34003a@redhat.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::8) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260907223959.113027-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|DB9P251MB0029:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f96357f-a317-457c-fa1b-08df0d30f470
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|55001999006|5072599009|51005399006|15080799012|24021099003|25010399006|23021999003|37011999003|25031999004|19110799012|8060799015|2604032031799003|3412199025|440099028|26104999009|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2b/NnFLap4R348yq7vQ0HUNBNB9dJf39vesw3UBq9VHk7HMw6oQ4CIF+HzPg?=
 =?us-ascii?Q?gbJFiKdAXDl1K2sdzM2HExKp9foRVw/Y/qSudq77arTMwFIFGrIlZGO0LxAb?=
 =?us-ascii?Q?9Z0x2JkQGw+RH/wnvdC90JME1Cy7yXFvyYZVBGxMuU9ABNRJuPKM+m7AUZVo?=
 =?us-ascii?Q?SDYrjz8J3hIdcr4tF07fzJDKaTAXg82Kn3M1BxLqviltUoj+OMy8dm+ANj5a?=
 =?us-ascii?Q?+PpD58aHomypYMIHPjF4c26o/R0cZeoOrYvNeH9RVLcNdxtpyqGmX9J81gKI?=
 =?us-ascii?Q?CMONbBZARf4EQX95hs/NEzx4I6ZZK0UgoXIJ+uMW8KwTNTf1ZrSbWyoeNHB0?=
 =?us-ascii?Q?Q9OcnZWsKkMw2JclMRGZE4AjMpXVl2zr66r3jq6ES7KvXo4pgthQsqUSLsM7?=
 =?us-ascii?Q?fuiNREkS7s6c2HOxYIO8Jzfn/O3ik1aQHRLpDBZSXUZpSwF0nfqNc4KHLdEd?=
 =?us-ascii?Q?m97Sx0/7QmzwyHhZoAnX/Ula0XzznR11XGjsU+WZe26vxb1K4igbztZkL3Be?=
 =?us-ascii?Q?tHPQdvzmGBcZAKmTt/Qsrok42L4wWEAorM5xEp7tOJr4UrSp3EgvF6NA/zYR?=
 =?us-ascii?Q?wgh3AMo2De7niZWYVwrpcWzWI/MSTYAEeqLFuU8qJfTrYFlY3CluWzqMpBBG?=
 =?us-ascii?Q?Sac2JAg+J2O0w9JqeIqrItqTrXtntxZe3jJk+DFKACbOjZbezdLqHowqIHkP?=
 =?us-ascii?Q?D+yQwCevVuLNPF3IZ8EuPWPII1v69BFQoYle3db3fAS24dvhcIy3D5iDvrSN?=
 =?us-ascii?Q?5N1NeizV/znL4nm98rNPJj6Ee74hhmgkVhuXN+D1hMkbAeePHpjrWuoDGxYz?=
 =?us-ascii?Q?0qJfmPthlhtbHGSPLVpeDaZ1eGN4HVHgyr64NX/9wOuw1+iww4rudnPsN0hO?=
 =?us-ascii?Q?m2l98rSAz/KF33tPAHaJiiOKUpVep+T8gn+l1xHfsYRWYMrXePLEzTt3HbAf?=
 =?us-ascii?Q?QLT9qPNpugO4IS3otjhF1FIZDvs9OzvPLDgvNZ9w0JWSze611A3M1DtvhEN9?=
 =?us-ascii?Q?Z+1+7s8yRUYkJB0ITMvRQ6e9IUBJbSXMelFj/7UwLs+GGkcE47V4dpuqHf2y?=
 =?us-ascii?Q?royatYYP8kK4ASmhR9LtlgHzwp8OfW1E3Ep7VkaSmU2Wv5a057E=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Vhh4Tu/6WsYCVefAJQnVpTRlI4OUYenpT0FWwmAqlDOzaZzOPIqTWhrhvpn?=
 =?us-ascii?Q?GAXHtyi+ntFHR1IfwOuqX6yd6fmxVEE0LeiASOOm3fkyiz85nX0efhxIZ7H5?=
 =?us-ascii?Q?Rfzr+LWyNHhcDAc84ijhZb3R9nu42Q1iglaaqrXYTLJoyGur8OLradrY+vJT?=
 =?us-ascii?Q?bKCAnAG71Y0p2+4hes8tFnGLJeymM/nvhZUHmlm14gnfhrhxOIRLmTYHMSK7?=
 =?us-ascii?Q?FjUhDER3yXJ0TBanQbRMcdEGWZRzLQi//0++BGYMfbJTWr9HHybk+djQXTW1?=
 =?us-ascii?Q?4gEio6xUhZ1omGFQpGXfifrnQWQIsWccd7yUaxxiTusjiq+gG/ilcIBMECUE?=
 =?us-ascii?Q?dGFzkRHUK68SwS0uuPCZGNmALCM7aRoQWEhIpqtq8tmOhTS2o0kyrBWlwqRK?=
 =?us-ascii?Q?OOPUA41NiFjGh7anYRZ4Aa6xloiYWtMvxfOSAFt7A9/xjZxQJ8LCTWBcVKpb?=
 =?us-ascii?Q?bmSqiLWsopd7yTZkGiZNeUpqkfZ+qzc1SwhNLbP7r5DVuz97pYpnOiDxSjQa?=
 =?us-ascii?Q?XllDC8nGv8KdsIXAFOpC7poXVRejHbnQUdH7gtO3TbUDXyX6qKH8RPpYhNV+?=
 =?us-ascii?Q?BVCO/2v/r5vQy7FdLI2IhN/TOEteZYSDECo/421aaQNyTr0YIfA+fZXxWhWv?=
 =?us-ascii?Q?My/je1Lr/qrz7pCWVToAz/uhymYiA1BpSIGsLT0rf+YWAcMbrpQ/q6/dtPLp?=
 =?us-ascii?Q?ETY9B5LP4vF/SiE2ePQMm79q9mRdPP92NxTHZo8rHBBMlaCxQDKhqGfFp8iK?=
 =?us-ascii?Q?RWUtkyakuzFWwz+SDeIVFGUk2alXs4NHLbrGU65c8vWyQtjas7xBZKpoqYYz?=
 =?us-ascii?Q?QQQMOlwejPU5d7LiYpdF/cFL8TpU++cpnl4LAU2/JCOBm6QYWf8Wq9CBKB9R?=
 =?us-ascii?Q?tdWILB7P3QYViXvDJAqrmfDj4C51IfiumKvvH4MaPgN/M0drmfRsY5vGwWZu?=
 =?us-ascii?Q?x8TZjAWbNyw+nwZRhBjMqqNrajQ0hCvYbPIbTMAa/mBbKtrTttS8iSHBuzRO?=
 =?us-ascii?Q?sD/aLlaGe/gf1v4w86X9LiICuFrnYoeY+rT5NVGGQS4eGMlXUEYeYeWnb5pL?=
 =?us-ascii?Q?enYMLLcEitHv5qP92Ft9q6uc41YEMhby05Jn4pCmeccBwDo3jySfMgR1fAvC?=
 =?us-ascii?Q?CjhUajU9b22NIiTl6k3Ay3C1Oa9ywJXF1kvdJR68SR6enrbbuELvsjgPwuwW?=
 =?us-ascii?Q?Vts4xb+y3ur3MOzOGTZTn+pEzOl5/8nB84YNBDLRayadadD42uE5GXAhf1FL?=
 =?us-ascii?Q?tciiiGjPjWsK7WwvFqD2WueMveOEuMZcbpYj288qskWqIxXJBy86ha2gLFp+?=
 =?us-ascii?Q?1v/qDOTEE1WgV2aIYzd+sNbfVkmaXqHnh4xKZcoyOXIP6Hj1WwJMt+TrxdlX?=
 =?us-ascii?Q?75MThNS9qx0AxEbYm/zKC4rlyCsl3d0Q8y+iNXFcL8x8+A0v2NV/EiLUbWWx?=
 =?us-ascii?Q?6VTBPOqCh5Gpp4wanwg1EUpYI1oorG4q?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f96357f-a317-457c-fa1b-08df0d30f470
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 22:40:03.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P251MB0029

On Mon, Sep 07, 2026 at 11:03:19AM +0200, Paolo Abeni wrote:
> Patchwork shows more than 20 patches from you in flight. Please read
>
> Documentation/process/maintainer-netdev.rst
>
> carefully, especially the section about the 15 patches limit.
>
> Stop sending new patches until are the pending ones are processed.

Apologies! This is my bad, understandable if anything I sent over is to
be backlogged. Will ensure this doesn't happen again for the future.

Kind Regards

Aamir A.
