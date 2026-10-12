Received: from outbound-ip173b.ess.barracuda.com (outbound-ip173b.ess.barracuda.com [209.222.82.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A24BCADC;
	Mon, 12 Oct 2026 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825801; cv=fail; b=pWxJizpns79g/sS0mR431HeYhonxiZjnBJ5BeirGq0pA7dGynCZdYDx4MaGWNlgm9YVZbBioSehPkYv8Dt5cSyfiD6dpCoC7+qBWkDPfK9ZkHAozDAQqpIKRTn6ZBaSIvxMJLqOYpnhaqS6nTMmzzwhRUtpGM+dJIqRz13geZLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825801; c=relaxed/simple;
	bh=I5tzdx3C6AkQ6Mdom3Bdbe4CZf8jQ0uXavKFcMtm5ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bKqPYpZvkbQzf5f58dzfX15WI0Sger3cbXi3+bkaVcr9DaumwXI5bQDdBGks1cemna2OxYsreFzetiJVrxWE2dcOCrOT4i19442BJ1LOMSDzGmmzYNC8qqpPCQQTIOVDuFGRRdbtYTFZqklcojXyYGiQv2/UqDVqSsI/sfy5Xao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=K/I8ooVT; arc=fail smtp.client-ip=209.222.82.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="K/I8ooVT"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021103.outbound.protection.outlook.com [52.101.52.103]) by mx-outbound43-229.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 12 Oct 2026 17:23:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFxFEGvdXRBRpv/qSVSLfu6qHRh8lAqMw7gtPJvgj+TvGitRmxpBNz0WrenDotVutViT2rlGZfj8EqfN/emrN2Act57hxkR7c+OffxCBlZKHLc87rrR0ADfZohR9H8cfjQbWh/gDo0tRoOD7157gksTsoaPejrbQEns1XJbwf77/uJjtOW026WKZO8rcxgpyA7NWTFGjeFl8wyeSw8Py+mEk8X6kLrMyHEn1qReyXR2ZYl91jUpP3M2NyLaxrRZXa4Cb3alw5ihDNGy6NClthqVM7iUwUduo6V3ilKx+WLqXjMqh0ElQd2LGtPTGtgQuipgvuWKJNRh6uvxsOZJJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibaVdB3ZahbpFvZLsDZvWH3PYjcZ02ik/t03kfOLdu8=;
 b=kyVwf7Yyv0snfdEHqw7vuwyxlxbC/kUOUoHv4+zocn5p64GezLBWu0IzmW3/gUcd0DcLuvfA2Ln/Pm6cic1I4HSOSyWRGNkawkQjxIOrbU49BGAr9gp1wpRSXIs/jJmkG1EjN+ndmpvTd+0OH20PBiKUVRKRqmzqgBvdOenBI7Bt+UBRa+0K/0avx5SFxSDr8xfnq9ZzqTFvO9RiLjTsGhunpLRotFtLmGpxrVNO+/X8XzDQiHwFudkea0MU8Zs0tnrYrjEkG9ScorIjGcZ0e8/KX+I2rDFKjFW87Q0QIuYS4NcGNf6x6+RimRN14NFDMov4qRY6++dYoWeMiwSgtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibaVdB3ZahbpFvZLsDZvWH3PYjcZ02ik/t03kfOLdu8=;
 b=K/I8ooVThLqVO8QlThTYPeI7Fh8WBBzOdcq1oKYmvSKvBdpqP67nCOKP1C1SrzNTFbSejPElXRPurdkklLZmFZBgIfnVxDPUMPshzeb70WuFwbAaJXq0eQ//pzqZ2jzaf915hofl4tbTcgQ9rHRQi/8DTYGoflOamg8w2NHf12+4Kz/6r9FPWL8nDvrEx1jEW6pho9j2jUtyWKI9ekMzEPogijSHblNDikLgnoZu+CxU+ZHpec7J6Eh6C3bmncITOGmw/90RTTti+tMdZpxQDUhMiPuTbmgWeZZ3F4ABlTh2GFwpV+jVHL+9ZIpHcszhJqeaqyuMP66FRhbLjtY2wg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by SJ0PR10MB5669.namprd10.prod.outlook.com
 (2603:10b6:a03:3ec::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.8; Mon, 12 Oct
 2026 17:22:28 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0522.006; Mon, 12 Oct 2026
 17:22:28 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com
Cc: Daniele Palmas <dnlplm@gmail.com>,
	johannes@sipsolutions.net,
	mani@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next v9 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Mon, 12 Oct 2026 11:22:19 -0600
Message-ID: <20261012172219.3668624-3-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012172219.3668624-1-peter.hunt@opengear.com>
References: <20261012172219.3668624-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::34) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|SJ0PR10MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b9af28-ff09-414d-3524-08df288563c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|6133799003|10067099003|18002099003|22082099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	FwKt4OjlHCEnTpxHzcRzAqW43PH5OsG9M3FTYiWlpqK/15FM2CwXFwIGtiBJvnW6zt3jpmE7jAZXL4rNx6smhBVn5plAaGaIuvPfGoXXTdlgsMwa75zoTxi4XAgEkVFrfQ0aIIW2PJKX5N7zcMplxDV2qlZhD7SnPXsgTQLj+I4RtfMlGMX5dv0OopaPb6HAeYhptZ18SANNTNyrXFbtY2SOJFaZTSr/C2fWeQpt13HJUtz4O7nqqsZZ+FE+IhG9QlS4wzOut/aI5mbUSZ3MGph82U5iWR4KSz9PWPrp0uhrcLBLnUcLqzqQA0HjQ/4DuNyhL7yqN55OAt9J0uFNrI0Wmd7LeKz4BilapPTQ8rfTBGSh6kMILQFpV1v7FA+qBixFPMMIWCX3h7qKv4cG+j4t2V0kQ43b3Mi7zP8FZcUN8wroK9KYKIro3bOBoYFk8VvU0dyffXyppYQN1AWoYx5dpKUxQm9YkiaPhaf2snOWvILxmBXmb/sUvfKk4akkdbuc9jjsaSKyx5RI9gmjgoXnfSndBkiwIObpJYHSU/dauWjZRbPv1NBE/kxS2O3rvv1l2eWvAt8gDyIrng4WCPtOIDXHgZGyjianLb6y4y/ABj1BDaIFTKhrjKwMPkKlBL6f9yT0oXm34sOfFYihpejL7wGkBngIbNV7VMQujA4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vT89s4Wcn435VrfukQCqFnYbJNUkii/FeMFHHdHAC3hjqmNPv7pUsQEpVTi7?=
 =?us-ascii?Q?aP21YQ7xTwJbAyidGkYjqkCcBtf5ewe4ki3F2nvYaPUjG/YOqvIteLIErtNz?=
 =?us-ascii?Q?G7ADOhS5QEKmxPJQFS/fS1ubjWo7DAk5CIpdl7TLDKV53KttY7ud4QYnVWHz?=
 =?us-ascii?Q?D2WuXMwNq4oZoh1B8Q9Z5yOcQDbwT08fD5zKdFQ8C1pCgADWLjgxBLkvxIf+?=
 =?us-ascii?Q?sOlzqPWEm11a/QatP016hip/9YPf/EAvAQkJSBXbY68vVVuyHaVt4W1A+miw?=
 =?us-ascii?Q?cxhIxkzoDwcqMJkiR0eG0GdXEUCvgOyR0eznHoUkoGbdKX1NZ57+1Azc5hY8?=
 =?us-ascii?Q?9lXomKMf6ZZ3P2DCLHDdupzDg0ZoXnpemyyDjc4TYitbmCrPQoSPmf3e4HY8?=
 =?us-ascii?Q?AwhHckxqXaWRAytFycIODiX55EFvPpxxpqz850U8HEnm0SuMgWwoTyiKZa9v?=
 =?us-ascii?Q?ACOBmQx63amw4jhhKynZ+4BvRAeYrOF1CDHW+o22VkJTSA0JUM47Wd/bBpel?=
 =?us-ascii?Q?YNxwY8ujulCNNL/UCQYM/V6OoHsRE4QeEbxzhMzVQXJYIfhG++nM/z2QzrXV?=
 =?us-ascii?Q?/gptM5KE2cSDI3XGIUQr4VWeXXuTtZP6GCr8jFHijOe00u4P5KAzKIoMancL?=
 =?us-ascii?Q?85abBsT8ATOXbHBu5Cyf/WHAJ/1HhoN3JOzeowhku/jS3oJftvl4/82e08uy?=
 =?us-ascii?Q?F7YvWCEZzJvb0Io9lmw1jYeIk41LzuPjT3CsipUjTqKxBPSO45P+21hTtbQm?=
 =?us-ascii?Q?DmUuZLkLR+1hkS5YcnuRNdxA6AaLgwH7iWeadzF0a8SDDIQnahqKFsQLxjVF?=
 =?us-ascii?Q?f/pAFK4ZRYlTOLXMOFy8x8peVVsBN7LWTEUxjkymobv27gKaXiEOmnbWkbA6?=
 =?us-ascii?Q?8CCGzIxfZLx1MjGrPbzEnyc6vDSFO3yCHrIR3MTz2eql28YIf9OKtoFAbhvV?=
 =?us-ascii?Q?GMQDFT5fAtemUHK3VLGcQqpWgI2M6qp2DEr874qEpz90aDjv/UuPnnhGp+jT?=
 =?us-ascii?Q?OiGeEijVE+FPWkmVm5JeW1y9PGdIfZ4wDQ6kPBrbA6Iu3FcVaHjZ7yQilsyw?=
 =?us-ascii?Q?DXxQ1Dw78tXA1fOfQ1/ks8q01jO0hTSHlkqTnQq9HIZYTiGgxSxMxdtF2B8J?=
 =?us-ascii?Q?GjD/uryyJG2l14JPKbJuV28jLX1WTsaEDjiqHO0/6maoPAu1jjHh5cuFybHh?=
 =?us-ascii?Q?WAcrRGPOrpmkhCq+mUrevj/uA6JdSlHOosBejkH2faKA9Z/+F+N6fRUUwEag?=
 =?us-ascii?Q?RY+c73PUpRAKqHrloQs2Yi1A/pKTL17DtHjuioWSh/vXh5RqjcC3d6OBENqT?=
 =?us-ascii?Q?C/yp6y/gfNxSEYx2POeaiZkWMdDbf9KX92rOz/d34l1nNHXWpvPq2foVoa9f?=
 =?us-ascii?Q?qZzQ6EALK868TIg1dZG8FCV1cuydljTgvL1pglYRfKqPQhFWHAbEIvam+T9I?=
 =?us-ascii?Q?kkEz27vW27c2AKuEAF3Wd0F/auVwFvNS/Eu+gdyjKu4LMBMlwewBjSxjDlne?=
 =?us-ascii?Q?8XOg6hRfLjBdige3FUBNqiMUhOlLhJlbl9y12AhPXlzediHgtdtAfxdLsCu5?=
 =?us-ascii?Q?LoWn10WYNXuUZ03TrbkLpXV9+C9s5OvhQ1cNFz+N+jPm+3JKGXjT477Uv8ui?=
 =?us-ascii?Q?+cfH5XNEkZ2v053WNdHS7wOEgST1eRgoLbXZBnS0rRoDXPoDyhmzAvGjwswT?=
 =?us-ascii?Q?2OlO3Y7UbMic3CocpJxgxUw0lJweW0KuI8hi9tERodN2045K?=
X-Exchange-RoutingPolicyChecked:
	kY+DF2++twJmaDYiW3eIbsDYb4bFagUnQO93ZL3VcUboCXj+eD16aofmQ2MQN4H10bBSd2jI53CO/RCUeumNV40qgCtSHnK62l1YDKHM8XeYcqqAXbzsJbTXMqTi97hsdisvn6Tmxn9A9LxMevKj+yZ1jsVV6VjZY6q5AZtR4G983HdaVmLIGF4ZwC/l9ov0jYYMNQxdqqF8mLFmv3Y2Xx7obfqNb16PRHpt3dgel/5B0LwWH9I70V+o1W+SkjWtLplqmzFHYG+zi7uCJ5pmO2UhuT97yrqXkz/IS4bPGinfZjGUPIIky2M/hHweKThRrM50c3qU0Moyl9Yg+s5C/A==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b9af28-ff09-414d-3524-08df288563c0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 17:22:28.0839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JyDOoa1xW+S0iJsfnZY0EsPoWeKqoo4mkQAGQ47aDp0GSDNGzSh9xHjZTAhxPrB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5669
X-BESS-ID: 1791825748-111237-9769-6683-2
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 52.101.52.103
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGFqaWQGYGUNTc3MjYNDnFxM
	jc0MzEKCnRIMnYJMXUKDU1LSk5xTAxTak2FgBxMpuVQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276792 [from 
	cloudscan15-88.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Qualcomm/Sierra SDX55/SDX65 modems withhold unsolicited AT result codes
(URCs such as +CREG, and the +DMI OMA-DM/LwM2M session indications) on
an AT port until the host asserts DTR. mhi_wwan_ctrl exposed the AT
(DUN) ports but had no way to signal DTR, so URCs never reached
userspace.

Carry the host serial-control lines to the modem over the dedicated
IP_CTRL MHI channel, which this module now also binds. IP_CTRL uses a
separate mhi_driver with its own callbacks so the AT/QMI/MBIM data path
is untouched; the control-channel device for each MHI controller is
tracked in a small registry so an AT port drives the IP_CTRL channel of
its own modem (multiple modems are supported).

The IP_CTRL channel has to be declared in the controller's channel config
for this driver to bind. For the Sierra EM919x/EM929x this is done by
commit 83c29a55b89e ("bus: mhi: host: pci_generic: Add IP_CTRL channel
for Sierra EM919x/EM929x") in the MHI tree. On controllers that do not
declare IP_CTRL the driver does not bind and ->dtr_rts is a no-op.

The wwan core, with "net: wwan: core: propagate modem control signals to
port drivers", raises DTR/RTS on first open and drops them on last close
(if HUPCL is set) for any AT port whose driver implements ->dtr_rts, so
no open/close handling is needed here. The new ->dtr_rts op lets
userspace assert or de-assert them via TIOCMSET/TIOCMBIC/TIOCMBIS.
Received device->host serial state messages are silently discarded; a
single recycled sink buffer keeps the IP_CTRL DL ring live so the
modem's transmit path does not stall.

->dtr_rts is void, following the tty_port_operations model it is modelled
on. Delivery is best-effort: at_data.mdmbits always reflects the committed
userspace intent for TIOCMGET regardless of whether the IP_CTRL message was
queued, and the next ioctl or open/close cycle will resynchronise the modem
state. The DL sink buffer is requeued from a work item, which retries a
transient -ENOMEM so the DL ring does not stay empty, and which remove()
disables before tearing down the channel.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
v9: Requeue the DL sink buffer only from the refill work and disable it
    with disable_delayed_work_sync() before mhi_unprepare_from_transfer()
    in remove(), so no requeue can race with channel teardown (Loic
    Poulain, Sashiko review of v7). Leave unpreparing to mhi_probe() when
    probe fails. Name the wwan core commit instead of "patch 1"
v8: No changes
v7: Retry a failed DL sink buffer requeue from a delayed work item on
    -ENOMEM, and log other failures. Note the dependency on the IP_CTRL
    channel entry in pci_generic, now in the MHI tree. Both from the
    Sashiko review of v6
v6: Rebase onto net-next. Allocate the IP_CTRL DL sink buffer separately
    instead of embedding it in struct mhi_wwan_dtr, so DMA cache
    maintenance on non-coherent platforms cannot touch neighbouring fields.
    Do not requeue the sink buffer from the DL callback when the transfer
    completes with an error (e.g. -ENOTCONN during channel teardown)
v5: Implement ->dtr_rts(port, mdmbits) and drive DTR and RTS
    independently. Pre-queue an RX sink buffer in probe and requeue it in
    the DL callback so the IP_CTRL DL ring does not run empty and stall
    the modem's transmit path
v4: Add dev_dbg when IP_CTRL channel is not enumerated for this controller
    and when mhi_queue_buf fails, to aid diagnosis of the "URCs missing"
    case on controllers that do not declare IP_CTRL
v3: Remove is_at_port, implement ->dtr_rts instead of ->tiocmset,
    open/close DTR raise/drop handled by wwan core (Loic Poulain)
---
 drivers/net/wwan/mhi_wwan_ctrl.c | 233 ++++++++++++++++++++++++++++++-
 1 file changed, 232 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index a31d8540fbb8..1cbbfcb3b920 100644
--- a/drivers/net/wwan/mhi_wwan_ctrl.c
+++ b/drivers/net/wwan/mhi_wwan_ctrl.c
@@ -1,8 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2021, Linaro Ltd <loic.poulain@linaro.org> */
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/mhi.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/termios.h>
+#include <linux/workqueue.h>
 #include <linux/wwan.h>
 
 /* MHI wwan flags */
@@ -14,6 +19,32 @@ enum mhi_wwan_flags {
 
 #define MHI_WWAN_MAX_MTU	0x8000
 
+/* IP_CTRL channel message that sets the modem's DTR/RTS control lines */
+struct mhi_dtr_ctrl_msg {
+	__le32 preamble;
+	__le32 msg_id;
+	__le32 dest_id;
+	__le32 size;
+	__le32 msg;
+} __packed;
+
+#define MHI_DTR_CTRL_MAGIC	0x4C525443	/* 'CTRL' */
+#define MHI_DTR_MSG_DTR		BIT(0)
+#define MHI_DTR_MSG_RTS		BIT(1)
+#define MHI_DTR_HOST_STATE	0x10
+
+/* Per-controller IP_CTRL channel, used to signal DTR/RTS to that modem */
+struct mhi_wwan_dtr {
+	struct mhi_controller *cntrl;
+	struct mhi_device *mhi_dev;
+	struct list_head node;
+	struct mhi_dtr_ctrl_msg *rx_buf; /* DL sink, separate allocation for DMA safety */
+	struct delayed_work rx_refill; /* retries a failed sink buffer requeue */
+};
+
+static LIST_HEAD(mhi_wwan_dtr_list);
+static DEFINE_MUTEX(mhi_wwan_dtr_lock);
+
 struct mhi_wwan_dev {
 	/* Lower level is a mhi dev, upper level is a wwan port */
 	struct mhi_device *mhi_dev;
@@ -103,6 +134,61 @@ static void mhi_wwan_ctrl_refill_work(struct work_struct *work)
 	}
 }
 
+/* Signal the modem's DTR/RTS lines over its own controller's IP_CTRL channel */
+static int mhi_wwan_ctrl_send_dtr(struct mhi_wwan_dev *mhiwwan, unsigned int mdmbits)
+{
+	struct mhi_controller *cntrl = mhiwwan->mhi_dev->mhi_cntrl;
+	struct mhi_device *ctrl_dev = NULL;
+	struct mhi_dtr_ctrl_msg *dtr_msg;
+	struct mhi_wwan_dtr *dtr;
+	u32 msg = 0;
+	int ret;
+
+	guard(mutex)(&mhi_wwan_dtr_lock);
+
+	list_for_each_entry(dtr, &mhi_wwan_dtr_list, node) {
+		if (dtr->cntrl == cntrl) {
+			ctrl_dev = dtr->mhi_dev;
+			break;
+		}
+	}
+	if (!ctrl_dev) {
+		dev_dbg(&mhiwwan->mhi_dev->dev,
+			"IP_CTRL not enumerated; DTR/RTS not signalled to modem\n");
+		return 0;
+	}
+
+	dtr_msg = kzalloc_obj(*dtr_msg);
+	if (!dtr_msg)
+		return -ENOMEM;
+
+	if (mdmbits & TIOCM_DTR)
+		msg |= MHI_DTR_MSG_DTR;
+	if (mdmbits & TIOCM_RTS)
+		msg |= MHI_DTR_MSG_RTS;
+
+	dtr_msg->preamble = cpu_to_le32(MHI_DTR_CTRL_MAGIC);
+	dtr_msg->msg_id = cpu_to_le32(MHI_DTR_HOST_STATE);
+	dtr_msg->dest_id = cpu_to_le32(mhiwwan->mhi_dev->ul_chan_id);
+	dtr_msg->size = cpu_to_le32(sizeof(__le32));
+	dtr_msg->msg = cpu_to_le32(msg);
+
+	ret = mhi_queue_buf(ctrl_dev, DMA_TO_DEVICE, dtr_msg, sizeof(*dtr_msg),
+			    MHI_EOT);
+	if (ret) {
+		dev_dbg(&mhiwwan->mhi_dev->dev,
+			"failed to queue DTR/RTS signal: %d\n", ret);
+		kfree(dtr_msg);
+	}
+
+	return ret;
+}
+
+static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, unsigned int mdmbits)
+{
+	mhi_wwan_ctrl_send_dtr(wwan_port_get_drvdata(port), mdmbits);
+}
+
 static int mhi_wwan_ctrl_start(struct wwan_port *port)
 {
 	struct mhi_wwan_dev *mhiwwan = wwan_port_get_drvdata(port);
@@ -163,6 +249,7 @@ static const struct wwan_port_ops wwan_pops = {
 	.start = mhi_wwan_ctrl_start,
 	.stop = mhi_wwan_ctrl_stop,
 	.tx = mhi_wwan_ctrl_tx,
+	.dtr_rts = mhi_wwan_ctrl_dtr_rts,
 };
 
 static void mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
@@ -255,6 +342,112 @@ static void mhi_wwan_ctrl_remove(struct mhi_device *mhi_dev)
 	kfree(mhiwwan);
 }
 
+/* IP_CTRL channel driver, bound separately so the data-port path is untouched */
+static void mhi_wwan_dtr_ul_xfer_cb(struct mhi_device *mhi_dev,
+				    struct mhi_result *mhi_result)
+{
+	/* MHI core has done with the buffer, release it */
+	kfree(mhi_result->buf_addr);
+}
+
+/* Requeue the single DL sink buffer so the IP_CTRL DL ring never runs empty.
+ * This only runs from the work item, so remove() can stop it before the
+ * channel is torn down. A transient mapping failure is retried, other errors
+ * mean the channel is going away and the next probe queues a fresh buffer.
+ */
+static void mhi_wwan_dtr_refill_work(struct work_struct *work)
+{
+	struct mhi_wwan_dtr *dtr = container_of(to_delayed_work(work),
+						struct mhi_wwan_dtr, rx_refill);
+	int ret;
+
+	ret = mhi_queue_buf(dtr->mhi_dev, DMA_FROM_DEVICE, dtr->rx_buf,
+			    sizeof(*dtr->rx_buf), MHI_EOT);
+	if (ret == -ENOMEM) {
+		dev_warn_ratelimited(&dtr->mhi_dev->dev,
+				     "failed to requeue IP_CTRL RX buffer, retrying\n");
+		schedule_delayed_work(&dtr->rx_refill, msecs_to_jiffies(100));
+	} else if (ret) {
+		dev_dbg(&dtr->mhi_dev->dev,
+			"failed to requeue IP_CTRL RX buffer: %d\n", ret);
+	}
+}
+
+static void mhi_wwan_dtr_dl_xfer_cb(struct mhi_device *mhi_dev,
+				    struct mhi_result *mhi_result)
+{
+	struct mhi_wwan_dtr *dtr = dev_get_drvdata(&mhi_dev->dev);
+
+	/* Channel is being torn down (e.g. -ENOTCONN), do not requeue */
+	if (mhi_result->transaction_status &&
+	    mhi_result->transaction_status != -EOVERFLOW)
+		return;
+
+	/* Modem serial state not needed, requeue the sink buffer to keep DL ring live */
+	schedule_delayed_work(&dtr->rx_refill, 0);
+}
+
+static int mhi_wwan_dtr_probe(struct mhi_device *mhi_dev,
+			      const struct mhi_device_id *id)
+{
+	struct mhi_wwan_dtr *dtr;
+	int ret;
+
+	dtr = kzalloc_obj(*dtr);
+	if (!dtr)
+		return -ENOMEM;
+
+	dtr->rx_buf = kmalloc_obj(*dtr->rx_buf);
+	if (!dtr->rx_buf) {
+		ret = -ENOMEM;
+		goto err_free_dtr;
+	}
+	INIT_DELAYED_WORK(&dtr->rx_refill, mhi_wwan_dtr_refill_work);
+
+	ret = mhi_prepare_for_transfer(mhi_dev);
+	if (ret)
+		goto err_free_buf;
+
+	dtr->cntrl = mhi_dev->mhi_cntrl;
+	dtr->mhi_dev = mhi_dev;
+	dev_set_drvdata(&mhi_dev->dev, dtr);
+
+	/* On failure mhi_probe() unprepares the channels itself */
+	ret = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, dtr->rx_buf,
+			    sizeof(*dtr->rx_buf), MHI_EOT);
+	if (ret)
+		goto err_free_buf;
+
+	mutex_lock(&mhi_wwan_dtr_lock);
+	list_add(&dtr->node, &mhi_wwan_dtr_list);
+	mutex_unlock(&mhi_wwan_dtr_lock);
+
+	return 0;
+
+err_free_buf:
+	kfree(dtr->rx_buf);
+err_free_dtr:
+	kfree(dtr);
+	return ret;
+}
+
+static void mhi_wwan_dtr_remove(struct mhi_device *mhi_dev)
+{
+	struct mhi_wwan_dtr *dtr = dev_get_drvdata(&mhi_dev->dev);
+
+	mutex_lock(&mhi_wwan_dtr_lock);
+	list_del(&dtr->node);
+	mutex_unlock(&mhi_wwan_dtr_lock);
+
+	/* Stop the refill work, and stop a late DL callback re-arming it, before
+	 * the channel is torn down so no requeue can race with the teardown
+	 */
+	disable_delayed_work_sync(&dtr->rx_refill);
+	mhi_unprepare_from_transfer(mhi_dev);
+	kfree(dtr->rx_buf);
+	kfree(dtr);
+}
+
 static const struct mhi_device_id mhi_wwan_ctrl_match_table[] = {
 	{ .chan = "DUN", .driver_data = WWAN_PORT_AT },
 	{ .chan = "DUN2", .driver_data = WWAN_PORT_AT },
@@ -278,7 +471,45 @@ static struct mhi_driver mhi_wwan_ctrl_driver = {
 	},
 };
 
-module_mhi_driver(mhi_wwan_ctrl_driver);
+static const struct mhi_device_id mhi_wwan_dtr_match_table[] = {
+	{ .chan = "IP_CTRL" },
+	{},
+};
+MODULE_DEVICE_TABLE(mhi, mhi_wwan_dtr_match_table);
+
+static struct mhi_driver mhi_wwan_dtr_driver = {
+	.id_table = mhi_wwan_dtr_match_table,
+	.remove = mhi_wwan_dtr_remove,
+	.probe = mhi_wwan_dtr_probe,
+	.ul_xfer_cb = mhi_wwan_dtr_ul_xfer_cb,
+	.dl_xfer_cb = mhi_wwan_dtr_dl_xfer_cb,
+	.driver = {
+		.name = "mhi_wwan_dtr",
+	},
+};
+
+static int __init mhi_wwan_ctrl_init(void)
+{
+	int ret;
+
+	ret = mhi_driver_register(&mhi_wwan_dtr_driver);
+	if (ret)
+		return ret;
+
+	ret = mhi_driver_register(&mhi_wwan_ctrl_driver);
+	if (ret)
+		mhi_driver_unregister(&mhi_wwan_dtr_driver);
+
+	return ret;
+}
+module_init(mhi_wwan_ctrl_init);
+
+static void __exit mhi_wwan_ctrl_exit(void)
+{
+	mhi_driver_unregister(&mhi_wwan_ctrl_driver);
+	mhi_driver_unregister(&mhi_wwan_dtr_driver);
+}
+module_exit(mhi_wwan_ctrl_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MHI WWAN CTRL Driver");
-- 
2.43.0

