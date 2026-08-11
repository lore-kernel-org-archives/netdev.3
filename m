Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B633F58C
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473460; cv=none; b=BjkE05r3OdARKyFvDePaGE+zf8GtNJmHv6trZafRhJ95u5Qoj6ktyb+pK9nuLhfffyLKaiMFLksx+Gh8I4BjgKgYE4YCo2kVQGpd+6c3D7bwvR+d5XHJUL/8TGmAKjD+tYmNRwwQNoW2b5KNKnG/F625E7U+VaCor+W4COJJ8PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473460; c=relaxed/simple;
	bh=C3PQhZjzRkeYwIMqvUvgXBQtk6dt5emCbuG5WgbBFOk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F/JiY27SMnv75UPKu/7HjLd0vyg6I5XcYODOOJ8px+cYna7KDWwSiN92IbCUZx/b2d/fZhVqsVf4hW5ptasSslkFOl61ZkudM4P5iSxLsvpbmTZblK+lOmb4MBhAzospC+tWm11dNeydmYZL0hvxOXj6Rck9uPhP/49FQSNtn5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZebRqYv6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZebRqYv6"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc891373e0so3642375ad.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786473458; x=1787078258; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zl1MeTDKsmvedxhj+cgrM9RwNvqMLWigHdnAJqd3vD0=;
        b=ZebRqYv6aOH1VLbU41yeu1rUSIl3+Cyg2/SAKl92inBsUTWGeOuWzu12IuLnJUzgAK
         FdrBclC+mkbiM0wT2t5TKYtGwB83HVtpjBpWxXG5Hi/ZHx3GHPx8MBHzinQ2NrtavBQF
         rHeOVG/okL7l9nHW6cTomBKPMsqPjdzT68SIFEyieTUmVAmAcY75HkuQuZnMDfluwKle
         GI3VHsdusIwlNU564n+zCGsmud4b1UMoOOhXh6xkWmDjGMMCTB9KxyrFXLRRYbJYDEGO
         lCnIaF8RCQQxcEoxWe3APbJhQI20wf6BG8C7ZmacyPdKFR6oOJzboksIWg/J97mbfHGx
         4n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786473458; x=1787078258;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zl1MeTDKsmvedxhj+cgrM9RwNvqMLWigHdnAJqd3vD0=;
        b=TWy2xrpQJNl3wR+7shFJ+yhq5J6VtoUZNmosCPknEYGHWb9sqQPLnB/3TLkRUm9QiF
         +El2xxCser3OdK/hsUyE1b1RqC7u5t/9marYWpnkLKJ3YPfacag+XHZwR54nMiOdT97D
         UYDSEh5zvr1JLvCgF46tVOPDaFd4qtyUTwyVtQxJZxokS1SUNRbcxV/fklk+4Dygt6oJ
         2WLWsMgEKBCh+OHScbV2S6eIEWqCUTwKxL4UPAE48w6p8rQ85No9N4hukfm5E4kAFi0S
         trX6vQ1SC8cCxCGBo/pZsrLAOiz4Ftw+PK4Q63IAjLIpKRSm7jkM04veln2F65Vr0D3k
         ic2w==
X-Gm-Message-State: AOJu0YwCLsrnmmdCq/XhA16c3ZNYvfpmMre9YAah3rz6yfJ1LJ+sfnn5
	fZP59oIq4rY24hxvPXJHaEHv8wb8Xamd9ZRY+ZmUtX40HFoZs5fuQUib
X-Gm-Gg: AR+sD11P578WlqTFdHVTR/wf+zfcQ5Rso4bgCU7d1kr8CDJD7O9CCW9Vt7jsDMxKIwF
	zQlsdWslI3FzSlDSvWJg1HrRpLa/Xo7XVTn4zmOHFzGt3YTzAolbkkeaG9DbXJLerwVr9XifQKS
	NZ8XYRxJ0THCvmacjpnQ+iHBQ/f1miI8rTEHpMXymGgYJr1YXqC8o6EoRbPYM3+0DepDqNbH8ki
	AEHoF7BCGeghJLuhNKFmPE0nHdm+ou7QJ3YQVoan1C1I2y7hzrbIkAs1r+dB1Ln76U2n61Y9z7y
	r+ch2evcZFtuLwaaomSkpAkI/fgwbahgEFRdfx0twcDqq3iCFku6AmpBiRlioZ0RKu1CNLYzcaY
	iryFf1I3/qmiUk+QqmlBocKGRYHsSbRNpopX0FmLJU4JMb7Us1trPfXT8HVsfIIL8t65Ar2Looc
	7dqE6KErOntVJ/bOVg0E/PaNq1POtS1Oq8D1QcvngzMQ4Ky5sajxHn/JKchPfHRmko6Cmr/lYen
	VfAJN157qcEjRMWjNCq
X-Received: by 2002:a17:902:d2c7:b0:2d3:1411:3888 with SMTP id d9443c01a7336-2d3178d4190mr60583955ad.12.1786473458092;
        Tue, 11 Aug 2026 11:37:38 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315f2d740sm11708805ad.22.2026.08.11.11.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 11:37:37 -0700 (PDT)
Date: Wed, 12 Aug 2026 03:37:33 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, willemb@google.com, fmancera@suse.de
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] tcp: fix use-after-free of the listener's ipv6_pinfo
 after IPV6_ADDRFORM
Message-ID: <antr7RCJAO578ZFW@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

IPV6_ADDRFORM moves an established AF_INET6 TCP socket over to tcp_prot
and ipv4_specific. The socket is still a tcp6_sock though, so ->pinet6
keeps pointing at the ipv6_pinfo inside it and sk_destruct stays the IPv6
one; commit d38afeec26ed ("tcp/udp: Call inet6_destroy_sock() in IPv6
sk->sk_destruct().") relies on that to release the IPv6 state.

Once such a socket is disconnected and listen()ed again, its children are
cloned from an IPv6 parent but allocated from tcp_prot, so they have no
ipv6_pinfo of their own and inherit the listener's ->pinet6 and its IPv6
destructor. The only thing that would fix that up is
tcp_v6_mapped_child_init(), which is not passed to tcp_v4_syn_recv_sock()
on this path. A child accepted from such a listener can outlive it, and
its destructor then runs inet6_cleanup_sock() on the freed listener.

Commit 858d2a4f67ff ("tcp: fix potential race in tcp_v6_syn_recv_sock()")
added opt_child_init for the v4-mapped child; this is the same stale
->pinet6 on the path that never gets it.

Clear the IPv6 fields on the child. The converted listener has to keep
its own, so there is nothing to clear on the IPV6_ADDRFORM side.

Fixes: d38afeec26ed ("tcp/udp: Call inet6_destroy_sock() in IPv6 sk->sk_destruct().")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/tcp_ipv4.c | 6 +++++-
 net/ipv6/af_inet6.c | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7f413f509d7dce..f830b212d38e49 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1730,8 +1730,12 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	sk_setup_caps(newsk, dst);
 
 #if IS_ENABLED(CONFIG_IPV6)
-	if (opt_child_init)
+	if (opt_child_init) {
 		opt_child_init(newsk, sk);
+	} else {
+		newinet->pinet6 = NULL;
+		newinet->ipv6_fl_list = NULL;
+	}
 #endif
 	tcp_ca_openreq_child(newsk, dst);
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 282912a1199992..2090289408c035 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -479,6 +479,9 @@ void inet6_cleanup_sock(struct sock *sk)
 	struct sk_buff *skb;
 	struct ipv6_txoptions *opt;
 
+	if (!np)
+		return;
+
 	/* Release rx options */
 
 	skb = xchg(&np->pktoptions, NULL);
-- 
2.43.0

