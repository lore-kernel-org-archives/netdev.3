Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D0B3346A8
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848406; cv=fail; b=nxIvDaPrwvPlji1oKXFUtHgeatYsOsIUef1bKiuvO+J46tEAMm0a2z9CLWIweWNBUwCDT6/zqksoN0859Uk3FrKUMPMJyVvcY2F5BgV2Ax7mF1XkikqLIXrYAg+78C08XvN/crpHQGL70QYFmWh2Noo7J9JwupvfVzYJV2mXc+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848406; c=relaxed/simple;
	bh=TzDIxDZ4tJxd6KGi304C+qNjePV5NRpvgyTXDMoyfjc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YYTIxu0HT/WRe4d9G/qtPlksB1+rdZxZzkgc7Efvj+WmDvWPuAHmItnft+YAgqlG1Krv3ljuLVziYAQOcVrewkX91f8sqy1gV0CrSB0eDoIhQO3Rb22dNg14i0TIL4HomX+ifx65C53VoxqhupdX3fef9wGVo0bsx8qeoB46Ph8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkqS87zD; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkqS87zD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788848405; x=1820384405;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TzDIxDZ4tJxd6KGi304C+qNjePV5NRpvgyTXDMoyfjc=;
  b=HkqS87zDHswpmt+rPEjFTX4v3L8PA2GPIebzxCqt6Fg6Y7ZTIgV7B56p
   l1Ojmu3c92y6uZKN+Ols8aRuBp1jgJTh3v7SC3npsalKbTamL8Sz5HASS
   r1Y1zio/RajChkerC3bF9NI4hb++JWg6TTCz4rEwnvi37ofl1PpuPLULb
   5M7iHy1oQSxWkbMvHpKajwA8qkLLtTZhKiy9HADhNpHoBobY6bPt6GXVf
   t91qZbssU9CbXMTTdbff1FmBsMKbmAAQiHd5Qnra4lCRZIfP7lIQC8VKn
   OobARJiO0sAvhlnbRhyQu99sSXuxureYiauez90jDlHtRHpBmLqMWSUFI
   w==;
X-CSE-ConnectionGUID: S8jedMeJRcOjDt0fZ8kuNg==
X-CSE-MsgGUID: v7JeagohRE+/CsOg/tzO+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89085721"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="89085721"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 23:20:04 -0700
X-CSE-ConnectionGUID: vzuXi+4nQdWovBMVLGbaJg==
X-CSE-MsgGUID: VI0nZY3kSKS21WlQ1bc2hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="272832613"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 23:20:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:20:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 23:20:03 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:20:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6V0Mv0bzyfu06vvtc/DwXARZPJbH8YpmckKXtyrmfDmJ8Dgu26yWPchMublieqeOfz2Ks0+vCrt+jxHu2rkSuP00sIWk7puXwg7qebKTN0EQgmECQApMHyDzwk+iTBfT/k14CdLTO3rpaENq6iHeiNChV/sCVAxoShzTxspWqVLelVFjrYqjsJZsTlhv0ODiVvV1BOWtrWZgUyVNxFMqBBE9XXliUdbcJkQdWhiNBNaHkRUyQPIGA1uu4eXjtgxapjhY9lf5PttfHRgubOvWckJPG9yKUo4W9oP8THdwkn11Y3h/dJwPXe4DHoAf4DZYoOj83kz4n9ffL4nLDHTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79KyL10kJeT8m3mA9+qU18XvHgrxa15Q/s98FcoDKyg=;
 b=cG5XpOcKLPe1PPbgD4pKUVfydXBE0Q+IwKaOeERjDVu6Cu+RBwomtuwGmFdoIjZlKfdF9C6EEz3GpYxOlsrc8f0BWE/IJ6fkq+XJUO55BG9DjvH1jaux3o45H1bteiNiuJTr9JNIHxf/SzuOUIKa3btAB8rSm9zePF5k2TI9wDJf8J6JliP+Y2ly8r4KaYyzYQid++MzX0PHximzTNxeEpXchUA41P681n7aZDNgmVB8DtUoecQ4xbDg/JGEkXQ/etea5R6krybllL35Vf3P/Y7VU4eg9LpzmEY9h0rP9nSlFnYG/knYl+tYFrpC8kfBlqVxNqO2V7SE2XmeMpKx2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 06:20:00 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 06:20:00 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v5 net 7/7] i40e: keep q_vectors array
 in sync with channel count changes
Thread-Topic: [Intel-wired-lan] [PATCH v5 net 7/7] i40e: keep q_vectors array
 in sync with channel count changes
Thread-Index: AQHdCVeW4fK7uFciLEekvVo/OleHX7bEnHJw
Date: Tue, 8 Sep 2026 06:20:00 +0000
Message-ID: <PH0PR11MB7522CAFBC60ED8593775E5E2A0B12@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
 <20260701124524.13644-8-maciej.fijalkowski@intel.com>
In-Reply-To: <20260701124524.13644-8-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|LV2PR11MB5999:EE_
x-ms-office365-filtering-correlation-id: 57309cb5-df8f-453d-61d8-08df0d713685
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: BxIJT8s7igqwedDMsDwZKXeMGr9vnWKmXkmrD8D2x5ClBOPjYLC7nI5fGBQBIgb831X8ZvihY49otBuRBANoFyBGSfew9YsYsDTJvW3Q6zGL7BNprRuFqUjEShWcslgQxZjZ9Yt/opUnGsSVW/YzBMdaoknBNUS5AUmuX4BsI3kmOYRRtG0vwTYOCdV0TsOz2BqyguyGRKv+2Wc9oKeNQ6LW0fOO8keoEFYG14jK9S4F+oGpZKIhqRhqwfuYr+Ts5FLxmt4DfyxChpa+9Ej/wcQWfD3qKl5CZ9uATvjKpCJQFabhBrJQ7mS96hhimYQtbsGrii1h+wF1Ejlz9H5rPGeVeqbdsF+pP/BWoLm1ihFbmyUJrrgoE5SzVmTbCYwIv0kv/C9EN5YScVlGp81xw5KW6Mvfk8JvZ2zMKXWL4teHSgMErB7JAjT+aNlt4f+O8tGOKJa4bKm0p66iFxTRijknrwcdwFSzG5n21arjCn4xnfAhZboR9mSjzlPJIxsiIlNVx2D1QosyEWr4P8WIRmYZYckYQNyhTkwHszkTrEewJxXFJF+OpaI6s3tm0rhaoM32E44+zXo51GORQxgALOMI+Ky1J//J2w2RypopYA7Kve+pDP0EYQ90YA+ZbRTJz6AKy0nP8f/a9J4H6fkT9eLo1rHP81QBB2HFgSzQneBXbxwdI4Tx5sBJpffW2PzVFNZTs4E1LvPOOFpmOhK5uQVA4KIV22ZsgSijAzjibUo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PpY37LlsOy0Ih/IrorgDadL1DZpsD/F6T0cimsCF6vQWdcIt1JgMjhOfTbs6?=
 =?us-ascii?Q?WAbcg+PUUuv1XfUHyAIYP0z2LUC76eyZPC3nI19QyU1yWbByfuDJ/AE9h6do?=
 =?us-ascii?Q?OUlJUwmcQ9lJXh2if76d1i8LmJm2CF8/tnpLm+9hfDTOkZhbVUGmzP6iEG/z?=
 =?us-ascii?Q?AlCT+Cyi4pPbxNwlxSXYK/WNopRaTsbd8N6+RvHR9VI3O3kheMweczFTorq6?=
 =?us-ascii?Q?HU3Iw4ZYtgf9VnjcGJyi5ngt1EXOBq1g8eXhh3l7nABYllXxQWd20lUYyjsh?=
 =?us-ascii?Q?YqcRMI9jwHzh6bFlOHlBNC1rJn1pdYRTbiIYjMqDPTelkuLsvUFGZ5MhG1be?=
 =?us-ascii?Q?+K8Kiy2cu4itxTiQ51xMrpFQ1y7kuIxJ0XgCuQ1++cUjpUwk/qc2Lcrdoz/S?=
 =?us-ascii?Q?gFxR7uvLQwUz7ylDg6ZfYajJhZrK+VUn29RCySbdNLIkqHBF0OUgT1TKJdkd?=
 =?us-ascii?Q?Vg3F8H/i8ppHgu16CxoZ3us3nE3+AeIj+BKNkY9uld8ov+2cmG96IHtv72qV?=
 =?us-ascii?Q?vgC6CcqqJ2JwyRy4OlY6zGh4s9t/1/c1M1Ey+AoqALwDmABmeBFyQjl/4iKx?=
 =?us-ascii?Q?BgJ451ef/OL86Av5K5NXJe4I/p/4hqCQczt0xBG6qFeLzXXKPJ2Su+Pmv9Bv?=
 =?us-ascii?Q?eC5bwlO4VXDXVHOosrKhKjvc08iTQLksk2IBqJ7/UJt9kca5RYDw133rTFq+?=
 =?us-ascii?Q?bsnG+BPnWBObDhF9MMD5WhWFtUuKx9w/3wNl1tacN/sHOKPwDFhlt7nrvXFy?=
 =?us-ascii?Q?sPcAR0d6HPOGpiUQhsiZfXpE17PBdWzgITdJQ39vsLHEkH392HVehHer02S7?=
 =?us-ascii?Q?+4LM3WAAlFSCSFmE4IPoUPHIOAlNRXjiuipWgh6VWpjWT8TuH8lUFL7C8Rtp?=
 =?us-ascii?Q?1c2pOx1LTIhu3N3CdYB+tKcCHIbZ2cofwppCA6g6eZeM+e4hPlzQsNMqi7/a?=
 =?us-ascii?Q?24mfrICF2mK3G6xXOV/D7fVULAEkdDZGaLe/eMEPKcmqfirWyNfrWZuc0u6b?=
 =?us-ascii?Q?kZEnXVA6zwHLdRjaweg15eIpxloQoJ+DIaN8tGIZazLd+vJDkMLbnbVqQZOm?=
 =?us-ascii?Q?C+zlrIyk9423Jw1Abe3hPjUnxy7+k/Ssm99GmUEV/Sir9Z0nSjs/vjeh4Mee?=
 =?us-ascii?Q?k4nFJBngzGVIVpc1RH3QoNb+zlyh9fO+rGR/tH5GnIgzcmT9V66FZtoJPPNs?=
 =?us-ascii?Q?wgkqAAKLXfDRveREYbAlby5n5SiZAF34tWAkCGG7CLIaMNePbKsGsE0Ytaj+?=
 =?us-ascii?Q?Oce7NE7JxT1pkpU6jCENw2zGQ3JGg6/QsFR02dFSsS9byorAEbS3ly4RfRyV?=
 =?us-ascii?Q?Nfegsy6Orrl6bQlxaxfeXLUGdxvUQ02FtnVb21m9n173m4++sqOOmdkW9AHV?=
 =?us-ascii?Q?KZQ5jBqZftluZ6opnAe322M5zKvs0Gug8FQwWkIOXgCMJ39pnvDN73S9rxaw?=
 =?us-ascii?Q?MH6GEm257TCQdGZjS471zqG2wGVwDl2z45/lRp7NO4DDdKWDgKbrrPev0An4?=
 =?us-ascii?Q?8v3TbCVDm3xlFieH9JfynsCFUGjW24jyfz20fpOuFXPwQQsUO1+wzsbz5nsk?=
 =?us-ascii?Q?EnoI7TM6uBkTdMbi7i+WRkUTw1JLbiHsOHF+nUSPmvfnZjRhwV6EMmrT7sE6?=
 =?us-ascii?Q?4OK9smLj9JBX1meBNv+0/k62dwtFqx3gDcLnwbXUrze+jYJl8iVusYwwOuG9?=
 =?us-ascii?Q?9m4AWEXQPvZYTgFHmuMdmmGnibdmCr49bUlrHgntbZIfKhdgt0RKDn2f2o1i?=
 =?us-ascii?Q?BN48HKZ3Fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0sPGbgaQtt1Gm/1gc+ei/++SRXbg1mKfdZAo2D//iO5baHyWvon7QlD3t2zoxBOCz0NAPZzXxerE8a7TBS6ZfgZ8vgEavwQfft4Iq/Nz98Tf1WFtGegkrZ6+B2R01Zl6TCiPDNEq5O1U5cxfLZNe13LQNLBLBwRAGEwO82L70EEpgwEufsGCHbkJLy+ApIxnWoLyTV9g9YmvnG842StdVpMeApip7dRgWx1NVSOJifHpsI0gOMg7w6a5JCj4fwm9AdeM74Nz37NayIehzo6rVbOjDjZigRvFJUaaAGLJIkotwwDKUzCBZTBaH/DdoI/7/Pq49RO15S76Nl8k5P16XQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57309cb5-df8f-453d-61d8-08df0d713685
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 06:20:00.6694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 205wULxtdsRMvPCS967hK4JAi5hOfj3pyeRINcAp/vqthOgQ0+08Tl8Rl3ZoYdFJ4FBDbuE7mXHC4HUsZJr2B2c9gNjGzxmij1CTMIqguDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
aciej Fijalkowski
> Sent: Wednesday, July 1, 2026 5:45 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Karlsson, Magnus <magnus.karlsson@intel.com>;=
 kuba@kernel.org; pabeni@redhat.com; horms@kernel.org; Kitszel, Przemyslaw =
<przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;=
 Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH v5 net 7/7] i40e: keep q_vectors array =
in sync with channel count changes
>
> For the main VSI, i40e_set_num_rings_in_vsi() always derives
> num_q_vectors from pf->num_lan_msix. At the same time, ethtool -L stores
> the user requested channel count in vsi->req_queue_pairs and the queue
> setup path uses that value for the effective number of queue pairs.
>
> This leaves queue and vector counts out of sync after shrinking channel
> count via ethtool -L. The active queue configuration is reduced, but the
> VSI still keeps the full PF-sized q_vector topology.
>
> That mismatch breaks reconfiguration flows which rely on vector/NAPI
> state matching the effective channel configuration. In particular,
> toggling /sys/class/net/<dev>/threaded after reducing the channel count
> can hang, and later channel-count changes can fail because VSI reinit
> does not rebuild q_vectors to match the new vector count.
>
> Fix this by making the main VSI num_q_vectors follow the effective
> requested channel count, capped by the available MSI-X vectors. Update
> i40e_vsi_reinit_setup() to rebuild q_vectors during VSI reinit so the
> vector topology is refreshed together with the ring arrays when channel
> count changes.
>
> Keep alloc_queue_pairs unchanged and based on pf->num_lan_qps so the VSI
> retains its full queue capacity. Also do not touch irq_pile when
> rebuilding vectors.
>
> Selftest napi_threaded.py was originally used when Jakub reported hang
> on /sys/class/net/<dev>/threaded toggle. In order to make it pass on
> i40e, use persistent NAPI configuration for q_vector NAPIs so NAPI
> identity and threaded settings survive q_vector reallocation across
> channel-count changes. This is achieved by using netif_napi_add_config()
> when configuring q_vectors.
>
> $ export NETIF=3Dens259f1np1
> $ sudo -E env PATH=3D"$PATH" ./tools/testing/selftests/drivers/net/napi_t=
hreaded.py
> TAP version 13
> 1..3
> ok 1 napi_threaded.napi_init
> ok 2 napi_threaded.change_num_queues
> ok 3 napi_threaded.enable_dev_threaded_disable_napi_threaded
> Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/intel-wired-lan/20260316133100.6054a11f@k=
ernel.org/
> Fixes: d2a69fefd756 ("i40e: Fix changing previously set num_queue_pairs f=
or PFs")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 69 +++++++++++++--------
>  1 file changed, 44 insertions(+), 25 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
