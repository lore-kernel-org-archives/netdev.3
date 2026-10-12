Received: from outbound-ip173b.ess.barracuda.com (outbound-ip173b.ess.barracuda.com [209.222.82.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2054B66D3;
	Mon, 12 Oct 2026 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825776; cv=fail; b=sdAqCkUpd9UNJGM+vXlgy1aJIloc55SIXyRRIieir4m2f3MoKe0EZXAIj/l4Kz4KcQUbMmXMeCIBKbZHG5kpHgHBhI18kiAMsgvWYTgYLgNn5O/rV68nNbc7fTFdW6VWPh/KtDaZXmdWmUyTpk4/YqNnEB7gYHKvTNLDQqSccVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825776; c=relaxed/simple;
	bh=ZA2oHCjYW8A5OUT6hnTePaDKzwafyLpXPbKzr/qCFak=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F2u8mIeKf4hTIdcP6lytgn9jInAbciw6mSSEfmYSV+mrJm7/+jI6qwVoepW0xlaW4QEC+gOt8CDtpTw0Pb/gZILXZo10QKc+W8VkE+2j9CYiMHbNXjkLSTygRWEMG1GO6aZ9s7+BM9bxnRmRh1XigpPmdUnScFgWLGlt9qx1vHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=Zv5lkPrQ; arc=fail smtp.client-ip=209.222.82.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="Zv5lkPrQ"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021103.outbound.protection.outlook.com [52.101.52.103]) by mx-outbound43-229.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 12 Oct 2026 17:22:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSRSPEO7aTzV1SDEKunon6xy6HhsBagN9Sg3mG+Hz1Gj5RG8zd7VNmWrQQ0DThIMurB6aR1be+IBdSmztFsC3A5Fbsk03S1af/SFEnfZPj/m54vaL0OKkhW9KefVQQC6Tn1rCEZDZlEn4GGYH0dCEiIR12eafcqFyDOtiIqLyJ3xxAxC4BPTPRZ1fPdbPhyy/FQsQwLSoX00axJsT3/IfSRwCQmlUN41mSBGk0VT/igFKYmavZkjmn6+AboJGrNJ0mVIPA/22lpyyaNPzcgaYxiOyPwT7eEwyvLFo4YHfWTfNu2dL0SQToPsLa3l4emocV6ZWYVHKrYSWa36yP/55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVdsIXROl0+mcizOQxhmtDK4sfWJW1u73xXveSoDzLI=;
 b=gPuIVlyqJKG6sk95FQqI8v0tuVNJCmuEDFEF4QB6XjXKX7EHbl8KpQyvQWEEcA/BocAjud64sVtXXaMIUJ1GRFhhY3uCIa0P5cQeCcAdFBS7I85ao+fAf9B/Aara24zRgWRnK329dbFpqW7mSFN51e0XZCFkDAbL6oMwF+w3Lf45t2AtK2WLKTctw3FplWsfw50q5PQKKkWNz2iiUDWR5gwWrTrOakCLzk7M9/czr1Wv6GOBhn3tZTW2iKahOcGKpWlAA5KXzctLnujLBgqni0Tmzy6lOuNaXBQXwl+4+KoZCPoLcH1m2D9VFENBvFItNvzWAhQgRX+daVAXXZx1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVdsIXROl0+mcizOQxhmtDK4sfWJW1u73xXveSoDzLI=;
 b=Zv5lkPrQ4yqyB1aIcb/ON+hA/mMFY8SXM9+DyzucL9YJI3gs2WEua8wyDg+ljz4v7ehF9fSNMFWJ3SeZ28srgD24p2azgp0ZSMKazAZXyq7n5lg6YBidEBI0LBCaLZ148wAN4pcjkET433WUDTuJHfjHwciwHRBuqKBIZTG+632qB9CxD51M9cveImOkwVf6HmwkZ81FaRJP7PzN/Bpgrt3JPCflsfOuArw1DspzSYgDgyY2lAA8TzH5gXbQupH4HccAV99GkxkzWazrwcItFV9r4JCh2WLUulqKamJF+cBv1ymJNfi+gTkvG8mAiHucJ+DdEfRCMMhXAtKgR8u61g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by SJ0PR10MB5669.namprd10.prod.outlook.com
 (2603:10b6:a03:3ec::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.8; Mon, 12 Oct
 2026 17:22:25 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0522.006; Mon, 12 Oct 2026
 17:22:24 +0000
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
Subject: [PATCH net-next v9 0/2] net: wwan: support DTR/RTS on AT ports via MHI IP_CTRL
Date: Mon, 12 Oct 2026 11:22:17 -0600
Message-ID: <20261012172219.3668624-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::35) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|SJ0PR10MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc36ca6-8f6a-40f2-113c-08df288561c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|6133799003|10067099003|18002099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6fg7f6SPVz726MluAkc2yrsxyBHJqVK8WG84s0bq8AqixBBr9axmW2NXEo/QeoXr0bpH0n8FqhAjcA5xW+Br4Cbr3D+2wtwArGV/DRrbNahyVaquImCDW+sKDDgTFN7IkjgTbG1hcmpa62fgIiK/uu6qKeZjRkuMHKaQmULrZMNP5UzaIq6C5D8juFA3pOWWM9F75Hy8ov8OoZeYLxuXa5Eex5YhAK/5IES0ifsWDsj+Z0wC6NXbG2HG5RP+F/WGQorkdiKQiUrZ5JneNiuxCBBJpDASkxjWClgqSEQKH+N4aygtdSpN1o8wTTWxAJBjcxFPvtnB3Xy/UMtw3Nb3ppK6Kyev5Ylw+38JyIC3TKZ7EICOSWsoX/EfNycgWI5zm3/pI7X4dSvyY8Df69u3/EliHhpf2gIvQxw3GKA6bt68yZ2mEWeqi3+TXFKyET9jkdKjEqLJ+qLiuf0VGrdounl3rFvk00GTIieYoFjjDUNxFDSp03IFY7zWviOGg4YeIClwbsjW7aq6XwQK+k8vpI8HRRgY0MKkxw8gx2o7PWiVnz2qwFzjW2WwAzpTTDQqxAOzDar5ZZCYTY8Jr3w4fx1bM3cvB7SMMLLImGST8/lE7ApTP3yM3x38JD73JWgefuJAP5F05xlRnH6+kWys15QX2akqZZ+kOrPwP+qRd3U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(6133799003)(10067099003)(18002099003)(3023799007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6SteN13up2XYme29Ep9ye/ZSG/rBiD2ZLdr9A2EW3VieH7w211TTNyTRb7CE?=
 =?us-ascii?Q?iyIN1IMGToj6PEL0+MS7vrs5V0SEuk+Z53RoHzkr0snqNHg6+5VH5/rcqeXQ?=
 =?us-ascii?Q?Us5SKpKJyMoP85vFPz91KrEmuPJxBo63kfx3Ao5rh/ezE9yhfdf4Rl045Lsi?=
 =?us-ascii?Q?P76a+5clweNscUY2R3tFfNGIkPqavvL8c9ycnPwrrQqo5lc97AJVs6WeHP9h?=
 =?us-ascii?Q?RmpzGMq21Dn5Yiv5whTOsKRe8BDUNiRCgxOF6EdHD5v4+aPXUE5o3Sr4FF/E?=
 =?us-ascii?Q?LndeAzwR6v0qFQotnc2y+xVxlQ1T9hmq6VwQTfR3HOExkOdfwj6IgwLINBkZ?=
 =?us-ascii?Q?d+mE4DoJcDsnjrYT7jWBKoXLFyovTgfaKP/nXC+1/hAxQxxKWxgKOIj78VJe?=
 =?us-ascii?Q?WvsyLEmiAq9syRAB3WD0kdFuDfxm553OUGqg9jDuKP7TSCVc949Hk5nb7g43?=
 =?us-ascii?Q?px8VpcF05QR17qBiZEc3RwatwNadO9IkGY8od/LRYHkEzGMu5HSYiJ7hFV3l?=
 =?us-ascii?Q?Xj8zAbcA3dhGuZFSoJq6xkglAZvT4fosYpLuVp1xrZfKh0cavjhns3zMUC4r?=
 =?us-ascii?Q?uXPDtZ5Z4ZNaNNALJSUOGjL66HoYKcNn1THMCpQ4FwGzTzLoNxwPL8NYRgwZ?=
 =?us-ascii?Q?c3nG6QSNTpdc1Knd9Mg9jbOlaRIgh8x1eQ2QiSXvJ2uGMH/9f1Wqwwx459c+?=
 =?us-ascii?Q?4kpqbPDA9xfsRniMaqNIz3fCAk1+hMNPQFiOGXCXANQBXefYamncAhZ+z9U0?=
 =?us-ascii?Q?JbN8n8aVjC0BayLv3LjCS3BwVKOVk09HtSO8tfoKwn7WjRKUHoQspsimJFlK?=
 =?us-ascii?Q?Z+D6hnt8PbsaTou6bduXuzV4lh7nBf+vG8278au9fkCcn305WwRS7Z6RQF7m?=
 =?us-ascii?Q?tPsjNXXNbLVet8b8JbL+jWDCF1GU98s1Il6d21X5xtOhaI0h7yYJxTjwxEuP?=
 =?us-ascii?Q?UYkib2ekRjTMMZcUGw0EgjsMVATNDxi/7qOsOgQySuAS89cQ9ruxBvwvL2G7?=
 =?us-ascii?Q?nu3L9W9sfVL52KP0D8s7oOePD46Xjw1UF7rARGLtedkeZBxqjpdUx+XxIhAL?=
 =?us-ascii?Q?GeIZH6n0w7+Z9UlYK+ulM5vUMbuntJYgxdC3tKPQ+3QsvckWIhXH65BHTmSZ?=
 =?us-ascii?Q?ZHAdtgUBLnGS5z9eDaJvvx6Ew3CPsCs5zpl4gEPRkSZtl5C48mg7dskETOpn?=
 =?us-ascii?Q?Q9dv/I6m+M7WBAP7WiEZz/XbsYqqy/OCGOMU3Ojk+Ow+jbOx9+/7/SCpf1MS?=
 =?us-ascii?Q?t1rpKS7QIsE3tGTGoVece1tmf/PJKHOwd0JuG0YJCYkt9ZOg7KWn4v3/gzXz?=
 =?us-ascii?Q?fu8+UHwhATcviRK82LIDtkN+9G0B8dWq6N97Z+nt/agsmOuuP3lVLyn4hHzW?=
 =?us-ascii?Q?+dBKLtoJ4pyxevnCCbCyyk8SHw+KWuho+Im570u3kljpza7fZlAOlCVLHoJY?=
 =?us-ascii?Q?+UsGlBLgBUzhxPgqiqvJcMdPRNWPs7G9PkEpoDkN+LghNlDNmEbvSyNRm9C2?=
 =?us-ascii?Q?Yl1nBkGbwdS0dbdBdVUuRHX69FMVOqAJuF2uSd1/SIJR9YZH9MgP0rNPA6C5?=
 =?us-ascii?Q?BDjf5Jkl6vvUe1lD4Dm2FBFRfez5Mi+uiB8EWHPzPIQL5L7JsLpAYJIxUbws?=
 =?us-ascii?Q?KPsuWY6PxlvLYv54ycrue2Gw6o6B1mfcgU5fHOOxWYqI7xbjJ0UXViVV5dSU?=
 =?us-ascii?Q?pBO0EbwKWxpOAAV1L0FBsW6rIvph6LIZ15EfYFPH6rDAkRtJ?=
X-Exchange-RoutingPolicyChecked:
	Y/VSsyXmy1XRwNJxqn6LupY8xxnoAZySvMM7ymbwW5xQaV11FxcBvLa0NW1B46d2ysAQDSU2XJZ/zV7mknl0B7Qt8iEWJWKhWbCscCngK2Tdir9XHN3F5xRwmiyUwBmBzdVw2ZkKGoHHWniRuIT+sVCAEh0bLwsLf6/IvzSPbF2F7zuPcqnJa8u40xH4SsMJCvrrUISK5IeNgJ3pZHgKGKittbQmmOEyPjeh7HGnQi48JOdmeCf2BW5/1UZ76Csu1QuoL/VqkZx+dHydrYDhTLe9hSEedbsj+6B87Nk45vI21ufMMY4boIJ40njTFMI1gYWq0vItm+YXLcN5r6edhA==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc36ca6-8f6a-40f2-113c-08df288561c6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 17:22:24.7233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/DljfPR5QYg389GGGrRn1vw7ZVNmkSZmeI+2uh20IdDl7Y0xcQoAZJBmy3Oz1xC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5669
X-BESS-ID: 1791825748-111237-9769-6683-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 52.101.52.103
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqZmloZAVgZQ0MQkKcUwxTTRwt
	DQ2DLRxMzCKM3E2CjN2Cw11cTMOMVCqTYWAN7h901BAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276792 [from 
	cloudscan20-1.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA085b
X-BESS-BRTS-Status:1

Qualcomm/Sierra SDX55/SDX65 modems (e.g. EM9291) withhold unsolicited AT
result codes until the host asserts DTR. The in-tree mhi_wwan_ctrl driver
exposes AT ports but never signals DTR, so URCs never reach userspace.

Patch 1 extends the wwan core with an optional ->dtr_rts(port, mdmbits)
port op. The TIOCM bitmask state is tracked in the wwan core, which raises
DTR/RTS on first open of an AT port whose driver implements ->dtr_rts,
drops them on last close (if HUPCL is set, which is the default for AT
ports) and on port removal, and passes the resolved bitmask to the
driver on TIOCMSET/TIOCMBIC/TIOCMBIS.

Patch 2 adds a second mhi_driver to mhi_wwan_ctrl that binds the IP_CTRL
channel and implements ->dtr_rts by sending the host serial state to the
modem over that channel. The existing AT/QMI/MBIM data path is untouched.

This is a two-patch series. The pci_generic patch from v5 that
enumerates the IP_CTRL channel for the Sierra EM919x/EM929x has been
applied to mhi-next by Mani as commit 83c29a55b89e ("bus: mhi: host:
pci_generic: Add IP_CTRL channel for Sierra EM919x/EM929x"). There is no
build dependency between the two, without that commit the IP_CTRL driver
simply never binds and ->dtr_rts is a no-op.

Note on the ->dtr_rts signature (Loic):

In v3 I replaced ->tiocmget/->tiocmset with ->dtr_rts(port, bool on)
modelled on tty_port_operations, and moved the TIOCM handling into the
wwan core, as you suggested on v2. Review of v3 and v4 then pointed out
that a single bool cannot represent the two lines independently. With
TIOCMBIC/TIOCMBIS on one line while the other is in the opposite state,
the line state sent to the modem no longer matches what TIOCMGET reports
(e.g. RTS re-asserted after TIOCMBIC(TIOCM_RTS)).

Since v5 the op keeps the dtr_rts name and the core still owns all TIOCM
handling, but it is passed the resolved TIOCM bitmask instead of a bool,
so the driver can drive DTR and RTS independently. I kept the dtr_rts
name deliberately, following your v2 preference over ->tiocmset, even
though the signature now differs from tty_port_operations.dtr_rts. The
open/close paths still behave as tty_port dtr_rts does. Is this
acceptable to you, or would you prefer a different shape, for example a
bool ->dtr_rts for open/close plus a separate op for the ioctl path?

Changes in v9:
- Patch 1: drop data_lock, so the termios/TIOCM state and ->dtr_rts
  calls are all serialised by ops_lock, which the AT/QCDM ioctl handler
  now takes interruptibly (Loic Poulain)
- Patch 1: raise DTR/RTS inside the existing first-open branch of
  wwan_port_op_start() (Loic Poulain)
- Patch 1: mask TIOCMSET/TIOCMBIS/TIOCMBIC to the output bits, only call
  ->dtr_rts when DTR or RTS changes, and commit TCSETS/TCSETS2 only on a
  successful copy (Sashiko review of v7)
- Patch 2: requeue the IP_CTRL DL sink buffer only from the refill work,
  and disable it with disable_delayed_work_sync() before
  mhi_unprepare_from_transfer() in remove() (Loic Poulain, Sashiko
  review of v7 and v8)
- Patch 2: leave unpreparing to mhi_probe() when probe fails, and name
  the wwan core commit in the commit message (Sashiko review of v7)
- DTR/RTS stays limited to AT ports, as agreed with Loic and Daniele,
  and the ->dtr_rts kernel-doc now says why

Changes in v8 (Loic Poulain's review of v7, no functional change):
- Patch 1: add wwan_port_raise_dtr_rts() as the counterpart of
  wwan_port_drop_dtr_rts() and move the open-path handling into it
- Patch 1: do the AT port and ->dtr_rts checks inside both helpers
- Patch 1: use scoped_guard() for data_lock in the helpers

Changes in v7 (all from the Sashiko review of v6):
- Patch 1: drop DTR/RTS on last close only if HUPCL is set, as a TTY
  does, and default HUPCL on for AT ports so close behaviour is
  unchanged unless userspace clears it with TCSETS
- Patch 1: wwan_remove_port() passes the masked mdmbits rather than 0,
  via a helper shared with the close path
- Patch 2: retry a failed DL sink buffer requeue from a delayed work
  item on -ENOMEM, and log other failures
- Patch 2: note in the commit message that the IP_CTRL channel entry
  for the EM919x/EM929x is 83c29a55b89e in the MHI tree

Changes in v6:
- Rebased onto net-next, dropped the pci_generic patch (now in mhi-next)
- Patch 1: snapshot mdmbits under data_lock before calling ->dtr_rts from
  the open/close paths
- Patch 2: allocate the IP_CTRL DL sink buffer separately instead of
  embedding it in struct mhi_wwan_dtr (DMA safety on non-coherent
  platforms), and do not requeue it when the DL transfer completes with an
  error such as -ENOTCONN during channel teardown

v8: https://lore.kernel.org/netdev/20261007182238.1154851-1-peter.hunt@opengear.com/
v7: https://lore.kernel.org/netdev/20261006040422.3208888-1-peter.hunt@opengear.com/
v6: https://lore.kernel.org/netdev/20261001204614.3481089-1-peter.hunt@opengear.com/
v5: https://lore.kernel.org/netdev/20260819224927.2274790-1-peter.hunt@opengear.com/
v4: https://lore.kernel.org/netdev/20260816121705.858013-1-peter.hunt@opengear.com/
v3: https://lore.kernel.org/netdev/20260807215042.2714442-1-peter.hunt@opengear.com/
v2: https://lore.kernel.org/netdev/20260806155253.3378294-1-peter.hunt@opengear.com/
v1: https://lore.kernel.org/netdev/20260804233411.1953445-1-peter.hunt@opengear.com/

Peter Hunt (2):
  net: wwan: core: propagate modem control signals to port drivers
  net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel

 drivers/net/wwan/mhi_wwan_ctrl.c | 233 ++++++++++++++++++++++++++++++-
 drivers/net/wwan/wwan_core.c     |  96 ++++++++++---
 include/linux/wwan.h             |   8 ++
 3 files changed, 319 insertions(+), 18 deletions(-)

-- 
2.43.0

