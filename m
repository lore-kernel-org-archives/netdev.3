Received: from outbound-ip199b.ess.barracuda.com (outbound-ip199b.ess.barracuda.com [209.222.82.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B2949BD7B;
	Tue, 13 Oct 2026 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916408; cv=fail; b=t3/pzdGvn5poIMEM48w6a20iaDV/8DtgGuuQFnVCH/4ZdwBoOGWBDie7W4PwAkczr+TIz2DQdLFKq50biz2tbkL8M3XGmpv6tn7JfwOr9R1dJFvfxRDyFwzzlpjwpouoiThS+oH+9wwoONvTsiyYYmr290fodHGp6+tIKb27LKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916408; c=relaxed/simple;
	bh=FRdKXi6TLM6xVhQlK26YsYwiNg3I+DGUWX4VvO4QfrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n8wKnBEP8hqCNQ6rmd7IHajXIclKzfxK7L+2DsA9h1nbYk7668mi/nxFh/PCFyAmGZDmTqL5c/bIaxGxrW7P+BfMncYYJF1Q7PxSDxVk7IGVZvWQ06C0M6Bvzb0M82KArJBra3kDdL4Em7/VloLUACmcsXlTHsoVnf4EaIviOhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=Ho6k6yVL; arc=fail smtp.client-ip=209.222.82.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="Ho6k6yVL"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022123.outbound.protection.outlook.com [52.101.48.123]) by mx-outbound22-112.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 13 Oct 2026 18:32:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvZt0LCi7yysQasGHu7Da2VYDmVaK0V95Poujfm/qT509zY4htDl+zgwWvwaxgKchZYtDR4EP/HSeu3KGW0S74B+wptixLR9ISclPK8cs5QaXGnlvUCmYT0a71GLCoKXK19ucPO6NmrXKESdKHqpeWt33cAD6CqodPLbkT2d7Etn5Wy+Mw7LJK0lnz3i0TXBsuqGxvBKxc622kXhlJtd5nCkV2VzzzISVLamaJNvJnBJAx7EXCHg3sTtWi4xAcCcjTmQhcHEKXS7Hpb35mp7QkkuWRy+x9w0VADBjTFYOZbkEECCkXYHlIg5TaEvW9OeZ4ACKKhVVsyIvsGErfsTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRdKXi6TLM6xVhQlK26YsYwiNg3I+DGUWX4VvO4QfrU=;
 b=N9HsecvtM4cEgAQ+5BaDnKarKa5ZjeUzg0iB6n0lgwx7r6HSRpfPiCyx0fx6f7lRaIvMVwsN2iOOf9+hLfKVD7BidJe4v9rEM7QTrD50RzuyvEf/Y/kxfpGfKUIU+A+TUdN7wllUNCV2uetEWhFPT5XsWArvsP8hv9TxZDeHb+RcHcawsaw1GyeW9mbfHktPeMiXFP0OjFk8fIheSFUr1TKLqWxZzVi936lzZ2WEXl1/Z+j+RSWQzorYJ2aFSvBXjJh72Ekdqf1iue57RFeIjEQ/wS7Bg/hP4oK8Q7G4GdCKzd1V2eDuiZ4H8bjhOS0P2rdf88NepfG9TT0jxthrEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRdKXi6TLM6xVhQlK26YsYwiNg3I+DGUWX4VvO4QfrU=;
 b=Ho6k6yVLIrGLKoxB1cjI/On8KgOu5ixYkLCf80EMejzR84hnodV1plzpeeTWpY7TgYpP1Mz7882byIzhWERNSTpP41+h2bSbory0JBBCfLnV1O83TstMQE/My9VNgy2BPlRksHUt3UT0Gt0daliGEQ6o5y/vARZuIVG7W2X92jdAq8H7RqigQp5F4tPSs8f++B+2JZHnkTn/tTnjo/jdEHtdvlH8xiVGkYOFriMesefcqI8idQS4Sqz6mIqe9KRUE4iorC23U0zjIcdxFJG9DcjWDbUUeGfd5S9/koBUwi/zrNCzECorTg3SKFhJdChbiVBXU0JrHVasc7UWfVuB4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by SA2PR10MB4521.namprd10.prod.outlook.com
 (2603:10b6:806:117::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 18:31:26 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0522.006; Tue, 13 Oct 2026
 18:31:26 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: netdev-bot+sashiko@kernel.org
Cc: loic.poulain@oss.qualcomm.com,
	Daniele Palmas <dnlplm@gmail.com>,
	ryazanov.s.a@gmail.com,
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Tue, 13 Oct 2026 12:31:24 -0600
Message-ID: <20261013183124.260511-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179191223098.434549.11899173102479904971@kernel.org>
References: <20261012172219.3668624-3-peter.hunt@opengear.com> <179191223098.434549.11899173102479904971@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:44c::19) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|SA2PR10MB4521:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2a736f-3d27-4473-02ae-08df295830ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	026OhwJfhueqiDFf3jS0vIhivuqrAnXs66Btr1k+2n20VdFaIXJb+QC61j5kLyjcDCiIpe2Aj8TltbyZKB+MEV4ZpQaO7A8JHuH76snC19t7cHFQwJnKzvjaWbhvKCLR4dBoJYgk1ELD0HCInSLpggF/kR6wFaX0MY9s1p5Pba70cpIk06A7C5xzaPeVZZhGQoZ3uZVqryP8tS9xfBqbJEVC83CtRmq2UxMLqY3JWdY/Y4B/vybqkAXzs2Zu3x5blXPSLew/UicH2hmFMnOBOcBDQzoko0mF0IOQra3qgIT47t+FV/6VEq+XyqXsqviw+doC74zM5yEzbUjQZRAhxjJD6elLsZsY72FEjF7TJnghah+0eepQlgLBJ9r+uHQAgwY7IByzGPMlZ2TAFuHnu7LV6ga79ZRqRYk2FhJQMz2Au3pKUom1twB8JlIGsSCBbprF6iDdRATSl1Whc+wQ+6LZtz9vPIM5I4sKWdYiS5I/LH2etXx4mZj77ZYKXKlPVm9RNJ2ljyUL5SafxhZIS+oC2KTEoFMesLpT+DekV93wIzrzr6Kxxssg6xcoS5ZFDPXMATcSjDz3NDAJmzSaMjbb1Hh01kxxh2x9zwb7dmK0PsnoAEnFzpYlBtRb3zpcquZRAyp4h+j7kjXEdWUpqQuCcguRpJUKSD+yoOfMSzM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DtRcJJ+1TGZihSmMkOq16gD5uZtcKPFVkECcW0sQc9gTCCdbJyuxRlUZbCEn?=
 =?us-ascii?Q?Y7+4NcqMnE/9T2RpbbKcmerL984sUQpvk+WlP/ZPM27c4KhJG9gXbRC3GKYi?=
 =?us-ascii?Q?ndPTjJLZ4/o0TfEMd7M3RVI0GbWnA5/M1ncJx1BB7RXCDjcMSlBPlhdamMiv?=
 =?us-ascii?Q?Q6bD5y1N61vsklw51Zy7CBJNF2redP6xSNCr/4l7fr0tiryKHBVpS8jPGtTy?=
 =?us-ascii?Q?/G9e1D0JcPEEZ1I1/oNwHTKvXl9xu6S0oUE3XdAsZzhxyZHte8IqZwy/6TY0?=
 =?us-ascii?Q?btOT+WnLsM/o+Weepg9WZQXLV3KQNs7h7gtLWLhCEIRVbfL8Axn/4fcs+01o?=
 =?us-ascii?Q?aS1jZ3mfNLJi626CTff+Sue0LX1iLotn5SWiDcmYmPwYoPpmjDUudyDOc4yd?=
 =?us-ascii?Q?UxDSn1dZ8hqLEVL6xJkzD91xfNa31zv1dNMpov1QBP6gXUEdcPWcimaX4xAK?=
 =?us-ascii?Q?9P8fjFCL/fZVt8G0hnWs/Pq8NfuvYo1qOkZL4PN61O9z4pBFJtjqzVlgiVRi?=
 =?us-ascii?Q?pgY64yuwk9yMxA/gq5/SRHntu3BmP+tmJIyl9wxWsp3M1oANCRZU9j6m8+fC?=
 =?us-ascii?Q?c2oZVplfj99YY5uPoeZe96kHKGT4MaqITBNsL8JAXfnJQ90AIeqHKJOdnW7m?=
 =?us-ascii?Q?xRFuXpO7adBA6GjU1aQWqj14yHrRObLfI4CW97qkdR1Ht/uPID3ixkuzbYeI?=
 =?us-ascii?Q?a6nPffIXClZWpYmJltoIGc0f1yfsWq+vMmZ2BiIjLQCKmamieyP1X5I84Hn+?=
 =?us-ascii?Q?lScgOM9Q9t1IKhYCn3FIXdcWE0qDJzyYr/aZr5OY0cEuXBa599J6CQ3bjNOF?=
 =?us-ascii?Q?02A2IaJMYnM3cGSUx4Imt8csbMGVx3dvJr0HycEKRs5uTP963bA3xlzhWqEK?=
 =?us-ascii?Q?vbgq538SqCdoa31g7Oe2WWVs5b8E5QxsQ6wuIMS6zltUwn20JIlm2CfGGAv9?=
 =?us-ascii?Q?okdjsL/30sykyy9BUXOgEdsEAgqVDye3SfAjVgBhcMHZLzX+Lu+9q9yd82XD?=
 =?us-ascii?Q?jbzIBzHs4Q4hK+8m2s65EkIPOjLZ7Dm9xtOYW9akjicoTJo1ilYc6fw4tcY4?=
 =?us-ascii?Q?HwiqW/M36axoKxIFx38kUbi49S8jAam9EsEKxdWVRkH0Wkjv90sNARTf/Kg6?=
 =?us-ascii?Q?XtPwAjbJZz3t5bCiNAx/1yCTgUI7+hRJhHx+qgPU1Rxay201QTj5/+V3wtSb?=
 =?us-ascii?Q?fvMnxnJZ5zdAhhsUvdnPqfWZx6U22n8tjY7fiK1gqWnlew+SHQY/s+9eNPm1?=
 =?us-ascii?Q?z8R+M04Mi+mJ8UmTEIHbHItMBHTmB/8sIppffqag0uokKvb/waLHf4d0c1si?=
 =?us-ascii?Q?tj4utG3P4M+cXS+AeA+2Q7tMVHxReTlxXfOh9IhCDwda+/jLu4iwyFa9wwWC?=
 =?us-ascii?Q?S97dLl+NZXFcbPGL4wOT6OGYbxxFBrFFB5p4T+lcfC56eeP2t9KgiSwW9Jxi?=
 =?us-ascii?Q?tC2LM4ex56huFopmp7/NzFHhH/moOF6azuVdKVXHLGhE33ylvCPoeSNj8jpC?=
 =?us-ascii?Q?uBPaBZ8f3xgl+y3aXpgebQMLa3iN2/RiZz/ODak05wAoM1XmnIGj6uJEoQ+h?=
 =?us-ascii?Q?UadesntHh8VkFyBN6dSyWNrzB4CHUQdcMIMC/Q05940Hd1rHKo1qSYDQyccQ?=
 =?us-ascii?Q?qjyvK8vol/2bOx7EX67KxzJB93oxFjczxilnBZL9X5GpFtIDLnviyKgPY36S?=
 =?us-ascii?Q?HAfnxQqkYho9Kv3Jo9bTfcI1ITPJcztzS+ey3blYUY94yAxJ?=
X-Exchange-RoutingPolicyChecked:
	lDQBXKT0vc/pHFFum/KdcSbo4ju9Ol5PmmMowzuISqH++avz5n51kovq4tOpHEDXBX628+gk54dFVPAQ3rH5vG3F71BXujyWJXjfGUsaM86NdUmQlrvJTaTphvGDC7bQxuAhKi9ejclw97ZWDbZzlXTrmx1LO1PpftMEQEsGZ7cWEEbdiezSP8xwpQYIZnjxMo60/c5GNWosptfuUk3KzAKsVLXEcK2+lDFTl30N4voIpyN39uAXEodzir+CW8Ed6fLm62YWK4o3uPOp06hMxS5xDtEV3k7/awpZBHmf6bJW+BTgsqw/hngv85/mMpaWRd/R+DRMVU7v59TpoWl3ug==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2a736f-3d27-4473-02ae-08df295830ef
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:31:26.5693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjJC1TUYP5yA/5LGGRVKyS2KvbfnGpryXcsVB8fqk9rNTMKIakT2Irn6vZQ7eur6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4521
X-BESS-ID: 1791916375-105744-9082-2888-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 52.101.48.123
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhaGhkBGBlAs2dLcwMAoLTnRJM
	nMONXcwCLZPNk0OSXNMjUtNc3YwFipNhYARTsBMkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276817 [from 
	cloudscan21-211.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Thanks for the review.

[Medium] a failed DTR/RTS send is not retried: agreed, and stress
testing confirmed it. With the change-only filter added in v9, rapidly
toggling DTR/RTS filled the IP_CTRL UL ring and updates were dropped
with -EAGAIN, so the modem could be left with a stale state. In v10
->dtr_rts only records the requested state and schedules a per-port
work item that sends the latest state, so a burst is coalesced into one
message, and a send that fails with -EAGAIN or -ENOMEM is retried with
whatever state is latest by then. The modem therefore ends up with the
final state requested.

[Low] sysfs unbind/rebind of mhi_wwan_dtr while an AT port is open:
agreed it's a root-only corner case. Reopening the port, or changing
DTR or RTS, sends the state again, so I've left it as is.

pw-bot: cr
