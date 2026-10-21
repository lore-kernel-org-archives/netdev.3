Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595627;
	b=PxyADRKugarwTXTY6ZUST4dZXZtTynwXdqeZ547xa8B74BSwGZIgXiDYj4tR9cJsqM41
	 yq2YHrGooKXpbUJPZWzLCk8Pqu3RuK7gdbXqPnr6uK7F2pvHvLIUwCE3M5s3fQX9T1QxI
	 aAE7XJxtp9nCstmUFrQPoxTabh7wrc8UECV7vAClf0OOFQJad2QRSjEVsuywP1zg5QSsY
	 PmuX0f0LrDY0q49Yv/EO7pwMS0P+b2uSrXRqnw0RlloUDSlod2gcjxxtjvGxFf/ml34Uj
	 Uu7uErb4ZT1lpxZ0XmcgMu5gq6aIGeHcYxxB1xR7hncWRcbRDrVTu7PXS+uAym9LTBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595627;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-Mailer:X-Mutt-Fcc;
	bh=QCOfg1rZWMUgTb5ZTU+yOGOcFfR8PsoLRApHT5roxNo=;
	b=lL/AONlGw9F1iLR1ikgNZB2gKtrzSWh17ZEMvsU2nNnED1zegyqOa/yehHeReQiRNQvv
	 nlkHZOTQJ5bQgWqkwIbe22VAm8B7dEh4D+vzBQNYumYi+R6qLBdBO/GCp5GpFScbAHV30
	 7Xejn/xhNw7emqYq7ZQy7TPFokK/rW3YOn4tIbUDF58k649p5teB5HMEd6L71Jr5s6BjY
	 kxKmAvkPNBcxCpYcJ3oIOnEYzSBlHt9zJu60baAisX4ACW2QFZp6zmCBx1+GjR4RMZlTc
	 FmvASDn59zV/0z9fzHetnEY+bZ1EE8Z+nlhqlZtcZdJo0hYhdWr48SfINYotM0n6OdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KWg28qqW;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lA125dKp;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C2F606A32D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53C2F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KWg28qqW;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lA125dKp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792595626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QCOfg1rZWMUgTb5ZTU+yOGOcFfR8PsoLRApHT5roxNo=;
	b=KWg28qqW16snJPEMwTL1WLCwkAb3N4MeZBTOl3oHM5PCWza8QzDl9vo2DhiA/yLm7oHqg/
	I6aaJeJD3/TS9tRrqNg/oZ+2/21+OVeuF8mXR5nrvuVKb4ZVeysC6PtYUh7FwMzbmQHK8y
	cnZc3qp6ol8GPXPvsUipcWEqTpDCj1w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-eXl33ZnZOI6brV52u_CdNw-1; Wed, 21 Oct 2026 11:13:42 -0400
X-MC-Unique: eXl33ZnZOI6brV52u_CdNw-1
X-Mimecast-MFC-AGG-ID: eXl33ZnZOI6brV52u_CdNw_1792595622
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b1bbf8dbe9so1056429a12.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792595622; x=1793200422; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QCOfg1rZWMUgTb5ZTU+yOGOcFfR8PsoLRApHT5roxNo=;
        b=lA125dKpTF48B05jQLljtTOtDyrp0VwXaJgZI5jbIK+K4fYZcZmd0l0bI/hOnwNpQO
         WIDdKWk8WKRKIDF7YiTE2O3XuomKb54jGE52xxLbGGBkdbvXxUOSESXA/dyj0qHuWxhs
         7mqVFOK2o1H8JCQzMoORMIWvPz+6ErB4KCOWcwiCyYY+fRaMsHP/VUU2YQfseaU6o2Bu
         einyLwsxZeqQM/CX9U1UI9AsLokCOTavYW0cyiiwsDJkku3JdFHvsDneWHNAtqUJMjfG
         /ZxdjMZZdMSsWzHCmSQz7JhiKtpiZJZSFYiSth0Y3T9eypqrWwA1NmVSPIfEgmGb2/4U
         bpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595622; x=1793200422;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QCOfg1rZWMUgTb5ZTU+yOGOcFfR8PsoLRApHT5roxNo=;
        b=LGp2R23fshDdoKos/2lZplg4jlQ3nBBdJyaXxMHg4Yw13X8I1NQdE+p+awE/I/ybWC
         4ABCarJk7fZs6xG/r8948uTCp4L2yDt92/t2xogKTOgBcIP3bS269hQHPcN7cnRBUKQB
         y4752lOHkkbDu/Hc332wJPHXuEqKxHRuisItpAKktYTyZKg7NY+LYkkhuxkRZ3esdwvP
         XrQxrpOZK04hxzA063WJO2YrZDWaHkyd3YlOaMVEgRv04HovXQpy9dh9Lqt6hXy9LSFH
         liyLKzmJ5HWiGWiUONdbPJPffU3eY+re/jgQcB4c/T4B2JcYgpTI78yPmjDkCGY064E0
         BB3A==
X-Forwarded-Encrypted: i=1; AKwUvBwsgNvL+g2c573cAPju8NWd/9IW+9rgUiIuKGl+dWxntoUCi7kOmUVsCawG5kTO061UeZfKKXg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYmeGus5NMmQUAksutkBpx7M/kPtV4RU1g0Wu7T7f4FI7ElHDY
	40a+5LMcsDzQcXPJetCobQSNkMxpSGnMPszKI23TfWQHd4y5lhjOXJGUDgXBW7xcy14BsYSR/H4
	nLbRnA1F0H7hT2eUCX3mwvKPYozMd7aogsOUO1LpCCV2CcYnk6/ouOmYjrA==
X-Gm-Gg: AYBFou1xAeE6yN3qlAN6+X44p+IxD3Fo5htVUn+AA+gM7swr70Zu2xAzkUY3OIlhzos
	1UDGXdMULoSTYbv0Oxfq1rjPQBQoUfeqvUAuchD9QSadc9Zmx2RcI02d7b0Ri8zdCnJim/JCeDL
	KaQgosjUcSZ3uz1cwpTesixoc8SYGTJ+mfc+YGw3vIhyPL2AGEtQgYXoWPnWCqHMR5tEHmDXx5A
	zzdRUtsA7Bbd+dWpor4J4DRKQWk5xNYVFb0lPikbVDLmgvm0r3J42K4PxCCZls2NUEreWvSIy2U
	Dkqcn3oH1+TBaYJFvz0BCBLg9wfxf0etZR+dvzBEHxhQaijbjra83ovXIy5xVYd3nXs=
X-Received: by 2002:a05:6402:3244:b0:6b1:c6fa:c45c with SMTP id 4fb4d7f45d1cf-6b408ee9f92mr1327649a12.38.1792595621518;
        Wed, 21 Oct 2026 08:13:41 -0700 (PDT)
X-Received: by 2002:a05:6402:3244:b0:6b1:c6fa:c45c with SMTP id 4fb4d7f45d1cf-6b408ee9f92mr1327622a12.38.1792595620934;
        Wed, 21 Oct 2026 08:13:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581f15esm6499835f8f.20.2026.10.21.08.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:13:39 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:13:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v3] net: gso: validate transport header before computing
 segment length
Message-ID: <52b8bfe4ee848aff8ace47752352de486171d45f.1792595507.git.mst@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

If a TSO packet is processed in the stack before a transport
header was ever established, the TCP data offset is read through the
unset header offset, far outside the packet.

This was demonstrated by syzkaller, back when the input path did not
dissect such packets: a virtio net header supplying a malformed
network header was enough.  Qdisc length estimation has carried a
guard against exactly this since

commit a0dce8752193 ("net: Skip GSO length estimation if transport header is not set");

the GSO length validators never got one.

We used to, but we no longer allow such packets in: since

commit 44378d02c5aa ("net: always dissect GSO packets in __virtio_net_hdr_to_skb()")

the virtio net input path dissects all GSO packets.

But as a defence in depth measure, let's also check before we read: if
the TCP header is unset or outside the linear data, report the packet
as not fitting.  What happens to it then is up to the caller: the IP
output path segments in software, a forwarder answers with an ICMP
error, policers apply their exceed action.

No unprivileged path is known to produce one - IP input resets the
transport header to the parsed position, local delivery pulls data
exactly to it, and tunnel decapsulation clears it altogether - but a tc
BPF program can leave one behind through bpf_skb_adjust_room().  The
comparison is free, so let's not rely on enumerating producers.

Found by code review.

Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/skbuff.h | 30 +++++++++++++++++
 net/core/gso.c         | 75 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a3ff380d43f0..6f33c014e568 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3041,6 +3041,13 @@ static inline bool skb_inner_network_header_was_set(const struct sk_buff *skb)
 	return skb->inner_network_header > 0;
 }
 
+static inline bool skb_inner_transport_header_was_set(const struct sk_buff *skb)
+{
+	typeof(skb->inner_transport_header) th = skb->inner_transport_header;
+
+	return th > 0 && th != (typeof(th))~0U;
+}
+
 static inline unsigned char *skb_inner_mac_header(const struct sk_buff *skb)
 {
 	return skb->head + skb->inner_mac_header;
@@ -3250,6 +3257,29 @@ static inline int skb_transport_offset(const struct sk_buff *skb)
 	return skb_transport_header(skb) - skb->data;
 }
 
+/* Is the (inner) transport header, as specified by
+ * skb->transport_header/inner_transport_header, in the linear data?
+ */
+static inline bool skb_transport_header_linear(const struct sk_buff *skb,
+					       unsigned int hlen)
+{
+	int thoff;
+
+	if (!skb_transport_header_was_set(skb))
+		return false;
+
+	if (skb->encapsulation) {
+		if (!skb_inner_transport_header_was_set(skb))
+			return false;
+
+		thoff = skb_inner_transport_offset(skb);
+	} else {
+		thoff = skb_transport_offset(skb);
+	}
+
+	return thoff >= 0 && thoff + hlen <= skb_headlen(skb);
+}
+
 static inline u32 skb_network_header_len(const struct sk_buff *skb)
 {
 	DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
diff --git a/net/core/gso.c b/net/core/gso.c
index e96ef6350064..204ab9d08c18 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -131,6 +131,22 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(__skb_gso_segment);
 
+/*
+ * TSO processing (but not UDP/SCTP GSO, which uses fixed header
+ * sizes) reads the TCP header as specified by
+ * skb->transport_header/inner_transport_header.  Make sure it is
+ * there to read.
+ */
+static bool skb_tso_transport_header_ok(const struct sk_buff *skb)
+{
+	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+
+	if (unlikely(!(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))))
+		return true;
+
+	return skb_transport_header_linear(skb, sizeof(struct tcphdr));
+}
+
 /**
  * skb_gso_transport_seglen - Return length of individual segments of a gso packet
  *
@@ -140,12 +156,18 @@ EXPORT_SYMBOL(__skb_gso_segment);
  * individual segments, including Layer4 headers (TCP/UDP).
  *
  * The MAC/L2 or network (IP, IPv6) headers are not accounted for.
+ *
+ * Return: the length, or a negative errno if the TCP header is not
+ * there to read.
  */
-static unsigned int skb_gso_transport_seglen(const struct sk_buff *skb)
+static int skb_gso_transport_seglen(const struct sk_buff *skb)
 {
 	const struct skb_shared_info *shinfo = skb_shinfo(skb);
 	unsigned int thlen = 0;
 
+	if (unlikely(!skb_tso_transport_header_ok(skb)))
+		return -EINVAL;
+
 	if (skb->encapsulation) {
 		thlen = skb_inner_transport_header(skb) -
 			skb_transport_header(skb);
@@ -175,13 +197,21 @@ static unsigned int skb_gso_transport_seglen(const struct sk_buff *skb)
  * individual segments, including Layer3 (IP, IPv6) and L4 headers (TCP/UDP).
  *
  * The MAC/L2 header is not accounted for.
+ *
+ * Return: the length, or a negative errno if the TCP header is not
+ * there to read.
  */
-static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
+static int skb_gso_network_seglen(const struct sk_buff *skb)
 {
-	unsigned int hdr_len = skb_transport_header(skb) -
-			       skb_network_header(skb);
+	int tlen = skb_gso_transport_seglen(skb);
+	unsigned int hdr_len;
 
-	return hdr_len + skb_gso_transport_seglen(skb);
+	if (tlen < 0)
+		return tlen;
+
+	hdr_len = skb_transport_header(skb) - skb_network_header(skb);
+
+	return hdr_len + tlen;
 }
 
 /**
@@ -192,12 +222,21 @@ static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
  * skb_gso_mac_seglen is used to determine the real size of the
  * individual segments, including MAC/L2, Layer3 (IP, IPv6) and L4
  * headers (TCP/UDP).
+ *
+ * Return: the length, or a negative errno if the TCP header is not
+ * there to read.
  */
-static unsigned int skb_gso_mac_seglen(const struct sk_buff *skb)
+static int skb_gso_mac_seglen(const struct sk_buff *skb)
 {
-	unsigned int hdr_len = skb_transport_header(skb) - skb_mac_header(skb);
+	int tlen = skb_gso_transport_seglen(skb);
+	unsigned int hdr_len;
 
-	return hdr_len + skb_gso_transport_seglen(skb);
+	if (tlen < 0)
+		return tlen;
+
+	hdr_len = skb_transport_header(skb) - skb_mac_header(skb);
+
+	return hdr_len + tlen;
 }
 
 /**
@@ -250,10 +289,18 @@ static inline bool skb_gso_size_check(const struct sk_buff *skb,
  * skb_gso_validate_network_len validates if a given skb will fit a
  * wanted MTU once split. It considers L3 headers, L4 headers, and the
  * payload.
+ *
+ * Return: Whether the skb will fit.  Also false if the TCP header
+ * is not there to read.
  */
 bool skb_gso_validate_network_len(const struct sk_buff *skb, unsigned int mtu)
 {
-	return skb_gso_size_check(skb, skb_gso_network_seglen(skb), mtu);
+	int seg_len = skb_gso_network_seglen(skb);
+
+	if (seg_len < 0)
+		return false;
+
+	return skb_gso_size_check(skb, seg_len, mtu);
 }
 EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
 
@@ -265,10 +312,18 @@ EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
  *
  * skb_gso_validate_mac_len validates if a given skb will fit a wanted
  * length once split, including L2, L3 and L4 headers and the payload.
+ *
+ * Return: Whether the skb will fit.  Also false if the TCP header
+ * is not there to read.
  */
 bool skb_gso_validate_mac_len(const struct sk_buff *skb, unsigned int len)
 {
-	return skb_gso_size_check(skb, skb_gso_mac_seglen(skb), len);
+	int seg_len = skb_gso_mac_seglen(skb);
+
+	if (seg_len < 0)
+		return false;
+
+	return skb_gso_size_check(skb, seg_len, len);
 }
 EXPORT_SYMBOL_GPL(skb_gso_validate_mac_len);
 
-- 
MST

