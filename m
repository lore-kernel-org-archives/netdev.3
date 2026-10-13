Received: from outbound-ip199b.ess.barracuda.com (outbound-ip199b.ess.barracuda.com [209.222.82.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A649E15D;
	Tue, 13 Oct 2026 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916580; cv=fail; b=CZcc70F7jYbL8TZPlQ2ucfP25m9Df1D2GHX3n2HMYbJYcCU65e6PS6HMKd6031lhwMYz43XED45m0Bc+AutgQrWqnfhjtBz9h2iw3UOxmvebnumTfRKgrntlogWvlQnodOIa7TkS2fzaZ5PClP5+QrKpQtXshqauFcHQqQW4WGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916580; c=relaxed/simple;
	bh=hTtzlWWwO+I3CGoMGEBC2X038INjDTGyxnXLofOwLM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QiWS9oSfj0y36rPDtiZQ53iVuK8n3ysq00EEJqjBUA2aXOprEIPENHqrHnzjlazSmbGBboybroDbh3m/nSGkZze+1VnOLST2/xebsovljmbpjEL6V4Zut8N2+/ijJ8SdfKbhM2c5Ub0KJVapvK3TET2LVWXo0q7FzdI1cMLgEdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=Mlia2Bo4; arc=fail smtp.client-ip=209.222.82.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="Mlia2Bo4"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023127.outbound.protection.outlook.com [40.93.201.127]) by mx-outbound44-35.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 13 Oct 2026 18:35:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THUeJxOi7dneG6B4/LUGna5dcC29JgwF+jDVscgpbsi8OGJRVtmcqJWJwihLg5t9PaP13VwBBfHbMasqWU+bTMtqtd4Ce09XFTzgiT2cjSK45s1U3xXrFXNE9fEMmPTHHzcT0XuMJJYI9jDw0FUFXCj81Bu2eueD89+W/jHFiPVdzQ6GwzQrx0+qJEhQTwzeQ/8/qnSiTu3ldY7kTTu05VJo1jB1pkyyjGH5wb1yoG2Z7fh0njReWgVZIqgudwwra83MRUoRr1SKatG9oeRuKjhO0DAfyEo89qNhb9crLjra7zh8Cz9NiF9E5ELc4i7V0oy8rZFRkEPaLFs8u7wTZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtaoWoDeVtNQEVL+dLiBWIlxl2xGB8XVfWFjdjds/VU=;
 b=wjHDHhwGGFoaEyRM0nl2nVo9Id8hATtqEpSoeC3abuAXfQU4lnNAYPdFfpq+6SkCMyYxkrnlwtyRu04/tVtfqZD/ndnuxMxoVEXW9E8ON+KfB28wD61qSkl1xj5qI562Ld5zVkR/rvMe1ux8NG5D85lseRt6KK9JNy6zo8QvuhC7A4H4HDu/l+kARd0IO/9vg2AvnxN/m49k7TP6MNOCmX8LZ1aK49z3Tu7qmeYvi2f9TD0VMNocbJVugzJukGu+cJ30MZOqQ+YTf1eqPABnoRhzHU556SKsANAwibNlDyq+HbGsTk4Lz+JkpYFGqkuH/KgzWpm0KDS7trHnr8ccvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtaoWoDeVtNQEVL+dLiBWIlxl2xGB8XVfWFjdjds/VU=;
 b=Mlia2Bo4kPmqADqAa/xH7DQov1g8pgRQ6gl6MkWqWThvnWjs3d0MgBrq+dE8XD6to6UVuiqcFaXqleS+oob2HWNqlYDBeh2KqTnrhGg3xTI1J0k+ZJVKfHoxzYUmxbeEiEgugdW2sQbZE9OV5pWqRvT0CE30imbBWU2efCqtuhq3w5xTboPKFShNHlvChWVjupS3uo2IfCEHaKFDtqyst/hXE8SlOPayBJsAHu0KO8cjL7gUliC0FNZom+w0xci+uaXqKNAKYWV0m5zmf7uZkxsgWIlANUTiR+MWvJvXAg4ZxDyOlxJ71zxS+Tlp3txmQTUrKAsga2kwcQY7wpY7NQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by MN0PR10MB5935.namprd10.prod.outlook.com
 (2603:10b6:208:3cd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.9; Tue, 13 Oct
 2026 18:35:08 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0522.006; Tue, 13 Oct 2026
 18:35:07 +0000
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
Subject: [PATCH net-next v10 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Tue, 13 Oct 2026 12:35:00 -0600
Message-ID: <20261013183500.261229-3-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013183500.261229-1-peter.hunt@opengear.com>
References: <20261013183500.261229-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::31) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|MN0PR10MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb28f07-6089-47e0-caf7-08df2958b4d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|6133799003|22082099003|18002099003|3023799007|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	wU3UY2aCpkw+FQxvyHBwPtniMO5Fgjlxhn5/B4zp2tHWtN15AeHIgdfBhTBfkKOIRyoaZyNb/eWcTXpRCE520qH6OaH6oowuK8EqxPmMqm/LGJdubURojV0sHG0AePoJ/OfhQHlJNqC1ytR498/oshdg07BYpvmM9WlTktK6kIlgNUClMUwFjY3Ga28qvPnxAzhdy6dHS0pJEuxXfa76C8hMepMEQHCm82LZsr5vfps8Zcrt96fCKy2urtc7xDhGg0/i0gcuHO4oOTn7n8gidLWhDps93900I08el9kNLvqfyGD+txvNlRRTeo6L6o8EzOHIm/Xq176yh7igEmzqir6Q+qlfEg2GNXM4p5KSmkAEKsPJ2ZSgOl9RNoZJuX9nkRO7TGFa4bX3+9bcoBnEpUQdufie4K4E7CrO7Bf75NXdAE6GjaHsKlE72NzFcPB5pf8oxLCdPC195bKrPyFbFP/rO8GciYbU7DhBmniZFQOVxpdZeOlaQnnpqzxlus4HoSy0rwIR4u64U2FjrdOpdNriwBH7KT1WMHruSTYmgMiEl4HpkxewY0eiwOrIgrD7FbExRrpy6fUmCz7ESJ6WVtOG/O/LWDQWExLBrVUOTqHhhZAKnRnN5sqrDQJI7a0I1+233lcVvEMiA1jlVRslVqHTYDU0BYB7YDCn1NUDT1Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?trSpM0SpEAhbzM4aV1x18pXAjsDpNzOg6/kaDHwLkkVVIOzkNfhCrqnQWC4V?=
 =?us-ascii?Q?x6eMIflneLL8phtIIAKbNp48gS79F/nTemUufSclAd6qK+VNmmI/AjMYJiS3?=
 =?us-ascii?Q?gpbRxCQm8EEoGFvq2MJDrCUco8BsfQnEPUKgAer1D5Z99wG1+9y9JP8y8Auy?=
 =?us-ascii?Q?6GZRzU11eQThb82s9Eab1+GZhOsBcZ3A/Sdu6Ne1eC6LbhID59ZshCEeObwE?=
 =?us-ascii?Q?jSJ0PoH3+UYY97rLiML03ct6LzjRdnkG7RbQHWzM/iXkdL0md2kASgYSt2V4?=
 =?us-ascii?Q?Xnl70Tu+oJpx9f5speRl4JnorVYNRz/mnaSHm29inYm+WSgkam6smgX06dwi?=
 =?us-ascii?Q?cJq3hqhLLCaxIqVcYUf6Os19PYluuLdLFN1LnadlpiX34I2AXlj56C0FSf0N?=
 =?us-ascii?Q?FSuyHajlHxg5yy8/Bh7eV4aoa4g8PvjXLgaSizwdY5JvRchUn3yRwnAYRtiZ?=
 =?us-ascii?Q?ikV0bXUD1oX5cYuXjPUFiHsKVrZrXshqJ1h8Zydc6oRop/RXXAjmSwYrJAgR?=
 =?us-ascii?Q?WRQMxEV/Isk4IEkJ5rhAtRNtvYeoPGAcpyprFPI8i6lbJGFPje1JYLxgSu9a?=
 =?us-ascii?Q?cc/TRSBPX3mygeQeniDoFYcppm2e4ZVGcBTnAolfFMusvO+LlWwnpWnMdNAL?=
 =?us-ascii?Q?mtaNOOaohCOd0VblrQDv0rvvTFXyeid4Y7aPpTBme3X2adFGIme07N8k3i5v?=
 =?us-ascii?Q?Azri2nqdy9x46SjUBuC0pFpbuEmqOEa8QF7DpFnj4vk8hXvpY9NboKEQngyu?=
 =?us-ascii?Q?+mQz+9Sc2q6Pd5XDbHpvXlvirxEXv36l/ZI6hyrlHjW8oK6wbGxUfq99RxoP?=
 =?us-ascii?Q?KwsYFdDVIqk3xRQkkKEwjbx/LHdQ5XHeoNAzOG5wezD2OWjakrmnNhfJONsx?=
 =?us-ascii?Q?PpMVM6otfdFNyBmuO5yhRz3m7mTheBNVS9HpYuq5sFR3X8P7pvVujffSz8ts?=
 =?us-ascii?Q?Mn4wxfDq2LbcHMvbdvLbt3EmFRH0l24RTpZ8F3Qu6UOdgXHKnF6gRmA3P7HO?=
 =?us-ascii?Q?rHvCnWoYRuY97VT5gzPupraOSfN3sgjT0jJKt89JHXumGZduMYtfqUBnh+xm?=
 =?us-ascii?Q?gqvZ67A6jaxchRSHDvNjlRZb2zrdrerbCmh1NoMwyPMWEglcaDWJJM2NLM89?=
 =?us-ascii?Q?4dHRU2WRGx0SPcJ+qC+x/pbq6ae+NmplF+rNYA3UIEQ/0Jmcs2Axz9UnyAqY?=
 =?us-ascii?Q?04KFX4RqZPodWA2qGmnmSIVY+6bU6woKZPKIdqEm/OAPwmAIs26F9xbVdRZI?=
 =?us-ascii?Q?+PsksDnDVQZs2F9o47ysDjDFTWPavfEtNgwcwv9x3VaIEIh7mkLr+vp/DlvQ?=
 =?us-ascii?Q?oz7lKitvlh2RY8aIEFF+q1YPAhQ048DiHX/Yc9q7bAE6ZY5nc6dgsVit1N0w?=
 =?us-ascii?Q?E2XZVss6SQVUQ6nNJfX9qbvBdOby/BzTkRt9yIGjs7P321xkxz9/3t3uUVxq?=
 =?us-ascii?Q?pF48NKKTU1upXk4S9OZ11HieBA6yXUzUlXKdrfS/LvIPVepKpK+whb7s8XTh?=
 =?us-ascii?Q?Mo6tBTxMCADy/sah8ejxfdWsjG6ufkKOHcjP6xdwa4JGcRYOFDPz2dq7m1F9?=
 =?us-ascii?Q?X7DKtIfNDFsTz6mjRzXB21FbPOtrC8R3z+nd5rM7NYXFWaE+MVun+mkRPoQZ?=
 =?us-ascii?Q?om6mCU3XyJM/kxMy0ORzA5N60zf+g1B1GYqou1RmPOYSvoe50aAUS80QWvOf?=
 =?us-ascii?Q?xpfxVl3GRi0DhozC7LFTqiSKS5FjdmLMOPIni9ONcZ+3gJZr?=
X-Exchange-RoutingPolicyChecked:
	L8yomEQmaNSK+radhAFWJqz82q0WJdhw1LIrX6teuD3fN5NcGsXUQGpJYPM4Ul4WE5QF5LuF3d8Qlh9IbQ++LHI/cJ0esSfv6dvB8AX4TECs8llnE5tqZAwED+zJfuYr54DEJDiA6YTfNmO2Ad2iPnTc+ehRcy1hM6DGpyR1d0uLRt0ZU96AtvLeTNECzNCROW2Od5cLKoeBNu7G3SbDFhPUZkChMQPMjIdo1yXgmHebTuU7oRaH5C/Rc+76MLvNuUYy+hVkRogAr7DPyzhrQq+2rFzsR5otmTquRtuWADxLM8tILFVJ3X20Nj9nZNUs+CV+b59cI9FlvraMoW9giw==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb28f07-6089-47e0-caf7-08df2958b4d7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:35:07.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKpLPWr0AR0NFvuuGaMDP9jdL5qRmIsx7ZkmnIvBiEoLPLjQAhIaMSoT+qmajDiX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5935
X-BESS-ID: 1791916514-111299-27300-4073-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 40.93.201.127
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmhhaGQGYGUDTZwMAo2Sgx1d
	TU2DDVwMw81dDYKMXQ0CTNPDnF2DQlWak2FgDakoOJQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276817 [from 
	cloudscan13-238.us-east-2a.ess.aws.cudaops.com]
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

->dtr_rts is void, following the tty_port_operations model it is
modelled on. It records the requested state and schedules a per-port
work item that sends the latest state to the modem, so a burst of
changes is coalesced into one message and cannot fill the IP_CTRL UL
ring. If a send fails because the ring is full or memory is short, the
work retries shortly with whatever state is latest by then, so the modem
ends up with the final state that was requested. The DL sink buffer is
requeued from a work item, which retries a transient -ENOMEM so the DL
ring does not stay empty, and which remove() disables before tearing
down the channel.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
v10: Send DTR/RTS changes from a per-port work item that coalesces
    bursts and retries a send that fails with -EAGAIN (UL ring full) or
    -ENOMEM, so the modem always ends up with the final state. Testing
    v9 showed that rapid toggling could fill the IP_CTRL UL ring and
    drop updates (Sashiko review of v9). Loic's Reviewed-by is dropped
    as the send path changed
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
 drivers/net/wwan/mhi_wwan_ctrl.c | 262 ++++++++++++++++++++++++++++++-
 1 file changed, 261 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index a31d8540fbb8..e3c207588956 100644
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
@@ -35,6 +66,12 @@ struct mhi_wwan_dev {
 	 * decremented on data queueing and incremented on data release.
 	 */
 	unsigned int rx_budget;
+
+	/* Latest DTR/RTS state for the modem, sent from dtr_work so a burst of
+	 * changes is coalesced and only the final state has to get through
+	 */
+	unsigned int dtr_mdmbits;
+	struct delayed_work dtr_work;
 };
 
 /* Increment RX budget and schedule RX refill if necessary */
@@ -103,6 +140,80 @@ static void mhi_wwan_ctrl_refill_work(struct work_struct *work)
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
+	if (ret)
+		kfree(dtr_msg);
+
+	return ret;
+}
+
+/* Send the latest DTR/RTS state. A full UL ring or a failed allocation is
+ * retried shortly, with whatever state is latest by then, so the modem ends
+ * up with the final state. Other errors mean the channel is going away.
+ */
+static void mhi_wwan_ctrl_dtr_work(struct work_struct *work)
+{
+	struct mhi_wwan_dev *mhiwwan = container_of(to_delayed_work(work),
+						    struct mhi_wwan_dev, dtr_work);
+	int ret;
+
+	ret = mhi_wwan_ctrl_send_dtr(mhiwwan, READ_ONCE(mhiwwan->dtr_mdmbits));
+	if (ret == -EAGAIN || ret == -ENOMEM)
+		schedule_delayed_work(&mhiwwan->dtr_work, msecs_to_jiffies(10));
+	else if (ret)
+		dev_warn_ratelimited(&mhiwwan->mhi_dev->dev,
+				     "failed to send DTR/RTS state to modem: %d\n",
+				     ret);
+}
+
+static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, unsigned int mdmbits)
+{
+	struct mhi_wwan_dev *mhiwwan = wwan_port_get_drvdata(port);
+
+	WRITE_ONCE(mhiwwan->dtr_mdmbits, mdmbits);
+	schedule_delayed_work(&mhiwwan->dtr_work, 0);
+}
+
 static int mhi_wwan_ctrl_start(struct wwan_port *port)
 {
 	struct mhi_wwan_dev *mhiwwan = wwan_port_get_drvdata(port);
@@ -163,6 +274,7 @@ static const struct wwan_port_ops wwan_pops = {
 	.start = mhi_wwan_ctrl_start,
 	.stop = mhi_wwan_ctrl_stop,
 	.tx = mhi_wwan_ctrl_tx,
+	.dtr_rts = mhi_wwan_ctrl_dtr_rts,
 };
 
 static void mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
@@ -224,6 +336,7 @@ static int mhi_wwan_ctrl_probe(struct mhi_device *mhi_dev,
 	mhiwwan->mhi_dev = mhi_dev;
 	mhiwwan->mtu = MHI_WWAN_MAX_MTU;
 	INIT_WORK(&mhiwwan->rx_refill, mhi_wwan_ctrl_refill_work);
+	INIT_DELAYED_WORK(&mhiwwan->dtr_work, mhi_wwan_ctrl_dtr_work);
 	spin_lock_init(&mhiwwan->tx_lock);
 	spin_lock_init(&mhiwwan->rx_lock);
 
@@ -252,9 +365,118 @@ static void mhi_wwan_ctrl_remove(struct mhi_device *mhi_dev)
 	struct mhi_wwan_dev *mhiwwan = dev_get_drvdata(&mhi_dev->dev);
 
 	wwan_remove_port(mhiwwan->wwan_port);
+	/* Give the DTR/RTS drop from removal one attempt, then stop the work */
+	flush_delayed_work(&mhiwwan->dtr_work);
+	disable_delayed_work_sync(&mhiwwan->dtr_work);
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
@@ -278,7 +500,45 @@ static struct mhi_driver mhi_wwan_ctrl_driver = {
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

