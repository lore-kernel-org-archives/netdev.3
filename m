Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A835226A1
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691873; cv=none; b=uZvwU2uwXsFeUzKt0k23rLG/0n6BJCBjojIW4rvONn+W7etEI1vqSjKS7WyJmY/oifMy+/Wk84OetzYhvGU3v7bc3S9TtJiwz1iMQ8PTsxVWJd6lYOyHsl767b6rlqwr38Ifdjk/zET0RyKjw1R8HEmTusP2WSuOPxzCvNMn2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691873; c=relaxed/simple;
	bh=FF5+ULRw4hO54xck9KwGDwRdr7GuxwcSVd/mkPyqdPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LuKGbEoRph4j6E444Wy/BGCIipQ7WjHXl6WgJvtfX7yJflUH/1UgsaLNTcRJG7wHzI4CNhvq1fH98TzbSDekHyCpLxMxxVO5jct0D+2R9yLp5oJZEyogy8WJF5lVjO2qfIbP9yfkYruy+TUhChLmwGRKatUSzSWDs+8NXVh///E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ruOvqu3w; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruOvqu3w"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so19555345ad.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790691868; x=1791296668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kE1PErOwA5bxVXYFyrSKZUxCQRKAPU34Zm0v54vSkyo=;
        b=ruOvqu3w5IR9syS7ZYisvJwUi6aZqPrXWfh/3ASr1C3v8jVt6d4nnGVbThuIyYV1Bi
         MZi7bOaXKwgxzq2oGNBWL+j/9S3LF57aQyygUO+pUA5sXCrTq/HaLEtg4VrF44Z8fHRN
         vyF9iXcdncrjjnjwWcTVVe4a3xyCJYgTw1ylRo7FQEIqX3tOzsuTilHVdCMyODuVe1ms
         GYFkfD/9mp6B+EK8CzFbulG4ivdtZkEJ5hSwxoBeayhWMjQlb8yvbP5CQXw3W24WP9tX
         SfCw+Bb59phTzgeHF2KRdS720EMfcOhRAuv/WznvGKDm1LINIxsPGBiJGw2BzhB55X6D
         18Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790691868; x=1791296668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kE1PErOwA5bxVXYFyrSKZUxCQRKAPU34Zm0v54vSkyo=;
        b=bYHkXklMwraVz3a0IBwSgLJYJRcqbRgxI8KOiD+StUlLJMZjAtm79rF57mt1Zwi6zo
         SU2Z0BHzMHvRFaFT3xr6JGgHb27xzO75BrU+UupD6Fijy0pSRKBtC0SLziCDErklNeva
         ArUy1Z61KveY6yY3M7A/GzFxJiJjhxtnolrTKYK1gSKcMr0xRyH7QMsjyYXxG7bcqKs4
         rJoZePrgElpRDZPxjuM4vbRD0RTinQLxn4M9dVSdhISdlGzR+l/MAibhm7587y81ll9q
         U5bGLOTnN0zMk12ehNqX1XayDhfLrwDCNLesbKUHQkBo+lE/NvLOOtoVKDPXLtuml3iF
         0Qtw==
X-Gm-Message-State: AFq9FYKGT1IwE2bmXWIm63Q3ptoi1hEzurhC//cqmL8s1XX5qWpqmpqZ
	t7hiqhP8KhfBetkpIKvfFeowCLCl36ArJpyMoeAHK8MDgTgs3j7VkrIA
X-Gm-Gg: AYBFou11rS6+7q4+lL+T230OdOpf2iEGjGXyBCWyCjtpwQBlKzPndHwOI+UyZazXO0D
	WX0dD7gyAKBnesGz1DYKeUUsflVJ3btbyaKyM4++4kPli/XcKtTKTCi0FrxHbcPn4OM0Tueu2ZV
	lA5hiMTVsY3iCfIPUQoCqHAHb3bH71UB8NjvppaISJK0pd1KMO7LsAX2VejIHmUWJO29T09LvOZ
	e5+iW/dmztZTzTRz9QLlpe4nA7S91ygT5ZCeatqyaAZiR8otsLPyUL15yd8mWoBw4XT+Cg5S9yu
	2rdYJKwiP5cxwFD3hcX3M/dM83u3RZvN5KU10FarHYg/lZYPeunKT0n0oiR2K3dr0ZFJjNnghGH
	AxMn0PNYU0NWXkt3x8H8NNZl4Robt36K4YRfEhu2BXxGgp2SfrDi1BhO7qajJSleVAlhxNi3ZjM
	tRdUN0nLBBwM60JeFybNTBfsQ1YfN7I7G6/4eVUR0M3oqh8CgVtqVe93kRy/KGkZ0aD0ICdTUd+
	PNjAH6gosSBBy+N0h163g==
X-Received: by 2002:a17:90b:35c4:b0:3a2:b16d:928b with SMTP id 98e67ed59e1d1-3a2b16da167mr5814264a91.46.1790691868252;
        Tue, 29 Sep 2026 07:24:28 -0700 (PDT)
Received: from umang-Inspiron-3501 ([2401:4900:1f3b:8187:c8eb:84b1:3b4e:3624])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4b71ceea2sm439666a91.1.2026.09.29.07.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:24:27 -0700 (PDT)
From: Umang Pokhriyal <umangpokhriyall@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] tap: report IFF_DETACH_QUEUE in TUNGETIFF
Date: Tue, 29 Sep 2026 19:52:38 +0530
Message-ID: <20260929142238.41742-1-umangpokhriyall@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tun sets IFF_DETACH_QUEUE in the flags returned by TUNGETIFF when the
queue is detached, since commit 3d407a80b62f ("tun: Report whether the
queue is attached or not"). tap_ioctl() returns only q->flags, so a
detached macvtap or ipvtap queue is reported as attached.

Cloud Hypervisor ran into this when checking queue state on macvtap.

Report the flag from q->enabled, as tun does.

Assisted-by: LLM
Signed-off-by: Umang Pokhriyal <umangpokhriyall@gmail.com>
---
 drivers/net/tap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index ff67d99deb39e..cb8ffb0c4a315 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -950,6 +950,8 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 
 		ret = 0;
 		u = q->flags;
+		if (!q->enabled)
+			u |= IFF_DETACH_QUEUE;
 		if (copy_to_user(&ifr->ifr_name, tap->dev->name, IFNAMSIZ) ||
 		    put_user(u, &ifr->ifr_flags))
 			ret = -EFAULT;

base-commit: c66d93e68728cfb5f40b40d0f24129d7768faf43
-- 
2.53.0

