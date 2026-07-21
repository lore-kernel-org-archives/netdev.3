Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575E346E00C
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662637; cv=fail; b=twVQ2XlSC7jWdEKGWprLEcH3sbaA0eGlCA5dYSGWNszY2qT4UUr398qIQN8LyC2ro63m5ICKWpAFdQEtYWY19owVWA6zLtd1SR9WjgIFICa1euxz+6M/s1DEnQHIQh3YQSUxuCPDLznelx6Awk3ilzxyZfdY9pcqZ8HKOta0rQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662637; c=relaxed/simple;
	bh=+hfT81YBm5JI+6dQlv+4FBLCYf1jerUSaMpaMBB6EtU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dwzn9TzsIcAUx23KGrMvYAjc0xX8oybFC0sP+QGJ+F6MYS24nEvTSA0rd/1pzyKsjX7lmeRbJwn+OqYx9xPlJjjY9VyQ6u1oHdxa97ToiScVgZCfnJyF3VGbwYyiARJX68ayWNTjsjYZVX2qj4KA7jjmqRuIJs3lPjzh5LRh7Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UcLu6sU9; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcLu6sU9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784662636; x=1816198636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+hfT81YBm5JI+6dQlv+4FBLCYf1jerUSaMpaMBB6EtU=;
  b=UcLu6sU9tKUd984xE2CXgdAaFVlsSQgpCNgft76U/yQH2ygaRi+NjTOh
   Tab8+Z4cFOFrPTNcp3/LDPYiYemfXoj38zu2o1QDITyjXOZtscqnKUYSm
   ttYx9kQp6h+h5jfXGAjjHDEk04K+ds7U6fdVX4aal79grL0qf3S11F9tF
   kjgCZv8m0i7EagJfivLW+K3a1tIp7Aw4RM/z4GnH/NbWMHpuPTVOPuLIs
   dqwqI6Am9xK/l8cOxIzEoklu+gkhDOT9d1kQcru4Xv58FoUWV0IrcRBjR
   qoauMkcUVM+ELCjd6M2hxmdRWIMvTXTFTkJyywvQQUKsoqMwVpnU2eB1v
   A==;
X-CSE-ConnectionGUID: 0alMNZNiRPaLBxEpwtxqEA==
X-CSE-MsgGUID: Z51isX1vQPOPvwvgoYo3ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85478076"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85478076"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 12:37:15 -0700
X-CSE-ConnectionGUID: n2IimolMSXGHzvsT+ZsjSQ==
X-CSE-MsgGUID: VGJ9hC+YSliI0eXSGm163A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="262788548"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 12:37:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 12:37:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 12:37:10 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 12:37:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeHE0q2pWHAsHh9AK/yQSjYV+bD9O4hHcz+hp29iZW6sZ4bzKghv48zwgBkPv/tnGOs8kgl3G2giBaXyt92g8qbQ9yaECI4L9W+/vj6vxupJhvZzeBGwktzNsODcpnLUEXXbAJj0I68cA1ahCVff6LpgRB02Qi3XY0Y7A3t3Idp/ZcVBxkQflCIwllHfBl+mcLvuQc9DBMAT0OM3gnETPg/p/dzKShXMuYrMNxtX85OQ+6LiHNeu7UdjsBGJZgmURmb9OC0/vwBan/fiOWekMg7vHDV/7I+Bi6VTGZfYOd6+Ry/hLyw/aTZRPBWJDRfCEd2EwUDIK5EnNbQwdoEF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hfT81YBm5JI+6dQlv+4FBLCYf1jerUSaMpaMBB6EtU=;
 b=b+imdcKSBBBPGMJDwA+tjdlIw3VwKBIjNE9O1zOVl0HTFpR+QGM2D4GNzT4SpqGLk949PwaK2m+kF5zvl8AFg7Nxfl9aBaxqVGozdmposFrpCpgthhFD7m9XTyBhlDs44YWgsLXCKn2l039zcbsmc/s5601Ena/xPyQdOZdkRFljp+enuX7jfy4O/XZBEH6JBnWv6YRiq/mwrkMADrfeuE3OYrhJ8Ft1QuU/Ca3vIYvdhG9clwNe979P2em8aC85ipApsBFx+5kaWDioB/VgpN9T2rAPowz9Bv6HyrdkntSV31uxspBjYe2cy3ShYyd/bNpZkBfLlKPG9wfqQcHNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7)
 by DS7PR11MB8828.namprd11.prod.outlook.com (2603:10b6:8:257::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 19:37:06 +0000
Received: from SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0]) by SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 19:37:06 +0000
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
Subject: RE: [PATCH v2 net-next] ethtool: link 10000baseCR to SFF-8431,
 Appendix-E SFP+ DA
Thread-Topic: [PATCH v2 net-next] ethtool: link 10000baseCR to SFF-8431,
 Appendix-E SFP+ DA
Thread-Index: AQHdCtOKeG/No5nN/k2enbl/VdHBsrZ3LZmAgAFMD9A=
Date: Tue, 21 Jul 2026 19:37:06 +0000
Message-ID: <SN7PR11MB6900461F46AFCB0B170B9C829AC22@SN7PR11MB6900.namprd11.prod.outlook.com>
References: <20260703100537.1109838-1-siddaraju.dh@intel.com>
 <20260720164355.3072df7d@kernel.org>
In-Reply-To: <20260720164355.3072df7d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6900:EE_|DS7PR11MB8828:EE_
x-ms-office365-filtering-correlation-id: 29496b61-5529-432d-a467-08dee75f72a2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: j70p8wLBRzhAOIK7+ShEYDUPFJ0Gtuom+lE7o5jIw3NIXcisOFdm/SsEjOWFi+sG7dXApvtyRpZJIfklXPLbrY5x6jSI70MOKxtgkqQF1ixldbj8pbgFZjeEUg/awMxcMYBzt5mis5Jl6/deSENQi9hQHVaP8m5Z/ME0N+nLKlYsm9U+ZtV6g+IaI1lfH+i5VsvCxXkpiBhfx0A6Qw+458ztTDX/FKpVW3Zy3sBrR4RPRjwvN08M5Es+Fhm145gG64PNdF1zxE5BMQqdW3ddobRSecu0SfsKhrRFZDvg9gsLpFPeY1sW+piOzBk9jRTI8vSM7r7H66IThZZ8bm6ApiM+UNozHL3t/qE0D9Ip3q3QK8VZ3Sr7OSKEkvRxE5oCbKzrFEGWZ94xxfhd+e74Yr58oLgHeTIpOR+ORrRxn+Qb7MU6dtVMng8jYlbQSdN4dJEhO+PQYDni4pOMGixv1hUkwQ+xxDUiiw5j2mwjTRhvkgwnDNqJWby3v0/19fYCqjc1j/ips0zaE+1zrvV5NA2Pydpyh/ve6AkVF1mzilmCtQTkPLsV+ZE5C8k8BRSaVB75ZxaIMgVZ16UVRJ+/ErnzGa7FLED9D0+g5h7JKmgxFzyD8xSj4twZn074TQeC8nnFcisfvEHlu7d361y0a7rGXnRGWpBPfYkUA3F+X7Cfp4lDwfYB59ZcTkbBTBHJzfl6fT8JZak7ke1Sj/XbZokInP3Zq9zd3wx3BYnK1II=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6900.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0FFUjNBTldLUENuWGZ4U2Z2aUxDQm9Ta3MzeElkendEdUtORU5ZR1NHTVlR?=
 =?utf-8?B?cmJDbHBvU2FZK3RiblJxSXFESkNpMlJBRG5SVjBIaDdHM25NL2xTUU02c0Vy?=
 =?utf-8?B?RTI1RDhoWm5TM20vYi9YU2pnY0xHZFkrNkZkQmdtVkM0VTdkZ1AvaWg4Ukho?=
 =?utf-8?B?SnpTRXpMWjRLQ3hsb3FsV29ackhYajliNTc4VTJGN2FEVjJWbzNyZHJqMXBP?=
 =?utf-8?B?TFI2a3NGL3gwUE1NT0l6QzhPZnIyRUR3VVJlSnVmVnNVUzBtajh2K2JlVWcy?=
 =?utf-8?B?c3ZMa1lzZlpDSUJhUnJBeXhaSFpRQlM0UWJrR0NqaStFQkxNMXVXK1o1NERM?=
 =?utf-8?B?UTNsWUthVnpld2xlWEZUdmhtQkR5cHBXeUgwa25XSUp3akgwb0RRUDR5YVp6?=
 =?utf-8?B?aU5SMVpvc0lhVnVoNWR2VWd6bmZNQmRhZWRZaUY5cC95QTRURGE0N3lYYytQ?=
 =?utf-8?B?dXZxSmZWSWhVcExFcngycnhLR0NqYi9ZczJoVHNhY0pZNW1kUGhXZ2w3eWxZ?=
 =?utf-8?B?OEduWk5kNmZzREVlRW5jRVN0ekNvYjdZRS95cituWnZJMHV5ZUUzSm1LUURT?=
 =?utf-8?B?dDB4akFJNWJQb2ZHa1pRRDZURDgramVwaVM1QlQ4Q0cxcWE1eTFxb1FxUU03?=
 =?utf-8?B?T3hTNGdpNGFHeGhlb3NSVStjQzR0WGREY1Y0aEpsbkhRSGQzOURLWnpkUGhp?=
 =?utf-8?B?TzQycVVFZkdITHdXSDV6MzE0MThJWjNKSkdMczVYYk1zTGR4WDA0Z1NnbkNY?=
 =?utf-8?B?NzhvV2FsNUxkaTVQTjBnSmp4LzFyaGMvU09NbW1FNTRKTFp2bGlUb1FJeG9y?=
 =?utf-8?B?ZVhKbEliMEV0TGp3V09HN0E0UDd6QmU0UUJRdmsweUl1TTRDNVE3UFpHR3BE?=
 =?utf-8?B?NXE4WStEbkFjNVZQNU91SytBVmk5TVh3M1FGbWUzSnVZMENHSDZZbG1QdGxF?=
 =?utf-8?B?S2ZqSE1meXo3bUNYa1BBNjBIeFE3UHU5bEsvdHlzRzQrSU05K2txYVJJY0Na?=
 =?utf-8?B?VUNRWEdteUVKYmxTRHpNOHNNUGRPNFc1NzNGVkR4MnVTRVJQRWRRallSeS83?=
 =?utf-8?B?UVJwQmxiL0ZEVHc1OThUZEpHVkFRQ3FTSUE3T2g0Z3N1TCtBSmN6NjR3Skxs?=
 =?utf-8?B?OUMwK0Z6QzBCc1BWOTlqT3hOeWhCZWZSYno3VkZFNHVqWHljaWlaYXdEMkhL?=
 =?utf-8?B?dTYzV1o1bkJZUzdXY2o0YUVsYkcrY3BiUlZjcE9DMVV3Qm8wMWhTY3NFWHNN?=
 =?utf-8?B?Mi80Mi9HNkpyK1NPVzZId1hxVXJWNFozMm9hV2dHV3UwMkJoeEcrQUd6RGFD?=
 =?utf-8?B?ekJYL3JtTnZ6VTl0UVdJbGoyOW9kaGVhWDJObmU5MUVteW1vY0dVUWsxV3Nn?=
 =?utf-8?B?MWhLMWxpVFB1c08vVjNCRVBObzZvem5WUlF2VHd0YnRiWVk3WmFPQU1oMnhl?=
 =?utf-8?B?ZGxVdHlEV0ZyNmJ1aElORjd3a0VwU25ha1lxUjNTemJ5ZlhwVFRxOGZlNjI1?=
 =?utf-8?B?clViaVZyWURuWm11a01NaFJUeEYxbGJJMFFaRTdNUlIveDhGamZtdU9OM1lI?=
 =?utf-8?B?d0lXaGpNbWxWQkROWUM4cUN4WnY0SXVxNnBZdFJUcFR1VUorOXNVZ3l2ODFT?=
 =?utf-8?B?N3VEVXBxK1paK05lem84SFRJUzlCRnZZRnV4eW1jTXBIU2hYNkRpbEQ1bFBn?=
 =?utf-8?B?N1c3ZXpZTk1TV3RxelZ1Z1Z0S0FDc1IyM1V5NDdYekZwV1QySExXSFVnSzZ1?=
 =?utf-8?B?V0xVTzNjME4vMjY3VmMzRjVPU01GRTY2TWtIdTJ0ajBFeTd5WkVFVllPdWt6?=
 =?utf-8?B?NG9TNnFsell5cnpHRXRub29zbERYYkVBZmgrOURnUUhPTXo4T3FmRGhCTXQ0?=
 =?utf-8?B?aWxMbUJUSFI0bXM2M3Q4VmJuVHBHc2xzS2tEMFZtdWZhdHRFVmFRcjQ0MEZo?=
 =?utf-8?B?YzVtL2pmRDZkSHVHMjFPczd5R0VYWkF5YjEyRzRFUWh3MWloUlhSZm1FVkhV?=
 =?utf-8?B?TnJ1NUdXeXB4QU4xWXpTTTNlaXo1MmNGQnlQRzY3WHlrUHllb2E0NnVhQ2lU?=
 =?utf-8?B?NndVZk96NTBrYVl2MGYvNm94TW1rSzlvZEN5dGlzaEVRbWRpVnMzaENsVWQr?=
 =?utf-8?B?eFBYTDFzNDl3K3dUQ3dzeElKMEVxb3B1N2Y0YUN3aFVGbnJyaG1YWEtVQitj?=
 =?utf-8?B?R2pjdERNVlNJeW5TNmNWSCtDMDZJTUFsd0ZWWCtKZzlqSTBFb21zYnpDYmpS?=
 =?utf-8?B?ZEF3Z2FMeE5pZjdBcHdkdEtiYlNQMmRvRjJ1bzBBaGppc0laa25KelYxbTNF?=
 =?utf-8?B?U2ErREVZd1pnVnlQRHJMdjFWNU1ac2RVcCt5RVNSOTkwVEJNSGt0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dOlWzG7Gn7Z5JgFyyxgtymA863ZyuJAl/UkImvUSqvTOfah9WG7szl8qYgW1TfRX7odVCjynjLvHnTnC/XwsIzObVFk/agbQfNo7wyu3+krFIN3SkEqg6V63o0hmgBtiLAqp6bkJ45ouK2UFedANEm4E0HucI8jKOMn1W7gjXfySowP+aGBzVeuZzGibElrKdXEoHkyEsAFcFqeC9Pm8k/b64JQM9KsEG9gfcWeJax67/xs7ZJcgdI1BrPDzLeDiLLR2YRyec7K95sPgBfA4WWwNO+aDUNazegxnmZEzqGjUz4UCAtu1qMa5NpQR7krbZJUc5PPFOEIFBJV+M9+nPQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6900.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29496b61-5529-432d-a467-08dee75f72a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 19:37:06.4009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /5cGiy6jhnKipfz1J+tjjkjQhtzzHwx1hCCPulC1LqJW6GJjT4k4jOaIBbYHtlxjJnK5oK9jIBvp/VGZKfl9NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8828
X-OriginatorOrg: intel.com

RG9uZSwgdGhhbmsgeW91IEt1YmEg8J+Yii4NCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L25ldGRldi8yMDI2MDcyMTE1MDYzOC4zMDg0Njk4LTEtc2lkZGFyYWp1LmRoQGludGVsLmNvbS8N
Cg0KLSBUaGFuayB5b3UsDQpTaWRkYXJhanUgRCBIDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPiANClNlbnQ6IFR1ZXNk
YXksIEp1bHkgMjEsIDIwMjYgNToxNCBBTQ0KVG86IEQgSCwgU2lkZGFyYWp1IDxzaWRkYXJhanUu
ZGhAaW50ZWwuY29tPg0KQ2M6IE1pY2hhbCBLdWJlY2VrIDxta3ViZWNla0BzdXNlLmN6PjsgQW5k
cmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPjsgTWF4aW1lIENoZXZhbGxpZXIgPG1heGltZS5jaGV2
YWxsaWVyQGJvb3RsaW4uY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgRGFzLCBTaHViaGFt
IDxzaHViaGFtLmRhc0BpbnRlbC5jb20+OyBDaGludGFsYXBhbGxlLCBCYWxhamkgPGJhbGFqaS5j
aGludGFsYXBhbGxlQGludGVsLmNvbT47IFNyaW5pdmFzYW4sIFZpamF5IDx2aWpheS5zcmluaXZh
c2FuQGludGVsLmNvbT47IExpbmRiZXJnLCBNYWdudXMgPG1hZ251cy5rLmxpbmRiZXJnQGVyaWNz
c29uLmNvbT47IE5pa2xhcyBEYW1iZXJnIDxuaWtsYXMuZGFtYmVyZ0Blcmljc3Nvbi5jb20+OyBX
aXJhbmRpLCBKb25hcyA8am9uYXMud2lyYW5kaUBlcmljc3Nvbi5jb20+OyBTaWRkYXJhanUgREgg
PHNpZGRhcmFqdWRoQGdtYWlsLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgbmV0LW5leHRd
IGV0aHRvb2w6IGxpbmsgMTAwMDBiYXNlQ1IgdG8gU0ZGLTg0MzEsIEFwcGVuZGl4LUUgU0ZQKyBE
QQ0KDQpPbiBGcmksICAzIEp1bCAyMDI2IDE1OjM1OjM3ICswNTMwIFNpZGRhcmFqdSBESCB3cm90
ZToNCj4gQWRkIGNvbW1lbnQgdG8gY2xhcmlmeSB0aGUgcGh5c2ljYWwgbWVkaWEgMTAwMDBiYXNl
Q1IgZm9sbG93cy4NCj4gDQo+IDEwMDAwYmFzZUNSIGRvZXMgbm90IGNvcnJlc3BvbmQgdG8gYW55
IElFRUUgODAyLjMgKmJhc2UtQ1IgUE1ELg0KPiBJdCBoYXMgbm8gYXV0b25lZ290aWF0aW9uLCBu
byBsaW5rIHRyYWluaW5nLCBhbmQgbm8gbWFuZGF0b3J5IEZFQy4NCj4gVGhlIGluZHVzdHJ5IHN0
YW5kYXJkIGZvciB0aGlzIG1lZGlhIHR5cGUgaXMgU0ZGLTg0MzEgQXBwZW5kaXgtRQ0KPiBEaXJl
Y3QgQXR0YWNoIGNhYmxlLCBhbHNvIGtub3duIGFzIDEwR19TRklfREEuDQoNClRoaXMgcGF0Y2gg
ZmVsbCBvdXQgb2YgcGF0Y2h3b3JrLCBkdWUgdG8gdmFjYXRpb25zIGFuZCBjb25mZXJlbmNlcy4N
ClBsZWFzZSByZXBvc3QuDQoNCg==
