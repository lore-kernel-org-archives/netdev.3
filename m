Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560910;
	b=eMYRazpAVv4x1sWQrRdBGzOp+bKTQiagU4vi0gjezUiAIuTciAqR/ky5++eOBc6lutl2
	 8GqN1rcBs+a1Apsc6te8+kJ5qluGB1aPhQRv1eQN35QujhzKvO2VHyDzvUpP55g8fr9+K
	 sOS9FkWTzP1JC/p1i/dJUUvx8qa9e58fja8efzDCm9qk1mNMp9eMcBdHJ2ct6f8Nv4Ug6
	 QQeQw2BDXKzG6qq8yBfYU02FQRJFiksei4R6sqnalxc+INbm+4k6PJVFskHUvs6rKi++u
	 ANnqQmrD6l2idEvl5Iykj1ixzEfd1e3xl2RLg0nMz7QUhmeBQL14JnUiWyGihG5Cl6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
	b=tYsyAzN10obtJBpMWIE1WAQ8DyT067KwSewrau11SbtYuXvwAoC3iCaQKf7rUXq6BwOf
	 dNoWhSmfssGTs7VAtLqjRMKL+Npc6UndziHCKVZxvQ6sMAzIzwQRKXARB9UaeWwAiuC43
	 Ug1Z7R2bzgo3vLZMITQ4kMkv1zavS0rvg1tZm6MPIMIM9Uc9IZlbE/ZIztqBoJOBkElet
	 fcd/Achkg1zQb7TRiCguKMKE5L/fxycACv4wopzll86BbuE7tbfy/abXcEtmM+od3PmBc
	 uL3H6Sypf2mJR9gacGWvaJpjVg9GCfMlOCNN9oxoh2/lZwGnui/HhZUzNwhD69kEX7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=huBau9VF;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E9606A32E
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 832E9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=huBau9VF
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so320658a12.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560910; x=1794165710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
        b=huBau9VFx3baoQw7ZWb9BSHofqTRsVq2Mr9yK9PQ3ZMt5ZFNDqOnGz6llDw7S8hWZY
         s74SzHLpyXpMNVyyhbv6ExfwNJvLLyyw/SlOmWpUIJggb4Fn0xx63b9JoYu0e/zEasei
         FLg0wW4ecO/RU0DfTLbGc9OexWFOj84kLoIErjfzww7zq+NCtGeKMKDcJegv2zlpa9bv
         5O5EhTUAeqeb7fXn8HDRSUrqab0xv760y2xlFV4J6p5E1kcdxvHmdyjSmNqt657W6fih
         V+BQCSo671L2Xy/GussTTonaaX8KFYX4TrB3ZAfNRpliXL+kvSD4tvqo1r4BfSf9fZW9
         tOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560910; x=1794165710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
        b=YeIgalYJpfImTmHjOPRYLGO9JeCETt/Uab0YC+49wHmQqd2QTG60TN7hOd6vmQo7Ck
         SL+4dOJXZRlZmtYZ31aJFCK1MWQnVsIE4mt8fKgcSguv77KD1jEzU2VH+7Yb/YHkPkPt
         fWP6wJ1X+PLDE3AbVE506/ZNRolui1XSb/8XMn2C0xa+wtY1CI0b7H/5PFSmyQiYVtru
         ++/0DQ/ii6X4JJo7+2+FVWVahN/DR5hhJUFSVLMqqBxv7u6RY1BGLRgFLBP+14ENxhoJ
         kPTBvSQhK2izgcrkyAt91k4//QrgEaKaeAI2BJqKKAfNgyhEEOXw8BdckiXlJtdisYAt
         6h+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzrj8KuxbcdTHdOP95f5uur3bmvdN0gmXVU4PcDNZ7YJNCZsRIEHMsrCsL1L4XbFiDGsuPJ0MY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cEDvpe5Guhbzy7ViHt0Pjcwjftww4RsF+PmgAbTTeghPtpyFA
	K6/s0x3ZAHxuY5Mm5lYFZcTOPSm9azJEWH+n9WRCaXZ4LJTAbvFsAIrd
X-Gm-Gg: AYBFou3Pz0UTdGGP83rBHw87fbLiIuQKR59Q8VjU6+045acTJ2HSpV3fG2xblckiKv2
	3HgWvR2mdVYZYbHdKVuAGfG74CvWWXF8rlw48g2JPyY5PwtD2+/vMho7RaetmsZukjhzI+8h0t1
	LUMB3+pv7OH6z+9di79rhCoBNh3bPjaaXZoUUgerbkkKUwEMBpgjs3fkRR5tM4VSevKKJ05EqrV
	T2tOhh7aa/WJLOcMZKu9EC0rLoTDT34llbta4buizL5PPGh561cGykCK+eIJRLBmtQOSNgUZ16W
	ZP0gxIXrMiXCpBWCrVpIMyQDNXjdEUQB78P2ej/eMjd6nASFsIMZAtmdEHRPIZVzIeC4fG2IuGL
	fXVJqZ+nDuxxn0L0Eu6XcKDlxsAFHaJuZUJaqH0E7s6F/K436jw1KQwAhGIQbPxhjyDSNSuAJkt
	auzOEfucRslxpVOH/HRZytZ1hvOF3zrCpjFJbnEpBHCWu2TnqFfn9C585kiX3GONSueyy/qIB2Z
	NKVlIF22IPTLf2i6YNr+e6IzF5DD9j0VVTKMiWJs1528fpD5VCN3/BJUTdEyXGrf2cvxe3iT5aE
	F1MXkquKEhs0e7GTLTv1JpLlxuidojjVAoBfYBLk9noVERJvJ6dBKTdQ8HRWKMQaHasgdwUM8+9
	fxRQq41cZ7swt/PWWY6eTBUtP54S3eZTm6/Hfi7PBhj3nR+NTjhORRW1NS8+WyocElS+GGUiVuw
	==
X-Received: by 2002:a17:90b:2745:b0:3ad:544f:81e9 with SMTP id 98e67ed59e1d1-3ae8977685cmr6101064a91.15.1793560909716;
        Sun, 01 Nov 2026 11:21:49 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aec233ba08sm1097664a91.0.2026.11.01.11.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:49 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf 08/15] net: Leave sk_stream_wait_memory() once the socket is dead
Date: Sun,  1 Nov 2026 19:20:50 +0000
Message-ID: <20261101192057.2296489-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

When an sk_msg prog redirects data to the egress of another socket, the
sender calls tcp_sendmsg_locked() on that socket. The sender holds a
reference to the sock, but not to its file. Thus __tcp_close() can call
sock_orphan() while the sender sleeps in sk_stream_wait_memory().
sock_orphan() sets SOCK_DEAD and sets sk_wq to NULL.

After the sleep the loop continues and does not test SOCK_DEAD. The
subsequent sk_set_bit() can dereference the NULL sk_wq. The tests of sk_err
and sk_shutdown do not always stop the sender. sock_error() clears sk_err,
and __tcp_close() can call tcp_disconnect(), which clears sk_shutdown. The
sender then adds data to the write queue of the dead socket, and
inet_sock_destruct() warns.

Leave the loop with -EPIPE when the socket is dead after the sleep. The
function already tests SOCK_DEAD before remove_wait_queue() for the same
reason. A caller that has the socket open never sees SOCK_DEAD.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/stream.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/stream.c b/net/core/stream.c
index cb255e2a3a5d..334124d683a7 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -150,7 +150,11 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 				    (sk_stream_memory_free(sk) && !vm_wait),
 				    &wait);
 		sk->sk_write_pending--;
-		if (ret < 0)
+		/*
+		 * A sender which sockmap has redirected to sk does not keep it
+		 * open. A dead socket has no sk_wq.
+		 */
+		if (ret < 0 || sock_flag(sk, SOCK_DEAD))
 			goto do_error;
 
 		if (vm_wait) {
-- 
2.55.0

