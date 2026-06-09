Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843B3EDE7A;
	Tue,  9 Jun 2026 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993830; cv=fail; b=ajjEle594FxM9MhvoSRmhS7JI5xRtMxH62WbWVSoQvjPlpOaFDeAwYGHlCOgxapS+DqB/w5T2Q7oNJXZlKNVOEmbPCEsqHKEYUA/fyqMKuUTQTRt13TDvi3U/qHMgpRQc4pIj72K2xTBiqWFad5+Q55cE9Z0f5AwB6SdUnkfa6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993830; c=relaxed/simple;
	bh=ZH4XtXjZPOJW3noVd7Nja5kUGkI9fOAdRX30Sl0YnR4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gUVhnYI4pSoeIHEX6mVJIDsVSBfzUnlsuM3AfmUeqn1HDq1ss1TfDUF8QtDBXSMGnm+Jssn1yVqHB1jm9KY/WQtDMpK2f8VuPV8wwEbyAwS3V6Ma/GHYrV9bwYPS/4uT9W1qYYutJMAHlhWN22LtwuTCPDfVJOMA077FRiSY+cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kzNO7fOy; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzNO7fOy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780993828; x=1812529828;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZH4XtXjZPOJW3noVd7Nja5kUGkI9fOAdRX30Sl0YnR4=;
  b=kzNO7fOyL4F9KDIS5wifG+CoSAh4bqEmNDLNg2I1XdW/aV5EpkIajR9N
   HNiazpsV5un8zIPx/eekxZOftNvlo8uz0u1Jc/4JD4dnwz3g7G05Zktoc
   f0Au0J3T2SbiJUIVyYZYtxGLXhO/WuPJqJra1wlcbHZt8OGRvJ0hgTCIz
   OXl9yW2/T8Yilu1kEd82hxyceObTNCOlWyyIt7Pq6bkQmxiPIbd2GYyUH
   VCIqJa7hcz2+8x/7FBgoghR48l3rUxok8SJlGao41vOi8nB+oxDjMNPqb
   oSwXJ4iJZk6RmxJXFP5v8Y1EVMiOKDHK/2DKRFW3A0j7xspjITXSpL/2q
   w==;
X-CSE-ConnectionGUID: HDkc1X8hT2iX/aTJAxgokg==
X-CSE-MsgGUID: oujpz98ERUKSHdDuLHXlvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81600363"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81600363"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:30:27 -0700
X-CSE-ConnectionGUID: +xtLEu2cRiyGvXTR73g2wg==
X-CSE-MsgGUID: 8ZnCT35hTTGTrmDK/4vA5A==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:30:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 01:30:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 01:30:26 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 01:30:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiujylXaAom/7wEH8r8fIrmgtH2/hG7VATjhi50VlaQPIjzZ1QoW1uFeB/Nj+QUWw5OnMULbh6QxM+Pbljr8vvAKVz0mLWVzuG0uEtUSbYjHAusjtaED796Of/OBVe2+xIavE8f7r/gRUlVbF3cc0IN1j+q16RMv7lEap+MZZCTuQz111cI5P0W5S2iityYKIO+/FNXA58yAJR8RhRfI2bVVzm9EQcablrlTcQXRIPFLtLAOoTV6uorlEoaAYdl+qV8HW4V35pf4IMoY78gxFUexaOLJaGxieTVGlZxFl9NIvxCG2lz4Po5xDMkr1+O2MOkmsZ/VKwMkDJKP9L7Vgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Pmzika9PFypCG5JzbQqvzNEjb4b+DS+eBV2ZHhWEpU=;
 b=IxUhNTd9L83GmlTxb76PqPzPUiSLMvz4u6AnXkT/rKXG3UlsYEPkMar172ccjGP1cZ3lFqMysL7iIgzHqhnZZJ3Z9Fpu9B4zarkaD04ZF3f1rBju/r+SJNctZ8wdLXHVcXQ1IMDyjreZkUq9rVJYK48KFjhbXLXDN5/AfI2eFHRJFsCCKeGG6JldPzwW5Jdgq7YPLHNK3L61j3ST/PfmBLqown/Iv4Rb8/0Eg3RQq5+Gm413ERe7ORO82l1EpgmgHvn3yln4IrN+/GpnGt90/N8SyB7VvKqw5c8uqttZrqm54nBztz8Xpn7IK3Msw/FiaZqu7Rw43OYJt9bxiiAWxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6687.namprd11.prod.outlook.com (2603:10b6:806:25a::15)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 08:30:22 +0000
Received: from SA1PR11MB6687.namprd11.prod.outlook.com
 ([fe80::ff1c:7079:78ca:b030]) by SA1PR11MB6687.namprd11.prod.outlook.com
 ([fe80::ff1c:7079:78ca:b030%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 08:30:21 +0000
Date: Tue, 9 Jun 2026 10:30:12 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Salin,
 Samuel" <samuel.salin@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v8 08/15] idpf: refactor idpf
 to use libie_pci APIs
Message-ID: <aifPFEfHKpIjG9PL@soc-5CG4396X81.clients.intel.com>
References: <20260608144127.2751230-1-larysa.zaremba@intel.com>
 <20260608144127.2751230-9-larysa.zaremba@intel.com>
 <IA3PR11MB898641BC991D8EAB20EEA185E51C2@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB898641BC991D8EAB20EEA185E51C2@IA3PR11MB8986.namprd11.prod.outlook.com>
X-ClientProxiedBy: WA2P291CA0028.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::23) To SA1PR11MB6687.namprd11.prod.outlook.com
 (2603:10b6:806:25a::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6687:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: d98521cc-71c4-47fe-69c0-08dec6015889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: X2KnbavbsHKUBZo1aeTT54+/zczhuMR8luVXmgNtWWDdcOAExo+s10FK1CM9aH1M+6lePTXE28dCvxA+idWlJRimtmmMXIk/jg6TE5C5FjogqaiFvTViYUUwZCyF5ax74qVemTfHLL27JnKoVITDsrXdYdhyEJ7ABNtlddoyYuh+M7Hj8MAuQmnkOT5wh7UkbdRpuK5sjN9E+dVqlk6bI3VjWXMJEol8GhzpSQ91dmuUcJvc6R49uNcf9eVv5HwMOxvFjSnIikcqZ9U+ZFMziTtjellUEcKpJdCJjjlGFe0IWrVZyvmlTC2VbpEzz0YwTRDPh5Pywf35GtHccP9XWp9tcn87N4llCzJ0ICKZf299p64uxpx1zF6UyEZmRutPQtVpg/JFDCOnZ9+Svv23eJP1hxGB/wKBc82XlSg9oXlrID608sXIWN3Soj2oBxTXRrT78LkmGLlPTE6qgilC3uDecVtGjdWIsFvPos3P2+HrOX33CCvKi9hxWLoKIJdK9S3Zu/01eH7iYCqdem8iND4jHeHGNYWIoa8VY9HgE75ThxpF9AJJsg8K7SAUnr9+50iBQlGee/veyav8NC4uNzRSIGeJBLVGgEbOO7aJ7rop3jRc/pynOj7i2ZLzqJSExrmRMPw3SOuDQBbYqUXw5EWiFbKNYkqW8EfS38ydC2oypIZjeOxiuFwn3dD799iT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6687.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k98fVKYWA5lGwQuxNPoU3MTswpbe+w7mAKmG8NIbyNoRIwcWAf9fF0DVviiO?=
 =?us-ascii?Q?m7Wt6zKuD5PNsByevwBQJI9JoN6+wR2CZSpxvnbBxw+2Bv39Yb/pMKoCeuwe?=
 =?us-ascii?Q?elaptwbaQ/RbgnOmxfzf4h3zBwoMWIZem92M8Rci+mOJ5D6U5J/R9BIhTviC?=
 =?us-ascii?Q?38toGY6hhEegrzLYgwqq+aHaSkJHwPyT2wvy7oswocAw3uNfDSs9RmDDH7sF?=
 =?us-ascii?Q?nPiVkGYrslHBvvXmQ++U+CaEMo54AILpgiAQTAXq1kltBJ6xtwyX6Use6x/k?=
 =?us-ascii?Q?Mp2HjVYpQSQmn1BwWPQTPEVKlwqIaD+8RdpGEZiRpNSBI6NTO44WvJ0BuauC?=
 =?us-ascii?Q?B+o8ButI3qayaUAnyUX3Y+5ue6x+x8C9ScNu0mTe3yd8UJft576dTPNunb/d?=
 =?us-ascii?Q?op5wV+6T06XxWNZx5T3SzBj3enkEUswZdmXaknkcATgbHEJKzG8ojUhhR5R0?=
 =?us-ascii?Q?05NY5dUgdMbzRYX/dmifVFTncC+4vGLZJ8FpWZ2CqB7MGO4veVqXo++yWLJ+?=
 =?us-ascii?Q?ibWeJ/Qxb1uDJdDZN5K25ELxtaivl7Qry2j5q3nOb9YEcG8I9uW9yZSZySY3?=
 =?us-ascii?Q?JBWX9UlXBK2rUdv4uw6CcRSZYiszfgN9FpCj0HVkRLb39nA/ROfY/INrakfj?=
 =?us-ascii?Q?IJHB7UgkniNMJOk56IrzbjNPhBAU728n8aYzm3D/SCMbpiRVlOS9kGQu4j8H?=
 =?us-ascii?Q?OPL09coD/F1H/OXwsCJt8U0r/hCq2F8Z4EXWulh6LhSm47pS3zaS3QdJZCKd?=
 =?us-ascii?Q?Gwjta40IefFj0fjCdd3qjZ5bVQYxS77zqI3TZFix5tGmbdiNh5yIZfgLMIJ6?=
 =?us-ascii?Q?FLVh+Z8TkaG4fNYYaranwj8N2VhdXqFcRRyUEWveN8BC3uTXPDuunlhb+Crj?=
 =?us-ascii?Q?dN8+McBJivu4apBouPpvg9YayfbSKNW2oK2xxeAyaU0Orjvogx4nYdfkMM5X?=
 =?us-ascii?Q?WVys0wYV9GLz2ErCAFCsrolxo3BK8xGsoHbxTbnhgs2tjFds8/J+2KbbgKBA?=
 =?us-ascii?Q?0hP+lpCXRkMBSqYL27ZK/jz3k51oxvok8eGVf5V+8btwuNqwBIsIRtGRWEdx?=
 =?us-ascii?Q?minKB9UUP7c2x9hR2ig17krJ+sIjRIHzkNS6CR225b8lLzWORTaHyZmvQB3R?=
 =?us-ascii?Q?yFLxjSmvS9bgsW85Nr+YMk+XoBL+cBTlcyN3HRT40+L9XtAETsN4bouRnx5Q?=
 =?us-ascii?Q?61nGUujXKKhLD+6QHiub59TOez7eNv5gXx7VtUwqtbDLndPvEa8/+3dAy8Sl?=
 =?us-ascii?Q?aT17TjuGslx6EFDIIpdjJCayH9+2C8fGhGna9+F35k7zPcNWXy7CtgNP1vJL?=
 =?us-ascii?Q?dKxAaHQAcUFMP29S+akhG9t9srZBRioyhFyGzDn4M28JFIEWpmbTWPULbGJ/?=
 =?us-ascii?Q?jLzvalo55eIDADmUKR7v1CE/x/Cy7KjF0ZoB+CIwQCN3lEZY8bHXPTgRFUGv?=
 =?us-ascii?Q?Q14RVgi5UGdU+/zKml0stAaMosPR2CTYO6iP5vuVZIPimgcEsUoURLai5NIl?=
 =?us-ascii?Q?BzZDlNc9lvhHlapJg3sUgo8awbNMQBv+rFTEXsTIvSJURmaFRVKPHyy+PXcY?=
 =?us-ascii?Q?kFOqvoY3BG2LnBzmok5XvF960OpqdmQDe2zX+f5RVvrpBPwQ45A1CtMSN0JU?=
 =?us-ascii?Q?MIhgeRcsu1clEk7Spgenm982w9Q2SQjpo44mbnwMcQIouRzsJSo3BbUr3w0Y?=
 =?us-ascii?Q?sXmJyoyQ5NqHyGU3X0ldqjIG5kkTbhZR3N6VIAsx4QYu1yKThK0vTRmHPKhz?=
 =?us-ascii?Q?LcksMCGzcVZBjVq42gImVJgqF25Ovxk=3D?=
X-Exchange-RoutingPolicyChecked: qkZFSKZw6zjkZxnId59hAMLRbbgrQjqoHlEKwq/fwA11JePL5N/fMFiTnoV/XCr62UV5A1GUS/umOrmbCQ0AkrtAhgzb9tW+2QjGQb1OXIC+bgHdDFMfLkc4MP/3w8A/KSsmm+89/IMuZzgU/sWkrBWC2pIsfqTAVt7OqAJFZyZHeLUlC/h5A7/I3v033UpeUTD6jfSiDoLkNp+i3anAngvkHU4sASGKuWUe6pHhmAlX9cx89TcZ63CzAXcnuYcTAMtq6vpWoHue+LQ6dXo4KeAZZtFhWfk5sHHI27C2xEheGepfzckHSXNH2ZQb20NtrWlOWktFHdwoSfo3k15Ubw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d98521cc-71c4-47fe-69c0-08dec6015889
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6687.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:30:21.8896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Duhj/HtIUxI5IMitOH+cYB6OLDfOW8vEIl7JdwyFVtb7ao4N5w3GH56rn0PE9FTLbWExQ5YurO8CfMaAn+ScAsSxHuzrrWhUvh1tTWSyJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444
X-OriginatorOrg: intel.com

On Mon, Jun 08, 2026 at 05:16:57PM +0200, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Larysa Zaremba
> > Sent: Monday, June 8, 2026 4:41 PM
> > To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>
> > Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> > Sridhar <sridhar.samudrala@intel.com>; Michal Swiatkowski
> > <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> > <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> > <maciej.fijalkowski@intel.com>; Tantilov, Emil S
> > <emil.s.tantilov@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> > Hay, Joshua A <joshua.a.hay@intel.com>; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Shanmugam, Jayaprakash
> > <jayaprakash.shanmugam@intel.com>; Jiri Pirko <jiri@resnulli.us>;
> > David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan Corbet
> > <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> > doc@vger.kernel.org; linux-kernel@vger.kernel.org; Salin, Samuel
> > <samuel.salin@intel.com>
> > Subject: [Intel-wired-lan] [PATCH iwl-next v8 08/15] idpf: refactor
> > idpf to use libie_pci APIs
> > 
> > From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > 
> > Use libie_pci init and MMIO APIs where possible, struct idpf_hw cannot
> > be deleted for now as it also houses control queues that will be
> > refactored later. Use libie_cp header for libie_ctlq_ctx that contains
> > mmio info from the start in order to not increase the diff later.
> > 
> > Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> > Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > Tested-by: Samuel Salin <Samuel.salin@intel.com>
> > Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
> >  drivers/net/ethernet/intel/idpf/idpf.h        |  70 +-------
> >  .../net/ethernet/intel/idpf/idpf_controlq.c   |  26 ++-
> >  .../net/ethernet/intel/idpf/idpf_controlq.h   |   2 -
> >  drivers/net/ethernet/intel/idpf/idpf_dev.c    |  61 ++++---
> >  drivers/net/ethernet/intel/idpf/idpf_idc.c    |  38 ++--
> >  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   7 +-
> >  drivers/net/ethernet/intel/idpf/idpf_main.c   | 114 ++++++------
> >  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  57 +++---
> >  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 169 +++++++++--------
> > -
> >  .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  58 +++---
> >  11 files changed, 288 insertions(+), 315 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/idpf/Kconfig
> > b/drivers/net/ethernet/intel/idpf/Kconfig
> > index adab2154125b..586df3a4afe9 100644
> > --- a/drivers/net/ethernet/intel/idpf/Kconfig
> > +++ b/drivers/net/ethernet/intel/idpf/Kconfig
> > @@ -6,6 +6,7 @@ config IDPF
> >  	depends on PCI_MSI
> >  	depends on PTP_1588_CLOCK_OPTIONAL
> >  	select DIMLIB
> 
> ...
> 
> > +56,14 @@ static void idpf_ctlq_reg_init(struct idpf_adapter *adapter,
> >   */
> >  static void idpf_mb_intr_reg_init(struct idpf_adapter *adapter)  {
> > +	struct libie_mmio_info *mmio = &adapter->ctlq_ctx.mmio_info;
> >  	struct idpf_intr_reg *intr = &adapter->mb_vector.intr_reg;
> >  	u32 dyn_ctl = le32_to_cpu(adapter->caps.mailbox_dyn_ctl);
> > 
> > -	intr->dyn_ctl = idpf_get_reg_addr(adapter, dyn_ctl);
> > +	intr->dyn_ctl = libie_pci_get_mmio_addr(mmio, dyn_ctl);
> Probable NULL dereference: libie_pci_get_mmio_addr(mmio, dyn_ctl) can return NULL.
> It looks like no checks were made.

This is consistent with how idpf_get_reg_addr() behaved, though I see that a 
BUG() check is missing in comparison, I could add that to 
libie_pci_get_mmio_addr() I think.

> 
> >  	intr->dyn_ctl_intena_m = PF_GLINT_DYN_CTL_INTENA_M;
> >  	intr->dyn_ctl_itridx_m = PF_GLINT_DYN_CTL_ITR_INDX_M;
> 
> ...
> 
> > 
> >  	return 0;
> >  }
> > --
> > 2.47.0
> 
