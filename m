Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860A5616B6;
	Tue, 13 Oct 2026 22:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931303; cv=fail; b=jWad0tD07d1QkllnJKKWJEjS6CKn9QNLMeCzdUW0ANH8F9D7LPY0JSiaE0/WMLFOE/xZNYmQoEDQnqkKz9hjMoiKLW15NS9Jm9TrXz7u72gKl6lBIfaP838xY3uCc7cIT6QSm6BticCzeYKvTCbYJ33YjusWsTdQBcn2wls3mP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931303; c=relaxed/simple;
	bh=ljdQIvsFUi48y5kzHWAmxyaOfnDhIUUR3jziVhcx3oE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CcCsS5B4u5pZVEh5HPE5OPxh+TWbpG/lU/SwdtEOPqrntEZaUlutxU8m8XrLN2+Sk7AohFHZ7FkII58n6O8MqBXXF6kKYPvOOiZlTZtMswZ727oVHv/jEuheQWDYATSSQeGBZnn5eKvcXVDc53FuzGmKP/GdMDNj0mWehBeqVSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=G6CEkv9A; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=NTz6Nj4e; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="G6CEkv9A";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="NTz6Nj4e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=XgXZcYJsS8Qkdd8ARzjcVLbg8ZVpovsABxQ2FVoNhxw=;
 b=G6CEkv9A5jd+wb78Ts00Ck9XenbslpyGaQCYN7925Eit1XEMNEWV3PqnCxcEGwkkzBLCXq1gwaAYzc8L7U0mE8k79o7QyJ7yTuOeCqtVX7OlVpjEwOF0ePxt5lahgL1hNQhRctyWq7exkv2R/MaXwoIMmqMSLOjc5Vout+zBqmPdDkmFSGvDRNzS1uH55vhRYOftRvpJi/16+1r/ceP+FMhUyBBwyp41ZiWc1XJzcE4znIjWMv4JrGiqzg2DYGvmmbifpayimV/739k4kW9GYwGU0zjol+RmV/oA5ietgR7pYudTfQ42hmildtl2FLCWnGzEqXg+qKvdvpPuQDdwWA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021141.outbound.protection.outlook.com [52.101.52.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 5DFB78000AA;
	Tue, 13 Oct 2026 22:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umncHNBoJclvefMqv2/BTZr8nMVC2JXhz9wZlmPKWOuvNvUyvkG1PwWCIf/pRriVkXJu5mojpSyqPqVRvGxr1d3XdJLecZx/t5p2FBWt9L773Dlt8M85AoZ2ZJMLq3LXTc+t9dBK3y5lXrscgvGnh40WIrsyZVVeOl+DtaVNBaQkL/wRfOKFfYPRIp2pTyQ7LmIAigvvOBfwvVRYmU/Kd1Q0WEHt1ZC4/UvuXWZP/rWJlYFULJN9BaUH3+WyzpWZQFaSHFhJtEpdwJ0hMms2VLqrvzAMXds4RVSeKHR0PqD/e0gYIXTJEoFJzGwlLqKHSKCQbs1Mk/Gc1jsuRn04bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgXZcYJsS8Qkdd8ARzjcVLbg8ZVpovsABxQ2FVoNhxw=;
 b=SnQFnpzMnnXVaFv6WZgLgIC4V8tsyZhsvLN6wNn4cOaPGiKUZYybJht4l2g141wkxEbUBJXQrthnJkX80m9JbMUNcFGv0rAGgKUUOLnIuJwhgrM7zqKxOqa78ChrtTQspvEcgFw8qScZ6x7eRF28zofo8DG5Nbwz1F8YRpi9RpTQDWrwAxf1OCE8QoNOHdfe0n4NSOeqpnHtpQg0lLLp0b9D/oipI3W7ze39bkjVyBSL6+7C9lL4m/GcEtJta+IKP5vI04Rylb8UhssHs3yd8kN1fvxj26HmAdp194oaJDKykkO31VeeSoegvIVFphGjD1i/MckakUUHTtBT20khcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgXZcYJsS8Qkdd8ARzjcVLbg8ZVpovsABxQ2FVoNhxw=;
 b=NTz6Nj4e80SIOaI4z6Umr+5yYn6j/hUWOnaGbDQohDPQSsdWIoDeEZ0TRGpBd5OHc/OGXa5jxm2SJuJMkJfG5U9Vx5OkJ4G8O7/aDnocc7FYTUZkuyUXFUHs13Z6hvFAfC0kFlqqcjj/VFL+fSjSlQWYYYg5dJFPw7kYFhcszA6FP+j4zE5OseWWpjw9rZRF7PnOuzDBCB3axXXE9V2CiJQ4dtjOZaeYuhoczmlT+0agkPjB5EkL7gLgucBVgYKBUEG6JhyvcKVuTflgdNAbgCmGNqQfrnShenFf49lMT3UUZZGtJfpk9MutX6oDqXannvaEVmLhcuiTdfeaPXLwpA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by LV2PR20MB995388.namprd20.prod.outlook.com
 (2603:10b6:408:36d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:41:32 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 22:41:32 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v13 01/12] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Topic: [PATCH net-next v13 01/12] dt-bindings: vendor-prefixes: add
 SiTime Corporation
Thread-Index: AQHdW2P+dqUoIq0Wi0iUoMOjIAP4rA==
Date: Tue, 13 Oct 2026 22:41:32 +0000
Message-ID: <20261013224131.27149-2-arouhi@sitime.com>
References: <20261013224131.27149-1-arouhi@sitime.com>
In-Reply-To: <20261013224131.27149-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|LV2PR20MB995388:EE_
x-ms-office365-filtering-correlation-id: f53b514d-4494-4a05-c117-08df297b2178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|56012099006|261009223027099003|10067099003|260925021911599003|260925021311599003|260925022911599003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 IEUpBL++fDPWHUgFRnQwN01AzTJMZom2E7Qcp6Mjg4cgg6UQ0O4vtZ7CZtX4lijEp+PVHkO37frpKw9Du7B5o0q1ax87rVbG5dyiIfN6mL5M4nIvblvG54NkFQEu+ldRBDmjf9RM8kK8JE5LqY2RYB0Yn09KFTHHwewtJL2Ma/T2wsgrBJX/feIb8uHZWROySoSGpknpvQTHf8wJ+jxYMRr9wX2dLhU/LlXIEGSXs08asN4vyYLJVim0vKytRvdTfiTMC8mqqRyFDgEkcX726grRbSmV7CH18eDLuwTRP0w3KRlxY0DtcMpvHq4Ez14/DZzb36u8Blh+Sztkrbj1g5E4FW4KZT72miD1djWQixxVKYKFs+4/rPbmq7zEnfcTQVXG6AeydvyCFezEt0897SVMrsvjE5jNzkRJBh48AptEvri8C/C8Ti/mZ9Cljhx6u4J7LQddPyF0xdlK10/RCARSynJNtKhyhs6oDyutuPWQVQ3VBvGFhhcOwNn106Vt9r5iIrFhs2UWDptsUASH6zBL/bYvLVNGE6Z6zsTstTMI4c8q2b4kN2JcQmuSqDXDJ9HSKuH5MFqa5zVj6lJvM06aZvw2S6czJth861z4q1erZWG+9zmIpjdSPwa7VV4tk5ET9flcyxj0C6ja9L+QuwgnuTWQaf8wPxtsNWWUE14SQlE5nidW3utWCMUbnscDJ1aTI3hzJ0HqUH/ZaowF6UK0taZzKlyPfyw6cWgxQlg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(56012099006)(261009223027099003)(10067099003)(260925021911599003)(260925021311599003)(260925022911599003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?p9WUImuNGy3cCd+VkrFxTahcgGMovc/fZEFTKqM1o5Renoc3dV8hL1gMkJ?=
 =?iso-8859-1?Q?eSO+EP538rk46jIE6VdgYcPFKRaNkOXVEhpgznX8UvvfZrmsHHZQnyUfzc?=
 =?iso-8859-1?Q?phwRjfxcKugIfO2416Qe5tRTfgmFt8ycNMcTZN83U/LnCD/L89+N3DpMr5?=
 =?iso-8859-1?Q?YYhV1yoA5/ti1rB7LarEwXUhwy7SsZC3lHEz30d9L+WZuCbJVYnTC04J52?=
 =?iso-8859-1?Q?+2VlOSXeZBbKLJSOOsCwRX+fxErxKdINqL4cAOjjnnE7bAkr/Nzh+4cLqw?=
 =?iso-8859-1?Q?12fRWIk4Ou1YY2RpEFri8AeZICy915LbWyY2aTkD60qqN4YA70J7we9dsQ?=
 =?iso-8859-1?Q?lM1PdYObOihkoTHYTw+n5z0YnBpMtg8WEtPeIm4xAkAftZFOJUJPOXCJbH?=
 =?iso-8859-1?Q?Eb9h3eG72Q+rqzjI1XmscawDbnaDWkdmOngzE7HkZ4DODIfB0cBZW1GWb6?=
 =?iso-8859-1?Q?HE4xxExhtHEYXoKsD2H/wBoFscSynFiN9hZACDCiBraYTkwccab6pmK57c?=
 =?iso-8859-1?Q?yI3kThY6ST/1HpGb7gwHb2m132ZXQ4nNkNtHXq/OkTTGcPTHxtSNdEtPXT?=
 =?iso-8859-1?Q?ytU23Y/IRFwpORelwIauhFngtUKdRrEhgWJ6R/E8mNUivWca5ccGw7fv7b?=
 =?iso-8859-1?Q?pXVKjwDtwsN1ZPGRXxi0MNNPYVwmb8A3BdsMcRPR+rzhYgYySukSESydY/?=
 =?iso-8859-1?Q?88S03ZgmL7GKxnZv94rxuyIPxsnLQet5Q3hYrfq0gO48xDm3s307zu0B6b?=
 =?iso-8859-1?Q?ZXr1qPsr0Trn1ICI339HDA8/e/x5rUUptQjHIMeZR1iTcOcioqJQHuJXoy?=
 =?iso-8859-1?Q?+ufw9S5KYpFAPMbOx+xgqtAZmtQueNmcIVWjpaj99rdq6J8WMOA83eFmqR?=
 =?iso-8859-1?Q?kS9skeUBV3KvANOK9zmDLAKQk/+Bixr51uonWQM3Tvsh3CWIKY+pwlo5Tb?=
 =?iso-8859-1?Q?aqjDJPogw72I2GbcPM5HTvcRC/vtZSY/0ewY6yHGZFFj14r4qe95cYbF9a?=
 =?iso-8859-1?Q?bVlp2tDZ1K7Qm30pJvc1w+iIxS6EadvYrjDSBp3Fpv6W2SgZRrf5jipKOZ?=
 =?iso-8859-1?Q?/PZ1mgD98gtNyArCgdj4AYGBwtllz07YVLqF3dv6EeY3eJsXtpnB+mWErd?=
 =?iso-8859-1?Q?hOdU3XhNJknTiTfaMOmdF6nC2WSAvvFqe+ZelGtwneAtzbmvfGU8LRlWGc?=
 =?iso-8859-1?Q?R9LjJYgNHTnI873JLhjFN9cTkvVP0hRYgC1VW78XEGZrxi6drv6jUlSyBz?=
 =?iso-8859-1?Q?GCs0FuCAiNvcHnKxioDOwtb9Lfdi+TC03vHE+TnP7hITFrkvRYx59dN/iK?=
 =?iso-8859-1?Q?wBqe0VAtPn0nPWfr2VunyWrPqHaKOqBXoqhe8iGkXKjlh5pvJN7MXhEXwY?=
 =?iso-8859-1?Q?OdvRIABx6ZYC2d52fJT3eyMg/VZRlIRilpNKgKE6d5NVLL5ui0Jk1zN0Wz?=
 =?iso-8859-1?Q?UOJ35enrfB70+fo3FTExxNkmM4lQi/DdJ1L8y7es7dBdK/y/9MSGfR1Adi?=
 =?iso-8859-1?Q?B9T+wD+d5VvKvAHrgG+JLJxjCcrEJKYRDGaDvxHdfpOyYBse8Tzq+zWRna?=
 =?iso-8859-1?Q?2Ib8LrFSO1gy9ySo5Eh8OakOV3BN1+iooizNKErzKvxG3cym6XAHsLAn6l?=
 =?iso-8859-1?Q?GE127ArQQXYicd3JtKPr975QnYOeXwfzY7x8QvcYXoO1Ljmal0YoK/IAAu?=
 =?iso-8859-1?Q?9Gkd2YrNTSVDK8kuk/+UzecibcbApA3P66/wMbPcDzS4B7Wa/APYFahLzd?=
 =?iso-8859-1?Q?puqJ+CuFeKAdzVl94QBjrJ84duyijNlh4uBf/Lr0z8b3gp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	FNomMmvBBF2oviL3uVmYWEVIY4KJur8WCmU1lPJ3f5DQfXKuWqzVnTYF+NQeu7KhD0iYCtjGUDOyWyrzmd3upML3k5NSf0qyVwPkA6YNN0DfABVc1AQ19Kiog9Bvel7L2yjUSB4hcSI1OVIUroFwDmR8HmpHoITE7GGCtVE5MevkA+2JMC1NFFPt+6bNsP/7R1TTXTQIUhnv8dKIep5DAk+JV8W3MZmNGApxuwI4AYqpv4MB5rzOHoPlAl59dK7idAE4kXcWOiQ2xqNRFdcNqkNdHR8y9R47Wk2FmucIW0nx3uy+X8C26TC8kgo2ojCx9c2YC+EqcjMPmJx5tYKqCA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53b514d-4494-4a05-c117-08df297b2178
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 22:41:32.8784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jx0ec+udHljkpjrJDM4OibyQRMW2dP7saUcJ8kDjLDQHSzez4droGUtfoXrpjuAnHXh8Af0KofJh12G3syDg1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR20MB995388
X-MDID: 1791931295-w4CTubZB7tG0
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791931295;w4CTubZB7tG0;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
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
2.39.2 (Apple Git-143)=0A=
=0A=
