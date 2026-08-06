Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9FC34D93B;
	Thu,  6 Aug 2026 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786058694; cv=fail; b=e1OKSSYvhxIROjxJwhAk/UpHExQ5TPXSUGRFLkufipxdlncUm9nAHg0qOVZ0rZULAX8GPVORcwYBP9UDUjgq60UwLLNLjJMlN4u9FBDwMs+s2CfYIfaJ2fSvrBfG3CTle+s0PnmJT/ABNRL8VtzxsrVx4uTFHQ91Og3W3rxICBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786058694; c=relaxed/simple;
	bh=qZnh8/mgSxsGTPptFu1zhLuga8m/x0xHM/AtsW3svUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DMyuq8swXtOlyw9Oy0nvLmOC5IsyRO/paaah4FgjpP3KNijYawd2NFGJ2+mTTtEo+oA4h3a2dNeQFeld021s4eeE843IRuYy9bzqxXkh9uPeegdi1GO910B8g9A5Esfgwukj3TZv0ZB6mY41IM59b+p86V/EGhqmL6k43aN0mME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=VeohlsAq; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=nzDB2MzD; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="VeohlsAq";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="nzDB2MzD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=WxzMc74uWslN84CuOVuPtRSEsTz8DY+7FfJRFBQZ4J8=;
 b=VeohlsAq+H4FVcWhPk3xujr0/6wbFtwMKKgJ5xce1/X7p30BCHRThgxtr8wyGEKu+RSVDVzg+SGx/b/Zeqt3t5wuH4HZymKBpniDw1d0hW2zGCQtU2fJApEs5SyhXY/hrik5mlnVB1/eDJBGx9NU88uPRXmTL5uYqaI8bFRSx90TPcpdJ7Ff5lLpraXmYyLFb8+Es0vQger6Yq+EHPrcqoIc2THZ1TS/dvcReYfNOKHlyPG4aF+kGFmoQdXZOFOJ2QWiEvwDMrWH2z27CjcCEWfKDIZyHZNkiEDmORU4iv+rv+k6xVZW0vqlR28GZJix8FTwmfKKUM3mQ1UJGiTDRA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022118.outbound.protection.outlook.com [52.101.48.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1FA4D80067;
	Thu,  6 Aug 2026 23:24:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuIx2Y1XhrIBLaCzOBpPUcUbnUR7j1ygWXRlk7wYWd8btvmX8o1fwz4E6F2g8uIweLQVK1Z5dkbKX73U8hend7ljhINjYrBXJrtGVNRbYLB/Hc1ZbudhH0mh/zIRKEf2hWAqAJtfepwI0Dmnu1EQzGb8O933KM5aZTEQ120No7E0W+P5mu8SP0msEs4ctMj2n3WHsIFmOZ2Aexmpa3GPGKQO3npbGAj/uBI9uSg5DCCPvzPwJyFg4APB9I/RF/m9N2DtbmEZXDIS8fq99aU+HIifnsfYm666dwbitS2J7MN0XLpKrwxGa69sUjpxPzoHYD8aM7n7oOXwbRJStwHd5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxzMc74uWslN84CuOVuPtRSEsTz8DY+7FfJRFBQZ4J8=;
 b=pv/xESDmj6gdmMUcb+GA33F44Y98JzB11/6ko6c4doi3oR3BUCZfCp18DpHTAmDQNPfpKfbP9RzGVq+0xi6U4eWaz7yVlEICmNgfOfZ8Qt8dBz2OZEk5da3FW3EVPu9q6Qqzk705WKnLZR5MVuiUJoHtcgjqPDSJEuEsBUJLuW68TqYjYPdg7xIFcTznsOeULO2PzOeDEXnQR11yODHss44GSEXTUyTBzeP+6u3IWEh7Uo2Uf5CtnKVh1HI+r3mZI87eOMO0rjMZaEzbHQiZx/hI1eCwBzskyo74hOKtxT50UXf1T97wofp4lt9tbSk193NxRs9HV/ns3VWmvsBiFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxzMc74uWslN84CuOVuPtRSEsTz8DY+7FfJRFBQZ4J8=;
 b=nzDB2MzDGci8D+ogG/TrODkFRNEEy8FuWD9kVyvToQIsFbC7Yj+LsCsGIJoS4s3+s5qE4ianzKftqCZbdls26nP0YgnxWRmWfqVgxWXZ9LloVTdDl8wxaPzO6Zw93RqtckqWddrCdFECyKt+kzrgvVuKm8wYIC/VRfjIydA6YYVoRTJ8JMLag3vyET/DH50VhjJhkeduztfvbk/CWUIYWANyG+6RZh4r69czsGR5iQ02BqcESwezl3VGeKn+SH1uPqIfDnet1/c9kONvO4okdvr5mhUUNt9NdAkAFFBCzgApwtfCdRa1j/We2cBO4cUCx0sexvOy8pESRTGFwCfnuA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CY5PR20MB5045.namprd20.prod.outlook.com
 (2603:10b6:930:33::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:24:42 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0292.015; Thu, 6 Aug 2026
 23:24:42 +0000
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
Subject: [PATCH net-next v4 1/3] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Topic: [PATCH net-next v4 1/3] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Index: AQHdJfrCRopWWcTawk6ATxcLVIGTGA==
Date: Thu, 6 Aug 2026 23:24:41 +0000
Message-ID: <20260806232439.27551-2-arouhi@sitime.com>
References: <20260806232439.27551-1-arouhi@sitime.com>
In-Reply-To: <20260806232439.27551-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CY5PR20MB5045:EE_
x-ms-office365-filtering-correlation-id: 20fe6478-fea5-4ab4-e97c-08def411e491
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|10067099003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 Zipx4fQa50/5XSwPmMd9Ytz3DLD5EKiMPNLVW8mQ/qLST5UqLEoIOiv6af0QEvsGC80i+uJ95Godrc3KWlg7JnnaWa3KKKV3QP0sTwz4C83z1qXiU/J54N4wd5W3QQUuriL1GC5MkzSpGSTkBtuDIVIIZoNCXXCK1aYkeAO4kDM1t8nOOrgZsAOCOd5YjiXO3UG4oOEnvEt0hraMv+XCYI4nRDhnzeWIdsjMjPFoFSCdq4jkYnzfZNKnZQJQZ6uoitsDfO6m7iYpYOPoU8oQG7zbm5sa3vrOg4vEP/gf5KC/haw0sMeZTJH/LnawZEIoQqUj2tORCN453GSi6cC74YXktVhnkQzJgfQAYcLQPRtfSg4jxbee5Tf3NmM0UQHkhQeBjnlxyJO7/g8kZjMgXnjbBYCSue7YfHiN/aFOwvT8K6mUE5mXuPRKVydHTITV4v2U31IiT9rzkI3UnvfnOqtz5zYj88DEgkKXX/fF4qsPKkd1/A6MZ/hUyfVqrs1oZEXbHvpgC5sK3WpcbirOBYvVEkz45OGZ9Pms6PjyU7PTrCDI1vELGB94Lz4mkZ9smUuCLrH7w8GVdYjle/3K33w/I3uhgxWZzeVBq+rRhepvehXl2gcsgOP6KiGXMj7WQRWpO9WfMC/KdLiZvLaw5CG2X5eEVuJ8mLuXiHrgC/aw1CfGRB/6IuDSKDEGrxMeWIBHbRjIHPhwkrHFlRDNpEtGLyRTNzJUrqemvWQIujk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?JkOm6Y+eT9nPd5oZ3oPKvkUINL9h7GYxoawcz73QryVcIEQvADj6+TJmB5?=
 =?iso-8859-1?Q?TXDdhaRN9i9Sv9Lenam1YUTiUHPCyXa/v0pKtlepPbvYpbrTQRt+TVI+Sh?=
 =?iso-8859-1?Q?pB0otqQGgLdXHkz3C0tBAR5qEXV0EX8BSy8ZU9NYWgUFollS+kAsDQFNWu?=
 =?iso-8859-1?Q?TmvTuVsn7vjKf7C1qXk2gwHH6/gkyjAa60JRIBhkProLhtXYfjzNX9/y4c?=
 =?iso-8859-1?Q?Apw8c+vnDGxCN0N7ivF9U479vh2PtpmygmBftujQ7ev9effPQBtf1vGDiV?=
 =?iso-8859-1?Q?gR5i3w9OJsVZLioedcMREELiVHCpjJk9//7eyxWJwxfckRnQHmQSYmjVer?=
 =?iso-8859-1?Q?P6to6h9Cs2H3xGvrohdYLJbnFWPwbW/Qu1MZMmU/FF7rArgxXMMPiyZqrF?=
 =?iso-8859-1?Q?k/skZq09DfE/KRVAyHMzl9U6Xo793wvt8VuCGchoCbsjL7ZoSk5Jl+pvud?=
 =?iso-8859-1?Q?d1XZtqz5UedDHGInpUeB48nTn+TjfviQsWwOPcEI1rHKL7VFjy7calZ+os?=
 =?iso-8859-1?Q?WZbHPhdn7eRsDpaOr3RgbIwutDjCidHfLROhoAirvpHh/xOngpgBQNsHmJ?=
 =?iso-8859-1?Q?rJzfM9raGH22x6/WAo7E1T+976TpP1CdOF/JKJU8MlJdjMQ569xpMrWG+2?=
 =?iso-8859-1?Q?DF4t1z1A+pVUXmqZ6hs++0fcgWr5mw1wtl6ErbhTbt6bPL4zwHAmA+PEwn?=
 =?iso-8859-1?Q?g27ZaLb0ncuhOMrZtMQqMEjJe9z2+3AfmRQfvwRn7HvkPK31KmoM0LxqKI?=
 =?iso-8859-1?Q?8Wdkw9vrdWP6ZvA+0zk9TGMkUU0EowmhioZQ9CWIxRAqy6HBRVTrJrLnoQ?=
 =?iso-8859-1?Q?1dWkyOoU1KeydrdcHtDio047l4Clglh/FDD/wGL3u2Dcn/UDiV5G/CxQCK?=
 =?iso-8859-1?Q?CemgGpQWq/+NTc2xliTL9puxald4MJQPuRvmn+hzNTESCuct3g4g1Y7AHm?=
 =?iso-8859-1?Q?jxK6uZfZ3GZQuy3p9BMvUXZICLPWp7T4qv57205k8zmjiGBhDJ1zR77VGc?=
 =?iso-8859-1?Q?eY1QTLKJFK7aYhdn+/OR743dKT4sM1wojGwuF6qFC04I8XtWVbuo4/BePF?=
 =?iso-8859-1?Q?Ham6CIskN/eQ44dRrP7+1gdK4TmJOn5LpMzbmwW7xPBr5RfPSB/v0KC50a?=
 =?iso-8859-1?Q?BAdyZGieSDD/cZL/jnIQBMaIeAgcM+n3lCaQvRtJggk/nQ9sCuzCgiRHCV?=
 =?iso-8859-1?Q?vFRSgC9xlOvm0Wdb+UkJwvN/2kcaQDD8DM3mSDnZn1IiaGpLPRiBgiJpQp?=
 =?iso-8859-1?Q?sM9U3v7X53SjLKpvs6ubpzfLuOp6rB3J/bM+C1MdU2qBfMQmmuDTEBEzio?=
 =?iso-8859-1?Q?B/+7bcIijgN9yim6FerEQYSBWCHKYXgFDGIzGhjuWObHeaTccGTr0cNfc0?=
 =?iso-8859-1?Q?ObJnDFBnbocipRL2YvNILM+JB1GjWmMMwxxds4tX1N4JqqoBPztS5CnLM2?=
 =?iso-8859-1?Q?DEpEaRReSFWHgFcr90FJvGfv8C5kJJym6pfIGp6MafaOkHlaBOzxIeszdd?=
 =?iso-8859-1?Q?FPD2erOUpJl5pnpEQ/5ECkdHhp/o9wQcZRLS3zFUvMpa3qcSF+EAFFNwua?=
 =?iso-8859-1?Q?HIur6r6CnmbHtGMvLfwg+bduhjpohCNqz6q0rbyd2D/5WzOy2K/YKtHHb0?=
 =?iso-8859-1?Q?QAlQG53N4O8WY4WllXUyAeor7Bt8x8kStJqL6CpmmzWuQsnOmczNgevt7d?=
 =?iso-8859-1?Q?yHGUsELOhs7KGCaoLUIEBec3QQPPkFMfwk7nZq4GHUaHvY2dawy8AzXu3g?=
 =?iso-8859-1?Q?p3prccgcy/A+h98p5Opxk4ZlnD7JE7s5a15sHnRiqZPADy?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	rihe22fKFtS6H8h8Dqd07ZTdagxIEcPOwZF/wC7O19SK1WUdn+M7fbsiZRAG0UQo51ewj2RLZkvBjlWv6PZjuvKBK4jVVvTl9fCvS5K0bjnV7u14l7BPxY1W6UfymocL91a9oVbEzwWI7iMdI/olwgO499yr4dLSG2qBx/dTSvTHoA33d1ilddAGIdoxivKRiQd5ntntTLj8ommIP6iQLn0XNsFCbD4K7JoHRbb9gSJfpwH1dlSCp3XT1R+pUkk5aceP4IFcV1B79EsShSfa9NSyg2/VKj3Ud+mP0c82qv5satj8CPgKS6Va8MsrS/9yBmPsAZC9h6qx8Kt+nwHU5g==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fe6478-fea5-4ab4-e97c-08def411e491
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 23:24:41.9114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xPAWO5O+kIQXLuHrc3ITCWqysA57yGZ8iPEjvZvesacRBZh/gPV5HyJBU2mfeoC/Vo3nknrZhn7KZBJ3wOXwJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR20MB5045
X-MDID: 1786058685-PtCmGcXHcCNF
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1786058685;PtCmGcXHcCNF;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
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
