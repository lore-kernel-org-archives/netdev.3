Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB771AF4E9
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 05:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791437391; cv=none; b=kWG9CUh4EmyoLDObME67YhXm6H7W8sFHkJatuOb4j2OLskc4WgJ2NoWWzWGTKdu3LjvutwMASIznwGB48iwrwlGrv9f/Y7KfpZhMIkDIOtRTdqVaMkaidBarox/SsJNFd+1F2pEuP1BrUGQPUqrVluC4zPsUvAmaJGsRZ45MpHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791437391; c=relaxed/simple;
	bh=/5UFvdGu+OHYF/gq3sfGR7CGH984AqlEKoEyR9gRllI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+LT0o2vMMoxZDnjLqkYP52d7dBbqD/Emdj0u9p4iEtFT9Rr8ymS1Q8eLZadw+Z5pqnNWZwDArWEr6Z78aROscVwxIlb8kO2Oo5AE6WlC17nyIDbUNCUOh71dMGvmAZGBRY/ELJSIYfTcPvYXlnE7mrb2/eti7SafO3Rk3CXBaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cx2POZGW; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx2POZGW"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3aacde0cc0fso223093a91.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 22:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791437390; x=1792042190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hGoxhrVVZ8PQS4Uszm5/WMaB7d9N6tEh6N4uLXjChtk=;
        b=cx2POZGW4juE5ZREcHGfS9DFLnqJdjwDAFri2IGuU12/suTgZyF+ULheLf/KL7+RCz
         FbDGJoAo/CMYCjXO49fNDq+YeswQiwxofhZrf033XFLo+s88bos/CntbkVyuEaOpFgM7
         UW9mPgsai+7dzd4Gjy104M1Y4Ri3DtgUrM/iu1er9MNfHDQJmb+IS6pa8RW/oQz2+jrB
         vC/BBFuQKgHxL8FGaCRBewPV4RejuZBhXPenYar5/NYsUVe9oDDofbjv7RSkyoQcvOHj
         fsoUk2qWoGJgy0HuniT0eIGTrZxV+H4yvORfbl3ubgPM6e1dGWaDdZk1BXTUzKJaYNp4
         CEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791437390; x=1792042190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hGoxhrVVZ8PQS4Uszm5/WMaB7d9N6tEh6N4uLXjChtk=;
        b=GOgLprBtN4b9+T+C4gs2d3k1yVkfR+vqxQv7H7FaIoIKJwPBusbFUA/1Ecyq9Zjjys
         DgsOqyshONOuefFkcliiCHbKgRQp/eIGtYCjUTmRxwUqDdqPyqoe3xiMUxKWZPZQ9qmy
         v3gKhDFuCd79VXpa/iBacjDSsNm/px7jPppf1XXw5aPGCBuSdtWLZZmsuSRjbGUjTExA
         /azuYRk1uvaha0Sb2Gcg99ONhIttvybNACAOelOXQnO5SVnY4s84RmoOVWKBJ2oDYm58
         9T+rKa/1fa8eCBiClNYIfeNAaYl+j75O9Tow2AsMwDuZpiJIawHSqAcJ8mJymjDvg+T2
         asAA==
X-Forwarded-Encrypted: i=1; AKwUvByNL23IDvdUO5lX8SeqshvltcAZHHru89rdZw7gB6gAVc7fgAj02s+/8V8rQKEwU4q7XMvyVfY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbbf/3Sa8JV5Xpc9TNx6LmlmNWjkGJZ5z5lTWsukPj48Zg1gIJ
	brBE6KtXxqnUKgnntON2wr5dFnE3T1Tc1QTBmLGJsgXncW44E7YckxJOeNMf2/Hz
X-Gm-Gg: AYBFou0aceVCllz+W3Z5ocs/oXJ2K8Sv44FE0T5HAJIjpmnWaJVGDm7LtcCevA0M1bP
	/h6Lub1WVSrJGvYEDDc+shR060s0Lg4k+kDPV8LOEAOrCU4IJcYLqcNu3g05E9rtQpy13UpI7Es
	F/3Nsl6nX3N0i6yXqa6lDhQT5VjiiSp8yByvQdt4zyfzIF75OjtPNSroWunFzH/TXkGwA898XxD
	lw8jUGQG9ziWSSrKISYWsdqevxoZDfUHEZ8/v2cjbxkLH8Xz74UOWrJZlhiB6GEKSzF0ixI5v2d
	rB67bnfl2q6CXnopd676PptNk4AQAm7/1oOXO+fCVMPigep1WCYVFaqh++Bl4pfNhicmc5QMyEr
	1wJxRMoI5YonPIhrnff/85RspfYg9xeebGOsUhW29bgeSDayvbp5ex6B3eQM4g5/Iaa+qaYPsjd
	sdGgu92nofaLFM2uz/CBwBAYZS3P6r+gCM2bw3EUszW8qLnZ5IL1lZxUeiixYPY/evLORdzDh8f
	Uy07R/NUIg=
X-Received: by 2002:a17:90b:3b4a:b0:3a4:adf9:5d38 with SMTP id 98e67ed59e1d1-3a89f674ce1mr3395846a91.4.1791437389813;
        Wed, 07 Oct 2026 22:29:49 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89dcc4e04sm3758223a91.1.2026.10.07.22.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 22:29:49 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Amit Cohen <amcohen@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net v2 2/2] ipv6: do not warn on route notification size race
Date: Thu,  8 Oct 2026 14:29:23 +0900
Message-ID: <4012604727e5ba80b69ccd4d08796511397ddaef.1791423190.git.4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791423190.git.4ncienth@gmail.com>
References: <cover.1791423190.git.4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fib6_info_hw_flags_set() sizes the skb with rt6_nlmsg_size() and later
fills it with rt6_fill_node().  With nexthop compatibility mode enabled,
a concurrent replacement can grow the group between these independent
snapshots.  rt6_fill_node() can then legitimately return -EMSGSIZE, so
the warning does not prove a sizing bug.

Remove the warning.  The existing error path still frees the skb and
reports the error to listeners.

Fixes: 907eea486888 ("net: ipv6: Emit notification when fib hardware flags are changed")
Reported-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/netdev/20261007114003.GA1011260@shredder/
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/ipv6/route.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 153ce16628c1e1..a5e955e56e794f 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6509,8 +6509,6 @@ void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
 	err = rt6_fill_node(net, skb, f6i, NULL, NULL, NULL, 0, RTM_NEWROUTE, 0,
 			    0, 0, RT_DEL_REASON_UNSPEC);
 	if (err < 0) {
-		/* -EMSGSIZE implies BUG in rt6_nlmsg_size() */
-		WARN_ON(err == -EMSGSIZE);
 		kfree_skb(skb);
 		goto errout;
 	}
-- 
2.55.0

