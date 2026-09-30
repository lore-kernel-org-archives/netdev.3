Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754FB35202B
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760710; cv=none; b=mzjEEKgFgPrunViYLmOqh2BIduDrM99Ik/uDqo1DLaCEZYNkmusk9yHBprsAbFNoQdW6qgkx9U3+yLigQiWC7HSgC4SsRzCXZmMttiWLDtkXYFzHNTt3ECgbNyfuWFtEKZ3V5WXnNAlLWUeqPV8cZfhedFBXGmDFUJ+u3zwesEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760710; c=relaxed/simple;
	bh=p0gH6VhX6KjMP+FtjJ8plJhhVTCWn3ruBIwY/HkF3H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BAgp5S9FTqS4MzA31kn7m8xbwSby3L5mahN5CV2fLJIjpIQ8nRCA3m0E9DRmJg7hV7ypk0nCoQqozXlFG5zv2RjKqMTyLhqaOwG24ayYYQ9YJEUwiUYYIOaQsrfRAZ2lV5k4fd3sV0JdFDl2aqK8RHvIXzz3yp4Ah4IkFZgyuSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security; spf=pass smtp.mailfrom=octane.security; dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b=XaQQUDej; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b="XaQQUDej"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-3468ec309afso2304589eec.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1790760707; x=1791365507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YQCbSgazPMjYU8lcAbB5w+2GY09p0ZB9zD7aYR/EAW4=;
        b=XaQQUDej1lb+sE7thEnG9sluKhCdjZfOptgMX5Ny70IkfnKsB7XrWBht5YgGyFfE+q
         6r10++Te31B6JOLogbSU/I9xBepikW8z9nc69tbKcuLt31oUfbfUwL9UlIIuDY9CRFT3
         gZaJpe3KUHMEZanlS/j5GnMUmhkqbNnGTUo+hgUSrGvK+ev+h8A6S76rogqU4/AqHRRv
         IAJuR73FbMOB4ZMSkMEYjNwzhIA34YFQ0qLYsgW3V9+p2Nwof14l2f+g58c3YNb49bBW
         YKh52ccZlO6EhlPHje2VBSfhKeQj0GU63l0oAw4SagaFV8Yfy2pVecX8oNyEElofP54P
         NsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790760707; x=1791365507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YQCbSgazPMjYU8lcAbB5w+2GY09p0ZB9zD7aYR/EAW4=;
        b=OhRTtahUAn1Vm45Xa5oMmsJEqESmQcfC1JtOgP7FGLi7PoIg7GDKEEvaKfL+tL11Dx
         IqQgWnSIE4ilSPcLZ/3FQZP97WPkKtuc4g04zCgqR/cvj+OmVDeEo4TI5+W4RjPiwxJp
         CtRcWYLP0wsoSnVyM7923XDiVEGFBiZ1eqh8kaIluv2JFSMYVH/jFF8+B3WBdxYT8nZe
         eqid7r/Z2OmpfA4cRblJfx6+A/jnGAdyMtGYmExU7UxrH1MF8v1Ugv/vSPbt7UmbvzUu
         DeOQ08cLC+TspEZAGErceNttM6l0zNo4nnA4NmVuR9w19vxZ636EdftYGh1SolmfXFpL
         EJFw==
X-Forwarded-Encrypted: i=1; AKwUvByOnZZCVXD983MtHzoWDFRr/n7u1Eq5TubwwWwcqLlJnAyudquTyD3JwUzvYpE+WLvNIg25u08=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGvtcC/eIsBOkyMffKHZLriFJNT1CvjqiUZjZRAWQwT9LwrIHD
	P3mD1EUPLqjkQN/0uZgbbovJIIgllJoBAh6KXdgK5KeGd/iwBhICSdFjTb4TtNCKLu0=
X-Gm-Gg: AYBFou1zCsl15asgnOypp4lnNe5QgpeO4htxn8X7xW9qZgRUCX7ux3py31P1FrRFtqu
	GB2g38xLGL3z9glqzG9cyamO9iEg9yKLrZMWgVezyXm3DO/Y4DQvKv2/5h08u6nxrdbgDFBiIN+
	61Rl9k918KU5JEzRkBsMz0msjvjsCCBeR3N1JoJ5nMvC5zpwY7PdEqr/TGSCGmjyKj7TIgBkd80
	VgYx5wkI8qPSE0DvJu7d4o3zr1sUso2QYTLfgZv4hVbnmXgAdhwfMPGKf4RCELPNCSnKPEAfkaD
	qREcsGwvl1SX/qCC/cm2XLuoa+dZ7+HZ1Xn9/ZW3wy0KXfKb5tuB9+WViJqAnlZ70oVOC21i0/Y
	J/tSBMEB/BwRrqtngSsMDszFL27uRXt9SI9G68TsMYWWETr0B0xpTziV0OFamE5CwXY3ZEER67Y
	k0dMvx+QYHqC592nujRaFa7Oe0c1+a2rxms8iDIA6lLTqrOydOKqkac9qcw8WTyxeFmjxyRvIdp
	NSGCRYB3uymbBqLD67dTYqNEi2d9u7lU/7eYxRR3z8fVxDk/hVxNSMajZ0TcicMNsS3kDdwHLJj
	j7P8k7ApCA/RYDwh
X-Received: by 2002:a05:693c:66c2:20b0:34c:7e54:65e6 with SMTP id 5a478bee46e88-34cd91735a2mr1060753eec.5.1790760707160;
        Wed, 30 Sep 2026 02:31:47 -0700 (PDT)
Received: from localhost.localdomain ([45.125.62.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf4a64113sm3727804eec.8.2026.09.30.02.31.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 02:31:46 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shubham Antil <shubham@octane.security>,
	Giovanni Vignone <gio@octane.security>
Subject: [PATCH] xfrm: zero-initialise km_event in replay-notify to stop stack disclosure
Date: Wed, 30 Sep 2026 15:01:37 +0530
Message-ID: <20260930093137.7163-1-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrm_replay_notify(), xfrm_replay_notify_bmp() and
xfrm_replay_notify_esn() declare a struct km_event on the stack and
initialise only its .event and .data.aevent fields, leaving .seq and
.portid uninitialised. build_aevent() copies those two fields into the
XFRM_MSG_NEWAE netlink message header via
nlmsg_put(skb, c->portid, c->seq, ...), and the message is multicast to
the XFRMNLGRP_AEVENTS group, so two dwords of uninitialised kernel stack
are sent to group listeners on each replay event.

The request-driven paths set these header fields from the requester
(xfrm_get_ae() / xfrm_new_ae()); only the kernel-originated replay path
leaves them uninitialised. Zero-initialise the event so the header
fields are sent as 0, the correct value for a kernel-originated
notification.

Reported-by: Giovanni Vignone <gio@octane.security>
Assisted-by: LLM
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 net/xfrm/xfrm_replay.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
index dbdf8a39df..9394953247 100644
--- a/net/xfrm/xfrm_replay.c
+++ b/net/xfrm/xfrm_replay.c
@@ -40,7 +40,7 @@ static void xfrm_replay_notify_esn(struct xfrm_state *x, int event);
 
 void xfrm_replay_notify(struct xfrm_state *x, int event)
 {
-	struct km_event c;
+	struct km_event c = {};
 	/* we send notify messages in case
 	 *  1. we updated on of the sequence numbers, and the seqno difference
 	 *     is at least x->replay_maxdiff, in this case we also update the
@@ -304,7 +304,7 @@ static void xfrm_replay_advance_bmp(struct xfrm_state *x, __be32 net_seq)
 
 static void xfrm_replay_notify_bmp(struct xfrm_state *x, int event)
 {
-	struct km_event c;
+	struct km_event c = {};
 	struct xfrm_replay_state_esn *replay_esn = x->replay_esn;
 	struct xfrm_replay_state_esn *preplay_esn = x->preplay_esn;
 
@@ -356,7 +356,7 @@ static void xfrm_replay_notify_bmp(struct xfrm_state *x, int event)
 static void xfrm_replay_notify_esn(struct xfrm_state *x, int event)
 {
 	u32 seq_diff, oseq_diff;
-	struct km_event c;
+	struct km_event c = {};
 	struct xfrm_replay_state_esn *replay_esn = x->replay_esn;
 	struct xfrm_replay_state_esn *preplay_esn = x->preplay_esn;
 
-- 
2.43.0

