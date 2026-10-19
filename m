Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B02472F87
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411096; cv=none; b=bef5AkJQXT9OTvL/eP0boaCel46J8dWyb4y8Gvkrdsb74l58oBcly5vSdlTBINA0vFMVHnqL3orb5MB9QjbCuBmOta+S1JvqJp+naAZQLRRP7xbkKrTzEqpdje9WEFsPkF8PoV3b6zaU6b3/PnVGlVVqOP28+6jQ5nf9mYTH2QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411096; c=relaxed/simple;
	bh=DzwW5JyASFKO5o0HYimeD4i5nfEK9kd3dgoVoMIc3V8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ufqvLcQoNEHTIIZn3bUuAQLrit1sxk3Bd/P4z6zMgnM+3PIlIz18LWuurLH0wpQtMRvlvp1zH9qGuiqLtihFi/g0IFQECrgxeBRVjA+TJ8cSco/NFduyym9m5wFq6wdITpPydgx/fBCYt0zqubgi0tsE3bWafG72eZMkg4a7VNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GsLgADLX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJkTaRnm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsLgADLX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJkTaRnm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792411094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0soTP8rwGVA/Y+n9XNjYC2vUcIBsp5X9RMWteJuwrj0=;
	b=GsLgADLXPdeGV67IEdfOkqOhUk16ATlN/asXPYMrpq8vq5rMT9MXqiB5a5oXG3lZehOqwY
	26DbhxDNB5GTrV2xFyLAXWKkMi67/P2DuaDgsZJnk+Eh+/3Gvz39moqBbv7vCibjFGZyjO
	oaNtaoqm4nI+B5SLiOBQ2Ygk+04Vzck=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-hImGfimoP82HcZ3o2stIjQ-1; Mon, 19 Oct 2026 11:58:12 +0000
X-MC-Unique: hImGfimoP82HcZ3o2stIjQ-1
X-Mimecast-MFC-AGG-ID: hImGfimoP82HcZ3o2stIjQ_1792411092
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a16faefac0so12324885e9.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 04:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792411091; x=1793015891; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0soTP8rwGVA/Y+n9XNjYC2vUcIBsp5X9RMWteJuwrj0=;
        b=gJkTaRnm+5OWmZ21aOESDm7VB6UjFNeWKIq4bK4BYLprxDPKLzqYFYCO4ffbdkpyn0
         sCf5OwrzcRwmSQDlGy8KV0YRgsBrj5ECks3WF67OJ1JI+LLpDaCFU3ymJ6JtvVgoK7Ha
         1sX3Fx9AvfYE8Y9yxquc7E8v9maLnlJ6/IfvTYPt2vrB6gFWNJUzRc3vcROXfcdRf6zg
         xuoq5y9KeBD3fIhGgD6IothSKLh2MpiylAgquCLHwaNW+wXoMZBn7SGz9kvEYtf1TJsa
         D+9+ZLYE2lRi3+UgxqaggPnDMdYpJbTdVJez5csR0xxNaKL37WLqVLsUy/UbyD2vqovb
         k6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411091; x=1793015891;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0soTP8rwGVA/Y+n9XNjYC2vUcIBsp5X9RMWteJuwrj0=;
        b=yDg+fYYx7eBaoNLOrUnQQnZuXxcJKQLGNK13ojMoJgGdimo1Ax9BLvElUPqfOtxVKD
         erKhsxmYiC8ws7irlwvToc+kqpdgeBXYzm05xm5QyrAWmWixbTOmGuPbiYebuX/xGZ9/
         9Al6MOgHGWbwcsWf9nYg8Iwmb1Y8ZAURsEX59ZDTRbjRVVVfLBrmqRH5XI5HJUo/NVTc
         FArzfYH4FdGFK0DGkrdv6/B//YJRZHnWdENJJgkZ7ZSIhXrjajadE0YW3Y85t1KME5UR
         Enu5FJEX45vwg7QnHEXlparxeigKXLAEX8TXC3kR/dwEvtgLHMZtk077aFgdZi93anOl
         uzSg==
X-Forwarded-Encrypted: i=1; AKwUvBzc3VfpbnqrrDtaLV5rGgueFbR+ux2N0nrxULEWqeuX1GFVc6iIbuZpI7NxIdCJaIgMJJ8Iiu0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdgn8af7nkgrB10O6aNIhBg/rsR46wiuwgJgIU3P25sr+EBKet
	MUMWasWWXTQpBcf/rLkwiHlkfZf1lQEl9isK1zf4FKgdx3aMF4MuT+Tb0EtEp3bfYZcU4UvXrtV
	MozT70OatDcl6xjy/T/+ZwUP69h1yXqSJm390/le/R6lvpDZx99+zu7A1CSwuWTI+kg==
X-Gm-Gg: AYBFou0LKNSA5D3MLwaT1PQz3mh7w31q7BESZkp9GcyVAkRHkRuJ7KBTkhdrS7HUzIV
	pfR/JnStAaYCyQMlK41VzDfkRV9IItpqs/QBJQaNlutOdBL8AORLA3fmWYe2MiD2u1rFe22l/qv
	Egqngh4fQweQXiGT0z3yy4bdw6qtfYF4MouczKScKPxf5UTdRojQg+sJYcEMpReABmmgmIKPpg8
	eLhhC/Wex4/+wmrzFX/VijbTLjvFbCg2p9L/JzlZFGNbt1wThSA6TMcXrTvlT2aJYqGl/dxqiEX
	pCrrWKkIZSX9+8RjYKMZ1bz1oV3vYmBT0UzmnB4GyfGd6ri11YR51jK2/eM/JGGmYzu21A==
X-Received: by 2002:a05:600c:870b:b0:4a1:d0e4:2bc7 with SMTP id 5b1f17b1804b1-4a1d7608614mr145113315e9.15.1792411091364;
        Mon, 19 Oct 2026 04:58:11 -0700 (PDT)
X-Received: by 2002:a05:600c:870b:b0:4a1:d0e4:2bc7 with SMTP id 5b1f17b1804b1-4a1d7608614mr145112855e9.15.1792411090867;
        Mon, 19 Oct 2026 04:58:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cc642573sm222037295e9.2.2026.10.19.04.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:58:10 -0700 (PDT)
Date: Mon, 19 Oct 2026 07:58:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Max Krasnyansky <maxk@qualcomm.com>, netdev@vger.kernel.org
Subject: [PATCH net v2] net: gso: validate transport header before computing
 segment length
Message-ID: <a53dbcdf068b3813689cf2359949578f627f9edd.1792410745.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
guard against exactly this since a0dce8752193 ("net: Skip GSO
length estimation if transport header is not set"); the GSO length
validators never got one.

We used to, but we no longer allow such packets in: since 44378d02c5aa
("net: always dissect GSO packets in __virtio_net_hdr_to_skb()") the
virtio net input path dissects all GSO packets.

But as a defence in depth measure, let's also check before we read: if
the TCP header is unset or outside the linear data, drop it.

Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
changes from v1:
- address Willem's comments, in particular, teach skb_gso_network_seglen
  to return a negative error, and propagate through callers.

 include/linux/skbuff.h |  5 +++
 net/core/gso.c         | 82 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a3ff380d43f0..aa5bc608de06 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3041,6 +3041,11 @@ static inline bool skb_inner_network_header_was_set(const struct sk_buff *skb)
 	return skb->inner_network_header > 0;
 }
 
+static inline bool skb_inner_transport_header_was_set(const struct sk_buff *skb)
+{
+	return skb->inner_transport_header > 0;
+}
+
 static inline unsigned char *skb_inner_mac_header(const struct sk_buff *skb)
 {
 	return skb->head + skb->inner_mac_header;
diff --git a/net/core/gso.c b/net/core/gso.c
index e96ef6350064..874e4c8b1f1b 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -131,6 +131,35 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(__skb_gso_segment);
 
+/*
+ * TSO processing (but not UDP/SCTP GSO, which uses fixed header
+ * sizes) reads the TCP header as specified by
+ * skb->transport_header/inner_transport_header.  Make sure it is
+ * there to read.
+ */
+static bool skb_gso_transport_header_ok(const struct sk_buff *skb)
+{
+	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+	int thoff;
+
+	if (unlikely(!(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))))
+		return true;
+
+	if (skb->encapsulation) {
+		if (!skb_inner_transport_header_was_set(skb))
+			return false;
+
+		thoff = skb_inner_transport_offset(skb);
+	} else {
+		if (!skb_transport_header_was_set(skb))
+			return false;
+
+		thoff = skb_transport_offset(skb);
+	}
+
+	return thoff >= 0 && thoff + sizeof(struct tcphdr) <= skb_headlen(skb);
+}
+
 /**
  * skb_gso_transport_seglen - Return length of individual segments of a gso packet
  *
@@ -140,12 +169,18 @@ EXPORT_SYMBOL(__skb_gso_segment);
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
 
+	if (unlikely(!skb_gso_transport_header_ok(skb)))
+		return -EINVAL;
+
 	if (skb->encapsulation) {
 		thlen = skb_inner_transport_header(skb) -
 			skb_transport_header(skb);
@@ -175,13 +210,21 @@ static unsigned int skb_gso_transport_seglen(const struct sk_buff *skb)
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
+	unsigned int hdr_len;
+	int tlen = skb_gso_transport_seglen(skb);
 
-	return hdr_len + skb_gso_transport_seglen(skb);
+	if (tlen < 0)
+		return tlen;
+
+	hdr_len = skb_transport_header(skb) - skb_network_header(skb);
+
+	return hdr_len + tlen;
 }
 
 /**
@@ -192,12 +235,21 @@ static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
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
+	unsigned int hdr_len;
+	int tlen = skb_gso_transport_seglen(skb);
 
-	return hdr_len + skb_gso_transport_seglen(skb);
+	if (tlen < 0)
+		return tlen;
+
+	hdr_len = skb_transport_header(skb) - skb_mac_header(skb);
+
+	return hdr_len + tlen;
 }
 
 /**
@@ -253,7 +305,12 @@ static inline bool skb_gso_size_check(const struct sk_buff *skb,
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
 
@@ -268,7 +325,12 @@ EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
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

