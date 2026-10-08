Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47B45A288
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464504; cv=none; b=ARfd50nToWObdekXv6glY3KBLeQuDL9qwevx+s9J+DdSDrsD1lA5SIV9UD6mn9oT8NTEzZw4phHHtOmuYF1qcvTK7URj+pH/rG0BTKngCweQ/1fxjncLYXkywN/sw+03vVljMQHm+9E59QIIabYzGWkGft7+zIzh6+HEH/lw0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464504; c=relaxed/simple;
	bh=NVSjmbFXspQSlYtadXCDuAQYa+rLjYgTp7TYWtDVFM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yd5UOLi9n1+U4ocZJkGdao2xy8S+IU6+uwXF6tslRQqM6AX9yR0YvWg32H+/CTs4xV9rAAVv7nzu2ueHplWT0dWUjeWBTAt4Y+kLbLRdLB8N529vgJ8v/3vnUjYDkE4QsMNba/zyGFhTaHIvLOZgqdIKF6VH/h6tsv7Bux9kHNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=gap0pq12; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gap0pq12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD5E1F000FF;
	Thu,  8 Oct 2026 13:01:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=gap0pq12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1791464496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yYb6K3rQoktLRqK1NPa5fQ0PKNAlMXppvr+fRepyjk=;
	b=gap0pq12P6cnvFnc2WfxK36d9wzhLdNNrccbmEw9mwqjVDN74s//0BujBYbkxalKaHGkRX
	BA9TVrUb2plMGiGpIFG6VL4eHjR4zfGsJZbx359nCGYOeWOy7YTw5Yea5fepKtjI7tRzr1
	Qbs4zrW3i6F2jnjGetaCk0KG8/iuxZ0=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id ee2cefd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 13:01:36 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net 1/3] wireguard: noise: remove unused variable
Date: Thu,  8 Oct 2026 14:59:14 +0200
Message-ID: <20261008130124.724119-2-Jason@zx2c4.com>
In-Reply-To: <20261008130124.724119-1-Jason@zx2c4.com>
References: <20261008130124.724119-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a harmless artifact from early pre-release wireguard
development. These days, static_private is read from a shared
data structure under a read lock directly, and it doesn't need to be
copied to the stack. So remove the unused variable.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/noise.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireguard/noise.c b/drivers/net/wireguard/noise.c
index 9c0a09bf6c95..63f41836ebd5 100644
--- a/drivers/net/wireguard/noise.c
+++ b/drivers/net/wireguard/noise.c
@@ -736,7 +736,6 @@ wg_noise_handshake_consume_response(struct message_handshake_response *src,
 	u8 chaining_key[NOISE_HASH_LEN];
 	u8 e[NOISE_PUBLIC_KEY_LEN];
 	u8 ephemeral_private[NOISE_PUBLIC_KEY_LEN];
-	u8 static_private[NOISE_PUBLIC_KEY_LEN];
 	u8 preshared_key[NOISE_SYMMETRIC_KEY_LEN];
 
 	down_read(&wg->static_identity.lock);
@@ -807,7 +806,6 @@ wg_noise_handshake_consume_response(struct message_handshake_response *src,
 	memzero_explicit(hash, NOISE_HASH_LEN);
 	memzero_explicit(chaining_key, NOISE_HASH_LEN);
 	memzero_explicit(ephemeral_private, NOISE_PUBLIC_KEY_LEN);
-	memzero_explicit(static_private, NOISE_PUBLIC_KEY_LEN);
 	memzero_explicit(preshared_key, NOISE_SYMMETRIC_KEY_LEN);
 	up_read(&wg->static_identity.lock);
 	return ret_peer;
-- 
2.56.0

