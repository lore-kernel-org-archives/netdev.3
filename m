Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C2346A607
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987329; cv=none; b=AoHbyLYYwEUpoQy3mvP6AOdvsWeWSE9Lw2pJod2bWLIBRPA8xsbnna5VNipb6q/+Ap5OrEo0atb8aCDbbTJqOa1kMAaygQmGbOdof1+fiS3363CWeP6A2xEyKV/R3A20rfeJ7tsG/56EiSA4I2gK+xhiaKKpbDW9XuZJuiKAhO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987329; c=relaxed/simple;
	bh=rsWpgWyTG8F1CuDnXVgty6t/FxOndhvrhLNDCyp5r0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fR0yy1YFCesG0fFmkNN7uoqgJ15yiVTxJH+KRBfwMFI9OO1Tm8CgyPeIxPZ2wrG096c8/zUFICGTEnmtckBbUQ6wTCDkwzEA9Y+m1BMkzA95PLgyfE2IhWVKHaNMg0+lYthmRWIqajgd76N0xexdSMXcb3ZlFelj3k02fRYy0aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=AHL3IEsO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="AHL3IEsO"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d53197d8b5so29968555ad.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786987327; x=1787592127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DSEJPmFXNKbNuUcOcjgoKVWZNDzQ/7KKx2/i/MKTQ10=;
        b=AHL3IEsO+7qiZ5BP36A8zNn7f0asLJ/pfKfopomTqV0WmeYUKO4UQZ/ejv/ZdKOdg3
         CQFUVx7eJ4y3LnKeEYqScwxsKXShsF4G53WoOIj10liRuzmbV4l0gVyfOyyzbH/Uvf3x
         lW6aPY//n1rdFg+rZHoa8B/O6DAIUAuX7CmXyGNiy6IXuTnGekEL+DK4Ulwx75oED+AH
         UQo4NcRNs3ipBrkakLAwLtC3XfIzdLsiZ8eCCaZ2mmPpgNvvnr6UHTg9hSvIeF4YwDyY
         QJ0AjJt4US9ZGE/cycxCOpP1fh41HY7EDssgpPGUJxCiNIopcdpKiPh44SRnFU0Gmsyi
         rC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786987327; x=1787592127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DSEJPmFXNKbNuUcOcjgoKVWZNDzQ/7KKx2/i/MKTQ10=;
        b=lle1rm4BeywjU3ZD4m68liCyZCs1APsjxZDvOsf0yf+o+2wLyJvMzXi9WaAv1o2+2v
         B1+EpUpeuYIqoaKbdLcdfI8vYrEK3FK7jj0DtLoGOL6OeZpD/J/kq5ULIpgoq8Z0O6Aq
         XR2oE/mfaRNx4l0KAZKKbF1k2zFKyAyqxHbCAsdExe4bQ2FjFX5noAEz+dGQ93lfYW2H
         xhN2non0+kIUEr+P/xPTbMaBY6oOT+FKsu+hel0IqZSzesz6nHjpjzwOXYg+PN60z/Nn
         InqcuuAAIuUsVhHu5SUBWB4yCObIh0p4nr+0A2p84c81gb/flqAOmgY0SOSwK336lBy8
         Y2BQ==
X-Gm-Message-State: AOJu0Yz4/gg1YILzfRyY6VkTqTWHSggGL71gjrHGKeUILWJRF2FxJnZi
	ayGU0OjXcgTYhmVPuXTyEXC3ve+OpfDplk8uCKEFA1cdXeIxQMDEmWQeUWw3GQd1pp4VAJjC1+h
	4lk+BGeYw
X-Gm-Gg: AR+sD13/gzuyP3Q9EB1giFh08kvdWaP7Qeung5r8SaDU9H556naj1DQ+PG2jfUZAeFO
	TV2TXXOp4oAFUIy9+6wDA1dJy6oCaBZHZkZfDwz4yfACvjNq416U6OCOz7XdDh80wEVWH/MbyUn
	8F1nS/Gi/LgaDfV5ao3zUhXr7U78Ee5gtszdxJcJy/EJojEKFv+R3kN+GC6hT56c1JMEY2OV9wr
	cpoIiqvV6wzyJfYVCjzTDdHWt7giQfGJt47Sv3RTYFtR7Z5XmpQJSHgjV4mA9tpZN2mK+PBlV7h
	gir0zaFBX5pNBsVuvpdelIylQxqvcpbxrSc5mDZPVT97mHAfW/7fMNl2nwbMw+7ApuHvaKkqgvp
	QKg46D0nL9DjCMIvdQI0/vuB/swfD4RkMaanm40CJi9HWO+b5Q69H8hDAJGQsA6+DKMzM1SBOFQ
	Gk1851oMa4C+UFst3XYgBOjURIBWSSbfcYRooH0xrvx7cV1n72eTIFNPPd4oJCtJ60
X-Received: by 2002:a17:903:3c48:b0:2cf:ba10:6d6 with SMTP id d9443c01a7336-2d5c4f07dfcmr19832145ad.4.1786987327419;
        Mon, 17 Aug 2026 10:22:07 -0700 (PDT)
Received: from gmail.com ([115.196.71.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb5175afsm9260495ad.28.2026.08.17.10.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:22:06 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bhong@brocade.com,
	stephen@networkplumber.org,
	sven@brocade.com,
	linux-kernel@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 1/1] net: l2tp: ignore multicast notification errors in netlink commands
Date: Mon, 17 Aug 2026 17:21:56 +0000
Message-ID: <e9cf566687c906ba6843f72b28f11a3431a595b5.1786962220.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1786962220.git.zihanx@nebusec.ai>
References: <cover.1786962220.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260817172156.v23zY9rxoVvzX1BMGt1_VsLbfChtFGL7_-cnFYCw8wA@z>

l2tp_nl_cmd_tunnel_create(), l2tp_nl_cmd_session_create(), and
l2tp_nl_cmd_session_modify() update live state before sending their
multicast notifications. A notification helper can fail while allocating
or encoding the message, or while multicasting it. Returning any such
best-effort notification error after the state change makes a successful
command look like a failure and can cause retries to accumulate live
objects.

Keep sending notifications for listener visibility, but do not let their
best-effort status overwrite the command result. The explicit (void) casts
make this intentional for all notification helper failures.

Fixes: 33f72e6f0c67 ("l2tp : multicast notification to the registered listeners")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/l2tp/l2tp_netlink.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 59457c0c1..21160284f 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -248,8 +248,8 @@ static int l2tp_nl_cmd_tunnel_create(struct sk_buff *skb, struct genl_info *info
 		kfree(tunnel);
 		goto out;
 	}
-	ret = l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
-				 L2TP_CMD_TUNNEL_CREATE);
+	(void)l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
+			      L2TP_CMD_TUNNEL_CREATE);
 	l2tp_tunnel_put(tunnel);
 
 out:
@@ -645,8 +645,8 @@ static int l2tp_nl_cmd_session_create(struct sk_buff *skb, struct genl_info *inf
 		session = l2tp_session_get(net, tunnel->sock, tunnel->version,
 					   tunnel_id, session_id);
 		if (session) {
-			ret = l2tp_session_notify(&l2tp_nl_family, info, session,
-						  L2TP_CMD_SESSION_CREATE);
+			(void)l2tp_session_notify(&l2tp_nl_family, info, session,
+					   L2TP_CMD_SESSION_CREATE);
 			l2tp_session_put(session);
 		}
 	}
@@ -710,8 +710,8 @@ static int l2tp_nl_cmd_session_modify(struct sk_buff *skb, struct genl_info *inf
 	if (info->attrs[L2TP_ATTR_RECV_TIMEOUT])
 		session->reorder_timeout = nla_get_msecs(info->attrs[L2TP_ATTR_RECV_TIMEOUT]);
 
-	ret = l2tp_session_notify(&l2tp_nl_family, info,
-				  session, L2TP_CMD_SESSION_MODIFY);
+	(void)l2tp_session_notify(&l2tp_nl_family, info,
+				   session, L2TP_CMD_SESSION_MODIFY);
 
 	l2tp_session_put(session);
 
-- 
2.43.0

