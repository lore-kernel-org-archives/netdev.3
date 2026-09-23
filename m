Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770333932EE
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175589; cv=none; b=aFd3GUZagKWNf/tDMulN09MIvV1oE8iBF0EcM0ENvccRqzUX3eJqWesyr2Xn5Odd3vjJDMQhZg4yCz5zr5ae9Byb432RUKM/7Imh1vvUnTlZaYhNXjXwxMTqQ+WrHUibZjiXwPJwhg5FGd0GfXNAsvc90NtpH3ljywTQm1KJSts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175589; c=relaxed/simple;
	bh=xHE6wF/f0J3wE4ftwKdaNVrrWjYIcQCMiWmeIyaza4w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JJPkY7e+PrQyGKhQyuylIec18jebLJcBLBWv2vPXH1AInyOzdey8OVdGclI1xlDq7omHycyUMTFH3ncRzKHSk2X7xNV/3MieS+rFzNmeCVGogFRoouH/WW+9x491hBwhsDC/iF1XNHlXYhgBFt5GQbO3/5V+boV6vAB3iz4ikhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s3kX6eJG; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3kX6eJG"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a0312937eso124389585a.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790175586; x=1790780386; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DyX4a/XU9qqMwAQtKliGGYuo8jxWZIV9wJF2N3/90Zk=;
        b=s3kX6eJGNV785a/O1rQffOrAaLs5GKw7okZPH7wtpEkN9ZOuE9Xolp/tPGutJFJB2N
         s1DHEJPTjGrwm1NmNEu+1WepjYNUea70/7DDLoFk/e8Ot/BPHVOgYlhfq6EFvBN/luFW
         Wa9xFVpsvoGaZ3chys8Y9cUXxuBPOLzUOntnFmC2MKoYADEFjZVTj0AmgXUBT6pxWuyZ
         3iEQ0+0gc2fTdI/LqIJLVgdxtCG3WvHQfGJrX/M/BhhfeTPoXHg7s5Pcsoa4KtEEGxme
         nBtMafAPoYfwMVIBPMzbRG9ctYx02s4OGYVbGExVUU46+Xn2EE8DsuWAgTvf4GpKKvR8
         AgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790175586; x=1790780386;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DyX4a/XU9qqMwAQtKliGGYuo8jxWZIV9wJF2N3/90Zk=;
        b=B2xlfRMp4aM4VesI0UjyNnB400kajXXjpPxk51SchYXKj/LmIYXKf2aCxVzxEwFV+1
         AHcdaxuwI/fZbvX/lm8ri48BLyJ6NieqiL+KlcscwvpDAJQCz+JzQbjTC4tL12qrC1r6
         GgXMjHzj6stQ/ON061fC2haR03o1DsEmxRLLglkmFO3s4uoyMjV1ylF/8RVY+sbYi269
         WVYfGn9yyhX46xpXSY0uRkoismRNNfZv4NDsbm6F3oyw+Gp7fyaTQC4RjFa4maKKOQo/
         EI2vwyzKlpsm9akD6pVwr4BCfYL0GUgom84AvSlNXR46oyNydXOEKHXn3CWFuNAv93X7
         44zA==
X-Forwarded-Encrypted: i=1; AKwUvBwFKaIQT+AKECN6ZS42ReIXnAgy4rWQTygHzz+BaDdrEO0nzFMj0wuGjGHuC+RRW4NPhKGWKMQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n4Ob12FcclA6zEbeUFPvVkPj1AWwrpHxknK1U1dup6PuJFvirJ
	Sprzo3QLKRBf3fpyTeVfdiunsvQ+zRtew3S12i3+dphpJa22ijE8T07mK1KkaxNzYy9Zl8h9i+0
	p41PGB2Umm/Vm2Q==
X-Received: from qknxj56.prod.google.com ([2002:a05:620a:5bf8:b0:93c:25ac:821b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:46aa:b0:93b:b846:bfd7 with SMTP id af79cd13be357-93c250cdf85mr434330685a.28.1790175585766;
 Wed, 23 Sep 2026 07:59:45 -0700 (PDT)
Date: Wed, 23 Sep 2026 14:59:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923145942.731365-1-edumazet@google.com>
Subject: [PATCH net] gve: DQO: fix header length used by gve_can_send_tso()
 for UDP GSO
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com, edumazet@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Ankit Garg <nktgrg@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"

gve_can_send_tso() computes how many buffers each segment of a GSO
packet would span, and for this it needs the length of the headers
that the device replicates in front of every segment.

It unconditionally uses skb_tcp_all_headers(), which reads the doff
field of the TCP header. SKB_GSO_UDP_L4 packets have no TCP header:
tcp_hdrlen() then reads one byte of the UDP payload, and header_len
can be anything in [0, 60] instead of the transport offset plus the
eight bytes of the UDP header that gve_prep_tso() programs into the
TSO context descriptor.

A wrong header length shifts all the segment boundaries computed in
the loop, so the number of buffers per segment can be over or under
estimated. In the first case, GSO is needlessly disabled for this
packet by gve_features_check_dqo() and the stack has to segment it.
In the second case, the driver hands the device a packet whose
segments span more than GVE_TX_MAX_DATA_DESCS buffers.

Use the UDP header length for SKB_GSO_UDP_L4 packets, matching what
gve_prep_tso() does.

Fixes: 014c607f86ab ("gve: add support for UDP GSO for DQO format")
Closes: https://lore.kernel.org/netdev/CANn89i+MS4L60sFQ49=-f-mibeveUfcrpVkD5X+Qy6SOnEpd6w@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ankit Garg <nktgrg@google.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: Joshua Washington <joshwash@google.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 80ab0a449ff54e3d19e9c69226949465d48dfe3f..0f6f7c5dbb2e027bb0a45eeaf76cfabff558ec79 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -918,13 +918,19 @@ static bool gve_can_send_tso(const struct sk_buff *skb)
 {
 	const int max_bufs_per_seg = GVE_TX_MAX_DATA_DESCS - 1;
 	const struct skb_shared_info *shinfo = skb_shinfo(skb);
-	const int header_len = skb_tcp_all_headers(skb);
 	const int gso_size = shinfo->gso_size;
 	int cur_seg_num_bufs;
 	int prev_frag_size;
 	int cur_seg_size;
+	int header_len;
 	int i;
 
+	/* Must match the header length programmed by gve_prep_tso(). */
+	if (skb_is_gso_tcp(skb))
+		header_len = skb_tcp_all_headers(skb);
+	else
+		header_len = skb_transport_offset(skb) + sizeof(struct udphdr);
+
 	cur_seg_size = skb_headlen(skb) - header_len;
 	prev_frag_size = skb_headlen(skb);
 	cur_seg_num_bufs = cur_seg_size > 0;
-- 
2.55.0.1082.g2b9226bbc0-goog

