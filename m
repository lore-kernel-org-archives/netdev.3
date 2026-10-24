Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792802939;
	b=gSM4fZuky3+fud8uurINUsCOevmxcePPlR2IGGdEjkoTK+b+UGz/hBOHNPXs4JcMJhaO
	 stoxg2T3G48aeLBkINNPptYFbHZFftYL22w6Z17aV7y40LjOioaR5xuJBw9YekYsYBrYr
	 BgsT74oIYQYKc142Ro3qtqhdDYh9tFyCeGhq4BzY+2y/u16dmLNdCg4VW5q0RWKAOaZcA
	 ex3j2R3z+7bZLt545i8sMpNhGJi8Ju367XepN7ICGw+AZy5JdcplnZkB7cfrpkQ9VAOrf
	 KthPdUeYjH2Hu9MdIJNaEmxsXh5BoYNhRqneWs9rTAgN8GPOveusNoVB+iVwMXGvLtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792802939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=puZi83kWsik1IIJ+MiOJRJ8bxyaV22QL6/fzP6n6rBk=;
	b=ujYJ7tQxZrw11YPivfHAzSlgKEEjLYakeP3GCq7ze/uQkQ1bPNCnpqxa0O1n3LYfPyVu
	 K0SfQivsqeK4yGqtLE4gHDbI4JJgbEcx5AfvPFgWJ+jobAT46Qh7xzhWl+Xz/ZZNPcs4q
	 vQ7k45u4J8+DUD25GXcnAg7NZNyY09qRtV27DfsqqWR/LdlTjUHj1ZBMqJ13PTtoee291
	 OZqgi8Mu/1PFUSGOXGayrMNww7MblG/y3xVhGwteYW5sMKLpQ3ZMVsTz9FrqCHY4hcMLT
	 aMV8WhFt3K91xBCD9gUT6OHYsfsB50K0t56b4bwkNPkfQptlBYG9VVj1nvO1DlpoAjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dTZPm+Ax;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE41606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 00:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE41606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dTZPm+Ax
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b3dc272dcfso1828297a12.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 17:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792802937; x=1793407737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=puZi83kWsik1IIJ+MiOJRJ8bxyaV22QL6/fzP6n6rBk=;
        b=dTZPm+AxFDziJFLK6HgiCVn3IQzgVaJg6G5yY6i0LLZqjPouUYeG4cMLgnnv4EKk0w
         5iwgRIVXF2bOA97iyj53iCJXPTtnZmk3kdoufDBsy6Jx9sItcjD8jEB1b6JoKL3l3vMc
         0IEmuExnsED0kUkW+AQHyr9NimeO8ADplAr6D2TdVor45whONQCTARWf+uo8wZT6p45b
         O/vW7XryegStZ0ydauBKlRAXr1LScAMjrRJsGNOLOrfH+pbkUhGkMt3afD5oVedIWxak
         aaOF/XmCj5zNZwggUJFggcqQnhYX2B+hpKNzrmwGADw67ly5Omg1ipuV3CwxcAVH96Rn
         1+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792802937; x=1793407737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=puZi83kWsik1IIJ+MiOJRJ8bxyaV22QL6/fzP6n6rBk=;
        b=p5QrFbUQkqtbbI1j2gbbCjsyg9wZ5a7Bq7CrRRHN3osM8RaJ3qlXDThj6/0LZ/iFKG
         WYCcCWourub+8eIen4jTlUsSwaOTto8vNvARWOHuY6rbdOcQhieDH1FBSXNTEbpASyG2
         Q/6von3EKxmQBWitbJsuRHJCjIjUhVI2TnIEymX95eaP2ttg/HdzXCHa+JWUuZpC/DqD
         K1lhGVHUz4Y00dWjQrfo5OPjpQtbDHCKNCf55aBI2G61DrMqhfr6T8O3t+eyOtiIbXvy
         NqfLScIdvKbEYAZLl8rhaGWMuyJGl11UfNIzJv1b1tH7cLb6nkNtBFzoiHf0Osp87viD
         zf4g==
X-Gm-Message-State: AFq9FYJjqklectIyDeSZxBO92YVca0vztJb7fAjiN3DbDu/IOc82QGps
	l4MYn6lvVXLqKNTCKahCjqmVDR7n/L8Es0IV2bG+Ufd8g6rWpI3B0K+/ZQyP4yUD
X-Gm-Gg: AYBFou3yP4uTDdFRXMK2YtECCB3FIz8kwlkh4iuLZt+OhijZ9AnZE+BSg64RelGOV5d
	NVutAvT0xqMFfWBzaEJcU90kmf/j7bHOFo36v4O+e7MaNLL+hOYaYqkClTw0waCzsQHWPDR7ikt
	wbfd5fk6dSTtrs6/nIUI6UWDJmGTBcmKIP79dhQaAbTqRMTpKbTYP1i3WxR9HWJsPtWSjZ6DUH6
	70mGqUgYNs8yBsRKq9Q2zT8wH/L7du52zvlR9IgCzA3MWl9astgACXEF2/ydteerwByhBWIh8Tv
	cV92YpzdAzQ4v0aESvfFmEgqCKyih56R17C6buKp6GgOkc0/3XdW8h7aaOFRL7K+d5kPakNIiz9
	j5zzktGgNZjdzRvavj5wtTBK3C580nrumTu5n6lq8bhqYdk6Tq4y2kgbFkmOtX0f6ge7ns8SMo9
	GAg8xTO8ik4p197QCWJHKBx+zKOtOs7Aa7Bf3MxL2ZNbMEIGH8nGY1Qjn3v14JNH2uD+TscaLmP
	s0PnF2/FkGhCIw/z/9fW9Tb4KtD8SS90V2+OkUGzlJQQcyAlYXtDHcEV8WibRhE1tJV+28dElXj
	MI0Ux3xiyAefpiI=
X-Received: by 2002:a17:907:2da5:b0:c33:ca5e:8ddb with SMTP id a640c23a62f3a-c46bde088d3mr58783366b.28.1792802937356;
        Fri, 23 Oct 2026 17:48:57 -0700 (PDT)
Received: from kali (83.8.59.162.ipv4.supernova.orange.pl. [83.8.59.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd7b5d54sm25240666b.86.2026.10.23.17.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:48:57 -0700 (PDT)
From: Kamil Sawicki <user148783812897@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH net v2] net: limit priority VLAN untag depth
Date: Fri, 23 Oct 2026 20:48:35 -0400
Message-ID: <20261024004835.17862-1-user148783812897@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The priority VLAN receive path can repeatedly remove VID 0 tags and retry
packet processing. Unlike the read-only VLAN protocol parser, this path has
no limit on the number of nested tags it consumes.

Each skb_vlan_untag() advances skb->data and resets header offsets. The
offsets are stored in 16-bit fields. With enough nested tags, the network
or transport offset can wrap. A later protocol handler can then derive a
large pull length from the wrapped offsets and access memory outside the
skb allocation.

Apply the existing VLAN_MAX_DEPTH limit to the exceptional VID 0 retry.
Count the tag already stored in skb VLAN metadata as the first level, then
stop before untagging a ninth level. Keep the accounting inside this
uncommon branch so the regular VLAN receive path is unaffected.

A single VID 0 priority tag before a real VLAN tag is valid. No normal
deployment was found that intentionally emits multiple consecutive VID 0
tags; permitting eight levels is therefore conservative.

The issue was found while researching the Linux network receive path for
Google kvmCTF, with OpenAI Codex (gpt-5.6-sol) assisting the analysis. The
affected path, reproducer and fix were manually reviewed and tested.

Fixes: 36b2f61a42c2 ("net: handle 802.1P vlan 0 packets properly")
Cc: stable@vger.kernel.org
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kamil Sawicki <user148783812897@gmail.com>
---
v2:
- rename vlan_depth to priority_tag_depth
- report SKB_DROP_REASON_RECURSION_LIMIT when the limit is reached
- address the expected real-world tag depth in the commit message

v1: https://lore.kernel.org/netdev/20261023003750.1133904-1-user148783812897@gmail.com/

Runtime-tested on net/main f4377bf85887 (7.3-rc7) with KASAN. The
patched kernel blocked the nested vhost/TAP trigger on five fresh boots;
each run recorded eight skb_vlan_untag() calls, no tcp_v4_rcv() call and
no KASAN report. The eight-tag packet was delivered, the nine-tag packet
was dropped, and kfree_skb recorded SKB_DROP_REASON_RECURSION_LIMIT for
all three nine-tag test transmissions.

The fragmented-head test stopped after eight untag calls without reaching
IPv4 or TCP. A 100,044-byte nonlinear GSO skb crossed two VID 0 tags, and
a 32 MiB BIG TCP transfer completed with matching hashes and skb lengths
up to 130,376 bytes. The 31-sample protocol-253 control recorded no matching
skb_copy_and_csum_bits() call and no shadow-probe hit.

Rebased onto current net/main 734bef548a96 without changing the patch-id.
Strict checkpatch and W=1 net/core/dev.o builds using allyesconfig and
allmodconfig completed without warnings.

 net/core/dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1a09e786911805..c9f07beee25782 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6306,6 +6306,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	}
 
 	if (unlikely(skb_vlan_tag_present(skb)) && !netdev_uses_dsa(skb->dev)) {
+		unsigned int priority_tag_depth = 1;
+
 check_vlan_id:
 		if (skb_vlan_tag_get_id(skb)) {
 			/* Vlan id is non 0 and vlan_do_receive() above couldn't
@@ -6317,6 +6319,12 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 			 * 802.1Q or 802.1AD and vlan_do_receive() above could
 			 * not find vlan dev for vlan id 0.
 			 */
+			if (unlikely(priority_tag_depth >= VLAN_MAX_DEPTH)) {
+				drop_reason = SKB_DROP_REASON_RECURSION_LIMIT;
+				goto drop;
+			}
+
+			priority_tag_depth++;
 			__vlan_hwaccel_clear_tag(skb);
 			skb = skb_vlan_untag(skb);
 			if (unlikely(!skb))

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.53.0

