Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604150;
	b=wTvb+bsFCRogcUAn0QWannfzjq/o1sIec8f37zGusRydhsJAGTjEyNmVECcKfYwb2L3q
	 2P9cZ9E00OgGuALJzLPuIRR5ePDYNiD8lWnE4H5X0fdJDphpPyqbAa1eDZEu68MJXwzDu
	 ccyy0dBAPOzukbrteSm/MwpMANcj0df+RozA84WYA9tphJWJUX44XoW/9aQXt3YlnRdbd
	 SyVEDtPUgRhQygdfhUMBfjtx5jnOEqKz95Iuad6w1awQJN0UqaIwObenNjagQOr4jTIhv
	 //NUSPWB7j3Df4zctGhe3ThSSlsN0dh3xlZVGsrtb3dOLPITUfGGHgBGTuPNPjIu8bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9Zt7GQo7rKWxtj60oDqSl5MgB+Al+Ojst9KtoXZQtmY=;
	b=ZCCqIdjE1HXeR3N8xbUyIMXIYEbUO5fiyd+k6hbJ6+/2Kjzkq8VjKm1DCx2aqZnahoqK
	 fvPERVReOXxlgv9uqls4c9oFOxdXin1dIWs/e5aAPklFxSoSrzoIgBepcceqD2lL8LV8K
	 a+ZJxPbFacEp26V3uLfNimM5d7nKUpN/TEW/btzbFVwHknVG8HOP5ajloTA3s2uQJZCHN
	 +F68R6dSySq0SyxhnpSs0AObvVVroklvGqJP2QxskEUBHeHKIUfskPXCvtdXblXyDVkaN
	 SjS6k7PRCZphExem0BhLAUcMrh7B5VYOx3hiLMZkh7KmOTu238MVHVJOuz5VETyXQHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DgZwYw2K;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8BA606A32F
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA8BA606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DgZwYw2K
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a070781f63so979719b3a.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604149; x=1794208949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Zt7GQo7rKWxtj60oDqSl5MgB+Al+Ojst9KtoXZQtmY=;
        b=DgZwYw2KbwxGowmlJVT8BaD/23fNgzAst5CdFAGisZiRKr5Pr0NvdqBs3NsjzXYC2F
         MUBGjMpedoXAN70Z7ynkiOhfr0N5nA1GvMBgzGXr4GP5aHFYF5tOySTCIHuJjbMAQ5tI
         zXkB0496ArVjUGKgcdB46i9KL8yTpMSNDcM3Gki9MZg7ycTRYMWpVKbEJP6BBFuEVnQS
         A0piu4Tk/7+9ffaJkYizv3h65HmpSkJLW5COx56yMryhtPE32702meD/84uLGYnlXIkv
         S9BvuOEVsBAOlIcEwgsWgGQPzGKK2KpWtRuFHYipQkkDspdJAaxOcgGMxc9Te8pjX8Vk
         s7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604149; x=1794208949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Zt7GQo7rKWxtj60oDqSl5MgB+Al+Ojst9KtoXZQtmY=;
        b=vDn42DlMWrdPj36F7yZDOCNn4diTdaG1G5k8pDcznO8bGZi58RePGihLjU42MbQ+Qo
         RzswCpkIFKRGQPBJW5CCaG6WWX0v5QOhPuxOFW6i1P2pJgeMQUiZJts7R92AvkOCH/By
         I7+QWnwtsEgqg/uLQAEpVfFCNgOD0Vi6AJAsPbDQZQkJ9wYx+FF8cU4H1xzsIe4GQNlI
         BHv/Z8Y8m/CQJ8o5+BbusRW974YwZIdMLHvSGFJVPs1zoLBDL6T7V4oifiLGZLuEtWPM
         VMToHKVaQ4+A4zJ1nIevgc/mMlWa+ek2ntDVIWVqN/+//J6kzCIsxzBUu01ESWM1A8WS
         ot3w==
X-Forwarded-Encrypted: i=1; AKwUvBxlJtPxSkSjF2icWqlG8nE2CrqlBoK4bhyvkqrY3+AmycRnIliRKI7G1q58SjphRoLxxqaM9Y4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Az1f3sG7H3kI1dQeypv47Deh064lsFtH4+uGobB4jn1wFxUJH
	IEc+3/HABsI4nLXrbceuvU6mqxP3oNtnnq43zRW7hmKF4obTtftjl4cY
X-Gm-Gg: AYBFou0gaiPUm/s2pVN38KKm9+C9RWWxIwt1eRLj6md3shkxiS62Qotrgyhd29DH5U5
	dBu5fviLGBpItTKQxt98JzYrCxTgzTGODHtVwx9J8scYc5AUi0fn1jJD5xsWcEsJZBKYF8B/wat
	DiYaBhaZqMZpMcRu1oLh0L5yCai6cZObsZ/IJUIlsUMNundUd3IENVTD2gerl+iMvyZWaHcqkLk
	z4KJ2VD72qosLEl7LeGzxfPiU89aXST3Dt0SzQaR/1y5OAq3LSix2iDZY1xhprig+CCaBCIOLWr
	dzMJ0mXCgrAn5bkWrvb66pbQK/f90WJi2diYH15ZdSj0GClXJtQAYxMMKXV/vAdA0SFVStdWxtz
	qEWMtzXZd6qGd2cjTeoEh1BZDsyuZeLFOeFbU+AEZB5BtO/+wCoe37X9VzEnHsAO5RPOsQzs1wD
	fdcSLssOrF9eg2VmpK31/7WEbjW+a/uXa94k6vIAu0UQkOddS5uKJ+k5dPQeE3Saofin3/AMk0d
	2abK2nliKKLUAOpZ3xk3ECGcxyDEWplrpRWbrmhAOR0rlEXLwbayok7Pnxs9J0GonG8jCrKZofd
	yAe4Q3g4Txd5PTJ9Cm2lTrj40YsHtoO8PHKJOBdKpgz+tvjtVb5CiYJgYcykBr09T4ex4N8WhcZ
	IMOdee+uaA3wnr70Lztl8h9uUGDJ7DprXQ/1wOxpys+Mgx1DR2yEISx6mYXJYJjk3LpYa5dJGGw
	==
X-Received: by 2002:a05:6a00:a215:b0:882:2195:5a6f with SMTP id d2e1a72fcca58-8a9bf04e229mr7517325b3a.43.1793604148654;
        Sun, 01 Nov 2026 23:22:28 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad7707ed0sm1659597b3a.4.2026.11.01.23.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:28 -0800 (PST)
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
Subject: [PATCH bpf v2 11/15] bpf, sockmap: Don't copy 0 bytes into a full cork
Date: Mon,  2 Nov 2026 07:21:08 +0000
Message-ID: <20261102072112.4160195-12-alexei.starovoitov@gmail.com>
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

From: Chris Mason <mason@kernel.org>

psock->cork is a ring. sk_msg_memcopy_from_iter() writes at sg.curr.
sk_msg_alloc() adds room at sg.end, where a full ring has a spare element.

When only a part of the data fits, tcp_bpf_sendmsg() copies this part and
flushes the cork. If nothing fits, it copies 0 bytes. This copy writes
nothing, but it moves sg.curr to sg.end and returns -ENOSPC. Thus sendmsg()
fails without a flush. sg.curr stays at sg.end, and from there a copy moves
it past the spare element. Then a copy can skip the first new element, and
the peer gets memory that nobody wrote.

Skip the copy when sk_msg_alloc() adds nothing, as tls_sw_sendmsg_locked()
does. This pass of the loop flushes the cork. The flush empties the element
at sg.curr, thus the copy in the next pass starts at the first new element.
Now sendmsg() on a full cork does not fail with ENOSPC. The prog runs on
less data than it wants to cork, as it does when a part fits.

The first Fixes tag is for the -ENOSPC without a flush. The commit in the
second tag added the spare element. Since then sg.curr can move past it.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Fixes: 031097d9e079 ("net: skmsg: fix TLS 1.3 crash with full sk_msg")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d534974c33f8..d8e29b09818c 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -619,8 +619,15 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			copy = msg_tx->sg.size - osize;
 		}
 
-		ret = sk_msg_memcopy_from_iter(sk, &msg->msg_iter, msg_tx,
-					       copy);
+		/*
+		 * copy is 0 if the ring of the cork was full already and its
+		 * last element could not be extended. Flush the cork below,
+		 * and let the next pass take the data.
+		 */
+		ret = 0;
+		if (copy)
+			ret = sk_msg_memcopy_from_iter(sk, &msg->msg_iter,
+						       msg_tx, copy);
 		if (ret < 0) {
 			sk_msg_trim(sk, msg_tx, osize);
 			err = ret;
-- 
2.55.0

