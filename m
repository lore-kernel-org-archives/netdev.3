Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506628;
	b=o2Zedf16wNAQVbWGJtapHbtaYsq496YtDINUMjInY62n1kAsJCMfCGcuGblUveoWLkZK
	 V7LQFAt9j+hm4asWOnZrjeRq8W+ksyHO5cL7hOqr/2nR2FYJEg6SyRv2TBqqgh1O9lmHK
	 AFfYafEzhPpMRSKqigvyyiIO9TXABqPaG3ZsI0fPyWjeFw8NPOe0W1mwV1CnAIibe67yg
	 GPLUx/islMSOpD8yAhgaEyt0T7lHmjLBp0d0nPgxkfBybTWuuz7iTNgFm4w+wcumJ7nif
	 3Jov7RPA4qEC5GHqU08OQ/mRMgR4LZAR2yZ8C/NERkLfnCGL171eVze7jXoUqc1eqkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506628;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=KWmfQ4Rcktpupq70cQYmKdTekcTMgohpolHe+exndVY=;
	b=BQ7mwGeYgUniRHkN0fjR4o9A2WfVJ9qtausMw8JLXdDWwK1oLTDOrhzdM74KEvnO19vq
	 GHcY3dfvbcOhUzqrIH0h0186ta94ujIH/lANTFj6HR1NvSjWLirD4Y16iJh8BtQOMIRsK
	 mtNtc5UXAEr8oA2cbs4Zcn9G1CLM01NJDJdXFqhnDs0HW7YHz6aw0dJ2At90me7bXU3Tj
	 aumqywlfLO04f8Q5becMnK0Lq5ddd8jEpVGRxTHmUVxNXVJHDtM7MGuEUnYhtrdglGQp/
	 /CBZ7/5pLq8HmCqweBawHyEI9rdpQAJTCWg2qG2+5pUqXhQQPjogMPTPNz3wTMy2UgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JEYDUHef;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1308C606A32D
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1308C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JEYDUHef
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so24247a91.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794506627; x=1795111427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KWmfQ4Rcktpupq70cQYmKdTekcTMgohpolHe+exndVY=;
        b=oSniVXDqBek8T/lH1j6RSG2qQShoPOuyIX7KVUsJRzYzWe5M6vnZx6UFFlMQ6XgzmZ
         kjU+QozufpH8DNqRvOJurRUQcyvLZ/dPH2YzxDiEcdN1d7jHW+aieAaWcSYI/+4hxSdE
         p9h8vZ1t+O0qYaglM+8Yf8unw8YA+EuUnp98mhQ6zq1InyLJPZtP+E0FXbPQ/y7quDK/
         9C60A+kPUGmJb0lW11KVAHmY4IetXfBTWWI4VDMi1K0x4uvayZx7+KTt4zMCZme+MbJj
         CVsLeDWXJgx+IbCuJA8SuW6l0ZZ8WI2maA1czB/bb9wNpy2OBYnJOA6tKQu5z5RRQs58
         xRJw==
X-Gm-Message-State: APuU4Z++KvmgQMU8f7euJZOZqjFVl2gSesG81tvcVnMvKB3341p3rtQ7
	/opF50fjc2UkgMiDxOyIvRptWtESkLxNPVamDZfWeUBn5iaWnKZdDrAh5PFaGNAbRBJPYPTpDo9
	NlFusUzzQ/QOhBsPkfb8obzTBfBFjnIii8rwg50bos/3kXasHCTv4pmsBvilNH2Qk5NPBemQbDg
	RPrZwCKwk4lNs+mOIBmqgkjnfmwFWRFPqncx2eP8by9ApS54CEiN5aYvNChAMEJn+kP3lHBpot4
	4bMrhxoe53DNrPE
X-Gm-Gg: AYBFou3JvtalpUKczGTu7DJIm6rK6A1jMwnue9mdLpxJ/Q3vDDyTpSKZMmPsn+u/yvr
	7heHcTqT053BeqLvO3umxlMBAqzHtgfncZiENgwUOIPCxZvHMwxH5tE/7A98RrLg3YWNqRojFuK
	u0bM2RHfHhrxa/09vgPhRiYTK7MPC+XyhB2hUhh+mGjZqqZTVeAt0+bHeJO1isWjeiEGoVXznec
	znNeTe543U+YeyIJFWJ+I7f3udHi3bWHerlI5YU6D0pOFqyuCtVZWob2yWUtm9fWViqoBH/Bs9L
	3RxMzPxEJbFXcNUofSj9zwqiDJ+OkXz98IU5NYr+BupsWDPIBpnR4yZx+9jxlTOsdTMOIdpMBU4
	92hh75THv8Can4BJgrJ7VG9nbIGjrt4xOkLQjuQDfxH5Uck6SdFq+5asXqLbPkD/Q30rslVhWhb
	2ZRBi9O0aefU5+f9Blq+chidexVOFmA0bmw5kxdskx
X-Received: by 2002:a17:90b:4a84:b0:3a6:e901:e79b with SMTP id 98e67ed59e1d1-3b182e9413dmr5975194a91.15.1794506627167;
        Thu, 12 Nov 2026 10:03:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1ae97e80bsm389282a91.5.2026.11.12.10.03.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 10:03:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cdb869327e7so108878a12.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794506624; x=1795111424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KWmfQ4Rcktpupq70cQYmKdTekcTMgohpolHe+exndVY=;
        b=JEYDUHeffcLgfzq4udhuNGiGnRIyktFi/daKzE0I3FHTKN7NrPzWHTSv4Zv2zSRTFi
         j+qgeQXS5mGQmnyByNtapbANmW5NiEDO+14O1FyWvOCjwKrQjprZvBxYTMd7cBe7tGOS
         w19tw7l1NcCi19du6gLRff9tBMwq9QBUSrtHk=
X-Received: by 2002:a05:6a21:798f:b0:3e1:c08f:16dd with SMTP id adf61e73a8af0-3f7a6ea0853mr7283637.27.1794506624480;
        Thu, 12 Nov 2026 10:03:44 -0800 (PST)
X-Received: by 2002:a05:6a21:798f:b0:3e1:c08f:16dd with SMTP id adf61e73a8af0-3f7a6ea0853mr7236637.27.1794506623837;
        Thu, 12 Nov 2026 10:03:43 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18abc06sm95004a12.22.2026.11.12.10.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:03:42 -0800 (PST)
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
	Vivien Didelot <vivien.didelot@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v5 0/8] net: dsa: b53: Preliminary fixes
Date: Thu, 12 Nov 2026 10:01:54 -0800
Message-ID: <20261112180202.324504-1-florian.fainelli@broadcom.com>
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

Except for issue #2, all of the other issues did trigger in testing and
needed to be corrected.

Changes in v5:

- resolved build warning in patch #7 by moving b53_mirror_init()'s
  declaration into patch #6

Changes in v4:

- Return success when deleting an ARL entry that does not exist per
  Sashiko's review
- Restrict the 2 Gbps override bit to BCM5301x and BCM58xx
- Restore mirror configuration on resume, moving mirror initialization into the reference-counting patch
- Propagate SF2 setup errors on resume and disable the clock on failure when WoL is inactive
- Add a patch fixing BCM5325/BCM5365 mirror port encoding, including CPU port bitmap translation

Changes in v3:

- patch 2: added Daniel's R-b tag
- patch 3: mention in the commit message that deleting an absent entry
  now returns -ENOENT, including when the lookup runs out of space
- patch 4: document that the patch also fixes the clear of the capture
  port field in b53_mirror_del()
- patch 6: reference count the mirror source bits per port and
  direction, ignoring deletions without a matching reference
- patch 7: new, harden mirror register programming:
  - reset the mirror capture and source control registers at setup for
    b53 and bcm_sf2, since not all switches are reset
  - check and propagate all mirror register read/write errors, only
    taking a source reference once hardware programming succeeded
  - use the source masks rather than MIRROR_EN to decide whether the
    destination is occupied, and write the destination before the source
- log failures in b53_mirror_del() since it cannot return an error
- patch 8: new, fix the mirror capture port encoding on BCM5325 and
  BCM5365, which use an 11-bit bitmap (CPU port at bit 8) instead of a
  port ID, and translate the CPU port in the ingress/egress source
  masks as well (verified against the BCM5325E, BCM5325M and BCM5365P
  datasheets)

Changes in v2:

- collected Jonas' R-b tags
- corrected logic in patch #3 to propagate -ENOENT, memset after the
  debug print, translate -ENOSPC to -ENOENT when deleting

Florian Fainelli (8):
  net: dsa: b53: initialize the jumbo frame size register offset
  net: dsa: b53: fix the SRAB grant timeout check
  net: dsa: b53: clear stale state when creating an ARL entry
  net: dsa: b53: reject conflicting mirror destinations
  net: dsa: b53: use the correct override register 2 Gbps bit
  net: dsa: b53: reference count shared mirror source bits
  net: dsa: b53: harden mirror register programming
  net: dsa: b53: fix mirror port encoding on BCM5325 and BCM5365

 drivers/net/dsa/b53/b53_common.c | 209 +++++++++++++++++++++++++------
 drivers/net/dsa/b53/b53_priv.h   |   4 +
 drivers/net/dsa/b53/b53_regs.h   |   1 +
 drivers/net/dsa/b53/b53_srab.c   |   2 +-
 drivers/net/dsa/bcm_sf2.c        |  10 +-
 5 files changed, 183 insertions(+), 43 deletions(-)

-- 
2.53.0

