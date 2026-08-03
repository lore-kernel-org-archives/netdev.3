Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B543D4334B4
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782796; cv=none; b=E9x4Xa+yN4ToIjD3TRDFHWdL5HutjBbOTDNw7lE2fnYibVXxedzWSlnG5hGdG8z/OtIKBHFmHnTqtuDvankWBZk/47ZQjf8dZYnjkDsefUhergaPYqEd8tqvBOQxWkHYnExNuOEkZeLEocC1Skotw9JMLQY0BQoyvitBVfmlvNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782796; c=relaxed/simple;
	bh=frH6jsEdOdsfiylCZZU+8mNGyrjO4vDVEUrOEZEaJOY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V0g+xif0EwQff4Kl1DVSTsFrW9Ftni59TfXcc4lxLKWSsDuOPVGP/xeS/+hk2jqY+hJeYkR3kPRqNgBPYrg4RH7yKbA/n6+7TvnsPUcz8FE4+6wt4ksu8BQxH+fKFyJH7EWt65+9/5pXI0PlHJBz27WHq520kmCBl1MfKAGdPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RPhVQiiV; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RPhVQiiV"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84885a4fcabso4354550b3a.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 11:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785782794; x=1786387594; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w7ASYggieirjDdtwumqn+FDfbcMK1nGnAGwXV10QRd8=;
        b=RPhVQiiVi1bz+RotG2Qq2bhDLzD8jNN9c+6VdJjcOEM10hNY3MHg6IB1SzNX5h2R0W
         +nGVmIcgbc3hwVIciQmUPM1OtGeH4wRv9l8tv9Zu7oJ4XWtDl9C/BslYO2eklbG7ryKD
         V0PjopqziA/Hlwebb6k1mi9hZvrfDuG+2EJIDGn71RsTtx2hCVlL0h40VvlVqxQLmJHm
         jVVwZgRTDZLkSvJqhy6wSv3qX/K0Hesv9uZDzowg/ry5YHQUkvB2+C9+YB4phbKqGDTM
         2rKGED1mQhwTlLrzhj/VY2DR4wCkpgRuasH6ALOMUbXdlB4hn25EXTepwqCe/N6Yzz/O
         ufOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782794; x=1786387594;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w7ASYggieirjDdtwumqn+FDfbcMK1nGnAGwXV10QRd8=;
        b=GWRNdi2BR2uRwbiGgqFr+qVNG9AGSiLHbsFa6Dhn++CRVqJeemB3WZiAjJMkpPphjX
         xIqr3L/OhiveooCs+SayYh4lS8D5wh+TLBmhDOa9kShTCKXXhkB+vCRUYkCfMxAwJPB+
         qQCBjK5Nsw89QWMk5g1LOOoW82BHacTTjdVmIANC6Ju0fqRWrA2DGkBSVdgpoX01R6TE
         t2GxnItSOD+ZR7auXCAlGmAp3UdUM7FXv0r4bylhAJFDS8CjTZqjBmQbSUbXivUV99+N
         iD7KUEwBkidYpLCX4Cv32b9tsodJwLpXVlvdBOiiau0KLVcnazeV5YBsWRYXAhzwstv9
         kEmQ==
X-Gm-Message-State: AOJu0Yxr8mhZ/6v7GcDkAfiAPJx/+kvJFGyz21rL8esDfj6ggol+32Yp
	cYWvnxQ4o9I4GjE1RqD4TvF6h8gwEhj0uB1OpX9awhWpWUDAszZidYATpMshmXstv1xHa4luRD/
	aGoim8tGhpClOGu6eYKtf7tJkKpABw4zFwxwDxryw2EFMAYHHqmCGji5iTlibf1WcZzeBGLPAGg
	T0OEo2zud1CsPr3us1lDBHCeQl0aXJ96PPavtSLbahMDsrDBS3Nfxr9OOFjeIYkjI=
X-Received: from pfblr45.prod.google.com ([2002:a05:6a00:73ad:b0:845:f28c:430e])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9296:b0:847:8dec:1427 with SMTP id d2e1a72fcca58-84ee47dc388mr10092613b3a.8.1785782793256;
 Mon, 03 Aug 2026 11:46:33 -0700 (PDT)
Date: Mon,  3 Aug 2026 18:46:16 +0000
In-Reply-To: <20260803184630.3813311-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803184630.3813311-2-hramamurthy@google.com>
Subject: [PATCH net-next v3 01/15] gve: don't pass in unused parameter to gve_adminq_free
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Clean up gve_adminq_free to not take in an unused parameter.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 2 +-
 drivers/net/ethernet/google/gve/gve_adminq.h | 2 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 08587bf40ed4..70ffed8b52c3 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -385,7 +385,7 @@ void gve_adminq_release(struct gve_priv *priv)
 	gve_clear_admin_queue_ok(priv);
 }
 
-void gve_adminq_free(struct device *dev, struct gve_priv *priv)
+void gve_adminq_free(struct gve_priv *priv)
 {
 	if (!gve_get_admin_queue_ok(priv))
 		return;
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 22a74b6aa17e..8e80f36116ec 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -620,7 +620,7 @@ union gve_adminq_command {
 static_assert(sizeof(union gve_adminq_command) == 64);
 
 int gve_adminq_alloc(struct device *dev, struct gve_priv *priv);
-void gve_adminq_free(struct device *dev, struct gve_priv *priv);
+void gve_adminq_free(struct gve_priv *priv);
 void gve_adminq_release(struct gve_priv *priv);
 int gve_adminq_describe_device(struct gve_priv *priv);
 int gve_adminq_configure_device_resources(struct gve_priv *priv,
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index e4d78ae52daf..30bf6df4ebc5 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2506,14 +2506,14 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	bitmap_free(priv->xsk_pools);
 	priv->xsk_pools = NULL;
 err:
-	gve_adminq_free(&priv->pdev->dev, priv);
+	gve_adminq_free(priv);
 	return err;
 }
 
 static void gve_teardown_priv_resources(struct gve_priv *priv)
 {
 	gve_teardown_device_resources(priv);
-	gve_adminq_free(&priv->pdev->dev, priv);
+	gve_adminq_free(priv);
 	bitmap_free(priv->xsk_pools);
 	priv->xsk_pools = NULL;
 }
-- 
2.55.0.571.g244d577d93-goog

