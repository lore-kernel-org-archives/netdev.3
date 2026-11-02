Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604130;
	b=w7kAy0pjF6er6aiM5f9n/XLknbetjWWPOpJPxMdB4iUfCue6l1ZKklUcD1cALAqUf6zW
	 M/I6x9I0gz6g6va9D8rC307FOJQzTJztOHsQyDuP/qXTyevbsI82Qy3AX+Zu2wHadtg2q
	 ebK5NlYKDUuLLDV7vWwS4H2AONbQGCi1jNjUtA87OmdjvsPfqDXmYBysKzvVUUDy0VC8o
	 oAMDKBi6ZhJVyl5clcB82Cngdnc1B6SPRQr5bvini+LNypTWxX7mryRuCM8BjPE6B5//x
	 nysZ3/+4QqJbJzANJWxAPlA8daxP7gT9qT48QwvMYv4HqMBhY9chxAXliQBnsgmArIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
	b=s77aTnWv4ysA418klmaaypVdSjcQjrWUs9FpNQo61jLKGeuTaM20NPjecAsi6m6AXTEE
	 CG5PRaHaoYFonUYEIXHg+TK/SzjbSLJITGdATDbDYO1odqMovUptPhYGcPArdAXgYQs4V
	 +PgG0hU+TbbDe81jklwNd/Up3102zVh7BbDNN1CfBeUE7JucdNazTpbfhr1qhlSK3kkoH
	 b7xdwjSqRA2+Tr2Oxb10boHjZd2WY/XxzFaOjOV2OymbekY++5bb3VLeXjyNhbiMSXPDS
	 Chv8a3trm8anexb/6Jkll9Jf+s+1+PvqeqCtePBKyQ2rpaSI6z8AeNXoJ+Scv2kJcrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TelWpy7y;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A887D606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A887D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TelWpy7y
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc758830601so1579893a12.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604129; x=1794208929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
        b=TelWpy7yjpGZcuy+E0mUUJFqN+c92ktLiy04CnEidXILsKmPn/nHJYpRowyDxI8FtH
         z5IBPuyPiumtBCT8j6p/VK23LScmYL501NxkANVkBwXwx+st5cI8deX4sfbweAtl20es
         R/LwUas+PZ5IEDD4uL3BV65qkPCPuUTKL4slV8VWv9/HdV98dVXJdtX3x33WuhMBFdug
         21nfpC6WIdzWrQp4/fzV2L6n1BQdKP9y2jFancUDm8bwxcdOEB0Ct93wv+1ds2lSLBya
         CgL3YUmUJqK+Vudt1bR2IjeDmUA6Ev4H1jzrKkULn5AeF/LvzqkPvOrkZdM1X64eRBf4
         +9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604129; x=1794208929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/uS3MNfywD3Vv+T8KYvUL+u5aHeTIkmuMrEypBwwRc=;
        b=MDcEjcXUR3tFn+Se8rcjthpe73p1QTUmqn7hGMLN1HNuQnUMjCfIKgC3vIeWJzTrBC
         ji6SCPgYQbsLV9mUjh4NfnR2fs++zr9/qAYQCN2zQoHYStKgNiSXulFolzjknh0i/P7t
         UVVtnobTldN0rQQuQ71Dkc0Ji+mar5+gX7KA91kiY/2Gxegb1Z8WpJb9TSfeUBUV6JKp
         wHaGe9Qox06LGInXa3+BtpSHeRnmbZf1Z25R1r5iF/ZWa37wtq0stw3LviXSDUew3HA4
         2ymvdVDDlCEjIh99AwX/PYEAB85RrQndtWHKrw9wVcHhHBXk96fD/NMpIaiZFd/FF1az
         5ZhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpjSMoEx10OKWsWPt32iqRoLbck0/yFu16VizOVFnepdyPUZiRz/2hyhSql0jeYSj+2Evf1Mg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Zg1c8ObwVvG/OhdsGJP3rBG+KBOiprBqA93aQ/RJmGymk5AsE
	JireHn4zKinxvvgW6nrew3bTsFfN9ayxaiaPO2nzR04wG1P1B5l3lRqz
X-Gm-Gg: AYBFou1pIzxFVq0s96cHABn8XIebsaY7r/xwtm4jgsTYEyxCG+rqtxQJ7OVl4l+rqYM
	ihklOLuzpPKhKNItzQEop5qZWDP3gxx21X5+dTqcoCIRVnVxj0F+rEwgZviTFRWe1IdwEAUOvJ9
	pYzrwqAm1Icfarorjal26uNTLlsNkdpc+DckCCDw4iI6M5UWY2SRoSeXlJcp8dpc0Hic9GrP++F
	c7X2nW89PpsbK6yAQ/KDKHe6exUQB65uPQ6o3Fvpi9Yifq1tg79eEUYf3yW1XqtCiarEB6briQA
	GV9vIh5dIGgtLGOhCiruAPufKdEmpFXroOps9FW0ipyVefb2RW4YQRt6OMWnr5jHtVRtpDhlWtw
	iHZbbLCU14ABBz058atqjZsFpvAmO33M2hmtYM7+7FFv5X/AP6OVZsne/iJcpDLsIjVlVJtDr6+
	/H0ux90zgiyanntxXH9wYamTou+iniaEmSxou/iDDa2Yj3iGHlKECG6WMx5vj8xGevC+oUNyZm9
	I1MathotEiEtMME9dUkB5WuZeJ0zLratVgMyKrDGxEo+zvBZufgFV2tfNIF2uzffjHi1j/ayrT8
	jjPTqbMDGSkXKDE1qcVnj8m5ZCcm/TrfMvoW+gP/sMYoqdbOLSye1N4qgMldWjRuTaR4k1TPdU4
	U3igW+9s2JFym2Ggx/rbkCgq3Y/uCIMqJbw72TYmYQWD6ckDJja9mPbPwCZT9q8nTGbfM8zow/T
	w=
X-Received: by 2002:a17:90b:53c7:b0:3a4:77b8:1770 with SMTP id 98e67ed59e1d1-3ae897c7747mr7453233a91.15.1793604129139;
        Sun, 01 Nov 2026 23:22:09 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845ae5b9sm13043295a91.12.2026.11.01.23.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:08 -0800 (PST)
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
Subject: [PATCH bpf v2 08/15] net: Leave sk_stream_wait_memory() once the socket is dead
Date: Mon,  2 Nov 2026 07:21:05 +0000
Message-ID: <20261102072112.4160195-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
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

