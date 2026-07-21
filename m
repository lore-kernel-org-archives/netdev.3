Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F57125392A
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651995; cv=none; b=ZxGHEyRZyof4/R88uUQKqKkw9Q/EsN42lvR9Ke2oJosTTs4/MsqkhO2GQqlZTayt5zfXa9CZD1tMEXe/7R2dQKBA+IUQuiGyPiGgxwuyMfZ7e6z4dUvaTJBI+i3ysDIqJNCb5fdMNALfoxQWiS/2cmJ6W/DVtFf23GbIPc64rk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651995; c=relaxed/simple;
	bh=/qjpJGrIfmHCq5Mj7sHf5syvJk05WVinZrublwWpFh0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G/I+tM0ppvd1D0+B/SrYV31H9ftfxmDXFfj0al15QqjV4SsI4kMAvt+fRv7AxXuQiwjo6CkQSPSj4DFRnwbZFMjKClKoqwUkJ2bcXxNAbDM0w/7Ut2tVptv2RJjDEeMuecWOBq+xzNfwB9AisM6Kb8JWl6ssOBHsggmidbzFaA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YHEYMCgs; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YHEYMCgs"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9308eafb465so1531965385a.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784651993; x=1785256793; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8/zfJ9P7MdvLArlXJSKO3GtfybEZAAWoFc+UbZLGEkk=;
        b=YHEYMCgsu+tR20PSO7m58mdq8DoZzPDudftrg1gIK50Ntgt5MOcw92bK/AgpN8bO8t
         gGR0O4s1fBUBDDZmfFOiT1AhgHPQCmIb6xO1Auy+qWXwzYCdQOgeHz6jkwe6dxk8X21a
         GC2FXp53O38gvI7kDIrCQLSqVveFrN8/ilxnrsr8UKu/oh0Y7zPXKettNapCSXY9cE0c
         6tcFk7KgFQNEeSu55hlyFLDSkDNBlSI/kD2rybGv47MvcUwqkViPM9uCnLRsPWYVSkF3
         HUAf9TB/pmzAnCZK88E2P1s5cABHkQS07aqBRZ9UCTCG5ipQTFWpAX7xcVHSAGBpFDcQ
         lA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784651993; x=1785256793;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8/zfJ9P7MdvLArlXJSKO3GtfybEZAAWoFc+UbZLGEkk=;
        b=dBLSZN8n+BPBEXEg6fHjy9DEynpgELofBH7Mj3RXnoOYkOaddlVlVb0tE5n6X40FIr
         5lxWkPWUC477I1nlDUZm+YEAQLNwquWN+1kaDdHwIjQbNdzqrJCYLrKd6I/2/vAIWcKm
         dpTqGccVSUbmH+CQMaAkv3ZK+y1TTOOpUJXqvLvT+qD0gi3k55LwBZ1ko3vLKeYsRD6L
         J/27pvF4zdhiUuS7eKLvLAP8q9T0SYU/FAQbr/c5DbhkMyeKmbfJtH9GKWY2VzrZIhgi
         T87oJrPDB6pPBeXP+E2fYiNpH3ipYr8fO4FFWI7Ali9khL5SlLCvwC3nMLTT4q5GUm/z
         JsPA==
X-Forwarded-Encrypted: i=1; AHgh+RruZz9ZAOISUyd4QzETMbYUR9QP2N/CunyAEcESRgeGOASLfLi+VKQQSQZway9B+5HB5AFy2ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA2QknuP6X4p+fHV7BJLPhdbzWRfj5HEnEm/K9mVOvhf9g0hjy
	KtpesM0axEOwE3no7m6s1ViKRaCfb9oH8oPtVAzRFHA3T0JbIe2unyq0V/fR/gw22BNPNjvjuU9
	NFOXgkpDSA0kyEw==
X-Received: from qkkb23.prod.google.com ([2002:a05:620a:1197:b0:915:7e37:5cd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4049:b0:915:745a:70fe with SMTP id af79cd13be357-930b3f45466mr1986225985a.28.1784651992239;
 Tue, 21 Jul 2026 09:39:52 -0700 (PDT)
Date: Tue, 21 Jul 2026 16:39:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721163950.1483019-1-edumazet@google.com>
Subject: [PATCH net-next] geneve: fix geneve_config leak on
 register_netdevice() failure
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

When geneve_configure() allocates a new geneve_config structure via
geneve_config_alloc() and assigns it to geneve->cfg before calling
register_netdevice(), if register_netdevice() fails early (for example,
in dev_get_valid_name() due to an invalid or duplicate interface name),
register_netdevice() exits without calling dev->priv_destructor.

The caller (e.g. rtnl_newlink()) subsequently calls free_netdev(), which
frees the net_device structure directly via kvfree() because reg_state is
NETREG_UNINITIALIZED, bypassing dev->priv_destructor (geneve_free_dev()).
As a result, the newly allocated geneve_config and its per-CPU dst_cache
are leaked.

Fix this by invoking geneve_free_dev(dev) directly on the error path of
register_netdevice(). Since geneve_free_dev() sets geneve->cfg to NULL,
this call is fully idempotent and safe even if register_netdevice()
failed on a later error path that already ran dev->priv_destructor.

Fixes: 0ba269933f73 ("geneve: convert config to RCU-protected pointer")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/geneve.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 17bd3543d587a9e941737109df82b83023d23711..eb156f33b62751b655178ad4f37d2c66f909ffc7 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -2043,8 +2043,10 @@ static int geneve_configure(struct net *net, struct net_device *dev,
 	}
 
 	err = register_netdevice(dev);
-	if (err)
+	if (err) {
+		geneve_free_dev(dev);
 		return err;
+	}
 
 	list_add(&geneve->next, &gn->geneve_list);
 	return 0;
-- 
2.55.0.229.g6434b31f56-goog

