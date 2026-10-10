Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496A409295
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629878; cv=none; b=piUZeT+vPiIUwWZ0Xa2xsMVm8AgaQfrN7eI/oAleSeHjmDtqRGCHaNc5Y1eT0G/T3gjz/Tv8LTw25mHEWSnsQ59aeUvaP1d3YJBN1Fonnv88zdLxsCJtlp8fH/wh0CV303UyRdI1ajTHhhGRPt/rZd2pubjy6ZVf8HvtR4SCX1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629878; c=relaxed/simple;
	bh=3OTy30U9zaA/EoJrB2LEVikw7T9erylLWW9kg7srSqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GEKKGHzo37Xtd8A5nmH/hikqGAhVGVDlV64Y228U61Gc74BOmnnLYiFREOt9ee63npO9jHZfpqLOGF3pAcdOGLjv59to6UScm1I3yzKqafPTiEKjhbFeznN0mKKweN24Jc1cJu3FWGaUvuUiAJtbAeJfPzJHgdnRf4z9uZkd7h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0ygltE1; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0ygltE1"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-354ba08cfd1so921906eec.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791629874; x=1792234674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uV/uHpIyvSDg1rMqWOrJjW5nbbNl8aiS8yrcLtotir0=;
        b=b0ygltE1Y1ZWbF4NPe3ThZemZnbNZwUd/lMTmMxkwUo7FOvDi+Hq392Qx7FpKWaBkB
         jolMA7uSnyE62/zfyBLTmLtinIHhAajliGepGkeCe+iZ/GCkdl+Jk5iD1wRriUU9Hvwo
         I9Sw/tp0bPC2dACMFkEC+qdklDrMuusmHsemncgrF3CBqIWf2u6uB8Odx8GViGhHrU1f
         VSdoSAhz6aLXvaxWTBVit/IeyE6kbytP0+m8yYH+fxSSApQ8Tb/5AmsDpZAjhdwmVPD3
         SJJZ7XJKjIZuqR9opsSP4eGt5gso5zR2tZC+vdXU4xy/DyoLRfQYFdUw+GUlosJSpLdL
         fltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791629874; x=1792234674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uV/uHpIyvSDg1rMqWOrJjW5nbbNl8aiS8yrcLtotir0=;
        b=gpg7lCRS/To1YW/znNf91+8WcZ0t1ogzwfL2ZyZ1si/GKDVpTqp04PJR/m9/qKXgwJ
         fnRudktAga1tY3PujA+33FA9fKWleMChd/XJW7ex1XGTtnIHH/RzzFLPvfoKKnqhx0y1
         DS8iyM1oWulw2UVbdW/fiIV9HMeyAkv3760akcG1TxB6Ebtmxp3w2QRhm1BN8bbFtZSJ
         4wbJ8010s0+09hcYVglWvNaC5ju5Hr46hBw9wOlK0qCEprIEBSFIrh8kg+Khg2zQQTNE
         KJH9T4SqAdQY/lffkhDBDJIkkU63dSbmfb7hXjYIPf53V2ALbgYoVvSLGnD+0c9j02O6
         ybJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzka+9r6VlFyFsW0n+6NHyK4sTL0QEwI3zNvF86oAM2jXrn99cbvxR/8R/IYajSqaSqkSbueEs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYbstMAKcyE7IPf7Sh2O9r9CF9HGJ3LnajKmAp2QeoJO62uUD7
	s5xvaKApu8UGqaFi/2hmOebm3mbeDjxSU2daA9eVm2r6sXqmuK9B4CD1
X-Gm-Gg: AYBFou0jVC0CIutzXbByCNnVzdZqI83l1zHiCnOOkG/rPoNwppQEef2wwh1xrLhb3Jc
	OfA9EpqrBRP8KNpfX6nLcgCvzSk+fJ7jWBmnda3rvw28fS3tvEnhT+S95xUkbFHVI62Z7DqWD7s
	5+405/cPLtarSomHC81BtsySHXtcN625OMlHhbUlththllqoSR7wbSMw4Eh0FjTnKyrofoJLKFD
	yCtOP3/Nrf1A/v3AZIUrK7bSjjKvx/8kCMLQc5OPmuU4eak5TeObyp7tJVuYSQPG8AY7S6+WQe7
	2vh+iC3+rf3fbM8EuWiCvJKzJMQPSO47VvfzD3hyQ/0DFmdM0b3+0LfSnqHofV1m+qYUvE15MLr
	P3Z9fFqJFxL7M+TiyYxEhRtQbx7I+EhBlx6xX30TYiNJktoog3IvrBnVI75v35mmSTqpl1yFKEx
	ST9zxS2nze6HRcJ8+q9ZhGPSxublPMBnmiyQD3PwtLNBfWLp3t8JzF1JxbW6k/fhnxzFOSr87AU
	QWAK903uEEIAiNQiHNEP2zANjqNyRvuj29MpyH50zSgldGfWiejnYB0SyU8txZRst4fqi8ermaC
	M+YoqOGxAdq1ADlM6wi/rfYAzt+y+GJX+1WuedD7tdWMZf6xkYW1Qw==
X-Received: by 2002:a05:7301:dd83:b0:358:ae07:138e with SMTP id 5a478bee46e88-358ae071798mr1145061eec.8.1791629873704;
        Sat, 10 Oct 2026 03:57:53 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-353810403e9sm13577784eec.2.2026.10.10.03.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:57:53 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net-next v4 1/3] gtp: set a valid genl command in PDP context get and dump replies
Date: Sat, 10 Oct 2026 10:57:38 +0000
Message-Id: <20261010105740.223992-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261010105740.223992-1-anilkaushikwireless@gmail.com>
References: <20261010105740.223992-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gtp_genl_fill_info() stamps the reply with the command its callers pass
in. gtp_genl_get_pdp() and gtp_genl_dump_pdp() pass nlmsg_type, which in
a genl message is the dynamically assigned family id rather than a
GTP_CMD_* value, so replies to a PDP context get or dump carry a
meaningless command number.

libgtpnl ignores the command and is unaffected, but parsers that check
it (for example the ynl tooling) treat the reply as an unknown command
and discard it. Pass GTP_CMD_GETPDP, as gtp_tunnel_notify() already
passes a real command on the notification path. No uapi change.

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 drivers/net/gtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 4aff23bcfdd1..99836b773e5c 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2279,7 +2279,7 @@ static int gtp_genl_get_pdp(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	err = gtp_genl_fill_info(skb2, NETLINK_CB(skb).portid, info->snd_seq,
-				 0, info->nlhdr->nlmsg_type, pctx);
+				 0, GTP_CMD_GETPDP, pctx);
 	if (err < 0)
 		goto err_unlock_free;
 
@@ -2326,7 +2326,7 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 					    NETLINK_CB(cb->skb).portid,
 					    cb->nlh->nlmsg_seq,
 					    NLM_F_MULTI,
-					    cb->nlh->nlmsg_type, pctx)) {
+					    GTP_CMD_GETPDP, pctx)) {
 					cb->args[0] = i;
 					cb->args[1] = j;
 					cb->args[2] = (unsigned long)gtp;
-- 
2.25.1

