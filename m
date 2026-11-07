Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053850;
	b=jAR9d0aEUBKaSKqjq4KUGkPj+2A3TBWicugQT5+3EYuT8pVmyWmaXdZ6CVhpjTcfQN6X
	 00qLfdTwq6JEE77v/g7/Av5SbwUpazaPZ/FI80lMxNRje8LC96CRPTyxkVUyZ8SjyLvNN
	 TnIAbUIaplALg7ZDcJ5DOjF+ZlTJcGjhPQ5uEIhBmK9HqzIPW1Z2MK6SVID140M1Jtoya
	 0qmTP5ipLGx+yCuqpmao4xkE06xF/P+zvmwR7e1qsjG5QwwXLXGFLYXxK4ovBd3yyWbRZ
	 7KdGOGbwbJrLNjb+XGSiTivuhaRbhWFqPZ7VbjxMjD9vuDpGQ7FeMECWiXkUZ+dlSXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cMAFThmdZJlbS1aX7SDEciw6V+3YUU4jS0RKfJ1+k+U=;
	b=SjhwWbRJJKXuf5oug5cvoxE0uc+IcxRAYcb6PpmU78kAzP7BjwDg70HivQ5BU97PXHdw
	 nMpaaVSQoKJc74shJFyInCOC4vJ+kcXmhcLFJSO8MjpyqHy+ZFnoQz/eRiHaXmc4JQxLn
	 JOGWW8HR2n2LYDtKtXcc26RuCJOlONNxB1r4O9WdYkx59Su0UCNKe8z08yc3AwaUAdod0
	 kGRyVGZCNAIo3k7e+/jXFnsRlbE+aJKPXCw4JswU5F0Ppr6s7J35PjlxKJ2K3lMK+dVCp
	 ngmPoCCBrxkXHlR5Z+dVs1CGI9uE767oGYOeWGmBq3eGx92fDUjHor08ks/2NXrtCAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bS0kT5Xj;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596AE606A32C
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 12:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 596AE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bS0kT5Xj
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ea7987517aso8749925ad.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 04:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794053850; x=1794658650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cMAFThmdZJlbS1aX7SDEciw6V+3YUU4jS0RKfJ1+k+U=;
        b=bS0kT5Xj5JjrCGZYBPS5x4+6T2PSCUiR2KbMIx+sFh+Ys6XyeUpaNZJQfp9m/CSsAP
         DLGRp8q9wQJYRG28TX8s31KGRmtSpLisPGyyJeJh70BXzVbfx3bZbJuJ0xIjP90dd3zI
         tiaZUq6lLGmUhuzfdJ0Mn09ye+2/7vXC3AsjIGXKVpQFLK2RXxEhQ5UOc6HBl7BmNtGh
         egxPaSJwnzJ41mPMaCMLeguUSLgjLRUFjuUKefgRm/0gBqcphqfKpTB5Zh1Q+D/yRJLl
         7xqaM6mIV3GM8Sw7LZ7xN3E/RaVUHBK3QUe6Nhi5P445CYWdPDMZTbBLvPIfH5MwMCqk
         BVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794053850; x=1794658650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cMAFThmdZJlbS1aX7SDEciw6V+3YUU4jS0RKfJ1+k+U=;
        b=PG+zrGKSiErJFG2hT1oOHAhwXubHWk6ulLjZFSsjzTxCgJtkGJB9uXLDFVxCXvf+/i
         ZaSp4Hhiim1d3WRH4RqFg3SHe7tN7pSUznTa5PzNHTZHUFeQFDlCT9VlEHQvrk128nZ3
         ZUsCaxuir8T1GARO15/z6Sq9NRAMH+SCzNWT+lKuhgGP+fbYLYI3H5VWjxbFrZ+hIpuy
         7KhIWl+uiIHiky3ZlaSS12EkEB2G6Ak/9Bn1jePux8Vx47rYufULE0DggVvhhlKT0URh
         +lZrM3Ku6Cpb6M/tQO4H0i/UJHHh/V+3/MtYlIGCaeGKIdUoeAx8ezLUuJM4sd6nnMNs
         oekw==
X-Gm-Message-State: APuU4Z95E9PH5SIb/uN+He0j1EdjehgoGDb62DBw8y3QMigdfyxv38wQ
	UwdsBFVLkgI5qc3uiWGvSAqgULQvaXJ0BXZZ0wvVo6QFmAkr0HhZe+EJ9HyFeu+pZ0k=
X-Gm-Gg: AYBFou3IYMyhSlIWHnvAsizasb2q1W6Cg9zTe+MeBKiq8H8uKwPHJcL9uUOheLWy8Wd
	Vwcc1Yxy9NsQIuzP9H2uXwNDmgGX9C6+3dWQ8a7haGf3H0cFsLHMaZ4H3ZAKOgCxlqS3k/sB9kC
	PWGO143PHY8rx0n/z47VnoOA3Y+O6VHB9PT1aE48m0uZQ+rM5aCSkhfLcrPutMNk1w0IlEWjmty
	wOFo2wD1I2tzuGIqTp9fJK4alATkDzrVLAis6cqq+d5Zcbfejb99L0TgPanBptT73Se3gLXqXD0
	swj+oqldobEg5PpfJm0rqJXxExr2OXH0IlusnBn/NM/66HVLAkNm2AWm+Vo6rY3S/ec1oAR49ak
	WUTO5WnY4vSvaXw6zclqYJVc+ost1z/IE4VJZ/qrwEc9jkHD1ic1nAgn40D/OuIU0ZVUdIu2tsE
	UncfiQbkl5kGwFUPhp1Ia65LN3vL1ypBEdEWn5WlmVPHEmRZ9zpQgpqeN6meE3yYoXUtjpc06jy
	hqx9i7WnKjSbXxGM5WRfp2kRChK+iBFGNz2Q9Ph+DQV5rThCH/JeZMJYzQwIWmJOPALnDfDJhzz
	TyBj0PQuhk42nYpxpyviEntt9KIipVSFJpG2dpMfn1/4xmc/HPWURA==
X-Received: by 2002:a17:903:2290:b0:2ed:1f17:65ad with SMTP id d9443c01a7336-2ed41c400c8mr56317455ad.60.1794053849543;
        Sat, 07 Nov 2026 04:17:29 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f35asm12773555ad.49.2026.11.07.04.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 04:17:28 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 5/8] net: dsa: motorcomm: Isolate all ports during chip setup
Date: Sat,  7 Nov 2026 20:16:26 +0800
Message-ID: <20261107121631.1040612-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107121631.1040612-1-mmyangfl@gmail.com>
References: <20261107121631.1040612-1-mmyangfl@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Chip setup only blocks unknown unicast and unknown multicast frames,
leaving known multicast and broadcast open, though known multicast
cannot appear while the FDB is still empty.

Isolate every port right after the hardware reset, in preparation for
the isolation refactoring. Note that this only minimizes the window: a
reset always brings the hardware back to a dumb switch, so traffic can
leak before and during it.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/chip.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 8ab499611fbf..32701f9e687f 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -2227,6 +2227,7 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 {
 	struct device *dev = yt921x_priv_to_device(priv);
 	u16 eth_p_tag;
+	u32 ctrl;
 	u32 val;
 	int res;
 
@@ -2264,6 +2265,17 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 		return -EINVAL;
 	}
 
+	/* Block all traffic as soon as we reset the hardware since it now acts
+	 * as a dumb switch.
+	 */
+	for (int port = 0; port < YT921X_PORT_NUM; port++) {
+		ctrl = ~(u32)0;
+		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
+				       ctrl);
+		if (res)
+			return res;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

