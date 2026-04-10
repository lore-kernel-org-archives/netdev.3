Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D669C2D949B
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847836; cv=none; b=QwXHcws3S7qu8t6rSKOMfGSzVaIcl7yvqAHzzxA1tAxfJS0ncn1UJ816pY1U/pOXp6V4Zo9RD+7zGWHqKk4w+7vkRUc/Ro0n89O96VrWqLtTSYHBi5V+AwF1KicVk13DSiSVWI6tI+9ira61PEkZ53IWuAQcVAf3bd1dS4NPIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847836; c=relaxed/simple;
	bh=Uli0c45GT4RcVHXIGisF25ZUxflV4Vi/9lJpVJyGj94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXvLMrF8LULrZ+h9k6uvQFffOX/kHqr57Y+cuRSMFiP2e6fLS+bhGREN7274XfvqwUKCR3bDNq/Z/fEq0hReqsf/l0mIxxCXH/Drn18Czoi10TVrwixqB5IMm7a+yHIi/MhfBnOKpb2tHhJk4k7jiOKGjpcghtjHAzceitg1Vhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDOKSXbW; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDOKSXbW"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89fc349b5c2so19335076d6.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775847833; x=1776452633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/rS0KeXOcqcVUCkXHDnHYtVIWPys5vu/jFO0AYWRmo=;
        b=rDOKSXbWtZPZQtk+iVuR5zQPFHVoD2IAPgBZ3Nw0Vm01w+JD+EK1IxgiJI3I7bI9Yd
         /w2Ugh6KWwHZfryhl4C18va3ZzGUUG61aSARDJnLid0eMwaFGXcxJiy/iNwVmpUHKDN0
         cFpmUrOyF6OE3AamaC0LeOK8O8BrKerrmhcUtvKd93s/2CLVDLDm1LRwruTuTf4RuAWk
         8DgZxC7buXW9h1Z5CrQjepWcF/vaLI2Qu/pgxo8oNW5hdHgRCfkeOMD8iALv/fu1xwea
         I8TwgXNsBBwKaZDpqbi7STW1zHoeV8rP0SUcBGKXk0ElNVuEajbwlzTrt5//OswOxVNS
         nXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775847833; x=1776452633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E/rS0KeXOcqcVUCkXHDnHYtVIWPys5vu/jFO0AYWRmo=;
        b=aDGhTKyj+OsenTLfk21/r1tEoZd1c3efTcYv8iE+dgkPexLBecphajQrHYfZe5S4gC
         pPkaaM+1K0xv2ch4Sn1GroW5a9gbtWiPqICPwHEjCQTGwsODuoaGEdalLM863RZijajB
         vGAYhI154xkdJiMwpre4/J34hHJCIXnknfhlflwI2e2+YhPKn+O6xEH6gbWWcv6G0Zmm
         q96HGEpVXJY/w5bMM2a6pUYd/C9lk20DDHMUaOG1gOt/xdX2etCA6e9fdIABiYTmb3i8
         OilOE9rLgRY2TtK/GQLA97t5TLqjiFqKQ90XeTdtwadZ2WepJv1f/WPW9FpL5Rwnnhv8
         jFCA==
X-Gm-Message-State: AOJu0YzqlYlkG+svpdh2smdI+SBQ8erf5b6Ga1woFJ9qP42P2A20dtbu
	sZAUuXp90gqdZukXZZrtMJdHWlEwfFYhDYxI96TVnuCgmkCt3FldMLBDD2OPq+8+
X-Gm-Gg: AeBDietVb23REtaFAEqDHw020Kypzz7CEfSElUewGbzRBxxjsef5CJfBU1DFaLROmT5
	8JqgW8flngGHDuTXvaK4e1MDTbmMA+hTuh+PVQbJEQZ1h7wSF/2e7fqJWBtdi7dgwVFnTTMTmG3
	0CQTR3FmZBU9wNflEJ+wfsgdmFtkLXmuu0fw2CG1CQVEhyq3eoGlxJqNF9/OaRkrtw8OzJXcZmr
	st+BE39l/iL/up+PPzlmUUYm/7aEOz3FjCiLjssd+ovD2V1pZwyX4LqeeTnOBLYHBpqnLc7sXB/
	uragEzdU2yR5+o3z7KbFNNBXz6BXXfN87QMfuvCTquZN/gVL2HjXJ5g6CE4n4hqLEo1pc4kKaFn
	FFxyg6JR5p820iK5v1/B80VP6XNXwV+iZ39beGhuwnhV5FKMCwuaHfUZ+zkyglBPxDVtQItLacg
	2jbYkqpNtT0r9lsXBgvYidFQz1vaC3f/vIbAZGoo7vGqKwM8asHE+uehRiuzpeIsBa3HnjDSlHA
	KEaytFe+USc8Bw0zwYvY8DvJF3PZGdjqOaFNz9c2VXwQXRdUJrsXv6WD7p+QH0Y
X-Received: by 2002:a05:6214:419f:b0:8a4:5cfe:a204 with SMTP id 6a1803df08f44-8ac862915a2mr63565796d6.26.1775847833399;
        Fri, 10 Apr 2026 12:03:53 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a47a0dsm30598726d6.22.2026.04.10.12.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:03:52 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Yi Chen <yiche@redhat.com>
Subject: [PATCH net 1/2] netfilter: skip recording stale or retransmitted INIT
Date: Fri, 10 Apr 2026 14:59:16 -0400
Message-ID: <6e09f9a8d1f13f3ce691c696d3dd7b2a2e6c6184.1775847557.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1775847557.git.lucien.xin@gmail.com>
References: <cover.1775847557.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An INIT whose init_tag matches the peer's vtag does not provide new state
information. It indicates either:

- a stale INIT (after INIT-ACK has already been seen on the same side), or
- a retransmitted INIT (after INIT has already been recorded on the same
  side).

In both cases, the INIT must not update ct->proto.sctp.init[] state, since
it does not advance the handshake tracking and may otherwise corrupt
INIT/INIT-ACK validation logic.

Allow INIT processing only when the conntrack entry is newly created
(SCTP_CONNTRACK_NONE), or when the init_tag differs from the stored peer
vtag.

Note it skips the check for the ct with old_state SCTP_CONNTRACK_NONE in
nf_conntrack_sctp_packet(), as it is just created in sctp_new() where it
set ct->proto.sctp.vtag[IP_CT_DIR_REPLY] = ih->init_tag.

Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/netfilter/nf_conntrack_proto_sctp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 645d2c43ebf7..7e10fa65cbdd 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -466,9 +466,13 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 			if (!ih)
 				goto out_unlock;
 
-			if (ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir])
-				ct->proto.sctp.init[!dir] = 0;
-			ct->proto.sctp.init[dir] = 1;
+			/* Do not record INIT matching peer vtag (stale or retransmitted INIT). */
+			if (old_state == SCTP_CONNTRACK_NONE ||
+			    ct->proto.sctp.vtag[!dir] != ih->init_tag) {
+				if (ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir])
+					ct->proto.sctp.init[!dir] = 0;
+				ct->proto.sctp.init[dir] = 1;
+			}
 
 			pr_debug("Setting vtag %x for dir %d\n", ih->init_tag, !dir);
 			ct->proto.sctp.vtag[!dir] = ih->init_tag;
-- 
2.47.1

