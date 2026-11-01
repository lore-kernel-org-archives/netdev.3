Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560953;
	b=ig9QoCX19zfIaQZjDT4z9Yz4/ycBdxx7hZZ7A5nAHgPdHN9/9pB2zW1EMIJH9ESC/hPs
	 hLYn3ZGx7oYL1XxxhmIghoxdw87loXK9bLdLss2/6pveL61dgb/Bcf9v5N5QMCxioz7cB
	 1WZXFtDqWLbWwusfyy+wDlBSnZCZXJ2Zt4CH2RfcOLGRpaWS1he1KwcfhLXQ9Be/DCvHh
	 NRSaPdvYWjm5CXAfSve463iSvx4dWdXjrw/gbx/O/vTT2SH5Cozo4bgsU8f/d3ltM8y9O
	 vPODWCi9N/wWgFomhemuEJNIcYkQHgKD5YXjiod/x1DmoE+TCVnhb6WnznbDd7+LYQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GRlJOwLDEqVYeEwYcHpzUEpdYNzizl6/DkuHhzPzoUQ=;
	b=omjzEsKOdpqP9rT+JaEe5c6ZY2DotWoD3TIFmDxF1QwTwrxQZxV6qo5u00VlPMVYDIKm
	 ybQL5B6oeDp/jbDwSvYcONsLEnQbL92g1BmtpBXraI8FwEHXgh6pELbX9y6Ca371y7lDZ
	 ETTVJ/KhHJAmWFXMDM2rUj8rdJF3zp3HJqCCRak/mrrgZl6/tva+vjysbZPdBsWUjjOWV
	 QKnHPxCufshNaHXlQUf8T4/yDQUDfDNwthAomCjU/XngPWVK1N3Sg635JHBiix4N+TnpK
	 ZiL6HlWsr4wzgIkB+y/eJ93bJUQwrhB4AbTjzvws+3BJzxuBX04RJZzrtUR5SazQy3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LyCU49Os;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC360A260C
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCDC360A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LyCU49Os
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2eb0f1b592bso7572005ad.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560952; x=1794165752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GRlJOwLDEqVYeEwYcHpzUEpdYNzizl6/DkuHhzPzoUQ=;
        b=LyCU49OsXXghrC1HRlyul7GdfItx/Hp8Jh2It9Y7ylMBJ6qBOpIvVsfk/Nbvsw+SkE
         Qba8vYChTaNVtDg9TuvrX+qUH3q8BT0JBZzybomIHnTnHDSFHXq/vys2PmPN8tffa5rC
         kGxQMzVsqHj8fINaHEfeSyytrZ/TVbOzR3I6apPPVGOQf9lhUnsI4kXeknQH7hoLjcVY
         ylWfrNIiJLJO+jInVnJDxKf2hQqVP3DEMKvQ2UOQDAkiAnqvLLS98FD0JA+gGY7URN7Y
         c0gdpiztz5OA7LCj47CBGVwRfpRXA8Yt7UoFM8nfViPbKx4sdk4zlITWtKtM/6DDbM8Z
         LC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560952; x=1794165752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GRlJOwLDEqVYeEwYcHpzUEpdYNzizl6/DkuHhzPzoUQ=;
        b=YvWM2yuwn2be8nNinxl59WtDTDFB6lFJlZzB+2aeEc7e1JS/Vs+vlptid6j8ATHWZs
         l3dJE6gXn2wmtbgF2GzDYEn9tv21ZTWpIrFXHKOYbDacbjB9bM+piiyYTR/53XEImI8t
         E8lcjYbvv46g+TlzMu+N31oI7p3jR2dJR52hYVmo4/YEBaPHABPgh2iBNE/R3Zw8qihS
         /ecQ5glJ3Yl/xhtDktR3QZ+zjxRt70x3LojP6/HugFat4FqjdFAkE0nPre3IIgMIydZ9
         ciBbpBL8IlORPIaUm/rhuz7/S6MaUqjiJXqrHTeHsvl8bf5/yBBdNBObJLw0axlnMUaq
         vN+w==
X-Forwarded-Encrypted: i=1; AKwUvByJbW63kk5zX6ya4w5OnY/WnsMPt957ma6/MMuOAyWFakmCyM9svQIzYrPNChhHfrqo7pfWsxU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IqyMWLwtuSkOHXNzwTQZrvzFVpVMGordifA6wJjaPXxLf3nDG
	hkWICvAfgbWjaUgbeqizrnMZZoR3DwWgE4qAXPyV2433zGC9QU64YcRN
X-Gm-Gg: AYBFou2GPbKf8bkFnHI0UqREk+MyAPe7lFfwpeH+geIyhOG0rYcYpZWaNNU/eG87yzG
	iQBoypD5e1AUpSYPrOln8+qdads1Q3FGtcEKPiPqmDPz/0UULU0U8PdiKXfpuxzaQ9+b75Bhm2c
	vy7sC3ePNtEAxww68BCgfzWKR0/f/zAH2HimjDTtkPDsE+8SGIjr6EWB8RygSzll2FvpwB1ppD4
	UWaTKuGVnrJdIIDab/ulPGvD0BYR6pprym5nOxsBAZlcdPN0s2+uc3mCmH7ORG24MygLRKMHQtO
	DYnIB9JaOzkQfZJfDcfc74/KVeOPB0y002mC1A3aw8xtmmNQBt/FPfUpZBG1BL6HPqAhoLQKxsS
	0WC6GoQuF11/XmZ1YMzTWHsmNYK+cMS/WHH8h3qGJAp5BoSZF1dN8D8v8rbBYgeJb1USUKG6Ucg
	8TtsqrvJFW+jC07DvjidABWl/cAchAC1QYeJ6wdTxm/4OrziwW7F5a0vlI01SShYtzoNaHi+iaP
	XmkbnqKqrYTxsCMSZE2qy/sRzV8K5N1TcHdnUAYrHvv1ABrzsqzTQ/7U3sWudjZPGRW/qzJ58lW
	EJmsN0yoBUoSJER2FJuigYxoLW6h7NnkEEa+818Zz/47UBeABfSFz0iR5DmwSPx7uPBjX83+pt5
	YWTJ12r9sNh4rzucKp3KglrB0AZNjiK7Qi3BjCjD7fcKPJSwfUtM4grK9MeghalcgBpFjQx9d5w
	==
X-Received: by 2002:a17:90b:58e3:b0:3a8:545a:9e87 with SMTP id 98e67ed59e1d1-3ae897cc9f0mr6175910a91.15.1793560952122;
        Sun, 01 Nov 2026 11:22:32 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9426ffsm15652012a91.7.2026.11.01.11.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:31 -0800 (PST)
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
Subject: [PATCH bpf 15/15] bpf, sockmap: Clear the end mark of elements added by push and pop
Date: Sun,  1 Nov 2026 19:20:57 +0000
Message-ID: <20261101192057.2296489-16-alexei.starovoitov@gmail.com>
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

The elements of an sk_msg are in a ring of scatterlist slots. A free slot
can have the end mark, because sk_msg_init() marks the last slot of the
ring. Also, sg_init_table() in tcp_bpf_push() marks each emptied slot. Thus
sk_msg_alloc() and sk_msg_page_add() clear the mark of a new element.

bpf_msg_push_data() and bpf_msg_pop_data() fill a free slot with
sg_set_page(), which keeps the mark. Then the sk_msg can have an end mark
before its last element. bpf_tcp_ingress() copies the mark. Since the
commit below, __sk_msg_recvmsg() stops at the mark and frees the sk_msg.
The data after the mark is lost, and its pages and memory charge leak.

Clear the mark after the two sg_set_page() calls that can fill a free slot.
A free slot keeps its mark, as today. tcp_bpf_push() does not read the
mark, thus SK_PASS and egress redirect do not change.

Fixes: 9974d37ea75f ("skmsg: Fix invalid last sg check in sk_msg_recvmsg()")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index e187e3c27999..d7b364e43b4f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2995,6 +2995,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	msg->sg.size += len;
 	sk_msg_clear_elem_copy(msg, new);
 	sg_set_page(&msg->sg.data[new], page, len + copy, 0);
+	/* A free slot can have the end mark */
+	sg_unmark_end(&msg->sg.data[new]);
 	if (rsge.length) {
 		get_page(sg_page(&rsge));
 		sk_msg_iter_var_next(new);
@@ -3128,6 +3130,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				sg_set_page(nsge,
 					    sg_page(sge),
 					    b, sge->offset + pop + a);
+				sg_unmark_end(nsge);
 				sk_msg_set_elem_copy(msg, i, sge_copy);
 			} else {
 				struct page *page, *orig;
-- 
2.55.0

