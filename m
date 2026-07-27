Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736293876BD;
	Mon, 27 Jul 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165065; cv=fail; b=AdfriTs4/d5PdGMtwxLt29O4rA+W83JXBRutOfu90WX+y1MugrmCilq4GrOkqhnERalIJtslP6eahPO6gst58u9BEIEtEKcDjwtwLRemwizi0QwDvCQQCqgCNUnaI/E41GuWeWrtEDTw40B5/MuJsIh4Q5Jc5/H0tZPvvx+bn2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165065; c=relaxed/simple;
	bh=Rdmi1JsZMfCV4IIBwRKXoFbY8MxWtQ9jWpByuprEB8Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F+WsN3Ow0vCQMXkeVe8qMwEEQMR8X3QMA3mlElkqX63aShEw3IHhRsqVu9ogOBuX7WmtS4cJ/FDXWqymA6GivKbYSVp+ob6ckL4GRWlltJloZLbVt84ayTTKc0YLKcE/riKhAWVvqqEnFJKLfCb3uqek5KhlmxO7xv+DUKqPTDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PG4xd1UO; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PG4xd1UO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785165063; x=1816701063;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Rdmi1JsZMfCV4IIBwRKXoFbY8MxWtQ9jWpByuprEB8Q=;
  b=PG4xd1UOQMadVAsusvrBCJkjAqu364sFiHYyXW/KDYKPehGIyCMcY4hn
   aP2+yySPHLwnpHPHoINTWdtBluS5J2SwhwE0CxYNUIi/9DJ42OJ9wPsS7
   wHQwi9R5KuRygaffUSS2UmfjOJiy6XzFRAiuBZ1dhH4wjtAbmR/l2WI/l
   z4VF1/uz+ji43aS8map6Xr2WMKglekXH0vGU1lpYROVc3UDYAj0qS0ClO
   RkYazLiyei4ehl/TBINEkIO4UGyNx1zDTK4NWnQBG3aouy6P5BPGZxP0U
   fa0W8XxHUTOauHENQi/RxEX/ybwWT4j9MfNM2JzqwkziYy4xc8YIte9NZ
   Q==;
X-CSE-ConnectionGUID: eqYbJjM+RHGPNmdRkXHTiA==
X-CSE-MsgGUID: jZDrp2L6R1eVWcf8TJrP9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="89405953"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="89405953"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 08:11:02 -0700
X-CSE-ConnectionGUID: 9eBre23HTfGsN5Hbsq/Pfg==
X-CSE-MsgGUID: AM7fNoWRRxOEqvWPKN/Lkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="260079748"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 08:11:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 08:11:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 08:11:01 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 08:11:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqAp/a8Y47lQhrGjtrDbpJpI1VbOuuFzuKsWscwK5mWUAY48FJNvFG576ZlV1HtKEdZZms1zTo8ddq/oxv1TsKY7f8cZTTp2LIeSN7cS4oAMTj/oWQB08tW5WnLLsWLGi4a8dpEhC/13j2PAsCJGb5GEB432L/1DJ+yR6olUXXiItKqfzEVbezZvhHvyLmk5+CBLEavNW0K5WVG4Iojwci+8yr4NIW2r+vw3iWQsO3VvU06IHfG6QGgJ7PUzjCbgorBdFMiBthgPle1l8jN9P9dH+hIM+wXWqSnjk2dXZAdLuu0ckcjJ0Vn4a+XSYwf+qCYdE9JkhMaDjGHfpfTT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq+cyswHY9bZFtuVSOy57MJ+p3nsuOoiyrzH1Vfw1LM=;
 b=EJDfEZ5RZn+814qfjNuzdXv0CCkN/O7iibqbVZKPNw8A5AXvuFquBa9TgNxb7AZGzOjRrkD01qYBNzXVtOrItBbV3/TzrAu3ecsUzQUPLG93J5BBqdsdkVHhGIYGbKs8t+41d/QzFha3OufU+PgqzJ5T1SUJEIbJIPU9K8tvhFYGc99HJ/0ePkkwpcYKQGEeCAgO4svbARKCitzbhuF+0FSIji8JUgG34Vr7sdq7Aoz+TfYmcggTzdGLAkyans8T4DiFnDFX5GzwACtodLthR36/sQnnyfCgkWCHC3icGFCY2MpF/fxUfJDoDmoEX5MMAAzDmXL9+dSxz8p3tvohsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by SJ0PR11MB6695.namprd11.prod.outlook.com (2603:10b6:a03:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 15:10:55 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 15:10:52 +0000
Date: Mon, 27 Jul 2026 17:10:38 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Simon Horman <horms@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<madhu.chittim@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <corbet@lwn.net>, <richardcochran@gmail.com>,
	<skhan@linuxfoundation.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next v5 00/15][pull request] Introduce iXD driver
Message-ID: <amd07io_6Ba3k9Tc@soc-5CG4396X81.clients.intel.com>
References: <20260715180042.1972010-1-anthony.l.nguyen@intel.com>
 <al5Lr2Qm5pDa-yOF@soc-5CG4396X81.clients.intel.com>
 <20260723061526.38902608@kernel.org>
 <amcX1fyBBKwzwMUu@soc-5CG4396X81.clients.intel.com>
 <20260727144713.GO418547@horms.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260727144713.GO418547@horms.kernel.org>
X-ClientProxiedBy: VI1PR09CA0092.eurprd09.prod.outlook.com
 (2603:10a6:803:78::15) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|SJ0PR11MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f080be-2757-40ff-4506-08deebf13fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|10070799003|10067099003|18002099003|11063799006|5023799004|56012099006|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: Ai0S60AGPPhQ/BJszYEUpJn4vxNuVYgRycDy4tNPF82EJYPU+WPUqoss0uDc+x87V6ilYjgSfhjdyGjkRLD5ZL9bdyxrXTxPfl6OL11MsFzDjwU15/JhVDshwVAqIYLGeh4St6rCUjcvSnl6NgLpHGOnm7MaWNUokqi4t5Lksi9Qs5Bu6wEpCTrj8RHL04Ub7/1qjDK8QZj1Dh3Zd42cen3tB4E6Bmfaf1Cfz3+pnds4Ev/mCER5MiHn6SAP3FtkinuzOXRN7DGEqbxZIjsew/9Sjnp/u7BOo4yOT2WgY3E6b3CxIUtEBJNR0eB/YYj0koBv+WfkGrPHSJRVhHQ+8/lLEwAFuvizmetb26PsRRn5gI6BY5GTunJ3uaNRrA6+tn3LkDWqNeF6AR2rFahPs8FokIgkHWxiAb6cUjTxNoCkyJ8ssatzXI/T/dpxYyfvOdI0RPY+CB2sataHGIhQ4cCQOY4LwSLo5/+ty+73XskIbWLIQ2SZ2/c2ogIuneRhW0LhVjA3gblSd4eCah5MvXb/zTdDIBVG0SK8y88aWcMQWC+8hsZnhr1wQ/2fq5FAt2Z+NxKSoBe7nNRY+ELflpb4zRz351tnUqN3kaX3N9QjD0WG2Dy1lTB8zkHq+wM7Vm3zkrx1UyYWO3Zituf/4HhuG7zFiRFk9fzMrVd1VPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(10070799003)(10067099003)(18002099003)(11063799006)(5023799004)(56012099006)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/esicsv4haACAQ14uiumGmDgtfQbtAX+ZAcf+eY0DOKlQvR/tlBiLn94HDUc?=
 =?us-ascii?Q?bbX93ReNr/jhBdcC+VCDngM9kELad5eFBsoBi1Z2mxowzlhrrDI15UVaH6zS?=
 =?us-ascii?Q?UDGV58XfzIlff7qJ/GlUcoDVPABOqBHqlcooQBWdE7ewjVCEpeh2nRlxLLvK?=
 =?us-ascii?Q?8RJPzLsGTxfs/kMhRv/rSCigrpJbcyBc1tYYBV6HbeyckB8pE3OtN1ZLmoin?=
 =?us-ascii?Q?ApAVe/NLY/xDW8XwEWvCVF6aMl8e4O1l1ZBgsqJe9v0I23qxB6jNAJIlIP7H?=
 =?us-ascii?Q?NzyShWzdmlyo9nX3zrRnGaFNebijN8Km9l9nl/Pult/7QKK+IjYqdphtk2+x?=
 =?us-ascii?Q?CO4maEk5TuV/XBSDPNA9M7LWOeJdXQHuR3kE55I+wj5kGY2LQTziHyLjQFqX?=
 =?us-ascii?Q?sKXN/TQmmmc15UYEoW75Dankb4C8Oz4ESTbcrtUqTfDQQi7eQ5AEN7tQq4Ux?=
 =?us-ascii?Q?odZLBiwjx1RQMH6m4MYqPb5w7p5fW6C8BmHzqrO3l8dWKIREq1ZlAAB7j45P?=
 =?us-ascii?Q?aNqIB6dCn4IBt+a3Ayb9gK79EfdET5deQwTTDzGtmh+JoUoliP/jTNmdhRY9?=
 =?us-ascii?Q?YjEG5KUdEWLjAQz49/2Acb8sw6KqfNfXgUbZ6q4drSSFDE5nkB1SNW/RPteC?=
 =?us-ascii?Q?WWibJBpnFV1JXjvRdN/z8vXgGJSWrdwTHW51PjWb5YCY5WA45PhI6TGUHTjR?=
 =?us-ascii?Q?k0Af35bllmxXm8T9FE5JLl3/13H9rmFma+Y+Wd62+8RGVHTUeaOFIo6DhduP?=
 =?us-ascii?Q?7AU/dz19Bqc1qa3f4FmcLFXb8cMcAT+vqtMLI2NFEU9IQ8GtHmfV8ClBS640?=
 =?us-ascii?Q?t9biE9v8+jdokJyh1LFOdqc25Z/FiiYnt1igUsRtc4q1mOQZgHQG0hMoC6S+?=
 =?us-ascii?Q?ytiq03qDLiGhjkSyZWhIQhAENYEPh2oh8sNUCwHJrWoedVtUKjvh1W6lGdE+?=
 =?us-ascii?Q?8x1ODtJR4IhDZ6Q6XQ2e9ZlDCIKac9lW2fI7KgCaHOC7Hrfg8VRGCuVoyV4i?=
 =?us-ascii?Q?iS8JI1ykbTisqEFtMHNnv9g6tz5Tm73vC80uV2y8Nda/Kasm6IWqi5GjRusW?=
 =?us-ascii?Q?3brphyj9bk5vZqEp25RKXBMYJiJiAP/I9/YQ7b0G4a1PdIPbGqQEWP8d3Iwz?=
 =?us-ascii?Q?riEBDv+nsWnOKTvFtotJ61U1zzyQeUkGMhJk2vjZOPOo2+MALWY6Eq7K9SoM?=
 =?us-ascii?Q?YmEQAS+ikDnT7iYN828N10D7RodtPEUbAv1vhHNw5EuNivqq/qGlYzgnZqHv?=
 =?us-ascii?Q?wqskfVdb5DcTQPkCS0u4bpHRrym/Bs4gGcOJ5gh0/dZhhJYUgac9hPcjqIZD?=
 =?us-ascii?Q?6UP2TZnfqLA3YW+zsPKZk4XjelS8VR8xaOagEVTFbuaDSwwtocd49vRdRJ3k?=
 =?us-ascii?Q?c/jiNPvPrnV2N1cUDbR2cccsC5c+s673R2CSv+L+WJ+C4fdugje64sNqeVe0?=
 =?us-ascii?Q?qlnElZKoNvMpwU+znDTerd0bUZwZP5bTAjShCWnpbtL/CRqrMf7fQvkozmQT?=
 =?us-ascii?Q?XM+J5PYY3rUD3dUGx6RyPy0aH9o99yR1bQbi0M9QA//W1vyWkbzO40gmNRPb?=
 =?us-ascii?Q?ZkmIFTvu9+pBfQ8LWOihPXdk//TLoZKUSlwavq9fYB4hc5ywb9YwJA6kdv3c?=
 =?us-ascii?Q?8X/c4x0C+LgwOAVi2Vx0xIHAbcRW4NUhoHBVTLzxEMiebfijfn2Z/ZR+rEfo?=
 =?us-ascii?Q?d3G2RRKQ2307x2PfuBVBeBZUL4YVOVN6yXFVioeETZR7wwSU9j+OfxdkeiDs?=
 =?us-ascii?Q?M0FQtDLUXmWqM8UqxgNLyWn8COsYb1wt/q8c2OF+BWneaD8tXPHCAj7PwIXe?=
X-MS-Exchange-AntiSpam-MessageData-1: jsnOjKqN0X6ZmbSEWgjBaR1r2Kn5vcsCq7k=
X-Exchange-RoutingPolicyChecked: sFVgUNM5ZNL/pGK8+by6CeQLTC41picdBfWmPCACUAK8rt6cW56aLZKMjW448bRNb86Ul3Fj/yDXcF0ONP2t0zHlGVoLFfdhvoYluH4Q0P6EmCoSxoZb/miHk6P2hARBo97YlXLud+1ynP3tA4YC//izwWs42ijvS4Pl60TWwjzr3TP6a0bJzmo24fD3c4hEpyKDUhXMdZ/yEMPUOEzQTOWmaHl6a+U02gbbJcZ14mf8eA4lItqunmLPuZNmI7LPIX8pRZxwcCvZBC1Ki7rbhCMFpsGhgnXP42cIntYlZyKWzdZy908ddFSorpBZTjsDYcQjtTo+WuBGXHHr7J/HZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f080be-2757-40ff-4506-08deebf13fc7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 15:10:52.6366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOCXX0kbVOcNTgB54tcwweI8szee0UioYeG4A2CHYX87Bs7WmbopzFU10GcxAJxkoVUM/8KwD1Ry+Q9bBmZRcZiov7P/X4GQBpQwMHF1xWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6695
X-OriginatorOrg: intel.com

On Mon, Jul 27, 2026 at 03:47:13PM +0100, Simon Horman wrote:
> On Mon, Jul 27, 2026 at 10:33:25AM +0200, Larysa Zaremba wrote:
> > On Thu, Jul 23, 2026 at 06:15:26AM -0700, Jakub Kicinski wrote:
> > > On Mon, 20 Jul 2026 18:24:15 +0200 Larysa Zaremba wrote:
> > > > I have looked though Sashiko feedback for this version. A lot medium+ comments 
> > > > were things that I have addressed as false-positives in v4, so those are left 
> > > > out, same as many of low-severity subjective issues. Unfortunately, patch 4 does 
> > > > need a fixup (see Re: for the patch itself), but hopefully this does not warrant 
> > > > another PR.
> > > 
> > > There's gazillion patches in the queue. Just fix the bugs and repost.
> > > This "we will follow up" attitude is getting out of hand IMHO.
> > 
> > I was suggesting you could apply the fixup that I have posted under patch 4 
> > ("libie: add control queue support"). If this is not possible, then Tony will do 
> > that and send another revision. (please respond)
> > 
> > Other feedback does not interfere with code working as intended, although 
> > Sashiko's feedback was pretty valuable in getting to the point where I can say 
> > that.
> > 
> > I see that Simon posted only medium+ feedback, I could address it one-by-one 
> > once more, if anyone would read that.
> 
> I realise that in the case of this patchset I forwarded AI-generated review
> which somewhat overlapped with your own efforts: somehow I missed your
> emails and I apologise for that.
> 
> But I wanted to make a general statement regarding commenting on
> AI-generated review:
> 
> I do try (and as we see, sometimes fail), to take into account prior
> discussion on the mailing list as part of my review process.  And I would
> like to think that I am not alone in taking this approach.  So to that
> extent, I think that responses on the ML to concerns flagged by
> AI-generated review have value.

I appretiate the insight, but this suggestion wasn't in any way targeted at you.
I know that you usually filter the feedback.
It is more about whether addressing ALL medium+ feedback in an organized manner 
for this particular version would reassure anyone that the code is correct.
