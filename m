Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845A64A1E15
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057341; cv=none; b=d2K1gnfs1wnHJFC7AoLifp0wrOnHauRSXY8J+rao6QoF6xVfYGqToqM6X83nXYb6FoaGzGo3qrainU4OD8/yoAoYm6vtGm7L8DPUSMSmhquF0sC1+QhwzCFlpyHnoq47rZ/WezVT6beVQa4rCIBS0tgYLmHNNt3rjzI8F4zDnRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057341; c=relaxed/simple;
	bh=RyTbIUwgIhratEqKyhdKRhnC/iuNyNVHTYlEaVCfjmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+dUUtKC/EfryTCBs7xPjPHkxjNx7awv8ATOogrUE2C3hAqULVIc++fQb4E6/Kai1qZuLGIk6iYaxn46qVJ/8w4V84S17kRej6wPbm9/xPaPSA1MiwcEzQ1ZYwz1lqtfi04eHg00JpaMnZhh8bglnkieFmt3n59rJ8zWT02or+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TKyvT0EJ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TKyvT0EJ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso26061945e9.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 23:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1790057338; x=1790662138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THpU7LPSOWoLjDoSzyFgxj2q2gwE7Im0Q8dYZLH2ceg=;
        b=TKyvT0EJFoPrV0LPq5gPEuKan5CJO76ctFMBjZZ6u/SgzwrOR/TlaziZwwCoIYeyOW
         Pr7qrdSQtEN70LRxs8mOFjKzLT2SBQ4BxgPxIcQWOvtvdeC1VVWLJQWHIl03tzlN6Ijp
         brybGZwQ/uczKA0d9s189qfhq7h1pKLD6fHCFb3IsXgosK/BlZjaDNqzfcPA56YULyDm
         6QKqkOpBKIHOyMXpUUYirdkDTsGTlW3uyrnFxACR9DlbiuDr9jkD6qiLgHcMhwNsa0Ds
         Ujja4dIRFqg2dLnPjIr3ZvJN0VFcdq/BOYFIbt2AU1GBQ9ztInukbNzFYYO1Bdu3yDk6
         sl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790057338; x=1790662138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=THpU7LPSOWoLjDoSzyFgxj2q2gwE7Im0Q8dYZLH2ceg=;
        b=I5xzojNzyhzoGjF7yrooRVBYlutobvjgWHVdq0zfTAOoDZaWrV8BfkRDfvNAKcMGlJ
         HPuGgAHCtFhpWEKBd0gg159bSXH1OgK/gBvgVOk/grprA8q11uxPfLvrZbNWXfuJQgEm
         wVWZuLXkTV1z8ji1cESqVqYVG8LcDwlBZXa777jI5JX+TI4mNJwbKUy1nznZe098IY5h
         vjqeotGY/9ZpqB6yGXoWTJuK4vfQaqNEa1nyxt5ab+a3bNh2gYUFlTKYarYphTXYtKbP
         FtIL8cU6QhzPqJKcS1gvffwKADs6Eh5EKvp7eWQuWNDOhMiGIGJ5yHQlhK/JgWMFgOkn
         deJA==
X-Gm-Message-State: AFuF++kEfSlNDWcmSuyzidZTrreC2chrvTvOQ6UKkV5pKneVLZVcVfTG
	deRkcHVmnxLagmPckwBK6a03TWgXcd7EVawaBAXX/0BclZkHfUh39QY3Tj5J6fyBrRxaoeu9m42
	vM6Zw8gNfou8R27x+csJJXigVjRj2AKGBWVt/l5TdFryb1MaJhRu89IDdIQz4I39szr8=
X-Gm-Gg: AYBFou0Vrtv1CAtOoZAYv27G+p77/SbIMuaKysvLGuSf/FOnRS1OshX/0FAeVs/N/aI
	9RcLAjHjawLNPoUp4oQwh1nWemU9N7GVy8kQiVOjEc5K2RJW0Fm5B3uZu//Jy1BSfmrMmhMS+U7
	1L0foKcSXAyvq3u2InBEeGtBIBtdM3a72S6c4rWI3meyjQWPOnc5X3/vZe9LTSBXc+Gm5Zjolkc
	400lp6RwC8l1JIr9uNIY5WXtZyD0JMCtWChZhTSAE2luDKcinRZSy9SO4NCP/+93B1nJ1iqqsSn
	1CD9I0kvwGJKF0/NvHYwnzslaChK/dDSoqt8i11uKSlCaxbGOfT7P0DnmZDt4N2rCHqca1vUjpU
	AjtH34b8gqXe7vIZBpRMkEXo3DE7eDA4MxZ+b0a8rcRd34ALP3ARQe1j80jNc4Nl6mCDQESoJrF
	r6G55NpRk5ZLdmVkklidr6x0tEf7YmPiEOdSxfswziW0r63grQ1GWHlGn3CXaoLg22k/Iu+10EM
	wd1VBVxvHI=
X-Received: by 2002:a05:600c:3b8c:b0:49f:bd3c:bc16 with SMTP id 5b1f17b1804b1-49fc572f58fmr232708965e9.17.1790057337833;
        Mon, 21 Sep 2026 23:08:57 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdad6306esm25814125e9.15.2026.09.21.23.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 23:08:56 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 1/5] ovpn: Fix the return value in ovpn_bind_from_sockaddr() kernel-doc
Date: Tue, 22 Sep 2026 08:08:47 +0200
Message-ID: <20260922060852.2266148-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922060852.2266148-1-antonio@openvpn.net>
References: <20260922060852.2266148-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karl Mehltretter <kmehltretter@gmail.com>

ovpn_bind_from_sockaddr() returns an ERR_PTR() on failure, never NULL,
but its kernel-doc says "NULL otherwise". Say ERR_PTR().

The wrong text came in with commit 80747caef33d ("ovpn: introduce the
ovpn_peer object").

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/bind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
index e42b60cd04a9..62a5ccfd3502 100644
--- a/drivers/net/ovpn/bind.c
+++ b/drivers/net/ovpn/bind.c
@@ -18,7 +18,7 @@
  * ovpn_bind_from_sockaddr - retrieve binding matching sockaddr
  * @ss: the sockaddr to match
  *
- * Return: the bind matching the passed sockaddr if found, NULL otherwise
+ * Return: the new bind for the passed sockaddr, an ERR_PTR() on failure
  */
 struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *ss)
 {
-- 
2.55.0

