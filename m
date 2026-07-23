Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC0A479884
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784808419; cv=none; b=sXe3LDkhtP6Gzkd3T19NNg51dI6fLDyJ1xiDb1U2NOBtkD9wuvkTmcjyRzmi8ATWMLsjaQYj8PjCHTk+RNZKFs09tl6eR6axuQ2G780gBkEvT36dPABGIgADx43SdXp5HctAOdAVvYKO00A/+t58/3VsH/M7EwZxzxCstmEUL2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784808419; c=relaxed/simple;
	bh=38yDr9kn42k/wtxHTNwnSYoU0CfJrfwfGUFVoHuyyGg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bcOafUM3qXD1ke4VDE5FhfwEGGEO/OcOXTyVPJD2douWpTJu6vPgq4+l9X2CXvn4Kw/BahMItxfLW6bLmQc+hWBSszi1pNMCeJ5smqFhVh31/RIhoaCUBKMQzSapF4F7EhvqaTdw6S/l+BfhTNmsrPkFNW7bZqTGPGRQ28ylplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iv8oFuFX; arc=none smtp.client-ip=209.85.219.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iv8oFuFX"
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ee593a5a2fso7764886d6.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784808416; x=1785413216; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R7S0qVzqqwGSUiN7+phEFoJwMKSDNBm6JxaSnBXE7w0=;
        b=iv8oFuFX5UnFYzIQh4eJ4YLtc9UXP2EzpJdl6FTf5NR3eJ98MKV362IAoriqx5xASE
         le2R3IaSB3yd5AvNtioLSQaJrM8/1d597nee0Tkt3SwOx5lE8Xi9O8Sm1Vv8sycVkBir
         69bms4d+xBKa0aZLXUr5QnkyrCq67SEojQiZ2FzM1ms5e05l79CQtA6LvRjzAt2xjI2f
         88xaexT7q4gK2yy8e3i+u53k+wDVA6In0be2On/kxquM4h3fGgF363pj9KhNonsNdebO
         mU23wTqkfwTnym4XIdnU80vVaIb5HaxFOgKKs3GxPNo8bSrF0/njhwG8cYtfXHhRvf+S
         mpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784808416; x=1785413216;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R7S0qVzqqwGSUiN7+phEFoJwMKSDNBm6JxaSnBXE7w0=;
        b=pxWLSH6lupE6UV5BEEVOgKtBe4xxI/TPfVggM60lVqgWGBD+bEacq9LuRTS8uBNo09
         xI/0HAyKjAGTsJSlzRHGAz8ykK1diQ5QK5MCFxuajYKp0sDMGiDZMJzkaSHdq5G++cJo
         o07VAqGWUNkEs7zfD0Up/iH7OFQq8bRPfTm6nYRXu6hkSjiDnePHdlc/stGCNNd+YOCH
         des7LTw3We+zoBi7/sdbgjMvaiPonrKHHp7TE1WoQiz6y/ntQooPoSvgEE+dLANVtLjy
         NZ9x0RzurTvGYEnaaJXyvKF2wcU2JridgLrg8KYDZVYTDJQyN4pXj75bhUP7kIhygh/S
         V7Ag==
X-Forwarded-Encrypted: i=1; AHgh+RpCu7iHy0x1ikrcf+1LDBOsuEqekC/ip2geCvjCzs0UW+qpDBMp4VFDkomC29IVvBTnoP6XOZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIXG2iJnGVFFL85+aSrMuBSRHELUmv8Gj7uW7DEGVubo6qosnW
	iE0O2NNcAQqn6F4VJ0bbD5fku/okb96SHLT5p4DrZ5I7NxOcsmYmdpHooDbZND3hqw5Q63QyU7d
	Xjs4uBmj8Jt1Tzg==
X-Received: from qvk3.prod.google.com ([2002:a05:6214:20e3:b0:904:f74d:b55c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:27e2:b0:907:5389:c62c with SMTP id 6a1803df08f44-907cd1b9ademr20143956d6.26.1784808415177;
 Thu, 23 Jul 2026 05:06:55 -0700 (PDT)
Date: Thu, 23 Jul 2026 12:06:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723120654.577578-1-edumazet@google.com>
Subject: [PATCH net] net: ipv4: do not send ICMP Redirect when peer allocation fails
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

When inet_getpeer_v4() fails to allocate a peer entry under memory pressure
or tree size caps, ip_rt_send_redirect() previously fell back to sending an
un-rate-limited ICMP Redirect.

Because ICMP Redirect is not part of the global rate limit mask (sysctl_icmp_ratemask),
sending ICMP Redirects when peer == NULL creates an un-rate-limited ICMP packet storm.

Fix this by failing closed in ip_rt_send_redirect() when peer == NULL.

Fixes: a853c609504e ("inetpeer: do not get a refcount in inet_getpeer()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/route.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3f3de5164d6e5854cae3ebe6fcecbac10fb63418..152d8cb28f65aacee378521e16885c9cf1a4870e 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -892,8 +892,6 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 	peer = inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr, vif);
 	if (!peer) {
 		rcu_read_unlock();
-		icmp_send(skb, ICMP_REDIRECT, ICMP_REDIR_HOST,
-			  rt_nexthop(rt, ip_hdr(skb)->daddr));
 		return;
 	}
 
-- 
2.55.0.229.g6434b31f56-goog

