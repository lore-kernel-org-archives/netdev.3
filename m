Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1591E372B39
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504310; cv=fail; b=rfQzSjLfEUOnfxxN5V17sViGhQochA3Ic0CYxxKfNEutKxhR76Wo4gOhsW4o9qlUizK+/XH1ZCBliC4T+VyVtxGMG5btf3mRTFdiR2KRBhuYLqGQtPUCvWHmd9Pky5srh8Hnfi8vJFI/CIrukIN6vv9Q3gKoGYpjawDJHkVsixk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504310; c=relaxed/simple;
	bh=XfBUAC69c7QZCQWiAfyp7m3KuzzhqiJBROcOgi8JHrU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=loNCw8vRyjmuPDH30rhnenmExSmPhZeSIxZ2LtGQab38B2/v/vI1DV9jgzmgEftL0RurGJnX7D//rFQrKkvK1N3RcudomnkRdp2VToT/VlX6SPXY/2E46KoNusK+LvIvH0opLrsCeSuAmBh7PDQyG3z8d/30/kf6FBWQjXBZZmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIK1u60P; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIK1u60P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788504308; x=1820040308;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XfBUAC69c7QZCQWiAfyp7m3KuzzhqiJBROcOgi8JHrU=;
  b=EIK1u60Pf/0KG9ayDxdXYZXJ6R6RftLCagaOLmS9TzSKQVTDuJWbVzYx
   yOkUKCojbnvrczo6JUldr/oKkqbL94TNzMyqrSaKI0p/gz6wBlOV8Ofe6
   td4gzkFaWfIP7SoyNhN2eGznzBNO2+WDtqZw/A/NyAfntBXv/+4sfpuzO
   JxKc72L7nVNwkKhpXFW8NRq09pIlxFB7Pnb1oU0U6qzuSow052YyZoLvN
   TEjcjamyAEcruKjn9ZI7UXvsbIMe4HnWptP8gw/FJSiafCEydKo5WHrAF
   1eKds3MGmTJOS1YfCYiCciVXTlmlrxGLUgjMbtFKqBLWWSeBjtKu/0Sae
   Q==;
X-CSE-ConnectionGUID: arm5p8B4QhiCbZ/PYXTMjA==
X-CSE-MsgGUID: Xm1prJIpS4msprmWXB/Obw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="91512760"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="91512760"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 23:45:07 -0700
X-CSE-ConnectionGUID: U23r7Pv5TdC+zoaAPXvGPw==
X-CSE-MsgGUID: +EqG6RRkSs618Qy8qeG8vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="269944745"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 23:45:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 23:45:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 23:45:06 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 23:45:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoKJ0nQEj8jBCW6WDjotmdlmSpMSxxt1m+cTEVWbcthP9wkixxOAjaWMpr4/sHUYeUed1Wx/lDdYgBGepXhjpOCWyfizlsxUTpWAJTOr2E7iljwg/EBT87CWE+9KFNDw2YxjlA714s7MBa688I5xMYSRFo0SxxIMDWTQ9BRHlluOS95H6oPmqymbfwmyfYyDA3wOAwmF6rorwhO2kPhzQG2He3pxjLsnHkXRJ/0CGoJDq3rmAOjnr+a20fdCBOQxhb/HdcsqTh6YBZ7inZb1H1qUsIg5KtZ58isbu2w21ACAjqNQZD7rTZ0GynWcisOjBTG3f9e6vO1WHc6aDnQDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pAcvzqb18PoPW++geoo7KDEN3Z3JMFHfp9vUD1USfg=;
 b=k7bEU8lws1PCOnbxQE5HKqytmID+2+fLWRX6YP1yOdKAXY+heUf8iUScRMNoH3EfGzHnIhCgga00cGlUg4Mn3408oHMeSNsC11n435w32bOACv2qiEks9aGVB6WFGoFp2vuzDXMQho2U3d6rz12cGqc0p+46xUiw2TF61WYhhjY2v9qHghtpC0eUXx7e7CGKdrZWvuVnB346su9O5f17dSQO2WONTMRWEkbGmT77j9EfjW4mzbO0DgXKdKzYSEWXVnuCsr6kwYe37wvaegwjKyu2Ghdg8r14eklGsB7UoPS3IBERf+By9TdACjVWDQp+zgpBqz9mNoNAbO6YgpyqIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 by DS0PPFC7FC39169.namprd11.prod.outlook.com (2603:10b6:f:fc02::50c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 06:44:53 +0000
Received: from SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde]) by SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde%5]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 06:44:53 +0000
From: "Das, Shubham" <shubham.das@intel.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "alexander.duyck@gmail.com"
	<alexander.duyck@gmail.com>, "lee@trager.us" <lee@trager.us>
CC: "D H, Siddaraju" <siddaraju.dh@intel.com>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "dasshubhamk@gmail.com"
	<dasshubhamk@gmail.com>, "Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
	"Wirandi, Jonas" <jonas.wirandi@ericsson.com>
Subject: RE: [RFC PATCH net-next 0/2] ethtool: add interface capabilities and
 PHY test
Thread-Topic: [RFC PATCH net-next 0/2] ethtool: add interface capabilities and
 PHY test
Thread-Index: AQHdNEtqYt8GYD1sa0OXr4r713I2tra+CMcQ
Date: Fri, 4 Sep 2026 06:44:53 +0000
Message-ID: <SN7PR11MB810922B4C8946C8B12E7868AFFB52@SN7PR11MB8109.namprd11.prod.outlook.com>
References: <20260825043708.1512634-1-shubham.das@intel.com>
In-Reply-To: <20260825043708.1512634-1-shubham.das@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8109:EE_|DS0PPFC7FC39169:EE_
x-ms-office365-filtering-correlation-id: d05c046d-df45-48e7-6483-08df0a50068d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|3023799007|18002099003|56012099006|11063799006|22082099003|38070700021;
x-microsoft-antispam-message-info: zOhEpzStb3c4gC8+kBE/KilO9eZ4jKaRtVyhA23J/0pPSSCprFqDPs+YKBqyY+mJPT9lJHHr0Tmvzd9jIE9Gu+zNK7fwa2ZY5IA+Jt4eqBMJ0CKjmFo4WJtzWfMOYEHU9mlZFuJC5rNinTR2szQ8vovTeOm9ns19fDehcViXc1+YECy+4oUKx7P6zyB9ZpMib0ffnOUQRKKynm1OrqP+2QPlUy7cmQjLjqlSQOgUYXeg6oUDDL/i8tO8BJQZ7ulzitN3gXmI/CT/ibJGlOXEKfaLr1Ruj/PN1JmRBilC+L843ZKOMmNoTpaD5WzF/J0YvOhnxUEPg3tcVsKHTbl4YSAR5W9W6wTuH3SI0IeiyturC7HcwK5xYVHCOUcCooBv/89Il1mhStSwP5KsbIIS/cRZPEv/9DeHcxQlSy3tc/QJ4Tu56p8MSm77J2ZsUiOwJ1RtABMsZtF3UwIyW1KKidVOcpQSSQdlZmgPGBgxudm0a6Koc7Fz87kFAuqqzkr2dYPGaFECHTLGHeoaZ+OpsZtKBIwt9bDGojYReVW4r2A/H4OXOT2Ve/pOqKd0broQt5vuPOP9dkVqznmE4Htu6zsM2Tz5qmbbdOZKM6ELehF11LW6zmwg1ShRRaGk4nMX4s3+MwMe/rZmvxRD+J037A7VTEjxBYHe9j0w+AXxy4au3It/bDXzOiZKA8aLARUYzXDtpkCOPOpDFGwxsGT+JfA3znUFVgYTRcobB3xKg+I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(56012099006)(11063799006)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VnBCZjLdLb0n/3ZOAG5Hiiks9oyz+VgBCit6gPe6tUox+e7QP2DuJ3JG0kcW?=
 =?us-ascii?Q?9lL2nIDixKf8g/4J5kmKuZtySOs4s8AAdeoHEqphvYOgsT8AMr4xzOd/BYGm?=
 =?us-ascii?Q?sSjeN9LUCaRXO7Ff7a9VjaHGCv/wZg0yrLEBsE8m833GuBVXuldB/LX/RMRw?=
 =?us-ascii?Q?I+PXsPB+wOZT0uS9L09pdOXosQa/VrfHcS0IEtjqjmB3nq735xK4XMntiuRT?=
 =?us-ascii?Q?9iZwf72ePfcDag6GkKK8lzV0O+/+8/kj39xiCYw7JsVAvEelXPz/M8iCCrZM?=
 =?us-ascii?Q?G5RVVHLjTCl0wXXxeKAUyGE5fLas57AtDpW4W6uw+8VzFu9/ZuBtRKfu7041?=
 =?us-ascii?Q?KakUjltB1h33oLzXWfzNuLrBBIMrwF77eQx6214jk7ukO5gY/epA1h4kWLzT?=
 =?us-ascii?Q?q6EsuBTIunae60+pD7svmjYMag44xlVfXK9tCNcicioPR7ebsH2Qx4RfRpKV?=
 =?us-ascii?Q?BWx0f6HH0PX7FMbt13cZZBk/Fd9pTJmRgYiikAOzGuRG3AuCDVJUEle5Kztz?=
 =?us-ascii?Q?khpCYHvXc6HeEUZ2gLeLxoF2oPKPRoOH3e3gI5M6h+2jzXIhNLqLPb4qIIi0?=
 =?us-ascii?Q?LJg3UpVQuBYEOxNHbD/hjOyeoCSKjj/icujHrqEsV/OF8VsF4NQKO49zglWq?=
 =?us-ascii?Q?5oNt3LZqLVVoxpVbwkG5L4fCQoJQYI+kLmuqEGQBvmu/6hWL43YtuMXN/dLA?=
 =?us-ascii?Q?h7gYOIpVTFP05NzsgmtTrXmNr2tuYcrCl0WljapaCuvSH+r/np+R2LyK337T?=
 =?us-ascii?Q?vhdjDSzg4CWWfMlGik8A7KDw6vSZiZ8Mfl2Fw8yuKVI0lVEuzHvx5YBj/p9A?=
 =?us-ascii?Q?C3/hR5q0jQKcSD0uxbYydbmxmXlrrXpPf2eADPp+EDK7LQay22/9MBGvRZaR?=
 =?us-ascii?Q?pCJE8CRIrbVJCQGU29Zi8l+wX+cSB0q4CF7IzNKkWq1Ld3avhRGjwtVL6muq?=
 =?us-ascii?Q?TITpUjCdsy0z4wKZQ9AwhYJl7WTf71E5bVT8qLUVyGZWfvrE2HfRrMGWJjYV?=
 =?us-ascii?Q?7aJCpOBpSHsmSy7c+0KN7emeyp3Do9jq0Kx6jgnkw7JGrJvnxBimTZAwLgEN?=
 =?us-ascii?Q?9RwLFvGPzH4PW7QzZFACrzvCy5vFhGx1jSntmEbUS+PMAE+VjExNOdXUm/v5?=
 =?us-ascii?Q?zWM9HUddSAJCvioBl+V2lIboohTeHs6BGKSUrPl9Zgos9thhLBUS7UWl532/?=
 =?us-ascii?Q?hWqYGRJjcUHfdOIhv35xv86RHLdMDlgZnRVJOB28fX+zQNH1QD7C1kAQZmFK?=
 =?us-ascii?Q?ETibTSQkzUfAG+e8RBiW/4FiyJHGmPczTeagLIkM2DFgC59Ku8OJ60pguL4Z?=
 =?us-ascii?Q?yoDiObELQ4KGcvAtsVKazzXiC/YCCF4EYdwPtT3vxEntYsWT3Ey3gOCqDvzm?=
 =?us-ascii?Q?tVulAVjT/0kjwczAUv2qmwaZF9fl3YIN3Bt0u+Fg77WNceHcrXaZXM969w4y?=
 =?us-ascii?Q?2CqSdiGO1Mt0EA7cN4WE4L35Oa2akpDccyDMFHmT9REodlbhopCGDM+IXekm?=
 =?us-ascii?Q?o+VO9exDXkiSZ1zMTQfUDhnev9NzezKBetO9qhFJtCWXtweFRw6Zkx9hpfQA?=
 =?us-ascii?Q?Y7u3tur+Y5uiyBwSh/6mxrwPHXRy2vQ+MAsMVzhD/f8iZNO6NBE6A3ADC14U?=
 =?us-ascii?Q?gMW2z2HmrI2wS6rgoIN2kep7u830Nx2lJuiAL5TYbTAllFKLxqstMJX1jtcF?=
 =?us-ascii?Q?n8zRDLZ6T9OaITgduMFR5xU44COxzBd3o2YJSmmthUKrEFTd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oH0URGIcipVIuniMLK/WoX05xZLEqs7yd8B16IamPx71C3NaV1LA/Go7C8HaJXfhg7PjsAi650gSgXZZtQhE6zOxtblO4ojT4hvUbBXSZX1sR5sYZS7P7RsqogTgL5RbrOeR4EZh3I4n0PBdffIX+pG10Gk2Uv1cdEGm53bbyQ0WWMsGy7vCBUImY0OThlpU3UP2r8LFX+pqocAj6lLlXdQHKgl0cJ2MSCGXf2aavcTM29LUydo7xCF2JE7EXcSsE7bd7KX3PYsXgCDqzpE1YsBG9BXcNuV+3m3YVCGEjfkEAxkZ7bIn0p8AQu/oEWpJNkFcdAqBXl4d4l43tWmqvA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05c046d-df45-48e7-6483-08df0a50068d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 06:44:53.3061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+rK3fbef5YmGcLH08AmSbzost+0uw3Qi2Up9PGF0Ct/lWT/oQ8TsdhK1lw9tA5HJTowq/s4C1HSSx5pSwA4vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PPFC7FC39169
X-OriginatorOrg: intel.com

Hi,

Gentle reminder on this series.

The patches add a generic mechanism to discover interface block
capabilities (intf-caps-get) and a framework for PHY testing
(phy-test-get/phy-test-act) using the discovered block identifiers.

I'd appreciate any feedback when reviewers have a chance.

Thanks,
Shubham

> -----Original Message-----
> From: Das, Shubham <shubham.das@intel.com>
> Sent: 25 August 2026 10:07
> To: netdev@vger.kernel.org; andrew@lunn.ch; maxime.chevallier@bootlin.com=
;
> alexander.duyck@gmail.com; lee@trager.us
> Cc: D H, Siddaraju <siddaraju.dh@intel.com>; Chintalapalle, Balaji
> <balaji.chintalapalle@intel.com>; dasshubhamk@gmail.com; Lindberg, Magnus
> <magnus.k.lindberg@ericsson.com>; Wirandi, Jonas
> <jonas.wirandi@ericsson.com>; Das, Shubham <shubham.das@intel.com>
> Subject: [RFC PATCH net-next 0/2] ethtool: add interface capabilities and=
 PHY
> test
>=20
> This series adds two new ethtool netlink commands:
>=20
> 1. intf-caps-get: Discovers the functional block layout of a network
>    interface. Each block represents a hardware point (MAC/PHY/MODULE)
>    at a specific 802.3 sublayer (RS/PCS/FEC/PMA/PMD) with its
>    supported capabilities (loopback, test patterns, BERT, error
>    injection).
>=20
> 2. phy-test-get / phy-test-act: Per-block, per-lane PHY testing using
>    test patterns, BERT (Bit Error Ratio Test), and error injection.
>    The block_id from intf-caps-get identifies which hardware point
>    to test.
>=20
> The block model uses:
>   - component: which hardware entity (MAC, PHY, MODULE)
>   - sublayer: which 802.3 layer (RS, PCS, FEC, PMA, PMD)
>   - instance: identifies multiple instances of the same component
>     (e.g., internal vs external PHY)
>   - depth: host-side vs line-side within the same sublayer
>=20
> Prior discussion on this proposal:
> Link:
> https://lore.kernel.org/netdev/SN7PR11MB810923BBDEC398E860099150FF1B2
> @SN7PR11MB8109.namprd11.prod.outlook.com/
>=20
> Shubham Das (2):
>   ethtool: add interface capabilities query (intf-caps-get)
>   ethtool: add PHY test framework (phy-test-get, phy-test-act)
>=20
>  Documentation/netlink/specs/ethtool.yaml      | 206 ++++++++++++++++++
>  include/linux/ethtool.h                       |  92 ++++++++
>  .../uapi/linux/ethtool_netlink_generated.h    | 104 +++++++++
>  net/ethtool/Makefile                          |   2 +-
>  net/ethtool/intf_caps.c                       | 130 +++++++++++
>  net/ethtool/netlink.c                         |  24 ++
>  net/ethtool/netlink.h                         |   7 +
>  net/ethtool/phytest.c                         | 171 +++++++++++++++
>  8 files changed, 735 insertions(+), 1 deletion(-)  create mode 100644
> net/ethtool/intf_caps.c  create mode 100644 net/ethtool/phytest.c
>=20
> --
> 2.25.1

