Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308611;
	b=4yGqB8lYO3U6mjbqJNTppk54b7O3E8TqB0yCiiRQRGRm8B0u42xIAQivQ0GaYhzOxoWO
	 hyOYmsC9Ps1UE0CLkT1uTmneqTkGl452nD/5b7WFppRaEJr6aA4K9UvHBUgTOLpp3Sc2w
	 JUp3xkEAaJ0QJJF79VuifjxAxld9FQWMujiGjrOYRLkoxO9z/BUlzApIdvIaYv+MG39NL
	 92fFbOjKjTbf3Rgu7+hqZmI6Cm7+rwhWFKqi/aZxA2KW1xT3cIggISpCKNILL4kGV83sg
	 SxVrQ7Dk3MomxE3GRymga7rnRZkSPtxwWBuiz8ZVv1H2P56xl2tS9LVzkFJbV30jZZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308611;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=uTkZJ0Yzp0GGufzljGd6jbiq9eMnJlsjmW0Q6mSjuiU=;
	b=WyPXwWun/GvsdTJpV4nR86N/paaT+b9iz0SUGMCxDY7C3GjniLOo7+WRbObfBXq3W73L
	 pdRixX+OwFVmCqTtByGqJmjjUONbKUISo2bh9/SEPaXcmR/QWEcWJz74Gzf+xlOhVwflO
	 ni6gwGD9tuRhDfz8Y0Z4idCEazuoh+7SQhdD0KN/G5YmFx31LQ8RK37kATDNvtgaqmkbH
	 LmnZlZBFi8QZtm/58l1lNUUG1fNfSXtZtyHC/SDRG4vZ+qzEJsWoHgW9EMgDh4SpMQqGr
	 dZJRQdoRKjuAC5rYnrAVWcxtg0WHBD4TlyxpDqAHPZV6aVRp4CYUR27bc0nFGlXvzJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=R66GEi33;
	arc=none smtp.remote-ip=209.85.214.226
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337FE60A380E
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 337FE60A380E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=R66GEi33
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2e5378b281aso329935ad.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308610; x=1793913410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uTkZJ0Yzp0GGufzljGd6jbiq9eMnJlsjmW0Q6mSjuiU=;
        b=Oq70GtWgtNimZv+sdteW1UljdrWfgc5o54DXfvBk/vHU/kVVt2QDfGP2J4V8R71brb
         XM9ldkzrhD2O24bi7jGOC3WOTG7B9YZt1FW8aSmjsvPLdkRvrJ0tq/FhCcWn6cj0J8gV
         QoRY59UAtbgHLSU2g19em7g2zpM1YuS/ZtoFjvdH4IrcWU1qkS1RVWX0t+K4NPehBctH
         mbIPEc1FyddyecsD8kRt5JvVV2pvg51ymjmvBo9HiyHnSVcy2t8x3FBGsCk+4ue+FkJb
         MNN1VFWl7mlRLc3ynyeUGmq+DSNjIhNivEt73qP5lZGCTUsLns8tLOaTxE8fOfzG6g09
         e+pA==
X-Gm-Message-State: AFq9FYJdtvOKuErxMXuIPrjkanYUT2qw03xBkHqKaTFhY6VFIjLc2N89
	ikOEarkfAsECK3mZEK6NWw9Si8TtF5gAj8Cx1Y9zcG6THdUr8aGc+qHVGM+Gq+ac0f9kq0oAV5b
	PnS2i//wOltWtI0wNsA5sh6buTLrS9Rtx8Suq5ZIbh8b9bCmjjI6byJ6FMdIto1R4bvfa7Uo02Z
	kWLLOOmc05q32O+WTRvWif/jy5TKjdXnaIWQyfTwvUE3eBIYWlq/WHP20L3FF79m+AmbJ8QHNbc
	BKbnUZ4UWKXAnWYSlw=
X-Gm-Gg: AYBFou0CBzaIoRP1ncA5sfcN55BXdi5C4lH2jeSJuzkcR+h6kYOqfjQs4fyctHF25OK
	Eocee3Hc3u0XVMisRqiBp9tdJoaMiRuui1pj5z9/aGCUTWSAzZfg6JtzPqNAQOsPFUDSn5yvtQk
	cyR7+IJPKWYfIS80J1buOWj9UGvfZoyMZ4i/3ZCPp85uRe+Eil38fV3UtIDdooBXy+r9ccHN51+
	HmwocXZcixujndbVX/FVzjROGxE5GNi1qbArHD0LJ9QEZAohE3z8I2e1gdWYsdhgtZHwym8oCaA
	V84ksHEGitNbi9AJ3FSIDMSxePopRUDWW9kASXPF3U0e0FuY0nGek915K3ew8iQFckXqyd1v0c1
	zShM0yHP81CptOxjcGUnLQ9Cqzm4rht2oO/oJavgMiIRgj/5gEbAjPYKtVYMlRD24PFx10zpeuo
	7rFSEJyAvFAUcehOHMcRBzArJLDjT3n8cWrXTfQXc7
X-Received: by 2002:a17:903:388b:b0:2e9:64b9:a330 with SMTP id d9443c01a7336-2eb3649b9c7mr6476865ad.11.1793308610512;
        Thu, 29 Oct 2026 14:16:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2eb369096c2sm129525ad.13.2026.10.29.14.16.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:16:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c046843f1so2466256d6.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793308609; x=1793913409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uTkZJ0Yzp0GGufzljGd6jbiq9eMnJlsjmW0Q6mSjuiU=;
        b=R66GEi33VwtFUWALyLN11O93c8XeXlKXcVlh+2of8G0izBqMG4woxUD14WyIMX4sXr
         aoUFLXcrt83raob2Xb55LnhPuko1iV3jrroKPRB+T1aukONcywdDiM5iB49cvVClkjLc
         QVeBKYrW2wRubmIKWpF1GbfJ3qOy5kv95unuc=
X-Received: by 2002:a05:620a:3707:b0:93f:5445:c661 with SMTP id af79cd13be357-944217b3b9emr80324085a.57.1793308609220;
        Thu, 29 Oct 2026 14:16:49 -0700 (PDT)
X-Received: by 2002:a05:620a:3707:b0:93f:5445:c661 with SMTP id af79cd13be357-944217b3b9emr80317985a.57.1793308608547;
        Thu, 29 Oct 2026 14:16:48 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca314f888sm6326926d6.35.2026.10.29.14.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:16:47 -0700 (PDT)
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
Subject: [PATCH net v4 2/2] net: dsa: b53: restore the NSP IMP port 2 Gbps mode
Date: Thu, 29 Oct 2026 14:15:40 -0700
Message-ID: <20261029211540.4123250-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029211540.4123250-1-florian.fainelli@broadcom.com>
References: <20261029211540.4123250-1-florian.fainelli@broadcom.com>
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

