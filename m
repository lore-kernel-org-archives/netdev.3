Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D4D47208A
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327594; cv=none; b=a7hwe/vt0vC4Np0HRQVvq+UeJeHjnQYClb9LwaqKNwOs2dknD50LJCQiBDhB8ayjDCYeZVVhzaqMeHKtzYMn9OSchb+pn0YVhqehA+Dpx1d/aLYpRtNLlJKTSGYSn1D4kZMvpLiTnW5yiNGFqTXJLoc5MMyE/zHM+bdPcXkEJZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327594; c=relaxed/simple;
	bh=+I/xyxYBL9zTH8cbJp/bZ7r4MhlNFsoYtH+byzGKduo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hBegm4CrlxoKlm56ns1sB5Fm1AYSMqMM/vtHv/DVIvHrKJlfvykeE6b9JYBepHGeugkPsBh/ppr44a6LbfQxGCnRakEMHpclsQJz69kFZbe0P2W4pqF7f/4sjh6o0Dhm1GNv/obaXxiCekZ8xxg/WNwEX9ZrBioPhALulRWO2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AL/jtuu6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyTKJH3K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AL/jtuu6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyTKJH3K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792327590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=7wv0NYqHBhJZNnHiTfLbjgIPRzq1Szg3Uz3MYCF5vwQ=;
	b=AL/jtuu6O5tPQkYQb3OGGe7uQcKHNNXDiGhYdUAY4kTadmTLXCLLC9R5QSHDQp44Z3Lm+Z
	+G5PWx5pylskjN8G9EXzEjxgosPxsXeMvCCrhJzKSSMVR4l91FMD6aPVg0KLaCrd4vION/
	eEsSSZkxJdXWySRIiGG4+QIkAykfSmU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-IBBrRblOMx-zo-yhBA4SyA-1; Sun, 18 Oct 2026 12:46:29 +0000
X-MC-Unique: IBBrRblOMx-zo-yhBA4SyA-1
X-Mimecast-MFC-AGG-ID: IBBrRblOMx-zo-yhBA4SyA_1792327588
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48af4046a3bso1071334f8f.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 05:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792327588; x=1792932388; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7wv0NYqHBhJZNnHiTfLbjgIPRzq1Szg3Uz3MYCF5vwQ=;
        b=JyTKJH3KSK6NPpM2IsD22Bg3eScrJpmCcOvfGJs86YeqZUTIP7pcmqrb3kPQhiXamc
         H15tCJRFh+Px0mPLAt8+BHOVAvVpNvIg2LZCbMF1087ZS2lc65cqU3y33M3Fjp9O4Oni
         1tQEMyjZuLPLy8nJma5CZZ0snkZGJJllUuaGbw+WiZgy4M/pCmpx5Oa3xoBhMk43M6HH
         SQNyfhwgA/2xPQhkM1a8UXDWbKMbCWpApU5RtaBqOvk49j+6AEnX4IZ3qdIdwg49AprM
         LQyKsxBFFJ7xstRIVIRHx6xzQxCZaohGcD5pJkWSthk2dXq1pHaPgi+6YfgEGfhWEONs
         TxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327588; x=1792932388;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7wv0NYqHBhJZNnHiTfLbjgIPRzq1Szg3Uz3MYCF5vwQ=;
        b=jKKps00g1++OAC8Y0EPKg4kqqYEJR+LUl7E/qFIWZckIbnqKo82lK2tWIY04vlVvm0
         CgbzMzt5g1mxarEAswE56awFbUILqzQmcoA0J5JeYCYc2lpIsT2sweW2bbxeJAxxkWgZ
         Dap4dblt6/qxULhw6/WEE5poFBnJ/Md5+PF7FWgHsMAT9GowLC7emKSJHtCZcVxV4oTO
         Fr7afgogbngq6xSp+ES2EkRbA9PjrMibv1qdIHguAVjOuSsALrzoIgRJPscVWeU3gnPJ
         WxC3DW1BlTfAW6Xrk+Sz4BzxmAUNx+ekDbr/U/kfKprKrk/IAKLQx0CamEMXANJZTC/D
         h7Tw==
X-Forwarded-Encrypted: i=1; AKwUvBxuDBPe+fRwIqBEN0cgw18cOs7WLa3YIxszmPkyZX+sZAJkr8ayA03If7LQVgXkBDd9ZHVjNa4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmYYNmRx6OrY5w/xOGRgGUZaro3dpJhde3KaAkeeTJUJrcn0/1
	8B1uS0aIjGSmZ7MBTzrCq9FDJnGdy3ch9WfddG7OlErMKXTGMxZIWr4n3JbS8+Zq1/HtJu3/nvn
	qGf3CgmBoYkTwrMDb+YYWU4gurSnq25ZYfbxK/gwW2g2phtLSwwswMSQ2EQ==
X-Gm-Gg: AYBFou3/2jutVw1v65Pid6M0MVSyT8HAztqxSPEwAhYpJnTOkoL8cVUjmE4+TUB/UbC
	irbPygbt/msNYZ7iMynbSzV0JHFst1xNeCL8/GSxDbhoral76E6E92NRu/N9eq3U4BeyzAwrpBT
	deW9dnCV9DNXpxD869Lby42lw8KvvSjfx7Yks50fsCqsi3fjixfr/0pXeblKx8Qh1+N98tf1Ce0
	E5ncIgJvBTsJ7rm3qvqQOsJiwPKba4JQ00dXzuWeK/KR3B21oW0Lc6MRDfGNv4h1V38CtCV4JRl
	Zn6UztZFxh3PZOMC496YEd3RK+OgVWAzQfZt3+Kei403I0hyjWqxds4YXC9pPvpQkruUwg==
X-Received: by 2002:a05:6000:25c2:b0:48d:f215:48d8 with SMTP id ffacd0b85a97d-48e07bc6babmr12076290f8f.27.1792327587906;
        Sun, 18 Oct 2026 05:46:27 -0700 (PDT)
X-Received: by 2002:a05:6000:25c2:b0:48d:f215:48d8 with SMTP id ffacd0b85a97d-48e07bc6babmr12076194f8f.27.1792327586930;
        Sun, 18 Oct 2026 05:46:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8bb6sm17732878f8f.34.2026.10.18.05.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:46:26 -0700 (PDT)
Date: Sun, 18 Oct 2026 08:46:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH net-next] net: gso: validate transport header before
 computing segment length
Message-ID: <b714fa38ab650b313ca3121cd4cb3ee847d06a0d.1792327180.git.mst@redhat.com>
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

If a TCP GSO packet is processed in the stack before a transport
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

Can be net or net-next, but given we have Eric's patch in net already,
net-next seems more appropriate, and it's safer.

 include/linux/skbuff.h |  5 +++++
 net/core/gso.c         | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

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
index e96ef6350064..d98acfd68595 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -131,6 +131,36 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(__skb_gso_segment);
 
+/*
+ * GSO processing (but not UDP/SCTP GSO, which uses fixed header
+ * sizes) reads the TCP header as specified by
+ * skb->transport_header/inner_transport_header.  Make sure it is
+ * there to read.
+ */
+static bool skb_gso_transport_header_ok(const struct sk_buff *skb)
+{
+	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+	unsigned int thoff;
+
+	if (likely(!(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))))
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
+	/* A negative offset converts to a huge value and fails. */
+	return thoff + sizeof(struct tcphdr) <= skb_headlen(skb);
+}
+
 /**
  * skb_gso_transport_seglen - Return length of individual segments of a gso packet
  *
@@ -253,6 +283,9 @@ static inline bool skb_gso_size_check(const struct sk_buff *skb,
  */
 bool skb_gso_validate_network_len(const struct sk_buff *skb, unsigned int mtu)
 {
+	if (unlikely(!skb_gso_transport_header_ok(skb)))
+		return false;
+
 	return skb_gso_size_check(skb, skb_gso_network_seglen(skb), mtu);
 }
 EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
@@ -268,6 +301,9 @@ EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
  */
 bool skb_gso_validate_mac_len(const struct sk_buff *skb, unsigned int len)
 {
+	if (unlikely(!skb_gso_transport_header_ok(skb)))
+		return false;
+
 	return skb_gso_size_check(skb, skb_gso_mac_seglen(skb), len);
 }
 EXPORT_SYMBOL_GPL(skb_gso_validate_mac_len);
-- 
MST

