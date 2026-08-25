Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013048.outbound.protection.outlook.com [52.101.72.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDB53DD84C
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654372; cv=fail; b=YovYePpOsQA679xUCBalqfJe/d5b3JPtQabIj8JXV23HDJKRUjAz7hWB+7vgq5BkOC/jDibMpcrNSq3g7H35nBNRpw7FnHzOb4XCTffbtC9NowdIYatbH0BmNcbVcbNXC3bKVxjdVgJVEz1kUHZnvVvSuzNfS2mo64N37QQ/Zc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654372; c=relaxed/simple;
	bh=z69FvXCByWc6KSllUBXKao7i631ytBcUE3Bm7yfn5es=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dxJRg5778io6SotBusriCeAu7QSJ8mXCg4f6Uos/qLwVJQW16KtVPq7488AF9rjvwP0iVBacVkFEpEoMxTm0FIfmtsoguBym+gfvxLm+OHoiQ4B/uSmgnnrl7HgRaTHGjoATJsk8DTXFW7xbZoZYxbHPU7G3BzcAFUgiNwvNmYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=lXOZUvXe; arc=fail smtp.client-ip=52.101.72.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="lXOZUvXe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoHA1eW3te9giU+4xRfsJF1cO7xmQZPXibTIIZ97sn4muWUXypldcqVJQtGXXHxB/VOY+G2PdT6QV7/LgPqotWtM/CvE+mvXeJpH9XK115av+jbTj2wsGEnY/M5yh/wpKjqNQBM8/Z/S1gBahAs3sIOM1Xc+yIB6+m2NSxw/nHLddHI+qRelTkPLyaeL+svcpyrRZdrBbiGuYb6bSgp3ZsPmjZqBIF5mUgxHwxjBmmF38Rvgd02gIqwFkIyG6Rufxo6Avb6s7e7YF4ZiN7DIEBQ8PWMGsHpsg2GYhIosgeMG+tWKL6Zn8A8ZsjGz3Kr8URHCF1dRyw+sgVCtVJBwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z69FvXCByWc6KSllUBXKao7i631ytBcUE3Bm7yfn5es=;
 b=oX9MjpOYuOERn4nJHOC0w+g4Da4m/4J5+JOS3qywbwREKK3F81DPOlh0nsEeLt9st2ntSnVN50zeqY3BfUyBCpG4wcej20W4URFHXBmxoL1Xxquosmoj7E9wcFl0Vsazz4CDr5hc/F+auQbJMSdmWjWE63/rjYYdkPkuCi97AhkMskTqXn1d23XShaDkp1kFBtJ3tWR8/SmDiNqKkPFGZ3B4o3cZQXZdZCd3byHL8yrY3KGJbw6lXoY2/o8GPccF3R0Rc0QYq5X6Y+nNFUF8XKmqJxzefuRaMQmJMjJOP8H9i2IrgMR5yZ16+dT3k2x7u9REzIHYISLgTYcfKd7n/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z69FvXCByWc6KSllUBXKao7i631ytBcUE3Bm7yfn5es=;
 b=lXOZUvXewejWWQ+8VXca7Jdr8U4uqbzOCeHnkqir+/fzGnA8pxsaVrAwPJVmlKevtqT/s4u6UOddPUrnuFMStm0FDjordmrBByQ2yAoOla8jJhD8dfoLqaJv6mDjVOeskf4DXn7Td7MnrtaV+5KGL0dAbayRLEcIVnthtwgCTmznFiEYnyIwVE+MUjiNLZMOPLTswflGXmoWXH+U85tkfFkEQ91voeMuwEsXSE32Rmvho4LDryCD3NBKbvgUtyL4IDeVKpY+kIau/6jpMNUaCET+MyqKf2HwahPwVEVxOKEMrr4/kx9kvWkQuxd82dWzVO2r4EeNgq3OLSkDNKsMrw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AS4P189MB1918.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:4b6::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.6; Tue, 25 Aug 2026 10:39:27 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 10:39:27 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"jmaloy@redhat.com" <jmaloy@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, Xiang Mei <xmei5@asu.edu>, Weiming
 Shi <bestswngs@gmail.com>
Subject: Re: [PATCH net v16] tipc: fix NULL deref in tipc_named_node_up() on
 empty publication list
Thread-Topic: [PATCH net v16] tipc: fix NULL deref in tipc_named_node_up() on
 empty publication list
Thread-Index: AQHdMhZacXR9yjRIjkKlbQjjAFsLe7aukqcAgAAAz5M=
Date: Tue, 25 Aug 2026 10:39:26 +0000
Message-ID:
 <GV1P189MB1988CC62F9E71B30E8038187C6AF2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260822091216.131278-1-tung.quang.nguyen@est.tech>
 <5524d562-db44-4edc-bcfc-65a3da7806a0@redhat.com>
In-Reply-To: <5524d562-db44-4edc-bcfc-65a3da7806a0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AS4P189MB1918:EE_
x-ms-office365-filtering-correlation-id: 6a71f70e-6c72-4a60-e0b0-08df029522ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|3023799007|6133799003|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 E1SmfMU2BQJa0JDP94f33yuuAaMj1kgvNcoNo3HJ4lj+XzKvh3zeBoq1LDOTwSLQ41VIzPRbW44b6qE/sw4ZDR2lukf6xzhD/zTTsaJA1pIkLCFpBYueZD5kXfH4OF0mbIepnC13MJQ6zYaImu9DX8FXI+hoEuyVsPwXI69IcYo7T+s01v+EdL7/0+dDVsxuLSsa7Gi53VDhYBMUIy3CEG2Eh5U94jQea/qizwu6sx2+5Dri2ggN03StIRGzfWqOEj+SDHuPzrV3RmDRdD4ZGSubc09lCf3AtvN0WvYmh//Ne2Op8+/7ZzjLJlu+P65ImRtMse5WrWutB33Cuk92MGrCVBdoH3QbY9Bd0vnc3wGdVpldDKptpfEEEOoiY/fTGcWQRL1Brct/chh6RYo3z2TaAwBeVYuxSfzO1GKRGiGP/7NcrCcnqtdQS6T9VUars+fG8KMCroTDgpYyM1qrMqV+obJ7u7NcAMDsgG+WfhMnzmVD92mw2N25RFSdhNGttiRvI8Rg04rMY6dxYkxoIUdoK1gyxkvO19OFbGowGchWQ0woaR2PGPUk/rpVQVVoW6CuB3mz0m8aIyp+uLo3Et+DvjeQstPkchxwOtZo9YsYaQz2sc+XazVYkh87zps0qETP2+JaILZaxYD87bx9fo9z11MokUL4LTaL2biHNNg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(3023799007)(6133799003)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?IKznz7PRqZQx2M7iMK70LyNFTYh0pMcoj8p0kEA/21VlBlvD3WYHd4g9/m?=
 =?iso-8859-1?Q?Cs/XZquvci2DtzK6d7kkKgCgxSZf11ZxdrUqv4US5aRUa+Tw71mKfZFTz7?=
 =?iso-8859-1?Q?pzkWDuSztXAgruOB0YfNptiQKET5soVGJlf/4lzvhLt2Uic+S2WxWYY90U?=
 =?iso-8859-1?Q?/+oXMRZVrNKdLlvM06DLN2ecQtyFyOEjcMQ+X9gCvz2JzHeRt3NWkGwGpb?=
 =?iso-8859-1?Q?qZU6i2QZNUwPKzrq8/OwzKhxkTbjyWJojWU0sWktBuZ27NtmscE2lQWbvz?=
 =?iso-8859-1?Q?OPkE/t7UmO4HZP3YFkf3TpNRReD1uyeabu4hEcPwWq50SfQAluPdgvSbI+?=
 =?iso-8859-1?Q?R1C2vzeEWu906H12Cb8OvE347svtU0DxkCJkRRzJ7jJWKVL6oMLwdsRp9P?=
 =?iso-8859-1?Q?VkmJ5xc0VypNN0GBdZ/3H7wipwcE+eFP9G92Lzu1NHMgUSA0vJbKtVRfF5?=
 =?iso-8859-1?Q?RTLXRqn0XbDj6BJXS/2Uz6EEN0GiRCfnUf2RkChyztpBQhAB21MrBRoK0Y?=
 =?iso-8859-1?Q?V4iPhZh1+u9FW0pzKMYiHy9tvWxPDDuTGqZE1RxqTR2Pdyr1HIyktDpOKI?=
 =?iso-8859-1?Q?VSMIEcVB6PI/9um/Q+c1hwly2LVN9PWIlQUE3KTRZKLxAgXGmi1/DnTgaM?=
 =?iso-8859-1?Q?auU3uk4sKLEbOt+PA8c/IjKRnojHg9lwXmMz16K8weYnSrVAPGWvIEbyZ0?=
 =?iso-8859-1?Q?RZfKbcGyrC90kcux3x2agRM+wMBkiQiCrD/CPqLXffybP3Mf8//WgJrQzQ?=
 =?iso-8859-1?Q?otPaFb29qZ2UJi6D+zyxEr0S0eK+DpNPaGfD0Y2k8MIwgoivK+gKLYDHQU?=
 =?iso-8859-1?Q?teS0FcrxjvIHeFexzfsVU7a6sgdVp4xxkpjOmlQJukgrWXMFZv3ZQcEc+o?=
 =?iso-8859-1?Q?xZt7R/wwNpVl86RactqKUUwFhFOvCA9kS5NV3p+j2beqmro1Vu1hMtinWJ?=
 =?iso-8859-1?Q?ux7MNbavLAH+2/Bm2Ayi15UT6MJ4Bjddj5Ar0umj+r/Y0fWGgr7ouOsJwc?=
 =?iso-8859-1?Q?fByJ7s3kAJFVdYS5Jxqo3UWaKEugjVIK2c15Zz1NakQuXofRem6mRC6Y6N?=
 =?iso-8859-1?Q?CQ8AchvKAwXRf1S2nMGwCw4g4WQr1e7dUziDRlnqC1ap5VjdBTbZ8/ql0v?=
 =?iso-8859-1?Q?VkfQHuwntGrgw3aAxKL6V5zMbMZNngxG4u+gE3/R8U/W91trQl08Jimyrf?=
 =?iso-8859-1?Q?TYuffgslVGWpID3w2bs4RDqLuIRcBJsLMelGmHQQjPqSOMdqSZ40cztVT2?=
 =?iso-8859-1?Q?vYQhN5mb1yEDJ2ousD5qB4UWgrWa3V6OEZfA9UENM/j/rgPcz1l1uZcm5K?=
 =?iso-8859-1?Q?0RHMTxcvXN8F+9mLLe25niLT5OP58IhEMjzkNWqxmfy0QdOPnhhP5I6LSf?=
 =?iso-8859-1?Q?v/v6LKqY7mKql6Vg1oMWjSQEdMmoieFtecpqrRTD6qm4HMrvV/sreLLI8a?=
 =?iso-8859-1?Q?SskzN9c5zI0gKVrEkl6WIqjlPwGsC7MPeWKk72mCGAkUAFhtNfmPTMUJAL?=
 =?iso-8859-1?Q?CKkcD4Otzb9pnZiEkn7WzRCpfEMSQAdWWo7nzY6h3qKM0hwWRYrRm8I9Lm?=
 =?iso-8859-1?Q?+VjvwVeRNie6MfJwXN5DJIl6yDWF+obhxYLBetGdO03vX5DSEJA0KmoeOT?=
 =?iso-8859-1?Q?t+ds38vxqNg0grjTfOIntd93t0vP9OXwGw7AjwhUVy1S9UDcqwv1Y9kyW3?=
 =?iso-8859-1?Q?+nF5KA22/fzgFFJ6VR07/oI9qetqnkOJfNuJDXfb0oPFsRVIehvJT+zMCk?=
 =?iso-8859-1?Q?ToynaSfdg2uVbYpXmHldBICOaztiLkoMI6pp4i4wVzuoXPEKSgE6ED6ouB?=
 =?iso-8859-1?Q?aWLcmbAj3w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a71f70e-6c72-4a60-e0b0-08df029522ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 10:39:26.8825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fNdYc7eDJc8gK0dqy2ga4hzOegglhdupyxRPS+UizC5ElbBEiscV8Qodp1mamXv3EGUk55ukQQTV1Gzy+ApJjyXBQ+vL9Iph32UhN7eKBs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB1918

=0A=
=0A=
> I'm sorry for the late feedback, but it looks like the above would allow=
=0A=
> the user-space to force the kernel to do an unlimited amount of memory=0A=
> allocations for addresses?!? That would be dangerous for the whole=0A=
> system stability.=0A=
No, user-space is limited to maximum ( (TIPC_MAX_PUBL - 1) which is 65534.=
=0A=
Only protocol types are unlimited, dependent on configuration (the number o=
f nodes, links).=0A=
=0A=
> The change is quite big, hard to review as-is, and it looks like it=0A=
> could be split in several patches, according to the major changes list=0A=
> above.=0A=
=0A=
> Sashiko has more to say, please see:=0A=
=0A=
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260822091216.131278=
-1-tung.quang.nguyen%40est.tech=0A=
I addressed all sashiko's findings and I am preparing to send the next vers=
ion.=0A=
According to your concern, I will postpone the sending and think again abou=
t splitting it in some patches.=0A=
=0A=
