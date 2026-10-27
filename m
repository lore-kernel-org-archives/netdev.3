Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132566;
	b=G+LKKT6zy3gHuCUumyx00GlX3xuJRYmDQBbYYFKbxGbHGeRM7pwWSR8nJf1qvt3oui6H
	 VaUZc7owGnLPuSDBzrHBBA+ed2eKls/QhopB401LwwfMg9FcgQzgkLLo2aWM9wqBl76FE
	 w7BVClmPN5gGTqgcWSeWmseozg56194CgSL0/4jwkEYF51FulN0BQm4fFf3xo674iSoZT
	 fxwxN6kL4F2vbZnmjCGoHZfuBeySJ64RlpGi9iwGYU2K7obNrjMQA0gIugJIzjEC4e/6o
	 H23RYlMDRonH4siDj7+frSSukTrQr8b1su2ZG9WwZqN6JBJB/zHbq5wCs5Ta0JnJADQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132566;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=GTTXDMrHUSZcZgYEx1pM/ktFnMhLa8f1HcQffbd11P0=;
	b=k/VeoODrrK7WhKiuvYAzYdGQ/t6oDCHHddG5m/xH1c3UkICDSHg8NTiPVck+X1f+QXid
	 PNWBLrC0Rs+IB2Wd53lNQcu4E4I7/Yw/yI4Disi78TLjFmwWRWeWsaLmfny3V6Mm1abdu
	 C3d0qr98AT45med4tP61PK+SfmNQVtrsLt2BizYQrcCKqoy49R6et2oI8vn0haHnzi3x3
	 Myu06nXk3xG51ZNQO65KdMLl3twd+o2s89wo/eexA6huLAU4UPvDVB4aRRiG8Hio/C+TU
	 aLEwSHH0962gUFn7KnfGH0xWhlRhyDSBpFQFEQ9GhcP3lbpLg+ByVcL1svTQDjpVU2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RBxPxkrP;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F160A262A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 20:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 279F160A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RBxPxkrP
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso144565a12.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793132565; x=1793737365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GTTXDMrHUSZcZgYEx1pM/ktFnMhLa8f1HcQffbd11P0=;
        b=0yuTzHYj1NLAZRrtBvefy4yN9kDW3ew3bIT39YPC990T7vvclYYOZA30/iwGucDBIg
         PNyS0AqANg1vtYDYPOm+IzuZHuFSubk6AN0uINzFdjwOnYkAI4WHrFjs1aW1ZONuCwoa
         mCcNCyojdLzaOV99G7nuCHZd8PiO/oemi0o/yqgTuXawJVOtNGzmwX5nyXUvqps3+Tze
         Xr/uGJj2cq7vhttxttqm5KZZrxLx/kwkguvx2DB1F14cH+MYihy0FZuGKRjzzVSphu6E
         XoqZlWoD3XISsO+GL6hoRpU339Be+3XF453ROR9S90lvgwsP1VUlmJ4fyT8NovUEVpCC
         mUtw==
X-Gm-Message-State: AFq9FYKXqWEXQpCLsFmSphGfJz4Gw0LIPMdaM5HXJ1keV9JdOoI+Uczb
	L08vsJCDxVDETJlNKKafoYh0zeRAqpKf0ASQjIhCJbUN1ryydGnbHm08L/13uQDmIe+UOE64f8F
	rDO0Uy17qt9uWxdQqiakgDWpgYrWeVuEF4lCsRi0vCYFuc0Ziz6LOTKPp0BtZ2xHkVG89/zL51q
	Zj19dwSfj4rzwYmYDFfBz9tYjHFgjG2bcZz+kOZTWZN3HG8ytFOEG0r5H1isPEDkg4h8Zc3OOdy
	+v/hNbOhpzkKUGH
X-Gm-Gg: AYBFou34k4EYv2OSvxFFl1+N/6tu7LlbpJ0R7GQKAP22hG8L6bPKPFm/4eFXB4pFNLg
	DyK3TgYopOXSJC/zJnMqcx4GghLIAMgTvJRkWUFR2qeW2tPGrYp+ZZ5haksgxTXOs7zgWTwDzid
	47g+sXWHX/enO5+U2+o60QG168GgDF3kVImk72dw520pbAtZkozrNtlr6O84q5C5QznnB9hsVv6
	SudZeIT0eCEKPDj0j+mmMckazAU9IVw08loLABlOi9WDhSkBA3xQwUeegBlpe/hN95dYqhk1DuS
	lHJUk/FSEYWF8CQ5UXkWHjNSgP7VkRNZBw8DEplxSy5qEKzITkeuOEt/7ZAj8ptZRUuMxJRBIy1
	f0tuFDl9Mj1B0BOrgTsyCyj8XMhCsaMTOTgOZ2EKj6fl3xCj1VfLdhKsjRoRBxOmO3rBdlOypN9
	pgCBQHhFYCe+atcIO9yg/GdgUGk5jvn5TnX+fmJHyuLlM=
X-Received: by 2002:a17:90b:2743:b0:3a0:c85a:ee02 with SMTP id 98e67ed59e1d1-3ae57f629e3mr140519a91.17.1793132565383;
        Tue, 27 Oct 2026 13:22:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae57a27bc8sm169119a91.1.2026.10.27.13.22.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 13:22:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ac8f449d1bso195842a91.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793132563; x=1793737363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GTTXDMrHUSZcZgYEx1pM/ktFnMhLa8f1HcQffbd11P0=;
        b=RBxPxkrPCdfC6y1Sd6C1f40VPq3RQcQsoFhzKJ4cuC9EKIICqK+iK8Um6xoQfcRHbw
         QuBWwjQ5bwNTD21go+Z7pQuGoH/iHAe6Bc9TYVz/9unFle1jMJy1+Cal8DdckGq0fF9p
         lBm8jTzUKvVBc8Rme1g18TrbGZOwr+c7vbkNk=
X-Received: by 2002:a17:90b:2891:b0:3ac:450a:fa22 with SMTP id 98e67ed59e1d1-3ae57e088b5mr159689a91.2.1793132563394;
        Tue, 27 Oct 2026 13:22:43 -0700 (PDT)
X-Received: by 2002:a17:90b:2891:b0:3ac:450a:fa22 with SMTP id 98e67ed59e1d1-3ae57e088b5mr159654a91.2.1793132562808;
        Tue, 27 Oct 2026 13:22:42 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d1650csm275486a91.1.2026.10.27.13.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 13:22:41 -0700 (PDT)
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
Subject: [PATCH net 3/5] net: dsa: b53: clear stale state when creating an ARL entry
Date: Tue, 27 Oct 2026 13:22:28 -0700
Message-ID: <20261027202230.3539646-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027202230.3539646-1-florian.fainelli@broadcom.com>
References: <20261027202230.3539646-1-florian.fainelli@broadcom.com>
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

When an ARL lookup does not find the requested MAC and VID, b53_arl_read()
returns the first free bin index but leaves the entry populated with the
last bin examined. The multicast add path then ORs the requested port into
that unrelated entry's forwarding bitmap, potentially forwarding packets
to ports which are not members of the multicast group.

Clear the entry before creating a new one. Also return without writing
anything when deleting an entry which is not present, instead of making
a new entry from stale bin contents.

Fixes: 5d65b64a3d97 ("net: dsa: b53: Add support for MDB")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 559d4b360c82..0871a10d8cbc 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1992,6 +1992,10 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 			addr, vid);
 		return is_valid ? ret : 0;
 	case -ENOENT:
+		if (!is_valid)
+			return 0;
+
+		memset(&ent, 0, sizeof(ent));
 		/* We could not find a matching MAC, so reset to a new entry */
 		dev_dbg(dev->dev, "{%pM,%.4d} not found, using idx: %d\n",
 			addr, vid, idx);
-- 
2.53.0

