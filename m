Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7264416CFA;
	Mon, 14 Sep 2026 23:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426865; cv=fail; b=SVmJos+DGzbV9j3SKUEw5/KPJTKtylUO820y6+JrnLAHou4gVoIXqKCQhWgZ3ehQGlBXzgchC5KY2iX80ayt1bJsCnuEPC8N/QeibOQVsEwN+4aW6pmMu4g+UF3ZV9MzFj4twdu7SVfoGIwAIhQBfX36F04qqzBEYDCmv2fp8Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426865; c=relaxed/simple;
	bh=YBWcAVmnGFUPo5MxRia8hQ6V21BzDRV9k0GPhx036CA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QcXa5MUyYjrOwcsXi36kHCnXo9qSIsJn5yAP7II0hoD7hE91v8Jalnkz3vlpDtsP9qm0BwEZMGmbSalqCdkkHiqwhJhIiUgGtkpg+qERstgmuKYH4V75PP+2fQYydGxObeZlYqBdWXDtepcoFA+ghYMOTqa2Xa8XxU7LFA5oWYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=NYr5BPlS; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=yyBhF2mz; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="NYr5BPlS";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="yyBhF2mz"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CF61D601F42;
	Mon, 14 Sep 2026 23:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=inVGyKNwEwV7mBHDzYqXfDVJYyRxFCpHJDGd60SQge8=;
 b=NYr5BPlSwQGOQm3jtQPLXNCfASLdOjWyRruSvsx6Jq7XQiqV0kmoYTTt9Xt1igiz2cCSY0d/5CmkkhwwMo4hK4ThJy2bHgDBuyVSe4FRiXCcE+5sqXq7lCfdmTdPIQ4MkIRntckIvqXDEwtmVpAh/5h0JsD01Sh0u2+EpMSQm7paYBK+pyOXieTRI+vjaQzcpy6VT2WoTxowlJ9vOmONnLkfYIJZmh4nH+AnaSxm000HA07PRudU9FKisjF1Ca8l0hbdQrCOzsBZP6FTiVs7PS3S82XQYNa4QcsftUekC7nHCRvg+SVTMgfaHlv7VtKipyij7cY9zt9+9IgKYW0H4Q==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021091.outbound.protection.outlook.com [52.101.57.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id A249B900066;
	Mon, 14 Sep 2026 23:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCRezs1f1bgsTtITdZICTxwBEgQ2MeK9j4SPkYTs5PcwfuAv8XRQypTak/m602LnK7H2Q+SRWkaB/cKLfQEiLY3yZCFB38fYHsVeX7gDE41SqIRYe8KiDp1y/M3xhSIq8Ufkuy6tLaqkodDUa6U4POE5XxrFemK3P/OdZTkhjcccWi4tQQ5AmfB2lHdEv5CQKw9eckk6hMhIvpsgrb5SE942bCAGujiM/7wKZr1eBQTjRXzuVfAPD55LYC32wyF4G1oP+eixeDak5iMwunqEMpGf2bPxRkzdgLlfrlzeIxiER8FC9W1ArMRiu4iIzB01to2uU6ovYIh9HnzN9VqKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inVGyKNwEwV7mBHDzYqXfDVJYyRxFCpHJDGd60SQge8=;
 b=Jhw4/TKTn3C6AhKTGf24p4334OL64oKW3x0Z/7GC2oF1abK5yZhPiJ+CsUvRQe8d1KcgujtDc+YXDGyphSUwlTt7DaWkzzQyfCONQhXfwvUkP4gQVOz7wQFVhwWDzR8gx49K5+yb4/M0OhdlrYNc+/kJ5CBkYr2GqZDzkP9FIXKNd7Y663QWMNi6dFuheIOlRjxtH89M8hscpEviwreNgpJdMkgSv3eCYIfCCsi+QBo68bZ3NDMnc+FshoalJB7RZbUUtgKIN5ie32ETEUBSEsT+SWzwmYdbYogVgLFclbr4pAXILgfdTwJAv3fpulvgRHt+4r83Nfwl4zDhv+44ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inVGyKNwEwV7mBHDzYqXfDVJYyRxFCpHJDGd60SQge8=;
 b=yyBhF2mzPOO5wRaFyiTzohgU/V3SPjLeql3YTchxBl/73t/avKIwgWmHk6IKdBB84/4VX4UltnFsHQ99D8aOK7oqbJDw5pdDu5zcHq6l8TzI4j1J4nYGRno/GgpLkxRm/Et5/SIS/NmlA0LohmBp6VAdKR6Oo/l+MVKqoPuwbYoQDJE6ENkF70Io4Jvh7vGbeaWFfm753EqCuedd4cQhruzo5sYLM/TxqCLR0JpaHfX4mGjCxq8DPyj6gOGfwdZpgII/1OO4ATrhRaa3wKPgDTnq1LR8oT3WygKjwvd0v8cHf5U0DMmlS7rO0sAyYrte2wp6en7dmIDIAx85EfFDTQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB7131.namprd20.prod.outlook.com
 (2603:10b6:806:3b3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Mon, 14 Sep
 2026 23:00:44 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 23:00:44 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Ali Rouhi <arouhi@sitime.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v8 14/15] dpll: sit9531x: model the inter-PLL
 sync net as a pair of pins
Thread-Topic: [PATCH net-next v8 14/15] dpll: sit9531x: model the inter-PLL
 sync net as a pair of pins
Thread-Index: AQHdOyOxiUDGlhbKx0eOlCCv0G44Q7bEqZIAgAoZ1gA=
Date: Mon, 14 Sep 2026 23:00:40 +0000
Message-ID: <20260914230034.63861-13-arouhi@sitime.com>
References: <178887152869.219967.4994728950594018497@kernel.org>
In-Reply-To: <178887152869.219967.4994728950594018497@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB7131:EE_
x-ms-office365-filtering-correlation-id: 768347d7-2649-48a6-5e45-08df12b401eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 ceubaBeCcrTadaPZ3c2Yf7DAwnrvHnDT84pXf4AyuD49JPyd3JSqpfLLz2ic6mTzcy6AopfY7OdpddpeWE/OsMLKuXseX0pNxlM9EKSbF5PQbYiLjySrux5cNMItkYcAbrQIDGzLxUIzW07ddBYcKskz/4KktZzYo+yaKtXvxnC+k1+XCo65MUMQJ/0YSg0/0hi2N0WhbOy5U3DcJoBCcbyb7J7hhlqgk+bxiYHr3UG2CPchG3y48BZ+or9SkvCIKAEbKbViFj19Pis7eAPhuqieNfcHCPVlL6XWNZvFaLzm+Vt7mc45IWALxXnuiDVvUX1FtyMcc62eDE42woNEDdxyKXuXjIhdOGbNvG40wFpUZfaFspdtthrjxe8f2it12AYg5/fkM3J/iwVTWTeyWxMxrNEqIMT6iQy536/ZcsfvBIzQ4eU8gveg1kNZxojbNy9UX7ltUInWIyNKI6xrIbzVhQZViuFfT/1uo0ZTLC8roHgDfklb+oV/QzcvMrFlx3yIMrWfaw27pYLWnLohQKoWwWjtst1C5NFv8ryIYJMdCkMRb8EMSJOQnQ8SOm6HDxJya5jNByE+aSq0ruxyot6+TCJG8496BN3tSMQy05nuys+s++Vjmx9pmQq6kYhWBP9565UAaZiOIrZddoDclx9DtPgRf47UnfmPwpUe0djDL+KqBq+zhEmW4qdTWynpBCWADKP0397w7UJR0jp2/BJFWDsya7pNwzAZCVL4tyk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?I1n5mWd17FRbnT4G9qMONTT3v2KVQvV2mI8yCk6niRIfPlqDjULMd+GK8r?=
 =?iso-8859-1?Q?2hyh+IdfKE944Xkcg07Zumb5SILKFjQzZ91jN5xWTP2LBaTOcvihwQmIUe?=
 =?iso-8859-1?Q?fxe3woPsQw6KgD9vUwdLitqoCwO+Z2uTLUQjx+GHlkNQ4XFEMSkHtqumMs?=
 =?iso-8859-1?Q?zGuJc0TGGmizTndn4JCIGiGnC7thWDLFXwr9BqLvnKPfsrxXRrPYbXRbfw?=
 =?iso-8859-1?Q?ubWdd/GoVKzkET+TX9w/hxrLW1WFsdbUmloetQK4/e9ujlcblabk/dakCF?=
 =?iso-8859-1?Q?1NCp+O78tidxzOZmuApwETDhRpRII8VbNKCRubBx9aUpej63HGAkF25mOl?=
 =?iso-8859-1?Q?FHsR013k0eK+A17cQxTmHf3QHBK9GcGYbwhMSKf2WvG2ja1eEYxFUw0T+Z?=
 =?iso-8859-1?Q?x8vdQtia5JQP1q1YHns+ULDMq12AR4XJVxm54xYeurAg4FETsoA+/8+W83?=
 =?iso-8859-1?Q?AvzSYT9IFi8usdcGfu1Lrwjna5tN6vyF8v8o3Uj2ACevptphm3K0jndPGg?=
 =?iso-8859-1?Q?p463y25D09Uwk6T9Ko6U35gLnxFrbfKhwYCvSnEJBrl1ArNBf2Y9XCsBz/?=
 =?iso-8859-1?Q?yvI/eXJbuquPzobFjpcdaRnZqQC9MrEzgyR2xnDDugRvUbHhfPv+fqG/QN?=
 =?iso-8859-1?Q?dBspzeHZ6tMoR24XbPrkdxckGDulAPbSqSuu8RoGPd2OFuPRCjXwrg3nW/?=
 =?iso-8859-1?Q?c4ZTcK1kKz5t3f3CIqHqyGO9I6cWMAFxPvX60a11jqpW5c64RTbMyW1Wt8?=
 =?iso-8859-1?Q?PDNEhJhhvjbiUTbKVyS80VSOBrEh8A3BZFbCfgq12neRA1rSxPoPe1y4lB?=
 =?iso-8859-1?Q?lc3JYPyFs+528gHCFfWI8NYAyD8CTlFa+HzOV5rY9hSENgsSlfZStDgd6z?=
 =?iso-8859-1?Q?TmppHpuYBTd7ob9u5KbSDSAzAKQz64q20jFvv9MA5kVdVjpAT/Md8aKr3r?=
 =?iso-8859-1?Q?6o15SUQ/jtUfa3NZcqrnbdB6QQ+J1R4r4tmzr4xr7FwxxqQCf0NITHo3Om?=
 =?iso-8859-1?Q?4kJ+x1x6a6zxW2BF3+T/cd1mQeFh93prGq13smJCo6uzMOxCAQ0lARaRad?=
 =?iso-8859-1?Q?HbUZnOxChHjIqJfdyHheOQ+V5Dg5hZSB9r29qOlLUzqqk42LGLv7fy2KS8?=
 =?iso-8859-1?Q?KkbhD8j89fjCvAxdYVgGnOnpRwpKRQpFShXn5cDTMFHE2/yCOmtywPVjWt?=
 =?iso-8859-1?Q?jPtDdOlqDvI/KSg3USGQYHAmW85Xonhzppqas29HB1K6Wt9gPAD6DBKZWZ?=
 =?iso-8859-1?Q?TPsjh5z4RBfpymWlSukACsA43UY0zR3WzyxC5Ng+O9WtRwnrMpyB+I98IJ?=
 =?iso-8859-1?Q?2N7dnDTESYE1920XJfESFhnsNC8Ov04W+Ci44suE0tHTfPSDwcDJ1FpYRO?=
 =?iso-8859-1?Q?LdQYmK0dNB+6FIsFHvssDKHhM0In1/SwhBtFmNf1+uMthGsbRB3G0teg2r?=
 =?iso-8859-1?Q?6xRVmQLIYfTnzntq8yTtKDVu34KWBAwCyw3JBOi7/vz7FPxcOk50uR8U1Y?=
 =?iso-8859-1?Q?lvtkLKs0DBOujWD+OL1nWwK2+CEzccaIjQaUPlCVfAQeePMgCv9TkMbUx0?=
 =?iso-8859-1?Q?FDXtn8SFvZ0WIMj5yAM/WGw0PHoPgtXp7aoTP+N6pk5ikmPQVOJry80w51?=
 =?iso-8859-1?Q?F1dlql3ug4Y4IiiSNNwn/5Rno+5Vrto7DGqiCgTANWQ+crm5bW+FmRYBTa?=
 =?iso-8859-1?Q?KvTtVnP32nv1iJ1l4tFoI5eNG7gYQQ6080831Qc7CYekPaM1b/te+zG9ua?=
 =?iso-8859-1?Q?EnCGNdLhfGLv4vvDg14iEfAFzoYMO1vKD8nN51Dn4Qsnaf?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	o+LS4doCkNJtk/et4mOfFBO13/5eJLb4jNgZvvWZHrRPwV+TUjyf5Xf+yIV0Hw6Q4VyhkE8PhEfhuwf9EeEwFUBeQgm8iAwAaHKVc8Z7v6Myz397BKBtuGO+Gsdu8L8ShagzE2p0edkAR7ZKcYZIFIdiTtOQ2LrTSP7Q+8r2fB5L45cGSODM+Uwydwbo98bLfGYOtlJi2fpDjznWqsEnztdX0cS9Pg9aNLDL0wRlrVIRBvqE+5EHHTA7TCRROCZ2XhAZKVdcUgvaPVUocPNUrEuATddvyLzAQM7MfzqZ2eeQfQCazXj/SFZmc4iJZ5AogrxkQFnS9uSQSZ+AzsOLlw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768347d7-2649-48a6-5e45-08df12b401eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 23:00:40.9834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFtf1Py/vYCChcHXDkYG3rJORhWAuGvtMUOtdGJq0k5/bpLlpEE5R+Ra2KHjvNdTYLIWVlzLIqE6t6FWAr3BgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB7131
X-MDID: 1789426847-mz936mwUZw7L
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1789426847;mz936mwUZw7L;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Replies inline.=0A=
=0A=
> Can the bit be stranded when the rollback itself fails? [and: the rollbac=
k=0A=
> writes dis_val to entries the aborted enable never touched]=0A=
=0A=
v9 logs a rollback failure explicitly (original=0A=
error and rollback error both), so a stranded enable is visible rather than=
=0A=
silent, and intsync_src is additionally reconciled with the hardware at pro=
be=0A=
(see below), so a stranded bit cannot survive a rebind unnoticed.  On the=
=0A=
second point: the disable values are the documented quiescent state of the=
=0A=
INTSYNC block, not a restore of arbitrary prior content -- the enable path=
=0A=
owns all eight registers, so driving them to the quiescent state after a=0A=
failed enable is the intended containment, and it matches what a fresh=0A=
disable request would program.=0A=
=0A=
> What state is the driver in if one of the later ones fails? [partial=0A=
> disable keeps cached owner]=0A=
=0A=
v9 clears the cached owner as soon=0A=
as the authoritative global-enable clear has committed, so a partial disabl=
e=0A=
leaves the cache saying "no owner" (matching the bit that controls the net)=
=0A=
and a retry converges instead of short-circuiting.=0A=
=0A=
> Is intsync_src ever reconciled with the hardware?=0A=
=0A=
Yes -- fixed in v9: probe now detects the INTSYNC state from the=0A=
global enable bit and the per-PLL EXT configuration and seeds intsync_src=
=0A=
from it, so a rebind (or a blob that boots with INTSYNC active) starts from=
=0A=
the hardware truth instead of -1.=0A=
=0A=
> Should the policy errno be excluded here as the two peer setters in this=
=0A=
> file do?=0A=
=0A=
Yes -- fixed in v9: the filter excludes -EINVAL and -EOPNOTSUPP like=0A=
the peer setters, so a policy rejection keeps its specific extack text.=0A=
=0A=
> Should the hardware's current selection be reported through=0A=
> DPLL_A_PIN_OPERSTATE rather than DPLL_A_PIN_STATE here?=0A=
=0A=
The getter follows the pin-state contract stated once above the ops=0A=
tables and applied uniformly to all selection-role pins in this driver:=0A=
CONNECTED reports the reference the DPLL is actually locked to, which is th=
e=0A=
same convention ice uses for its input pins.  We agree the operstate split =
is=0A=
the cleaner model going forward and are happy to add=0A=
.operstate_on_dpll_get in a follow-up series -- for this series we kept one=
=0A=
consistent convention across all input pins rather than switching the model=
=0A=
for one pin pair.=0A=
=0A=
> reusing the generic priority getter for the new pin also inherits its=0A=
> out-of-contract return value=0A=
=0A=
Resolved by the v9 priority-getter rework (see the patch 07 reply):=0A=
the sentinel is gone; an untabled source reports the lowest valid slot.=0A=
=0A=
> is that model actually introduced here? [pins already registered earlier;=
=0A=
> bisect window with OOB indexing]=0A=
=0A=
Both points are addressed in v9: the INTSYNC pair is=0A=
registered in this patch, together with the dedicated ops tables, so the=0A=
"model" and its pins arrive as one unit and no earlier commit can dispatch=
=0A=
them to the generic tables; and the changelog is reworded accordingly.=0A=
