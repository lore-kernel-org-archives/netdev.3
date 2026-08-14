Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B93EB0E1
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751366; cv=none; b=Cnt8NhZfpyCWHb1Ix04lFot4RoevGxH6BArrUz2LIs96leACdbnTsJJmNl0h2Y2MakUT2A6kP0ZoBVGoVjsKAEPP9tlTEh6HWoLgonFPIebOD0f6yU29kcjMqlbdWbm6cTL803NvC2D0KSlxncwTfx/ZiPqdsoxYndLof5HoxF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751366; c=relaxed/simple;
	bh=i5raLJ/viRB4jfYcj0wFvVQznmGjwyiH+SUbX8pRp8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mbotkapb2EbcHpi3sf+URk3dllllMZSHDJ3EH12ZK2NAcPW6W/FZ3ZyCu9JBqG6RPYkVgiSXWn2rGlJf2Rpaw8ANZ7bVz8hagUUZ66RgskgNeP+5XFLJIqwNMznUsWOXn9ms/kZbd2xMReNZpNAytAtzmOFCCCfwbhBbYGmJzo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p6mrx4fn; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6mrx4fn"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d001671a54so31666455ad.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 16:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786751358; x=1787356158; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7djAafJOLBuE+bXbQTtDxXCPhwnYez80KiMRMTkFHt4=;
        b=p6mrx4fnHojiNdphcYhOL1pN3SK3a2BR+qXr+ynr9+jIS+E/5Lhp1IVi67MNm2AzE+
         unPSkS+O5JbFV536ggTX0fFNDsceiaGM57CD8+qsH3BOitfPPHzF/zIS+Oe//JKWHYGZ
         tgIlS8aRhAx6D+1+PmIE+pj/+mG+hyOawuWRkXlQTjCcTbeR7JwzmfNBGN5oemaKp8nB
         FFArPu+nCYHZ4i9ZbOkgdawHVtfcCf22yiTjd1zU+EitSAQrY23TEpJ+cTiiuXjkkFZO
         SnoTLO29VqgWx0v4Y8oPSQeG4s8bG93En7UdgwssXSg1wsvQqZ5s9UZ+n5u/h/Tw/7JS
         dqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786751358; x=1787356158;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7djAafJOLBuE+bXbQTtDxXCPhwnYez80KiMRMTkFHt4=;
        b=alujF4m1YulFieeSc8P76Exg460kRhFxmYaA4b3ox9WLNWkt5lrZC/+pqumfM4Nvpi
         Tu2QhzJkPegAcH0xE96GQTvoGgrLUJLg5yU9NGbM/a6SR1P51KnTHA+phEDR5xzOUcI+
         lOUHIToHQdRkLKq1z2nnYlGqEx/R+7hCm7ekE5NOwRyqfHsUGS3I9WtPTxcYtzl4zGOG
         VTx+KN1L8cVts0ohTE7xPEnRnCNd2U2V+nn+qTmheXbbnNRlED/B5I9dGrdAiI3ZYFxc
         pObdnryc15x/PVTZisXLuflSdwym3dH5YhNiuaV7tEloJNKXCpoFrN+AAnkM0jDYEotG
         NPgA==
X-Gm-Message-State: AOJu0YxrX85ZIOX7Qe14lOp2mWV4tPl5WXH3b1eJcyRHeY4uzTxUEpS4
	+9N428aNLlCxP774SBqodjAQphsokBMBlGrjxlD/P23dhG6tp7JGN2zqIjaHapJoZggsCi95Kv+
	S0u/8Oh2NpHAyun9i/N3z2xtqzi75T1HLQzwdlwal4S7DhA2ZLrR/IXiZoBXNEoD4/qWm0bsC5v
	Ctfl8BwHuVoYPVVikIW9V7QjTOw2NgZ0pCabkbw0Nahh4pU7Q=
X-Received: from plnt11.prod.google.com ([2002:a17:903:196b:b0:2c9:a5a0:a677])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f689:b0:2c9:fa31:84f9 with SMTP id d9443c01a7336-2d3b0cdc256mr101631195ad.5.1786751357477;
 Fri, 14 Aug 2026 16:49:17 -0700 (PDT)
Date: Fri, 14 Aug 2026 16:48:42 -0700
In-Reply-To: <20260814234845.773189-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814234845.773189-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814234845.773189-4-joshwash@google.com>
Subject: [PATCH net 3/6] gve: fix XSK buffer leak on error descriptor
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jordan Rhee <jordanrhee@google.com>, Willem de Bruijn <willemb@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When the error bit is set in the RX completion descriptor, the buf_state
and its attached buffer should be freed. In the case of AF_XDP ZC, the
XSK buffer was not freed, leading to a leak.

Fixes: c1fffc5d66a7 ("gve: implement DQO RX datapath and control path for AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Tim Hostetler <thostet@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 2c1ce23d1550..811db42d05c6 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -845,7 +845,12 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	}
 
 	if (unlikely(compl_desc->rx_error)) {
-		gve_free_buffer(rx, buf_state);
+		if (buf_state->xsk_buff) {
+			xsk_buff_free(buf_state->xsk_buff);
+			gve_free_buf_state(rx, buf_state);
+		} else {
+			gve_free_buffer(rx, buf_state);
+		}
 		return -EINVAL;
 	}
 
-- 
2.55.0.691.gc56d675ccc-goog

