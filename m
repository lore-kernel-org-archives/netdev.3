Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BA442B738;
	Mon, 20 Jul 2026 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563896; cv=fail; b=nzB8UhO1h30Daq+S4RZwfL4t2a8tGLK7vogPltP4jvwlThvzSKV6n7C4jFBaCmfoB1aFBoIoPPhvRoiFZN4FC4z4c929zb9T8UX1bNnmCXQEUO+m7r6aqr05T+UCPZSIxnIKoW+m+j3IDDhWEg/dQUg7Zh4pOLieYq5Fn6oIzhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563896; c=relaxed/simple;
	bh=HpcVupoHd8A0OXIcS+I4JmepIu2Ie6tt4TZIPF8jyX0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iFlNS/k+czq8wMT29KKvbL9ycnBSe+TpuOnRvyZm2hp0Yk4RzBxRyZomsVuCWQZeSORKkqgCZpWswSYq009iGsIhRWvm9JS2P9pArNM4fVuRpVv4bKkma93CWkxLYRUDwpcPVJUBF0ZL8HR2qZR3/avLichU+NolJh5xetKVVGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLZr+gzK; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLZr+gzK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784563892; x=1816099892;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HpcVupoHd8A0OXIcS+I4JmepIu2Ie6tt4TZIPF8jyX0=;
  b=PLZr+gzKuZiKl15FDtoVLar+Avq83KTl/SbG0m9iyimdh2pqTktHo7ka
   Yz+31scKgqh6fglE4JvCyFdcIWUdiIORxyVsfZmo4y2wDBrl2dkmbIr9C
   eI4IQF9+lTq5I+rfiztCLbMfabc4AKDJ9smR2wTz/VO7IurvHM5qIuBDh
   gccU7OfD47ceam4qzXkFoZjoQ2svZoWCU/sashI9FkOBTKL2wZRQ7JGFQ
   AyU5pRw1lOtHcpkPi6Ncfk+hR6xOfs20w0BrhGg7oHw1ZvCjs0K6rEwT3
   nkk6+3VN/DWkmc1GBXweV/tBp8wQdEi/4YRc65jTu3FCrtD3I7QgZJEIt
   w==;
X-CSE-ConnectionGUID: bpxadBzbQdqCzvQeaK/sig==
X-CSE-MsgGUID: 03v6w82iTi2JnHcWJB9MOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84914404"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="84914404"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:11:28 -0700
X-CSE-ConnectionGUID: rTSgq4/jR9yR9/ooER3+Ww==
X-CSE-MsgGUID: WfVlq59iSe+7C5XIzMprhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="261062454"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:11:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:11:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:11:27 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:11:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4n190SFdvO0LtdnwkD5MjR8OJo+/RRjQyznOUj4wnw6Lx43Y/GqbE8yINY6c4C7LFSmsgst1zeq+STww/Q1iLYOYRySGQQ82MK9SVD8saeFzS/o1yYVKlmJs+AbK37qL64USlOFgbkCG17MiqPkVVizpFzGcUkzrhd8gN+E7TPehd7uSQd1s8GyF2Tu7jL7OoJ9wPAWbGpqTuAURCsc6G2SdG6oauUxEUdr+n5IMPp8PzNwyL5GvLKCyc9dTBXi/g8SF5T80FscCYvHBy9KHVM2q8RscygvjWheIcgTbGcaMgk/BUmm5iiBnI2fQnCn0Q2nWT7IdoQXi6phSexvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSpkTql61jKPHVm53Dv+siS9jfoNnSApArZ7OQFzObQ=;
 b=wqYUCadYonjY5Oi/5mweAefjouMSQKAPxaNNp7cdqZIwC14U/I4h/vSHPESd0iyYOibMMX5MKv/J4hhXz5mULqNFrD/DLMQ7gz19EGFQ8sMZEDI3n/Mk/9sdDrE/ao+EnHF1SjEnoTfjLizivHaKr74sIGpbdTDgbDS+Gw3ydq6LU3m0p/GIhapaG+jwnf6k0fFkWhFgmOMDLefrWb8mOIj8wS0mEijYbp0RfCRJJjMO3eYdftrDI639XHgZT9gcSQylIs44YgMSubuzvH5AYcxl7rURJTlHgow0iJfiDvbJdjaC0oUTT8K410B0L8ucXfuLiJKLhmIvMwrr1Ybunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by CO1PR11MB4962.namprd11.prod.outlook.com (2603:10b6:303:99::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:11:23 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%6]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 16:11:23 +0000
Date: Mon, 20 Jul 2026 18:11:14 +0200
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
	<linux-doc@vger.kernel.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net-next v5 09/15] idpf: refactor idpf to use libie
 control queues
Message-ID: <al5IosyZyYS4Y_gj@soc-5CG4396X81.clients.intel.com>
References: <20260715180042.1972010-1-anthony.l.nguyen@intel.com>
 <20260715180042.1972010-10-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260715180042.1972010-10-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AS9PR06CA0276.eurprd06.prod.outlook.com
 (2603:10a6:20b:45a::34) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|CO1PR11MB4962:EE_
X-MS-Office365-Filtering-Correlation-Id: 0676dc19-56ab-4718-41ec-08dee6798b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|10070799003|366016|1800799024|6133799003|56012099006|11063799006|5023799004|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Wwic3CUsZ8Gk+aedgXpjhmgErXABoIXMzCq1WFKv0r3lL21EH9GmMiwo8QisFl3o6c8Vr3MNFnNHTF5EMX9JHIeIXVs71bxPetZzNXAxTsozyeYGYSCTmvzfr1YxC2paTUR/59v15EVqFQ0dzv31cJcjYgbrjj0LarHOzJeuLGvkPE0zleYAE8WIXjWQWxHVBiLHLy93LV1Yy9+CZn2K8QsB6xCMpXLrML5J8c9SjqyTzNaqp4jZ+QY3awQkmAogqzwWnmcIFyMopwABAje3rYtQG2nLE3B4u4Fl+hdAEEblQhowgUZtzt4egZ/pvUVfWg9NqF+CiFjkEJ0tdhwlEwwv2UNywfaWU3wtJDFd6SeW26igFrzLpZ/vaARBOJknPKf33CQuPkGRjRok5tPqZeTISkonpQZhpdAvwJms4LxlpZgCNdKUzzmP4qEBx/6C0Vbufmu7sXvu0KBsXERddLiFMOMu9I1immUP236VzkRGzkvDLb7ZnmBX9gqCqpihTGtgr/0WQ6uR0FTJ+tMtpRmAo9nhPJuBA/cCoxW1UO0pZkr66a5NpTOF3KWMn1hENgSzpNR1B6iA7aOYMJ9WoOzOFTKEYHIVCugguFKJ0O17GzZSPG3MJPscmCIWnr8uh1mCPxCtFSc9e2eGyewZeBW2mxF3ocmIGrUelgzZS1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(5023799004)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2sbbgMay7Ho+lKQPOiiSkP1VHsxE9FK9Nmz1LnlaZli59nezlSP+qDqR/XcI?=
 =?us-ascii?Q?PXh+sD2T2fClTLbZ9grOYa8XlLEw1KecqxeTv7N9u1C1+QGxSTdF+TZAz/pT?=
 =?us-ascii?Q?eku7eGgw72XeICHJV9mbOr2k8U3KezE7se52AW/aRPiKiaQnz77U4VssR1NS?=
 =?us-ascii?Q?3rQ/lhNOlffdKS7OlSGKmnsyOkf72bhDCvw8H9oKdk4otJGgPPTrkZU7ElQ4?=
 =?us-ascii?Q?zrM+1TM7Nq6N6hiPtUHs58FjNh7lghsNPsXamrb2i4WOxfZ8GnofG7v6fk11?=
 =?us-ascii?Q?kk/LUuw49GWKCqY3Rm6kJquDKzzdqK7p7UVk2S68eq2esOmsLHpzkdwB9564?=
 =?us-ascii?Q?4sMfYGKDWEa79adgLHCcj02M3RuYmi4NjtV0XC9d2MC0MsDmkOmYT4YX+Zhp?=
 =?us-ascii?Q?lEDvRZQlx9XLBPGARHGDPIWvgs3nQyGPsUSM1MohKBHsyAB9CuspU56xNXyx?=
 =?us-ascii?Q?WctZ+3JJBGrIjWVTRC5+udiZTUC7rcp1bJrrtVwPkzeFN8WcSppl6UGbVGtX?=
 =?us-ascii?Q?8xRZXhfqEEikFlqC5jMODHPTYwVKJch5PCT8AbvoCW6l20D9tQqumxg4g0BK?=
 =?us-ascii?Q?FDWxgyXzuO0+sxNwuFjb/Q6RQG5kXO4OcjcsQKGl66Tzpdupg4dE1dsmQCfY?=
 =?us-ascii?Q?dJla/Bscdl5UueB8B/nBMRspOH9cMSEyCgpGu1EvyqcYqC9e533e47jEzOSV?=
 =?us-ascii?Q?KM/KqQMa3f+Go2Efz5XH9RNJs7WC8k19N4CaFK3k1Iot9copo70xACntpnos?=
 =?us-ascii?Q?1tVDg49hP20G3uKV6skzBnIcuEHjEYvDEdi3H8qQIS1Ao158a8dgvKJ5mfwT?=
 =?us-ascii?Q?auJSKfYi6hBx1V+35UXNqNFoncLn5rWLeyQz96cUVwdfxAm4spRALHfyTCg3?=
 =?us-ascii?Q?7sIQXS2mMclmqslfoYVSHcXAH7S7CjYsCDL7FHWPstv9cyZqm16uApSEm2WY?=
 =?us-ascii?Q?KimpE2z44s2aAKoyBnnCurQARIXqniv6zgdCFhIC6jZhSlkAPY/cThRCqtrX?=
 =?us-ascii?Q?DfUK1Ab5B7T/2btBjjYRIz5/SFf8w0eDC/EZF4970h6lrfKcQSs117CXCMcv?=
 =?us-ascii?Q?G3FcQmqAk75ngZcd7RDLoTclulBLI+mK4KA09Ph/dLFq9F2jY9TdWzjBG0d7?=
 =?us-ascii?Q?SAR7JYDmyh5hEakvmRSsi6CjFG9J6qUs7d/FRkscYKV9rhipYa+nJlnyOHob?=
 =?us-ascii?Q?Zdk/psIbjB8dv3JhMpIfi1ogCxxDXuV9flqx7fodcV8p6z0RNsHYh9ynyIyB?=
 =?us-ascii?Q?F8RL0v2Gy8nXzgqzMaQKZqBbDsr6oXm374XGIkQRRz8dGkxsVQrIaSWQaU2R?=
 =?us-ascii?Q?1mYtSYzKdvTNGlXre9hh1XAdnmL/2x3Ag7ZMdstsI1m/AEo+DEaKzrF4xSg/?=
 =?us-ascii?Q?kYGF0BE5/EJAE7zgBECM7+Vjnj10waYu9NOn06kEMrX1jtq6xV0iX0EvvpR3?=
 =?us-ascii?Q?i5TJ2pKZs+bMUPyJWg0XefVBMZOZNv5Bb2LLHGEMhYUECYCNDcD5OI0nST67?=
 =?us-ascii?Q?GwqL2Uol7hkTtn85atqwwhjBOFWDo/xtS4i1u5uEBv4ZQoBbPRCCLkN2RO2k?=
 =?us-ascii?Q?jlN2pmmILuFI1lbyobWPIhMdcP2mTMiqwigh7pbQ1jnHsEqG73qEZhioGneq?=
 =?us-ascii?Q?0GijOeDAhujcIlLB+Il0wHG/i3TeRSZUQFURo+H9JP2ptedsiVd6gIw4rB2Q?=
 =?us-ascii?Q?iY2soC/qKGtBALNpg84Ctpw6eCpyGJl6R+gxHQe/NNavx0G+hAVHSFFogY+o?=
 =?us-ascii?Q?viR36n9d4diwyrA9U7aS1I1XDoMoefE9+a8846XKlIJBW8wJLOBmNjEiK8n8?=
X-MS-Exchange-AntiSpam-MessageData-1: 9zPRJGPloZL9L1NW9EQGiUCPCba5ETf7CHc=
X-Exchange-RoutingPolicyChecked: HkAdVBi+MX1VUNDHMgdbjv9juOc1LYxqa0hyjh4BMonTDH2S82xLepu2S6nz2c0v2nT2VnlcxW1cRCqsh37rfbCZtkMXndtKkReBDyocQ3YELdEQxeMMsvAfwWHB/M1UrQffChzQXerVWRue4MziLkycibgZKywrfwvIiA7i8A53eiTEdaZG73c1o+KCNZy3pcx7xzQZ1mEnD25h/B0HgMYKycYB1RrFRx7LjIwBvM+b0jawo8HSWJWHcvdlgnejP0eZWuF/WPPiukmGwr/K+8ZVWyGaP90eOHoPppfYOnnTnDqfap9wD/dMW7L7uQA0SIsqofbUcPyHnTI8GFihIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0676dc19-56ab-4718-41ec-08dee6798b21
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:11:23.4970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9SwHUekRhgoVJRNTxRprKfJM9pxBS7BaYZC3rITtAouosNY7IxeG9jHBWD1LBv4WXqXYGYSqxRA5J7AhDs7xAFa7I32Ew+b7qlV1n/xGOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4962
X-OriginatorOrg: intel.com

Sashiko says:
> > +void idpf_send_vf_reset_msg(struct idpf_adapter *adapter)
> > +{
> > +	struct libie_ctlq_info *ctlq = adapter->asq;
> > +
> > +	/* Forcefully claim send queue slot */
> > +	idpf_mb_clean(adapter, ctlq, true);
> > +
> > +	scoped_guard(spinlock, &ctlq->lock) {
> > +		*ctlq->tx_msg[ctlq->next_to_use] = (struct libie_ctlq_msg) {
> > +			.opcode = LIBIE_CTLQ_SEND_MSG_TO_CP,
> > +			.chnl_opcode = VIRTCHNL2_OP_RESET_VF,
> > +		};
> > +
> > +		libie_ctlq_send(adapter->asq, 1);
> > +	}
> > +}
> Compared to the old call, which routed through idpf_send_mb_msg() and
> first ran idpf_is_reset_detected() (via the arq registers) to bail out
> early if the mailbox was gone, this new helper unconditionally
> dereferences adapter->asq and immediately calls idpf_mb_clean() which
> takes &ctlq->lock.
> Can adapter->asq be NULL here?
> idpf_deinit_dflt_mbx() sets asq = NULL after libie_ctlq_xn_deinit(),
> and idpf_init_dflt_mbx() can fail with asq/arq still NULL if
> libie_find_ctlq() returns NULL. If a hard reset flow is entered on
> such an error path, ctlq->lock would fault.
> Also, is bypassing the xn manager and reaching directly into libie
> internals (ctlq->tx_msg[ctlq->next_to_use], ctlq->lock, and
> libie_ctlq_send()) intentional? This is the only send path in the
> refactored driver that pokes libie state directly, and it is fragile
> against future changes to how tx_msg[] slots are allocated or
> lifecycled after a forced idpf_mb_clean().
> Finally, is it safe to writel() to the mailbox tail via
> libie_ctlq_send() when hardware is already in reset? The old
> idpf_is_reset_detected() gate specifically avoided that.

VF reset is done only in one flow, where it is performed only
if no other reset is going on.

[...]
> 
> > +int idpf_send_mb_msg_kfree(struct idpf_adapter *adapter,
> > +			   struct libie_ctlq_xn_send_params *xn_params,
> > +			   void *send_buf, size_t send_buf_size)
> > +{
> > +	int err = idpf_send_mb_msg(adapter, xn_params, send_buf, send_buf_size);
> > +
> > +	if (libie_cp_can_send_onstack(send_buf_size))
> > +		kfree(send_buf);
> > +
> > +	return err;
> > +}
> Is the stack-vs-heap discrimination here safe as a long-term invariant?
> The reset-detected branch decides to kfree(send_buf) based purely on
> libie_cp_can_send_onstack(send_buf_size), and rel_tx_buf is set to
> kfree unconditionally so libie_ctlq_xn_send() will also invoke kfree
> on the send buffer when the send fails and the size crosses
> LIBIE_CP_TX_COPYBREAK (128 bytes).
> Many call sites pass the address of a stack-allocated struct:
>     struct virtchnl2_get_capabilities caps = {};
>     ... idpf_send_mb_msg(adapter, &xn_params, &caps, sizeof(caps));
>     struct virtchnl2_vport_stats stats_msg = {};
>     ... idpf_send_mb_msg(np->adapter, &xn_params, &stats_msg,
>                          sizeof(stats_msg));
> virtchnl2_vport_stats is exactly 128 bytes today, so it sits right at
> the LIBIE_CP_TX_COPYBREAK boundary. Adding one field to it, or any
> similar stack-passed structure growing past 128 bytes, would silently
> cause kfree() to be called on a stack address in the reset-detected
> or send-failure path, corrupting the slab allocator.
> Would a BUILD_BUG_ON at each stack-based call site, or a typed helper
> that only accepts on-stack buffers up to LIBIE_CP_TX_COPYBREAK, be
> worth adding so this constraint is enforced at compile time rather
> than by convention?

I would very much prefer to go the callback route right away, like in ixd,
but the diff would be even more unmanageable then.


[...]
> 
> > @@ -1586,33 +1168,29 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
> >  	}
> >  
> >  	if (!adapter->vport_params_recvd[idx]) {
> > -		adapter->vport_params_recvd[idx] = kzalloc(IDPF_CTLQ_MAX_BUF_LEN,
> > -							   GFP_KERNEL);
> > +		adapter->vport_params_recvd[idx] =
> > +			kzalloc(LIBIE_CTLQ_MAX_BUF_LEN, GFP_KERNEL);
> >  		if (!adapter->vport_params_recvd[idx]) {
> >  			err = -ENOMEM;
> >  			goto rel_buf;
> >  		}
> >  	}
> >  
> > -	xn_params.vc_op = VIRTCHNL2_OP_CREATE_VPORT;
> > -	xn_params.send_buf.iov_base = vport_msg;
> > -	xn_params.send_buf.iov_len = buf_size;
> > -	xn_params.recv_buf.iov_base = adapter->vport_params_recvd[idx];
> > -	xn_params.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN;
> > -	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
> > -	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
> > -	if (reply_sz < 0) {
> > -		err = reply_sz;
> > -		goto free_vport_params;
> > +	err = idpf_send_mb_msg_kfree(adapter, &xn_params, vport_msg,
> > +				     sizeof(*vport_msg));
> > +	if (err) {
> > +		kfree(adapter->vport_params_recvd[idx]);
> > +		adapter->vport_params_recvd[idx] = NULL;
> > +		return err;
> >  	}
> >  
> > -	kfree(vport_msg);
> > +	memcpy(adapter->vport_params_recvd[idx], xn_params.recv_mem.iov_base,
> > +	       xn_params.recv_mem.iov_len);
> Is the memcpy() length here guaranteed to be bounded?
> adapter->vport_params_recvd[idx] is a fixed LIBIE_CTLQ_MAX_BUF_LEN
> allocation, but the copy length is taken directly from
> xn_params.recv_mem.iov_len without a defensive cap. This function

libie_cp does cap the iov_len at LIBIE_CTLQ_MAX_BUF_LEN in
libie_ctlq_fill_rx_msg(), so this is fine.

> relies on libie's Rx path always delivering iov_len <=
> LIBIE_CTLQ_MAX_BUF_LEN. If that invariant ever changes (larger RX
> buffers, multi-descriptor delivery, or a missing bounds check against
> the descriptor's data_len in libie), this becomes an unchecked heap
> overflow driven by CP firmware.
> Other call sites in the same patch use bounded copies, for example
> idpf_send_get_caps_msg():
>     memcpy(&adapter->caps, xn_params.recv_mem.iov_base,
>            sizeof(adapter->caps));
> Would using min_t(size_t, LIBIE_CTLQ_MAX_BUF_LEN,
> xn_params.recv_mem.iov_len) match the pattern used elsewhere in this
> file?
> 
