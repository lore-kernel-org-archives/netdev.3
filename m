Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A8F3815E3
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251301; cv=none; b=nYla516rpSNDgMmJwMNtE0/0uvuvPRsZvuz88QCU2KhT0I8wniRavxcSYBgUyrMIZmlTlfD11ioQ+QZe6Fz+cTozsCjRFtFvwd/muPC9kk8EC7Tl82ZqaBXPOLATre0ZbIzqzFvvyuYzg8yiQFKF487Pwk1FPskZ9o2K3RXK+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251301; c=relaxed/simple;
	bh=tNLgd/FfC4f53hgSjcu9ATEmRr5XYCTKBn1ygO83kDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkWnzKBmrIahie6SvM8DMhPI8ohMRw1/eYC/LMIV8wUnUAhM4PEtK3tSA7X2aF1SOlY+W4tmLxTV14TgVF+aizolRmft5wWTxMLqosQEk0ks/bH8htby5+hW4oFEkh7Db/NxDhvzWbd4Oc6JFga1br6J4MRcp5HT7oNxTtwagmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=VgfZFLLY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="VgfZFLLY"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e347638adso129115a91.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787251299; x=1787856099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QbbEA8njahnpZFXoKuwhGp1hqSSP84JqOYyTbSBwwxs=;
        b=VgfZFLLY8YiGUuaxsyeBoZIjhLzQkUj5MPGgUIl+EBkc/pj1xB/VFmDCC+j7E1ruUS
         BIqHcesTGHldg6IDJ3ZxLKltgB1KYP+YJSnWVnOVKWIrA30ec2SiGXETRUQr0zos2gbX
         rrmozKjZkdU6IVo5OX4rRo++qqnpq44534Y60+Gfvf/NBXlqSGuTBNYisUBHoqouh9xl
         Ug7ObTa9EPI+k6kSi1IpsHpSXwa35SEmP574CA3OwdmHQZjA3vo3BV80X1OTzl4HYooc
         VkzG/+X9TWjumlHH+SjX7sD9RV2IIe6wDq3+xeB7aggK+459Ijk9UeNmUq2AO28zONQM
         1yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787251299; x=1787856099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QbbEA8njahnpZFXoKuwhGp1hqSSP84JqOYyTbSBwwxs=;
        b=TXkfs2D+SnlG1hUhfUUQdBw9OJ3XblAkg3ah4QHW0xIPdUR+4S7rE3MjVeHKidPQ6t
         GUZP5M1UlqMM4gsxIcIjRh7HxGHx9rHX7vWUPnDARO2iTkRh6R1GGacWmAle9vZa5ZaE
         KAQoy/SGYOKvGqrWdJldEGmueR1yjBCWCN5osgvClQN0G2JE7SOiW2eefCmlVI66xCNI
         YX2MeyKC9xLIjcCSZR8A3of/dlVCCGTTlyvb5PsnolrOwKDSlmrl4VYdInuqLPeHkha3
         g+uES3xBgT46S0GdMZ1mae3YImDkT/WMvclx+7kFBVzsqSsadwPI+HD/mwg1jAg4t4sq
         0shg==
X-Gm-Message-State: AFuF++kAgM6ez8BGK6tGQaQRQGBSPmonN+hMOFNv7Gx6EDK71eOICb6t
	cn7Y4Sy3dq9rM38GY8BPl7rdipsDY+Cz/0bif7km7/XcF2iHii50QAeOQ+tZLqXHDduZXefCK33
	puUhQq1yzY3U=
X-Gm-Gg: AR+sD11Q/4Qezbar2fqqDujQAm2o7Ec27OSpRMkOBMWAwPpYThulfxkIi8gbd/zsBbi
	rN0K9/tBrBpfRcIXfvibJr5b/SmivZlqbAM6Oed3FPGWZe/2r7t8tPtHgBGhDSk3LIyynsmgR80
	S9plytjGSW3tPpSgb1/t3COGAo24huX4Y6Wut+iwX+5XpwmFVO/N6yyYbZEGVkOo21+LOBW1Q0n
	tn8YhsmVzoAIOZHUm4B2vcerMN6QiTjetjRtCKAR+F8AjgmJdEgXJYxohbyvip8odAIED0xbpb2
	qf2HBu1eauKjVdY4TcyjQf9D6zg5YIXqXgmJKJ2UJFe1aojv1jM2Hx41Zf1fDibPw+vjK7lHi6M
	9L+L+KGGjs55XNcnaRo45WsKzPLkr41bCaYWKTfoA/GwXCKwnSUqIkWK/IJ2j1hAPF7OuMWbNFB
	iFyfqzLVFwpPJsLFGahtueQL0wS9n7g0suqQbKoazV/P+SQ4WSnp+DBe6wKibwwsp7NphAhH70b
	VKIUR0r4sbXRxI=
X-Received: by 2002:a17:90a:ec8e:b0:38e:659b:f366 with SMTP id 98e67ed59e1d1-395c2f2d9d1mr1256800a91.0.1787251299357;
        Thu, 20 Aug 2026 11:41:39 -0700 (PDT)
Received: from gmail.com ([115.192.250.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c46b88e9sm20142a91.7.2026.08.20.11.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:41:37 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v2 1/1] net: l2tp: do not propagate multicast notification errors
Date: Thu, 20 Aug 2026 18:40:28 +0000
Message-ID: <54f48e812ca0424c47ffdb9a8182180921f7e6b2.1787247008.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1787247008.git.zihanx@nebusec.ai>
References: <cover.1787247008.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tunnel create, tunnel modify, session create, and session modify
netlink handlers send multicast notifications through helpers that can fail
while allocating or encoding a message, or while multicasting it.

For tunnel and session create/modify, a notification is sent after the live
operation has completed. Returning a best-effort notification error as the
command result can therefore report failure for an operation that already
committed and can cause callers to retry and accumulate live objects.

Keep sending notifications for listener visibility, but do not propagate
their best-effort status as the command result. This also keeps the tunnel
modify command consistent with the other notification-only paths.

Fixes: 33f72e6f0c67 ("l2tp : multicast notification to the registered listeners")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - Extend best-effort notification handling to tunnel_modify.
  - Follow the existing bare-call style instead of explicit (void) casts.
  - Document the observed ENOBUFS and committed-state reproduction.
  - v1 Link: https://lore.kernel.org/all/cover.1786962220.git.zihanx@nebusec.ai/
 net/l2tp/l2tp_netlink.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 59457c0c1..fbdd3d055 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -248,8 +248,8 @@ static int l2tp_nl_cmd_tunnel_create(struct sk_buff *skb, struct genl_info *info
 		kfree(tunnel);
 		goto out;
 	}
-	ret = l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
-				 L2TP_CMD_TUNNEL_CREATE);
+	l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
+			   L2TP_CMD_TUNNEL_CREATE);
 	l2tp_tunnel_put(tunnel);
 
 out:
@@ -305,8 +305,8 @@ static int l2tp_nl_cmd_tunnel_modify(struct sk_buff *skb, struct genl_info *info
 		goto out;
 	}
 
-	ret = l2tp_tunnel_notify(&l2tp_nl_family, info,
-				 tunnel, L2TP_CMD_TUNNEL_MODIFY);
+	l2tp_tunnel_notify(&l2tp_nl_family, info,
+			   tunnel, L2TP_CMD_TUNNEL_MODIFY);
 
 	l2tp_tunnel_put(tunnel);
 
@@ -645,8 +645,8 @@ static int l2tp_nl_cmd_session_create(struct sk_buff *skb, struct genl_info *inf
 		session = l2tp_session_get(net, tunnel->sock, tunnel->version,
 					   tunnel_id, session_id);
 		if (session) {
-			ret = l2tp_session_notify(&l2tp_nl_family, info, session,
-						  L2TP_CMD_SESSION_CREATE);
+			l2tp_session_notify(&l2tp_nl_family, info, session,
+					    L2TP_CMD_SESSION_CREATE);
 			l2tp_session_put(session);
 		}
 	}
@@ -710,8 +710,8 @@ static int l2tp_nl_cmd_session_modify(struct sk_buff *skb, struct genl_info *inf
 	if (info->attrs[L2TP_ATTR_RECV_TIMEOUT])
 		session->reorder_timeout = nla_get_msecs(info->attrs[L2TP_ATTR_RECV_TIMEOUT]);
 
-	ret = l2tp_session_notify(&l2tp_nl_family, info,
-				  session, L2TP_CMD_SESSION_MODIFY);
+	l2tp_session_notify(&l2tp_nl_family, info,
+			    session, L2TP_CMD_SESSION_MODIFY);
 
 	l2tp_session_put(session);
 
-- 
2.43.0

