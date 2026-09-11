Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F4439658D
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127366; cv=none; b=WWdqeQ1gm0OySeyeIQijwOniqX1zJg+65ZiTe+sEkxwuz9TrKmJpzyfbyL6b3FWxBrdPQ1zQMPO0/hBEFZfJVbdwDdW5OzVt0h4yg+diWCWREkITmeOrIhwqFl0KJseuqnnulHHl+UfDi4TgGMT3Wi/wNPGfoRB8KJ6jxg2YUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127366; c=relaxed/simple;
	bh=9MtbI1wROr4nNWXGoJIvvTLgCnw5mW/ajDIwWwTmHAk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cbFrvQ4Ax0lzgvC6IRuNj4W01oLqB3opCmvIzpZZrThX/wZCmDhdZ49ax+X5LVRsmtOvGnf4olLHEg08Ghs8nUgsAhIdXbXWGOgMf9dQGuDd4Bn4t/7iUMeVd1fqaJV/dtReMld/7u8jqC1XxvqxfPsYpO2FH+ThNolCZ1DohzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=esVuWFWt; arc=none smtp.client-ip=209.85.219.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="esVuWFWt"
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90ce21f2cc9so19062516d6.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 04:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789127364; x=1789732164; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=numUXiOUjvLOKU5x7tNgPauI67rVFcMYtF9Y6fh2Vu0=;
        b=esVuWFWt+JKfzoZxxPDJfrUaSCkzhFnYx8U+F5POE6496qxLY8IZ6ma2KfTXIq3jUI
         If07MRbzG8GSv1uMjxjUznwhSJ5AppBG/C0jk9AxbwWfH9YBAYvUNvqCmKoq49eyDCtv
         47NAiH2RU/rBA3p9SjHPM9+JwY6iv4w8Bhi9w2kZp1gTkQgorFEHN4dSqz//KqWS2qO6
         K3rYhvQ3FrCeXsWVyxUAcmFziawijpblEc1x1SUAXgNfwpiuMF2tOcidqMUmolUCqy07
         kO0UnedQyyLWryRmFDsxBs1b/gs5K2dQ7hjwoUD78RRyTjbxZaeaYo3PrqBwAgXBm4pv
         nLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789127364; x=1789732164;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=numUXiOUjvLOKU5x7tNgPauI67rVFcMYtF9Y6fh2Vu0=;
        b=YmtAi+fcqgtTm91S/WUKH9pqMaIrvzx0N1iKETOOt4R2fdRNire5VHo0QjPAWpxEp1
         ekZINz16U78TRCNf+alaY2rgM5h/T5VF5Nckb0I24rZDxkQ+9xZczA4dDajAIiOQxDrs
         ErMkWoncnOC0/7jwkYiGzEB3m+HjpDV2lxfAW20WgE+AEAjkowfWnj4aTAHbhM1/bf8p
         sDCtqfKdz2VhB5zoqe9yKkNFysClyCXK6Vkzs6ak4z9p/VkpZroLvqIKMMGV1qku1pgw
         lC81HyOOAPfp0nXdAX2IztSmoPO6IvD0lktkOJMAo5TOKurAwLteNSMWPypGnMlfU6lN
         m0gQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTjWDO0xR/HxNGA+5uuhdFbjVZ/IIZVXxF4VOVwavcheB77WVr7P70gSujOG1kDbVsNVoIJdQ=@vger.kernel.org
X-Gm-Message-State: AFuF++klarE/aZCuDGF8SMMOWgbYTVFaaGH96n/C2d6o8TX4+mL0AnT0
	N1UYhx7V6zPt3i4LVYfX4t/15DMo7EmBMrdsUPNE3jjMESpHhemFPo4uuPnI/QwPWekUdCsiFaM
	FDka/k9h3i9Jxbg==
X-Received: from qvqu14.prod.google.com ([2002:a0c:ed2e:0:b0:912:5a4:173])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:19cd:b0:908:949c:4adc with SMTP id 6a1803df08f44-9121207b95dmr51879706d6.10.1789127363699;
 Fri, 11 Sep 2026 04:49:23 -0700 (PDT)
Date: Fri, 11 Sep 2026 11:49:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260911114922.621937-1-edumazet@google.com>
Subject: [PATCH net] net: skbuff: do not leave stale header offsets after pskb_carve()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com, 
	Allison Henderson <achender@kernel.org>, rds-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"

pskb_carve_inside_header() and pskb_carve_inside_nonlinear() remove
the first bytes of a packet and reallocate skb->head.

All the headers that were present before the operation are gone,
but both functions call skb_headers_offset_update(skb, 0), which
is a no-op : skb->mac_header, skb->network_header,
skb->transport_header and skb->csum_start are left with their old
values, now pointing into the freshly allocated (and possibly much
smaller) skb->head.

For pskb_carve_inside_nonlinear() the result is a zombie skb with
an empty linear part (skb->data == skb_tail_pointer(skb),
skb_headlen(skb) == 0) but skb_mac_header_was_set() still true and
skb->mac_header pointing far beyond skb_end_pointer(skb).

The only user of pskb_extract() is rds_tcp_data_recv(), and the
carved skb is queued on tinc->ti_skb_list. When the RDS incoming
message is released, rds_tcp_inc_free() calls skb_queue_purge(),
which frees the skbs with SKB_DROP_REASON_QUEUE_PURGE. This is
visible from drop_monitor, which then tries to pull back to the
(bogus) mac header :

skbuff: __skb_pull(len=234)
skb len=6968 data_len=6968 headroom=0 headlen=0 tailroom=0
end-tail=384 mac=(234,14) mac_len=14 net=(248,40) trans=288
shinfo(txflags=0 nr_frags=1 gso(size=1428 type=16 segs=5))
csum(0x100120 start=288 offset=16 ip_summed=3 complete_sw=0 valid=1 level=0)
hash(0x7b446c6c sw=0 l4=1) proto=0x86dd pkttype=0 iif=60
------------[ cut here ]------------
kernel BUG at ./include/linux/skbuff.h:2847!

Add skb_carve_reset_headers() to mark the mac and transport headers
as not set, reset the network header, clear skb->mac_len, and drop
a now meaningless CHECKSUM_PARTIAL (csum_start would point outside
of the new buffer).

Fixes: 6fa01ccd8830 ("skbuff: Add pskb_extract() helper function")
Reported-by: syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6aa3e9d3.f2639fcc.29487d.0028.GAE@google.com/
Cc: Allison Henderson <achender@kernel.org>
Cc: rds-devel@oss.oracle.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index cc3b4b70288b4e3f17984cd4f4e4b7a330353e15..0e6637db6da201fe2640c244e1b0983fca39b918 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6832,6 +6832,23 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
 }
 EXPORT_SYMBOL(alloc_skb_with_frags);
 
+/* pskb_carve_inside_header() and pskb_carve_inside_nonlinear()
+ * remove the first bytes of a packet and reallocate skb->head.
+ *
+ * Whatever headers were present before the operation are gone,
+ * we must not leave stale offsets, otherwise users of this skb
+ * (skb_dump(), drop_monitor, taps, ...) would read or pull garbage.
+ */
+static void skb_carve_reset_headers(struct sk_buff *skb)
+{
+	skb_unset_mac_header(skb);
+	skb_unset_transport_header(skb);
+	skb_reset_network_header(skb);
+	skb->mac_len = 0;
+	if (skb->ip_summed == CHECKSUM_PARTIAL)
+		skb->ip_summed = CHECKSUM_NONE;
+}
+
 /* carve out the first off bytes from skb when off < headlen */
 static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 				    const int headlen, gfp_t gfp_mask)
@@ -6887,7 +6904,7 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 	skb->head_frag = 0;
 	skb_set_end_offset(skb, size);
 	skb_set_tail_pointer(skb, skb_headlen(skb));
-	skb_headers_offset_update(skb, 0);
+	skb_carve_reset_headers(skb);
 	skb->cloned = 0;
 	skb->hdr_len = 0;
 	skb->nohdr = 0;
@@ -7027,7 +7044,7 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 	skb->data = data;
 	skb_set_end_offset(skb, size);
 	skb_reset_tail_pointer(skb);
-	skb_headers_offset_update(skb, 0);
+	skb_carve_reset_headers(skb);
 	skb->cloned   = 0;
 	skb->hdr_len  = 0;
 	skb->nohdr    = 0;
-- 
2.55.0.1007.g17ff1f9808-goog

