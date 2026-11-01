Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560947;
	b=2+WkleTq12hOp2N0ZQvE2TNdmti2Sj/KbOPzDR4XQyjSh4/EJroNlkL6Cii2iqjK0odF
	 GYTR1bQJYZvrcMR310vJ32SRzHgHaZhgAtdBsfexvJivZDvPGFEfzYn0P16MqRgQ2FoGH
	 qMiQK8MuSLgLoLnpYugOaNI/+QJCcY5utWy3cGHiMtrpPUH0CDleUUFwLaJaDhOapS4Gd
	 8aEj3xI/FhmkdICF12b5XiFAl+G+bVMsIn/xySrlXMglvSHTJtciXsbum5d+K4PwqB3Om
	 eQbGDQgFl+756e8Na3jOStgSq61ECyXO27ISpchF8yEuUygLEoq9AHqYicZVIS29T4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pLfQTSZWiMHhpz6dJ4D5IaCGs2afSNTfy0DFwwVYQDQ=;
	b=GI+H20mu64/KGHnq8oa/7bgG4uUJOhv26nTYlf25mJszo2y79Q9J/pXdq6zYf6qelw5q
	 Ha7XN9hpX2DTFi9fFQK6q31S6JNr/med4SWUGcGhBlIboL9tES2KQo3twLj9r//qkCf3x
	 Cb5YW/Ihu2tkurh56mjlG66wExqHFjpK+fbMzCA3RDKTOYf2Y8jBpsjUQd6WqZDfk+gUg
	 sxJRFlDYBFq9tGuLxTFbhvhV/ba6be3EqXDPEjAvSqGC7i4r/RHbW+DcIjlcJNvKVyjvq
	 Ol7xSlmnTV+9LwGgIOfmfi436kq0dvlUKl7QWIjkZ3yW/ZBwTFJWc+WwAWg2MtmR6iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BRV4wo01;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29660A2613
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB29660A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BRV4wo01
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso921366a91.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560946; x=1794165746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pLfQTSZWiMHhpz6dJ4D5IaCGs2afSNTfy0DFwwVYQDQ=;
        b=BRV4wo01yuPFeYbBbTQCbaWIrRZKl+tkEOKn3HueFgegwxzYyUJpokh7V/ty+XSNi0
         Cu6cVLukL+5q3juZ75cSK2YmlzkDGk2q0yFRho0uOICgHqqNsb5e5HU7QGxh9WJfotHX
         HjTMLjDKlqIwf7mOyvk7v4mu30Q9r+zt31M/8pFjFmV2771C1E9m3706YKEs/HbIg5ap
         07eEM9xZay5cuyxrldb6m8Mjzebk3uFp7hSqEePzoTEY8eba1RBTFedSuo7ca5NbWUFP
         nOEsPwpBoejX8urHDVHXsHRDyAY1mKyUvdxwdKY9LTLCwfLUqSofql9ATbql+l5zfLzs
         JfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560946; x=1794165746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pLfQTSZWiMHhpz6dJ4D5IaCGs2afSNTfy0DFwwVYQDQ=;
        b=0aHkEmLcrP2zMKahrpgjUJ/AdU4aNMN1A8T5N2u+kmqrF519vtHOV80MUkaA/U5dDP
         VDeveWOcvbJSkRPGuG1N7dghYxPHcuxwwEuVcRPu2YzfRx4nBTnoQJVySYkS5U22j/4L
         fJ5ry4XtZh6wl93u5q63ZDe7IqeSpMpu4liXS2d3Uzu32ZSEnGF6iAL5vyetgRMtvTF2
         +286FFv+1VJsdp62xhWx5o+NAVivaI0LxLNndrS+VYodw/g8nyQ/q5NZIJ2B5oA92ZDe
         CKQjOIOutDNCs9ncBZUAKgSmexghMHWsaBJyPUE+SFpr0X3EoHAOhimd1mRHFbzmlHdl
         LmGw==
X-Forwarded-Encrypted: i=1; AKwUvBz2HTw7J+ktNoUVz8vo61eN73Y3g+nyXUMvBjsPtDh5BKYUH8n+aakSZswTd2uELXWNJd88pMM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aQMruQdi+W/jYaAKOiUnDcyfrRTcFEjMkIphdZpAJsIdBMcPE
	bdq33QZKI87tZ4/rD3Z9pO/a1zoyHL2H2yff6vkXZii16CFWSW5dBNq7
X-Gm-Gg: AYBFou2fNOitg4RUHKkscD+NYXxE8t1Yw0T8PY44nqIQRHMA7h8SVNjy492TiQCE4Ua
	xNsGDEk5nwUM5mx1GahPzuEW9XuFEjEf12kWVu0mRZvZgaDrdAalbZJ9/Ge+oCCq7NOa8H/zsQL
	GbaHyK9LwNVkID5xe9Xlzsbze9GiYRaXfOSryRQvOTG4GMZ5Pwnb3u5ieNrf+hlzux0jR+vmevs
	4+lxGGuF2TzIqCnKXCiIRElYM+0l3/et30Dnq1DMJZtoqt27InRTZBVDCAjYSWRNNe6H4aTIb7L
	h14jnzhUx8mqKZnAbCauI+QjYlc3p7JokHbSE2EUt5oxCNNLi8cWrmpkFd4zfIva0U7oev5n/vL
	JW2o7TG3gTDir5PIyt3mSDGUABP/ie+UErRyPt55D3Rek3Vo4Wfdb07QBDReqLNmnM4oK+FLINf
	tGa1SrZjRTOzyR3wP6boQZA/UBCHfnF2vGCiGvLxTCuM+W3f3vGur0rF/9/np24i94jSkMmTEVv
	XrdThUlLBZDhGodV2rRH+nnAJIYqXBU9Fy1qrtGCBvE9HPzu/sr1ds5thiXrMH/k8KUk3xcmOCS
	lNf+X4v2ar18pz6NMs74b/pDER1NYwwzKSeAFa19XDjDBZeMcM1I3FigZ3XEZRYw1cXpQeLFzL9
	G9f1qRIJR0dbCXzWK+4NTEh9e8WtFfHua4mWYLs58fF9uklUKu0Nhfc+Gw/aUDmFqqTGxUXN6Pw
	==
X-Received: by 2002:a17:90b:44:b0:3a4:acde:1e3b with SMTP id 98e67ed59e1d1-3ae896f8546mr7005266a91.13.1793560946060;
        Sun, 01 Nov 2026 11:22:26 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e973ac6sm16068213a91.11.2026.11.01.11.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:25 -0800 (PST)
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
Subject: [PATCH bpf 14/15] bpf, sockmap: Keep the rest of the cork after a redirect
Date: Sun,  1 Nov 2026 19:20:56 +0000
Message-ID: <20261101192057.2296489-15-alexei.starovoitov@gmail.com>
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

After bpf_msg_apply_bytes() a verdict can apply to a part of the message.
Then tcp_bpf_send_verdict() sends this part and goes to more_data, and the
sk_msg prog runs on the rest. The SK_REDIRECT branch does not go there if
the message is the cork. It removes the cork from the psock before it
releases the socket lock. After the redirect it frees the cork together
with the rest. Thus the rest is lost, and sendmsg() reports it as sent.

If bytes remain after the redirect, put the cork back into the psock. Then
the prog runs on the rest, as after SK_PASS. If the new verdict is SK_DROP
or the push fails, sendmsg() now returns a smaller value or the error.

msg->cork_bytes keeps its value, thus the rest can stay in the cork. If the
psock has a new cork after lock_sock(), the kernel still frees the rest. If
the redirect of a cork fails, sendmsg() still returns success and frees it.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 9bdcbb0a5998..a9af6be2aadb 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -536,6 +536,14 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 			if (!cork)
 				*copied -= free;
 		}
+		/*
+		 * The verdict was for tosend bytes. The rest goes back, unless
+		 * another thread made a new cork while the lock was released.
+		 */
+		if (cork && msg->sg.size && !psock->cork) {
+			psock->cork = msg;
+			cork = false;
+		}
 		if (cork) {
 			sk_msg_free(sk, msg);
 			kfree(msg);
-- 
2.55.0

