Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C824220698
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309232; cv=none; b=Ix6i0PVC5d71e7RBZu80YPAebpdNPs8idnOhhjiw5r7JE4UHzFUU+09rPKp7EzuhUc9aV5pI1EvD1OyyvXWtpx717evWJ8msjopPEefdYka2ULnI4tdpDoyvo2rirMFfnSaEfcz3Gx0j/MapR4hzvS9ZM8GKH0OpghXhRtF+wIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309232; c=relaxed/simple;
	bh=Dy1xk6cFgXpLiiw6t4pLDLUgzQsg5kuUZotEC2qA/Jw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BoJ9yPhFhMAcnFbtghDW6PYCZyXcDjwhdiq2yISlWVw/mmNXESIsiQOfRGxl+mDlxsJXFJUTuiu8tQyt2gF8Gi96COvaJ5CU7SZ7lBD00ZOHH1ubGwLtOXmT4Hg9kefK4wUyafSRiMRqb1RZksyEwhUetRBHHpar/8mFdYUk/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OdsQNeO1; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OdsQNeO1"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92ec3146553so152027485a.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 17:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788309230; x=1788914030; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JGJWrHOSnyRz2ZQ6Fn4p57X8zqLnhKTqSmyiGGVbUmc=;
        b=OdsQNeO1FLkNxQSbYMXgALkM7RlCKTLgX5YtqgcG81XPDsCtlRIBnT7YHXA3pJeazn
         wD5I7HJCdfEf+frYgUHJDBiT4Pp/RHVNOBwzGq0HDrGaQ2koQn7YZoiyBz8xZq+cqWtn
         50M1yQBp3v0IHhHDUFxSyVfYvubwTu0BuqXgrjP0vOPjfqrVbVb1Ds+LyeZ940ZSVS19
         QRPC1hp/sKmOnLmmY9Lej1P+nZgCVMWx2rO1owchggIpr4SlLSS5LmE3l4ngIBgtOjV0
         1rO8Y8d5a7FJRJjqo5jlwT821C4pATNKP7brbhR//N7qiBn8gjIRgAfvTGANDM1QedB0
         bT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788309230; x=1788914030;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JGJWrHOSnyRz2ZQ6Fn4p57X8zqLnhKTqSmyiGGVbUmc=;
        b=gQw/W5l5XWZcsySzyAqbQZ0bHBBTF+Cjzwt2rdHVqFlR86O/NG2tM3Qk79KBsMpnAS
         x1uwWS8MO//OIl5GDJrWn4aaeCosYVwdbEY7T+MuFPKTfuXH5Y3aZ5hW297sUmwQNi4w
         mpvQ9QA5glY6lBoMRz/MLQbRiJE9H1GorrJzDtppbK/+F508sz5hjWRlSV3hApYzyAvT
         aonA4TRDVpQOhIrzSE8hJ3cjqdi0AxZUS92TiBAqVKaUleqSFDwJA+OytCnWSBaRyF/v
         Ii0RCCxhoAd9K0S04FTBo1Yc1icZG9qvkQY75z0Fci5dxmaXXpD8b675Ul8kGSagToaY
         T97g==
X-Forwarded-Encrypted: i=1; AHgh+RoxlwAFayYQlMCu5KlcQ3x0fpTax2X1L5Vg08MTnypQ5BLJezk/+SIftzch3cGxWvAMu2JH8QQ=@vger.kernel.org
X-Gm-Message-State: AFuF++njc6mWbCsgGR0a1nd+dAWISSAnyr96IVgq7I1gd+Omry/yndRt
	2SijqgS482AuBMInidWFbJv8ZtTSnPJKG3njVdTPqGEl7XYxX6Nj3rmRDAdYbSmNeEc+lWsuvSn
	i9cQKJDfTHnScjA==
X-Received: from qknqj7.prod.google.com ([2002:a05:620a:8807:b0:939:44d9:c213])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a184:20b0:92e:9d63:a6f6 with SMTP id af79cd13be357-93960e05252mr130070085a.17.1788309229637;
 Tue, 01 Sep 2026 17:33:49 -0700 (PDT)
Date: Wed,  2 Sep 2026 00:33:36 +0000
In-Reply-To: <20260902003344.1931843-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902003344.1931843-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902003344.1931843-3-edumazet@google.com>
Subject: [PATCH net-next 02/10] atlantic: do not assume mac header is set in aq_ndev_start_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not assume mac header is set in output path.

Use skb_eth_hdr() instead of eth_hdr() to fix the issue.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
index 1da14786fe5cc73234227222569f1f6c8207eeab..d7cbab46a943a87fed7cdd80b22d2542bbf12282 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
@@ -120,7 +120,7 @@ static netdev_tx_t aq_ndev_start_xmit(struct sk_buff *skb, struct net_device *nd
 			      udp_hdr(skb)->dest == htons(PTP_GEN_PORT))))
 			return aq_ptp_xmit(aq_nic, skb);
 
-		if (unlikely(eth_hdr(skb)->h_proto == htons(ETH_P_1588)))
+		if (unlikely(skb_eth_hdr(skb)->h_proto == htons(ETH_P_1588)))
 			return aq_ptp_xmit(aq_nic, skb);
 	}
 #endif
-- 
2.55.0.966.g6673acef38-goog

