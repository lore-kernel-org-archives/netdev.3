Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793685236;
	b=QfmQJ3F1uniQrkPO8aNUDi2N3I3lGLlJtL2Vc1usEJ6SKdQcguXzfvTuQXKgyV9ETx/3
	 geVvZVNEYGQB0tTpbCk/xnM0lJQ+bfp8SN1rMGvFpZcg0qi4f23jxCYFVMAZMjKin4Bwm
	 ajSfJUxY0/pG7FaKlzVSo9V+A3gUceLylScLtkhCxkS35Omhep40O+9nV3RGuMOd3dnRg
	 aHes81uevzLbTeHG/CRCXE2RR/uUS/ihXyr3P7O3sYwov4suuv9vzGzNpRbaV4WE2Yp6m
	 6UCfuQrIGf7JjlybfHs/u7Ws0Fx6497EXaFwT0w4oZ/5Mpc+AbkN5aCoz7dbJu1tf6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793685236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=LQOSfvYjsc0pne7U/QqZbr4f9DH/Fqk28lPhlIhBOEA=;
	b=Yxyg0ywv1r9+s1I3HlgTDxzfZtbZBzdbCMMKFu263uBP62gAxjhw3tly8dTBI/3sna0v
	 DY+iUwCB+8fl0DF2kiVtnyQ9pbALDVuocV4JD2S6G6kPsF36hh/k6SUqQvsG+2uaqecwj
	 tQvwaZLXH51828HxYL3UVGpJhIyLVWmxF7lHNyQy67ZjY3FvdIIYoji77QPD5kqjNxa+R
	 VzYsiU7Lh8Hmus4W7v6MMsp5E8GH7ulqXR9WbvY6H5sCZSMx512Mt6EJqry6qRJz0x+Vs
	 xAP/p9uVL+s0xE0NFWLP+XyMBSp4DGLwveDZVMTA2U34TCMIRzwnpNIJKk/EmARY03g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=StFthbsA;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E6E606A32F
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 05:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22E6E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=StFthbsA
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eb362d1f5eso39944295ad.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 21:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793685235; x=1794290035; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQOSfvYjsc0pne7U/QqZbr4f9DH/Fqk28lPhlIhBOEA=;
        b=StFthbsAOp6jdyLITZCeesv53uxGdx7tmGtLXJFplgrKgU6dRrKMf31aKh5NByS080
         ZOxD6LKwIZiR5Fk42GJDFakkKnrBJZAWMGjtRT2y+xdNvyAUiHjcENxUIk4LM/GrR/1l
         chTPZSNddCb07kj3GMXweJSzTRLUzlQRt6I19JPyha71MOsj3hAnhvMT0yLOKGNSFdRW
         S1mqRoQrXlfpI+3YE+odNwJHwKsb8IwbjujPeAs4Qk+RXB6r/XmUNwBYD9H8dDoUsiDc
         D6tOZ+xc1vtUEIQEuTP3Ap2xUIq9vUAp8iPPcuQeO5YORSsE8Gnfaz4+GZXoE2dn2IuD
         M6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793685235; x=1794290035;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LQOSfvYjsc0pne7U/QqZbr4f9DH/Fqk28lPhlIhBOEA=;
        b=XXuctDGZ4ZKATc93WqkvY15aNuyT6Na9ZaXy0GUjkJzdUB1mSfuMMGtor87pntajEE
         urCfGVij2WU2kgJUZ1CmZ+xzwVuUpZXUl38xWy4QOoHVx7tF76NjsdbHCje1NMPwI7b/
         J2qQYSoLQxp6WwxUZ7B4uPtFtyF87vkfOiF5+ZZzp+AbU0fzSJ2DFdl6XJ9bTxje3AyE
         RYssc7bAgBkNBNbD1uT85i893wmqdreW1Kjve6DgdW/l+4l9OvWMDYJPcTc5c4V/TU3D
         Mr6Jl5JbqBL4FX1oT2l1Zd7i7jCvh+ZAyOfk1RQsB43Gq5TJk2mlvT0UcHeErVwlND/Q
         6IOw==
X-Forwarded-Encrypted: i=1; AKwUvBw9T6I+/h5Bx9HglY+TR23ujhk3tYW7ZlFjxtZ/h3cJ+cgHs1eN6zqfnzvUHwDLcfuX4T+97EM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4Zw33wVXh5IHvO1izqnzl5H2MPcwszDS+G3uvNgeKuskDXXFO
	HIxnPGOaZ5KZWYvgBisD+Wkm3TjAGOV8FmYavw0cbtJpbWFl1Pequ1qVEm+b7OZlm1uR9+ojSXr
	GY84iag==
X-Received: from plbmv11.prod.google.com ([2002:a17:903:b8b:b0:2e9:4bb7:2719])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1251:b0:2df:9497:3c89
 with SMTP id d9443c01a7336-2eb36526a09mr102814215ad.59.1793685235115; Mon, 02
 Nov 2026 21:53:55 -0800 (PST)
Date: Tue, 3 Nov 2026 05:53:54 +0000
In-Reply-To: <34f32e63b803f9f7faf0b0a5754219e48a986136.1793616950.git.x-professor@outlook.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <34f32e63b803f9f7faf0b0a5754219e48a986136.1793616950.git.x-professor@outlook.com>
Message-ID: <aulzHJaoSQOWbw_l@google.com>
Subject: Re: [PATCH net] tcp: free saved_syn after an RCU grace period
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Yingjie Wang <x-professor@outlook.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, 02 Nov 2026 10:55:58 +0000, Yingjie Wang wrote:
> tcp_reqsk_record_syn() allocates saved_syn separately from its request
> socket.  bpf_sock_ops_get_syn() can load that pointer while processing a
> retransmitted SYN under RCU.
> 
> There are two ownership transfers which can let another CPU reclaim the
> allocation while such a reader is still using it.
> 
> First, tcp_move_syn() transfers req->saved_syn to a newly created child
> socket.  The child can be closed and tcp_saved_syn_free() can reclaim the
> allocation before a reader of the old request finishes.
> 
> Second, inet_reqsk_clone() shallow-copies request_sock during request
> migration.  The migrated clone becomes the owner after
> reqsk_migrate_reset() clears the old request's pointer, but a reader which
> already loaded the pointer from the old request can still be using it when
> the clone is released.
> 
> Both request and full TCP sockets currently free saved_syn with plain
> kfree().  Embed an rcu_head in struct saved_syn and use kfree_rcu() for
> both teardown paths.

Please add rcu_dereference() in bpf_sock_ops_get_syn()
and RCU_INIT_POINTER() on the writer side.



> This follows commit e3f33b0a1d89 ("ipv4: free
> inet_opt and ireq_opt after an RCU grace period"), which fixed the same
> ownership-transfer pattern for IPv4 options.
> 
> The issue was confirmed with KASAN on v7.3-16007-g36aad21d50d1 using
> temporary kernel instrumentation to widen the reader and request-migration
> window.  KASAN reported a slab-use-after-free read in
> bpf_sock_ops_get_syn(), with the allocation freed by __reqsk_free() from
> reqsk_timer_handler().  The same explicit migration test completed without
> a report with this change.  A patched kernel without the delay
> instrumentation also completed a successful migration and seven saved-SYN
> reads without a KASAN report.
> 
> Full allmodconfig and allyesconfig builds completed with W=1.  Existing
> warnings outside the modified files were made non-fatal with
> KCFLAGS=-Wno-error; the modified files emitted none.

I'd drop this paragraph or move after --- since it does not
add any value after review.

---
pw-bot: cr
