Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392664A8C;
	Fri, 16 Oct 2026 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112114; cv=fail; b=M7ywpTe+zOI8VKPRqwCGL4Qf2CB9tnEimMw43s8nGlF6QGqalO8x70eDbs/eexHEpBHyAOxHjuVemGS6MwVKyxVgiMP9hqMeU4n+ai7fOsS7Yja1LGTqzZIFO7eQNPDfUtfCGoZhBxS3eBH+J586WGqnGGdNTX4zN5PVXrmzxJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112114; c=relaxed/simple;
	bh=wLz1t+M2zyGmndVGhYzBEHPnghniB/gB2lYy3mo53oE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j+hf7iL4MpMiJ6GqA9VCnPLxiDPoYGcVKhgthI8qnH9sf8fCyU7MO3AZkXzxUrGc5iqkIDQuxwJKVdbGA1BVTJd2e4J9zJVAuz2rcPYJgDVEwa6lD1PTNZ9IRA7tDYNDpB/DzfH//Boqf4DYbE3ECTt7dsq9R2mWYv487A/awks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=iuC0GeLy; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=We9t5eLP; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="iuC0GeLy";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="We9t5eLP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=wLz1t+M2zyGmndVGhYzBEHPnghniB/gB2lYy3mo53oE=;
 b=iuC0GeLyRkggZn1xuTaA7pB8f+/0vTsjdNhUZSCtVSo5rYgG6qVuhvuFRvO7Zf5yCjHcvBDw0a3cnV/fjoT80hy+7AwQapO/hBphVFAgNEB22BhqYXzCzGtw5JUqcVWOCUTXEUzWeCM/OR2kxiYEnaG0dGSP8jSI/MNA+rzvthEhwrN9NIcYlm3BbHI7D9cSOnhuQ1jFfWdSss9KxmlBMZV0tpc+tbnI7y71SFG3xZ00m/hc36Fbv1z/ok6xQ5Xqrue4EC+O79Rc8UltIu549oxfGybRUFL+RqRNHr4cIwruUzmJaElshbN0sGUsLjvSbjYmvZpoQpgNtwYfSZM20w==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020073.outbound.protection.outlook.com [40.93.198.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4D8D4340076;
	Fri, 16 Oct 2026 00:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWXSUkK29JEOauHw4XSNEWJ8PRSVdMyE6bBgf/yxziAb0J6I7cq9VbUBabfw2iO91Y9pr0jE2nbputbj0fUA9zTIo5eju3iP4xdw2P+RUcIHJ6LeM9gNKG44v5Z83H7cUyCwgx9Qb8FIXXXqSfXsxXM5M6Vr+AmtMfCdPZSjHwbXkFzWOgRonAUTZcrUbGTeTG82lb3LSV1Vgo8RhTcW1d7gvT4a31fREsCMhoFuG2mIYm0H8zUxT8skqIHdRefJeLqLWVvBwG006nApm3ut5UP3ehMOSS52SInSGqJ5sVbuqFJ9CH2FW0PfwZDzOWSwzDpGga3FmtLfJaMts+Ywmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLz1t+M2zyGmndVGhYzBEHPnghniB/gB2lYy3mo53oE=;
 b=ZOwA6i/InI/53hvh7FFUQYXXfp/Eub1MHph/KeB2nW/jXJZsIDYy4kwVVxOOIcySGRM/OXrahp9Z9vdFgJB6z34W2XneUA9vL2r23TVEFllZkuRyPbrbn6Lw5dR3Repfu4l9Go8kV+zQK3sY8lWAzrl/x14Ay9aB1Wr/dkVuNLamVtZOHEjTkTSDQYh59t1FVnn79SMYx6QcCFG0TD7/+327sAL5rwKFef7MtptF7JXHEABN+8z3TCrL3qdT/1uJjBVAAgqFhDEE4uMHfkUp6LtwmM61ondrLIz3yj1dQJRnHo4cHBbz7qoKk++UZ++2t77IbjtgOzWQ+NcYMKiLzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLz1t+M2zyGmndVGhYzBEHPnghniB/gB2lYy3mo53oE=;
 b=We9t5eLPAOTQLULmAzzwhVhRAhHHm7DcYluwHO1gUy5P8NqpF9TRHQLDZxNXf+KqF+EZds3msUr21LsTcRlDEpcsCuvYT3oWM2jcsGeYpbfP1ERglgiiR4GeSmt+51D1F9Jgbbcd1Yus6oshaMG+fkzSpKHWmR0U99XJB0dyjyI5bsHUM9lsrUctUasQVWy8mBaeetbwYcC0IArMBqy7+gRNwwEswGJAuSjermL/TKZKJM+cy6gVnDiT+t8ySrl2qhTBzFbO2ZYrPiIU42p4M8p86SRxY1CAHXE2/Rg07Uy7YPWGIz4vROKl0HxQvnhdtNhGlj3Vaq3TsPVFN0hwsA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MN0PR20MB4789.namprd20.prod.outlook.com
 (2603:10b6:208:3c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 00:55:06 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 00:55:06 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "robh@kernel.org" <robh@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lad
 Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v13 02/12] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Thread-Topic: [PATCH net-next v13 02/12] dt-bindings: dpll: add SiTime
 SiT95316 clock generator
Thread-Index: AQHdW2P/9ZE6kK9KDUy1mF8AMssy67b99J2AgAFmkYA=
Date: Fri, 16 Oct 2026 00:55:06 +0000
Message-ID: <20261016005505.10602-1-arouhi@sitime.com>
References: <20261013224131.27149-1-arouhi@sitime.com>
 <20261013224131.27149-3-arouhi@sitime.com>
 <20261015033143.GA485921-robh@kernel.org>
In-Reply-To: <20261015033143.GA485921-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MN0PR20MB4789:EE_
x-ms-office365-filtering-correlation-id: b0f07d4c-ab4a-4c18-8a2d-08df2b201eb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|261009223327099003|56012099006|261009223027099003|261009221727099003|4143699003|261009220027099003|261009221227099003|18002099003|10067099003|22082099003;
x-microsoft-antispam-message-info:
 WXfE3Z14sYwmoJZPBaFBUYfzLNle02BhJDMAcXql1sFk7kuq5V0jSbyQ8eMYY7NgdFVav3hQg7l81X1u1jsy9DER7BPXdzbVjpnfvdLvsQ28dS2a+0M1jhxOwi0bu4utJWzGtXqD7jLuHTZIgCaMauYwQqEvDHzD1rC6FCfbE9k5ibUHVt2TiWBHjxNJQOMsYMsB4EmKmNW/GZK2EvcLryXF4Oc2TrAJn9G6rIJ+/yulhoHdtT/GqVXu/x5xJeJL6W7KuzSQbxcOi0Vm0m/+MdU19fxSITzD5vhwgzuE7ov7RfhyKF143h0jJf6qRtGveRHCNyNSKs9bfqYMQbI/GV/3YDNOOauRD56lvkG6LOM1dWZwegE1kwvHaJ1wbYEsv+wyB4hKhp14b4QwtRq4wOUaXgljgktFFJsAEX9k5Ftz/gr/LBL7IIcmXBPXtprTprEQB/d6O70Zx6bCibgJtiqASUM031QmVFkxheVGUhVXG3E2QI9IYIbqHTWk/gG6uQiWc9l1jnHTWuwsbMLUVa/G9tenJbtW5RmQeATzrnmv57gzBHzADuOZMpMWP4mQG0pXP+dBnL10G1HmL8Cia6DEy9n1Kt1e0EjNeQKTOuu+pJ1E7OAVnHE1TLb4lyzswR0GEumLODbnqD1YgYzmYAtdYQo0qG6bmroyWeap6PD1Fk62V1Gikgiid84OCCocpSKawGZpSeg44Jw7Mv7GVMYZmxuc0W97TQiMEqtn/xw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(261009223327099003)(56012099006)(261009223027099003)(261009221727099003)(4143699003)(261009220027099003)(261009221227099003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1NEQThuVndrMFBKQlhPNUlMd2hBRjVOdzBTNzFoVEgvd2QvZmFRV2JtKzUw?=
 =?utf-8?B?bThWWXJHczJCVGRzL0hzaDMxVG40Um9Va0FqZ045QSs0L0JLUGwxa0E3Umxy?=
 =?utf-8?B?blFRMVpHSkFNMEdNT09FN1IvTkRlRHlZTGN6KzI0UlRVbUhJWHlRNHJQOEZY?=
 =?utf-8?B?THRCWmZXYWF3ZmVDOHhvZmdUUHB6U2ZKVDVQRDVXZGp2NDNSL3NFZDMxbXlX?=
 =?utf-8?B?SWY5NUtlZmlLTld6VERyY1FmQ2JqVllmYXgvTCswckZ6REc3NlNDcmlQK0h5?=
 =?utf-8?B?cUwyd2FFS3YvSjF1MC9laWJ1K1JkcVNtSjlKcjlrYXgvcDhGLzNsM2pldER0?=
 =?utf-8?B?dnh2SktDMnoydFdCMDg1Y3JkS3YwS1dsUmNFQ0pHTERXWllXU0lMTFNWQm9Y?=
 =?utf-8?B?R3BlUzFtZkptUk04aHF6Z09pcTRmclJ4ZndvNXhWYzJqRDNRUDF3QzlORDZG?=
 =?utf-8?B?ZnRPanJhNVlBWDJlWFR3eHZlazMxWVdiUEwrVldjWjFzZkQxcmNyWUhHRytW?=
 =?utf-8?B?N1Z4YlFYSXdkRnNad21EZ01aVVVtVlBpdEl1RVNsRmVtWXU1RGhuc2gwVGRE?=
 =?utf-8?B?VjhJRityRjVMYXRGaFE5SzJPMmpMSHZ5bk05MlBXTnY0UzU2eWNvczh1aVJR?=
 =?utf-8?B?dU5EZmV4VS9PeUdsc1psd2NNYWJBenV4Vk1CRkZCbUpJYk00Rkc1bjcya0o2?=
 =?utf-8?B?Y0x3bEN1bjdWVzNNQ1Z5cWxoU0tQWWlJMlY5YzBGa25kbnN4bFh6cVJoWWNq?=
 =?utf-8?B?TW45QTdnY05VSXBIOHdaU2ozQ3ZzUlBCOGNLdGJMOTVrK0YrWUxYWUhkZjRL?=
 =?utf-8?B?LzRMYllCR201V0d6M0xDRzZlUXpINkc5Mms4YkI1VldBVkwzbDYwaGthZjVJ?=
 =?utf-8?B?bTN4Vy9TRXF6WTBGcGU5RFZuVWZqUW9CQlZHcS9CM1BZaG9ZZWJwREFIUDdQ?=
 =?utf-8?B?TmpTUzg1SnNxZmNMcDJVbEJPajRoaFBvZVp3RjRHMmRyYzJtTXNFRmZtL3Zz?=
 =?utf-8?B?SnpBQ0dqU2E5V1BNK0x4WUVlVkU0dlBRZythejRBWUQwY0h0eGxlRlRSYmha?=
 =?utf-8?B?RjUrRjVhNkNGUkM3WnVCR1FDa29NaTM1dk0vSTZ2bTBWazAyMXIzcTJTSkY1?=
 =?utf-8?B?Znd2Sk8ycjZERDJ2VjBEUkdHK3hMTlR4QnRsekR5YmNPalNpSWt5Q24yYnFE?=
 =?utf-8?B?NzZyM1hScm0zbGNOWnJSK2RkSW5UZHZXOVV5MVNPNVpmU3p3Y0ZZOUU0cUhi?=
 =?utf-8?B?SGZOejU4LzhlUTlvYktVY2drbGV3a255RlJqTXRPOGVsMDU3N0UydzYyL1ha?=
 =?utf-8?B?dXllOFU3cC9RYmhhOTdpNS9FYVRuMFZ4SVUrTU5nVERSUlQ2U2w1L0RQVlpY?=
 =?utf-8?B?azdwZUIrZXQwa3VRRWVMMTFzeDR5WlJ0ZG5wZzJWWjhYQ1Zka0RQbmxyR0I4?=
 =?utf-8?B?UEdxM1FQK3V4dEFMclg3OERIalNyNVF4RldFdVdpZVp6S3ZlVEd2bzBjTk44?=
 =?utf-8?B?MFREVms2SUtPa3NQN2R5RHlPdEYxUVVuN3RNa1AwcjdmSXFqeS9Xb1MreWpM?=
 =?utf-8?B?YkxiQnpFS3B6Q1JZRnRwUVN4cVdYWHR0MGdab2FzYkRBN015ancyNVYxdnB6?=
 =?utf-8?B?cHNXbmxId2hNVVYvSWV6QktKa29PTzFScHU0OThvQlgwTkxlSmtCYmxQbEJ4?=
 =?utf-8?B?TmlsZkUzZVFyU1o4UTRodlIyQkJJMkJ2SE9DczFqWW83ZFhXVHZoYkFwYXg5?=
 =?utf-8?B?bG5XemEwMzZ6dFFvWkRRUUNHY0JxV1o0RnA4VmNBQ2FrQ09DWWhXQnFzN0lt?=
 =?utf-8?B?a3QvTHB3MmU3aGgzc21TcDhQbkl4WjZmK2Z5TDRML2djbUY2cmYzK2ZYb2pI?=
 =?utf-8?B?eXlHcS9JOFhGR0ZlSDkwa3BHQWdNRGROWkM1M3ZlWkRTRDhBTkpKbzBTblBk?=
 =?utf-8?B?ZW9BQ0hLTHhwdzI3cmNCcVVDQWJaWWtOTG8rQnpIbVpIVmZTeGgzZVo2SUNL?=
 =?utf-8?B?bEN3WllHeG5ZQlR0RFN0dVJueGJ0a1lTMWpvOW56U3BpKzJ1YlRUQjJIdXJ6?=
 =?utf-8?B?RFZFL0h2TWoxc3VKTk5nQVpLVWhkR0d0MGVSK3ZpTTVpQmdFN21rYUFVZVhv?=
 =?utf-8?B?OXpiNG9hclV6N1pGZVYxc3BEVFRyQU1ETWNpU00wTUNMdytQclNZUm1mWUdY?=
 =?utf-8?B?MFRCVXd4a0RNZzVMTG1ycTMyWVd1TWcxUzBaTld5WlJqWWFCRndhNllZQzdO?=
 =?utf-8?B?NGRsOUZQeXV6RUZIVTVMUGhrTTlrcTdnVy9iUWJqU0dRWndMcTR4WllDVVpW?=
 =?utf-8?Q?jyIEN3tVjaEmSMVWH+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Z11L3Qf/ls4sKheHt4RfrtCnUkdzfJdJHsyZQ9iqLJTDh46pbg2pIOPuU7eyeHRFg6pwn3Q20DEMVjPIOHtiEdIz1V+gTvNrrwL7oJAVr6//AsLyGhkI2hCMrI6NGsw22rN+LzTGONHfkMMkfnp1aTKBg/gK72AchrncDr+5y/QXri5Z/4teZdkjOv8EX4bm2aupWAj6lgzeeJ1LfO4GwBiedbfGuZeafPC8unj9fFeukvZhHTKRAyZ97C/LxGqEOBRh+y3qdRP1JBtJAZ1Rcaqu1sISU8mLzDlA1iBluorZ0mZcK/MA8k9Xx2IWurTIYu5UQuzQSb16RaRaDeHrzQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f07d4c-ab4a-4c18-8a2d-08df2b201eb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 00:55:06.4171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTpNHeiGxYT71ECNRxUtDWn6Av0K9WEWLYFQrE+StG2JDBeLrKaUVRv7LqxvrIblhxW+iMOSZ1A3YZmvXEO6PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4789
X-MDID: 1792112111-M-oM1YFaemmI
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1792112111;M-oM1YFaemmI;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

T24gV2VkLCAxNCBPY3QgMjAyNiwgUm9iIEhlcnJpbmcgd3JvdGU6Cj4gPiArICAgICAgICAgICAg
ICAgICAgIHN1cHBvcnRlZC1mcmVxdWVuY2llcy1oeiA9IC9iaXRzLyA2NCA8MTAwMDAwMDA+Owo+
Cj4gLWh6IGlzIDMyLWJpdC4KCkZpeGVkIGluIHYxNDogdGhlIGV4YW1wbGVzIGdpdmUgdGhlIHJh
dGVzIGFzIDMyLWJpdCBjZWxscyBhbmQgdGhlCmRyaXZlciByZWFkcyB0aGUgcHJvcGVydHkgd2l0
aCB0aGUgdTMyIGhlbHBlcnMuICBFdmVyeSByYXRlIHRoZSBwYXJ0CmFjY2VwdHMgZml0cyBpbiAz
MiBiaXRzLgoKV2l0aCB0aGUgd2lkdGggcmlnaHQsIHRoZSBpbnB1dCBwaW5zJyBsaXN0IGFsc28g
dGFrZXMgdGhlIG1heEl0ZW1zOiAxCnRoYXQgaXRzIHNpbmdsZS1lbnRyeSBkZXNjcmlwdGlvbiBo
YWQgcHJvbWlzZWQsIHdoaWNoIHRoZSBTYXNoaWtvCnJldmlldyBhc2tlZCBmb3Igb24gdGhlIHNh
bWUgcGF0Y2guICBBdCA2NCBiaXRzIGVhY2ggcmF0ZSBkZWNvZGVkIGFzCnR3byBjZWxscyBhbmQg
dGhlIGNvbnN0cmFpbnQgZmFpbGVkIG9uIHRoZSBleGFtcGxlIGl0c2VsZi4KClNlcGFyYXRlIGZy
b20gdGhpcyBwYXRjaDogbWljcm9jaGlwLHpsMzA3MzEueWFtbCB3cml0ZXMgdGhlIHNhbWUKcHJv
cGVydHkgL2JpdHMvIDY0IGluIGl0cyBleGFtcGxlcyBhbmQgemwzMDczeCByZWFkcyBpdCB3aXRo
CmZ3bm9kZV9wcm9wZXJ0eV9yZWFkX3U2NF9hcnJheSgpLiAgZHBsbC1waW4ueWFtbCBnaXZlcyB0
aGUgcHJvcGVydHkgbm8KdHlwZSwgc28gdGhlIC1oeiBkZWZhdWx0IGFwcGxpZXMgdGhlcmUgYXMg
d2VsbCwgYW5kIHRob3NlIGV4YW1wbGVzCmVuY29kZSBlYWNoIHJhdGUgYXMgdHdvIGNlbGxzLgoK
cHctYm90OiBjcgo=
