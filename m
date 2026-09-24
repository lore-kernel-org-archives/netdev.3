Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFCC43F4DD
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238601; cv=none; b=QjYHteBaJBLJV8F2snIXRf+L8tgZMctTIkVbsnjON+eYwp1b7IlYNRtg/DTCdAxTBkPTZo/hzmMmiS4ZPYlOpV8CxsrqALDZTijjdDBHtmYiUZ+3viHEEQNp4BqzI4xGr/y0W7OqtNG7CAFd/KpXgH4TITXhYg/mOKCYKDQPHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238601; c=relaxed/simple;
	bh=AgNj/0nT4ysnWRugD7Kp3AULjkYm0vN5thIQj+vAg4M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rLmtNv2cJeQfciAKkxzDWLzxZePUgOW3d5gs6LgjSAb0YCtAgyXGA55b2ykuJ4GtpS2eehEze6X3Yrvk8EoLa63TEEPyBGfvyFmv/4iks2gHS+jfodx6c16sDdW+GZfAk78rGswkQurj+7E/DQAf1O6WiBgno2GEE5/w5oQenp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eh9xQfkr; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eh9xQfkr"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9308eafb465so412502385a.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790238595; x=1790843395; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZSDT+FmHqawgk0tMrseHQ2mpMCwGa8sGS551PfTEx9g=;
        b=eh9xQfkrHJEUxtM30lX81UbVlHiluOxhfqe8qSEibQSpWRwMdDQc7WlSy7+0WW5sMd
         rTGfUKLRXNmLRvbNrbwHwzAe/E4SZKsXjTCwR0uXQqloOQ25qTeYZNyG9OYa8eqghrO5
         VeQq49IBkT22iU5aZvveuWJHI9S4VqzzpnIzsGrFs2yWP/mgn/S38x0Tp7/vPGvPqiu8
         bSI0HlXpKbX4E3OAiqLQWfXegkjK8KXn+0coMRxMtfUL/lZdAJU79sSSJLsl92GVu9lr
         21cIKWtuQ+y+mp+8smzwLPk+SZz3zKLTGBJ9lV/2pN6iOGe7SQEsyrb+1449jH5hWLGm
         nVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238595; x=1790843395;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZSDT+FmHqawgk0tMrseHQ2mpMCwGa8sGS551PfTEx9g=;
        b=IaujwRrMww1oM3Su9wG3kVSIidHora7PpsCcc9aQZuVd+dN0kR2gvrzgFikdOeSiZY
         /TNMHAMH2lOkiiLi1Z5nSD2FKHs/6a2SSAAQeGhSfS1Ly/0VPmYT65AF67lbiU09VVFr
         B/7BeeIC7gizCDkYX4hevd9ilnmSAHyeuar5Ty5JYESLAj0lX78WeM2OggzwVepcSxzI
         vjcjsaVJ7lD2UaD94pjxd8jWouMozMhItR12bncm5HeekQ70oo9wgCrct3w14x7eLdHl
         l7vQvx1K1jjMhzgg/m/L1S7sBqIjiMhSuPo9ywnWzYPwTaGr6tU8rlSxTJ3TsespT9e2
         L6CQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjir6CrLvBXA1bxf/6R7Y+49CqabBgAD+w20/0//s0T8rwObkRAskhSRnJ9xW//BAJxR68q7s=@vger.kernel.org
X-Gm-Message-State: AFuF++nExwBLIQOEUakz9BjgEul1mtPjYqDHVKiOG952FQSIc5n47P1F
	rM9BlwiG2TkDIY5Gj1qySZ7wu7NCHLoG3dZsb0BRTN7DQISTgHZrbK82B0DUalmFR5x4IQ9+IUb
	5yHunS0I9iQAA5g==
X-Received: from qkbo25.prod.google.com ([2002:a05:620a:6dd9:b0:93c:2fc6:f24])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8081:b0:939:de48:e41f with SMTP id af79cd13be357-93c36396c40mr175113185a.31.1790238594607;
 Thu, 24 Sep 2026 01:29:54 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:29:48 +0000
In-Reply-To: <20260924082951.1599377-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924082951.1599377-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924082951.1599377-2-edumazet@google.com>
Subject: [PATCH v2 net 1/4] llc: fix skb UAF and leaks on llc_mac_hdr_init() failure
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, edumazet@kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In llc_conn_ac_resend_i_xxx_x_set_0_or_send_rr(), if llc_mac_hdr_init()
fails, kfree_skb(skb) is called instead of kfree_skb(nskb). This leaks
the newly allocated nskb, reads from the freed skb via LLC_I_GET_NR(pdu),
and double-frees skb when llc_conn_state_process() drops its reference.

In llc_sap_action_send_xid_r() and llc_sap_action_send_test_r(), nskb is
leaked if llc_mac_hdr_init() returns an error.

Free nskb in all three error paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Closes: https://lore.kernel.org/netdev/179022851638.2160803.1808206741379444999@kernel.org/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/llc/llc_c_ac.c | 2 +-
 net/llc/llc_s_ac.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/llc/llc_c_ac.c b/net/llc/llc_c_ac.c
index 724ecd741d4cf482d1768fd2e35342171ba1ecf2..1aa7fe28acddb2368ff0fce3cac5c2dab75c57a4 100644
--- a/net/llc/llc_c_ac.c
+++ b/net/llc/llc_c_ac.c
@@ -437,7 +437,7 @@ int llc_conn_ac_resend_i_xxx_x_set_0_or_send_rr(struct sock *sk,
 		if (likely(!rc))
 			llc_conn_send_pdu(sk, nskb);
 		else
-			kfree_skb(skb);
+			kfree_skb(nskb);
 	}
 	if (rc) {
 		nr = LLC_I_GET_NR(pdu);
diff --git a/net/llc/llc_s_ac.c b/net/llc/llc_s_ac.c
index 98deee560373515007fba57463e5a5868650ff42..831998211b52eeaf70532f08d86e8a1eb8b03c1c 100644
--- a/net/llc/llc_s_ac.c
+++ b/net/llc/llc_s_ac.c
@@ -121,6 +121,8 @@ int llc_sap_action_send_xid_r(struct llc_sap *sap, struct sk_buff *skb)
 	rc = llc_mac_hdr_init(nskb, mac_sa, mac_da);
 	if (likely(!rc))
 		rc = dev_queue_xmit(nskb);
+	else
+		kfree_skb(nskb);
 out:
 	return rc;
 }
@@ -170,6 +172,8 @@ int llc_sap_action_send_test_r(struct llc_sap *sap, struct sk_buff *skb)
 	rc = llc_mac_hdr_init(nskb, mac_sa, mac_da);
 	if (likely(!rc))
 		rc = dev_queue_xmit(nskb);
+	else
+		kfree_skb(nskb);
 out:
 	return rc;
 }
-- 
2.56.0.rc1.310.g51773c2048-goog

