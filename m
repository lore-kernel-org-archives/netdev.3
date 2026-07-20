Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B803FD957;
	Mon, 20 Jul 2026 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563759; cv=fail; b=T9u/B5WZ4CHmxpPoT9gQs1nviHetG7lufxC1+Kx6fjQRR2ymQu5C8WKSCm04ADMyRopMVzrDlvpG2jY24jcOyxq1rjyTpdClWbefl33jTok4gKDWb6VeyKwjgxVRll/hDC//9tYnDRUOumKRpUY5SIlyCy7Fp1AEwJ1KrFJBJjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563759; c=relaxed/simple;
	bh=zs2dSuici0LZN156QlOk7eF1h/NMnFZmM4IqLnINvRA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=deAkf9Lo3LuYo9GvYMOMjdpEaX4qnUNF3brZ/ipHoXaWknGAl5ck9y4pyaf8pitFeD5dUFpxeKhHs0gX+dfko/tX0tuKshSOvOgI1MPgUlE03xykoOkhAlTD1O/Lu2jImXXj0MmqI6p8XMBPbI/IY9Ko7V0NmxuPQqGzYSnGGbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsStKXnS; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsStKXnS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784563757; x=1816099757;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zs2dSuici0LZN156QlOk7eF1h/NMnFZmM4IqLnINvRA=;
  b=dsStKXnSH3k3ilF53Kt+efVMugcD82z3QT5e/HEKiZzV6YOre01LL6pW
   TCvnajjbRswkEjh6uV93u4/CoFsCcHc4RYw7BZnyFe7YWbqZ1CWFzO31I
   k8rOabfZo139dhefQJ76OkyvsIneX1x1ixoTr4IwQGPldiLC1npFJQUkh
   mh/FRsDiYCI8Wnxjxk/F23JbmawDg9ZMlHCFZ613cUbycTj6J+O6T1AH0
   6JTfF97unHGEDjzB+vmRKzvqEA5Oupb5ne+L1TzI4r256G+XnvhwqDKZ3
   K9pB9qDyfYom60mAkN2j0lCDxqPFh0SBuWPg7mCRBLuqn0Z1zzGAZ+3gR
   Q==;
X-CSE-ConnectionGUID: 3jyk4dPPTxqPm70JRBxPOA==
X-CSE-MsgGUID: LIdCX6NsRe+T/AeXAEnEpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85187742"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85187742"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:09:16 -0700
X-CSE-ConnectionGUID: eN8XOgFKRCmTEsc9dQonMQ==
X-CSE-MsgGUID: C7yAq5ksT1WLIE9lCMGOOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="256924249"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:09:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:09:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:09:15 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:09:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyiOF9XaynONTwgzwy3NiQiby6wRhcXiDbtEyfAybLW49rK2oguBEw07vlNP+XDwjX2F1Zxpda6Hgvw0fcB2evj3Ob/f3sjAeAvxsZAtMIfnf5ZpGHo+28j4sOGucwmYh9UluIMouZcKLBOqV6TU48QNXqwe2uZjzMzgaUQTOsv8TaL6poXKf0GWeRecjkvaTYxR8U8g4K1GTeRoHftu44Etjd+D155DZr+VowbJ/rcZ3tmZ7EKTXcpAhj5BQ/iIBYtZ3Ft4jOyU5oSGVhFfFDpToV01W75XPxrZ0xOyd6wekbZzUs+pL8xfs3qPfTUmlWhqCnDs5Ovk0+7IeQKnFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjerUHkB6KOhYj5vbnCNVeA4LJsg+gS9nCuG1KepfIQ=;
 b=ZPASFCYSFALkih8vCL2xZtGP/kIey8V87UYKh++fIvr8ome93b+bt6xrArzo/yqtNJFqjEFq5sLFBBK8FndKCG9FR/SiaBaksrgFJRqUFuQbDK5D24ujKZXyrM7y4hguye3EI+Qh0gkYAHGicMomHtqPS1DO3JN5gXBdhTvduTJXl+MdjUY69LUeddCajv4QpxegTsz3OBKvCmHImPfZgU30tTgFTeB1DwAPDK9/X0H3nzU+mJ9+9z++bD43Mlxa25BM4f6J44rSnfjL3+rbeIlDXG1+Vihd8tnRaWqjysLN6MFfLo/uVdTzrHBl8ikiP2hHbwZf1ZNaRUXA3jFqPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:09:11 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%6]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 16:09:11 +0000
Date: Mon, 20 Jul 2026 18:09:02 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Pavan Kumar Linga <madhu.chittim@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <sridhar.samudrala@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <skhan@linuxfoundation.org>,
	<linux-doc@vger.kernel.org>, Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net-next v5 08/15] idpf: refactor idpf to use libie_pci
 APIs
Message-ID: <al5IHo3ZO4Qhhhqn@soc-5CG4396X81.clients.intel.com>
References: <20260715180042.1972010-1-anthony.l.nguyen@intel.com>
 <20260715180042.1972010-9-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260715180042.1972010-9-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AS9PR07CA0048.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::15) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|MW3PR11MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9fa4e0-0ce5-45c5-e6e8-08dee6793c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|10070799003|376014|7416014|6133799003|56012099006|5023799004|11063799006|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: cYrjETqUjvoymGhe/xGmRYg+A8xofgvjid6nJtvuEIhsjKksX9JGiOpuOX+HjaLUSkm0B0DgBIEOPu8ncNzTS4Z2/Pv1NaNefh4yEbThtkez0VEL/Fejs+aXe8QiBaanQ9f/ZAmTbO9qUnGUJsGDUdm3V1pDPwkmwyOk0g5vQQacPhMfVDnHqQxoFoorGnrSse07NeSqyn8GZwwoXxAQPPMNDxSiM1je1FUYXKn7TryxFzrANUhlqoRomj5Ba1GByOzltAW7eNI7GB2pgqdpB7yu/igDLB6/xnOs3xlf6jxn+OUg2YjQNfO5nH2JF+/9C6cJ4NKm1cFi2FblDrI5Z3/K2Lgr13imCB6l2rhoGaEVxZ/a59mqO1lbZb0wraXxVsQXXZnd4RYwLfBuxg858T1J5PO/hkEoDxJU9V/o0W+ipNVAzABbiWvqhnoOxvo6LqgyxaRwt73L086i9yRYkvfZHnHqpvPq+lsNvdnsi+rAIH4SSJIyLoFugYw0Co79tQeo/kH6bzgzWZAVfB5Zu5BlDf45A1l+Q8TjA6BZCJZsRapmLh22mxJolEPNWcGwVaVsz0uHiIuN6rJ7KazDgPcgiN2rgxHTfECgN8Nc/e0JkvJZ1r4xjxVstq84Bo5dAx633/RpClEhNk7Jq4Y/XcXLJjxE8/w5fu9h0StTop0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(10070799003)(376014)(7416014)(6133799003)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A990wRp/s0bkgsf+oYnr10vlmuvxshfCeNmRbv9JQ5zNDdje44UngwV3LBpm?=
 =?us-ascii?Q?iUWySnO03PugcZWh7eD8sodb4kvE0cYLTGXMX6EkuxA662bmEMphPCj5qjxx?=
 =?us-ascii?Q?nUzwlbNrXleePAhSedBWGxPlVa+a7jtboJYGpcVQfSzaRtLFvgXHcSFvebaW?=
 =?us-ascii?Q?oGjWHSEX9HrsRbXd2XnMp+p9KAyvoBpbFvumJFQzRa3ayWHmfjxmr0nlI/xk?=
 =?us-ascii?Q?h4sqrGAGp94hGa8lT5c4AIDH91WYuw2GbwFTjRLJ+M3z/dN0dzET8qHbT/ny?=
 =?us-ascii?Q?g6BxkXWLWDJFfgETTNTWF7OHUkoqaBp3/mHYkbHqqNxEAEAvESJ2TTVtkQ+c?=
 =?us-ascii?Q?Kij+JknP3gFwJ4CRFwHOiuhIKKlLYgOzwKdQsrbMMFaScVyldrIbjubU8F3i?=
 =?us-ascii?Q?8MN2i0GJuqia6POLbxqVoUZk4aBKqwdkqumgIydrW64TPF3CYH0dzinl8Aqe?=
 =?us-ascii?Q?hSMwk+2AazjiAuZfpUuF9j2oH3Rq/t0Atkgl6TKHfB4H0SaWa9EhYk5ONzc4?=
 =?us-ascii?Q?NcSqH2/NHfMKUtqGwzt1GlnqAdYcg39/fIudtptjrLS6hHqVpRMb5WdEfxvD?=
 =?us-ascii?Q?uNbpuugV2zGAzQ8QGSeENPUV7eLkoSOcQuADt88Uly/KdWG9BiysUDHN/xDT?=
 =?us-ascii?Q?MchOtgRyDHtBZKs3UQkm0mI38fdAc8ze/8PiibVmnzr0XGV8pHYW5DDz15Ja?=
 =?us-ascii?Q?rkLs0J2IfWQYVDRcZY7zjvUbivDV+XkWFjxrTe5kxTVFBPoo9GPUUxQTloJ5?=
 =?us-ascii?Q?FdH5mgvp97fk2Mg2sUUHUqepx/xVEPDBRrSuJiJ70V28lhXQuvQ8dCSaHgKG?=
 =?us-ascii?Q?BpuRdIxRpRArWrH+iYTT1Bsw8osY4O3gauyg0Cd7I/DrVzoZGPwyKPJloAfC?=
 =?us-ascii?Q?HBmWdMXoQKMZWi1DAr0ZJ8067HmnQZHfqwFZgn0C1WaE65X62SrRGbmdfLI8?=
 =?us-ascii?Q?g72MqTiQNJRTi4b6tTdowNwu3xGP9W0lj4B0mMYp1GrtEZyUthEBks2ocKma?=
 =?us-ascii?Q?xM9xwRb3gWX8BU87V/4CK3W0upAkttuNbWSxmKD2m4MHT6Rli0yI5qgYeUQb?=
 =?us-ascii?Q?49RBoVd16z0caU/wViDyuo6b54brD8DJODffH5S35ZwdPqL6vnB9VLZs07b4?=
 =?us-ascii?Q?Fo+40CpcRGMRn09kLHAWItaTvL+LM3oCE4i4YtQsV6P4EZmZaOVrnDsREc6F?=
 =?us-ascii?Q?/icsv4R8q8V0aqHP5Fdzp3Kbms6/PcWRWHKSJFrNE1i0SxlORRD1VTxpSk8c?=
 =?us-ascii?Q?GaAwqd+tEqaJamPsqpmoYup4QD2pG2b+Vtzsau8Tt8KIhwnaUoV0daIgp6rq?=
 =?us-ascii?Q?01XAketyguoqErr89mraaPI2NmYvUmxPm/zYGjGi+vYb9MVZFhgGAL7NoWh3?=
 =?us-ascii?Q?X6FREhRmNMIDLE8JdOc81nrPXG2HAzhLZDRyXYQyCVLv2ges7ODtGlfnaRwD?=
 =?us-ascii?Q?WHSlxyPtlYMBx/kRS6VhambMk+fogJKpIMIJXSU3S4hT3fpIK17VOpU2abUY?=
 =?us-ascii?Q?GXTK8mziBSknrfBNn1CiwNxzcfdCuef+DwuC0dysvNuC80uWBcQ98Wg1K5kO?=
 =?us-ascii?Q?U/+5Rcd4vLBRPmoIcO+2LheO36xxV7ubLhQSNUj97VL1YzK6abiagJGH3FY9?=
 =?us-ascii?Q?PAnMEhQXmc921KBFxsWwhdk9Zg+eeKpiqWdNiLIcwj/1vC8SlbZwEZ02qnYv?=
 =?us-ascii?Q?bv9qqlC0qKY+i929kV0AVDyp5RVwB8c2x+nNZ96XsfMUXRNx9iIBdxKSkcPz?=
 =?us-ascii?Q?gf/WRC10dX5OgvxPuayqLEoIPQZWN06XWfKig77YhB3lB1uwa70JBOj5bfdD?=
X-MS-Exchange-AntiSpam-MessageData-1: V0xiccnTMIipC88lnBFo+oca7qKDb8L7XGQ=
X-Exchange-RoutingPolicyChecked: L+0lCaBQc4GZE0C0eLBs7lt3qecsnhV4oiJHrn0bHwvUgj3I9qhSHDL2fefNLSe+9XuGs65buGdTZMxzZfW5bCKY2RB3Y6P2py60PohQ1uEvb/ew4fv8nh12CSqFXbpYRRgbhCIssidJSDywnkngBLchhIr2TAPngYOkNxUp0HJmUwv4S+HhEPmJwkl2gq4ocneJKkXJFGPf7Lydq2LT3z7v0r6NqsNT2tyN7cPJd0MBpHJctCeZrFs9BSEaS4z3K1eh+apnyjwiXKlIxljE/IRKkvMl7EedeyrlCO/OQ8fQi5T490xi86W77fgRf0Mnwu3aiiRsW07OPAT++SRfnw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9fa4e0-0ce5-45c5-e6e8-08dee6793c8c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:09:11.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EGVt6onw+UHFdkdikNCZgh1jBv0LusMt5ja3LASVIJqLH867IrxhtE+uKBVzhofwwJj0KGw4c0Fc8eeF2kDAGMz+h50CggvALUsGIzs4ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4556
X-OriginatorOrg: intel.com

Sashiko says:
> > +	wait_for_completion_timeout(&xn->cmd_completion_event,
> > +				    msecs_to_jiffies(params->timeout_ms));
> > +
> > +	spin_lock(&xn->xn_lock);
> > +	switch (xn->state) {
> > +	case LIBIE_CTLQ_XN_WAITING:
> > +		ret = -ETIMEDOUT;
> > +		break;
> > +	case LIBIE_CTLQ_XN_COMPLETED_SUCCESS:
> > +		params->recv_mem = xn->recv_mem;
> > +		break;
> > +	default:
> > +		ret = -EBADMSG;
> > +		break;
> > +	}
> > +
> > +	/* Free the receive buffer in case of failure. On timeout, receive
> > +	 * buffer is not allocated.
> > +	 */
> > +	if (ret && ret != -ETIMEDOUT)
> > +		libie_ctlq_release_rx_buf(&xn->recv_mem);
> Can this cause a double free on a stale receive buffer if the transaction was
> aborted? When a transaction is returned to the free pool, xn->recv_mem is not
> cleared. If it is reallocated and enters the WAITING state, it still contains
> the recv_mem pointer from its last successful use. If libie_ctlq_xn_shutdown()
> aborts this transaction, its state changes to SHUTDOWN. This switch falls through
> to the default case setting ret = -EBADMSG, and this cleanup logic will call
> libie_ctlq_release_rx_buf() on the stale recv_mem pointer.

LIBIE_CTLQ_XN_WAITING can only occur in the previous critical sections,
since it's only applicable to idle transactions.

> 
> > +	wait_for_completion_timeout(&xn->cmd_completion_event,
> > +				    msecs_to_jiffies(params->timeout_ms));
> params->timeout_ms is declared u64 in struct libie_ctlq_xn_send_params
> (and stored to xn->timeout_ms which is also u64), but msecs_to_jiffies()
> takes const unsigned int. On 64-bit builds, values above UINT_MAX get
> silently truncated to 32 bits before conversion, and the MAX_JIFFY_OFFSET
> clamp inside _msecs_to_jiffies() only fires against a value that already
> fits in int, so it can't rescue the truncation.
> The async path uses ktime_ms_delta against a u64 correctly, so the sync
> and async paths would disagree for the same input.
> Should timeout_ms be u32 in both structures (matching msecs_to_jiffies()),
> or should the value be clamped before conversion here?
> 
> > +		if (!libie_cp_can_send_onstack(msg->data_len)) {
> > +			libie_cp_unmap_dma_mem(dev, &msg->send_mem);
> > +			params->rel_tx_buf(msg->send_mem.va);

> [Medium, Medium]
> Two questions about locking context here.
> First, params->rel_tx_buf() is being called while ctlq->lock (a plain
> spin_lock) is held. In libie_ctlq_xn_send() the same callback is invoked
> at the free_buf label with no locks held, so the two libie call sites
> impose different atomic-context constraints on the same driver-supplied
> callback. Should rel_tx_buf either be moved outside the critical section
> or explicitly documented as required to be non-sleeping?

I see no reason to do this currently

> Second, xnm->free_xns_bm_lock, xn->xn_lock, and ctlq->lock are all
> acquired with plain spin_lock() throughout the new code. If a future
> consumer drives libie_ctlq_xn_recv() from softirq (NAPI-like, which the
> budget parameter and page_pool usage suggest) while libie_ctlq_xn_send()
> runs from process context on the same CPU, wouldn't the softirq deadlock
> against the process-context lock holder? Would spin_lock_bh() variants,
> or an explicit documented callable-context contract, be preferable?

No softirqs

> 
> > +/**
> > + * libie_ctlq_xn_deinit - deallocate and free the transaction manager resources
> > + * @xnm: pointer to the transaction manager
> > + * @ctx: controlq context structure
> > + *
> > + * All Rx processing must be stopped beforehand.
> > + */
> > +void libie_ctlq_xn_deinit(struct libie_ctlq_xn_manager *xnm,
> > +			  struct libie_ctlq_ctx *ctx)
> > +{
> > +	libie_ctlq_xn_shutdown(xnm);
> > +	libie_ctlq_xn_deinit_dma(&ctx->mmio_info.pdev->dev, xnm,
> > +				 LIBIE_CTLQ_MAX_XN_ENTRIES);
> > +	kfree(xnm);
> > +	libie_ctlq_deinit(ctx);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_deinit, "LIBIE_CP");
> [High, Medium]
> Two concerns about this deinit path.
> First, do large in-flight sends leak DMA mappings and TX buffers?
> libie_ctlq_xn_shutdown() only manages xn slot state and does not touch
> the TX descriptor ring. libie_ctlq_xn_deinit_dma() only walks
> xn->dma_mem (the copybreak buffers), not ctlq_msg->send_mem for larger
> sends. libie_ctlq_deinit() eventually reaches libie_ctlq_free_tx_msgs()
> which does only kfree(ctlq->tx_msg[i]).
> Nothing on this path calls libie_cp_unmap_dma_mem() on msg->send_mem or
> invokes rel_tx_buf() for a msg->send_mem.va that a caller supplied via
> kmalloc. Wouldn't every posted-but-not-yet-completion-cleaned large send
> leak its DMA mapping and buffer? The kerneldoc only requires "All Rx
> processing must be stopped beforehand" and doesn't warn that
> libie_ctlq_xn_send_clean(force=true) must be called first.

Could be phrased better, but idpf and ixd use the API correctly.
