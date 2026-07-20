Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB614330D29
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533961; cv=fail; b=Te33C8wRDuL8EbtgJHwBEiVXQ07Pid/SFRmBA5ybqF1LIHgfRyHQzmu1oK98LW05wCyzp8sl2PBFNwqZvvOp4/wdF/acaKK3hE26uOJi+QWKxA7fyfdzs+OQPYHWLQAzPTrL+RqSw+J87/VfUTvImNXVveicdkqqikfYPMdswks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533961; c=relaxed/simple;
	bh=Imw2Ckx4InMlUMVrxcMA722IO0VjMQFwg3Hc7L+Bg34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aVdwNNeIfaylAOvq/YqTn5MoUNXS5co+kqKh2b4rVSbGGpauMj/pvKwdh/addYoqdW76y3baKXFyZNS6QG6JxAxmBwSW7JvE6eF7qF4I2lRyK5i+rae0MVEquvZ/Y9fv2K/FJHru+3KhFyCptFfij4YIzE/JiGS4W0g/DdImeJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNDskUH4; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNDskUH4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784533959; x=1816069959;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Imw2Ckx4InMlUMVrxcMA722IO0VjMQFwg3Hc7L+Bg34=;
  b=gNDskUH4/TggRRqKgvxKvvgilFGHsFDzm4sP5XBnmb40uPhbExia33rf
   1FxI0ufb/SlUvH2Xp1ILfbnl5sOYsjcnHYPN0ytBiymZ9Ejt4N0quYrhu
   Xtf3buXUygcQzZRV2XoYpihT6HCib4Qoz0+XfRduIiqArAFfJ8u+JbSXp
   fivu419GpydQ+OYCy6o8LcyFY37U0aRfPakgASc9QkGi/HL18AMqx6sn5
   l5OeKU3E7k95nQAwlMJmvQfvP6qmcsqkokcX3DCmjeGV7gD08VFH7dtkX
   6vzTaEmomv48jL5QCj+YwsJ9nlqygYn3+ERWp6ZO69XNXcX2Ea+CPbV1A
   w==;
X-CSE-ConnectionGUID: jCY+NhGyQNOhUSfkGDD8yw==
X-CSE-MsgGUID: SFK3RdF9S+i6h/s+yePeww==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="84232355"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="84232355"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 00:52:38 -0700
X-CSE-ConnectionGUID: 2TJZykFeSO6IDsubwMsWmg==
X-CSE-MsgGUID: DW6xByxtRh+MxXxaC9UHiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="251041734"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 00:52:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 00:52:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 00:52:37 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 00:52:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igd0wEX9cojQogwwT9kWsvKKDCZp2DwoEI8IWMce/xL5oyXkSbkN/cDBliDU3XN01xWybWhFcfGSxjF3ExzDk0nEFLiha/j+bV3JWABIVzlpUXIuZyMK+q/pP849N3Ejx2cpC/Nbk2TwF8Lmco0Bx8DfwaeFFePF/zpf24F/fBk9QWw0W3UxWlfWVj+xXu5qOSwV/hwb1LdcFFn2awtqyTNB/6FjyhWo/MuA6p9k3721TwAMNMJ8JkeJZ/RgVqvc7jj6SeBUhw0EocWvhqCaOOdwKTJ6roah+9Dlpn4a6/X5ZqPapEePOXghak3KLw5wqPoulLDlUGs40AN3R5qceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4x4sUNRLiHa7ejYu5YCYjxV/zhRiNCvBii/bpzV43k=;
 b=yVIW5bFbGPzMU4R5DXQgH8wwptBMsONWmCjCur/nCOQpzOQ3W8YN8jBMvqqOwfhKXNdF+b/a+pCgRxPpc5qtigxtdTXTvF5aUdaXlZRhyW/y4jziZ7Uwstf/YTxpvwmC+OxFDfsm3duaHzr7UlVbGOV241LHmwLD0kHdSdSR2GUeoY8I+Gs15UAB7kk9TDcO3zeIpmr5qFNPFApZNwW5pgfJqmc3qLoX/s05vxIOrmQPgEC3VWhV6JNNAwhcnJf8InoYWJYvaZabNiRTCLYZ10sPaoOXk3oqMP3eeJQeF+tla1YqMw7QDGlVwBIJpGbSj2MjSxC7rys/YB8xFOkMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by BL3PR11MB6459.namprd11.prod.outlook.com (2603:10b6:208:3be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 07:52:33 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 07:52:33 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Ilichev, Konstantin"
	<konstantin.ilichev@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v3] ice: fall back to SBQ when
 LL PHY timer interface times out
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v3] ice: fall back to SBQ when
 LL PHY timer interface times out
Thread-Index: AQHc9OOj2d/Vo9wTUkqV4z0ykBBh8LZ2TFxQ
Date: Mon, 20 Jul 2026 07:52:33 +0000
Message-ID: <IA1PR11MB624101B558DA41A567884A1C8BC32@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260605120734.1462847-1-przemyslaw.korba@intel.com>
In-Reply-To: <20260605120734.1462847-1-przemyslaw.korba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|BL3PR11MB6459:EE_
x-ms-office365-filtering-correlation-id: c7dd7916-1f4d-4fdc-e6a1-08dee633db9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|18002099003|22082099003|10067099003|11063799006|56012099006|3023799007;
x-microsoft-antispam-message-info: V/j0ilsKLuEIWkK0cT8xb2NK6QEdXnozRsR6uxekAdZjyw07noFre2aOLIVH0zkylSVWU0/dnmeFJYA49i0j7WJTPKi3q+aKOZmH+pq1JnOgZf+2jZ1V1oSiSeUSJ8jAUA57MBrbdblKs/br5UGWjlfCkocPmd314bPPKARSRCbrehRCfrfZUEy7pouBWqC0Xj8zul7IHIKJdarZX5eY0wL3zqYx9ID1Z1HSZ8eobqS/Y6a5mD+DxT6wH4PMyBWIl+lDbPkMWhXY9D/qyYN02asi1yKmbfNjw2yZbGpNkdeQDYGzg8aQPq3A/jv4n0fj/xPc5r8XcwyiGH9why3Y8FAH9HH377XK1Tjg6tndhcscEGiXM2bor7lDfhJoZBly7c8PYAKEjvvZU6sd7mCcVDvY1MmDU/fE9pm4a20Pgobm3wvFzGsddDypc8M1FGE4Re/TYAJS2aJ7GPE2lM1TwC3Hh5/7GDuZKZWs43ee7Cdk7HbuxlMtpKeQWPldtJe7XYyppJ7+8c4wpkZHHgzkoZmLjX+QljHzgJg6BXhrbmE4dopg2z/xumtt7kdQAXjokU4MDNZXk0j/yTDfEbZoS0w1exYXNLLXfiFvaH/gEK+lSAz5zJhaZc62OMA0T5y0Ct+KZFlixPt7qqU6OfSF9xWUxzbPTj/i53dH/19GnWYuZ1H8ydOPHfnIGIkW3OK6QXqgFqqPI4ys3qamy1KZZyqHSmVAX57g3vLbI7BOftE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bJKNJ3zlr7b5mIaCWPe04KvyVne5QNg+e9ZTbUA040cHYt1YCMmMS5rdigKd?=
 =?us-ascii?Q?BmEVupKkuBKz584v7TL6EOkaYrfBJaYqcRFK+hPrOdSHr5yF5eWG95akTMWp?=
 =?us-ascii?Q?7pmDme6420AFs5ToUdDKOgOZ4zuQ/Vw63tVXq6QmkLgchMmL3Xx1szvtk3s6?=
 =?us-ascii?Q?qZpVYZ359Ezr3ZXQibGZb+ZYkvSXyT4VxAWU82zNeZc7o97cHUmYH2GS1Y1w?=
 =?us-ascii?Q?2E/o+7iU75MR2/6xXwUDD5VSigmzw0DqZ8eJnUb3yyuwaHVcnx3QS7gUSeXb?=
 =?us-ascii?Q?E7LzYhDgrJHrOXAPyGyAoSE07+S2++j3LiO8XLyqLIbPz4g90UjwjciSTog/?=
 =?us-ascii?Q?9+g3ybQ9W/hch9il6YP+v78r4okGt6oYNLxgdJxJKHLlV4FdkMxiQFMmQYAG?=
 =?us-ascii?Q?VwaEU8DTS9uuHfYdz8YL9T6CH4KVtDiTUmbi/EUm8PlukNcWXO2RebaUnqc6?=
 =?us-ascii?Q?8Xh8T4bp1OEWkvHTdEyTFhQX6i+GtF0tjiQR6a8JJgqvNekl/OUDaBFmhtAW?=
 =?us-ascii?Q?uXzuLQcBstfm+2s/QF0psy4emI/kRodtLm7PVX4OjBg5rHJM3E1/DOlT1qSC?=
 =?us-ascii?Q?5hHoCzGLZC8h3+wK/yJLlpdat71c/HXxuZN0lBGG9GiZxenwQpqkdrZHqfgT?=
 =?us-ascii?Q?NFSXmEc1YHQ12p7seQ0jv6Qbb6PD6lu2Ub67fGvSgMVCWjQfHaimGcxXP6bX?=
 =?us-ascii?Q?4IDNIl7Z1Ok61/aoRJS1flMq5qwjrtwBLpmwKM1drHp1ZwY+8tmYYiy+JlWI?=
 =?us-ascii?Q?xoQLMY4epKSouzmI5aVbPHIxODu3CsvHxIi2YAgkVFU3z+hjlT93EJv/WUD3?=
 =?us-ascii?Q?NtjLRTUnXzolu0wN9iS5TOkklMLckIE9Ubg1k0B3mXCNVQhNdabu7GPSIgp2?=
 =?us-ascii?Q?KkaSL0aJe7z8ltUrXQUlWOawc4k/t1yO2dH0IDJfvxjJ+GMhzaBZLrO2wLHS?=
 =?us-ascii?Q?Ksrw1xzoQmir9j0xiL0nVIvJvU8XTtb2FFvA6efAGxfwMTgLW3Xp/mRIbd8Y?=
 =?us-ascii?Q?MY84wXIdjnDV+Wrp0iiTvHAm4cCvPQ7QQ1Zc8bUsDtfyBTZYbcdFl5sszHhs?=
 =?us-ascii?Q?Mw8ML+RQhB2mVn/028V3Nnfme9DXV/MsH3NEgL56h90mlete+u+BB0MfJZDd?=
 =?us-ascii?Q?5PfS5cVUTBYBbH9f6E6HJdMOcAXcFpGZSpOwdfagbxQUqI1jTDpyN76+bOns?=
 =?us-ascii?Q?Gkm6/cWtED9cLf9YLx4WNhWBnbfaGgJVGIdyhoGsqZCvPOOUbLG4wawG/ZXV?=
 =?us-ascii?Q?QVifDoG62eo3bxEe6Yum0QaRcVQ/lPkMeeyg5zg51+g3DLfuQNYQYFvYEuSz?=
 =?us-ascii?Q?SJkVfmrgedI7lLyhd17IaULswvMgUse9LKTLzXq6LRNYxGcLuKfwceKFqQzW?=
 =?us-ascii?Q?VHNLOxBtb3/NQA+5k02bqgwB8mnCGEr3kkp11vEsx79kgELXWU6S20tD6xpV?=
 =?us-ascii?Q?oGolvY/01GwVlgWIUQ+IafH0mQwJoAm9Z2GwdJAqe62osiF6HkrO9nGqHkbm?=
 =?us-ascii?Q?VW/0FB5akinrIDDR8lFySM/zAEv3PJ3mj2EEbvWXYZOaXPmVYNNBheOxiC6s?=
 =?us-ascii?Q?02zVIBszD11WFm2zy+WCBIbAFe26MOW0QI4jkq7S+Qe2KpdcCy4urz79B7Ae?=
 =?us-ascii?Q?/pM7efCWpY7P0Sn9f48dfSs3i5MJwuthmvsZZTO4nyWI/MhTOZpIlvivQWMK?=
 =?us-ascii?Q?ld8l2SVwT43HpYFdx2yrwiYEXQAGMnDLccNWb2qhl0MtEqD6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AHwpbCIT7+lhTExjA3UOGHqFszM598pvVbifapZX27LRNXzms7t5ZiKqZl2T7sjYkzIF2TwAf1o+1OtgScczaKIso2cgiweRyB3IRuAj4jKBJjhvJP8cqPP48wY16L7BSTW28bHvQPvX5EgwMgrUKXAfCpdVTd4ZhTi6sVO3pbMW59CX7CSqKnEnysEWqbhGjE/e9xKVP6qS7VzMZ4SgntiL1zq3InTQOQred7nLNbBo9hpwLJE+blJoqxdRGaKvngY4mrl1uxR/rcKUUNCQJhgpVvSVwGl7JDWgIHFe3EWssMDgxPR5j8Goy2zmxauVIQazzoj13Z+GkH6j5emTnQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dd7916-1f4d-4fdc-e6a1-08dee633db9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 07:52:33.4956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fGc5vCvbV86XV+dIrm5V052cmQtoci9z7yXfdqkOyLpkmFZCj5QvEy53G72l1cgprOFcMvJKSwGHyNWEyFz8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6459
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
rzemyslaw Korba
> Sent: 05 June 2026 17:36
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com=
>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Ilichev, Konstantin =
<konstantin.ilichev@intel.com>; Lobakin, Aleksander <aleksander.lobakin@int=
el.com>; Korba, Przemyslaw <przemyslaw.korba@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v3] ice: fall back to SBQ when =
LL PHY timer interface times out
>
> The low-latency (LL) PHY timer interface relies on a tight, atomic poll o=
f the PF_SB_ATQBAL register with a 2ms timeout. After an NVM update / EMPR,=
 FW may need significantly longer than 2ms to start responding to > ATQBAL =
commands. The first PHY adjust or incval write issued by
> ice_ptp_rebuild_owner() fails with -ETIMEDOUT.
>
>Fix this by falling back to the existing SBQ-based PHY register write path=
 when LL times out. This makes sure PTP is initialized when FW takes longer=
 than expected to come back online.
>
> Steps to reproduce:
> ./nvmupdate64e -if devlink -f
> Update E810 card with nvmupdate64e, and observe dmesg errors:
>   Failed to write PHC increment value, status -110
>   PTP reset failed, error: -110 (-ETIMEDOUT)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
