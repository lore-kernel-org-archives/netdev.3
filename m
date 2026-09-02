Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A993A2540;
	Wed,  2 Sep 2026 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385254; cv=fail; b=TIihwI8zrT2amsjmAeEMfiXRijyEo5iHY0j3ECOV5l7qljwBZBKfqwsPwAUuJ+x0Vni3SiqzcSTXlcPe2sV7fiElGCyudbyKishBwmeY1/p+Jw+9+3tNm6OTP0VQmXCITNHZ2inR6rYgvtd/Nj1unhX6ttxVgaztx6JQBhG4VD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385254; c=relaxed/simple;
	bh=QFt3K31SvMGZkxnWDftd/dr4sazZS7C/N9WT/yweot8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rQSNVM5NSkeZMQoAZq9tszuDiJEUjvQMuYulGXVWDxUlcDTOktf2+ziIvaTbwJUXK4iOQ8tRXp+K+8tdUX1Jn9Dwul/is7RHgtC5P9w8xWlLtaZ50zJqxarhgeeMD8DJahsAPb5MZtGiHa5Bpk49c8yJ530sJYO9B9pXKQAjLjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=orEFucA0; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=zV8a6l3V; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="orEFucA0";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="zV8a6l3V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=GUMQxhpXW13mboPPWDvdQWiT0aoaZ4vpdNJdKgJ6Mg4=;
 b=orEFucA0hwCUBzM0ajvcGx46SLZvbxvGNifUDW0721OVXQ40byQq8Nfxr4gokP3178mzSjq1PIo7eIC+htvKDKROSuhr7CH8PRsOmESfDf0OEafNt1Yl5d28ssk3s8lW+LW4csN549UQEVzU+T950Nhmavb8MszdM848gGjkz/J87AQeRjHmP1ozrHg2KmaSnZBS8ubyq/NtP5h4B3Qq80DKuX6LCRT3c5ImYEwXMqrHimGmMx0u7ejmQm8+VfTuzEUY0ZUFR28ofR1r5ImnVPWujQbPLeqAnowF+14N5MyqwCrLk0d1a8YeM4RPJsyX3Gy5hoOqSua5wb6lI4NcuA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023110.outbound.protection.outlook.com [40.93.201.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 62ACE3C0088;
	Wed,  2 Sep 2026 21:40:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDhAI6+O9y2W9EgiOuIc/wN3OJBgSLa/4f/wq05pYvqM5I0ZLKOfXEnKj85BP0HvxUkhCWkVESHBCEBxSuxzV/Lw/0yB231tgAj9powVtnDeO2URxcXGFs7Cu/PZ51bLDe189onKKPCXMzzR21vqAy/OJdJqiof4Kkws1di0JXPitz+/btdQnp+s938S6ErS345qqQ2hcQhjUWrz/Tg2r+u5x2SO08jEJosiymd/LC0h3iRVnJRcsxGzP+VRtdmrM7mKIOKJs9Y6bV6jYB5bYjQlnJNggAZEYAAu2D6TD7b6X3Cdhl5qo8cugy3HUWV+mCDvBb2jgjss9tAPm8fPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUMQxhpXW13mboPPWDvdQWiT0aoaZ4vpdNJdKgJ6Mg4=;
 b=f2SkBBugeiQPXUdtfb0/dXeMqTjz/Nl6k3rktmw3/XFsNi/3ZC4TBXyB9/1eJfjzLGFTy1aqal+X5iD6BtVxSOpwT/pLKQGSatkdUK/uPFgG+ewtsexpHTRvoJIQr/LEWb1Smfm9WC4XjLqNtwZZTTOSks4aPmJGRvdLYibjNY9YWYWGXDrHW4jUpuC+2oJESPF/vMc8IvchRacv+R1+Gnv1rpg2NuyINhS+XqDXwty58SBw/9cs6Jg8rXkKqh8KD5r0NjRGNXkpnQMBVOC3/NYjR5Xsh2lUICw37bm2xG/PvWEBZVFG9wBqdJiDrdTSRDbRYzJi7o3J5qlkZ0JbVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUMQxhpXW13mboPPWDvdQWiT0aoaZ4vpdNJdKgJ6Mg4=;
 b=zV8a6l3VctL4OB+qkJ3siAY6XdN9AK77XAfQw+O6YnjDJ09mkfA3cIMExthLWpX7NmknIjxkPMHQgGH68/rLZR0EPsxgvsYju+rcOfazYehyaMz1L42SXwCuPMalJhEbWLcjVGzAlluNZc7QSGW+JK7KGPZYvCKil0my+HNRkVt5Wm4Z27qyYWNXW/EM0Cve8oEx4iwp9+S9E8E0MOMcZuC2LEzbGPgSUwnu52vi7C/Hbfdl1f2K2bgEyyAR6Pvq92oHuVtIbVhXvS1kA8t6YaosqBvqb7eOMDTWtr6Cgimu7N9TSdJ+Xlagwc9/kyckuEpQyw5NpH5TXEW9uAt8Sg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS7PR20MB4877.namprd20.prod.outlook.com
 (2603:10b6:8:97::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:40:32 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 21:40:32 +0000
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
	<linux-kernel@vger.kernel.org>, Ali Rouhi <arouhi@sitime.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH net-next v8 01/15] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Topic: [PATCH net-next v8 01/15] dt-bindings: vendor-prefixes: add
 SiTime Corporation
Thread-Index: AQHdOyOtdzxNfre4VUG4ep2vRQhUNA==
Date: Wed, 2 Sep 2026 21:40:31 +0000
Message-ID: <20260902214030.20955-2-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: ec0e6854-2f17-4881-38fa-08df093ad09f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info:
 7AdrZ1NK/WzigNiLt7L8hRtauGFhpSI5TfpX7+XgT3Yj319RqG6u8LH4uOKGTxxWnWqUb5BNMKlTngI76SWVpU787n4czO8jN2tQxPPk08iJLCz4tOQB8oDaMqLCovl4yDhvk8MSGb3ktwZ1QAIvAdSOgR31zYPlx1yxvijQihar90cLOt3pTqEn7jO99dWrcATZMQcDNnDrT5yRQyqrg0QkkCZeJ9K4b0dcVy//C4RKJlkuWDGtdk4Qnk6YiyD7X+OH54Q7EMV67EguMhdrReddrCdHFBuN5fHVSQqlusXuXKuVZeTQfTXDpo3Pxal9FY06UiwUL6uWIjTwibMCb0bzrMut1j+IDkFZ6JubDQ+SluJsw75hxo8CEtNk2OS0H9D8+6K0qgAxQY/EyDuOE/9HcGXN/+XoaLk2CLRN66FNEaZrrgMXB/hZw2Eq5NmAoRZNaYcKCgNoXy4s83fPtNAinDQ7ikQhpypktISNEWzrxYlisjNMwBDEFRmxz25S2A69+hBp2IWSU4DZ8dXY/9/xtcjZFNxx5b1E50/9MJ2Tnk4P/dheovgt87BTNTxrdERJhdORvTPWvhJjlVWX++GqD1n9HlOmTYxQ9nRNbF+5EcOnkFnut489Kd/GVcmKjypDOZMxNGMzbifXgpYInXuFElYx2Z1DRQXg0OHWVFUuA7TtyitDueYfdzrwXYiwcIbEvsatyQ+FweHOB6MuUfSEot+whEIGggbcP+Dw4oQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+KxFaLSn0QqmSdzjgR5eGdN0dkSBjL3gAs94Bn0NEENI+2ntbh5nEFOq1N?=
 =?iso-8859-1?Q?hy317bEu5hn2NpTU6wYi7/xthA3z2li3J8iOKcKp9oYDq+jdF53YCnIu02?=
 =?iso-8859-1?Q?9bu+jgCmP1qfBuGR01iHMnQT75WEwGA9uE0E007h4rYtLR1flD1KJRNtJO?=
 =?iso-8859-1?Q?gqe6Z8qkMYCtn9Kb8YONL+az1qcmWJ5afrAOa3iKdAQnlw7JcvUR+HBx1P?=
 =?iso-8859-1?Q?PVEA7wvqiZ1wyTcpXy8MKLYfjpMMg1OZ5B3YrqTWTiUqS3aLkmS+YtNCiI?=
 =?iso-8859-1?Q?e46aKkn5fhKyvE8tussv6NrKuteIohC146wDGi3OKOx7bkDTYtBOrTzQ+w?=
 =?iso-8859-1?Q?Bw5EHId1nFSjrSY+AXOHVx59YMX/T74If7vwMvudNaOCy7R2x6ocPPFRKS?=
 =?iso-8859-1?Q?wOXvVt9tCeYjoFHEpQHafiDYmBTr8YxdsLJqq4EH/m7iUFiFisquOCr0ui?=
 =?iso-8859-1?Q?uMT4XCavP1x3NEdD6wXgeWWamcDQIGURQ82UguYXfFG6zqeQSXoKvW48ME?=
 =?iso-8859-1?Q?VXW5R0VwY0KTNsM8/qXrG9eDxVIs7FJslcH3bqa26kOYcQZoNJtQZyaoVz?=
 =?iso-8859-1?Q?A/CQwOgW1u+aUErpYnT+Iyq/umN4vHP8Sr/cODjNAMvHlsbPzhyw6nPC94?=
 =?iso-8859-1?Q?BUiWpFIuzdMU0viHbbr2Q8HoVDvkKvJ9pwx0pXpt6ytfreDyrAd1tLTzBs?=
 =?iso-8859-1?Q?IRU7BMc20G96wmfQpOxXCf++/UM1kznxGCwbekvd8fulsgeqo4N8yVCUG4?=
 =?iso-8859-1?Q?n1XHhKpgEZVb0E6trhtUQaGOmgy+fQLKHOS2b163cX/9mrtOyvcxa7Mecx?=
 =?iso-8859-1?Q?lMzIVQhhon1KpMwsNh5yu2HJBuOi6u+wFltquUtvNmeW38wUIeJda5fMhy?=
 =?iso-8859-1?Q?UO29dHIl/PrrZSrt0z3JKsWR+kO0UWTLP4UzqBwb5F/S0l7VgdPNuo46us?=
 =?iso-8859-1?Q?4C2BrSLO7GIT/QoX8KZfVbKYB8YrU7qps3mXtzV0Ma7lJlo8fm5+WaDNjw?=
 =?iso-8859-1?Q?AJV0qQic43rV9xVh/St27rAp0yWyfTsaR/N0YjjRiI1nhjgM1qkkidOQ5N?=
 =?iso-8859-1?Q?3egrm8ukGrAR99XKMJ3av1H2WPYJdDUZjctKkgaRjLxRpAtc0idabM5rtY?=
 =?iso-8859-1?Q?JOWewCPjBkkcNzIomitMeiTKpT9p2z1MQsAUZCx4hbLut4KkROFb+gsp49?=
 =?iso-8859-1?Q?U+6YcAZpWxedWCfvI3cpMQQb6uoUFD1EIQL0fenap5Rj1/t22b8WoyP5jV?=
 =?iso-8859-1?Q?uLOAuWrOeMGEoAU6mt+By3MzUUP7ZOqee41r/zD8AtvxO//nByGRuNZ+ya?=
 =?iso-8859-1?Q?w6blgYtZjsA17IQLTx++2YrUB7NCChUn2XMsKXON/A+ExspWxYmRXhHtRt?=
 =?iso-8859-1?Q?WdvHwH+QAk45fHE361vHBztM/Rfh94JrBAf/0wvBh0DySmLSz4ZVrEw/aw?=
 =?iso-8859-1?Q?MGRLp62U/giMx508fCsdKo3vFRa4yq9jyJLySRrLg0x2E7uGNe2FwXoja3?=
 =?iso-8859-1?Q?m49HJV+JViYeQZGYGupHG+7HXqfFFlr5wNI/ByvtEpqkg/sg+XQtjNgJxr?=
 =?iso-8859-1?Q?KZ881QkESpSlDCRv5mmKeTyPnsPPm3c0SGFUGLnDDmI0abgyhwlzDQ1LSv?=
 =?iso-8859-1?Q?vEYgyl8BMZygVLjop5LRTcaG6J+4Ay6bUUS/s1mwAuWScgxw5PAlgcO9pG?=
 =?iso-8859-1?Q?8aL4bl93XzLGEW7e+KLEYV65we4xWwZ0L9zfz2naqk8/cMAUdqFe7U6jCu?=
 =?iso-8859-1?Q?f1rZLHkYHCJwgKr+6D2wNYOZd8QoXZruIEWRBerDPVUJ/G?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	eEKSbUOXz0MbbCyMqyd8iLbSkjVC0tbWD8AEMH1BA50iIXMhP6GjQVWgAIkxW27BM1dG4894+ePTM91jZNp6nKfdgWE2sqvEZJR3gAuWjJZgkpsgVdbu1hdo4gett7zIm2C5bors0QE9oSITkVEiBOlS6Sph1dXxmbe0byXnZDw6Lso4OTbc46uS1XlrDAZsZt884xhA0zip2TGPcHis5UTEYPmdTq/UrwXZd7mVYmkHSbZZkBvqsIGdu8jHAFD4gUphwVfARhC0Rnx0VBVDzH40Vp+kwLDf6xyayyFZDPv4a5bIsH0GPozbfAd/DrMBgGwzqO2x96ihRZkJM+VcXA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0e6854-2f17-4881-38fa-08df093ad09f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 21:40:31.9235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dh2SZCce3HHJlvMAKmXL454KPGU0QvED7lyUBWF8GRWkzcckt0kVMFa3+CfN56lM+5o7vWpIKlIa4LaKFJmfhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4877
X-MDID: 1788385236-XyjU6467gJHq
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1788385236;XyjU6467gJHq;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
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
