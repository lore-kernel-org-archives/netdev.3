Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909605;
	b=kkKckNKbRdQKXv+YAvEK92hKtz/c2sb3+UccwW52dKROrZCqLk8pOf2Qud/m3Zrgt6XJ
	 wgm0qHxjXQynFMJTSL9V8lsj2Z+dHB43PnRPaC0e46rCBf7Gog5SgQ5JIFv2Z+VJH0Wfx
	 x1T/pgXrAbD3+Ga6nyLeJ0MC9dpNdeh86vPyw913qD2yDxIIrhYwLQgpJlxCyccPsekEG
	 hDFhxUHZIGUtMVklY6mxzpgL0CrRh57HvAXb1KYmD+NXGjM01KI1JCs2e8hbkOHx4C8Y0
	 kEi0Dq47n/weLmQUUiitZU3qYd2jY0/CBga3r76g1stmTqrea98ukU1c3dqzRyrmAOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ryZaGDx8x3a69Rl5DLQy2dlizJwtAjr+7G9khhFuLno=;
	b=pt4FzXDmbG0MSs2frAVbjO3L7nTkNsvXVayKPlZWSSY/wXywwt/6i/AECLXjFuBEBKAP
	 DO3RTeUAHX1KZnIFjMgTk/cz84Wo57A5BJjjeJTB6XRU+TLBRcyDWl4cIhMh54RrY661S
	 zBN8lJfldalKCcCBkh8dlfT6uSbc2+NMfvy3xYwYFdNNW/C2bqTowcQ0WjWoKQGPQyw8l
	 mDUtLLd/u+K72ngiiTo+1G8IvNjzirlQPtn1/kXdJgGYi/SixZ/Oo5r6JEPzSwE2cFw9Q
	 H+wXKhON/zlB2cl1wdmdndXSWD3Maq7aB5mJjpiJkWKYQTH0jN248FCBx14XUNucVlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K8i7d1Vr;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E3606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 20:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 616E3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K8i7d1Vr
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36dbde64409so2225196eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 12:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793909604; x=1794514404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryZaGDx8x3a69Rl5DLQy2dlizJwtAjr+7G9khhFuLno=;
        b=K8i7d1VrkroBnkNc8zQUxWBfEJTpZWK/wExpNTghloqtlCEraSKnSfrretlhwNS4ML
         icFROYQINC7ZQaYPZOqF/lZFgfRkPhQOkmiYecGHpEE66ltNn5zFtL9fqHEQXDdqfSql
         Hg1BhMEu6xO4paZ6Z61zQdanU+2F85CvBDjw6T5qAM2dBZpeVSgS9KYFUBZ8YSTpU3Gi
         YNfFsLfI898tNKNsref4CTXeRkNhA1QCGI+XvtF6v0dhyIft8k70W9ERy2/P/WDTzTWr
         dMdxcRBxzIB6gfyNfNbV0EeMSHDkJbp5RYtgMHhhHRBRo4pDLeFXgMLyny4g8zZPTcov
         AQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909604; x=1794514404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ryZaGDx8x3a69Rl5DLQy2dlizJwtAjr+7G9khhFuLno=;
        b=evnBz3JmMX7hGaWZobmtTMV721NkiYR3CwCe46mUOG92x7o8ceOR2bOSDrKz0i0wz1
         B+5YQP8P+5oeZusi+3V9aRZUH9yF/0vcosdvEp1RhvsRNy6Nfjz/OhjMbZMr4ArQE88Q
         LcdF72x/sebbtb0j7FbSjO8IvhWibEY0Va5/F4WTec20c9ojRj6wRaPLLsDJgbIXdx++
         Sin5mah1xTLUKEJWFlEK2yYV4BzCSgNHbDn9cxUPUf7FQUfQLMd2ViDmwKAwAd7jau/h
         pcJKZLxHSx3eeLwA9mQru7e79x2/woX2xBDspVuXYYNyBv5EFEcwBsRICXhxtYZDf54n
         9qxQ==
X-Gm-Message-State: APuU4Z8fBez+1Ixh9OkH8MjUVEV8IEEYsaj/speD6rQB9USuR9agEYFo
	Kn5afk/wqE30CGeJ8VCP4B2rgdfP7T9GTYkq45b8yO+R8XEqtsni/TqZnmG7BHxk
X-Gm-Gg: AYBFou1tfOM9hsyIXF5VTmNQmFZXAxaMHlvuN4DJixe1tKty2w+1BK8FNT5F1xFA4RT
	QEi0m8844v1Uv24XScGI0cYyjldcMOgSyVv97T1iF7j4hm7Yk2OnwcImI9XQYAQYrse1rdlVeI1
	ux5+972wzjW4b2esL5FXZtSn63CL9/pLsR6dTVy/f30aTCeWFXzqHdEVzh9dmveNyuD+V5wpLt7
	t8XXSCf0fcw1M2HKFXLycZcnDIAhJjfeBhEDBEd7mLhL2uXj80D0eUxIYCgLDgI409soKjDMcdx
	I7qxT+p1/3rlCvxVME1AFXiphby3/4uTCBonyAHvYGE/XycECB569V6RJ+AJ/UQFoJJpQF2HMxc
	E7M21C4qPTagrtFRWaaWqRT3rPGZTwhJprGDYN5pl4GMk1ScmvP1PMvjCHV88k/MTg+petvONou
	49GozlTyUfyXUfCsCN34Q2tkW9wfPmo2mZMGQj624D6bY+xZpQ3Ix2UhwmIoFCm20tVRqJmVIDz
	GN0boKeVUuLp0PRvit8YKCx8fbLW0l1r60s8SRn0N1NnrdNG/T3HvqAp1htOygXeWQ2RUCpK6Gc
	HejlxPntHyGF/vHBqr0+IYRn+KuWBQ==
X-Received: by 2002:a05:7301:460f:b0:36d:5102:9974 with SMTP id 5a478bee46e88-36f723e76b7mr336421eec.2.1793909604349;
        Thu, 05 Nov 2026 12:13:24 -0800 (PST)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f722ed312sm590869eec.19.2026.11.05.12.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:13:23 -0800 (PST)
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
Subject: [PATCH net-next 2/4] ipv6: sr: keep transport header after inline SRH insertion
Date: Thu,  5 Nov 2026 15:13:07 -0500
Message-ID: <20261105201309.3182307-3-tactii@gmail.com>
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

In inline mode, seg6_do_srh() leaves transport_header at the inserted
SRH, although the L4 header has not moved. GSO length checks then read
the SRH as TCP, and since commit 7fb4c1967011 ("net: pull headers in
qdisc_pkt_len_segs_init()"), a bogus doff below 5 there makes
__dev_queue_xmit() drop each GSO packet of the flow as SKB_BAD_GSO.

On output, restore transport_header from its distance to the end of the
packet, which the insertion does not change. The input path keeps it at
the SRH, where local input parses extension headers from.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
transport_header has pointed at the inserted SRH since commit
6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection
with lwtunnels"), where qdisc length accounting and ndo_features_check()
read it.
---
 net/ipv6/seg6_iptunnel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 0d39a38a5dd2..942704eca8db 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -676,6 +676,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
 	struct seg6_lwt *slwt;
+	int tail_len = -1;
 	int err;
 
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
@@ -684,10 +685,17 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 	dst = dst_cache_get(&slwt->cache_output);
 	local_bh_enable();
 
+	if (slwt->tuninfo->mode == SEG6_IPTUN_MODE_INLINE &&
+	    skb_transport_header_was_set(skb))
+		tail_len = skb->len - skb_transport_offset(skb);
+
 	err = seg6_do_srh(skb, dst);
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

