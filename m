Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D5C4519A0;
	Tue, 25 Aug 2026 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663340; cv=fail; b=X82QQi+aZ8erKrjVCjXs2pXO4w35OvhalHrrSGQj1M1SfYoa4uvI2iitWWuQJql9/+ffcml80PQGs7m9gz/+ocxWjwOHoGIjUXzwL6AytxvzvJRM3ZRzvAGz4sVy6bXcN0CJizmResvkpTYpbN2lcYUoeRcLCZLqaP6++zMd6bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663340; c=relaxed/simple;
	bh=3Fy/jk775kuzg7NbRPbGtBPVPuhxt2TRJN9/BL+r9O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kSFo8L6/MrvhcLb2rI96i3HKPtHPiJor44h7dmfs4UEEZkReqyHEGQOzB1baYvxD8GFOQ/DDyGZceVCkGjk8L0EcBRzAqHGq/UKmVjhRJ8aSIDYhKs3tEMpcrBCFF9KZh6zgWcohnYjxKXbdUycrawRgwb1/4cpUxcKZVxsygu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qeZoLY83; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bXjPopNO; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qeZoLY83";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bXjPopNO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787663337; x=1819199337;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3Fy/jk775kuzg7NbRPbGtBPVPuhxt2TRJN9/BL+r9O0=;
  b=qeZoLY83CgFZOL4VaUCJfI8uHV1fUg3N6XM4UlQiUo0TQ0BKAuzmaqiE
   qR9lzDvuv+3ofAA0Sxcgz4HQ4NcFIflW/rF3M4C5StR3JmFBEtGWdKuyo
   FC1mJXR90IK4ARVZePGHEbZwS/TnsWx+Q45O0+ggrr/2ILSjH7v4h3M6n
   P/NyhPubUzI8gqT/ZU4Bd7sBPLcufxOBADIWEmk/piq2Sb5ZAxZqS0pGp
   yEwZL9IP7qRjgxONX3cznixChk9vKbakFUpwv8LmfWFICFpYhIq0pIvw2
   NqJgW4/5CqYbjHVoxEd8Jy3OTcSuggOQ/tuVk1jocinHyUkuRme+/C9kE
   w==;
X-CSE-ConnectionGUID: sAtwfJXORoWdou6vg2TpDg==
X-CSE-MsgGUID: 2jH/nepTTWeCdGgnB3hEZQ==
X-IronPort-AV: E=Sophos;i="6.25,242,1779120000"; 
   d="scan'208,223";a="154003381"
Received: from mail-southcentralusazon11013054.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.54])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2026 21:08:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qW2KIri3NequmYMoaNOTaG56p+IoSrc40XaNJi6WpD9lY/ve5vInOop4W7O0RbEM4wupwX3Q39hyqMS96ESWohG7heUl6yvSRL4OeqrGH4k7NQCZu+BAkZivH8kU/YxG5Tj/wV3E+/y0neEHHAQXwn4HDn31rUfIQ2n8SUEsqHpWWya1f8bVyy4lujBzbeirUDFq/ayNke6SuiBvUmjH06VqLmpQEUpWFP3lDl8J6xaQK/8GQv9kWkqP1gABjulhuaOwqnxCck6RLqd2UFsN3dF3wb56PdFzAWBsQKLgC7yJUNgmy8JwxM8esXu2SQWS6Xk1/pjvYrw0YCdoQEKDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grfo4W6Wo21amHFXLrIPjG6A7sFUjZJD2uey9HBKNhg=;
 b=myiO2xZl9VkvVoRjYgqXrtlFfS2hllXAsismWS578rI1qti0faFEIzlhF49N0dsB/MY7EAR482A5aiEIeMJytcj/3RbfBO7SEPxVMJS2Qntw47xx/Goke8FDvzb1Vyc+jEvvw3Fiv/KcDp1FLeIGnSi94WcSDruPqZMuPs1m/Kdd/F7gDSUo6VTERC/+UhE091ELHTE00hsvR/QlR31UfFl7krJ2JO7+DAzcXJ+fo2ANYkztqSSs7eSTm8oYdb0tovTwj8QAsUSnBGk4e9NJMOawwFUwPWfxddcnhAhrYqI5bEiWH12Sx/Vhlj7sxiRwQvuZSC+PlvKSUaK80o/EzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grfo4W6Wo21amHFXLrIPjG6A7sFUjZJD2uey9HBKNhg=;
 b=bXjPopNONIWBYMBqSI8KDcvxmnZ2gNoZJeZL5C79XCWi76hWHtbZ3NR22DH/XiRO/ey+nANcdU7+V4eHn8dWv4cCs0AmSOUU6OqTabQz1DjJATOqKY8xvZWJcDhN/si2ApaI/uar2bEJYBizgQfL5Ra5APJofrc+Yjlr0HUu/ZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by PH0PR04MB7400.namprd04.prod.outlook.com
 (2603:10b6:510:13::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 13:08:51 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 13:08:51 +0000
Date: Tue, 25 Aug 2026 22:08:45 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>, 
	Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>, boqun@kernel.org, 
	hdanton@sina.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
Message-ID: <ao2QHIDrGeYjltX9@shinhome>
References: <20260825002924.1439-1-hdanton@sina.com>
 <6a8ce8d5.dbb3a75c.7844.0018.GAE@google.com>
 <CANn89i+wnTLC==UnXCpjsS4YxvEfhe5oK0N7fttbqr1zKyqdug@mail.gmail.com>
 <CANn89iJ01nSttn66xfaM+AOa4U-nvw=pSeqKxzvU64426-ZJrw@mail.gmail.com>
 <ao0mwtt8ePAINFni@shinhome>
Content-Type: multipart/mixed; boundary="btsgphlxdv6zmmxj"
Content-Disposition: inline
In-Reply-To: <ao0mwtt8ePAINFni@shinhome>
X-ClientProxiedBy: TYCP301CA0032.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::15) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|PH0PR04MB7400:EE_
X-MS-Office365-Filtering-Correlation-Id: 45843be7-749a-48aa-498b-08df02aa022d
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|7416014|376014|6049299003|1800799024|366016|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003|4053099003;
X-Microsoft-Antispam-Message-Info:
	d6GxwjeVKedfv/ALaa11WpchJPKtcn/TPAyFi7NLqdUTBYVIMqubwpnZS7NomldxfyD4MarXahBOE/schXkt9F9eBi5wDM3afyA2nQWoDLBT4WgDlXd8duymLoCRfBLkqTfwkYQr9lTqKOkfmMwNUaUYlY1HYPLHSpH3zPp8SVgNW7UnyF0JMnCqmVaqn8rC6f/QXB8Xo+xXKwmx/fQniRYPjbMmJKgr0ifeSRXMzNqd61XP/CtR/RzR/04lhar/s+OcivybsLCWrlRe15R14I/r3TK5XdvCFekdIqElHuaSB8UFyhx2FXZ+Nz+wd5Vw/vVQai7lNRO9YZ/jexBvdiMUbTkQr4vXBtjokvHRb664bpVuaP7h8i2aEcuDbQZIn2UiaQz+OsBRzpdbbqkCtmSHpJL8oszQDedFOOMQeMT4Cmw16vcbwaLaJH5W/MxkjyyeeXRDcMuifsODEar18ytVN4KvZa0uRmA8ZLSARNVKEibb8kvfn2IwctpOn3WseOQqqXhkaaBqnG/JUmJQYwRxPKZfeLJgZgk51/lg0jnzVJ/+twYU/7h7dZQ2puNxVVAycpJWJkg7+UQWXifvipiKGToWnS1/kF/2tt5yYeYTWCeG/9Mq2ZhPSUcKdYtUjoj1BbY+YABtkA/AcXZsqeMlgaQAq/I1msAwzLigekg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(7416014)(376014)(6049299003)(1800799024)(366016)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6sfCXkC81NiaXLBlXzEhdrAVxxWoNTDxzM49KAMNd5UNrjSwg6Pz61GrU9iw?=
 =?us-ascii?Q?3QB1a1dmP4JRmqVxMwkQVfmDDgqUbto9vo31vTjpr7C3V2ecs2HEo0kU7hRq?=
 =?us-ascii?Q?AIZEHClS8baeZlEu20kkJ0udKuIxqkIwCW/uBNAUS4G4i0rqBfOWFkVmVv4p?=
 =?us-ascii?Q?MK9oR94nmzaE2tr69d+ZqftmhL+NuGXWEug6UxgP933AqQoixthtiqGGAH2X?=
 =?us-ascii?Q?ZfJIcJz3NVYATvsG7QTU6FnbHJ0QL5eDufUShakJXWCtiJgxrltCwn6CfK7j?=
 =?us-ascii?Q?FYGM41+HooFshYyNLwW3dT5Wb3M5wNZy2zN4PBUV5yBeySL0mNqMYSt+xj8O?=
 =?us-ascii?Q?Zgm5WtG9wmAH0YQT5KmNdQwBws6nvcRLG0DpMXIrNDRcyBEqSIhQRMJT0b1j?=
 =?us-ascii?Q?Z1yw+vh1+dPfpAw7aZxXCED7gvd5Mso4c8QXvTTPabySYIAPqNvEfW8SIazf?=
 =?us-ascii?Q?zaQzv9AKheW5b9bGg6K4BOmZC8Gt2BR8Ln/8kQqeHmh+BbNsV+gunFqTvIV+?=
 =?us-ascii?Q?Zw8IAdoHDoU2+zvreRwsCwmBiy3a7U9GlXomij+ZUCCy3Hz6CLNpgUxbXO8B?=
 =?us-ascii?Q?P2uRDkg76bMqjuNZ71LmPaSvm1irgVNrDvg5mx8jl54Gz6zklbAYiLN6G6tp?=
 =?us-ascii?Q?aEOmrPjmDJUfeDUo++Qeiovb8ldZRfyP5QEtH9Jg0f5DgBFOrEd7KjIKbbdn?=
 =?us-ascii?Q?mRO6StwaHORA2sUEFt8H38GVBqViEXRDDf2Gx3w9P1VATad8Flj4fHO20Hfg?=
 =?us-ascii?Q?Dl+eF4UsL6jb4v7IUqio4b0/3aK4oKAbdXaGK8ERnhel0mGpejuvIfQDVumY?=
 =?us-ascii?Q?QPXXHsR6RW06EI8f7w/I9vvzEXRS4ff34cT+Iomrzs7XCIbh7DWwOqPMu++J?=
 =?us-ascii?Q?EAOpHcUFPEd31x0QrwBcUcjX8+8/4ibWXOsIyC5fsynmNMygSHSGt8CGX4nC?=
 =?us-ascii?Q?A5DochT6Vgc6kJbbuKe/8XfIHrQp6RWRmoRD4qA499P2gxW96BL/LSkoA432?=
 =?us-ascii?Q?t2XTInMPDBmk3hLyH5kjFIA6JMJkgz3a4YkeaeOd/wLMILHK4Q4ed7e2BRDP?=
 =?us-ascii?Q?as62pU03Ky54TMLZKls6IpzOo2yX9FO2obdp6ohW8CvUUV3oWzoBukjQmR/m?=
 =?us-ascii?Q?AKFlhzNOqGiRdbB6OMnmkQ+xGVbmAhwO4LSVXlubbE+XuUHZyuHfPYr1cJwc?=
 =?us-ascii?Q?hTk06gR4YGroF2xm4vP9+u+D/tN2Gn5HAJalbR2GdI2cPiE777ECmHLzbrj4?=
 =?us-ascii?Q?JbI8uKOa6nYKiV4r7GxZA91t9hU3GZ4tGv7wXksz6mogBsP0leOSFsI5Ohn/?=
 =?us-ascii?Q?0Yrn/W50958tHovPELq8SYD4tsJ97oDMuj4W73ibzfxQjIiJOn2DgKNA2aPK?=
 =?us-ascii?Q?5jSV9uS9LqcxELn2A41FhiC6gEn7DMUXmg1yO7cHX8Vm6zjvHFv702LVRzxp?=
 =?us-ascii?Q?iTgxx/2ujnuZEn8ZH6QxMzRH8kEfzYfu3Q7rv57XbEMKwBibzWch5DNpzCBW?=
 =?us-ascii?Q?tpIOFLwhQDTnDgQ9LUcUrlUlQn+Z4JCNnSSjEIc/UNup9YO7xgIcPSq0vrSw?=
 =?us-ascii?Q?6v2SME0hSdf35f/iYVLTrFXdk3zK30Y1SDglhbvDfn2SvXNUb4G8C93BGXcg?=
 =?us-ascii?Q?JFGF0NcSmYTCGl/JvoDltRvIRLUM6aaANEJe9l6Osi4kOeyYAZE9CgFa3fbw?=
 =?us-ascii?Q?8rixK3q1ZXH1UmNCrt7fcbS2WLzZznHnfvIOgS6ZJvhN8nFm4L5kYJNGnVCa?=
 =?us-ascii?Q?6kxy1TIXnHVdqNlDS76ghOBpCTkqfsE=3D?=
X-Exchange-RoutingPolicyChecked:
	Sdgpk6StBoGjJqllNTpIVGqY3apAYIAzjyyDzsdG3VuPrcBs5wN+QIiBYc3A4hJvOeHy6ZAqfyCfTSSht8YyofSjwuQQ3755j1/T/CN1O4Ma7dn3aUdgxssSDrgR/bQpBJa+HbCPMwUPJJzp4LkPgAL/SN4q1fiqvCNGjnnW33SbNgcVKr2cWm797W1ZylbPFQDjJGW1GfaxfuJPROLvBCmfMBeFA83VMhQeMhnNaEwMEjTmi7U49wGUQkAMhAK0JV3YHsUYHfB6E8bG0RY7PKAwaT7SBB1NWsK3SHvVk5w0Bq4lXvoZXJT8rsCTGuc8OzPN8AIQt8mLmWrbPgr8jQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z41jYJU4ITFTn6c6UUX9jMN5x5dBcO5NfvP+4fUnJ/ueTGLx+6qNDKppAxjYtnj1XhQtb4AxZCEXNQkmL6p2FRtwGbtJtDBDWh2PKSZ9MWk6ZWZk4mgeIPC0bluyklI4K0aZGei/oXl186E1gUg/WzWYuuEY+vnUauSAqwtRfD6P5hcBYazfhTFigrsvn9m4d9Ic3M/dxGpmkDNgkI/F1wm0HNaui/I+oNnQ41JFYkRzPwulYw6d1dw9qdm7p4Q+ISkL+/vK2kcGMhn2OyHc8GzHpVzHiug+UviOXzqUhewMVISBKig4rH5rZTl0Th6es+X5ugtenCLIVPTCbnhtqqfgAM1y+61EMPQQqerI264AA7SJ7g8cVnCFn6hOvK45JHyLjJz66UMswZgTn7zWTM+XTgJix6wOGs9ZWqAI+I+Jwm1F62w5wXPrVzYcLte1+Hu35dzL2eyjb8YuUbV0zkei0dd9JODwyjGsJZ+GHid3dzz2BMD750guli8qCRx9B3xco1/Dij4hEsY4AtIi47PWaVS6bvGzZ77j/3ISUsvDWJX615PdL7Apf3yW9thGMGav7KupZYELOch14SDBe+KkOcafxTktW9OtsaF38YWjXrPyNB8W7hTzrlwINo8n
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45843be7-749a-48aa-498b-08df02aa022d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:08:51.6452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aen6bjJAf9bZDqzaR6JzgcXkCe0nU0QCPbTts7WzzlZCEye7GP2fVJsfWIjwEHQ7+i/LlnV36Bjjw7ILJIKAalS+OXG8jFqFdtxpXMUZUs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7400

--btsgphlxdv6zmmxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Aug 25, 2026 / 14:44, Shin'ichiro Kawasaki wrote:
> On Aug 25, 2026 / 03:50, Eric Dumazet wrote:
[...]
> > I think 19bdb70c77d3 should be reverted.
> 
> Just reverting the commit will reintroduce the other lockdep WARN that the
> commit addressed. I hope to have another fix to avoid the WARN.
> 
> > 
> > We can change TCP to use sk_gfp_mask(sk, GFP_ATOMIC) instead of
> > gfp_any() in tcp_disconnect()
> > 
> > This ensures tcp_disconnect() respects sk->sk_allocation = GFP_ATOMIC
> > and never acquires fs_reclaim under sk_lock.
> > 
> > WDYT?
> 
> Thanks for the idea. I did a quick trial with the idea.
> 
> Step 1:
>   I reverted the commit 19bdb70c77d3 from v7.2 kernel, and confirmed that
>   the blktests test case nvme/005 for tcp transport recreates the lockdep
>   WARN that includes fs_reclaim in its lock chain.
> 
> Step 2:
>   I created a patch to replace gfp_any() in tcp_disconnect() with GFP_ATOMIC
>   [1]. I applied this patch to the v7.2 based kernel that I used in the step 1.
>   I ran the test case nvme/005 on this kernel, and observed it still fails
>   with the lockdep WARN: fs_reclaim was still included in the lock chain.
> 
>     I think this is expected, since fs_reclaim dependency comes from CPU hotplug
>     bring-up context.
> 
> Based on this observation, I'm afraid that using GFP_ATOMIC in tcp_disconnect()
> won't work, unfortunately.
> 
> Another approach I can think of is to use sk->sk_destruct hook to unregister
> keys, so that the unregistraion happens after the all in-flight skbs complete.
> I will try this approach.

I created a patch that delay the lockdep key unregstration until sk desctruct,
and attached it to this e-mail. It applies to the recent Linus master branch tip
(git hash 818bebeb63dd). Eric, may I ask your comment on the patch and this fix
approach?

I think this approach will avoid the lockdep that syzbot reported. But I don't
know how to confirm it. Could you do the confimration ? (or let me know how to
do it).

This approach adds some complexity. If anyone has simpler solution, it will be
great.


--btsgphlxdv6zmmxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-nvme-tcp-unregister-lockdep-keys-at-socket-destructi.patch"

From 3691427f5e9df338bc21068dfb12f4af00a371e7 Mon Sep 17 00:00:00 2001
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Date: Tue, 25 Aug 2026 17:26:53 +0900
Subject: [PATCH] nvme-tcp: unregister lockdep keys at socket destruction

Commit 19bdb70c77d3 ("nvme-tcp: lockdep: use dynamic lockdep keys per
socket instance") introduced dynamic lockdep keys for nvme-tcp socket
instances. The lockdep keys are unregistered in nvme_tcp_free_queue(),
just after __fput_sync(queue->sock->file) call. However, at this point
still in-flight skbs are there. When the skbs are freed, the socket and
the unregistered lockdep keys can be referenced, which resutls in WARNs
[1].

To avoid the WARN, keep the lockdep keys alive until the socket is
destroyed. Allocate the keys separately from struct nvme_tcp_queue and
replace the socket's sk_destruct callback with an NVMe/TCP wrapper. The
wrapper invokes the original destructor and queues work to unregister
and free the keys in process context, since socket destruction can run
in softirq context.

Hold an explicit module reference until the deferred work completes so
that both the destructor and work callback remain valid.

[1] https://lore.kernel.org/netdev/CANn89i+wnTLC==UnXCpjsS4YxvEfhe5oK0N7fttbqr1zKyqdug@mail.gmail.com/

Fixes: 19bdb70c77d3 ("nvme-tcp: lockdep: use dynamic lockdep keys per socket instance")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/tcp.c | 117 +++++++++++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5fda9661bdb7..645913edf1f4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -144,11 +144,6 @@ struct nvme_tcp_queue {
 	void (*state_change)(struct sock *);
 	void (*data_ready)(struct sock *);
 	void (*write_space)(struct sock *);
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lock_class_key nvme_tcp_sk_key;
-	struct lock_class_key nvme_tcp_slock_key;
-#endif
 };
 
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
@@ -179,35 +174,93 @@ static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
+struct nvme_tcp_lockdep_keys {
+	struct lock_class_key sk_key;
+	struct lock_class_key slock_key;
+	void (*sk_destruct)(struct sock *sk);
+	struct work_struct free_work;
+};
+
+static inline struct nvme_tcp_lockdep_keys *nvme_tcp_sock_to_lockdep_keys(struct sock *sk)
+{
+	struct nvme_tcp_lockdep_keys *keys = container_of(
+		sk->sk_lock.dep_map.key, struct nvme_tcp_lockdep_keys, sk_key);
+
+	return keys;
+}
+
+static void nvme_tcp_free_lockdep_keys(struct work_struct *work)
+{
+	struct nvme_tcp_lockdep_keys *keys = container_of(work,
+			struct nvme_tcp_lockdep_keys, free_work);
+
+	lockdep_unregister_key(&keys->sk_key);
+	lockdep_unregister_key(&keys->slock_key);
+	kfree(keys);
+	module_put(THIS_MODULE);
+}
+
+static void nvme_tcp_sk_destruct(struct sock *sk)
+{
+	struct nvme_tcp_lockdep_keys *keys = nvme_tcp_sock_to_lockdep_keys(sk);
+
+	if (keys->sk_destruct)
+		keys->sk_destruct(sk);
+
+	/*
+	 * sk_destruct may run in softirq context. Do cleanup in process
+	 * context.
+	 */
+	queue_work(nvme_tcp_wq, &keys->free_work);
+}
+
+static void nvme_tcp_set_sk_destruct(struct sock *sk)
+{
+	struct nvme_tcp_lockdep_keys *keys = nvme_tcp_sock_to_lockdep_keys(sk);
+
+	keys->sk_destruct = sk->sk_destruct;
+
+	/* keep nvme_tcp loaded until the lockdep key cleanup work completes */
+	__module_get(THIS_MODULE);
+	sk->sk_destruct = nvme_tcp_sk_destruct;
+}
+
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
  * because dependencies are tracked for both nvme-tcp and user contexts. Using
  * a separate class prevents lockdep from conflating nvme-tcp socket use with
  * user-space socket API use.
  */
-static void nvme_tcp_reclassify_socket(struct nvme_tcp_queue *queue)
+static int nvme_tcp_reclassify_socket(struct nvme_tcp_queue *queue)
 {
+	struct nvme_tcp_lockdep_keys *keys;
 	struct sock *sk = queue->sock->sk;
 
 	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
-		return;
+		return -EINVAL;
+	if (WARN_ON_ONCE(sk->sk_family != AF_INET && sk->sk_family != AF_INET6))
+		return -EAFNOSUPPORT;
+
+	keys = kzalloc_obj(*keys);
+	if (!keys)
+		return -ENOMEM;
+
+	lockdep_register_key(&keys->sk_key);
+	lockdep_register_key(&keys->slock_key);
+	INIT_WORK(&keys->free_work, nvme_tcp_free_lockdep_keys);
 
-	switch (sk->sk_family) {
-	case AF_INET:
+	if (sk->sk_family == AF_INET)
 		sock_lock_init_class_and_name(sk, "slock-AF_INET-NVME",
-					      &queue->nvme_tcp_slock_key,
+					      &keys->slock_key,
 					      "sk_lock-AF_INET-NVME",
-					      &queue->nvme_tcp_sk_key);
-		break;
-	case AF_INET6:
+					      &keys->sk_key);
+	else
 		sock_lock_init_class_and_name(sk, "slock-AF_INET6-NVME",
-					      &queue->nvme_tcp_slock_key,
+					      &keys->slock_key,
 					      "sk_lock-AF_INET6-NVME",
-					      &queue->nvme_tcp_sk_key);
-		break;
-	default:
-		WARN_ON_ONCE(1);
-	}
+					      &keys->sk_key);
+
+	return 0;
 }
 #endif
 
@@ -1511,11 +1564,6 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
 	mutex_destroy(&queue->pf_cache_lock);
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
-	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
-#endif
 }
 
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
@@ -1831,6 +1879,9 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 	int ret, rcv_pdu_size;
 	struct file *sock_file;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	bool reclassified = false;
+#endif
 
 	mutex_init(&queue->queue_lock);
 	queue->ctrl = ctrl;
@@ -1864,9 +1915,10 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	sk_net_refcnt_upgrade(queue->sock->sk);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-	lockdep_register_key(&queue->nvme_tcp_sk_key);
-	lockdep_register_key(&queue->nvme_tcp_slock_key);
-	nvme_tcp_reclassify_socket(queue);
+	ret = nvme_tcp_reclassify_socket(queue);
+	if (ret)
+		goto err_sock;
+	reclassified = true;
 #endif
 
 	/* Single syn retry */
@@ -1960,6 +2012,9 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	if (ret)
 		goto err_init_connect;
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	nvme_tcp_set_sk_destruct(queue->sock->sk);
+#endif
 	set_bit(NVME_TCP_Q_ALLOCATED, &queue->flags);
 
 	return 0;
@@ -1969,13 +2024,13 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 err_rcv_pdu:
 	kfree(queue->pdu);
 err_sock:
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	if (reclassified)
+		nvme_tcp_set_sk_destruct(queue->sock->sk);
+#endif
 	/* Use sync variant - see nvme_tcp_free_queue() for explanation */
 	__fput_sync(queue->sock->file);
 	queue->sock = NULL;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
-	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
-#endif
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
-- 
2.54.0


--btsgphlxdv6zmmxj--
