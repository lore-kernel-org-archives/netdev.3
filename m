Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2F438004;
	Thu,  6 Aug 2026 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008895; cv=fail; b=Jqa9ceWp8LNrXe7vtBYQjnONVqclwrQBS6l99ik1IZIEMHbsdde97NjQ4EoDOZfIkFes7pQjaHvMCfvKTzSy1t4VfCokzJrKpVI6vBw8MA/NW3EiqhvG1SqGkdrpdolNjxcVJp2b+MevkE9xa0nLh+/UdlhkCPyh9LljUeWWUU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008895; c=relaxed/simple;
	bh=ss3g8Bvr6TPzXkNnDe4TCLCVqiKSmi6q1SadEJZzhJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tcNqmg2GrzWhBVrfphQ9MlVucn0wcpIUkDukzQnPIcx4AzeYwYX2dzKf/Qf0UjUBK8643Ov4EV0JweWd0BGxEZ0vCkx0wqxCzGANIc/wRA+fSeBX5iQMBqaHYdBpX/7e/ZpQrM4tyhSWYUgBuRIwgUlHfRvGrlyr76FAN7F7+N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlhS2ZSs; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlhS2ZSs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786008890; x=1817544890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ss3g8Bvr6TPzXkNnDe4TCLCVqiKSmi6q1SadEJZzhJ4=;
  b=nlhS2ZSsJYc19DIuwfi8t/2dDou53e2eWbNYkkzmuOz9E8WHHt2yIDqv
   m8IhdKF+FLaBlKUh/WrgSiiSDqxkkMlF+7hy32hJed4NP/AILVMuuZi5x
   nQaYizg0vfSAkvQ8r67mhdcVijZSaN2oWIY5hWdEHxqz/I2PKwuXRa8S6
   Em4813uwzqzFBZbAn2wVoLdLwP2TltaW+UHnxyLllgtkLeJ+G00rwqgih
   vBTv3quojuD3arHE0ymOjzmqVBFU98+emxMM5tmXOwTVWAQAWTpqOiYWw
   XXS5azZgDsZuSGRze5TrUxI2MH2QsHcQPg2Q8tPdTeyBkRnwy+RuK8D9l
   w==;
X-CSE-ConnectionGUID: SoAqlONxQ2ypL+OhCzgNpA==
X-CSE-MsgGUID: p9LMwk/LSGWV/2O7M+dvQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86539912"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86539912"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 02:34:06 -0700
X-CSE-ConnectionGUID: l0PooQ4mQeeojlRXDIVreQ==
X-CSE-MsgGUID: IkfcAv64RoyyPzYNvBrW+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="261512908"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 02:34:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 02:34:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 02:34:04 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 02:34:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrMskxnOckAhkpy4nsNDa1WAqTlTxQ0A3Sw9fQb8y/s8PiVKBq/0troK4aW5o+du0F9gnZYs+/nPubL+I8eH+Y/UU3lVnFzJIALaROXpURPil4GeExwPh6BoLFLK9j5ULSqjB3qHhcrYWljqmOvU4YI0knYAHlpg8PnwEoqOfnGZqFYdY9WCqYjcwaIzBtB2nvgKdKtK8A9NMO0yGUemcpWuMX9nzGsUhCFKBKUkUoxQAxkRJqsAjTa7JYeJDHgM6OgqM2xqRUVaTKKg7yIrMBRfOhJgl9Otjb9mRL8Ea8eKBd11g085us2R9l/IvWMwolUhcYWA2VA7a8LHGujlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ss3g8Bvr6TPzXkNnDe4TCLCVqiKSmi6q1SadEJZzhJ4=;
 b=dSkzHDblnl36JJfiFuQ3fwKrp+D0ILOexY36x90JQts/aOlyFHfzhnFnqc4u+ykld5XRKpbfxf9G5CGG9+onW+74m9xdnpKQU0p6ZQnPDRk9PVJVJStFkfkcbwfHCpy7Q1RofzNJ27Xv4pCuO/uRQxK6A99p06yteNgE5JsomtDUMIzuDS7/S06JSgc4wcIHSh2VzfBnpAuuu9qR7pD5F8nQGVUiNROSaekVRWC+ae47GSaJ7WAertoEP2mvM/LH1DFaxWB0FIILbdNfFDPIBgbxn8MeGA3zVCB3iNNLuY9uJevQi3+tgPPDoXnrv9OYFK0rqc137w0AM3wWGCa87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by SN7PR11MB7665.namprd11.prod.outlook.com (2603:10b6:806:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 09:34:02 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 09:34:01 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: James Hilliard <james.hilliard1@gmail.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>
CC: "mfd@lists.linux.dev" <mfd@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v3 1/4] dt-bindings: mfd: x-powers: add AC200
Thread-Topic: [PATCH net-next v3 1/4] dt-bindings: mfd: x-powers: add AC200
Thread-Index: AQHdJUKoZKqc6YQLC0aVMVo+yZkvs7aQwnkA
Date: Thu, 6 Aug 2026 09:34:01 +0000
Message-ID: <PH0PR11MB590277D605426A9B0D6AC2D6F0D22@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260805-submit-acx00-of-dynamic-v1-v3-0-32c3210a6f25@gmail.com>
 <20260805-submit-acx00-of-dynamic-v1-v3-1-32c3210a6f25@gmail.com>
In-Reply-To: <20260805-submit-acx00-of-dynamic-v1-v3-1-32c3210a6f25@gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|SN7PR11MB7665:EE_
x-ms-office365-filtering-correlation-id: 20cc51d5-c534-4900-4cef-08def39dd9a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|38070700021|921020|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: ganeSzC/dQXRM7PmGe8n7u4/lq4vUylisuECHOwG8qg9hMveUGlSxISxbUiXxVcBgliGZWpoHlqOMLnoLydSieczo0oebHNjvUUuWCrjXh4Rlp8Xmen/BpdP/kO03i/iIarljN333nGaA+0VoXyLVF4/NZVtssJGxkyuk+116zG2DKPAF6mzrPFe2eDLbAwYsy+Fq37588mEpLJ3npYyE6lxRLoJACApAlPvLjAhJv1Y89+n/HsI6fWnSJO8vUxT+GEdyOvSBuxHp1SNJ6LT0ON3EYqEgB2gbeejqXbhi3VIK5JAKvZ/8RbTqnpGDhvv/4ChACthmPRkguttnC9KaGn4NIOXbkWJlc9xFSvYRO4TrVTVU20Kp4RkyHxERI7PxOdT7c+i1I/NEibLsjTWqoNc5BnQyUfK+ZebJTZz9oTFhszaY+MTRFfvcTAgMBrkSloSkXKIr3GAAMRVOPXEYqUYRN9uykCXqaCpdLvE5qGhaTTO6/AlsC6lKo1T7dzi/HmcEL9h2yBtDz/d6dwim/NqKHa7ch9TZpAkkM/Vnfb574gcXHxEhGqI1fws9adqaH1LcO11dFRV7P/dWb80qyB+RgkEkf0mS7iZ7Wq7JpSuO+cqBMy/BWC1PZ5+UBO74r1d1fcEsqEfrPKmdG6dxE3NRAhEJR6CsBuwA2k0nsMW7FNtv5gZ4jsldraX7JIzxbbmF4dctVAXS/nExy8De/rSHzAsslC3o0BR/TXJGOaq60pfLEB6xRRzFzF+KvZw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(38070700021)(921020)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkQwakxHRkJyUzErKzR0WDJYRmdYUHVaNDl3NjdSYWRXNnF0WHp4NkhKNmdx?=
 =?utf-8?B?VDcrN0puWUJuKzZ1OExIeitoaVI5OHpZSldDcXdHaTVwWjdqdTR6b3FYVGc3?=
 =?utf-8?B?OUZtODk2dmVjV01NOVJ0YTlYcXdqeExTb0FXUzlUVHVXZzRxYVFWUGdVMTkv?=
 =?utf-8?B?bXR5dVBUUDd4TmhsTkE5VkJKbzNhbFdoTzA5NEFCMmUrYW1rQ2IxLzRTV2pv?=
 =?utf-8?B?Y3luTXk0TGlab203ZmRnOEp4V1JIRFRIN2ZRZGVzVnMwdTFPSmd1bjFoTUNl?=
 =?utf-8?B?TWhkUG1XU1dIay9YdGdoNEMwcWZrb3c4SXJRVHNEWGp0N2FRSklybmlRK2JZ?=
 =?utf-8?B?eHpNcnN3dnQyMDl4bFYxMnlWUmlwNGxXS3JVVUcwaVhPbk03OExvUXg5VXM2?=
 =?utf-8?B?MlFrcGdWNzYvMFQ1K1JMSFBLU2FLMndIM0xydjczZ2hOdFh0VUJKTDVTa1cv?=
 =?utf-8?B?QzRtUVExL0lRNFh6RjRSQk90NE1Vc0hwNDVYWVF0NSt2NzVJTk83RlN1QjI0?=
 =?utf-8?B?OEhFTjJQRGhydG5aTVRMVjZlWk5hYzMyUFN0TXpXT1pEMVl4cUpGTEw1TXRQ?=
 =?utf-8?B?dE9PZHpYaDYrdE4yZU8xdk9JQ0hqME5HUkRoOGlxYXRtQUFCVmtXa3JDS3Zx?=
 =?utf-8?B?Y2o3Q3V1eVZKcHR5NllyQVFjMUlhcTIzMkROZkhNUTB2S2kvMmxrbjdkbDJz?=
 =?utf-8?B?ckE5SDBQcTNseVFJMDBNUXZ3dnNaM1d6NVJLS3JPcURURWV3MDFCV20wWHAx?=
 =?utf-8?B?V1RHREZaTDJSMzNIN3QrU3kycHBDa3ZyREJ3TjkrY3BDL2ZZOVVIL3M5SmJW?=
 =?utf-8?B?aitDMGpRSEhoUUxvSk5rNVFhTWVwQW9JcURqVXVaSVhyUlBXcm1kQm11MkND?=
 =?utf-8?B?Wk9IZWswT3AwaCtTenpvdlFjb1BCamNRSSt3ZHJnQU5HbVNCWElUQ29zZTBE?=
 =?utf-8?B?d2RTdVJ4ZWs2aXkxNEF4Q25aZFU1NUZwMytrZnV3aXdydjdIajEvYnlCL0Uv?=
 =?utf-8?B?VzdMU0ppMjVEMHdVLzFSa1RkVnpWeGlKWG9WRTUvbE9HY21jWGYrSWxpVWhn?=
 =?utf-8?B?OFNvd1F2UjFBdmUrclhEMGRRcGNRY0JId1ZLY2xOT1lJQmowemJnVUduY2Rk?=
 =?utf-8?B?OXdjWUVpMDB2Z3NxRkgxMll4dnRHNmIwSWhsS1BSRlBlOVVZazQxRCtzaXNX?=
 =?utf-8?B?cWZ6c0RJU2xyY0hvYkNDLzFXMkt3c0Q5akIvcUdtRU1DMkpNa3hoSlFUYWsv?=
 =?utf-8?B?MGpKYzZTbnYyVVZDeGo3eXppZlF3WVdWWm84YjVFWEZoNEVhQmN3OEJaUzFC?=
 =?utf-8?B?ZFhnRXRNK1dQaTNMaVNxd29LQkhUWTNwbGR4NUVFbHNqV01RVFc3NitlVzFS?=
 =?utf-8?B?eDlmVmxST3BCVVJ3SGxCTTFQSFZrMEl0cllZdlcrQTQrVnAzYWIzeHowUE9J?=
 =?utf-8?B?a2Rkc0VPWVp0K0hHSUlQckFSNHdWdU9NaHZIbXEwVk1FeFBnZlRXZWlOZ2VG?=
 =?utf-8?B?VDRra0VwR01TbkJmMm9BQ1Q3U3hoRDJUSWI5Ti9XZUl3K0s0MURacmJBR1ZH?=
 =?utf-8?B?WVk1OXM4VlBJZkZ2MWw4VVB0Z2ZnVTlONlVxQXVwNlVBOTZweU53QnBVWDNO?=
 =?utf-8?B?TklabzNTT1ZhNldCdFRQcFp6WFdJbGxPb2RlVzUxMlRrUGNGMG9pZXNPanVT?=
 =?utf-8?B?M09Wa2gvZEtlaXQ5Uyt3bno5NDZUM21uU2pNNEdjY254RjhQVjdmU0NaRUYw?=
 =?utf-8?B?c2c5bVpRZlF6RmZZNGJob29lYjJqOUhFT05TSldEMy90Q29ENkNIV09scTdB?=
 =?utf-8?B?VWJsRFpXMHdNODZBMWdwZEVmTVRublA4VlRQajFCRzJ2UVpueVd1MHIyZkZn?=
 =?utf-8?B?OFZ3OExtUW1kN3ZyZHY5d1l5VHZnY0lsWXRPNVJLc2U3eFV5eXlpTGVTN000?=
 =?utf-8?B?cnRXcTBlWUhQN3NRcnVsZmR1aGgvTGR2ZitaYVZYdjBCbFFsSURERzgxYVJ5?=
 =?utf-8?B?TXRBaFNLcUJEbXFBT2dJa3hCNVNsM3NMMUU4Q1dhVG9jUUJSNkhSQlRXcWVv?=
 =?utf-8?B?NlVXSjBVdEhBL01OdlFOOG5JcDNPbnA3Sm5WWWJtb1ZrWk9vckVuTDA3NUdJ?=
 =?utf-8?B?RmNUVnJiVnYyc2tqZEVYdkwwbXNxVzA5RFJ1UWpHdkVKamtsQ2w5cUh0RkpC?=
 =?utf-8?B?emh3TDR4TzUzcVdOeW1Ram1CRk5LUVNJVEF6RWJscnZCcXFZWHIvcjYvMllz?=
 =?utf-8?B?ZkUvR3RudE5wV1l0SVRsVDNJYnFwemQvclU5TlpreWdIT1o1UTl3RlZVejE0?=
 =?utf-8?B?SjVUSkxhMDgwRC82Y1d5UWlNOWN2c2FvSE9sNUQralJ2Y01Cc2dQdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: C9idEQ4TdOWu6CsGOlAVXEvpGCqNwGcaYFv3gGLW4TKx43eofc4m3+8adw6Kb7zNAHGbddX5dIvRYU26+w6pBWY21+WZlc6rRUE/iMp5Oo8ImnjjSSrpALRuOh1+7LY0tBERwloK5WPPjzuEYnLEluYZMvOSa0i6cVA4lRRQfwSsjvFW+hCpwqqi0Wn9KAcvpq4E62W3YvS3JVwe36WmA1sMOFSWTDZqnKJS8eNTH7P4ik6dMDUhFHGZ25cBLzAh4zyAaHqa0H/ls1AoWMIV0JM4emNc8F/WFvDuj8gwxPQr7NT1Csc9toEC2h4pqilqxDmXf8OHHlX085WdEs5HMQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cc51d5-c534-4900-4cef-08def39dd9a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 09:34:01.9704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xFqToPNydwOhWIU+8RCCAcPgFQbvH3EyHEBVSX8VYd2TkBwb2Y+9qhoJiAkqMxTaIHubZMjW63eL/iVwASEYyba89Yx6t++lcvMyJj2YxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7665
X-OriginatorOrg: intel.com

RnJvbTogSmFtZXMgSGlsbGlhcmQgPGphbWVzLmhpbGxpYXJkMUBnbWFpbC5jb20+IA0KU2VudDog
VGh1cnNkYXksIEF1Z3VzdCA2LCAyMDI2IDM6MjQgQU0NCg0KPlRoZSBBQzIwMCBpcyBhbiBJMkMt
Y29udHJvbGxlZCBtaXhlZC1zaWduYWwgY29tcGFuaW9uIElDIGNvbnRhaW5pbmcNCj5hdWRpbywg
dmlkZW8sIFJUQyBhbmQgRmFzdCBFdGhlcm5ldCBQSFkgZnVuY3Rpb25zLg0KPg0KPkRlc2NyaWJl
IHRoZSBwYXJlbnQgZGV2aWNlLCBpdHMgaW5wdXQgY2xvY2sgYW5kIHRoZSBmb3VyIHBhY2thZ2UN
Cj5zdXBwbGllcy4gVGhlIEV0aGVybmV0IFBIWSBpcyByZXByZXNlbnRlZCBieSBhIFBIWSBwYWNr
YWdlIG9uIGl0cyBNRElPDQo+YnVzLCB3aXRoIGEgcGhhbmRsZSBiYWNrIHRvIHRoaXMgZGV2aWNl
IGZvciBhY2Nlc3MgdG8gdGhlIHBhY2thZ2UgY29udHJvbA0KPnJlZ2lzdGVycywgc28gaXQgZG9l
cyBub3QgcmVxdWlyZSBhbiBNRkQgY2hpbGQgbm9kZS4NCj4NCj5UaGUgaW5wdXQgY2xvY2sgbXVz
dCBydW4gYXQgMjQgb3IgMjcgTUh6IHdoZW4gdGhlIEV0aGVybmV0IFBIWSBpcyB1c2VkLA0KPm1h
dGNoaW5nIHRoZSByYXRlcyBlbmNvZGVkIGJ5IGl0cyBkb2N1bWVudGVkIGNsb2NrIHNlbGVjdG9y
Lg0KPg0KPlNpZ25lZC1vZmYtYnk6IEphbWVzIEhpbGxpYXJkIDxqYW1lcy5oaWxsaWFyZDFAZ21h
aWwuY29tPg0KPi0tLQ0KDQpvaGggc29ycnkgaSBoYXZlbid0IHNlZW4gdjMgaXMgYWxyZWFkeSB0
aGVyZQ0KaG9wZSBjb21tZW50cyBhcmUgc3RpbGwgcmVsZXZhbnQsIGhhdmVuJ3QgY2hlY2tlZCB0
aGF0DQoNCg0K
