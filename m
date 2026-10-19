Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6A13BFAEB;
	Mon, 19 Oct 2026 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409319; cv=fail; b=MWLgy9TUcxeCLSDG591MlhIJ0TIxlOKtLyOQmpBrSRYhy/ecAd2P7tgvoPtZrXZvR2kSqltAcuxeQQk9493QxLAY+oo5L7yL/EVR2xrjZnc494vOjJ4muwvNcM0SvolXZD+iouicLIM29bouIftQZ/LY5VgO4wu4FK7KzMI9KVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409319; c=relaxed/simple;
	bh=bGXJIyH0twufEnL9XrXpNqQOD8vU1QnqcS88Go/zvlQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QqlC80F2kc0SLsApKDUNnVvAgsngoRtcjTadJlXiorJM2PrWyBKi3Xov7vlimETRgIejIFp5PS7/Uu6owY7xRh6PtNCTEewC1PFIKHo661aDOFGo9F95VU6QwqbLVA4X27d/Pff65GYc9/XD/5IWgupQxj10A0oHTyfBQ7RA0lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVfGllJU; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVfGllJU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792409313; x=1823945313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bGXJIyH0twufEnL9XrXpNqQOD8vU1QnqcS88Go/zvlQ=;
  b=hVfGllJUEwc+ZQf0hjqIAA3047CkHtX7Dhda4uoNOgJYubWWr0RpUZO4
   hmSOSt4pH6ZUIZGtZJ+bCywfTeuV3ucQ1eup12lceSnnLhVnXWBIVubP5
   XSAvod53UMW5+mVgIVzZE8mnsdPT/LHtDr8eMOMmsePjRVXAnz612P0aK
   QdsLHFkR2/lETmd0fmStCafGMOjeZ6eF3WxEhmqXWCZcPebm3ty73t/a2
   j62T1t4GpkGGa9Kj5Ra3qAKhjwtYARvsRreUXEhMaPE8RXyjm992BNHUS
   bVX+mTWZcZgWZHev3x/7pD4o7FnXgUnqQWt2N3iUmVg35eXAb9BEGeDwQ
   Q==;
X-CSE-ConnectionGUID: CeLoSEH/T92OGCv8fAec3w==
X-CSE-MsgGUID: wwMRrYpmRi6rE1kzwCnPsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1082698"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1082698"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:28:32 -0700
X-CSE-ConnectionGUID: Ejvp90OjR6+gqNrb7gIjbA==
X-CSE-MsgGUID: 5zVr3QALS4CaTMEWznrYHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2489949"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:28:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:28:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 04:28:30 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:28:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRLrbI9QdRXjXVQPtZ0stVzlEY3WO5r++Dnovt57/f9J1IWaSztP8RfXBbx/iVmFJNNdyYDmB+23Agz0UuwaPzz1Y8DgIfZCX0jIze2Gi4cDF6ErmfISdyC+W8PdQbSiJlA8q29C4y/Wh04W/zjL8Bshc4agW5wTEi0SRoH2y0mS2g/B9hZFvZ+P1SKALPnlinQjZqz0mN5VRbRbG2vhzW5G+M4jTK5oNC5MjWJVnT3m4QK5wjZ/ndH0JavSBcuRg8wX55hrJEu/tuiJte773gVRXeoFy+T4IZvSQ5Nk2CHEo+iq2C2PQAcRMv4kxWqjuYS2g31V1DbCJshEsYbRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGXJIyH0twufEnL9XrXpNqQOD8vU1QnqcS88Go/zvlQ=;
 b=Cp1YCOTkdW4P9RmtPJxWTopMUu+cYDteI9DcmodCOqqQHLVntc1a3Ap8x6oVkIHjS9a8uZXYrpKbomkTP7GMmkhrSZqh4Bp1sVCq6B8c863FJHR6y2vBhP8y1wJYn2jeMFurtjLskWUU4sWq7rzT4gVt3cJPem6nhR327QoB3+HI471mtHHslRuhglPzczkPbnBhApb0Ij2xMvIL1CZJkv/t634QcvEwUjnJsgpxHHM2HtwHNISQI0HfCQzZrNh806h5kENWHG1XiLHR/tQXNoY5hNG4cHxPBwVOfiLmG8OsevJRkj/uHF+fNrQniMGMPojxH5ZhHLVPk6tyBW3dRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 19 Oct
 2026 11:28:27 +0000
Received: from MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b]) by MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:28:27 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
To: Aaron Ma <aaron.ma@canonical.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Richard Cochran
	<richardcochran@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley
	<brett.creeley@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH 1/5] ice: check the full PF reset polling limit
Thread-Topic: [PATCH 1/5] ice: check the full PF reset polling limit
Thread-Index: AQHdX7gIe+QzE7pjy02c7wi+M1jgD7cEujpg
Date: Mon, 19 Oct 2026 11:28:27 +0000
Message-ID: <MW4PR11MB6864B28EF48A22FC7256FBD380982@MW4PR11MB6864.namprd11.prod.outlook.com>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-2-aaron.ma@canonical.com>
In-Reply-To: <20261019105155.3793063-2-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6864:EE_|IA1PR11MB7295:EE_
x-ms-office365-filtering-correlation-id: 873c2bfb-56f4-438f-fc4a-08df2dd41866
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|10067099003|38070700021|11063799006|4143699003|921020|21046099003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: 1b2nCB8k2GyOjtpDF5rEgXwqpZcyCwXhwswWZcBetwEDRqsMNHFOSScIpd93wt5duB3qfV6OAyRXJdSpTSpyhYwMqOJ6zncm3vf3cf6uelKj7x6NyPpKnR64+SqNjBrlU8wYBYK2cwa0Yi6pYRHkP8NRQ8Q+nNDQzPNAeb/bXIqpMIBx/wp+jVzKFc+YupXEa9rSemVsfej/kZzn9DqVo8D6KBTXbZq9BhE8sjYBoh/6U8ZEf8tdoZLhBXbzfdBkEfXu/QrJy4B+OKY+CQfY5bBqEsUL1VsKkyB+6d5LAHXYGEJpoO7VHLfiaBWmFEUtvFZ4HhPo6POmafizdzUEsa4lddZryAOafYD9YbYyf/brCEwWFzkZ6gAebnJTyXxBCutltH24dC7M9dtWa4y4f7jvKAr89H8WP0vj8hWLSyFpOvXFIkpzf4N5O+1E9gXd7V9OQJdi46uty1gQ7bAlYOgb44Yzj+YoCTnCFhCwlSW/Bs48Exc8Zl/QgIrHn8BrfECOXE4PF8AWrOmPAE/2yV/VeOgVQwBpR7VUO6zQ/VABhm5EoPzPKvz8fqa5GwQnQ+y0TLR/EO59o1cof8Z526+DTlQ35ZCja91Ho+8eC5gfv8m5na5aNF/q0a08WJzaBeAGUN3GwwCrYT0JzPq8j83N0H/9RUUYVIcxEpr8KPQFpQCgu2T4AMi+IudFJWZxPdYsz8Jr0yvBNGrlwLRfdNWQmjM2Xubrp1LQUU94QlXI6hkVXMbTLYR1fENbHCsU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6864.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(10067099003)(38070700021)(11063799006)(4143699003)(921020)(21046099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mX39BRrCFeiCNwxQWPYy3711LWN6re2hCKNqrEBjIVx3gS6OpX77kGllXDlH?=
 =?us-ascii?Q?v8o2pc7S84D1raMIfmAJq0xlZUb+tnKnm8dOdPhiM9syj4jRUMygNFpmq4Zb?=
 =?us-ascii?Q?VsHt8dOXCGX3jrByz56xjjapeDVrP7g0FAmyP7iPUZCFuCNcc3ZzGrClEvKm?=
 =?us-ascii?Q?M1W6oXEF90OOt+bLo6bqpfRIipbDWpKcJNrosCF6o8fbQPFmwkAHsvg3Q7K/?=
 =?us-ascii?Q?NuxTIjMaUHxQyWU77J6elMYMeuFw0dj/PFZMSIPbGCcrj9cMXm4/UnZXsBP3?=
 =?us-ascii?Q?6XDq8VrQdr5ffzvK3VC/OyQjpmRsq9cgKdH/KhZu0dTWPNmZe4XA1aXUkFeL?=
 =?us-ascii?Q?TUmeBi8xQrVGlHBZvTUFrfzm8ceUKYeFc9brML4M3488aLWV2hsd4ThYLL6G?=
 =?us-ascii?Q?DK0wMqoX2cKBbah7HPdiG1Ju9U516Sw1jJPP6oKh3tfMEMo4sR7NAcjxEF0k?=
 =?us-ascii?Q?l96dvOEpaV7gzGcyCV/D6P6bTPNcTrW4ZRx5vcNGcOhGy/Q2+VEvWx4KCrdO?=
 =?us-ascii?Q?a91sUZBeOd7Y0dkOyupOM6n8g/OxP0uj5iDEcR6c6tLgk5u8s7rk8/wCNSZd?=
 =?us-ascii?Q?W2lDMQSE0xG5E0/c3yywoUxGkuQwJzAxPai+jQPGA0tuFjyn7ZXFcjEMMapG?=
 =?us-ascii?Q?vtAdaabzwumFgENS9cAieRxMASQa2pTSY2GVRf8cHzbDhxmzR4zlOBFUNtLR?=
 =?us-ascii?Q?acT3KMLIxOwcenc6lI5gh/EW3vn8VAAREmhsSLf0FjWHXTsqbrWsAhUhaS+W?=
 =?us-ascii?Q?eQCA/+VJNHnsFTQxpL/uXE+yZ5dssXjpw1bFtQ15x5+DBMsl+XZ64d1nuDFP?=
 =?us-ascii?Q?4TJvo6hvqxAoS4bokglVVwyATF+W+2MwZHGkI+Oi84A+TqIDTvP5Y5ixjefJ?=
 =?us-ascii?Q?Pjv4cDIRYaJHmdgKWWGDFM4k36LKU/pT6X8ngEoYPnrnDM58bIKmXv9E+er+?=
 =?us-ascii?Q?0doQtTPfiFEDW/181B4M61WsLuW0oraiey55aehesT5pC1xT0u5kaBd5vNz1?=
 =?us-ascii?Q?FbzU2maUr/MMfN7yAhi81Lj74T9FajMaI8cqHX+KjaJtw58Yiqaenrd9uY3M?=
 =?us-ascii?Q?4ppNaWKTxB+QTWCfI321vWRb8uwsU9evD6fiaK8KwPWtlK6QJE/3WiYjO1kg?=
 =?us-ascii?Q?yiyQh0Uuv+UEMCeOLQSp2FrvyoyDSnNxg6RYVtpWaJDKoh1EaugXk1rYBW7m?=
 =?us-ascii?Q?yoZ8x831YcNMghj5egA5mgArTxiIDBeNAqC3JZTAuE11u7U4+UHO/wHk9JaV?=
 =?us-ascii?Q?mLhnF3RxHQ1RZhHA+3ziBrYMhT7zbqLxJVXXjqf5gjQTJ7Ukx9+m5jigHIiQ?=
 =?us-ascii?Q?jXzNWrU5HTYWllvZELcTRxLw65KfGYNprhr/VMPNVE5s1c9PncYi7qOiOxMt?=
 =?us-ascii?Q?hsLoHTSGLRSLiFuVptQQNm0/kMh/U1QyiAbokaylEKa0H5Dty+JuY0vhO0M7?=
 =?us-ascii?Q?y3g6HQA/7zjDdg5apYa9e9rWh+bkn5/wexAaP/l8goE5JV+czhUcM/BRv6vl?=
 =?us-ascii?Q?VFzP/Q2oJStXFGVr1XdxtPYWok3LuOzyBwRxY4I1JZA1yIwirA1To0nW9qsB?=
 =?us-ascii?Q?phX7lCTXDeUTwXR6WFPjkuR91aooz0y8J/9ATSJPGfLiPKMHbqAT+XxgGwjW?=
 =?us-ascii?Q?sFOfeiWQCJkkmL7ZFKKXiDuGMfLYldeD6bO9ta/MWYhxZYF4pj/MTR6xPmCc?=
 =?us-ascii?Q?rufY4sTYKSUamr4QT3xj91z5FwTgmTPsDFj9/CVyXMiU8XuY6xlQc2bUfOaa?=
 =?us-ascii?Q?ibF+Gcl1KS8O3nR1p2xP0OX2Zfgjr6c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nok6gMn4FNnEjyYIGHJGYdAJIojblAcfylAk4Z5tc6F7TbA3IO8bkWIJfFZQufzEe3imaUIIA9f1Jh6XeNTXnT0u8byY5qSffHzYvuQGuEPyPHxaUyzD6qJsUuF0UpU5XB8imDaCmG1kshcVJruzYJe3Fe+VfqCNyzrW0GroK1B51Arcmz1Eq7TyBMT1TPNM3ApmpApNV7qVvhzWFtP1fZN66e8WDVlozTU3HNjQUwjCsls69dBVj6WKDJe6RDNeA6WjY1U2qy96v0pg5VtDLAjKJvw51uWD0VoDlPwvaYkAQpJSXy6qVMo3LBRd0tBU3bjSNXJbW8Ebw3cMX4Bdug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6864.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873c2bfb-56f4-438f-fc4a-08df2dd41866
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 11:28:27.5277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0FyMIGe1hLsm/X6/6LckijKkj+se7DxE3dIIcj4g4Qgr8N/5RTNkQFBaapmNz9C/KJ9Sr+xZtRQV4zmKTx/LwL8aYJT9gQg8jXcV2SowSqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Aaron Ma <aaron.ma@canonical.com>
> Sent: Monday, October 19, 2026 12:52 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Lobakin, Aleksander <aleksander.lobakin@intel.com>;
> Richard Cochran <richardcochran@gmail.com>; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: Dan Nowlin <dan.nowlin@intel.com>; Brett Creeley
> <brett.creeley@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> moderated list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>
> Subject: [PATCH 1/5] ice: check the full PF reset polling limit
...

Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
