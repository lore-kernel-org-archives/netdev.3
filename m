Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AAD3812DE
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853800; cv=none; b=DACEPB77iGqhTw7W8O3lsVS37MzjHozAC/syqXtBBpLCR+dnTvDJNLBnsiRA2hwy7j6sOfkkUCPu6hm32EOkr74mJZwSN7zWdNSp+KAE1XV8WhN4Svfyl42IzrfsnqUvU1s8cG+ppOj3ET8YcWuStheMqZHuz9UmlPdFV56Mrr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853800; c=relaxed/simple;
	bh=6bizVIdgIj1fNJLVf+eOfVtpiCc+m0cvPAZP03MoOZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGVgcorhrep3EM6rPBB2Z5XCdIJcBOU3NEhrAtwETwqPSauUcMWvY9zmHK5vvPUzWJyLL47hC6HXuCjkcPaJ98TCQbrKv96EzOfI9cj+4NY/VtAg220Bzf4FSiz2XgT3u6StP7Wru2ZKXkDl8wyA0USEKv7sTYXWvD9pPKSKrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fqm5eufv; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqm5eufv"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so1711838a91.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853794; x=1790458594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YDLB5spO9G86KxxkAWQZpWYmhLuhLdNenkp/2zmUocU=;
        b=Fqm5eufviFjPOlyEF+t4FkaNGnoLfTtaMaEuK1miUGPdubQElGchhbM1f/ux4FtXnc
         UH7Uh8Ea8pue9b6AhYMuHQni3rpcKoS9bwD4stA6WlTYZveD7oMQaZnK24FpcJIvlPdw
         rUtXnKLm5WgtxFGxCn4aXPPq20djI2dzjp9som1j8qD0NmzW8K7PUfnxlXpC19DtfWf4
         2vDcloNjWUnmJ4oVKatKPFBrjT7y3x6VbHCE+rWN/TONPgh0B1a3SiNwpWFTVvojJ2cf
         KdsdJwwUP6zG1RMQ9n7nBqpvjmPE15PJa4nuDuCpHkgmBt1sQ93rsw0R9N5Kqgtekj3O
         4gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853794; x=1790458594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YDLB5spO9G86KxxkAWQZpWYmhLuhLdNenkp/2zmUocU=;
        b=JzUIa4DLqGFc1/ZzTH7f9nxPnm5Uu4rpEx3DHZ8jTA3UK+YkqNE1eUFs7o1WWCNGBu
         X2KWzIBTsrYq46v1DJaY35XdwPXIVS8KdUhzY8Kj5BV3QRgcZNoSp3FkYWK/+mK6I2Q2
         xKVmwi2nkDwdWiLm/UyxzagSGOIlpQ++Mx9wMD2+OSb+bkfky51A+c2cfHZEQd5BLnAv
         lKf7MF8XROItRj4Vynr+HG0CFUJ4hCP6ynPynND3E/UP9EN4kRSx/E9IRQIxS8ko8NdZ
         OmbbBYAyZwBmOKbu9dfoNxoheXwMGmc7P7Ulbe4idoc075BepHACZmkZsyKnTKIjk5Sc
         MHoA==
X-Forwarded-Encrypted: i=1; AKwUvBxcotkFdCSCjuBvOwDujqrkmiwhtOIc1XLHAjELvNzXUikVH5aOiP1s9JJYk0eDIh+tnAP7H4k=@vger.kernel.org
X-Gm-Message-State: AFuF++mvGZznPmrZdYyKpfXCJ4loEs/9DUR0VNNgtkkL6j0XmoA6OhEw
	HdohsLVwHtpyAXZQBkeO00gjw0gw1uPgxXgfEQ1oYUCHw0BjAZnw+gXH
X-Gm-Gg: AYBFou3d5zsBT2hy0lfxWDAM9CyvnhSJL5fZNh2OvLoJTfq1R1Oa/cWjd7ao6wvkcE0
	IYjJjzFGCtmi3atRpTnYb9GdXIKdHTMqO6HmaTtXU0NdSOof57XQsNrQtQECT3rjoThXtmzuUno
	XOqMVaL1gKlQNVhmpIbc2dXq/Um1H4yBdWut/d80VlWwzq4pEKd/tRYOjc9HXAPo6eM88bfFQTC
	urBKQz3lyY1t3YZB2kRU52AB0Ffk7IQhNcGKEkkIHoYtowPt+fbEJUvwy95ayFgGsnkJkrmEyCg
	fObgr4SzR3epropgEJDdBhQN4XnW3upW99Q4TQtJs1xZJJKCQhAYFJZwGz6+pBHddwWOPGKjqUC
	fpDj10GIfJhzBRprY3c14/9egpx//pgMvT8zjSNtJJ3gM/PB3M5OWbyarCeLz6aQTFI8rFD+ySC
	PPBVC4VVtNJLk2P2QxdNoZGO0dAEQtsYTHU4lNrnMzRF/fxsEMWYkzvKlo3s+m1M1z7Fa2G77GR
	XoTUJImulibQ6FFOy7XUe8Y8yzwgYlBxRkPH8BpZHN1LNNTuBiAPPSnY71oFhv+fpjKU2rb7P8g
	jaDozUqbHw==
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:4b6d with SMTP id 98e67ed59e1d1-39e6c6a550dmr4317444a91.55.1789853793981;
        Sat, 19 Sep 2026 14:36:33 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ed362c71csm2147955a91.2.2026.09.19.14.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:36:33 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: robin@protonic.nl,
	o.rempel@pengutronix.de,
	mkl@pengutronix.de,
	mailhol@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kernel@pengutronix.de,
	socketcan@hartkopp.net,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: j1939: return 0 instead of user value in j1939_sk_setsockopt_flag()
Date: Sat, 19 Sep 2026 21:36:32 +0000
Message-ID: <20260919213632.3313825-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In `j1939_sk_setsockopt_flag()`, after copying the integer option value
`tmp` from userspace and updating `jsk->state`, the function returns
`tmp` instead of `0`.

If a caller passes a negative integer (e.g., `-1`) to enable
`SO_J1939_BROADCAST` or `SO_J1939_PROMISC`, `if (tmp)` sets `jsk->state
|= flag` and then returns the negative value as an error code from
`setsockopt()`. If a caller passes a positive non-zero integer (e.g.,
`1`), `setsockopt()` violates POSIX by returning `1` instead of `0`.

Return `0` on success in `j1939_sk_setsockopt_flag()`.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/can/j1939/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 50a598ef5fd4..1d4af472de4a 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -688,7 +688,7 @@ static int j1939_sk_setsockopt_flag(struct j1939_sock *jsk, sockptr_t optval,
 	else
 		jsk->state &= ~flag;
 	release_sock(&jsk->sk);
-	return tmp;
+	return 0;
 }
 
 static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
-- 
2.55.0.1082.g2b9226bbc0-goog

