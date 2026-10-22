Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703479;
	b=AsjJu0E34uhJxrPXXtcz8KIEMndzxB2yPOwjZiyD9QZcE/p366H7OECRq/UpS7SV0oWZ
	 KZKYdz85rtnlg9W//6MhOpSzbmcOQhxTY7gEDXi5ZpfEyvZNaRtv48CtGQTkbPt845jfn
	 bVAJZZhd851t90AhtPVM+vYa7gXEj0lzXfxe48LgmUVm5qHlFD/0x0pLJ4nCoRybTtNXz
	 ei4OKDPMgtM9ZwVehRNWn4jxnptiZrb4g6nPS6VkSAxgF7E9IPmjwHoSOzvRCygUEnITD
	 wMo2O80ACG2ijDHFLAlj9kuRMASLtud0age+YQNHe2iNFwBE8RJOIt47UMAMNGi+LHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703479;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=pdc+k/SesN/2ZkyxXS5Fk5LQPEObVcKayv5obo6VCXI=;
	b=uT38DZUha91gvW2297BKKEUOQiwpnz0GrqLsxX3eAaFB2Q8R9PPJ/fsIm8aRGpXPuc6w
	 Zi/yqHNfZ5srxMLuoAk0aWWDYsdZemW07cAk1lVdirYc5Vo5lMf7gXx4jqv0MfUip1LC1
	 fEy6SiWjj2yKIRZsouWcIV9bcnnJw9QaVCnab+VabopvTjrmMu2AmwZa8YOan6iCHvk8o
	 sv+mf6DEPwnImxf0JgpZ66ElGzkyPXVfFozkD40shogLyVL9v925sCC6j1tYD50oFGFK/
	 NJz1/EicY7neEM1rPeiQyoT9451GVQBRXLyj0Tku46fFWYH3uDu7yfKmXykcesOKcZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=TA7+jLtl;
	arc=none smtp.remote-ip=209.85.221.227
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7739C606A326
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 21:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7739C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=TA7+jLtl
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-5eac01ff101so143392e0c.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 14:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792703478; x=1793308278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pdc+k/SesN/2ZkyxXS5Fk5LQPEObVcKayv5obo6VCXI=;
        b=bQedclP4L8kfMgzLXnBVyb7pqbD+r3XJ5j5VidAa74LDb1pjoQPPoT/nsM3Nohu91P
         SgqZxaLSmt6PkSSw+4j99B9lYnnhFy2fJjvy7D6d0hMADb6C22Ib1ltfNkPS88ofGaH7
         s9eLOjXlY9jh46H0OW/I3bEW9xCsMW7XIYAMrrtKXZn0Mjk6/tuFzsldmpUg00wYairf
         VyaiPRgrSwCyar7C//0yF790BUh1ZqYL6TSIE0Szlj0T4ehLXwVXLmHLlyXehz594G7G
         G53pfw0Lf+2HcxNKOBUIzlGKyKgotK1Eckv5o0dwxelOCEKgb35MR1QIw4BXKl9JhMoW
         vPkg==
X-Gm-Message-State: AFq9FYIvao+GbLI+86kGLcWwZ2Vnj9fTopsef72Prw3Y4dDZ01HUlg1H
	KSnIiSJEmma4su7Yd68glnJMT1KjeHxDYBB2CmYbOsmn6ohqvvxAOY8OrdYrVk/+GgvokfGWvto
	bG5HLaWgWBOSxgDo5nnZu/CE5b8C3MP2VifSpQ94z+tt8gqPTpdF3twT4i2cUezZnio8cSSQ0ql
	A3ljeSIA6PBVCjtCcGrX2d1ezeShoHgKpApFvmMp2HxEigtxK4RnD+hpGrkYU5DE0ZHQsFspA7O
	POs0cnaVB4C2Kuu
X-Gm-Gg: AYBFou14B/xbTlTnEACJkxnKNBcAzViPVG8Qf0i2ki3oyy9rmJvIQnQXRc5aDM7RcfI
	eq3jmbuL+ctfOBJE6gw0eV0CjnbfnXKLQ77Ac1FGZ/C2gXORQ9YGXAFwQ4uo8ACcjQifQVwcMLP
	9rluqwS+3e9Ga7tNHYjRzZ35q7G57B/Zv+tFDOuV3rmR4+8E6ff/RiyROkBtG2N65+4WH15ClH7
	O8TU+xVXJ/rZFBSkb64muhKSALXlf5cBc8SB2IoFm0loxF0orF2zAReHoGbF7ytkm/CKoFbRjG+
	YzjROf25mOj1NYR6C098UIOT8uqMSvYBcvvpaxxGVbYA6hV/K0uFyIRMx8EtwpDr6iYINgKKtc4
	n+7xG3X0eiIRwmkUaCwyGli3jc1gU34uDT7bV5uZjHm8MYE11K7obMSKmJZBbctar395f632P2k
	wXuPcZ4If/lFVDsgdtKhtuH8uSCnJLIYdarbzNLVxMOw0=
X-Received: by 2002:a05:6102:f0f:b0:7cb:bbcc:e52 with SMTP id ada2fe7eead31-7ccc2d84b0dmr272742137.0.1792703478169;
        Thu, 22 Oct 2026 14:11:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-7ccc226044dsm9279137.26.2026.10.22.14.11.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2026 14:11:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-917a2de2cc1so3925536d6.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 14:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792703477; x=1793308277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pdc+k/SesN/2ZkyxXS5Fk5LQPEObVcKayv5obo6VCXI=;
        b=TA7+jLtlklgsV7T9U/3xcg8bTcjGGtb5F7Nto6PyjP4/bmt+yv8kDXl1L4FI/Ku/fs
         +meUsnQ6RkvCuYN7LViNsZYs2jt9vG1Zmxa3ypOf8MQn/eZ1jzDznYd7F7Gqldp0XmiY
         9BOZ9Ck2g7vJRLyc65GBp4YtUrDLihpW2fopY=
X-Received: by 2002:a05:6214:4993:b0:912:517b:7bdf with SMTP id 6a1803df08f44-91c3a8c0921mr214166d6.42.1792703477288;
        Thu, 22 Oct 2026 14:11:17 -0700 (PDT)
X-Received: by 2002:a05:6214:4993:b0:912:517b:7bdf with SMTP id 6a1803df08f44-91c3a8c0921mr213416d6.42.1792703476428;
        Thu, 22 Oct 2026 14:11:16 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396afa91sm2472036d6.11.2026.10.22.14.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 14:11:15 -0700 (PDT)
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
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 2/2] net: dsa: b53: restore the NSP IMP port 2 Gbps mode
Date: Thu, 22 Oct 2026 14:11:04 -0700
Message-Id: <20261022211104.2091128-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022211104.2091128-1-florian.fainelli@broadcom.com>
References: <20261022211104.2091128-1-florian.fainelli@broadcom.com>
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

The Northstar Plus IMP port uses the switch's proprietary 2 Gbps mode for
its internal link to the AMAC.  Its fixed-link description reports 1 Gbps,
so applying that speed clears PORT_OVERRIDE_SPEED_2000M and leaves the two
ends of the internal link configured at different speeds.

Force the 2 Gbps mode and flow control for BCM5301x and NSP CPU ports.  The
mismatch caused switch output queue discards on both copper and SerDes
ports, with one discard for every TCP retransmission.  With both ends
restored to their high-speed modes, iperf3 reports no retransmissions.

Fixes: b6a8a5477fe9 ("net: dsa: b53: fix resetting speed and pause on forced link")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0880310c9ce3..1f4964c28fc5 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1663,9 +1663,13 @@ static void b53_phylink_mac_link_up(struct phylink_config *config,
 	}
 
 	if (mode == MLO_AN_FIXED) {
-		/* Force flow control on BCM5301x's CPU port */
-		if (is5301x(dev) && dsa_is_cpu_port(ds, port))
-			tx_pause = rx_pause = true;
+		/* Force flow control on BCM5301x and NSP CPU ports */
+		if ((is5301x(dev) || dev->chip_id == BCM58XX_DEVICE_ID) &&
+		    dsa_is_cpu_port(ds, port)) {
+			tx_pause = true;
+			rx_pause = true;
+			speed = 2000;
+		}
 
 		b53_force_port_config(dev, port, speed, duplex,
 				      tx_pause, rx_pause);
-- 
2.34.1

