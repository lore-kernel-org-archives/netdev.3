Received: from outbound-ip199b.ess.barracuda.com (outbound-ip199b.ess.barracuda.com [209.222.82.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA632836F;
	Fri,  9 Oct 2026 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791505076; cv=fail; b=jfjglG16IRsucjtKFLFn46AcmkSrFylz6wwihpOOG9oB+Y06D3J7DmTkDgHzVFCHrpi91d/H+MW87eRY1Rg3OrudTRjArNdrr2XwGi5KwNQCpZerV//2ZpbmU1ZkxujG4opzOGQ9QnkBtY+KCJ8JRa5u457Et0NnVMaZ63RIW18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791505076; c=relaxed/simple;
	bh=+4EQAPGW8b7KJCi1mSlfiEJpjEV4KxuasjWS4uuTYUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J+0DcDs8LkFALoQBz2brGoaA7sG+1tpmsFuhcvjT8JW4rANzFXG5jG720GdOSKMfX+L3tmlbWudKHAxLCMFnobTjDX409om+P7+UCy7JTAS5kWrrwvHCO/E+KcYhTxWMlOWlwDM5ZPNcRgg2kKrpIs30HFJoCawHx64N9vXy/BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=h5Yjf+Za; arc=fail smtp.client-ip=209.222.82.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="h5Yjf+Za"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020074.outbound.protection.outlook.com [52.101.46.74]) by mx-outbound16-175.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 09 Oct 2026 00:17:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUzDAdoOyMtTtVp8hpxVseiHz7m0482ILjLPl1HMqcS3T/hKJQ1rOqje6M1OZ9e2JQ7O2vsRMhiVSAhXkSPXdSUnubI7kY4LOGZQn+9gL+dGvxdecWiCd81b8aNZdxw3DESeStX5AGh/42SbIuuR/YB0dHzEAdjJeBBS40WbAe3tv1k6ghtDeTp2IDbJ8ZWTm5rDEnH2YTC+0ZHtMSDaN5lQoDBjLSoSbz0sE6ctO2WIxdOkM9dxWqhhbS0njDiGnxwBVpZx6TpVEh8hhIoFAIi245VIbGVjpffNG17iFE/0rrsPUs4AONzcHZx58efC+F1vdp4ZtGojU489Tm2p4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CQstHzW+r7ciyO/CNMbvkqiFeulV73MZRJE6XIBJeM=;
 b=xRH1UqdLqrs/w6wVYRESaUQXwH2kxsQpZAQb8Wg9kyEN0iuA4bZYk2R4BVOwTsiE19bE7CEP5TQ57sg2QlupZZ9th5JtasGQCE3yEX8lEU1LlaJaYBGU7Ur2zVwYL/ChWc4CtssbK4GOUyZz3Tz79Vw0nvJtVGD9MZ5ViCP+OLgrLsSTDAcExHeNaxpP42a9JUfACKlSJIkXpfzi9iRUbF67BxYpm8OGfGFoCYpsitksKJ654mBCfJ4ZQ00VqW6y2GW0ZonL5lkeokJMOKTqCO6T7XLj3TqO5nkTVeX5X8GTo2VBfyOJ7UFSgivZDpwnufMV1W3Aje3k11dqewcGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CQstHzW+r7ciyO/CNMbvkqiFeulV73MZRJE6XIBJeM=;
 b=h5Yjf+ZaVYoiGV0SBcTXdIszC78H7EHEk99hYbHiFp6q6Q1bZOUQ6ma/X3C1LAg7mLw/xv97MDBoKIN1FVmvPFR36CbPajtpD7BaNe/lh+bBURBDfpKEiAu1Jl3SB/EbscMesjIRZfnmlMaZcgg4R2S88F5s0ZPkY/4hVHdO1V06+bRq8ok2I4HrPTsS2N8hGCiCEMeS+IJ07x8zeNxdOVLGdXsAjYbpdyPvq7SOBjIqv5p7Jqys4vQ1grOt7t1OJFQ+EudCcdJVH0a0pllSMNfkyCdLqt2f/QJ4hG6vjDQWbaZb8eW47P0qwdY/ZdRDxy2NVTw3d3nRU+tLT9Gw1g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by MN2PR10MB4286.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Fri, 9 Oct
 2026 00:17:19 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 00:17:19 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: peter.hunt@opengear.com,
	Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: ryazanov.s.a@gmail.com,
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
Subject: Re: [PATCH net-next v8 1/2] net: wwan: core: propagate modem control signals to port drivers
Date: Thu,  8 Oct 2026 18:17:14 -0600
Message-ID: <20261009001714.1078580-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFEp6-2QsKyZfEdSotVPhxVNOyRzncUphqLY5cRwHXGJiEbzuA@mail.gmail.com>
References: <20261007182238.1154851-2-peter.hunt@opengear.com> <CAFEp6-2QsKyZfEdSotVPhxVNOyRzncUphqLY5cRwHXGJiEbzuA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0035.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::7) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|MN2PR10MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c783f2-fb12-4de7-dcac-08df259aae48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|11063799006|56012099006|4143699003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CGIfPyb7hNCaf+b4eeQWnJ4zvDORztct0vq2l3sdDGRqqkzCunDzhnkhhPwU0IJebZQPKI5HCUUpJBpByTvtcSVZeJi1uJ5PwwFShNHq9toCwjbWCwZnPPh7HHqDB2uvRAhdsIxUfZOzIijasNgKnsRw/Hf7i04fJYMAta/zqSeE92rz1CQirHlo2BiD+Dmmtl3A7zHy7lUY/oIx6fD8jCdxjwr72WL9IHmGWNYaHTsZDU2of7zFbxDvdkstaQ/n2e0Ejr2bGX8Rym7IrqpfeyWT7LNyBIgyU/uj366ts50vhDnc/nMMI1LCvBn2RJHHM6rgO7e9qd19LRRhd/rFALsZqkVR7ToWuS3aAjifvLwq0LeUDgJSfKmEm6vAvSs9lSrmI44pRa5DoJ3oWnOHKNYea6iNbSYdhEpErnwPXPfn8TMLTj00G/hxYzDXq0/h4JTRQFNUyqXKf95hM8LMtRih+FUBsXOWn5GhoqhOBjPkq3K73yIQYoTVqc5aiMD7o69gbVnMHjXL26bx82dYxlMzVbhKO8rG2PACmmR7VrZzGdQIpytZy5oH6iHWJLi+B2sj2lBlNl6lvl4mJZLOqRPtPMoLNxVxUCNk0vjgYTgbez2VyJEZJP8yh+57IXMQ6CiukIU+KUp0L0Wh+xS2mu8tZ8d5+/burnsjgq6l9zM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(11063799006)(56012099006)(4143699003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6P2bezdP9jNsVObGkZ1Te3JMI26pXTCAKDwhqHa80nF0kJIqN8DRdFlcfkP1?=
 =?us-ascii?Q?uZtyCxiYXE783VY4sAPMU2aAMoPhOeFxHp0Ga48ctUrG3Am3K7eB3+Ox7Vrw?=
 =?us-ascii?Q?ZCht+WghnSjHMRP3KU0NU59+EsW0/DtH5CwrXAeHMH6ln/PHln/NPMyvUj/H?=
 =?us-ascii?Q?JfOBE9jLBHuX/HmWJlVf/5aZHelKcsZCLwGVUJ2LEfuKZUqiK2RPqCI91xSb?=
 =?us-ascii?Q?p0AosOzvV5GC0gUs/rD5CoEhGbYrWAa0v2fQF0IkxI3O7Q2aTTWR3sSIo/hp?=
 =?us-ascii?Q?x6kmScYu/CPdRPm5UW2xAQQsDtcoVB/mAUn3z9MJ4kh4SyBI2/9AMM0sogy8?=
 =?us-ascii?Q?oTnsw/u7umMT0Bnw4nrrzavx2Ey2oqFQmYP8P7Ij1+8tiKPGH2dlnqE1YA5X?=
 =?us-ascii?Q?qXW5IraybKWMcukIgLzfQChenKWFSNGT5OEyoqfrJYWzbgNlULEJyLNF5def?=
 =?us-ascii?Q?O1cYuN+SkpzuEulHovm7nf628XS2GJX1obR5CFKPxST3Rl8XZGeMVWYydSdw?=
 =?us-ascii?Q?EqrNORsKXf81YgEsBNlfyBD7enck2op7HwuIaZaJ9A322NNEj/aw1CWpJuAG?=
 =?us-ascii?Q?KFqw6Ker075i+ZCZGIUvFykUZijPZt/O1RdC7PFSL59XZsV1bBwzzrF5KGnJ?=
 =?us-ascii?Q?E58rv1zcnarfMcZB0TzNJtATdQN9mymIMiGjv6GO2ULrAmwNV5VJHDuwXrKJ?=
 =?us-ascii?Q?fNGpXtdofkuBX3WDfCo5pDRokPH2aRrLL0rgabWccYqLVBaqmTr0H54jH8Gy?=
 =?us-ascii?Q?3OybvnKy1Yzyrug0guWixfJXwrkL7Y3+xe/JX5oJuD+B+WxchLnkDSSduaDZ?=
 =?us-ascii?Q?vT+XrSpeLgqcCm+pZBFZ9Y1BJB6VCGQjbpsAke6q7+54hxNWntSkNcI3blKz?=
 =?us-ascii?Q?fh+HFhEmfULmjVYuSccymp2zeMn8s9JZBUJw4jijMXcAEswNADi2xsqN47Iy?=
 =?us-ascii?Q?kSbFHeDFb+THxLw8Tlsu2GfHVJUBQbEqb9pE4ojpzr/3dOrXrYQzyyIJTjog?=
 =?us-ascii?Q?+YCudD2TM+tlrE+fPvNyTIGbSpT7ovOAQvg8dkgG/FG3j1lF2ykWLljYqnqj?=
 =?us-ascii?Q?uoj/zK7yjze0XfKuKbjCEi5f77a8ImKk2tvc7tcMS6Hb2wTHriIvgW4ttUH1?=
 =?us-ascii?Q?6b2pIgnTU7DI0bSLBfob7xIgDnZUUZfaLXsbOEKVcmlfYcOaOErDtLgI8TKA?=
 =?us-ascii?Q?2MY6n41hYgWcUpHNwSEoqasDeu9twQGRfeuBhxoPTQKxvoFWErNPj7e3dOJQ?=
 =?us-ascii?Q?9hzUIOXnSb9vrfeYkeIqLcCrERMolPGh+wMxWzVOQJXlg3cXXhK9d7e0c66c?=
 =?us-ascii?Q?BnQ02PbZR/QDdcxOEp79IMPdKU5ZXqrpUTfAXUqhkKMebB8HKi5+XNlSaA27?=
 =?us-ascii?Q?CfziIy4gf9f5SH9HXaqPc0+EkGpMfI/CEyq0lts8vOchWPDXL9FXk7+iKIfn?=
 =?us-ascii?Q?qKaZ4EVGsifshd+tlC8XujErlsw7VxpJ1RcqoV8miMI8cU9QUPA1tidfzzPe?=
 =?us-ascii?Q?TPBWu7W9ztOsDCDMpjLmmmc/qvscY1zIe0cFvzI/Oi7gC+3EHu/TBu0OJ1Vd?=
 =?us-ascii?Q?3/+coxWW1eXHReK9X12jLPJOw/qiSw1i5Yj5RBgFi/MUHDrJ443a28XLj0Im?=
 =?us-ascii?Q?SWoJd7bTPM/gKYGcENScxKVLqkWinfsGQtdoYDnt7HV8GPM7TrSA5E3x85Hb?=
 =?us-ascii?Q?e8sJkRB2hke3W3LeuYm4+qzp+fkfrdueifsxFIFkqwvbpn7r?=
X-Exchange-RoutingPolicyChecked:
	C2ga/JgIZ4KTuIxmSV7OVuOaiNe2L/mFzHg1Zn/jsbNdPpk3H9nY76RVJWIbMOEgSDV7iiBuCO06sQbkIyz4kTOZaZvfEjMlhKMBtdkxZLRyoK8cQA3QgXp5ZYRMDc5Vu3PbpLketJLUVflFowKxDnY82iljXdN8wW9zy+NgMC0PZvEQkoGNs5RgSEZCO7ks/ZIlKIIz+rvUp/JPz5BvPsEOxJaefJbfAJz56SvhZbEznngesbR/ye/PP1bFFJXCNxEfzy/yqgLYlYCDTdxJRzQ//5EC0JMX+lwlf/U8VKqbeVyCKPR95Yu8jJx7lMqGGTZaMIiGfFs4HgUBvZphJA==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c783f2-fb12-4de7-dcac-08df259aae48
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 00:17:19.2725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VENM2JizP5xnBWfORT+ZAenj+wnHBeMZY9hi0LRo4WfCHs0JK1fKiyjbWS1YbTf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4286
X-BESS-ID: 1791505042-104271-9967-1013-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 52.101.46.74
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkZGpuZAVgZQ0NIy1cIkxSIlMd
	XUPNks0cjQxMI0xdzAwjTJLCXNyDxVqTYWANLeu5VBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276703 [from 
	cloudscan23-7.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Hi Loic,

Thanks for the review.

On Thu, Oct 8, 2026 at 5:19 PM Loic Poulain wrote:
>> +               if (port->start_count == 1)
>
> You basically have the same check above

Agreed, v9 raises DTR/RTS inside the existing first-open branch, once
->start() has succeeded.

>> +               if (port->type == WWAN_PORT_AT)
>> +                       call_dtr_rts = true;
>
> Any reason not to just call dtr_rts() whenever the callback is
> implemented?

wwan_port_fops_at_ioctl() serves both AT and QCDM ports. DTR/RTS only
means something on the AT (DUN) port of these modems, QCDM is the DIAG
channel and has no DTR semantics. Open, close and removal raise and drop
the lines for AT ports only, so I kept the ioctl path on the same rule.
Review of v3 flagged the opposite mismatch, where a QCDM port could have
DTR raised through TIOCMSET but never dropped on close.

If there is a case you have in mind where a non-AT port driver would
want ->dtr_rts, I'm happy to drop the type check, but I'd do it in all
four places (open, close, removal and ioctl) so they stay consistent. Is
there something I haven't thought of?

> So now we end up with two mutexes essentially protecting the same
> state. Since dtr_rts() is always called under ops_lock, and the ioctl
> path acquires both ops_lock and data_lock, would it make sense to drop
> data_lock altogether and rely solely on ops_lock?

I looked at this, and my concern is blocking writes. wwan_port_op_tx()
holds ops_lock across the driver's ->tx_blocking(), and
rpmsg_wwan_ctrl implements that with rpmsg_send(), which can sleep until
the remote has space. If the termios and TIOCM state moved under
ops_lock, TCGETS, TIOCMGET and the rest of the AT/QCDM ioctls on those
ports would wait behind a stuck write. Today they only take data_lock
and return straight away. The automated review of v7 raised the same
point about the TIOCM path taking ops_lock.

What I'd suggest instead is to keep data_lock for the termios/TIOCM
state, and only take ops_lock (with mutex_lock_interruptible()) for the
->dtr_rts call itself. v9 already reduces how often that happens, as it
only calls ->dtr_rts when DTR or RTS actually changes. Would that work
for you, or would you still prefer a single lock?

Thanks,
Peter
