Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048842;
	b=CSaTD3NIFrPKF5NTcpRXs7/LUYilgstg/am/AMMe5FdlgvwPZJDAnm1HmFG1f+z8d7sb
	 GRt2bifYDsX36vRiqTuaxfT+A283xN5hZXZ97uNyKRRNrNsPeYG3toLhNb/vNDDbqB5zK
	 vNqZZAt9odvWCeQDphc7kdkN8qr0rEA7FYRVeQ636Pv0WKXS+f6Mt6yxQgx84lF8b8n0P
	 w/eanahaJRTP4wfG6jWnD+xBxY7IHYceSUeKZP129IZ1S4TZgo8EH30E5FTlLIJy6mxu9
	 LTwAAdaf9q2zPXF00EoAb50o2aYswqpO9v/SwrHmamd0gKBIF44Petg45YvX9Vs76UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048842;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=uTkZJ0Yzp0GGufzljGd6jbiq9eMnJlsjmW0Q6mSjuiU=;
	b=dVbMQ/sOvMFfkbQAoXg9Yw3uyeEdhqEj6tL1phoJuceVwsh3AjCLv0xAkkgu7zAyxvaV
	 hZLLK/WdoCvfsp1Xfr8KYrlaoaSBeLSk2jHDanNxHbBvakxPnWMBzwZjnRU63QjbB8Wlw
	 QV+QsN0jU+zC4hoFUH8GSSr+5gJEu7kWmuYhERVJr+z9MRyZMWHsRU6traHuB29fB0wG7
	 K8gRJyOADCVwNJmx4c6D7l9OiF6tah2d2pUskHnEynuN+BCJTPzAfaTHlK+1d0+Twv08M
	 oOYQiii3Z1SXzhevyEOEqD6d/kkBYAJMr7ZKXdCkb376UEYqmCVOyzz4d3AEuPEYYGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="GB1J/OwO";
	arc=none smtp.remote-ip=209.85.222.227
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C53B606A323
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C53B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GB1J/OwO
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-930c0f9c1b1so309316985a.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048841; x=1793653641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uTkZJ0Yzp0GGufzljGd6jbiq9eMnJlsjmW0Q6mSjuiU=;
        b=eoIrTSkhGVNHt4ERCBPoAxJMUA2L3Xh4Xuv+b8oxIUR1gmFfGE6wyrhQAvBURRQGtq
         fVtZRnuEtPvuR82gE84fh2dEd7m6kYPCKFlGCF1m9Kw8Xty+ilrqBjWMsf/5FBGnE/6I
         7/PoAOBzbrRz2Om4HqgqgY1ge2XiTWHRw4Xs0AxIk8LgceZ6IR3z27U1Fkb9jmbxi4O5
         z+k9VSEhpLOGUYqwrzGQZD8cHYpViNdJUBTRfm46lXaLlEBQEtAMOQiJyunIf4mE+oKn
         qWzZxFV7tdaDV1SqDe8Nw4vTMjNlmPVOdBUcGI8pFq5cF9ppZNzPc+Jk6X+oHDD4uxxc
         TfjQ==
X-Gm-Message-State: AFq9FYKYylaLs4SZTrkOKWqcjmG33Lx+yjhsvSsbG9I45mruFHmLXCQC
	kH0uHdK47d/rVL7pgpFxakr8fDK23uO81Uib0jLnl8BrBNf3pJjF5ME4ahqvE9R8SJULXXQ8Nwq
	Oy6cHW/0ODW5hEv1beqjPn+1rvO+mQG70ZAtxCNdPPn0lx70u9z6VKIWTW2zviCsKICOfEfKS1V
	S6A9BUwCMNuHgwvfFXFksqjPMc1x/6sLu7pW+WmmR5R2ctAzBUyZQB7QASejS/xnSJ/GQ+lCflu
	64VuGuK/1mKkKLGB+I=
X-Gm-Gg: AYBFou2ic14INK7SzonYBBqdhEOu5/bbDOlRXnV4t3oJhrBHNHg3mzDgUm/X1rYaRdQ
	0TrV7uaI5+b2fuYrQyFelDPOdMxzIjIf92uLNx/yognwo1hG2xEvna24F7l9iWOUFCGohVk7sw+
	hT2J5CBQbL3xTwDrZthbFaXKkMJ6y6vEU2qoUQdac59n2cWi2myWmJCFhv3U0Ss1YPo1vJDEHiR
	mUg9lOVZhd2KZem6XEDAo8TmN4wtDYdH0EMZnUn9TtBHsgeiVWsmgzWSqzl143xLEsVeAf8jYFo
	2eB848C+sLz3HdUI86pCqAIAfadluwNCYG/nQ72hme8c9rTsfqxKgHJrM7n12U2gWpnA4ggXiOX
	3RK8gY9+Z37leDgOr0YPUeV8P3+SkhRqDQJjp1UC5/GKJkANCAusiaHapJDI00YdOYuLPdoyIKn
	B92EDVYRrjz5znVYz63SRR8qQ8qgtXh9ES+WwUXbQf
X-Received: by 2002:a05:620a:25c7:b0:93e:e531:b78d with SMTP id af79cd13be357-940ef7ca684mr1151109085a.7.1793048840616;
        Mon, 26 Oct 2026 14:07:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-940f06613cesm121233485a.6.2026.10.26.14.07.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:07:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ea71803effso35897235ad.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793048838; x=1793653638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uTkZJ0Yzp0GGufzljGd6jbiq9eMnJlsjmW0Q6mSjuiU=;
        b=GB1J/OwOUp9OwFeIaRzNnLPUia/7R/jz4jRHDP/RgEsXdjC+vVEteMqdNlI8e7GNEg
         bDl6Z6m2REAPpjX5/XAyHEyFl4huzQ/thNQDlJBr/2/4lGezIhGsQZoiDEbnAH6ebaWl
         nPzzI6dpPLQFs5xn/pHzxjsXBvpE+aRYwwPD8=
X-Received: by 2002:a17:902:fc45:b0:2e9:9a19:c5b with SMTP id d9443c01a7336-2ea9c7bf298mr69830685ad.47.1793048838629;
        Mon, 26 Oct 2026 14:07:18 -0700 (PDT)
X-Received: by 2002:a17:902:fc45:b0:2e9:9a19:c5b with SMTP id d9443c01a7336-2ea9c7bf298mr69830405ad.47.1793048838119;
        Mon, 26 Oct 2026 14:07:18 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6ce5d92sm808245ad.75.2026.10.26.14.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:07:16 -0700 (PDT)
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
	Jon Mason <jon.mason@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 2/2] net: dsa: b53: restore the NSP IMP port 2 Gbps mode
Date: Mon, 26 Oct 2026 13:37:42 -0700
Message-ID: <20261026203742.3198673-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026203742.3198673-1-florian.fainelli@broadcom.com>
References: <20261026203742.3198673-1-florian.fainelli@broadcom.com>
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
 drivers/net/dsa/b53/b53_common.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0880310c9ce3..743fc04da0a4 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1663,9 +1663,15 @@ static void b53_phylink_mac_link_up(struct phylink_config *config,
 	}
 
 	if (mode == MLO_AN_FIXED) {
-		/* Force flow control on BCM5301x's CPU port */
-		if (is5301x(dev) && dsa_is_cpu_port(ds, port))
-			tx_pause = rx_pause = true;
+		/* Force flow control and 2Gbits/sec on BCM5301x and NSP CPU
+		 * ports
+		 */
+		if ((is5301x(dev) || dev->chip_id == BCM58XX_DEVICE_ID) &&
+		    dsa_is_cpu_port(ds, port)) {
+			tx_pause = true;
+			rx_pause = true;
+			speed = 2000;
+		}
 
 		b53_force_port_config(dev, port, speed, duplex,
 				      tx_pause, rx_pause);
-- 
2.53.0

