Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593572DA75A;
	Fri, 18 Sep 2026 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700775; cv=fail; b=R2hrlr1NN4aoNlo0yI1EaQoP8Mt8BgvQbqJ5L1LQYlkUf9ZJTdtnF8fdau/Ih8fyoSFxCFi+9aLx+mD9gb3zymfzmd2ZUmLQnDQd7BwRpOktZlcLqhs+yqaJ2iYK3Yect5obZFMMnK1Lhhv4yRV7WfkRqrqW+eTPQfXiUOkXKN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700775; c=relaxed/simple;
	bh=+Sx8+BZhD0ymQJDbcRFQRYR8zIOmkNfIgiMcYXDfgMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mfpBmwL0LoTSRrZg1OlLLilss9pBn1VzMyxMryfdGtpZju105jduB3LwDE95EIoyw2+9Mexg8tCiCpNItioNIVVWpgseD5t1bnyRG4rkkushIqCP43EK1P1Hz+zRBat7jT/vOVMXD/JZJm2ZGPxJGKioDZknp+g1/U+qwjocZOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOGURVSf; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOGURVSf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789700772; x=1821236772;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Sx8+BZhD0ymQJDbcRFQRYR8zIOmkNfIgiMcYXDfgMI=;
  b=DOGURVSfvSgzaSuOl45quX1nBo8xvGMM+MuaMB4MI8mSErAiTZ0LCVv7
   l6B0sDDVBTx+2/O03zSrrTp5X7Hrkq+5BHnlmPlOwcjC0i1hkIGjzdbQG
   y9QEv6o3Efr+tLN5mb7zPAJju8FPmIZhfaReN4LOZft8tyBrEJMYXWPfR
   5ICAIban7+NNPLOGW/9kIEgT6w0bHRfJJpfMLcEsC8bxLhO2ods+ZzEkV
   jmExewMebj0f1c3iWxKW8wRAoJ+Oj73GyEJ7IvX8Kc9nIsfUGs7/QXrei
   o4MKnTRLeeKabAH9fVZXE0ggXFN7Bp3HyNy3Z0GyBqBhQwzLbAilLYRlt
   w==;
X-CSE-ConnectionGUID: qrQKo7sHTjmr4BISN7UT/w==
X-CSE-MsgGUID: J76UGTtqT7ubRistuBndcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107684438"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107684438"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 20:06:10 -0700
X-CSE-ConnectionGUID: mgVCKRk5QM2wbeHWFmEwgg==
X-CSE-MsgGUID: 0hJyONJKT/i51wWJHFjUwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="279390121"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 20:06:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 20:06:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 20:06:10 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.66)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 20:06:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIsZdKTWN1ySVlt5szfawU0OdoQKfgY1YClWJNagI0kHFr8o77237ebdBnS4cChmQdmjZObULdXc07RCDlwj3K5DXU3aKUAYAA6smkERFG5MKperr/TCtPg9tDNySQQJuYH2w8nMw5NekBLYBZFOaOg5OK7VH1Ac4mZKoCMoyiis11BGgW3nTOOt5lxNfeGshij3WZ2AjlXN8Xt6njTXfnziLG7BEIoejTTY1D3D9pSkKz+LNcjx5ajv4peTfPlzfUV/Uh9uBVuR0Z+7y/WBnrYrhv1alGWxrrc6aUjGABGPtRkasKzzhKK0fkrDe0pxupo50/bs/fpGkQ00L9cdrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVw8cb/tsGNN+p2qwHqXz/PuQz86ffPJX7+Rs/81eWM=;
 b=Hq+A2SbUFlCQxmLWcCCKu6ZpdPBfxK/thIeWazm+ppatxIUySZp1ZSPvxZdf4+GhChEzDZwkI3WzmGYpiUFeMMMipSrV3vf0mZjwQT0WTNfAJft1m4CgyDQmkjUsD2uXb/v7JBivELgljKK0hPbDgBgIcQkFNAedOK/tnxFjUu/JpRL18HB+sS0ssKXuMOT9lC3rEmrMk6Kl4a0yNuE6Yo97/98dVUf5W0mMEs1JbtIf3ojRYf8nnwSZxwa5IlfgeHTssqnEenvOpyw7ufDH/2TZ3byyXxCHpIGYCcJpVamvItlsbrRMBOXoDWpZ5ZU18+p9A5k4Dn6ahbs7oc06sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SJ5PPF20F246184.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::819) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Fri, 18 Sep
 2026 03:06:05 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:06:05 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Bryan Fraschetti <bryan.fraschetti@canonical.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alice Michael
	<alice.michael@intel.com>, "Greenwalt, Paul" <paul.greenwalt@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl] ice: Restore Ordered MMIO Writes
 for Tx Doorbells
Thread-Topic: [Intel-wired-lan] [PATCH iwl] ice: Restore Ordered MMIO Writes
 for Tx Doorbells
Thread-Index: AQHdI13y94FVfZvt0U+Z4nEb2syAZLbT7mIw
Date: Fri, 18 Sep 2026 03:06:05 +0000
Message-ID: <LV1PR11MB8790DE56DD18C8806022C2C490872@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260803152854.305298-1-bryan.fraschetti@canonical.com>
In-Reply-To: <20260803152854.305298-1-bryan.fraschetti@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SJ5PPF20F246184:EE_
x-ms-office365-filtering-correlation-id: 5b8528f4-0c3e-4006-6337-08df1531c748
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|38070700021|921020|3023799007|6133799003|18002099003|10067099003|5023799004|56012099006|11063799006|22082099003;
x-microsoft-antispam-message-info: ghGUX3NGCWV8oe/WJglmyky+PZQVHtaRHZrK4QPHrNInbtvYFveEY/tUqCHMU1bjyBhr0C2okeONahnF+wAxhyDDnMKSJYrBd1UnJVFZ3PHXCJfGmKP8RevB33xwcVm5s8oEq+qrHCauexzdeN04aMOpRkhTVOVWmWRF09yIT2UwL48WsSrW4F7Xu1+mDUWpbYIOmTQcoI4z7kWR7+aRC7eXZu2TnB6aboMDG8d0oI3YCFKvzySfnxnUMHBouEgB5yFqhNjwGMaCE47oO0tIhKbmT7ACMiKA4fwXOpIyGACAmHYkTnBI3A3nuphJDOwLR0he9pyhY30SYFmVVkDBZW9tVnRF2JkoaAtfyaCjEk04hLPOtZTbe6HeJgIO8fvtw5PUqGvnA5oB29G/PHeiLMW6YjI24EKqOhYFPFa/FZZFUR/ivA+QEHwSpN5ElgiOG9b6KJYNM50br/ZYrCtF8Jpncy2wnh6td1cx1QNZ2lO+U/L51B25QIlybt3lGoWXPW1SwfVY+x8aeLfdXjWxBSKB2CUqc6PxIvyZ3/bRhHK1jL1k41OzrKBPjR3JItZcdbvSjU96exdHglHibFzThRgV97wqXxMnxOGfqWXM3Sgpk1dnI8X1fD3luDP4ouMaG0k0oOfQMc0VM0sjMMbgURscvraSRHw07pzky+/hdzcoKeJZkVfmJ1vn2W2Gqz5V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(921020)(3023799007)(6133799003)(18002099003)(10067099003)(5023799004)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W/sHylY6ZLnPTuNmbUdEuE8OwA7t6e90KsnwqqqiuFUF3Pcxc6RcagsctPhc?=
 =?us-ascii?Q?g3eqnlkIj6tel8sOtLjTZAPylxbTsyQ94NewhL3uWd/w0y2I0LhWfVCsJ0KN?=
 =?us-ascii?Q?C9ZmNviH7i/VqUSOnKGtAfQRhtR+KNtFeCSn5JJbKCUWTBJZuZRmALVUd30t?=
 =?us-ascii?Q?W1eBz62xw4byAYW2uUyGUCp0SGD3wFEV/OxOwkO1v6VDMcFu9eMcWGg0sXmP?=
 =?us-ascii?Q?yq9kJAWgxKCbR9ZoF+6zFknlfrC+uoMI543uUGzXZyWrQ3WiB4NDVESwqqnd?=
 =?us-ascii?Q?bzypyzHwIg5lUluEpcOQ1NLEEd8t1s6i2JAnZjxVpLHhDhKUxeu/luTC5ySV?=
 =?us-ascii?Q?y/3yidUCkfIrJZOB3BNEIft3Q6CovYGkpjkDc+zqfbzqnmarGGvnAc5w3pI+?=
 =?us-ascii?Q?1K7USuC0zpNm2JADADOjCPZEskKMD/E6kQePVSzVd/b/mvRP474TNtJ/kshk?=
 =?us-ascii?Q?jt5gD+1cRWVRqYWZeOwVmwrutxudjH7rZ/D1+iSkuCh8scO1YSnIZaKixrkC?=
 =?us-ascii?Q?WO+KPhHLd9i0ZTKjdQTArDDdl2xPyhaWlyyj6iJX9APTHyrJcMosa4oVAfg5?=
 =?us-ascii?Q?Vg53tIXRrnVDSGcM5Ryc4uezf7t7Lv3nD3pFMeYgMAukndBVODiJ+RaFave/?=
 =?us-ascii?Q?dTmWNQzqmBjHemjTruIbU2x3LxbSMlRARSJ8otvVg0ev8ZCNhxtrLDyGLiue?=
 =?us-ascii?Q?xr/iMHCF+deN1k+ChTJvMThET2x17gLaUtm1TLOO9e6CMh7BkSre70yrRs02?=
 =?us-ascii?Q?oLEYM5J4/0NbkWH8DyUEdEPmECUy0B5G9m59xanh1E1hb4cUtyQjpE+mLLN2?=
 =?us-ascii?Q?1ZXf8on6JtigAllwSMZk6RQTV0z0HBx+iRMqHR9DoKZRxyW0d9rBEoFfytRx?=
 =?us-ascii?Q?iqlUzmpg4SssbL8RrbAKknaAo+uBsoyiqcnMmgdWb8uicMASdcVwuAYY8Zho?=
 =?us-ascii?Q?bHsjEfw1bpaS6UUHELbx78UzJ9SnjqF1G6cbOBekR+zNWd64gP7AqoDRaQT0?=
 =?us-ascii?Q?JT0FjIvAaSxnSFkQ9SEZsgZj3wZgA5kOQuJBRXVSmZQWP4TLaHoq17xggOsW?=
 =?us-ascii?Q?A+qPppRtQuVFVK3Ooc5Fyzbc7r7A/B5SoKbFpdMlqY9wcDXXT7467fuWtyVv?=
 =?us-ascii?Q?hOnIvP/EQAG3nSohU+HkXocIv26qcVqkRFH9y28jm1cLWDF+kgCvA5H1dUf6?=
 =?us-ascii?Q?hE8Wq+DH//RisEiAwEZa6IVetnjoSxwaJcOvr/A5t6CxHE3D+/HGK7oshudH?=
 =?us-ascii?Q?CU5CEQY7ccD78TpopafNX7KMlNyFNFxm1D8niofkvpgtjeDDz/+MMmdeGI1Z?=
 =?us-ascii?Q?gVJpftLddKUCwmlxGthTqb9TYi1EOJlhVHDp1wab7S/tGl9E6CYLJwohH74x?=
 =?us-ascii?Q?IeaORq2sjqq7GLvMnCIiuprM9/5xRBgI/gS1x4jUxvYpDLMECIePyKbsVzcC?=
 =?us-ascii?Q?hvf+b18YrWjwveYkojkJBfkuxUZU7fF4ylruYex8ckVVHgTy95v//+ZY8C0x?=
 =?us-ascii?Q?kh2mhyyDeBPPT7EBVi1yMGdenB8dbATEgLoXhbsgh4H1XIMbQT36NHIZIJKH?=
 =?us-ascii?Q?3G5Lly2qa2nDwYbEZmPQOdPpvhbsV9W6SWgVOqGQqlX4OV6ZR/dUK/5hd7rH?=
 =?us-ascii?Q?h2hX1HD9OYmFpBkZk/0k1JpEg1qWyOvblBaV26SSCR5u2mkze4AGM7slSQfw?=
 =?us-ascii?Q?f3cTioRx0ZE0EBZYwbPkqLeRBS+5sN8nNg6IjGoP0HmnpzfNAGU/ufLSyJbs?=
 =?us-ascii?Q?0/PWAfsglw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: owHnmMl+sGDtqWLc6aYaVaPGVbxyfL4t8kSrgOHDmwbMX+W0ybV5Olnz+ulqWUFfUUp34lcZZ/Z+fl4O6OLGxn0opm95B1jmbXC+oNdHo4uKJNF3NDrbmsoab0ivjMqwUnVnUGHciXDe0hGD6owtf/22YqwyQNw5vfg8e5yUxyK/IqjJ5aTCfHyM39wV9bglSUdQlAOUu+Ul76siaBg51Je/3yVpdSgNq3cqXFUloG8rXnQy6sQWN7gD7O6+j4YV2nHfOwM1H4HHHiAeiFiclLmtyf9MzGWTQWnFoWMr46tyIv4rCa4i2S/fzmW/G0VuD+spPbBU/h8X4IpHcoOl9Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8528f4-0c3e-4006-6337-08df1531c748
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 03:06:05.0390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0QYQqvEAq0sT8Rbx7C98jfo+J9Tmt/0V852GpFgo2631lyeFsrBxwkobvQy6t5kPaav3B11+QPCiLBtnHKn0aqi9heS+lbfDEiT4XpHq9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF20F246184
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of B=
ryan Fraschetti via Intel-wired-lan
> Sent: Monday, August 3, 2026 8:29 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Alice Michael <=
alice.michael@intel.com>; Greenwalt, Paul <paul.greenwalt@intel.com>; Fijal=
kowski, Maciej <maciej.fijalkowski@intel.com>; Loktionov, Aleksandr <aleksa=
ndr.loktionov@intel.com>
> Cc: Bryan Fraschetti <bryan.fraschetti@canonical.com>; intel-wired-lan@li=
sts.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl] ice: Restore Ordered MMIO Writes f=
or Tx Doorbells
>=20
> The DQL accounting state which tracks the number of bytes queued for the =
NIC to transmit, namely dql->num_queued, is updated by the ICE driver when =
it invokes __netdev_tx_sent_queue(). Subsequently the > driver updates the =
hardware queue tail allowing the NIC to begin processing the work queue. Th=
e queue accounting update should be ordered before the NIC begins transmitt=
ing descriptors.
>=20
> The transmit path currently updates the hardware doorbell using writel_re=
laxed(), which (on arm64) does not provide the same ordering guarantees bet=
ween writes to normal memory and writes to MMIO registers that writel() doe=
s. This introduces a potential race where the NIC begins transmitting descr=
iptors before the dql->num_queued update is globally visible. If the NIC fi=
nishes before the update is observed > by dql_completed(), it detects an in=
valid state where more bytes have been completed than have been queued. Whe=
n this happens the following BUG_ON is triggered.
>=20
>   BUG_ON(count > num_queued - dql->num_completed);
>=20
> This has been observed and manifests as the following crash (note that th=
e trace has been trimmed) in an environment with sustained network load tha=
t uses an Intel Corporation Ethernet Controller E810-XXV > for SFP (rev 02)=
 on an arm64 machine. Replacing writel_relaxed() with writel() in a test ke=
rnel eliminated the crash in the user's workload, which previously reproduc=
ed the issue reliably.
>=20
>   kernel BUG at lib/dynamic_queue_limits.c:99
>=20
> Internal error: Oops - BUG: 00000000f2000800 [#1] SMP pc : dql_completed+=
0x268/0x2a0 lr : ice_clean_tx_irq+0x1d4/0x620 [ice] Call trace:
> dql_completed+0x268/0x2a0 (P)
> ice_napi_poll+0x94/0x520 [ice]
> __napi_poll+0x48/0x3f0
> net_rx_action+0x194/0x420
>=20
> This restores the behaviour prior to commit ccde82e90946 ("ice: add E830 =
Earliest TxTime First Offload support"), which changed the notification mec=
hanism from writel() to writel_relaxed().
>=20
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2161572
> Fixes: ccde82e90946 ("ice: add E830 Earliest TxTime First Offload support=
")
> Signed-off-by: Bryan Fraschetti <bryan.fraschetti@canonical.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
