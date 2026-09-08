Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D254059B678
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890741; cv=fail; b=hauGEQEM2Vp4wSQpdNii1VsBeHLrQREdjkpumkYVNocv2iz18eeAWO3Ovhcu5rLi6GPpv7v5if/8kvrcPhU0lyDNkQnCji/QCupofc3hTBqaBza6Ah12ZbnkdGg+PzEyOgK7EdEllN8ulMgDxJu1MGj+yfZ4A7Lo4qE5tDbDp38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890741; c=relaxed/simple;
	bh=fp8cifu7qCERRyIKo9xfpciOmACfXWt+zqrdM+1Hj6c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LOJeA0wGibxZfmtHPxIvNFOHB2gkr4SgNXIrlL5nJTuUlMooLhNIMWIdpWgL7qrZzOpHYrHMsJN5+lPkh/LSsSPCcNRlqnEj76RnH30v/YxMmpltBTRTClHybDyVLVdfTTLruBSEaSuFmEw7wLcDN7CBJEhAU1Xv9rRdkyFLVwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CcAo/wOp; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CcAo/wOp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788890738; x=1820426738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fp8cifu7qCERRyIKo9xfpciOmACfXWt+zqrdM+1Hj6c=;
  b=CcAo/wOpKTuRR4pG6QGNXCIaisndo9suxc8QBrQuvhGPcrqTn0YlLBlh
   W43iiETYlwAA9CvyGMmBUQJH5SeGI8Ecr6+bfvmDx7BBwLvzpUfGIecc8
   8vBFbOBpMIYGFjR9TnhEmBl0iEiSI8ja0GJnzZ/HSPdy1lfsnF8BT6q9Y
   LSN11ilsp+ZL1/HxDuRe5Eo+Y02MupAmP3ZWA/L2xqQTsUbbbnV/gQJFE
   bt6Ce7Gio+6dcnrrGMK+sebYdTF4TKorub1/CRHY8OJuv1SUf4GLCAgCR
   g7E0+K1szacbMqEstVEKJhmSEKQ+9FhtfUN2o5SHeXpiBwN9fty1RnOUO
   Q==;
X-CSE-ConnectionGUID: 7yoZ534EQL2fxbpiibXTvw==
X-CSE-MsgGUID: EQnswyliTHa6lNxFaqyhyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="88238805"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="88238805"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 11:05:35 -0700
X-CSE-ConnectionGUID: p9GbCWzlRmq19HhlUDoSTA==
X-CSE-MsgGUID: 2S+eFL2iQDSDaxs9ZibbNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="274863432"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 11:05:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 11:05:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 11:05:34 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 11:05:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqMlQ/8QMYYHOXDEps6grNTlzxdkplAQ2dB6pecQwZk/Xb3qDDCym8u13f0jjh2Hpe6024i08Q4xl92nh1ihNtbzTRIWGphQgzkxaa8bn+Jnvn/t20AZ6msRuSTA6kt/+TZ2ZDWHpU2adAAPXpwCFuaIQlv75VVTpnvKPs6IRMCgReNM+WhFKuHBud/uQPE+Rrw7MA2mBd1EBZ4y/6zV/l7m8BDrduVIIj5Xqq41F2vsTyMsBsPoKf5e+jlSxfJ1dX66H6QISwYx6AZ6NmYm6JuanArJ56kqOpYS8S3WZ0b01S7V6LX4dBXqRw3T5mnRTkq4Z7l4aRq8zfNoH8dLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp8cifu7qCERRyIKo9xfpciOmACfXWt+zqrdM+1Hj6c=;
 b=H4Gy42q2YXHl6UIUsplKmQQKUhw8DXq9BxT0BV6acmYXxB0kh2EvafZXG0gmSVnmnHdqbgaXkQ1IQDtewBY1Ac26iN96Qn014tXy7LckIFtqDw7wS4qWC2KJBcvkTCRir7mTctuk0IIwbVEZqb5iEybxzxyxdBvFAiQtautR4k4Vwqevk4gTBSNmrpmYlWauVC/wF8QEp3PbRgGhI6W4pNklTlqou9kW23IEZ/5z0xSnSSF1kIpSEIN73pHhUmQVPr05e8G+xV+M/7pLC4ktWNOx1+XXmM6UGtud2NLT1X4J1Dlq+EBk48zwA+895kI4YoSBJNrsv2lFUWc2fLNSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DS4PPFAC42FDD50.namprd11.prod.outlook.com (2603:10b6:f:fc02::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 18:05:31 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 18:05:31 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
	<maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"Oros, Petr" <poros@redhat.com>, "Bross, Kevin" <kevin.bross@intel.com>,
	"Cavatur, Ranjit" <ranjit.cavatur@intel.com>, "Machnikowski, Maciej"
	<maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net v2 08/14] ice: E825: clear
 PHY_REG_TX_MEMORY_STATUS prior to soft reset
Thread-Topic: [PATCH iwl-net v2 08/14] ice: E825: clear
 PHY_REG_TX_MEMORY_STATUS prior to soft reset
Thread-Index: AQHdNOTVmPTVL10ZCU2lN2fqW9gkGrbFD1Xw
Date: Tue, 8 Sep 2026 18:05:31 +0000
Message-ID: <LV1PR11MB8790745C1598E991EC6F08B290B12@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
 <20260825-jk-e825c-minimized-fixes-v2-8-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-8-8223f95d26e3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DS4PPFAC42FDD50:EE_
x-ms-office365-filtering-correlation-id: 263803b5-11f2-4c7c-f544-08df0dd3c5d3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: 6bBa5qSDYc+L2QABagninyWE0bPsLfbeqElm24G5rAe2J4muK2miwpmQbYDNiXZvHlqDFXoLMNjgmq0c2S4tr3K8W0hFth8W+PodPZvDg9iN2mG/c6Kc8DCdm08K7+npufZRM7HmE0NpSzalBgfLUuQn/PeDpnBtDb7nJGi48l93YL+6uKGIHZEsbJW1WowkRF5fqRyas4P/L4RMYSVda1rCrHVA+aYTqeoDQcbSVBTj9/5CLh1EXADBNfM1Ns8qezDhcuTOUC2kkGFhUMEqhtAqW4yRI0cB3K+TPez1I19g6Hdy8bCY6v0EXEZjzhLBHnQeJfh73s6OUhwywGowW2wQkvNj3DAQ8bR/Ms6hidS9GjLcDORsQSZpuTSZxuJtdyILdSYa3MxhVs8/Rl5FQbOS8blW+ZuGcGcZ0Sc9A+EzwxvHkm4sHP9V6BLU8nbVTDbVksRN3Zsax8w7g5u6YzXWgl7ELLilLuGc4PfA4uJgMyICNFe4lp9I2GZe7PDG9oH73vkITsuspdm/FliWzsZNGgkThTrUz24ZPuKrca+Lp8MO9ReNMQXCnkBTUlrg9vwOBkyq18XesUHR8WC8l34cQvgB3UO2aBrMj62qb/VV6q9H6OukpHC0s85H1JLlJh2FqRVWbWvJuQwfwlDaqwFh10i70ykAmx0JVE50hdlOLRFRt3UkMlmVp2bypcXaH5J4KLQ8QCcyrmOLuDLQPsh+bu8ZYL01kfONoFGQ0FA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVZtN0EreS9mUEpaMHUzcnNKbnY1M1hjVVBFd1ovL1J4L1FrQm1JQTZVbUN6?=
 =?utf-8?B?MExCQkZRVXZQVkZtSno5NzdCT3NEa2FCQTVZYU9mMktsSTdEV21nV3R4QlQ1?=
 =?utf-8?B?QlEwTUdaUmFvcTY5SmpxRmpUNzVSN05GY1pNcjJia1hlalNoOTgrVmNkeUNX?=
 =?utf-8?B?SEFWU0VVR1hzaUtWTXQ2YUM3UENHTHB1T0RaMHV1STZIblFEdVk4TW9rc1l4?=
 =?utf-8?B?d2Fmdk00QXNUb0g3UjM1aGx0Zk5hbUNMMzljNkFsdzlXN2NPd0ZJNnNoZFRT?=
 =?utf-8?B?NVc2aE9sTVZyTk9nOHRvNmZrSHBET01SQkdheVVuRmpXVXd1Mmo4ZEYxSHA4?=
 =?utf-8?B?YUczenFmSFFCZEg4Q0VKbG5BZlArNGdoZ1REMXJwWnRPcWlyZ1dJazBZT2ll?=
 =?utf-8?B?SURjODMvb3dscHpuSzI4bHNhTkJjSE82UkUraHloSXJvVVV3azhEUW1KRXI5?=
 =?utf-8?B?czRxc1poUS9VUFdweUNFMmZ0K1dhVW1ObUo0ZEVyc1YyK0ZtUFlZa0VsUFd0?=
 =?utf-8?B?YUdQNWd2Z2FnMXh6UUNlV2V5WHBheExXamNLN3o4cWM0ZW5rcFp1NDc2cmVw?=
 =?utf-8?B?YktkNmZWZ0pTSlpjdldJTlVCQW0wOU5nUkJ1b3lhd1NvcklaeXpvRklYTDNn?=
 =?utf-8?B?MkpUbnBoZnZNd3A5RzgrV2JDcmppMUM4c2VTSWt6Zms1K3Z4ckVvZG1nVjA4?=
 =?utf-8?B?OHFISkdZc2tzTXd1blRXcUFSdWkxaDlqY2pKRWxlRjhERjZYZWZpNHBvOGhG?=
 =?utf-8?B?SnV0R1NiQkxkT3BqdWlYa0hLOE1VVXlCY2ZhYTBkdXVIT3FEYUN4L3FJZ2Iz?=
 =?utf-8?B?VmhrclJMMDl1Kzk5SjdTcUJhckV2M1NteW4vMWJ6SkVzMUlpblJxdFZhTnpT?=
 =?utf-8?B?NFZwcTBCV1UrTHJjZXAvZGpsNGJOZUlBZXJYY3NUS0JwQnhCV1ZwRFZIN1VQ?=
 =?utf-8?B?KzNZTUNHZ1NoZGNOdnBiSEJFNDVuaUxJQnpnWXRpTWtmME5MbzZDZHFwVERS?=
 =?utf-8?B?eWhjeXZ3T1BZSDNIMmxmeFNlbVRFUlNoOGEzd1NFSUZGTmo4UEZGWFBjZ1pI?=
 =?utf-8?B?WGc1MmdYRlM3eVpCV0k4VzZxazJqN3hpSlRpbVRNMS95dSs1V005U2VBOEk2?=
 =?utf-8?B?R3czSGdTNXpuSXU3bk05eWw4OTVDSzdvcVBhdzVjK3ZEVTZmODdzaHJjditr?=
 =?utf-8?B?Smhzc3djS2diVFZkUEJOVE8zZ2wzUHVaMTc4OHFUS0JZTUN0VXZGRGZ1Z00y?=
 =?utf-8?B?dUYwWTMvV3I3MmttMWEwSXVYNkpWWmV4Y2laSTlkd01nblNHN0x2ZittWFdY?=
 =?utf-8?B?RkMrV1NLeVZhU2JHMnBKY0hOdll0QjN6dzFBQ3JLNUFIOUVsZkwyVVB1bHBX?=
 =?utf-8?B?bzJuc0NCa0xqR090dWVudXNneFdSbW1OVVZEVVV0cW92WjI0cHp5VVFnRS9S?=
 =?utf-8?B?K3RJc3d6TytmREVMbXpUYnRjUVg1ZFE3WXVLYWtlV3Q2U1ZFMXpVdDlqdVp4?=
 =?utf-8?B?a0RYUUN4V2pCSDFrK0VYeUc4U3pnWHhDVEhUZDMvc2sveVRXa0I3LzYxdjRq?=
 =?utf-8?B?b2g0ZW9STDhOSlp5MGNIQk1DMll1SmxWMkFaemhnU0lZMnRBUE1MMG5UZEMy?=
 =?utf-8?B?bklOQ3BtZ1RndEZwN1MrbXhmK1p3eHY1VVk0c3R3VjFMSHRGZE9sRmp1c1JO?=
 =?utf-8?B?NzZoRGhIWHg4TlBWZDlGSTUyeUxQaHlHWnZYT3M4d1lUckIyczYxWldORGp5?=
 =?utf-8?B?UjhNQ2kzcFZUSnBybDhON2hnYWF3RFBTY3NTbUJrd0RvL2N6Q1Byc0swa1ph?=
 =?utf-8?B?NTNxeERBV1RFU1E5VVRPdDZqbHlSbW5UNlR4bnY2MDB5YTE5S2wvWjhwbE5G?=
 =?utf-8?B?ZGxoakdqUnBkR01hamhvV1lQeUlLcEFkaU9oS2hKYkJyMlppb2YxajhXS1hC?=
 =?utf-8?B?dWYxUU80dDQwZitTRnFxODJHY21QM25sQlBuNWhRcDByVWQ2a25rNmlRNHJh?=
 =?utf-8?B?RGNnZS9DWENwL1ljTnltN0g5d0dKRnZDam52aDRxZDFUV1pBVVdQY3FoVWtG?=
 =?utf-8?B?eTg3VEFXZFpDdnBWd2RrTFNSbnFvajBSUy9hQ09QWmN3SVRra1YzS1ExWnBI?=
 =?utf-8?B?aDFZUnY2Sjg5ZFRRV0s4NkhyOHlmSlNmbEhVUWZrYjJWcWRQRnhVaDcxdWZi?=
 =?utf-8?B?QmVUUEJQcmF5UnVuRThCK3huZjhRNUVsZVNXTlVBMmRUS1NJU3ZEK3JpRmRa?=
 =?utf-8?B?dnZXcTdIdFhma1JJdlVlZmhNUDdOL2p0WEJlbWdpY0g4OU5ya2lLYklxS0th?=
 =?utf-8?B?UzNEQ0dWTWI4dTBTdGptTWhFWW8wZGdVeGVYT1E5enNyZDVoMFNpdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l25AW6JOrXULCtlYSWi8NMBS2gdSRIluPYlyMFDtzlej3hJnqKdJLgxgKS+LpOQIlONfsVa/RAIF4FxfwilwoL9Nbii77c6odEpR/uRjw1m818uQf6YvHS9nFWJGhgujPX/FvDQPTqXP3k5mIP6KP5JvpbFk3oZVkF1Lc09TwHcYBJ/42U61wyPQ1XLoTHQobz+jZv0wP+c9oW+EPwGhbydDylTtdk8R5vp9JqcrqbSYiO4ES6qK38Yu+5mezbe3UFjLPwtZRjSz7gUwaf+gaFqGmxdS/w7pCPbCXDQKi1fKdIdVRaKBiYz5DGOSR0BNrlBPCXE4kbDGSOnE4V17SQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263803b5-11f2-4c7c-f544-08df0dd3c5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 18:05:31.7471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9tAGYbGyDj+G118NCdTpej2GUybk3zEhVZhkR/2Anz18brrjFHgQK6kInItAuumlrtly8ufYYuz6WwEpX44XteMRCF5oE7oAMc3pGKTeG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFAC42FDD50
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZWxsZXIsIEphY29iIEUgPGph
Y29iLmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyNSwgMjAy
NiAzOjU0IFBNDQo+IFRvOiBJbnRlbCBXaXJlZCBMQU4gPGludGVsLXdpcmVkLWxhbkBsaXN0cy5v
c3Vvc2wub3JnPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTWFjaG5pa293c2tpLCBN
YWNpZWogPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPjsgTmd1eWVuLCBBbnRob255IEwg
PGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS29yYmEsIFByemVteXNsYXcgPHByemVteXNs
YXcua29yYmFAaW50ZWwuY29tPjsgTml0a2EsIEdyemVnb3J6IDxncnplZ29yei5uaXRrYUBpbnRl
bC5jb20+OyBPcm9zLCBQZXRyIDxwb3Jvc0ByZWRoYXQuY29tPjsgTm93bGluLCBBbGV4YW5kZXIg
PGFsZXhhbmRlci5ub3dsaW5AaW50ZWwuY29tPjsgQnJvc3MsIEtldmluIDxrZXZpbi5icm9zc0Bp
bnRlbC5jb20+OyBDYXZhdHVyLCBSYW5qaXQgPHJhbmppdC5jYXZhdHVyQGludGVsLmNvbT47IEtl
bGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgTWFjaG5pa293c2tpLCBN
YWNpZWogPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0gg
aXdsLW5ldCB2MiAwOC8xNF0gaWNlOiBFODI1OiBjbGVhciBQSFlfUkVHX1RYX01FTU9SWV9TVEFU
VVMgcHJpb3IgdG8gc29mdCByZXNldA0KPiANCj4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24g
b2YgaWNlX3B0cF9yZXNldF90c19tZW1vcnlfZXRoNTZnKCkgaXMgZmxhd2VkLg0KPiBJdCB0cmll
cyB0byBjbGVhciB0aGUgdGltZXN0YW1wIG1lbW9yeSBieSB3cml0aW5nIHRvIHRoZSBQSFlfUkVH
X1RYX01FTU9SWV9TVEFUVVMgcmVnaW9uLiBUaGlzIGRvZXMgbm90IHdvcmsgcHJvcGVybHksIGFz
IGl0IGRvZXMgbm90IHRyaWdnZXIgYXBwcm9wcmlhdGUgUEhZIGFjdGlvbnMuDQo+IA0KPiBUbyBj
bGVhciBvdXRzdGFuZGluZyB0aW1lc3RhbXAgbWVtb3J5LCB0aGUgZHJpdmVyIG11c3QgcmVhZCB0
aGUgdGltZXN0YW1wcy4NCj4gSG93ZXZlciwgbmFpdmVseSBkb2luZyB0aGlzIGFzIHBhcnQgb2Yg
aWNlX3B0cF9yZXNldF90c19tZW1vcnkoKSBpcyBwcm9ibGVtYXRpYy4gV2hlbiByZWFkaW5nIHRo
ZSB0aW1lc3RhbXAgaW5kZXgsIGhhcmR3YXJlIGtpY2tzIG9mZiBhIGNoYWluIG9mIGFjdGlvbnMg
aW5jbHVkaW5nIGNsZWFyaW5nIHRoZSByZWFkeSBiaXRtYXAgaW5kZXgsIGFuZCBkZWNyZW1lbnRp
bmcgYW4gaW50ZXJuYWwgY291bnRlciBpZiB0aGUgdGltZXN0YW1wIGluZGV4IHdhcyBtYXJrZWQg
YXMgdmFsaWQuDQo+IA0KPiBUaGlzIGNhbiBwb3RlbnRpYWxseSBsZWF2ZSB0aGUgaW50ZXJuYWwg
aGFyZHdhcmUgY291bnRlciBvdXQgb2Ygc3luYyB3aXRoIHRoZSBhY3R1YWwgbnVtYmVyIG9mIHRp
bWVzdGFtcHMuIFRoaXMgb2NjdXJzIGJlY2F1c2UgdGhlIFBIWV9SRUdfVFhfTUVNT1JZX1NUQVRV
UyByZWdpb24gaXMgbm90IHplcm8taW5pdGlhbGl6ZWQgd2hlbiB0aGUgZGV2aWNlID4gYm9vdHMg
dXAuIEluc3RlYWQsIGl0IGlzIGZpbGxlZCB3aXRoIGdhcmJhZ2UuIE9uIGEgY29sZCBwb3dlciBv
biwgYXR0ZW1wdHMgdG8gcmVhZCB0aGUgc3RhbGUgZGF0YSByZXN1bHQgaW4gdGhlIGhhcmR3YXJl
IHRyaWdnZXJpbmcgYSBjb3VudGVyIGRlY3JlbWVudCBmb3IgYSB0aW1lc3RhbXAgdGhhdCBuZXZl
ciBoYXBwZW5lZC4gVGhpcyB1bmRlcmZsb3dzIHRoZSBjb3VudGVyLCBhbmQgcHJldmVudHMgbmV3
IHRpbWVzdGFtcCBpbnRlcnJ1cHRzIGZyb20gYmVpbmcgdHJpZ2dlcmVkIGZvciByZWFsIHRpbWVz
dGFtcCByZXF1ZXN0cy4NCj4gDQo+IFdlIG11c3QgcmVhZCB0aGUgUEhZX1JFR19UWF9NRU1PUllf
U1RBVFVTIGluIG9yZGVyIHRvIGNsZWFyIHN0YWxlIHRpbWVzdGFtcHMuIEJ1dCBkb2luZyBzbyBt
YXkgY2F1c2UgYSBkZXN5bmMgd2l0aCB0aGUgY291bnRlci4gVG8gcHJldmVudCBpc3N1ZXMsIHBl
cmZvcm0gdGhpcyBjbGVhcmluZyBhbHdheXMgYW5kIG9ubHkgcmlnaHQgYmVmb3JlIGluaXRpYXRp
bmcgYSBQSFkgc29mdCByZXNldC4NCj4gDQo+IFRoZSBzb2Z0IHJlc2V0IHdpbGwgY2xlYXIgYW5k
IHJlc2V0IHRoZSBpbnRlcm5hbCBjb3VudGVyIGFuZCB0aGUgcmVhZHkgYml0bWFwLiBUaGUgcmVh
ZHMgdG8gUEhZX1JFR19UWF9NRU1PUllfU1RBVFVTIHdpbGwgcmVzZXQgdGhlIHJlZ2lvbiB2YWxp
ZCBiaXRzIGVuc3VyaW5nIHRoYXQgbm8gc3RhbGUgZGF0YSBpcyBsZWZ0IGJlaGluZC4gVGhpcyBj
b21iaW5hdGlvbiBlbnN1cmVzIHRoYXQgd2UgYWx3YXlzIGhhdmUgYSBjbGVhbiBzbGF0ZSB3aXRo
IG5vIHN0YWxlIGRhdGEgYW5kIHdpdGggdGhlIGNvdW50ZXIgcHJvcGVybHkgcmVzZXQgdG8gemVy
by4NCj4gDQo+IEZpeGVzOiAzZWM0NmUxNTdjN2YgKCJpY2U6IHBlcmZvcm0gUEhZIHNvZnQgcmVz
ZXQgZm9yIEU4MjVDIHBvcnRzIGF0IGluaXRpYWxpemF0aW9uIikNCj4gU2lnbmVkLW9mZi1ieTog
SmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBN
YWNpZWsgTWFjaG5pa293c2tpIDxtYWNpZWoubWFjaG5pa293c2tpQGludGVsLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jIHwgODggKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRp
b25zKCspLCA0MSBkZWxldGlvbnMoLSkNCg0KVGVzdGVkLWJ5OiBBbGV4YW5kZXIgTm93bGluIDxh
bGV4YW5kZXIubm93bGluQGludGVsLmNvbT4NCg==
