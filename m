Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506632;
	b=MUOiCYNKatSWIzeZnVnKKgbPPQYqreji9lwlzWJDzvnzACzItP+2ft2L8JDgod7JqJID
	 zGWGv5SgjuD3s2Ske+9v2MurL62D9Dy0AYB6vrzwjLnrgd46SYy0s9keaJSPLMGJl9uSJ
	 PuygFxB3lueiZ/sTELdNrrmqSzVM8uObpAhCOS/bbn6IAaIjvvFOZM6eeX1DBMd7CGvu1
	 zwvxclNCi+BOfH1sb/gaT+wrfGEt1HntKQ/o25bD/D+px0mxDGmIzqQ5Uk0hgNEi6Z+rG
	 iHKXStA6ws8hvS4GUop75u2CDxu1zOzzqA6ZZPQktEqcx1KcD6/0W7imJdo7PpBgm0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506632;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=wh0SeQdNWzsZyoJ4vl/0g4hHaNPzl6qxcqRd7BCWar8=;
	b=CWpXyrnNv7wCbygMj8tOsrQ+5ze4w24nXgMSbziwyAjnbZyi6QokTa9HrLjAkCAW4LAk
	 YO+4j4bkRK1OXhVYgbWZLrcOLCIH9KTvOBATVMr0vqgHtTrHzJSXkVZ/H0lqE2oyjYin6
	 KV4qRJUZKf69+uF8cL4BN0iX3SXgHIiAW7MohUcWFBrF+uMZVC1MtPyK7c2zD+fbG/iqN
	 cedm6ZycD+RyQdRbGsasLu8N3ztT+44fBPybgssYHVFvJ89U1HpN5KX34sMiI/Kx8XL/S
	 8tpjsxuMy4DvwhNPLBMrhBgPtBhqL0MRZNBau+EPriWF5JrxTChH7BiOrtOICmr+4PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="g8/zVgfA";
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1835606A89C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1835606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=g8/zVgfA
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so28538a91.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794506631; x=1795111431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wh0SeQdNWzsZyoJ4vl/0g4hHaNPzl6qxcqRd7BCWar8=;
        b=hnQ4cid+X1/qBKfF9BjTZ8EVqqR+ObeiDPzODSHM4lct79FSHHHag5fcN7L4GCRb9C
         mwqIRL/UUwXbrwkj6fv/Wk0wSJ/GYnDyjnmZxYcXJCgIVMyDroPXZncEZ0dvWJluja+J
         3cURQcLdtmLSwlUpSZu8Mh6ep7SW249wpflaAZ6hAPZvLpM27dFevb35PI9A+quVgh8V
         s85sNNnS2CC16ploJ0a6auFt05s6QoglLS8NRHx/LNr1nVYTfiGxZ9Xn0xulnhcpfFXV
         6xaffqbXT9uzQw1mg+FL7NqYHnHO3gNJCP+rWU5Lo1sj8R1RkOZgQylKQB4a9S2rqfQm
         zdWA==
X-Gm-Message-State: APuU4Z/0bwNw7NSvQ0InIEMjNNLIOjl8qZRQ71G7oWIlfeLOLsneWjLa
	VZvS+LXa7Q4cI23BsG0gPATkLQLYI9O9sOHnmkGK/C2FU+Flh1cL/0fT5FSm7rAsM7+ooJtfmTE
	4aTzNfA/dgDE7x45oyzuAq3Ux+CQmzRzap6jE7w6B8f+uB63Li0jdK8QryAISJ0hOUv8nyJ2ANA
	WP5zE1V6+xgmok/odQkn2PZPt+4ujs2TngBtlolbw56usgr9s4zUY/idM9N6uR/m/iMuETBZDGh
	1OS3hTE2Dktu6FY
X-Gm-Gg: AYBFou3DvggTT8gzjf3ZmPtEdWZ69pDoePA9jJ2vdHUUCvoz+ClZ3hlQp3iu+bIw+bw
	avI5t0NszJ8gBmUB+MUW2DOdJHV7E7cTNoIeuK82kAoolmMAG+DZ7eGTZhhErr8T6UkbOvQ9wbk
	qbM0Mm28ciZCVO2EdRuzhb1Rc0uSdsMZAU18FeME3kIFGs99LnAVQTPKP7NOf+Weg5SO74u4ZOl
	8rZA2+TKj2qbPX/wvpW7Fe5ICptNL9CQ+nt5dq3E8Ndwg1mNQWlrikRJKp+K44WuDDRfcSLau8x
	Yz52bPiHTGinrbEH1FyTSRPNI4YbjpPAa0v6szbuzv0tuXpedfKybCU4K+JxO4K+xOP2sH3HMwW
	nb8FI9lqJX/oGAk2fzHdtxeWOAmJukVlKK69hzBmk31lWP0aiU9e+8rEuDLcFv93LSGo3juFKwA
	t+gYjaEaE+PUiZzwIgs4XP5nM2vp08PhzdwpTOsUh/
X-Received: by 2002:a17:90b:35cb:b0:3ab:b39f:41cd with SMTP id 98e67ed59e1d1-3b182fde4f4mr6205291a91.60.1794506630824;
        Thu, 12 Nov 2026 10:03:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b197cca680sm3172523a91.6.2026.11.12.10.03.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 10:03:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd652c0385bso75053a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794506628; x=1795111428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wh0SeQdNWzsZyoJ4vl/0g4hHaNPzl6qxcqRd7BCWar8=;
        b=g8/zVgfAu/jBC/XooHrOpDYMfG6DnWh+cJ4aXNdmeuzII6718IICtvDwF7SDvx9jFL
         qMVNN/5gn5nuZdQ5qrWTbRRkMyLwTQwGBdIXzPYtcDNjEL3Yb0LqemIXyX80BsJBANU9
         P8or8LF7u73YEhHBd5UqrfcA58ticfqkJB9QU=
X-Received: by 2002:a05:6a21:1643:b0:3e2:e341:8a55 with SMTP id adf61e73a8af0-3f2fede7567mr6551615637.71.1794506628580;
        Thu, 12 Nov 2026 10:03:48 -0800 (PST)
X-Received: by 2002:a05:6a21:1643:b0:3e2:e341:8a55 with SMTP id adf61e73a8af0-3f2fede7567mr6551575637.71.1794506628033;
        Thu, 12 Nov 2026 10:03:48 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18abc06sm95004a12.22.2026.11.12.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:03:47 -0800 (PST)
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
Subject: [PATCH net v5 2/8] net: dsa: b53: fix the SRAB grant timeout check
Date: Thu, 12 Nov 2026 10:01:56 -0800
Message-ID: <20261112180202.324504-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112180202.324504-1-florian.fainelli@broadcom.com>
References: <20261112180202.324504-1-florian.fainelli@broadcom.com>
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

