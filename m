Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F94640A95A;
	Wed,  2 Sep 2026 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385263; cv=fail; b=oIBRSNF1eCZa5wqt2ChnOZXio8PcGZhdE7ye+fQ8Z+bV5qTCRH5DAF+INnBed0Mq7G+fMCGupINDhDKETZJQhwEqVsUd28eLT5NLMEl9kG9ICS463359P7Lhuwss0KxvEb+MRmTHICDq7H4JgAb14DKb4eFjekJqmfr3oCGhgzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385263; c=relaxed/simple;
	bh=TdUF6fhBjX7rJ0v9TYmMPBWuWJIQVB5oijk/DeXDafQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f3wBlajqzSOZrttjfZi9RPjJsA/S67hO3+xQfKVK1jK2rbZDDS0xMjyHeWjyfYPE8PAncG30aV4yfOj49YiQ2iGMRZRIVuA5yamwO/ixVbRsLIh/7fAc32bfB9ifTHbrdlfrw2zy3hjeWuMxB+d6Y/JRMVF/XvWF9XJIPO8b4EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=N8klDR5Y; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=TKizSMRG; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="N8klDR5Y";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="TKizSMRG"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E88851C96DF;
	Wed,  2 Sep 2026 21:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=SwIMuFhr6NyFDe8v4cMPJh4hQnYJFzQYtZiNByxRKsg=;
 b=N8klDR5YRIl7R7Pd1FQGthJ8YaE/i+0+jPJFGzNyYAMUGGP9I+fEEDQev98IJd9CBHmBD0WBDTNN2YVdOfrmh92hCfADSyDfNfNB5u8dAxNsfnSm+jpDH5ODvAUu5lKPatnL8oBzH2CYvnh/6lxhHb+aEW6WcWbJzl9wU5SOFc8fFLQ2S+SOSvPrQFnYz8knwjkQ8//9jNhvNp1hqqahNYou9SQKY5JgeFJJRT7aYsUBwqVHI3oy7uDWnEuZNhzqIA7nYl0CnrO047mrGz2O4fGy6eGIVFDqM3nYBrDAIFWZL0OaWdlRXGDUEzuLlC4zXp+MlkB8J7fYtK3NwGk39w==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023110.outbound.protection.outlook.com [40.93.201.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id DBA5F3C0073;
	Wed,  2 Sep 2026 21:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prdnNaOaOoQG/0kbWYe5a+NbPAurjvEYapeBeBu5PY8FDfF2BR0UHwJU6KRYeYV67uO3SlV4zDdFkxD3gXt7fS15J36FgbplHQtpDvZ2+QCsE4fPw7QQ7A1tsDgieTIUFNbEa2GkalfrIGeQb08HFgsIOXAr13ipFcR1wCSlYYc14yjRM+Afc/bXeBtm07JW9cUxcZHKbxvgJ0riet3DJG6/A6Y9YIXETZu8Ag607cVgja1VoS5KSdyyLzpiuvnh66DkeOUVGgIwrLOnQ5pZ0cjk7J0tBk3NbZMjxLvasfPtnbgItC8GRZYLDTVVvDZEpxuurh1nES5yJsX/CH3YVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwIMuFhr6NyFDe8v4cMPJh4hQnYJFzQYtZiNByxRKsg=;
 b=h2/Y5v1Asr2OwnDo2p0pd5fuZCAmr23ffaSEmB8u1cSdhjxZBfGJaagCmNNpS16anqRJ99GZtgs1aaPGUeu3gYNfxv4bNKziGSplyxuK8lgYIOOBOHl+ZUq0ENaP/CaY3LzHNQ1bv+tG2mJamJdxjZWqN53NG31M2/iScDebFGMi1GRznHo44nOQMrO6YhAn8LiDnJtKMOxxb1pUmfs64igXAuN45zeTfncMpM2NoHF8OmMG0d7uU00AkIkr6O1UQqUaQYph37n5CSi4grwqKGsmBqbs+lRkHXpisWC5y59Ob9YDjmVbBitDZh6ECscEmpjfcJINSLbhu5UGqN4wkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwIMuFhr6NyFDe8v4cMPJh4hQnYJFzQYtZiNByxRKsg=;
 b=TKizSMRGw5MU+fa3DBYq/1kBnC3A8QOCy/DB6P9Vdd4MWNDlIKJvybBVqwhjhj8wuyAyCC7Hjja5uQ6ZSTPTALCiS/DxJxUM5nrUoYmR2zW9i4J5zNnly4vDphElnEHeRMfBQIFyOcgxh3Ear16VQZJbQlDvyBk3rzuFqYtYMq1f71DHUj8h3USdrICWy67D4pszeG0HEP+O1XBmb0bO7Bvj50WlXpn8lpB8mSuuFsNKqtKgQF8LGoOspVm8rLel1cCC3PezWxZEa5QX6Bq1NLpWg+6wU8ZqQWBHyPafKNzoRDgG0PS/eVlhRfeJTdQEkkungUJ9N6pBLod8+5O1JQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS7PR20MB4877.namprd20.prod.outlook.com
 (2603:10b6:8:97::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:40:34 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 21:40:34 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ali Rouhi <arouhi@sitime.com>
Subject: [PATCH net-next v8 06/15] dpll: sit9531x: implement input pin state
 on a DPLL
Thread-Topic: [PATCH net-next v8 06/15] dpll: sit9531x: implement input pin
 state on a DPLL
Thread-Index: AQHdOyOv4Fp9BWvewEGjh8Jw9FVnyA==
Date: Wed, 2 Sep 2026 21:40:34 +0000
Message-ID: <20260902214030.20955-7-arouhi@sitime.com>
References: <20260902214030.20955-1-arouhi@sitime.com>
In-Reply-To: <20260902214030.20955-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS7PR20MB4877:EE_
x-ms-office365-filtering-correlation-id: 1d907162-cc12-49a8-3511-08df093ad1ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|38070700021|6133799003|10067099003|5023799004;
x-microsoft-antispam-message-info:
 vBly1IONoMY2jXtwEkAwE/Ar1f8wKXhOHRTA+7B0PbMhQ1nnKNcut/tJaOHo2lblBrX66ndG3fNni108lDYBn1H7zOYTUHrOLKjyaJmmZPrVKF2+8zveLuPJYHe+/lCOYo3NQ6ljPnNgdyx9+jRunRI2xGF5HB6eCHOPKT+uWRV70u6xYeL1SNiKs/W20cbcYbiodXKL/H8Y/HUi646CgSSAHSegq/cj+U9EyndAbHctC4gL2rAjZc6fD5CE59E5nOiujsavqHHvrl81bDqkKXjCU8cKy8sTRlABvq0s2DMFX2skawMgzeHetVXjFx4soJ4qFWghE+WSGo7pQq+kDrpttEF6nQyGHPsZeFV8RgoGjrPj0PEdzz0FQNJ8vHtWws/KNHGm7VqbrVDNEEnwCgQXwcCeJixM57TLijU1Kth+I0yjsK0eVnQVfWAHX7PGZ3slEvwrbfi2MpKoimu5FWplPnY7NT/ijib+s42j0tgGzdOyXQ+RTXpdap7r8MtUd1VpdsR68CSLmvvGrtzB5olZHAVnNHttAGI0RrybdTIDBLcQv8u6AVu827DDkxusr81Uwgxwhofm8dXwMy7AIqEGRkM2XSh/9BX8koyHLkmfu93ym7W7OVHQ7BV/ffjnsK6grisqMKDEEMB7P+deCcaXGSGq9C424HvT126pt1wLFjRT7wBSG+vE9v0x7MTlDsxcEf3+I1bjKAI1u0esW+eJw3OxE5q/0dtOLhUOjYk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?IGaRzBuzHiRg/QEs8HVArB5ree8mCaXoEbJyA105Ceks53d+fjRbf2Kl7O?=
 =?iso-8859-1?Q?QTFODnLamtwK+c/u8brriOMwEjqKwqluIoCt204Uu0Pw62TJQShXtllRwa?=
 =?iso-8859-1?Q?cWdfx2sdEdWaqRHsdaG7e/K6COo3YpxXnBV+HLkNS6q6qvcBvnwXVdoLK1?=
 =?iso-8859-1?Q?uxBVnSiP4/bI37RuOYfaSF4+lRvSdfEFmKKrDFR3PzV3P0jYD3upnKbe7s?=
 =?iso-8859-1?Q?HKdRAP2EfHTS3Rt0TYqt5V4KPenpeQOIFYnzuJNUtY34JLhjdLCCK50RU9?=
 =?iso-8859-1?Q?htB/HgB4fUhMTADl6SUNzuA4uTDNbNtCDLp4bxsihVoc9U03WA1YGQet6N?=
 =?iso-8859-1?Q?y9DZJPHeO2vXqwC1Ei0QsX7BRlbz07QiyxVv3gwJU2+cA05GLi+eh3lz5y?=
 =?iso-8859-1?Q?JnmZMyJ0GvzX5/eVJ/wqjvRjo8Q+JMY6pMeM7F73NyahV2HKRboOTh/cVp?=
 =?iso-8859-1?Q?SY7PFFvIJ7/vA8YEwJLmy0GecEAZaojS8jC+0UUSs8gNDRItZJKC24xUiI?=
 =?iso-8859-1?Q?mvVxhGkWQ5o+roUf0r/lYOKunhVedOgzV1Nyj/PIFy8pZySg6fuHZYyxuZ?=
 =?iso-8859-1?Q?Gup3Ktl1bbNX3MRUymmXW2fDnk4enfgyqZ6q6PVuIzYPxfHJDad6ffdneo?=
 =?iso-8859-1?Q?BbE4ENtHFMgx9FQc5lo6KvFtt4DLnPPc+8XWa0+T8++HRjENfSHY4B7Pso?=
 =?iso-8859-1?Q?yqDISmniY/3qgeKHSlTUbP10pU345pFg2Oms1UI//qvXPHebdo8tBKbasW?=
 =?iso-8859-1?Q?Ps/r3sXMHA06MEUU8JznIpq0H7/lEK5XlbhbR7IgE35NpjfNrZeHURFi4b?=
 =?iso-8859-1?Q?1Sp8ZxBXsa0+A4eUKJgz+iZxDSeDqYceS88KXPSEk0JcV+BhZozAq1opnp?=
 =?iso-8859-1?Q?sxkr0437mkV4c83slO/mBBK89xwBg/C+BEXEDWqmsDKB6g9tVfm88z+E2X?=
 =?iso-8859-1?Q?bArkGqtk0ZGohHH8x6fl6VddpMMrWwtDZPUdhvHgXVHlkNUaNt6Qf7EAbe?=
 =?iso-8859-1?Q?pd+hxuvKxR0TdjTp8c7bGbvOUMTKvRaBHZoivLF9FhzW6fmaZnNIdE8zMH?=
 =?iso-8859-1?Q?hNMAkN/f1KcZvONY2np4xvZ8SDiexf+TsRrlKpd+X3JUfEU+AQqr2wKlKn?=
 =?iso-8859-1?Q?sR0HMQYTDoI5XOC3cAd5VpmU0ywdaIAOZFhhc5A0ZJ43YGZL/NC89MDCbO?=
 =?iso-8859-1?Q?Lagm5fHTNVECsArjc04LpRug+HiQRpBWcG4IZ4ct61dNLUNAtUftvqafZi?=
 =?iso-8859-1?Q?PFrooFwdCuOAjm5K/P92Pks2hE5xblyeOgN7FoFqM5v6bnZuxiEACQAhWI?=
 =?iso-8859-1?Q?j33KM2GVgrLBOw2sTlRLO0jXZKB5YN+uv/808GtCMDJ69XBKTJEaTL/DNX?=
 =?iso-8859-1?Q?nvPa2O0sy5bYR43v7+urqOV+SZPXlnK3AxX/WZ/GeWoef+bzHt+CkBaTd1?=
 =?iso-8859-1?Q?uEvbLO5GKK5JefwgvNuIGm4f9y9tHqaLtJV5g2+nJmqeJkQtUKdUccWv/k?=
 =?iso-8859-1?Q?SzuLYagIpc6K5lELHa/oNQJp8igXCw4Q9hF+sNGnZtWP165dPlK3yapKcj?=
 =?iso-8859-1?Q?7TgQbr181Sd+dl/Lfq9ARqNDYTjLNu73z5eCoMIEj5f1VEbHIGudQiktcj?=
 =?iso-8859-1?Q?cOtws5JTHbXjJW2tpkm3H74OOFXtn/g5UcokJzqjrIFVLPc7ldTE1TdRf1?=
 =?iso-8859-1?Q?21qm1XXvuGTsl7WuHHvP7ayY6Au8fnzIClnoO1p5j7Mr82Q6cJinyMiW8C?=
 =?iso-8859-1?Q?HbvIFaVaTOB5NB6ZOnsxr88HDlKBGQ9m5SfMYLkjBavveY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	eRBRIXQnUxOs0If6MIzeeMuW5hqdZr9qeLbxDSvPcMaVt5bvXAegfiVmI0Q3GJWSWDY/Va3wz/yENh0FnHAWTcVFI4BCFa3rnetX/uhoRUZJ4FwHrVeDqga2MYNnXl9KPrQTHF1Ag4psBqothLgA4+XINgHa+Q47lNa6TBdlAay33uJDY8TbnDKF6CpvEKT7qyZQe84vO3766PYCVlD7Y5pGTF9jvreoMDOeZPPCRZv7pCd0JH92JwOJgz4wwv+j9XQUNV00j2ZXWwNU4yoQt7SPgFuQ/wIbIsvnK9UQcThJH4LtP3znruwSMrgS3KeF0A+bS824epo9luv5SNdsBA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d907162-cc12-49a8-3511-08df093ad1ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 21:40:34.3190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuhLRmlKH9d01byedDsdKi26O+gYJ7u3O9fsxnFkKDCy/t+01ibo22sAyTDdQZ23t/Sgxm669bUPjbkEiB7tdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4877
X-MDID: 1788385238-DghpWbdE-PyC
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1788385238;DghpWbdE-PyC;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Report and set whether an input feeds a given PLL.  The device selects=0A=
its reference itself from a priority table, so membership of that table is=
=0A=
what "connected" means here: an input in the table is selectable, the one=
=0A=
the PLL has locked to is connected, and an input absent from the table is=
=0A=
disconnected.  Setting the state therefore adds the input to the table or=
=0A=
removes it, and the table is read back rather than remembered.=0A=
=0A=
The pins fall into three roles and only the first answers this question,=0A=
so the contract for all of them is written above the operations rather=0A=
than left to be inferred: inputs and the inter-PLL sync destination take=0A=
part in selection; an output and the sync source are driven by the PLL and=
=0A=
report whether they carry a signal; the crystal is fixed and always=0A=
connected, since a PLL cannot be told to stop using it.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 330 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/dpll.c | 152 ++++++++++++++++=0A=
 drivers/dpll/sit9531x/regs.h |   4 +=0A=
 3 files changed, 486 insertions(+)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 1394ea1077d9..f42c41d8a42e 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -184,6 +184,73 @@ static void sit9531x_input_get_regs(const struct sit95=
31x_dev *sitdev,=0A=
 	}=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_input_disable - disable an input reference=0A=
+ * @index:	logical input index (0-N)=0A=
+ *=0A=
+ * Sets the force mask bit and clears the state bit for the given=0A=
+ * input, effectively disabling it.  Register selection depends on=0A=
+ * the pair's signal mode (SE/DE) and the lane (P/N); the bit within=0A=
+ * each register addresses the input pair.=0A=
+ */=0A=
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	struct sit9531x_ref *ref =3D &sitdev->ref[index];=0A=
+	unsigned int force_reg, state_reg;=0A=
+	u8 pair =3D sit9531x_input_pair(index);=0A=
+	u8 val;=0A=
+	int rc;=0A=
+=0A=
+	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, force_reg, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, force_reg, val | BIT(pair));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, state_reg, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, state_reg, val & ~BIT(pair));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	ref->enabled =3D false;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_enable - enable an input reference=0A=
+ * @index:	logical input index (0-N)=0A=
+ *=0A=
+ * Clears the force mask bit for the given input, returning it to=0A=
+ * hardware default (enabled).=0A=
+ */=0A=
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	struct sit9531x_ref *ref =3D &sitdev->ref[index];=0A=
+	unsigned int force_reg, state_reg;=0A=
+	u8 pair =3D sit9531x_input_pair(index);=0A=
+	u8 val;=0A=
+	int rc;=0A=
+=0A=
+	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, force_reg, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, force_reg, val & ~BIT(pair));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	ref->enabled =3D true;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Output enable / disable (Hi-Z control)=0A=
  *=0A=
@@ -310,6 +377,43 @@ static u8 sit9531x_prio_slot_get(u8 val, u8 slot)=0A=
 	return val >> SIT9531X_PRIO_HI_SHIFT;=0A=
 }=0A=
 =0A=
+/* Place source @src in priority slot @slot of a register value. */=0A=
+static u8 sit9531x_prio_slot_set(u8 val, u8 slot, u8 src)=0A=
+{=0A=
+	if (slot & 1)=0A=
+		return (val & (SIT9531X_PRIO_NIBBLE_MASK <<=0A=
+			       SIT9531X_PRIO_HI_SHIFT)) |=0A=
+		       (src & SIT9531X_PRIO_NIBBLE_MASK);=0A=
+=0A=
+	return (val & SIT9531X_PRIO_NIBBLE_MASK) |=0A=
+	       ((src & SIT9531X_PRIO_NIBBLE_MASK) <<=0A=
+		SIT9531X_PRIO_HI_SHIFT);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Commit a priority-table programming sequence through the Page-0=0A=
+ * programming directive register.=0A=
+ *=0A=
+ * A small change update is all the table needs.  The NVM-bank and=0A=
+ * loop-lock directives that the output system issues do not belong=0A=
+ * here: the former programs non-volatile storage from the efuse and=0A=
+ * the latter only means anything after an escape to the PRG_CMD=0A=
+ * state.  This matches the vendor input_priority_sel() procedure.=0A=
+ */=0A=
+static int sit9531x_prio_prg_commit(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	usleep_range(1000, 2000);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Rebuild a PLL's membership mask from the source codes of its priority=
=0A=
  * table.  The mask is what the pin state getters test, so it is refreshed=
=0A=
@@ -328,6 +432,67 @@ static void sit9531x_prio_mask_build(struct sit9531x_d=
ev *sitdev, u8 pll_idx,=0A=
 	sitdev->chan[pll_idx].prio_mask =3D mask;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_prio_table_commit - write a full priority table for a PLL=0A=
+ * @srcs:	array of SIT9531X_PRIO_MAX_SLOTS source codes, slot 0 first=0A=
+ *=0A=
+ * Programs all priority slots (nibble-packed, two per register) for=0A=
+ * the PLL using the same holdover / small-update sequence as=0A=
+ * sit9531x_input_prio_set().  Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_prio_table_commit(struct sit9531x_dev *sitdev, u8 pll_=
idx,=0A=
+				      const u8 *srcs)=0A=
+{=0A=
+	u8 val, slot;=0A=
+	int rc, prg_rc, ho_rc;=0A=
+	u16 reg;=0A=
+=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_CTRL,=
=0A=
+				    BIT(SIT9531X_PLL_HO_FORCE_BIT),=0A=
+				    BIT(SIT9531X_PLL_HO_FORCE_BIT));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	usleep_range(10000, 12000);=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		reg =3D sit9531x_prio_reg(pll_idx, slot);=0A=
+=0A=
+		rc =3D sit9531x_read_u8(sitdev, reg, &val);=0A=
+		if (rc)=0A=
+			goto commit;=0A=
+=0A=
+		val =3D sit9531x_prio_slot_set(val, slot, srcs[slot]);=0A=
+=0A=
+		rc =3D sit9531x_write_u8(sitdev, reg, val);=0A=
+		if (rc)=0A=
+			goto commit;=0A=
+	}=0A=
+=0A=
+commit:=0A=
+	/* Latch unconditionally, as in sit9531x_input_prio_set(). */=0A=
+	prg_rc =3D sit9531x_prio_prg_commit(sitdev);=0A=
+	if (prg_rc && !rc)=0A=
+		rc =3D prg_rc;=0A=
+=0A=
+	/*=0A=
+	 * Refresh the mask from the table just written so a get that follows=0A=
+	 * a set does not have to wait for the next poll.  Slots written=0A=
+	 * before a failed write are in the table too, so this is closer to=0A=
+	 * the truth than the pre-write mask either way, and the poll read-back=
=0A=
+	 * corrects whatever a partial write left behind.=0A=
+	 */=0A=
+	sit9531x_prio_mask_build(sitdev, pll_idx, srcs);=0A=
+=0A=
+	ho_rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				       SIT9531X_PLL_REG_HO_CTRL,=0A=
+				       BIT(SIT9531X_PLL_HO_FORCE_BIT), 0);=0A=
+	if (ho_rc && !rc)=0A=
+		rc =3D ho_rc;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_prio_table_read - read a PLL's priority-table source codes=0A=
  * @srcs:	output array of SIT9531X_PRIO_MAX_SLOTS source codes=0A=
@@ -352,6 +517,171 @@ static int sit9531x_prio_table_read(struct sit9531x_d=
ev *sitdev, u8 pll_idx,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_input_prio_set - move an input to a priority slot=0A=
+ * @input_idx:	input source in hardware encoding (0-11, see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ * @prio:	priority slot position (0 =3D highest)=0A=
+ *=0A=
+ * Reads the PLL's table, takes the source out of wherever it sits and=0A=
+ * reinserts it at @prio, shifting the entries in between.  The rest keep=
=0A=
+ * their relative order: a priority change asks about one input, so the=0A=
+ * fallbacks configured behind it have to survive it.=0A=
+ *=0A=
+ * The table is what makes a source eligible for this PLL, so this only=0A=
+ * ever reorders sources already in it.  A source that is absent is=0A=
+ * disconnected on this PLL, and inserting it here would make it a=0A=
+ * selection candidate again behind the caller's back; that is a connect,=
=0A=
+ * and it belongs to the pin's state setter.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -EINVAL if the source is not in the table,=0A=
+ * <0 on error=0A=
+ */=0A=
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 prio)=0A=
+{=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 slot, from;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+	if (prio >=3D SIT9531X_PRIO_MAX_SLOTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (from =3D 0; from < SIT9531X_PRIO_MAX_SLOTS; from++)=0A=
+		if (srcs[from] =3D=3D input_idx)=0A=
+			break;=0A=
+=0A=
+	if (from =3D=3D SIT9531X_PRIO_MAX_SLOTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	if (from =3D=3D prio)=0A=
+		return 0;=0A=
+=0A=
+	if (from > prio) {=0A=
+		/* Moving up: push the entries in between down one slot. */=0A=
+		for (slot =3D from; slot > prio; slot--)=0A=
+			srcs[slot] =3D srcs[slot - 1];=0A=
+	} else {=0A=
+		for (slot =3D from; slot < prio; slot++)=0A=
+			srcs[slot] =3D srcs[slot + 1];=0A=
+	}=0A=
+=0A=
+	srcs[prio] =3D input_idx;=0A=
+=0A=
+	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_remove - drop an input from a PLL's priority table=
=0A=
+ * @input_idx:	input source in hardware encoding=0A=
+ *=0A=
+ * Rewrites the priority table with the source removed: the remaining=0A=
+ * sources are compacted toward the highest-priority slots and the freed=
=0A=
+ * tail slots are backfilled with the lowest-priority remaining source=0A=
+ * (matching sit9531x_input_prio_set()).  This makes a disconnected=0A=
+ * input ineligible for automatic reference selection, not just gated at=
=0A=
+ * the input buffer.=0A=
+ *=0A=
+ * Removing a source that is absent is what the caller asked for already,=
=0A=
+ * so it succeeds without touching the table.  Removing the only source=0A=
+ * would leave the table empty, which the device does not accept; that=0A=
+ * fails with -EBUSY rather than reporting a success the hardware never=0A=
+ * carried out.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -EBUSY if the source is the only entry, <0 on=0A=
+ * error=0A=
+ */=0A=
+int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       u8 input_idx)=0A=
+{=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 kept[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 slot, count =3D 0;=0A=
+	bool found =3D false;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		if (srcs[slot] =3D=3D input_idx)=0A=
+			found =3D true;=0A=
+		else=0A=
+			kept[count++] =3D srcs[slot];=0A=
+	}=0A=
+=0A=
+	if (!found)=0A=
+		return 0;=0A=
+=0A=
+	if (count =3D=3D 0)=0A=
+		return -EBUSY;=0A=
+=0A=
+	/* Backfill freed tail slots with the lowest-priority remaining src */=0A=
+	while (count < SIT9531X_PRIO_MAX_SLOTS) {=0A=
+		kept[count] =3D kept[count - 1];=0A=
+		count++;=0A=
+	}=0A=
+=0A=
+	return sit9531x_prio_table_commit(sitdev, pll_idx, kept);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_add - make an input eligible in a PLL's table=0A=
+ * @input_idx:	input source in hardware encoding=0A=
+ *=0A=
+ * Ensures the source appears in the priority table so it can be picked=0A=
+ * by automatic reference selection again after a disconnect.  If the=0A=
+ * source is already listed the table is left untouched; otherwise it is=
=0A=
+ * placed in the lowest-priority slot.  The original priority is not=0A=
+ * restored -- use sit9531x_input_prio_set() to reassign it.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx)=0A=
+{=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 slot;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++)=0A=
+		if (srcs[slot] =3D=3D input_idx)=0A=
+			return 0;=0A=
+=0A=
+	srcs[SIT9531X_PRIO_MAX_SLOTS - 1] =3D input_idx;=0A=
+=0A=
+	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);=0A=
+}=0A=
+=0A=
 /* XO doubler register */=0A=
 #define SIT9531X_REG_XO2_GENERIC		SIT9531X_REG(0x00, 0x2D)=0A=
 #define SIT9531X_XO_DOUBLER_ENB_BIT		7   /* inverted: 0 =3D enabled */=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 821370ddeab0..29088707a3e6 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -255,6 +255,41 @@ const struct dpll_device_ops sit9531x_dpll_device_ops =
=3D {=0A=
  * FIXED role -- XO pin.  Always CONNECTED; it cannot be routed.=0A=
  */=0A=
 =0A=
+/*=0A=
+ * Report a selection-role pin's state on this DPLL.  @pin_id is a logical=
=0A=
+ * input index, SIT9531X_INTSYNC_PIN_ID for the INTSYNC destination.=0A=
+ *=0A=
+ * Membership comes from chan->prio_mask, which is the priority table read=
=0A=
+ * back from the chip -- not a record of what the driver asked for.  The=
=0A=
+ * getter runs on every poll for every input pin of every DPLL, so it take=
s=0A=
+ * the mask the worker refreshed rather than rescanning the table over I2C=
=0A=
+ * each time; table writes refresh it too, so a get right after a set does=
=0A=
+ * not report the old membership.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void=0A=
+sit9531x_dpll_selection_state_get(struct sit9531x_dev *sitdev,=0A=
+				  const struct sit9531x_dpll *sitdpll,=0A=
+				  u8 pin_id, enum dpll_pin_state *state)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+	bool active_input;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);=0A=
+	active_input =3D !chan->mode && chan->locked && !chan->inner_lol &&=0A=
+		       chan->selected_ref =3D=3D pin_id;=0A=
+=0A=
+	if (!(chan->prio_mask & BIT(sit9531x_input_hw_src(pin_id))))=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	else if (active_input)=0A=
+		*state =3D DPLL_PIN_STATE_CONNECTED;=0A=
+	else=0A=
+		*state =3D DPLL_PIN_STATE_SELECTABLE;=0A=
+}=0A=
+=0A=
 static int=0A=
 sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,=0A=
 				      void *pin_priv,=0A=
@@ -267,8 +302,125 @@ sit9531x_dpll_input_pin_direction_get(const struct dp=
ll_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_state_on_dpll_get - get input pin DPLL state=0A=
+ *=0A=
+ * Selection role; see the pin-state contract above.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv,=0A=
+					  enum dpll_pin_state *state,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_dpll_selection_state_get(sitdev, sitdpll, dpin->id, state);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_state_on_dpll_set - set input pin DPLL state=0A=
+ *=0A=
+ * Enables or disables the physical input receiver via Page 0x02=0A=
+ * force/state registers (sit9531x_input_disable/enable()) and updates=0A=
+ * this DPLL's Page 1 priority table so the state is honoured by the=0A=
+ * PLL's automatic reference selection, not just at the input buffer.=0A=
+ * Selection role; see the pin-state contract above for the states.=0A=
+ *=0A=
+ * The priority table is per PLL, so it is always updated for this DPLL.=
=0A=
+ * A single physical input feeds every DPLL, so the hardware receiver is=
=0A=
+ * only cut off once the last DPLL has released it: ref->pll_mask tracks=
=0A=
+ * which DPLLs currently claim the input, and the physical disable=0A=
+ * happens on the transition to an empty mask.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv,=0A=
+					  enum dpll_pin_state state,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	struct sit9531x_ref *ref =3D &sitdev->ref[dpin->id];=0A=
+	u8 hw_src =3D sit9531x_input_hw_src(dpin->id);=0A=
+	u8 pll_bit =3D BIT(sitdpll->id);=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		rc =3D sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_src);=0A=
+		if (rc)=0A=
+			break;=0A=
+		ref->pll_mask &=3D ~pll_bit;=0A=
+		if (ref->pll_mask)=0A=
+			rc =3D 0;	/* another DPLL still uses this input */=0A=
+		else=0A=
+			rc =3D sit9531x_input_disable(sitdev, dpin->id);=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		/*=0A=
+		 * CONNECTED asks for this input and no other, which the=0A=
+		 * device cannot be told to do: it selects by priority and the=0A=
+		 * manual-active-select path is not wired up (see mode_set()).=0A=
+		 * Refuse instead of quietly behaving like SELECTABLE.=0A=
+		 */=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Device selects its reference by priority; use selectable");=0A=
+		rc =3D -EOPNOTSUPP;=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_SELECTABLE:=0A=
+		rc =3D sit9531x_input_enable(sitdev, dpin->id);=0A=
+		if (rc)=0A=
+			break;=0A=
+		rc =3D sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src);=0A=
+		if (rc)=0A=
+			break;=0A=
+		/*=0A=
+		 * Claim the input for this DPLL only once it is both enabled=0A=
+		 * and present in the priority table.  Setting the mask before=0A=
+		 * prio_add would leak the claim if prio_add failed, keeping the=0A=
+		 * shared input receiver powered even after every DPLL released=0A=
+		 * it.=0A=
+		 */=0A=
+		ref->pll_mask |=3D pll_bit;=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * Leave the messages the switch already set in place; only a failure=0A=
+	 * that came from the hardware path still needs one.=0A=
+	 */=0A=
+	if (rc =3D=3D -EBUSY)=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Only source left in the priority table; it cannot be emptied");=
=0A=
+	else if (rc && rc !=3D -EOPNOTSUPP && rc !=3D -EINVAL)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set input pin state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
 	/*=0A=
 	 * The measurement compares the PLL's running feedback divider with=0A=
 	 * its configured one, so it describes the device's own reference=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 705176c35ddd..dd027142b370 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -132,6 +132,10 @@=0A=
 #define SIT9531X_REG_GLOBAL_UPDATE		SIT9531X_REG(0x00, 0x0F)=0A=
 #define SIT9531X_SMALL_UPDATE_CMD		0x02=0A=
 =0A=
+/* PLL holdover control (PLL page offset) */=0A=
+#define SIT9531X_PLL_REG_HO_CTRL		0x6F=0A=
+#define SIT9531X_PLL_HO_FORCE_BIT		4=0A=
+=0A=
 /* One bit per input PAIR (bit 0 =3D CLKIN0, ..., bit 3 =3D CLKIN3) */=0A=
 #define SIT9531X_REG_IN_DE_FORCE		SIT9531X_REG(0x02, 0xE8)=0A=
 #define SIT9531X_REG_IN_DE_STATE		SIT9531X_REG(0x02, 0xE9)=0A=
-- =0A=
2.43.0=0A=
=0A=
