Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D22C4BEE22
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 22:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164695; cv=fail; b=g6lhxa9qgwAGP/jOrSuCLv2h3KBAcKngpPr0K/UhRsZfAHXtTwTFxFMqltr9kspj4ATL77mB/y3rG3C82qGWMaPChvURoUFE2zdCSW0x9sMR3xgQ9q+2Tp7Tl2LRjCKOJqgHFklOGMyC3I6Wcd1DZ2upum7UHsZwf4lT86QiG/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164695; c=relaxed/simple;
	bh=kJburd9JBE80jMNQ4C1vm1Qx4ijYPoFKi4aQ85Ub214=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l3/atzS6mShtee9k9Qab0Zu0rQP0HqPDdP/KccpMcCgPpe0NjkeXVAI13cLtKMU97CcZ9PelFlcTGvN3WCaMqaSnxy8h8zM1eNH8aBlCsoOI+zkbmTa1b/FXyF/vsLgiuM1LT7qovqX6ZfqQgiJoUeabruLunU6hCc9Rc9DFB14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYG6ouu3; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYG6ouu3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789164690; x=1820700690;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kJburd9JBE80jMNQ4C1vm1Qx4ijYPoFKi4aQ85Ub214=;
  b=KYG6ouu3SSribfvuE9ToQ95r0EoLaAmtXtI8p4PkYx5pR3hCWZq9G4e2
   colWd5aXlcmz1kyrUYmQPbewbnZ/7Mqxnk+HYM/XX3zMbllCcZZyATRSL
   YHNhxTmsGgjrDOjMFSA80Wr/yTQrG/z1gft3w54xJKdctXBU3XIEA5vLJ
   mRm1AhxkVT7pJ1xE2RqwjDAw0pS45CMc/HvS/93tJSTFc9pTc7Y7O7gay
   j7LpoX9eM1yYj/97DgdWDTBmv58AztHq8THMWp339hs5jVB3LicZXChqj
   1cA5rrp5hOnHM0LHMEMBLZ3ZseMXWJ4vwdDmgIwFmYRlDjRXdKEnR9Gda
   w==;
X-CSE-ConnectionGUID: O7jBxFZLRi2UmA58W/nQFw==
X-CSE-MsgGUID: Ez4Sb0ftSJGtHYonIMCqlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89472470"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="89472470"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 15:11:30 -0700
X-CSE-ConnectionGUID: pTZefYxWQcGyZN8zR0W8RQ==
X-CSE-MsgGUID: OvrEKpIpSXi2qSmHDzEtMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272010280"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 15:11:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 15:11:29 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.29)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxeEnzbNnLeLeseWwQ0PRHshy1YoiNnzScy5RAX8b0n3G/ScnynLy0tL23FTCVb2gS2JvuzQb82xThESKe6QVEGtdeCo/noli3uuYCoC0km3ncb7wLZXqISqIcPrGYnuNYE+MwkaAzpYvKGfw5kCubQzDiLAyNAijvQkU3SHaaOeYtC6MElVi4QEKtSFOCWNRGg9NMbFG0rTDf/CZ2rK1IaJbSPJ5r6cWHLpcBGX/UA0Gs8DhIOafq+pOKDNhpW4IMgS0rmjXoDotWtroEvIAahvH0r5WidNMA+WKz9SqAEvVENFlwusul12QBJ/2vJ4+iVgvtMfKTdaCdnGgV7Eog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHB8mMUqqhhYrrgNFaKj74C/Em9iAscDvXpk7CO5crc=;
 b=IUCdiKVZC6/2M2py4oCbmnR9G5DJHGTcxWkpJb6y6k3TdLFBF1Ip3HkhfRSfW/QQ+891B0AjToySUOpF0b76s1jCaIJAr22cBFYI32ghTkOMB3TIbZLWRi85BHTkmjw38vE7KXbXlWwY+lSDXwiA+s1q0x8I+qbfdO41qqmucSlIYSjhXGyznxQjjgvrQ/s+5fvUop6f4H1PmQwU88nDhAwVhhOOATtEoiNvybjz3T7PuwNAzn7Hbfj2eS0zQOHzLnJpDuO4Sh6Qwz3DD38TpL+/qGyAcqkxmBmH56zXQDII/EYvcDKhXEMHl+Wee7WnD1cwDIJlEpgK9r7vbS4pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by CY8PR11MB7800.namprd11.prod.outlook.com (2603:10b6:930:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 22:11:19 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 22:11:19 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v5 6/6] ice: dpll: Rework the SMA control logic
 to match the requirements
Thread-Topic: [PATCH iwl-next v5 6/6] ice: dpll: Rework the SMA control logic
 to match the requirements
Thread-Index: AQHdOVgXoO7LPnl4rky6Fu395UGwWLbJ//2w
Date: Fri, 11 Sep 2026 22:11:19 +0000
Message-ID: <PH0PR11MB7522246F9FB265614789985FA0BE2@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
 <20260831145005.191040-7-sergey.temerkhanov@intel.com>
In-Reply-To: <20260831145005.191040-7-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|CY8PR11MB7800:EE_
x-ms-office365-filtering-correlation-id: 71794d67-ee65-49fc-6378-08df10519b21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|4143699003|11063799006|22082099003|56012099006|18002099003;
x-microsoft-antispam-message-info: IUKr1ABii4+PwgwxRffjMJiZ0Osfe4ez7njdTYbeXYlPdIAb3NyUHZowEi1mP/dKsU2JvzUR/ewnsbJagk3W9aLX1GMYsUgPpJoBArXy6pj0WvfuPqPnlOOdWW5kCflj50uob2cVzmXDuvcn3zu/nRYfPDEbH6dTTW81wVMSZClhYlRY8fYak3/unoLNgXmptkQbHEYJZlVx9/A+qtyfumClbikGgODoZ1nH6GRepw0uWmeFSQ8JGfBzAMYdZt+0hKQOpIXnGNHvZqruUZSTPbh2kgmitjUT1XVh6u0bWAg3A7eBGlCTkqPycB5cChlTS/jPtzqLRIuZN/nMA2SKz4FMyFu9l6AE5b8rc3iu1Dw8w2b8HXCmiBzp00mvnrrrk16FHUWD9P9IqaXpl7AS4jaEaNdDjluaQW1rSmpB37WNZqnpjwfYhywcZmHmNT7o4efkdhuCaElbKN37CPHor/bA0jz/J1hu92hXxcWgmDnnjrxmR5DyzuoSURpBhTa+O30KiCjsXufeCOjwqOFZxBiAVoP3v4L88JPiYdhPVmBzFKnYJJjnv4f6AzaPFB195exG2v3nd1HfcKdgATAEykuEaUfJn4DvnxFhgyZtseqlnM3lVAOIamVhTlYfugS7Tgn8MJSitn6Rez4m+/ZehrgqlcHhp9lkvEVAg6XAYeixDcRVzN27RechAa6Wj3TE7nZTnFXM42ZN2Nf+jYm4pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?shELb9lIPFY7R40Sdu6dl6FuSRZ0LNuAzqWKzNqHa63ou/UBZSmilnfMBURq?=
 =?us-ascii?Q?jOIhHiddvpuJuK/jWE+XB2IR5YMfpSvdRfZmanlrDaxNnt/0u8VPOAMh+bYC?=
 =?us-ascii?Q?5VSkGEeyIF281s+IxXIu7Si8hcEJbQv+DW5hprdPCSBIOwARzrUo7DpXc5jP?=
 =?us-ascii?Q?ggQV6aV77rArn2j1F3F8ddEgFWyuXdqgJyiYXsolYyw//MrLlUxSMzjvzTh/?=
 =?us-ascii?Q?CFVMQavEIkOMtRR6drBsdIWXo1Nr0Jc7A5nb5mrsbIhZUTbI998CAZ6Kw7Gv?=
 =?us-ascii?Q?duBvechtj17I6YBcsTEI2+XCN1CW4saNlPdlN7cE8PQuJMixeAr9ihs0cEA7?=
 =?us-ascii?Q?tYkDtY/09+tE5/mNE9H/70nh0mSj1tZDaILEsDP9vbM3bfyqa9HJozSbrlCm?=
 =?us-ascii?Q?g1gpW5BuJT2pKGPclgy40xP5POETTOm9gYyRHU2bOsFoTSblnWNAEUN9Gop7?=
 =?us-ascii?Q?HxysB+u8OxGf+HEk3Tf2Wxn0Pwf5N5kVHlP0ZWVpX3mL07/7HJnefYqUxc6N?=
 =?us-ascii?Q?sBaWEyhG0EkUSYsCztgZJGxST/YXFwathFnBR7kyOUO8yibgm6M/bXX3IvNi?=
 =?us-ascii?Q?CyLayHU7M+CkYahK68Zho8CDWf3SiiKw2t2xx3YloYYhcqgISSn9b5HhQcy8?=
 =?us-ascii?Q?+L/tOqGqpxSA4JCXUT8nT5VPfYuKl8eoXTRy/aelmHXLTNs+6xauaGFSiBEC?=
 =?us-ascii?Q?jSxcfiZvM62OSkvK0+tAJzDrY46QBcXDae09UDPocuA+a/Y5CGw9Bpj43cIW?=
 =?us-ascii?Q?cgWpLDjNQMYNKtBHNcblvwkZmTJ3KBQXwrjouWPmt3MzNetV719MC/BOvsZZ?=
 =?us-ascii?Q?9osgxJvtxYt1spXW12oZgVlW6u2SVziojeflsFBIUYcQoqP/oCfhuvWdxEie?=
 =?us-ascii?Q?ZN4t0PWd7VRMFUGr28t1QWpdHy+DPFiRThT29S++RAQJRdfGcmm8+I5GqDey?=
 =?us-ascii?Q?AWQbNYwu1Sph7ciSTRhALC0Tny83QaIRxXgnMvbNTgvEnNE+6ZYOeOQVRGs1?=
 =?us-ascii?Q?witGPmxL6rVSbX2GLTei9D5CyqarhJVXUHmwpF7cKBl7Mn7XxiKD2gc2ZeGx?=
 =?us-ascii?Q?59oZ2megGaVISfHDjwtaX8wYKjcMDzE0jNGK5JFeeBsJOk4dwQ0/DIZiRDCj?=
 =?us-ascii?Q?n6+GUZHDV7bADyRYRzN6gfwwu+1wNfg/GvNWYqinPKMwdXgn2e9aQHSrG3wt?=
 =?us-ascii?Q?mlXhE4p6qtNSckh3f7PCDrLQsj8t7Huu/qDUJmBDnzYVx6l9g/ihtA5ZNcLi?=
 =?us-ascii?Q?JcsVu4/Qg4tWvHsUz6Xq1aHMRfCdlQE/8LZ54IA3qGT20ewt9eCGany0yP+K?=
 =?us-ascii?Q?/KkbKEk3T2QoG1gFJPnswxxxyd/XsD1Bp9l21+p3I84lzFZfwNAHbDXNHgze?=
 =?us-ascii?Q?iMBFJl+DlI5SGx/EBva0H8mHDrlQRRe6GUkMdJy+KCztpo4etDGT9bkOFrcS?=
 =?us-ascii?Q?YZaqSgZwjP0kh8OBMEYXR1+h6ryztYI3SQtbcUfwM5rUv7cppM8JParcTgUl?=
 =?us-ascii?Q?dnX+Jm1OwHrePVdH50bVM/Jik1wso8zY2MCY3OgDCwZ/2dikLqy5ybrfeTyp?=
 =?us-ascii?Q?EFiw/3NNm+szXVngvQyZ8Y7DPod3Lu3R579l3UEFQbLMi65Divpz8Jbrtse3?=
 =?us-ascii?Q?a7UT4iinXcBzsrmmjci64AHEmLfPn1/gYQasU4LzRuHSdk2jSas9AoMA5kwz?=
 =?us-ascii?Q?YoR4zM0aq+Cd7xJj1QcFUpfBGXD69Y89AVDoEDXJyhs6dpiNUvZ4k8xUoLPX?=
 =?us-ascii?Q?BWyYv5Lcew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ydz7Jqc3IFnpC5mbEzr1+EBsnF3126/Kq7Cy/ikd/FmsVKpcg50UWFRCt3gadQUYsDk8IYT/5VFgwm2DQeduxIJ9/jvqnDu3QOlFeWUoMFAMWhw5hJm9I1s7I8uDrxfimsqB5JbTlrsWrZiNndvvAQOF9BATiOXREGbKTRdsZYlNLdBMH1/Kb/YZvIDtgHdCDaS7wmLWl040+jhVfC6Jwvixl+JLLlqQvKnzagC6Hzf1HoaUPMo7BoHbISzZ3BdiwqASoOkvdolYRIspahhd2OiVCW3NAbR2fIswLFCcmMo3Ssz12tv+hLQP8uwuuIcBpgGEaWMU7jHaZdrOFmF9DQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71794d67-ee65-49fc-6378-08df10519b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 22:11:19.0407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHF6OZy03nqO0aA5Li6LbieAkPgAaJr2i4oIGJqxOYBsS+BB1YtFJBFmIS2oWW0YHaQn9ShXRTxGbgfe8g99fdmIVf7HxGYNNf4Uun3G35Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7800
X-OriginatorOrg: intel.com

> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>=20
> Sent: Monday, August 31, 2026 7:50 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [PATCH iwl-next v5 6/6] ice: dpll: Rework the SMA control logic =
to match the requirements
>
> Make the SMA control logic match the requirements:
>
> Setting SMA1 as Rx automatically enables U.FL1 as Tx if U.FL1 is
> disconnected.
> Setting SMA1 as Tx automatically changes U.FL1 state to disconnected.
>
> Setting SMA2 as Tx automatically enables U.FL2 as Rx if U.FL2 is
> disconnected.
> Setting SMA2 as Rx automatically changes U.FL2 state to disconnected.
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 180 ++++++++++++++++++----
>  1 file changed, 150 insertions(+), 30 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
