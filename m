Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282632;
	b=0g9YTz9BvZI8qu+lbsECPCwOhQ81YjMkM68ZmL6n5QKxXfj14CjPWxwmWVXX/TWpp/S0
	 5P6LMRns0NrTB+yzpYXmJ2lryiCKbVVWLTDHJeIVNYsRWbL1hC2D8utneNHKGbuEnY2OE
	 1ZwDow9YUT7R/pM8DjHndfBVL5SicfPknQa6VaYWyMe/LZgDlwBOYSH08x5WEfB5YBA6H
	 7l1h1BzAeXxk2gUxLfTq6qWThl9WzAdnKPDwLvJ1/ZBil7slRTYNLijY/uLffuazs4TV1
	 2KoaL3GVG5pX4+Yp/Ijb/Ngt0eaj0qmDE3rWCOeeU+zq8t/o66uSfpZUnahygdBdO2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282632;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=wh0SeQdNWzsZyoJ4vl/0g4hHaNPzl6qxcqRd7BCWar8=;
	b=5fw5fmFdDkVqth+cZvtOGjCHet6pOuvUSPVCnRSv3+s20zwEbNLzJ3IsWSqbBPNaoHEb
	 4VEo2xLZxWb+l3zW7JFqJnqXur+mTGI+ajrLaUommaLBIl5xu6O79qvupWPkIXgYyEjgj
	 oVohlN/DsSFHSWTeBrbYRYDkiegv74D6VqPmYXbBZA+PffG8oNXLwDcv6+FgbwQNQDydf
	 2lhDhVXAmrJIejkt0/2+a/Q8BMvxdiMdTtLZ6ms/lKiAe+6JPRv/ZRHW40mjkDnwJ7IOa
	 MsGCFw17JksD5qBcx3Kkxhy9uH8gdG6DG36omXlcRkJO5Kv9QC8zgatmU0QXKK9lKdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=de+wxAW+;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065E660A261E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 065E660A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=de+wxAW+
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso660374a12.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:50:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794282631; x=1794887431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wh0SeQdNWzsZyoJ4vl/0g4hHaNPzl6qxcqRd7BCWar8=;
        b=YDZuron2Q+HTlOrE7OQPyI6wLQ5rW16RI3IDht8d+CB6gZHccuRvJaGUit9GZjD5oe
         E7VcOGCRZB3XWSuhcmpGsMrUQU/suFjUQe0uksQh8r9xU2HbTWmKIzMyQihqTeDPLCb0
         YgQBww6vWzwos6Q28OY2M9n7gDlHaMk/jRZVw/A3Asxlfhasdeczns6k6QlaMo7K/D6S
         Z45z/fQJmxH8J5FNyQHCxXeHznmMG1UASAAkl1z/RgJ8Vj5WSoLVygwYJLwoFoIk/4GL
         d9wB/ftlUiJmrc77zrcssQwxGn79Q+6JwDx3PmYWIiHNpqzsMXaJgP7idUHMvygIFdLX
         0Cxg==
X-Gm-Message-State: APuU4Z9P4ZW05GWeaWP7fBeSxNVBWomwh4lu6peAJ0hz2sFKzwcT7101
	8o8nW1but9fq78HHLYIpdNL/nlrbvUKsxAy5cpJye5aBKSqMlhEqouzaDJbDFQmP0sqIE+1qA60
	qqi+cmL4Whr8fUTf6YS7TE7KL4X581Jf/ROdhyU9UN4SIIuJXj4K/FubSNH//qOkjtLFSZC4gBb
	DUIruubVnu2S+e3mQFOvKaW6dgNda7cyQSR+19BdexRRiLjB3gX5xA2lyVBiDpBm8NIDtHdGRU0
	erirlNDNtwcT+Hz
X-Gm-Gg: AYBFou1j14jI3uDuZ+KnPs9yvuHH8pSgm04zAN6cNXxu9YXxUFya+tDTVJ5jGf1OtGM
	1SIYc1bSfUtY6o0WaTkYKtCYtUnhKk0IIGMjPRMumaObk8bT+nBkuoS6GUshWqs3/MVDxDMeUId
	mSb22bfQWp0UnEg/vx6sBj+NusCjLBLJWZNfpkS0fkr2ERqRSjSZmZFsQWhPEGP30lL6BmLYkOt
	Qx/XYCm4tKRGyrDJ3TVomWHltvhyTPhTG1K79QHpT1d1SBLB6C32z4rSjKCg5CrJWBkyGbrFxIe
	v3mkWyqp/oDOLD+GvV3lTHtZsLS/LUS/9y+iJV1dUhDTilHRL57XBe1ZMBiwW7nquT5g6G5eV+6
	TOgvPQg7E3uHZcfaJlGJ0BiGJl2f0pb5lOg0zp+6yA5JsePCMkkVzAENRxttcONcC0Uc8IUrctV
	Gt1Cbma9S1GY2fd4HAydo2rmsRxQ3qL7hngO6t5b7A
X-Received: by 2002:a17:90a:bf07:b0:3b0:97b8:d6bd with SMTP id 98e67ed59e1d1-3b166c89a73mr1455119a91.12.1794282631181;
        Mon, 09 Nov 2026 19:50:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b166f5328fsm1057713a91.1.2026.11.09.19.50.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 19:50:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5339739b343so33253511cf.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794282630; x=1794887430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wh0SeQdNWzsZyoJ4vl/0g4hHaNPzl6qxcqRd7BCWar8=;
        b=de+wxAW+0NsgGktxhi2Rk4z5LF5he5gjBfGi+amH145fIx+RgOZIoo4uUMsQP7Sbou
         TsG9SG506utQBuC9dX30iJX+rUzGTF/31vOHcJOo2Id79tCHgT9FdCiUKLPEVMzn7Jf5
         qEScJ+QMQ2tliPBsCFjr+FKC8ja0zkmygXVOg=
X-Received: by 2002:a05:622a:1a8e:b0:535:a5f9:7529 with SMTP id d75a77b69052e-555291c1fccmr20766171cf.72.1794282630095;
        Mon, 09 Nov 2026 19:50:30 -0800 (PST)
X-Received: by 2002:a05:622a:1a8e:b0:535:a5f9:7529 with SMTP id d75a77b69052e-555291c1fccmr20765921cf.72.1794282629595;
        Mon, 09 Nov 2026 19:50:29 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550af612dfsm13740951cf.8.2026.11.09.19.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:50:29 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v4 2/8] net: dsa: b53: fix the SRAB grant timeout check
Date: Mon,  9 Nov 2026 19:50:12 -0800
Message-ID: <20261110035018.2169370-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110035018.2169370-1-florian.fainelli@broadcom.com>
References: <20261110035018.2169370-1-florian.fainelli@broadcom.com>
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

b53_srab_request_grant() polls for a grant up to 20 times, but checks for
an iteration count of five to detect a timeout. This rejects a grant
received on the sixth poll and reports success when all 20 polls finish
without a grant. The latter allows a register access to proceed without
ownership of the switch resources.

Check for exhaustion of all 20 iterations instead.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_srab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index 83a03fca142a..f4689078ccd5 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -105,7 +105,7 @@ static int b53_srab_request_grant(struct b53_device *dev)
 			break;
 		usleep_range(10, 100);
 	}
-	if (WARN_ON(i == 5))
+	if (WARN_ON(i == 20))
 		return -EIO;
 
 	return 0;
-- 
2.53.0

