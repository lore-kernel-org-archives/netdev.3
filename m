Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021120.outbound.protection.outlook.com [40.93.194.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C1476076;
	Tue, 21 Jul 2026 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656408; cv=fail; b=E+7jYveSwgkjXPyC4xfoEJaKKU1qbHdQ8UxW44GGGASf265koWmNfbjDHwE4Td+4VY8ZH8QzOxjA6xruWF0jmO8iwc52eXMCADQUN/4xLZ6Kh1bbmoqC01DJd6lhlf2JvMOHc6fmJwg4XULh7u6yNNWvl2fPxRh3hSVt/Ua8KXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656408; c=relaxed/simple;
	bh=3Rx95PcRxqFuYKYZolWU4fN/i4OCNtb76ITqxckWmh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EqKvhlvws+iFdM5j3AiW3e1JF7oPPidx1krZsgEqScgM9K8cI3k7JL9T3LqHGjdoXPtdZNy1Pux3NHRlYPHX8c8mZNn1+7zwPu3rTHPouaLHSeYObS5N/I8FTsf+mESvQhPhvsDJEwN6PAwb+/I6CsTGOGyqMX6ZZe3yIzuaITQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=BMZbY7Qd; arc=fail smtp.client-ip=40.93.194.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="BMZbY7Qd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+zoyuN1LotTC2JBYc1+mnnbICPIRrwCIhsK8tSe+nrH3KR3fTJf5QElQu3Ffnhr4fzUXbfjbUONdbInF/UOuJJkrrxtLjp+lGPWspYNvInuMYhmUVI6SKJm9AweN2s4qRp03NQBhasKCZnoK0R6FNN8wNbpF68GlirZIsKPTv8TP1WoRtXBnz7oFioXierisMcKA5H59Q9uWsAVRVZa35Ox7n6WUWXISfrDaA2cIb/aR3CAYg8XqYV75rwYmaIL4pMFWcnxwHSkBcqX3S78WDNb5EN1f4b2uzlrVGSHMS6uNtgHcG/XiMLSUAs/fSawctLyp3PxawSN7zZPRTRzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf2ZDSc18vjWHfbMNhfc7lOGHRDveyKJ/KgwmBvBgJ4=;
 b=kMd2lJH292IudmoRQ9+ef7IqqDPx8DtVKxUKcb77g5C65NCKhdIwuD6q26ATUlgKoW1GylIxQhq7j4beRajd4ejhpvY1ygvAfIfuhPfNz4ewP6dpaOScPIyCXQ8hOrCHh7mesxgy18cecU7p0MUsk0U4jIOCXL+G3IPsgqYI9c/1nTyxxAKBz6zEXw80dT+lkVH/u9Wl6bZkEdM3LMjFXZHbbvN+73jo8bVPTppN3/DQiioKGdn//QUzkvUc/ayL+gGv8ilGcB8JRDoB11FrUBjpRjmmzn4QpjGdcjrAFevVNy72fFlNtGm0Aa4V2lr6WuaLZikbH/KXjWnBLfSZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pf2ZDSc18vjWHfbMNhfc7lOGHRDveyKJ/KgwmBvBgJ4=;
 b=BMZbY7QdTs6U11SZD2GLRs4nUDKiS1azRDxnOalgVgDNScnccwFiElTre3K4GPGtkswn17rMRqTUZG2Sbu8NxHU9ty0vk6/FCO7QMfYg6+aYWPlfvUpwQwD8v/vZsBTLYACoRziDYqU9ripe0IIidHzDMe0F73f9kWfL1pmP9mc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB7425.prod.exchangelabs.com (2603:10b6:510:4b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 17:53:23 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 17:53:23 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v45 5/7] mctp pcc: Implement MCTP over PCC Transport
Date: Tue, 21 Jul 2026 13:52:54 -0400
Message-ID: <20260721175258.87600-6-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0136.namprd15.prod.outlook.com
 (2603:10b6:930:68::24) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: b4441660-c719-4051-230a-08dee750f522
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10070799003|13003099007|22082099003|55112099003|18002099003|3023799007|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	16/A0TZIjOL14H4PghNKtCLFQHhkP2QmCLNk4uHUfMCsctjybawJlB+AlFZ2AypMrt71kbPa6MkMJ2oHf9YltC3kY1AR3B1ANKg4RwXB855UksHghKY4ScfhCVZL/ARZjc0QZj+E+hF82GoEpSG9zwJulV7oTmN3VNRq+qNcaq44pu87nYzU0A+CNVHf14XaZGTJTXJIs5ZNmQZBEKM9oXMBjWqUDv8J1zMHu8eNh18YXh6Lq/wfmk8LoVOzB87YUb84ssXOExVjk6wZk0H8UMsHx+8GaArj4v1xL0BYm2kVZgLjOTTV2Kn0k0Hco3Z2vkXLxUjRAkgivOWj20Awawv9vU2yY0MWZ86H0T/o5kwfRFrGsxHW1P3xmIANrdFpX20AJAkXYFfWvA/BFPzhjjFqgLTJKZiCcEjY8IE93vf0Qz4f9eophzvKymFmwb0gCEK6lFDGFHQjp67vefp0AHbMHB2mXO9vOhcP3jRBOygx5VHd91F3ryAnkFIbhU1GGUgUmnjnpcpKwyltGvEB3WVqxVrKjUv8PHmEnexNjS7KwlAZZgtyOYc2ABbkifSXl7wqyFrDz+lUHd/PaQdwHoz6hG2wwv2sJGZgI/8BnvB+jXvbASV1cBDdc3t6zVVH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10070799003)(13003099007)(22082099003)(55112099003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iVnd+M2wOsUS4jJ8dWlhaQix8vlJjHGm9ATuUAZsxhkebU29kr3AtlDr9oZz?=
 =?us-ascii?Q?tmCO2Wtbvp8WUDRv3XgUbC7LOg3/OUeg945YCHDP1esHrBNh7X4E/Z5bIQUy?=
 =?us-ascii?Q?Ya4yymOcxyjRKR1XVnbH3BfgLmiKVLHYAGtBvX1r3/W6vl3K/fBzWNrOFUaV?=
 =?us-ascii?Q?M8x8v2EkZyK5iHcv6YRxsjSkwxPbMp/RTZtxsc+STm7mRkdkUd4tT1QMiHsi?=
 =?us-ascii?Q?e5/Mp0Q4pgHFO1iyV0E3+BOsWG+iKxqPrGHMqheSrtc0+GtcTV65GHbqU7oo?=
 =?us-ascii?Q?efxwPD7uTJk9jPCvTWOYgytPoSXWfXScBiaoP+0H0iey1PO+kMHPWThgNRqj?=
 =?us-ascii?Q?UP3rv6JObjPRoYXYV6QhSQnXh0tW6UgmMjnRRh9V3jDjfbCEU40RU7/w0kdf?=
 =?us-ascii?Q?IY+5qoYc3By5nI9FXbKjdi05tMmRiOczI8qtDw73CYfDmCwF9VrEXJoIB1+d?=
 =?us-ascii?Q?g84mbDfwl0rwGeQZaVlcMQbIva9Hon+xydCEwXaqFDEASY9UlPopeGtlNaQR?=
 =?us-ascii?Q?MKE+kJ5lt0tIJgpqYceA5zGOGtFuHuR1DGTW2g9E/E9PE6hwM32o3FYEpWG2?=
 =?us-ascii?Q?plXmOLj3Quuw5T2Ti+aIMBVqNoe6Qv6lKuEFRTOm3UW6jpbsGcp8b8h8N04C?=
 =?us-ascii?Q?Pfo3HiwxWkUcvdQ0K5bFzy/O/vdme2gW7t73OJ13jhg3lAx2kXgsdVFnOZLu?=
 =?us-ascii?Q?RxeJdeIaSt5zpHmF8jWGrL9rePWKA8gRLnfwR82Cl4hNhvbLtUyRtN1q3A/y?=
 =?us-ascii?Q?pgPgCS3QAQXFxGBioUjvKZRCWLUhFU6RJTUHAZ3TAbF4xdNcwKvaYmkse1fC?=
 =?us-ascii?Q?qOdam1sB6GEcSODz1WruLkFDvaxXdWefGIDz2pmKBUR8E6xyJa/Y6wXJ5irW?=
 =?us-ascii?Q?m/Z2ayslqdYOYnNGGbJeF/A9xiPTOGVG04llbisECINVupGENO/0CocHcufy?=
 =?us-ascii?Q?JXRgDqIvYLbgV4A+ur1p5ZLbamOOzEs3D/ZLQ6XHqvb7jtRyoE5N+6ssBtnQ?=
 =?us-ascii?Q?ejIaEFksueOmh0OzRvOAS3C69x492tXJ425Nv4AXmSiaXRS7lbng9kXuVnqZ?=
 =?us-ascii?Q?Fa/3ahGaJgvqDI1ibjUlq3ux/2TC9xZObq+mTJDKpOhvckU4NqcOOH3gEUNA?=
 =?us-ascii?Q?k4ra3MNhAZb5SCNZ31Nq8l95AgPT5QZ/+eMxo3YB/wdI3veIvtBzhGFDGq+Y?=
 =?us-ascii?Q?qO5WWXyAdVbskODlslcp04A21W8qRG1TsWPTZDwR1hPoakpqEIQ69RKHMAXK?=
 =?us-ascii?Q?JcwU+wmHmMDgFf5G+o0q+b8pTthLbfCiBNc+8X8LXTe+MxXCWZNw7wQdP889?=
 =?us-ascii?Q?kPHYHvZLCia4OzbkWHSFVgyCO/j7zuOzK2M+G4fWWPqOPNxepYFeXm9ymIJb?=
 =?us-ascii?Q?lQyHTYDkea1k31Pr177nqg3tRfyPCivyvAassf1u+C0Jq4KXevGOAFdMhjPV?=
 =?us-ascii?Q?QjUm1OoKk8TyTjCV95tbV98IvxJaWfS+yDWYJNRsGH/KACVXvmzo0vfMrYfB?=
 =?us-ascii?Q?61/ur8WW2FhqAIG7piaulJxMZqXjBpEptarW0rIfIGuBlVG4xZcYwiF1yFiS?=
 =?us-ascii?Q?XGVk+nkMDnMxoFD2massv8HfEDxwjMvCfsu2LEP9D/O0gm1Qp3TL9kEC+24k?=
 =?us-ascii?Q?dskqQYyL6uPMivAUTx/NOrfZcWMdywWe+OF4vXYHcMiBufGjDACIkGhqh/rt?=
 =?us-ascii?Q?g5VvGD54YyHmpVmNY8sMI+OfUlK/MrkkY+qS3YzqQ87env7fXUxaY+EXI1SC?=
 =?us-ascii?Q?mWg9+hgk6qDC1db9bQ+hWKdnck93ehcwRPcFJmTlyvAEzq2jkAhWipjrsuxy?=
X-MS-Exchange-AntiSpam-MessageData-1:
	gKWlrYmXKQtj5z0jlA3YEvUX9t0YdWCQNMaULviDK78p//F6VQ82OsnE
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4441660-c719-4051-230a-08dee750f522
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:53:23.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sbw43l9jglWzukYDSrhSF7qLnFWaxfOA0ZRGqoaP9b5Q614rExYTKW+EqQNicXUCOrLDC1JR9o9Cug9UKzowtA5dvz+WPUWacXf90kor4LflevTuP9ZKxjxThOlYphmK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7425

Implementation of network driver for
Management Component Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292.pdf

The transport mechanism is called Platform Communication Channels (PCC)
is part of the ACPI spec:

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

The PCC mechanism is managed via a mailbox implemented at
drivers/mailbox/pcc.c

MCTP devices are specified via ACPI by entries in DSDT/SSDT and
reference channels specified in the PCCT. Messages are sent on a type
3 and received on a type 4 channel.  Communication with other devices
use the PCC based doorbell mechanism; a shared memory segment with a
corresponding interrupt and a memory register used to trigger remote
interrupts.

The shared buffer must be at least 68 bytes long as that is the minimum
MTU as defined by the MCTP specification.

Unlike the existing PCC Type 2 based drivers, the mssg parameter to
mbox_send_msg is actively used. The data section of the struct sk_buff
that contains the outgoing packet is sent to the mailbox, already
properly formatted as a PCC exctended message.

If the mailbox ring buffer is full, the driver stops the incoming
packet queues until a message has been sent, freeing space in the
ring buffer.

When the Type 3 channel outbox receives a txdone response interrupt,
it consumes the outgoing sk_buff, allowing it to be freed.

Bringing up an interface creates the channel between the network driver
and the mailbox driver. This enables communication with the remote
endpoint, to include the receipt of new messages. Bringing down an
interface removes the channel, and no new messages can be delivered.
Stopping the interface will leave any packets that are cached in the
mailbox ringbuffer. They cannot safely be freed until the PCC mailbox
attempts to deliver them and has removed them from the ring buffer.

PCC is based on a shared buffer and a set of I/O mapped memory locations
that the Spec calls registers.  This mechanism exists regardless of the
existence of the driver. If the user has the ability to map these
physical location to virtual locations, they have the ability to drive the
hardware.  Thus, there is a security aspect to this mechanism that extends
beyond the responsibilities of the operating system.

If the hardware does not expose the PCC in the ACPI table, this device
will never be enabled. Thus it is only an issue on hardware that does
support PCC. In that case, it is up to the remote controller to sanitize
communication; MCTP will be exposed as a socket interface, and userland
can send any crafted packet it wants. It would also be incumbent on
the hardware manufacturer to allow the end user to disable MCTP over PCC
communication if they did not want to expose it.

Although the config Allow 32Bit builds, they are untested.

Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html
Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>

---

Previous Version:
https://lore.kernel.org/lkml/20260522193610.234166-1-admiyo@os.amperecomputing.com/

Changes from Previous version

- Compares inbox and outbox buffer size to get smallest MTU
- uses mctp-pcc query channel information without opening channel.
  Opening the channel can trigger the sending of
  a message from the remote side before the driver
  is ready to read it.  Take advantage of the API that allows
  querying of the channel data without opening the channel.
-  Sets network queue to default length instead of 0
- Removed reference to MCTP spec
- Remove reference to endianess
- Rebased on top of PCC mailbox change for atomit startup/teardown

Remove reference to endianness

remove reference to DSP0256
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  15 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 466 ++++++++++++++++++++++++++++++++++++
 4 files changed, 487 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6940aa3d498b..9f48dee0f4c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15582,6 +15582,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <liam@infradead.org>
 R:	Alice Ryhl <aliceryhl@google.com>
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..c9b8f38ff0fb 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,21 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	depends on PCC
+	depends on CPU_LITTLE_ENDIAN
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DSDT/SSDT that matches the identifier. The Platform
+	  communication channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 config MCTP_TRANSPORT_USB
 	tristate "MCTP USB transport"
 	depends on USB
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index c36006849a1e..0a591299ffa9 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_TRANSPORT_USB) += mctp-usb.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..57c4f3b21513
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,466 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024-2026, Ampere Computing LLC
+ *
+ */
+
+/* Implementation of
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0292.pdf
+ */
+
+#include <linux/acpi.h>
+#include <linux/hrtimer.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/skbuff.h>
+#include <linux/string.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <acpi/pcc.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <net/pkt_sched.h>
+
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_MIN_MTU            68
+#define PCC_HEADER_SIZE         sizeof(struct acpi_pcct_ext_pcc_shared_memory)
+#define MCTP_PCC_MIN_SIZE       (PCC_HEADER_SIZE + MCTP_MIN_MTU)
+#define PCC_EXTRA_LEN           (PCC_HEADER_SIZE - sizeof(pcc_header.command))
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	struct net_device *ndev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
+{
+	struct acpi_pcct_ext_pcc_shared_memory pcc_header;
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *inbox;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	int size;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
+	inbox = &mctp_pcc_ndev->inbox;
+	memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
+
+	// The message must at least have the PCC command indicating it is an MCTP
+	// message followed by the MCTP header, or we have a malformed message.
+	if (pcc_header.length < sizeof(pcc_header.command) + sizeof(struct mctp_hdr))
+		goto error;
+
+	// If the reported size is larger than the shared memory minus headers,
+	// something is wrong and treat the buffer as corrupted data.
+	if (pcc_header.length > inbox->chan->shmem_size - PCC_EXTRA_LEN)
+		goto error;
+
+	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0)
+		goto error;
+
+	size = pcc_header.length + PCC_EXTRA_LEN;
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb)
+		goto error;
+
+	skb_put(skb, size);
+	skb->protocol = htons(ETH_P_MCTP);
+	memcpy_fromio(skb->data, inbox->chan->shmem, size);
+	dev_dstats_rx_add(mctp_pcc_ndev->ndev, size);
+	skb_pull(skb, sizeof(pcc_header));
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+	return;
+
+error:
+	dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	int len = skb->len;
+
+	if (skb_cow_head(skb, sizeof(*pcc_header)))
+		goto error;
+
+	pcc_header = skb_push(skb, sizeof(*pcc_header));
+	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
+	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
+	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
+	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
+
+	if (skb->len > mpnd->outbox.chan->shmem_size)
+		goto error;
+
+	/*
+	 * There is a possibility that the mailbox can be cleared on
+	 * another thread. If that is the case, and we don't restart
+	 * the queue, it will remain permanently stopped.
+	 * Stopping the queue before attempting to send the message
+	 * allows us to always restart it if mbox_send_message succeeds.
+	 */
+	netif_stop_queue(ndev);
+	if (mbox_send_message(mpnd->outbox.chan->mchan, skb) >= 0) {
+		netif_wake_queue(ndev);
+	} else {
+		// Remove the header in case it gets sent again
+		skb_pull(skb, sizeof(*pcc_header));
+		return NETDEV_TX_BUSY;
+	}
+	return NETDEV_TX_OK;
+
+error:
+	dev_dstats_tx_dropped(ndev);
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct sk_buff *skb = mssg;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
+	outbox = &mctp_pcc_ndev->outbox;
+
+	/* The PCC Mailbox typically does not make use of the mssg pointer
+	 * The mctp-over pcc driver is the only client that uses it.
+	 * This value should always be non-null; it is possible
+	 * that a change in the Mailbox level will break that assumption.
+	 */
+	if (!skb) {
+		netdev_warn_once(mctp_pcc_ndev->ndev,
+				 "%s called with null message.\n", __func__);
+		return;
+	}
+	memcpy_toio(outbox->chan->shmem, skb->data, skb->len);
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int rc)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct pcpu_dstats *dstats;
+	struct sk_buff *skb = mssg;
+	unsigned long flags;
+
+	/*
+	 * If there is a packet in flight during driver cleanup
+	 * It may have been freed already.
+	 */
+	if (!mssg)
+		return;
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+
+	/* Use an IRQ safe update as this is called from HARD IRQ instead of
+	 * dev_dstats_tx_add(mctp_pcc_ndev->ndev, skb->len);
+	 */
+	dstats = this_cpu_ptr(mctp_pcc_ndev->ndev->dstats);
+	flags = u64_stats_update_begin_irqsave(&dstats->syncp);
+
+	if (rc) {
+		u64_stats_inc(&dstats->tx_drops);
+	} else {
+		u64_stats_inc(&dstats->tx_packets);
+		u64_stats_add(&dstats->tx_bytes, skb->len);
+	}
+	u64_stats_update_end_irqrestore(&dstats->syncp, flags);
+	dev_consume_skb_any(skb);
+	netif_wake_queue(mctp_pcc_ndev->ndev);
+}
+
+static int mctp_pcc_open(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
+	struct mctp_pcc_mailbox *outbox, *inbox;
+
+	outbox = &mctp_pcc_ndev->outbox;
+	inbox = &mctp_pcc_ndev->inbox;
+
+	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	if (IS_ERR(outbox->chan))
+		return PTR_ERR(outbox->chan);
+	if (outbox->chan->shmem_size < MCTP_PCC_MIN_SIZE) {
+		pcc_mbox_free_channel(outbox->chan);
+		return -EINVAL;
+	}
+
+	inbox->client.rx_callback = mctp_pcc_client_rx_callback;
+	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
+	if (IS_ERR(inbox->chan)) {
+		pcc_mbox_free_channel(outbox->chan);
+		return PTR_ERR(inbox->chan);
+	}
+	if (inbox->chan->shmem_size < MCTP_PCC_MIN_SIZE) {
+		pcc_mbox_free_channel(outbox->chan);
+		pcc_mbox_free_channel(inbox->chan);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int mctp_pcc_stop(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	unsigned int count, idx;
+	struct mbox_chan *chan;
+	struct sk_buff *skb;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	chan = mctp_pcc_ndev->outbox.chan->mchan;
+	pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
+	mctp_pcc_ndev->inbox.chan = NULL;
+	scoped_guard(spinlock_irqsave, &chan->lock) {
+		if (chan->active_req !=  MBOX_NO_MSG) {
+			skb = chan->active_req;
+			chan->active_req = MBOX_NO_MSG;
+			dev_dstats_tx_dropped(ndev);
+			dev_consume_skb_any(skb);
+		}
+		while (chan->msg_count > 0) {
+			count = chan->msg_count;
+			idx = chan->msg_free;
+			if (idx >= count)
+				idx -= count;
+			else
+				idx += MBOX_TX_QUEUE_LEN - count;
+			skb = chan->msg_data[idx];
+			dev_dstats_tx_dropped(ndev);
+			dev_consume_skb_any(skb);
+			chan->msg_count--;
+		}
+	}
+	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
+	mctp_pcc_ndev->outbox.chan = NULL;
+	/*
+	 * If the queue was stopped because the ring buffer was full
+	 * we can restart it here as we now know the ring buffer has
+	 * been emptied and the queue can be used again if the
+	 * netdev is re-opened.
+	 */
+	netif_wake_queue(mctp_pcc_ndev->ndev);
+	return 0;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_open = mctp_pcc_open,
+	.ndo_stop = mctp_pcc_stop,
+	.ndo_start_xmit = mctp_pcc_tx,
+};
+
+static void mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = sizeof(struct acpi_pcct_ext_pcc_shared_memory);
+	ndev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+struct mctp_pcc_lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct mctp_pcc_lookup_context *luc = context;
+	struct acpi_resource_address32 *addr;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_ADDRESS32)
+		return AE_OK;
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	default:
+		return AE_ERROR;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static int check_channel_types(struct mctp_pcc_ndev *mctp_pcc_ndev)
+{
+	struct mctp_pcc_mailbox *outbox;
+	struct mctp_pcc_mailbox *inbox;
+	struct pcc_mbox_chan chan;
+	int actual_type;
+
+	outbox = &mctp_pcc_ndev->outbox;
+	if (pcc_mbox_query_channel(&chan, outbox->index))
+		return -EINVAL;
+	actual_type = chan.type;
+	if (actual_type != ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE) {
+		pr_err("MCTP-PCC outbox channel wrong type: %d", actual_type);
+		return -EINVAL;
+	}
+
+	inbox = &mctp_pcc_ndev->inbox;
+	if (pcc_mbox_query_channel(&chan, inbox->index))
+		return -EINVAL;
+	actual_type = chan.type;
+	if (actual_type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE) {
+		pr_err("MCTP-PCC inbox channel wrong type: %d", actual_type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int initialize_mtu(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct mctp_pcc_mailbox *inbox;
+	struct pcc_mbox_chan out_chan;
+	struct pcc_mbox_chan in_chan;
+	int mctp_pcc_max_mtu;
+	int inbox_max_mtu;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	outbox = &mctp_pcc_ndev->outbox;
+	if (pcc_mbox_query_channel(&out_chan, outbox->index))
+		return -EINVAL;
+	if (out_chan.shmem_size < MCTP_MIN_MTU + sizeof(struct acpi_pcct_ext_pcc_shared_memory))
+		return -EINVAL;
+	mctp_pcc_max_mtu = out_chan.shmem_size - sizeof(struct acpi_pcct_ext_pcc_shared_memory);
+	inbox = &mctp_pcc_ndev->inbox;
+	if (pcc_mbox_query_channel(&in_chan, inbox->index))
+		return -EINVAL;
+	if (in_chan.shmem_size < MCTP_MIN_MTU + sizeof(struct acpi_pcct_ext_pcc_shared_memory))
+		return -EINVAL;
+	inbox_max_mtu = in_chan.shmem_size - sizeof(struct acpi_pcct_ext_pcc_shared_memory);
+
+	if (inbox_max_mtu < mctp_pcc_max_mtu)
+		mctp_pcc_max_mtu = inbox_max_mtu;
+
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_max_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	return 0;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0};
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct device *dev = &acpi_dev->dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	char name[32];
+	int rc;
+
+	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILED to lookup PCC indexes from CRS\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Ensure we have exactly 2 channels: an outbox and an inbox.
+	 */
+	if (context.index != 2)
+		return -EINVAL;
+
+	snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	mctp_pcc_ndev->inbox.index = context.inbox_index;
+	mctp_pcc_ndev->inbox.client.dev = dev;
+	mctp_pcc_ndev->outbox.index = context.outbox_index;
+	mctp_pcc_ndev->outbox.client.dev = dev;
+
+	mctp_pcc_ndev->outbox.client.tx_prepare = mctp_pcc_tx_prepare;
+	mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->ndev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+	rc = check_channel_types(mctp_pcc_ndev);
+	if (rc != 0)
+		goto free_netdev;
+
+	rc = initialize_mtu(ndev);
+	if (rc)
+		goto free_netdev;
+
+	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
+	if (rc)
+		goto free_netdev;
+
+	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+free_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001" },
+	{}
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+	},
+};
+
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC ACPI device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.43.0

