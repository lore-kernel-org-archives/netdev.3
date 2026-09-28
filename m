Received: from mail-yx2-f6.google.com (mail-yx2-f6.google.com [74.125.224.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A325D17BED0
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570430; cv=none; b=bkq+HKN9s8NCZ0HPLNoUgXkxyOMkV1FCWk+G9FDMeTon3mV5eIa/gmDFDXvOsW1VuIzo9cQxOjYCAH/HrQfNAZEOA7Rqnf4POLaFsBf1q1fkraDJDy7+n4GRt7up8WosLKQE6kd3shTdZCM3uQ4Df0X4wwj4U5AyXb9/tTOK32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570430; c=relaxed/simple;
	bh=ZyJlgK2kDWR3C9TbduJX74lPU1kiQGhl4K9ex08siEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMndb/hIQa+7rCeldh1uWUZsSzFjsNHfo0VqhrHlcVQSSOlcta6QvBg8s+uThhoQQDzjHlve17+Nv7ldFuY3oE/MxyotGwY6emDgY5ja1XQ+iHZ2JU7oi6dRK9QRKusiLsRT1exqzrrWWIfK8bvD4lrdMTfospkXVBHy0vhbdCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W621x2cB; arc=none smtp.client-ip=74.125.224.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W621x2cB"
Received: by mail-yx2-f6.google.com with SMTP id 956f58d0204a3-66e623a0149so1145689d50.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790570427; x=1791175227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KnkJG/BFuPflYXbPqzI6CXrDjqgOy9NIeRkK6DTXM0E=;
        b=W621x2cBXhPUH8QpJ2nm8mhiNztL73PPiZeBhNpsL0UIKbk10KfCJXJWtRwyJztBt9
         QRTI/MDKUQ5b8ea7lNSOzYdk8+hhKGfFrTZiRGhbM5GvJrelZUCilBLel5PGlHX1BLvf
         uuAmgvvd5R8GooIMyOzHc7OBFR2E3845jHRSV0El2I+xmKzQHXdgkgZmXiicVO9vV14U
         PfBiRXNUV6qlp6NtNbBxfpFWV22TdfVZ2N2ipUDy7osg3EA5JBUe3or1duxCr4G1gXQk
         8pv3uTUqdnjOHyhHU+6selfR/fqo31J+L/uQmM3WqmEYfCzNA2AXM65229V2U9ppQJ7S
         TgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790570427; x=1791175227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KnkJG/BFuPflYXbPqzI6CXrDjqgOy9NIeRkK6DTXM0E=;
        b=c8JOc1Ix8sDE4HOhufhB3bgSeQxQl0qqjNyPKLchHzDx9oPOgshVQFLTA2osu8wrP0
         5Z+sFb+ROr0Le9juvJ/MB8bsbo2n/MhKqEVrNYdnFWjoXmnEnSUWNUukseJZQAdhee7V
         Yt30uenYmx4azOgA87ODU0yau0r6uG8iEPIDskV2EXrHO4EKo3CMHeaUQQWnFz2p0eu+
         eO+7SpvJYKwpi76f1v1u7OJafJYD/EJkZzrfssg1GIMmgRXICXTK+1ZtzyiVEnER0uiw
         c7yWkWuboM3NJt3ZqpTYu/QQR9AfUZteEzKmk2JphTcaZJ32KNSiqv4GjIEUaGze9vlI
         +3Hw==
X-Gm-Message-State: AFq9FYLNpHSc+65bLUvX9BSEdvVnJu8NDTXYuReGPpXX1LU0pEjiyANF
	wjWbnYvRFpNVTskh0L8o/WqeOLI7IPUCHSwC8mwaeRPihdpHR0KLIjCj9BHyEgiPEh8kjA==
X-Gm-Gg: AYBFou0KEBhaYdnfc3fj74aFEAt9oU8Jr4+T6y1ElrKrnJVzMGR7kPZmTW9kt79MapS
	bryLegHsLko9RvUpSYsGiwW/DhSVrPfScpovgNBoa1kxP2XmLrL4xCWb9COi0EZOYWF91impWeM
	xzBKyCGmZAmaINueNtt1LRO3w0MW8tPrKArio9+t8edcr2c1qjiSBE9wOJ9QPjKORqovX3BQDQl
	J0eun/tUJDzeWpOI6KJBNCIqJeUeJa1JhZycaU14gGlQDUXb5C34orci4/KLz/qLhKJYU8RM+4u
	gE0bSIEZg+XxguFkki1iCzUhPfD2A3+BX2viNPDk/GbqvQr2mTgA8vob+QY14LTYHzaZNXjLHva
	a8fGjmnOE4JPc0oadlrPmzpCVarKG8PGejwrU+fAVMvP1mX8UV5gFqu8r6VqNKuGqtfV+xeQ0ZU
	E5et13odPuoRdE/uy0G9lYPTYpcZEmN7pgZoZQ2QUj06lFFen5UTp/qhs5VU3QBLpKO7fz41/nx
	loRfdSkdruSX47/PiUL212ce5VfoTEMh9C7pE+vcoCkRQJJCxqj
X-Received: by 2002:a05:690c:6609:b0:8a6:b4f4:7339 with SMTP id 00721157ae682-8a870638d9dmr35527787b3.35.1790570427627;
        Sun, 27 Sep 2026 21:40:27 -0700 (PDT)
Received: from Xinshengs-MBP.attlocal.net ([2600:1702:7d20:7d20:7139:eae7:b25b:5d54])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a85ec40be3sm38503747b3.0.2026.09.27.21.40.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 21:40:26 -0700 (PDT)
From: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: usb: ax88172a: improve MAC address read error handling
Date: Mon, 28 Sep 2026 00:40:11 -0400
Message-ID: <20260928044011.63926-1-xinsheng.zhu.ny@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When retrieving the MAC address, ax88172a_bind() checks the return
value of asix_read_cmd() against ETH_ALEN to detect short reads.
Commit c28d9a285668 ("ax88172a: fix ax88172a_unbind() failures") added
an -EIO assignment to ensure that this failure path returns a negative
error code, even when asix_read_cmd() returns a non-negative short-read
length.

Short-read handling was subsequently added to asix_read_cmd() by commit
920a9fa27e78 ("net: asix: add proper error handling of usb read errors").
The helper now converts short reads to -ENODATA while preserving
negative errors from the underlying USB read operation.

The MAC address short-read check in ax88172a_bind() is therefore
redundant now, and overwriting the return value with -EIO is no longer
necessary to ensure that the failure path returns a negative error code.

Check only for negative return values and remove the -EIO assignment
to preserve the error returned by asix_read_cmd() through the existing
cleanup path.

Signed-off-by: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
---
 drivers/net/usb/ax88172a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index 6b14bce2a552..f5036451f086 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -173,9 +173,8 @@ static int ax88172a_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	/* Get the MAC address */
 	ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, buf, 0);
-	if (ret < ETH_ALEN) {
+	if (ret < 0) {
 		netdev_err(dev->net, "Failed to read MAC address: %d\n", ret);
-		ret = -EIO;
 		goto free;
 	}
 	eth_hw_addr_set(dev->net, buf);

base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
-- 
2.54.0 (Apple Git-157)

