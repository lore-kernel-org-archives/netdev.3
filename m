Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45743E00B4;
	Mon, 27 Jul 2026 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141225; cv=fail; b=LeWrd8WCLMqXhwT5GTO3dsJSghynNo4oB5DS4gUIS56FL2bpQcrJyOP6Bh2daqh/gZ7359QhJf+WN4M5+MetLP5X8Jrj+V+CrfvTGxAla5PKFb8NIkpdkwLXh3uOhsCzeJl8VJ78szx3OWfO34holbLxlK/0lYnnbsG9Kk/Kt2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141225; c=relaxed/simple;
	bh=Y5Vvx5oPeaaLIE6irjJiweLXdcpSuXe9WliPeOtBn5I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YWVGpf0xBD6EPitGFDnDYlu5Ob0QneitlKldMco76kiOh1DOIt8yvCL/1PYHEWeWFbMXwomkMxB5GhD4dzBUyPvYJ/wSbU2NTfgTWOShB5joy8T/0uu11cjstP65+zRQooE1DEJCQWNqrRCvA+Fna1zsykUt+x++qmoXkOZxzjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGoxpsy2; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGoxpsy2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785141224; x=1816677224;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y5Vvx5oPeaaLIE6irjJiweLXdcpSuXe9WliPeOtBn5I=;
  b=GGoxpsy2a7zna8V8aQIzIdm8uefHw+gaiVCaFSQqEJZXpYQnQRjt1WZd
   ufy9xDQZ4U4/HaQJ42Zm8QBFcqe3DmvNOFEeZYDNz0lfVSOa4C0VqGEDt
   m1zCbvAMsnF+vJf0f6xfMwUDNiDNdGvATIUdt13SPfwp861snoarXP3Qi
   80tn6uMaW2xAqTTmwgzxVcwAv5NU1oYyIh5pJFEU+avhwo9Bmc/SKhqQw
   4xCqKAmfOYxq2R1R9iJNeMckx+yhF8Aq/jjlQtsGYbfL8rgZ4R81ZMcDS
   ffZzWl5s4LcqTQpzOyq45CIFxRKh/6DhNaJ2UJ4hwWfMV+1WkXR4j30Jv
   w==;
X-CSE-ConnectionGUID: 52asE6FqSe+wpRc4MNxLrw==
X-CSE-MsgGUID: r0UTkQN4Ro2HqHb21jDfCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="88243608"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="88243608"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:33:42 -0700
X-CSE-ConnectionGUID: MJafQwHkStCVL+MjunrGEg==
X-CSE-MsgGUID: rAIwrZEVTXu5oJicdVuqIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="282689303"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:33:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 01:33:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 01:33:41 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 01:33:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgJZhoMClrzvmwnxZ6/LStjFbhDMhbBHOOiLeTY83i+AUljmeClZSBVp/sUf1T+YUafSX+Ko8kIUUnVtcjac7hC15sSJ/hKsWEVeayeRk2cIQ6ReprlGUIvJk179EVB/mpb9Vcrz70gi422vCT5vVNuBwP5UQCcGGHY04jEuOaS7MtFlDlo0+vDAZBlCKgRhqaYGpv5D9jX1BnSxT0EsdseeFmp3eQ7P7TnkPlpLF9ZkXundQgwnbDKY14E5Do3z5cFQ6/Vkhdk6q8fadHpVaTYuTB+wG/q3Sa3yJoCNCJ1pl9gS7Q2wcJfrRIEKFboMVVu8bAvnjRcvfupqkYTfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu2YYktP4uL/Cr8MWwRteHwZpFnYgETzC0D10wDB6bg=;
 b=Xc+lrZnhCSTOTN/s/tRf6cC+H5BznbpA0Tmi5NkpGdoFM34ZSGEuht9VUNxCWwULwR2am5wE2u4I5+9qvU9JJ/eIuXUy8GcUnW2/nixKW0k3J3iY7x1hI6qjg6m3VYpp3nmHRqCLW1QeL+KqkbX00tL2r0aNeHq51FDbscmyyJgr/AW/CJc+SYoijQ577RMazipW8Tdqvy82HPJVSFPQKVkWfHU9UB46rfDiNo+Mt+FoBHY/WJQdgP+ui4B/+oGHBkDGa2j5pT5nSCIaruf0hgZiZcR48iCBfO9X3hScL6d1DcaDPmsKsL4mXsWDLHnoA1O2nGepSfWvwa+9g5OzvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by PH3PPF740777B0C.namprd11.prod.outlook.com (2603:10b6:518:1::d2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Mon, 27 Jul
 2026 08:33:38 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 08:33:38 +0000
Date: Mon, 27 Jul 2026 10:33:25 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <sridhar.samudrala@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <skhan@linuxfoundation.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next v5 00/15][pull request] Introduce iXD driver
Message-ID: <amcX1fyBBKwzwMUu@soc-5CG4396X81.clients.intel.com>
References: <20260715180042.1972010-1-anthony.l.nguyen@intel.com>
 <al5Lr2Qm5pDa-yOF@soc-5CG4396X81.clients.intel.com>
 <20260723061526.38902608@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723061526.38902608@kernel.org>
X-ClientProxiedBy: VI1P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::15) To BN6PR11MB3938.namprd11.prod.outlook.com
 (2603:10b6:405:79::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|PH3PPF740777B0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af33fde-b9ab-46f2-a967-08deebb9c129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|10070799003|11063799006|4143699003|10067099003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rs8e3ux9IgHHUEOEKFVFbyqU6Y9bb4dYbPSz/pjZdsuVegg01f3ejdw6lCCVw1O/DjSqKJno9+kpau79L4gQta1bIvDvj8RMVewe8Jq4HN6iTckOCmqY8Z+G5WHXtJXVHNSlHIe0hI6cin4vbkNNTlnVy74KXnt0b9qbo9Gk+w+tueDayD3GqWehLRutJyvGmb55exoejC66nyD5kBFPFh0WmKhqC8iohulW5Zbyzde5hLo8x2AtHN7fleDOUEQOiIBf+8iJpx/ltw5Uyw9D2t7afbde7HTk398GN4MMSwKbw8eiZoPTMUSg2HbhvlHanH7xTn+O6PuMsYe0WwCZf+g/UNb9YK364BhXxQeLazRFf9xPa4Kut/OUDt8Dyzsp6XU3e+QUYwcSo/1rq2RWQ4n5bOLLAKPJQFqP6bLei7dJPbvXklus4wlzu4oSZiAxpmC2xhFfEviGnJvn8JNzSBctzEy9GJLCKNQVfbour3OLFOvNCrARypSwLhzbXCv7aV3/UdcuXssakGc4orNLsgULZNKCebdLTvw0tTwyPvpmeCMfaYcljh2VfAR4vGJ+6zUrCaWZ4iPSMIGMvDZg3FwpW7kFPwgmS7SRc6+sKOluEReyIJbdOqCCluM67LUqkX1+xBo5dRYCT6hAHXCuZE02rKJaZP6pnlKUcrsf6Iw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10070799003)(11063799006)(4143699003)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MA6h/5sR71HixkKbwaBIduULHepF+1UYrpainhNJTmFmL+KLRcpgx32ir6QU?=
 =?us-ascii?Q?wZSShEuspetSlB8g4Gc3VJbglN96GmFHdGXJCk5lLmc46pMEVP0JSQPBvlNI?=
 =?us-ascii?Q?tbbek12H2trfnffjHDAyHLXfc+CtKuPWNsC+Z49spsXrLlSSp5dbN6E+CMNE?=
 =?us-ascii?Q?l6b6xJn+B/cG48MjsSyhrhzAY9KQ0VMCW6axImaH42WUbEouvEkpw5v+RrSw?=
 =?us-ascii?Q?f92hT6nrkU3+JjKln2d2nbc05HdzSh7YyFgJAXYCJfuSUmw12e8Dy3cUqYqP?=
 =?us-ascii?Q?wfPh3LlR0Jp9grj/EJ2YnfymHJknnIzRWTc02o+g40bJ8Rf4noEK4urzEdLL?=
 =?us-ascii?Q?5dGgy55suKCr0eDMBgxEBAkFqq2gnN9uqkKQFCzMlFtkqrEB0uGPQtmrX6Im?=
 =?us-ascii?Q?q3bL0ZFhR9juBgBbKBUT1f5Jqp1wNr0rd+bmIlYrXbEmEhfh1oAUJHzHV/Fm?=
 =?us-ascii?Q?PWLxXnS/Hx/hvF/gUe93vWgvIHaWhMN0cCFuEy02fo5xEJNtXHZ/h96QzvGu?=
 =?us-ascii?Q?noXDyGBUhg/l+J/wOE00qxj6Pj3Sdc8knriDJpGzj6ds4ip7pHxT7IIjbEAK?=
 =?us-ascii?Q?EUMjCcNAIyyJqYOZsmXvFZUgiGCw6SqWXlcc05zao335jC4BP6q3/0bnqUs6?=
 =?us-ascii?Q?oepDDLjxa20gpK4A59XXscpRz9/cGvHF4hcdscdi41B7ibHUvqCG5WqawsY+?=
 =?us-ascii?Q?OQQQNFvL5bR1o51hmxAzW30j2OVlR905HS60li8FqG9Ynkj4eAg7FPOkFPQO?=
 =?us-ascii?Q?V2TQ9PAj56OqscQ96duc9ReAz+mPCfJsFBtRjyWPXEAOhI7yyCvHIWXIvpvV?=
 =?us-ascii?Q?TvAE+9NmbjbF/KNkfTm54k3xAJkq3uz0nCfFFghzqb2Pkti+9es8gi6QNOz/?=
 =?us-ascii?Q?QSeu+s46okEllYSGKjZea7h++Kv/CXLx5JahULJSCbup3gOwZ+Z5eRPpm/0/?=
 =?us-ascii?Q?kAxswDUkXYtnoE++A8t/FbhSuTHs2TNvIGEl7yrlSTuWQjJ8W9VDyK2Vnxt9?=
 =?us-ascii?Q?DrpAbmknN9cJqbAQMY8HGZaD9f3tATACF7aNxM8vMoYKRwR4apP5YOg/F8XE?=
 =?us-ascii?Q?lU5VVqdVN6Zp4QJF3RWXiGbw0bgAUWCVLCExWuQHGqO0988kFIJBLuRlHUbF?=
 =?us-ascii?Q?OgbPVhfIv9wflYGE6qLiiiPFhd9JBi1o+mTLOWR8SdpYbOwueCmaraaApU9D?=
 =?us-ascii?Q?4Vnbu9fsHhICRCr+emhIRGZEeq0uWtaoVN+RcP1jvJB+SGuvbKX0ELj9P3i0?=
 =?us-ascii?Q?6gEBTnNcqbViZGlQ9d1BFEiO2o1Q5d8ky6NZfy8QWeba3XyPQklHtbtBZba/?=
 =?us-ascii?Q?T34wm/Ln6grWWowP7SbDH8prKwDDJFlQUA+p+sk/H5J99PYr3tYAGlmfG0ty?=
 =?us-ascii?Q?UcV18ln+M2zP+LbifgilIQqfWs8abK/mHfmR/ZBLxNFgcKB+VUFcI34cyKLX?=
 =?us-ascii?Q?DzWDovkkVwiCNNpsF+ZshhXVtZaWNKcfLhxdW/lKK6624vv+TSqSbZtlrGMN?=
 =?us-ascii?Q?HLfUVY3FVwiqEhtlDqIGNZAHKmaC3BWaJN+cNtPy9g5Qkwxa6+l+Vye51eqi?=
 =?us-ascii?Q?La2idK5Leu778ym/WJFFhUbJM/UvkwKe3iIamdx2wie7ohTeQPOZ+ocW0AJJ?=
 =?us-ascii?Q?aPUsIH6/DoE0Ty+zz6QR4YiPbDbEh6L8v9wzF9wDMzG5K5oiLbf09UvAavea?=
 =?us-ascii?Q?FqNoKWH+DnlEiyoIDxAMOg0u9ia5GMHLxcmemEDjXyMjbmWdQuxMkpyNEyML?=
 =?us-ascii?Q?2dwp5ZtpcBuwFrjmL9yr6/IIUsl8eg29IRpaX6XzNsumLZ70Z5lZgmiL3j6F?=
X-MS-Exchange-AntiSpam-MessageData-1: A1BTfxtGeAa6QUgYhwrtlS5cpAusmKBgN2I=
X-Exchange-RoutingPolicyChecked: XFQyu6pUngsYYPkLs/bcdpnevMKyIGQDjiKoLuxe17NGmiy00igTZHSsJ6EfJVJWA0lwqpQjeiaURqVQ3n2NrbUGS5OT2jbW6vUSyCLU1BO/KrEUbdcYhrLnU5cy4XMdzsA+Z89eZvCniXIMYaHTzgx8AMhbL9E5obvP+Dv5VSVhZGGGBILpDpPZ7Dj1Xslz0z4i0ks6R117apAtVffvQAXyZmMrfQ4l8ajMnpOH7C1oHNg28OoK+4Q3HqEtLByCdc10VgRM4QWbdyimWTdv+KHfWoBTilfa3k98RbznU0ByxfKi4bfCiGCbPkZz5XhI8q2VD+CPFPtuP0ZBdvNXmg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af33fde-b9ab-46f2-a967-08deebb9c129
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3938.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 08:33:38.0838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cfwx8nOD/Vp9ZUJRmcLuwwoN6Cz9f4+NGWxwFHz847y6E6oqLEvEzMpjpZM1h6kajIqQUG8/HFf9rgZnonCcxZfIf48GbOGWg12ydyCd7Yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF740777B0C
X-OriginatorOrg: intel.com

On Thu, Jul 23, 2026 at 06:15:26AM -0700, Jakub Kicinski wrote:
> On Mon, 20 Jul 2026 18:24:15 +0200 Larysa Zaremba wrote:
> > I have looked though Sashiko feedback for this version. A lot medium+ comments 
> > were things that I have addressed as false-positives in v4, so those are left 
> > out, same as many of low-severity subjective issues. Unfortunately, patch 4 does 
> > need a fixup (see Re: for the patch itself), but hopefully this does not warrant 
> > another PR.
> 
> There's gazillion patches in the queue. Just fix the bugs and repost.
> This "we will follow up" attitude is getting out of hand IMHO.

I was suggesting you could apply the fixup that I have posted under patch 4 
("libie: add control queue support"). If this is not possible, then Tony will do 
that and send another revision. (please respond)

Other feedback does not interfere with code working as intended, although 
Sashiko's feedback was pretty valuable in getting to the point where I can say 
that.

I see that Simon posted only medium+ feedback, I could address it one-by-one 
once more, if anyone would read that.

Thanks,
Larysa
