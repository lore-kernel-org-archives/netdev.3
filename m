Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821B352030;
	Mon, 14 Sep 2026 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426855; cv=fail; b=HMbTI/dswOl0x2fGCymJuswYwd5/NAAJKQqVMeeitEYGWSrbpz1Lf2O0cA8Y9oPc7Ix3C8KN+VpAa5UXKFRYHyo28nE824iROQTCBHOadbQLkId2v3jVHnbUmFXbylk782Dfk7shGbJAzQcplYn+ZWxon06CZ19d12Zi67/IXEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426855; c=relaxed/simple;
	bh=g1cG7pBLAFSRwahbYPUyIYHK9h77x1XNmylrxgUiCrs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gb8tMIfhpLLvv+jWpaQAjULYybIoWwF1qUv+MOOX0EpHryj4YgvE/psZz+tztnoy3/NbOHFkVvPiXBn7PFGX+9IKPKmZwGlPatbheVa4IYuwLIsCp9pX/6xmtiMNIY+rH2Lw71ky+ya/t4aDXBxhzzxRt1fHjX09Umwl5T6nTnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=eYxgTZgT; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=fYO+WWtt; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="eYxgTZgT";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="fYO+WWtt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=H2+WAmtdSd1cYIk2QCsxwKg16DtClqxv4+fTN8q/8cE=;
 b=eYxgTZgTajHaUWfa1Usq8cQZxceoRUc4shPoibl41J9k0zpNl/CRX191hzuQUu96YU3fnAgpmCbx2CyXY3WzDSXId9qhQt1NgRJJxThKq5fdxuJZ5Tue8Pztjy5W7n6C+KgCa22robibAzUmF980UkNPXJdNbEYdj0dCafxM7Kc356n0FcDTOg3UrLHBkOWXpfGMKZkmDszfSGBf9eWeWmp22l1HB8xA6iXCsLP8GQIsOQ6dE6V3PzEOc/+zkPjhoaFyo03X0NFMjM2tWPkYagrewV20NMDvUrkzxZbAGdnTC9sZNd5efilsec9B/qcpKET9WG31ZFDBBnt6uXnSpQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021091.outbound.protection.outlook.com [52.101.57.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6C5CA9000B5;
	Mon, 14 Sep 2026 23:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PobIHJ1qBkQUUDUkAkCf1zH0GpOiqYrkPqQiRGObmVnkOKrO6Y2wfZQvgWlffGmifHrCaADHqP45QFItflUZLpH34YEDS/gGOQIt1wagIGSZH/P7s5HZTg2sH+Kcf0ShNYMByvukObVZXzfQeGAN5bM/2TZIZ72mcWBI+pkXRdgCXqVyv/uNoIJj/Lfx0uhsBsXJqxQ+1rwj6lM2kSAknqlfj9uS9wZcCw8/UUMIsHX0Hd4cUIiXaAb9NBVjg6TH+QgaOpHTRv3se+qbr84DYYnC2pN7raFsLXjgjgyEr+9+LY0X8ymSard2hWSgjQDzjsFCwh90HzMq7vr/Mn1NWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2+WAmtdSd1cYIk2QCsxwKg16DtClqxv4+fTN8q/8cE=;
 b=fz4b6IfMtsWORX8RSIx0x0a8eP+pCJltuGdoYIYJX8M3GvpitDJ5Ss47nWrwfAclfOAdZGkhzaPacHlVqkonCQ9m0QD4/C2hX2YvF48ED0PWokKAFVD21CIKvDMADmOkQvrOHnAwmzz7Vs6IgJNKzthgeVxmZvJmKiQv711rMwWAqkPM8gqAHAmuUv7nYYk5bQDFcQNeFkYRlNxHUTPzfTMMPYIbKx5cb8pYvgJeD4QaFADJAlLcMPBYtSGSWevLg343pT0WhgglTYRlngXH/J5GDvoFTCct/hcjW2/J2eqzIBBp5/1kG3qvdM5haVafzg+EAfus5iIjPxO84k8neg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2+WAmtdSd1cYIk2QCsxwKg16DtClqxv4+fTN8q/8cE=;
 b=fYO+WWttMhPIV+RC8t5NO1r9c8c5RdOFhZ6hmSQkIu6OES5MOYrqIhcgPNwwl2zWSzu4dLyan7ZYtnkVUyTz5XDRFC0rq0wUDCVQKrNmIvNltzaXT8ZlyHY/4CHmCz98hY5WbTZtoKB5QQEwMdPUCpiuuIw9JZIbNJDELdjMVhY4YI0IOL04frxRcwPswCBQAlKtzRPfeLOGRjjCWtDneUqAl69CYsE8ZqjEdPq/bobzt5dBZctfH9VsSS4F2kMz+4qkZ/7y3J21rvNf5L8yE5sf6c3qrWDX4GRyPOzBg57ng1DIbCw3P9HsygblzbFiXaJ6wvUoF+8SCcB9sdIPBg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB7131.namprd20.prod.outlook.com
 (2603:10b6:806:3b3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Mon, 14 Sep
 2026 23:00:45 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 23:00:45 +0000
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
Subject: Re: [PATCH net-next v8 00/15] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Topic: [PATCH net-next v8 00/15] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdOyOteVjEkYcikU67LBe2iMR+3rbErM+AgAoWmwA=
Date: Mon, 14 Sep 2026 23:00:41 +0000
Message-ID: <20260914230034.63861-15-arouhi@sitime.com>
References: <ee4a593f-93b3-4d89-885c-bdf101212411@redhat.com>
In-Reply-To: <ee4a593f-93b3-4d89-885c-bdf101212411@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB7131:EE_
x-ms-office365-filtering-correlation-id: 4a5488da-ff3a-413d-fa73-08df12b4023f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 mkB+sn0tt5e9kdS+i3pZ7CLGLraMooEnXWh19pvdqrpHP3UM22Jt6+A65JFJdBS4bGF+c5Vv/2R8MJuvDGV8Q8vVTLrQATChAgE2xY2TyGlOY0YFeL6QI1XDm/vobHrEzwywQ1favCtMvkZVlPEDzKeLz/NlQlQ/Ie0RfjdNFdDNKyX4mtDnMJGTL8uVYbWfWD1ngcx/auM2RQk0iWPIFrWL+jM92XQZAMbREUfBi6IaBq2Bp6q8aXQMa/Id3UGqhNj9JLZhkCb2wXsaRIqoDFT9NT5YNJcM5nAwMy2/qy5U7TGJM5t34rN0BuG/Si71bcfgY3Q9fi2vd0039DSNbGV8inbQBgKrBCE78cd7oS5z8QSNfot2eXaB0drZpojDbcm9J6LLOKqXd8GXd3xHIUSizrTcdjYkw/6zSom85ldpTaeA9YhV/ArrM48N+i5vvlw54la4X9VOvYpJ6/ZJSY3J3XBzsbJQswqKkKfgVgYr4z3IIG4IsC3jcDieNrBUDCiVPhCr0WDPPaJ514YkCZEjIOjUOwJJIs6qdojvLTwVYncK0HOSdMRk33izczmB8KGjkW34PG0iE8J02Sdnn3isdHI9xd/F+TrAde7Rg/wQ2tM0mRctoey9a7j57/FJMw7Z4iX6e3h1i22uau8GNWRZN6deoLvKJtwy0RlV8I7WMnkgH4hwTpOBkAeJKWZg5j2ZsjQyJIHvOiKl7FcK+Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fQtJfI4L1gUzBLFc72d0ZbVwMwI9vmO681LMmQKNGCcne66qEtDVwJQaCJ?=
 =?iso-8859-1?Q?VOnL4BZqxKKdVpJf+dzyscteDO2uAOQUdCb6uWh0EjMIKs/VRDwbkt+vfA?=
 =?iso-8859-1?Q?dOX0S4NIZ4CdfJ9ucGCaMOronb0bpvRRYY0P72IXzO0bBojZRt2nan28mb?=
 =?iso-8859-1?Q?cWgw5WmsSgwMLkF2iFYIh9enHH3uXpFStN/K+yWn/LufrSx6Py491wTVIn?=
 =?iso-8859-1?Q?PD+fZe+A8eedSlNUIahNPS3kSrzSZ1IzDXaLQIZto+xDBHnCAv2ZPHmbTe?=
 =?iso-8859-1?Q?KrBHcZWbuQ92rgwVfKGGwou3FW08K8spfYOMxPlpQcRkP0eqa0yooR+d1i?=
 =?iso-8859-1?Q?RYwsRrU89AaYquYT8FKI5toHa8vagyY+MufCuJezLxiR5fLqfKlvHSAvbB?=
 =?iso-8859-1?Q?gPFhzqyI3TUGlXlTWZ/v0bSFiXsb3gayzkeafl2KBsm/eee7zrmPUYVx6M?=
 =?iso-8859-1?Q?Cumok4U2bVDS9nqdXEmzuUCjUE4X9x8AJbwt3suAnNf6AFurpPa8jb2oql?=
 =?iso-8859-1?Q?PzecyVGFudhTi1ToHNZJLia73bXNi3Roxptoq8MqZudc7cIVzOIlRaYgtW?=
 =?iso-8859-1?Q?/3k5pcb5eQZ60GdlaLwcQRICv3YUa4XuX8IJkEM7hyKMsG7NVrfcAKinhQ?=
 =?iso-8859-1?Q?botn5fx8nUtnFwQ+lY4YIK6pc23Em0UETExMf7DHEWkUNqvHBaKP6YBf9H?=
 =?iso-8859-1?Q?+RjKDwqU25RONbm4KDArjZpvQnBb7GN7WYldUejbTk7n66YpvGuy8/BLSa?=
 =?iso-8859-1?Q?R1gJn9XQ1DWLB30wfOsloHrFtuGv5HfMuXrHeCYe9SYNW3CAW5xW3ZhxX4?=
 =?iso-8859-1?Q?hFQqKiiNTIsSrMdGN7RWmdI9h3eqcPCKzEkR/ozep3Jt7jIQWd1vzMadFR?=
 =?iso-8859-1?Q?tsWgZzEvIMl2vUasA/pZfBq85XgvAGrW2/fGsQgKHt7y27vVsHqVkEwY9l?=
 =?iso-8859-1?Q?6kvTi6m1CQRxurMpsQIJTuVfEUIoJkDcFbG5npcpmQycTBWeihSeBERlbN?=
 =?iso-8859-1?Q?iloc/BAIPbQjBieYfnNbCKaurG6fTYsI9xU18VSu9/7CUhJauqRQPCHCjk?=
 =?iso-8859-1?Q?cK+/8dZ/EbWpCO27BJ5xl51JsIAX+Ksh3CZVkYjBHw4Mt/m8QfegZu/T/W?=
 =?iso-8859-1?Q?+gVt1Rn9OWAeuRR6yyZYt1m4NBXmwvUlpLvq3BxXv99yk8hS2m4St3SA2W?=
 =?iso-8859-1?Q?uVppzTTt+HIcy2TY76HuUDohTM7C1hWJd8J31mEt0ZmvoO2yqJQE0MAlH2?=
 =?iso-8859-1?Q?7a1G6aq4X1E3X3bRNsN/X2FRZFrmTZB3z7AfjZsymVrQL36S5dTkj28suf?=
 =?iso-8859-1?Q?jYIoHY5oLOQXdaRkwhcYxiUEDEUH3QMNxT6ENcGYgsl+aZV2u4YCWLhfmg?=
 =?iso-8859-1?Q?XBwLPanM0OTf05FQtVzrzIKg4IAHXHz8cteV8eKXe1UJPxJERmqEs2SvZT?=
 =?iso-8859-1?Q?aqicH+Y3njEISBhRHq0zDOrjJsGVp1a9Sh7y/eeLL/zi1/xQJ7NLR1grl+?=
 =?iso-8859-1?Q?6yYP3kq7pq0zQabROGCbVF4M7W5uB1vpO3qnnOHyvZiPrAfBXA9SWTkq99?=
 =?iso-8859-1?Q?+JV6NS+8XNFYzQVnjQq0ffqjmAVo3cd3/BXKjLXTYlEeltd1hwuCxFFMSc?=
 =?iso-8859-1?Q?YLhGAUwe+KTmbpGspYqnjgRRfoXcW52BUwS6TAvE9kQwOqH/rmWESWzWRU?=
 =?iso-8859-1?Q?IHhRUdwBQjd9io4nmtwZaLl57ZsCWMrPDDuWEgKQpO+YH+fC0+uSMzaUUm?=
 =?iso-8859-1?Q?YAkxWgY2YOt2mroBzjqftwAXBI5/HDmGBbg5kxKUupprtp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	31/2/cnjxJf3ejnHiC5R3dgIC9/afFX2FNzhgtorGJBHWj0jWoIVclPyLFQLIjfN8HsdpP+m80tVujGZzWL5shrXKREDxMJk9emqjv0naJgtTPUIifWdH4SNEa0RuS8dh3X/ClxyvWoEP65oj8SgLpoisuRz4dPYQwX19eYg5V5b4DTxawuBR9zRQdPT0Bq3lwKV3X7GaAPLBlUjCb8WmWIlPQwM7f84k+xdlGPvqOy4dDe6RYAH/HF4kazY712CFR2OSpA+78ylG3+IV9tr/eabVihF0qBFrGA4MbV9sSwMF6sIIWvtUjogIDb1PbiF0C0tvrujcMISa5kEDBpo1Q==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5488da-ff3a-413d-fa73-08df12b4023f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 23:00:41.9891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFOem9kEhVYeToy1j8J8Cxl2zougLGLgI4FA0VBsoXASnbFtMrstDFTjT3VpgpzuikCY7mIZ5ZcopV6eJjgJVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB7131
X-MDID: 1789426848-MUw87g1WGIzF
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1789426848;MUw87g1WGIzF;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

> Clashiko had several comments, and some of them definitely look real.=0A=
> Please note that you are supposed to handle such comments proactively,=0A=
> see commit c82ff94592fb68f529afe63ca7f5ddb7dae4ba83=0A=
=0A=
Thanks for the pointer.  We have gone through all fourteen per-patch review=
s=0A=
and replied to each finding individually in the corresponding sub-threads:=
=0A=
the majority are fixed in the upcoming v9, a few are answered with the desi=
gn=0A=
rationale, and one review suggestion (renaming a vendor property to a "-hz"=
=0A=
suffix) turned out to be rejected by dt_binding_check itself, which the rep=
ly=0A=
on patch 02 documents.  v9 with all of the fixes and a full changelog follo=
ws.=0A=
=0A=
On the second half of that commit -- running LLM reviews in advance of the=
=0A=
post -- you are right that we had not been doing it, and a 15-patch series=
=0A=
drawing 86 findings is exactly the case the paragraph warns about.  We have=
=0A=
since set up Sashiko locally and now run it before posting rather than=0A=
after.  v9 has been through it twice over the whole series, and what it=0A=
found is folded into the patches rather than left for the bots to raise=0A=
again.  We intend to keep doing this for any further revision.=0A=
