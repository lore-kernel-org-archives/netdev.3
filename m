Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD32AD2E
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785589950; cv=none; b=Y3q4SMiuHCLs8ihqzyJnFPOjJ7Nj29NHLGVH2vdn4a1HKMNsm1EpIAdNoMwvqKxZLCr7jyK8ulJWaxnhquPrdJ5Tz9iip2vTI5M4axRVIcAtCb1JY8SczrPbn3nZaTfYD5c+is66C7xJ6PxcMgcF972D7dJJt6OK1eRs5zCsVj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785589950; c=relaxed/simple;
	bh=4BRY6KoOdauYmPF5fBTUd+XKCYyGAVkzvoBATbQL0XU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J7L19HJTwOn2AD2Ds325ygQZNO7eVlsebH7RRXFr0VfFw7HHmUiE7HZQ01w7bk1D3N4zHMsLmMj5PQwLq/Dh+Rg3OLj+CcuQEs5cmd++pwqi1a1k4AISbIzWYFsSd2rEHdlY3NPCWApgddN4wWav4ckfRGmnPzvmRV/bawYYYIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DEtuSg+7; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEtuSg+7"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccd1958e8fso26897015ad.2
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 06:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785589949; x=1786194749; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/aWkN/OGOT7T4dSY4UAyK4hHRJ4peAhz+fEX2PJq0JI=;
        b=DEtuSg+7Yy9U/Yf6ua9v2LOlfvtaT+UVQcQvlhGEtSkH9ZZjdV6JyJtFLWgPH7TW06
         +UDmjyGFsRgZcp5yenqpnnEb0zMCyLJXXpO0NKOnzGlXeFGB+DiN6/3IVClcPaipHo0D
         EzcK31Yt8ypdVe+BBt3I2cxerqeaRC8WENYqZYvhqfjdHltJQrC2yyVoc6Qx1AJyYw3a
         6cy3HscwQoRNbU7ItHu4XCf5geQTADSKs1ZcbGifCPZ/9H/LTW7hLcZ89uyQ3L86bTP+
         FpHZgZlbtF9a4NjP3n0D6X4utp/6uOa0wF5Yn3BVXrHLlngpl7Z30d90r+EhmjKnY+9P
         NVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785589949; x=1786194749;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/aWkN/OGOT7T4dSY4UAyK4hHRJ4peAhz+fEX2PJq0JI=;
        b=cwrXH/ubgzZXe1EHGFJYlwtWXb2eQru4egp8/hBmi8eFmJwanGgkkV3A0C+K+2f5Vw
         AdHLYluq0+jdHVN1q10S1fntCosazou2Wi+el80HOUhmsdDKZCsLUtCuhHToQGvJVtqR
         Ry4289pqME1G5SHJjdPK/+Uuw3zMHCscerhPx2MzLL0mTWKOxp7cJoGjMCBN9kCQwn2r
         6JstcT0iYvySweTRONz7iLfhN8HWBYcP7sNw1ERrSImtyB93KGJVyqkO/hx/uRezh1Rt
         b2RHEcGb6WlXmnEx3kdvXXPlUHTvZxPmx2hf8qel9h3TB9REUdjOFjW4VxnZ6aQBQrwK
         QGVA==
X-Gm-Message-State: AOJu0YwS4nVhFqBMoOBlNGT1Xd3QUgvjNKt2AZhL9akL77SyqFks3p9W
	GQQEKQD1vWAcRzMfBLtr4mDtY2zLxuHlPAY3lzELQGj7vO90ySI9JugGEPjV8rhQ0ScOFBhGrS5
	ebdtuhZnyGov6sFpTFZt/2F67G8xilbWSeOEO7mCqEDv3v46d0xCsRV7ZA7Ue6K1QXZi/pAyMKG
	oeM7EbGo5Cu/deRdCODYG5XotMzKrzzjXfQ/eQggmanajh2y7FIYgqyOPjUB/w9sA=
X-Received: from dyz9.prod.google.com ([2002:a05:693c:4089:b0:313:cf0a:f653])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef01:b0:2c9:c517:d078 with SMTP id d9443c01a7336-2d0523f6110mr34076635ad.36.1785589948421;
 Sat, 01 Aug 2026 06:12:28 -0700 (PDT)
Date: Sat,  1 Aug 2026 13:11:53 +0000
In-Reply-To: <20260801131220.1367229-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260801131220.1367229-1-almasrymina@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260801131220.1367229-2-almasrymina@google.com>
Subject: [PATCH net-next v1 2/2] selftests: drv-net: ncdevmem: gracefully
 retry bind()
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	"T.J. Mercier" <tjmercier@google.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

In testing environments, binding to the port can transiently fail
following a driver reset caused by the preceding queue configuration.
The failing bind() is typically caused by DHCP/IPv6 DAD needing some
time to resolve and assign the IP address back to the interface after
the reset. Retry bind() multiple times before fully failing the test
to improve robustness.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index ffe1d5c1fa4e1..6724f81e389fa 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -898,7 +898,12 @@ static int do_server(struct memory_buffer *mem)
 	fprintf(stderr, "binding to address %s:%d\n", server_ip,
 		ntohs(server_sin.sin6_port));
 
-	ret = bind(socket_fd, &server_sin, sizeof(server_sin));
+	int retries = 10;
+	while (retries--) {
+		ret = bind(socket_fd, &server_sin, sizeof(server_sin));
+		if (!ret) break;
+		sleep(1);
+	}
 	if (ret) {
 		pr_err("Failed to bind");
 		goto err_close_socket;
-- 
2.55.0.571.g244d577d93-goog

