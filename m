Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA94A5EAF;
	Wed, 30 Sep 2026 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811442; cv=fail; b=aOjKDWx4ST5YRgvcGY3sqVC8QpxhZZ0mBERNTx0lDV+po5yGzLvvRk7+sddz/rpKnnIuRunaFJzL58YF9kEepyrpuLUHcW+FKvw1rX+zp9qOWW561akTN03iSuQDn8IoBakVmx7JI2/wbHaEvDuDzDtaerILNCELeAnpkAiDvtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811442; c=relaxed/simple;
	bh=QFt3K31SvMGZkxnWDftd/dr4sazZS7C/N9WT/yweot8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XOOMuFmtJel8XfaDFUaQrEaUpDnDmsYmT6VOlyvAMs7723u9INciMNLOQjENrOnDf9ePN883I8RVKIPZSXwnJYVIRns1xKpAZiillt7nNONpO4qw4/D8U+ku0puWChTJp1xCFLmflUV7gXX4qczLeKKY++Wy+Am8ODEFD6T+hZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=OmZW7zJL; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=AtcYknkg; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="OmZW7zJL";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="AtcYknkg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=GUMQxhpXW13mboPPWDvdQWiT0aoaZ4vpdNJdKgJ6Mg4=;
 b=OmZW7zJL4vbvSNqfNg6q+0Kz+Xw0JP2kzXiqHR1x388ZiXQClr+Y1bflJCAES80/BV7JSwpvx0DA43jsAvHckiGiL0j+xInt/0SnwcG1Ew1OlMb7UKRH6tsnppb3RDt15Y3j4kJobtIJzm3MJmrrNj5GDchASpLf4Q0pArGT503IuxEHgUa7yOXGKrAdCiDDUqpObFgDmMbafHUTvj3eX05YnZT7ga2QYH7twIrycKOlRGE6Vbq5zMX4W5b0y70jCKdRqYXjJ30PlBDmDTgE3OopaNBEDPmLtVoQ+qP9QvohWnhEUGCkn7B1DKV0sxv4uS1TyjYJQ0D3JzNgnyn5Tw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020134.outbound.protection.outlook.com [52.101.56.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id AF0A2100066;
	Wed, 30 Sep 2026 23:37:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LonEymIr5DD2To3RWK1Q5azr09U/9C2M9TZj7MzeKWbK0x9dugEXmFCKYIMGuRXxzr/hAmQoELNy3T+uqKvFuhGWHPlr/Xr24r+OJEEe06PzjIIzcE+sJ74i0seUAqp1uDsN0QKG4dkN4T7DxUtq/idfl9XSwqRUZ24Yd/YHDImUItKQWGbVknwzbxTJa8zFH/4ZpziQrb5mGSuT/krUQFggFR5O2XpaBQrcpiHIFuFgYZnyLN3MXEZBBlUCzPuCy/wdAb9oZN127QOkPC+4Ndfs8Qvc1us1fhRMVOP7ufcIQspWQfCGlLflNbsug/VUXB6reE256YmTaiFfSRitUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUMQxhpXW13mboPPWDvdQWiT0aoaZ4vpdNJdKgJ6Mg4=;
 b=mbtJNZSL8l01f1CX1957cJpL5kz/iCJvJUqwHlmPrhkFfSaZilHsHEWXDRSwcS9rmCscItm1EW6rG+91hCU8LgyrD8dsIHhrd3qacbgsHTwzMSK1qoxod9xYS4r45tBxDfAFRocHvI/ZvU58WTk68v7/6VOKg4Llq2n/dQZPOR1MqJhhRh0gYWjQLmW5dSWSfvDVzB8IAb9YlbqVKxoEU0HeGQ8WkxRmbb//lcoPNXFF9gz8Y6fHr0Gm7S/hbAu/wtEVb1EniEFlY61u7wEcQwl7T5WcLKUwqaUc6IlrUJ29L2gtO2lKfH4QE6ksZYV50/EPOpiBInW4MhJQ2uvKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUMQxhpXW13mboPPWDvdQWiT0aoaZ4vpdNJdKgJ6Mg4=;
 b=AtcYknkg4cWtyY2AfebOR9QkZLE/mWNvdt19Cj1vG0PeKY2FMPscFnIr3f/hPIpHb4AmwTCgC3w5LP1nvAoLlS1/JCjHyvyYTu9cvbFDFXJ7CDLU9V89B9rA7BCkzbQPvKfT5vAb/MMTlpUENvpQzVnv8JvoJ0QOPa29ZB4pQG9hOsiwQr1KKjgV3424YPXIMQFr08C6ij1EtV4gmHcvcBOMKGVbhJR4D9V3laMO8X2YdusoT86y7wBKkfAFPTsKkCusDFBq003zercv5wdLEd4A0szWyJGRUFIbtsMK6I921Ql9OS4zNc+dszcRR1WzDKUK1ymQhIVlIaaELKTfFw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by BL3PR20MB6748.namprd20.prod.outlook.com
 (2603:10b6:208:3bf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 23:37:17 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 23:37:17 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v11 02/13] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Topic: [PATCH net-next v11 02/13] dt-bindings: vendor-prefixes: add
 SiTime Corporation
Thread-Index: AQHdUTSgRdCr/uWwIkWnZ/LtRTnmtQ==
Date: Wed, 30 Sep 2026 23:37:17 +0000
Message-ID: <20260930233714.87679-3-arouhi@sitime.com>
References: <20260930233714.87679-1-arouhi@sitime.com>
In-Reply-To: <20260930233714.87679-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|BL3PR20MB6748:EE_
x-ms-office365-filtering-correlation-id: 37fb82c7-533c-49d5-03d1-08df1f4bc3a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|38070700021|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006;
x-microsoft-antispam-message-info:
 dQ64yuG/InWniu3lrkV1091+S7/Kvm4pVVAihqr9IeIjGfAltcr4i6szXaSk97lk8PirRDM1EcR9wkriYnSxm6qgIdm3JROyadvcNQDS2Fjit5ovXNSjNR+yG01nPYVr9pxMxmdWatMJRjMDYu4bciUNAwugsoXO68QU8m5o79+hdDx68Povi15J2YY/RH/KntKhLagWnbQtTl5riZThehon7KMkgE1n3D65vcppWgVQOQ+yrIkzdRYmDKLq/xRhQYEMFHPQhMvB+RnR10w7VEpWC5UxQfzicjGIDgBqZswh6YhM7jrcOukOCIXOY7/tPaO9Nodl3/9ZBlQD07eO6PuVwT62vjF6zOq2mqH8i/l/ssINudr0iBnqPptNFMkD21w5zZCV46jqO8zBJ3pI2wIprFLrJcM1rIXRYAAa1GBCKKOB/danw78pyA7TFfj30oC/OtoyQn6m0MVI9f5IkePXXULKsyaeTIGh1L6IQYtvNAS75QLmDlkfUH2HPGG2uRj5WDX1Y2Mt5qmMxBgzYwPZLjF+ZfbEgq3uxlsGzG9OMxNd7HqsWKywaWWMUgYf5LUSvvXvMg43R+hNJVhQTY4Od54N89Uw51M9G1LAv3Lvh9YLC8vHxtqHPiMT3PEylYaec5W7K9dQzEaBJG0TENoaDlR4ISPVRpyZRVgPPgvCTNdyzQRvoXEfgsvk4bv9MZZO0qzaul+himOjOeQ5v9pLWH1c2V9lgWInl0HswKc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3Bv+IUzg96m+xkGvHEk9oZ9VtvCG3nNObz6SO13hGzRFENWeBn6pofV9ku?=
 =?iso-8859-1?Q?FrmW3/i/68dpaW8nxn3R2t0sHQLnn64FzplbYMOYe2oIambq27JwqxqAZH?=
 =?iso-8859-1?Q?X6iBYgECxew1zQXWtgkBbrmR2DKQKKRraT8tscGl/FbYxfEZcFOiD2LSSf?=
 =?iso-8859-1?Q?eiZDA9M7q7E6zW7kMx4G8B00B9cT3DOD+/H/jo9Vmytft6lblhywG5BGeH?=
 =?iso-8859-1?Q?ltP95mOW7r2gUMYnG0JONAR59iVoHU+8vF1lkVofDhFtlFkwoEYskvvq96?=
 =?iso-8859-1?Q?kH7MobXZ2QAuE4B/3v/uwkZgyUt+RR5lqgY63YzurjDzhIIsoJ++yh7Nfs?=
 =?iso-8859-1?Q?SYYxaOO1k61bETquRkoGGy7xAg4xJmBWjxvzbYCzV++HdwDyWdDAhKTz8T?=
 =?iso-8859-1?Q?fmQv6AARW+oFJLYleh/k08oQ89tLmBQ6D87bEKiF958DFr2TjMi5Jc9nyv?=
 =?iso-8859-1?Q?O/cbi1L7zGxosj7rvxcImKD7UJI4k0VO3qiwNYsjV3kJ68AOQTZ7M4uURW?=
 =?iso-8859-1?Q?kUsbrVvV2wErxwnriPSh+XYH2S89hCxYqCK93zEQjyv4mxDCD+VlJ3vUkQ?=
 =?iso-8859-1?Q?tp7dw4RW+Dnhhkj9ocWd2TS9EFB7qyN33axzAXB5KZii/zg/vQ3A4AQtc5?=
 =?iso-8859-1?Q?7SvQNfXPcr85YlwhYWIu8yLHzQIZmbfctEW6ukO5ViKAMweiMGMbtdMnHz?=
 =?iso-8859-1?Q?TQ5QrFc1onlc2xkwExmRquWB4RZGoRHw+/MMpWp4W2VRUUX7C9KSkPfn6b?=
 =?iso-8859-1?Q?TFBvOS1My0FI77Lnk4HfhLmBZLpmeKor7fsiROC1fKEWpuGTRrNM0Cz592?=
 =?iso-8859-1?Q?YO4CDSt+48x/slCv98rb+BaNe1fTfb4ET2I2LvkM/jliJS12YLQ3KABDMs?=
 =?iso-8859-1?Q?j1xoCWMUDVsK5uBXgUmU9reYjRjqu/2ouxrUg+AXwOLk636eT+ZUh/Casm?=
 =?iso-8859-1?Q?z10Z1HrqqLWxvNvzSpUj/BcHYJikSeXsaz98Umu1q67t+g3iIwybU6qwv7?=
 =?iso-8859-1?Q?msDUKLV9+FDglsOOGhNl5io5iydYRcQFODgwUCaM9eiPd9z2JCvA1879ge?=
 =?iso-8859-1?Q?X0iZHPvqXfzoZszUuIdTPT/ecvLJ1Gud5GJe9r1tvIr3bLjMPxFaOW5jHW?=
 =?iso-8859-1?Q?RJIajNWBpL7BSrv9P1MUg7U7Etnr2d3tsv0SL2D60DehXWsimdUyNQZOQW?=
 =?iso-8859-1?Q?0cNz7sdSBzGXsfpmS7PM+yQDWr6o9SPIujoOmYED2Rvoj1yH42BaTNTP4i?=
 =?iso-8859-1?Q?CWJDPdH0I7wwXS1plczY/SSkj0or++5xrDx3QmqltIixCBC/+ISP8U/kfF?=
 =?iso-8859-1?Q?P/xUKVQqWqJPjzA9KYAqzXkW3kVgFW59vXZodRzEfvoap3CDetTlsKLzY8?=
 =?iso-8859-1?Q?O6biINROpjHpjrL89PBZhfn5BCdoNbB8iqZclPVSduaSYgO9e2jvWZ98kk?=
 =?iso-8859-1?Q?646mTsC/5DK0Uv1Zxwq/hd0ZTlTaVyoj2PG+0BUCNMBX27MEsRClsq8auD?=
 =?iso-8859-1?Q?Urv0A+T0KkFXhsNYlDAqe/3T9CecxdP7+b/8KI1tG6B2+o8TzVsJtucT06?=
 =?iso-8859-1?Q?UusNclLezGIGXAy8g+W1h5ilRnrbirrA/TtFMyat1Vx4IEQVqN0/9XCrnh?=
 =?iso-8859-1?Q?pQ0Qq2Eh8KAnmoIfmzxY0FlwuEUAGXO+rJ2/B5653MzKuUcbVt7y8Rmiri?=
 =?iso-8859-1?Q?t56jV8IC0iEHRkxGuS6TKhlyS5HLNcN//im5mpQ5EieOYkthSMQjWiN/EE?=
 =?iso-8859-1?Q?oo93Y5LzS1J36sNwRROWq7Uq7BqpkX1TQfmtQkfSqdV1YV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ObH9dltuF35I+D5oNKgR4Xj1LvvKzR9DXE2ObQBGV+AU+isGnjjWNkmBMXF3Ru3OZl91KBk4+AIfee2RiJYC4C0kyF6iK//uQcZZsb0VZyhfMbQZjMZHOnuIvwthIQ/R98hjTfY0gFjCEoGWAOA6MweKGHHihm6Y3jCfqgFuFvjQN6InZoGOnevJYGA4gAVXmEw31x8TIaB5ARFM07zGtL4Ssmn3Ylw2yRRHPg8g4jbx6C+hK0sOarEeSRAB7dDvZpndBh+P5C18ANKYpB6rHvtrdQoYzJVptPkI8oey7RK6Uzq7XbiU+H9wr+/410vdZrZ4Uk5aP2gadrl60rDmqg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fb82c7-533c-49d5-03d1-08df1f4bc3a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:37:17.0447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUqZ36HMuRJz3lH4khIBIl0/TYeY0lToE6nWKJbTZgU1y36w543j7+P2ZUgv07IdnlKMm/QmBdvOG27R8H2Baw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR20MB6748
X-MDID: 1790811440-68hucTUxilmr
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790811440;68hucTUxilmr;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

Add vendor prefix for SiTime Corporation, manufacturer of=0A=
programmable clock generators and MEMS oscillators.=0A=
=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
Acked-by: Conor Dooley <conor.dooley@microchip.com>=0A=
---=0A=
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
