Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A606456287
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386508; cv=none; b=ccgptAC+afFZQmi36Tpmt044EQYGokW1TMgpfjZysZ4b1yCE+p1QiL8zoeFJXpJl0iLvkULtG08e0jf2L610OM6ia4RY0czbGir5n+bluScLIgkGOG7Oyc2rg54v4yZuk7/3HHJVsPZFbB6+beUxsk6f+uTrLu+v+TL2A0YOEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386508; c=relaxed/simple;
	bh=0Guj2iAM9rWN/CLvhnq0IsQtN2pWPAV51fgIeanD29o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQszHO9FHt2+r1ePl3gK4vsmlF68gu9Na3M9IiQlTEGurnK5ms9RdWn8JiobkV3nOAQDQHITTrePxXVigjB0vcbAnc5kZ3BRzWhDPfGtmRt5ysrBXGK2T1z7DTiWISh/DYmjK5D6YpSJS6hHsErPo+KU9ocYEFf1hsVaFhtcS3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBkbEDhY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBkbEDhY"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a601ba6870so5893539a12.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 04:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789386505; x=1789991305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tq7uzj3Nuht/sUsnSMR7xKzenitos6XuGY/rnGcdmdg=;
        b=OBkbEDhYGyvH0mBBv8biu1quzB5LC89sEKXsC6GmpP7yEp99ea6ENr2WhWAI0uLDF5
         I+SCUNX7e4qDurDNx11cGZSVVNCGykyrfx41IjTEWO83ChFpx/HN/ER/jv4qu2GsE+G9
         G+OdRD18aLe4UQaiQ+67JC5KYyJ+mkW3koPZGur3bsGpweV+f8TpPwSwpk+CxV21l5N/
         MdrDPLIB+JYad+TdLGI8YhwktPl0Oep13IeR6Ck52bBm/iM/alZMnuBl5c89uzeD+j76
         ll+1HCtE2v4iar6W5rYbmJ9D1owwS5FLoRirFk8b9jiu+j4yaUtQVr/l+VEMH9In00LI
         r69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789386505; x=1789991305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tq7uzj3Nuht/sUsnSMR7xKzenitos6XuGY/rnGcdmdg=;
        b=fYwvEUeuzV6y0fOO/djL8F4opGl2CEy5s+YRPAY57l5rQ84C6rcWiR02qgrNCTrBOW
         j+B04XzspatgPDihnQ0otJir+lIyra9sg0wQRGFe9iF8+7eNl7R9gXatmFL6oOzzOeA/
         Yr9jhxdwMtnva2VdEnqvrk+IxrYj1CEaDyXH1k0oUmeXbe8EF48/WRqrzVSf2Yy9EkAo
         06ZN0os+6Napk3N0jIs4PUn6bz5WcOe7Z/rLv9mhWd+Q6GPSIKxUDn1ghGx8VvNgK+mN
         feJvoWzu6BrX9vEgs4Ombi3EDh5Ed50OnqmZywDsZ3ch64pEBXpoiRjcoU4YZVL7Yy3A
         uVrA==
X-Forwarded-Encrypted: i=1; AKwUvBz1G8gEOJD8Zpmv+N2OwhHA/RNUsREqX6kpeuqJ7X0N39xTDfUURCpFaCxhfzrHkoG86GxK9jc=@vger.kernel.org
X-Gm-Message-State: AFuF++nvfV3y6USWDiM1w9Wf6cVWgFjnVVTKIW10gHBBUTz/i6oo16Vt
	yodLbhPiaUN+MnW0k1laDSISiSj2btXkx+s/fhFaypX16ywHgCP7eKV4RITieIGM
X-Gm-Gg: AYBFou1G7LwdYQpJI/whX+OVJkDB2ASF37a1mQo9ZAmn4h+8sBAHAtq3gbSAMDVW0Qq
	QqnWgbGFLHw8LfRivjqEp/jQhNKdFuiJUp81ZIdUUj0E4e232zWhjzvaYgyl8dsyn5Xz6n3E4tY
	Ue7L+dNf5hNHblqT64DHQ8p2RqixMoTNyNFSNR2xjQRNGhd37D0WsWhIyvidlOLkpR+Ivv9gwoJ
	6AeecBvJuYcYltgSgZY0r8wEza4x9oye0o0mfEmXsDk4QW2VoxZhTzvowmTRMjy7TtUDstLBlh/
	PlK61b62WNDghdUCJuha32TZ95rq1O9vT0txw0ukmavZF02kkI9vQ0y+ucYCqsWnqiAleaKRuQQ
	Bf+6fppfrJNO39Ws0gF1pdh9B6X+h4LxRnr/2AOqcKF3ocVu803zJQQdhdUjdVfwl4o7ThY0k9t
	U7HojUlwPvQxTwceyqCOw7kEAD9EBfbK4p+K5mwle3/eq/EC0Ww+suebt9TOExok78U1jCtZhdL
	VU9AgUxc+ZZv6/XTblINMnkMtgBFEz+vNJY1kBA
X-Received: by 2002:a05:6402:249f:b0:6a9:9894:e4b4 with SMTP id 4fb4d7f45d1cf-6a9f63cd9ffmr1264857a12.34.1789386504591;
        Mon, 14 Sep 2026 04:48:24 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b59644f2sm3749062a12.29.2026.09.14.04.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:48:23 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Robert Hancock <robert.hancock@calian.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: axienet: bound TX completion cleanup by the NAPI budget
Date: Mon, 14 Sep 2026 14:48:21 +0300
Message-ID: <20260914114821.55503-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

axienet_tx_poll() passes lp->tx_bd_num to axienet_free_tx_chain() as
@nr_bds, and @budget is only forwarded to napi_consume_skb() as its
bulk-free hint.  Nothing limits the cleanup loop to the NAPI budget, so
the number of packets returned is bounded by the TX ring size rather
than by the budget, and the poll can report more work than it was
given:

  eth0: NAPI poll function axienet_tx_poll+0x0/0x180 [xilinx_emac]
        returned 96, exceeding its budget of 64.

Returning more than the budget breaks the NAPI contract.  It also makes
the "packets < budget" test in axienet_tx_poll() false, so
napi_complete_done() is skipped and TX completion interrupts are not
re-enabled on that pass.  NAPI reschedules the poll, so this recovers,
but the accounting is wrong either way.

In steady state fewer descriptors complete per poll than the budget
allows, which is why this is rarely observed.  Triggering it needs more
than @budget completions outstanding at once - for example when TX
completion interrupts have not been taken for a while and a full ring is
reclaimed in one go.

Stop the loop once the budget is spent.  cur_p->skb is only set on a
packet's last descriptor, so breaking there never leaves a packet
half-freed.  The check is skipped on the @force path, which cleans up
after a DMA mapping failure with a @budget of 0.

Fixes: 9e2bc267e780 ("net: axienet: Use NAPI for TX completion path")
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 782f903d318f..37309fa355ab 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -788,6 +788,13 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 	dma_addr_t phys;
 
 	for (i = 0; i < nr_bds; i++) {
+		/* A NAPI poll must not return more than its budget.  Stop on a
+		 * packet boundary once it is spent - cur_p->skb is only set on
+		 * a packet's last descriptor, so no packet is left half-freed.
+		 */
+		if (!force && packets >= budget)
+			break;
+
 		cur_p = &lp->tx_bd_v[(first_bd + i) % lp->tx_bd_num];
 		status = cur_p->status;
 
-- 
2.47.0

