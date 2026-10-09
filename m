Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4294F93BD;
	Fri,  9 Oct 2026 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570220; cv=fail; b=HjFtnaNNjd2wTkhmLN+ql7WRAjra4okOo0eovpS+0jk+LfL23uEKbCqd0iVi30KShgJNxriSF+OAeA2WMNFt+Al9XznHdhOb37xW6Xs4MfKqcgcX+QfEopxspE3pE6dEQTpHBCxNREfiil63sDJC5SOL4BsW/KCuqw0llPOn3fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570220; c=relaxed/simple;
	bh=Y5l/iYK9Fd7/7noQUTPvqZr6BhhbHTQ/n6r+e8t5RoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R/BAwrVArnedFZD47gawxcK3ojTy0NsXPOqMrZM8IQN8TJ4H9tLBuIyshFTlMag5q6p5nEtu3hYP8vf9o2YvqgusCpBHpRJ0Zg0WeSjG4MQzEW8ZNjgVnQsl32bKQdUG4oOcyruTOMyP4G/MvO8gERhVj9Z8iJ26dtgaONYQZiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=NprL6hNN; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=XV3/IuyP; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="NprL6hNN";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="XV3/IuyP"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9F94D24D790;
	Fri,  9 Oct 2026 18:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=Y5l/iYK9Fd7/7noQUTPvqZr6BhhbHTQ/n6r+e8t5RoM=;
 b=NprL6hNNz8w0uBr2jI5Or4TofTnITAiY57r4NDo9EmJnaNtdOO87LrYmljxzJVUZz38BWyrXvBn7UAJTJsT6hh9wi5ELFSyXFinZoN7MtARhNAVWFC/ZM+H4kxv8H4xz4fFnR3rxr5ZIRb5CvspwD9g60fetMWWeelZqDIIIYxUzhvNjnzsWx4yPwK1cVOb3wE6f67zhszg9t2RJSUggjXGiZ10tr/f7uBdVp/j0jlngEOwSFLRFp9ZVztTThMue0nP2I9IeUOae62yuzuxiH7tDNmxC9ukvzZMGo8W6qFPqiqW0yy3iCd1Nxr1q+G7lhLiQcBz6J+sESqzyCZ4Mxg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022092.outbound.protection.outlook.com [40.107.209.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C802210008E;
	Fri,  9 Oct 2026 18:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxGifjauNDVqzJIx42iEJKE5xEj+EgSyl4+2iXs9Kvlkct1DN3ONgJn4QnlX2bH3oCbR4+a7jK8M5aFRkTkXi4KECTmgLtx9NL2O+m4C4Ggp1qQRdb2upAqn4dNTc1JJjuPtc/8OzPCLoMhOcgkoZypOFtODfw9mJZNFC6rvoOdJQ1vwCGgxLM4y5sodQ0KHBJIKYXbmljETkRoFOL7KHvzL7uLonVAWUwByK3WqMRbLNgQj1ej3XOBBZ2fdkDbqvpzzrtJgLz/wXYIJmW5AUC0RDtMLiqUWu73nUz9PQ+HBftDv1ApcU32BUvImRMuI1fCLrwM8vDgO++aLEKOgYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5l/iYK9Fd7/7noQUTPvqZr6BhhbHTQ/n6r+e8t5RoM=;
 b=eFhyk3/BjQuh+aDjZk5PM/2R3LlZFpvV3ig40HvZjVVNyImHCUVOggLnE/sNrNSe7kCLHGArDay2uQ+cBUQsJOO2k3cDJuwylrQ1qeBOi9zJqfY7aiClxdFvbBFR9UqnpSf42h523qVhrVkhh2lwXGs+g0leKlnyBkZHQs14LU5nQ5OJgrK7BquQ3Vpc3VogTxSc1IF5nRMMq0eBpL+dNlHCdSFyhT113Qcb/xWadnqrPg7V25JFu3bAPk1gADnclWE8EHHBdUbPAZFz0ESuoQX1ahEYYqVp27o9dp7X1dNHwQGDt1rHOK1dnlrcSmzDcvA2N8Os3O978G2mAmsZdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5l/iYK9Fd7/7noQUTPvqZr6BhhbHTQ/n6r+e8t5RoM=;
 b=XV3/IuyPKYav2je8J69ZCF2dAv03fb47AmfYW1sdIDgEufF91x7WyrVjmNpyCxoEuVkbqmVH9YHDS3BrVObMIqURwWdSvm/qWc8RJS5wnxTJUFkExiD730wACw62fYidhEejBsXtKbPJmZ+86agOzKqX1y6BHdjv9oh36dOZfH5LVTdl24QbvltXoXC7v2qzkvfn7R9+tT/myixj3e21i50ykIT+haDeqmGi7/uk5lwH13D2dTDu8qvQEd8e+qpVb8pn+KD6mtNJCkAZ77ujWh47bCkQVHHNLpAnreYmQFaypKmcL6yDGqNz2Z4DdRZcti8v0jkondbbihVNZMInmQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH9PR20MB007164.namprd20.prod.outlook.com
 (2603:10b6:610:314::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:23:25 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:23:25 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v11 04/13] dpll: add basic SiTime SiT9531x
 support
Thread-Topic: [PATCH net-next v11 04/13] dpll: add basic SiTime SiT9531x
 support
Thread-Index: AQHdUTShebuE2pn/x0mY8/vS78K0/rbuKg4AgAdqBwA=
Date: Fri, 9 Oct 2026 18:23:25 +0000
Message-ID: <20261009182323.76166-2-arouhi@sitime.com>
References: <179116259637.434549.13673583471206119318@kernel.org>
In-Reply-To: <179116259637.434549.13673583471206119318@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH9PR20MB007164:EE_
x-ms-office365-filtering-correlation-id: a1af37ec-f7a8-465e-b170-08df263268b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|38070700021|56012099006|5023799004|22082099003|10067099003;
x-microsoft-antispam-message-info:
 4fWkmv/ebgR6qZgGhhJNheBV2iugmQXwFZnmPUOKXM5n6CU6/b3s0kVnaxGFl9s9uDb3A8xkCyXB1yb2lnXFYeS8TF4gI4kYfXLffAyyEhYtfT9C29uFgQkWV/2hiz5/RsYYloYYv0ioNoRU3s6r8bHrV29rdMakyFJdGO/iHCOP/blrFkXMKoK6V8RNNoAPMuKMeTI/EV8bsAFuJqmBinPSt/eAF/LfzU+zNhEd/grlVoEjqJ5Z5gr6tPOa9ekpQzdpSQnpJ6dgjjL5ug75uOqKWcVx/8AehorIfXU3Q9GmtcSK7acOWU/ckullqvDVYHpMzErDtIjjfkvsSbIHiqfaCyprzWtpmhu9Yru4+1Fyq3NYjdue0xJcRFFmr7A4noaB1UISmKC8mIoNz+TtgwyIi9i7Ah0HbI+V2o3J+VpjJWkwJKfWlbsOWhMAmOsizJPTPyzZm3s6gxh4kKaYqGhhjLKgH0roekZzJrUQZXw/nYQIrkl9HN8jGMVa2oeRT82gAgREJIUjxEHRRojT4/wyg1tDTVYwXgkAL9JWHs0d7PfrGv92QGYATxTahuLTdYOG6Soqg/Jzc5mSAN1y//4r3HHSVEL8QEvQDQainMLbsn77GguVJcwWgL5VCZ0e6J/kQELUvskQ8hp28+wnbHXMnGQyV5sLIOW3KYuq6J2j8AZG+dYcfzO5ydHneWxX7BfDkKrLbc2czQVRU83gOz2CtaEsAKp4aGxwX7fMwsY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(38070700021)(56012099006)(5023799004)(22082099003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HPWCFWf61CvH49g3dKE6RcT2CnDQDQRii6CRpjlwafAvcoJ22naq+dq+g9?=
 =?iso-8859-1?Q?0IIG4VpH5r6b61FJOcOzzwHXJPu1BHVll+GGjU4F1aXfieKBV9quIkk9XC?=
 =?iso-8859-1?Q?9mJ3VQBEBltjX9ufdm7WD26qmnqPI4/nYg5cH5njbbbfrPM4b1/38uK8hE?=
 =?iso-8859-1?Q?hSKU3AWRkN6l37AhVl42buoI3nZ4QxoLv0k+oXD7QsEsRwKqNfQpcpfkNq?=
 =?iso-8859-1?Q?S84vfNEjH+7jRPgksey/ui/AIc6zicWuRZUEhsm1UGqs6rC1IfFWsyMT/S?=
 =?iso-8859-1?Q?bGj/2v6+wZnyx0+1vicwAgBzBlev/4DnAjDjbCMTqJ76gcqxKsXRLQq7LH?=
 =?iso-8859-1?Q?PNTkpb2ICEzufgl6nkKSsTGSNAOf/lByGJuC8TewK1vkVETBbSn7J2Xivi?=
 =?iso-8859-1?Q?crv0+IeLBenXanU+5YTb2Y8xiqEBUMEFSWYzAptFC+orsFnZ4cSjdv9hpm?=
 =?iso-8859-1?Q?j3y6VkExjZ6r0OmJ1/ruDWiUOvRLwbrWzcZpXdFPZRPdA6EqbgK523rMCR?=
 =?iso-8859-1?Q?dCZxS5wdUrmDexOYClln+DFauKOneRH2I2RqKnUmvCFHYT/VIFoYGTOZoG?=
 =?iso-8859-1?Q?Ew2ArUvG/b6MbF3zSU1XHK+/m2RdhY9xFPZKvydJXgTQkt7vKslGPCCcZs?=
 =?iso-8859-1?Q?/5+xc16R3P6nO4ifP4kLikqHJnwdCRweDuMickMuTRg/QrfdvyOjGDhV8W?=
 =?iso-8859-1?Q?Sdu85lOtEOdpQLNQIALfo46Ef7WYT2GeEK6c7f93OBOuoTGrutKPmXGxVx?=
 =?iso-8859-1?Q?yn9cj8QFk7htB1iml0+9JYcnS5kEaW5f5nFeDqeaGy+K+F2f3nw4UWra+T?=
 =?iso-8859-1?Q?NSm7dQ07nHtsLpO5F0+nlO7aNd7ofNWS7GxYo3GVTXh9CpqDZ6W3PCoi5D?=
 =?iso-8859-1?Q?AskUD1QUNV2wjLezqAFRKuDQI3kFiMpLcb34UYMw1VkhxV+8gxhBMU0kmd?=
 =?iso-8859-1?Q?w1lgYOzd3SmT/PQUEmBeMOohsvL2V0nNwTvu/Sfr8+fOA37EL6h0lxQNCR?=
 =?iso-8859-1?Q?IjbMWuUiOL9XOrIEKj8qvoVvGibwCtK270qw/MDhZKEMOra9cQ6JeEqLdH?=
 =?iso-8859-1?Q?WiV76hSYXYLMu4JDpFASSvTYIa9j3uOs1yDPdnXrqzyBm+NmnLuUtHADRp?=
 =?iso-8859-1?Q?l25uPgYhkkZUhJvyI/PhY/j6P1zmT5QX5MJKUTDs8QoTjF7PCqWRV97ex5?=
 =?iso-8859-1?Q?/wzb19IkumkN0jtKWs7hLvLWo+FgbT8LSLd67lcwxTZPmNpUsKENva9oxk?=
 =?iso-8859-1?Q?HaOwNRfzViWhk3/HXiAujjluUIza0YZmrwBftClwBvXweI53UbGI4mZYSD?=
 =?iso-8859-1?Q?+kUK6sWEcCkWPs/bLZAmhQSHSk3ffDLGZr6ncbPZWDkiEfzPOBGh32JGm0?=
 =?iso-8859-1?Q?OOYM3NkWg6QLTq52LY474LRVSPqEGNp6d8oLJ7prNYxcfms5MTDPXhgaP6?=
 =?iso-8859-1?Q?AwhwoxZHM8OkRrgRvLvsfAR9RJVranVHvjkUFpSowCMKHy4Mp5yy8r8uUt?=
 =?iso-8859-1?Q?aRtPPZ/r2oMv5lFVzIk184bz9iD6bzI9HCaScHWOpUzMnLOB/S88D2yEip?=
 =?iso-8859-1?Q?aX7KrBMWPIxqfCkGusSmaUm2U6xUDr9gF0eUEkT5DM5sQJX/pa0tfdZKrw?=
 =?iso-8859-1?Q?19s/0QklfM9hvGsAl2cLXEOT/hGXHjZ8UVBZlDeNEPEmDHUh6f9rtS4VXc?=
 =?iso-8859-1?Q?ivhVkKmEtts3sEavz9Nik6M2UzPVOFDNT5ffgTqFFzDZub2XXRV+6rpedV?=
 =?iso-8859-1?Q?KjQVko+uovtN+dyVtqYxlEfx7mcG1++ZY+Owb79XbdS2hh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	110N2kSeXIXh6ZOv1jEic05ACONZLA3iWvi+/01K3jDfERXyObmGxqkz062PMFWjpKeoavOeL7QOSNcVxuNasfVbUphZ0fmxUCjYzCECknQDzubHiUj8bClO/N1fAlpoiIklvkOuQvvo1IHDkhOUgnE5DX8F0IEbcy4POAcMnW8abWz3lZWHpgMCJnUEoL+P1EoqGm8w317daql9vo7re7I0RnHOhW+uuPKksyafZfvDUqYRJy/TDBYOI/+1gwANputphh3Qz9YkQTDcQHDJ8MpGdJFxZ0DZFWe41AbweaOrsQRBIW/w8aw3Oqw/OFiGg7lgun5UEA9wl+oN5bR8og==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1af37ec-f7a8-465e-b170-08df263268b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:23:25.6368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g9y2vLwEnXdKleqB/NV9/v79+SIScz8mFLeLxg3nQVvv5AFw3e1o9eehNm+i6l147tLdGSwc7VU5IEO9fr+URQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR20MB007164
X-MDID: 1791570210-pcj15fyPvT1R
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1791570210;pcj15fyPvT1R;<arouhi@sitime.com>;5de2396b9b83917d02f0372d9ae54394
X-PPE-TRUSTED: V=1;DIR=OUT;

On Mon, 5 Oct 2026, netdev-bot+sashiko@kernel.org wrote:=0A=
=0A=
Reply inline.=0A=
=0A=
> [Severity: Medium]=0A=
> Does dropping the cache entry on error keep the cached page selector in=
=0A=
> sync with the chip? The comment above sit9531x_volatile_reg() says it=0A=
> does, but some paths seem to be missed.=0A=
=0A=
The entry is dropped on every error path the driver controls:=0A=
sit9531x_read_u8(), sit9531x_write_u8() and sit9531x_update_pll_u8()=0A=
all call sit9531x_page_cache_drop() when regmap returns an error, and=0A=
sit9531x_resume() drops it before the first access after a sleep. That=0A=
covers the SMBus byte-data case: the failed selector write returns=0A=
through one of those three, and the next access re-selects the page.=0A=
=0A=
> If the failed selector write happens inside a debugfs read, nothing=0A=
> drops the entry at all. Can the next sit9531x_write_u8() to page N then=
=0A=
> land on page P without any error?=0A=
=0A=
It can, and that window stays. It is not a path the driver takes: the=0A=
regmap debugfs registers file is a developer interface that bypasses=0A=
every driver on every regmap.=0A=
=0A=
> A later patch in the series drops the entry on resume. Nothing covers a=
=0A=
> reset the driver cannot see, though. After one, could writes meant for=0A=
> the PLL pages 0x0A-0x0D go to page 0 instead?=0A=
=0A=
Yes, until the next access that fails or the next resume. Dropping the=0A=
entry at the top of each poll tick would bound that window to one poll=0A=
period at the cost of one selector write per tick. It is a reasonable=0A=
addition and is noted for a later revision rather than folded into this=0A=
one.=0A=
=0A=
> Would it be simpler to make SIT9531X_PAGE_SEL volatile as well?=0A=
=0A=
SIT9531X_PAGE_SEL is the one register sit9531x_volatile_reg() reports=0A=
as non-volatile, so it is the only cached register in the map. Marking=0A=
it volatile makes the _regmap_update_bits() in _regmap_select_page()=0A=
read the selector from the bus before every access rather than from the=0A=
cache, which adds a transfer to each access instead of removing one.=0A=
The driver's own paths are already covered, so that cost would buy only=0A=
the two windows above.=0A=
