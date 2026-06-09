Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1E4363087
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029948; cv=none; b=MM3m3GlE0ygA9d+LjU9ThZVwHT30X7PKgbIPBpLl8M73ITn9BcpHd0oBwbPquI+L2hbcgnnQl8ElZUFYJLN+/fRKqMEArj2TWA7Yl2j/JF5+NBEgLjF6r5OBfxpFsGcvJU0Nimc88gkBy8lMMAIjYDn/W1/AQqrdZReOpZJeVh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029948; c=relaxed/simple;
	bh=U1EklQm+nU1nLZqPXGdeCT5+o51yPHfWzGvDPtxNQEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohChkbP7HA8pczm4EZbY/yrLLoCHHpYHSlyne7p+TxqCulhCm1OkoPZa5/dIuJxhO/+SK7ZHu6nA1E3eXccdkpZSELZCS6Zt7wXh0loGAYx2xGm4Zok+CHGH99IcDPHLNo4oeJneJGpL8BC0zCeTJHq+cE5HGEUqVTFIGR1aWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsjYvhUu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsjYvhUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192F01F00899;
	Tue,  9 Jun 2026 18:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781029947;
	bh=sUEK4Aq097camM+Oo827VJQjdV0/OyLi5lR6dPIRNNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LsjYvhUunoUB9xB02LjhLOHqtvP2tM4dqBfVkWR4dnxp3xb1GuOBWqHnz0npqPpbe
	 OLx49vP/ntHlE+a6Dvm5PaHAGUjkjMED88l4S7k6uXztfo29k6ud0Ig6T8F33BHY6f
	 Nkb/5azkeM8DfZCA//B1i4KZ3M38L+Swqs9YeHye/vhn5m7WivuumMwhWbKM1rxAVh
	 Yhy1OyRQA0RRsIZhSH/fdKJ23bgdNpDNZ7K2NJeAnY9CfAhN+nJq/S1bEvbPhCfYXj
	 oHMPJ4BCan86quVbj3LPeVBKgScszau7m1C/ntse0sx8J8GJ89hLYH960Tf369FWXm
	 fgYfrcHAleybw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/4] net: shaper: add a comment why we don't need kfree_rcu() in flush
Date: Tue,  9 Jun 2026 11:32:23 -0700
Message-ID: <20260609183224.1108521-4-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609183224.1108521-1-kuba@kernel.org>
References: <20260609183224.1108521-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We keep getting misguided patches to fix the flush.
Add a comment.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/shaper/shaper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 33958462e5e9..5a3b44c5d10f 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -1470,6 +1470,10 @@ static void net_shaper_flush(struct net_shaper_binding *binding)
 
 	xa_for_each(&hierarchy->shapers, index, cur) {
 		xa_erase(&hierarchy->shapers, index);
+		/* No need to use kfree_rcu(), netdev is already unpublished,
+		 * and synchronize_rcu() has been run as part of
+		 * unregister_netdevice().
+		 */
 		kfree(cur);
 	}
 
-- 
2.54.0

