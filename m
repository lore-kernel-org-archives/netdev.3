Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3FE3C07A;
	Tue, 21 Jul 2026 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632236; cv=none; b=I7shTU+lung6n4F72cWSNoLXyNncY6CMMDLiSn416TJ2I3QtsobzAr1jJQmdrrY2v15ql12qpsryq82FQZd+7k03xUb2BjeD70HNgRGVRFKke6oUj3nN+FpME1lTIhPyFxyaHJ8pU5uMSw2n82o41q+QCMlc6jk8xoI6WUrIRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632236; c=relaxed/simple;
	bh=HCpdGVqBWTcNVUjN+h2GAtnI6x1ESIEDVOzH7fgIYag=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=oc0VQDMRJa27MeGFtgXm7UsMOyDOcLnfVWj1Fzjk7DzZRzYsqfeRUPsWVLlkUd4k/AdwbD694EjhbXKTH8ZXY7mu4l9JkBxMjxXsJSLeapJjrG69L2EnEDxQnSinLW0nDjN41nXf/FGLAPBFm4VZp7j9iVpVtHfPX1OyW+Q2xhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tx7RH0+B; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tx7RH0+B"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h4F6J0bfnzKw7Q;
	Tue, 21 Jul 2026 13:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784632216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=z5q+fJq0Ed9DR82CIrO9G4ctT+0WFjAgsobzu9PrmI0=;
	b=tx7RH0+Bueqs9zv9R74Q+hRK+QOi7CH4aIUraPuEjz5CMzdbBEjuhiJn6OXISn7Faq/SQn
	bcEUfLI0STPsAQLsdzTo2XYer/nqEAep0uql2/pB3sT2lbU7QlqKXgVPmUvPTKqHBQ76me
	DcBQOYQJ0mXse55lkp815+yJ4z+0cM8o6aLA92BtK210HCe4TNm0eGIz8M2ABPuBT0lb+6
	D8vWEUPm7s4c6GrZ3hQA/Prl8BiJkF3zHXd7tLergxtHtpAYEEzvo7VtRbeth7F7HxQdvj
	1DUB7PVW9HslqIFjRqkoOwTs6qeZWGhVtEAevKeFLn9HI0EKwiRYOF2OsoLN0Q==
From: Claas Flint <claas.flint@mailbox.org>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_D41C2F46-429F-4949-A3B2-4BD8893B712D"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [BUG] atlantic: soft lockup / system hang on PCIe surprise-removal
Message-Id: <C39C5678-08FC-423F-8EF3-8B1F3ECCFE7D@mailbox.org>
Date: Tue, 21 Jul 2026 13:09:57 +0200
Cc: linux-kernel@vger.kernel.org
To: Sukhdeep Singh <sukhdeeps@marvell.com>,
 netdev@vger.kernel.org
X-MBO-RS-META: ajjxsoxonfwap965uka3mgurir53ebkx
X-MBO-RS-ID: c151b0e31f815ea233b


--Apple-Mail=_D41C2F46-429F-4949-A3B2-4BD8893B712D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello,

I would like to report a soft lockup and subsequent full system hang =
caused by the
atlantic driver when the NIC is surprise-removed from the PCIe bus.

Hardware:
- ASUS ProArt X870E-Creator WIFI, AMD (AM5), BIOS 1805 (2025-12-11)
- Onboard Aquantia/Marvell AQC113 [1d6a:04c0] (driver: atlantic), =
enp11s0
- Kernel 6.17.0-22-generic (also 6.17.0-35), Ubuntu, ZFS root

Summary:
When the AQC113 is surprise-removed from the PCIe bus (device stops =
responding;
MMIO register reads return 0xffffffff), the atlantic service task does =
not detect
the dead device and keeps polling its statistics registers. It spins =
indefinitely,
producing kernel soft lockups on multiple CPUs and ultimately an =
unrecoverable
full-system freeze that requires a hard reset. A single NIC detach thus =
takes the
entire machine down.

In our case the trigger is upstream of the NIC: the shared AMD =
600-series chipset
PCIe switch downstream port (0000:07:00.0 [1022:43f5]) fails to resume =
from D3hot
("pcieport 0000:07:00.0: Unable to change power state from D3hot to D0, =
device
inaccessible"), which detaches both onboard NICs behind that switch. But =
regardless
of *why* the device disappears, the atlantic driver's reaction (spinning =
forever on
0xffffffff reads) is what turns a recoverable NIC loss into a dead box.

Sequence (previous boot, timestamps):
  06:36:48  pcieport 0000:07:00.0: Unable to change power state from =
D3hot to D0, device inaccessible
  06:37:14  watchdog: BUG: soft lockup - CPU#13 stuck for 27s! =
[kworker/u128:0:3575224]
  ...repeated soft lockups...
  06:43:47  watchdog: BUG: soft lockup - CPU#2 stuck for 392s! =
[kworker/2:3:3707537]
  (log then goes completely silent: full freeze until manual reset 4 =
days later)

Representative stack trace:
  RIP: aq_hw_read_reg+0x39/0x60 [atlantic]           =
(RAX=3D0x00000000ffffffff, RDI=3D0xffffffff)
  Call Trace:
   hw_atl_rpb_rx_dma_drop_pkt_cnt_get+0x13/0x20 [atlantic]
   aq_a2_fw_update_stats+0x13e/0x1e0 [atlantic]
   aq_nic_service_task+0x78/0x120 [atlantic]
   process_one_work+0x18e/0x3e0
   worker_thread+0x2e3/0x420
   kthread+0x10a/0x230
  Workqueue: atlantic aq_nic_service_task [atlantic]

Note RAX/RDI =3D 0xffffffff, the all-ones read of a device that has =
fallen
off the bus. aq_hw_read_reg() returns 0xffffffff and the stats/service =
path neither
checks for this nor for pci_channel_offline()/pci_device_is_present(), =
so it never
stops rescheduling.

Suggested hardening (for discussion):
- In the service task / stats update path, detect a surprise-removed =
device
  (e.g. pci_channel_offline(pdev) or an all-ones sentinel from =
aq_hw_read_reg())
  and stop rescheduling aq_nic_service_task instead of spinning, so a =
NIC detach
  degrades gracefully (interface goes down) rather than hanging the =
whole system.

Reproducibility: intermittent (~once per 1-2 weeks on this box), tied to =
the PCIe
D3-resume failure of the shared chipset switch. Full dmesg / lspci =
topology
available on request; happy to test patches.

Thanks,
Claas Flint


--Apple-Mail=_D41C2F46-429F-4949-A3B2-4BD8893B712D
Content-Disposition: attachment;
	filename=pcie-d3-crash-2026-07-17.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="pcie-d3-crash-2026-07-17.txt"
Content-Transfer-Encoding: quoted-printable

### akator-ws02 PCIe-D3-Crash =E2=80=94 Diagnose-Bundle (erstellt =
2026-07-21T12:12:32+02:00) ###

## HW / BIOS ##
System Product Name
ProArt X870E-CREATOR WIFI
BIOS: 1805 (12/11/2025)
6.17.0-35-generic
cmdline: BOOT_IMAGE=3D/BOOT/ubuntu_voytzu@/vmlinuz-6.17.0-35-generic =
root=3DZFS=3Drpool/ROOT/ubuntu_voytzu ro quiet splash pcie_aspm=3Doff =
pcie_port_pm=3Doff vt.handoff=3D1

## PCIe-Topologie (NICs + gemeinsame Bridge) ##
           |                               |                             =
  +-05.0-[0a]----00.0  Intel Corporation Ethernet Controller I226-V =
[8086:125c]
           |                               |                             =
  +-06.0-[0b]----00.0  Aquantia Corp. AQtion AQC113 NBase-T/IEEE 802.3an =
Ethernet Controller [Antigua 10G] [1d6a:04c0]
-- Bridge 07:00.0 --
07:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] 600 Series =
Chipset PCIe Switch Downstream Port [1022:43f5] (rev 01) (prog-if 00 =
[Normal decode])
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ =
AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 16GT/s, Width x4, ASPM L1, Exit =
Latency L1 <32us
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
		LnkSta:	Speed 2.5GT/s, Width x1
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- =
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
-- 07:05.0 --
		LnkCap:	Port #1, Speed 8GT/s, Width x1, ASPM L1, Exit =
Latency L1 <32us
			ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; Disabled- CommClk+
		LnkSta:	Speed 5GT/s, Width x1
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ =
ASPM_L1.1+ L1_PM_Substates+
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- =
ASPM_L1.1-
-- 07:06.0 --
		LnkCap:	Port #2, Speed 8GT/s, Width x2, ASPM L1, Exit =
Latency L1 <32us
			ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
		LnkSta:	Speed 8GT/s, Width x2
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ =
ASPM_L1.1+ L1_PM_Substates+
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- =
ASPM_L1.1-
-- 0a:00.0 --
0a:00.0 Ethernet controller [0200]: Intel Corporation Ethernet =
Controller I226-V [8086:125c] (rev 06)
	Subsystem: ASUSTeK Computer Inc. Ethernet Controller I226-V =
[1043:8867]
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L1, Exit =
Latency L1 <4us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- =
CommClk+
		LnkSta:	Speed 5GT/s, Width x1
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ =
ASPM_L1.1+ L1_PM_Substates+
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- =
ASPM_L1.1-
-- 0b:00.0 --
0b:00.0 Ethernet controller [0200]: Aquantia Corp. AQtion AQC113 =
NBase-T/IEEE 802.3an Ethernet Controller [Antigua 10G] [1d6a:04c0] (rev =
03)
		LnkCap:	Port #0, Speed 16GT/s, Width x4, ASPM not =
supported
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
		LnkSta:	Speed 8GT/s (downgraded), Width x2 (downgraded)
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ =
ASPM_L1.1+ L1_PM_Substates+
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- =
ASPM_L1.1-

## Crash-Fenster 17.07. 06:29=E2=80=9306:45 (voriger Boot) ##
Jul 17 06:29:00 akator-ws02 kernel: ata7.00: exception Emask 0x0 SAct =
0x1e000 SErr 0x8d0000 action 0x6 frozen
Jul 17 06:29:00 akator-ws02 kernel: ata7: SError: { PHYRdyChg CommWake =
10B8B LinkSeq }
Jul 17 06:29:00 akator-ws02 kernel: ata7.00: failed command: READ FPDMA =
QUEUED
Jul 17 06:29:00 akator-ws02 kernel: ata7.00: cmd =
60/70:68:90:32:a2/01:00:01:00:00/40 tag 13 ncq dma 188416 in
                                             res =
40/00:01:06:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Jul 17 06:29:00 akator-ws02 kernel: ata7.00: status: { DRDY }
Jul 17 06:29:00 akator-ws02 kernel: ata7.00: failed command: READ FPDMA =
QUEUED
Jul 17 06:29:00 akator-ws02 kernel: ata7.00: cmd =
60/90:70:00:30:a2/02:00:01:00:00/40 tag 14 ncq dma 335872 in
                                             res =
40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Jul 17 06:29:00 akator-ws02 kernel: ata7.00: status: { DRDY }
Jul 17 06:29:00 akator-ws02 kernel: ata7.00: failed command: READ FPDMA =
QUEUED
Jul 17 06:29:00 akator-ws02 kernel: ata7.00: cmd =
60/90:78:00:3c:a2/02:00:01:00:00/40 tag 15 ncq dma 335872 in
                                             res =
40/00:01:06:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Jul 17 06:29:00 akator-ws02 kernel: ata7.00: status: { DRDY }
Jul 17 06:29:00 akator-ws02 kernel: ata7.00: failed command: READ FPDMA =
QUEUED
Jul 17 06:29:00 akator-ws02 kernel: ata7.00: cmd =
60/00:80:00:34:a2/04:00:01:00:00/40 tag 16 ncq dma 524288 in
                                             res =
40/00:81:82:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
Jul 17 06:29:00 akator-ws02 kernel: ata7.00: status: { DRDY }
Jul 17 06:29:00 akator-ws02 kernel: ata7: hard resetting link
Jul 17 06:29:00 akator-ws02 systemd[1]: Starting office-tracker.service =
- Office presence tracker...
Jul 17 06:29:00 akator-ws02 python3[3732955]: No change: present (Mac =
(WiFi), Mac (Ethernet), iPhone, Watch)
Jul 17 06:29:00 akator-ws02 systemd[1]: office-tracker.service: =
Deactivated successfully.
Jul 17 06:29:00 akator-ws02 systemd[1]: Finished office-tracker.service =
- Office presence tracker.
Jul 17 06:29:05 akator-ws02 kernel: ata7: link is slow to respond, =
please be patient (ready=3D0)
Jul 17 06:29:10 akator-ws02 kernel: ata7: found unknown device (class 0)
Jul 17 06:29:10 akator-ws02 kernel: ata7: SATA link up 6.0 Gbps (SStatus =
133 SControl 300)
Jul 17 06:29:10 akator-ws02 kernel: ata7.00: configured for UDMA/133
Jul 17 06:29:10 akator-ws02 kernel: sd 6:0:0:0: [sda] tag#13 FAILED =
Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D40s
Jul 17 06:29:10 akator-ws02 kernel: sd 6:0:0:0: [sda] tag#13 Sense Key : =
Aborted Command [current]=20
Jul 17 06:29:10 akator-ws02 kernel: sd 6:0:0:0: [sda] tag#13 Add. Sense: =
No additional sense information
Jul 17 06:29:10 akator-ws02 kernel: sd 6:0:0:0: [sda] tag#13 CDB: =
Read(16) 88 00 00 00 00 00 01 a2 32 90 00 00 01 70 00 00
Jul 17 06:29:10 akator-ws02 kernel: I/O error, dev sda, sector 27406992 =
op 0x0:(READ) flags 0x80700 phys_seg 3 prio class 3
Jul 17 06:29:10 akator-ws02 kernel: sd 6:0:0:0: [sda] tag#14 FAILED =
Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D40s
Jul 17 06:29:10 akator-ws02 kernel: sd 6:0:0:0: [sda] tag#14 Sense Key : =
Aborted Command [current]=20
Jul 17 06:29:10 akator-ws02 kernel: sd 6:0:0:0: [sda] tag#14 Add. Sense: =
No additional sense information
Jul 17 06:29:10 akator-ws02 kernel: sd 6:0:0:0: [sda] tag#14 CDB: =
Read(16) 88 00 00 00 00 00 01 a2 30 00 00 00 02 90 00 00
Jul 17 06:29:10 akator-ws02 kernel: I/O error, dev sda, sector 27406336 =
op 0x0:(READ) flags 0x80700 phys_seg 6 prio class 3
Jul 17 06:29:10 akator-ws02 kernel: sd 6:0:0:0: [sda] tag#15 FAILED =
Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D40s
Jul 17 06:29:10 akator-ws02 kernel: sd 6:0:0:0: [sda] tag#15 Sense Key : =
Aborted Command [current]=20
Jul 17 06:29:10 akator-ws02 kernel: sd 6:0:0:0: [sda] tag#15 Add. Sense: =
No additional sense information
Jul 17 06:29:10 akator-ws02 kernel: sd 6:0:0:0: [sda] tag#15 CDB: =
Read(16) 88 00 00 00 00 00 01 a2 3c 00 00 00 02 90 00 00
Jul 17 06:29:10 akator-ws02 kernel: I/O error, dev sda, sector 27409408 =
op 0x0:(READ) flags 0x80700 phys_seg 6 prio class 3
Jul 17 06:29:10 akator-ws02 kernel: sd 6:0:0:0: [sda] tag#16 FAILED =
Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D40s
Jul 17 06:29:10 akator-ws02 kernel: sd 6:0:0:0: [sda] tag#16 Sense Key : =
Aborted Command [current]=20
Jul 17 06:29:10 akator-ws02 kernel: sd 6:0:0:0: [sda] tag#16 Add. Sense: =
No additional sense information
Jul 17 06:29:10 akator-ws02 kernel: sd 6:0:0:0: [sda] tag#16 CDB: =
Read(16) 88 00 00 00 00 00 01 a2 34 00 00 00 04 00 00 00
Jul 17 06:29:10 akator-ws02 kernel: I/O error, dev sda, sector 27407360 =
op 0x0:(READ) flags 0x80700 phys_seg 8 prio class 3
Jul 17 06:29:10 akator-ws02 kernel: ata7: EH complete
Jul 17 06:29:11 akator-ws02 systemd[1]: Starting =
network-watchdog.service - Network watchdog that reboots if no =
network...
Jul 17 06:29:11 akator-ws02 systemd[1]: network-watchdog.service: =
Deactivated successfully.
Jul 17 06:29:11 akator-ws02 systemd[1]: Finished =
network-watchdog.service - Network watchdog that reboots if no network.
Jul 17 06:30:32 akator-ws02 systemd[1]: Starting =
network-watchdog.service - Network watchdog that reboots if no =
network...
Jul 17 06:30:32 akator-ws02 systemd[1]: network-watchdog.service: =
Deactivated successfully.
Jul 17 06:30:32 akator-ws02 systemd[1]: Finished =
network-watchdog.service - Network watchdog that reboots if no network.
Jul 17 06:31:24 akator-ws02 systemd[1]: Starting office-tracker.service =
- Office presence tracker...
Jul 17 06:31:24 akator-ws02 python3[3733723]: No change: present (Mac =
(WiFi), Mac (Ethernet), iPhone, Watch)
Jul 17 06:31:24 akator-ws02 systemd[1]: office-tracker.service: =
Deactivated successfully.
Jul 17 06:31:24 akator-ws02 systemd[1]: Finished office-tracker.service =
- Office presence tracker.
Jul 17 06:31:44 akator-ws02 systemd[1]: Starting =
network-watchdog.service - Network watchdog that reboots if no =
network...
Jul 17 06:31:44 akator-ws02 systemd[1]: network-watchdog.service: =
Deactivated successfully.
Jul 17 06:31:44 akator-ws02 systemd[1]: Finished =
network-watchdog.service - Network watchdog that reboots if no network.
Jul 17 06:33:02 akator-ws02 systemd[1]: Starting =
network-watchdog.service - Network watchdog that reboots if no =
network...
Jul 17 06:33:02 akator-ws02 systemd[1]: network-watchdog.service: =
Deactivated successfully.
Jul 17 06:33:02 akator-ws02 systemd[1]: Finished =
network-watchdog.service - Network watchdog that reboots if no network.
Jul 17 06:33:41 akator-ws02 systemd[1]: Starting office-tracker.service =
- Office presence tracker...
Jul 17 06:33:41 akator-ws02 python3[3734448]: No change: present (Mac =
(WiFi), Mac (Ethernet), iPhone, Watch)
Jul 17 06:33:41 akator-ws02 systemd[1]: office-tracker.service: =
Deactivated successfully.
Jul 17 06:33:41 akator-ws02 systemd[1]: Finished office-tracker.service =
- Office presence tracker.
Jul 17 06:34:44 akator-ws02 systemd[1]: Starting =
network-watchdog.service - Network watchdog that reboots if no =
network...
Jul 17 06:34:44 akator-ws02 systemd[1]: network-watchdog.service: =
Deactivated successfully.
Jul 17 06:34:44 akator-ws02 systemd[1]: Finished =
network-watchdog.service - Network watchdog that reboots if no network.
Jul 17 06:35:01 akator-ws02 CRON[3734902]: pam_unix(cron:session): =
session opened for user root(uid=3D0) by root(uid=3D0)
Jul 17 06:35:01 akator-ws02 CRON[3734903]: (root) CMD (command -v =
debian-sa1 > /dev/null && debian-sa1 1 1)
Jul 17 06:35:01 akator-ws02 CRON[3734902]: pam_unix(cron:session): =
session closed for user root
Jul 17 06:35:44 akator-ws02 systemd[1]: Starting office-tracker.service =
- Office presence tracker...
Jul 17 06:35:44 akator-ws02 python3[3735103]: No change: present (Mac =
(WiFi), Mac (Ethernet), iPhone, Watch)
Jul 17 06:35:44 akator-ws02 systemd[1]: office-tracker.service: =
Deactivated successfully.
Jul 17 06:35:44 akator-ws02 systemd[1]: Finished office-tracker.service =
- Office presence tracker.
Jul 17 06:35:44 akator-ws02 systemd[1]: Starting =
network-watchdog.service - Network watchdog that reboots if no =
network...
Jul 17 06:35:44 akator-ws02 systemd[1]: network-watchdog.service: =
Deactivated successfully.
Jul 17 06:35:44 akator-ws02 systemd[1]: Finished =
network-watchdog.service - Network watchdog that reboots if no network.
Jul 17 06:36:48 akator-ws02 kernel: pcieport 0000:07:00.0: Unable to =
change power state from D3hot to D0, device inaccessible
Jul 17 06:36:52 akator-ws02 systemd[1]: Starting =
network-watchdog.service - Network watchdog that reboots if no =
network...
Jul 17 06:36:56 akator-ws02 network-watchdog[3735450]: Gateway =
192.168.9.1 nicht erreichbar (1/6).
Jul 17 06:36:59 akator-ws02 systemd[1]: network-watchdog.service: =
Deactivated successfully.
Jul 17 06:36:59 akator-ws02 systemd[1]: Finished =
network-watchdog.service - Network watchdog that reboots if no network.
Jul 17 06:36:59 akator-ws02 systemd[1]: network-watchdog.service: =
Consumed 2.430s CPU time.
Jul 17 06:37:14 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#13 =
stuck for 27s! [kworker/u128:0:3575224]
Jul 17 06:37:19 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:37:19 akator-ws02 kernel: CPU: 13 UID: 0 PID: 3575224 Comm: =
kworker/u128:0 Tainted: P           OE       6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:37:19 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
Jul 17 06:37:19 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:37:19 akator-ws02 kernel: Workqueue: atlantic =
aq_nic_service_task [atlantic]
Jul 17 06:37:19 akator-ws02 kernel: RIP: 0010:aq_hw_read_reg64+0x7a/0xa0 =
[atlantic]
Jul 17 06:37:19 akator-ws02 kernel: RDX: ffffffffffffffff RSI: =
ffffcd8c41488800 RDI: ffff8d615b1f6400
Jul 17 06:37:19 akator-ws02 kernel: Call Trace:
Jul 17 06:37:19 akator-ws02 kernel:  <TASK>
Jul 17 06:37:19 akator-ws02 kernel:  =
hw_atl_stats_tx_dma_good_pkt_counter_get+0x13/0x20 [atlantic]
Jul 17 06:37:19 akator-ws02 kernel:  aq_a2_fw_update_stats+0x111/0x1e0 =
[atlantic]
Jul 17 06:37:19 akator-ws02 kernel:  aq_nic_service_task+0x78/0x120 =
[atlantic]
Jul 17 06:37:20 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:37:20 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:37:20 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:37:20 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:37:20 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:37:20 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:37:20 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:37:20 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:37:20 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:37:20 akator-ws02 kernel:  </TASK>
Jul 17 06:37:20 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#2 =
stuck for 27s! [kworker/2:3:3707537]
Jul 17 06:37:20 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:37:20 akator-ws02 kernel: CPU: 2 UID: 0 PID: 3707537 Comm: =
kworker/2:3 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:37:20 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:37:20 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:37:20 akator-ws02 kernel: Workqueue: pm pm_runtime_work
Jul 17 06:37:20 akator-ws02 kernel: RIP: 0010:pci_mmcfg_read+0xba/0x110
Jul 17 06:37:20 akator-ws02 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Jul 17 06:37:20 akator-ws02 kernel: Call Trace:
Jul 17 06:37:20 akator-ws02 kernel:  <TASK>
Jul 17 06:37:20 akator-ws02 kernel:  pci_read+0x52/0x90
Jul 17 06:37:20 akator-ws02 kernel:  pci_bus_read_config_dword+0x46/0x90
Jul 17 06:37:20 akator-ws02 kernel:  pci_read_config_dword+0x27/0x50
Jul 17 06:37:20 akator-ws02 kernel:  =
pci_find_next_ext_capability+0x82/0xe0
Jul 17 06:37:20 akator-ws02 kernel:  ? pci_conf1_read+0xb0/0x100
Jul 17 06:37:20 akator-ws02 kernel:  pci_find_ext_capability+0x12/0x20
Jul 17 06:37:20 akator-ws02 kernel:  pci_restore_ltr_state+0x29/0x60
Jul 17 06:37:20 akator-ws02 kernel:  pci_restore_state.part.0+0x16/0x280
Jul 17 06:37:20 akator-ws02 kernel:  pci_restore_state+0x1e/0x30
Jul 17 06:37:20 akator-ws02 kernel:  pci_pm_runtime_resume+0x3b/0xf0
Jul 17 06:37:20 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:37:20 akator-ws02 kernel:  __rpm_callback+0x48/0x1f0
Jul 17 06:37:20 akator-ws02 kernel:  ? ktime_get_mono_fast_ns+0x39/0xd0
Jul 17 06:37:21 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:37:21 akator-ws02 kernel:  rpm_callback+0x6e/0x80
Jul 17 06:37:21 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:37:21 akator-ws02 kernel:  rpm_resume+0x4d3/0x6d0
Jul 17 06:37:21 akator-ws02 kernel:  ? queue_delayed_work_on+0x81/0x90
Jul 17 06:37:21 akator-ws02 kernel:  pm_runtime_work+0x80/0xe0
Jul 17 06:37:21 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:37:21 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:37:21 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:37:21 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:37:21 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:37:21 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:37:21 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:37:21 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:37:21 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:37:21 akator-ws02 kernel:  </TASK>
Jul 17 06:37:22 akator-ws02 kernel: xhci_hcd 0000:0d:00.0: xHCI host =
controller not responding, assume dead
Jul 17 06:37:22 akator-ws02 kernel: xhci_hcd 0000:0d:00.0: HC died; =
cleaning up
Jul 17 06:37:22 akator-ws02 kernel: usb 1-3: USB disconnect, device =
number 29
Jul 17 06:37:42 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#2 =
stuck for 53s! [kworker/2:3:3707537]
Jul 17 06:37:44 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:37:44 akator-ws02 kernel: CPU: 2 UID: 0 PID: 3707537 Comm: =
kworker/2:3 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:37:44 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:37:44 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:37:45 akator-ws02 kernel: Workqueue: pm pm_runtime_work
Jul 17 06:37:45 akator-ws02 kernel: RIP: 0010:pci_mmcfg_read+0xba/0x110
Jul 17 06:37:45 akator-ws02 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Jul 17 06:37:45 akator-ws02 kernel: Call Trace:
Jul 17 06:37:45 akator-ws02 kernel:  <TASK>
Jul 17 06:37:45 akator-ws02 kernel:  pci_read+0x52/0x90
Jul 17 06:37:45 akator-ws02 kernel:  pci_bus_read_config_dword+0x46/0x90
Jul 17 06:37:45 akator-ws02 kernel:  pci_read_config_dword+0x27/0x50
Jul 17 06:37:45 akator-ws02 kernel:  =
pci_find_next_ext_capability+0x82/0xe0
Jul 17 06:37:45 akator-ws02 kernel:  ? pci_conf1_read+0xb0/0x100
Jul 17 06:37:45 akator-ws02 kernel:  pci_find_ext_capability+0x12/0x20
Jul 17 06:37:45 akator-ws02 kernel:  pci_restore_ltr_state+0x29/0x60
Jul 17 06:37:45 akator-ws02 kernel:  pci_restore_state.part.0+0x16/0x280
Jul 17 06:37:45 akator-ws02 kernel:  pci_restore_state+0x1e/0x30
Jul 17 06:37:45 akator-ws02 kernel:  pci_pm_runtime_resume+0x3b/0xf0
Jul 17 06:37:45 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:37:45 akator-ws02 kernel:  __rpm_callback+0x48/0x1f0
Jul 17 06:37:45 akator-ws02 kernel:  ? ktime_get_mono_fast_ns+0x39/0xd0
Jul 17 06:37:45 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:37:45 akator-ws02 kernel:  rpm_callback+0x6e/0x80
Jul 17 06:37:45 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:37:45 akator-ws02 kernel:  rpm_resume+0x4d3/0x6d0
Jul 17 06:37:45 akator-ws02 kernel:  ? queue_delayed_work_on+0x81/0x90
Jul 17 06:37:45 akator-ws02 kernel:  pm_runtime_work+0x80/0xe0
Jul 17 06:37:45 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:37:45 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:37:45 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:37:45 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:37:45 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:37:45 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:37:45 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:37:45 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:37:45 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:37:45 akator-ws02 kernel:  </TASK>
Jul 17 06:37:45 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#3 =
stuck for 23s! [kworker/u128:0:3575224]
Jul 17 06:37:45 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:37:45 akator-ws02 kernel: CPU: 3 UID: 0 PID: 3575224 Comm: =
kworker/u128:0 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:37:45 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:37:45 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:37:45 akator-ws02 kernel: Workqueue: atlantic =
aq_nic_service_task [atlantic]
Jul 17 06:37:45 akator-ws02 kernel: RIP: 0010:aq_hw_read_reg+0x14/0x60 =
[atlantic]
Jul 17 06:37:45 akator-ws02 kernel: RDX: ffff8d615b1f6400 RSI: =
ffffcd8c41486818 RDI: 00000000ffffffff
Jul 17 06:37:45 akator-ws02 kernel: Call Trace:
Jul 17 06:37:46 akator-ws02 kernel:  <TASK>
Jul 17 06:37:46 akator-ws02 kernel:  =
hw_atl_rpb_rx_dma_drop_pkt_cnt_get+0x13/0x20 [atlantic]
Jul 17 06:37:46 akator-ws02 kernel:  aq_a2_fw_update_stats+0x13e/0x1e0 =
[atlantic]
Jul 17 06:37:46 akator-ws02 kernel:  aq_nic_service_task+0x78/0x120 =
[atlantic]
Jul 17 06:37:46 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:37:46 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:37:46 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:37:46 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:37:46 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:37:46 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:37:46 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:37:46 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:37:46 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:37:46 akator-ws02 kernel:  </TASK>
Jul 17 06:37:46 akator-ws02 kernel: workqueue: mmput_async_fn hogged CPU =
for >10000us 4 times, consider switching to WQ_UNBOUND
Jul 17 06:37:45 akator-ws02 systemd[1]: Starting office-tracker.service =
- Office presence tracker...
Jul 17 06:37:54 akator-ws02 python3[3735618]: State changed: left (no =
devices)
Jul 17 06:37:59 akator-ws02 kernel: igc 0000:0a:00.0 enp10s0: PCIe link =
lost, device now detached
Jul 17 06:37:59 akator-ws02 systemd[1]: Starting =
network-watchdog.service - Network watchdog that reboots if no =
network...
Jul 17 06:37:59 akator-ws02 systemd[1]: office-tracker.service: =
Deactivated successfully.
Jul 17 06:37:59 akator-ws02 systemd[1]: Finished office-tracker.service =
- Office presence tracker.
Jul 17 06:37:59 akator-ws02 systemd[1]: office-tracker.service: Consumed =
1.131s CPU time.
Jul 17 06:38:02 akator-ws02 network-watchdog[3735675]: Gateway =
192.168.9.1 nicht erreichbar (2/6).
Jul 17 06:38:02 akator-ws02 systemd[1]: network-watchdog.service: =
Deactivated successfully.
Jul 17 06:38:02 akator-ws02 systemd[1]: Finished =
network-watchdog.service - Network watchdog that reboots if no network.
Jul 17 06:38:02 akator-ws02 systemd[1]: network-watchdog.service: =
Consumed 1.325s CPU time.
Jul 17 06:38:03 akator-ws02 kernel: workqueue: mmput_async_fn hogged CPU =
for >10000us 5 times, consider switching to WQ_UNBOUND
Jul 17 06:38:07 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#19 =
stuck for 22s! [kworker/u128:0:3575224]
Jul 17 06:38:07 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:38:07 akator-ws02 kernel: CPU: 19 UID: 0 PID: 3575224 Comm: =
kworker/u128:0 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:38:07 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:38:07 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:38:07 akator-ws02 kernel: Workqueue: atlantic =
aq_nic_service_task [atlantic]
Jul 17 06:38:07 akator-ws02 kernel: RIP: 0010:aq_hw_read_reg64+0x3a/0xa0 =
[atlantic]
Jul 17 06:38:07 akator-ws02 kernel: RDX: ffffffffffffffff RSI: =
ffffcd8c41486808 RDI: ffff8d615b1f6400
Jul 17 06:38:07 akator-ws02 kernel: Call Trace:
Jul 17 06:38:07 akator-ws02 kernel:  <TASK>
Jul 17 06:38:07 akator-ws02 kernel:  =
hw_atl_stats_rx_dma_good_octet_counter_get+0x13/0x20 [atlantic]
Jul 17 06:38:07 akator-ws02 kernel:  aq_a2_fw_update_stats+0x120/0x1e0 =
[atlantic]
Jul 17 06:38:07 akator-ws02 kernel:  aq_nic_service_task+0x78/0x120 =
[atlantic]
Jul 17 06:38:07 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:38:07 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:38:07 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:38:07 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:38:07 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:38:07 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:38:07 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:38:07 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:38:07 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:38:07 akator-ws02 kernel:  </TASK>
Jul 17 06:38:10 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#2 =
stuck for 79s! [kworker/2:3:3707537]
Jul 17 06:38:15 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:38:15 akator-ws02 kernel: CPU: 2 UID: 0 PID: 3707537 Comm: =
kworker/2:3 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:38:15 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:38:15 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:38:15 akator-ws02 kernel: Workqueue: pm pm_runtime_work
Jul 17 06:38:15 akator-ws02 kernel: RIP: 0010:pci_mmcfg_read+0xba/0x110
Jul 17 06:38:15 akator-ws02 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Jul 17 06:38:15 akator-ws02 kernel: Call Trace:
Jul 17 06:38:15 akator-ws02 kernel:  <TASK>
Jul 17 06:38:15 akator-ws02 kernel:  pci_read+0x52/0x90
Jul 17 06:38:15 akator-ws02 kernel:  pci_bus_read_config_dword+0x46/0x90
Jul 17 06:38:15 akator-ws02 kernel:  pci_read_config_dword+0x27/0x50
Jul 17 06:38:15 akator-ws02 kernel:  =
pci_find_next_ext_capability+0x82/0xe0
Jul 17 06:38:15 akator-ws02 kernel:  ? pci_conf1_read+0xb0/0x100
Jul 17 06:38:15 akator-ws02 kernel:  pci_find_ext_capability+0x12/0x20
Jul 17 06:38:15 akator-ws02 kernel:  pci_restore_ltr_state+0x29/0x60
Jul 17 06:38:15 akator-ws02 kernel:  pci_restore_state.part.0+0x16/0x280
Jul 17 06:38:15 akator-ws02 kernel:  pci_restore_state+0x1e/0x30
Jul 17 06:38:15 akator-ws02 kernel:  pci_pm_runtime_resume+0x3b/0xf0
Jul 17 06:38:15 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:38:15 akator-ws02 kernel:  __rpm_callback+0x48/0x1f0
Jul 17 06:38:15 akator-ws02 kernel:  ? ktime_get_mono_fast_ns+0x39/0xd0
Jul 17 06:38:15 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:38:15 akator-ws02 kernel:  rpm_callback+0x6e/0x80
Jul 17 06:38:15 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:38:15 akator-ws02 kernel:  rpm_resume+0x4d3/0x6d0
Jul 17 06:38:15 akator-ws02 kernel:  ? queue_delayed_work_on+0x81/0x90
Jul 17 06:38:15 akator-ws02 kernel:  pm_runtime_work+0x80/0xe0
Jul 17 06:38:15 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:38:15 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:38:15 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:38:15 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:38:15 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:38:15 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:38:15 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:38:15 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:38:15 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:38:15 akator-ws02 kernel:  </TASK>
Jul 17 06:38:27 akator-ws02 kernel: workqueue: mmput_async_fn hogged CPU =
for >10000us 7 times, consider switching to WQ_UNBOUND
Jul 17 06:38:33 akator-ws02 storagebox-upload.sh[3690809]: Timeout, =
server u458719.your-storagebox.de not responding.
Jul 17 06:38:38 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#2 =
stuck for 105s! [kworker/2:3:3707537]
Jul 17 06:38:41 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:38:41 akator-ws02 kernel: CPU: 2 UID: 0 PID: 3707537 Comm: =
kworker/2:3 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:38:41 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:38:41 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:38:41 akator-ws02 kernel: Workqueue: pm pm_runtime_work
Jul 17 06:38:41 akator-ws02 kernel: RIP: 0010:pci_mmcfg_read+0xba/0x110
Jul 17 06:38:41 akator-ws02 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Jul 17 06:38:41 akator-ws02 kernel: Call Trace:
Jul 17 06:38:41 akator-ws02 kernel:  <TASK>
Jul 17 06:38:41 akator-ws02 kernel:  pci_read+0x52/0x90
Jul 17 06:38:41 akator-ws02 kernel:  pci_bus_read_config_dword+0x46/0x90
Jul 17 06:38:41 akator-ws02 kernel:  pci_read_config_dword+0x27/0x50
Jul 17 06:38:41 akator-ws02 kernel:  =
pci_find_next_ext_capability+0x82/0xe0
Jul 17 06:38:41 akator-ws02 kernel:  ? pci_conf1_write+0xad/0xf0
Jul 17 06:38:41 akator-ws02 kernel:  pci_find_ext_capability+0x12/0x20
Jul 17 06:38:41 akator-ws02 kernel:  pci_restore_vc_state+0x3d/0xb0
Jul 17 06:38:41 akator-ws02 kernel:  pci_restore_state.part.0+0xf6/0x280
Jul 17 06:38:41 akator-ws02 kernel:  pci_restore_state+0x1e/0x30
Jul 17 06:38:41 akator-ws02 kernel:  pci_pm_runtime_resume+0x3b/0xf0
Jul 17 06:38:41 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:38:41 akator-ws02 kernel:  __rpm_callback+0x48/0x1f0
Jul 17 06:38:41 akator-ws02 kernel:  ? ktime_get_mono_fast_ns+0x39/0xd0
Jul 17 06:38:41 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:38:41 akator-ws02 kernel:  rpm_callback+0x6e/0x80
Jul 17 06:38:41 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:38:41 akator-ws02 kernel:  rpm_resume+0x4d3/0x6d0
Jul 17 06:38:41 akator-ws02 kernel:  ? queue_delayed_work_on+0x81/0x90
Jul 17 06:38:41 akator-ws02 kernel:  pm_runtime_work+0x80/0xe0
Jul 17 06:38:41 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:38:41 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:38:41 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:38:41 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:38:41 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:38:41 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:38:41 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:38:41 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:38:41 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:38:41 akator-ws02 kernel:  </TASK>
Jul 17 06:39:06 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#2 =
stuck for 131s! [kworker/2:3:3707537]
Jul 17 06:39:08 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:39:08 akator-ws02 kernel: CPU: 2 UID: 0 PID: 3707537 Comm: =
kworker/2:3 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:39:08 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:39:08 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:39:08 akator-ws02 kernel: Workqueue: pm pm_runtime_work
Jul 17 06:39:08 akator-ws02 kernel: RIP: 0010:pci_mmcfg_read+0xba/0x110
Jul 17 06:39:08 akator-ws02 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Jul 17 06:39:08 akator-ws02 kernel: Call Trace:
Jul 17 06:39:08 akator-ws02 kernel:  <TASK>
Jul 17 06:39:08 akator-ws02 kernel:  pci_read+0x52/0x90
Jul 17 06:39:08 akator-ws02 kernel:  pci_bus_read_config_dword+0x46/0x90
Jul 17 06:39:08 akator-ws02 kernel:  pci_read_config_dword+0x27/0x50
Jul 17 06:39:08 akator-ws02 kernel:  =
pci_find_next_ext_capability+0x82/0xe0
Jul 17 06:39:08 akator-ws02 kernel:  ? pci_conf1_write+0xad/0xf0
Jul 17 06:39:08 akator-ws02 kernel:  pci_find_ext_capability+0x12/0x20
Jul 17 06:39:08 akator-ws02 kernel:  pci_restore_vc_state+0x3d/0xb0
Jul 17 06:39:08 akator-ws02 kernel:  pci_restore_state.part.0+0xf6/0x280
Jul 17 06:39:08 akator-ws02 kernel:  pci_restore_state+0x1e/0x30
Jul 17 06:39:08 akator-ws02 kernel:  pci_pm_runtime_resume+0x3b/0xf0
Jul 17 06:39:08 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:39:08 akator-ws02 kernel:  __rpm_callback+0x48/0x1f0
Jul 17 06:39:08 akator-ws02 kernel:  ? ktime_get_mono_fast_ns+0x39/0xd0
Jul 17 06:39:08 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:39:08 akator-ws02 kernel:  rpm_callback+0x6e/0x80
Jul 17 06:39:08 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:39:08 akator-ws02 kernel:  rpm_resume+0x4d3/0x6d0
Jul 17 06:39:08 akator-ws02 kernel:  ? queue_delayed_work_on+0x81/0x90
Jul 17 06:39:08 akator-ws02 kernel:  pm_runtime_work+0x80/0xe0
Jul 17 06:39:08 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:39:08 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:39:08 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:39:08 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:39:08 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:39:08 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:39:08 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:39:08 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:39:08 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:39:08 akator-ws02 kernel:  </TASK>
Jul 17 06:39:27 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#9 =
stuck for 26s! [kworker/u128:0:3575224]
Jul 17 06:39:29 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:39:29 akator-ws02 kernel: CPU: 9 UID: 0 PID: 3575224 Comm: =
kworker/u128:0 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:39:29 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:39:29 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:39:29 akator-ws02 kernel: Workqueue: atlantic =
aq_nic_service_task [atlantic]
Jul 17 06:39:29 akator-ws02 kernel: RIP: 0010:aq_hw_read_reg64+0x3a/0xa0 =
[atlantic]
Jul 17 06:39:29 akator-ws02 kernel: RDX: ffffffffffffffff RSI: =
ffffcd8c41488808 RDI: ffff8d615b1f6400
Jul 17 06:39:29 akator-ws02 kernel: Call Trace:
Jul 17 06:39:29 akator-ws02 kernel:  <TASK>
Jul 17 06:39:29 akator-ws02 kernel:  =
hw_atl_stats_tx_dma_good_octet_counter_get+0x13/0x20 [atlantic]
Jul 17 06:39:29 akator-ws02 kernel:  aq_a2_fw_update_stats+0x12f/0x1e0 =
[atlantic]
Jul 17 06:39:29 akator-ws02 kernel:  aq_nic_service_task+0x78/0x120 =
[atlantic]
Jul 17 06:39:29 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:39:29 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:39:29 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:39:29 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:39:29 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:39:29 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:39:29 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:39:29 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:39:29 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:39:29 akator-ws02 kernel:  </TASK>
Jul 17 06:39:34 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#2 =
stuck for 157s! [kworker/2:3:3707537]
Jul 17 06:39:38 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:39:38 akator-ws02 kernel: CPU: 2 UID: 0 PID: 3707537 Comm: =
kworker/2:3 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:39:38 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:39:38 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:39:38 akator-ws02 kernel: Workqueue: pm pm_runtime_work
Jul 17 06:39:38 akator-ws02 kernel: RIP: 0010:pci_mmcfg_read+0xba/0x110
Jul 17 06:39:38 akator-ws02 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Jul 17 06:39:38 akator-ws02 kernel: Call Trace:
Jul 17 06:39:38 akator-ws02 kernel:  <TASK>
Jul 17 06:39:38 akator-ws02 kernel:  pci_read+0x52/0x90
Jul 17 06:39:38 akator-ws02 kernel:  pci_bus_read_config_dword+0x46/0x90
Jul 17 06:39:38 akator-ws02 kernel:  pci_read_config_dword+0x27/0x50
Jul 17 06:39:38 akator-ws02 kernel:  =
pci_find_next_ext_capability+0x82/0xe0
Jul 17 06:39:38 akator-ws02 kernel:  ? pci_conf1_write+0xad/0xf0
Jul 17 06:39:38 akator-ws02 kernel:  pci_find_ext_capability+0x12/0x20
Jul 17 06:39:38 akator-ws02 kernel:  pci_restore_vc_state+0x3d/0xb0
Jul 17 06:39:38 akator-ws02 kernel:  pci_restore_state.part.0+0xf6/0x280
Jul 17 06:39:38 akator-ws02 kernel:  pci_restore_state+0x1e/0x30
Jul 17 06:39:38 akator-ws02 kernel:  pci_pm_runtime_resume+0x3b/0xf0
Jul 17 06:39:38 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:39:38 akator-ws02 kernel:  __rpm_callback+0x48/0x1f0
Jul 17 06:39:38 akator-ws02 kernel:  ? ktime_get_mono_fast_ns+0x39/0xd0
Jul 17 06:39:38 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:39:38 akator-ws02 kernel:  rpm_callback+0x6e/0x80
Jul 17 06:39:38 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:39:38 akator-ws02 kernel:  rpm_resume+0x4d3/0x6d0
Jul 17 06:39:38 akator-ws02 kernel:  ? queue_delayed_work_on+0x81/0x90
Jul 17 06:39:38 akator-ws02 kernel:  pm_runtime_work+0x80/0xe0
Jul 17 06:39:38 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:39:38 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:39:38 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:39:38 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:39:38 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:39:38 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:39:38 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:39:38 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:39:38 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:39:38 akator-ws02 kernel:  </TASK>
Jul 17 06:39:54 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#20 =
stuck for 26s! [kworker/u128:0:3575224]
Jul 17 06:39:55 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:39:55 akator-ws02 kernel: CPU: 20 UID: 0 PID: 3575224 Comm: =
kworker/u128:0 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:39:55 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:39:55 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:39:55 akator-ws02 kernel: Workqueue: atlantic =
aq_nic_service_task [atlantic]
Jul 17 06:39:55 akator-ws02 kernel: RIP: 0010:_nv045350rm+0x3d/0x80 =
[nvidia]
Jul 17 06:39:55 akator-ws02 kernel: RDX: ffff8d617293df2f RSI: =
ffff8d6183554008 RDI: ffff8d619b838008
Jul 17 06:39:55 akator-ws02 kernel: Call Trace:
Jul 17 06:39:55 akator-ws02 kernel:  <IRQ>
Jul 17 06:39:55 akator-ws02 kernel:  ? _nv015459rm+0x10f/0x170 [nvidia]
Jul 17 06:39:55 akator-ws02 kernel:  ? _nv029005rm+0x26/0x70 [nvidia]
Jul 17 06:39:55 akator-ws02 kernel:  ? _nv013496rm+0x5c/0x80 [nvidia]
Jul 17 06:39:55 akator-ws02 kernel:  ? _nv014145rm+0x7b/0xf0 [nvidia]
Jul 17 06:39:55 akator-ws02 kernel:  ? _nv045545rm+0xa1/0xf0 [nvidia]
Jul 17 06:39:55 akator-ws02 kernel:  ? rm_run_rc_callback+0x80/0xd0 =
[nvidia]
Jul 17 06:39:55 akator-ws02 kernel:  ? =
__pfx_nv_timer_callback_typed_data+0x10/0x10 [nvidia]
Jul 17 06:39:55 akator-ws02 kernel:  ? =
nvidia_rc_timer_callback+0x29/0x90 [nvidia]
Jul 17 06:39:55 akator-ws02 kernel:  ? =
nv_timer_callback_typed_data+0xa/0x20 [nvidia]
Jul 17 06:39:55 akator-ws02 kernel:  ? call_timer_fn+0x2c/0x150
Jul 17 06:39:55 akator-ws02 kernel:  ? =
__pfx_nv_timer_callback_typed_data+0x10/0x10 [nvidia]
Jul 17 06:39:55 akator-ws02 kernel:  ? __run_timers+0x236/0x2d0
Jul 17 06:39:55 akator-ws02 kernel:  ? run_timer_softirq+0x8a/0x100
Jul 17 06:39:55 akator-ws02 kernel:  ? handle_softirqs+0xe4/0x340
Jul 17 06:39:55 akator-ws02 kernel:  ? __irq_exit_rcu+0x10e/0x130
Jul 17 06:39:55 akator-ws02 kernel:  ? irq_exit_rcu+0xe/0x20
Jul 17 06:39:55 akator-ws02 kernel:  ? =
sysvec_call_function_single+0xa0/0xc0
Jul 17 06:39:55 akator-ws02 kernel:  </IRQ>
Jul 17 06:39:55 akator-ws02 kernel:  <TASK>
Jul 17 06:39:55 akator-ws02 kernel:  ? =
asm_sysvec_call_function_single+0x1b/0x20
Jul 17 06:39:55 akator-ws02 kernel:  ? aq_hw_read_reg+0x39/0x60 =
[atlantic]
Jul 17 06:39:55 akator-ws02 kernel:  ? =
hw_atl2_mif_shared_buf_read+0x4b/0x70 [atlantic]
Jul 17 06:39:55 akator-ws02 kernel:  ? =
hw_atl2_shared_buffer_read_block+0x86/0x110 [atlantic]
Jul 17 06:39:55 akator-ws02 kernel:  ? aq_a2_fw_update_stats+0xdb/0x1e0 =
[atlantic]
Jul 17 06:39:55 akator-ws02 kernel:  ? aq_nic_service_task+0x78/0x120 =
[atlantic]
Jul 17 06:39:55 akator-ws02 kernel:  ? process_one_work+0x18e/0x3e0
Jul 17 06:39:55 akator-ws02 kernel:  ? worker_thread+0x2e3/0x420
Jul 17 06:39:55 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:39:55 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:39:55 akator-ws02 kernel:  ? kthread+0x10a/0x230
Jul 17 06:39:55 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:39:55 akator-ws02 kernel:  ? ret_from_fork+0x121/0x140
Jul 17 06:39:55 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:39:55 akator-ws02 kernel:  ? ret_from_fork_asm+0x1a/0x30
Jul 17 06:39:55 akator-ws02 kernel:  </TASK>
Jul 17 06:40:02 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#2 =
stuck for 183s! [kworker/2:3:3707537]
Jul 17 06:40:02 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:40:02 akator-ws02 kernel: CPU: 2 UID: 0 PID: 3707537 Comm: =
kworker/2:3 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:40:02 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:40:02 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:40:02 akator-ws02 kernel: Workqueue: pm pm_runtime_work
Jul 17 06:40:02 akator-ws02 kernel: RIP: 0010:pci_mmcfg_read+0xba/0x110
Jul 17 06:40:02 akator-ws02 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Jul 17 06:40:02 akator-ws02 kernel: Call Trace:
Jul 17 06:40:02 akator-ws02 kernel:  <TASK>
Jul 17 06:40:02 akator-ws02 kernel:  pci_read+0x52/0x90
Jul 17 06:40:02 akator-ws02 kernel:  pci_bus_read_config_dword+0x46/0x90
Jul 17 06:40:02 akator-ws02 kernel:  pci_read_config_dword+0x27/0x50
Jul 17 06:40:02 akator-ws02 kernel:  =
pci_find_next_ext_capability+0x82/0xe0
Jul 17 06:40:02 akator-ws02 kernel:  ? pci_conf1_write+0xad/0xf0
Jul 17 06:40:02 akator-ws02 kernel:  pci_find_ext_capability+0x12/0x20
Jul 17 06:40:02 akator-ws02 kernel:  pci_restore_vc_state+0x3d/0xb0
Jul 17 06:40:02 akator-ws02 kernel:  pci_restore_state.part.0+0xf6/0x280
Jul 17 06:40:02 akator-ws02 kernel:  pci_restore_state+0x1e/0x30
Jul 17 06:40:02 akator-ws02 kernel:  pci_pm_runtime_resume+0x3b/0xf0
Jul 17 06:40:02 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:40:02 akator-ws02 kernel:  __rpm_callback+0x48/0x1f0
Jul 17 06:40:02 akator-ws02 kernel:  ? ktime_get_mono_fast_ns+0x39/0xd0
Jul 17 06:40:02 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:40:02 akator-ws02 kernel:  rpm_callback+0x6e/0x80
Jul 17 06:40:02 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:40:02 akator-ws02 kernel:  rpm_resume+0x4d3/0x6d0
Jul 17 06:40:02 akator-ws02 kernel:  ? queue_delayed_work_on+0x81/0x90
Jul 17 06:40:02 akator-ws02 kernel:  pm_runtime_work+0x80/0xe0
Jul 17 06:40:02 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:40:02 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:40:02 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:40:02 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:40:02 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:02 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:02 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:02 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:02 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:02 akator-ws02 kernel:  </TASK>
Jul 17 06:40:05 akator-ws02 dockerd[54167]: =
time=3D"2026-07-17T06:40:04.612896744+02:00" level=3Dwarning msg=3D"Health=
 check for container =
1cdec6d514297b3823c2e8d12cca4d8495d770adc50a1956af9ccfa250e64af0 error: =
timed out starting health check for container =
1cdec6d514297b3823c2e8d12cca4d8495d770adc50a1956af9ccfa250e64af0"
Jul 17 06:40:07 akator-ws02 dockerd[54167]: =
time=3D"2026-07-17T06:40:07.481242913+02:00" level=3Derror msg=3D"copy =
stream failed" error=3D"reading from a closed fifo" stream=3Dstdout
Jul 17 06:40:07 akator-ws02 dockerd[54167]: =
time=3D"2026-07-17T06:40:07.481246940+02:00" level=3Derror msg=3D"copy =
stream failed" error=3D"reading from a closed fifo" stream=3Dstderr
Jul 17 06:40:12 akator-ws02 dockerd[54167]: =
time=3D"2026-07-17T06:40:12.335227875+02:00" level=3Dwarning msg=3D"Health=
 check for container =
8153b4b7ffe473a63dfe09ef41d3954e7d329d0087e146d4c19b911f3f9cda1b error: =
timed out starting health check for container =
8153b4b7ffe473a63dfe09ef41d3954e7d329d0087e146d4c19b911f3f9cda1b"
Jul 17 06:40:12 akator-ws02 dockerd[54167]: =
time=3D"2026-07-17T06:40:12.335464873+02:00" level=3Derror msg=3D"copy =
stream failed" error=3D"reading from a closed fifo" stream=3Dstdout
Jul 17 06:40:12 akator-ws02 dockerd[54167]: =
time=3D"2026-07-17T06:40:12.335472618+02:00" level=3Derror msg=3D"copy =
stream failed" error=3D"reading from a closed fifo" stream=3Dstderr
Jul 17 06:40:22 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#20 =
stuck for 52s! [kworker/u128:0:3575224]
Jul 17 06:40:22 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:40:22 akator-ws02 kernel: CPU: 20 UID: 0 PID: 3575224 Comm: =
kworker/u128:0 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:40:22 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:40:22 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:40:22 akator-ws02 kernel: Workqueue: atlantic =
aq_nic_service_task [atlantic]
Jul 17 06:40:22 akator-ws02 kernel: RIP: 0010:_nv045350rm+0x3d/0x80 =
[nvidia]
Jul 17 06:40:22 akator-ws02 kernel: RDX: ffff8d617293deef RSI: =
ffff8d6183554008 RDI: ffff8d619b838008
Jul 17 06:40:22 akator-ws02 kernel: Call Trace:
Jul 17 06:40:22 akator-ws02 kernel:  <IRQ>
Jul 17 06:40:22 akator-ws02 kernel:  ? _nv015459rm+0x10f/0x170 [nvidia]
Jul 17 06:40:22 akator-ws02 kernel:  ? _nv037877rm+0x28/0x40 [nvidia]
Jul 17 06:40:22 akator-ws02 kernel:  ? _nv037881rm+0x1a/0xe0 [nvidia]
Jul 17 06:40:22 akator-ws02 kernel:  ? _nv038522rm+0xa9/0x200 [nvidia]
Jul 17 06:40:22 akator-ws02 kernel:  ? _nv038533rm+0x50/0x70 [nvidia]
Jul 17 06:40:22 akator-ws02 kernel:  ? os_acquire_spinlock+0x12/0x30 =
[nvidia]
Jul 17 06:40:22 akator-ws02 kernel:  ? _nv014145rm+0x7b/0xf0 [nvidia]
Jul 17 06:40:22 akator-ws02 kernel:  ? _nv045545rm+0xa1/0xf0 [nvidia]
Jul 17 06:40:22 akator-ws02 kernel:  ? rm_run_rc_callback+0x80/0xd0 =
[nvidia]
Jul 17 06:40:22 akator-ws02 kernel:  ? =
__pfx_nv_timer_callback_typed_data+0x10/0x10 [nvidia]
Jul 17 06:40:22 akator-ws02 kernel:  ? =
nvidia_rc_timer_callback+0x29/0x90 [nvidia]
Jul 17 06:40:22 akator-ws02 kernel:  ? =
nv_timer_callback_typed_data+0xa/0x20 [nvidia]
Jul 17 06:40:22 akator-ws02 kernel:  ? call_timer_fn+0x2c/0x150
Jul 17 06:40:22 akator-ws02 kernel:  ? =
__pfx_nv_timer_callback_typed_data+0x10/0x10 [nvidia]
Jul 17 06:40:22 akator-ws02 kernel:  ? __run_timers+0x236/0x2d0
Jul 17 06:40:22 akator-ws02 kernel:  ? run_timer_softirq+0x8a/0x100
Jul 17 06:40:22 akator-ws02 kernel:  ? handle_softirqs+0xe4/0x340
Jul 17 06:40:22 akator-ws02 kernel:  ? __irq_exit_rcu+0x10e/0x130
Jul 17 06:40:22 akator-ws02 kernel:  ? irq_exit_rcu+0xe/0x20
Jul 17 06:40:22 akator-ws02 kernel:  ? =
sysvec_call_function_single+0xa0/0xc0
Jul 17 06:40:22 akator-ws02 kernel:  </IRQ>
Jul 17 06:40:22 akator-ws02 kernel:  <TASK>
Jul 17 06:40:22 akator-ws02 kernel:  ? =
asm_sysvec_call_function_single+0x1b/0x20
Jul 17 06:40:22 akator-ws02 kernel:  ? aq_hw_read_reg+0x39/0x60 =
[atlantic]
Jul 17 06:40:22 akator-ws02 kernel:  ? =
hw_atl2_mif_shared_buf_read+0x4b/0x70 [atlantic]
Jul 17 06:40:22 akator-ws02 kernel:  ? =
hw_atl2_shared_buffer_read_block+0x86/0x110 [atlantic]
Jul 17 06:40:22 akator-ws02 kernel:  ? aq_a2_fw_update_stats+0xdb/0x1e0 =
[atlantic]
Jul 17 06:40:22 akator-ws02 kernel:  ? aq_nic_service_task+0x78/0x120 =
[atlantic]
Jul 17 06:40:22 akator-ws02 kernel:  ? process_one_work+0x18e/0x3e0
Jul 17 06:40:22 akator-ws02 kernel:  ? worker_thread+0x2e3/0x420
Jul 17 06:40:22 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:40:22 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:40:22 akator-ws02 kernel:  ? kthread+0x10a/0x230
Jul 17 06:40:22 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:22 akator-ws02 kernel:  ? ret_from_fork+0x121/0x140
Jul 17 06:40:22 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:22 akator-ws02 kernel:  ? ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:22 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/R-rcu_g:4 blocked =
for more than 122 seconds.
Jul 17 06:40:24 akator-ws02 kernel:       Tainted: P           OEL      =
6.17.0-22-generic #22~24.04.1-Ubuntu
Jul 17 06:40:24 akator-ws02 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/R-rcu_g state:D stack:0 =
    pid:4     tgid:4     ppid:2      task_flags:0x4208060 =
flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  schedule+0x27/0x90
Jul 17 06:40:24 akator-ws02 kernel:  schedule_preempt_disabled+0x15/0x30
Jul 17 06:40:24 akator-ws02 kernel:  =
__mutex_lock.constprop.0+0x538/0x9e0
Jul 17 06:40:24 akator-ws02 kernel:  ? __schedule+0x315/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  __mutex_lock_slowpath+0x13/0x20
Jul 17 06:40:24 akator-ws02 kernel:  mutex_lock+0x3b/0x50
Jul 17 06:40:24 akator-ws02 kernel:  worker_attach_to_pool+0x20/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  rescuer_thread+0x103/0x4e0
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_rescuer_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/R-rcu_g:4 is =
blocked on a mutex likely owned by task kworker/R-mm_pe:13.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/R-mm_pe state:R  =
running task     stack:0     pid:13    tgid:13    ppid:2      =
task_flags:0x4208060 flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  __cond_resched+0x5c/0x80
Jul 17 06:40:24 akator-ws02 kernel:  __wait_for_common+0x36/0x180
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_schedule_timeout+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? wake_up_process+0x15/0x30
Jul 17 06:40:24 akator-ws02 kernel:  wait_for_completion+0x24/0x40
Jul 17 06:40:24 akator-ws02 kernel:  affine_move_task+0x1f2/0x740
Jul 17 06:40:24 akator-ws02 kernel:  ? __dequeue_entity+0x2b5/0x4f0
Jul 17 06:40:24 akator-ws02 kernel:  ? =
__pfx_migration_cpu_stop+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? affine_move_task+0x4b6/0x740
Jul 17 06:40:24 akator-ws02 kernel:  =
__set_cpus_allowed_ptr_locked+0x17b/0x1f0
Jul 17 06:40:24 akator-ws02 kernel:  __set_cpus_allowed_ptr+0x68/0xc0
Jul 17 06:40:24 akator-ws02 kernel:  set_cpus_allowed_ptr+0x38/0x60
Jul 17 06:40:24 akator-ws02 kernel:  worker_attach_to_pool+0x71/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  rescuer_thread+0x103/0x4e0
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_rescuer_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task khugepaged:223 blocked =
for more than 122 seconds.
Jul 17 06:40:24 akator-ws02 kernel:       Tainted: P           OEL      =
6.17.0-22-generic #22~24.04.1-Ubuntu
Jul 17 06:40:24 akator-ws02 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jul 17 06:40:24 akator-ws02 kernel: task:khugepaged      state:D stack:0 =
    pid:223   tgid:223   ppid:2      task_flags:0x200040 =
flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  schedule+0x27/0x90
Jul 17 06:40:24 akator-ws02 kernel:  schedule_timeout+0x104/0x110
Jul 17 06:40:24 akator-ws02 kernel:  __wait_for_common+0x95/0x180
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_schedule_timeout+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  wait_for_completion+0x24/0x40
Jul 17 06:40:24 akator-ws02 kernel:  __flush_work+0x85/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_wq_barrier_func+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  flush_work+0x1c/0x30
Jul 17 06:40:24 akator-ws02 kernel:  __lru_add_drain_all+0x175/0x280
Jul 17 06:40:24 akator-ws02 kernel:  lru_add_drain_all+0x10/0x20
Jul 17 06:40:24 akator-ws02 kernel:  khugepaged+0x64/0x210
Jul 17 06:40:24 akator-ws02 kernel:  ? =
__pfx_autoremove_wake_function+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_khugepaged+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/R-ipv6_:255 =
blocked for more than 122 seconds.
Jul 17 06:40:24 akator-ws02 kernel:       Tainted: P           OEL      =
6.17.0-22-generic #22~24.04.1-Ubuntu
Jul 17 06:40:24 akator-ws02 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/R-ipv6_ state:D stack:0 =
    pid:255   tgid:255   ppid:2      task_flags:0x4208060 =
flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  schedule+0x27/0x90
Jul 17 06:40:24 akator-ws02 kernel:  schedule_preempt_disabled+0x15/0x30
Jul 17 06:40:24 akator-ws02 kernel:  =
__mutex_lock.constprop.0+0x538/0x9e0
Jul 17 06:40:24 akator-ws02 kernel:  ? __schedule+0x315/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  __mutex_lock_slowpath+0x13/0x20
Jul 17 06:40:24 akator-ws02 kernel:  mutex_lock+0x3b/0x50
Jul 17 06:40:24 akator-ws02 kernel:  worker_attach_to_pool+0x20/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  rescuer_thread+0x103/0x4e0
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_rescuer_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/R-ipv6_:255 is =
blocked on a mutex likely owned by task kworker/R-mm_pe:13.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/R-mm_pe state:R  =
running task     stack:0     pid:13    tgid:13    ppid:2      =
task_flags:0x4208060 flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  __cond_resched+0x5c/0x80
Jul 17 06:40:24 akator-ws02 kernel:  __wait_for_common+0x36/0x180
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_schedule_timeout+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? wake_up_process+0x15/0x30
Jul 17 06:40:24 akator-ws02 kernel:  wait_for_completion+0x24/0x40
Jul 17 06:40:24 akator-ws02 kernel:  affine_move_task+0x1f2/0x740
Jul 17 06:40:24 akator-ws02 kernel:  ? __dequeue_entity+0x2b5/0x4f0
Jul 17 06:40:24 akator-ws02 kernel:  ? =
__pfx_migration_cpu_stop+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? affine_move_task+0x4b6/0x740
Jul 17 06:40:24 akator-ws02 kernel:  =
__set_cpus_allowed_ptr_locked+0x17b/0x1f0
Jul 17 06:40:24 akator-ws02 kernel:  __set_cpus_allowed_ptr+0x68/0xc0
Jul 17 06:40:24 akator-ws02 kernel:  set_cpus_allowed_ptr+0x38/0x60
Jul 17 06:40:24 akator-ws02 kernel:  worker_attach_to_pool+0x71/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  rescuer_thread+0x103/0x4e0
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_rescuer_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/R-atlan:443 =
blocked for more than 122 seconds.
Jul 17 06:40:24 akator-ws02 kernel:       Tainted: P           OEL      =
6.17.0-22-generic #22~24.04.1-Ubuntu
Jul 17 06:40:24 akator-ws02 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/R-atlan state:D stack:0 =
    pid:443   tgid:443   ppid:2      task_flags:0x4208060 =
flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  schedule+0x27/0x90
Jul 17 06:40:24 akator-ws02 kernel:  schedule_preempt_disabled+0x15/0x30
Jul 17 06:40:24 akator-ws02 kernel:  =
__mutex_lock.constprop.0+0x538/0x9e0
Jul 17 06:40:24 akator-ws02 kernel:  ? =
finish_task_switch.isra.0+0x9c/0x310
Jul 17 06:40:24 akator-ws02 kernel:  ? __schedule+0x315/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  __mutex_lock_slowpath+0x13/0x20
Jul 17 06:40:24 akator-ws02 kernel:  mutex_lock+0x3b/0x50
Jul 17 06:40:24 akator-ws02 kernel:  worker_attach_to_pool+0x20/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  rescuer_thread+0x103/0x4e0
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_rescuer_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/R-atlan:443 is =
blocked on a mutex likely owned by task kworker/R-mm_pe:13.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/R-mm_pe state:R  =
running task     stack:0     pid:13    tgid:13    ppid:2      =
task_flags:0x4208060 flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  __cond_resched+0x5c/0x80
Jul 17 06:40:24 akator-ws02 kernel:  __wait_for_common+0x36/0x180
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_schedule_timeout+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? wake_up_process+0x15/0x30
Jul 17 06:40:24 akator-ws02 kernel:  wait_for_completion+0x24/0x40
Jul 17 06:40:24 akator-ws02 kernel:  affine_move_task+0x1f2/0x740
Jul 17 06:40:24 akator-ws02 kernel:  ? __dequeue_entity+0x2b5/0x4f0
Jul 17 06:40:24 akator-ws02 kernel:  ? =
__pfx_migration_cpu_stop+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? affine_move_task+0x4b6/0x740
Jul 17 06:40:24 akator-ws02 kernel:  =
__set_cpus_allowed_ptr_locked+0x17b/0x1f0
Jul 17 06:40:24 akator-ws02 kernel:  __set_cpus_allowed_ptr+0x68/0xc0
Jul 17 06:40:24 akator-ws02 kernel:  set_cpus_allowed_ptr+0x38/0x60
Jul 17 06:40:24 akator-ws02 kernel:  worker_attach_to_pool+0x71/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  rescuer_thread+0x103/0x4e0
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_rescuer_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/19:0:3281280 =
blocked for more than 122 seconds.
Jul 17 06:40:24 akator-ws02 kernel:       Tainted: P           OEL      =
6.17.0-22-generic #22~24.04.1-Ubuntu
Jul 17 06:40:24 akator-ws02 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/19:0    state:D stack:0 =
    pid:3281280 tgid:3281280 ppid:2      task_flags:0x4288060 =
flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Workqueue: usb_hub_wq hub_event
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  schedule+0x27/0x90
Jul 17 06:40:24 akator-ws02 kernel:  schedule_timeout+0x104/0x110
Jul 17 06:40:24 akator-ws02 kernel:  __wait_for_common+0x95/0x180
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_schedule_timeout+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  wait_for_completion+0x24/0x40
Jul 17 06:40:24 akator-ws02 kernel:  __synchronize_srcu+0x90/0xd0
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_wakeme_after_rcu+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? ktime_get_mono_fast_ns+0x39/0xd0
Jul 17 06:40:24 akator-ws02 kernel:  synchronize_srcu+0x41/0x130
Jul 17 06:40:24 akator-ws02 kernel:  hid_bpf_destroy_device+0x2d/0x50
Jul 17 06:40:24 akator-ws02 kernel:  hid_destroy_device+0x1b/0x90 [hid]
Jul 17 06:40:24 akator-ws02 kernel:  usbhid_disconnect+0x49/0x70 =
[usbhid]
Jul 17 06:40:24 akator-ws02 kernel:  usb_unbind_interface+0x98/0x2e0
Jul 17 06:40:24 akator-ws02 kernel:  device_remove+0x65/0x80
Jul 17 06:40:24 akator-ws02 kernel:  =
device_release_driver_internal+0x20b/0x270
Jul 17 06:40:24 akator-ws02 kernel:  device_release_driver+0x12/0x20
Jul 17 06:40:24 akator-ws02 kernel:  bus_remove_device+0xcb/0x140
Jul 17 06:40:24 akator-ws02 kernel:  device_del+0x162/0x3c0
Jul 17 06:40:24 akator-ws02 kernel:  ? kobject_put+0x44/0x90
Jul 17 06:40:24 akator-ws02 kernel:  usb_disable_device+0xe5/0x280
Jul 17 06:40:24 akator-ws02 kernel:  usb_disconnect+0xe6/0x2e0
Jul 17 06:40:24 akator-ws02 kernel:  hub_quiesce+0x65/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  hub_event+0x26b/0x450
Jul 17 06:40:24 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:40:24 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:40:24 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/u128:1:3342397 =
blocked for more than 122 seconds.
Jul 17 06:40:24 akator-ws02 kernel:       Tainted: P           OEL      =
6.17.0-22-generic #22~24.04.1-Ubuntu
Jul 17 06:40:24 akator-ws02 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/u128:1  state:D stack:0 =
    pid:3342397 tgid:3342397 ppid:2      task_flags:0x4208060 =
flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  schedule+0x27/0x90
Jul 17 06:40:24 akator-ws02 kernel:  schedule_preempt_disabled+0x15/0x30
Jul 17 06:40:24 akator-ws02 kernel:  =
__mutex_lock.constprop.0+0x538/0x9e0
Jul 17 06:40:24 akator-ws02 kernel:  __mutex_lock_slowpath+0x13/0x20
Jul 17 06:40:24 akator-ws02 kernel:  mutex_lock+0x3b/0x50
Jul 17 06:40:24 akator-ws02 kernel:  worker_attach_to_pool+0x20/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  create_worker+0x12c/0x250
Jul 17 06:40:24 akator-ws02 kernel:  worker_thread+0x359/0x420
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/u128:1:3342397 is =
blocked on a mutex likely owned by task kworker/R-mm_pe:13.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/R-mm_pe state:R  =
running task     stack:0     pid:13    tgid:13    ppid:2      =
task_flags:0x4208060 flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  __cond_resched+0x5c/0x80
Jul 17 06:40:24 akator-ws02 kernel:  __wait_for_common+0x36/0x180
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_schedule_timeout+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? wake_up_process+0x15/0x30
Jul 17 06:40:24 akator-ws02 kernel:  wait_for_completion+0x24/0x40
Jul 17 06:40:24 akator-ws02 kernel:  affine_move_task+0x1f2/0x740
Jul 17 06:40:24 akator-ws02 kernel:  ? __dequeue_entity+0x2b5/0x4f0
Jul 17 06:40:24 akator-ws02 kernel:  ? =
__pfx_migration_cpu_stop+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? affine_move_task+0x4b6/0x740
Jul 17 06:40:24 akator-ws02 kernel:  =
__set_cpus_allowed_ptr_locked+0x17b/0x1f0
Jul 17 06:40:24 akator-ws02 kernel:  __set_cpus_allowed_ptr+0x68/0xc0
Jul 17 06:40:24 akator-ws02 kernel:  set_cpus_allowed_ptr+0x38/0x60
Jul 17 06:40:24 akator-ws02 kernel:  worker_attach_to_pool+0x71/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  rescuer_thread+0x103/0x4e0
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_rescuer_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/19:2:3573245 =
blocked for more than 122 seconds.
Jul 17 06:40:24 akator-ws02 kernel:       Tainted: P           OEL      =
6.17.0-22-generic #22~24.04.1-Ubuntu
Jul 17 06:40:24 akator-ws02 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/19:2    state:D stack:0 =
    pid:3573245 tgid:3573245 ppid:2      task_flags:0x4208060 =
flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  schedule+0x27/0x90
Jul 17 06:40:24 akator-ws02 kernel:  schedule_preempt_disabled+0x15/0x30
Jul 17 06:40:24 akator-ws02 kernel:  =
__mutex_lock.constprop.0+0x538/0x9e0
Jul 17 06:40:24 akator-ws02 kernel:  __mutex_lock_slowpath+0x13/0x20
Jul 17 06:40:24 akator-ws02 kernel:  mutex_lock+0x3b/0x50
Jul 17 06:40:24 akator-ws02 kernel:  worker_attach_to_pool+0x20/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  create_worker+0x12c/0x250
Jul 17 06:40:24 akator-ws02 kernel:  worker_thread+0x359/0x420
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/19:2:3573245 is =
blocked on a mutex likely owned by task kworker/R-mm_pe:13.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/R-mm_pe state:R  =
running task     stack:0     pid:13    tgid:13    ppid:2      =
task_flags:0x4208060 flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  __cond_resched+0x5c/0x80
Jul 17 06:40:24 akator-ws02 kernel:  __wait_for_common+0x36/0x180
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_schedule_timeout+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? wake_up_process+0x15/0x30
Jul 17 06:40:24 akator-ws02 kernel:  wait_for_completion+0x24/0x40
Jul 17 06:40:24 akator-ws02 kernel:  affine_move_task+0x1f2/0x740
Jul 17 06:40:24 akator-ws02 kernel:  ? __dequeue_entity+0x2b5/0x4f0
Jul 17 06:40:24 akator-ws02 kernel:  ? =
__pfx_migration_cpu_stop+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? affine_move_task+0x4b6/0x740
Jul 17 06:40:24 akator-ws02 kernel:  =
__set_cpus_allowed_ptr_locked+0x17b/0x1f0
Jul 17 06:40:24 akator-ws02 kernel:  __set_cpus_allowed_ptr+0x68/0xc0
Jul 17 06:40:24 akator-ws02 kernel:  set_cpus_allowed_ptr+0x38/0x60
Jul 17 06:40:24 akator-ws02 kernel:  worker_attach_to_pool+0x71/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  rescuer_thread+0x103/0x4e0
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_rescuer_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/28:1:3676143 =
blocked for more than 122 seconds.
Jul 17 06:40:24 akator-ws02 kernel:       Tainted: P           OEL      =
6.17.0-22-generic #22~24.04.1-Ubuntu
Jul 17 06:40:24 akator-ws02 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/28:1    state:D stack:0 =
    pid:3676143 tgid:3676143 ppid:2      task_flags:0x4208060 =
flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Workqueue:  0x0 (mm_percpu_wq)
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  schedule+0x27/0x90
Jul 17 06:40:24 akator-ws02 kernel:  schedule_preempt_disabled+0x15/0x30
Jul 17 06:40:24 akator-ws02 kernel:  =
__mutex_lock.constprop.0+0x538/0x9e0
Jul 17 06:40:24 akator-ws02 kernel:  __mutex_lock_slowpath+0x13/0x20
Jul 17 06:40:24 akator-ws02 kernel:  mutex_lock+0x3b/0x50
Jul 17 06:40:24 akator-ws02 kernel:  worker_attach_to_pool+0x20/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  create_worker+0x12c/0x250
Jul 17 06:40:24 akator-ws02 kernel:  worker_thread+0x359/0x420
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/28:1:3676143 is =
blocked on a mutex likely owned by task kworker/R-mm_pe:13.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/R-mm_pe state:R  =
running task     stack:0     pid:13    tgid:13    ppid:2      =
task_flags:0x4208060 flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  __cond_resched+0x5c/0x80
Jul 17 06:40:24 akator-ws02 kernel:  __wait_for_common+0x36/0x180
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_schedule_timeout+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? wake_up_process+0x15/0x30
Jul 17 06:40:24 akator-ws02 kernel:  wait_for_completion+0x24/0x40
Jul 17 06:40:24 akator-ws02 kernel:  affine_move_task+0x1f2/0x740
Jul 17 06:40:24 akator-ws02 kernel:  ? __dequeue_entity+0x2b5/0x4f0
Jul 17 06:40:24 akator-ws02 kernel:  ? =
__pfx_migration_cpu_stop+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? affine_move_task+0x4b6/0x740
Jul 17 06:40:24 akator-ws02 kernel:  =
__set_cpus_allowed_ptr_locked+0x17b/0x1f0
Jul 17 06:40:24 akator-ws02 kernel:  __set_cpus_allowed_ptr+0x68/0xc0
Jul 17 06:40:24 akator-ws02 kernel:  set_cpus_allowed_ptr+0x38/0x60
Jul 17 06:40:24 akator-ws02 kernel:  worker_attach_to_pool+0x71/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  rescuer_thread+0x103/0x4e0
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_rescuer_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/16:2:3708602 =
blocked for more than 122 seconds.
Jul 17 06:40:24 akator-ws02 kernel:       Tainted: P           OEL      =
6.17.0-22-generic #22~24.04.1-Ubuntu
Jul 17 06:40:24 akator-ws02 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/16:2    state:D stack:0 =
    pid:3708602 tgid:3708602 ppid:2      task_flags:0x4208060 =
flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  schedule+0x27/0x90
Jul 17 06:40:24 akator-ws02 kernel:  schedule_preempt_disabled+0x15/0x30
Jul 17 06:40:24 akator-ws02 kernel:  =
__mutex_lock.constprop.0+0x538/0x9e0
Jul 17 06:40:24 akator-ws02 kernel:  __mutex_lock_slowpath+0x13/0x20
Jul 17 06:40:24 akator-ws02 kernel:  mutex_lock+0x3b/0x50
Jul 17 06:40:24 akator-ws02 kernel:  worker_attach_to_pool+0x20/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  create_worker+0x12c/0x250
Jul 17 06:40:24 akator-ws02 kernel:  worker_thread+0x359/0x420
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/16:2:3708602 is =
blocked on a mutex likely owned by task kworker/R-mm_pe:13.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/R-mm_pe state:R  =
running task     stack:0     pid:13    tgid:13    ppid:2      =
task_flags:0x4208060 flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  __cond_resched+0x5c/0x80
Jul 17 06:40:24 akator-ws02 kernel:  __wait_for_common+0x36/0x180
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_schedule_timeout+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? wake_up_process+0x15/0x30
Jul 17 06:40:24 akator-ws02 kernel:  wait_for_completion+0x24/0x40
Jul 17 06:40:24 akator-ws02 kernel:  affine_move_task+0x1f2/0x740
Jul 17 06:40:24 akator-ws02 kernel:  ? __dequeue_entity+0x2b5/0x4f0
Jul 17 06:40:24 akator-ws02 kernel:  ? =
__pfx_migration_cpu_stop+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? affine_move_task+0x4b6/0x740
Jul 17 06:40:24 akator-ws02 kernel:  =
__set_cpus_allowed_ptr_locked+0x17b/0x1f0
Jul 17 06:40:24 akator-ws02 kernel:  __set_cpus_allowed_ptr+0x68/0xc0
Jul 17 06:40:24 akator-ws02 kernel:  set_cpus_allowed_ptr+0x38/0x60
Jul 17 06:40:24 akator-ws02 kernel:  worker_attach_to_pool+0x71/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  rescuer_thread+0x103/0x4e0
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_rescuer_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/20:1:3722897 =
blocked for more than 122 seconds.
Jul 17 06:40:24 akator-ws02 kernel:       Tainted: P           OEL      =
6.17.0-22-generic #22~24.04.1-Ubuntu
Jul 17 06:40:24 akator-ws02 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/20:1    state:D stack:0 =
    pid:3722897 tgid:3722897 ppid:2      task_flags:0x4208060 =
flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  schedule+0x27/0x90
Jul 17 06:40:24 akator-ws02 kernel:  schedule_preempt_disabled+0x15/0x30
Jul 17 06:40:24 akator-ws02 kernel:  =
__mutex_lock.constprop.0+0x538/0x9e0
Jul 17 06:40:24 akator-ws02 kernel:  __mutex_lock_slowpath+0x13/0x20
Jul 17 06:40:24 akator-ws02 kernel:  mutex_lock+0x3b/0x50
Jul 17 06:40:24 akator-ws02 kernel:  worker_attach_to_pool+0x20/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  create_worker+0x12c/0x250
Jul 17 06:40:24 akator-ws02 kernel:  worker_thread+0x359/0x420
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: INFO: task kworker/20:1:3722897 is =
blocked on a mutex likely owned by task kworker/R-mm_pe:13.
Jul 17 06:40:24 akator-ws02 kernel: task:kworker/R-mm_pe state:R  =
running task     stack:0     pid:13    tgid:13    ppid:2      =
task_flags:0x4208060 flags:0x00004000
Jul 17 06:40:24 akator-ws02 kernel: Call Trace:
Jul 17 06:40:24 akator-ws02 kernel:  <TASK>
Jul 17 06:40:24 akator-ws02 kernel:  __schedule+0x30d/0x7a0
Jul 17 06:40:24 akator-ws02 kernel:  __cond_resched+0x5c/0x80
Jul 17 06:40:24 akator-ws02 kernel:  __wait_for_common+0x36/0x180
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_schedule_timeout+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? wake_up_process+0x15/0x30
Jul 17 06:40:24 akator-ws02 kernel:  wait_for_completion+0x24/0x40
Jul 17 06:40:24 akator-ws02 kernel:  affine_move_task+0x1f2/0x740
Jul 17 06:40:24 akator-ws02 kernel:  ? __dequeue_entity+0x2b5/0x4f0
Jul 17 06:40:24 akator-ws02 kernel:  ? =
__pfx_migration_cpu_stop+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ? affine_move_task+0x4b6/0x740
Jul 17 06:40:24 akator-ws02 kernel:  =
__set_cpus_allowed_ptr_locked+0x17b/0x1f0
Jul 17 06:40:24 akator-ws02 kernel:  __set_cpus_allowed_ptr+0x68/0xc0
Jul 17 06:40:24 akator-ws02 kernel:  set_cpus_allowed_ptr+0x38/0x60
Jul 17 06:40:24 akator-ws02 kernel:  worker_attach_to_pool+0x71/0xe0
Jul 17 06:40:24 akator-ws02 kernel:  rescuer_thread+0x103/0x4e0
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_rescuer_thread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:24 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:24 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:24 akator-ws02 kernel:  </TASK>
Jul 17 06:40:24 akator-ws02 kernel: Future hung task reports are =
suppressed, see sysctl kernel.hung_task_warnings
Jul 17 06:40:30 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#2 =
stuck for 209s! [kworker/2:3:3707537]
Jul 17 06:40:33 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:40:33 akator-ws02 kernel: CPU: 2 UID: 0 PID: 3707537 Comm: =
kworker/2:3 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:40:33 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:40:33 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:40:33 akator-ws02 kernel: Workqueue: pm pm_runtime_work
Jul 17 06:40:33 akator-ws02 kernel: RIP: 0010:pci_mmcfg_read+0xba/0x110
Jul 17 06:40:33 akator-ws02 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Jul 17 06:40:33 akator-ws02 kernel: Call Trace:
Jul 17 06:40:33 akator-ws02 kernel:  <TASK>
Jul 17 06:40:33 akator-ws02 kernel:  pci_read+0x52/0x90
Jul 17 06:40:33 akator-ws02 kernel:  pci_bus_read_config_dword+0x46/0x90
Jul 17 06:40:33 akator-ws02 kernel:  pci_read_config_dword+0x27/0x50
Jul 17 06:40:33 akator-ws02 kernel:  =
pci_find_next_ext_capability+0x82/0xe0
Jul 17 06:40:33 akator-ws02 kernel:  ? pci_conf1_write+0xad/0xf0
Jul 17 06:40:33 akator-ws02 kernel:  pci_find_ext_capability+0x12/0x20
Jul 17 06:40:33 akator-ws02 kernel:  pci_restore_vc_state+0x3d/0xb0
Jul 17 06:40:33 akator-ws02 kernel:  pci_restore_state.part.0+0xf6/0x280
Jul 17 06:40:33 akator-ws02 kernel:  pci_restore_state+0x1e/0x30
Jul 17 06:40:33 akator-ws02 kernel:  pci_pm_runtime_resume+0x3b/0xf0
Jul 17 06:40:33 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:40:33 akator-ws02 kernel:  __rpm_callback+0x48/0x1f0
Jul 17 06:40:33 akator-ws02 kernel:  ? ktime_get_mono_fast_ns+0x39/0xd0
Jul 17 06:40:33 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:40:33 akator-ws02 kernel:  rpm_callback+0x6e/0x80
Jul 17 06:40:33 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:40:33 akator-ws02 kernel:  rpm_resume+0x4d3/0x6d0
Jul 17 06:40:33 akator-ws02 kernel:  ? queue_delayed_work_on+0x81/0x90
Jul 17 06:40:33 akator-ws02 kernel:  pm_runtime_work+0x80/0xe0
Jul 17 06:40:33 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:40:33 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:40:33 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:40:33 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:40:33 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:33 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:33 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:33 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:33 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:33 akator-ws02 kernel:  </TASK>
Jul 17 06:40:33 akator-ws02 systemd[1]: Starting =
network-watchdog.service - Network watchdog that reboots if no =
network...
Jul 17 06:40:33 akator-ws02 systemd[1]: Starting office-tracker.service =
- Office presence tracker...
Jul 17 06:40:35 akator-ws02 network-watchdog[3736134]: Gateway =
192.168.9.1 nicht erreichbar (3/6).
Jul 17 06:40:35 akator-ws02 network-watchdog[3736135]: Recovery-Versuch: =
enp10s0 down/up.
Jul 17 06:40:39 akator-ws02 python3[3736126]: No change: absent (no =
devices)
Jul 17 06:40:41 akator-ws02 containerd[43735]: =
time=3D"2026-07-17T06:40:37.488230096+02:00" level=3Derror msg=3D"ttrpc: =
received message on inactive stream" stream=3D1078425
Jul 17 06:40:39 akator-ws02 systemd[1]: office-tracker.service: =
Deactivated successfully.
Jul 17 06:40:39 akator-ws02 systemd[1]: Finished office-tracker.service =
- Office presence tracker.
Jul 17 06:40:44 akator-ws02 containerd[43735]: =
time=3D"2026-07-17T06:40:44.107234985+02:00" level=3Derror msg=3D"ttrpc: =
received message on inactive stream" stream=3D40013
Jul 17 06:40:44 akator-ws02 containerd[43735]: =
time=3D"2026-07-17T06:40:44.107290900+02:00" level=3Derror msg=3D"ttrpc: =
received message on inactive stream" stream=3D40017
Jul 17 06:40:44 akator-ws02 kernel: workqueue: mmput_async_fn hogged CPU =
for >10000us 11 times, consider switching to WQ_UNBOUND
Jul 17 06:40:44 akator-ws02 containerd[43735]: =
time=3D"2026-07-17T06:40:44.548758847+02:00" level=3Derror msg=3D"get =
state for =
a80b7ad6edf0bfea3a5c08131534e049f390a844fc619827f13035e629178b7c" =
error=3D"context deadline exceeded"
Jul 17 06:40:44 akator-ws02 containerd[43735]: =
time=3D"2026-07-17T06:40:44.548789605+02:00" level=3Dwarning =
msg=3D"unknown status" status=3D0
Jul 17 06:40:46 akator-ws02 ntpd[120388]: IO: Deleting interface #3 =
enp10s0, 192.168.42.1#123, interface stats: received=3D0, sent=3D0, =
dropped=3D0, active_time=3D676708 secs
Jul 17 06:40:46 akator-ws02 ntpd[120388]: IO: Deleting interface #4 =
enp10s0, 192.168.9.10#123, interface stats: received=3D9094, sent=3D9114, =
dropped=3D0, active_time=3D676708 secs
Jul 17 06:40:46 akator-ws02 ntpd[120388]: PROTO: 158.180.28.150 unlink =
local addr 192.168.9.10 -> <null>
Jul 17 06:40:46 akator-ws02 ntpd[120388]: PROTO: 141.144.241.16 unlink =
local addr 192.168.9.10 -> <null>
Jul 17 06:40:46 akator-ws02 ntpd[120388]: PROTO: 144.76.76.107 unlink =
local addr 192.168.9.10 -> <null>
Jul 17 06:40:46 akator-ws02 ntpd[120388]: PROTO: 193.203.3.170 unlink =
local addr 192.168.9.10 -> <null>
Jul 17 06:40:46 akator-ws02 ntpd[120388]: PROTO: 79.133.44.140 unlink =
local addr 192.168.9.10 -> <null>
Jul 17 06:40:46 akator-ws02 ntpd[120388]: PROTO: 129.69.253.1 unlink =
local addr 192.168.9.10 -> <null>
Jul 17 06:40:46 akator-ws02 ntpd[120388]: PROTO: 185.125.190.57 unlink =
local addr 192.168.9.10 -> <null>
Jul 17 06:40:46 akator-ws02 ntpd[120388]: IO: Deleting interface #9 =
enp10s0, fd63:afd1:5a5b:0:befc:e7ff:feb8:4b59#123, interface stats: =
received=3D0, sent=3D0, dropped=3D0, active_time=3D676708 secs
Jul 17 06:40:46 akator-ws02 ntpd[120388]: IO: Deleting interface #10 =
enp10s0, fe80::befc:e7ff:feb8:4b59%3#123, interface stats: received=3D0, =
sent=3D0, dropped=3D0, active_time=3D676708 secs
Jul 17 06:40:46 akator-ws02 ntpd[120388]: IO: Deleting interface #76 =
enp10s0, fd63:afd1:5a5b:0:aacb:90d2:55c7:5a64#123, interface stats: =
received=3D0, sent=3D0, dropped=3D0, active_time=3D594177 secs
Jul 17 06:40:46 akator-ws02 ntpd[120388]: IO: Deleting interface #84 =
enp10s0, fd63:afd1:5a5b:0:593c:920:63c3:aebb#123, interface stats: =
received=3D0, sent=3D0, dropped=3D0, active_time=3D507816 secs
Jul 17 06:40:46 akator-ws02 ntpd[120388]: IO: Deleting interface #85 =
enp10s0, fd63:afd1:5a5b:0:3f92:bcaa:dc07:8561#123, interface stats: =
received=3D0, sent=3D0, dropped=3D0, active_time=3D421459 secs
Jul 17 06:40:46 akator-ws02 ntpd[120388]: IO: Deleting interface #86 =
enp10s0, fd63:afd1:5a5b:0:745d:c50d:2786:7ac2#123, interface stats: =
received=3D0, sent=3D0, dropped=3D0, active_time=3D335101 secs
Jul 17 06:40:46 akator-ws02 ntpd[120388]: IO: Deleting interface #95 =
enp10s0, fd63:afd1:5a5b:0:5645:aefc:22c0:226#123, interface stats: =
received=3D0, sent=3D0, dropped=3D0, active_time=3D248736 secs
Jul 17 06:40:46 akator-ws02 ntpd[120388]: IO: Deleting interface #103 =
enp10s0, fd63:afd1:5a5b:0:43b:9de5:f4b9:aeed#123, interface stats: =
received=3D0, sent=3D0, dropped=3D0, active_time=3D162375 secs
Jul 17 06:40:46 akator-ws02 ntpd[120388]: IO: Deleting interface #322 =
enp10s0, fd63:afd1:5a5b:0:bb5e:a622:4beb:acef#123, interface stats: =
received=3D0, sent=3D0, dropped=3D0, active_time=3D76017 secs
Jul 17 06:40:46 akator-ws02 network-watchdog.sh[3736176]: RTNETLINK =
answers: No such device
Jul 17 06:40:50 akator-ws02 NetworkManager[2498]: <info>  =
[1784263249.6235] device (enp10s0): state change: activated -> =
unavailable (reason 'carrier-changed', sys-iface-state: 'managed')
Jul 17 06:40:50 akator-ws02 NetworkManager[2498]: <info>  =
[1784263250.5064] dhcp4 (enp10s0): canceled DHCP transaction
Jul 17 06:40:50 akator-ws02 NetworkManager[2498]: <info>  =
[1784263250.5064] dhcp4 (enp10s0): activation: beginning transaction =
(timeout in 45 seconds)
Jul 17 06:40:50 akator-ws02 NetworkManager[2498]: <info>  =
[1784263250.5064] dhcp4 (enp10s0): state changed no lease
Jul 17 06:40:51 akator-ws02 dbus-daemon[2421]: [system] Activating via =
systemd: service name=3D'org.freedesktop.nm_dispatcher' =
unit=3D'dbus-org.freedesktop.nm-dispatcher.service' requested by ':1.6' =
(uid=3D0 pid=3D2498 comm=3D"/usr/sbin/NetworkManager --no-daemon" =
label=3D"unconfined")
Jul 17 06:40:52 akator-ws02 systemd[1]: Starting =
NetworkManager-dispatcher.service - Network Manager Script Dispatcher =
Service...
Jul 17 06:40:52 akator-ws02 systemd[1]: network-watchdog.service: =
Deactivated successfully.
Jul 17 06:40:52 akator-ws02 systemd[1]: Finished =
network-watchdog.service - Network watchdog that reboots if no network.
Jul 17 06:40:55 akator-ws02 dbus-daemon[2421]: [system] Successfully =
activated service 'org.freedesktop.nm_dispatcher'
Jul 17 06:40:55 akator-ws02 systemd[1]: Started =
NetworkManager-dispatcher.service - Network Manager Script Dispatcher =
Service.
Jul 17 06:40:58 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#2 =
stuck for 235s! [kworker/2:3:3707537]
Jul 17 06:40:59 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:40:59 akator-ws02 kernel: CPU: 2 UID: 0 PID: 3707537 Comm: =
kworker/2:3 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:40:59 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:40:59 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:40:59 akator-ws02 kernel: Workqueue: pm pm_runtime_work
Jul 17 06:40:59 akator-ws02 kernel: RIP: 0010:pci_mmcfg_read+0xba/0x110
Jul 17 06:40:59 akator-ws02 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Jul 17 06:40:59 akator-ws02 kernel: Call Trace:
Jul 17 06:40:59 akator-ws02 kernel:  <TASK>
Jul 17 06:40:59 akator-ws02 kernel:  pci_read+0x52/0x90
Jul 17 06:40:59 akator-ws02 kernel:  pci_bus_read_config_dword+0x46/0x90
Jul 17 06:40:59 akator-ws02 kernel:  pci_read_config_dword+0x27/0x50
Jul 17 06:40:59 akator-ws02 kernel:  =
pci_find_next_ext_capability+0x82/0xe0
Jul 17 06:40:59 akator-ws02 kernel:  ? pci_conf1_write+0xad/0xf0
Jul 17 06:40:59 akator-ws02 kernel:  pci_find_ext_capability+0x12/0x20
Jul 17 06:40:59 akator-ws02 kernel:  pci_restore_vc_state+0x3d/0xb0
Jul 17 06:40:59 akator-ws02 kernel:  pci_restore_state.part.0+0xf6/0x280
Jul 17 06:40:59 akator-ws02 kernel:  pci_restore_state+0x1e/0x30
Jul 17 06:40:59 akator-ws02 kernel:  pci_pm_runtime_resume+0x3b/0xf0
Jul 17 06:40:59 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:40:59 akator-ws02 kernel:  __rpm_callback+0x48/0x1f0
Jul 17 06:40:59 akator-ws02 kernel:  ? ktime_get_mono_fast_ns+0x39/0xd0
Jul 17 06:40:59 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:40:59 akator-ws02 kernel:  rpm_callback+0x6e/0x80
Jul 17 06:40:59 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:40:59 akator-ws02 kernel:  rpm_resume+0x4d3/0x6d0
Jul 17 06:40:59 akator-ws02 kernel:  ? queue_delayed_work_on+0x81/0x90
Jul 17 06:40:59 akator-ws02 kernel:  pm_runtime_work+0x80/0xe0
Jul 17 06:40:59 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:40:59 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:40:59 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:40:59 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:40:59 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:40:59 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:59 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:40:59 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:40:59 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:40:59 akator-ws02 kernel:  </TASK>
Jul 17 06:41:01 akator-ws02 NetworkManager[2498]: <info>  =
[1784263261.7595] manager: NetworkManager state is now CONNECTED_LOCAL
Jul 17 06:41:02 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#3 =
stuck for 22s! [kworker/u128:0:3575224]
Jul 17 06:41:03 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:41:03 akator-ws02 kernel: CPU: 3 UID: 0 PID: 3575224 Comm: =
kworker/u128:0 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:41:03 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:41:03 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:41:03 akator-ws02 kernel: Workqueue: atlantic =
aq_nic_service_task [atlantic]
Jul 17 06:41:03 akator-ws02 kernel: RIP: 0010:aq_hw_read_reg+0x14/0x60 =
[atlantic]
Jul 17 06:41:03 akator-ws02 kernel: RDX: ffff8d615b1f6400 RSI: =
ffffcd8c41493770 RDI: 00000000ffffffff
Jul 17 06:41:03 akator-ws02 kernel: Call Trace:
Jul 17 06:41:03 akator-ws02 kernel:  <TASK>
Jul 17 06:41:03 akator-ws02 kernel:  =
hw_atl2_mif_shared_buf_read+0x4b/0x70 [atlantic]
Jul 17 06:41:03 akator-ws02 kernel:  =
hw_atl2_shared_buffer_read_block+0x86/0x110 [atlantic]
Jul 17 06:41:03 akator-ws02 kernel:  aq_a2_fw_update_stats+0xdb/0x1e0 =
[atlantic]
Jul 17 06:41:03 akator-ws02 kernel:  aq_nic_service_task+0x78/0x120 =
[atlantic]
Jul 17 06:41:03 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:41:03 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:41:03 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:41:03 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:41:03 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:41:03 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:41:03 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:41:03 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:41:03 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:41:03 akator-ws02 kernel:  </TASK>
Jul 17 06:41:15 akator-ws02 systemd[1]: =
NetworkManager-dispatcher.service: Deactivated successfully.
Jul 17 06:41:15 akator-ws02 systemd[1]: =
NetworkManager-dispatcher.service: Consumed 1.335s CPU time.
Jul 17 06:41:26 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#2 =
stuck for 261s! [kworker/2:3:3707537]
Jul 17 06:41:26 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:41:26 akator-ws02 kernel: CPU: 2 UID: 0 PID: 3707537 Comm: =
kworker/2:3 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:41:26 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:41:26 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:41:26 akator-ws02 kernel: Workqueue: pm pm_runtime_work
Jul 17 06:41:26 akator-ws02 kernel: RIP: 0010:pci_mmcfg_read+0xba/0x110
Jul 17 06:41:26 akator-ws02 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Jul 17 06:41:26 akator-ws02 kernel: Call Trace:
Jul 17 06:41:26 akator-ws02 kernel:  <TASK>
Jul 17 06:41:26 akator-ws02 kernel:  pci_read+0x52/0x90
Jul 17 06:41:26 akator-ws02 kernel:  pci_bus_read_config_dword+0x46/0x90
Jul 17 06:41:26 akator-ws02 kernel:  pci_read_config_dword+0x27/0x50
Jul 17 06:41:26 akator-ws02 kernel:  =
pci_find_next_ext_capability+0x82/0xe0
Jul 17 06:41:26 akator-ws02 kernel:  ? pci_conf1_write+0xad/0xf0
Jul 17 06:41:26 akator-ws02 kernel:  pci_find_ext_capability+0x12/0x20
Jul 17 06:41:26 akator-ws02 kernel:  pci_restore_vc_state+0x3d/0xb0
Jul 17 06:41:26 akator-ws02 kernel:  pci_restore_state.part.0+0xf6/0x280
Jul 17 06:41:26 akator-ws02 kernel:  pci_restore_state+0x1e/0x30
Jul 17 06:41:26 akator-ws02 kernel:  pci_pm_runtime_resume+0x3b/0xf0
Jul 17 06:41:26 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:41:26 akator-ws02 kernel:  __rpm_callback+0x48/0x1f0
Jul 17 06:41:26 akator-ws02 kernel:  ? ktime_get_mono_fast_ns+0x39/0xd0
Jul 17 06:41:26 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:41:26 akator-ws02 kernel:  rpm_callback+0x6e/0x80
Jul 17 06:41:26 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:41:26 akator-ws02 kernel:  rpm_resume+0x4d3/0x6d0
Jul 17 06:41:26 akator-ws02 kernel:  ? queue_delayed_work_on+0x81/0x90
Jul 17 06:41:26 akator-ws02 kernel:  pm_runtime_work+0x80/0xe0
Jul 17 06:41:26 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:41:26 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:41:26 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:41:26 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:41:26 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:41:26 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:41:26 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:41:26 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:41:26 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:41:26 akator-ws02 kernel:  </TASK>
Jul 17 06:41:31 akator-ws02 kernel: workqueue: mmput_async_fn hogged CPU =
for >10000us 19 times, consider switching to WQ_UNBOUND
Jul 17 06:41:48 akator-ws02 systemd[1]: Starting =
network-watchdog.service - Network watchdog that reboots if no =
network...
Jul 17 06:41:52 akator-ws02 network-watchdog[3736418]: Gateway =
192.168.9.1 nicht erreichbar (4/6).
Jul 17 06:41:52 akator-ws02 network-watchdog[3736420]: Recovery-Versuch: =
enp10s0 down/up.
Jul 17 06:41:54 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#2 =
stuck for 287s! [kworker/2:3:3707537]
Jul 17 06:41:54 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:41:54 akator-ws02 kernel: CPU: 2 UID: 0 PID: 3707537 Comm: =
kworker/2:3 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:41:54 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:41:54 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:41:54 akator-ws02 kernel: Workqueue: pm pm_runtime_work
Jul 17 06:41:54 akator-ws02 kernel: RIP: 0010:pci_mmcfg_read+0xba/0x110
Jul 17 06:41:54 akator-ws02 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Jul 17 06:41:54 akator-ws02 kernel: Call Trace:
Jul 17 06:41:54 akator-ws02 kernel:  <TASK>
Jul 17 06:41:54 akator-ws02 kernel:  pci_read+0x52/0x90
Jul 17 06:41:54 akator-ws02 kernel:  pci_bus_read_config_dword+0x46/0x90
Jul 17 06:41:54 akator-ws02 kernel:  pci_read_config_dword+0x27/0x50
Jul 17 06:41:54 akator-ws02 kernel:  =
pci_find_next_ext_capability+0x82/0xe0
Jul 17 06:41:54 akator-ws02 kernel:  ? pci_conf1_write+0xad/0xf0
Jul 17 06:41:54 akator-ws02 kernel:  pci_find_ext_capability+0x12/0x20
Jul 17 06:41:54 akator-ws02 kernel:  pci_restore_vc_state+0x3d/0xb0
Jul 17 06:41:54 akator-ws02 kernel:  pci_restore_state.part.0+0xf6/0x280
Jul 17 06:41:54 akator-ws02 kernel:  pci_restore_state+0x1e/0x30
Jul 17 06:41:54 akator-ws02 kernel:  pci_pm_runtime_resume+0x3b/0xf0
Jul 17 06:41:54 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:41:54 akator-ws02 kernel:  __rpm_callback+0x48/0x1f0
Jul 17 06:41:54 akator-ws02 kernel:  ? ktime_get_mono_fast_ns+0x39/0xd0
Jul 17 06:41:54 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:41:54 akator-ws02 kernel:  rpm_callback+0x6e/0x80
Jul 17 06:41:54 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:41:54 akator-ws02 kernel:  rpm_resume+0x4d3/0x6d0
Jul 17 06:41:54 akator-ws02 kernel:  ? queue_delayed_work_on+0x81/0x90
Jul 17 06:41:54 akator-ws02 kernel:  pm_runtime_work+0x80/0xe0
Jul 17 06:41:54 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:41:54 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:41:54 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:41:54 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:41:54 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:41:54 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:41:54 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:41:54 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:41:54 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:41:54 akator-ws02 kernel:  </TASK>
Jul 17 06:41:56 akator-ws02 network-watchdog.sh[3736438]: RTNETLINK =
answers: No such device
Jul 17 06:41:58 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#3 =
stuck for 22s! [kworker/u128:0:3575224]
Jul 17 06:41:59 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:41:59 akator-ws02 kernel: CPU: 3 UID: 0 PID: 3575224 Comm: =
kworker/u128:0 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:41:59 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:41:59 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:41:59 akator-ws02 kernel: Workqueue: atlantic =
aq_nic_service_task [atlantic]
Jul 17 06:41:59 akator-ws02 kernel: RIP: 0010:aq_hw_read_reg+0x39/0x60 =
[atlantic]
Jul 17 06:41:59 akator-ws02 kernel: RDX: ffff8d615b1f6400 RSI: =
ffffcd8c41486818 RDI: 00000000ffffffff
Jul 17 06:41:59 akator-ws02 kernel: Call Trace:
Jul 17 06:41:59 akator-ws02 kernel:  <TASK>
Jul 17 06:41:59 akator-ws02 kernel:  =
hw_atl_rpb_rx_dma_drop_pkt_cnt_get+0x13/0x20 [atlantic]
Jul 17 06:41:59 akator-ws02 kernel:  aq_a2_fw_update_stats+0x13e/0x1e0 =
[atlantic]
Jul 17 06:41:59 akator-ws02 kernel:  aq_nic_service_task+0x78/0x120 =
[atlantic]
Jul 17 06:41:59 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:41:59 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:41:59 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:41:59 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:41:59 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:41:59 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:41:59 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:41:59 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:41:59 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:41:59 akator-ws02 kernel:  </TASK>
Jul 17 06:42:04 akator-ws02 systemd[1]: network-watchdog.service: =
Deactivated successfully.
Jul 17 06:42:04 akator-ws02 systemd[1]: Finished =
network-watchdog.service - Network watchdog that reboots if no network.
Jul 17 06:42:04 akator-ws02 systemd[1]: network-watchdog.service: =
Consumed 5.078s CPU time.
Jul 17 06:42:22 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#0 =
stuck for 22s! [kworker/u128:0:3575224]
Jul 17 06:42:25 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:42:25 akator-ws02 kernel: CPU: 0 UID: 0 PID: 3575224 Comm: =
kworker/u128:0 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:42:25 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:42:25 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:42:25 akator-ws02 kernel: Workqueue: atlantic =
aq_nic_service_task [atlantic]
Jul 17 06:42:25 akator-ws02 kernel: RIP: 0010:aq_hw_read_reg+0x39/0x60 =
[atlantic]
Jul 17 06:42:25 akator-ws02 kernel: RDX: ffff8d615b1f6400 RSI: =
ffffcd8c4149376c RDI: 00000000ffffffff
Jul 17 06:42:25 akator-ws02 kernel: Call Trace:
Jul 17 06:42:25 akator-ws02 kernel:  <TASK>
Jul 17 06:42:25 akator-ws02 kernel:  =
hw_atl2_mif_shared_buf_read+0x4b/0x70 [atlantic]
Jul 17 06:42:25 akator-ws02 kernel:  =
hw_atl2_shared_buffer_read_block+0x86/0x110 [atlantic]
Jul 17 06:42:25 akator-ws02 kernel:  aq_a2_fw_update_stats+0xdb/0x1e0 =
[atlantic]
Jul 17 06:42:25 akator-ws02 kernel:  aq_nic_service_task+0x78/0x120 =
[atlantic]
Jul 17 06:42:25 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:42:25 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:42:25 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:42:25 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:42:25 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:42:25 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:42:25 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:42:25 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:42:25 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:42:25 akator-ws02 kernel:  </TASK>
Jul 17 06:42:25 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#2 =
stuck for 313s! [kworker/2:3:3707537]
Jul 17 06:42:26 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:42:26 akator-ws02 kernel: CPU: 2 UID: 0 PID: 3707537 Comm: =
kworker/2:3 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:42:26 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:42:26 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:42:26 akator-ws02 kernel: Workqueue: pm pm_runtime_work
Jul 17 06:42:26 akator-ws02 kernel: RIP: 0010:pci_mmcfg_read+0xba/0x110
Jul 17 06:42:26 akator-ws02 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Jul 17 06:42:26 akator-ws02 kernel: Call Trace:
Jul 17 06:42:26 akator-ws02 kernel:  <TASK>
Jul 17 06:42:26 akator-ws02 kernel:  pci_read+0x52/0x90
Jul 17 06:42:26 akator-ws02 kernel:  pci_bus_read_config_dword+0x46/0x90
Jul 17 06:42:26 akator-ws02 kernel:  pci_read_config_dword+0x27/0x50
Jul 17 06:42:26 akator-ws02 kernel:  =
pci_find_next_ext_capability+0x82/0xe0
Jul 17 06:42:26 akator-ws02 kernel:  ? pci_conf1_write+0xad/0xf0
Jul 17 06:42:26 akator-ws02 kernel:  pci_find_ext_capability+0x12/0x20
Jul 17 06:42:26 akator-ws02 kernel:  pci_restore_vc_state+0x3d/0xb0
Jul 17 06:42:26 akator-ws02 kernel:  pci_restore_state.part.0+0xf6/0x280
Jul 17 06:42:26 akator-ws02 kernel:  pci_restore_state+0x1e/0x30
Jul 17 06:42:26 akator-ws02 kernel:  pci_pm_runtime_resume+0x3b/0xf0
Jul 17 06:42:26 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:42:26 akator-ws02 kernel:  __rpm_callback+0x48/0x1f0
Jul 17 06:42:26 akator-ws02 kernel:  ? ktime_get_mono_fast_ns+0x39/0xd0
Jul 17 06:42:26 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:42:26 akator-ws02 kernel:  rpm_callback+0x6e/0x80
Jul 17 06:42:26 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:42:26 akator-ws02 kernel:  rpm_resume+0x4d3/0x6d0
Jul 17 06:42:26 akator-ws02 kernel:  ? queue_delayed_work_on+0x81/0x90
Jul 17 06:42:26 akator-ws02 kernel:  pm_runtime_work+0x80/0xe0
Jul 17 06:42:26 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:42:26 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:42:26 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:42:26 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:42:26 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:42:26 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:42:26 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:42:26 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:42:26 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:42:26 akator-ws02 kernel:  </TASK>
Jul 17 06:42:44 akator-ws02 systemd[1]: Starting office-tracker.service =
- Office presence tracker...
Jul 17 06:42:45 akator-ws02 python3[3736584]: No change: absent (no =
devices)
Jul 17 06:42:46 akator-ws02 systemd[1]: office-tracker.service: =
Deactivated successfully.
Jul 17 06:42:46 akator-ws02 systemd[1]: Finished office-tracker.service =
- Office presence tracker.
Jul 17 06:42:50 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#2 =
stuck for 339s! [kworker/2:3:3707537]
Jul 17 06:42:50 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:42:50 akator-ws02 kernel: CPU: 2 UID: 0 PID: 3707537 Comm: =
kworker/2:3 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:42:50 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:42:50 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:42:50 akator-ws02 kernel: Workqueue: pm pm_runtime_work
Jul 17 06:42:50 akator-ws02 kernel: RIP: 0010:pci_mmcfg_read+0xba/0x110
Jul 17 06:42:50 akator-ws02 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Jul 17 06:42:50 akator-ws02 kernel: Call Trace:
Jul 17 06:42:50 akator-ws02 kernel:  <TASK>
Jul 17 06:42:50 akator-ws02 kernel:  pci_read+0x52/0x90
Jul 17 06:42:50 akator-ws02 kernel:  pci_bus_read_config_dword+0x46/0x90
Jul 17 06:42:50 akator-ws02 kernel:  pci_read_config_dword+0x27/0x50
Jul 17 06:42:50 akator-ws02 kernel:  =
pci_find_next_ext_capability+0x82/0xe0
Jul 17 06:42:50 akator-ws02 kernel:  ? pci_conf1_write+0xad/0xf0
Jul 17 06:42:50 akator-ws02 kernel:  pci_find_ext_capability+0x12/0x20
Jul 17 06:42:50 akator-ws02 kernel:  pci_restore_vc_state+0x3d/0xb0
Jul 17 06:42:50 akator-ws02 kernel:  pci_restore_state.part.0+0xf6/0x280
Jul 17 06:42:50 akator-ws02 kernel:  pci_restore_state+0x1e/0x30
Jul 17 06:42:50 akator-ws02 kernel:  pci_pm_runtime_resume+0x3b/0xf0
Jul 17 06:42:50 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:42:50 akator-ws02 kernel:  __rpm_callback+0x48/0x1f0
Jul 17 06:42:50 akator-ws02 kernel:  ? ktime_get_mono_fast_ns+0x39/0xd0
Jul 17 06:42:50 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:42:50 akator-ws02 kernel:  rpm_callback+0x6e/0x80
Jul 17 06:42:50 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:42:50 akator-ws02 kernel:  rpm_resume+0x4d3/0x6d0
Jul 17 06:42:50 akator-ws02 kernel:  ? queue_delayed_work_on+0x81/0x90
Jul 17 06:42:50 akator-ws02 kernel:  pm_runtime_work+0x80/0xe0
Jul 17 06:42:50 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:42:50 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:42:50 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:42:50 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:42:50 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:42:50 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:42:50 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:42:50 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:42:50 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:42:50 akator-ws02 kernel:  </TASK>
Jul 17 06:42:50 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#8 =
stuck for 22s! [kworker/u128:0:3575224]
Jul 17 06:42:51 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:42:51 akator-ws02 kernel: CPU: 8 UID: 0 PID: 3575224 Comm: =
kworker/u128:0 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:42:51 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:42:51 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:42:51 akator-ws02 kernel: Workqueue: atlantic =
aq_nic_service_task [atlantic]
Jul 17 06:42:51 akator-ws02 kernel: RIP: 0010:aq_hw_read_reg+0x39/0x60 =
[atlantic]
Jul 17 06:42:51 akator-ws02 kernel: RDX: ffff8d615b1f6400 RSI: =
ffffcd8c4149376c RDI: 00000000ffffffff
Jul 17 06:42:51 akator-ws02 kernel: Call Trace:
Jul 17 06:42:51 akator-ws02 kernel:  <TASK>
Jul 17 06:42:51 akator-ws02 kernel:  =
hw_atl2_mif_shared_buf_read+0x4b/0x70 [atlantic]
Jul 17 06:42:51 akator-ws02 kernel:  =
hw_atl2_shared_buffer_read_block+0x86/0x110 [atlantic]
Jul 17 06:42:51 akator-ws02 kernel:  aq_a2_fw_update_stats+0xdb/0x1e0 =
[atlantic]
Jul 17 06:42:51 akator-ws02 kernel:  aq_nic_service_task+0x78/0x120 =
[atlantic]
Jul 17 06:42:51 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:42:51 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:42:51 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:42:51 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:42:51 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:42:51 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:42:51 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:42:51 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:42:51 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:42:51 akator-ws02 kernel:  </TASK>
Jul 17 06:43:03 akator-ws02 systemd[1]: Starting =
network-watchdog.service - Network watchdog that reboots if no =
network...
Jul 17 06:43:04 akator-ws02 network-watchdog[3736696]: Gateway =
192.168.9.1 nicht erreichbar (5/6).
Jul 17 06:43:04 akator-ws02 network-watchdog[3736697]: Recovery-Versuch: =
enp10s0 down/up.
Jul 17 06:43:07 akator-ws02 network-watchdog.sh[3736702]: RTNETLINK =
answers: No such device
Jul 17 06:43:13 akator-ws02 systemd[1]: network-watchdog.service: =
Deactivated successfully.
Jul 17 06:43:13 akator-ws02 systemd[1]: Finished =
network-watchdog.service - Network watchdog that reboots if no network.
Jul 17 06:43:13 akator-ws02 systemd[1]: network-watchdog.service: =
Consumed 1.330s CPU time.
Jul 17 06:43:18 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#2 =
stuck for 366s! [kworker/2:3:3707537]
Jul 17 06:43:19 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:43:19 akator-ws02 kernel: CPU: 2 UID: 0 PID: 3707537 Comm: =
kworker/2:3 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:43:19 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:43:19 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:43:19 akator-ws02 kernel: Workqueue: pm pm_runtime_work
Jul 17 06:43:19 akator-ws02 kernel: RIP: 0010:pci_mmcfg_read+0xba/0x110
Jul 17 06:43:19 akator-ws02 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Jul 17 06:43:19 akator-ws02 kernel: Call Trace:
Jul 17 06:43:19 akator-ws02 kernel:  <TASK>
Jul 17 06:43:19 akator-ws02 kernel:  pci_read+0x52/0x90
Jul 17 06:43:19 akator-ws02 kernel:  pci_bus_read_config_dword+0x46/0x90
Jul 17 06:43:19 akator-ws02 kernel:  pci_read_config_dword+0x27/0x50
Jul 17 06:43:19 akator-ws02 kernel:  =
pci_find_next_ext_capability+0x82/0xe0
Jul 17 06:43:19 akator-ws02 kernel:  ? pci_conf1_write+0xad/0xf0
Jul 17 06:43:19 akator-ws02 kernel:  pci_find_ext_capability+0x12/0x20
Jul 17 06:43:19 akator-ws02 kernel:  pci_restore_vc_state+0x3d/0xb0
Jul 17 06:43:19 akator-ws02 kernel:  pci_restore_state.part.0+0xf6/0x280
Jul 17 06:43:19 akator-ws02 kernel:  pci_restore_state+0x1e/0x30
Jul 17 06:43:19 akator-ws02 kernel:  pci_pm_runtime_resume+0x3b/0xf0
Jul 17 06:43:19 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:43:19 akator-ws02 kernel:  __rpm_callback+0x48/0x1f0
Jul 17 06:43:19 akator-ws02 kernel:  ? ktime_get_mono_fast_ns+0x39/0xd0
Jul 17 06:43:19 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:43:19 akator-ws02 kernel:  rpm_callback+0x6e/0x80
Jul 17 06:43:19 akator-ws02 kernel:  ? =
__pfx_pci_pm_runtime_resume+0x10/0x10
Jul 17 06:43:19 akator-ws02 kernel:  rpm_resume+0x4d3/0x6d0
Jul 17 06:43:19 akator-ws02 kernel:  ? queue_delayed_work_on+0x81/0x90
Jul 17 06:43:19 akator-ws02 kernel:  pm_runtime_work+0x80/0xe0
Jul 17 06:43:19 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:43:19 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:43:19 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:43:19 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:43:19 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:43:19 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:43:19 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:43:19 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:43:19 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:43:19 akator-ws02 kernel:  </TASK>
Jul 17 06:43:22 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#8 =
stuck for 25s! [kworker/u128:0:3575224]
Jul 17 06:43:23 akator-ws02 kernel:  snd_rawmidi spd5118 irqbypass =
snd_seq polyval_clmulni ghash_clmulni_intel mfd_aaeon eeepc_wmi =
aesni_intel snd_seq_device asus_wmi asus_ec_sensors snd_timer rapl =
i2c_piix4 wmi_bmof rc_core sparse_keymap platform_profile drm_ttm_helper =
i2c_algo_bit bluetooth ccp k10temp snd i2c_smbus ttm soundcore joydev =
input_leds gpio_amdpt mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
parport_pc lockd ppdev grace lp parport efi_pstore sunrpc nfnetlink =
dmi_sysfs ip_tables x_tables autofs4 zfs(PO) spl(O) raid10 raid1 raid0 =
linear raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq ucsi_acpi typec_ucsi hid_generic typec uas =
usb_storage usbhid hid nvme nvme_core atlantic nvme_keyring ahci igc =
macsec video libahci nvme_auth thunderbolt wmi
Jul 17 06:43:23 akator-ws02 kernel: CPU: 8 UID: 0 PID: 3575224 Comm: =
kworker/u128:0 Tainted: P           OEL      6.17.0-22-generic =
#22~24.04.1-Ubuntu PREEMPT(voluntary)=20
Jul 17 06:43:23 akator-ws02 kernel: Tainted: [P]=3DPROPRIETARY_MODULE, =
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
Jul 17 06:43:23 akator-ws02 kernel: Hardware name: ASUS System Product =
Name/ProArt X870E-CREATOR WIFI, BIOS 1805 12/11/2025
Jul 17 06:43:23 akator-ws02 kernel: Workqueue: atlantic =
aq_nic_service_task [atlantic]
Jul 17 06:43:23 akator-ws02 kernel: RIP: 0010:aq_hw_read_reg+0x39/0x60 =
[atlantic]
Jul 17 06:43:23 akator-ws02 kernel: RDX: ffff8d615b1f6400 RSI: =
ffffcd8c41486818 RDI: 00000000ffffffff
Jul 17 06:43:23 akator-ws02 kernel: Call Trace:
Jul 17 06:43:23 akator-ws02 kernel:  <TASK>
Jul 17 06:43:23 akator-ws02 kernel:  =
hw_atl_rpb_rx_dma_drop_pkt_cnt_get+0x13/0x20 [atlantic]
Jul 17 06:43:23 akator-ws02 kernel:  aq_a2_fw_update_stats+0x13e/0x1e0 =
[atlantic]
Jul 17 06:43:23 akator-ws02 kernel:  aq_nic_service_task+0x78/0x120 =
[atlantic]
Jul 17 06:43:23 akator-ws02 kernel:  process_one_work+0x18e/0x3e0
Jul 17 06:43:23 akator-ws02 kernel:  worker_thread+0x2e3/0x420
Jul 17 06:43:23 akator-ws02 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
Jul 17 06:43:23 akator-ws02 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 17 06:43:23 akator-ws02 kernel:  kthread+0x10a/0x230
Jul 17 06:43:23 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:43:23 akator-ws02 kernel:  ret_from_fork+0x121/0x140
Jul 17 06:43:23 akator-ws02 kernel:  ? __pfx_kthread+0x10/0x10
Jul 17 06:43:23 akator-ws02 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 17 06:43:23 akator-ws02 kernel:  </TASK>
Jul 17 06:43:47 akator-ws02 kernel: watchdog: BUG: soft lockup - CPU#2 =
stuck for 392s! [kworker/2:3:3707537]

--Apple-Mail=_D41C2F46-429F-4949-A3B2-4BD8893B712D--
