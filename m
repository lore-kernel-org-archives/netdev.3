Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E11C3FC5CF;
	Mon, 20 Jul 2026 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562265; cv=fail; b=fR7f9YQBX3qocLZdyeO2t4gWeemhN7Vb2iU1WiZNTcgF4hBHRpqXNydldFK/zXpZJKQildGFGGm21AQMg2OwRjiWAjkEtoKios9RlAID4JACEj3/sA10Hpg7UICY09Ompf2utS87PoTblLJsZl9ZfS3X06/PLqK0ZyolzBoeCT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562265; c=relaxed/simple;
	bh=KBmu2C6O3fiOFCsH8BQM+7uWNkyCfgw7oS04Zr/LUyk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pgd4upnlULVtFYIvqMlNQPO3JxXyJlKf4eqMGItXwo7fZzHLeCAbBhVbiNrMROxaWi7PWnhjPQJI2gV8ott3j+ixSNLN9d5P2yQb8ItJTlSKNUlUJFriK6dPt7bx3NdYmypeDLLh7HZrc72YVGJHI+DYA52n6tkUHQyS7JiXSfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=MxGwI5td; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="MxGwI5td"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3vQPfGg9LQsZa6UogKMgT2OXDBd0VCG4vr+Lym3XtQjA6JKSb7/kwYZv1JAc4Tu8GbIw0MEhfX+2kjz/wmxMzq95PrDmnvUB2UC2bqnPY8OwjZsbtDJZVVjOf4IDrqTFVaj5FvhWGFLyBE6kZklIIELXGnzZ5ggHYPbZS2kMx6Jb1egPQOcaNJgreOwdwkw3oD34vrLNbnHqgjRZr3i82A6DVA/9RqGoN0VEUkcc80uVhtC35RLbRNksMLIifnHNYAqDkL/PfE0zN+6ZMHjRoM880k6Awz3F/41oVExe6PScLSnrMLAiQrZfIQDoTtrXphyjdvaJRVmUkcvJG3dgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYVpYUlauynqMGPtR4FkXZznsXpErU7b2em25M5s/6k=;
 b=yUAHUGoLbiLkIIcmEUfwh3dz2vO9cKHIkTEU1P64ucE2XdDPjH+yn2dGWv8yeCDUCA6BRJHbEaF8rOUZEcqcEP6MLjoIhItkpT0p5gtzEPaLdSWImxn5jcEQlUwfZVGEpbbJPgivZJYjXsLL8MBC0l/GqQ6QkUx3QS/e4KZixByT9e86H0O6BsrSG3J5k6h2DeZCap1dr0PsxEzcWxAwOTaBEjXi5Cce5l42PNBs4FVD+T5B/xkbv3Tz89Rbgr3v8366O8QqEC8ZbJUVxm8RFOTur+NHnMweQ3emYPk2YdrW3dmYzp++lTVhcutqVcCUDOZIYWS8/T2rWe1PSPgPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYVpYUlauynqMGPtR4FkXZznsXpErU7b2em25M5s/6k=;
 b=MxGwI5tdAVuScdS7hB4sq2zhouC1WLQPpcDGu2LixySzoL3ty1vJv7YGgb+zzVRXRODRleTNFsK1jWEhLquEe12qTZramf7YXd5v16sjFzFCsfF9BjltSY/J14f/s+Xx9VTM4yRoKvzAIfIxZKaExwvgByzaCiVv6PP0+wNLaxh4nEFAYPjJLSEAbwBWV4l65NXZwaIKKPBW5TMI08vX7hvVy02DFI5e0WFmf6EOy4dhLlh0H4JNsQTnbFhd1h7Vs+LbCx3sXKnwzalRD8a8EX5g2IwbXPsbVro273tBS1V7ZwSnFj9ue+ehitgWAwYNIT6ELCXjJYxNOsSDqJ+v1g==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PA3P189MB3332.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4af::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Mon, 20 Jul 2026 15:44:20 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0245.009; Mon, 20 Jul 2026
 15:44:19 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: Xiang Mei <xmei5@asu.edu>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, kernel test robot
	<lkp@intel.com>, Jon Maloy <jmaloy@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v8 2/3] tipc: fix NULL deref in deferred bulk
 distribution on publish failure
Thread-Topic: [PATCH net v8 2/3] tipc: fix NULL deref in deferred bulk
 distribution on publish failure
Thread-Index: AQHdFpd2JBj4V5rUCEqU4jp+eOKGSrZ2j2BQ
Date: Mon, 20 Jul 2026 15:44:19 +0000
Message-ID:
 <GV1P189MB1988C74C3A4DA54B45B55DCBC6C32@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260718092544.785289-1-bestswngs@gmail.com>
 <20260718092544.785289-3-bestswngs@gmail.com>
In-Reply-To: <20260718092544.785289-3-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PA3P189MB3332:EE_
x-ms-office365-filtering-correlation-id: c3362e5b-789f-47e2-48dd-08dee675c36d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 5//ORF5FepzsGxcTIfJm1T/yUVk0rNflHRc0ToOAZxpuh8KpKhNi2iADuHIkhnM7Pfwt4wfr++spfiOzaSDQt/J7k/ZkjS3tgtOSck0CavUUJXHhN5jliH1JzKRw8lPSHF8cy7/7Xx/WTNpI0J9ily+WxALtM8lilngzr+ouRBiVtyr1BBfpkuq9SctBc8D/8TaomBaf62AJ/0OCR6VAH0APKSuFm7KI5DF1fOHDjycRmydgl77IInI/PEjeD1LOrPfk6WBi9e1aJTOQLqKe6vdz/gbjPeqqj8tDeavOCS5xhfMe3OrqWOXe1gN1rEdPZQjKj524lbDDw1k7ahhCOya7p6Jb3iwzSLgGQyaKAdvW4K484SwsZH/bd0qIDlRV0XL4D5QBUdJNGHQG2uwOde/6puWcVU+H9NtrUYWyugkwttoV/AVvf2PQ72Rcj2jeEfjZRQ6i1YwkU7GNNepd8qF8V60lbLepKvSbdPlx8AdUwMxM4bWsGvvDz7cUx3aeMeR7EVuFww0QToDLygO33r7xXIGyIOCRsQLq4UNe87nl0FGysoEVKSEMt3XW0pXFY4NrHuNW6KyRcEL7y3bwSR/reN4pJrh5pu0awS0eKtksWUspiSXSa0dYuDK11AHXaMLJsCbOhkqCPTW1tEujvai4uY6ZBueJ66497LQszvQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vnQ4PASMMvEXGWmbX9sP9H+wFvD+x9/pYUPYAWdjCqMj/GHkwy8AsOmtuysc?=
 =?us-ascii?Q?o1vIAZNXGaiavw9KvzaASzs0nkTa7S6eNrmgNBfVwBXPzsxZFHM1P4kApc3e?=
 =?us-ascii?Q?zFUyGQE5ryhq0/OlefFpod9lGINx/1EJucVdazzMPpOjMsXoK+Brgm7mJ1bc?=
 =?us-ascii?Q?5M7Zc6QYWKKb7uWKt9jcaiYfdCZ7TUnUSOEWAlCMQNshRjw78IFQ82rVKqBi?=
 =?us-ascii?Q?HBZiU7zoYVwsQp7so+Lox7G7XfsEBSProht0MsVVFZWc/NY6rRocQwYwcCQu?=
 =?us-ascii?Q?RBd+0RrrXLnAkC8dT5Hge0eTBhbM+uBiQ38fu9T98w+2/yPcvvYhMc0ZnnjY?=
 =?us-ascii?Q?zzL9ufe6CvMcgcvJm+PZWO4YM338VI7y3sD75k3nncp7Hsm2F2SVp9UhauTI?=
 =?us-ascii?Q?dQ36fNuCUSdqqd27XHktaiSRQBfyTlUz3tyVzNqTkEV5l34wAkNzGwnZ9Iuv?=
 =?us-ascii?Q?1IJPwB47bO4B0+gMfeQe9w1huyEcq2QSg4n2PaLHpMoJsxcqlYoKLQ4f85A4?=
 =?us-ascii?Q?7i84WOxDAhKfHOK+mW+qVez80bk9i3onI/t8uByLTZ6jD6dNaVrVHPKtixKh?=
 =?us-ascii?Q?IcGKzoRkPgT6vu/xgSBmSNoqiHRngzhogCBAOvPa93WVI1sVxjYZLtg6gSwq?=
 =?us-ascii?Q?GaOyNleV0AWBDJdBsTHQzn3wrTGhIhhCxasxkiYqdX28/U4yeEQnGtTQXhNy?=
 =?us-ascii?Q?roVRChi95/uARcDH4lThoh4mQgVgG1ZnE90K7899snQjDWhibMLUoD0MtZgo?=
 =?us-ascii?Q?J5WN9YL8XTpJI6wfAjL9jcJfYHdmvoyEmd1LAepGeRYqB1dv7pevMb4uEAxi?=
 =?us-ascii?Q?+CWoe/FeZdJX7v8Gnw727lROGoz0mrGm1iX6PDva8KnYoWHmPbf5BzSdPj9r?=
 =?us-ascii?Q?9gOoyMwxO416/SJ12rFPpZWY2XiaEKv9duBmnb5r29j6UIu3KvPxP+stArDx?=
 =?us-ascii?Q?oLrpQnqdy9pu6NadKkMiEphQg36hWJxeOmtcYlhYnOZr/dpWP2A+UnSg+6jz?=
 =?us-ascii?Q?1LbjHi7ykecvLkSrBNdJkccW86GcxsevV7cxfpFMbgDWhcSh9UcKgFujN0Rp?=
 =?us-ascii?Q?1OGDCP/NqInKSNM56FG/Q5RVIkpZZ8GKfiQydRxv++oekMRrx+m17XvyGHbU?=
 =?us-ascii?Q?k4dd4DQdNKtb1YticJrPEN7wUNcPRiXf6C64aDIRnX43Kza0K2wPfcYgoU0m?=
 =?us-ascii?Q?UT3FIJaj853x30D3MdrtAYJmmD2sYREbLtqWSBeFQzZxHpak4+/VUm7qRQkz?=
 =?us-ascii?Q?pdPGiNCdf0mofvkLrKtkjrP94D4GK3o1OTHutomfTVuIwVFF7CkcuZ1sCbtW?=
 =?us-ascii?Q?Vqs8blyy9A3vUiiWU6SDcQ3tnBTiQIvr6UFPvuY5fiW+esf7F3xZaPhneaHS?=
 =?us-ascii?Q?r4lvgVqYibu1jNV3UYs7LXKs3gNxE0fKeqZsyXtQe8VXzq0HQLs+6TVg2Ifv?=
 =?us-ascii?Q?LgJLGKa1xbk2cbahGZCkbMtXI5MTbKcF1f92xwadHIzGn8gjXdnJqixPyUIB?=
 =?us-ascii?Q?C3AjLzms3Ba0X6+ySTy1+57u8vbXn8XaZ7hVUQZGwbZYk7Qo9UfwzcgaNdEq?=
 =?us-ascii?Q?h+LQij7gdSReC22WsjmjlmEXSEs01gylptIzsM7/tHRaTX9QZrcbw1E/7DRC?=
 =?us-ascii?Q?JjS+MlcVj9Iet84VlSDZWK+0LeX3WJHJ5EWgQ5vVa8CUceUdRtKB4cwNIERO?=
 =?us-ascii?Q?1yr1YrtUJTBq2Bcrkw/WWAxi/39xDUE+/qfVYnGO9FZIeaeSQU0wj6D0Sde0?=
 =?us-ascii?Q?VWvlUlhnqg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c3362e5b-789f-47e2-48dd-08dee675c36d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 15:44:19.6976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dY7Z7D3T4ycPYnDmkG+sad0E+6yPJfJ94Nyp+x/KKP3UN7OHqy0+BxJZr0kPQppQyiSiYzOqBtDCsrHoNwZ1RglIpNXLQZutfGf55XgMMos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P189MB3332

>Subject: [PATCH net v8 2/3] tipc: fix NULL deref in deferred bulk distribu=
tion on
>publish failure
>
>tipc_net_finalize() does not check the return value of tipc_nametbl_publis=
h().
>If the publish fails, for example on a GFP_ATOMIC allocation failure, the =
node
>state name never lands in cluster_scope, but tn->finalized is still set. A=
 worker
>deferred by
>tipc_named_node_up() then wakes and calls named_distribute() with an
>empty list. That replays the same unguarded buf_msg(skb_peek_tail(list)) t=
ail
>stamp, this time on the tipc_node_dist_bulk workqueue:
>
> KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]
> RIP: 0010:named_distribute (net/tipc/name_distr.c:200)
> Workqueue: events tipc_node_dist_bulk
> Call Trace:
>  tipc_named_dist_cluster_scope (net/tipc/name_distr.c:267)
>  tipc_node_dist_bulk (net/tipc/node.c:403)
>  process_one_work
>  worker_thread
> Kernel panic - not syncing: Fatal exception in interrupt
>
>Check the publish result and warn on failure, but still set finalized, oth=
erwise
>deferred workers would sleep forever. In
>tipc_named_dist_cluster_scope() re-check cluster_scope after the wait and
>skip the distribution when it is empty. This is a permanent condition, so =
return
>0 instead of an error, otherwise the link would be bounced forever. Also g=
uard
>the tail stamp in named_distribute() itself, so a caller that misses the
>precondition gets a warning and a link reset through the existing -ENOBUFS
>path instead of a crash.
>
>Reproducing this needs an allocation failure during finalize, so I verifie=
d it by
>stubbing out the publish call: both nodes log the failure, the workers ski=
p the
>distribution, no crash, no link flap.
>The normal path is unchanged with the same two-node test.
>
>Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Please drop this patch because sashiko reports the same issue for patch 1/3=
: https://sashiko.dev/#/patchset/20260718092544.785289-1-bestswngs%40gmail.=
com
