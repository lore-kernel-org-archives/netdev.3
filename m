Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB3286AC
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790986082; cv=none; b=d8RKZn57Lf/7K/hMrItBcU5wInw7ryNptVHW8J/9X9Sd3lGRwiUN3WCb1pGw4GVl477TT/gchKPofGdMQTSRAnB8Iu3GVgQrAOU6V5RehUS9oDZ7UZGwdxDBh3HDTUxfDad+X6ImWzXwPFXyzsj9CpM9QPcZyIk7k1DV642m3ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790986082; c=relaxed/simple;
	bh=Tp8H9tqO/zqLYh0jrnKq2sL1/ck2X0RZ1Ip9X9AZcDU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sYsqEqFbaqGexSV8S2fsFz9/UMIowJdz1dbuzCat9uGhyeHMuJqDw53xVumUmfrrGnbuCjhBedYgGye/fWebBOEsEkZgGv8nkLa1grXSLv+V1/Q17HqdPXW+Syzr9X2iTthvWdyNRWOnj3u8DY0MTQ7nYaMZ89bihIK8AsKeIsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=N/G3RUci; arc=none smtp.client-ip=79.135.106.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="N/G3RUci"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1790986068; x=1791245268;
	bh=zbBnf0OjFPWQn7EnEDmlbEbl958cnPIq1bvithgIshw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=N/G3RUcibsV1YC3gF64iSXIAdzXSptZYNKxURBh01U/3qegKpF1hjtGSt2rqt7Jfl
	 QrOZ6XT/j4tg09DVjM6UUFr6bNJgjSaQzX0QhTbjRHWm51pCtMxlC9qlcMlzhyL6Lo
	 w7fPbBWmuKypVMGt1pSQBVrMK4o9ZNI9Qn80/G69QwabZs2uE/e4/Btb47RYz3nFtK
	 pWEmTb14Mzk3e+jvFLLmszpirWVh6VXNYtITPchZxXNmMNGAhwXZRYZ7tZoJm3Mxut
	 iPo45peRnRrGxYAWxz15l7a3meAhb5axMqVaNN4xwFSqGOzn/1HJj3HoMe7RYzRns/
	 zAY+cnx2+DDVg==
Date: Sat, 03 Oct 2026 00:07:43 +0000
To: netdev@vger.kernel.org
From: iugfdin <iugfdin@proton.me>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 0/2] r8169: fix checksum eligibility and failed TX batch progress
Message-ID: <179098478409.1174319.4377246796187959500.r8169-cover@proton.me>
Feedback-ID: 225708956:user:proton
X-Pm-Message-ID: fe50010e9753d154c2ef7d84e66feac09bb81a25
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series fixes two TX-path issues found while investigating a report
of loss with an RTL8125D 2.5GbE controller (PCI revision 0c, XID 688).

The first patch preserves hardware checksum eligibility when a packet is
already at least as long as the padding target. The second ensures that
a failed skb does not leave previously committed xmit_more packets
without a transmit poll request.

Neither patch is claimed to resolve the reported physical packet loss.
The reporter observed 10-20% loss, particularly at 2.5 Gb/s, while a
vendor Realtek driver/firmware combination worked. No affected NIC was
available in the development environment. The reporter identified the
loaded firmware as rtl8125d-1_0.0.7 10/15/24. A possible firmware-related
cause of the reported loss remains under separate investigation.

The series is based on net commit:
6dc989ea46b96ce170840174b4a38c4a387fb005

Verification:
- The patched r8169 objects build with Clang 23.1.1, W=3D1, under x86-64
  allmodconfig and allyesconfig on that net tree. These are driver-target
  builds, not full-kernel builds or boot tests.
- A userspace harness extracts the production functions at run time,
  with modeled kernel/DMA/MMIO boundaries and ASan/UBSan. The checksum
  matrix changes from 42 failed assertions out of 85 to zero; the TX
  matrix changes from 40 failed assertions out of 102 to zero.
- The matrices cover normal IPv4/IPv6 TCP/UDP, short and PTP padding,
  transport offsets, GSO, ring wrap, successful fragments, failed
  head/fragment DMA mapping, allocation failures and queue accounting.
- Both patches pass strict checkpatch and apply cleanly to the net base.

AI assistance was used to inspect the driver, compare upstream/vendor
behavior, develop the fixes and source-executing harness, and draft this
submission. The investigation started from the packet-loss report; it
did not establish either issue as the cause on the reported hardware.
The patches carry Assisted-by: LLM.

Patch 1 fixes 8d520b4de3ed ("r8169: work around RTL8125 UDP hw bug").
Patch 2 fixes ef14358546b1 ("r8169: make use of xmit_more").

The two changes are independent, and the complete series changes only
drivers/net/ethernet/realtek/r8169_main.c.

base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005

