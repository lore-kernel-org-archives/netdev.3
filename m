Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E38F397E9A;
	Tue, 29 Sep 2026 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642345; cv=fail; b=sCSewPF4+OqbxY4s1ddAXkVJHPY/REXAJpumaZsNs2qOKY2IUaLGfr1256Nu/S2l5GuxNn8cidicLX1CxXhU2yOclQfoYWQTYZbILRzB5SR3KG3+UlYwxiYNPX6u+9OGFBUj3d/RDH9GxAfgnQXPGLKx0FCrn5d+zxhvHHpFYx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642345; c=relaxed/simple;
	bh=3bO7oMH+DvO+quHER6YtT6kLrLDZ16YJTBgoQe4GCwI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SwC2xsZsS7Aaw8tO/mlILXz5aaungbk9G2AfZ3boA/6mF3Jy8p2xEcSAFzg0GbqPHCnQ6wdJfXUc8xSFkO0CRXzAWFusSekgyKJT9TcMRExUfkP6jfA3UU7rMYGAezKkyUazvMuxCEkPs9yo0kjLU6K/nxnoo2afjMlera7rnng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=dBL4VcTF; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=EY99yVa7; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="dBL4VcTF";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="EY99yVa7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=3bO7oMH+DvO+quHER6YtT6kLrLDZ16YJTBgoQe4GCwI=;
 b=dBL4VcTFrb5wXTcyovX9cqGAcocOmii4p6pjSf18iLCmjFh1BHvPsrPjjP2zFblTG6kh8t/2efYXhVULGn5paqqX1s51j8dYz3ZQEj0NNshTLLk6aY4U4wuDA8dIK59U2UNSJUVlE43a4vQq2hOiseL/IEL/4W4axgqSY3qDNQAyv4P9rVrqnHuS4ITfx/COerG7PygNRAxcNEbG6q4vKAEdZhL+BUId0LbppvHk97xrZ2kOUT7xM8E/VGE7MAx5/k16NYcfKtVAKFgXiSWjhH8kdu3YASIhtAotoc7DxxQ2zz8wFcPYfIdHArSme9pc7I1TC3+W7XK9FlEarF/gRg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022129.outbound.protection.outlook.com [52.101.48.129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 0FA8F6C0067;
	Tue, 29 Sep 2026 00:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqjlW7xUiKRkYN+wNmbMJlEsnlrB9N2VUt2eGvrQHZRrl4RIRyH40k+K2/B3VuhLHVGuuXS9l0MVNwohlBtCV+zceOxJL6HdcDb8TWPjPvGqLtRuJXk0zYjnOc7tN8LaFc1YSTEDhDnJzydS6ds9rw2gPNAGuVWEFgeK2kp9CWyz7Odb/+BqeAyc+PyIqlE0JnWeKOZLThzhDp6mEBlaA5jSqFGlerjWzT5GZJmrijiYbYj71kWaOQdLtlwiGa27H2cgp+9c1UYfaJ1hg1H4dG/9WMjjurbB5/4yEV6PAljUmKQ4MGkbQwdTl055lG4OE1g3YhCOGWwviEQ8A1XsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bO7oMH+DvO+quHER6YtT6kLrLDZ16YJTBgoQe4GCwI=;
 b=P1ptfWSZEoTwZDafyLI0PrUdutx+mO6XdrCatAb1qGYF0lTNmVgvl6i/nXigrQwQ7oMFh3pK6OBGvxZWQgcwsNrCrBcatgcBvhaoH2zGwhYpFCe0SiMMysgIE7Yxvmc2NwaHv0Ocyo2va0/zkKPEghJCTcQao82HxtXg1HmqwfH4gja+sD/WN9eaBQIXm7qxe7yhGapaCeMTLfHC6RRVG4HU1KL/f0l2McL2mNUuLOyB19c+Atz0JYzbRmUndcqESSl4pfXNHSJpNU4PQVif6uR3m30mgLkCQXtwWyWpLgRB5bABlnLdvTE/VNqqTxASyC5YKwcBnlRi5G3jvVjyhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bO7oMH+DvO+quHER6YtT6kLrLDZ16YJTBgoQe4GCwI=;
 b=EY99yVa71n2oDsaO81R3TopmNQmL6mYp3mjKLURXAyE4Q87a7eaKfK5M3Umi7MxdAqxbHGx0CsByEy1hRKhtC7tqGExN+k69kDIitmiRgtIRy/3IjyVGOPea5a79RPGnJ1uTT5CsVvbBp7heTY/hZHiRfh24qhkZiMyGNWWkDCzEsopZM1TpFuSZqc5LaeIc+hbb+XBmgI5UwmHRnhO4Eo7Quhdihrn6h51Jsdh44eUqkalT/F2q5KRUR8KXxVMnvRBThDceiRYzbAYyc2Hg/M6x3u9ZBMcTCsW2Xw6ORUXx+q+qaH85AcBAXXI3Lj26Tjph5FkFH8Fx1D+20FdzcQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS7PR20MB4647.namprd20.prod.outlook.com
 (2603:10b6:8:76::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 00:38:45 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 00:38:44 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "jiri@resnulli.us" <jiri@resnulli.us>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "arkadiusz.kubalewski@intel.com"
	<arkadiusz.kubalewski@intel.com>, "ivecera@redhat.com" <ivecera@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cjubran@nvidia.com" <cjubran@nvidia.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "dev@kael-k.io" <dev@kael-k.io>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 00/14] dpll: add SiTime SiT9531x DPLL clock driver
Thread-Topic: [PATCH v10 00/14] dpll: add SiTime SiT9531x DPLL clock driver
Thread-Index: AQHdSgVX5pHuy2OFZkS5BUm+FBBzRrbkrmaAgAATUYA=
Date: Tue, 29 Sep 2026 00:38:44 +0000
Message-ID: <20260929003843.29474-1-arouhi@sitime.com>
References: <20260921201108.42676-1-arouhi@sitime.com>
 <20260928162935.713c28c8@kernel.org>
In-Reply-To: <20260928162935.713c28c8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS7PR20MB4647:EE_
x-ms-office365-filtering-correlation-id: 18517bf2-197c-4311-f9a5-08df1dc204ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info:
 JYWcMxDh7sTuHRbxLfMQ/A/+lA0fz77agIOXUvTYgDYIrFcKKITx3AtprLF8wyQgHfFMNExVJ08fZn28JXGjAHDnjKf5bo/8s5aOWYJ6mAVmI9nF959MNtdqOlOdcGcuiEGOeHo5lZnO67nYgy6xRPDZpWgAFo6eAJjbG87hsYX7HM0BPj15DHqr0zRRg74bUWUwcoOH0sK05rIJDwXD/IDPjEkyKtB8BDfMixUoWXhRLMrfM2KCyk2Nm+WpSgLaw0Tc6yL61SKZkJ0C9WR4FDn2+m3IYmrIx3Q6M7snQHROpr9OFmqN61hY2HYsfQ/7h1i5Ybc74WqXe5pVAelsMRA2EPsxo8BUQCPRLTXJLpCvQ0Mf5/dMiX9BVtMHAk53j9Dp5g+sz0F/h6EXU+t7ju5DvEnlA/EPcnOpY60Tg7Lbfn1GX3dvgNh+F7xifqGrKeonwZKRhsFobM/FjNiCvY32psmlRyyV9m/naAM2nvHjE2UjWZy+nNQROEaTR+q4egNTDk3KXOIO8qrX2s0BaKqPKlKMp+h6Qj7AWUb9t8WP5mL5f9U9dUhWPCbaIhiCrf0W+mUd09fKlzdvnV3o3cxieP+NadGR5F8YkvVdybbv7zS/Kq84cOcr8P4NOasmy5j37XsLptrrn2OSvOMSQy06mMNw4K9Qe0uMgD85g7jjrkGEzKwDrNsNNgv7kmDja6srLynw2ME6jf/ct3JRBUrTxeWGNDIgjQ11RoUrKd8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?anUl43jf8f5a9LcEFkErDkZdJW72Ae2Cbr1GZ43W6Cl29gUjCwS9knbstM?=
 =?iso-8859-1?Q?oZwPzxHRUiM7Uo4trHDn6h/IC/BKXuXzKmHJXxg+WJXBPyHBGP0j8mHTvl?=
 =?iso-8859-1?Q?g+RGM4rCtFhg97Rzu4EOjCofoxecJgkPUmI+bE8WeiH+Pnk5Q8GkB+SEb4?=
 =?iso-8859-1?Q?TRSFdBrCU2fZk/1urVTwEYd25J17kiJYW7zPpqXqFruE+7Pp2XUFktXq53?=
 =?iso-8859-1?Q?4Y/w8PUIX5EPr8lkx7Hmll8L+nsn1z0CsHoL8PslAjswUkgHwUCo+Hxfc5?=
 =?iso-8859-1?Q?1b4Le6izOWpElG748UmneBnFrQ0bS0MDNblluSBRj+N5ks1pmjjgJc8uNL?=
 =?iso-8859-1?Q?EiCRGKGj0W6wF9Y2Tkr9h9NYxXErUE63Ztma5qlnOzFO7+Zbs5EXBoSVHY?=
 =?iso-8859-1?Q?hMYkWYIG6AF++UEb8Efww+7J0xXbeGOz8+MJ/wk4oO3nB1OsLyHSeCmNn5?=
 =?iso-8859-1?Q?QD1WfzdBU/VBeK21HEcPdYZZL8PpJ0IBsq5Bu5Ok9+eOTTyhxTCOFut0+s?=
 =?iso-8859-1?Q?JfvGWZ9khapWnvYJCF8sAx9G9WM8/u5Wd3dzzjErj81UVyUytp5uyUfzEc?=
 =?iso-8859-1?Q?sXCOJy0+30/K81pKTKQWwow8tAhaCE7eOIbuFIIXbmIk+bNdbr6GrmDaL1?=
 =?iso-8859-1?Q?T1MyaR/ijayy4sDnte1GO4gEfsVhHFpPVqKSiuCkzCsCDxzCMHFLjgX7ro?=
 =?iso-8859-1?Q?nboiyffV7XQfHfWkeQdtNMTq0Rwf9ggkkECDK1Kv8JgQqJ5OCokVBjfeer?=
 =?iso-8859-1?Q?qX0NQRWPXcA/3wc2Zh0kiygPaRXRTr3puJLWlBNjbCgT1CjjV3X/VIFUdy?=
 =?iso-8859-1?Q?/S/t5hcflQcESFIvIMpLRYDu3fhwfN6Xw0juBeZRfQhq4LBFSyU2vAtjbd?=
 =?iso-8859-1?Q?jKLXA371qHegiMsby6MQszkxUbDQJ1vVDj5jQ9EewKTWcURb9PalKsq9fd?=
 =?iso-8859-1?Q?GT1ur6OPwPdwZoUsHMxUkKUcMgmTuyogGOG0X8vFj3d+bU4jcBUI7AoK4m?=
 =?iso-8859-1?Q?iL+KkKQjdzIYJVVJqIkRZdadZ7YOYqzJeWyeRy3pHC/MNIiyxiaMBpC6xz?=
 =?iso-8859-1?Q?HC6o8X+kUxkv8qbJgiOgwTohvXBYs+yiWodYZlP9feCO2cterK19oj/fNJ?=
 =?iso-8859-1?Q?d7a9O/VEtszIOmTkwbovPY6Le88tD+bTHqwPklTj9fFOb6wHOORnOacufN?=
 =?iso-8859-1?Q?pc8eg2arOVureFC7DSh15oNnKIBTVITZXUui0NkNPVDDLIIhN/yR7UQaRY?=
 =?iso-8859-1?Q?z44MHbXoD4gxFHzHhr6oNFyyB8TweTZ9QeC9cNr9Db109hz9eydymYx5Lt?=
 =?iso-8859-1?Q?J01+x3epOgFnEb5ej72bgCi1NPd+/Ogq1GBXTpYV+tdZ7DB+xa9C9sXXh2?=
 =?iso-8859-1?Q?BNp/nvQpsOjGDJsgZAPci5tiDJahh0pQ0ExxZabHLUULbQ6qgrLZeLHtcr?=
 =?iso-8859-1?Q?JqN3WgCZrgFEGAjPLZI2DQ8gM84bf8YmqBK3TY54PKP4g47RNCOpY5Wr1k?=
 =?iso-8859-1?Q?ftbbSoXJSo/AHG5yFGSyA0BWTO+dC745Huug0mLfn2FwZ0lelhs+TbDRF2?=
 =?iso-8859-1?Q?3vJCu05AiXF2RuDz82k9K9YKROuKwM+QCfqDnvnLFGbuiSJf5Mgr2oY/TF?=
 =?iso-8859-1?Q?VrYSD7BxcFgEgwiufzhoHPc39N8/pIAAu4JTg7rCM17jCX5huFjVHxNY8H?=
 =?iso-8859-1?Q?m+UytYl+g/eCk5kB0wU2gDw9zyVw0I1agsXkqR4kE5LFU5kfa8jKkwjrBD?=
 =?iso-8859-1?Q?j6gP1LPzc82Mshbi2wmzezBdSh+3/11vq9/kE4XDyA6ISk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	EwujvkUA5LCoH6FTIJmRy87ZBYidC866DhdaAtG8qeEQ76pqTj7wwHMtfAnRBxV1Aqhqqfom9RH/rHZHzsOD9KFCCSBe7mm0sre5oGAaNRaqTxB8W5OqiAm8YwXJ8/X44RvOjrOwiRNlYJo/jr1Jya/QMjQRZv8PmULTL52EauSdzp/1BlKbRUhY+NM+dyA+C7f90sF+vWk2OaaJv+HlH70hRt5XQvIjbGOnUbDuIvAfdO8zRz++7n3Ttukux7YoDBRNgotkdagk2yTNu1BcYJ8PKN3ppD2XmM8Miu1cPed+jzDqxL6eH0nKBBunfdxYpjl28bX6yas+0OJa0Hff7g==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18517bf2-197c-4311-f9a5-08df1dc204ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 00:38:44.8679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6mLgesJP03WoEt6xEwHtqtZUqMoz3ANNvZzAmSLZvOJuyvHxoJaaIjVHpU8AIJSV6WKduIz9AtpcVfsuWRv5oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4647
X-MDID: 1790642329-BD7ekB8QZ8RU
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1790642329;BD7ekB8QZ8RU;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

On Mon, 28 Sep 2026 16:29:35 -0700 Jakub Kicinski wrote:=0A=
> This is now the oldest series in patchwork. I'll drop it based on AI=0A=
> feedback Please LMK if none of the AI-reported issues are real and we=0A=
> should restore.=0A=
=0A=
Please do drop it, no need to restore. The issues were real -- two of=0A=
the four marked High were genuine bugs, and we are dropping the FFO=0A=
patch altogether, because it was reporting the wrong quantity for the=0A=
attribute.=0A=
=0A=
75 of the 82 findings are fixed in my tree. I will answer the rest=0A=
on-list, including the binding question on patch 02/14 that carried=0A=
the pw-bot: cr, and post v11 shortly.=0A=
=0A=
Thanks for running the review -- it caught real bugs.=0A=
