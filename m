Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BAA3CE4A3;
	Mon, 21 Sep 2026 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004641; cv=fail; b=MZtUE1y7B8rYvBxEPymDmc3zlJTes1JQes8IULwQnJ4J93gBJNyAG5a3GXlMUj2vQHmnfx1W4Dka/7IdRTrL1q4LL3wesX1KM2e0k4kVjW9cK1fWoshCyjulfSy4V6NfEI7kMZ/SWOcTrUDCgvoXFTj28doU9PjxlDPKyXMZJVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004641; c=relaxed/simple;
	bh=Z6DGhTc1FkhvpOyAEHcGdUVtpRyDqVmDZgANb756Wgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kjMDP8cqyLFHOS2OrU/K6a3g9uIuU0mnv7ccXCrAasxW+2ENnKHEo4u0F2RZd6vLKlnfvVhhjOYaQRaFmAL95NBnZKnbH3B/ZDee+7P9Dw+yFpqlQKZwANfyWTj5+h9rEEafRgJ8/B+yvIU+0HwLs2+A8atgmpeqNJgiZ0Yz/Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SO2cefCJ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SO2cefCJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790004639; x=1821540639;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z6DGhTc1FkhvpOyAEHcGdUVtpRyDqVmDZgANb756Wgk=;
  b=SO2cefCJz18l6K3wGIwniwz5mp3tThhI2No3aM+Ya3Fzd2lak423TMtJ
   yYxJcxV8np8ML6XOEnFykIbULW4dPvnr+sVkcNYVlW8E04HGhtDl61Ivp
   JfEMTDdCzjuBfqmBTyE1IplVekBi1XpLA8b3g17fuMUpnxUumBBSxT4nt
   CMGLvr5I5Ldfo1ZnCGo6k1z0A5Iad22RD0cwiPLWwRiF+JX9/KO2lPred
   uJkwdAyWsmBfMmMj/d8zB3llYeDXjiSWJguAFZaSEhAqbwhypiGGFx2iF
   kKnu55sgpMKQRKm4LqKe4uWT5ln/VXcGsCAfwKptcbhlewMk5TPSXpYk5
   w==;
X-CSE-ConnectionGUID: yaO90GjaQ7qSr7G3DpPi5Q==
X-CSE-MsgGUID: Q5Vy0W18TN6um7WUn3yDPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="116057990"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="116057990"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 08:30:36 -0700
X-CSE-ConnectionGUID: byMNNNaWSkqzo51xn0hWsQ==
X-CSE-MsgGUID: 0ME0VQ5YScCNqoUfgUSTPA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 08:30:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 08:30:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 08:30:36 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.47)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 08:30:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnIhV/XkCI7DBl2p0bfO2OwFA7QZJ73IphmuHayz66xrIGaA0vIwjw6zZlyfTDq28UpAQg/3Iylq0ODCJJpNRuInaBMCXiAKujWiim2s8vCc4YHf/l/PPBtP5HDQ99YfPp6HA1VcUYdotAYNtE+iwsPaBxT2xP8vuS0hTWkm3yDYIXDvdyzHT65SyOUd6FmAedbIhQ+8sISHZzLdI7TXN+BZpUWZactTJdqD8T+/iLjT9QLNLjtNIeHq9kHHalOmYGbaVkcnQlsRB6t4tHJAszcO5KoV2UiJpEMzXx1eQBxTNo41M9xZhVvtFh6ex3FjuRx8JA6aUuqgEAPcFiaeYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsLAFCvtnzwkg8N4ASfdltupbppxl/7P6QTW6Omhvds=;
 b=wOp49AF652pBVctp2zvyFTTA7VQN8C19ZVSdxUwX1TxoaV30w9cTl/E3KCN1xE0VemaONb2D6x0viUBXeVmXj37n9Zu66q0u5yvnCbOqz0t3KhQq8ew41O9oPCSfdgcQRqdp6qQna58649pqoCAzF/ch6tjU14gukgHFWmgOLnWzbKrvTnmhU7KhtIWpYvLNKGIndY8p8Jt1snv/SaYALC5M9ghCb2min+8L/fOHTbgap4VVA7qXh0nkUvI9mbSqDikEbyFfAKmRTLiHWY1xpPNeb0cRC1i0jRk3Me+1dQdQWhY+lDmUjNfJP1gbn5vQM0MnviUBABTskkQsPUMxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SN7PR11MB8110.namprd11.prod.outlook.com (2603:10b6:806:2e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 15:30:30 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:30:30 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Filip Balluch <fballuch@redhat.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] i40e: fix freeing of TX rings on RX allocation failure
Thread-Topic: [PATCH] i40e: fix freeing of TX rings on RX allocation failure
Thread-Index: AQHdRTY7N5V2ZyEMfk6e02nr19aRarbZMciA
Date: Mon, 21 Sep 2026 15:30:30 +0000
Message-ID: <IA3PR11MB8986A57C8EFEC6747D4CD5D0E5842@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260915122639.64936-1-fballuch@redhat.com>
 <20260915122639.64936-2-fballuch@redhat.com>
In-Reply-To: <20260915122639.64936-2-fballuch@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SN7PR11MB8110:EE_
x-ms-office365-filtering-correlation-id: 08a31e88-b74f-476c-7ab6-08df17f54518
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: LlL2e8w0umSApYBLuuUTJ7Mv0OJLLxjw4PwbTEyBNw0ZXuT4CbjQDUEV1u3NLOM3xU2mX6oeA/PPqJyHj9VSTofMXR48W9czrDiQPxKxnf4mfKsDqqtApT+b0c6acDm8WJJrr1MFxBoAvzHK4uEYktm8DLdoEpGngum5m6IFUtfrExdkkBrF0cDEfyy3g5SiDdomzbShLrJFGczEnHe7eHBAPFrC2rXE2aLyQ1EoBuDojiig2F4nBCVavmshBeyS5TScaiPrVwtMT8nPLao/mhxvdXuIr47IafWBuUMpMcx04KkkWofMwFpDEd+yjsP+cQpvbikn3YVbupWOe1wiFGB7Sd2/DD6q8ApUGqGgXBM8PTZy0Br9n4zgxJeF6VWNyUhTeEKYxwgFGRTIGXtXxO/752hsrDxrrnCqDY78cjKqxKWQD6CoDregIFChoiGRhHxj9epTZ1rmwDHK8lgm+Mh5QtCicRyqIDuih39Jo/bO885bOvPZWWtLSRpULA8YPKJhnw4iANmx9UuN8nPlxhmyYSMPui5N/uxK5Hvi2HLtRVXjgEeaU7swyRPLHXb9yDTvhI1jqigTUQE9dOPH+cYBcwGmSBBYAUcF35HxP7klX3Uci0ilw8hAZ0mKI1B55o5Q6boDZNHxGIY+oVYSworhTrZRTBOlptqqvcizHQ6P9lnSUdXd1o42qS3E7B1xu/8mIOwuWSMs5/NTnW68LYHeFn2Gv/1VaJvMymxShPw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sVebX9U9k9LfpHcfr7bdpqu5dYUmQGPBtqO+K0vwQCglUJd+MUKwPQAx66AV?=
 =?us-ascii?Q?KD+oOjCMZEyYgCBaQQpX5uflnlK2xvv7/tjHuzTZw+TKEmP9hjNU0LaWx23Z?=
 =?us-ascii?Q?IP2wy7fVabUBCHe+mKIMJaLt/hE7FpD3KIqzkjjV4RjxiF54vWqoerIoHvVg?=
 =?us-ascii?Q?Odt+WjDdhh4/j5moRmNhzoAn0LUZyBfjNI7RZNsr3QgV+x7IczRccsKLLV0I?=
 =?us-ascii?Q?iLD8+bFPuZBjVsgdT2W5/8vnFLKhFEgEGO/Z/k/uWhitefGm3VHG2EwybDiq?=
 =?us-ascii?Q?/F8HdCMS7LQwPH6xcnUD2rWVyLxr0oUiDCBc0wB9pWmfPuvL9pDCbZQK0BH8?=
 =?us-ascii?Q?f1FGMFwaYlFRLphH8nbUG43Ldb5Xwvqfsn0tQ3uGoljd925BkPWOVcsQx+Zw?=
 =?us-ascii?Q?w27Z1Dn6Oz7hj41iv9YlG71uj+we7wyIk8BmOSUzCNLgqgMwGXl36lpZ6Z9Q?=
 =?us-ascii?Q?sc849Qhd35JkuqO8/S3EwAESxW/Fbr8kD/H98Nxo4efbSxkl+Gxe9NmmvC/m?=
 =?us-ascii?Q?/iSfnBOYo0r3KxL3gkcsTG3OIzPXUmTX1xI6l2G9dwu6hrl2ycqw1OemEuXS?=
 =?us-ascii?Q?DjoEZtw2919RkxP0PSzYBrl6V/POjz65Mzf9FEijf53oboaxRhOgr8ovTFY5?=
 =?us-ascii?Q?axQRj8T7p2yU6XWCw4dJ3wH+0Zjf2mIR9UomZLx7KOokQHuwfNQROKYBdjCH?=
 =?us-ascii?Q?79dGVxXmZ+zvKwzV+Oo6bX3aundcezKSOBXAoyVUJ15GWitAdWiriAOT2B5s?=
 =?us-ascii?Q?V7l28+YdKbQ35gfIEFZR9O37yO/IDjlXOWW9wmKeAWuqocMdZdXzYvCyPpIz?=
 =?us-ascii?Q?bhk9k1a0LJXXdFH93cBQMPoLEe2VenN5JSlh6nbhAtuUYx8rq/Y8Ww7c6mBP?=
 =?us-ascii?Q?db2hrq5dT5syiFcLun4+5C+E0+gOKBtX2YucmZzgKQQK+nBIhBFqrsXoLZeO?=
 =?us-ascii?Q?kcl0yGHRoxcD1SVB7o9UYF2p4hb7WSKUSV7bcDhVwtP5XHTqI7prpWRPFArU?=
 =?us-ascii?Q?ssnMo5hKGmDpbkWrXhcn98M1BmpmSNAqz5McpV070M6yGPsb6zmioXeRPjiF?=
 =?us-ascii?Q?/8zZbjcr7BwfAxpZJrcQ297qG1WOMUFuqo4TuJDg3ONFjZJpc8wY1yZfHj9H?=
 =?us-ascii?Q?X+824iVOQ/NBKzQXVbuGwqLGofIoXP66QhpoXrvbk4kklp6Ov9bXqh4wqgqm?=
 =?us-ascii?Q?uDVAcueiCB+HS/De5spoEBBEI6xHnvIPD0cTcR9iELHr8jnhShDBfOx27fEP?=
 =?us-ascii?Q?zCPZVA9m6Lj9tIusmTzsHpQjVw6xMJH4SPCGq7+L1h/pmTBWSmPbAwC+e/1W?=
 =?us-ascii?Q?R73klejB7Awl9XNZd9eGqWS8YywKxJMcIrLhSMMu2q0PntT5L6sIG/e7jyrT?=
 =?us-ascii?Q?BKde8uF3FzNfmxM9OHZZQMdXf4+MgLcnBLafTAatD0YUrTHc+GD3Q0ZvB96g?=
 =?us-ascii?Q?yMDpvK2Cqam4S6zIwdLvGXf63nK6ib0S30sxF6/DHqyvCWiFl+/ISBjD8U7d?=
 =?us-ascii?Q?j3jD3wKg29TR1DIqWWlVBbKMG2Di3LL0kGTMIPwONvAfarU5I/rtC6A3zSPL?=
 =?us-ascii?Q?rc209YwFwXhjCowfSiIO9/SSqJDBDRhQZJUQHUeTUdWK5UT7Mne/zSWQ1O4e?=
 =?us-ascii?Q?0pKtqFxjjRuU0QsGvcGU9tfgG1fTau4pttl75remRw1xyoeq41zEinQQV9ow?=
 =?us-ascii?Q?Mm/YK2qEyxFIdpHTxDxVwEwGZVFn4VkmWQQ+H7BO8TAJUR4ySTFEaRY3QaoD?=
 =?us-ascii?Q?Q9tEQx27LYIhF3rsPlGRd5Spf8mOjR4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lDfLPaj1V955YDS92qccHtt+9Vqf6IFZPhyBDE1XGyuqFVjNRW0BgR4DJsRtuNEi7cFJYVvBGIfIEkgwc3LE85iKi2gQ8Z2wMniShXgjPUlpV8fPxS0Q6lNjpbIDMTUHSD4dhifBLTU8g3sXOo4YjM4dokJO6or9OZujhpTMZVE8gJG/rpZ4BUIsuLomRx5liJZA3dRi8naF8h2g7FxLi1VkZPon+iP2a6B6yCvEC76HqSdp9Ml4Dh3xiT6+EjnSwE4E0OHrmOgv0WgMJOSSxeFEW1g4JrjLRxZKxYps2/J+14vPv/vl5oC57MM2UMGB4PfKJuSsCexXPiuVMQeF/Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a31e88-b74f-476c-7ab6-08df17f54518
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 15:30:30.3215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2JnwIt6Ns19DMjCBqOaOLf9Xwwh6dQizdaE3VfI+gMZyTAdahdZN0bA1Z1uVABzyqh9HzmbjVVx6+UKdHbKNFlVfoFpqVVglvqbeq2yqCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8110
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Filip Balluch <fballuch@redhat.com>
> Sent: Tuesday, September 15, 2026 2:27 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Filip Balluch
> <fballuch@redhat.com>
> Subject: [PATCH] i40e: fix freeing of TX rings on RX allocation
> failure
>=20
> When ethtool -G is used to change ring buffer sizes while the
> interface is up, i40e_set_ringparam() allocates temporary TX and RX
> rings. If the RX ring allocation fails, the error path at the free_tx
> label incorrectly calls i40e_free_tx_resources(vsi->tx_rings[i]),
> freeing the live TX rings instead of the temporary tx_rings[i].
>=20
> Since the interface is still up, the next TX completion interrupt
> causes i40e_clean_tx_irq() to dereference the freed ring descriptors,
> resulting in a NULL pointer dereference in IRQ context and a kernel
> panic.
>=20
> This can be reproduced on systems with Intel X710 NICs under memory
> pressure, where the second port's DMA allocation fails after the first
> port succeeds.
>=20
> Fix by freeing the temporary tx_rings[i] in the error path instead of
> the live vsi->tx_rings[i].
>=20
> Signed-off-by: Filip Balluch <fballuch@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 3da9ec49cc74..6d2b076049f7 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -2249,7 +2249,7 @@ static int i40e_set_ringparam(struct net_device
> *netdev,
>  	if (tx_rings) {
>  		for (i =3D 0; i < tx_alloc_queue_pairs; i++) {
>  			if (i40e_active_tx_ring_index(vsi, i))
> -				i40e_free_tx_resources(vsi->tx_rings[i]);
> +				i40e_free_tx_resources(&tx_rings[i]);
>  		}
>  		kfree(tx_rings);
>  		tx_rings =3D NULL;
> --
> 2.55.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
