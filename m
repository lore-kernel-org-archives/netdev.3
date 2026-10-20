Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792532763;
	b=vr7f+Zi1qEzCGqkwvODXOG0hE0OiAmSHp7q8zdhi0kfH3q2An6m+ZlD8HCK6AxKpHz31
	 mTT3r4yRXXtm682Xm/sFGroOlAc6FPxwyyiLoQF4EQZHVuc4QAl0lcRyWFPfC2TNOd2jl
	 nT+SWa9yQBniaIgde1GnZ2t0pdIdwQD1VeK7puo7HMbsfQkeK0WtfK9K7+CX4RBDfiG/H
	 YH9VVgG8Mk8YGGYM1zO9MklTzWNsorV6CQlS+mGY2pr9TQQ/vAyxTS+5RZPuLwwM05eYt
	 WS5mzqdvFq6ju/M4o7dafNECRsOp180fv8czb+I6tZQlUdyFe5xtsEcvxRISGXTFIrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532763;
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
	bh=ykwsq/iizuVY4D9WlpjEgUplGgtGjQ0Uk/A8reUHtfw=;
	b=4clxJf6waO/BQn4/CL4xj5k82z/oIsR5yUW/dIPLs8ODvBMEC/lt5nKdId3KcMEP2Bqf
	 BdE/WqzTUDqKSy3CyGRN/Nda0ylSraE0SEoO4PBt0vbkQZZVtk68vEm7UIyK6s0P7aGQ/
	 /YEKYTwfIQgIwq7uP8JdKyeugWbCE1Jaw9yiqWXZL4iU/EqSl3bxhADDyXhwXFwVJNGv2
	 AWBv563xD4YVqqVQsocei6vRg8KzMzYqa2oKtU5qZEzOa83LUfzyeayePvnhHB/K6ib32
	 fOxglkzffZ4g9CvclEJCUl+AT3BKVUv5RlGyiYd2rkfu1seNUAH5lMmtmzUIHmK0jYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PWvZ+y9+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6FC606A319;
	Tue, 20 Oct 2026 21:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E6FC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PWvZ+y9+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792532762; x=1824068762;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Y0/jWRBT+iIiILSr9ep2VT6r0YOylBYD/bnz8DZr5A=;
  b=PWvZ+y9+t8MU6HXjx+aNtTjyKx8ssweGxs12B5dT4pitLlaotEJVG9PH
   r/vzflNbVTJrfPjack40DGFqeRVdUBhA2ydgw7VzKNskIYjSOP9UKeB1p
   B7rFJUba2paH5059r70Rai7pJfxphd5LDgXQmDystu2NYxhGQp2lk8S4J
   5aoVAxzfTgjb/r7RpmCqzO2OUFBkKpCsLZfP796C2Y02oBm/lT9wcPERD
   aVaGwiHMco0FPJEpoqWnD5lMixucTyOwitLkStoAW4JwmGhZInjRyu1Mo
   Fyph30+LWR5GpqOE4wZp/oGVCFq8wT6zZqY40GeN1mD7pLEENYc2xvDMm
   A==;
X-CSE-ConnectionGUID: 8FTkK4vtQrWHhriWvNUvdQ==
X-CSE-MsgGUID: fy4TnOS1Q0u59+rrIio/Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1264608"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1264608"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 14:46:01 -0700
X-CSE-ConnectionGUID: QwrsfBapRjuL4djJZCupSA==
X-CSE-MsgGUID: QPsPs//7TTuXKDrB94X52g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="4747050"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 14:46:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 14:45:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 14:45:57 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 14:45:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/kRIY84z2M3Z45VEVZyCr2p9hX2tMa/0u58BcGMyzNIg96uMYAW1Ouu5bvvuE75y/18OwFlEiS7VFn5xIVJe4BuIJBJPnABlUOVRzBkBrrwqvWaESEI41zokYsPNFle1l8P4hYF+00qr6HJvbml3f25k7nnBTaA/mEPLzJy4iwrKpsVHOu1pFxEICoX2xiW4F5TGH0O4zy2I9SYImvF+MuySOI33kJvHeKCBj7Kb0qgilPR4L3PndjUp+z4QZzzWDZ0tku9O/WLM2ik6xr0mReqA6JFF/8j0LApnTpQ+emaDwQyG7pErt9OYUkZ+qVl0ZRTBBZk9WcvP+rdzYP3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykwsq/iizuVY4D9WlpjEgUplGgtGjQ0Uk/A8reUHtfw=;
 b=A5fNC07rHpVF2Lyvwriwqul5okq+FAyqVjsixjGW9vGyWuqjdTZaLaxyFe4k/YstFRX3nUHyoKUSOAvQGKnCbnGfrvimzHCSlUDw9XlN3BBx7/b/bIXOJnSA1B7K1U3KQkaxYyuwh2Ha9SuKUxc5c0bzi/GZnpdVpk5yo/+jYROzg49BHbDye1tG1rJCKouGbhAOHaqDoZnZLxFIO/oPaAEt/knPM4Lt8EvgHU9IvU/3f7kjgohGV9aJ46b69pZXvxnDKLvax8LMe6UNmt6YVPGl3cOnTW3utJcKMqy3ORhFCpAKkrcPFTg9+F6sjUcpyjvvBlqG7CDSs6DBcpxutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by SJ0PR11MB4800.namprd11.prod.outlook.com (2603:10b6:a03:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 21:45:48 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 21:45:47 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: Richard Patel <ripatel@wii.dev>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew@lunn.ch>, Steve Douthit
	<stephend@silicom-usa.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-net v2] ixgbe: fix MDIO bus lifetime
Thread-Topic: [PATCH iwl-net v2] ixgbe: fix MDIO bus lifetime
Thread-Index: AQHdPagySZ/X1hpHnU6qMjdiJzqVQ7cHPMHA
Date: Tue, 20 Oct 2026 21:45:47 +0000
Message-ID: <PH0PR11MB75221E49C22D15459F87503EA0672@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260906023319.1978945-1-ripatel@wii.dev>
In-Reply-To: <20260906023319.1978945-1-ripatel@wii.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|SJ0PR11MB4800:EE_
x-ms-office365-filtering-correlation-id: 1a968166-a3df-4e85-8dfb-08df2ef3809d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: NJfqNRCpIy4mbANCxTMdC5s0EiZo86e9y3/eTnAubtR8hAMi8TtKdmrrBumfrrQSICaOxlvhV8xL6sw8rEf706qr4/IK08VZjb3JTvBhARL7Azes9IuPgN233xbwyeIvc6dYfEi/Z6iEOQLH8804xB6WuYUGEHj+Q3FvMDYoP5JiniZ5jGiG2NLks2o/G97Th+omS7HMZpmLci/iXiK4neaMGJNUn8lYfTrVVZ1mg4Qlju4QZD0ZbmxFTtSKHMC2NO1DwjG1EE6yeO8ny4jkFt+NI1KSQ0fPjgDB+OWpco08CUuTLGRcEBQOZzFqnzQjKTeypltSq3sKlxWGSa1cxUMIhTC3ysX1lcClDVJLfwECXKfIjfXFsZi4c+O3eggz87emU67qb17bBmR9f5vBv6D2vJ+Axt68RIlXiOM9CzL3n0IRrVEvRk10P8qL4pNOSve4WBQ0oaSF61hdWSjDBbjlly3KeRoq073wTrPl03fGwiLr8mmNdWkK8JLMXYGkavru15wp2JyMmZTff0dSZtSvOwRIc8g8TWFh16u88/TK7KqChNIAJaG9I87WCZ4whO9gGoN0C+ysiNlN+KNAoEmrsLWWqm6pCrebY10xpl2iqKQPN44HukoFLux8C6PBtQys++Mi5qx72Dxe9KBKHrcEFYxeES0f5HsQYCYZ4PFPAhXUY4hRaUHL6XG9+ROG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3/6dWRjmOU7yMp0XWP2HepEg+FU1iU4iCfkSo/mg8Ehkz6KVrAI41u5t4dje?=
 =?us-ascii?Q?Lq0++I0153S0pCaUQzEm2xt5KTPzUWDQtAVCYXjPx/PQZztYrcIkYjnRZMmX?=
 =?us-ascii?Q?YwfF+qBTnyvMR+LI/OE5hUR89rWCzJTDukDCm7rMabcQlz8Kq1HNHWOLsDES?=
 =?us-ascii?Q?XnZk91wud9BLIKKc9y/z4LLKIR1ih3mVgc2oBZmx6lSDwM+R7hNcKqGbImjO?=
 =?us-ascii?Q?2OmwInD1D3AUfT+grC+EhLKPmImNXRwLkGmXzzEFDa7PqrEYEWmcIB1x5hyi?=
 =?us-ascii?Q?1oxC1yG+jCea8UsQFNr69UT+GNKEwcw2j1CezSmsz0wUrH6gBf8Jq5JNWd04?=
 =?us-ascii?Q?54Z6geeu+i3mF9ZlWK/Oy8GXOE3yxaM5Acuz1ugm6+0JvT0QNiQCzPd/C60h?=
 =?us-ascii?Q?J6suzoWnZ6ZGrmh33B8YZ8AuDC5O11jFyROJ/xeGm1GfijAu8BvK6K2alVFk?=
 =?us-ascii?Q?Cq+Q2GfKitNddQONGqTEOh3r+VeN3KIruvTq+Ev9XF+kGh6rc8hlp7wsPVDa?=
 =?us-ascii?Q?/TKB7pN2HqXNPjiR5i0DW5MNVj0R1+xKWiGwHI0b4ZspQuFNLU9C75QZpTB+?=
 =?us-ascii?Q?EUwH/bQ+iT7UtRV7VBKlDUl1Jv8LYTDhkDHCu2nAYyZwS4yL2JnrbIY4KQUb?=
 =?us-ascii?Q?NZwg/gXS9egMVdRDPKpN7+SvMXQtgpOuA6H3aflHxJNe1pWVpJ/T38RIN8Gb?=
 =?us-ascii?Q?iA/7acPNraZ//VjoQ5D9oosLPvLXDlOvjlM3oDBJdCP/6M/bxd5QV39RQY02?=
 =?us-ascii?Q?ByItW7txMuN8//s8M2+34cVyYPZVvdD8H+T8luVJ+DO9i6d+gYiPxDm3xGlt?=
 =?us-ascii?Q?eL3N4xiapxSgDnGVRIuhb1lMheCIWXvjlvfafhNE+3n3pl7l0XIG0rERYL+j?=
 =?us-ascii?Q?QB9voa0Hd79DuWr3ESNpZ5hvtVc642XNxb+3zY7y6BIdyNDtvhQPPi8jsxmc?=
 =?us-ascii?Q?pxIKsD0wIv0RGQQ0SS1YCqraxpaZMI74eDnMC8F/fg6G0yhxOjBmnLtidPzc?=
 =?us-ascii?Q?G0i0QOlkWrvpPRAG0oJxmxBd/8SUYo9hOBGL5fVQsFvtuoH1TWhlzdQnHMLM?=
 =?us-ascii?Q?ISfAIu4uV6qrEzk6JUe2HfevhOj5hDMoQKVOrrrLV+BZKi1BTp3rBAxKvTcD?=
 =?us-ascii?Q?VDgDnQFjEcWe+v5ogS/9JqI/2IpO3Y61jNJWeBbjOVZLFjd/KmcwJ6ay9V7W?=
 =?us-ascii?Q?/oTzjOvqdNbTUORws7P7T0X+IgXUeVMKrVaTwFM6nj6QPhZfImHa6QAkYXAV?=
 =?us-ascii?Q?qoatnJ66XxSW+Hcrz5k9aAEuwa6MwOfIIJsqCgJDvwTQtAQLSbQiIKt0Tqmd?=
 =?us-ascii?Q?1HAJafmB9G0mEShjLYFzgQ5l7Pk3mKw2OlFU9JPP2JjLklAqBw5p4OG87m1k?=
 =?us-ascii?Q?vrTWpCGI876Wpltt8mv46s8dIFJenQczohPl84rz3Jf2epU2v7v7JM9rO/Nf?=
 =?us-ascii?Q?0zsy/IDTusBiK7NDZ2oQU6L8YiPOiq9zd9SXjd7onwNE6tTdDg2rskBnlpku?=
 =?us-ascii?Q?rXtn3rzy+7Up9T5m+indynfTB/ZW0YgBeDn/k0mkm17/XOHFNhkcMOB2bsaI?=
 =?us-ascii?Q?HglYyp7cBJC46mgNhMClbmo4rVcnWtyzhZ6VQ2lfhjGGTxyXvawuaFe1rwVg?=
 =?us-ascii?Q?igRrxcXsMp8o+Zy+BoNgvk2kdZ57AOJThqS7ONybMzMAAkaUssIo7Fp4NFc0?=
 =?us-ascii?Q?0VtPGXJfQI8slP+OM6862IHY39i0EsPU8RKbHY91zPC8n11CORn9re9aToyS?=
 =?us-ascii?Q?vwjt+C20sg=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: nvy/5tRpcykH9DA8u5Iwtl1XqawFCJzWQM/24WoC7OcnzkZMIhUVdTSnzVFntwUUki2wkFM6IgEoSoQjeqQHw1MaaJIS194rEi4WeVVfDdtWR+qzTrgKJtIFpuw1lo9I4KcDIXTfebFuo0aDDF0Tkf/f+AsgDuVaLczWF211TLzEFn4o4Mdbl7i/GOwZZ1Ql992PptSAfOYXZJpRaWCZFQPWoddbEsG98K7gE/tx6enrJ2fWut3p8xURj6ARGhfHL5Hqrpv9snpHRVrYSLr9+EHGihU+zYE2nlD3qriXjBQTDm62p1TqrkLo/Xk5/N+lPu9oyy9JPBA/s5gw3UYu4g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a968166-a3df-4e85-8dfb-08df2ef3809d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 21:45:47.9040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICnJrKrg9+HNjjYghwKrMevq+g4nxcTjhNkKr1sb9rDCXPNqiZyef7inTpbFL0rGWyQz/YmZyS1DsdGC5t3zMsmBFsrz+LU29GQHLbYTNwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4800
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Richard Patel <ripatel@wii.dev>=20
> Sent: Saturday, September 5, 2026 7:33 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew@lunn.ch>; Steve Douthit =
<stephend@silicom-usa.com>; netdev@vger.kernel.org; linux-kernel@vger.kerne=
l.org; > Richard Patel <ripatel@wii.dev>
> Subject: [PATCH iwl-net v2] ixgbe: fix MDIO bus lifetime
>
> Plugging in an unsupported SFP module caused ixgbe NICs to get
> wedged permanently.
>
> ixgbe unregisters the netdev when rejecting an SFP transceiver as
> unsupported.
>
>   ixgbe 0000:3b:00.0: failed to initialize because an unsupported SFP+ mo=
dule type was detected.
>   ixgbe 0000:3b:00.0: Reload the driver after installing a supported modu=
le.
>   ixgbe 0000:3b:00.0: removed PHC on enp59s0
>
> This code path failed to unregister an MDIO bus owned by that
> netdev, so when unregister_netdev() tries to tear it down
> (via device_del() -> devres_release_all() -> mdiobus_free()),
> it trips over the leaked registration.
>
>   ixgbe-mdio-0000:3b:00.0: not in UNREGISTERED state
>   WARNING: drivers/net/phy/mdio_bus_provider.c:711 at mdiobus_free+0x3d/0=
x50, CPU#21: kworker/u128:0/12
>
> This prevents ixgbe from reloading, even after PCIe remove/rescan:
>
>   sysfs: cannot create duplicate filename '/class/mdio_bus/ixgbe-mdio-000=
0:3b:00.0'
>
> Switch to devm_mdiobus_register(), drop custom unregister calls.
> This is safe because the bus is already devm-allocated, so unregister
> always happens before free.
>
> Assisted-by: LLM
> Fixes: 8fa10ef01260 ("ixgbe: register a mdiobus")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Richard Patel <ripatel@wii.dev>
> ---
> v1 -> v2: use devm_mdiobus_register() instead of another
>           mdiobus_unregister() call
> v1: https://lore.kernel.org/netdev/20260826042945.2344686-1-ripatel@wii.d=
ev/
>
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 ++-------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 2 +-
>  2 files changed, 3 insertions(+), 8 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
