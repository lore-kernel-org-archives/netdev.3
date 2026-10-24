Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792814232;
	b=i9245c0VJVUsklUk13ZUogP2OOqC6An35jYew8o40cW6TzpZDBfnc4XiEQZrSfSsiR27
	 cECPVrW6EVadYx3SQ0LgNywNlAYOh2AL7NnBZ1bzcYCdsj9MCyizJBIcIAjLY2zTPK0iF
	 RWU27zbOy13HKOOrunK29qk7tFEz1aMEy5zstpsZ6eYGKPHb6/YbuAEMLgde3/CDiqIyj
	 JFOcGa6qjaViQH3F7WmfvZY5Sv9Mb41KqjCP1cC8++nqgS3i/HqxyR4X/PNVeSf41Lc3/
	 uKjs0ir8AOjVswuaCDZgANgcTx99j6qVwzf1NPqLK9vfniS5Z6lgbS47bopBZkIaQqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792814232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=qf2hRKhFhKH70S6KxPnT6SQuFQWB8KH6vcovfBYK69A=;
	b=5TV4vXTaK1p/ncW/pmKFjAZOoNLKYqnbJMx8sn8+w9qXCnpP/DwMiEUEm3RYIbQsUigt
	 DDHiCCjEmVm+zxaB5siPyMAObdyDxPJ98y/qZgYJ+dNb4tLpO5Jem5kyY10RinemO32si
	 sH6i2ru45YI4YA66MTjxFHRewitW+ZjHbtcnORelctpWLPUmbz1Ii3Bvw+NF+qmvYJ3S8
	 B3+QRhxwBMSSQ4aFEDi+8810Gku/IbLcbUYTafN5I7rJoMXv0rGI07BDyHHaibDex7eqs
	 iLmBfbTBguCbZGsvLcCId/TAX6KDmtUxnPc7kXIwU1LPowmsobLdRf2pgQKBAjRKuaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Py9Jmxz7;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B19606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 03:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7B19606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Py9Jmxz7
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso849599a91.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792814231; x=1793419031; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qf2hRKhFhKH70S6KxPnT6SQuFQWB8KH6vcovfBYK69A=;
        b=Py9Jmxz7V8E4vB+2bbuLbiddb4ALSjWJ4Jn1EHjNEItU2bPdw37aJnkI64PkxHX2P1
         Wl9MMxXB4HK0qUVpYORaaUBt9i0XS5WPLPRi3ZWDol5LJVGfDbDiggQxDF6ifeRfvRrd
         oPlij3ckMPQ2QXhnQaUm+MRNjkreGIvEqI869YkeDPS5F3T0kPxvk1+Br6wIhn1ZTcpt
         +TssZRTe9Sr2FHGRblCYaakqkhwFLKvaOeQEb2xx9SUJAGCCYq2dSxpdFndeIEX680ak
         L4m+aGIIb+6PoZGhVUT49DKk0+C5sAy48OHlQSRKZdPLeBN2PbGKmEvEKOb8u8ncxENm
         MhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792814231; x=1793419031;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qf2hRKhFhKH70S6KxPnT6SQuFQWB8KH6vcovfBYK69A=;
        b=sBqVyq+fuUDQTvocycESyX09XkGP+KcthKTqVCrVAFiSpqZ/ojUgwg+WDSPLe4a1lY
         kEc8bS2ddSC02xH3Ld2fvRk/6ZCfeDskJlLycx8rjN45ym9rMvpi1btwt4oRBcdiRjOX
         zghtuBZr34laa+F58Gsv/NZ7l/DrSU57iNLrnopUDgtykUN6+NXdvkPlZ/sw/qN/NiuI
         OKXV7t/L7wDZ+7KGBeDIW3UOZeMvyAC6PdmYUf5zbAsmVJ9lrdz7vD4bGq2UC2aRwMGB
         vt6B6RlQxCVHY0OsJjof8Sk4EYwUTdiEasF2232hiED/uP+JFWPJrZbWA+V8/5EdqpfE
         LueA==
X-Forwarded-Encrypted: i=1; AKwUvBwyp9z8M6Attz9MVAQtZD4txT7EfxlYhyiXZECvGyVminerVqQB1s4KkHKNm0ZDRWPNOXBLAeU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTWiSHAUwcBT3toQQXSO7oITy2OEOcF9M5uxfD7/qj0zqxypvx
	/z8BheeBsmeh+M2SER/TosWGmBhffLD3JKwsIy4djBRCtv27FdTqbrex
X-Gm-Gg: AYBFou3GN7bv0fY7XTTGH+db6X2iAPMMhy0ctC8Mp4vXi1LukuNrSI/Nphxa12+uKLl
	7T4ZStXaGs8E+sJEosxUtyaf9TApXzJ/PMccyFlf7YqlLY1UDKKiB/KkapXgYQatAL6CS1Z6f8K
	e1VefqX/cUoDgCIiDjCJY3Hl/LTugI9HnQ4vjzkDB9FkdYOJLTS7gn5h4urTFsoq9tENEc1Yg5V
	h9rKff1UqWSN/J8vFMC+oRIxDz4UIVy320n7i3J4XGBDdW/puHUAsU2jZXItOQyNgbPoLZKexDV
	stPRljTSk7nNDIah+Xdnn7/bAJu/uGNbBq3C+5BaDZj0agfXmvI8V9/5hjPyGJ0I9mbfNeR8GVe
	u6y/lFAoc9+TrDDwF1SW0ZkiD25Bzylu4YXXr2OdSrOl2VALVR2EICJUQDcAE+4Ls2nTOIFjfS4
	6b02SORDKXD0jDMDMXjUsaSpIcV8Gox0SaYt7fNJS2kDjG/xMWkWMGmt62UR2IBboAL7Cv4sQ2U
	m9XswmlKvzNzPvaw1aynRs8FRMcMkUaschqjKSr2EJ+jhjA3Z8qDBbZTTNThTaq7Z4zHYkriHka
	dGLrHXIUgdQLVye+w87D6W6XHrvGP06unBAhawOFA5Ub2CRYe4tDdrZrmUDb
X-Received: by 2002:a17:90b:280c:b0:3a4:a592:4cfa with SMTP id 98e67ed59e1d1-3adeae6dc11mr937549a91.45.1792814231151;
        Fri, 23 Oct 2026 20:57:11 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebae7f3csm917288a91.3.2026.10.23.20.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 20:57:10 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 Oct 2026 03:57:09 +0000
Message-Id: <DMCRLR5MNV8U.GS7VU9KHKBNG@gmail.com>
Subject: Re: [PATCH net 1/1] tcp_bpf: sync copied_seq after pre-accept data
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Zhiling Zou" <zhilinz@nebusec.ai>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Cc: <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <edumazet@kernel.org>, <ncardwell@google.com>,
 <kuniyu@google.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <horms@kernel.org>, <daniel@iogearbox.net>, <vega@nebusec.ai>,
 <sashiko-bot@kernel.org>
In-Reply-To: <af73f81ba5060272e63bfe3757295fb09f5c6198.1792733621.git.zhilinz@nebusec.ai>
References: <cover.1792733621.git.zhilinz@nebusec.ai> <af73f81ba5060272e63bfe3757295fb09f5c6198.1792733621.git.zhilinz@nebusec.ai>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Oct 22, 2026 at 10:46 PM Zhiling Zou <zhilinz@nebusec.ai> wrote:
> Refresh the local sequence from tcp->copied_seq after tcp_data_ready()
> processes the pre-accept queue. This preserves progress made by the
> sockmap path, including when the receive queue could not be fully drained.

tcp_msg_wait_data() has the same problem.
sk_wait_event() releases the socket lock. A packet arrives, the verdict
prog returns SK_DROP or redirects it to another socket and tcp_eat_skb()
advances copied_seq. The reader wakes up, ingress_msg is empty and

    copied = -EAGAIN;
  out:
    WRITE_ONCE(tcp->copied_seq, seq);

rewinds it. So blocking recv() leaves copied_seq behind without any data
queued before accept(), and tcp_recvmsg_locked() hits the same WARN
after the socket is removed from the map.

The snapshot is the bug. copied_seq changes only under the socket lock.
Just add what was copied to it at the end.
Like this:

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d5fcf3c..d85fdd5 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -227,7 +227,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	struct tcp_sock *tcp;
 	int copied_from_self = 0;
 	int copied = 0;
-	u32 seq;

 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
@@ -241,7 +240,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,

 	lock_sock(sk);
 	tcp = tcp_sk(sk);
-	seq = tcp->copied_seq;
 	/* We may have received data on the sk_receive_queue pre-accept and
 	 * then we can not use read_skb in this context because we haven't
 	 * assigned a sk_socket yet so have no link to the ops. The work-around
@@ -273,11 +271,10 @@ msg_bytes_ready:

 		if (is_fin) {
 			copied = 0;
-			seq++;
+			copied_from_self++;
 			goto out;
 		}
 	}
-	seq += copied_from_self;
 	if (!copied) {
 		long timeo;
 		int data;
@@ -320,7 +317,7 @@ msg_bytes_ready:
 	}
 out:
 	if (!peek)
-		WRITE_ONCE(tcp->copied_seq, seq);
+		WRITE_ONCE(tcp->copied_seq, tcp->copied_seq + copied_from_self);
 	tcp_rcv_space_adjust(sk);
 	if (copied > 0)
 		__tcp_cleanup_rbuf(sk, copied);

> Link: https://sashiko.dev/#/patchset/20260630205043.184894-1-rhkrqnwk98@gmail.com
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260630205043.184894-1-rhkrqnwk98@gmail.com

That's a review of a different series.
Drop these tags.

sockmap fixes go via bpf tree. Pls tag the respin as [PATCH bpf v2].

pw-bot: cr
