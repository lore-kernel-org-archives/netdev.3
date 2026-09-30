Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FFC4A68A2
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812023; cv=none; b=qbbortRCTXCaRK6Lvk1yaEJBcVDnKGxzjS59DGQxnh/njOedGtv2tWTCQo/6a00ld5nTEwfTMWgXgoADYtow9sIcAxwQjMW7deU99V0C1IrxBtRvrInyLPzEUyM3rk93z084F0Iy7D19/ZlAO9P2ppeFPwsUHcGGE7gMOtmHeTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812023; c=relaxed/simple;
	bh=TsKEM23vrGNZP59nClNAGbEF4QPHeuq9r9xlzWpsDi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TO600jZyLUsyUnwjuoWApBn3g7L9dhSUbijVDYZ5+KeD1aU1z5tDJQJ4FrelOPd6MeLH2PNWwNRERaKYu/f2HucaL3o3Y9N7il17FiIQhlNWms4J3vCujy6WIOR9k4swCr55oiD0EwPRwtC/91TrWjsp113wF9Q4o8oCtg1BiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUX1kLeF; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUX1kLeF"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-81be5042c51so4200949a34.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 16:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790812019; x=1791416819; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CKazThAjDvEancv5DllE0t7hYEI/Pi0fz1aTpnksd5Y=;
        b=FUX1kLeFelJ/FZlVzCuvg6arDKp/L41BWts37Udf+dlXucGs0pnjVP48wCPcPfMw7D
         lENgOg67FtmVvvyxvBXyjX1yJa2+itG07uF8HBUrednPzKmaUrHOcb5/DBBQj4UsvUH+
         w0/VuHE0WSaKGLBAfm4dfPD0n9vnBo29pTtTo8xLYxr3uU2vWorffwJ0ZYGAhFwVxjTm
         j9JmFu5z4TMXDPHUYdtIuVqlcZeuk6H7Sioa+ptqm04NDlB1JqRhh6SIlUUOekUJGo5w
         tf6LUaLelZGZRQrTkqfH2Nk6EsKgeq/jfqXMP0dotfFwJIHtK+dR+ynqnWZ6FPNXXqzn
         mycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790812019; x=1791416819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CKazThAjDvEancv5DllE0t7hYEI/Pi0fz1aTpnksd5Y=;
        b=T5+X3gqFfElXTvwmaHtOuzlu9iF5HAn1DRdmCuKY4UUd4F+gRZLjcc2mI8KgYbHunu
         9OkZYHVqIiPUbLw4Z1ZJTqCVGV8sm9xDFgNbLo+Kvf0G+2DAtdMnJO0ay9Y2HHjnYvNn
         RYlE1X1bHnjBSSZGUPUK3FNfkWwwuslgz8+HfP+93ctstwhZzS3rjnNcGrmszYdvIeM/
         MmT9+Is8Fs1B7DkkhRnx8R9ZcGT37eK83FVk1mKDXowm4E+xSe3tYpHS0UQ1O06vySRU
         9ysdZMu+MZh9EX/o6fOz0TIui1+CELxSmhBJ4cmiuYb5FFCQEpjwVxkrmiNSQ+S3ur9E
         v88w==
X-Gm-Message-State: AFuF++l9wqaON2BmgFyXJFNVMlXt2wQVkygt12ObXB2sv/+yxu5GdgOk
	uwYDMLVGi1KEHrz7WrGC2CUh0JZqJe1Xb+FcUKJKjaMFlkYAZ7Qu1Zb4
X-Gm-Gg: AYBFou1oPXk/kMBLbSrb0/kCZGaPPFFU/BOnflEyv8PDNdM1NHLU88J5DtKHdJqMvXE
	uSYHFA5sRk+5G1lA+odkpNXL7PLjha8bx1bFf8TXCTaLOqs26CvdyW3RRsvr97kNX2mW+DkrWFM
	wJmr1bZxCTXsC4vhUyIPU1rV4wFFFJ4ep7EgFwJGgheRbpkYClnEPabZpCCZk564o2cKxmdpTUj
	ddRAOm3WOdJoW9ZCOT2evorr3NJ8tivuHYNpEYqWFQcm+Ux6YOKwYivmcyjJyVA0Uw5YvkDQH6h
	OlJkXuLqaXY5Rn2aB+33w0PDEVXwMkgOrqMpYquHQaeJtRPoy3XJSMCBAAv/K4g6ssdrFuQ7FZ2
	CdcwroxbQXCnfHBxXngp/O9q5u82m3kcLWEpuxTAAJzjXxlt1pswfM3fx++MthcdbQ9sNeFXmEv
	XO9VptNNqK7CkMFkKqV6mwQvUgpWaOa+QQ4OQd9/4i0DzfnqBTtEjzW+FCUb47D2bsl88=
X-Received: by 2002:a05:6830:4110:b0:806:6e79:c7ea with SMTP id 46e09a7af769-82048f1eec7mr4160685a34.6.1790812019674;
        Wed, 30 Sep 2026 16:46:59 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212ae3ed24sm1348726a34.17.2026.09.30.16.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 16:46:58 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Wed, 30 Sep 2026 16:46:48 -0700
Subject: [PATCH net-next v2 3/4] net: psp: drop psp assoc clear in
 sk_clone()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-psp-defeat-v2-3-f266e7447129@gmail.com>
References: <20260930-psp-defeat-v2-0-f266e7447129@gmail.com>
In-Reply-To: <20260930-psp-defeat-v2-0-f266e7447129@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.13.0

Unwind the change from commit 1d2929d0850f ("net: psp: do not inherit
the Rx association on clone"), now that assoc state cannot exist on
listen sockets.

With commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between
ehash and lhash2."), and the change in this series restricting PSP assoc
operations to established sockets, this state should be unreachable.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 2948dffcc3e1..d7ddd365abeb 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2496,7 +2496,7 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
 #endif
 #if IS_ENABLED(CONFIG_INET_PSP)
-	RCU_INIT_POINTER(newsk->psp_assoc, NULL);
+	DEBUG_NET_WARN_ON_ONCE(rcu_access_pointer(sk->psp_assoc));
 #endif
 
 	/* SANITY */

-- 
2.52.0

