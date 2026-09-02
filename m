Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AC74A8FF4
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377951; cv=none; b=JkU39x0ZejdF4/laUAOqCXYPniBu/LBqGmts7Mhdqhv7HQZzufs/j0oaINHgoDjA2MgRTeaUoeksipj9F0Xbm0wovu1QqyMcvmBKaRHUNlACB6fyRuC1/FL5wNlS5BidcaBXghjk0NV+TTgC6b11fYKqfZM3WDHnQhwMythY+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377951; c=relaxed/simple;
	bh=IN7KgNnqs8D1ESaMkPXU7u0sHCNgKxudHA0yUaGKH3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B6WoVBw3kAoxuptCSJn5Xl1zcMrwHgOcxXxR3+q6SvJRy5OcSNwTrx89O20WCS5nmBIVVTm+DsH8teaSxWPIsM3bJQz5zpFn9JGlvybY4AN1uI0+8X2u5+U+I/MgOcS33gJDqfszVcI4TMNIZceJ2PsFYG1EsfnbvrizBN1VyeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEdv7W3n; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEdv7W3n"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4957eefd361so10290895e9.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 12:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377938; x=1788982738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qf3cTJ2gK9rwWSik6ILKIPabS+XWIpM77pAw1SCvPKM=;
        b=eEdv7W3nyILq4p2OHNywxGRG+5XtQG2woHts9iT9TzZp1+keMP5y3pdLlzRObQOxCd
         ggUr3NSe9r2lOEnkYHMERSjsKpifnPbzZpYrjPzfkuONGUnZWGG12HSt92li9HgtRt1g
         4zzKucecLqf6xhZOpV43+wW+bUM4DTt1+AUt5qZicA37b0Hi3ru7w1s2hUhVCCYMg/99
         RUHlv8zprAhaD1kkFTyCCmTCM/x7q6nap2N32Vv6hiK0Odjet5rl/NH3ehcnv8Aq8nIU
         oBBTNr3ZRlcb99+VGpj4ilUCD1AiSf+9GmZRHq1LfzO2TmuJnA4vTme2zKRqg4S8A5Sj
         knww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377938; x=1788982738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qf3cTJ2gK9rwWSik6ILKIPabS+XWIpM77pAw1SCvPKM=;
        b=n7LwTJbUW3Bb7QQkbnZj8tenN5nQ4k/397PKzH94mIBlzGDqlO0evkhoLs1KrbU1LB
         lW8iaN0OMC1z+lJTjyN1iab7sX+j2nNQLa/rEolVTg9RyrohSpNxle0KS37G8PgHqIbH
         2cnvZNFmSZpjhTgbmOViaM2b4di1yXwqwCTYsdscHpLUcP6CDA6MTXMDCtPxTSgqp5YI
         Pv6ZR3s/Et9tMoj9d/2YIxxtQXeZK+APA7wz2Oku3RIqkulqSEHyog10IK8BbM2LZ0Zy
         oWaRrxQvMC9dR2gMcuWe9qzFKLnwHBrB2CQIXehIqiW6jZFK0Z2NiHJKoipaBgCHNFYB
         xWYg==
X-Forwarded-Encrypted: i=1; AKwUvBwY0rBAsKHHXeweJikEJ+xUAYx3SAuYlRKB5aVLszglguPrvVJPWZ2GnACzUo5tRwE901VXywI=@vger.kernel.org
X-Gm-Message-State: AFuF++mJ4E3Kw+od2wZ43+l5QF9Ocjzj1zq1Ios7s4goSL7p8oA8vg66
	bSX2z/v/1aDYCQuH2v8JuLt8XtsEx1BwlCwaRUJerQAB7iyswTofA3b0
X-Gm-Gg: AYBFou2dMWr7NIvtKawGRwlMadEZELb+NVQB9dw0zSNAqv1v3IPC7HIaTJLqddIffp2
	9s1ZjF59p4YUqG5B2iOhBlTLW+wE9Afh06h7OVwzKf/zKdLWpqTdlxmum5Es2ARZ+DgvvTspIFp
	fXhiTOTq1vLfSNZgh7Vb7JFBX2kNUA1T2KRSscbPs31tFgf/YI9lX3FRzz4YpdLmteG2oquEV/S
	0pUPlfFxZewzmHT2dMEXVRIEdm0N1SLgGqxMhZCpl3m4AHEH+W83ccRuMf2ev6yZyYQ9+mFmV/R
	Wvj0WTMxtd0y29kwNzkE4qhszyiXtR9YwMwAhXZGuBaqWnbpGXhoPattL64D9a7/xzfsgN+E0rt
	fyXZj9N18Y0yHWH3GbabzZeOHWpOxR0Te95ROKlc2IzJ2BEciYBq6OEmfiXUzBziYcYVyowmYgv
	nCClX3rapwHxo6qtSZ0yEjzqqPYpclxJvsbn6S0Sj1LUAbwXMuFLIShyuZBaxMkdydnhMcUyvid
	qDgRoI=
X-Received: by 2002:a05:600c:a402:b0:49c:ee22:364c with SMTP id 5b1f17b1804b1-49cee22422dmr34410355e9.9.1788377937983;
        Wed, 02 Sep 2026 12:38:57 -0700 (PDT)
Received: from christian-ThinkPad-T470.. ([2a03:4460:170d:5700:2ccc:f994:68d7:fe7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce554d52esm49925915e9.3.2026.09.02.12.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:38:57 -0700 (PDT)
From: Christian Melendez <chrismelnu@gmail.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Christian Melendez <chrismelnu@gmail.com>
Subject: [PATCH] Documentation: netvsc: Remove stale "not yet supported" XDP_REDIRECT note
Date: Wed,  2 Sep 2026 21:37:11 +0200
Message-Id: <20260902193711.113291-1-chrismelnu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831200357.45390-1-chrismelnu@gmail.com>
References: <20260831200357.45390-1-chrismelnu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netvsc_run_xdp() in drivers/net/hyperv/netvsc_bpf.c has handled
XDP_REDIRECT since commit 1cb9d3b6185b ("hv_netvsc: Add support for
XDP_REDIRECT"), and netvsc_drv.c advertises NETDEV_XDP_ACT_REDIRECT
in xdp_features. Remove the stale note.

Link: https://patch.msgid.link/20260831200357.45390-1-chrismelnu@gmail.com
Signed-off-by: Christian Melendez <chrismelnu@gmail.com>
---
 .../networking/device_drivers/ethernet/microsoft/netvsc.rst     | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst b/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
index fc5acd427a5d..616f808e885b 100644
--- a/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
+++ b/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
@@ -116,5 +116,3 @@ XDP support
   before running XDP::
 
 	ethtool -K eth0 lro off
-
-  XDP_REDIRECT action is not yet supported.
-- 
2.34.1

