Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604144;
	b=HQfX/y3p7MlxrbloJbsO75t7JsN9+qw+qu+hZDKldog5lPKq/SEc1yQJAvx22hspTwh+
	 Yno9avE6OuauYI6Pr0WuHnkLUyr646AKPNOlU1BLYq8crf+AQH/Po452UvOVrcpVtkd4y
	 PzQCLUmQkEHRagCm53PN//CKXFQfey3IXy2/AsqSQnYnuFPsGpVJVI4TCCfSMpIapsLn0
	 EQT96UtvkTYg3DPlZiE/B0FphZYbXz+NkrVJCRSsWrbtoqd6aODP6QpmA3/0oR31gr2vR
	 WWDMUIainE6zqhVcQlM1dH7qAuU9Ti2nkwR/Yu6DBMvUWHuABrP+ryRMR8b8RlCzKmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iBcyIy0xL+PHZYTiuLv6mXl5Ptne15lxX+AY37+XXm4=;
	b=T5i/el82+la9IF4EUP8M2gw5VoThWfMUlTZ984R/vE1Lf5k+kpgBSSGM/LRgBmr5EmM1
	 fGksdGQPzAkuOLORZWe7wnOMHWnAxG0DOHpOmC7shg/es/Nif9Tp4eQvT+i+9RqIjG1nl
	 cTt+hcnG76Tz5cPRyQwy7HrVI6gCRNUC+5zjjlJcRe8Cy+hbi965HGr+LB5HqFPq+L3zT
	 nKrugPupy85cGLKwxT6U2LkEn78a/X45KHI/krU6tBqQPf1fHLEGRad+6rcupF/Vrb+ya
	 Uk1K6HNVSLTPf6wwDDtAZHySClaBvQyK57plW79waqGnKHInauT0HHWkRx1T52mdyrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cEa2+q7B;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25095606A32D
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25095606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cEa2+q7B
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so1064483a12.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604142; x=1794208942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iBcyIy0xL+PHZYTiuLv6mXl5Ptne15lxX+AY37+XXm4=;
        b=cEa2+q7BHmYZLs9Dym7mrKX74T/THo0PnIG9tTN+NwJ53QgDy6Jd9kRHf2jzQeEqEJ
         vYizGvnaMj4AoUwTmCuZh+1TaMDXYS4Czrdl5Yz5pkLhYZoW0v/sDftaOaEEPGdzfUrT
         y2BSaFao+6BPo8oTHBRkzWmzXiHQ+7aFncAxZB5R6/r0P4KuD+WEj7NkvbRJmcd2XKxh
         BRtIXcccnz/sEzolmXLGHskKp0Twbaq9NsbxumWXxlq9iLbJw8ktBT7tvgZOJFLA2Gea
         R+X1qPxuXPOUW7FPxnlE1uhrr4lUEwNwrJ6yJ4vsqvBZ91eFTW6LfxNme2Mj7JvimIbH
         RZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604142; x=1794208942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iBcyIy0xL+PHZYTiuLv6mXl5Ptne15lxX+AY37+XXm4=;
        b=NQZVAlg3IyTI2/JVRQmVpWqGygNfDK5bg/FKy07gHUO2OI+tow3cRKJ97q8nHYgO7j
         utxJa3EWhbFj8zMq/BvGoDH7De7HXa35MwzaonkkYINeJf+GIFjAwAds8oWq4WqKl3BJ
         nYvsNoEeihmtIpYnb2m06l4SjLvOdYqy34czozYMpB0c3JwbpB3qzFWQsqbkj4pUZ3Zp
         IdE0n9MJI908h/dm+DN+u9yJfpjpkAGfeF2hMRiO8zdKXqT8iynhHB1+UfuKbhZ8ZXgw
         WkiqgxysLlEh+Gx2szHHTn7AdoZ9aUqKVcxwSQ0Kxo/nt5FKr5O8ianxCBp7gq75zzmw
         fstA==
X-Forwarded-Encrypted: i=1; AKwUvBwvNOVcWgRqVztesMeFo/EuAlqKklVMDfVOmdOIJ5Sw/neqJCEUgSZiKxTituiZK7TWV1gALEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvjr/FeCZpRmc+9OVkj+Ou77eLhJzGGxA/DM6VpVhEh9yFf2Uc
	ACfVhfyQLSOpMB31OSuCKst77YLn59N2fb4D5wKleRN+szxO8k4qG8CL
X-Gm-Gg: AYBFou0qNubwXhzq7lUWsF1vX1A/9BnYXzoIMDeKrVSIQZ87T5UPrGqqENVZNNgcDbx
	vZQ+auEgsY7tS4DoauNZE3roEtsFlNddRe2s1R+EY1H+E6yN1WTn5rnkcLnIwOn6mleewaKLnQG
	QKsPeKRn3GkNbTLSjX9SwQevQF/lpmmhm9df9v0xU9ZHLwynCUY+OjVJOQcrYq/830FIRje667E
	gekgKDXf3z+CIksATDUCozK9wfJ5U+6RNf4F2mu6dHVjA0ugax/mXGEn2B9eM9V/NBA7b7N1Ycn
	bSpjWS4TbC5UngULOhIdU0Gz2d9LZusKYG5IH6AUdGtw+IRN9bqAQYDSgqt/UIeT1T5WG0uPybu
	SXDlr7GlQ6/TIJYy2evJsHKoaoBmLI01GWMfUnqlkHjzf1EQTYm8kDI6GZr9tItRFPtxjwnji0o
	Xk3IAbkfIkOFXDiSbdFNE8GSX4DrpoVH9CKi7u4rdKiqL4+hsC1ehXz4lrCysYx1dx8erBeuryv
	UBKTc4elf/EI9FlG0yKG71P7rwTHJ31iAv6CyRhXdx8Fv0lt38H9gLHcMCUcJcgyy0xqdMOW2Yj
	5DLmN4LwVXqEu9ZAy7qElTR2PN1JQ0OlEeSSaAd4DGmsyWYbFqCUG5ynE5+SIKorwWr4lS52dIc
	eiFkFQoQoI+sdfBRxTMhJw//dtSNh1gtIbTvmajDdXwZMun7N92pfeu22ARqxYbvUd7pD8PbQeA
	==
X-Received: by 2002:a05:6a21:1644:b0:3e2:4350:152c with SMTP id adf61e73a8af0-3e928b8ad69mr8141975637.4.1793604142251;
        Sun, 01 Nov 2026 23:22:22 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096b4bcdsm2756194a12.5.2026.11.01.23.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:21 -0800 (PST)
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
Subject: [PATCH bpf v2 10/15] bpf, sockmap: Reset the copy position when corking
Date: Mon,  2 Nov 2026 07:21:07 +0000
Message-ID: <20261102072112.4160195-11-alexei.starovoitov@gmail.com>
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

sk_msg_memcopy_from_iter() writes to the copy position: byte sg.copybreak
after the offset of element sg.curr. Both tcp_bpf_push() and sk_msg_xfer()
remove bytes from the front of an element. They increase its offset, but
they do not change sg.copybreak when the element is sg.curr.

tcp_bpf_send_verdict() can send a part of a message and keep the rest as
the cork. tcp_bpf_sendmsg() appends new data to it. If sk_msg_alloc() then
extends element sg.curr, the peer can get memory that nobody wrote:

  old offset    offset    end of data     offset + sg.copybreak
  | removed     | rest    | not written   | new data

Move sk_msg_reset_curr() from filter.c to skmsg.h. Call it when a message
becomes the cork, as the helpers that change a message do. It sets the copy
position to the end of the data. Without removed bytes it changes nothing.

Fixes: 91843d540a13 ("bpf: sockmap, add msg_cork_bytes() helper")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/skmsg.h | 19 +++++++++++++++++++
 net/core/filter.c     | 14 --------------
 net/ipv4/tcp_bpf.c    |  5 +++++
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index d5e35f24738d..f0e27b4b929f 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -196,6 +196,25 @@ static inline void sk_msg_init(struct sk_msg *msg)
 	sg_init_marker(msg->sg.data, NR_MSG_FRAG_IDS);
 }
 
+/*
+ * sk_msg_memcopy_from_iter() writes to byte sg.copybreak of element sg.curr,
+ * counted from the offset of that element. Point both past the last byte of
+ * the message, after something other than a copy has changed its elements.
+ */
+static inline void sk_msg_reset_curr(struct sk_msg *msg)
+{
+	if (!msg->sg.size) {
+		msg->sg.curr = msg->sg.start;
+		msg->sg.copybreak = 0;
+	} else {
+		u32 i = msg->sg.end;
+
+		sk_msg_iter_var_prev(i);
+		msg->sg.curr = i;
+		msg->sg.copybreak = msg->sg.data[i].length;
+	}
+}
+
 static inline void sk_msg_xfer(struct sk_msg *dst, struct sk_msg *src,
 			       int which, u32 size)
 {
diff --git a/net/core/filter.c b/net/core/filter.c
index 9245009d9f1e..50c0cda778db 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2677,20 +2677,6 @@ BPF_CALL_2(bpf_msg_cork_bytes, struct sk_msg *, msg, u32, bytes)
 	return 0;
 }
 
-static void sk_msg_reset_curr(struct sk_msg *msg)
-{
-	if (!msg->sg.size) {
-		msg->sg.curr = msg->sg.start;
-		msg->sg.copybreak = 0;
-	} else {
-		u32 i = msg->sg.end;
-
-		sk_msg_iter_var_prev(i);
-		msg->sg.curr = i;
-		msg->sg.copybreak = msg->sg.data[i].length;
-	}
-}
-
 static bool sk_msg_elem_is_copy(const struct sk_msg *msg, u32 i)
 {
 	return test_bit(i, msg->sg.copy);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 3d703f1517d8..d534974c33f8 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -469,6 +469,11 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 				return -ENOMEM;
 			}
 		}
+		/*
+		 * A push or a redirect may have taken bytes off the front of
+		 * element sg.curr. The next sendmsg() appends to the cork.
+		 */
+		sk_msg_reset_curr(msg);
 		memcpy(psock->cork, msg, sizeof(*msg));
 		return 0;
 	}
-- 
2.55.0

