Received: from outbound-ip199a.ess.barracuda.com (outbound-ip199a.ess.barracuda.com [209.222.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70518FDBD;
	Sat, 10 Oct 2026 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791652573; cv=fail; b=ZHHH0dkJQA7p+wzAdkwC6kXpkrNeyRZcrrzSek5R7rHrXCeRh6SDmuuXPEGjUjtVCr/YM7H4BnujXVEu53BtQfneyPq+6dSLxDIpSzRYYhB5BExpL0Ntw4dSXWYfAi9JptJIHRfcXhshgqHWtGj5UtJgb1tnTZ6zOvdfAkny5MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791652573; c=relaxed/simple;
	bh=xDI7UlboCzoxT0lQUrKdCa3mxuOO7NdG7mgC3LZwvsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R4UfxiEshIsfR8tWwmYEe1jYtq0sxu5qifn+RH1SMqg+ejfGE1PqP9OeGBDuJcPSctZMqn5h3J6PD+muE56J2cDbqTVhirh2WDJQwJ5U42iwvUoCXdyWbzyaixeQ+pHRCE6iy6sK8J/8pM0BIBUJL27TRcyqGih2JCJrCIXrg3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=WLCzLEGb; arc=fail smtp.client-ip=209.222.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="WLCzLEGb"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022080.outbound.protection.outlook.com [52.101.43.80]) by mx-outbound11-208.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 10 Oct 2026 17:15:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMXZR5gS5fT74PwOCH3wmxEBR0gtgHIP/PH6/qpxFSgn/6KWqEiMfxgqBSHZzPFZvNQxWp+dKRX9Ry8XE2Hlt/zgwknCQ9TIid894rMdt6Zjk2ZkxT4ldofdE1zW9L9ce//OPnfWCBO5L2JIF0hXmk4qhhFVlCtBJH/YAq+BOdGd5CMuJhCcQ4xCvLO27gvumYMWNHLdv56eNVYokThgoqwg9xdTYeZIcjoycwo241d71VY0t+KKgR4we+5GH2g1Qw2rd6AD/45hJJLI5u0MWn5l8PAMN6oV1Qq9Elb0A1twECZiGOoHg0wJyfOmSRdV83DUWoVhQ/VJaApuEIc2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtDxXTDdSe4y1cmFH2l+06b/ykaS5x1dLKeNkVOd76k=;
 b=Ky/eX9Q7i1zcZqZX6fETE7lV0lNDNcMSwA81Ty82by5qzaSx3D0IZlfZbiDAYeKH7OO2AfboPZo6GrarpepW+Eb+1eGIhdOL7Eu+vPK7DzZDzR6w2/AruMraqjr7wRyq2fgLznaiAIr9IRwjq9tQ/BC7dRLYeeD6iERhl1ZZQdmkdsWHv5SQxYXJomyJylfmq2YUTUfLiInmaMHlq8jHnvP2bgZCi0XMxVituL/bdcCC24NmdTM92Z1nkcmIEImggYXllk5a93C0/6eA3H5obhepqZufd0QzJTXIqrlflTXCaogmsa5iJepkBtP1EDU4x0r9Pfpofy30E6mPHvsoQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtDxXTDdSe4y1cmFH2l+06b/ykaS5x1dLKeNkVOd76k=;
 b=WLCzLEGb/vwZlnCd/wfCsZBNXCrHAy5aEj+5iLxexIAft+sbPzUiX2rqrw+7IiQniU60dqg8FtFtbcD8rrKK+EuytIHWsdt45JVHKrYL46snfHwvDSwEs3PECjqxmUn9QCCO/LZaGLwhYK9m2tZjVPCOjhUKtGDlv/t9dVf+HPxeRZDdLt2kT2l6Q5/pLiIfV5HrVlwRwY1HCfRXx13ENTEgIAW3AgBUQs+k9my7oOjlQnZILEfQHm/EMlI0Cp9wKFYZRFTAyLQULCzYhZPKjDZemv0AqhCD0u7PEYeH9KjylrP25wHSdn1PS4T99PYBEwU0fmjXuyaQ5YwnOzUU9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by PH7PR10MB6310.namprd10.prod.outlook.com
 (2603:10b6:510:1b1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.5; Sat, 10 Oct
 2026 17:15:34 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0522.006; Sat, 10 Oct 2026
 17:15:33 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: loic.poulain@oss.qualcomm.com
Cc: Daniele Palmas <dnlplm@gmail.com>,
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
Subject: Re: [PATCH net-next v8 1/2] net: wwan: core: propagate modem control signals to port drivers
Date: Sat, 10 Oct 2026 11:15:31 -0600
Message-ID: <20261010171531.1659006-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009001714.1078580-1-peter.hunt@opengear.com>
References: <20261007182238.1154851-2-peter.hunt@opengear.com> <CAFEp6-2QsKyZfEdSotVPhxVNOyRzncUphqLY5cRwHXGJiEbzuA@mail.gmail.com> <20261009001714.1078580-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|PH7PR10MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 6850609d-0125-4e04-7787-08df26f217b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|18002099003|11063799006|4143699003|10067099003|22082099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	StJqX07xWZmihxiYcPiY4QioVpL+a6dW5wij3DByIEkeOvn794gvWqwZtghhZPfbN8SF1HIdeRsPCzW5ZIH9aCGl6MsUMRwZOQ91H5gx79HUIGMQk8e9oUMcTe+NcSL9JRW283fVOycSZHdb8BA2N4gDXUE658ZCR0p7fYPmdiTL7wiuVBI7BcsLQ03x/KVai9fut6+DPbaJwH6h9NGdfwsxqKutNWHTHaESuRZdQALHwzRwFJTdM+/jXY/hczXNs4tdtkZMg7Haki8o1KvzwzXPdkq63pp3Av3/akz7NYFscLjDYj3vltEyUQUqyxBQlsrUF30MAQYi/GviUu41tmYcvi1F2d6XhwEULhMZR2u1v3PXNqEAaULgjFqqT7AFZ7Bdq55Y2KzauvnFxGgQo1ownjwb4A0lBAakIyGZAvrP24HUlj0GrrVIgpAQfEB6uX2aP85aUGg1ShFPMNnHhTAGEx1Y9dk+XS4xF/rBwCKVb3pZ+WW0aftVDB+R0OZRziWHmP6xCsZXgpNOM00C3zqs9tBIjZPlWH/PgyJ74ibAARhISDX26hOuv3LifMpfhR9sk8hUYH0PfBtQyb/l8zlaw5YAuhBapFluxbbNI79d3r3u9eewQvmkog/q+2D6yzF5WApolCj9Gq05cDMYuM0cRn73g4+NUEVKpIlNpYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(18002099003)(11063799006)(4143699003)(10067099003)(22082099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7bNzLbh9jK2tXFVV5TeS+VIB3hUKSOeoJrTAasfkXLQ4Q/x1Hfb2bior7B/U?=
 =?us-ascii?Q?O/Lmfenr32jlXeN6Kn7yjmC50E4/adLF6ZKi1kk6JVrfXSO1cZwA+3LMmPJS?=
 =?us-ascii?Q?VrGP68LvndEi0moN3xlDbFsQpgCbseac52yB14F6NgRQkJn95Ikq2252Kpq3?=
 =?us-ascii?Q?g2jHwrtg1rE7dhkk60Crc9FE1m7QOKsyYX4PqEr+OnKH9OQAImqCuDD5E0e6?=
 =?us-ascii?Q?3x7ePrCMM9QQWS+i0Cy1EVvn+a/Y+ktRT9YMkCrIPOlc2VM9cp+PTnjS8je8?=
 =?us-ascii?Q?QNUId9KycqXcSmBqu3Qf/F6ultCR49qw0MRurdz+029NxhaA5/zGN20oh9rC?=
 =?us-ascii?Q?HPgUJDV85gPGC8bWdElDMn89M/PHFk8RKBTWUD0Q0DZXro8qLVWTOcrIR/rI?=
 =?us-ascii?Q?3nUoLkM/laESvJVpTUMOKbMCPAChJZntRJR2w7z1xvrOiS1GkUpCMzHfHs+f?=
 =?us-ascii?Q?z2SveScTENOqmC5M5kv2ASlKIbXi7sOAV69TGyIxk+kSRQ8gNRbttciFGAiP?=
 =?us-ascii?Q?/JILclVMlJCxhyRnZLbHW+c7d6dwfcMnp4ksXkmkhOKuBmNgTosutbS+6chl?=
 =?us-ascii?Q?UTjxU3brhUA/enZmNeiV4gtZ6e725B/PMc2X4CIs4C88E2oAx2rrNwoZXy3A?=
 =?us-ascii?Q?ebu369O0Lg9ia0gPHmp3HUvO8U4/IHUSTKTaatOXtnq+8j+abcQPr14+YV06?=
 =?us-ascii?Q?TFOo/4Aqzm23iwd863fvGmy9mk09q4qAmJPgLJ8qL0oyUXsctx+JpPTbNaRJ?=
 =?us-ascii?Q?7h2xuxI4OyCWkzG2/h9wv9KJ5a3ZEzusGA71eHEVCJZyPI6Ge2x6Zfjze5LL?=
 =?us-ascii?Q?cIAJAzUTbzdpH1hgahOyaAfpHMbk9P9ibEyBhUjL1rBYWn3QpBcYS0GwCVSF?=
 =?us-ascii?Q?R9GHf394BaKqV3y/fmKQylF1kotibiguQCcXx+czo+5nsiCDCO9+9gA9cQY3?=
 =?us-ascii?Q?2vQe7c/rmfbsYi8Utl3TJWwV6/KVcra7IXyeHa1nFIqqEBlfoz9YSojoCxfJ?=
 =?us-ascii?Q?WoHp8KvceakKn9LDZh5nwnK38ggBHejgxxC8VYGPnsTwim+uB9Iqi8Smoh2C?=
 =?us-ascii?Q?sD+0S23XY+QtWa1ZXaVGrs+38rwJiqEFsjdV2/I9C/V+XS1Bhy6s4I27b8iN?=
 =?us-ascii?Q?pG9jQqQYAM1rak45S1mzcKcZAHT7pI5Zd+T2yXVmElvxtXqrJo4HwHqoYeYl?=
 =?us-ascii?Q?qa2pX0a3VJ7SwgUuCGTUHupHiJwnkrWKf4USit6isBX0jvNGsitwp4QR/cE4?=
 =?us-ascii?Q?Ndem4O3qCV/2DSjgeUXpw6uZY0mzcrxl7tbSK3b1flKi9XdHiKrRbdIGdvjW?=
 =?us-ascii?Q?LZOAndm/qJqBYMPzFe7AU11T+5Ji45OvtxvsbxGJFuy+TiXBwIZOEnqIalRi?=
 =?us-ascii?Q?qITmB1MeqmhKdIZHQjyiUfIgNVUs2M2GBGAStMRTVHH1203HZ3D1YCfq/eP0?=
 =?us-ascii?Q?KvOlhlLqY6e1vQOi/6LGHjWnHQN+El4oDfurP/ZpduC8r+wM8ZsTjRde+vDn?=
 =?us-ascii?Q?O4Lyk4+o8CEGwHnnwX/m08H+30m/0LVc3KfqQNv1FuYDINAl2TeZS4PxHsuR?=
 =?us-ascii?Q?YSkMrzDTQ01fWZnhRuVLOr7Yt3g+RQFYL+s2e2dHovE9h8dIeI8TB6KpKjyL?=
 =?us-ascii?Q?zwRsAIGbQwii6MZcBShZUj+2SqFQNi8bfvmK7nAhuTIjV7HomiHA6LcpghXm?=
 =?us-ascii?Q?SQCJoFhKoc1hvv0vqT63TkbMEy+6/h1EudDA3A+WNgiMyl2o?=
X-Exchange-RoutingPolicyChecked:
	q1AZGGNRuA3Wvryha63t0fJptN8qTLYClWUsEt6uFBlVBnIUShUkuiCR6exNx7Lq8DK7e9oe5phipEa17xvnrT+iWRpgYKo1PL14QhK34KW1xVRHaAv9sLSpPIMP0i1p9omacJPhddhMSFFnmMjClIKtRMdkdHYUq1PI8JMQaiWuq0oyJQI2iRrxOWW7NeGHnmTHscnsK1I/dQqrqsd2sKwFrebF6c+NVEPkXtryImU+SKM47mkZTTjnKhBaPO2ZX/QkZDGSyeYlNnxqda460nWRk5y97aphAp0irr+AiSUkr6wO748EJSRhwpS0WWT5UQflVyGiytXnQbG/wPlHig==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6850609d-0125-4e04-7787-08df26f217b2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 17:15:33.2570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGYuz0A4U+ryfoLuOz45L5wYDQMPFeR9j6qEOULQGDBlYCOYHpy77BJjOLaBgFml
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6310
X-BESS-ID: 1791652536-103024-9149-3634-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 52.101.43.80
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmxuZAVgZQMM00OcXSLCnRwN
	DcOMnM3CzJICnFyMLYKDHNxDLN1NRMqTYWAF/kIe1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276744 [from 
	cloudscan13-111.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Hi Loic,

A follow-up to my reply, as I overstated one point and would rather ask
than argue on both. (Adding Daniele, as the first question touches his
recent QCDM ioctl work.)

On the AT-only check: I said QCDM has no DTR semantics, but I don't
actually know that. I've only verified DTR/RTS on the AT (DUN) port of a
Sierra EM9291. I don't know whether the DIAG channel behind QCDM ports
honours DTR on these modems, or whether libqcdm relies on it now that
QCDM ports have the TIOCM ioctls. So I see two options:

  a) Keep it AT-only in all four places (open, close, removal, ioctl).
  b) Call ->dtr_rts for any port with the TIOCM ioctls (AT and QCDM)
     whenever the driver implements it, again in all four places, and
     leave it to the driver to ignore ports where it doesn't apply.

Which would you prefer? If you or Daniele know that QCDM/DIAG ports
care about DTR, that would settle it for b).

On the locking: I agree the data_lock/ops_lock split is awkward, and
it's this series that made the two locks interact. Most of the races
found in earlier versions came from it. My only concern is the blocking
write case I mentioned, so the options as I see them are:

  a) Use only ops_lock, with the whole ioctl handler under a guard and
     mutex_lock_interruptible() so a waiting ioctl can be interrupted,
     accepting the wait behind a blocking write on rpmsg ports.
  b) Keep data_lock for the termios/TIOCM state and take ops_lock,
     interruptibly, only around the ->dtr_rts call. v9 already limits
     that to when DTR or RTS actually changes.

I'm happy to do either in v9, which do you prefer?

Thanks,
Peter
