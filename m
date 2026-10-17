Received: from dd30414.kasserver.com (dd30414.kasserver.com [85.13.131.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A00D4CF49A
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.131.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792232572; cv=none; b=HFpc1rSEjBIcOxqazxUutE2akLMl2JtiYR2+uvuJY0MrJac1D250APnD0RfWthfR1AFZAICqvkKxFH5o5ESCnCUJyGH3zh7ATerX4GMITwqTc13GZ5Ki+cjnwKGTzr8BFYihSUjMzERq8oK7V3GccbqsyMlFEZLXv6SE9EftnYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792232572; c=relaxed/simple;
	bh=KQ5Y3SFp+rDf/HB536cwooVe5quCPUbF8qOnVuc80g0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f6aW+vT5QecGG3yUOMK9IC2bI60dw4p0V99pRNoEJ5SsE6Ff7wiTO5k3hvtwpERkHrMAfXUN8twCwuJ6IIwZ7RUoDuZ7Yz718pO1Ta4zR98apqmKOUkRLaRE97xJSyoqgz3Ouz2WjXpdlcwSvmUt2Rc0k4lkMUTn0AgUMUoEZFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mser.at; spf=pass smtp.mailfrom=mser.at; dkim=pass (2048-bit key) header.d=mser.at header.i=@mser.at header.b=oMsTZbY4; arc=none smtp.client-ip=85.13.131.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mser.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mser.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mser.at header.i=@mser.at header.b="oMsTZbY4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mser.at;
	s=kas202607210106; t=1792232140;
	bh=CGhY1j5WWDRuIQj1Il7dEANey+L6PXZwc9JnpFqRboE=;
	h=From:To:Cc:Subject:Date:From;
	b=oMsTZbY4SL7Xi8DAu7d/aYpI04VzQeovBO2rxmS5R/uHmY9aW/SZPNQpQT9mgw0QC
	 ALCieFKw+h0uil7LISnJhn/9alBJl6BlJ4omtxuBlW9m4LStW5E/GtefAmmW2EjtH1
	 zky83O+NEaQwu3hXTrme2rzfEXQkQM2vRN/rzn21HbGRzNE0+46hC7+F8KpOb7NubH
	 Sd1apTyuna3Ae8wBZdtjx3szk+0HYvgn5nuwi1ZWPp08TnCtOQMYOo5Cq0GrLd/oA5
	 jOweDd3qS0o2yaqw6+HXhmqc92GkadEK2DbywCIG4345wQE+JpBtGYBhAyoahxpnpK
	 qMx9zS6WlqDjA==
X-KAS-Sym: v3:f51bdf72230551df:KL96b82JnBvxBVxJ3ViTV0fFYexrc9umwBgZIAwwdJqGj
	3xyZaY9+eM4tTRkccUcGnXxh4f+qznOGrs/Adhj6Aj5XC4gXBW820R191HABSXM9NidEeN8E3+n
	gVxLZ6gtfo/1dFR0VfKpdLCOfcFhokqbmlZPFzn6XWTcXK41SjHCIfHFeV02ONZgDDYJPoQvjrZ
	Ax7xtyt3COMA8LZNdDJ9/CNad2eImpPJJmsCuhu8nn0/3wWEOeMyl90Sfg5s4XEdh2Tq49GkLv8
	qRUXBFZuMCYaQ6ovFpVzGB3eb4BCZCltS4fZnmZdUWOkM2dVCx0GLrkITY9aNf6ZWhR7ALYw==:
	nh7ikQqpUbBvYN27iR3kwS86UFVfHADlVzoJ6g4o98k+QEQpBybMAf0mqk3ohV2KHr27595+D1m
	pixJjhcsnAW7jR/eQG2g1yOiSvgHjEhsSm5mTwi6eJc8+CSe357SZSBY/HC9DnyGKSyvwJ9iTaF
	G1oRxldyRUtH1C/bXmhGjkmS+isfg5yyYI2Q5ovORX2IC0pZrIv5H0R2d72YDeK29D7WZdlxEzp
	HuphS4qfGKQ9XBemxozNiFwECAwH1qhMa+HJfB2GNz0QTdDn0+aikSD6lSSgCrH0CFfnFC7Ftw8
	OLmG0xvvM8y/pS4Hx99dcM6+/m6wLh3hpoclx+8mkl7eudJFucquVXzhuiNmpUdJlANmS+NKGme
	Tq7G1CHMW/zbC2BYa4JFYKHY/SgxSPfRrsowjV2s/KdLsfSHS5XBZ+vLJe2zb1j1TZd+2cNfCqo
	1C+xftq/iI7EHlpXmxggHcevXP7a9X1yH0oHr9f1UaEyhfwC0f77NJSQ0g1jFfqKbjuBO4lvilA
	UtV0nBXrTajJlV/Pbwuub+gdDB50y/ttU1kiemsoCYPlG0=
Received: from report.eml (178.113.74.246.wireless.dyn.drei.com [178.113.74.246])
	by dd30414.kasserver.com (Postfix) with ESMTPSA id 232617F047C7;
	Sat, 17 Oct 2026 12:15:40 +0200 (CEST)
From: Michael Serajnik <dev@mser.at>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Subject: igc: I226-V does not wake from S5, PHPM D3 link-disable bits never cleared
Date: Sat, 17 Oct 2026 12:14:45 +0200
Message-ID: <179223208565.28107.1987245697366860479@mser.at>
Content-Type: text/plain; charset="us-ascii"; format="fixed"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Bar: -

Hello,

Wake-on-LAN from soft-off (S5) does not work with the I226-V on my
board under Linux. As far as I can tell, the cause is that igc never
clears the D3 link-disable bits in PHPM, which the NVM sets.

Hardware and software:
- Board: ASUS ROG STRIX B850-I GAMING WIFI, BIOS 1063 (AMD B850)
- NIC: Intel I226-V [8086:125c] rev 06, subsystem 1043:8867,
  at 0000:0a:00.0 behind an AMD 600 series chipset downstream port
- NVM: 2023:889d
- Kernel: 7.2.9 (Fedora-based Bazzite kernel); the code paths below
  are unchanged in current mainline

What I see:
- `ethtool eno1` shows "Supports Wake-on: pumbg" and "Wake-on: g".
- BIOS: ErP disabled, Power On By PCI-E enabled.
- /proc/acpi/wakeup has the NIC and every port on its path enabled.
- After `systemctl poweroff`, the port LEDs go dark, the switch sees
  no link, and a magic packet from the same subnet does not wake the
  machine.

Register read:
With igc unbound (strict devmem refuses the mmap while it is bound),
I read BAR0 + 0xE14 (IGC_I225_PHPM):

  PHPM = 0x00045298
  DIS_1000_D3 (0x0008), DIS_100_D3 (0x0200), DIS_2500_D3 (0x1000)
  are all set (mask 0x1208).

As a sanity check, RAL0 (0x5400) read 0x62e7fcbc, which matches the
MAC address bc:fc:e7:62:d6:2f.

These bits come from the NIC's NVM, not from the board firmware, and
FreeBSD bug 282140 (below) reports the same link-disable bits on other
hardware, so I do not expect a BIOS update to change this. [1]

With all three speeds disabled in D3, the PHY has no link while the
device is in D3, so the magic packet never reaches the MAC, however
WUFC is programmed. In mainline igc, `__igc_shutdown()` sets WUC,
WUFC and CTRL.ADVD3WUC and calls `igc_power_up_link()`, but nothing
in the driver clears these PHPM bits, and igc defines neither the
bits nor a D3 LPLU operation.

FreeBSD's igc(4) has the same problem: FreeBSD bug 282140 describes
the same NVM default (PHPM 0x00045398, same 0x1208 bits) and a
proposed fix that clears the D3 link-disable bits on the wake-arming
path and restores them when the PHY is powered down.

Could igc clear these bits when Wake-on-LAN is armed? I have not written
or tested a fix.

An agent (Claude Opus 5.5) helped me analyze this problem and write this
report. I ran the commands and checks on the machine myself and read up
on the background, so I can follow the analysis.

Thanks,
Michael Serajnik

[1] I have not updated the BIOS yet because of reports of dying Ryzen 7
    9800X3D CPUs (the CPU in this machine) with various BIOS versions,
    and none of the newer versions' release notes mention anything
    Ethernet-related.
