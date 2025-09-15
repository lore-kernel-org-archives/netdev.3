Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDBA2F4A17
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928009; cv=none; b=S4tDgZwqdRakW+XitegrFJdiF96LYFJODjU5hfiMcBFQJocm2o9f+CIHsAAkeogJqTK/Fmf2O5Z3KXAb/03CCzKER96+XkMumhDYHlLQnzBo6kN6rE00kebv9nmuk+AXvg2YGzD9YZsTLEPtbXSKfFFLQkkjd+DRmc1VIV4TP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928009; c=relaxed/simple;
	bh=OG51gZ9FT3Yft/f9V80kYaqN15PmBJ964yzj/asMkOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egc03bbNWQslspYsfjOQ05rhUjKqbz2uzwuAWI6JcQ9CTNcIHIi9ghLGfjxfh5lQ6VxEXbnqnmktEG69ccNekvPcbIISEwkX/+DCZnV4I4JskaDrynn4uk4I9ibVPwdk4LscVsnJbJFHY3UQI/5CeJ2h0aFOxNvZeQ8W1pIXH3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEyapuQc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEyapuQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B622C4CEF1;
	Mon, 15 Sep 2025 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757928008;
	bh=OG51gZ9FT3Yft/f9V80kYaqN15PmBJ964yzj/asMkOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JEyapuQc9oYJAANbzY4fksJvlT5c2/oPLpOPj+q8rr626XLsORYP4Cl3Z2qYf6/b4
	 +A0R4HxptcjuxA4pyfLxDyacRpCc29ipxLfa6BtHE1gEQBUt1H4XJz6fO7RnkVn9ub
	 B+lREGXckweEhCTcyUBNsr09LjrIeUMHvgv/Md4zy68wmXpjZie1mQjbrN1LePmcmj
	 3Bhsroj4I11MH9J+CF1e/hFAVDQFIfYelIeeWYssvilDbzGlpJIk62gHFSlQK5wS2w
	 1UFbWT061WXY/OOW0i64Ke1hRDmM/wbH/v9I9rJun6QxtTCEfVAiaRXwgPuoaj2wKc
	 qHaF4JWY/c7oA==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/3] net: ipv4: simplify drop reason handling in ip_rcv_finish_core
Date: Mon, 15 Sep 2025 11:19:55 +0200
Message-ID: <20250915091958.15382-3-atenart@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915091958.15382-1-atenart@kernel.org>
References: <20250915091958.15382-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of setting the drop reason to SKB_DROP_REASON_NOT_SPECIFIED
early and having to reset it each time it is overridden by a function
returned value, just set the drop reason to the expected value before
returning from ip_rcv_finish_core.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/ipv4/ip_input.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 8878e865ddf6..93b8286e526a 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -335,7 +335,6 @@ static int ip_rcv_finish_core(struct net *net,
 			goto drop_error;
 	}
 
-	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (READ_ONCE(net->ipv4.sysctl_ip_early_demux) &&
 	    !skb_dst(skb) &&
 	    !skb->sk &&
@@ -354,7 +353,6 @@ static int ip_rcv_finish_core(struct net *net,
 				drop_reason = udp_v4_early_demux(skb);
 				if (unlikely(drop_reason))
 					goto drop_error;
-				drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
 				/* must reload iph, skb->head might have changed */
 				iph = ip_hdr(skb);
@@ -372,7 +370,6 @@ static int ip_rcv_finish_core(struct net *net,
 						   ip4h_dscp(iph), dev);
 		if (unlikely(drop_reason))
 			goto drop_error;
-		drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	} else {
 		struct in_device *in_dev = __in_dev_get_rcu(dev);
 
@@ -391,8 +388,10 @@ static int ip_rcv_finish_core(struct net *net,
 	}
 #endif
 
-	if (iph->ihl > 5 && ip_rcv_options(skb, dev))
+	if (iph->ihl > 5 && ip_rcv_options(skb, dev)) {
+		drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 		goto drop;
+	}
 
 	rt = skb_rtable(skb);
 	if (rt->rt_type == RTN_MULTICAST) {
-- 
2.51.0

