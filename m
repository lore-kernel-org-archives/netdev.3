Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792774318;
	b=tMmdCww27ktRTOo58byWiCvljsuaoeskMy66bEzB/NT/3/wppDBZcHvVyWoqPJucPd2t
	 29jttPdcH32KK9rrCzyCG1E/YaxCIBObp/xcO708g++tEbvgey6HBTcHru7Fsv6/XNWw4
	 2F5hfqUPvI6nApjOVv1qQq/GT9X3tz4V3NOc6PXGD6W088XIFtlVKc/r2+FvXRx4y8OGq
	 CNLfrtTrLsQUowQsrdj4qG91Bc2Cpcx0dSZOdqOpk2TH1dDRMX90fEeV1FbcmKQYArxQ2
	 PJKvANDx79Tf/kDLzlKVvzbcoPBbMq1MVhhtBEcBtS+JMck33Rq8OColVDsqvs3WTyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792774318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=NrZphcz5lq/XVkFiO5k417V3lQBEA8arVq2lRRgYyGQ=;
	b=D/eGmZefU/Xn/UugmzKMrott4nD24Q4TT8+mb7RZkL+a4rcHG/SloPLLbEl8DqYMG337
	 ePmyUhM4k+U/yrtNpBg6jGErszxasjErEnfcqs1+nqI6sxtZZjs1/fifs6LsMnYMZjUl5
	 yU9QAZJ7i99SxOSBF+butuArea9xK9v2Zhkd1Ymi025RSAW1QdFWdTz7Z9al0eVFMAxP/
	 FZt14o1I+MCv35iPc5cIFvxnQdWoSeH36Azgxd8rUGq8ucL4RzFMP4O34LCaiR5hXDkD8
	 nVcnAWfmZqjB6x2zaIHON4I70cKd1TxBpFAC0wpOtt0H2ryXH01M6VycKLvcgXY2J/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20251104 header.b="g0JOuUB/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16706606A31E
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 16:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16706606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20251104 header.b=g0JOuUB/
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9ae391a05so7528825ad.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792774317; cv=none;
        d=google.com; s=arc-20260327;
        b=lIKmbt6xB2KKAndjcs+KbNkeJQAROdqMhApoVbw8x6o5L0otQK9PSROwRqbcE+Gqx9
         Fm6lioRPRuikJh+222kVU1LjwmH4VIgsX8c98rrwWkdvqxjLoMnF+nMrvmNhjpy6ds2N
         PjxVVUpEW1w6els/7b4zeq1vV/ykFwKujoxM86+lzNFnb9geq//wepH1j2NJLne4r/1Z
         EqdN1dSqcR5H5B6VO2K31FsPjc08h0rC6wlXxKNeGoiEnESboSwhAa1DiKfM/bvp8buJ
         BDG3bscoW/y14EncJQJaGfTroaDbuyRK6w6mP52h7mkopnqFsodl1E2V7J3evuPcUtUQ
         p5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=NrZphcz5lq/XVkFiO5k417V3lQBEA8arVq2lRRgYyGQ=;
        fh=aDUZZ9N6NPmO6DMPx8G1ADwl9DVnQFUvUJ2oivftvxg=;
        b=rx7CS3FaEDUcRSynxXDFCm2lsQwRKAqL1sLWctvgaivXZkUsI4mcgtUzCA3IpdZair
         l2i+ROgdbYmHdPfKzfbndlw3y9TnTBc+c9R91Ih6bP/Jm43OqWp5fkp0AcAzuuiVTW8R
         /DD4dddd1KIdfhzv0X7yjEXfbVb5V25KmP0UcCYJON3/Tp+v3/O4QTsHwakS86D3Q76Y
         0jO7f0u2+3+nFYIFWjr1Z3UuSKcMVh9M5f6jdfxrP5J9HIsSsXgdCLkDRzuBU+/oD7cq
         V68aTrxYL4FwKe58t4gmYB+KWqxz7+wPo3mMauyT15SgEErZzdyx05gtpP14ssBFYFuG
         Z2Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1792774317; x=1793379117; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NrZphcz5lq/XVkFiO5k417V3lQBEA8arVq2lRRgYyGQ=;
        b=g0JOuUB/Su9rbbP94uSQFuzdOt4CvBUJPghMCegkLEU4NA4nzedmFtr5cyYjDkZJ8j
         hunE7o3pUvpZFkkD49RCtiW/oJN1LjspvGUddGqnxI5aQkfMydspwSMuoFSuCN4wJ1B7
         Fe+mloai+x0bH/7UEMj2EdJj35vd/C1BuKLribQtBkCivQkpT9pxYjevSJf9srgf24/M
         mqYxBSpNv/cqg0xUivEgWSCN3lsIfLDoItZCYu4dXr9uXQCurafPYOLYDYBJ2XNAOjw1
         5iwREFy+A5PS/GB+jvFwyVsLg7rETD1JBMLEYBIOuNziTklGUS8fruOzrsKeqv2osxj6
         vCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792774317; x=1793379117;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NrZphcz5lq/XVkFiO5k417V3lQBEA8arVq2lRRgYyGQ=;
        b=GyxcYP4mzM6LnI3pnCNnFoTmIgIxZ91WANwqBoo0gVNvGtPpNFUJJm/T7rKOgwPD54
         6zmZc3/785AfKfsShY4Vx8THUQlPlVy+ZPUTftQ7PzfF6z/seFzArJq6gN/LcqqrFZu3
         0kUe/8HzRBB9EfGhF8eCC9XC8a9ma5wgQBEZ1HQxLrJq+YAqdkVOqc8So87gj/M3Scy9
         IN0Q+s173xjR3ne8SvYf3AUAa6qdUO7t9MJpUQsFWsFtWD2G+XPZcuVy6qDDReBuRftp
         3+I6GpzakE7t9LInaXmOipsgTmkZuOJ3iFOeMAwB49LPhbbjBhWe+P8X5Jl+N2jSsT84
         LhdQ==
X-Gm-Message-State: AFq9FYKHvFGSa6B7E3Ud36VHHH5v9mkUFj4RoFPgCSI8pb+oS/yvuiaz
	fGyeqcA7g2qW7T2qr6jPKRY6Mk+XMvsg0z8+p9TIG3/5csz6t4+wu4u6ykNbJNllgNPmdDEi6YP
	VKvJ3VcfQYtzevNfuu+bsuls/6Y0m0RI/5mvKWzY=
X-Gm-Gg: AYBFou0GbEEGkvl8Y1pHv06iKDBomvgXHmLktv4A/5avbs6lXCPGzpS2l4qDy/9bHyA
	Y81MkuliSLjq6mEirJ9icOIe5sJcRxxxhpJ3nJjuxl9coV0Wod38YYUfBMkSZQyWSb1zgZkghrc
	1djankvMxNdYZHrqfefQD8qVubZFEkgPUa20zWxjHmVW0shwdU0VdQBwShE9u0iBjwtOnmBALZu
	qWDhWvmtCiFezGuGxcpySzQOWeeWFOvKYLtW7yL3e/AxxLgSMp2pGRzIhIQ6j9dFkGY0/lVMgUT
	bfEzckTJZmItw6wuF14y+93+/c9JD918QauJwJIhE1iUQ4Szzk4ckuRas+uE2tyM7pKr2UfWgmG
	lTpb1ILhrCOEctgMswo4+ADLz6P5Auk8PszxzMDvJj65VfRAV3SDWfHZvJNsWw6VQ/AnRPbE=
X-Received: by 2002:a17:902:ea0d:b0:2df:b004:df28 with SMTP id
 d9443c01a7336-2ea7c325c55mr21827375ad.35.1792774317250; Fri, 23 Oct 2026
 09:51:57 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Danny Heinrich <volleyballlive@googlemail.com>
Date: Fri, 23 Oct 2026 18:51:46 +0200
X-Gm-Features: AclHuK9tli8dHeyB3ZQGv6DOxN_LCyKY0ZncYoI4pxzcqgSAR7WaED26_Euogwo
Message-ID: <CAAg=yQ4JtRVpi1+RnwHn+ReWTe31Abz14kC52QFPMjX019RMSA@mail.gmail.com>
Subject: igc: I226-LM loses PCIe link in igc_suspend, root port GPE storm
 blocks s2idle afterwards
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On an HP ZBook Fury G1i 16 the onboard I226-LM drops off the bus during
s2idle suspend. After that the system can no longer suspend at all.

Setup:
- HP ZBook Fury G1i 16, board 8DE2, BIOS X96 01.05.01 (latest from HP)
- Core Ultra 9 285HX, s2idle is the only sleep state offered
- I226-LM (rev 04) at 0000:84:00.0, behind root port 0000:80:1d.0
- Fedora 44, kernel 7.2.11-200.fc44.x86_64
- Kernel is tainted OE by the NVIDIA out-of-tree driver for the dGPU
- No Ethernet cable connected in any of this

From boot onward igc logs this every few seconds to minutes:

  igc 0000:84:00.0 enp132s0: Timeout reading IGC_PTM_STAT register

The first problem showed up about 70 minutes after boot. From then on many
suspend attempts aborted right away with this message, without naming a
device:

  PM: Some devices failed to suspend, or early wake event detected

This happened 189 times. Each time, IGC_PTM_STAT timeouts appeared just
before. I can't prove that igc was the device that aborted.

About 3 hours later, one suspend failed like this:

  pcieport 0000:80:1d.0: Data Link Layer Link Active not set in 100 msec
  igc 0000:84:00.0 enp132s0: PCIe link lost, device now detached
  igc 0000:84:00.0: disabling already-disabled device
  WARNING: drivers/pci/pci.c:2198 at pci_disable_device+0xac/0xc0
  Call Trace:
   igc_suspend+0x19/0x20 [igc]
   pci_pm_suspend+0x99/0x1d0
   dpm_run_callback+0x62/0x170
   device_suspend+0x17e/0x4e0
   async_suspend+0x21/0x30
   async_run_entry_fn+0x34/0x150
  PM: Some devices failed to suspend, or early wake event detected
  igc 0000:84:00.0: PM: dpm_run_callback(): pci_pm_resume returns -19

From then on the device was gone from lspci. By the next day, GPEs 0x6B
and 0x6E were firing at roughly 145 interrupts/s each, and their status
bits stayed set. In this DSDT, _L6B and _L6E call GPEH on every PCIe root
port, including RP09 (80:1d.0). From then on, every suspend attempt woke
within a second:

  PM: Triggering wakeup from IRQ 9
  ACPI: PM: ACPI non-EC GPE wakeup

Over the whole boot, logind entered suspend 666 times. Disabling or
masking both GPEs through /sys/firmware/acpi/interrupts did not stop the
wakeups. The next poweroff hung after systemd-shutdown, and the machine
ran until the battery was empty. A cold boot restored the NIC.

Separately, on a fresh boot I get an RTNL assertion during runtime
resume, triggered by an lspci config read:

  RTNL: assertion failed at ./include/net/netdev_lock.h (72)
  WARNING: ./include/net/netdev_lock.h:72 at netif_queue_set_napi+0xe0/0x110
  Call Trace:
   igc_set_queue_napi+0x45/0xb0 [igc]
   __igc_open+0x2da/0x5b0 [igc]
   __igc_resume+0x13c/0x240 [igc]
   __rpm_callback+0x57/0x210
   rpm_resume+0x4fc/0x730
   pci_config_pm_runtime_get+0x3a/0x60
   pci_read_config+0x98/0x300

My current workaround is a systemd unit ordered before sleep.target that
runs "modprobe -r igc" before suspend and "modprobe igc" after resume.
Suspend has worked reliably with it so far.

I'm not sure whether the PTM timeouts and the link loss share a cause, or
whether this is a platform/firmware problem rather than igc. I can test
patches and provide full dmesg, lspci -vvv and an acpidump.

Thanks,
Danny
