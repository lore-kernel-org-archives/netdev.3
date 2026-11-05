Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909608;
	b=laIqJpMAEa7+4UfiR8crjRvEjSmRaKCqkyfN4CLER3v7XvPVpk0mMZhE+lTIKz8Dw83k
	 UBK5ySLSuMo/xvj/IOXt/4MZoA63MPL4wg0AfRXB2RBugyE3jhu6iOySTXXzg9b6vi726
	 FA3h3S4Pj/S06pzLsV6IjpTdR+eyUf7pzetW1GLogr+8MdM39NVAzUMJptN0yB08F9Hlm
	 Nlhs9FGHc1hhTFKeOGQ0xC81zsKMpjZ8+Cv7T+qELXGAdkweBMOTTbVFA+sG3J2zcrjUx
	 XzkCdzVvR/l0b6x3HICouurIHvYWHMTBSTRp4dmtFX1SgQYH1/cq97VcEu5vzY25N+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HQDzoOOgeqS9vfCo3nmNhqUW8QBy2UVieL22lloPtLU=;
	b=FK80ob0q7FI8HJCd60UzZzKFnjpHMCn6ojq9ioKw8oGdby3sJ/QPtflDpiQzE46I1Rnq
	 SZWzOMaM+AJdlTeon1vPTpAEOewmcqM3I+8Y0Ws9Dhgwqxj7Ru9Maeuo/YgwbPMenwb/Z
	 z6hdIKd9sDk+yZyWe7qh/tG/CdXxCic+ctwIyKU2Lx6VdORAH2CAEWXOcQixMJooElCpy
	 VlsWV++UKlAvUQQr38G0Z8XLWL/vpXRXzhCJfXwM+GfjYwbM3fNgphC3Pxu80KnD50wom
	 4+468WQVsIZmlauMnwG9aQLHcYkW6KHJZp37d0WHGXmXt4R6r9tbx9+WH73l2gfp+qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B5icUa3+;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216D4606A32D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 20:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 216D4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B5icUa3+
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3744058eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 12:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793909607; x=1794514407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HQDzoOOgeqS9vfCo3nmNhqUW8QBy2UVieL22lloPtLU=;
        b=B5icUa3+EzgK/0r/NY6rupyUN6VZefrHF49Fnimi1kfT5rulnO1bMQN6s6BitpgZH9
         WUzmEUhnUMrIlQKUVfQ39q39LbQVChV1+lWhAMUevca7BqravH0ToApOxOhPgZ//SSgx
         499etZca2kX3WL/pBzebN6HwV7fYKRkjztj41C0uhWcyngZJwd+9i7aGknlLzy11aq5q
         x8v7wGXIcIfmodG2WjTE2DaPlJTPZlANXcV9U9z4a994HjJAMmfwSGh8PWZLaS3WntwM
         m7uSS9j57IzpJpS8bXX/8RwcqPuGVTIhPZwQvv4VKGX+KOko46+AK0eC77AyqnPDTs9X
         I1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909607; x=1794514407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HQDzoOOgeqS9vfCo3nmNhqUW8QBy2UVieL22lloPtLU=;
        b=2m2ycarSbd5k3JnUprE3xjgEtChyR2SRF7rF74DNSZhLBbiFgg+KnBYJQeWmxonRaB
         rCcvNUoErT2oZ4f8n6TVTAJzAyrPItC6GKLoMWjjTSwgqnKVrc11542RQ9tazu2UnPfV
         pazmp7alQKnGJkwVt8JVQeVg0EgPK8NGcCK04kxij5hY094eT2UACOYlNVCOrb2EQnBO
         lGokZRdW7GjetJzRexFHO1N7vAv0odYS2EKrnOUnhp4GH6IjcpbzEw6QJOypyKGh1zqr
         3A2FQR6w+ti3mEYEamytGjiYb3r/3+mfVK5LT6Jfr9Gv5qE/JWMskg2pJP2i7Mjmmsr+
         sPzA==
X-Gm-Message-State: APuU4Z9Vr8OitamdJxZLiVhfyse6Qj8y8DZGeACk+CTRpjzbzI1XbS6I
	ZfoFAuMTg16/uhPiHXjht70QKvHxDmG0bsdiTsQ7SKXOQvZzzDRRrbrv5elXkTZC
X-Gm-Gg: AYBFou17mhY1WTeH1uPh9Gx2IIjo4eCapYrRvdlAgDtEJNMx1SHLx9Vpae5yDo5MPiX
	2mf04+HJ4VtZDVi7pX7aqRXdgP/IldLvF3++CJqMdcnrzfAogQ50/7jPXeQ5X9Rmu5mSNhHmK3o
	FZEiXffLmn7J3CKflj+UN/okTBih9PU+NnweDCUL7mUK6AMGZjap5dUmI9OYtAIC2ZRe+sJa6+M
	AjudrW1oL44zTCle0Zvang99RLLxK4qRfNJqPmgtUPdgGCLA3ZjCr1eyT46Jv+j/UqhKcaepGnu
	wcMdMw0sRjT+OdybGlkUjKkwpG2R72BbnnCBJEwchBsgK3AXDjHC2QC7glyl0kv4Sgazo7TnN1m
	iwd+D0AHAcvjCfalzcbHrmxEGvWxZM6nYT0EPgXW8Ri6jP2Sb3cWprlnXFferOZGr7/QENSgUS2
	E/4LjVjsF9GviAXYTO0RlrPoLgw3PvgW0Jkg3VtN+0bMNntfI0kl7y1E9Ai6RBTUZUbC2ysNQKl
	tiqIYLJeOJ7fLdwKCA51kBsRzIIcRd5yIxRj/b1ZeKeJxYzBH8RL4ly3/kNhiZqCIJi9QDUfC7l
	2sFps3IrcxeqtwNqOqxygBf03mqCQbI=
X-Received: by 2002:a05:7300:c8c2:b0:36e:b3e6:ebe7 with SMTP id 5a478bee46e88-36f76326a0emr261352eec.26.1793909606868;
        Thu, 05 Nov 2026 12:13:26 -0800 (PST)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f722ed312sm590869eec.19.2026.11.05.12.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:13:26 -0800 (PST)
From: Matt Vollrath <tactii@gmail.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Justin Iurman <justin.iurman@gmail.com>,
	Alexander Aring <aahringo@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Subject: [PATCH net-next 3/4] ipv6: rpl: keep transport header after SRH insertion
Date: Thu,  5 Nov 2026 15:13:08 -0500
Message-ID: <20261105201309.3182307-4-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105201309.3182307-1-tactii@gmail.com>
References: <20261105201309.3182307-1-tactii@gmail.com>
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

rpl_do_srh_inline() leaves transport_header at the inserted RPL SRH,
although the L4 header has not moved. GSO length checks then read the
SRH as TCP, and since commit 7fb4c1967011 ("net: pull headers in
qdisc_pkt_len_segs_init()"), a bogus doff below 5 there makes
__dev_queue_xmit() drop each GSO packet of the flow as SKB_BAD_GSO.

In rpl_output(), restore transport_header from its distance to the end
of the packet, which the insertion does not change. rpl_input() keeps it
at the SRH, where local input parses extension headers from.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
transport_header has pointed at the inserted SRH since commit
a7a29f9c361f ("net: ipv6: add rpl sr tunnel"), where qdisc length
accounting and ndo_features_check() read it.
---
 net/ipv6/rpl_iptunnel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 4e10adcd70e8..0556bb989041 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -206,6 +206,7 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
 	struct rpl_lwt *rlwt;
+	int tail_len = -1;
 	int err;
 
 	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
@@ -214,10 +215,16 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	dst = dst_cache_get(&rlwt->cache);
 	local_bh_enable();
 
+	if (skb_transport_header_was_set(skb))
+		tail_len = skb->len - skb_transport_offset(skb);
+
 	err = rpl_do_srh(skb, rlwt, dst);
 	if (unlikely(err))
 		goto drop;
 
+	if (tail_len >= 0)
+		skb_set_transport_header(skb, skb->len - tail_len);
+
 	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
 		struct flowi6 fl6;
-- 
2.43.0

