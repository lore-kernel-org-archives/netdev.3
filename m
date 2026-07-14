Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEAE3630B0
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784068234; cv=none; b=GY8bXKUwXcTzMLk0UmhD1WxjfXOHTnLGyK0qqxamYyOVWc8YAEQn6reGM4peapKdwiGWCsO8vtjGBTZU1fCI/lAKXcdwQmzzCIYQpdWF5zgBjzQCgWMj76+is71qKKmAdkFi+AiDD4Onlt9TVs1ukEXsh0orBwp9pYFjRJ/VovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784068234; c=relaxed/simple;
	bh=yCxyz5vMtCXbzwphhTYHliMyAJmOkLPbekiskBvFq7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VgUiepW996v3YhHolN6BaDqnbF+WZ0uulrD4y3vvUvbv3iRHRYA2VLT7tLvKvlpbLXcS05qb9u76tevdvCl8RiB24pTKJJXJzeol6sKVVO24VKgeBT9XwOHpNRIm/Fpymfd26yQU5VoyeAfMyqw+u/Atc/8cATK7UTyYFeaGoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Mk2Qwl/N; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Mk2Qwl/N"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so11605905e9.2
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 15:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1784068227; x=1784673027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W6KUr8HepVyeORxgizJB/OB6YbettUbebwaiS4ePIes=;
        b=Mk2Qwl/NohqYs2bIuJ1d8ML15gJjVAndIhdr22Xo+oKa2F/OT23guALg3XRpzbugnu
         9bCsM3kBNGHPBEw+ByLSlog1EmhFt5BBnNV/O/SM00TmfGY9e2pcbfHS3brlT253vM0L
         7wN5dskux7SfdUAySukqug0kwNP9GM8vjLX9gYp/MDphFiKxvTWNkMrAMMY95cX3NhDz
         brvuZpZQaJqeFTzuRztzg7+U7DeL08HbkxIUdqFFTJWpDcDmZB5hyHuMiN1H0ZgQYFUY
         hbI8qFD45lRa3yK0QH7l7RlY5OkMHcn4/qMyeIPcBOAJ08dwy3XO7UHn2O0u5TCjXbln
         /9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784068227; x=1784673027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W6KUr8HepVyeORxgizJB/OB6YbettUbebwaiS4ePIes=;
        b=YmUS70iWfZqNcvVoTFJAOQzADqaTolYp/oM6bz4EHCXa+9FYbo4Op5mCUyUoOvufM2
         eKKHBOAm+3kjsXKUCtyQKqd6yqZlKfmM2ZXOJuiCigdeaRTsb73aUy06cgCNb9t4emdg
         4jYb7BYEPqaSRx7is0qpXnAnLk5bQUOx613x5v75CbI28MBKfyD5m8OIIld2XOheVVAS
         pQEXl46KcsH6KjFq5dxGqeDCH1+sP9BszBLPTEgjz4Oc2c+SZUX2Ynx8dkVz8VJGEGg7
         d2T+gtguBewCgM+PsitI5LJHNuJKVNo4LSzoPAgCgASKmpYSWuUJlPWWH/54adzB1M/k
         A5pw==
X-Gm-Message-State: AOJu0Yzy5h6qiwJpOztpvEt2OakO8Gc4TezLMvy9cUWUp0ipoTyqpOeG
	GsgHwRdGBLtaoDeRNN/uh8j61/1hIvfi9pbMC9Hy0GWOH8lDtqJMza30wXme9i3FYR5yLBSpzet
	GntTjaZAuSCvi0CAFeqSggDTTWWncCqHTi7Sy+iP0d17UKnqW6pNnYJEuIeUNOe2+RPW1vJDcGw
	Hckg9og3FeRi2aIKCEJWKIDtFgiKJBG+Do+I44bg6lqvq5GmQ=
X-Gm-Gg: AfdE7ckH56xE5KaWu4+QckgX+7AnQwsW1lij5vaz0QOJQQhVvoRrfwqBo8RfEOSxOTT
	Fb0aqL2mSBIXEQqqKN0rG14uLNbU9jHQBp7JAPJn7Tlg5jxiWWCUQ4dIUmcIdoakzTzWxpKL4+f
	BDN1q9ZIqMpJ5KbzNrztstCNZWW9SqFOOy6xrkJsSsyJOV/aD5uwANac25NynieeBseThBgL4bH
	swTQRJNoWGoSaGqqEckiHGlf1nXYqS48WTC+ZfrpCx1+yn/cOagNTDpn/9y5vGN7b08EoThkCsN
	C5BvgXqh1WMJdxQTmEVddD+kz6kWTlnFO9jchwLuCd0JY7C4tamTVnpFJkzBzuf8IfDZuVVhzz4
	kugpGLMFEsZvhISnidISWuggrQenIjbMCkMelvN7CU/aUMRerISYYOM6EqfTm4yeyGQo0W/5C+9
	T5UUatMQRnTOPBpGKkn6ggYLc70mPKOOPtiFjrwgdX8yule9r/vvElBSg5XG0NanEyy/U8g1BKP
	/IZPSqR5J46p+8fqmsiEStZQgfJ4+X9JGDfrDIsVKqy9AyVoaXLqVMNdZbV3rp+NDr+n0Wdlur3
	AUGB86ECI2LAf3E+qZQ8sP+Xccatt6D13JU=
X-Received: by 2002:a05:600c:1f8f:b0:493:e79e:da6b with SMTP id 5b1f17b1804b1-493f8815d42mr197840995e9.21.1784068227346;
        Tue, 14 Jul 2026 15:30:27 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-495087366c0sm196536915e9.7.2026.07.14.15.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:30:26 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	nils.juenemann@gmail.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH 2/2] net/mlx5e: kTLS: guard RX resync against stale channel index
Date: Tue, 14 Jul 2026 16:29:15 -0600
Message-Id: <20260714222915.2334949-3-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260714222915.2334949-1-rjethwani@purestorage.com>
References: <20260714222915.2334949-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An RX offloaded socket stores its channel index in priv_rx->rxq when
offload is enabled. If the channel count later shrinks, e.g. via
'ethtool -L <dev> combined N', existing offloaded sockets can still
carry a queue index from the old channel layout.

The kTLS RX resync paths index priv->channels.c[priv_rx->rxq] directly
in both resync_handle_work() and mlx5e_ktls_rx_resync(). After channel
reduction, a stale priv_rx->rxq can be out of range for the current
priv->channels.num and lead to invalid channel access.

Guard both resync sites with a bounds check on priv_rx->rxq and bail out
gracefully when the stored queue no longer exists. Account the skipped
request and, in the workqueue path, cancel the async resync request and
drop the reference taken when the work item was queued.

This complements the previous add-path fix, which rejects stale RXQ
mappings during offload setup. Existing offloaded sockets still need
protection in the resync callbacks after a channel-count reduction.

Fixes: 1182f3659357 ("net/mlx5e: kTLS, Add kTLS RX HW offload support")
Link: https://lore.kernel.org/netdev/20260627210635.89769-1-nils.juenemann@gmail.com/
Reported-by: Nils Juenemann <nils.juenemann@gmail.com>
Tested-by: Nils Juenemann <nils.juenemann@gmail.com>
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 232e998a8f24..c0676148a36e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -343,6 +343,13 @@ static void resync_handle_work(struct work_struct *work)
 		return;
 	}
 
+	if (unlikely(priv_rx->rxq >= resync->priv->channels.num)) {
+		priv_rx->rq_stats->tls_resync_req_skip++;
+		tls_offload_rx_resync_async_request_cancel(&resync->core);
+		mlx5e_ktls_priv_rx_put(priv_rx);
+		return;
+	}
+
 	c = resync->priv->channels.c[priv_rx->rxq];
 	sq = c->async_icosq;
 
@@ -568,6 +575,10 @@ void mlx5e_ktls_rx_resync(struct net_device *netdev, struct sock *sk,
 	resync->seq = seq;
 
 	priv = netdev_priv(netdev);
+	if (unlikely(priv_rx->rxq >= priv->channels.num)) {
+		priv_rx->rq_stats->tls_resync_req_skip++;
+		return;
+	}
 	c = priv->channels.c[priv_rx->rxq];
 
 	resync_handle_seq_match(priv_rx, c);
-- 
2.25.1

