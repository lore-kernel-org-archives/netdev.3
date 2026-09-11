Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F33F44D7
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 23:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168516; cv=none; b=B2d90jGQcZRn/lFmqn/UcKgRhK+/jt3JF3EBmua8Dfc15Jx5/xzSlIa6++xxBTu1jQn7DAxzZQryCpVcOplPG9ztCqVkuXfraAWJkqwM50ouYMEBaSyMTKk81Ko/Z2kYBAwoRLIJts7dpHxUimyrqS6lkT/QXkoBVxQBH8bVfa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168516; c=relaxed/simple;
	bh=gOjvvX82AUYe7RXXt/0k2kXy8hscDaCjw8dbHhtTwhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nexYSAbcoLV90mlP1ZMzvpzkVAtjmYRVAsAEREVGgefGso6I6APvN2l5hGRL6UBvPOAsFac6FtVZzRR3Y4VguVB5OV7667h/QMR2e0igKEpMd7wgG0S7q9muxcAf4qQVxua7FejTtgLPzBnN1SRv/8mhypgYQC0EbTbq50RU2mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RngWluNg; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RngWluNg"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so2379475e9.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 16:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789168513; x=1789773313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b2mWYsIChjfxQsD+xpNWBWCUshmCpIYMChyiD6YqWGA=;
        b=RngWluNgpD13XAk7pl1fwT8Z7AJvo/4gZPv4DhiQLuwbuaV9c1KRcMUaDN5XGUO9km
         bi+s7s64SGJBiQGo+kyPnVva88soskgrmZUTGVIO2YYlTZZg6zqQT42f0LVm1JKys7dt
         MPZl5V92B7G7HA+DvjpILm8/yeBtWeLUuphO2VnZGlaqKj8eSw3GnQ43mqNZSi1PfEJZ
         d1Uy51JPOBYwrNa7OoiF3eU+iI4s19QpnmmIsaI2EXWQd8LvwbznPvrFeQRMdDxJVC9K
         ufvIfRqgZxWe3vdm7S2ycRjo192xFiVpu+LAXb7d0W2pk3RjHnRkHxitMz1nkERSw86E
         Sy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789168513; x=1789773313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b2mWYsIChjfxQsD+xpNWBWCUshmCpIYMChyiD6YqWGA=;
        b=WPqZbORwIe/pPBzn+dQ+DUXY4dCCPlo/7No1u1PYvvLxXVS0gLJiFjJWZWynFagKu5
         MAiA9hqYBxnDNQrzKxVsEALzOCOjClF3Jzhqr3W0ZmT+vcMxTtwjDctIUiOtJTjBxquR
         Y0IsJ7ux1d/3iU641vMRGSGzVMS5h1yGWDH+33GqSLHZhu60SQQSdhhgG4dOhsBpVfFm
         kYwhKQiL7Ot6TwzhLgfw/rV3ob46/P55TZo+qGxR6GYrOtzVHCc7km1vNZT/m1AXTBQK
         7lwNaG2QIcrHfwtOlY2jK4MgL44NqV/2vOilGG6FoPrF7TMQ5vJTh21wz58cZ3J4qaFw
         p84Q==
X-Forwarded-Encrypted: i=1; AKwUvByLoS+HCUdYbK/LFtMgwpF0DuB3Pq6JcGTwyDEwR3VQUGpu9pThF2ppDnwITytFf1/dvx0EBiA=@vger.kernel.org
X-Gm-Message-State: AFuF++m9MbIYKzMcjf9wOJ7JdabJwHVm6Tja9j4BZLaTbaG+HuONUclT
	2G3Jl+EHc2RI4fWWDq5dJ9Sie1eggJcXoj3I2tV/NJkceCTyJTRWcGSY
X-Gm-Gg: AYBFou0Z5+1zsHOGDOytT2cKTjIvY2ivUdFj0lMvOYB5k8zitY3hCCZWdD4s18Odj93
	HcRdQszMxvwDDax5ol6ddpT3E14zl1AEZHJ3jv4ORg/6d2KuqCx+hyctxpJPZv0S80G9HehgVTj
	q2In7P1KKQCX91+H5189gGSqq0xy1cCNu2YeLtcpenXekKnM064QuR/X4Q55K9zZeFgZ9acgM0Q
	iw5711uuEtj2wUIwmFQTaNX+7er5ivOEQZ6GTOnE771kq3fezPPEbGEfZDcW0hdskQcQ953QctF
	q2XKzskivlJFcAcPv4lXdYtrxNVtl38iS41mbDfdHEfCvc/qbS6IB8v30LvUgrJRvZtwuHzO3fq
	c0zM8oBikPmED4Y9JHmOqamezk+RkQMmoL4iBUuFE6XDT9p7p0p4Q/Gq4UWUYpvovQajg9qPXo9
	WN3yveXLum+hPVhmCMnrTWQqgCE/QOszz6Gl1BBC9I180m+MiH4/hJWqZ1da9bK0sqLVHDEsnt7
	3rL9cMf7obQvlkkvPTcTFLIS+2eMebrpj/DGAL2Y8TOW1uCHmXqQyyxwJ56iwvej2+FqJ+7Y3LG
	jNzurV0YjN+Wew7h1urOVQTX4BTWo+Isnk3Waw==
X-Received: by 2002:a05:600c:4e0c:b0:49c:ed94:cdd8 with SMTP id 5b1f17b1804b1-49e6198734emr184554905e9.6.1789168512866;
        Fri, 11 Sep 2026 16:15:12 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c39086sm171124655e9.10.2026.09.11.16.15.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 16:15:11 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Antonio Quartulli <antonio@openvpn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] ovpn: Fix the return value in ovpn_bind_from_sockaddr() kernel-doc
Date: Sat, 12 Sep 2026 01:13:52 +0200
Message-Id: <20260911231352.12706-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovpn_bind_from_sockaddr() returns an ERR_PTR() on failure, never NULL,
but its kernel-doc says "NULL otherwise". Say ERR_PTR().

The wrong text came in with commit 80747caef33d ("ovpn: introduce the
ovpn_peer object").

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/net/ovpn/bind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
index e42b60cd04a9852c80a0cc478d499821836ab909..62a5ccfd3502a2680b45b0732804eafd47d79a2c 100644
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
2.39.5 (Apple Git-154)

