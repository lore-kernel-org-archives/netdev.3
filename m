Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A911215161
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786400079; cv=none; b=Vy2eGQPlj57J5nXO/8ceaPqGwisFY5VQCKxxpDYWxtYIgCHpwy8rwFoI5uGckgMhQvu+puDh/xZpM/FQfoSbygotF3fNRtzcGrNffqV0I78og+JaL484zDaVu3jNJK483wn503IzQ3kXXSlo3CPTJeYY9ffaGaEt7JWUzDMkPm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786400079; c=relaxed/simple;
	bh=R+nJgBHLUg5G8FqOw6sYG/0O0FQzt2QBmneJAqQJ1SA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWVzYiYojdR+WF9K7xf8AO7ZgIp3rZYGYtvcURCRbZ88037uaxIcUgjFxxsMC2siWg/FvGMkxPjKJQRbOx1gIvJSbE/tR12KGzWC6yVsE8YMI8OlKG/94cxEuZxoH5FPgiBMWAOwpQMYjkD2PGbZ0/iVllJhyOqqoClFt2F+1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=HcZnci5k; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="HcZnci5k"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso275254a12.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 15:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1786400077; x=1787004877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TcWTILMa3E47IXaacxZ6F1frXvBazt7YqfOX/WCkxYQ=;
        b=HcZnci5k54jVcI7Y8ArEsKajaXDBUk93zcEtlhBs+8FhaBXUrCABsVoagpo7aQX+n+
         b4IpPT34pcagRYWTlZJTl+yfOG/FiONi5JT0kRNEUqouM2MhXk1XFN9jpDTBpSNqdVmG
         V6oEcO72UWWORBHz6vDvmoA5Dc+XuiLQeQmGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786400077; x=1787004877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TcWTILMa3E47IXaacxZ6F1frXvBazt7YqfOX/WCkxYQ=;
        b=gJ0gkyj6KbYWmJa79jyore4Q0ZZr7SMk4TNKZoBEXp0gZlmAbrrjhfFGC4xXoODSwh
         h4G834T9W2FSEhqqS/7aKTg4+L/qq8CPxFne650TssEBlYHXT3gDbW0l/bjqwm7niicj
         jSiIbc+cNwIM/cr4pLThRWadrpDFprwFnylHfymMGCwwTiwpWNlCSAbR4jE3SQiJJu3d
         m4h6MttXOwC8OoCELsz1wf9RPmzSX7yLLOTP/I3JA3jdJmAyeE41/7+Jt9pkBegdWRCQ
         z4Qz50OtIc7MlhBKW1gwvoVNO+D9LcB+5vYKCe06lwo7VZSb+wkuKAf4uNnCTSVp5a5f
         iJ9g==
X-Gm-Message-State: AOJu0YxfQ0c6NDyDrUET6TTfiERb1x93LHJwPntncnDv3IXWSQtJeGHy
	HluOfzUB2NJENRphogw5otNyDVICyRQschrOJQsy89JcEc/cwidCHb0Oj1EwglOCPQThw3CLooS
	GOOzF7TRFDg==
X-Gm-Gg: AR+sD12AxesOgHBxQeU2dvS0SV7i4S6GRNh8aCpguJcijpjcIpV8Vz7/cZVhlrKoNAH
	7HGeyTt0L25D4ObdeW5HWsw8O0KCeDW6OuCZ7nmV5qIR27pZwgMGESxSdWhAOSIzHQVtzJ8efqq
	pXuaXLBWQ5+VOrGiuy2C6qtLpEK1MNZH+0ij3JvBszG7liVnJybx0z441iFreImfVSeDYiTVTbD
	sdK6LMKtaFDr0CAolkSBtjzrnu5IBO9F+FqZr4y0KJfVf0q2BB3BUNhFhfsWBBHjO41yay7F8uL
	G3AOAzn/1ZKEJ4DDGyhTfpSDLxz4RTxZZgNRHEJn15KPz2U2NeLo7lvFxfD0adiWCx+SWjbvHDk
	2wm7972kX3hsEYZBrycc6o6zagaLYCaJqOvmqIi98MyH+6SrUiR8YbFpGSh7JM0KqMiXIGhqSBY
	BJii2RMqTjfFBRqI3S2SLdZOAASJyc9H9+Jck5sq+Nag92CrT4wiCu3RZ6SsviARXjeC32tPujV
	gDnij4w3SBUYZFn76IexHwqtATyMLVCrrvHF9LLgJQwk2dlvck9sfF3V0m6gXte
X-Received: by 2002:a05:6a21:7317:b0:3bf:a7d5:df34 with SMTP id adf61e73a8af0-3cc22addd19mr2082694637.0.1786400077512;
        Mon, 10 Aug 2026 15:14:37 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b41d9sm37709398c88.5.2026.08.10.15.14.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Aug 2026 15:14:37 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH] ipvs: fix reversed sequence option serialization
Date: Mon, 10 Aug 2026 15:13:47 -0700
Message-ID: <20260810221347.34267-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hton_seq() expects the host-order source first and the unaligned
network-order destination second. The version 1 sync sender passes these
arguments in reverse for both sequence blocks. This leaves 24 bytes of the
kmalloc-backed message unwritten. It may disclose stale heap data and
replace the live connection sequence state with values read from the
buffer.

Pass the connection sequence state as the source and the message payload as
the destination for both blocks.

Fixes: 986a07579533 ("IPVS: Backup, Change sending to Version 1 format")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 net/netfilter/ipvs/ip_vs_sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 93038abbf..f6ea6c953 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -747,9 +747,9 @@ sloop:
 	if (cp->flags & IP_VS_CONN_F_SEQ_MASK) {
 		*(p++) = IPVS_OPT_SEQ_DATA;
 		*(p++) = sizeof(struct ip_vs_sync_conn_options);
-		hton_seq((struct ip_vs_seq *)p, &cp->in_seq);
+		hton_seq(&cp->in_seq, (struct ip_vs_seq *)p);
 		p += sizeof(struct ip_vs_seq);
-		hton_seq((struct ip_vs_seq *)p, &cp->out_seq);
+		hton_seq(&cp->out_seq, (struct ip_vs_seq *)p);
 		p += sizeof(struct ip_vs_seq);
 	}
 	/* Handle pe data */
-- 
2.53.0

