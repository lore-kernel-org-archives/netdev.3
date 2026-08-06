Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E6415F13;
	Thu,  6 Aug 2026 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008101; cv=fail; b=H4Nm9+AeQllWDNbpPfTbsgleUkzsGYG8ZUVDLZH5v/I9i89DXbhTe/K5sd8yojnTChL/Skd/u76MWi+Gyu0njuELElXUVr5o6zUwOnmSO2v968wqjiYqebxBL8jK3+DBz962eev8KSjU0tjmY0jmxRmjlMPXNKU5IEuXyhZv5/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008101; c=relaxed/simple;
	bh=y9JarZc3keDSowPrWhVDsLubxMrMwCEw2h40Gj+z+gU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bHWShiQIRBqI6zqN2qpyjYbDAucJX3KgyhCrWJdp+pDno+NVeSG4+4ot+e6QlY1Q4ALglr7LJ4hCI/f+gGO9EpzDJd/TkEWRn5eaCkMhmajC73kL3xqbtIg2xyK1A7/Awy2WiTaFECVdzT1kJC9rr1ZIIL3S7wmeweFRE4vwG5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWKMdIB1; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWKMdIB1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786008098; x=1817544098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y9JarZc3keDSowPrWhVDsLubxMrMwCEw2h40Gj+z+gU=;
  b=BWKMdIB1oXZUrOFl6AQEk7kyP0HjgoTanmG5KQGioN9NNmUGg/IsKaZO
   W9BqTtO+TodRD2XE4LvVXBYbLhtqmsTNbPPI1QjnIIbwgMi8ntraGTvpM
   oPLNGUhip+teyvgEZy4zvPkCpGpy28uwbbzTKN5dlWmSDen1TVvN1lbGC
   10ldgUle39DOzbC11j6k8FkNju4dQBDr2Zal9hkF6SeCMFnp8mUChuzn7
   0shMB5DOnszKCVzx4fyAY7rsRw55L9skwR5lyrnsWappJc5sqrmB+Wrmm
   1KeTfP7LIFPD6JounFtmP8EKjKUXKg0dq/L+hZqAbrL05DU5IRnvKHurl
   w==;
X-CSE-ConnectionGUID: udTQlKICSMyvP/5KOi9bDg==
X-CSE-MsgGUID: mA/Ce4UnQE+4RpEYZZnsYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86538249"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86538249"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 02:21:35 -0700
X-CSE-ConnectionGUID: RNiuI47WS5OeBg6Pmq1tcQ==
X-CSE-MsgGUID: RBeNPuglQpmBcBM9hJoagA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="267198862"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 02:21:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 02:21:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 02:21:34 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 02:21:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLw2bplqC+ducT4li/LuZ62t4i7/NaV9Fc/0vx50sHZ+DgBgwagRbs30d4bQd/LTRTYHkvcklRDynYPyv3uFKLUHD9Hw5KMXgrhJpXheOdbqAes4YeF0WjMshByWlCK+ncuS1fMe19I7pzCHUVIogJJfNbZ5YBNJEnvPMaBVxg6mR3KVZsQ0XkJahDARW1mrtN1NHZoFUhg33hbpuZL6zK68jJNG9SeFcT9T14CuPEBxN3MNxwgACve62ssNHV1xVcmT66pwKFS901ZAjaycHsuk2z9EVz9J1CpLz/Kfmt0C4t0zKEAqHd0QDEwElv6A2dWnFCJ8ouAIaug/hvlSvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9JarZc3keDSowPrWhVDsLubxMrMwCEw2h40Gj+z+gU=;
 b=JlB2t9hU9bDx2yNFhfYOTxgOlwH5UVz33YLePVg8PQodiX9HMh/DLCJ2ApbBb5S6GMkt1OyzrJqvbFl9jOrjWZtZAx0OXcze0BAREGaGQsCidylpfOct16PDNfRMzmLcaVPhTh7Fj33XZ7Flq9BL8Oqg0/V0b3gb/IZpGbZosh4XZdzwR6+HWTV9pS1w0HZjPROKTV6NI6WKRvSR2lZ5uGo6Y9KkwPmNrAPuImZ3Y9ajkZg8Iaoejtwy3+4d8Bde+pCmVstFO4O29IeNukZBFnxwZvo4bsxEfWThzQwFi+8d079zWnpONsziU5/NYL57fN9A7Q/o9d9UcbGyXd5AVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by IA1PR11MB7810.namprd11.prod.outlook.com (2603:10b6:208:3f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 09:21:26 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 09:21:26 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: James Hilliard <james.hilliard1@gmail.com>, Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Heiko Stuebner
	<heiko@sntech.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mfd@lists.linux.dev" <mfd@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>
Subject: RE: [PATCH net-next v2 8/8] net: phy: add X-Powers AC200/AC300 EPHY
 driver
Thread-Topic: [PATCH net-next v2 8/8] net: phy: add X-Powers AC200/AC300 EPHY
 driver
Thread-Index: AQHdJIKJe1bkzfqw7EWZs7Wz2GNhjLaPZXmAgADXRICAAIPskA==
Date: Thu, 6 Aug 2026 09:21:26 +0000
Message-ID: <PH0PR11MB5902F56C72ED0C31020B277CF0D22@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260804-submit-acx00-of-dynamic-v1-v2-0-3eef49ff1d8c@gmail.com>
 <20260804-submit-acx00-of-dynamic-v1-v2-8-3eef49ff1d8c@gmail.com>
 <30bab755-3356-4d4a-a939-8488aa487874@lunn.ch>
 <CADvTj4r5y7ME1jb1OxnvjXoQRhpnQq1L=QgdUE7ESNgS2jzTBA@mail.gmail.com>
In-Reply-To: <CADvTj4r5y7ME1jb1OxnvjXoQRhpnQq1L=QgdUE7ESNgS2jzTBA@mail.gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|IA1PR11MB7810:EE_
x-ms-office365-filtering-correlation-id: ab470641-8dda-4489-a391-08def39c1747
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|38070700021|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: oy5U14sC40Bn3MDIkiaLyNt338Iqqo/DH+qD5zj+7b0/eal2nLFhsq1+jK+0/D7RKv/yJriV1udsH4b7+BBWLURaZob0/KWHRUAxUtin3RuxJqPIKao9mNS2M27FGCFXnkl3eX83um3qMllLZ/5XA32Bvj6aVeYeimfIFK314PeopnCnSnRyQPmQ4SzL40FefzYR5OBDXMYLrms+gc5BwbmWOJV6b9kXgreHfSlqtBkRkKrqsqMJhxYvz5fXSiCCr2LCxmt+IFX0YUm1nsQIFFNO6Vfd+9cWzTrmC0XIb/JC7IZTRxnmcDmv1uDlvVA7Ae2d2pbOjhc4iHrKkOF1L+X69cYnPOk+Fv5RAY4PmKqrhn8zM7rmMExZx82UhGROnv2HAay3nceMVeiMcI2v0jVlQAeRx2GDCD09ChRlxoOfE9vLOLJb1O9i1HFATFqqe1c3eijjAhh/25X486CO/qqalNOwcRtCCq1veXbKKRF5FTPy8zXaUPsyhdqy+N5YSSA81SZykjPjomBaDZw8j8MqH0OT84yk+PEsrXPX39Dcv+npzu0el6LFv07NJf+UwS7Wxz5N0ksUPICGxS6xAwA7pxQB2aTOIjbUViHWHPKeGIQciJsH7egdIPih8PuSeNACclBlH4GjKCxJ3+kRoraudIxJ6jJIDY51AbDO9p+NYouzRTYoO0mnYizz5gDe50A4+tFMqimuOXq66SpUbYMP4mr4tPSQO2tzPr7yMXk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0lXZk5KakdjNFV1VS9JbEhsZkZSRTlpZEMraXE4eTNpYjRoaTZhY3I0Zkh6?=
 =?utf-8?B?ay93cDNUZjd5YzhsRnkyWU92bG1WWHRZK3FnRGwxQzRHa2I3N05zMGJVR1l2?=
 =?utf-8?B?SEVFTVA5ODRJeGYzUTRoUE4ya1VCVEF5UHp5cFBoMUZjc3NTMmFMRmtaWDhH?=
 =?utf-8?B?L20zYXRTVFhVOVNHMlhzL3IwY1QyWmM1RnMycVM0dlNaVzJaWTY0Y0FUOThs?=
 =?utf-8?B?WE81Tk5XYjk3alFGOXF4bGxZOG12bHpQa096MHRaUlgvNzZUdDhPY1pUVmVE?=
 =?utf-8?B?NzZTcU1ZelFTVGNBdEtrZmtZbStaMm5tUGwwU3lzemQwTS95NTZOVnlYMTZK?=
 =?utf-8?B?UXdGM1F0c3I3WUFsMldiTDZGSlREREdPM1BTN2F3OE53RTlJNk5SQlQ4aVZY?=
 =?utf-8?B?TVluZWsxSUJmRElnZVhFUWFsTjhYcWdIV1RTTEw5WUxxRDZuQ1RtcnVnMUNE?=
 =?utf-8?B?emlnMkphaXFTQ0ptdTRDUklHSEx2V20zRTRPUVJSWW1mNGdockRtUENwWjgr?=
 =?utf-8?B?Zk9rUDdidG1Uam10cWc3Wjk1SWJnLzhzTlJvOTNwcXQ2OHRmTHdzUm8zTTdV?=
 =?utf-8?B?M3RTT3pxenY3UzhveGhUcTBDL3o1SStsOUJuWmhYbXJUVHJWcDZNQ1VXM2Zq?=
 =?utf-8?B?MTdXMHFyY3gyTW1XRms2RHN0NkFDMzF2cVprYVhlL3VieGd6OG4xa0tVdXpM?=
 =?utf-8?B?RXBTVDVOWnFFRFJZVHM0bU1kOFAxV2RKVjhFRzhzS0lHSU1mWWF0VGdtL2p5?=
 =?utf-8?B?eTN4NGdNN2ZEdEdHdEE2cGZNZXFKdy9mUlhRNC93aU53aHQ2Zm4xV1VmL2hH?=
 =?utf-8?B?YmFpVUV4UW9OS2lyOVFtTWdCRS9TYXgzcUgxbUV4dTFobVdxZTZ4b0JrZjhL?=
 =?utf-8?B?am9xT0k1TEZKVmd2V29VNWIyVHB3dmk0WWsvZmVWR0VpUlpsTTRPVHZUN2Zx?=
 =?utf-8?B?WUJJcTBaL2lWeDBGb3JpZWtkaHVBSm9lR3FXWGpucVVneEkvZ2ZVOFl2Tk5h?=
 =?utf-8?B?c09vRHJocnlwY3lFYm9wRnB3N0MzbVlsYVcwT3NMZ0tZUE5RNGtWVS9GYVZH?=
 =?utf-8?B?Z1lGQ0ZJVHdTWW9PSXJXNjRsamlyU1lHZmVEa0prczZNZlg5YTVpUzJUb2Zp?=
 =?utf-8?B?S2VnVHpYcW81N1hTeEY1eklDdGV5NmVKeVNTRzAzcEFBa3ZxM0NqZnYzcStv?=
 =?utf-8?B?QVg1TDdXRkM5KzJLam5JRkJiWm4rTFJTS3BuUmNUcktVUkZqT2g1TTZ1UVFx?=
 =?utf-8?B?bVNRNjZ0d25hT2xLdnh0eUFCb0IvUWJaVlMzODVoeWNOMGkrRUtPSFBEdkxG?=
 =?utf-8?B?V21tNTdjK2JLQjZUaGxGWkFncWtBNnNraVZ5NGZQYng2RTVuNFJhVEFEZmd0?=
 =?utf-8?B?T3JTTjNyMU5EbEdzV1F4emQzT216eXZMMVJ6emd2aUdJNFpRUEt0cG5zQ29a?=
 =?utf-8?B?SVQ2MDRoN2J0U0JhY1ZlVzYyT3d3OTFvREpqM0lwdWpJK3VZSXliQjVDTWdW?=
 =?utf-8?B?SW5Xb2FPVTBIYVV3L1N2NjRURGlTb1FqLzZSdDhnSjZaelNsQjVBOE5ZWmV3?=
 =?utf-8?B?Y3FYNVIvMTVORWxSSVdaS2U4M1NqenVUSG1ucU13YnNoQUF3Q2dYMHFLR1dN?=
 =?utf-8?B?Y3ZPSGNZRXU0MlRpOXBkb0M2T2VGTTFEQnZLMldpc3BsNHc4V1JDNExmZVZn?=
 =?utf-8?B?VGVxdFZwNXZETHl0WW9aWmlxdnVTcnB3aUI2b2NxdXRjNWczUzFpekRDb0Ri?=
 =?utf-8?B?OFVVbkFpeDI5dWgvRDlOMHExMzFaWTM2MDlueVEwTEpxZTF6RlpYVzVub1N6?=
 =?utf-8?B?ZzVhS0Q0L0NhK05FcU9FV0lZYU4wT3l5Zzhua0V5b1ZUY0hLQXhHTUREdmww?=
 =?utf-8?B?TE1mNnlYR2RicDIzSEkvQnV6YlNwbm91bXR3MUMxbHE3TitrQ2Nib3FkT1N4?=
 =?utf-8?B?RnpNYnNOeVpzTWNJTlRTY0NuTEd0LzYwTkRlVk0wSUNLcFhaMHdNZ1AzYWFG?=
 =?utf-8?B?d3YxbUk1WlhvdVZvZlNKUEo3NmF6bVQ0VFQ2bklBNk1mbFNrV3AwaHdIUVcz?=
 =?utf-8?B?REEvT01Fd2FSbHRtL0lMV2lYRDRyUjhYeWtPV2JWaEh4K1A0SFppTUhsdUdX?=
 =?utf-8?B?ZEVZRHFZZ2NLOUVTRFBjbDFjcmgzWG9LVCszNE04ZEhBNThsWDRRai9RRUFF?=
 =?utf-8?B?NUJzNXZlbk1pTWtUM29oU0ZoWkp3NElLUyswQVpkQlR6K0JFYnc0bldwN2hK?=
 =?utf-8?B?T2l6bFgwa29OTDl4dG1FL3ZZbnovL3d1bmNIV21mb2JaUTZsY1F4NFJtYmpn?=
 =?utf-8?B?OGpyV0Z5RzRDT1dJaWQ1SUtnSXhLNDNNUDJ5c3lqcFZ3L0pxcHFsQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aJ04zTZkfJgijLq8OBZxKiM2a62pysgIriqZk9ZVkufMFXZlCoVDmD/IvtfPjBrtuWZ49/QWJk+biCN2L+4GF1K9xeRbCuHqtjolzElv9AlZO6NQQ4CcyAV6ppU9hzWYQUs3rKFi9RhTmB5BCwlk7Skg9W7dadqzcO/sxE7JsWiMCaBpxkIMOe+GtBvstg6uf+Gp9Lv4dD7R/QoIG1L5KEtJX+2fCEUS8U7XnHUvHSE3nPB0MKcsQm/Sh4yTditExKOqqbvgg0ExzqKY6bylWtKRxFkrE6HRENBTakHbhfI9+8SK5pHyFrLSjzQrU+vi59PM+qTta98fGqFeu9PlAQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab470641-8dda-4489-a391-08def39c1747
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 09:21:26.3991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJLRy9a4ydmBWvpUw8zgyk1sIAF0Pg4qVsy6gCRHbPMGO3vhkgFuotfXug/P+8riRXeTOE9QUlrHSAvsVW4nk3DO3/C2mHne2fssQeGbyXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7810
X-OriginatorOrg: intel.com

RnJvbTogSmFtZXMgSGlsbGlhcmQgPGphbWVzLmhpbGxpYXJkMUBnbWFpbC5jb20+IA0KU2VudDog
V2VkbmVzZGF5LCBBdWd1c3QgNSwgMjAyNiA0OjI3IEFNDQoNCj5UaGUgQUMyMDAgYW5kIEFDMzAw
IE1ESU8gbGluayBlbmRwb2ludHMgcmVwb3J0IHRoZSBzYW1lIENsYXVzZSAyMg0KPmlkZW50aWZp
ZXIgYW5kIHVzZSBhIGNvbXBhdGlibGUgbGluay1zaWRlIHBhZ2VkIHJlZ2lzdGVyIGxheW91dC4g
VGhlaXINCj5pZGVudGlmaWNhdGlvbiByZWdpc3RlcnMgYXJlIGluYWNjZXNzaWJsZSB1bnRpbCBh
IHBhY2thZ2Utc3BlY2lmaWMNCj5jb250cm9sIHBhdGggcG93ZXJzIGFuZCBjb25maWd1cmVzIHRo
ZSBibG9jay4NCj4NCj5BZGQgYSBjb21tb24gUEhZIGRyaXZlciB3aGljaCBtYXRjaGVzIHRoZSBm
aXJtd2FyZS1wcm92aWRlZCBpZGVudGlmaWVyDQo+b25seSB3aGVuIHRoZSBub2RlIGFsc28gcmVm
ZXJlbmNlcyBvbmUgWC1Qb3dlcnMgY29udHJvbCBkZXZpY2UuIFZhbGlkYXRlDQo+dGhhdCByZWZl
cmVuY2UgYW5kIHRoZSBBQzMwMCBhZGRyZXNzIHJlbGF0aW9uc2hpcCwgZGVmZXIgdW50aWwgdGhl
DQo+cHJvdmlkZXIgaXMgYm91bmQsIGFuZCBjcmVhdGUgYSBtYW5hZ2VkIGRldmljZSBsaW5rIHRv
IHByb3RlY3QgaXRzDQo+bGlmZXRpbWUgYW5kIG9yZGVyIHRlYXJkb3duIGFuZCBwb3dlciBtYW5h
Z2VtZW50Lg0KPg0KPldoZW4gdGhlIG9wdGlvbmFsIHR3by1iaXQgU0lEIGNvbmZpZ3VyYXRpb24g
ZmllbGQgaXMgcHJlc2VudCwgdmVyaWZ5IHRoYXQNCj5pdHMgcGFja2FnZS1zZWxlY3RvciBiaXQg
YWdyZWVzIHdpdGggdGhlIGZpeGVkIGNvbnRyb2wgcmVmZXJlbmNlLiBVc2UgaXRzDQo+c2Vjb25k
IGJpdCB0byBzZWxlY3QgdGhlIEFDMzAwIGxvdy1jYWxpYnJhdGlvbiB0dW5pbmcgc2VxdWVuY2Uu
IE9taXR0aW5nDQo+dGhlIGZpZWxkIHNraXBzIHBhY2thZ2UgdmFsaWRhdGlvbiBhbmQgc2VsZWN0
cyB0aGUgbm9ybWFsIHNlcXVlbmNlLg0KPg0KPlBvd2VyIHRoZSBjb250cm9sIGJsb2NrIGluIHJl
c2V0LWRlZmF1bHQgTUlJIG1vZGUgZHVyaW5nIFBIWSBwcm9iZS4gT25jZQ0KPnRoZSBNQUMgc3Vw
cGxpZXMgcGh5ZGV2LT5pbnRlcmZhY2UsIHBhc3MgTUlJIG9yIFJNSUkgdG8gdGhlIHByb3ZpZGVy
DQo+YmVmb3JlIHRoZSBub3JtYWwgUEhZIHNvZnQgcmVzZXQuIFByb2dyYW0gdGhlIEFDMjAwIGxp
bmsgYWRkcmVzcyB0aHJvdWdoDQo+aXRzIHByb3ZpZGVyIGFuZCBsZXQgdGhlIEFDMzAwIHByb3Zp
ZGVyIHZhbGlkYXRlIGl0cyBzdHJhcHBlZCBhZGRyZXNzLg0KPg0KPkFwcGx5IHRoZSBjb21tb24g
dmVuZG9yIGFuYWxvZyBpbml0aWFsaXphdGlvbiwgd2l0aCB0aGUgcGFja2FnZS1zcGVjaWZpYw0K
Pm5vcm1hbCB2YWx1ZSBhbmQgdGhlIG9wdGlvbmFsIEFDMzAwIGxvdy1jYWxpYnJhdGlvbiBzZXF1
ZW5jZS4gU3VwcG9ydCB0aGUNCj5ib2FyZC1zZWxlY3RlZCB4TUlJIHJlY2VpdmUtY2xvY2sgaW52
ZXJzaW9uIGFuZCBsZWF2ZSBNREkvTURJLVggaW4gaXRzDQo+dmVuZG9yIGF1dG9tYXRpYyBtb2Rl
LiBEaXNhYmxlIHN0YW5kYXJkIGFuZCBJbnRlbGxpZ2VudCBFRUUgaW5pdGlhbGx5LA0KPnRoZW4g
cmVzdG9yZSBwaHlsaWIncyBzdGFuZGFyZCBFRUUgcG9saWN5IGFmdGVyIGxhdGVyIHJlc2V0cy4N
Cj4NCj5Qb3dlciB0aGUgcGFja2FnZSBjb250cm9sIGJsb2NrIGRvd24gd2l0aCB0aGUgUEhZIGFu
ZCByZXN0b3JlIHRoZSB2ZW5kb3INCj5jb25maWd1cmF0aW9uIG9uIHJlc3VtZS4gSWYgcG93ZXIt
b2ZmIGZhaWxzLCBhdHRlbXB0IHRvIHJlc3RvcmUgdGhlIFBIWQ0KPmJlZm9yZSByZXR1cm5pbmcg
dGhlIG9yaWdpbmFsIHN1c3BlbmQgZXJyb3IuDQo+DQo+U2lnbmVkLW9mZi1ieTogSmFtZXMgSGls
bGlhcmQgPGphbWVzLmhpbGxpYXJkMUBnbWFpbC5jb20+DQo+LS0tDQo+IGRyaXZlcnMvbmV0L3Bo
eS9LY29uZmlnICAgICAgICAgfCAgIDkgKw0KPiBkcml2ZXJzL25ldC9waHkvTWFrZWZpbGUgICAg
ICAgIHwgICAxICsNCj4gZHJpdmVycy9uZXQvcGh5L3hwb3dlcnMtYWN4MDAuYyB8IDU0NCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IDMgZmlsZXMgY2hhbmdlZCwg
NTU0IGluc2VydGlvbnMoKykNCj4NCg0KLi4uDQoNCj4rc3RhdGljIHN0cnVjdCBkZXZpY2UgKg0K
PithY3gwMF9lcGh5X2ZpbmRfc3VwcGxpZXIoc3RydWN0IGRldmljZV9ub2RlICpjb250cm9sLCBi
b29sIGlzX2FjMzAwKQ0KPit7DQo+KwlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2Ow0KPisJ
c3RydWN0IG1kaW9fZGV2aWNlICptZGlvZGV2Ow0KPisNCj4rCWlmIChpc19hYzMwMCkgew0KDQp0
d28gYXBwcm9hY2hlcyBhcmUgbWl4ZWQgbm93IC0gc3BlY2lmaWMgY2FsbGJhY2tzIGFuZCBhYzIw
MC8zMDAgY2hlY2tzLA0Kd2h5IG5vdCB0byBmdWxseSBzdGljayB0byBjYWxsYmFja3MNCg0KDQo+
KwkJbWRpb2RldiA9IG9mX21kaW9fZmluZF9kZXZpY2UoY29udHJvbCk7DQo+KwkJcmV0dXJuIG1k
aW9kZXYgPyAmbWRpb2Rldi0+ZGV2IDogTlVMTDsNCj4rCX0NCj4rDQo+KwlwZGV2ID0gb2ZfZmlu
ZF9kZXZpY2VfYnlfbm9kZShjb250cm9sKTsNCj4rCXJldHVybiBwZGV2ID8gJnBkZXYtPmRldiA6
IE5VTEw7DQo+K30NCj4rDQo+K3N0YXRpYyBpbnQgYWN4MDBfZXBoeV9nZXRfY29udHJvbChzdHJ1
Y3QgcGh5X2RldmljZSAqcGh5ZGV2LA0KPisJCQkJICBzdHJ1Y3QgYWN4MDBfZXBoeV9wcml2ICpw
cml2KQ0KPit7DQo+KwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGh5ZGV2LT5tZGlvLmRldjsNCj4r
CXN0cnVjdCBhY3gwMF9lcGh5X2NvbnRyb2wgKmNvbnRyb2w7DQo+KwlzdHJ1Y3QgZGV2aWNlX25v
ZGUgKmNvbnRyb2xfbm9kZTsNCj4rCXN0cnVjdCBkZXZpY2UgKnN1cHBsaWVyOw0KPisJc3RydWN0
IGRldmljZV9saW5rICpsaW5rOw0KPisJY29uc3QgY2hhciAqY29tcGF0aWJsZTsNCj4rCWNvbnN0
IGNoYXIgKnByb3BlcnR5Ow0KPisJYm9vbCBoYXNfYWMyMDA7DQo+Kwlib29sIGhhc19hYzMwMDsN
Cj4rCXUzMiBjb250cm9sX2FkZHI7DQo+Kwl1MzIgY29uZmlndXJhdGlvbiA9IDA7DQo+KwlpbnQg
cmV0Ow0KPisNCj4rCWhhc19hYzIwMCA9IG9mX3Byb3BlcnR5X3ByZXNlbnQoZGV2LT5vZl9ub2Rl
LA0KPisJCQkJCSJ4LXBvd2VycyxhYzIwMC1jb250cm9sIik7DQo+KwloYXNfYWMzMDAgPSBvZl9w
cm9wZXJ0eV9wcmVzZW50KGRldi0+b2Zfbm9kZSwNCj4rCQkJCQkieC1wb3dlcnMsYWMzMDAtY29u
dHJvbCIpOw0KPisJaWYgKGhhc19hYzIwMCA9PSBoYXNfYWMzMDApDQo+KwkJcmV0dXJuIGRldl9l
cnJfcHJvYmUoZGV2LCAtRUlOVkFMLA0KPisJCQkJICAgICAiZXhhY3RseSBvbmUgQUN4MDAgY29u
dHJvbCBpcyByZXF1aXJlZFxuIik7DQo+Kw0KPisJcHJpdi0+aXNfYWMzMDAgPSBoYXNfYWMzMDA7
DQoNCndvdWxkbid0IGVudW0gYmUgYSBiZXR0ZXIgY2hvaWNlIGhlcmU/IGVhc2llciBleHRlbmRp
bmcgZm9yIGZ1dHVyZQ0KcG9zc2libGUgYWM0MDAsNTAwIGV0YyANCmR1bm5vIHdoZXRoZXIgcGxh
bm5lZCBqdXN0IHRoaW5raW5nDQoNCj4rCXByb3BlcnR5ID0gaGFzX2FjMzAwID8gIngtcG93ZXJz
LGFjMzAwLWNvbnRyb2wiIDoNCj4rCQkJICAgICAgICJ4LXBvd2VycyxhYzIwMC1jb250cm9sIjsN
Cj4rCWNvbXBhdGlibGUgPSBoYXNfYWMzMDAgPyAieC1wb3dlcnMsYWMzMDAtZXBoeS1jdGwiIDoN
Cj4rCQkJCSAieC1wb3dlcnMsYWMyMDAtZXBoeS1jdGwiOw0KPisJY29udHJvbF9ub2RlID0gb2Zf
cGFyc2VfcGhhbmRsZShkZXYtPm9mX25vZGUsIHByb3BlcnR5LCAwKTsNCj4rCWlmICghY29udHJv
bF9ub2RlKQ0KPisJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgLUVJTlZBTCwgIm1pc3Npbmcg
JXNcbiIsIHByb3BlcnR5KTsNCj4rCWlmICghb2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUoY29udHJv
bF9ub2RlLCBjb21wYXRpYmxlKSkgew0KPisJCXJldCA9IGRldl9lcnJfcHJvYmUoZGV2LCAtRUlO
VkFMLA0KPisJCQkJICAgICIlcyBkb2VzIG5vdCByZWZlcmVuY2UgYSAlcyBkZXZpY2VcbiIsDQo+
KwkJCQkgICAgcHJvcGVydHksIGNvbXBhdGlibGUpOw0KPisJCWdvdG8gb3V0X3B1dF9ub2RlOw0K
PisJfQ0KPisJaWYgKCFvZl9kZXZpY2VfaXNfYXZhaWxhYmxlKGNvbnRyb2xfbm9kZSkpIHsNCj4r
CQlyZXQgPSBkZXZfZXJyX3Byb2JlKGRldiwgLUVJTlZBTCwNCj4rCQkJCSAgICAiJXMgcmVmZXJl
bmNlcyBhIGRpc2FibGVkIGRldmljZVxuIiwNCj4rCQkJCSAgICBwcm9wZXJ0eSk7DQo+KwkJZ290
byBvdXRfcHV0X25vZGU7DQo+Kwl9DQo+Kw0KPisJaWYgKGhhc19hYzMwMCkgew0KPisJCXJldCA9
IG9mX3Byb3BlcnR5X3JlYWRfdTMyKGNvbnRyb2xfbm9kZSwgInJlZyIsICZjb250cm9sX2FkZHIp
Ow0KPisJCWlmIChyZXQgfHwgY29udHJvbF9hZGRyICE9IHBoeWRldi0+bWRpby5hZGRyICsNCj4r
CQkJCQkgICAgICAgQUMzMDBfRVBIWV9DT05UUk9MX0FERFJfT0ZGU0VUKSB7DQo+KwkJCXJldCA9
IGRldl9lcnJfcHJvYmUoZGV2LCAtRUlOVkFMLA0KPisJCQkJCSAgICAiQUMzMDAgY29udHJvbCBh
ZGRyZXNzIGRvZXMgbm90IG1hdGNoIHJlZ1xuIik7DQo+KwkJCWdvdG8gb3V0X3B1dF9ub2RlOw0K
PisJCX0NCj4rCX0NCg0KDQo=
