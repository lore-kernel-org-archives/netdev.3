Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBEE43BDC8
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238604; cv=none; b=WkIV9SCD0ihwhUcr0PQlXWdU4IabPckQm+tsKkj5QMofEZamohUK5sKvsHLSbqCvrxV4K10gRT5itUxRFTUpZGJJZlxxv1YGmz9XBxn70CIH0h7KLH5JeGN5RL4x/g5DcgzAT/9tkNM8iRPpmq3i6zNtNxHodpjMU2BEkMBrnlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238604; c=relaxed/simple;
	bh=xRa9+XhnH139UlMz9q8QC4ImWbH0adT67Z5A84Y4dfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QJxUZ/EOD9RF5OT13QGNz5wvAuFlpmnBkyKEXepP8PJO0KjvC5TFK5wGHi81amxV5/13jsDUgBLv3+ZXSTLIK7AW8d/AyCL3Qwkowm01Ta2xmF0jk0t9oD0ulEZRbj+aM9FgXGixOaCcHE9uvkJHZSNU9vjyoPWET/DWz2Jfx9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FQ4tXCEa; arc=none smtp.client-ip=209.85.160.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FQ4tXCEa"
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-532dc3793easo11693001cf.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790238596; x=1790843396; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VHG5LsKzXWnAQza+czJEgZBibMlnELCbqoybOyO8YD4=;
        b=FQ4tXCEa2VMdAyuQinyEoZ1hUUTeNxIjPLYylx5yHztzXTPToPxz6e0zILPuhTotNZ
         5NhX1QlDjENBWQjs1K5l/vrk+sBnFED5fDzNMX4CzO5o03RifJP6Vixnbq01pf+3mpbB
         irhIi0evD9+7Z/rVVWewaFWUCB9j13WIhlcbn+60gWjjDm5jjXHhjPrM2Fy2CR1Wl2ML
         y1VUpnpg0t2zhzlxi3jxpOnb7A9Zs0OiT3Wbd2xD5FEFRvzc9ZMPBvp29AW/FRRYJnsj
         Ftrg0enOOCEwOvXTaLn5Qasz4FyDmCO7ynVZ7NSjS30stLJ5MFII9p+rkes1K62X4Ae+
         Typw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238596; x=1790843396;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHG5LsKzXWnAQza+czJEgZBibMlnELCbqoybOyO8YD4=;
        b=HtXqQ+A3eB6RPmTCqPqq3Dq8TRJbhZlYFOH8d6ywC1V3GtxbQDCDVYAkU8gBWHMtNY
         WY3woUB5m9SI4Pm03P/FzuPH06ZuIX54oFPXoLqXr37iUCaYNkWfcdNxtp/ZNmKD5d7B
         73+lC82sj62kehzY51X7nV7Z4/OjGAxCGZp9kMDIpBZ7p+zqkI63D0CpZ2DJIJzpt9bM
         XdmDiKhv/J702LcZ0MVUSwBRzriTBPPq2GCQy8wPoUVb1xKJgPCmV5dAoIyu8apDwURs
         U9lyaopXBtkfeoBvvUZ+3SjvpgP84OMnsHnI9m7QvO1v7F6bmRYQMIAHKiL0Jq80z1+S
         Jbzg==
X-Forwarded-Encrypted: i=1; AKwUvByI6bb/2qsX/GVY1pUhVAL1khXKoR0E94U4G4HQuFTes8llTTZD2VnTrMvn35WHGLtI3OsMr+w=@vger.kernel.org
X-Gm-Message-State: AFuF++mTS/zr7nZ0g4sY/srFDkou8LYuq2e6yo+4azxK19zPL46yGtWu
	biR92KZYaok9pPkniNi9oDfqfkWTvdx7VBBWIsCGGrBJ1Rht7SMq0Rl6l/Q4mlgz0q3wQqxiHh+
	I8M4qU9+zdZ2p8w==
X-Received: from qvae6.prod.google.com ([2002:a05:6214:6206:b0:914:1dc3:df5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5513:b0:52d:6f91:86e with SMTP id d75a77b69052e-532fea5306emr11751091cf.15.1790238596027;
 Thu, 24 Sep 2026 01:29:56 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:29:49 +0000
In-Reply-To: <20260924082951.1599377-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924082951.1599377-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924082951.1599377-3-edumazet@google.com>
Subject: [PATCH v2 net 2/4] bridge: check llc_mac_hdr_init() return value in br_send_bpdu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, edumazet@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

If llc_mac_hdr_init() fails (for instance if the port device type does
not support LLC or dev_hard_header() fails), br_send_bpdu() should drop
the skb instead of resetting the mac header to the LLC payload and
transmitting a malformed frame.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Closes: https://lore.kernel.org/netdev/179022851638.2160803.1808206741379444999@kernel.org/
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: bridge@lists.linux.dev
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_stp_bpdu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
index 74ec42ba1e7d086cbfde608c93f5fa24d6b4ed7b..21d092f5acbb81f1d0ccd80200cebdbda722f4bf 100644
--- a/net/bridge/br_stp_bpdu.c
+++ b/net/bridge/br_stp_bpdu.c
@@ -52,7 +52,10 @@ static void br_send_bpdu(struct net_bridge_port *p,
 			    LLC_SAP_BSPAN, LLC_PDU_CMD);
 	llc_pdu_init_as_ui_cmd(skb);
 
-	llc_mac_hdr_init(skb, p->dev->dev_addr, p->br->group_addr);
+	if (llc_mac_hdr_init(skb, p->dev->dev_addr, p->br->group_addr)) {
+		kfree_skb(skb);
+		return;
+	}
 
 	skb_reset_mac_header(skb);
 
-- 
2.56.0.rc1.310.g51773c2048-goog

