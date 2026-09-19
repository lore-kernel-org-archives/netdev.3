Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA286394EBD
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789854765; cv=none; b=MZuYt2X8YkdvauIspb2x8Mg6RU2e+18VbE9PAHII3hdNmdkaKHEPWA4XqPCTq4e08YXHTwTadyq9egFZliSWiv+IDUhYoVB64WQICDelG32CuSQHNaxI5pHJqs2zfjKJnN45U9izchgltLjv/26jxJS9AurCiPYNQIkvNcZPf84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789854765; c=relaxed/simple;
	bh=BntXNVTAE1crzVQG4zUNy15sf1O1LyXIl22qSy/4NXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQ2y7KQVagmW7mh7q50vOunRNi3HJt3ut6oEeDoVs+kMnjOWllxonWvfZPh6qk2L4oOtCZ3kDtIRYqa/H5bkWLFunETB32D3rLLV+rZpvGTAdoB64Qt0cQGWmUvbr3s5Su+C/uIaajRoWDfmm6kNJcEjOFig4pnp58cRpTOOggQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkOLYO87; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkOLYO87"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469d20963so1202662b3a.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789854757; x=1790459557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/h/iBMsKjYf4gXSNgib/JEQ4/EySf55r7ftrtNb0u6U=;
        b=OkOLYO875xlu1OUviRhPkxZx7TNPu6MWrs91r9X5sCMydAsJ4gt9j8JJJtPUN1fgk4
         BdikYCIqOfqujv18gfGTuQJQaej4BhIu0hU6at6VhmBvmgllkPG8SiwMPAC5tc+re7fH
         auQStbuDHhHkpeh7GXFTtoB+tnhOAbj6SUvzIu3a+SMM48DEcLE15lQMMhn9aW2F69Bf
         8H60ambonw2c0nxfvl3TgR4TUmXoDbb5jFLT1PxZXj3pzVbgUps9t+eo6ORWFELHDwb7
         zhGHPExNpE93A9Xj9zPBN/DWQtreCNe7igIe1/1YKl34yEh+EQb8bibEkmysb2k9BZ15
         lTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789854757; x=1790459557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/h/iBMsKjYf4gXSNgib/JEQ4/EySf55r7ftrtNb0u6U=;
        b=QxDuNquNaECfWRQR75tJkG/lFzHKqcVoR+0K0VdUiyoQpY+lBmsaEZHMm6xzuGxZNm
         oWWqDRPWx7S/wO0u3OxjWWlNPOKWvI/C4VbwmDZWfxyiu2QDrU50XQ8eznGMEsv13Aft
         b/xwrxS4E03Qnmdaba3G4o9pmX/Kn9Ol7robq1c6wW180G/JIv79IBKTzb5pKjknGE5D
         TB5Um1nupBSerQ8/RbJ7vMIAmiHL9iJVJXguYWOJln2MAn71kRoOjhicTq9XVsVbBc9B
         nu0lBw3wSW5bxGMNddyZkUfdRbmM6WAEQ52N1lRjL6g2BGP1l1So/f1GiHAMqAws2H9C
         +nrg==
X-Gm-Message-State: AFuF++k7xuD8TyygULu9NCjuvj30Cq39p/jWxxfOj2iSM/YhEgJzyfLo
	RICcew/z7i8Q1op4Ih0870zssDP30pCFTAe4HmfdimePzZvJgi8f05iih7JGGmN1
X-Gm-Gg: AYBFou2q0q+M2UBunhaUq1P1MTh1Bis9RowtB5VDMd8Pw6Ocg9ue3LjSDyyPsHMo4lg
	DiBa4jxJpRMA1M5r7KrFj1VgaqVibtC+Bb1SZiR7gYKfsGu5HZGP5dXl+XR/ynuIMI+j/Gj66rt
	eULvQEkkT33pmmgse4lKeN29+ZToIReP42F9roi/q4EQWFKxSn0cApXxTw3bXVcM1ow5ovJnOXj
	Y6+EmK3rHM2rB1BgFeK3faI3zw0yv/Hnr1jNIlqWOLaaThjIR0e1QHX84PflKbvjheot6VbJfsJ
	Pf/3BD3/M4dXl7SYyCwTnSZAhhYxc2Bp75EjOuVxFcPG1KslqOB5by6B8Msym6yzAqg2VNbNjs+
	gyg5/hkMNWcbRnDwD3SgYLPF7G8Pl+JChSuunJUnWoQlBkWjxGNtQbv6TvfpwiL2aDXCEM7p+Ms
	6OmEi5Qtm8kLuWNYv+jhm1Rzyzdx3ZojQWmj5bEmDWOQrpb3GJ5Md/2PxB9jVXiUp0RefJOBt1D
	LWfoUvBLKUqGHYsZDhFS8iwTC5iF2l2M1yeDtp9ac516AB8RHtex7KGA3I8AsqUILC2JbAdr1th
	U/DuqTL1DA==
X-Received: by 2002:a05:6a00:ae0c:b0:878:3507:8d69 with SMTP id d2e1a72fcca58-87835078ebfmr2119429b3a.48.1789854757327;
        Sat, 19 Sep 2026 14:52:37 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a94f4ab3sm1339922b3a.23.2026.09.19.14.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:52:36 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tcp: drain out_of_order_queue and update SACKs in tcp_send_rcvq()
Date: Sat, 19 Sep 2026 21:52:36 +0000
Message-ID: <20260919215236.3470714-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When TCP_REPAIR injects data into the receive queue via tcp_send_rcvq() and
advances tp->copied_seq and tp->rcv_nxt, any segments already sitting in
tp->out_of_order_queue that are now covered or contiguous with rcv_nxt are
not coalesced or removed from tp->rx_opt.num_sacks. Drain
out_of_order_queue via tcp_ofo_queue(sk) and update SACK blocks via
tcp_sack_remove(tp) after advancing rcv_nxt in tcp_send_rcvq().

Fixes: 292e8d8c8538 ("tcp: Move rcvq sending to tcp_input.c")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 92bc60716f33..8a7c38a4b1ec 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5589,6 +5589,11 @@ int tcp_send_rcvq(struct sock *sk, struct msghdr *msg, size_t size)
 		WARN_ON_ONCE(fragstolen); /* should not happen */
 		__kfree_skb(skb);
 	}
+	if (!RB_EMPTY_ROOT(&tcp_sk(sk)->out_of_order_queue)) {
+		tcp_ofo_queue(sk);
+		if (tcp_sk(sk)->rx_opt.num_sacks)
+			tcp_sack_remove(tcp_sk(sk));
+	}
 	return size;
 
 err_free:
