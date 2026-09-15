Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0E11A6839;
	Tue, 15 Sep 2026 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430432; cv=fail; b=SEWVOh45dYRzuyq08Ls4fGNncOiYhqWkEc5C8H9W7Hj0gqI7r3l7lZpHHWR28WS1iulNwmw28l2Sa6jVuIsKYivwtnpzEl8wZideMmxTyr+JGl8SurqvAAnEX1FKmzaycvCRPFSn18R/AfDSvjFn01tA/7JG0Ydei1RKZTcU/Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430432; c=relaxed/simple;
	bh=jwzrVbTKnCH9vVkv7hA8dY20QZYbB+dFW1pKv44Gn/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xr/54wNqk28YHrbapXzcM9UkFERm61i3c0Q/ef+d0oTQQb7scl3E4BaJKkt4bpGkAh7HoAZ7CEtlKRj3ltB9nrYByHgwqqtWvicfldTYSN3C9p3tfe4L+AHENNg/wOWZqJQbjOu2UNxFh0vKykcFRGRYCazk2SV5OVN3TW8q4xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=BH/fDKRJ; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=baNe9P+r; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="BH/fDKRJ";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="baNe9P+r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=2VvsipK1izl+Yhy9EfuZS0b6gbeUh6Kbzie26/salRc=;
 b=BH/fDKRJl+7qvHAyS7qdxLBRYME3FL+rz87Z3OprPD4b0JesVekp2Zf/VddcxxKEYf6Tk0fulIxCRQ/RaycNEnmcVOL1yRQmy4VagezRhoZLLGXvk2yCRdjZZ+no7raBNLAHgU2dplCxGPpfIqjTqGuP+9vbW1/LJ8GgmLiRimpEPpb19MSkhzZNxrm75byjrNVSsnhSYsJDu1Xrbcip9eGp/US+yGVsbkYvjteRmnLsoNOjkiYbkLLCD085BCFKOq5nlg7yvXZdnvmUq8DfLxkp4QDKkDatvwzgxEMj/ViKa6qbsCj3t0eXOBeWqlOCt/1Ye/pBUYyGq979RhG7Qg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021084.outbound.protection.outlook.com [52.101.57.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 12C57100075;
	Tue, 15 Sep 2026 00:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3wfmbPxh9Yzh7v3Iqc5k8BJ/Uyb/lxgYVIz0vqikKwQIX5X/YhTTE7Ey4j5GKTnPDqWKK58eBegdp68oWOGkOKrfJo4QvbjP0v8/7aVeEtoX40swkQw4ErBPiWDC5Iba7c72SUae3tDGPVsVC3NzT6XfPSf9dGnnRwWWG+OkNVTCDd169u6wlxTsrKaqhjtMQFlTJ2esV062GIWr0HLCCr9GN3eoEYi9r1wFGg9wPVX3Es/Go5YwqoSzEPU9LyTRgy5+JaDvTA6uKnKXWEPeSJd351LSi2KKSVKoZJFofR/i3Rh6iSelD20/bL7h8cNUgkGWK47Ts9j1nKiD1scQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VvsipK1izl+Yhy9EfuZS0b6gbeUh6Kbzie26/salRc=;
 b=ktKndIRB8Owi9g06fE3jX5m8VxuBTI+xzPfSooEq0UVXNiAUlMv1cAwhz8d0dXLK+JwMkbDJlQXhs3ubnhvB9Pf6PiNYiVMzTcVudeL57T1BvkSAEkl+/fLnq09m75hTXNhvwsCCwZi56SUTkYee97WzxwWDfrOGpq8bvr09KEpEqJSidd6ALXzVPbgYVac37Cth8STXNXD1kbyRRun+lCHRcP2boZ2pMFvcig1U3NN4ZY7BlAhdtPH6MMHebhKLKOVNIpu7T27PSh2KbeKKuXaTvF+JboC4OZQmNibgfe/4VqftXpXGIx/T24nXfGlqNaRM4dOwru9CKsx1NmIppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VvsipK1izl+Yhy9EfuZS0b6gbeUh6Kbzie26/salRc=;
 b=baNe9P+rfxvlgNhsjVXo/eF+ARiOcADtKOmMx8CPiMysdt8Mj0Js+Jz5z0zaYFT1cUO4uKWZbvtuDTMLCsshEY4IX6CqG4hmeXAtqtHOejOyTDzrfsqxkileJ3/4NIdbCUxqB25MxPbsxZkVmGQYSzbSBVX1oH8sKR/4GFD235CD3EvqV2Hi+JkUepTd9WHSZ8eqXsbSP51Ig+vTk2Zzv8UNUrMxM6e9Tr96NvPmmPZEnP38sME62FpIAMH7QqmIn11Y8ad1uZKptGnt3v9FZt94vPSo+TnRS683+joC8aL94Qa4KRPfv+PP6dUb8mz/gRWajpbfMJI9n7EuZRcFUQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB4277.namprd20.prod.outlook.com
 (2603:10b6:510:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:00:20 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:00:20 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH net-next v9 03/15] dpll: add basic SiTime SiT9531x support
Thread-Topic: [PATCH net-next v9 03/15] dpll: add basic SiTime SiT9531x
 support
Thread-Index: AQHdRKUxgmlRKX+8FUemhwI5cng9KA==
Date: Tue, 15 Sep 2026 00:00:17 +0000
Message-ID: <20260915000015.80480-4-arouhi@sitime.com>
References: <20260915000015.80480-1-arouhi@sitime.com>
In-Reply-To: <20260915000015.80480-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|PH0PR20MB4277:EE_
x-ms-office365-filtering-correlation-id: cdb8e8cb-0ca7-44dd-dcf5-08df12bc552d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|5023799004|56012099006|3023799007|6133799003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 o1qvU+KacaO8QnyKahBnq289b2TRJQC9WlKyloLJZPAm+NIWQrFf8RW4jm88XFjzbexGwb3q8txrjiE9nWVJzWWJgD3AuOScAWy9p8IIF9Ycoq4BiFS6RFxdkqzCjIGYiUzQ42EeWcwS6ydfSGp/za3F5S7OFW8onjl8cH7meE1bDnSmZ3Jk/lMOsZWfk8khnQUsMRh/hP7vDvSghc9lOlox4gbPemPIN7ReRo/kR+O/iGOHiFeOi7lBMqpA9ibfndfXTy0hHmyasqoYdYaOWd99mT+ys/ZD+PaQqUtw8caqEbeEhMQ7AKZBNCGjNYKf9mmz+TqKuyfs5MJCmU3w062FvwcCtxGJYSg27y3E/nUd7/6ZHdjkcbH1XYLJOpsunebCgVPHg/VimYEhik57FyloCpdLtjPZ6Dgisg4UwKylksq3plgcR9YF3v4F3zEOlGmscLd+luxcgPVJw5NIJBfWrfTq+XEoYHvhcIHGqhLnVwEK5KcLbhN7UpC67sCPHv/5ZLU6y/vRkc/SlM6yeN2zrJX3HA+otUE2m5mP5hCXOtDya75HhyTsln9ySD4novG7ZB2knXDZinS+slzFvF+QxiHFVXoyJWxamEISQHY+JdzyLGnN3373tG6MTsxZteyvfIqSrfPr0w1oguFkF///0rg6VQbUWfJSgFn5SgIHvEM+2DV7SW/4D406rprDTt0GOKnV0czbM5ugXHcj0ccx/LEVZtwKskLOBQE6R2o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Jsml/BGowpNk2AMFhVciTunUe4D1aFLwwX62Cau7mVqJ5DRm2sMDonQ4Zs?=
 =?iso-8859-1?Q?vNB2G6/S3Nxhi3SmlhQpwPHeGwVwyku882CVqaQnOcJDDPbD8YvbZYNxGH?=
 =?iso-8859-1?Q?gTaSJzZr5lumUZb1UWvAmazmQbUmIf6nhqlGMU9R+a5bQgknPHmIscgGd8?=
 =?iso-8859-1?Q?ItTnyvEWe1WbttuCpAl4aRdohUDCdM+pEdX8efF3we+y1glVjnspVvt4Rx?=
 =?iso-8859-1?Q?aLa1g5v1Qy/oo7YVj5mCStilVYAexlCQXqC2jT70M5I8vUrvstVN1FiU6r?=
 =?iso-8859-1?Q?9KQu8viS65l2XfNi2aSNOH4Fb7mvtZSYix8RT5zpdh5Fto1wRI0xGuBRED?=
 =?iso-8859-1?Q?rFp0RHvVhnxtJMqtTpPG/FIIYL2YFvWzVsGcwwT/aNP0rqAKjWXYbGsl9Q?=
 =?iso-8859-1?Q?PbGuqlL63WIYT/XNTm5TTofMs7vf3Y0xQ9uTrXlx9rmPCkSmfyOMOkfzf5?=
 =?iso-8859-1?Q?x6A+Fw+QdEi0g8qC2F1FuMiiyds+ACUXrVXjL5MQnluMolbq5wp6UsBoV9?=
 =?iso-8859-1?Q?rjT53H2M9osMsWvr93ZtntXEQCVu56KF6iLqLn/9t4EsmJavVGa86Xl575?=
 =?iso-8859-1?Q?tGZeL+h0DYsAeic5oQVUVhhlxv3zRLn6/6m8Cmq3qecADNVthEWPfvNgm/?=
 =?iso-8859-1?Q?tHOZCctzAa9eJoDvxa4FfehcLJH44roMPwR6GyHJqOUsTYAJ593srtoD8A?=
 =?iso-8859-1?Q?PgWn0oDy6joiCQGgRZmU2r1g1FBXsYzALwYA0ADe/fVByUJbkSMjhfIBlD?=
 =?iso-8859-1?Q?vYDGVdHUtTSul5FoLL2eXVyLP0pC56glPFAP7zE43Mstmc3CFi1BlCoALa?=
 =?iso-8859-1?Q?6e1ZMzsrURdjIiKFDxqZvJb6XohgFtkv8GmXzrA6JNIoISvQT5SJOgbVSd?=
 =?iso-8859-1?Q?2v/HjQkm+7qEvkzVexYzNXLOk9Cx9BFlkRFcxJPPbbQB3sqsaHK17lkxNe?=
 =?iso-8859-1?Q?HJtiaoGLI8TFthxWRxAq+k5jkI4yw+n80o+g2B8lpqf8kuj2tNSZeEEqz6?=
 =?iso-8859-1?Q?zvpfUXBN22q+3hVkhpmGZmSdrRTlxMjQDWpYqAbpWHE805IY6ix1/2DLYG?=
 =?iso-8859-1?Q?vKNjWtCOAARLqZzDEi3r+zHYxjISF8Uwq8jmYNAnwka96MwL1XGp/3xt8L?=
 =?iso-8859-1?Q?Wu2/59cXsMhFtjcLHO2hdUF9CDnj93a/lhEqd+uOmnnjwAGD9MBKtHaQye?=
 =?iso-8859-1?Q?vS8mJPYy4hePL3coyyMeoGw3fRg5UsuBiEaztPjJRDWv/zydruKkzcRnAl?=
 =?iso-8859-1?Q?nw6YFwITxeXxzi4jw7fR4vD9gwhhOOtIFD9m7v7HmGgpE1nzTwZwIlm2GB?=
 =?iso-8859-1?Q?n3ZpJViTB5jj3v4LZlCmjxwqAmU2RPaH7+cmZmkQcDL+SUg3PLgwDgfC8k?=
 =?iso-8859-1?Q?nS20dXKVr3Rz8Y0IgEwQ/ur+qO13wk8CiOQVwvxjnxqS1LjMQZ6qExCUDw?=
 =?iso-8859-1?Q?jW95EhOuqSloS9ify8IMuotSpjnaibO1TCrUOEZpqj35BjqoCyCXPaZrCa?=
 =?iso-8859-1?Q?CrwyuD5gDb5ZLhsqsTzg1umzfQ+dkWseungVfyJzSas5jQ/u/3rqK4uyME?=
 =?iso-8859-1?Q?ZeQdeFNov+5asHUOkISbcOPJhTilczdudrHeVSW7iOA3UXzYAy6uQNPwOQ?=
 =?iso-8859-1?Q?CVsBUibXi1f03vOotzOt+xPI/4ENujIFwB5N8iPy+W9RrQe91wi8HSyA/0?=
 =?iso-8859-1?Q?WndlMnOtnhI8Ef45AT8YUnIhnDvHgcDQvkU6+u/Fcsfj3SAoOcuVIJoqL8?=
 =?iso-8859-1?Q?rpGCS0ADk65V1rAVMKGm1MMrN4dDIe8EI0UxSpVnqh6P0Z?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	16xHKWWq1/OIXJQkGMlMhr8dNHM4Sixr55CWD4hCU3zjQQqUD1phyVq3jhbEn27PgBRKQyiyjOpt0q9gif0JslOoVtgZTpXDkXEqUvk94ABuTTiZ1rZTXOGRyioH/jHOz0xKtB45sMY+NGZJGqNG1sE/y+JbRoGssBZs11ZNmhLviv8pbTiWlg8GXd/g0oWp3CMtFgZfKsloXOeIDCYG9vzZgZWQkYB1gwX+I0mgTuRDKfpGQBrgtWGadgzeMvQ6zh5b3ab4HrTuoCUVE8sQcd9Wesd8kkA3xj0A7eukMSoEJBRPvj5uTKEPGrsSnG+AV4XhHqOa/q4Q8+IFU5Mdqw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb8e8cb-0ca7-44dd-dcf5-08df12bc552d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:00:18.0045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpudnD0Qh52yExB496qb5cZnVtC8wJ6trt75SNkN3ibOxc3cNAdYjh05OSotfESxrXLu+mVf1mimVfgigXWONA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4277
X-MDID: 1789430427-bDjYFEoaq1J9
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789430427;bDjYFEoaq1J9;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The SiT9531x is an I2C clock generator with four independent PLLs, up to=0A=
eight input clocks and up to twelve outputs.  Later patches register the=0A=
PLLs with the DPLL subsystem and expose the clocks as pins; this one adds=
=0A=
only what is needed to reach the device.=0A=
=0A=
The register space is paged: 32 pages of 256 registers, selected by=0A=
writing the page number to offset 0xFF, which is present in every page.=0A=
A regmap range configuration describes that window, so the rest of the=0A=
driver addresses a register as a page and an offset and never touches the=
=0A=
selector itself.  Pages come in pairs for the PLLs (0x0A/0x1A for PLLA,=0A=
and so on).=0A=
=0A=
Probe reads the rate of the crystal feeding XIN, since every frequency=0A=
the driver later computes derives from it; takes the optional reset line=0A=
and leaves it deasserted, because the device configuration comes from=0A=
efuse or from a blob applied before probe and a reset would discard it;=0A=
then identifies the variant from the single byte at page 0 offset 0x02=0A=
and refuses to bind on anything unknown.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 MAINTAINERS                    |   1 +=0A=
 drivers/dpll/Kconfig           |   2 +=0A=
 drivers/dpll/Makefile          |   1 +=0A=
 drivers/dpll/sit9531x/Kconfig  |  17 +++=0A=
 drivers/dpll/sit9531x/Makefile |   4 +=0A=
 drivers/dpll/sit9531x/core.c   | 272 +++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h   |  91 +++++++++++=0A=
 drivers/dpll/sit9531x/regs.h   |  56 +++++++=0A=
 8 files changed, 444 insertions(+)=0A=
 create mode 100644 drivers/dpll/sit9531x/Kconfig=0A=
 create mode 100644 drivers/dpll/sit9531x/Makefile=0A=
 create mode 100644 drivers/dpll/sit9531x/core.c=0A=
 create mode 100644 drivers/dpll/sit9531x/core.h=0A=
 create mode 100644 drivers/dpll/sit9531x/regs.h=0A=
=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index ef07a53b5fc4..73cc0634c213 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -25162,6 +25162,7 @@ M:	Ali Rouhi <arouhi@sitime.com>=0A=
 L:	netdev@vger.kernel.org=0A=
 S:	Maintained=0A=
 F:	Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
+F:	drivers/dpll/sit9531x/=0A=
 =0A=
 SL28 CPLD MFD DRIVER=0A=
 M:	Michael Walle <mwalle@kernel.org>=0A=
diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig=0A=
index be98969f040a..f8f7ca121b93 100644=0A=
--- a/drivers/dpll/Kconfig=0A=
+++ b/drivers/dpll/Kconfig=0A=
@@ -23,6 +23,8 @@ config DPLL_REFCNT_TRACKER=0A=
 =0A=
 	  If unsure, say N.=0A=
 =0A=
+source "drivers/dpll/sit9531x/Kconfig"=0A=
+=0A=
 source "drivers/dpll/zl3073x/Kconfig"=0A=
 =0A=
 endmenu=0A=
diff --git a/drivers/dpll/Makefile b/drivers/dpll/Makefile=0A=
index 9e7a3a3e592e..4adc50d748d4 100644=0A=
--- a/drivers/dpll/Makefile=0A=
+++ b/drivers/dpll/Makefile=0A=
@@ -8,4 +8,5 @@ dpll-y                  +=3D dpll_core.o=0A=
 dpll-y                  +=3D dpll_netlink.o=0A=
 dpll-y                  +=3D dpll_nl.o=0A=
 =0A=
+obj-$(CONFIG_SIT9531X_DPLL)	+=3D sit9531x/=0A=
 obj-$(CONFIG_ZL3073X)	+=3D zl3073x/=0A=
diff --git a/drivers/dpll/sit9531x/Kconfig b/drivers/dpll/sit9531x/Kconfig=
=0A=
new file mode 100644=0A=
index 000000000000..47aea8674327=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/Kconfig=0A=
@@ -0,0 +1,17 @@=0A=
+# SPDX-License-Identifier: GPL-2.0-only=0A=
+=0A=
+config SIT9531X_DPLL=0A=
+	tristate "SiTime SiT9531x DPLL driver"=0A=
+	depends on I2C && NET=0A=
+	select DPLL=0A=
+	select REGMAP_I2C=0A=
+	help=0A=
+	  Driver for SiTime SiT9531x family clock generators=0A=
+	  (SiT95317, SiT95316).=0A=
+=0A=
+	  This driver registers each on-chip PLL as a DPLL device=0A=
+	  and exposes input/output clocks as DPLL pins, providing=0A=
+	  runtime configuration via Generic Netlink.=0A=
+=0A=
+	  To compile this driver as a module, choose M here: the=0A=
+	  module will be called sit9531x.=0A=
diff --git a/drivers/dpll/sit9531x/Makefile b/drivers/dpll/sit9531x/Makefil=
e=0A=
new file mode 100644=0A=
index 000000000000..a221fe55386a=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/Makefile=0A=
@@ -0,0 +1,4 @@=0A=
+# SPDX-License-Identifier: GPL-2.0-only=0A=
+=0A=
+obj-$(CONFIG_SIT9531X_DPLL) +=3D sit9531x.o=0A=
+sit9531x-y :=3D core.o=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
new file mode 100644=0A=
index 000000000000..b0920f76362a=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -0,0 +1,272 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+/*=0A=
+ * SiTime SiT9531x DPLL core driver=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * I2C probe, paged regmap configuration and register access helpers.=0A=
+ */=0A=
+=0A=
+#include <linux/bits.h>=0A=
+#include <linux/clk.h>=0A=
+#include <linux/delay.h>=0A=
+#include <linux/dev_printk.h>=0A=
+#include <linux/device.h>=0A=
+#include <linux/gpio/consumer.h>=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/property.h>=0A=
+#include <linux/regmap.h>=0A=
+=0A=
+#include "core.h"=0A=
+#include "regs.h"=0A=
+=0A=
+#define SIT9531X_CHIP(_id, _nin, _nout, _name, _map) \=0A=
+	{ .id =3D (_id), .num_inputs =3D (_nin), .num_outputs =3D (_nout), \=0A=
+	  .name =3D (_name), .clkout_map =3D (_map) }=0A=
+=0A=
+/* Per-variant output index -> physical slot mapping */=0A=
+static const u8 clkout_map_95317[] =3D {0, 3, 4, 5, 7, 8, 9, 11};=0A=
+static const u8 clkout_map_95316[] =3D {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, =
11};=0A=
+=0A=
+static const struct sit9531x_chip_info sit9531x_chip_ids[] =3D {=0A=
+	SIT9531X_CHIP(SIT9531X_VARIANT_ID_95317,  8,  8, "SiT95317", clkout_map_9=
5317),=0A=
+	SIT9531X_CHIP(SIT9531X_VARIANT_ID_95316,  8, 12, "SiT95316", clkout_map_9=
5316),=0A=
+};=0A=
+=0A=
+#define SIT9531X_RANGE_OFFSET	SIT9531X_PAGE_SIZE=0A=
+=0A=
+static const struct regmap_range_cfg sit9531x_regmap_range =3D {=0A=
+	.range_min	=3D SIT9531X_RANGE_OFFSET,=0A=
+	.range_max	=3D SIT9531X_RANGE_OFFSET +=0A=
+			  (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,=0A=
+	.selector_reg	=3D SIT9531X_PAGE_SEL,=0A=
+	.selector_mask	=3D GENMASK(7, 0),=0A=
+	.selector_shift	=3D 0,=0A=
+	.window_start	=3D 0,=0A=
+	.window_len	=3D SIT9531X_PAGE_SIZE,=0A=
+};=0A=
+=0A=
+const struct regmap_config sit9531x_regmap_config =3D {=0A=
+	.reg_bits	=3D 8,=0A=
+	.val_bits	=3D 8,=0A=
+	.max_register	=3D SIT9531X_RANGE_OFFSET +=0A=
+			  (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,=0A=
+	.ranges		=3D &sit9531x_regmap_range,=0A=
+	.num_ranges	=3D 1,=0A=
+	.cache_type	=3D REGCACHE_NONE,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * sit9531x_read_u8 - read an 8-bit register=0A=
+ * @reg:	register in SIT9531X_REG(page, offset) form=0A=
+ * @val:	output value=0A=
+ */=0A=
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		     u8 *val)=0A=
+{=0A=
+	unsigned int tmp;=0A=
+	int rc;=0A=
+=0A=
+	reg =3D (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +=0A=
+	      SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	rc =3D regmap_read(sitdev->regmap, reg, &tmp);=0A=
+	if (rc)=0A=
+		dev_err(sitdev->dev, "Failed to read reg 0x%04x: %d\n",=0A=
+			reg, rc);=0A=
+	else=0A=
+		*val =3D (u8)tmp;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_write_u8 - write an 8-bit register=0A=
+ * @reg:	register in SIT9531X_REG(page, offset) form=0A=
+ * @val:	value to write=0A=
+ */=0A=
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		      u8 val)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	reg =3D (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +=0A=
+	      SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	rc =3D regmap_write(sitdev->regmap, reg, val);=0A=
+	if (rc)=0A=
+		dev_err(sitdev->dev, "Failed to write reg 0x%04x: %d\n",=0A=
+			reg, rc);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_read_pll_u8 - read a register on a PLL page=0A=
+ * @val:	output value=0A=
+ */=0A=
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			 u8 offset, u8 *val)=0A=
+{=0A=
+	return sit9531x_read_u8(sitdev,=0A=
+				SIT9531X_REG(sit9531x_pll_page(pll_idx), offset),=0A=
+				val);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_write_pll_u8 - write a register on a PLL page=0A=
+ * @val:	value to write=0A=
+ */=0A=
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			  u8 offset, u8 val)=0A=
+{=0A=
+	return sit9531x_write_u8(sitdev,=0A=
+				 SIT9531X_REG(sit9531x_pll_page(pll_idx), offset),=0A=
+				 val);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_update_pll_u8 - read-modify-write a register on a PLL page=0A=
+ * @mask:	bits to modify=0A=
+ * @val:	new value for masked bits=0A=
+ */=0A=
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			   u8 offset, u8 mask, u8 val)=0A=
+{=0A=
+	unsigned int reg;=0A=
+=0A=
+	reg =3D (sit9531x_pll_page(pll_idx) * SIT9531X_PAGE_SIZE) +=0A=
+	      offset + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	return regmap_update_bits(sitdev->regmap, reg, mask, val);=0A=
+}=0A=
+=0A=
+static int sit9531x_read_variant_id(struct sit9531x_dev *sitdev, u8 *id)=
=0A=
+{=0A=
+	return sit9531x_read_u8(sitdev, SIT9531X_REG_VARIANT_ID, id);=0A=
+}=0A=
+=0A=
+static const struct sit9531x_chip_info *sit9531x_match_variant(u8 id)=0A=
+{=0A=
+	unsigned int i;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(sit9531x_chip_ids); i++) {=0A=
+		if (sit9531x_chip_ids[i].id =3D=3D id)=0A=
+			return &sit9531x_chip_ids[i];=0A=
+	}=0A=
+=0A=
+	return NULL;=0A=
+}=0A=
+=0A=
+int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct clk *xtal_clk;=0A=
+	u8 variant_id;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Fvco =3D Fref * (DIVN + frac/2^32) with Fref derived from the XO=0A=
+	 * feeding XIN/XO_CLK, so the rate is needed before anything can be=0A=
+	 * computed from a divider.  The rate normally comes from a "clocks"=0A=
+	 * phandle (clock-names =3D "xtal").  On platforms where the firmware=0A=
+	 * does not expose the XO through the clock framework, fall back to=0A=
+	 * a "clock-frequency" device property.=0A=
+	 */=0A=
+	xtal_clk =3D devm_clk_get_optional_enabled(sitdev->dev, "xtal");=0A=
+	if (IS_ERR(xtal_clk))=0A=
+		return dev_err_probe(sitdev->dev, PTR_ERR(xtal_clk),=0A=
+				     "Failed to get xtal clock\n");=0A=
+	sitdev->xtal_freq =3D clk_get_rate(xtal_clk);=0A=
+	if (!sitdev->xtal_freq) {=0A=
+		u32 freq;=0A=
+=0A=
+		if (!device_property_read_u32(sitdev->dev, "clock-frequency",=0A=
+					      &freq))=0A=
+			sitdev->xtal_freq =3D freq;=0A=
+	}=0A=
+	if (!sitdev->xtal_freq)=0A=
+		return dev_err_probe(sitdev->dev, -EINVAL,=0A=
+				     "no xtal rate: provide clocks=3D<&xo> + clock-names=3D\"xtal\", o=
r a clock-frequency property\n");=0A=
+=0A=
+	/*=0A=
+	 * Held deasserted, never pulsed: the chip configuration comes from=0A=
+	 * efuse or an NVM blob applied before probe, and a reset would=0A=
+	 * discard it.  Must precede the first I2C access, as a board that=0A=
+	 * powers up asserted keeps the chip unreachable until released.=0A=
+	 */=0A=
+	sitdev->reset_gpio =3D devm_gpiod_get_optional(sitdev->dev, "reset",=0A=
+						     GPIOD_OUT_LOW);=0A=
+	if (IS_ERR(sitdev->reset_gpio))=0A=
+		return dev_err_probe(sitdev->dev, PTR_ERR(sitdev->reset_gpio),=0A=
+				     "Failed to request reset gpio\n");=0A=
+	if (sitdev->reset_gpio)=0A=
+		fsleep(10000);	/* internal boot after release */=0A=
+=0A=
+	rc =3D sit9531x_read_variant_id(sitdev, &variant_id);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->info =3D sit9531x_match_variant(variant_id);=0A=
+	if (!sitdev->info)=0A=
+		return dev_err_probe(sitdev->dev, -ENODEV,=0A=
+				     "Unknown variant ID: 0x%02x\n",=0A=
+				     variant_id);=0A=
+=0A=
+	rc =3D devm_mutex_init(sitdev->dev, &sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		return dev_err_probe(sitdev->dev, rc,=0A=
+				     "Failed to initialize mutex\n");=0A=
+=0A=
+	dev_info(sitdev->dev, "%s detected, %u inputs, %u outputs\n",=0A=
+		 sitdev->info->name, sitdev->info->num_inputs,=0A=
+		 sitdev->info->num_outputs);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_i2c_probe(struct i2c_client *client)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev;=0A=
+	struct regmap *regmap;=0A=
+=0A=
+	regmap =3D devm_regmap_init_i2c(client, &sit9531x_regmap_config);=0A=
+	if (IS_ERR(regmap))=0A=
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),=0A=
+				     "Failed to initialize regmap\n");=0A=
+=0A=
+	sitdev =3D devm_kzalloc(&client->dev, sizeof(*sitdev), GFP_KERNEL);=0A=
+	if (!sitdev)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	sitdev->dev =3D &client->dev;=0A=
+	sitdev->client =3D client;=0A=
+	sitdev->regmap =3D regmap;=0A=
+	i2c_set_clientdata(client, sitdev);=0A=
+=0A=
+	return sit9531x_dev_probe(sitdev);=0A=
+}=0A=
+=0A=
+static const struct of_device_id sit9531x_of_match[] =3D {=0A=
+	{ .compatible =3D "sitime,sit95316" },=0A=
+	{ .compatible =3D "sitime,sit95317" },=0A=
+	{ }=0A=
+};=0A=
+MODULE_DEVICE_TABLE(of, sit9531x_of_match);=0A=
+=0A=
+static struct i2c_driver sit9531x_i2c_driver =3D {=0A=
+	.driver			=3D {=0A=
+		.name		=3D "sit9531x",=0A=
+		.of_match_table	=3D sit9531x_of_match,=0A=
+	},=0A=
+	.probe		=3D sit9531x_i2c_probe,=0A=
+};=0A=
+module_i2c_driver(sit9531x_i2c_driver);=0A=
+=0A=
+MODULE_AUTHOR("Ali Rouhi <arouhi@sitime.com>");=0A=
+MODULE_AUTHOR("Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>");=0A=
+MODULE_DESCRIPTION("SiTime SiT9531x DPLL subsystem driver");=0A=
+MODULE_LICENSE("GPL");=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
new file mode 100644=0A=
index 000000000000..76a2632f0ce4=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -0,0 +1,91 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x DPLL core driver=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * Device structure, register access helpers, and core function=0A=
+ * declarations.=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_CORE_H=0A=
+#define _SIT9531X_CORE_H=0A=
+=0A=
+#include <linux/gpio/consumer.h>=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/mutex.h>=0A=
+#include <linux/regmap.h>=0A=
+#include <linux/types.h>=0A=
+=0A=
+#include "regs.h"=0A=
+=0A=
+#define SIT9531X_NUM_PLLS		4=0A=
+#define SIT9531X_MAX_INPUTS		8=0A=
+#define SIT9531X_MAX_OUTPUTS		12=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_chip_info - chip variant identification=0A=
+ * @id:		variant ID byte read from register=0A=
+ * @num_inputs:	number of input clock pins=0A=
+ * @num_outputs: number of output clock pins=0A=
+ * @name:	human-readable variant name=0A=
+ * @clkout_map:	per-output slot mapping (output index -> physical slot)=0A=
+ */=0A=
+struct sit9531x_chip_info {=0A=
+	u8		id;=0A=
+	u8		num_inputs;=0A=
+	u8		num_outputs;=0A=
+	const char	*name;=0A=
+	const u8	*clkout_map;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_dev - SiT9531x device instance=0A=
+ * @dev:		parent device=0A=
+ * @client:		I2C client=0A=
+ * @regmap:		paged register map=0A=
+ * @info:		detected chip variant info=0A=
+ * @multiop_lock:	serializes multi-register sequences=0A=
+ * @xtal_freq:		crystal oscillator frequency in Hz=0A=
+ * @reset_gpio:		optional reset line (DT "reset-gpios"), NULL if absent=0A=
+ */=0A=
+struct sit9531x_dev {=0A=
+	struct device			*dev;=0A=
+	struct i2c_client		*client;=0A=
+	struct regmap			*regmap;=0A=
+	const struct sit9531x_chip_info	*info;=0A=
+	/* Serializes multi-step register sequences */=0A=
+	struct mutex			multiop_lock;=0A=
+=0A=
+	u32			xtal_freq;=0A=
+=0A=
+	struct gpio_desc	*reset_gpio;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * sit9531x_pll_page - get register page for PLL index=0A=
+ * @pll_idx: PLL index (0 =3D PLLA, 3 =3D PLLD)=0A=
+ */=0A=
+static inline u8 sit9531x_pll_page(u8 pll_idx)=0A=
+{=0A=
+	return SIT9531X_PAGE_PLLA + pll_idx;=0A=
+}=0A=
+=0A=
+extern const struct regmap_config sit9531x_regmap_config;=0A=
+=0A=
+/* ---- Core lifecycle ---- */=0A=
+int  sit9531x_dev_probe(struct sit9531x_dev *sitdev);=0A=
+=0A=
+/* ---- Register access ---- */=0A=
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg, u8 *va=
l);=0A=
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg, u8 va=
l);=0A=
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 offse=
t,=0A=
+			 u8 *val);=0A=
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 offs=
et,=0A=
+			  u8 val);=0A=
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 off=
set,=0A=
+			   u8 mask, u8 val);=0A=
+=0A=
+#endif /* _SIT9531X_CORE_H */=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
new file mode 100644=0A=
index 000000000000..ae553bec0fd8=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -0,0 +1,56 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x register definitions=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_REGS_H=0A=
+#define _SIT9531X_REGS_H=0A=
+=0A=
+/*=0A=
+ * I2C register model:=0A=
+ *   - Page select register at offset 0xFF, present in every page=0A=
+ *   - Each page has 256 registers (0x00-0xFF)=0A=
+ *   - Some pages are paired (e.g. 0x0A/0x1A for PLLA)=0A=
+ */=0A=
+#define SIT9531X_PAGE_SEL		0xFF=0A=
+#define SIT9531X_PAGE_SIZE		0x100=0A=
+#define SIT9531X_NUM_PAGES		32=0A=
+=0A=
+/* Helper macros for page:offset addressing */=0A=
+#define SIT9531X_REG(_page, _offset)		(((_page) << 8) | (_offset))=0A=
+#define SIT9531X_REG_PAGE(_reg)		((_reg) >> 8)=0A=
+#define SIT9531X_REG_OFFSET(_reg)		((_reg) & 0xFF)=0A=
+=0A=
+/* ---- Page definitions ---- */=0A=
+#define SIT9531X_PAGE_MAINSYS0		0x00=0A=
+#define SIT9531X_PAGE_MAINSYS1		0x01=0A=
+#define SIT9531X_PAGE_INPUTSYS		0x02=0A=
+#define SIT9531X_PAGE_OUTSYS0		0x03=0A=
+#define SIT9531X_PAGE_OUTSYS1		0x04=0A=
+#define SIT9531X_PAGE_CLKMON0		0x06=0A=
+#define SIT9531X_PAGE_CLKMON1		0x07=0A=
+#define SIT9531X_PAGE_PLLA			0x0A=0A=
+#define SIT9531X_PAGE_PLLA_EXT		0x1A=0A=
+#define SIT9531X_PAGE_PLLB			0x0B=0A=
+#define SIT9531X_PAGE_PLLB_EXT		0x1B=0A=
+#define SIT9531X_PAGE_PLLC			0x0C=0A=
+#define SIT9531X_PAGE_PLLC_EXT		0x1C=0A=
+#define SIT9531X_PAGE_PLLD			0x0D=0A=
+#define SIT9531X_PAGE_PLLD_EXT		0x1D=0A=
+=0A=
+/*=0A=
+ * VARIANT_ID is a single byte at page 0 reg 0x02 (95317 =3D 0x17, 95316 =
=3D 0x31).=0A=
+ * Reg 0x03 carries an unrelated revision byte and must not be combined in=
to=0A=
+ * the variant identifier.=0A=
+ */=0A=
+#define SIT9531X_REG_VARIANT_ID		SIT9531X_REG(0x00, 0x02)=0A=
+=0A=
+/* Variant ID values (page 0 reg 0x02) */=0A=
+#define SIT9531X_VARIANT_ID_95317	0x17=0A=
+#define SIT9531X_VARIANT_ID_95316	0x31=0A=
+=0A=
+#endif /* _SIT9531X_REGS_H */=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
