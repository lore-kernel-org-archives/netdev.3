Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B932E728;
	Thu, 16 Jul 2026 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784164985; cv=fail; b=I+jlGtSMT7oCKCV5aZMs8MbpmVLK1xjCQ+xE2uoVEhXyR3X6flw+12zaxVhRuQfiPc2OtBCH7Z4DDeIK2jizlFwcU+BXVM4RQPjaP2QrFMEhT4toY7WHQ+fp5M9vewV45uBvVE7sYqd4uxLuGtkCbb0lOrsjzAKCN+m344h4rig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784164985; c=relaxed/simple;
	bh=cJWtDeXb5V4rqOYClLTeSduo04W3fWUr0NLcNo4REos=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rfYsnc9+f4dcQ+xYkEDqAYWql28N7azQoazMvNDARbovZt4/oUTcpAzpjwQn5Pwkbjhz8Y7My3/Ueh/umbIH1qpwyHnLT1AisJ7H4gFU9oYSwtKDhLXpZu9ApuJ1J7Qk+L6qlk8SCXsAvJcnbfTKRMLqwgAz+Q/z5BBhiDZlrhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijgQTr2o; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijgQTr2o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784164978; x=1815700978;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cJWtDeXb5V4rqOYClLTeSduo04W3fWUr0NLcNo4REos=;
  b=ijgQTr2o8dE8UtjplxM4vbSlKKVs+0NuEmlRxSBOKL9s/zZlA8JbaHWY
   601d7cVJcfhf2E1dm7nQnjQFKHMQe7SC+v9yZp6KLUjl1nJvXTIRopbg+
   4trZol4nXf3EE2XyFt02kNc47udyAdljciqCTo/Obs5XA6UI2ohzkbnBo
   WL0DOs5qEBmbs2syzN/3PonQAsudxCqDw1bA1cfUo4rGQM6tdM7Bk9+v4
   p14RF1G//9+/62ctzJwc61usqp8MezNGVKNzusc+qzs+RcXfwK3HYP+s+
   xhrgmcesCCfGvNKOudvgKB4eF+SzjnMu7rTcHFHCKSxBjGs5dJ9UGOwKo
   A==;
X-CSE-ConnectionGUID: UV/uH89QRUGWFaM2RXTefw==
X-CSE-MsgGUID: 825ATti2Qh6VWSgUVSpiqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95170817"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="95170817"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 18:22:53 -0700
X-CSE-ConnectionGUID: pkU3FUWXRHaI5W46mwUQsQ==
X-CSE-MsgGUID: REcP6lncSY2D59KFeLno9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="256404197"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 18:22:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 18:22:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 18:22:52 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 18:22:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ss3bAs1YVXDP8WxaOwk7NTheyXi53RgpTfh/keifhXDtAsW54RfmesghhhdLqJZ3HmKVqf9I3LUsgmXACym7uEjgHphHID1oSHa2ufc3eZOiuRaoTOzDjZdarhfGhjsyi13Ka+hj1Bxersn/Z9X4WpqX7lAGqt9EQRzGpb09O66TfrM25IXdJvhRH/0+cTouGno6byUKfzbzYCnjohH6oq1xmz1t8OHaCj5XZw5CMmZcxHX86uQ5LnqKF9PgIi8+2AVY0ZN5HquSOq+SkVUI1Lt8LErbM73sesd2DjDKtIIcXXj2r1Pvy7o2KCkDn1t0auGEu7R7xxAAbXTzfPvDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QITe8mcKxDGrLMsa5P4ImXZqUIdmR1/vu9F9jEVFyoU=;
 b=CVDbt/LYdRB9G6Ucji+2snDS45IJR4z7WWKJ0+JsQnizCc2Hvcbq3GhkZP5ojd309vKpXpDU6zirdNBsTOYDNHJqqEM4x0qq61bbF6UqsQ9o2s145nTXk11+LpIgTweaFE/Ycdl1rOxPNny+0sQH9zVnh8tIwHaWf5EXB99zOegSgAVuk0QaqGWmCChHKsYVTswFPJytetbGGgGjwrAZKvZSWuZ3DHgcRCPsUb6XqAZ1dk0RT66Bsd9KxSgbUPZi03X3ldMn+loThFYz13zROEabxTXisf8gXQeyyW42MdJStVHOL1jwfZDXUHjin+KW55Br/C22V8eCV8K+a9j5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by SN7PR11MB6703.namprd11.prod.outlook.com (2603:10b6:806:268::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 01:22:47 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 01:22:47 +0000
Date: Thu, 16 Jul 2026 09:22:35 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Brett Sheffield
	<brett@librecast.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ltp@lists.linux.it>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	<linux-doc@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH net v3] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
Message-ID: <algyW7c79Vl1Ilq2@xsang-OptiPlex-9020>
References: <202607151550.5d829a99-lkp@intel.com>
 <1ecf0eb8-17ef-4f9c-ba87-da69d207e4d4@tu-dortmund.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1ecf0eb8-17ef-4f9c-ba87-da69d207e4d4@tu-dortmund.de>
X-ClientProxiedBy: KU0P306CA0052.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:28::8) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|SN7PR11MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e57f20-04df-4a1a-001e-08dee2d8be97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: BfqT8v5QqUvpV8vsOvVuXibJ97Rc7vP2rxB9ScZoU6DzWDA+EmtSlU8QfuXTct9crzo/EiqGHT69cn493i4wUPJMGqynnQugxFOT+tuqihTMUXhGlsZkanHfessC3w4TX16xvqSSFcagCRe7v7t9pD4zmdUa0CQE4+dX7NmCFEqGQOW0Skt62uC+fOys8SPapoqN3pzU8caJzWByzmRKVCP/9wDw4yMfMe6gBtNtb+Ih4yItYpIgotjw3AlmFveluE6AHXrtswRRfiYbKhjJCSlMiUOAcPrBHI8IoxdsYR2Jy2T2alI4nNl99AY0OIHK1megY6kVJRueVrB3bo9hYg8Y6UazWOkcE+3KsIMwlBll7/lFeTOrNtAitdQdfV6JSrXAQ+eB/Edgb/vy0vvbZJpcNQBmsKIxje6FYHr93KiAOc2X3wOVNnmxggXu3rYfDkNTROBpFvXPmP5U0qVUD7GCyD81+0AigcogWcaVinP4GsWUTUee3mqGNHBQUVPkma8kguL5pmiqyanTDNNDNmVLPWhVy6tVFtHWE5hISjTqQdEOzZulA/vNuBWqTO/cooqnnAkSvxAqU6GPeqZd+7QaPvT57l5MmtjFSA+XmAhDcPRKLypFlKg4kcEaYvVo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9caDBpouZ06RV6BKTb8R3sURQxELFk3PNnFv/Cw1Sy5noqG+wsKBsq/qFoFY?=
 =?us-ascii?Q?pynFWPkYYzaUUfWbmmyEqLJNZHxwdmsJVYwdWSCGjL0Fy3AlVjdQ2ichkvYZ?=
 =?us-ascii?Q?wKYJHr0TI3wkm6r6ckF/t0wc/dR/Y2hTK6yosswVdMl28JthAiafa9f7bt04?=
 =?us-ascii?Q?HZSmbNQLaebB3ETGv9MVYgXw0huCso16VmGbeokrRUSDzWgPpdN9f1aa1Exk?=
 =?us-ascii?Q?KnFaG3Xy3ii3Jew+ie5RC0jU0fG5ZytRTxYgzLG6o/3NdeYOMHm7tcLl0Cy7?=
 =?us-ascii?Q?wRlCMwqmhcRuSAM6cC3kdgBBDXsYZSS+2yTRh2L9onBtk4zzUOfXgBz81fEo?=
 =?us-ascii?Q?AGJ384JJTmSvL7HKy2Yvjl7z/kwLcpabdykpRrmKHstwwfUpQZ38jgWYdZqj?=
 =?us-ascii?Q?FgH3VtIuQNkHmZY7GHumiS8OMkG+VF69RSBni17Y0GNwBo1Vp3vqY0irwclu?=
 =?us-ascii?Q?hrtxjjQ8yZNFOTnxjYc7nFJUg8AD0fD3Mo8ePHlLsN/LjC+nn1dQrgQEX5IY?=
 =?us-ascii?Q?5YdpOG4BLs2g94bAcsnHu5YkB8V5tpK0qbw2szEe4jRn6WYdHFsZ5OiIHAYI?=
 =?us-ascii?Q?eCRAIHe4jpw6yVjvf41cNWGlfB748NprSmdGbXBbUYo+wjnywZZeMz1+lS0x?=
 =?us-ascii?Q?i/C9ffJY59n3OMXbP9FmA8Bjfm8kPxczZV+UFqbd/tmNyLEo48A4AS8bsGwD?=
 =?us-ascii?Q?YeRxkUCyDL9d39MKM/5VqS6cDUFn0OGZUPH0QgqrG445GKaAqrBnT7reCVr0?=
 =?us-ascii?Q?aUubeesYKsySwmx8G9GWxGNnkvW9p9LkjNUWz1s7O4Eu4d+ehE8bwYPNsKQS?=
 =?us-ascii?Q?Kene9NcIijEXwls89V9B/Tpj5NWdXwgD3quSdXEd41YE4qDliJcILhluZj8D?=
 =?us-ascii?Q?Ohh/HlylQL+yFvISLu7bK1O+s+GQuqEMFsHYybZjZZdKS/siqTFTggALzsAn?=
 =?us-ascii?Q?caowEUbj25ODV6MGcO/P2ifUjCxxYeJNBEgFIqvZOoStZABbQph42cAEDD/7?=
 =?us-ascii?Q?t3ZoeTK6zU3AmepDunPf4ldaPa3W3Ex87Gmj8m7EYoSTEbeO4OVuny/Ecaqh?=
 =?us-ascii?Q?gj4ITxKwblsgeo4EzSlazgtKkTyA42h0l42fLfQGevuX8AHuwVDlzEnkzly7?=
 =?us-ascii?Q?ZmqsKxRPHT+C2pPDmB1mJamC6xHYD+wMGf/CiR+DlN8C8FviPOGXP6cCpPer?=
 =?us-ascii?Q?0Hmenac7qJasDD51bOWTBfsoZRS3Kk6YL1vEyO+Y/bE+Fqi85eMMsR4uXL3G?=
 =?us-ascii?Q?LFnuDMfKZqjNoUabjisvHAhvHpOj5UXTJcSLHdEi1pFznbsFF9jLotnrzEl1?=
 =?us-ascii?Q?BRHtxtS97KJ7y0FPv5YttI/B2mFBtWtBi9dvATwZcT4Md1MpVUBOJZTaOAZg?=
 =?us-ascii?Q?l1LC9GzoCelmWNyr+zGgOZhgTH5s6DTp7Oz+ZLdLd+Eq5b7yxlJ/4ALm55fM?=
 =?us-ascii?Q?4morJpwk44VLGVOmPF32A19+SrwzcCQ8xoUKStj8GESqkzWds2vIUmTfyWXs?=
 =?us-ascii?Q?FF0igl3F7DqN5boCrq1BBNvuRhwSzXbYpiCjPnr3UE43Ysi7hRdzUXJ6ve5E?=
 =?us-ascii?Q?SRlJqJB3vi144vAXwxO2oNbu6B5hmCyEbp9Cp6ud2zSFwfTmHZsFOLbXOkuL?=
 =?us-ascii?Q?viBaFEe6+KITpdzI2rgqsU/GjpbAdeSk+JKUaPx96FCLSrxQT/OslzMP9MdN?=
 =?us-ascii?Q?kdUQTtZi91O4CIWq++RqhKO59kz5JiqNgqDPW/1+ZFr4nzKsdPrlsLoTB6T4?=
 =?us-ascii?Q?oozdZdYldQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: d17A5b7Le+h5eQbGbBgL5XKNWngZfgoxTrFM6kIYm6jaxltNKpFbhJ4TNzh93WHw5Lhz7jMzOZaMF0whtM84ATS/yUE20PN4zHjKBv4SfL2o26/prv94Lh0NZeTWDE5RYyXKngMGZ1c9L9xa6LrAn+OuEZYKOWlRGNimNOafL+/cgjM+TXRLaSZEn9dgUq0SDAqihngqo3h7zZcmI/EMhTG/pWSRjKsdE4tcyV4EE4F9NggxEtNGelJtUHkpyx/J6MR5OhavA40OURnLmByeJvyyXL7BAYZoaSbIlc4px5SIshmMQbapOWoS3Qzh48aloS+mgof6FYNgqiWXUd1fwQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e57f20-04df-4a1a-001e-08dee2d8be97
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 01:22:47.4138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOEptO739PP8YJbZXAZ/F10P2vavdBfDkE7sSo50m4vOXYyy02vTvV4W1hObbU+HbMlyi5qKcHVbJ1faNKIAew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6703
X-OriginatorOrg: intel.com

hi, Simon Schippers,

On Wed, Jul 15, 2026 at 04:32:26PM +0200, Simon Schippers wrote:
> On 7/15/26 16:01, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "ltp.ioctl03.fail" on:
> 
> ioctl03.c does not know about IFF_BACKPRESSURE which is introduced here,
> consequently it fails.
> See [1] where it compares TUN features with known_flags.

thanks a lot for information!

> 
> Thanks.
> 
> [1] Link: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ioctl/ioctl03.c#L82
> 

[...]
