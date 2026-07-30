Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAD8431A33;
	Thu, 30 Jul 2026 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419580; cv=fail; b=WZTqhbsYXf4uC+8HL5OhZBOTXz3nTVS2M4ge9bWUmfSp/be8D3hbUNm2C2d0soYj/RJIx8R46RrHhwE9tKYv0+t+dK+/TOAxCddfaDTk8APL/AHxevBykKmeQEOh2H3lCEpUiClG/KLPpFGGxifhNwtKj0ZT37oTAhM9E6ZJ5uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419580; c=relaxed/simple;
	bh=R7YW3ka90CUAxUIuCL2okBVt1hw12Sm7wKWpFDTF0Ls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rIFWwqTEqXPSr/S0BIe5NYnhBYkg3R5pZAXK/FzMwDOvw9DvSyY4elyv63X4x6SOSMoXY3QWx5YQAknCFoEwuw1f+OjVKufBwcXtw1n2q1TiemuvVDVNfHAXEbRLMVTWAhTQRxF4iZV+TL0kYVLbgjF9RrMR6sj+DAfidqXF5VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PYGHlMRL; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PYGHlMRL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785419578; x=1816955578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R7YW3ka90CUAxUIuCL2okBVt1hw12Sm7wKWpFDTF0Ls=;
  b=PYGHlMRLZLsN9djqZlL4ZHjA1QJGcIeeqiadPFObdeNDYYZ3daZ4Vd1b
   452vJepmg0Ozl6b/FCCvrK6mA5EzwNhOsoF7qWj25SOsxJeZ7sVe34/d0
   G7xfyZA6GfeFPU+BHFawBBMRVn7LWgwIgCgaRHiEFhD/ZzUD+H8u+OYGj
   ZPypQnmDZ5VPhKHpqNajncqFrOKNbKo58QjOPEpOlIZDhtRJkh9/BUSR0
   RlQH/lZQr/PnWmD+rOIRWStqiUnCJJ2ZTVVIYKm0oE9HBzEhW73N9TaYo
   fJtvA8KZ6aXQmsRyUK6/TXdLP05LS68aJ/d3Z6heWZOH4d4B5EmTMeBA+
   g==;
X-CSE-ConnectionGUID: 1HLzfvEgTBiYGLGqmRLfSQ==
X-CSE-MsgGUID: XAJ45+fvT2+KMgY8HpRVgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103445479"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="103445479"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 06:52:57 -0700
X-CSE-ConnectionGUID: oHgBnFA7QGeOEFGwrO3Iog==
X-CSE-MsgGUID: 7uFFd7eJSzSMOslDwlePXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="260367607"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 06:52:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 06:52:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 06:52:56 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 06:52:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYjbkf9HJm6JSSSKs/2vA4/AylxTzPZHcjOn9aW1/nb88kQoUWjcxvuS1w6ArSClJ5HpVQZuec4BMojAp+JtcWLcIyLhgNhZMhytzJ8rtTDZX2P09gZE8tG6mG30h072VuuXMtS6B6gRjI+FqVsiR3PzGNdg2FPs6EeoXaCPIiiAQCy+ZXlYGHMAZXbvxihdSzsCx3xm6hangU5WWn9e3i+u6/WyZDSZalmdVbtl9Vaq3hf0NQfOJzuYA1FWBbR1WCiViT6aUUmCiXP+coKedT28uxkPdy2UBLd+1idR1xT2tGiwqNRyNqsh+4uBPsluR0S+kjWUAgbOeoAkET9vwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkiSdtm1NU6k9GiWFCJF9j1VBya0BIEZ8LejiiXKOes=;
 b=UDu9t1JiZsHvfFDtEXjXz5kV/yPj93TQrjA5bwlDvGGVL7NYzYnR3AJHeoR2+/+QPnKzuRVOCh4WredZQjXrXDE8gX4o8ZbcjiNMqwKImc0se6m8JsRJTUTVqCRCyZE4AuJ8EeqZuM7Q0JoENtvtdmLom7LRD47ebhyLShyUaestFJJ0asac3rFvnL5YtAVQm0Pe5wptzlSU6NjKexpt1L6X+hQic9tXcfyX+HjrNBumlezkIDsrgqwbVnxIf3Z/9TLuX7w8B1t4eASUI8s35Hpr5xmPtDbIJa/KUymXd4vMqQBetiSnWE4VQ5p+3HIGCg/982VWXmYo50zEDkcgDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY5PR11MB6440.namprd11.prod.outlook.com (2603:10b6:930:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 13:52:53 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 13:52:53 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Blair Steven
	<blair.steven@alliedtelesis.co.nz>, Carl Smith
	<carl.smith@alliedtelesis.co.nz>
Subject: RE: [Intel-wired-lan] [PATCH net-next] i40e: Avoid repeating RX
 filter warning
Thread-Topic: [Intel-wired-lan] [PATCH net-next] i40e: Avoid repeating RX
 filter warning
Thread-Index: AQHc4znxAws3ky155UeDKINfRFUwBraGjuog
Date: Thu, 30 Jul 2026 13:52:53 +0000
Message-ID: <IA3PR11MB8986BDAB698D8D7A1AC1AC3EE5C92@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260514003733.1718771-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20260514003733.1718771-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY5PR11MB6440:EE_
x-ms-office365-filtering-correlation-id: c1a82095-a737-43fd-09b5-08deee41da34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|921020|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: gYkRxlZHyeXItfuM6RCdE+IEQf7sb/fEUIbwbqB+iFabx0o0TuAFRxKnZKeBXUFfwcldYjQ+dH8wvFIK10uSsw9w5SQg/lsqRFk5niJHoR0frFoqG8WwomnR7FO2n0x3yEVHxfX00qDIT1Ih9buce2BhgC9mLlyoR/pRoeUOajeGYI8xVZ9x+Qj1XA1ZEhw3rv/meCU1LYkuAElyk2phbr+Bc+GQaX0koQsgQG+KzrkawJuFoechdlM2wq3wnvBTQSiT6hXGlQA+U/2zr/BwEIO4l3AyiPXkmgdKajG6MZCG73SSaLH+F/ww8eoLtefF01sw+H+fw5lYhEvdMCMIbVjnxtezwyKSZAZ7wPB6OoKemk4/pAlMGO/x8Cr7Cy/rPoxvevJ0nxm588Yl2/BMBTxC+0JrIn8CcQWHdQMNDygcID5qtlF194H0+Lqny3a3IzyzMYh05OC6PIBfUjVBPt5v6MBzFVCdtlHSODPvg9EsMmtzKzyUJP/ibVCgLQqSZqm2M8LyB46AFzOVTNi4ViRrHHzr/My8wCtKYC7chG2t6iDQ4wzaD+lLP+lvFPMP5qw7rqpdqbGO+eBM9uRZ7imbdC4f8mJsKkYbwAeM+4khcz91bzXw4q77rTZ1XI4p1/RDHzkZP60pdUxffmdJWPEERSDUr/h8Kgopo5nWVOb9Ym0/s6kf1d4PgtyIJKJXluRFk8mShCHTD2S9LPPb08r3CCpDu72pBxlOppF3excuwM4/0ut9WCxhCm+GwkJp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(921020)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m80p/Nw0GJShla5j3AQiJnJzFn0gHUOx5BPndku+j0j4JZWWNBoDHc6js/sO?=
 =?us-ascii?Q?4eJx+0JG+6G7gsEqSQRMQ7ifsS7Xftfh8pj6vmO7cUkrulbL8B4/3qxbOULh?=
 =?us-ascii?Q?igOutEnLzvPEQS/HL9SikUwNLEdUMEV+MQc3a1tJm5T+446z6THV2DKH7KEM?=
 =?us-ascii?Q?8ekQ5aAdD9Q0Je1KgkJo3ROMyC+4bdSq4T29GwZ0xrSmKM6FFXEF/DdoOTyF?=
 =?us-ascii?Q?dbVj9LyJT0VPW6W8VDYlg8sZknMwffCLZazTIXdQURR4QmMh650Idb10n36j?=
 =?us-ascii?Q?4LtXKj2mBEa36IXBs/M0cZtLznNSUUayNOkZLGk7kkkEEym+D9kOa//E5a70?=
 =?us-ascii?Q?x/fXZZ5YrDzd7I05zchzjT/iao2f55Q9dSGV7M9/mT7MnRuccRbK5rtNsPwV?=
 =?us-ascii?Q?02gkQAlZSEVvlGD7EL0wIMy+iSJi3N3dGhJ+l37gadoOfThO1OvFycfNT8fs?=
 =?us-ascii?Q?GKAIZc99M8aArUHjR+GBB8QF3yCMg8FNkLzuzWoiWuR6JaKpDzVx84IcQ+db?=
 =?us-ascii?Q?I7d0IBFLQtr4Fw57y2SC3UnXNiCzoPP0fh2jZ9gy40KJgMD0ukg+W3PQaqmV?=
 =?us-ascii?Q?nJqBiMs8+v3G6YWLdZ2pSswFBdOYo9FLqEJV2bylAfvNiVDfmGBqWyNjBX+H?=
 =?us-ascii?Q?9JKXS2rR/HX91mmi+kl9kiS80TBvjLjU/SlzzTBqmoEY0HVVcbNKrZ8WOx/W?=
 =?us-ascii?Q?sPC+o1Dx/CVkaB+9yUWnITvu7c8rwcMWcV1fjUK5V8iAyldKFWxmB5O33bww?=
 =?us-ascii?Q?zNmDWAcg69zt9uPEmqVyRwV1c0YW2XaIoUcLwNCv4zSV8p8YxR7FwfZGWhuo?=
 =?us-ascii?Q?dqskozBfAsuYlHkbx9VWF2TIOrtaLn3+zkMFNlu7StzLgpTL109qYF0xQa2A?=
 =?us-ascii?Q?4DiMLtiWuGhDqkuFyIZ2ysAbSBhZ4AD7UOCgejqtW7VM25jIX+vQ1p+Fb/Zy?=
 =?us-ascii?Q?YLKFIgxaIdD4yF4ZHpvHFuJaRtzO2sPDaCshQNQzhDC13fI6dsgA9stqTiEe?=
 =?us-ascii?Q?Ey9DRABePAnbKHForrwrMfGh1iZPJ0B//dGqzwyZdve4jiXctWzOBmE/Lm18?=
 =?us-ascii?Q?gGUUcfrWgKzN8gn7KDehTVgnnBKBfFrGqVk4F42oJlVW3PvSw33+eRlMqcCj?=
 =?us-ascii?Q?keD1CfSJpT/FSUQohaiX4k6Xy++c7y1K7oRymbqjK/qo90pRsLO3GTS6wzcM?=
 =?us-ascii?Q?8c5FVuIGi6L8wKunpzG4bNDw1696bliM+bEyn98TGJebu5aGNtFn4OOj/oR3?=
 =?us-ascii?Q?Yrw4l3QetCnOXCXdcYBhhWoLSbiAvLA5U7zla2vxmjV0tNuSh1qj8T1mH8+6?=
 =?us-ascii?Q?h6xeaNkXV30CaRgOott+z0fKzIcT23Pqwm1qiB3TDFMdekgmXPLyEFDn78vy?=
 =?us-ascii?Q?3GFv4a+VljMO+EGuE1DsVm4PlFU/oioRtpJX6WqdswxQJRrLXvkRdOhIIpGb?=
 =?us-ascii?Q?CJvPV3w0O2t0leUMSA2UiGm2x/NboEtDITje8ALaNKpMsg0M99xOcgzIOUXY?=
 =?us-ascii?Q?XLw/R6sQREMGLtCZHWnCAQPIs7YFVgHlYWD3W/hQ2s2biPJU1sUWXpuT/3gw?=
 =?us-ascii?Q?OfSZUcnjXMfWuWOXfNYTKLtGqAqr8oDLydg4VjvrsG/OASaKBCuGMtrX4Vtd?=
 =?us-ascii?Q?cKQbNV/q3xw0b9lXzKSsAeq2Gacl4/u3BbSHHMYaQgxmD9KgSRgDKlWRZlfq?=
 =?us-ascii?Q?2i8iF0kzquDl/OD4Rx74pP7QMozaPhmiAXX2/BMXLiIsrY3e5GoSQOVFBU/E?=
 =?us-ascii?Q?K1T5Nn+q4u/CXRgVsCmlEmVY0dcnffE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L+jPF9nYu5qwlragDbx0WaLMiqFAHhPpxw6cJBmrofOmZyQ0OB4tJCJ9irlaOf+o0VObjk/6fB9dmA62nhY03Kq2RQnu6/ck/BVSY8nCBfRQhk+2u5dYgxgPjLse0WkOti8g+ZsGHQaPG2gKNCnZNQ78EEVcte/MHPbXHMY3uq3nG3jLG6YReyDBPTaphhDqJU0kz+ot1qgH3s6eBE/xQRiIMTmwcbVPcg003mCRKq9jVvDYCruF/mPTq5Q6GttIuBfnuBZBMmvSOLveuqlrQMDQK82TZmrg4sUFT2NVyyXrHaRM/vUU4tCaPQ/5+w7N4/fgkythm9FIE0M8f01GdQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a82095-a737-43fd-09b5-08deee41da34
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 13:52:53.4158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A4R8J7ZZBnuuxnc1DNAW5lSt5BhY/Q76V2T/2+aI2bOMnT0sSGBC1a9RDJkA3MqTBGu5JddEd42J2rFcaJogoxzDBU6N1QAE+9qYTdFZsgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6440
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Chris Packham
> Sent: Thursday, May 14, 2026 2:38 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Lobakin, Aleksander <aleksander.lobakin@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Blair Steven
> <blair.steven@alliedtelesis.co.nz>; Carl Smith
> <carl.smith@alliedtelesis.co.nz>; Chris Packham
> <chris.packham@alliedtelesis.co.nz>
> Subject: [Intel-wired-lan] [PATCH net-next] i40e: Avoid repeating RX
> filter warning
>=20
> When the i40e runs out of space for RX filters the driver switches to
> promiscuous mode and warns that it has done so. In scenarios with a
> large number of these filters this can generate a lot of warnings. For
> example:
>=20
>   $ dmesg -c > /dev/null
>   $ ip link add dev br0 type bridge vlan_filtering 1 vlan_default_pvid
> 1
>   $ ip link set dev eth7 master br0
>   $ bridge vlan add vid 1 dev eth7 pvid untagged self
>   $ bridge vlan add vid 2-4094 dev eth7 tagged
>   $ dmesg
>   [   25.601705] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing
> overflow promiscuous on PF
>   [   25.601833] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing
> overflow promiscuous on PF
>   [   25.601961] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing
> overflow promiscuous on PF
>   [   25.602088] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing
> overflow promiscuous on PF
>   [   25.602216] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing
> overflow promiscuous on PF
>   [   25.602344] i40e 0000:01:00.1: Error LIBIE_AQ_RC_ENOSPC, forcing
> overflow promiscuous on PF
>   ...
>=20
> Use test_and_set_bit() so that the warning is only issued when the
> driver enables promiscuous mode and not on the addition of subsequent
> RX filters.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>=20
> Resend with net-next tag
>=20
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 926d001b2150..8741990b5a5e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -2408,10 +2408,11 @@ void i40e_aqc_add_filters(struct i40e_vsi
> *vsi, const char *vsi_name,
>=20
>  	if (fcnt !=3D num_add) {
>  		if (vsi->type =3D=3D I40E_VSI_MAIN) {
> -			set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
> -			dev_warn(&vsi->back->pdev->dev,
> -				 "Error %s adding RX filters on %s,
> promiscuous mode forced on\n",
> -				 libie_aq_str(aq_status), vsi_name);
> +			if
> (!test_and_set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state)) {
> +				dev_warn(&vsi->back->pdev->dev,
> +					 "Error %s adding RX filters on %s,
> promiscuous mode forced on\n",
> +					 libie_aq_str(aq_status), vsi_name);
> +			}
>  		} else if (vsi->type =3D=3D I40E_VSI_SRIOV ||
>  			   vsi->type =3D=3D I40E_VSI_VMDQ1 ||
>  			   vsi->type =3D=3D I40E_VSI_VMDQ2) {
> @@ -2461,10 +2462,11 @@ i40e_aqc_broadcast_filter(struct i40e_vsi
> *vsi, const char *vsi_name,
>  	}
>=20
>  	if (aq_ret) {
> -		set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
> -		dev_warn(&vsi->back->pdev->dev,
> -			 "Error %s, forcing overflow promiscuous on
> %s\n",
> -			 libie_aq_str(hw->aq.asq_last_status), vsi_name);
> +		if (!test_and_set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi-
> >state)) {
> +			dev_warn(&vsi->back->pdev->dev,
> +				 "Error %s, forcing overflow promiscuous on
> %s\n",
> +				 libie_aq_str(hw->aq.asq_last_status),
> vsi_name);
> +		}
>  	}
>=20
>  	return aq_ret;
> --
> 2.54.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
