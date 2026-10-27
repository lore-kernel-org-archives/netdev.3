Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132561;
	b=xOHiKzlDoGA6J1d4wR3vwbQYc7XXm0lLs3SjEaqCRhSwtR/mvpKXJqNxY/rdNhrlGreH
	 KCAEfEOR4KT/wx9Ds1l2X6dJdaXmk7l4x2OfmxCszMcHlzS/9lh1zvEaWBQWmDv/oQznJ
	 4Ou/mGkm6pEnBMCWSJpHkKwDBOc0MifWfehoMA61gQ45Pa0V2aAPTCs43ysGefbGuPU5r
	 qOv8NTrR9IG1mFmmffIe1lY0TpKtDvD+hRJFJqn5HcehlSA+WJrUeR4/7MJfbSa3sihqe
	 y1EMtNXgo3EoO2UnCsgN3T5fQ2XMz0tQJFBA1cWeIQC88JmKaVvIGp0PgYlxHl+NaKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132561;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=VUv6HB4C2stQq3xByuoC9CaZvjSaPUQ+4hRcV5y8Phg=;
	b=HhnGeRej+gxnGqOJGRyfcSiPaOWrNJC9YdBMZJr8tiNCPDoADeeSFTxCk00izdHpa+Cw
	 ox9RredM+L4t4fexmJ4ungX2MJ1AK7RmOJSwOJ6k4M4TXYKYb/UQz2sTSrh1Cb/BDF/ix
	 Tw08MYbNIxsMWY37iLU6cnhGAFIgVGefxXK71jVED8KgVhHskJkXnr8Dt3ApKTH0L/1VA
	 w69guaKTNI3PGnZlW4801/D/bDxLBXTLNPzlrKqXrUSyGi+su3NH0NdtgYWMOrn/A8zP6
	 zOyG8eaHd8vzmaXaoBAp2xxAQbdqbYvJttwKC01Hn64uP0DaI68Uz9JlOnhtWCKmeBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VY431Kqr;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8970606B5E6
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 20:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8970606B5E6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VY431Kqr
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso221941a12.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793132560; x=1793737360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VUv6HB4C2stQq3xByuoC9CaZvjSaPUQ+4hRcV5y8Phg=;
        b=iVKExXrb8YqdWH5L//+OdOJU+4croU8BeYsVBINB7qqUQxOtwxX7GYE6MSgXyQecVP
         fC35WfL9ifwxv/Cb9x4+7jRmoO2UXh/Zzm1t6Lwq4NAsSwemC3ltGq2rp/YSVIk3d184
         IebQU/KMDqybi4QPtHuc5Guh5bokBqc4mpvvx3xX58R6p5ZB1PZbSXpqlqD/FbeYUaD8
         KXbTnbmtAlrLJqyVHM8wf14sNClALcCmzqNOg7iaRpmHlIrYBoQpFy1XRQ9IsjL1bh+v
         s5gfT11P411B7NOzMAAMvOq0hdowPfvAfoO31w3XbMqqX/jL2v17Uhz0WIut82w1MSg9
         Ui4A==
X-Gm-Message-State: AFq9FYJCXxA079we6J2lgyghJ16+cjGKYGCwFbbXlUGU2w4tOgMpBQSh
	A+tsbPvbWxqj40oMGpgYu1u9VtV2ab4qh/6zj0QWks6cqgyLd73ZHoVQz372xezaSjcBj6eHfYY
	pWVg3/fJSXLtSqp2jfXyEQroBYcuqSZd/DfsA4Hz9JGdBS5VXuwx4qsldavRwl1KtTo0B5GLGSE
	TvkOUziKWxp3ZUJQhP+8WonyQqfdkyHxoMRNRL2njGiAu0qmLsOObuHFQuBa9HTNrP52DzxLhiZ
	dlsM8YSTGANZyX+aEA=
X-Gm-Gg: AYBFou15IAsyEqONzqEOGNUd+yOyr/MLuucZmyYtQLDGycb5Eiga6/yZ3+eg7HeD37B
	aiUa6D7JvwQpdFP0ZFCxBOjqHS9iBKWIK+o1lLQqiZ16JmyEYh5RYfFfsgUyB25mQp/CGC5eHkz
	1ca5visrojMph93zkKB8bJwB49qudWRqesRrFlV1YWnOp46wKYQjtKlB3MoqQRw4JFlAps37mYL
	Q4k5S2LNauAMMk09K+Xt91cwDeRIH/8cWKITmYaUPDNyRyns+CneoQNXBdATiuw9euOIH/HDODx
	/asRyhMPhZOPsSAij7JT6gAHQGaGorREUWWeoc61DukGZ9jFsLzfmqvKeH+qmMD/pXuh51w1qI/
	zighUUbQudyycsfTCSyBrX3SYrKe11PFMynGrdNd39QAf/7gYiHycLPcysn6xuGtRF+M78FKqll
	ronrMnKf/VqdUS/FnymB4Cx+3RENUPoY/HAbj/fZjs
X-Received: by 2002:a17:90a:f944:b0:3a8:9d0d:ca50 with SMTP id 98e67ed59e1d1-3ae57f639c1mr129203a91.10.1793132559753;
        Tue, 27 Oct 2026 13:22:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae57a6ece8sm66790a91.4.2026.10.27.13.22.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 13:22:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3abfcf726dcso372564a91.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793132558; x=1793737358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VUv6HB4C2stQq3xByuoC9CaZvjSaPUQ+4hRcV5y8Phg=;
        b=VY431KqrW0K+sd9uY8uk1QJgNvOQ41AV3EtmrmpYyZ7DyC68OzKmvmUANysDut3t9H
         2yW3JjaRqFCc1+3HaoQp4WOUyLWRqz508sj6ijxqgltNgq5VC+g8lbD6NE2SWVuY66KC
         88MUAB3r948A28TRPb5L2csgdqnRV0AhwyZL4=
X-Received: by 2002:a17:90b:57e4:b0:3ab:27f0:c90b with SMTP id 98e67ed59e1d1-3ae58140325mr148377a91.53.1793132557659;
        Tue, 27 Oct 2026 13:22:37 -0700 (PDT)
X-Received: by 2002:a17:90b:57e4:b0:3ab:27f0:c90b with SMTP id 98e67ed59e1d1-3ae58140325mr148343a91.53.1793132556871;
        Tue, 27 Oct 2026 13:22:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d1650csm275486a91.1.2026.10.27.13.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 13:22:36 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 0/5] net: dsa: b53: Preliminary fixes
Date: Tue, 27 Oct 2026 13:22:25 -0700
Message-ID: <20261027202230.3539646-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patch series contains fixes to issues reported by Sashiko on the
b53 PCS bug fixes being submitted, and then some more that came from
code review and testing.

Florian Fainelli (5):
  net: dsa: b53: initialize the jumbo frame size register offset
  net: dsa: b53: fix the SRAB grant timeout check
  net: dsa: b53: clear stale state when creating an ARL entry
  net: dsa: b53: reject conflicting mirror destinations
  net: dsa: b53: use the correct override register 2 Gbps bit

 drivers/net/dsa/b53/b53_common.c | 42 ++++++++++++++++++++++----------
 drivers/net/dsa/b53/b53_srab.c   |  2 +-
 2 files changed, 30 insertions(+), 14 deletions(-)

-- 
2.53.0

