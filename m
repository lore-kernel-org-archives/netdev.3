Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9886639B947
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788022595; cv=none; b=CW0BG40EL18KnOXw9AqqJPSryuL2alroJD7280LWZ4g/aw1ViCO3C+kRplUPyYSJDftrojZBmL3JiHpxZ9GR4wb+c8GMkjKYzjG6NqA1eZbECEMvyMmO35WkkyiVCUotITKHQQNNbfdRXANfkAA8tnl+5L1iqYK4BcNDW6zwYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788022595; c=relaxed/simple;
	bh=1uEW+6SOlAFA8NY9T1gSTaZvUlQQS478fgHHsQ7CsWc=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=RY0CPSBC/sDCS3tKLdiUZD/lUeleGUpCuTF90Cwr4Sgu3O25CJhoIMeaofyIWVXXpkhIucmHpJp6EJwUdoK9tF9CSUkLObtSXIUMYW5a2ynma+POqYljKuhkThO9WW0ZDUy8he3JpVIUxza4ae4V00T4dFPx5uAHMxvYBers6/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=WMuXIup2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="WMuXIup2"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2530cabcf4so323043266b.0
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 09:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1788022592; x=1788627392; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2JHuNFyBqBV7i/n9uU3aIKvff48cRNUPOa5Ukv7rkvQ=;
        b=WMuXIup2SHzZ7f19VvJe+M3YxHZVzuf7+Km+X+tOXymo1rZpPtX0CoxGynXZfGaUk3
         /LIij0c/z8rEDTmW5LH1BQFzngJ/45blucQBaMUJma7iByJHaEC6hXdubjtG90K8vhHZ
         5TYSYUN8KKjJs3ouGQKRpO0a9hLTgj+EjdFv22tdbzjECUUktRoURAojdWSjGP6vQr+R
         gwLdc0Mg49vrKxIHSpWTXdnIh0EwUYSnuzgrKjL2F6ol4o4DR73y1f42D09LBjIhbhbt
         o2neFqpFHl347jgtP/Ikgt4YNVrNz+23WwSK4aKK6JFxzdcI+f+GJcDpNf45p06UzWhA
         kg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788022592; x=1788627392;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2JHuNFyBqBV7i/n9uU3aIKvff48cRNUPOa5Ukv7rkvQ=;
        b=a1yw8Ym/BrmkHzAgmH76Ok74mAr6g5bG2RPxb2FJUBSixpcyXVKHUvM/ti+Lh/zgai
         W5zLzlxzzcb2r0SN4NvS1kmFNAfpXdGEXBkkkLPDhwRD0Y//vCC+RWJP6dHja1hglbxq
         goU9Gwq6FXEB08bJjH/LKpjIq3qgFy9cjp2SC7/5wmJJaV5BOVQHggwIm4nIDyRmgWXe
         VrpWReociU0GG6Rsv/z/wpF5ACvpq4odYa1CuGINjVijEyP7BmPahmLmqYtdwrtcO4IO
         t4wUhsVdV/wWZ3+a6E/XOhL9JSruZDme3LfA2RaXF09GA7AbnAUH4PW35r+r8ixAEGI6
         D68w==
X-Gm-Message-State: AFuF++kwCIDSjJExSJ8K5uut5KeO3XjIbg6f/M7lprF1GIdJQIQA31ba
	jBqz6iPcMImjGMI5bEgcwveAGh5AoBtcUbEwAjt0B8JbucMA70zJerv1sTsFyqjMef+C8iEnJm9
	pFg7QxIj7YA==
X-Gm-Gg: AR+sD12COlCjQWCyKi9vUkeIsD8onhGsBaueCkoTZ4NY/ZWM4HD1amIbkpYUot4GfIG
	qJ0lWnU9D7bOeuU9tPokgH13XV3P+x+P2pLuZTDBXmswZmWY/ED7UkTGHot8nbB8vFr9IqePCfG
	w2SWZ5m6hHVDrFhM1d6kY2ZNPB9o+vhNryfz0FRkhUvS28vTn/kg0joWUvG+t2k/dpldRT1G7El
	Gvul6ebGeGZeYWYsRqU7qmO53m+KCN92H+G8+wFV0/oSYc7aTEvTEKbUYlPBL4z80Q/ZZcuHphd
	pNadyvySGfAwaXUsGGnu2xEuGR2uXKc8pXhOsRc/vgVbJp0OLigrCrWinuBXNQMVNze1FgCeTT2
	pVp0U5E6izmbd9nRPJmaZq68q8hAtp9HMJRZzwCFAgn/vLDpjmQVMT47n4ngcNundTFD8jH2she
	U8yC5Fq2xBGspSNx24ao/Lrvu+IVy/bi1zhdc/l76+x50YtHdb2rNGRU+xR+ieIqQQzAjNdkpGb
	CBtKagiDqFiNAgSN6oN9rnzlPp7HjPD+bmjTxrboW8E4HZrGgnn8BS99L1F8dBuA+wVbXoloeW6
	F8AwuJsa33Qf5wH11PnnoQkxLkc=
X-Received: by 2002:a17:907:ea7:b0:c25:4f7c:8ec5 with SMTP id a640c23a62f3a-c25571fb792mr967095466b.23.1788022591667;
        Sat, 29 Aug 2026 09:56:31 -0700 (PDT)
Received: from smtpclient.apple (83.10.35.35.ipv4.supernova.orange.pl. [83.10.35.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1fa3ddsm210342666b.45.2026.08.29.09.56.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Aug 2026 09:56:30 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net] net: psp: do not inherit the Rx association on clone
Message-Id: <BC10EB92-ABB3-41B2-AB16-266BEEBE18C0@doyensec.com>
Date: Sat, 29 Aug 2026 18:56:18 +0200
Cc: Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Daniel Zahka <daniel.zahka@gmail.com>,
 linux-kernel@vger.kernel.org
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

sk->psp_assoc sits past sk_dontcopy_end, so sock_copy() copies it into
every socket accepted from a listener without taking a reference, while
inet_sock_destruct() puts for every inet socket. psp_twsk_init() does
refcount_inc() for the timewait socket, so a child closing through
TIME_WAIT cancels its own put and leaves the association with one
reference and N timewait sockets holding the same pointer. Closing the
listener frees it, and the timewait timers then put freed memory.

Rejecting the association on a listening socket is not sufficient: a =
socket
can acquire one while established and then be turned back into a =
listener,
because tcp_disconnect() leaves sk->psp_assoc in place.

  BUG: KASAN: slab-use-after-free in psp_twsk_assoc_free+0x6f/0xf0
  Write of size 4 at addr ffff888110f9255c by task swapper/7/0
   psp_twsk_assoc_free+0x6f/0xf0
   inet_twsk_put+0xda/0x1b0
   call_timer_fn+0x53/0x2e0
   __run_timers+0x764/0xa80
  Freed by task 99:
   kfree+0x1a7/0x500
   process_one_work+0x7ec/0x1100

An association carries a per-connection SPI and key, so a child must not
inherit the parent's. Clear it on clone.

Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
Reproducer available on request.

 net/core/sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 1ad41904db25..fa60b7494c58 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2494,6 +2494,9 @@ struct sock *sk_clone(const struct sock *sk, const =
gfp_t priority,
 #ifdef CONFIG_BPF_SYSCALL
 	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
 #endif
+#if IS_ENABLED(CONFIG_INET_PSP)
+	RCU_INIT_POINTER(newsk->psp_assoc, NULL);
+#endif
=20
 	/* SANITY */
 	if (likely(newsk->sk_net_refcnt)) {
--=20
2.55.0

