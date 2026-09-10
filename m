Received: from mailer241.gate86.rs.smtp.com (mailer241.gate86.rs.smtp.com [74.91.86.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3504854EC
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.91.86.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043897; cv=none; b=jSY4m0ezh4QBkkr6tGpGi/K0fJvedUbHh3HPvSmJoVRuZu3+boKJTXmxBFkSJs5pnalN0kc1M4ob+bUUI3jmRyX6ANKuELwhdFahzaWVeZLFFKbLX57Dcu5K94ErFENGP8FH7qAzvB6FEcgY41351WAu1j/rGA/nVzgXvkaK9QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043897; c=relaxed/simple;
	bh=w2lh7ptEnPTKkoQwNFhNxV06/VvmaNakq+TNlN/nnRU=;
	h=From:Subject:To:Content-Type:Date:Message-Id; b=PU+4EPFyJLhjPVYYCsZecxin8tt4UarB+FxilWsyd1UquM9PSm5JP/3eCnTRC3Xks0WX4MoBVuYmgTilYCjeXC3neoUh40vYNlh6gZFV1XyN6sPUwO3/0J6Cw+lV4RH6Jq4C49BXPO+ohyotYKfGSoJIz5n2Q8oFHzyqKjetOT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=computergamingpc.com; spf=pass smtp.mailfrom=computergamingpc.com; dkim=pass (2048-bit key) header.d=computergamingpc.com header.i=@computergamingpc.com header.b=nFW7Kkt/; dkim=pass (2048-bit key) header.d=smtpmessage.com header.i=@smtpmessage.com header.b=Eq2Id9UP; arc=none smtp.client-ip=74.91.86.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=computergamingpc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=computergamingpc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=computergamingpc.com header.i=@computergamingpc.com header.b="nFW7Kkt/";
	dkim=pass (2048-bit key) header.d=smtpmessage.com header.i=@smtpmessage.com header.b="Eq2Id9UP"
X-Report-Abuse: SMTP.com is an email service provider. Our abuse team cares
 about your feedback. Please contact abuse@smtp.com for further investigation.
Received: from [10.0.16.4] (unknown [10.138.12.176])
	by s0-aws-app2-mta-out-2 (Halon) with ESMTP
	id 2eaba121-5f2f-44c0-8927-933187284c1a;
	Thu, 10 Sep 2026 12:38:14 +0000 (UTC)
Received: Received from 10.138.12.155 by Caffeine
 (s0-aws-app2-swarm-manager-4) with SMTP id
 26fb8623-0c98-4efc-aa6c-22a4f1659b79  for netdev@vger.kernel.org;
  Thu, 10 Sep 2026 12:37:32 +0000 (UTC)
Feedback-ID: 9194450:SMTPCOM
Received: from ObaTech (unknown [191.177.202.135])
	by s0-aws-app2-mta-in-1 (Halon) with ESMTPSA
	id 26fb8623-0c98-4efc-aa6c-22a4f1659b79;
	Thu, 10 Sep 2026 12:37:32 +0000 (UTC)
From: "Computer Gaming pc" <sales@computergamingpc.com>
Subject: Current Inventory Update: GPUs & Enterprise SSDs Available
To: <netdev@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Reply-To: <sales@computergamingpc.com>
Date: Thu, 10 Sep 2026 13:37:33 +0100
Priority: urgent
X-Priority: 1
Importance: high
Message-Id: <2026100913373275D4062729$6F4CF24353@computergamingpc.com>
X-SMTPCOM-Sender-ID: 9194450
X-SMTPCOM-Tracking-Number: 26fb8623-0c98-4efc-aa6c-22a4f1659b79
X-SMTPCOM-Message-ID: 25e1b2bf-a4a7-43a2-9361-8a98686f1be6
X-SMTPCOM-Payload: 
 jQzpeBuGvwGUqJuaN4OYgRe3Ic_XizPmlJG3VmGjJ9LUcTKGeg8LD4OkEL6f4GfrPwbdRkJzrsY8ZmuL0kPC9A2DkFoVzMoO6kBjPnpI16wx8Z3kXafQvg5GGUqMFOV8aaRzqL1A2gmffMaTCZJqRs4F5QzrcgUlnSyKbJUC3xj7V1v15ZE3nz0pBR5d5ITr
List-Unsubscribe-Post: List-Unsubscribe=One-Click
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=computergamingpc.com; i=@computergamingpc.com; q=dns/txt; s=smtpkey;
 t=1789043884; h=feedback-id : from : subject : to : content-type :
 content-transfer-encoding : reply-to : date : message-id :
 list-unsubscribe : list-unsubscribe-post : from : subject : to : date;
 bh=w2lh7ptEnPTKkoQwNFhNxV06/VvmaNakq+TNlN/nnRU=;
 b=nFW7Kkt/7w3SJDWq6EibFLc9cR4EXFVIUh+eJpvo+VE0uslsk2Hz22RgZUPFWVPiFZp+L
 gz6bCxutxGXdJH/gIV4xSgUO0PFUoXgCqWtOMqKmwp2az0/BRFcGsL23sdmlRD8Lw/X8/Wn
 OlGN0J22OipSLGK/k2A4feSlziFaxgKglSdCY0E4NJpNPtnnB+yOvgWN58HLLGP3is/cfi5
 nSXzrkQ4aW5HnsktSRt9aUN5dHqWE8tqt+5d7hFd+kS/nFRkP3+5ln+/JeKnqyYHJWobEy9
 9mmHxD0IZyeMKKsMLsjf1AmtNb2nQt99Hp5zaYWuCsyyOofx2W2/YXAJgcDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=smtpmessage.com;
 i=@smtpmessage.com; q=dns/txt; s=smtpcustomer; t=1789043884;
 h=feedback-id : from : subject : to : content-type :
 content-transfer-encoding : reply-to : date : message-id :
 list-unsubscribe : list-unsubscribe-post : from : subject : to : date;
 bh=w2lh7ptEnPTKkoQwNFhNxV06/VvmaNakq+TNlN/nnRU=;
 b=Eq2Id9UP5/bQFXnHChUxm8raWQ0OmEH3PTjI5A4KjJGey0N3XG0MT+wQ81zr71qnK8vHV
 9diNGsugBpqceApFwm7lwjN7zRwequKOyStWs14VjXrr0sPTEKjmyaYBE03NvJz09fRb2Cy
 BrtmbOkZ7RB8v2tN8fHkl2UXOaggftdjXlL6BFS8zDGc4DA0MuSNqXeyA549Rn6Kq9MvdgV
 L+6ymzZb+S5aXSs7scihoklvZcCx7zK9SqmHJXiAdt5tmwptv1GHrAQjvc+yTPt4ydh+wAd
 8O37cV+rYac7bHwEOKaAqlAYYwfnLDLdHBeE+b9AHatQJZWv3XK4VJgPOzdw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Dear Partner,
We’re pleased to share a current snapshot of our available inventory for 
immediate dispatch.

Memory Modules
* 128GB 4DRx4 DDR4 PC4-2933Y REG ECC LRDIMM (Qty: 980) – $140.00
* 32GB Dual Rank x4 DDR4-2933 CAS-21 (Qty: 1,500) – $1,140.00
* 64GB Dual Rank x4 DDR4-2933 CAS-21 (Qty: 1,200) – $1,450.00
* 32GB Dual Rank x4 DDR4-3200 CAS-22 (Qty: 1,500) – $1,150.00
* 64GB Dual Rank x4 DDR4-3200 CAS-22 (Qty: 1,100) – $1,450.00
* 32GB 2Rx4 PC4-2400T (Qty: 1,500) – $45.00
* 32GB 2Rx4 PC4-3200AA (Qty: 1,500) – $45.00
* 16GB 2Rx8 PC4-3200AA (Qty: 1,500) – $20.00
NVIDIA H200 NVL 141GB — Qty: 10 — $26,500
Nvidia PRO 6000 96G Server Edition - $10,000.00
RTX 5090 Founders Edition 32GB (90 units) – $2,800 

Solid State Drives
- SSD SATA 6G 3.84TB SFF (Qty: 450) – $120.00
- SSD SAS 12G 960GB SFF (Qty: 470) – $300.00
- SSD SAS 12G 1.92TB SFF (Qty: 560) – $350.00
- SSD SAS 12G 3.84TB SFF (Qty: 560) – $150.00
- SSD SATA 6G 1.92TB SFF (Qty: 450) – $100.00
- Samsung 990 PRO 1TB NVME SSD QTY:410 - $150

- HP (HPE) P43331-B21 64GB DDR5-4800 RDIMM QTY: 390 - $1,750
- DDR5 64GB 4800Mhz ECC RDimm 2Rx4 P43331-B21 (Qty: 500) – $1,750.00
- DDR5 64GB 5600Mhz ECC RDimm 2Rx4 P64707-B21 (Qty: 500) – $1,750.00
- DDR4 64GB 3200Mhz ECC RDimm 2Rx4 SK Hynix (Qty: 500) – $1,450.00
- DDR5 64GB 4800Mhz ECC RDimm 2Rx4 Samsung (Qty: 500) – $1,450.00
- DDR5 64GB 5600Mhz ECC RDimm 2Rx4 SK Hynix (Qty: 500) – $1,550.00
- Intel Xeon Silver 4214R - QTY: 420 $350.00
- Intel Xeon Gold 5220R - QTY: 410 - $450.00
- Intel Xeon Platinum 8380: $450.00 QTY: 410
- AMD EPYC 7542 - QTY: 490-- $380.00

Storage & CPUs 
Samsung PM9A3 2.5" SSD PCIe 4.0 7.68TB (115 units) – $650 
7.68TB SAS SSD 2.5" 12G Server Drive (140 units) – $650 
Intel Xeon Silver 4214R (120 units) – $300 
Intel Xeon Gold 5220R (130 units) – $300 
AMD EPYC 7542 (97 units) – $450 
Intel Xeon Platinum 8380 (95 units) – $450
HFS001TEM9X173N PVC10 NVMe SK Hynix 1 TB - $85 (500 unit)

For quotes, availability, or inspection scheduling, please reach out 
directly:
sales@computergamingpc.com Call or WhatsApp: +1(774) 559-1248 | +1 (641)232-
4364
Thank you for your continued partnership.
Ann Kamila
Computer Gaming PC Trading
2500 US-6, Iowa City, IA 52240, USA.
