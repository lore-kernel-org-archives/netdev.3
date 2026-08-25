Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043BA3D566A;
	Tue, 25 Aug 2026 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664412; cv=fail; b=r0yJlWVGXWdrfXAb/AsNrX5DEUZE0ja0f4vXMbG5149ps2V/JdPoeECEUXzXKs2v4GY/npq64nlDmEfK95qg61t6Qzesk75nV+GdAnia35+7+TgsVd4PoXRoVsUTzkM/QEBuc+kILcbWeV4XYpt5MJEbWFKvhfHhQXaMcBdgh94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664412; c=relaxed/simple;
	bh=UXDnD15U7LUKqiR2SHRHWh84QVJ/36r9jt91bbVI63c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pCDMtBvWkohbOtWJ28AFd2CumBaqlAN1d5dG10Jppox7t+BNlYuj1EzQ4y/7o2WePunDW33lCemZ9FI9bZIyjpPDA+qCha8Q9BXvki2QhuqS6ot/BR4NeaNa1S+cp6y+grfpqeJwZEFa2SQ6TBXPA2YnjOjqOnm5cAmkjva9sBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=knAIXjDZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lvgqW1ed; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="knAIXjDZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lvgqW1ed"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787664402; x=1819200402;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UXDnD15U7LUKqiR2SHRHWh84QVJ/36r9jt91bbVI63c=;
  b=knAIXjDZaNwLyEjI/qzOXvyAMeWIIIvbf4LlEcgnOsrLxHM+DT7wW18i
   QxnywHiO2E0xpbfTZ0IVwXUIa3lRz+URfTqnXk2GK4IH9EsGVf8gITBz8
   d00bovTvI+1YC4YsCjDYXv2MBBQCL8nlxJVam2dpZqiV+ZGnDz20jP18j
   lsrlRv4Q/XOL+TQR0/KPqf1xfNAjcHhbgEU31zepIQj7fe+Syc6yHt3El
   Ix7dcTslEsUPMWQWsDmjxSid0LKR7uLTa7OFhh3436hI3HWCj8Nr5aHBL
   bOK6CDW49fdxkHb0us9DijlMw6oNX99lAnm2MM8j6slHucqZFp7b74XMz
   w==;
X-CSE-ConnectionGUID: K8xwOb1nQFiUZT19y7cI5g==
X-CSE-MsgGUID: 8DmCFKBMSMOJddeTXynrUQ==
X-IronPort-AV: E=Sophos;i="6.25,242,1779120000"; 
   d="scan'208";a="152658494"
Received: from mail-westcentralusazon11010069.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.69])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2026 21:26:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNoGeQTYaq/R0hfsJlTG6uDeYBQ0rEOOHy8EFmRHV+Yb/evo/2WcwJUr+x85ICdFUlrC6EXpUVru7fhEFSMd5jRJJvea6VSNOeYyiHS+Cp5BbXNav7SnW/3swbHCPXtXN5/0Pq3qyGrClq/cekMluNyc2zM0zhxtBHpDI2MOWU+nYtmTZEYbFeEMpLunt5sZuWPH9hKcWQqF3yt9jzuc3Fb4mQc3hqXWRiB1Gsd0RfVCHzxe8sGGeyqr+nEHzA651kuc4rYlmzcSeKwENeZ1WlBCw0CpgJVMueKYmZmMUHLhBxpu0ayqoMbTP4ZTWexX6k/qJ4Xm7OXkIDpO/m2BYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=de/TwCYbAzVcANHSWsKyH8061OLmyXZmjG5yiB1wkH8=;
 b=t78wZw3XAj+1SuevYwwNeRc6CUfxYfNee9szK10NTkH2OhN58n/AvhDn7nbAHYdYo6+tp5GZhJGIl8gZjOzQ/5fx3aMH7D7qLZ82slZufwLHkbqU/bpnfifTqAoO3x+hmsyKMapXAsA8bDmO/SpUKImB7IyVwDpODDqPU7rRA8IOgWZtm7jKzQXXx5GjcK+ZiTeGzAyQWF/4lRDiJlv1ecihy4J3JqH6rhQ5fy6FePj2CA4AfDxwZIqto1qLqRjSBcvUSbjZnpqbBfXZ4AkzTSE4ifNAgGO6CoraBtXfn2Yal6YSbTV6xutziB1I1A6OZ55EfB71KG+ryBxJkYV8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=de/TwCYbAzVcANHSWsKyH8061OLmyXZmjG5yiB1wkH8=;
 b=lvgqW1edoeO59VXiAVP1F67cDd1Ul2Gl6FOomgZCLDBfhU3TguyNN86pVaPddHPxKJtMhucSRXMG0/cUoPNwZaAmYEpo/WijguxoH3hXfxX9sGv2JBmL/cPHTm2wHVFRBFAwSjBnBnW3K/TuUnuAGXZ3PMWXaByMgyVI114xVlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DM6PR04MB7004.namprd04.prod.outlook.com
 (2603:10b6:5:245::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 13:26:31 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 13:26:31 +0000
Date: Tue, 25 Aug 2026 22:26:25 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>, Nilay Shroff <nilay@linux.ibm.com>, 
	Keith Busch <kbusch@kernel.org>, boqun@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
Message-ID: <ao2WptQpM2zSQHDt@shinhome>
References: <ao0mwtt8ePAINFni@shinhome>
 <20260825064507.1499-1-hdanton@sina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825064507.1499-1-hdanton@sina.com>
X-ClientProxiedBy: TY4PR01CA0001.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::6) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DM6PR04MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b845b5-e9f7-4f97-3b79-08df02ac79f5
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|23010399003|18002099003|22082099003|10067099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	bkD3DGXR8W6LWUg4ar1ZGdZk4uF2PIHcFvUq21HjOk4gvJtETshYvHQ8r7r97WBYMTZa5F9keI6p8cB5J0moqweVG52tU3uRGbJ7ETTlakMaJIStl/KRG7e3QNg8CC2h8DovRjMaOPjQdnpqipC/OjLfEqKtgNpi3lGaI1cOXO0+O9MfbkKaxG1ADYaP4ucaboW/fvwyIdc75zO9Obdze+KlkO0W6epkbeeEQJgSDUuJo94tXvbzYbV7DiS4r95eVJKxkQObsw9pZvjjm3eZTdJfo2znQ6WYfRWGKleGpHLUG3JHNSCB+fXHDkAhsmPsEamFeeJ3fqrzf8jemw3yyUJwydnU8KQox/M3yZTJ2d2f0T0eDHiaNz55KvT5E6ihOJu1RkODkGfSSL8G3Vpq4+sXJ0KLOcuKzqNkVYrH1E/ya8n8GzxlcOv/1RDe+gHiKM/8mnQaoVb42Pfs/6XkMqxd8KgcxgZNNFKdZDqvGazNZhTWfmXqCvlbRxAact2+vBizmI6uCSqZTi0xKQHPilwdTEpJNYL43YLbaQgsSiLXfkCO/bKMshe9iwT5Snmz6HPGMuOmdFeD5fgr37LrkmJHQPshNcXFDfLwqZ4U4HGCjgOPjNK5PNjiT1R7AQKWE6uS2lGfCHKkgVcpyBWEm8dMZdKW+vqHQgZoldm6/Cc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oALU8R6Lk4kXqgsuko23uLq5g+cGOvgj0zMP7KKgVIVKkhs6/IoI8WegwzXw?=
 =?us-ascii?Q?kMXfO+8/3SEFbTDKy84+VM0p5PUqnYqFoK1UvxwKU/89P7tmH5GHeMnWE6r4?=
 =?us-ascii?Q?gXbXtnaqD7PxBCoWPV95fOPV7YuqZUFYTN5dhFl0bQAPEqjvYjlkTGaInDWx?=
 =?us-ascii?Q?DL9u77FVTE/jTMkMRHKh/EdGvDWtpV2Q1e6uKqdVdARmymkP6UNN1AoImnXi?=
 =?us-ascii?Q?KjjVk9Nm/HYwgHFvNu35TjoxeAqlGhUPcc1AdmUppf4CPrKmQfPG2sjgbHWE?=
 =?us-ascii?Q?s7b6a2PzP2wnijsiLOTutvF1YvyVoqMPTDUVWvNQBB2wBEFyvwecEL6zNc0h?=
 =?us-ascii?Q?pKf7LmGD8OH4kYptA4u0Lk2AocjAUZIocmfdA95rEP2Loxy2NP36Qd8YQCu/?=
 =?us-ascii?Q?Ak1geCD2Hmhf52Ry1MyFuNlQ+TibuUh/qvvgSIs4Y1IHGsB470cqaFJ3lMt4?=
 =?us-ascii?Q?0LVjC/GX666QdJm0MZ95vz17jzJUxAy8BW9T9Hmts6YjnGdaWvWFdGktA8Oz?=
 =?us-ascii?Q?mDdDAG+UfjFe6Ey07r7xBMGQR4H+xdNCJD5I6/qJogVCLIrdaYX9AqbaOfyZ?=
 =?us-ascii?Q?gx6sjsmUjrt9460aUUl6u4YYQtQB+DfyEt4hM4NbBv0iTsfW4Qbish3H1QB5?=
 =?us-ascii?Q?2DaePgjlux8n2Z5bQmfggmKUMJCJauIGN85wnPMV2eyzzc7xTYQHsG7hjh4U?=
 =?us-ascii?Q?n5p27dHeOy9STJ4IhWugcLtkb0Y4A/p9EjwBZU0nCTzL/TOIfATQHdc7UoQk?=
 =?us-ascii?Q?hI7bw+mw0aRio7m0QC2+qHDf2ACebzrkT1U1uHGLxn/sv1eE+u7jDuQnEYPn?=
 =?us-ascii?Q?s0JaAp3xZjzU/OCWlhK+7KWLpQ74xzZpEHQL25OiO6UYCuwaul1mR8rcXPdG?=
 =?us-ascii?Q?69V5TAyXiFCU6nA0BUtcDsARXjUaq1hb1R7AJCDUfA1zPicaEtQHohwo2VqE?=
 =?us-ascii?Q?HsVltoUDW1n/xSaaLOC+80ZE+j60eqL8ycdPTjwjN+3k6QYneWMVHYffq2LX?=
 =?us-ascii?Q?R4RzbsOKF7VRp7gvwEmhSHUZiBRBL/rBblCh6tGvJk3rExKuBowmUbMyoEBB?=
 =?us-ascii?Q?a+gSrDTcpC1zl40+QuJ9msD5vDXGSyYqki/l6hGCbkuyyRL9lr5MzCftudNt?=
 =?us-ascii?Q?+CefIxNpV94dQL0nO4G09ZwnVbAnWonvoFbByXhJ/soe2HWns2fxTAZoSD1v?=
 =?us-ascii?Q?wf9m2JkJy7PayZU4vBdh3zNq1EWCEd0saY1BLDix0kYo4Qpisv0cDoZ+ZvRM?=
 =?us-ascii?Q?Cr2rf4RxMiwLu/MNmmpb+12Q3AlaA1DR15FdQNPDD6a+FZOBhQ/dlurN2swl?=
 =?us-ascii?Q?pYgRNQIDcShwUj268+Z8VOybOWMvkfclfJELKHvMB/Prawz2Tl1halI6UR/J?=
 =?us-ascii?Q?mtWyHBFGUbvpYmAkmKCp8WaZgMnQTdOSMLEXX0R1vLjIWzV2qEPF9SBvocwo?=
 =?us-ascii?Q?jlIyTYOjQFCLSV6xiNcCzf2n2UEk6gLkDDV0UKbO2dwglzLX87WXRJRCre1g?=
 =?us-ascii?Q?J/c0+EFuGLJFleUIJNlWqc2/cBBULAik88arHvvW0M6Lk8wBdgfVu5VX9Rs4?=
 =?us-ascii?Q?lt0oBT634hvZzF7aOPK0jRXLQihfZnbG4nYaTrPwSLyO4g9X2U/60xAlOVTw?=
 =?us-ascii?Q?5Sy0sN2zbWmsrB5Tq4PiVkqVj8g9S4TN0iOyX1FUBAGbw6NRPSn2tcxQ048z?=
 =?us-ascii?Q?nE8tOwDtyB5opFHJ+D6lBbH8c311L8/Bgqx4Em2vQkUzmHpaUQgER5EggBHU?=
 =?us-ascii?Q?Tq4V7J5+H4OVTKqOYj6+s74Jo7gULdU=3D?=
X-Exchange-RoutingPolicyChecked:
	2WVCOFqKCY2/0DB9aN+7sGJnh1+bRAQfcFN8M14qQwZ0z6idDLumfJf7FuiFocgk+6ElEynKJq2V6UkWsQe8Q2bTPjwlpfZ/exhwQhqRST02KXWLwFLd9gFTMQh+8vGShbb9DSzyOPTGqvvt6viKZAMDQqLfvU5pqwmckGh2CGUv4G4DNGM0rlQr93gQ25xJOsu+xfMYog1jeN5/U+QbBwEJ2eOQ3GoDJ5GSi15tCnmnISOKwFcehYqtUG5Aln2IZBuaSmstjWpZeTP55uoprWmjAsszp5ZXUnM+W82i0RLYCbtrdkocmx5uoXttxG3euFR6JlJokmLCy825R1h1Kw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Mcse1MwbFAE/61yeOdkPtMg/vtC8ZVK3+g224tY7Qd283RORGGl59SfbqIZ59WJ/jGU66AmKo2bdQYDrJzaQ132l/ZyJ+YOqRHJb7PVYADcuFN5dAQ4BsCFluj3XuuhNkKcOUoycd8i/FFiwfq+aUGS2yFTJFzRB2sDXpMnMNQ50s1yp1VThNhmyxtuctcGberXLDt3/F6aiHemqjHDbqg6S4BlidxZMN8jNyMJoXyB9k+p/kFDqFH0+7hjy5V3ZbtiCy9pbFgqj6TdKGL0paIBVelmkYJpFmjMRuiLFNIV/Us9QaNHuttn8Mx6IsQL4SWMFEBYV036rwyWw+oDSlb2IsSPdruZWChWiG++0fP8ahOvTNj2E3M4VVM5QXLKo65ZHoeRa9UcNvo6d2rnoFioP5ONLICIdGJn5vPm3Q1IORRb/su4P8rCra/jmkYV6Hwy7A1rReJ4or2VUtrE6w/u39u4MYAhtkokXmFIjYMeH4s61ZArcggbKVzuBMIuMEZxwwfIaYPZhf8ADur/RoYSGS9QX1pBxV7AMvqREo6OO5gwOQfx0uRJl/ek4Xc+HPxsyvva4Ta/byo/wtMp4JHHX3Qi/JCxA9UmmdVThVs6t1rlzqPMkuyuJrigTfpJ6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b845b5-e9f7-4f97-3b79-08df02ac79f5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:26:31.4559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXmr8nMhLdmAwrub6dq1X9hcwB3KvDEjgeHoffHwQLCVVCQxYqwOPCBePXwyotPfFoiaJbQa8jkKAqgX+UFsEzPE0w/af9sp8eYVh/h++Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7004

On Aug 25, 2026 / 14:45, Hillf Danton wrote:
> On Tue, 25 Aug 2026 14:44:35 +0900 Shin'ichiro Kawasaki wrote:
> > On Aug 25, 2026 / 03:50, Eric Dumazet wrote:
> > >
> > > I think 19bdb70c77d3 should be reverted.
> >
> > Just reverting the commit will reintroduce the other lockdep WARN that the
> > commit addressed. I hope to have another fix to avoid the WARN.
> >
> I do not think you know the root cause of that lockdep warn, so reverting
> 19bdb70c77d3 is the right thing to do because of [11, 12].
> 
> [11] ffa1e7ada456 ("block: Make request_queue lockdep splats show up earlier")
> [12] Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
> https://lore.kernel.org/lkml/20260816014906.1149-1-hdanton@sina.com/

I took a look in the commit [11] and the discussion [12], but couldn't follow
why the commit 19bdb70c77d3 should be reverted. Could you elaborate a bit more
about the reason you suggest the revert?
