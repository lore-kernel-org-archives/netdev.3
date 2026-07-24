Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052323264E9
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906713; cv=fail; b=GMLq6ffatp+3qVA6d6wQnn9p35LmAviWtDdeGLep0N/nN933SQ7o+fQb9Vljcj/D/n/B8tBX9cybKgcHWiQhXdCA4dOkqbqbhBpW4AokRXj/23kAb3Mzwg8dtcsnfv+L/Fkhx0Z85m0bXOhOdjpylD4G+zyjttBaKwW58eC5ULQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906713; c=relaxed/simple;
	bh=g+IrFVEIIFFBX3zA/y8sQWCzwkcRCb4wGZJM9Lgwgqk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jnLXR0DYFSrPlBxmAsA7OJORDSVfe/eNM9BIHMnTlDcZQZBaDdryC7EB0p/zdha6BotTV1JeCxWw80iyiqvHrNVMuOj4yckT47gcPHZDBJsqK/FbjGDZUNdDirtXkVaRTjcnnoU5jJjua/G0IjW487RoP90ocb8BymWaSQcdpu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBeefMhI; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBeefMhI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784906711; x=1816442711;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g+IrFVEIIFFBX3zA/y8sQWCzwkcRCb4wGZJM9Lgwgqk=;
  b=VBeefMhI/EUdsR4DJodw2rdsmLPnos6TOBFZMVYligmoW5U7CAyNxWAk
   1pje4srFJK2YQsgMLBTKJkSptzBJn1Cl0YuZuY0Jozs7SPZI0VWI263++
   yMhdYrTTtiPW5WpqdXJuT24xY5Cipfwcepd1QW20KFIUqXZCMbF0/8Z1u
   wwWDllwUb9SVaxzI+MZcp9yHLoYsjQKrorcob4OZV9bGj67dEDu+TrmKR
   AKuFXDBblRbv2VddHv07R3NGSQOFHDNjTr8LCGW+f19zDny9HhsWDNwd4
   mAXSQcKd1aYiNbOTH+EeyTGD8+JwSIL4u0liwu16e/iRIgrjQUomE8qE8
   g==;
X-CSE-ConnectionGUID: FGwCTj3KSRm95L6RsLDzqw==
X-CSE-MsgGUID: UHZs8i8LQ++jCdZqKPZMZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="88111617"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="88111617"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 08:25:10 -0700
X-CSE-ConnectionGUID: jfNSYniISWGtMDeTCFdb2Q==
X-CSE-MsgGUID: 3iIYJHb3Trmy/E/AnDLAIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="260679231"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 08:25:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 08:25:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 24 Jul 2026 08:25:00 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.50)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 08:24:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgRfHmESMRCzYDwAVsPMkfJleuuTYPRo3zMj0PgbqPgRNMncWxCS+R5TqnUSWB03BQuqN2s+jzFYvxDPHFIn9Vv6PpowePK8Y0oQhBfHQk0pmw1WEZLBF0YaBvPwP2103tecPeAgJNwq0jhK4kg0o6Zn652CIVVYbPRFIjAX6uD2FHsmY+TQcBuyoSOpzMxMWVSgKLIvngEAEKNP9VLbiAXGuRnpfV7s+IzInQT96ywinIXrDGmSDB9iuv1cTpKW9NeFfj68h/OEwmqpI9f7e2fWJ0ynb6bh31xJKs7IhH9R0gg5HSBjUVyaXA5/36anbhRXobWahrmIFTYVGmakzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+IrFVEIIFFBX3zA/y8sQWCzwkcRCb4wGZJM9Lgwgqk=;
 b=HYGPhlde4dExkKBKRuhpNiZECRbuUBhorZOWNXXOKNaKncYfB6rOfUC1v9FuJlGfsObne8Lbe/saJnmDfLTVTXeAJccIqxfeAQFGwrZbMpv6QvXI1HJw9guwbOL7ukL9rP0voUH+bQ/kl1iByPCKqvsltU7qEVzWF3Gwxp1YhYcxatdKRIEk4/A/ON6JyL+bkPOWaAwb3bfb1lPYc8vN4QDZA0R3sEsPLC6crZ4/3Vtt/cUYfu1B3Nug0suGDiW50mW9li8OY1N1MqOpAjF6Z8zQs6Ny1tOFMC+YDf9EmRoEsR89wHSy7FJpfa/b0ocLtD+nEHmv/LNmEtAKPqA0tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.11; Fri, 24 Jul 2026 15:24:51 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 15:24:51 +0000
From: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
To: Chenguang Zhao <chenguang.zhao@linux.dev>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Chenguang Zhao
	<zhaochenguang@kylinos.cn>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, Jason Xing <kerneljasonxing@gmail.com>
Subject: RE: [PATCH net v3] i40e: xsk: fix multi-buffer XDP_PASS skb
 construction
Thread-Topic: [PATCH net v3] i40e: xsk: fix multi-buffer XDP_PASS skb
 construction
Thread-Index: AQHdGw9BOWsx4mnvhEaiTk4v4EYoB7Z8ytrQ
Date: Fri, 24 Jul 2026 15:24:51 +0000
Message-ID: <DM4PR11MB6117EB6F9538C7BBB808C24682CF2@DM4PR11MB6117.namprd11.prod.outlook.com>
References: <20260724015328.229726-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260724015328.229726-1-chenguang.zhao@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6117:EE_|CO1PR11MB4835:EE_
x-ms-office365-filtering-correlation-id: f8df6f38-1eb8-4d72-b0ef-08dee997b48a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|22082099003|18002099003|921020|38070700021|10067099003|11063799006|56012099006;
x-microsoft-antispam-message-info: Dq+tgxlr9vT082J59/VJlsxxGzSShk1+AmEu6kgJo9x8VFaWbEq21u08gyUjL9yPg36EvSHLw8boHeOF98+++70Q3lYWuVlRTkZtZ2P8xsF09y6xmuiBCN896T4tGd9BXmuf3+1sdxjDmJPA3rXYYBcUAnYQOIXY5Cb1tW+UqbXPSO0fLScxxnnBroCA6xgkDKtg5nY5Cop+Zty/PKffBDEXfbXGUWfpZdtkmfqxiHNNoiFQAd6jwSInyb/PvTsWpvvKNH2e+5syilgBsj+kRGrnTqbUDUywOFLgxCVSf0byAlkFJjJrdCByQMo0xLUVrWe1q8PBC+9RhyXVPiOEWo37e96z1rV0BUNOLToFRXnwyIjKftbSgVYKt444E9teQ1Ia/BgJlhW6h8br6aqXocGuToCxDz/HS+uP5RxOn0LFhOR3mQAxSGClt1LyIMTExbUqAwzu8JRiAGPmBi6N9XMY3mJK9UXzFGx1bWLlw4Rnc0u6bORabuJExJhInZKSSWhqfFT2vrTql0p5Y1KdXUW03GE95rp2MBKHsH4+VumbU64H62FhUZakvG0uHdRaIYSIQOxmP/Wm5lh3w3AYmlSzHW3Mau+DFzKf037ojOpPqQa7a270e9vtrIY38HxngnR+VTptR+JXDJ6/q6kRBx+3ro2Vcyeini6oPDhBYspfGhTmneGIPJrOVukq6pnSaB4W38ELqx87RilfNFEGTDMUlMnI/iq9u8ASJcLbeb/KvK5124O9oKEYO0j2jrY3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(921020)(38070700021)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M+hh6/qk7Mx/Z95b0R13ur4HF1R9sbE2GHII+vKl6gdEwtm5KHsEPogg0yQ9?=
 =?us-ascii?Q?BIWEOEqNm/OB67RRAGttdp9PaqpOs0GIzNcrmG20Em21RTa9AOaBIRnwj9I/?=
 =?us-ascii?Q?naIGeu+40RVKewutUY38F5zykSb44HlJWG9hCML/paJKbefS0RyTEHjAAOFe?=
 =?us-ascii?Q?17ixxlBrBSERtpCMdCiFlL2AeGdNmqP2l5Dm64Et8JcRNgzgPPSBneRx3Ybs?=
 =?us-ascii?Q?yGXSbdQ98Mr1vlyEeD2GPFOVfvBZ+FTXXBIw+WS9yq0IVEFhQU8/KLlWOx7K?=
 =?us-ascii?Q?yaV2h3YIGZ6ibzHaXYghu4+hJ5GOmxNY3+Sp5fgmLahcaVbz59udAruOQYv8?=
 =?us-ascii?Q?sA8228OPVdOc0jnRmWNSWZS5JobILD1uTw4DCdiLd+oQrtl2O1mrUidEkKFR?=
 =?us-ascii?Q?q7HBgD/7hCk2AcH5bcRelrHQdv+G9wF6WMrfrDxRr7qlC6l/C9R3D5WGnWFA?=
 =?us-ascii?Q?HV6JeG6pvVq171824IwI8ZATEvfMWop3sww+Rjm0TC2KLS4wwvqT838bVAKx?=
 =?us-ascii?Q?n614MK98gkgrSwC5Hh+oMNdKyYfkiO7iqgbWGEXuPokEYnue56212XQPIs29?=
 =?us-ascii?Q?RapAcekW1i8HoVzw7BVFmTXAUbWXP0pELhuniBKKlGjMFbH9NTkCBkRdNE5G?=
 =?us-ascii?Q?7i3wNvXUVuxZPbwrLwL1ewY5VzmeF5SQfaXSE5DOFy5VxLs3CgZqsKvjQhRT?=
 =?us-ascii?Q?4Ei7KdOXz2Rd9sc+irAO7ZB7qTz0kL9hCnOmLk98vmfEIhzIsx+ceG2S7Z1P?=
 =?us-ascii?Q?PZ4HFDllDiIp26wbNIRPtCu0vIx7vqqzr8bJyv5PhkPSAsygx00cW/dn+Doi?=
 =?us-ascii?Q?L0uF+cxHVMKqhdAFzTA5OW2uteg5HaLWIqDxq+t3rkycXb7Te30yb4YY3277?=
 =?us-ascii?Q?ELXxrp4jWo3LOLOi+pEtEKKgCxQDyhxfcOeq5eVnIjxxQduYALxRDAUWZpGq?=
 =?us-ascii?Q?aXnj9XERQ2mx0zHM+lILXV9YF/l16EHWinhlwv+vX9BqL8reYYmlJJIvZPqS?=
 =?us-ascii?Q?XOZVjrRZ2mSBxetNoc5CkwkV7T1EeEJMNTJvY8qx92Kc0Tas8wPgwl4w9pYA?=
 =?us-ascii?Q?ltxqwM+bEg0eriNMe8fNKc8MpY/o4LM7H2floLI33kx0Eb/hNN6tDuJzsVTo?=
 =?us-ascii?Q?zTdfpLs/NAnxqIISvDBSUqM+hr55YPLQaiTxujkA4EaKz+nrO/XWpGD8a8vV?=
 =?us-ascii?Q?ZjC+3HhdxaBF9vlWFvXiCejM9nPPWR/meQZGqNsf499rXS+PxrfS3FklYoyt?=
 =?us-ascii?Q?EI/FvsJ3R2hJg85yF6Ianr2rGNQwcbBE4CWhh6ACUX0+eRmEIROqo11sXaPh?=
 =?us-ascii?Q?IWyeraDn8eOdc7bQwY6TU5WLpL8SGnSZCme+A5jb/af5pMd8LsZXPzi0zlJM?=
 =?us-ascii?Q?NLhnqWkVdRGWk5ef70nAt+TUM5u4vhrGHp59GqVSazJhG3Q+Q3kpqZPKMpM7?=
 =?us-ascii?Q?cZRkrqRoduXSFQSO34i9IbEmwSMtWRr3o5grHYGrAhdN+gnUY5jBNJf1ouOM?=
 =?us-ascii?Q?KZkVWARVRW2wqKQXUmtNYQNcaJY26ZMWDyb0xo2sgVLuKDmAAmt1V6mstW+f?=
 =?us-ascii?Q?2gCjB7ic+e2/Ohx2ZaDWTOFFEu1Fc+5PRgJbwJr65ynJovK6W1BTugJLPXDR?=
 =?us-ascii?Q?vkxm5CxyVv3TT0l0HoRqHRuCYs0ZzBIHh253v7WGYlOgyGLZZ4hAEAfm4ynU?=
 =?us-ascii?Q?NW3ZkRDSioSCCHHQLDbqGdeD/IfmDAwSLbGY/9c9RnyElMfM6HG8/Bi2Re52?=
 =?us-ascii?Q?jPW+HgNJGQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hlTXLg6zEhMnLSUudu9yZ+ATNEKIQdub3o+kWey+31kXFHCzPrC6URMRGNyiJYp1bRuw76Gz2NbjTSL2ogmWjhGV/SbHoZpM+betvY/IfvlLAKUTmKtVAmVGtKqfKMbVIgzpZGsiF4lGq7D7Vk2pjJLhp4cqyYGfnz48vx/FhFtzE7LgCrbwB1oiqNNp70Fwv3mtFj47c+rgKzxatvFGCuY9wzt8EylXllqLDMol7/eKKYicI7BBqywwnAOMYU3EjSJWOhHkTfP0S4EcHRJSAg6ZoSb3vCQfbPMNcHqQtStGqiKfXhL/HIM6VDRDSuCl+ERgKbsvqCbN543zwqrOwA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8df6f38-1eb8-4d72-b0ef-08dee997b48a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 15:24:51.1097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PrykAM+Yz9ykh3TB819YYIssKC5n39hVUrWhExxoxB6hAvzfWDK4sHhtQ/lqZjGlFCCvR4mC7ilMAFkeIsWxsQMdf1Y9Kamo4NKyQWoPyL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4835
X-OriginatorOrg: intel.com

> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>=20
> When AF_XDP ZC receives a multi-buffer frame and the XDP program
> returns XDP_PASS, i40e_construct_skb_zc() copies frags into a new
> skb. The copy used skb_frag_page() as the memcpy source (page
> metadata instead of packet data) and passed a virtual address to
> __skb_fill_page_desc_noacc(), which expects a struct page *.
>=20
> Use skb_frag_address() for the copy, attach frags with
> skb_add_rx_frag() so len/data_len/truesize are updated, and on
> dev_alloc_page() failure free the skb via the shared out path so
> xsk_buff_free() still runs and previously attached pages are
> released by kfree_skb.
>=20
> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

