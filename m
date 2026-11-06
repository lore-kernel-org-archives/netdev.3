Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965128;
	b=NpKEiFa0VYrRqWvN2m7dShPjPrPBsvRJxp42P1tu8l4pIjv25/l3GRYrJ26+huljQ5C2
	 p0xipCb4nvOdqaMV2XptUSsw81l4hZz6uayOp7eBop8xALscZ/Qw+FnouSU4Eidp50Qqz
	 GXdBouY8s0S60wA9T4gws0h1960DB0BrHD28+GLsEhYTREQs01rxyrFdMLZrTQ/Ur+wx8
	 6p+D1+Swn26Y634UmxDMM1S++/r8nUUbUD7PydjBqQd6jrd7IANBlU8f/BLwSQnDcEmQN
	 Mr2HfF7vTr/sUx3CXop55ZrGDWkcYUmXz9hOcuhhRUzlu8/tTyTU6OmhZZ3ieO0PTUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965128;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=/jfLHbBsiNk6pHzafuB3Dsviz9dVAGhH/4U+1XXEIc0=;
	b=QWBeJ7Gyc95bSwa1Xspn1+6EesdoLqwU7BkT2ry4fwz3HcNFKGUtyrV1ILCaLHR1yuj1
	 Hjwydlaij9jgLZGC2bCP9RsmhiAnt/t+Q4ME0+lsRNTf00ernkB0PeISu17zkkd4EriuF
	 8m6NpCcJtr3/dHhBaruR6Ugcw7XDx+KY2f9okq46y8/Zo6E0Xkq7kZ2jxUtKZth/Mp4QL
	 BVLOlbaX00OkXZPxwiWG3DSSQik8/IXai88Q0Kss38ZzsGzgUltYE6GnlpXLcBLgJP7Ap
	 jBsbs9TDA2tPRBkiTifImwsyWBCHTfN3htU3bJ9ax+bz1Eke9nPoeCOzclh/WoPFUqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC8606D807
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 11:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8DC8606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67bfdab8f20so284640d50.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 03:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793965126; x=1794569926;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/jfLHbBsiNk6pHzafuB3Dsviz9dVAGhH/4U+1XXEIc0=;
        b=l17WKtfPXXTWoG56CKLc6HH/XUzrJYeWHlV4AsyL0YM4eI60aT4LdTR81K4BLlJJOd
         eBI3GYnjNoFKfTU2Q/0eIO1pMzZ0Yq5wdrQAf+X4cuQEjXZc86gA7fF7udoqn4GKWmdw
         n293pMPRRnSIkhSjVsU3qXhBFQQXMLYE009BYW3FAXm7zk6Bqus2awuUA0L3wT6rIfFl
         8odBlLZ8+pKsf4ai803n4wIdAuLxnfAdyyGmI/BFmHK9OtBU1/fortQXe+oy7JG9S00S
         CgH8MVOUTmhXtNLQlLgL47ip1G7To59DXAeQ8unHre9sBb+ZNtvEr3OcXoZMJ+zh27kN
         uDug==
X-Forwarded-Encrypted: i=1; AL+hErFC91pbTdvghpyTwUOMob9dN46NL15jXWycZ7JnF1CFyvXTw5j7u42/lF5JOWVzw4VhdPXkVns=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CnrJzvowLJGS/hijlabn8uY39m0ptlLX2qFUFzWLjrhfHmsmP
	6KmoGpP9cvbM6jVwHCgTecwUoWVP6Z9AW25ErnR/IyujEKkzpZ3qyEQt
X-Gm-Gg: AYBFou1once+cuYwHdYOZc70kimczn8mo1uTA3woKPlK1LMDGT9px2IVshAtrfnY9PA
	gQKOUl7vHL5wXi1OzXWNvKbiWa8IiZPS6CxOQDJ+P+caM5YwU3xCtw9vIe2kKOyvistIkesE5k/
	um9runPlpy2bqoH4yF6Bx7G0b3NemhkWvQGtQ3rPWzFxKYeLLQ9fiY6UD+FwUuFJI1ou1W0oxGi
	hOtsjDUEnV3ZKHaPH+DVrOUyU3dnYE69RkuxgByqM5n2byPPtyMeAGUGIwngSNGTKJoO30YBbKq
	I5jmWo4vUKgjDrNXjkd3W+v16A78oTBemLuL0jtzLIbQRPA+CfjYNSaQS1LHRq8wdS3zfFOrI0a
	l1w49XyKDrvE2MhBhHOkp5PTxTGvL1ZxqwubWrt+wXjUUPhSmrIRLnSsE6WAHw6cq20AdvPqyIA
	mIxFvFn3UubyeBxzUDRuXZ+dsoXQyYNWY/CAZz/bzOFCIA0tDC+vLUbE5UK2ZjyxoAPOAyM8Drq
	ZocHCGA26n/yC0gHO6O0gU0wLWoFWV5EaMjLGXQwHwAaVfxGinKlOSKUxwHrl4OPw2Nx1EiwKSq
	mZgkAAcdO4hIw2a8VE86y/Bg93SiwSSPyHsu30lH
X-Received: by 2002:a05:690e:b8e:b0:67c:1da0:6bd8 with SMTP id 956f58d0204a3-67c1da07981mr297045d50.68.1793965126563;
        Fri, 06 Nov 2026 03:38:46 -0800 (PST)
Received: from gmail.com ([2a03:2880:24ff:5e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f8221absm16709167b3.27.2026.11.06.03.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:38:45 -0800 (PST)
Date: Fri, 6 Nov 2026 03:38:44 -0800
From: Breno Leitao <leitao@debian.org>
To: kuniyu@google.com, netdev@vger.kernel.org, llvm@lists.linux.dev
Cc: ast@kernel.org, yonghong.song@linux.dev, bpf@vger.kernel.org, 
	kuba@kernel.org, tj@kernel.org
Subject: [BUG] bpf: tcp: bpf_tcp_ops_set_rcvlowat() missing from BTF with
 clang KCSAN
Message-ID: <au27Y9m78_3EH2v1@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

My arm64 KCSAN builds of linux-next fail since next-20261015, because
bpf_tcp_ops_set_rcvlowat() is missing from the vmlinux BTF:

  WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in bpf_tcp_ops_set_rcvlowat_kfunc_set
  WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat
  Failed to generate BTF for vmlinux
  Try to disable CONFIG_DEBUG_INFO_BTF
  make[4]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1

This is clang 22.1.3 and pahole 1.31 (current pahole master behaves the
same), with CONFIG_KCSAN=y, CONFIG_DEBUG_INFO_BTF=y and CONFIG_WERROR=y.
v7.4-rc1 is affected as well. With pahole 1.31, the same config without
KCSAN builds fine.

The kfunc came with 5f549c1e49f3 ("bpf: tcp: Add kfunc to adjust
sk->sk_rcvlowat."), and 201a454df948 ("resolve_btfids: Fix the
--fatal_warnings exit status") made the missing BTF fatal with
CONFIG_WERROR. Without CONFIG_WERROR the kernel builds, but bpf_tcp_ops
is never registered:

  initcall __bpf_tcp_ops_init+0x0/0x70 returned -22 after 302 usecs

This seems similar to pahole behaviour sched_ext hit with a bool
argument, discussed in [2] and worked around in f2f095c87603
("sched_ext: Work around pahole 1.32 dropping
scx_bpf_task_set_lazy_resched() from BTF").

Here the argument is an int that clang reassigns, its location list has
no DW_OP_entry_value, and pahole 1.31 drops it as well, so staying on
pahole 1.31 does not help.

Not reassigning the parameter is a workaround for me, with any pahole: clang
then describes @rcvlowat in w1 from the entry, the kfunc is back in BTF,
and __bpf_tcp_ops_init() returns 0 (tested in virtme):

diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index 2ba73dd6c52cce..1afa6bd7f508ef 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -370,10 +370,9 @@ __bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat,
 	if (moff == offsetof(struct bpf_tcp_ops, dequeue_rcvq))
 		wakeup = true;

-	if (rcvlowat < 0)
-		rcvlowat = INT_MAX;
-
-	return __tcp_set_rcvlowat(sk, rcvlowat, wakeup);
+	/* Reassigning @rcvlowat can make pahole drop this kfunc from BTF. */
+	return __tcp_set_rcvlowat(sk, rcvlowat < 0 ? INT_MAX : rcvlowat,
+				  wakeup);
 }

 __bpf_kfunc_end_defs();

Would this be acceptable?

[1] https://lore.kernel.org/all/DLRKT5MG6W2P.2V1P0QD4GQEKY@gmail.com/
[2] https://lore.kernel.org/all/7c139810be5ffc9764ed4236efc28794@kernel.org/
