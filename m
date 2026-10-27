Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106393;
	b=SA/2EZZKXeT+t9iamBA0PmWr+vjsWsdP4StnPxO22VmWIGte52+qCtj5p+Q/i4HSb4Ky
	 4LR65vSpfTVk4woS0ZcITbaXNUHxPEwcK5VZaVe3UKFatPnpDrDPfYEe5Mfo1HtEXDDWc
	 fFxbHGqXqkwpUP0Vu0DU2fmvlBAJD4biVpA2X+dfu7Iv2EsvR8C2SZ65/GoToabP3kUK8
	 xyBpxQrHy8ri9+xFwd3V+x31iBOlhxtVJrlwvCsOh1bUgSq9QaRlz3M4fOThRHqUsbTHi
	 EcL/jAt3LWq3BfF5i41d7XW8NuXpIiYeX0pVWw89Cz5xEoQ+oeU8fhEr905iAth/vFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vbRBu1C63eyTt9/fvNVaFYb4y1grLI4jAq2tU4V2p2Y=;
	b=EacSAjxRlepU5LMuoh/Gxse9scBsSxyHjxUS+Z8zkpfllMkMb+JQ4rv2ZvESD1dRO07u
	 5NU0ybdpipqncz5/iRFhWpqJUBcZJQc8vs189orvsYayVM6S7Yrf4/ZePwSrq5gH8+YCm
	 6XfAt2S1lM3z4M0SJ0S6ajMhMcCyZu0jiZliEgo8s9Gf+/oVJF7Qph+uPjxRnVWZcOgYc
	 GzQGgB+8d57ttK+ei12VstHdSPsJxeBasp1Jd/rkXUK/VzSjhEnBqVAtBSRCJSUVlgfdB
	 WPhTRKut/5Yp3qrDaAbrzOPInJSP2e2KSCEhKcu2gSZR4ROkA3vDFpicZpjCjV1txQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NxZEPCRJ;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3659606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3659606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NxZEPCRJ
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a2af4c8d00so2211410c88.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793106392; x=1793711192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vbRBu1C63eyTt9/fvNVaFYb4y1grLI4jAq2tU4V2p2Y=;
        b=NxZEPCRJCuWSuIjHr9sX32vY5xca8UeAp8zS02zpjxZuupKF2Wr03nNTiMnOaobgU+
         nk/HvfNWbqchKO/ILksdwbokjN5pE7mA7Wr5XVCvyW9Qr6saAqqGl4ld81mkPl1rPGAf
         RvBBIvApClPbwydYLGHrSjnG3C9Mgf3IzhyhBbsT0h0fsmU+zgm/Uy3y9VyCUo63IBcw
         G87W+sq0G9giQIfQ9PM3ig7Ofyfe6g4KmmhYAcZHEsva/ibQvExv3vva+rPQ44uDJ5bU
         xjU7COUurAvyoUDkaSyIt0TrCSm268WBPMnoqkaFC5NDZH5cHq0EqbRNFKMKpeUqGNp4
         pOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793106392; x=1793711192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vbRBu1C63eyTt9/fvNVaFYb4y1grLI4jAq2tU4V2p2Y=;
        b=1cuXQLYG3XxHPqZ8H35CTaLlAMBg9oa2n2TjygSs4DCgkQlxknVb1RQCeQJdHD4CSO
         /QOrJ19imoEtZlbT6AlMiI6rnjWoMwmE3FMbUXsD7fJNxAg/vEWk+ITn/JOxGZFwOklY
         gxBij64VZsUtJS70fjQKxV3tAUg9zxrrnrHJf5DN8hnFMOtEvZSvCbz9e1oryPa1235x
         xLL5v2Wpz44nTDUu6iaZ7jIFH3nMLV41uAmj+CINjdg3zIPfj2FBZmXeLGPF3xXIEDRj
         L4m68328/Xz2FCXdVD59pEsDlc8KHYY++TDx8OA3brXVRFxKE9DaZw5BDCScrPrfEwwI
         JacQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIY1q/qtK1S0akeskonv9Os9NLsoQBWsJFR8O9kiMmwtQbGHEpv7phtPLHJBCBpZKsf2zd3vQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7TxnSqLcyC8tuiituxNvhBsTqmb6f/Ng3s/gj3Was1nGVMHIR
	lBqGpFeOnBnlpbFCZHIhyryPFeAxWGTAMLv8LyUGFoJFJcrasvAnVs87O6pdgw==
X-Gm-Gg: AYBFou2BXaU9eslZgVhR9UQQPpHJU37/IvLcoPabqIUsGRbBVrLltEGsDdR6EpYJkwN
	Hx25xib/Hi8gq8wH/pc9xXD3Zf7SVRiW992Lw5GhJG2OzdIlXWz0SFGJZY2KVLfAvB0tljATF9x
	oUjwjK7mO7XKV41JWqdekwBK35Xb0yUslTrEC2nrI3dQcf+cfw54DyAK6Zu8CoAJ3sAUiTF78m6
	TdWmwAnhZORGPRlzeH1grFJ8IidBYCU4h32AECqHKCX2x0yuwwSSbt+Ku6HJB9opRkNZM3TJUZU
	okcIhrnDV1iGUC5dp0j78qnVlGNCehIfqPJ43UljwOsKunE7O0HROgx7Yjn8HiOhwMI2dwkIUmx
	C94Xhx36XjtMMi2REwwCeqo/TUcVDAFyaiwduqkpm6FyiIDnybAHlcWfERXsjaI4OWCnJkrpZM8
	J8ebKF+lBj+F1gNUw+LcbThhpV3RvzTWB58J6EmSawBUv1yQglkZdnZK8Ou4vZ6vNxdVAObyD/j
	fkZ6DDgYDOLHTy1d0WHSYNCWn2T8GT16xv+tUISaFO8Wq3hMXzWylVYgFP/12eTyhUnYwq2ex63
	H9o5CnjuVYFZifEonITxinQi/81caUpZys1D1a4HaLadXrQaYb39Ql14ZGnV8CjMk8oGEqKW+WO
	4hUtZ2PrvW7+FfcuoOpr2rnYe
X-Received: by 2002:a05:701b:4544:20b0:190:f24b:9491 with SMTP id a92af1059eb24-19b5804d78amr11537959c88.12.1793106391697;
        Tue, 27 Oct 2026 06:06:31 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a249c331sm70137612c88.17.2026.10.27.06.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:06:30 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net v3] gtp: Require 'CAP_NET_ADMIN' when joining the gtp multicast group
Date: Tue, 27 Oct 2026 13:06:23 +0000
Message-Id: <20261027130623.3136658-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The gtp generic netlink family sends notifications on its "gtp"
multicast group when a PDP context is added or deleted, and for GTP-U
echo responses. They carry the same attributes as a GETPDP reply: the
MS and peer addresses, and the TEIDs, or the TID and the flow label.

GETPDP requires CAP_NET_ADMIN, but generic netlink lets any user join a
multicast group by default, so an unprivileged user in the network
namespace of the gtp device can read all of this. Found by code
inspection.

Fix by marking the group with GENL_MCAST_CAP_NET_ADMIN, like the psample
"packets" group, and with uns-admin-perm in the gtp netlink spec. Only
users with CAP_NET_ADMIN in the user namespace owning the network
namespace can then join it.

This is still weaker than the check on GETPDP, which needs
CAP_NET_ADMIN in the initial user namespace: in a network namespace
owned by another user namespace, its root can join the group, but not
use GETPDP. Genetlink has no multicast group flag for the initial user
namespace, and ioam6 pairs its ops and its group the same way. This fix
blocks the unprivileged users.

Tested by joining the group as root, as root without CAP_NET_ADMIN, and
as an unprivileged user:

Before:
  root: joined
  root without CAP_NET_ADMIN: joined
  nobody: joined

After:
  root: joined
  root without CAP_NET_ADMIN: EPERM
  nobody: EPERM

Fixes: 50aba46c234e ("gtp: add notification mechanism")
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v3:
     - mark the group in the gtp netlink spec too (Paolo)
     - v2: https://lore.kernel.org/netdev/20261023073738.2436362-1-anilkaushikwireless@gmail.com/
    
    v2:
     - say that the group check is still weaker than the one on GETPDP
       (Sashiko)
     - say how it was found
     - v1: https://lore.kernel.org/netdev/20261021065750.2069795-1-anilkaushikwireless@gmail.com/

 Documentation/netlink/specs/gtp.yaml | 1 +
 drivers/net/gtp.c                    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/gtp.yaml b/Documentation/netlink/specs/gtp.yaml
index 7871f5def054..b65e18ae5df2 100644
--- a/Documentation/netlink/specs/gtp.yaml
+++ b/Documentation/netlink/specs/gtp.yaml
@@ -194,3 +194,4 @@ mcast-groups:
   list:
     -
       name: gtp
+      flags: [uns-admin-perm]
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 15b5d845fc3b..8b29c35d7cdb 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -118,7 +118,8 @@ enum gtp_multicast_groups {
 };
 
 static const struct genl_multicast_group gtp_genl_mcgrps[] = {
-	[GTP_GENL_MCGRP] = { .name = GTP_GENL_MCGRP_NAME },
+	[GTP_GENL_MCGRP] = { .name = GTP_GENL_MCGRP_NAME,
+			     .flags = GENL_MCAST_CAP_NET_ADMIN, },
 };
 
 static void pdp_context_delete(struct pdp_ctx *pctx);
-- 
2.25.1

