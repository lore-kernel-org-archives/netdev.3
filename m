Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604177;
	b=CURNMa8LrbpX3A6OX2lhi/6S7MG/XGXXpKT8CdmcYe9OHn/UdNifojDYxVkO3YC084HD
	 KQzXyfT/Kh4VyUX2R5mhsX3UAurbDPUFt+OEhvdZp2Y0WGjv3Tk4tNlShGYijjdmzNQp+
	 RucXan3YfZDW2WxYu8RwFaZ0CFX3lumQrEhgJ82Nhl+kkIQ7eRtV4STZMY5VkzUvZ5XRV
	 UfS2Z7Ck22FftmAVpp6eqDCTh2cMB9YITDv3HSeU2lQQdDxehS16tJ4/ER0JGWERwbXG+
	 MFI1BLmrxGgZl9ts539JLIMaXhlvg01FYjrJRup1Xmiae7SAY3XBpM+3ZC6zo0JLOuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iOc7GMvRx5yq+dlbPNKyqujbMy6NRm7RjZeRF42pKDU=;
	b=l1riz1mTBPBMUz46x9PIq3OshZag08OvXfZH3O4idv3vrEbV+rhhITRZHX2H/vboF7uy
	 mLQMwOJifUwbOXnMwofHhIEoxWa5tTTtwDVGbFN36kZs86ARdu1KnKqvPG0/d2lqoSOoQ
	 ptGmtMYKUv4rvWQRJiainqpGh8PDVXcIWshWQ9aBOS4U1Ipm70FyNsfg8cpCaLlusHaIa
	 VN7h5BBa9RGw/iPmp3jJG+yzoUXgR0SURjcalWBTKb52A2i7iR1JcLxVRyubbxnNvqqig
	 bDX4mpMce2SL/mM1OXiWZhlxuGnsc0ZGoL3WrUk8Qk/UBL2W/yEJucuZSPmkvXXb32w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p29ySwB2;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5742606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5742606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p29ySwB2
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd3310348d2so1478807a12.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604176; x=1794208976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iOc7GMvRx5yq+dlbPNKyqujbMy6NRm7RjZeRF42pKDU=;
        b=p29ySwB2d4ctEFxg6SPwooqVEVkkzgOMqzljXnH+nlOxcvXt6uutwLiOp58Voj7xRb
         Vz3c2XfDqgIPr0lw3Rkwi6wf1IKmOa7F298eHTNbfmAVh87zI3EsGOV8n+Y5JPBX/zeo
         jUnOWV164lUA3obLn2GM+djz8hk2ALpFmz1GA8Jmy5htkwoJB1Ny0cq7eIsRTs9uoJH/
         UT6+XDVPavyak7cL1xRANvwLUSwRZPU77rpZ8wGpn3Zr0bXUvMVqFgAjP4BHkr3WvhkI
         Fax7RdhEaIX7WH85byPkvjjMJYI/PJ7nCFnFnDitb5rqmak00o8hu1VelV5YCLBaXg7A
         KinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604176; x=1794208976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iOc7GMvRx5yq+dlbPNKyqujbMy6NRm7RjZeRF42pKDU=;
        b=wfpUUcwBkpca7N7ZPDjDpJlQ0fBRuR9mxMfcujeFIZM+x8iGLVqr3I6Lpjko36I6LP
         pd7ohzvDKn2xD6YPqP3LCTdo0ZDnphnTnZK5B798VUhIUoa/MCSsU57Q1EWg3NDVtHH+
         b1+S+eBIqDFdwlSdFaCP+QqvfNwvhfjVrAORn9RXrn2I9XpS7upLcxY8ukLlb8Pp4LX3
         ANDoEinxAABYK0id2yCEB6TBlgl7q9fj0VuiiBxQHMcub5bFpf5CBr0s3NwUaK0eKZL8
         EJncpRmf446YN7DXGZ2EnJ2AOCxrKJhOgCSccgU92nQxH2BZPYocIFuJ622e+tbw9/MF
         lcNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYbpGgDZodcVztIavlFyqYZdgtfvo1cH+z602nEx9GE6H0/UysDm+iALs1f61T2AEuEdh0wtU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qtZ8dcYFa5+8p13D1MZ9Rla6OW47IS83LKXGyDK8Nn/w5iBos
	irgSHy3CruJwMjZDqjSG+ebdRMeuHXOIpN+ALELMruWuUpaC1mDRpjMX
X-Gm-Gg: AYBFou2h6gNOVBm9IOisJAhDt8E/osC3cy8n/3bbvAU3oL3FZdFJsBJW9AjrmOfxqZB
	wBmz4g+3pT32sxq+iLvbHgE4Wdc/S+yzhAv4SCt89sjNUmVD1CLAdGjahRuYllEMRnp2SDDtiX8
	kVi4hAJpMQNaREYB/+o8mdcxrs3YrFuMHARAOAy5hnZfstOP+57XbLd03ZPsjy3v5j3XhFDEIxC
	kR2EjbA9B+zhvIM9dSq39AvB2Mv8lanATz47tVwCgm8ImaOd/GbLwnimgj3XgvDvN/om3eepAQk
	Y2eWkegtT0OKHrQiQq/ZxgUNOkRwklbjlJlMW5RwS2icR0diRqNc5jbZ5YWYvPYsnUmYVInrls0
	t/KQOHmBJjbl0JPcknsL4oI+JFvFPxRWET4o0pboN0dMmrhCvsvoAQgfhSWxjFqKe6iodbQxZc4
	unme1oC9mMWCKMSpAo2ZBmzZDBaG++u2DqLBfh1ceJvDQpBBFghVKI8Q9NgjVhA+AekqpDlPbni
	73j9bvRRFTG3lxxHWHqoBqhIcq+eXSDWNX4H2Ay5Z4StzSVPWDjqDr4dRHWZ6LYhy5f/Z9W+g98
	U+220OJkVVopnwVPKd+42xYcC4gTzUzKo2rGpfrr+wDGtScH3HSHNZG5ud3nCwucypGVpG+FJ0X
	XjouiQ33eUzr/7diUj70PgVeiagVbdpcUDnJ8v+Iyf1OyILsI7eLFka2419POV4azEJkw0uRFUw
	==
X-Received: by 2002:a17:90b:5347:b0:3ab:be66:ddd3 with SMTP id 98e67ed59e1d1-3ae897994b7mr5021140a91.32.1793604176024;
        Sun, 01 Nov 2026 23:22:56 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845aa27esm12518065a91.11.2026.11.01.23.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:54 -0800 (PST)
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
Subject: [PATCH bpf v2 15/15] bpf, sockmap: Clear the end mark of elements added by push and pop
Date: Mon,  2 Nov 2026 07:21:12 +0000
Message-ID: <20261102072112.4160195-16-alexei.starovoitov@gmail.com>
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
index 50c0cda778db..d68b52150405 100644
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

