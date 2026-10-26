Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793008734;
	b=oQ5BRFqr8CXLGvchkgHpckanRWkxEwnjYASEdsoT5KmFOpGhW2FqgxJDGE+p1h047KPj
	 dACKCaqloBJC7L+X68rQdAQFnfcqHDh+IhYcrfc7RdFXbi1ug1m33/gm93yVLWOFHFwMm
	 R4ZJQvYJ2pGojoqdyCaWX4iedYnTUYtp/Jei9o2MKg4ZJBns+2nHbDcKpNBaZw7hnHe51
	 +ycZe8gTEMhag98I+DlN6LtsPUMTBO7GU1IDAmtY4MEYRruNj+V11T/RWCzAzWWyiTfK/
	 5UHDz2lgJPVH6MhMzqomHn4BMueUTHiiUbR8+N4bNl2zQr/G8uUw1/FaqMeZkjNlb6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008734;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=iw6w9CyfegEX1h71ZAOEuTuLgOpJr0T1h3XRZoDYewA=;
	b=dOuzOa5WIPcELlQGMuf8eK9atDItt4BtHq3BtFOIUQwXWw218lBIqiWh9phU+AChEY3A
	 b4jghqoiGcyRVesDPGPxYwdNwtrACQLqMde5N1T2owMuJTx6qIWIE/k0Zec0TYAeGBFHn
	 5Oxj1g8vMjfexBaOyafZif1WhfLpBX+q3siika1C9mrWTQxlAxfBy39yadolEblYS4lVw
	 naoSW7NjNTuARiIjwaXAgAf9j/4af+dtCny5/FqRDWEJqFcS8Pa9xwslmf/0FCAtE3Ejj
	 q5hTiOS2XhcpLEUvyf839On9gbFiNMOABnlq028mJTLNbSGfXqesbPIup5tRew1946w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SqjftRhH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DB2606A31E
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7DB2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SqjftRhH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793008734; x=1824544734;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iw6w9CyfegEX1h71ZAOEuTuLgOpJr0T1h3XRZoDYewA=;
  b=SqjftRhHNOYo9OobO8zDMr4/O8GoLUgS/SHNMhNV/a+D+OItrbpEtUij
   Fo6OAIe6HyYjHw538rOwCVK9GliM8WIgZyTlOslTCoZ6/9mKVI/wg2dkN
   DPWYTZril80eMQrskkj/Gmd5HGRWOTkVQDtm55SPRnogF9GiXmj9dngox
   6XefvFiTjFrhciwOyZWQoEcIKVWCcWQZVuGSHZGyGJES7veikTskAeIhZ
   kn//hu1b+cSbQeFTUraNarzfm9lEC77MNFT3t7YOO1pUlH+Uhc9HeqCN1
   mDe2I2wlfDQNHav61knG2ePAGSPOKNHrS+vBoAza6XbeyRmJE3JBa8Bq7
   A==;
X-CSE-ConnectionGUID: zIiR9XEmTSCLT34yX+ijcw==
X-CSE-MsgGUID: 7mkRJgEqTRmb5SWnx5CGYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1565638"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1565638"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:58:53 -0700
X-CSE-ConnectionGUID: K8hZ+BjhTEizNMWIpahd8g==
X-CSE-MsgGUID: QRzr6K+1ThSJeiKxkA0p/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4728136"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:58:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 02:58:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 02:58:52 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.12) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 02:58:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+ol/VEw0387nXfzoDAY1QAbtsRrcr1ui43Loq26KLWEnx9FfsaETVnWpKhbQ+UvT1CM8PT5woX1CfZcSxnEiXGiPhfcRO6bsM84Ovr3feVCS4VUF0XITBk8ozLaUDiNCICTZ1Ek3Zw6OLkwENwJePvgHvbbio58euCC0NAw0fpGFCs6VUaFHhjQafHNJMDcCR1Prw+Usi0aAN5bLlAT476SbDwt/0RpfzHQn9hv6E4ZN+oRrLVuCvDsSUswJq2BElWH4usHYLzK95CGoCECZxjPZ51NDupBQf7+Z2VH1IrdDcCCcMRK8LpVL2ddwq96gRmUkq/gR6PBtrgCfZoRAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw6w9CyfegEX1h71ZAOEuTuLgOpJr0T1h3XRZoDYewA=;
 b=tU1+3hdvSkf7E3Hj8MLWWSnTezwWnY4nO1JiymviZW3nO6XwiWBb8U0zcmfKUP9VHzxX3A+cQRpO8Lcm1ghHlRVaysh/tQr21ffl7hZOL3/q90z9Y3jtAngy4c1eHV/vI9ggn44WkznNeTnebAqKHF7j6k9FQdPZc45slw+yb3RV9viCvjsbE741IhwpbAf4b36/mcKJ3sRoSjyaXEEK4uQ9fgB7xD2nP2Sq8IOLo3WShFQamZCqDJyQRdj4gIVZhX7Q2tCXJ7EFMr9aEM9A7TYn7gjxBaT51S5oVLOe8NK/2GqZls7xKHSZbetplgBEO3rFvw8kePfvPgD1aI2tHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:58:50 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:58:50 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-net v2 2/5] iavf: fix error path in
 iavf_request_misc_irq
Thread-Topic: [PATCH iwl-net v2 2/5] iavf: fix error path in
 iavf_request_misc_irq
Thread-Index: AQHdRRGk441hPDhvu0608ViEQ468IrbUdgoAgDtg6EA=
Date: Mon, 26 Oct 2026 09:58:50 +0000
Message-ID: <IA3PR11MB898596C7660FB8B016056AF18F612@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
 <20260915125551.3976068-3-aleksandr.loktionov@intel.com>
 <20260918151216.GL51261@horms.kernel.org>
In-Reply-To: <20260918151216.GL51261@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|IA0PR11MB7378:EE_
x-ms-office365-filtering-correlation-id: 76012225-9d59-46a0-d197-08df3347bc78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|38070700021|4143699003|11063799006|56012099006|261021121427099003|261022105027099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: lx9ctfUXr17HVOC9yqrlRRhDexU5jak2NABG83UQUSi20l3GkbCyLlsr8vdr9ZgpmZS7XzVgbGkUOGHOrErgSrTdTLaGmQYK13qki1746PfytQVPXy3d3p8fw09WPh90HYO63ZA8G/nF38ENPv7vslehfZ9tRtqUfUsUqnCn13iMx6w47RCNrEV4Img4HO37cr4j4FLazJ2y26ctoh4JwH4e+gCGsvg4uA0ARXtbKUKY52uA0MKHMPtAX31jvEbDhARp9yApdn2P5+/KIZAswUryspqyzJMUFbBs4XkGQp85N1KOOfVeT7oj4AaMmA9KeXWGT2Mx3VhYVDuEJclww3q9i6e74diWCyrZUZODZvvxrpV/ZPWsI89xNzwpqLK8ToxvMXSrjlE+rp+n2AdDoZka3hwRPMELgSOVnlFua7nBCPRZuwF3dr5bqyEdMDMrKDLGSftbEChrNFznCKGuGGX/5qXK7b9PLET+ZC4SnOQ+gNkoE3Wmsdjfs6nB9Jo95Jmx0tLcK2KXCkRLAJMX6QSK222OE8QVYiKl5qhAowGhhuWj6JmvHVPCeAe9++RHKoqUOdfX96wnzmgM8otmjdhJX0XweHOz7nQ9Fz7cm7+0csC/UEr6pE8eOWur59qwHysL/z+CxQ5U3Q9xoQ7TN0Uu27Nj4jXuwfmfzp6gtLoh9RIgquYeoGaaWHWieoxvhK8ezYx52SiidgXAsMzTQrrmHmRdN1Qzt2r03iyw6m4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sh69h/OfRoYqqykRFwYkSdQjLVKx9RFvO4igkSqeK/7W5mgbSX3if1Lpm63Y?=
 =?us-ascii?Q?XJngFTxRSNF0khUViEZ05h35lQO/nOXJWsTuEJj2gQj8/Pg0YAXOQqODp+gs?=
 =?us-ascii?Q?CFdoDhKEiXpqjDThTNYhsOphJEL9I3DQeocxNvVc0gONyoNZ49/TH4zLCS1D?=
 =?us-ascii?Q?0PCDGYGGESg/6QumDfuiVZBjLjxdJwc9rh5evUmJImP3Z+R6tbGmNXGJD4k5?=
 =?us-ascii?Q?FSibsonxz7pIHPL0Bi0c5MhUlvXjLCOtOJbzXHsD6HqlMlE46becrUimJHti?=
 =?us-ascii?Q?Rt/6o2mOQ62nHCWo0VZUrijOKajJQs++xrYp9PQJSlOC1BdHAkNqntBnzJb/?=
 =?us-ascii?Q?XXjaTz46ZZc95eYHYXB1BfeEB8WkIYM1a2LFB8g6pyzJ1t2mU0qa29gfA5dr?=
 =?us-ascii?Q?ZM16GU4rd8UW8Q77HYFTmUAZOlPqGWC0FGKOpexmnUfMKK88UarBJWI4Vkf2?=
 =?us-ascii?Q?gdTiGr6Trp+W3BoiH3cvki2qZ6jc/ZPaSnXysAuMk0uM/OhmP8VtFJJR4eNj?=
 =?us-ascii?Q?zVeSjhq97F4QlFvbW5iiWAx39J/3da/YQyALqs2qfWFWEcqXATV6DQcgkKji?=
 =?us-ascii?Q?vt9dImeZy86kXb8NcQPnsoiVw6yqNl0l7QcZYs1GZDCkzCtGj8RE/QswA7oq?=
 =?us-ascii?Q?98s16/uR5j4Es6LF0aww+BcO5ua8fWV0N0C4I/Rf5chnNzWVavKPUkGuosGB?=
 =?us-ascii?Q?mqKVDimwghq7kWGA9oWcDuF71pBV+VnkqtKNjm0Y7K0NbQnOluoXSujio6f4?=
 =?us-ascii?Q?kYmn0VqVtxvZWtf/XGdXmP5jYW2KZSeKYA/CrgR7Y2UHY5pcaMjr8HUOSxVQ?=
 =?us-ascii?Q?gYW13P+HwhPs3k3n/wpw5v2uYurqSRaKX/VGr4FdNDlykBRBLvqFCA2r5ACo?=
 =?us-ascii?Q?dVe4AW6lhvBwe/ZkpryjhPxF0uZkVMG7hGwAways11VruFqtyRyhPpUQjzxk?=
 =?us-ascii?Q?xYPardaJb4VmONfdfwHmiFYuZXudxPprv68rDS9fcTClzDzl9rzWbVKiR5dJ?=
 =?us-ascii?Q?sOeXkRpWbwPac6YoxFA/0zYnXXtonr5s5Rs8/6Ka4WWj7l/NW0BlJgoe4X6t?=
 =?us-ascii?Q?M07r/+5JxGQZTSg3scYd+Fw8nr0yAiASUdOmQ79zEBkCqxanquec89B0QA1W?=
 =?us-ascii?Q?3J9kbC1Ad+33nfETX8/iUsGWdCGFieViZd9psjuJd8Uacuxn265dlqHSyskx?=
 =?us-ascii?Q?oNlZu0N3Rodi/Qpnuqf2SbBrmTKXlplr50yMOjg+2vGzITt5t+AESzndO2qr?=
 =?us-ascii?Q?rP4tDynvdDgdVeJ6FxPn9TiLfNPF+UIV88qV7bdLDeCFKULltTygcK9RI5dV?=
 =?us-ascii?Q?gk/NH8/o0RJVy4yW1B/VIOvjqmK5czX3Bb+ZF7qUz9RU6dDYLDR7hnZC4Czy?=
 =?us-ascii?Q?yVE39JoSDSzxqlCUYdlSBHnbskn8y2b2B0ROLDIG0o+12OKDb9TWZQnW4EXE?=
 =?us-ascii?Q?lLPPqIHmruHlVFs/yDuM2Ulqtf564BvPPcv+EVz2I36dBtEmXza4v4Ew4C07?=
 =?us-ascii?Q?ETZwF2bOsx7+U31iFoUzXnyn8sGhzOx34dwvSWg1IVk8raOXaAFUIjjXrqbZ?=
 =?us-ascii?Q?56UGu2qQWxJlT7I+SRU9RMsdRW2Rr44/io2OIlo/SLNk6yGNfRJ919KGN0du?=
 =?us-ascii?Q?KIUQGJEgkFQxTuf0JJUbLNO6DQFRU98JYA+dpgOOpuux9NOrc7b00N9v0DSJ?=
 =?us-ascii?Q?e4aLdiC5kBdi+4iL5k/HAO39VhdJJIx8lJ3H7AYtI+l20gOA8iJDWfiTn+yB?=
 =?us-ascii?Q?zk5ZokmmrQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NC3E8qYlnTMIr8CrYK9xnybAPiLKYaGxjlzadxSQQnDc8OhtOdMO6X5rSmjwLaV36aa37m6FHgu2mRzp9E+EpvrJdBxepqBJ6aLUGnQr0BP3S5W/ukTIkHi7WcBkBaiKcxcFkJGbCdkYCLWAF/7bCVoO3ve+GDfSXVdCiCp4KrQfTHcFabhWVlw10D+lz+OXjiMEEbp35tlthPjmKxxMOPbEYepPog4AZuX0KFIupnKlwWjIplxGr+itx0NECq7VT2SgTyTuAtPJ+pwoWcKAxPmt0Dp5Cx937UnxJB48sTYyQYs3Gw7idabQWcij4cHh4re70udhV6pwJEm2uRLFAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76012225-9d59-46a0-d197-08df3347bc78
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 09:58:50.7497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anSYef9047p647rKi6HZnPmolU+P+H+HBeyk2Y8oZX0nfOMTClk0uxLeGHUPhrf/Bx2xHZ/LU3EM3kowWebqFd6gsET+n2WQ7Hg8IXrD+Fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7378
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Friday, September 18, 2026 5:12 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org
> Subject: Re: [PATCH iwl-net v2 2/5] iavf: fix error path in iavf_request_=
misc_irq
>=20
> On Tue, Sep 15, 2026 at 02:55:48PM +0200, Aleksandr Loktionov wrote:
> > From: Piotr Gardocki <piotrx.gardocki@intel.com>
> >
> > When request_irq() fails the interrupt vector was not registered for
> > the driver. Calling free_irq() on a vector that was never successfully
> > requested triggers a kernel warning. Drop the erroneous free_irq()
> > call from the error path.
> >
> > Fixes: 5eae00c57f5e ("i40evf: main driver core")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>=20
> This feels more like a clean-up than a bug fix.
>=20
> But regardless, the change itself looks good to me:
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20
> ...


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

