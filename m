Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280353469F6
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931283; cv=none; b=lWvsbMtm/eUH6Yrjd3LP8Hur7neP9HZypS240gOClY+LhdlFSl0Oqs+I32G9/+/RTMWhAormYmy1KP1O2VX5ikfTPdkSW4CDMADmoeqzn0ASjMjMD0LrrwgnSzBQt3Dm5hEQ19OJMUZ7si1PJCMjzZIMAXbc9dhR2OT1ttLQrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931283; c=relaxed/simple;
	bh=17sbTA3zHpidwXg6mQVDZcXrXShVsrdtcJYk46R8Dl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPCWUFPj44yZs52S0/0+3oWUrd8pK15IzvhcdqUbrR6I8hWvS1Jkm8FUxy0lDri7tcMBS6/9gmIEjTHaBdJfWkwJgmTSwdEn45r0rlNs8XeOsETIVFvt05ohlj4uy+CkXfBpmHzMoKwOO4EVQcr+/xJ7/OLM9RQXWczm22+z854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bIB6JUuL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bIB6JUuL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso36575075e9.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1780931280; x=1781536080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhGKC4HtWHOvasUkvWPAtqxR+wq0zox5gwYzF9/jpqg=;
        b=bIB6JUuLKL8MNZURxbSx5ZXrJCo1D92DD32nR1bnnFgV+Cd97/268CosGtbmSbKQqn
         GZ/N+n1Z2qHMUBTlL8Yo5U/772eCaxUoIX2xc+y6T9H63ybNndqeVS2T5AjVFiiIK8cv
         lApFBPVg/3/QEprqtWwL5dJIRtfnGkEhqS7OOVnOm4k2eJK8s7jK4lvEJtAtuzECl9qb
         KGvCi1ZfhIDy2lwJ3yH3it4RW0mH+B4x4LHphRYNO0idCy1IcDHBomh+V7g0AfUrfc3L
         wh2aPBQz5ta7gHheHsedS2PahBD7cD/AldKWvkURJMET68rqmC86dRgOTcwidVPFKNFk
         DCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931280; x=1781536080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JhGKC4HtWHOvasUkvWPAtqxR+wq0zox5gwYzF9/jpqg=;
        b=YXLsO75GtC6ZmET957Qmsg/InHPu87vDHnrdt4oFj9r/lVV3iTIKduyjooEPRxSaeJ
         x9WAq3GozD8EtNHtl5UtoteBo3Hx1BBqS9CcKTtXvTGDqxqm32ruU5sWEmA7EdE+L7ci
         o2sYssnZYP9Zhkb8sm8LESzEsmb1VCqktoQEYq95IygXBkgw9Y47LYYU0WDgWmdR4+2+
         lFCK3bRTRtcOHmukzVgOp3looN+T/NfUAn48u6ecjF9hcE/3NH5Xrp2p6Kdi7VKwfdLv
         hqPqGPFfLmFhtP5n/IQVj4/qEKtzyKOhBuRAGdP1Hx3UTiGMKJdF9COYP68dEiaJjfXg
         zjIg==
X-Gm-Message-State: AOJu0YyVdORtOqqLHypPwbXXPM3L9qfS2mrMY9WNBEaRtQXkqNSlmcqH
	eb3ZZrGCQ+d29UZvPfsnfZJRWWODpPJWvmBWF4Z6A6pytVSANY4NZObmDHnYa17Xe5dOtjU6J8Q
	kBTOSZfSXjYM7X4ovLiP//2S5mQRaNF/Slw7tf6A8myxIDosrD9e8uUzIdyoEl01t9AI=
X-Gm-Gg: Acq92OEhLyS3sgYoSJwHVG/c5rCRGkbhey2qRGTLYM9BzK6AoF6XU9rRqb5Ha9/hJDA
	8gwAyMx2GyFTTe08fVaM5hYU5l6Pu9ZhZMCnjxQoj40c1VS4HWmtN9xo1EmYWeOVM9kATgnvFJx
	bfNR/I/hb+4lEAl/u4rqsIKK3TvhVQGLWd7ulOlobfF7Nd/dcPizsdCy2WAUJ5zLWY0DBo0bZVE
	oxzunifjDP1VTpovIO/TwSt7CLI3teVVnMi/MCjQeGS+1YHrNetfAq+jxgOsC1uM5U0kU1cbr/b
	jCClHQiCo3wOlPn1bSk9a1UxcEjNc6b2Q0f/5Y65Eeu6d46kCgqKehRGHZEwVH17zi12JLDr4l2
	lNnod+qsY3diqi9MXoeG7IR/QsNHWkRa7ZrI3VtMyXS3x64L7s4DT+JOFsyE8YTXQafHiFzppIe
	+P/ssZNZKQMxprrHCdccbyI+2cCJyYyYhl+TvXqcGpSs6l//7AYe0p/HVWiKwTNjhVy5Vv
X-Received: by 2002:a05:600c:8a1b:10b0:490:be1e:6ce6 with SMTP id 5b1f17b1804b1-490c265c075mr182241585e9.9.1780931280568;
        Mon, 08 Jun 2026 08:08:00 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:7e36:aaf2:5280:7b3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm390659705e9.5.2026.06.08.08.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:07:59 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Marco Baffo <marco@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 5/6] ovpn: fix use after free in unlock_ovpn()
Date: Mon,  8 Jun 2026 17:07:36 +0200
Message-ID: <20260608150741.3320919-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608150741.3320919-1-antonio@openvpn.net>
References: <20260608150741.3320919-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Baffo <marco@mandelbit.com>

unlock_ovpn() iterates over the release_list using llist_for_each_entry()
and drops the peer reference inside the loop body via ovpn_peer_put().

If this drops the last reference, the peer is eventually freed. However,
llist_for_each_entry() reads peer->release_entry.next in the loop advance
expression, which runs after the body. By that time the peer may have
already been freed, resulting in a use after free when advancing to the
next list entry.

Fix this by using llist_for_each_entry_safe(), which caches the next
pointer before executing the loop body.

Fixes: 80747caef33d ("ovpn: introduce the ovpn_peer object")
Signed-off-by: Marco Baffo <marco@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 2b6096d8b1cc..8fdbb5050690 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -26,11 +26,12 @@ static void unlock_ovpn(struct ovpn_priv *ovpn,
 			 struct llist_head *release_list)
 	__releases(&ovpn->lock)
 {
-	struct ovpn_peer *peer;
+	struct ovpn_peer *peer, *next;
 
 	spin_unlock_bh(&ovpn->lock);
 
-	llist_for_each_entry(peer, release_list->first, release_entry) {
+	llist_for_each_entry_safe(peer, next, release_list->first,
+				  release_entry) {
 		ovpn_socket_release(peer);
 		ovpn_peer_put(peer);
 	}
-- 
2.53.0

