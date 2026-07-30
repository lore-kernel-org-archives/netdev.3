Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8883FB7E5
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404252; cv=none; b=ZMVesfqDbKwx/E90GBZBp1iB7F8PFIR2QZ+85pBfGZdk6W2ZEM0feAZdfXhqwJU9ReWWE5g44An1YLBpayimHWVd7Rw7l6t42J+rZlr/UEoSXg40KJRF6D6EjPQhsBpJ8bHsWMz7weYVEw4S1uZEFJUsob+bA+5R2jVKwpTygiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404252; c=relaxed/simple;
	bh=X8TqHta6SQG1kDetfgvisBDb0XOd0BhPLN1LSm2gESg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AWSZ3BqCQbgXUAKNcNJr2ogEtKbpefawmw7XahUiYUgu54nQHkEqb4+s29FcAwztl/yJNaouacr449IvjsQtoi5USZXxlA25R7LjNcECSXIdfRqXOk3acYUTRj6iR/IhxrlhVvy/DsGYxFvWdxhvUbLX+6WTfiOqqYgV8u60P1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Od9R3sOQ; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Od9R3sOQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785404238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q68pCMBhtAA9sl/pJLe4jec7qNxz/4+cksry5gtaMjg=;
	b=Od9R3sOQBXyekooCYGEwKtHtMuF4jrCDEhQEmQsM0/xF/KpkdpD0RWjIIkUHUUchcaVj5N
	tcalQhgZgAlTX05qCuGbfBA5KhGS3F4MJZLbYeX1OGDUYB7V5to2Trm59dybRdcCgjBWGI
	e7zjjoNuvxX9D3iEiQvuKgh5vS4JKqE=
From: xuanqiang.luo@linux.dev
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tom@herbertland.com,
	aduyck@mirantis.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v1] udp: fix potential use-after-free in tunnel segmentation
Date: Thu, 30 Jul 2026 17:35:54 +0800
Message-ID: <20260730093554.68127-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

__skb_udp_tunnel_segment() gets the UDP header before ensuring the
tunnel header is in the skb head. If the pull reallocates skb->head,
the saved UDP header pointer is no longer valid.

Get the UDP header after the pull to avoid a potential use-after-free.

Fixes: dbef491ebe7f ("udp: Use uh->len instead of skb->len to compute checksum in segmentation")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/ipv4/udp_offload.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 29651b1a0bc70..639c59044c135 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -178,7 +178,7 @@ static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
 	int tnl_hlen = skb_inner_mac_header(skb) - skb_transport_header(skb);
 	bool remcsum, need_csum, offload_csum, gso_partial;
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
-	struct udphdr *uh = udp_hdr(skb);
+	struct udphdr *uh;
 	u16 mac_offset = skb->mac_header;
 	__be16 protocol = skb->protocol;
 	u16 mac_len = skb->mac_len;
@@ -189,6 +189,8 @@ static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
 	if (unlikely(!pskb_may_pull(skb, tnl_hlen)))
 		goto out;
 
+	uh = udp_hdr(skb);
+
 	/* Adjust partial header checksum to negate old length.
 	 * We cannot rely on the value contained in uh->len as it is
 	 * possible that the actual value exceeds the boundaries of the
-- 
2.43.0

