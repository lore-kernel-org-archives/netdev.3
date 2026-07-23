Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAA047FB08
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832397; cv=none; b=omDH/Drp8GvZ/IqBwc/gYs0AdirlcwlDzrhLTb9KCryZp7gJYEPFTIGDzzue0cVmsz0SKstkzLEbhSe/WvrtLZjpQbO2V6bNaCoM+LZ3EhcUEEl4F3YZxbSrCw428I9LKvhJ8hWQQ+t0gXSmDIOLnVP+Igtg0OACWCFVxDrI274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832397; c=relaxed/simple;
	bh=zNsz4g/9jlKYeSwyAkgTCr/mWLvx1XT3kgMf7ziCe00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KY5uMhtlqQZrnVpvOhYoKMswARILaZrCSQXVk1M6/UZ5Fb56UULYKv3NYvLAkQjcBkvLgIKnLgkqjH+TkoTK7lCJtnYtTSn3LobrkNJlyd+wnMLjf1nVNjxb1vvPFvEg74nEgoz1I3JU78snNwbj+MaYYozhxnDh+VFtFzNjkPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0l4Ru16; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0l4Ru16"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1021015a91.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 11:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832387; x=1785437187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvjX2o7DFFzayFyUFs0i0LzhZ1PMgAv+++MqFVj9d/o=;
        b=K0l4Ru163rF4tHzGTfr2Y6xJ94fETN8xR+E/v70yXifc5TWJyT/ns7xFE3HlW7IyTD
         rqFWUZNU2xbwXbJJ1kiA1M1KqTloup2DbD3GBhCY0oOULOs0I4n/Vdg4mIcymMlkPNom
         05jLtTGTKRJ0Pzk8hjXMOONkFpkz+VY4UwFIjGT84rQtiBIBCB+9x/pivh1eGHGZRW44
         +GdoCQnS9tVrL/aSqdMx4D8wp0LB2bkofN2fZ2xbC+men9lMu3Hcn45yk9f+i+mhD2zK
         NgGr698RE1H7S/wYh3nCthw1DAH2T2tBGG1mmirAZJ+Omth19hkwtQUlOjVlojge2ypQ
         56+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832387; x=1785437187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gvjX2o7DFFzayFyUFs0i0LzhZ1PMgAv+++MqFVj9d/o=;
        b=amaglGULndD7szEs9AY33m5UzCchT7eWcp1uzNYs3b8FRv3wBIsvlvBjQGJsYB9XE4
         pinB61ZEjjMka7QPrMuL+TsldyGruDscyrelqat8eNGSlhtwmCvz5ndYlia8UUqLp6hj
         VLmhtFP7nfWXM+cUzm+S8xRix3sWEsldAjvGpJ2fjLI2JOeXEACom6KRe0SwfuUF8KHH
         y1QU1/zFEiQg8j9GHEV+0LrpxxlkbQDeKeBIFYKp+qsQzB4GC7dbDixbLA22IEL4O6Rt
         6DB5hSoEWXQ/YiM8JXi6ivNR4eLcaZKkgDg8WKwQ9vfi/dq/EPkRxI1I7ARDX1wIMCMP
         ECRQ==
X-Forwarded-Encrypted: i=1; AHgh+RphNpnYmwrCcuwoYDOoZIHHKz00izKRbPLIjAE4mTE5ARwUnXXTWN/jK4Jdwhp9FVT/mCP+uyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8RmHIcr5sH99T4G9Emcj9RO7UXGedEGAtYldoczkYolaIxCN
	PfDZw9jb7CS7tP29ewtqdouu3SaZf6oGXtTRYroW5NmF+QdSO4JaBnPs
X-Gm-Gg: AR+sD11ditwRTcfA0DBaNMKwbJWKvh4WuMBlEYlk6fzlyv/l3gM3BLSjiZ/GPgJbjoS
	d+/Q198daAzUHD58oJL3G87p6syrVvtuwEFmaXdOcN88lh5pzorfOmCDF2UxR2dPVSVt43vX93F
	rstAX2ltdtkbUTaF6zCQC0iyKd9GHBbpA9LEF+VXtemBx8ZGOwHyaOzDiLgUb400NwwAw4LLnuL
	goXyGiXr75wBWLY6Fg3UiOeI/FfirDx1Xj+VdxCS3hbPMKVYILVgc03GVMLXhJQPaCbT2yGPSlt
	TXgZ8+oCc05bOyVwgLLkl6eYmBfjlNVYtI5cSDpHcJ/sO57SSIeO2Stc91Qdw7NaIRjqqtrpVe2
	jU2XqWBBv0HdUUry6+nwLO6gSc1dQ7SE9xRrYZT4JleavBRSKqZX5REWNVGyecek1irZABZTVOw
	RD4OeXJ/w=
X-Received: by 2002:a17:90b:3ccf:b0:37f:fda5:8d9a with SMTP id 98e67ed59e1d1-38ec6a5115dmr4284232a91.25.1784832387385;
        Thu, 23 Jul 2026 11:46:27 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:26 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: cocci@inria.fr,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 11/36] ipvs: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:13 +0900
Message-ID: <20260723184538.3888637-12-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 net/netfilter/ipvs/ip_vs_sync.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 93038abbf5e0..bd4f7e906cf7 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1603,15 +1603,10 @@ ip_vs_receive(struct socket *sock, char *buffer, const size_t buflen)
 {
 	struct msghdr		msg = {NULL,};
 	struct kvec		iov = {buffer, buflen};
-	int			len;
 
 	/* Receive a packet */
 	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, buflen);
-	len = sock_recvmsg(sock, &msg, MSG_DONTWAIT);
-	if (len < 0)
-		return len;
-
-	return len;
+	return sock_recvmsg(sock, &msg, MSG_DONTWAIT);
 }
 
 /* Wakeup the master thread for sending */
-- 
2.43.0

