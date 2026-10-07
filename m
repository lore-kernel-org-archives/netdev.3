Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F50D33F38A
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379842; cv=none; b=bQc5Gi7f0Y6V0SJBlUZEKcRjPQ+Ift6IC9dAKQq2ksvJfP4dtL+5UynjyedYQUeWPUoXlgiSa2sN2FppjdOkNYS6EqFPP1KVSR4W6M338qf+zx9HAmNOj8aBvJEHC8svuQN2ImijWcgc2wJnTb4Cv0RxGVw2P53O4z6ymfqDy3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379842; c=relaxed/simple;
	bh=RyTbIUwgIhratEqKyhdKRhnC/iuNyNVHTYlEaVCfjmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2mbsmHBRZhLLTEQ7xODNOT1o/QCJi/f9sFQDgmPomYPCk7lLdPQZIQ32NBu98m3NILu12hnVmq+a/GpJ9uyfuHM2xtcMlwKWdr+ggQmZ7F6bDssGdlNlaot0r+Tk9BAsxs0gSaqmmb8NCyl+d6RevuNtbkky3195I76MilZSTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CrM6aph7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CrM6aph7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a17f65ab8bso5012915e9.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791379824; x=1791984624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THpU7LPSOWoLjDoSzyFgxj2q2gwE7Im0Q8dYZLH2ceg=;
        b=CrM6aph7nE3/fSSLuKGNeFAr1Q1SOdH7sNwZyXYQnqgjvqHO0c6H888eMbOKZ4IuWr
         POrz7nRQosM5aghS7+c6iajgP3gkxZ7Ytj/K5S9oJXQkC86p9IIqdqYfOI94qHpRoGLC
         51ihAq/94eVKdmPVh7wuzxL2wvqTlnfFYNOkA7jZ97DWcDdF75ctPP9saSNeSeASdZuF
         RATgdtw/RROitevqGH/RnKEw9ateoGgHsx2Bsm0bGEWiRUuXJt+rTVEXSF0XMTcKmK15
         AbqsY9cFRRS3LSJH+bQ1USJChzkKHqeZ+9OsOwAlWjjiNlY7i2j496m/2kuwz58OrhWN
         F39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791379824; x=1791984624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=THpU7LPSOWoLjDoSzyFgxj2q2gwE7Im0Q8dYZLH2ceg=;
        b=VW17cxuMpXZDe6KpgUI6hAe2aaew1NZ3fsC0AyLRUjX+awqxdrMo+fSnGqoXVaQym8
         +2lCDW0vW2Qu6sjERtUMEvdPWmSlnHcP1IiRSGw9JyT7Wic5lWXsVWk6n7imPJsUc0WV
         UyOz4bliaFAsrnA+NhbPJY7aaC/z4gA/AZgAKgsvaxLO25Yquki+f8uoLIZweWZ8irZ7
         YlhFR1W7c/7lOwPw9TCEF3+RU+wUO98/2JkN2Wk3HOhRZ2ysBSmh/ej5shm2RH/qaWVC
         dN/Osd2hXZHvjqQozakN1810FIF77P8/M58SpEpX/+cM73QCNHrHuQ5MfE0ram2NAXXv
         rrtA==
X-Gm-Message-State: AFuF++l6Xi8Eqii9ERt3CehVZdQDQTOLSLfq0pRylxvqoHWQu5yFXuqv
	5eaIW/XyodZ7YJmzdqTQ2/KnGZ/duqiEcMuHZbICFWbVreI6z8ryzbBD6jQ3kQyV4gPmkKGg8Xk
	xG3VWfM4rFm9di3YTTr3sBesQFm2b3I93OAv9Lat6w3+9e5znNYzifrNyA0mSXHw0
X-Gm-Gg: AYBFou0rFBSha6Ry/9S7oAZI4nAwxPg3LDqCUvNXOYVtUdsoalej2FHen3LIi9UG4Bd
	NmaIwXu43l+UGnKA1jTqYdzEVm+MS//d28ayLMVQj8Zej9CIY0MqnEKQBH7zfBzykto59rpCTW6
	tJfUDol9NdtIMw0u23+Ir0Ej6t85eGHrkgqvv1tefsczREdMqeWuIIlTko5cmHkkLPFMTzEX0ju
	5eI4mmYQrXVg3zDJ+9kqQEY/k1ztpvIYI966AX5EziyOM9Wscf+Z8tD+EahwG7h0OndzWAmsSs8
	QCx0fYQWd6KXsOjp3QR+KNKr06NKesOuLACY5eEaxgEz0d2SgQbLSUO3YDmaGKMoYsn3hHoRBWq
	jLZNt4Vlhwnl7KFJ7oOTms1SdhOa6jR5JlcLHX75GSWui4y8x8gqY6VmQJYXH4ZLxjnK5FTHUNl
	8YFYFrAK/br7VuRi4994QejmUYaPzwJOgIRoXsQ6Zxvt4NbR5FE8TH7BCXVVfRyqrwGIKs3/kUR
	ZPuNTio5Vh8vqMNKSOzrQ==
X-Received: by 2002:a05:600c:821a:b0:4a1:777b:8a12 with SMTP id 5b1f17b1804b1-4a1803112f1mr38914755e9.14.1791379824101;
        Wed, 07 Oct 2026 06:30:24 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:7fc5:5cc8:bac1:5ef3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17a0fc2e4sm150356145e9.3.2026.10.07.06.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:30:23 -0700 (PDT)
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
Subject: [PATCH net-next 1/7] ovpn: Fix the return value in ovpn_bind_from_sockaddr() kernel-doc
Date: Wed,  7 Oct 2026 15:30:10 +0200
Message-ID: <20261007133018.1451958-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007133018.1451958-1-antonio@openvpn.net>
References: <20261007133018.1451958-1-antonio@openvpn.net>
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

