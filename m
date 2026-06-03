Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE03F54DF
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467649; cv=none; b=FWSVs/TshfU+WsKZPPtB9XcbTcrweXQyqXDZhLVhQQdmaX21VfYDp1uFQgRIrBUZfPTzLHrHFHlctxoCfdmVmIai5uV/9IbJL4Yp8iGMbLp1rKyDshXeecXMR4XNfSF6xrXZ9dUbKI0l5GGJiaZ8MftSzfiG9V2BBdW1u0Cblvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467649; c=relaxed/simple;
	bh=J8vNvcBWArS7JzC7JyIJ9uEPZewiwtj91zjNfgpPEpg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hpj68TyLb5z0m5igGJLp5YWB3T9CiKN0JA4ZQrX2MTisOaYTFPcLzx7vWwHpFqD1dpfCr0dW6mVbY6FmnSfmeh7aUMg0RbutrRUJFHkYG2Tp/UYcrC+1EVz1taVjrzsSzFq3yDIC+gHpEJmbNvZzAZOpcNz6ppua1SQnc/zbFUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=krIfhK2p; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="krIfhK2p"
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-9158e75cbc0so62211485a.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 23:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780467647; x=1781072447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3CChTIGrI/WBodT/UU6vaSXaXM6dZ4Rv4nA/m2PW0rE=;
        b=krIfhK2p6HgSnBXj5A5FQC+fJvrYgJEY61+Ew8hM40MR74s+0qI5AcT2EzlshSGpmm
         eaSLf6aQxgeA+XdkPzFrfWMTmr0xROI94tlfHnIBDlMra6G/ho60o9r3UwFuWn0r4BDM
         ufr+EWq2msAKkz828Luk+lTkI3XuVFXCC+O/JK8fqRAsu/qYlREaVmqfn7SKD6fbm9Ec
         Yu1EVI1HsrhwkNcOzdYSX8EL9u0Pue7V9kopOuRyGTzikfxH2pccbIrZj+f1EII0Kj1t
         tZ5RwZnIaMSoUg5ytanL0ybqVp1v0IRtx3Z+BLVS5fM13FO/kbNJWNQ1dqepRALNSaqZ
         9G3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780467647; x=1781072447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CChTIGrI/WBodT/UU6vaSXaXM6dZ4Rv4nA/m2PW0rE=;
        b=io3xcKYNa9T5IxWTS9HHkXuPMFTRElHbNP0o4+eLeie1OkuKQdhtM+bLl3zTRwmkKx
         72SKhbRBCZ/wnHUiEYd+uIUYkinSwRdHyGrnxdAKOCRcATxF7IoNmm7DxW22Lv/BpWxA
         yfrcPMT2VRGBGY+KuBhQ8XcfvJAdfBv2XSyXawyWF9yNNvo2VzSVA2KfpagjM3hxGVeO
         xHYqrD3c7XIQxSYWx+iX/ZvWeMgrukMTEJhNtmmIEMiQSDPdScyRih8tjyxc1Rdht/H9
         jkWarA5X3V8KFm4T2t/L/fuNvtj7O6GL07DlBFVqfw75GrHPJQVyzGIaqnBYIOIkr1O6
         UvBA==
X-Forwarded-Encrypted: i=1; AFNElJ9jOkKhuJHB1g/IjSvqbdALv6RcnGY9qEbukf2u7viygxe7Gx+6xsBRq5aEFM4ndZrD5yU8ZUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxqlG6K1Gzw06O4Fjh7C6flqpJPvRGL7tYMG4BG/Ub0h5VC8Cj
	ktlkLu1DQh1q+4/QaymHmo05VRAwFsBdJB7iRzKqw8uVDy8bLB57Uwl2iY9pU4aBDuPh8Ef8XsC
	Dkb/ajQl/B5OXiQ==
X-Received: from qkjz6.prod.google.com ([2002:a05:620a:1006:b0:915:70f2:c7ac])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8903:b0:8ef:74c9:daa7 with SMTP id af79cd13be357-9158a65654dmr374018785a.8.1780467646994;
 Tue, 02 Jun 2026 23:20:46 -0700 (PDT)
Date: Wed,  3 Jun 2026 06:20:33 +0000
In-Reply-To: <20260603062043.3911278-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603062043.3911278-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603062043.3911278-2-edumazet@google.com>
Subject: [PATCH v2 net-next 01/11] bridge: add a READ_ONCE() in br_timer_value()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

br_timer_value() can be called locklessly, the expires field
could be changed concurrently.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_stp_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_stp_timer.c b/net/bridge/br_stp_timer.c
index e5d453305381baa34225a144ac99e98f2a62d810..83cc9c6a3943508eb94d20ddc1b7e737a58d7abb 100644
--- a/net/bridge/br_stp_timer.c
+++ b/net/bridge/br_stp_timer.c
@@ -160,5 +160,5 @@ void br_stp_port_timer_init(struct net_bridge_port *p)
 unsigned long br_timer_value(const struct timer_list *timer)
 {
 	return timer_pending(timer)
-		? jiffies_delta_to_clock_t(timer->expires - jiffies) : 0;
+		? jiffies_delta_to_clock_t(READ_ONCE(timer->expires) - jiffies) : 0;
 }
-- 
2.54.0.1013.g208068f2d8-goog

