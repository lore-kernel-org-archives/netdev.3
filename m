Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3773C43DA38
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599842; cv=none; b=Xyi4bakYz4jmx/NFlGitX8JtDX0C4BgwtPLFyqwk6TJaHs9+JaINm7vgEH3ozJB885qbnEapJxi7Skb1SRTC2tYT3YdBQWssA4KJwDEamqGNA0YfLdRMVyTmOUjlUwt5HWHE7xn8WQmKQXCvx257XvCHp9Kosc3oIA2ch+VTqYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599842; c=relaxed/simple;
	bh=YXQVrVQ5DmAlnxswTi3z3ON/83E6m36dReiCfihc+gI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AKkYEitOZiRcToyP/aTQ0dq/sRb3fzOIrPj5dW42Yn84Mq61+m1uhJFAzUYlQgsZjET5A4pCVND+AOkak386HedhsDvzlLhaPc0PkOgVbyCdCvgyl9M86Bvk/sd29nGGuIvnsa/fw/alMVbFlCKOzXA+04z+XaYeobZ7DRnRRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/o9ez5J; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/o9ez5J"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d02df2bf09so2527195ad.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789599836; x=1790204636; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmzHMsn4rLdpvn6aC85DE5tEW/DLLQgZvQ56BTyHhNc=;
        b=C/o9ez5Jn2/U2dw+jXQ9H9kz02XZ3NWVQnwuJvIq+zr7iVVKIoiIAK+rJAsuD7EI13
         CRnRIW9z3P4C3MZAGKd5IhEEsStn2KOKY0F0VLALIV4hgP+DlW4PKnmILALuPaoBWFSr
         5ezkAqrisR6K0vwbsQuPsrQMSo0MWbnv5YOPv3ChKmpw2Id2kZY50K9RvWoSo1/DS1Vv
         ZaFL7ogf/Xjlg04n0ESz2gXJ170c0oSE/lDRJPMSAfyCZPZbrcutIPv2hKQfKDRH4et/
         7XdJUbUnQDW0vo2iIMExFLugUOO77HO3f6N/5FZexGW7G9/gDL5lh1619dsGTY3IO3Ef
         2z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789599836; x=1790204636;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmzHMsn4rLdpvn6aC85DE5tEW/DLLQgZvQ56BTyHhNc=;
        b=uUIrYUV0EedjM8ihdGS/au8F9hNVQNcSpFG0+p9YuujWBrjM5YdPwsDK3wziOX/cL2
         dOtq6ssxEFQpAyPqyREK2uRHLWGe912HRen7gXBQFtkpH9AG4ZfKl3cBALZBm5w8xhjk
         wbFdvtjqNJCLPwuz5g1wjPMAB63GY/TsWN+vs9IAK1K0hrZFg6wy0XD2aQPRP60mJJqS
         M2h5OHDhvkfBMij3rzXMnrMdAlKw5m3RQ95uXlYO5rnz97Q1ejprl9W2M2YqiK2eUzut
         qzMrNBIEBmrTzJfkHYsyE1vhUxyTVx2jfVA+FT0gA62h91y6kchXOVuaXqWmhRwPSRiR
         11Aw==
X-Forwarded-Encrypted: i=1; AKwUvByrDT/aFY7wUcYbFtH6JbVoyrCN3hJT7gFNFwsvI0sEON4zN/btu5+88eFxRL/S/ARYPm9bLGk=@vger.kernel.org
X-Gm-Message-State: AFuF++ktuda11CNvwCBa7rRoFZws5z4XWRUjKB/Mwd0xRcxnPmlSy+jJ
	m429KWK1fS29ncsgfNRfJR3iVhXxNtAqfMuohi/XbDyYJO8E9yAjnG682yqP3ujvYbHKIRvUQkU
	bGDHqHw==
X-Received: from plsl18.prod.google.com ([2002:a17:903:2452:b0:2db:36ca:f184])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:228e:b0:2ca:9d5a:8b6c
 with SMTP id d9443c01a7336-2dd8dbf7d83mr94053185ad.5.1789599835702; Wed, 16
 Sep 2026 16:03:55 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:02:20 +0000
In-Reply-To: <20260916230353.367014-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916230353.367014-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916230353.367014-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/6] ip6_gre: Initialise ign->tunnels_wc[0] before register_netdev().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ip6gre_init_net() links the fallback device ip6gre0 to
ign->tunnels_wc[0] after publishing it by register_netdev().

While ip6_gre module is being loaded, there is a small race window.

If ioctl(SIOCADDTUNNEL) is called before ip6gre0 is linked to
the hash table, a new device could be linked to ign->tunnels_wc[0].

Then, the fallback device overwrites ign->tunnels_wc[0], and the new
device will be no longer found by ip6gre_tunnel_lookup(), resulting
in no RX.

Let's link the fallback device before register_netdev().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
day 1 bug since 2012, not worth backporting, but if we want

  Fixes: c12b395a4664 ("gre: Support GRE over IPv6")
---
 net/ipv6/ip6_gre.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 8ebda0b6a78b..183218100d69 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1607,12 +1607,13 @@ static int __net_init ip6gre_init_net(struct net *net)
 	ip6gre_fb_tunnel_init(ign->fb_tunnel_dev);
 	ign->fb_tunnel_dev->rtnl_link_ops = &ip6gre_link_ops;
 
+	rcu_assign_pointer(ign->tunnels_wc[0],
+			   netdev_priv(ign->fb_tunnel_dev));
+
 	err = register_netdev(ign->fb_tunnel_dev);
 	if (err)
 		goto err_reg_dev;
 
-	rcu_assign_pointer(ign->tunnels_wc[0],
-			   netdev_priv(ign->fb_tunnel_dev));
 	return 0;
 
 err_reg_dev:
-- 
2.55.0.1082.g2b9226bbc0-goog

