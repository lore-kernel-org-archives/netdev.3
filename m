Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65043EC834;
	Mon, 21 Sep 2026 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021477; cv=fail; b=pqJjPK+573be0sKbRQ53v9rAbx2/wJe9iCAOcaFamuopgqqKekTATg2SGe1hoSXTJUUMq/11gCvdopSw5hgs0fPnkv847CAGsHnpjejxNgqZ7AsHeQgfj718OBicykhW0fcMSDwIMcRuEANFvHAY23Pf3j2NPd3vNuYKyQFkdtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021477; c=relaxed/simple;
	bh=B6T26e2ygWFH/C7izK4SAbuOXDXb0Ob/uk2TPxFErk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FiVNq/cxdYFa3Z9DIyeV7wcJo6LfYci+PSLpp6XN0+SjUmDfvJnNrcqL71nPG9/XNfWIb7XJE97tgynR7P0X82sVIRABYKYZGaUT0gYE5hX1OhKHxCOPiMq49COG9+T5ZLholZ1MHNQks+1rR0D3pw1HHpypViYl1yfAM76M8ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=NGIwYe7D; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=aiusEq3e; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="NGIwYe7D";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="aiusEq3e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=7UNH/Ls3LpSI6de9uvsXc19fqrZvohjH8leJgVeF5sA=;
 b=NGIwYe7DJbf90D8ioQbaTNlQK+RkoRtgj74Ky9WfiAia9ccvl08MF6jiJb22xOPW4NhCHUqR1TbRV9ULlUC8l//uJeJntc+Sj2vVkSA+cNYjJ2YhrEulF5I8PXRUtnWsYR3uWsG5o9wOH40U3zurvW1S+Du1ohxXC3Us9Wd8hrWozNOJp8wpHUK1hjBLaqNjy8Z2U8fFfi8/eNNmb48MKGWY+Bjuj+ErDm7wulX4y3rr9GSGWvy16gQ5xRDZkdVBZddYUQrtBKMgLHkMU3lcZTnguizQXDKoKcXlwASRXa/OWjWdzLNRzMzoXdUJs5VQewQQtEM04uns6iywgxaxKQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021115.outbound.protection.outlook.com [52.101.52.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B4F71AC007E;
	Mon, 21 Sep 2026 20:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0QjUB0/51iuonomaayxSeBuir9kArVu2gBXMEOspQuBku1Z/1hV2NYfyUxRMMR/UtCTKoqWvdAzWvuMjQuzJBEyj4Y4QiPrPWeEed5nn8UKa2+WT7LIopSXtXVP5QMRds8oB45imEF/M3xPqs+K4Yzr0b+p4xA9Lewjoi4pFgfMp2WDeyZsJoVgQ8flO6y1HL+k/oVFhgnTgjgJZwe4TJmsDHxcXmayYsBj56WOu18maoQwrw3jxXVImF9rM6wIqiIPPfw+AzCLwDgbs2MiOSVIoIEH1ESg7AQA7Ei73WyW6sUFOBgD2yWKDX64vw+OEayHb5X2W+uie3YWpL0DZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UNH/Ls3LpSI6de9uvsXc19fqrZvohjH8leJgVeF5sA=;
 b=sdnqrfWZG9wZ/UeHBcue3M+q2HBX58Ze8HfmKJj12i/6J/ar8uvlWQZM94lQi0dGhayLnNa9XaDstaLkQVtt5ua3v5LEzzw7Ue2QskuyFUN5qvb20Bq6p4VAwaYoWEgPkQzVSzzGCq6F3xm1UcbkEivYA0eJisOpRbfR4IDut7ZEk8/84k6JS9ByTTT3g9rYST/N6UPWOWtlz4TS384gU+rJNTnmlxoPpPE4OGM9+d45k3Z6HT5Ug+++xSaifVCYaiPY+UsD4FmY9GsVEG6Awj97N3c4m2ZC7YEUSnq2KE9Mf6buRucpDElHbEHuUK80m4ZlLWKocTpgKE532sZ3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UNH/Ls3LpSI6de9uvsXc19fqrZvohjH8leJgVeF5sA=;
 b=aiusEq3eTtXMkE6OEPPo5ACX/gcUyFCWCqas3kytdPlrloW//DRpySURerCMAl4+zolCVzk8LTb9hvGq/0PdR6DyJU/h5jl5rn2Q6hY9u2oHlD7PQBj9SbrxW0NfO5fvLWFKqcE+yFKKXE/Mf8TGMxn/dM90DBFZQBO7eyD5KCvZsUbu5YOjI07BJ8ljXpx10kmx5yUOVjI+MaZSAU9Qn8M1HUhSOyO6QdxX9Sqe7AWQcfZZEo95XLP5oArJI9boC8OKm4IHInV6aLKpnBBIA37JTkY03BgJaUgjwp0bSxRWghT1B2YSfIsqqTZnk8F00TD8KitLyUgMTUs0Jm1eFQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS3PR20MB7783.namprd20.prod.outlook.com
 (2603:10b6:8:2df::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:11:09 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:11:09 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "dev@kael-k.io" <dev@kael-k.io>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v10 01/14] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Topic: [PATCH v10 01/14] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Index: AQHdSgVXy0I5HSnqCEyR2gvCWQ/pIQ==
Date: Mon, 21 Sep 2026 20:11:09 +0000
Message-ID: <20260921201108.42676-2-arouhi@sitime.com>
References: <20260921201108.42676-1-arouhi@sitime.com>
In-Reply-To: <20260921201108.42676-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS3PR20MB7783:EE_
x-ms-office365-filtering-correlation-id: e523f121-84fc-43c2-9e8c-08df181c79f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 0XnLD8hxFnBl7aA7aN6qMFRTUaG5jKeOhrqC0FQy4ao/laa0HhScmCVQDpHc0F8Eka/L02vSqHo93FpxJ98K7r3S5fftU77ARzoYHnPIxsJuLLt06UyKyjY4xj35Mh0+jrkjMF4j8QyyNbspsFBobI4dO86kysCXn/1oYgXyJYFyVr9+LowYYy8kKUdYjaYgEFnMM0WxleIGTe5ITbAdREtMAbSPLptIcpxKiG5MstcZepVUnG2b2IIdkmo7bpJSkmc2XZ7RctlCbhvA8tTpzZDe20CJKVBZ89QYIARc0w0+hDnTZNz6M8AsAQcPSdjy/PBxz1kyjYyTKmt+dHoxgTFvIcgsWitnuyfKzY0EIKcXfgCEGgJrTAiJJEfwljjsX15OIJNf9LqvCcWR0JraPsHHsLN3y2VHmmvuZ5atvCYvFIPowCy7OBFOXMaWoUCrqoWik2FL5b9yehBEhiImYY13QX46cNXIUV9ovEx5Nl10GYI8DArVospUbMc4q+rjRIPa44zl7UiKKv+BeuZKlY62puXUBMbLwnEkrDCH7qjmpjsBX8CVRULVINIvmy3S7BFv7clTWwXBmB0806EFTUXLdEOjgOHiX6UiR+I1UbGlQrbFzfySP0E/yhEUjqn7htoibt4Tm3pIRTV5pe04I1f4Zz8Fi3U1OjnfEzEozPvUk+mgnykDxJ85g7JGMXWJN+ykmvpocPbCjb28vB3Smx3PMSuRg8eGH5eiwh27EC4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4joYTdxswDoCKM15xpKdIX0mRKyspf4llWPU2NJTTGLQjuJUS27N6ylTwF?=
 =?iso-8859-1?Q?M78LxPuhX4gQf/Mq+0Fk0bdNT46lJjd82O2EmLChdn5SSyg7wYRgDjR5dV?=
 =?iso-8859-1?Q?3l/qzB6GfCiF3s4u9GQAfHDbqga5LwJVeGMNM9+shtE5eEHrUjCxuodlxH?=
 =?iso-8859-1?Q?awjpEHC9A/ntikNa6mwYv8eLfsExw013DGe3mtUzpuGajAcx4YT81boisf?=
 =?iso-8859-1?Q?8tBlrdIYJHZRdLtZXuAorfFf6FnqRh/VRav9UdMw+WLUyHTdD+L2u1addS?=
 =?iso-8859-1?Q?VSnQWMBpZ/UKl5pzgN103zjZ5brHxtQTt4nh3q+NuESs+4wrPvAZVW3g4z?=
 =?iso-8859-1?Q?IN8KTSQ6wsUFzAcAoCBajDg5OoYBEEKGUhurk9k0lDG4oHzubg5te3hfHo?=
 =?iso-8859-1?Q?tY+zNyhqyBmE3Zd4cZ95QPj7RF/ZL3D/CCw0FWNhsFGrZyD3eEjpbENpwS?=
 =?iso-8859-1?Q?9BP15YH07iTdwiNuB6ZgX+TaMOooNxKvG44sbqYlYmxYeogZAF6KxqtV2v?=
 =?iso-8859-1?Q?5urkhEhbYGv5js13+3vEZijmU9D3MK/DzEHLh6bjHZ1PJqf+ZirxtSLgET?=
 =?iso-8859-1?Q?/NAlFwG18/j6bxAy0oaRzZj4A5HtWVv0AcQzPPB8Kz/0MsBGt8jIi131jk?=
 =?iso-8859-1?Q?OZZOe7EQVyXF818xYvX8hvz6E1ztOwbGTnrkhcWSUKJhwJtxNo+EEeJGh5?=
 =?iso-8859-1?Q?NAG3ytmuF/BzdJwg1hxlSPvQfYErKWfmmQXyulA9DVGlphthQaHwMYv2a0?=
 =?iso-8859-1?Q?pWbtf5uaSsgzgPBnxBp0dBXpLXeA+fp24+asaKPQUY6W2q2Eiy+ju4uM9f?=
 =?iso-8859-1?Q?gJCZxW9mtSX5VKCMW2MoTMB2lCKfhS52DQYLiXBh7RdvdhIjf4e2V1ZpjB?=
 =?iso-8859-1?Q?hT028dvyStrw70iVOWtZfiFoqHupmiH79DpQfBw4GPpgT6RLyDITJiIVnm?=
 =?iso-8859-1?Q?3efMhpC2jEcfIv3ryalFEMLzktrSVU8lobphA4zUnRB7uPCRpWwfUz1F8p?=
 =?iso-8859-1?Q?aTW1Sqd83A8NMx/g0hm0nTHjTFZtvux+Bafp4ZvsXtsn/L/NkQKtICWlf4?=
 =?iso-8859-1?Q?CVq4ElX8ZDplffBosIFQ7mvaHotK2+RxvNmsG2iL7mQIc5ZrkhHZCxOKtu?=
 =?iso-8859-1?Q?dbI4lJIjB7nTaFM1XLq36QcxKXunibPKwWbq+GYCYGdRuNvU8ncElTXBhe?=
 =?iso-8859-1?Q?zoVQgEAmnmAUk8b8ZknGARrJ91aMi7bMwCwvokcNlCGSqwhMrgb0S8Hu3R?=
 =?iso-8859-1?Q?F2NqRf7joSmHkp49Nm7aQp1QWjDM/Rok3kOltcx7uGuaJWyiJuSPyIT/HJ?=
 =?iso-8859-1?Q?YWMZ+tJe4ikNMRiOV1jnftDilb4hwobpDqrGpqPQQw3xh48neh/G+sm7Z+?=
 =?iso-8859-1?Q?vJzgBJlM1UH6Vxr+Gd9pGbaHq/06Wt3C4XV7WLKqeJ7lUzNC9bUGufLtsC?=
 =?iso-8859-1?Q?eR5Wqw+ca9PVIsqhNgJvCqXJRHeWrb9525dDWW9P+r06moIjIY+pNILkM1?=
 =?iso-8859-1?Q?2XU4fnNyIQ+A7NVVyxBGIMadyJasaOslL0Pj1jR+VYfYPih58DH/FhhHcL?=
 =?iso-8859-1?Q?qSnxOm0X9GRChNsJ3v3t3vpyfVHASFWeCYB2wIa0zx14TskaVKRf9IfO5i?=
 =?iso-8859-1?Q?TIPgcYbUKn9tOXLQinw4hf5By1S6nriDaxqLnytc7MPOZAEEjyvCb0qaLa?=
 =?iso-8859-1?Q?Ca/SMVsVHElrEtuDBuJPCGN2xDXthmYEQFBBqgoaJuuXFAYZ08PZyPEsP9?=
 =?iso-8859-1?Q?XbDFK8mrYb4mmzcZBkwiVro5JRmaoOh0g9gAM1cE15WLED?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	3BfsnGC33Wql14JMEAlkavCEPylxFVS0e6AGo2OI08bpxRKuaV1qy6zRfOoxmgreg3sWA+fEeU82BjwRfEiaYjXX9eJYwdHufMiseHx8dnnHb98ieRmr4Io8WALwLO6+/Oe128/9xiedknfusLiQ30FD56B0waNd0+yK1aS/gtyBJMfjQNo94QvAGfsYunjJNVYRJ+1m3L38UqKNWv1/46Cj/aCycUDIqIljGIZUn4xuEEJ7zVZkSEcqwpX02pTVQmRKG/eYkrgF/035SFBQy5OytqHjFyP8Vr/cruz9bQMuVu6xajPxUYeqnDY7YWipC6pB8BOkMzUTBZFW/JyJCg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e523f121-84fc-43c2-9e8c-08df181c79f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:11:09.3605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efdo88qf9ZdKkT8tNPXDqz3QFNMXr80GpsspPKDe6vQmvPNNhTmM2O4v/YxH56hBoY8fS3xBEBxRNfiGcq45ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR20MB7783
X-MDID: 1790021473-ieXyMchydsJ3
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790021473;ieXyMchydsJ3;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Add vendor prefix for SiTime Corporation, manufacturer of=0A=
programmable clock generators and MEMS oscillators.=0A=
=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
Acked-by: Conor Dooley <conor.dooley@microchip.com>=0A=
---=0A=
=0A=
Notes:=0A=
    Changes in v10:=0A=
    No change since v9.=0A=
=0A=
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml=0A=
index ba2002969373..65da27d6e84d 100644=0A=
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
@@ -1563,6 +1563,8 @@ patternProperties:=0A=
     description: SiRF Technology, Inc.=0A=
   "^sis,.*":=0A=
     description: Silicon Integrated Systems Corp.=0A=
+  "^sitime,.*":=0A=
+    description: SiTime Corporation=0A=
   "^sitronix,.*":=0A=
     description: Sitronix Technology Corporation=0A=
   "^skov,.*":=0A=
-- =0A=
2.43.0=0A=
=0A=
