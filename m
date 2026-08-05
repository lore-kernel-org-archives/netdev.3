Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D234165B
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785960384; cv=fail; b=HmUfkj0BO5AtUH7gFrL9V6FqpSE2NqzpwK+B20WNefXDglUHkez7BLp4MQr32xyixHxV3FZV9tKSdSqEYXZLLYSHJWwVI7Oq2agyxxaUYq0JdVTov3vVPDxgdpg+DrNq8GaJ7tZuDYVEwzWALY22IHqeUPYM8eXjlKJLqx+9rM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785960384; c=relaxed/simple;
	bh=uUkE44K0KmWMjgokNyP+mCA6kFbHRrenjKSNw7J4hss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Add+TUmVwsMni2dp152Qv613La6G0etUS2OkzCIwXitZLQmZabO4aJ8uTBpnN0PJm0h7EA/NNv3gb780qyySMjVvu85+4VMbL30cjAkWK+l5jFffsqu7mjNCvbaoqayUfGChqGPIiJjbmf3eHvvBqnTmLl97CqyPVZMTOHjdeK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJCVGVJZ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJCVGVJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785960383; x=1817496383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uUkE44K0KmWMjgokNyP+mCA6kFbHRrenjKSNw7J4hss=;
  b=PJCVGVJZMpaG+znpTmeNYozua3T58T4JpH+KSsW7GRSe/Ojp7ASRuwKn
   E8CfB6OqcP+kZjFjALOzshVe7ZXDPHDOad4IGMDiYp9GgXHOrXwxUdbJg
   awdUCHSMPq2MkKhsmjmKVEElvpsqLMsRAQmPGTrUKo7ApXLU/Xx7ZGVRJ
   dibVyExvPT3QoS0XvYwVoU25cOSP17N8OjqDmdkK3PfQuaACHxsfeYAK9
   TqG30xB6cf65sjPmUqa0j7eu8U3EJ4YNASGYXFs9xTd5lj+JkXfNxa6KQ
   2zwSgK08pepUf9w1hS4hpF1nJY36BpcmGzFko8crbeAT4NB0Rvs8+9m/q
   A==;
X-CSE-ConnectionGUID: oWzvnIbzQLCi5SZJPfuchw==
X-CSE-MsgGUID: CqRYjS34R+Wz3b84xeyMHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="97907347"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="97907347"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 13:06:22 -0700
X-CSE-ConnectionGUID: xTktyl4fSE6awkrGaiNKjQ==
X-CSE-MsgGUID: SdACetLwRGCXi3GQqi+XhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="255650318"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 13:06:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 13:06:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 13:06:22 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 13:06:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBxa0B9OgIJWr7Z3bzzzjy/BtmlK0s+tbJuFaFtxNLZVrCdWOAPVetKj2xjIK+Z4amxx0C/lucAsnTb6qXKVaG42QtU5XJgjA0guJxJxpyHgO/bDgXI1kFrEgY6YZ4J/lY6pPCmq4R5ZRE8fi6X9sDWg/OGBjKWx+cdTp8zzfz77uJVs/Ufb/xs0V7pByB24T0AmvPOE3BNaPFrEVsEMixcS4o3JUbhFV3FccOrPl3tvu/XBAUkLjZBMdtBwCeJQA7cFlf8Wt53Oc1ws0Z7NQGD29iJCzNDpuo1woH0ty4NlkRXgXGKbCryAuUoZ6XyHtbweECms6uMaMzJlTocFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUkE44K0KmWMjgokNyP+mCA6kFbHRrenjKSNw7J4hss=;
 b=uTfGzaANdwQDm6IH5C7ZpGLTUUvwvh8sV2apIDUfOfA1GhErXRUvKkisVw+t+w8zhv+VI2ET0wrGm5950I0MkE44DwhVAW3CRUaqWDh93igeMAULsMZCA9prRVOjKFhyOgPshOSMcik4DCFXZiBMTByRGJV4NWI47DpGJmdEaCVCDnQbhoWhSRMNlAIgJMoQx25zKKGTSzEXZKW17HAqSKfrFEWz8W1JFu6P/JFSxb2t0vyrsIFACXdXHWmqm8RU66O5Z0X3WDJ4N3HOPHdLOkYfcQvLRzR4Cr2pBbTV6+Mk14efKN508hLT/kJKOeuAScubSG0HhBq01waEtEzZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7)
 by IA1PR11MB6538.namprd11.prod.outlook.com (2603:10b6:208:3a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 20:06:18 +0000
Received: from SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0]) by SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 20:06:18 +0000
From: "D H, Siddaraju" <siddaraju.dh@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Michal Kubecek <mkubecek@suse.cz>, Andrew Lunn <andrew@lunn.ch>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Das, Shubham" <shubham.das@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>, "Srinivasan, Vijay"
	<vijay.srinivasan@intel.com>, "Lindberg, Magnus"
	<magnus.k.lindberg@ericsson.com>, Niklas Damberg
	<niklas.damberg@ericsson.com>, "Wirandi, Jonas" <jonas.wirandi@ericsson.com>,
	Siddaraju DH <siddarajudh@gmail.com>
Subject: RE: [PATCH v3 net-next] ethtool: link 10000baseCR to SFF-8431,
 Appendix-E SFP+ DA
Thread-Topic: [PATCH v3 net-next] ethtool: link 10000baseCR to SFF-8431,
 Appendix-E SFP+ DA
Thread-Index: AQHdGSKc1ve79ub29kS0QZBSoOYJz7aCKecAgA3OfxA=
Date: Wed, 5 Aug 2026 20:06:17 +0000
Message-ID: <SN7PR11MB6900841A0D44ED2F89A730E99AD32@SN7PR11MB6900.namprd11.prod.outlook.com>
References: <20260721150638.3084698-1-siddaraju.dh@intel.com>
 <20260727181158.1791cf45@kernel.org>
In-Reply-To: <20260727181158.1791cf45@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6900:EE_|IA1PR11MB6538:EE_
x-ms-office365-filtering-correlation-id: 648e0eda-5ef2-4e2b-7826-08def32d02e0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: qomn7kmRl/etDqOmPsnVv+ZN8Q5xuy8GTBtMRTBtEkCiZ+AExwWaP0lichrqbqLKV7QKY1Mng3t3xqp8pyLvILDBGbU05Od3470ne3z4jdXnB5LHfxkued7MogsYAFfs9aMpOrTqedHhyCNz/ZS+DhcfvujZrEQxCUmIP2OU7TtjiKFoONJLCnnuZGCyPcLxBVsqemD9uaKJAhL7b4yNDWduIm6DTy3M9NLDUkUtO/CvQbUDxTeVujLbcogIFmnL4xMLGGGyPo3uj2WYG0IY/4zkH/Ay7XZwt2yzeqn8IHcTGSfFGPZRnTcow+zMtCEzFKY0EqK4cgLbLJxjgU1vLQOiBLwhWY5o71QfezpRBlMGi5OKVi2uZkRgJkiDHNdlDIdC1HPs0grMlSZAZtapapzPUNZnFWiU0lDnyopdgOK9WwaAA0KyoA58R6fnwYOM5td24AlHkMu/TYzqdR3/+RbPX5NFeiJJ0urC9S9la5cxja2J3TX5yyI3FYPCLJ0w7B1M8d4zI8yAFuPCjdGtbn2E/Ydii8Bkw5dhLP86mMrsuujNs9yZrUqYsnKZepWMBK1itnqKy2xfzVV5Jrxk01mGknQdfOIpQ7dUK9Lzqir3wgzZguZuX0wr0uyzdlpf/Ju4ukV7C0Rg2jJb3EbWu+utUfASRt6XIxdBFVN+fMoGY4LJIElmr8GQll7KZwFRFBirs96w2uzuW0RN36Cm2k2DfTvZRSsxV/Zc1R2IVFk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6900.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aHYZ3HqfTNGSXxBEVWOHOTepoZT9jmFWdL9azHEZctcjmY4OJkk9hhSbMWck?=
 =?us-ascii?Q?ASbjn6lsWGogPapdm/qEnq3jXL0mi5/UFAj+uiTNcfIq9z7iIVR/JQje2Y6N?=
 =?us-ascii?Q?yese59NRbxWvKFDtbb9qu3qkmz6QCclnRpTmW8mwlg9wd2pZ87CVqd60Ygd9?=
 =?us-ascii?Q?iREbHkUff65TDxlFJPNJQuGIyLizYcFQpK2m4aBD2AkWFYMGM1ILxglnTx6p?=
 =?us-ascii?Q?ZOj92dyi8iAL0q5vkMdsLWnVF4Irx0RTI5Y9Hj89PgPtge0spOakeoWfgyN5?=
 =?us-ascii?Q?xsdA2hTic2FcpadYNCQBbMtf2xIVwQOd+JfKZiU9KrVJeFqwFyLr2T1bSTl+?=
 =?us-ascii?Q?I8JC4Ir1bQnXd4OuJiobLp+bY6z+idgGCoeqk65evxN7qD9xupYo/G3OI4UN?=
 =?us-ascii?Q?/SdJo8ZI+jJ/v5yfCORJD/hm5uBjTTVpU8hZ4j3MCEUZX2JfKtCCWIIqg1D/?=
 =?us-ascii?Q?53Q4ljRoX6wBwrvfxVoBrQXu6Z9Wz3R+isgtmnipmnWpqQQuW/Z0rBtiBC8s?=
 =?us-ascii?Q?DT105m51cB+VX26sUhqBAoCltjBx9jVssPsiiDOvZCK0Iyb/vptdq5zoc4HU?=
 =?us-ascii?Q?qIMyR7bVUUilHTdmDfcexPBpyzAaEmelwZkiEeGMy3VJCoZna7XEOeUBCFfC?=
 =?us-ascii?Q?540p6hkyglqwbvmwEk9GvKPyZ39gyIVrrlI8Hn8JYTDUBsLpdLnulTpqfuvI?=
 =?us-ascii?Q?GIRHq790O21GUMENJEkRDNi7P60XnFFhT+T8WZk0/n+fTruc77OcUfnb3ot9?=
 =?us-ascii?Q?2OFXyhom9VRoEpp2unP45D4e6Z7158Kh2rBup3af2luSLFl+yYOxT7xwKB2h?=
 =?us-ascii?Q?q17gK5SdIjEBNV4wCb4FXuGp0iC8KCB3G6qfj3ROnwvQuqTnFMCy4W8MWqGP?=
 =?us-ascii?Q?kmHRBUnGOm+cW/+UtInLg42wttHjZflBwMf667ll2JWFd+Qg/LwTkggS2x0W?=
 =?us-ascii?Q?vWGch/g8kdcLqBywB9lVJhc34zR6QIDyeFi3TCAfVi0o4fM84ruMam+O49zG?=
 =?us-ascii?Q?tJEi+vsji4hQme6j3bgOganevcKxsL1aj71pYF9IsbWFEFmrJAKtSwNq0ARw?=
 =?us-ascii?Q?heKgOM9snzVq9uYbKaL5pdze2sK2fwAcl4Io9AQ4M/OMcry8QmLt+G2H2CTu?=
 =?us-ascii?Q?nwoMIF9hIRmDMG4tfN4etNigRmLKMCY0PinjTxrIP0ItZXV7087PpWT/eLaI?=
 =?us-ascii?Q?xFjV0ZH5o5ONYizqTOg9jJTjwtRLnnWGtG1/yxEiRu2Ndjj+F/FVCIlo9A+y?=
 =?us-ascii?Q?O/T8+4xxpXmpznxo8+KGhp2AIksrYhDhKNhEbEadiSZdkimeVRtz6Y1hfS2e?=
 =?us-ascii?Q?QOiztAj3yDrzpuz4fDOJedNUtALcoK9bRG/4jvWw1nLn2BNkh0kMVn7Y7YjW?=
 =?us-ascii?Q?FY40pxItdPeR2SGLLLQZ+HWLEM1T+zv1ToB2mYqOARxkdKNtdO77n7bmc0Td?=
 =?us-ascii?Q?gWT+9RIeEdILP9D2KKA3h2VnWhzp+lGJbhmfRV9Xn7i8xN+8gM65SdNml0ME?=
 =?us-ascii?Q?IGoSAor2doN4fdJyHa7p1MAeRdzzMfByVK96sgQ4alkkjSY70Dw/XmreziYj?=
 =?us-ascii?Q?6RImNu4LCIuinEkbBqoj7BoHjEHdqa3R9zmHRSe3mO5q0w7/A0kUpj429TXg?=
 =?us-ascii?Q?DJlnRm1glka8l2N6GTAbQ5BeHvD3mY5l/XRdM/nzovCSZAaKN64s+Oa3qAT6?=
 =?us-ascii?Q?XXfs+I5SVLQ9UltmUtJqCbsH373oNDHrqgo4bwhrMzNaSU+5IIf644slokjZ?=
 =?us-ascii?Q?efhTthQooZiJPSLXGcp+pcuGeRS9pKD9BjxpJqjmdzhqOkwkOaPM/K8m7kLr?=
x-ms-exchange-antispam-messagedata-1: HJponoo8a0uX3A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZIu0sxE6EIOZcUIF6214upzKk4zRSb8PuYLYZY52QLKyypmp8euROO1iogLFb/mC3G5+05uUab9XgzSGcrriXQdTb+Z6rJhA2BTcHMBpa+QPYCOtmLwtjKJxqkKIkppTIdsBxTcAL6Q9AMPgEOQsRJOB9oG+HuebMrDE9T107jBPYUl4f/zID5v0Oc1dBBVsZFsW60v+BVWQNRXn11R9wB931QOL//jtyZsUp7zBje+NLV14CDiBgLMHQ6AsBz0k3Qw0fqNfe2ThqpOdUFjpsvrb76ure82zuigxTvb/TtjAhdozlf9HMgLmWmYpvCSdIc9Q9PrFuUHSHPbvzVs1hQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6900.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648e0eda-5ef2-4e2b-7826-08def32d02e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 20:06:18.0274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcxLXdMPS34dP3NoiSvIPBqenQxa3y3u8u2T/v6wDFZ6C6CS6LTNMTkLlMDXcuPzp2dpe2KbVXY/lrq0dzObzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6538
X-OriginatorOrg: intel.com

Copy-pasting & replying-all since selective reply doesn't seem to be helpin=
g.

No, Kuba. "v2 of ethtool" application patch was accepted and applied.
I received an explicit email for this acceptance & I see same on patchworks=
.

"v2 of net-next" kernel patch fell out and this "v3 net-next" was in respon=
se
to your repost request: https://lore.kernel.org/netdev/SN7PR11MB6900461F46A=
FCB0B170B9C829AC22@SN7PR11MB6900.namprd11.prod.outlook.com/

If you follow the below link, it gives the patch set summary:
https://patchwork.kernel.org/project/netdevbpf/list/?series=3D&submitter=3D=
Siddaraju&state=3D*&q=3D&archive=3D&delegate=3D

Am I missing something?

- Thank you,
Siddaraju D H

-----Original Message-----
From: Jakub Kicinski <kuba@kernel.org>=20
Sent: Tuesday, July 28, 2026 6:42 AM
To: D H, Siddaraju <siddaraju.dh@intel.com>
Cc: Michal Kubecek <mkubecek@suse.cz>; Andrew Lunn <andrew@lunn.ch>; Maxime=
 Chevallier <maxime.chevallier@bootlin.com>; netdev@vger.kernel.org; Das, S=
hubham <shubham.das@intel.com>; Chintalapalle, Balaji <balaji.chintalapalle=
@intel.com>; Srinivasan, Vijay <vijay.srinivasan@intel.com>; Lindberg, Magn=
us <magnus.k.lindberg@ericsson.com>; Niklas Damberg <niklas.damberg@ericsso=
n.com>; Wirandi, Jonas <jonas.wirandi@ericsson.com>; Siddaraju DH <siddaraj=
udh@gmail.com>
Subject: Re: [PATCH v3 net-next] ethtool: link 10000baseCR to SFF-8431, App=
endix-E SFP+ DA

On Tue, 21 Jul 2026 20:36:38 +0530 Siddaraju DH wrote:
> Add comment to clarify the physical media 10000baseCR follows.
>=20
> 10000baseCR does not correspond to any IEEE 802.3 *base-CR PMD.
> It has no autonegotiation, no link training, and no mandatory FEC.
> The industry standard for this media type is SFF-8431 Appendix-E
> Direct Attach cable, also known as 10G_SFI_DA.

v2 as already applied (no need to repost just for review tags)
