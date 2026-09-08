Received: from sg-2-2.ptr.blmpb.com (sg-2-2.ptr.blmpb.com [71.18.227.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889D582BB2
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885244; cv=none; b=jZxK47Nk0Oc1TcOubyR7nCFm3XzZ+v28POVAK03vjAgYvYjofl7i7k5eMKw2XpIRmn8JpfxNn5y4X/gIMTFIJGJhnRU4ZUgQDCOjrWW5Zm0Vnc9DEATQVvO+BVARBVSprquKHISe0izZiAmtM/ASPD7jDSZJramt7LADTFbPWVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885244; c=relaxed/simple;
	bh=4PWeVwZklsxBELa7PilCTz0ljdxc8I/fxpQlz8ppqaM=;
	h=From:Date:Message-Id:To:Cc:Subject:Content-Type:Mime-Version; b=ZK6SuNgAERidr0rHVUD9E4L924zKm77ZA0Eht8Q2dCfcX7/9pNRScRJl+1J4D9LwanrsrjJZrRKHLrrcasvXEdUPd/iJ7w2GxDJlv4lRWxFJs2z2CCy6KuBEW95cjXaGYnEhFDfGb0s5PxgolLbRyTYn7vEAmpTnukW0BgxNjZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=Ga6vS0RM; arc=none smtp.client-ip=71.18.227.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="Ga6vS0RM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1788885230; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ATYwopDq3lOeKRynyx5bJtLt5Assf/MvZRtPVsMMab8=;
 b=Ga6vS0RM1ljoSbbhFWuBmHpKE6GcrbuPCnX8hgY493uUmuo1Ra/zvXbsW7I/H4Xyy3A1zU
 jyiQxykhRGj2t3q727J1v94Y92kvD3kNu3xzdYnS+YJiIGldRg2aHkRGQp9BznzzAZi6ct
 s44PYkU9PfyJQk0LYzxJsL7Tng7sRq0D+4mJE7Qz8nJgEwIM/wjW5i+XsGJj/bpNjbpoGp
 Eu+bPsjVGCq1NoCVr8lyC7WzHblegzAK+5WFFr/S7zsrOCfkCTqDJJ0UOTeTfTAZXeWSfj
 1n90ms4+lCWtdhTYJNEClyMirFIFD58NZLVBOWFPSm0h/L2vz6tCjuBU+XMa3A==
X-B4-Tracking: v=1; b=H4sIAOc4oGoC/3WNQQ6CMBREr0K69pv+WkBceQ/jorS/UhfQtKXRE O4uoAs3LGcy897EIgVHkV2KiQXKLrqhX8LpUDDdqf5B4MySmeCi4g1HsKTBJw/eR6BMfYJRWTB a19iWhKblbPn6QNa9Nu6N9ZTY/VvGsX2STitxnXUupiG8N3vGbfwTyR1RRuDQKCtl1ZJUiFfdU QhHrTdFFv+Q8x5ELBCh0JQ1ClSG/iDzPH8AEycceBUBAAA=
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Received: from [192.168.9.107] ([111.42.148.75]) by smtp.feishu.cn with ESMTPS; Wed, 09 Sep 2026 00:33:47 +0800
X-Mailer: b4 0.16.0
From: "Shengzhuo Wei" <me@cherr.cc>
Date: Wed, 09 Sep 2026 00:33:43 +0800
Message-Id: <20260909-fec-ptp-pps-event-uaf-v3-0-bead12c29a16@cherr.cc>
To: "Wei Fang" <wei.fang@nxp.com>, "Frank Li" <frank.li@nxp.com>, 
	"Shenwei Wang" <shenwei.wang@nxp.com>, 
	"Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, 
	"Richard Cochran" <richardcochran@gmail.com>, 
	"Troy Kisky" <troy.kisky@boundarydevices.com>, 
	"Fugang Duan" <fugang.duan@nxp.com>, 
	"Lucas Stach" <l.stach@pengutronix.de>
Cc: "Simon Horman" <horms@kernel.org>, "Phuc" <phucduc.bui@gmail.com>, 
	<imx@lists.linux.dev>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH net v3 0/2] net: fec: fix PTP clock teardown races on device removal
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26aa038ec+27c1be+vger.kernel.org+me@cherr.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Change-Id: 20260901-fec-ptp-pps-event-uaf-dcc71b5e1db0

This series fixes two FEC teardown races: ethtool can access a freed
PTP clock, and the PPS interrupt can outlive the PHC and netdev.

I have kept the main Ethernet IRQ issue discussed with Phuc [1] out of
this revision. His PTP initialization error-propagation changes are
also separate; if they land first, the new probe failure path will
need PPS IRQ cleanup too.

The bugs were found by code inspection; no hardware testing was done.

[1] https://lore.kernel.org/r/CAABR9nHLcR103aADF1WMSEkw-_BjWB9vyWXENJCYfjX5Wz1nkw@mail.gmail.com/

---
Changes in v3:
- Use request_irq()/free_irq() for the PPS interrupt and drop
  unnecessary braces in patch 2, as suggested by Wei Fang.
- Patch 1 is unchanged.
- Link to v2: https://lore.kernel.org/all/20260908-fec-ptp-pps-event-uaf-v2-0-2a1d57121ade@cherr.cc/

Changes in v2:
- Drop the ptp_clock_index_by_dev() lookup and unregister the netdev
  before fec_ptp_stop() instead, as suggested by Wei Fang, so the
  netdev callbacks are drained before the PHC teardown.
- Use -1 as the "no PPS interrupt" sentinel so a valid IRQ 0 is neither
  skipped on release nor freed when the request never happened.
- Link to v1: https://lore.kernel.org/netdev/20260904-fec-ptp-pps-event-uaf-v1-0-9af446be4a11@cherr.cc

---
Shengzhuo Wei (2):
      net: fec: stop the PTP clock after the netdev is unregistered
      net: fec: free the PPS interrupt before tearing down the PHC and netdev

 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c |  2 +-
 drivers/net/ethernet/freescale/fec_ptp.c  | 12 ++++++++++--
 3 files changed, 12 insertions(+), 3 deletions(-)
---
base-commit: 548e7bcd0c5460ddcbca9600cea603ebeebf4da7
change-id: 20260901-fec-ptp-pps-event-uaf-dcc71b5e1db0

Best regards,
--  
Shengzhuo Wei <me@cherr.cc>
