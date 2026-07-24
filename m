Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341B4423EAC
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889568; cv=none; b=bY5sX5QsAFZxx5a+nFqvMvnQ/MnTbnX+t4KRfKFncP9WCLko0S8NbMrgoRWrjR8R8ppzgSygMzZTLrOR2Z9kW8y5v5Ffe1uokRPQwFsK2miXegFreBaNn8NKcBlIDzZvn10e0gpCT5+E0/+gFyVSu0x7AwFk2HiYTY4bnDP5FBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889568; c=relaxed/simple;
	bh=eKd9pCQK8yq/2taFlLxedEdPHpo601/nz/qzYpE3TWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGuKwMDknysJ+GO4W+jtSPkn6Yjp2epER2XYE9mFvnbXKGZ/38rmkvsSxrlRDm+ST1T4nb1X/orz675CWS2AnMRaSRbBtizDNFxHumv/DrhI5eRL0dJM43MeFWeAdApzGU1ZCeoxqXVbHHsIiEzyuBNJw2wqkQ0bBf82rXj4iQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRpfZyOI; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRpfZyOI"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-664a5193741so33445d50.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 03:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784889562; x=1785494362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N9RSE/2JZSOuvVzl92N/Hvh+oDgfC4zbCGCsJCtj4yw=;
        b=fRpfZyOI9xZogkAs2e+FLw/KFHE6GRjMp8hORrC9BV0aYChO5JwYhtuwYzZK13A4Fq
         FSxdENCJ61EQc+u2QFowdzvbLFLvn+xsvtwVfNZDONGriFO2XOReM6Kbjm7rWIoAmX/q
         vcS+mZQchYEZmVc9sMGPFqjX0kCKwc6bhk9pmM+L0sN0xAOVQFTU1CqLFHAS12Y8IEi8
         Gce23RVayOkKPh+J/kftwSKO+ERkw8o9qvW26sMtakjqFIpj3hnEQ16zKel/plqqXTBQ
         egDd/JRaeDSh59uwvq2+QS8RBkDrXa5yiHi1iVcGL9NyL6z5gm12pq5WDO8lojPxlnCY
         53TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784889562; x=1785494362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N9RSE/2JZSOuvVzl92N/Hvh+oDgfC4zbCGCsJCtj4yw=;
        b=FAl5aosyCiWCnW+Uke38bGAIXR99liRCFdxGaqY8O7S01rFGp/dIzVzej5O3vRYcg+
         6zohL448tp2SdYF0WJqquP3cbgcFiCQpTED1l2NGPwdM3EVfOU9abNKp2cTHh91Qk3Cj
         43lXcc7xzibjASh/Z3swEXr/IsfdfqxqeMdB3t1KDaw0e9Km/leizPGLztz92LGnGIi/
         IN+KD1WMwl7fQcRVAgfuHa1O+QMsdM2r1nY4Ta+c1y0ZmAOgD/svFUYVVKw+q8i8wTGs
         QLHxiXQvH89xooSR7S9YxsA40BbOwKtc+/SqZzQ0pmE3z1VpQ2UBym8nyM9KBM3FkDWW
         T3FQ==
X-Gm-Message-State: AOJu0YzfeQ0WwGJOig9Dk+EP9gJDYdNUW9tS+ONmh8w0AxLc5V48Y9ki
	5n4nZBEW02ZAY9YYEq39pfvqs4JFls3leP/7r9y2LmxXuVdQy6VFZOTB23hFp93m15g=
X-Gm-Gg: AR+sD11YrXKghO86fevQTDOKpRFtJcJGd6fZ03fK2ooFoCXMz3VNsn6gcdMI/dIbKMf
	nfsPxfhS8/q+OngQIIEM8MbeTMswbnTs7IF1ceuqVwRGm6JG0IWkaukp9AJE3du24kH/euH+/w2
	phas+ZcPi9TkM1Qvf7/kgty1N/PVy8URUIgEK8m3zIQieXkfd7GEgjrpxpdtTjb5Nc0l6wsQoXQ
	mvaPZ83HaKWCLtAjVSj6TEUjdFpc6sgtaCdX8TbaMjf+h7GgO5ZpH3J5MEfyghumm1Y5i+OBrGV
	3Y7HQh1cX1EFMmh35ikYmBa5Y0f+QeUmCr/UwWxx0d6YvA1NC1ZV/WBAMnon4l6nkn7BQG2gTP4
	NTUL5wZeAoBL0irQjsM1wxwXVLTTmi6mWBJRI5O5ENZ4pEKYzPoe6xORsvnjZYX8C2GrfpVWv9p
	CFP3IcoDrOx+EMyMh91zbw6H0EMgkryCAcv9MzlM6lMdmTWCzkISwKonx10ISg91nw5nBG
X-Received: by 2002:a53:e18e:0:b0:668:99fe:7ba4 with SMTP id 956f58d0204a3-668b2fe1f2cmr632835d50.0.1784889562290;
        Fri, 24 Jul 2026 03:39:22 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66890521642sm4645770d50.3.2026.07.24.03.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:39:21 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH bpf v4] bpf, sockmap: Fix cork use-after-free in tcp_bpf_sendmsg()
Date: Fri, 24 Jul 2026 18:38:56 +0800
Message-ID: <20260724103856.3399001-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87fr18lmzo.fsf@cloudflare.com>
References: <87fr18lmzo.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_bpf_sendmsg() keeps msg_tx across sk_stream_wait_memory(), which
drops and reacquires the socket lock.  Its error path tries to decide
whether msg_tx names the local temporary message by comparing it with
the current value of psock->cork.

This comparison is unsafe when two threads send on the same socket:

  Thread A                         Thread B
  msg_tx = psock->cork
  sk_msg_alloc() fails
  sk_stream_wait_memory()
    releases the socket lock      acquires the socket lock
                                  completes the cork
                                  psock->cork = NULL
                                  frees the cork
    reacquires the socket lock
  msg_tx != psock->cork
  sk_msg_free(msg_tx)

The stale cork is therefore mistaken for the local temporary message
and freed again.  KASAN reported:

  BUG: KASAN: slab-use-after-free in sk_msg_free+0x49/0x50
  Read of size 4 at addr ffff88810c908800 by task poc/90
  Call Trace:
   sk_msg_free+0x49/0x50
   tcp_bpf_sendmsg+0x14f5/0x1cc0
   __sys_sendto+0x32c/0x3a0
   __x64_sys_sendto+0xdb/0x1b0
  Allocated by task 89:
   __kasan_kmalloc+0x8f/0xa0
   tcp_bpf_sendmsg+0x16b3/0x1cc0
  Freed by task 91:
   __kasan_slab_free+0x43/0x70
   kfree+0x131/0x3c0
   tcp_bpf_sendmsg+0xec3/0x1cc0

msg_tx can only name the stack-local tmp or the shared cork. Check for
tmp directly so a changed psock->cork cannot turn a shared message into
an apparent local one.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---

Changes in v4:
- Use the PATCH bpf prefix.
- Restore the minimal v1 fix, as suggested by Jakub Sitnicki.
- Drop the changes from v2 and v3 for other issues flagged by sashiko.

Please queue this fix for stable kernels affected by the Fixes commit.

Link: https://lore.kernel.org/bpf/87fr18lmzo.fsf%40cloudflare.com/
Link: https://lore.kernel.org/netdev/20260719161630.2901208-1-nicoyip.dev%40gmail.com/ [v1]

 net/ipv4/tcp_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 8e905b50dead..a30475afb6f8 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -604,7 +604,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 wait_for_memory:
 		err = sk_stream_wait_memory(sk, &timeo);
 		if (err) {
-			if (msg_tx && msg_tx != psock->cork)
+			if (msg_tx == &tmp)
 				sk_msg_free(sk, msg_tx);
 			goto out_err;
 		}
-- 
2.43.0

