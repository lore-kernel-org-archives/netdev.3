Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B73603DD
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747431; cv=none; b=imgRQ875UXe2vOeYBjVFpUDAX7QGdimLltStjpY9SUPIYLlnMHi4IZTulJlqZYT3PEboPITfgM09dn6AsxH7/gPg4/L8ctcqavuE6XKAJEvxvrIT3enrkcBiFaSYazL6S2mH+gzc2156brCuaU67vOkkpy1vTjqtGd64VHdyl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747431; c=relaxed/simple;
	bh=lmPpYSlPcQNZpTQXLMEyB3rxC3XM040jCc/+2R5k/b0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RyMQ+klm3xIzrJ4lchbKY9niOvPcwzDVT0XNnouwBOnsX5GGx9bGDDiS1qIBzy0eNyu8ShoEzi/gWh6G5XPuSLc90TvruAYntyAtHYGqEc+ltJETU6Brz7osP2P6sSqW+cWaDDQ2RcxseYxNLOlWrAu3wr0TyML/GyqHhLQMT2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BPJcBdUy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPJcBdUy"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3598d3e3bc7so4424031a91.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 13:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772747428; x=1773352228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q82HY+Ox5JF0vwG5eIoCl0bQkH1ycg7BDvsoRBp0gXg=;
        b=BPJcBdUyqtlPnWnmC0qotZqGwAZv3gPcSMX7Y8Hn1FKBefTIQJGTS7236qHjNFC/9n
         07O6+CdYNvqFrXHR6rIRpeQAo319sIUbY6Ans6okNlrnG3I0/mVw/SEsTN9mPye09yLR
         YT5xtfEbjapQZRwzU/JwzWKmHgczNex9Qo17bexgciejq0pNNnahNXOrUPTUdJr2LaNu
         pY1qhwGLNjycgHCN2aqoS+p9bwzDnHzqLkx14iEZxiIceqAkh+1z/SXBYnMCKiB2n7Bd
         4RizIWGzhaHfOhnAjI47IZHRNuupe3FuiL3abzrvKDz/qBHyLdPe8Z2WUR+v7Vuj1ZOL
         Vz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747428; x=1773352228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q82HY+Ox5JF0vwG5eIoCl0bQkH1ycg7BDvsoRBp0gXg=;
        b=t7i/OQ3lF7YcZ5d9qgPt6DeEC5aJmDz5/1JfdD/YCpBSRwpx4ppuxRtRlNWiClGhzS
         N73AmQuac8ybx/oos58y7Lx0I6vobmKJ7z5oRyLSoz9SP+TjvHaigo7vAONm0u9uoCsn
         Z0De1vze0d/tAmtfFU9QIHamEhLFj+9T2KJJ4FSgL5H2DsXuK+fFGm3A+Vuo6j9GLpVl
         +8bRny2gIMFxV1rGLFbpZWvXKg4kdA7tt4vWANwOaWJvB3l0LAQPMTCh6Ou8g3VsEriu
         +qr2g38ud7m6zZpoZuOt/Nzyo+SYczx8L/XnmKEL/ABka9gxmwOVSp/9M572wUvnPdL2
         TZvA==
X-Forwarded-Encrypted: i=1; AJvYcCWpJM7oQGy4bj1Ox+/TyBtGDP+T+qY4fjr0NOUOyerqXtUJrloD1+7Vtqa0wdI4MjzyG8reaIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqrfIhV1fJxL0Wl4fX08RnEqQPTNkkr7O1HsnxTid0ZNkmWFh5
	4qn2zQnuUjk1izak5c60HGh77WOrKFjfWuWwKMhz6TaFeXgFh18vOzJNTIOK/fU0QmL4NWA4IWP
	ycUYqVA==
X-Received: from pjbgk12.prod.google.com ([2002:a17:90b:118c:b0:359:9051:f779])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5111:b0:343:7714:4caa
 with SMTP id 98e67ed59e1d1-359bb337ee1mr905032a91.3.1772747427978; Thu, 05
 Mar 2026 13:50:27 -0800 (PST)
Date: Thu,  5 Mar 2026 21:49:52 +0000
In-Reply-To: <20260305215013.2984628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305215013.2984628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305215013.2984628-7-kuniyu@google.com>
Subject: [PATCH v2 net-next 06/15] smack: Remove IPPROTO_UDPLITE support in security_sock_rcv_skb().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

smack_socket_sock_rcv_skb() is registered as socket_sock_rcv_skb,
which is called as security_sock_rcv_skb() in sk_filter_trim_cap().

Now that UDP-Lite is gone, let's remove the IPPROTO_UDPLITE support
in smack_socket_sock_rcv_skb().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
---
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
---
 security/smack/smack_lsm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 98af9d7b9434..e581d6465946 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4176,7 +4176,6 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
 			sip->sin6_port = th->source;
 		break;
 	case IPPROTO_UDP:
-	case IPPROTO_UDPLITE:
 		uh = skb_header_pointer(skb, offset, sizeof(_udph), &_udph);
 		if (uh != NULL)
 			sip->sin6_port = uh->source;
@@ -4301,8 +4300,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 #if IS_ENABLED(CONFIG_IPV6)
 	case PF_INET6:
 		proto = smk_skb_to_addr_ipv6(skb, &sadd);
-		if (proto != IPPROTO_UDP && proto != IPPROTO_UDPLITE &&
-		    proto != IPPROTO_TCP)
+		if (proto != IPPROTO_UDP && proto != IPPROTO_TCP)
 			break;
 #ifdef SMACK_IPV6_SECMARK_LABELING
 		skp = smack_from_skb(skb);
-- 
2.53.0.473.g4a7958ca14-goog

