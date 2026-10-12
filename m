Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7000731619C
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 07:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791743; cv=fail; b=ip0+5MTv+1ofxsvA3cmSRXv1nhlOd8LQIPbh0ZG2fnIDbqxM9g2tNrqmGsZgxkEGj1POa8ScOTBBnS61FdNMGGoq7F3Z1OYCPOnlfHO+yVVyahv1XOTYoG8ZkJOCs9vO79zOQsJgr7IRdBP4eauVzEGENrPJ7iymgWcivYDT+HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791743; c=relaxed/simple;
	bh=ESA0/2m0Q9XmXjZEIAaIOcBbPCSnGTRjyOkXPPb2JQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jf18Lhae7HBqr625BxA41pAjBdYF3JAO0T6cngCq3sEFfXU6JQWRV48d5F+FTeIrMPo8twx+K2l0pv+y2eu2pNZHg+Lr6eF2N6ubYe1WfQtzx0B6RB6mAjdluCRn+PDeY9vq70as4kvKoDzpLl8vA1fiBoUx4MRu5UkFvKAt9Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFSTn2pO; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFSTn2pO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791791742; x=1823327742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ESA0/2m0Q9XmXjZEIAaIOcBbPCSnGTRjyOkXPPb2JQE=;
  b=RFSTn2pOltz4YNg+t1X5tQ24f1vpwuXHt9EeJlT3kxn6L+7IBuV7NGJL
   fKBfgZ3DE4qm55hIjCzInm6Vnj1IzSKtdRThj+nCGWLr/PBmvK1ivDBdT
   5ArHXKxtZ3oS4s9bPxFO53TIjrZ96/x+hc+3bBGAeEOIJpcQnULqShx7U
   odNhVA75XBtHIYvUfGHpgH9sU/LoazZXrJ9cqSPfGaaBAMhPmapOvjd32
   7dfbxW7OfI4F/sIVZMKup9Oe5rLUJKNZ4Zhli/mAczwWr8Nl+7nV1pAks
   O+Zrjfg+IGN4UfEiw52La/9Q0mVldEdMx12j+5nTNdI7LEghb6xw93sgg
   g==;
X-CSE-ConnectionGUID: sVTu3s/hRAqWqLXg2A+aHg==
X-CSE-MsgGUID: TKJNziFOTYyy7Rrq3LurNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="499965"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="499965"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 00:55:41 -0700
X-CSE-ConnectionGUID: EndzNNRUROKJ6pLH4XkixA==
X-CSE-MsgGUID: oOqfbNV+QW2mtV5GC/NvLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="799745"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 00:55:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 00:55:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 00:55:39 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.63) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 00:55:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lp/ipUCB6n6E7K3c8oIh62JnxBOuNIkUr7ObvOtIzqsm36U1/HlQG5XF0JWpoAPo7DqDsHWbOrkoPINN3PfM+a/hOVPttdFBjqmuYZpApacEAA7PRTJUfrWveDnxjobsLiHMPeqzhMLiZ0UN2aTTgeJ677GO4l/l9dRZBHIIJs30Ql54uAgS/xjeDpNeTPvi0XGh7ahd1JC3iMcq2EQOWiLRrxZknv5LCKOpk/vDzeStaUkn7jpwGLjM4ACOMLmA8pgLI1nVBvyk89DMGBoZGK8BsSjo1Pziuwantv4I81cFYsPhKgIq7pvISEe38BzTXTIyTKXKWBIf7OUnN6UO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESA0/2m0Q9XmXjZEIAaIOcBbPCSnGTRjyOkXPPb2JQE=;
 b=GRd0v46wER32jkuqh2/Y5hmznoNHLhEpK3ue48CpREJO7S+1iVjk2pKwyMv7K3reI35Mo3cip2bF9kjNGhyhvADrBdlbeD8wrNt7i8/yO7Kvz2TLKlsj+p3o2A0V90KOqj5eyoAWRdrwRyWHThMIgzNxTm4Hj9LzP6phrewv/x7YM1Z9Usgoai/AXPlBb2cXwik41+FFX8EZ9FbIgFnlYPvnw5PLrNMGopxIHTCN3Xf6ltTNC2SZMflCd8prw7rKvOsB2loDDUtgDjZ+vCFwDCMhbIg+VNqfEqrbMocXlP1TxVlYzAARSuVIp0AmP8s6AD7etCZWIPVrHZ/wg1W1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by DS0PR11MB9478.namprd11.prod.outlook.com (2603:10b6:8:28f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 07:55:36 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%6]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 07:55:36 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Thomas Lamprecht <t.lamprecht@proxmox.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, Don Skidmore <donald.c.skidmore@intel.com>,
	Radoslaw Tyl <radoslawx.tyl@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Simon Horman <horms@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Viacheslav Tyryshkin <s@tyryshkin.me>, Melissa Romanus
	<melissa.romanus@proton.me>
Subject: RE: [PATCH iwl-net 0/2] ixgbe: fix MDD handling without VFs
Thread-Topic: [PATCH iwl-net 0/2] ixgbe: fix MDD handling without VFs
Thread-Index: AQHdVDi/qz5mnTulcEexnabcco9RULb5lQgA
Date: Mon, 12 Oct 2026 07:55:35 +0000
Message-ID: <PH0PR11MB59027E497A72001E8DE62FA8F09F2@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20261004193704.2895700-1-t.lamprecht@proxmox.com>
In-Reply-To: <20261004193704.2895700-1-t.lamprecht@proxmox.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|DS0PR11MB9478:EE_
x-ms-office365-filtering-correlation-id: 889adb29-d617-46c6-b03b-08df28363318
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: J62PE68jW/aOPcN/0jSYxwSnNPRDI0WrM+H/68Htow+qyheKz1oJVIs4bHFn/bCEBNmeurJ8LTESP3cvEPFdOtdbFv4kdaJ8IZJ4foL+qoe80i5m9I/0GQdtRu+ZN2IFanFbNBLJTmOyo3gR5S3IrQaO83nPGb/fkI9ZKYkWOvpBklsWr4afImZulv1QHixhtyYZ1TJEDyKbVDn9JtlgYRHWfkszg9nn/AyKgbylqlM/vOqQYkcM1oDrdCyFb2bvArMbRdOBhjvLhenCADxnIJ+Q6pxfKy3dMlTyn+daZKToE3ykQ5BkLgH2hu7CaxKRZb43+zFHnvLkA1iO0B4S6WPC7xBIL0Am8LYlNwsPuPGsBqy2ZwT2ZgDazD+66TfaTGN+kgS7uOAZMq7x1VSprQsVfRWsHS5rPRP847DQAEHY/08EUouy4+xiDZkK8ws3gGz3a2qt/DWfYRKeBk+g98lSfb4nj95NJhSNJjeyd0WQj+lC5qvIWOmxJZvdo8dvbZI8v64rfl+bE6mrMdcWwdXKq/juhdTlsg6GnAU6NH1tSnjI1Pk1xw13/ua/fv3zNUub35mhmWhl9KDzqDnDlQjhsimpQUnHHFIPeSsA3Y20btIPBHnVskgahnC1+U7HuRBjXicU75Y+H+C/mB46DC8Zsxt+5bfZxO9aDjlxgVUhSsaSyIWQS3/oPCJkhXVipUdZOd2Q6F5efiU14tCguQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EuyrP1EL4h+f4wftuIFLfZVNIFA7VoX+SBdBq5zmnYSFkDhTyU2GZ7LtsL61?=
 =?us-ascii?Q?DFEn2kHeVk14/OF56WnKeAcLjJfILMH69MRgzAbhO5nsncQqaF6dx7rjYwMo?=
 =?us-ascii?Q?ww2pmiK/y/BKpYKP3Wk20gXwgK41CEld8oGZQ4HWC9E2JhZxk3Vq//eYOtPa?=
 =?us-ascii?Q?hYyxcbbB7R7GP4fJzr9QKEveGfw9+lRrOc7onuE3fDAryOVXgOXDb1MkVch3?=
 =?us-ascii?Q?O0/LWdfHERvbCUzcdYmzu4KZ+bv3dKv4SWqaBqFT+RvLQXfxnLWftsUjPks1?=
 =?us-ascii?Q?tEeYQYTEddXqqSvC+WCzCfStzf1UPQ4Viuq1ENY1vflUVoQUfYL+cBYzO65G?=
 =?us-ascii?Q?3QBU2lKjbH8BLNsfSq0K7H1xgWeFYPxJ9UloXcXpfcmm01BWF66Ni5XwLDF8?=
 =?us-ascii?Q?JlECcqjMacphp8jOl4bZna4bQWezMiaovCAJ2sTRpnAXWWRKA/WL6kwmO7ZU?=
 =?us-ascii?Q?9VPF2GQC3QBs+tXWMbL3y/C+PfZih+u14UIBY5SLd8QdmEu3S/2g4WisiWIk?=
 =?us-ascii?Q?XFha0232jdT1+QBxD1g4vh128EF68ibYSV9SjhMAhNvznQyjZ/fGZ8aPz64m?=
 =?us-ascii?Q?bxze59C86raYMdfA71pfh1G06J3I+leUGe7rdGU458bXNJnKu3UJTQY+pNjW?=
 =?us-ascii?Q?D3vXPWg3kdYZ6lKknZNSoASs6XK8nBYBFYcyXg2bkD2WxLo2ukRWFCKQGpvV?=
 =?us-ascii?Q?giR39DwFaRQOOjOY7Nk6mqhd0to+tEKy6bP2ZNivOEbQXwp+lJppNKVWKe5V?=
 =?us-ascii?Q?NbW+GLSEvxAm5CYsMb2vcr/T5DVpRmqMPPYh4EZYDzweogbtCDK1jwauFr7+?=
 =?us-ascii?Q?imrjP02jM9xN713yauBTQqmvXmBwu/jzp8VavhxrubsykaX75C3LvE7kFZ5z?=
 =?us-ascii?Q?zD5ybds3EgTxm5FpCPM6dVSfGkvSb3kKNAvPWStUuc/TUzZWUuPCg6P+ss0P?=
 =?us-ascii?Q?Yr6i/Ntidj83wucB2JyARhMMJ+ScQfCFFesIxNZ7YezDSpvynfV25tcE9S5t?=
 =?us-ascii?Q?/4NshBdhZaaGkdabuUKd87xdNsKuumfOOa3duqX8nP7eQN8z18TSQl8sKEat?=
 =?us-ascii?Q?DOgqujl47cnNyGmm4UqYhFgqaGMyXSipRu5DIbC68wJqOXALJ8TiWaPsp2d6?=
 =?us-ascii?Q?IX3B6HtZgZkushwlH5LBcwrXPi764+kI/Rn9S5Fzr0S2GcrFh/CbW1YwY0cU?=
 =?us-ascii?Q?J760u/B2xf+vyoRtXhZlEtWE+mkV3gQdNoC46Y6vxVwv2bvuJODQ1yNxs8Vh?=
 =?us-ascii?Q?tdpiMguZG/6GezAwbC9zdm4RajJ9icknhdMpUIhYI/xKhJjaKLyObD+XuESB?=
 =?us-ascii?Q?rkykxjUKbErlyteKK1Ee+O67mVDA3R8brSETvbi0oLtiDmTMzvgKue86cUiA?=
 =?us-ascii?Q?YWDoBzUKhoH3Si1XIDZ5F2wf5nMi8hgUNXI9U5yq7LzZaj0EOsSKmGztiFzN?=
 =?us-ascii?Q?CDpVQY5LL1a86Mmc/aRHwX/h9IxSV73itdZqnZXILx7GpjK6LmCMFPWS15X/?=
 =?us-ascii?Q?+FQZicOupFF80+Ttii1cXPRuB+jKV0FrUX2orDaN1W5SWHJB4DQ042hFvfrE?=
 =?us-ascii?Q?2zHCd6ST5Av6PM7j/w8tRZ+rNkyqq+0N+1za5yGhjvE5dIdiNbtIgmaZWaOd?=
 =?us-ascii?Q?QXg6gIfuX+Y+hbITdO8nTMqrTYPN6wZ8kM2sODLD961iJwlulqyOff7ZERld?=
 =?us-ascii?Q?1ZDsvLXEA593cH+lj8Pblu/SuhUgbDDyJUxzSAgcfPdOAhfksyuFhOAq+7QS?=
 =?us-ascii?Q?r3PtdP7I+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TQsSuyhM75WQ9s7S/3Kwo5ODla1td0CcZmxUbnORT6VFK219MB8ab49YCY1Q2+8hON7QI92Na4VJwPum4xMqw6UrgG0sss7n5rmoDWulchoX/YelDK44RKguorZNmzXrqSPikxsyOg81+PsvLG3X6NIYBz42Et6R7CH9Ya5FdfPTtJY5BBl1/Qq91bYWXOzW1mvyQ92ECzbwM9J0TRZD24nLiujdWJAUJpQ2ifw2T/+ikru4HJb1zgH23k3A7zt2hvj1XYeta1rjk/8Mih8hIjm2w+nGlqThZjpDkkV2pUt6U4zXHRxSJcGNlEIs+biBEQd7pjaqS2IObimKjJgcZQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889adb29-d617-46c6-b03b-08df28363318
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 07:55:36.0069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cwUpsNlnjKE7CPLHLJIVRMBEKSczZpGyN4v84UMAgiKQzjk0FublifRlQ9PIR9JbNaO2npwhhqDHQL6tscrTRKfLao3Mhju6IIBi62JsoXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9478
X-OriginatorOrg: intel.com

From: Thomas Lamprecht <t.lamprecht@proxmox.com>=20
Sent: Sunday, October 4, 2026 9:37 PM
>Since v6.17, X550 adapters without VFs can crash the host on an MDD
>event, as reported by Melissa on netdev [0], by Viacheslav on
>intel-wired-lan [1], and by Proxmox VE users [2].
>
>Patch 1 fixes the NULL pointer dereference, and the out-of-bounds
>vfinfo write for events on PF pools with SR-IOV enabled too. Patch 2
>stops enabling MDD without VFs, which is how such setups get MDD events
>at all. Why the hardware flags PF queues is still unclear to me, all
>reports show tx:80000.
>
>For completness sake, on E610, the tx hang path in
>ixgbe_handle_mdd_event() looks like it can still reach vfinfo for pools
>without a VF if VT mode is enabled without VFs, e.g. with macvlan
>offload, that's not fixed here.
>
>Tested on a Supermicro H11DSi-NT with its onboard X550: without this
>series RDRXCTL.MDP_EN is set whenever the link is up, also without VFs
>or after removing them again. With it, MDD is only enabled while VFs
>exist.
>Patch 1 is not tested in-depth yet though, as I have no reproducer for
>the MDD events themselves, so any testing by the reporters would be more
>than welcome.

Hi Thomas

great, much thanks for fixing these!

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com> for both
