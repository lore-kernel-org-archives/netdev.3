Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912A517BD7
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548149; cv=none; b=aC2PjvrluOS4TmsXBHKste8UDJShIJSPSWjGUt20FXxXhF4B8mcn/Z8PouPlMSo2vlriPflwaHJSeC9wPPjDAkB/UjKxvrOeMGvNE3qpRAviAfUwp4pWhUW0S2PxuwSE/tEY55EsvS/R8v1+g2syIBanTaODk7MAK53L5crMm7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548149; c=relaxed/simple;
	bh=0NORGIkug1vpAvzWXIzBHkSvbxPib6PIHpFRP5Q7Op0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TlvoQvBN3TNIjGtOOgBhHupGP3O4ogGzvndQnzLvKZknKz/ThXOoWZ/js11yNTme/KXWi7cNyrapgBR7N/+Fx5otxPJ5PpoNpP1QLdEUSt3jWUl/Fw9AuohzhDIt7F4sPmEHiNvrrivZ4XggSg6s1SG+YuFbZXHyPsdDMkmD2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=kyzONtvo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="kyzONtvo"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so14297765e9.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788548146; x=1789152946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=770Nkcotd4mXRhWdRLFuBCumpZlPw+psjVw7wcTW4Fg=;
        b=kyzONtvohE/icR0rf2joY+yH7xsM2DrOWvSliBbQFPg4ouzaO8qGCL9/ws3c0Yoocf
         wn3SMAG08vIgtoQzi58Pnnx1pxmw7KA5dal/jfaRL3+euwh8KqAqa7rUgeFP0FX7S3ih
         e+m+VTWoXbWgvgpwPrTg4L1DA1bOw4P3ey+j7u45H0CrgSSMFZG/Q6DD1QyhWAkiJHCU
         EIgd7Hr2wSPfi6TPLDztLOhQ9ytiyHkzjp/DMN46qQs3+11Bo9xWEHCbcAQ0BId8e+3t
         0s8JzBfAvx7knC8BztjEKLgxsK0N3x4QNd8Bjs18tI0d0x8e+EsBE+SBkrEnnTgRPTMP
         ckxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788548146; x=1789152946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=770Nkcotd4mXRhWdRLFuBCumpZlPw+psjVw7wcTW4Fg=;
        b=hIS8bucAku7LYu3NOwZnzj3yUqFntwPeR1VXzws7nFaufIhym7/mW2OREmxej2H9J9
         Fx+ybwsBY3V0dng0WTIOix0NGpTp7i/D2n3BFx3Ugk8vIyohnDB/hlUM91MEeDTrkJm0
         hNHEAkPncY9YS8gYL7lSEjcK7d4sw5knoMoL29adowrKuMjuVWbOZoZQupgqjH8Rihi5
         ts6+/sxDIsPoFOMTNu/PV8yopckjd4Swpz0g+T5forWNq3fyL1HsUfT5AkeP1iMFx0tL
         rqNhNdwurFjY0lfOa+MF809vybQxhTuo187Hb3jwksAuubI8mnvNKGDHLwH2l5oyOv50
         BT4g==
X-Forwarded-Encrypted: i=1; AKwUvBwvUu+qbWHAv+R8ckjmokoBQVC+CL52XvS2CKY+btoJ9hy2BXiFMD5lcDx8Tgrg4rT5tCxIkUk=@vger.kernel.org
X-Gm-Message-State: AFuF++mTXL0hKbghXr7y0yCuM8HvBm0pRyf0M5UXpNQ8irbzmInJ38Rz
	jDUHpaoAsXxvg//qelgcNODlpaxOW+w/GpKe7OQ2vE+/lPgVPEOpik3VzsQhruSUJX4=
X-Gm-Gg: AYBFou2z6bcSi+k52dCOwrFOWs44ftlseI81W4sFrC6UvYSVEhTjmXk8v1pMJgXPDiJ
	GIvuqAdeNrHYOhaBfbMyIN5zjjNX79GZ4TRy1/o2kCPg+9JvwyYT1zjHsgzFYg9zujvhN23INZJ
	vo8L5No0jNF/NH8lLfIuAwSlOfborA/TAGJhMJtEBvy5rNgXapEg+gru+xmiTPBx8kIJBiPuTnj
	sqXt7s8WeawxWjGqEkdgDi/Wjm9nk0irI699Hvrc0acaVwhswbAMVH8v/oiBlOKFxtfZuXEeCPz
	z4vRrf1zP+W+EldE7hFSmfKmm3GINcLAJ/bVlwX/FcbxPwl4lPGar8ZldaSeiMS7VTYB4odQ+cF
	GWMf9v/0/UjlPM7BjSg+gdeOJzBb2sWXvwAsGVw7JB61bjKraqJ+Dx8SkkJA1MiBMqZN1OPkHhQ
	EmLfaD55ccjhXWqcfGJOP1VfR9qeTeqZcsqImsZow=
X-Received: by 2002:a05:600c:19cf:b0:499:726a:a017 with SMTP id 5b1f17b1804b1-49cf7fe601bmr74931135e9.1.1788548145720;
        Fri, 04 Sep 2026 11:55:45 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f815bsm40176455e9.4.2026.09.04.11.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 11:55:45 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phylink: initialise link_state before a forced major config
Date: Fri,  4 Sep 2026 18:55:40 +0000
Message-ID: <20260904185540.2844261-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phylink_resolve() leaves link_state on the stack unpopulated on its
disable and link-failed branches, which set only link_state.link.
phylink_apply_manual_flow() then reads the struct's advertising on
every mode but MLO_AN_FIXED, and has done so since long before
force_major_config existed.

force_major_config turns that into a write to the hardware. It is the
only trigger for the major-config block that does not require
mac_config, so phylink_major_config() programs the MAC for whatever
the stack held, a zeroed interface is PHY_INTERFACE_MODE_NA, and the
write-back stores it in pl->link_config.interface.

phylink_replay_link_end() is the only in-tree setter, and
sja1105_static_config_reload() calls it for every port that has a
phylink instance, regardless of admin state. On a stopped port
phylink_run_resolve() no-ops, so the flag outlives the call. The next
resolve consumes it whatever branch it takes; an unpopulated branch is
where that does damage.

Found while developing a series that attaches a late PHY from a
delayed work item and sets this flag there, so the PHY attached after
its port was already up. The link stayed down until the port was
cycled 29 minutes later. With this patch on the same board the same
attach programs the MAC for 2500base-x rather than unknown, and the
PHY's interrupt fires without a port bounce where it had stayed at
zero throughout the failure.

Fixes: 96969b132bf1 ("net: phylink: introduce helpers for replaying link callbacks")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/phy/phylink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3ec3bb439109..a1458da8111b 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1630,8 +1630,10 @@ static void phylink_resolve(struct work_struct *w)
 
 	if (pl->phylink_disable_state) {
 		pl->link_failed = false;
+		link_state = pl->link_config;
 		link_state.link = false;
 	} else if (pl->link_failed) {
+		link_state = pl->link_config;
 		link_state.link = false;
 		retrigger = true;
 	} else if (pl->act_link_an_mode == MLO_AN_FIXED) {

base-commit: 641d03105cc0d2437e32fdeec164f91a4ccef6c4
-- 
2.53.0

