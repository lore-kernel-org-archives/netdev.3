Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0773B47F9;
	Mon, 10 Aug 2026 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786403444; cv=fail; b=BcDf4W76a8NS2w59Tur2yqLcw4dl2T+Zvpl1AqTVcKe0R4JjXZwL2lcf8sN/trAN759JWm7fgRDqef0usICTOTGJ9wVQBfutfr+gJ7l0GUJ6CsS2Emp78MsNMxZ0ttJ941cwYB0lzt/eb39vBKw+HJfy5LQ8sAv+46nnXJMKMF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786403444; c=relaxed/simple;
	bh=qZnh8/mgSxsGTPptFu1zhLuga8m/x0xHM/AtsW3svUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=odlBCHzsKhkbbE9Yuce+So4xmro4l0WvvSB8klEo2zohUdJn7fzfgjaRLVIKWi4rMvRwvjnij8pWGEtUxwwCD6Mfjje4FB2jTif8XWFTvkt+lKheG4khI8lVZNIWKvwE8cgfKg8KJ13aDD6S8MxfwnWcdmASrjvuZ6Et6Ex2N94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=hjYxTvb8; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=mbpWEcEy; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="hjYxTvb8";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="mbpWEcEy"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8D1B7445561;
	Mon, 10 Aug 2026 23:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=WxzMc74uWslN84CuOVuPtRSEsTz8DY+7FfJRFBQZ4J8=;
 b=hjYxTvb8A1l034tP2whH6aGkE2AENLR+/0jqHNod4u4ZbT/gGgtcIazHuUYjdopKMtQiyPRswRQ56YPbO6njOWL+jPIgdbWVa4r+299dH/xjywpf/rYLr6MC9bX8CkTxiNfBo09K0ZwTFlDwF/MWuvXl/mcC/gx2PIHHjLYYMI1YkrTpxC2U+KNqMAQCEdY9zR6Hmpe33UGh8Ll1k7TkODZfs1NdQmpghchJnaykXzmhpU3Rzl0W9gGVuTEOXnVYLWiuJ3lDjSNzZTgMplBdYCm7+z0aIQYk2NhOvnomKOXHTv63dYlGS/nto8qaXTxtoyrwWwbD/UC4Kd4SVJ0w0g==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022098.outbound.protection.outlook.com [40.107.209.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 184E4AC006E;
	Mon, 10 Aug 2026 23:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMyF0ZebMWYsg5oU0ko2CSiU7AvSjrdJIOdfmyarbdNBfRrrflrVXG10iMzrituPfOi7ZMfL2QoF1khBkMX3FFMtuWFZa2JmGvJ/jf5FkBw1uV296cLuKaavhq1sOQYfcvuNk/vmOspp3VYg9CVbcuCMMAz3ZopvnvAvq4vwKaLNkNJjaQTbATOsOD7bxlCGs0JniCIPgkySlKxb6MD7VS4b7JBwO11IMD3Y59hGRJASZmjygv5Fkzyqv8GGW/oN2h5keoZQqkHDbUibNRWZnzU+jKd43lNvxoExl/Sb2NIMqxTt7gYniltAwGfP+0lsfjScML8Rofw41TWauwcClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxzMc74uWslN84CuOVuPtRSEsTz8DY+7FfJRFBQZ4J8=;
 b=qmdxtAAx+92vFdZut+KARxl+nz9DhnYOyVVQusUTKLKlTD8wkzUWSxKoWkYZmL17minysx4BkEGo88y5AUxqpHjNbhC3Pqa+rUwe8LeXdA+5odXbKc0bgwzfFrxg1f+qO4H5fDpnIOZdm974ZJIl99WK54g4SCvpDk/0+X4xWTgRV0q+UtJagcQapnIzh1gW+L8FWjDyplcu+NipsXExUYO1iYDHdQnyp0YbYO6J5uphxZsmZmNNiERbE81WQdzO+uUkUP/ZRjhQR5ONfHzEk+uYbdkULFNMWjHqKKoKoMpUXzQDudr8lV0cTN8BfXfEhK5ipPRCX/W+sFkDuLGz0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxzMc74uWslN84CuOVuPtRSEsTz8DY+7FfJRFBQZ4J8=;
 b=mbpWEcEyO1pdRpsZ4kYD0gD7r5f1aMowJLz4oW3/qEknF6Y7QqFpfvN7Vx+uhDjrKcL8OzfQn3XpEYTY+1yLrxJmw+OzJGKaSCeZ4NHqWxntYiQ0kYDWZu563stTpaym7YXZtBjULFMKnA8lpefZnrTacHvWXmXeJfWmI9TFEM7sUn3ZN1STMa+JzMg3ebAyLe2krAR/+zY1jFqXy8PBg9bYXgueqqh3AK3xlU7XenW1PmR9bmwL0Ij16eDI7ejpbsfwln5PbrIfneveQFhxQPz7LNstQVbFyTAx2tqdUF4aBkaNqPSR7Uq3qNzqd4ntdd1gNICrDbtiQ/37v8BrlQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB4516.namprd20.prod.outlook.com
 (2603:10b6:806:23d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 23:04:41 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 23:04:41 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cjubran@nvidia.com" <cjubran@nvidia.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v5 1/3] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Topic: [PATCH net-next v5 1/3] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Index: AQHdKRyghlXcA+JanE+MG/8CmmRLag==
Date: Mon, 10 Aug 2026 23:04:41 +0000
Message-ID: <20260810230439.22866-2-arouhi@sitime.com>
References: <20260810230439.22866-1-arouhi@sitime.com>
In-Reply-To: <20260810230439.22866-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB4516:EE_
x-ms-office365-filtering-correlation-id: 99afff8b-cada-483e-aef8-08def733c299
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|56012099006|10067099003|38070700021;
x-microsoft-antispam-message-info:
 LkeU/eg2LRFT/1SA+HX8S2P0zDn/BX39fhyXTWwQDXNg9tQdp1MKMsJp2PL5T847qxuflqAuceFki7yEBRUfItD5C0wIiAEm1frjI0GeM5wsPB4txg3a6LzNHm7/AE3dD2QJ8JAWV69UoRWnRSLXHrgSmHNrn2EAjtxkn4DnJxj5c6tTCgC7lUECJVwSCDd6hKh7enDynrenOLiix+nBoXB4LS+Jo1aQY4Bed+VeOOhRHH3/xemkIhdKi3VIk24SE4RK9MQFlo9OpEfK9IasD8l7aOJ2HwIQjxj85mrh8c23qT2UAGA+8owO3OR/0d1SgmmnV4t/Fdxjdktro9ckak44SdcK0UjJSaXLSCHFC/5lb3SH+PJdQGYAsO11rKJKNMECXNtn5s51re3w6KuDA+J15Ba1HGBrVvpJQuZf/z6b8fpr9V5weBNLDPhi43uvqBw1puEXaMHytFcKqAG2tfaSa/ed9v/5gs0rlhjfMsZm/lHbJFz45ANK2MfJaW6yeUhj0iK2FtUTnHmd0vhgb94cRc7wXmrfjvpgeuate77JatNe8HEN43mrmGOI8ti1IJ2hMRpuOrk6hnNnyYeG1K9nPw9Og+VI6FsUZPD/pCGXCO4o0fS18Q5fHendQ6eY3Wkg8pW7LYguowcdXJNzh9rYYX9PW1MAIOGWDDtwCWaJjFyJdMBQ22QIEiDuRjJInwMCzsgwmouY8kdEEz9ofGMQgkkvyzdaqR52lrEWn0A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(10067099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ZAKnVW2adenRs+PAXlJTdGZ4gIQrPKc4VOZDs+7I9G0qrlv7rHbzzDwV+P?=
 =?iso-8859-1?Q?9FxY4NkPZVu9qd2Opc3Q+W/c12lLFAtRA2eMlpv9e5ZMf6TODge79IRsy2?=
 =?iso-8859-1?Q?Oo/16HsQVj12hwZG4gg+2BEhyC9WkNKqX/T1xyvzM11xPwquJ2vdC6raSU?=
 =?iso-8859-1?Q?LxJJevctpa0gs8PKNcahQjLmWfZ3JkMLI+xdeQCzB5Xp66l2vx19Maxkl7?=
 =?iso-8859-1?Q?5PdPUSm9zLgsBXCWRWFfhwooeY4yV5zzwe45HD16K5ooGeclsltjAIvSuo?=
 =?iso-8859-1?Q?2Ylp4ZyZLIDVbmregqxuyBOT0wlDCMwSwps3fK3gkGVhWFgkwvmt3k5tQX?=
 =?iso-8859-1?Q?iwJaLatPV7OfDBzwrvLUVVxxz+C7VjoDFgJ136HQG7waLTLcQgcF2IPH5U?=
 =?iso-8859-1?Q?wErz+jE8EMbmllRtGcMi7OJIiPUuG4UNRgH62UHat+cqNg7Iz8ou4Wdjg3?=
 =?iso-8859-1?Q?uWz8nCK1NT/1NMpiu5PZDeQXW+yhx5UfNuOUPkvE/ti8WwJR0ADAG+VkiN?=
 =?iso-8859-1?Q?P/Lf1pmUMcZxvQS4EBpeq3xSfZoZ4KMtf1XZw+dckhbqngOsdH1xUcCgVV?=
 =?iso-8859-1?Q?kIIkBUo/Ez+snzETtWp8xOLlNYhTX+TzsH6txtiZ8Q33GrV5tWRYljzv9+?=
 =?iso-8859-1?Q?6OUAFcMqLS/GDbsDNVur6Do2m87Tir7Z1DPxey07tTt8CCB6r6ehUVU7Tx?=
 =?iso-8859-1?Q?yJlHp8eb2TtFKaBT12YbjSDbVLk3yR29WNX7EWz9G1veTNVjD9L/T6SP4q?=
 =?iso-8859-1?Q?YFgx0RBFA/D4V0g/f/9UIBiNIWZh2K3U56NyEJvvTvpTiL7rqjoipPHeth?=
 =?iso-8859-1?Q?5vHKdtMskYccwCxJ3HS3Mpx3aGLMBXmJQtaFdtmeWrzJbO+jwIBAfzdAh9?=
 =?iso-8859-1?Q?1zbl0toLCbmK/XppVHz7mUPzbFbDhu2znhJxtqkno5X+iMZVjKnFl5KVQ4?=
 =?iso-8859-1?Q?PeLL9oTqO1B8KI/aXFSGpB6YWTRVQaLAvXBhWvbNb47HNr0l80hn1AsXxg?=
 =?iso-8859-1?Q?5oL65il37jCIeI6RlS+nkRlArehZNz9kJE17VyquYA9PCwhDiElFqp5UjO?=
 =?iso-8859-1?Q?FrMEI4NovsegykCwLLmf8DDxcNHlnvGJcok98j8H70S194+PFQ4ez+qezx?=
 =?iso-8859-1?Q?nyeAWCfHoJIz3/6DwdqpGuroie9KS3dFet779UhhNuG7gDkgy25kHobZic?=
 =?iso-8859-1?Q?qEtTysNN5LemktvdXQEKC4Jhe1c0SCdkHqmX+hai9bTU6TZDWp6MWkDTQ1?=
 =?iso-8859-1?Q?jbQT7AQ3nrKGOaUIEPCValbSwCV6g4TIQNMqotehR1+ayYo893vUdaojwk?=
 =?iso-8859-1?Q?JdQCL4oG7oG3+NmszWxZCDPc3CPd2gIfb+SHHgEDzuQNVSQcLagoaLP9Oc?=
 =?iso-8859-1?Q?cy4olr+Eab488dnDyscSLiYApNizBEAGdaiXgZ0fxh4FJL8e4VGdQBkIf2?=
 =?iso-8859-1?Q?rHV4mYyy2TcEI1Aoa/CmgYiYNA1irdqurG3YE9kFWg5DHgPn2t5A/iD4sR?=
 =?iso-8859-1?Q?hMVc4ugqOq3sK/n0A4gGTXRdCpGUEglnOWmuHU14vM9F9l370X9Vthp0UA?=
 =?iso-8859-1?Q?7rRBYoKfenNbP/NI/oJ1Kn6NInmd/9SFzRxiYyjq68HIlWB1D2Tw8mfa+s?=
 =?iso-8859-1?Q?M/ICzhLSkAeuKHr/Mz8ica+2Y9N5OdLoTV5UPoblK7KNAgjqh+F8uRzzxk?=
 =?iso-8859-1?Q?a9OWMWM6JNjQdh6ZTllQIwfzG7aa3LY9M0Pu+dYhtmMV3TrAjHXmBj+UH/?=
 =?iso-8859-1?Q?8jGRH8QK9ZYGHT/m7lsKJIqnV1lb6ZWAzi9O2Lzzs6dHSH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	MeGRR9z51b+ZhJemdy/D+Zij8XBfCYJPRK7s8PiEYJgWxBCzSbQBnTU8pSHPHKCmcSkBxrYUp/AlxNahYhO0c+Lo607VHnwCxvQTjgzExsbqqAyiVU4ctz9m6LgL0gl7Mk0RWDX9L/u2Mhx5xlUgEh/kQm5kyEHBVEFQwyz1cvtUpVp/f3z4EsjIbdZFxQRyrVciBJoKdYtF+rkX2aUL/3gwSUkceWR7DN5zgkV5U0zlsHlgZePbw4DuHb9/iF+F6yRdEedXT7Hi4Cj4GGvygQvEVE+hduVeCfD7BvfEHqk9wav7TNRSnzDpSxXBgHc/hmJNi6zSEpjHjfqSCcyW3g==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99afff8b-cada-483e-aef8-08def733c299
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 23:04:41.1702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HnDHB8FDlN1tkIEeKc6LgHfFPYF1NNaoTtgkBE201dSPbBkkzXcZLYWxH/obO9XAz6r7GETSisn1SH4v3K8EQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4516
X-MDID: 1786403092-VVrZEZNL3pCR
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1786403092;VVrZEZNL3pCR;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
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
index 396044f368e7..1921718a5f82 100644=0A=
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
@@ -1535,6 +1535,8 @@ patternProperties:=0A=
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
