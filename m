Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.147.154
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793114359;
	b=bBVb/66rgj72XfV0aovhTzVo6yjOiqwRE8IQr/7bIoY2jOE5xyGB4v6hneBVDhtTkNl2
	 s/1HFJlp3+LiXbqAboVkkQY82G8nYEmABg4ExI6vwNxzlPjBAY3sxuT1Bu8MOBfJ9BZoT
	 6VOotC4LoSUGyIfHHgNv7hgEkXqY1mb25ZsIAmVRfi/yOUTZ3+6+aOJ5u11On6E+KIoTC
	 pr1HbShtS+L1jOCQ3KqaQrC72epzaCk/YiyIQelaUMDz2AmtGpzR9DY7OsUO4IpFPFVAY
	 YjFV5LH0uI3JbUtDXR/mhiJO9NqdcWMngJuUirlzGDgabiGP1VSywooXJa7W6h1CPSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114359;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-RemoteIP:X-IronPort-MID:X-IronPort-Reputation:
	 X-IronPort-Listener:X-IronPort-SenderGroup:X-IronPort-MailFlowPolicy:
	 X-IronPort-AV:Received:DKIM-Signature:Received:From:Date:Subject:
	 Message-Id:To:Cc:MIME-Version:Content-Type:X-MS-PublicTrafficType:
	 client-request-id:request-id:X-MS-TrafficTypeDiagnostic:
	 X-MS-Exchange-RecallReportGenerated:
	 X-MS-Exchange-RecallReportCfmGenerated:Content-Transfer-Encoding:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-TrustedPartner-TransportRecall-OriginalMessageId:
	 X-MS-Exchange-CrossTenant-TrustedPartner-TransportRecall-Client:
	 X-MS-Exchange-CrossTenant-MessageRecallSenderObjectId:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=outNrj5BSw/t3crkHGJXZWaTb/6lLsCLpDtrjCwiirA=;
	b=pXNt/v/ZeB4qK8cmWod0Cq9KxC2rpbK+ELi3/3TMbeiDymQMqes3iLpmbWhJ5Ly3v7dK
	 JYJqPZGWCx1kapK+yQPFnHdpWZ2ZLYmqsg9HYEIwY4SmfWeDH9ytvMO3QOXV2c/Oe+18k
	 HMuTTMIpnY41HkQOnIm/ZQqWv3FNr3YyDC8XQQjWDjz6AkCrhuJqGi5cWIjS+pOl20FmQ
	 5u1J8SZPqHRDHHj6pXbiTzolkp/TRiPKIBNqjIPEjBwGWXltPxwIqdLIEEryOEfFFKpOO
	 HL1PQo1UwohlYoIP33LCeXycaTO96Fvqegcn7TEy+9+ILbE7JjCyu6hcpj8C7OudKgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gtt.net;
	spf=pass smtp.mailfrom=gtt.net;
	dkim=pass header.d=gtt.net header.i=@gtt.net header.a=rsa-sha256 header.s=selector-esa header.b=og00lhHT;
	dkim=pass header.d=gtt.net header.i=@gtt.net header.a=rsa-sha256 header.s=selector1 header.b=Z1exFbu7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.147.154
Received: from esa1.hc3324-5.iphmx.com (esa1.hc3324-5.iphmx.com [68.232.147.154])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8FF606A334
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A8FF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gtt.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtt.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gtt.net header.i=@gtt.net header.a=rsa-sha256 header.s=selector-esa header.b=og00lhHT;
	dkim=pass (2048-bit key, unprotected) header.d=gtt.net header.i=@gtt.net header.a=rsa-sha256 header.s=selector1 header.b=Z1exFbu7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=gtt.net; i=@gtt.net; q=dns/txt; s=selector-esa;
  t=1793114359; x=1824650359;
  h=from:date:subject:message-id:to:cc:mime-version:
   content-transfer-encoding;
  bh=outNrj5BSw/t3crkHGJXZWaTb/6lLsCLpDtrjCwiirA=;
  b=og00lhHTWLjBeMwjL0zzPBAihCz8LRUBQ6Wd/J04JmE+/RIztwP3IJuC
   LQg9hYaXUYnkztCZH4Olr7/JRDI4GilGAe1IpvJehg9ghW1rLosTsfd07
   ewqPya4qDKe5m0ZPuK8roefAIJ6XlQtCNHqCzEEtlaeJnmTJz+gdRxQVO
   SgxIY8iDwtuETd3VqTf4LQyEr5oX1giRjaydT82Y4UwL8NlSECmcaWiCc
   qvGxBlqG+/WjGxKyROhQ+CgF8Yc+Eve6iSBFL0voyjSWf6UzBEv0DK1dB
   odE6nXRL0HyItshY5803XYKe5PeDijYzQfJD3oCLWTUPSdaEb3xl1gW2r
   A==;
X-CSE-ConnectionGUID: iFKxORL5TZq+FLaywjCSWA==
X-CSE-MsgGUID: co9MnP4HRHmlINec9aciFA==
X-IronPort-RemoteIP: 52.101.62.122
X-IronPort-MID: 206445579
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
X-IronPort-AV: E=Sophos;i="6.27,181,1787025600"; 
   d="scan'208";a="206445579"
Received: from mail-centralusazon11021122.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.122])
  by ob1.hc3324-5.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2026 11:19:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njj0G2a/yYVXWGM1E9jtysGeVLm9AzlSRwIu0XbWnjXehHLFeEMy/blMWhTli2leQtbSzLDq+xb0NgW/KREpxMcO0javcoa/mtMVpP6qA9Thdh6iPZ1XsHYq/46S6hKnsGPyi9QxX0kYKMi/r1TeCe+/exBz5fzqFBTU/cYYqv749DgOcvn1cFvuc1tnmEPeuK+0NlV6/TDeEUThNtzmUSW2H/FfX0OfbfHfdCHjdKi1SqmmMDHePEArrf8l8fFwcuM9mtqiqSTALIh/SixatkKdWSusPBP+HFYvAGJo1P/I1XfeVloKz4qS9F/HpQyMGoBgDr7gI9kSAawQzswXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=outNrj5BSw/t3crkHGJXZWaTb/6lLsCLpDtrjCwiirA=;
 b=YS32cdA7DF2pD60F0AX+0ZHsxE0gnSu/27e/Gms0/NQDxldsRi6zTxUWI9G2TFLOXsIeUqMPVcLOBxPu0zklKcTXa2okqMEHog8y2XtbLX5WigGcEdOaxnW10Opu8aiSmMk2qGYA1vIpfDGxFfY1po/JAKdLNWZDi5n/DuP2buNepzmJPz9yzvPrCmpaWKFGb9OaZ/sz4cdNo6UkU84sdAntfxIHWUoaBNtI3Fioc7opF3yld+lrC/TKRlTjs1z+z/fdlMWz5Ps/JcX9tCCn0YdDz5m0DsIvk5t4KcWKKrxoxw7V+7Of/JOBGIHEdHAl8ZWtTVOfXj0DDhr+xWJikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtt.net; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=outNrj5BSw/t3crkHGJXZWaTb/6lLsCLpDtrjCwiirA=;
 b=Z1exFbu7kMQHlgpEWCvmXIP9j66N1Jox+p1IMKS3rrQarYwy0E3/37w/vmv5Gu5U+iwBJTaaBKuvsS/ojAphqmdVsgGNsK+8Klui2oE+9hBmsQmQopMAHqPgFoRnwXmAJAT2plpvDuLgK7SfeM3qMXDhbiBwiMpQIyuX3nt0lHV7nU2M+T0OHXhSkUp6UbG3xFTh1N6Q2QSEwae7EC8KZkYYCil3YG78TmVHo0gC9vzRnF2wQPegUvExHB9Vq77Db2do/utO0D3TnW8eWrEqEYjbqDH+48/8srOmQma4PlGGX3whyl8xMrv0i7b5dnC3yUevxptL1tPkFewnlOFP8g==
Received: from substrate-int.office.com (2603:10b6:510:2da::18) by
 LV1PR15MB470013.namprd15.prod.outlook.com with HTTP via
 PH8PR02CA0027.NAMPRD02.PROD.OUTLOOK.COM; Tue, 27 Oct 2026 15:19:10 +0000
From: Mark Wilson <mark.wilson@gtt.net>
Date: Tue, 27 Oct 2026 15:19:10 +0000
Subject: Recall: [BUG] vmxnet3: kernel BUG in skb_put() from
 vmxnet3_rq_rx_complete() with XDP and frames > MTU
Message-Id: <J117YN8DOUU4.OYVB6QV467Z22@eaypr15mb532708>
To: ronak.doshi@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 atanas.prezhdarov@gtt.net
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-MS-PublicTrafficType: Email
client-request-id: 22788a5a-41ef-059f-8cc9-09b2828143df
request-id: 22788a5a-41ef-059f-8cc9-09b2828143df
X-MS-TrafficTypeDiagnostic: LV1PR15MB470013:EE_MessageRecallEmail
X-MS-Exchange-RecallReportGenerated: true
X-MS-Exchange-RecallReportCfmGenerated: true
Content-Transfer-Encoding: quoted-printable
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|19003699004|6133799003|18002099003|261026140227099003|10067099003|56012099006|11063799006|261022113327099003|261021123027099003|261021121427099003|261021135927099003|261022105027099003|261022075727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	h7sx/hsYDmZku30EM26ibFfFAk876GfrcTA0DLMXYu2ynQyLHSMkOex1u2471ksCVqxCfHEZwfkYdqyt/1xIeEcfwOdklB2zl/cwqwwnQAftse9aBEet8mqy4c7WNNB/fYyisyuFNtI7EZ/cM2sRoE4iHtHKc8u75mFgPQ1ut4k1DLiOvnVjRFbYiPhJlvslCUA/W3UNrlPLF1umpDUWRogq9hUAhyFgO/V8eoi8X4hQTeILmoUCFlLABcIFM+KX6rpAk0H3C593EiQD8WI2mRlgw/nL8sUQ9lohlKkd3qdz+IcQe9KR2d2XtDawXIITSq4KNqiunAgKwygN0PGGz71iRISwf5WvT5X3dZL1kLxIcuswujrdvuORWQ2GdlwFU/VWTZU7L/AsvxUE/7S4hojQsCWrDoWJfet7n52mJqNSj5Qot7ybNgJpcX9bzkNn7bbtySHNe9BhPt5ch+srVXkyGo0NXJkeY8Pa6XkJU/N8tO/P30rho117VkDvEgw8UEFdRwX1Z7XP4Xq+Tt3uDm9ZdXit8v8asmT3jg/dNBYP6WjCJL/RnhzlA7Ye7pQVvE+jVxx614vJuFQliWvxa1cIT5CtuOadDnhg1ApG35aVCRLldF4kK4j6OA1HXHbIIKfJgeEsuOFTLCqKv0cXFmdDEj0eHBCQcWTeT51VZQk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(19003699004)(6133799003)(18002099003)(261026140227099003)(10067099003)(56012099006)(11063799006)(261022113327099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(261026121527099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qlkQpWqZN1i8DHib7Y2fqauiLwuY7e/IYtS7n2uIRD+LlxpOhAMSZoIRZ9vhGxJCE83UrP/NWWibAICnRt60npCH65lYjE4mmEWL0/86zZWKyY9CvfAL4zffaotQwaogkCDkt088sWz3xNCbhT2MOQmzkHbzBR6URgGVW8awMjG0lDbZk3qDOhHMzvR3M+JQKYfPqvnfAOUEZT4U0WEFQHu5vaKUbw1JaFC+WF6yap5xH/qBMD2PZ4uGVIzVrtGJjCoMpyUWncQdanknz9/4iZupb46nZKLjECXSmUpDi+GBLSaB1Id1WMxWxa7XhnbXRz4qxFjbbkHlN3AQztRIh6XjZDybnudEFdFjbZKySWa9hTISNBYJOJnVnOchF/+XH1IO9shN+W1fcb5Q3iNhk8MznvgYiAn2mpzANqG1tBXkF1yZStbS7KLwKtCPGsRu8zrSPytf0WaCSz/jQeNKoDnxwabcGmYo3JSyEb9soVFdKPIEwxwkj+78/h27uxZX7b8IPZFN0mo8gGvvkX/geKvlfZc4+kHIKI/A2MhyUEAzXE6HNr9B5Rm8qTIJXfu3
X-Exchange-RoutingPolicyChecked:
	MbS7IQegwYB9TvyTGB33GrT+L7NC0q96U+4MF50VAUHVROph3RzNt9MXhRMkxfIs+oEh2RtsmgvW6xtV0n1in85JHyCoYgU3pysH3E1ns5tda4JCIGPEyycQIiyF48A73j1T8GWRzoUz/f7XC4aM+NkR5+FOcGu5A5aepAtRhP3uib1yovN7ubtEopB/pYADMAi4rjGT8qSKWkb3U+pbPtcR2lZULLTjtnhuE31waEQFzfigex5dNKYlph6wzwBoFRzYKnWdBSXrFRLEoLTi0p4TViMD1h5Y1lkPKtj8xdTX8AVkjTp8HzCt4cBot2nfNApGT47PuONUOYsAJCHO+A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TfqbBWL0jZAbxnWLSWn1yYFcl8n9qSs+c+74/g0HtS/Nc8G7/FNWMG02mCfmC8oV1qzu6T8eSkAk/PhAhHdvrVqCkG99IndB+EkFNq4EkZX6qBepGPfJKktxxh6tIZka/oOLRBsRBhqQbzhZ/V+O5awDr/BVIa+t48SXnCmqzEbixDyyi51uzfkqG5Ld85QnMoIQ1l/sn+Mi/BfKOWlqSI8llBlUaj6I2mEuV3OXJrk4FzPaEyGJYOr8sGF/uigA5vrvwp+ZuN7Eo/DUiYUNq53iPLXy6lXnSoGet0873UmEdvHtw4/tuVmdMU2RBC45/LK+8MDWKHxKLBRx9rJWaZFzhohVUJJTRGhnKahv1bdffTzpLXFvJbIEr7JI5RD2v0ldzmUTJRkyUR5ZqFFq2frly1B2NVEw9ECnHhn7yExI3IQjJuxrK76IUyBbh3dmQTpi4n2svWPfxcCTeXGYgeWBvKgkm1IaF5HL+XRsoUKGCuN8j6taK4kb1SYS5l5pUnaOPNcfizq4+3uHKWpeDiLQUeFCs5BFPz9/Oej3THXZwbOva7EDw6p0m8+nA/z5vvM9QItIx2f9S4x/dw28mP/QncpNrffP5j5G0/B3ImSkTOcPOlxoFTl8dPfdIgt2umIejQnioJS6Rl1L3c+ofBX1L+Y9uwLXBXd8p6TfzoY=
X-OriginatorOrg: gtt.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HttpSubmission-LV1PR15MB470013
X-MS-Exchange-CrossTenant-Id: 8906d48b-9cdb-4dc1-b158-9e9e600b327d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:19:10.5339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id:
	eab5090f-f392-4bab-64c5-08df343da6d8
X-MS-Exchange-CrossTenant-TrustedPartner-TransportRecall-OriginalMessageId: =?utf-8?q?=3CMW4PR15MB44593A86A3BAB8E160E4775CF7602=40MW4PR15MB4459=2Enamprd1?=
 =?utf-8?q?5=2Eprod=2Eoutlook=2Ecom=3E?=
X-MS-Exchange-CrossTenant-TrustedPartner-TransportRecall-Client: HxService/Mac
X-MS-Exchange-CrossTenant-MessageRecallSenderObjectId:
	61ec8bf2-b473-4955-b8cc-a95da46171bc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR15MB470013

mark.wilson@gtt.net would like to recall the message, "[BUG] vmxnet3: kerne=
l BUG in skb_put() from vmxnet3_rq_rx_complete() with XDP and frames > MTU"=
.
NOTICE: This e-mail is only intended for the person(s) to whom it is addres=
sed and may contain confidential information. Unless stated to the contrary=
, any opinions or comments are personal to the writer and do not represent =
the official view of GTT Communications Inc or any of its affiliates. If yo=
u have received this e-mail in error, please notify us immediately by reply=
 e-mail and then delete this message from your system. Please do not copy i=
t or use it for any purposes, or disclose its contents to any other person.
All quotes, offers, proposals and any other information in the body of this=
 email is subject to, and limited by, the terms and conditions, signed serv=
ice agreement and/or statement of work
