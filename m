Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918120;
	b=Hig8JDwCnzDn8cyZY9R+d3Z6P2XRGju6WoLn6HOYEVOZh9J6hI2pdEb9bogya9mjT6Y3
	 2kOJx7UuL64cM0aSaN2AgyusuKS/BswcQlDO9Hc/uVnBW2ugA2if8/xGnElOq4eDW2e50
	 S0ugq+E6gBf0EHGFMD3zcNgr8BbZZRm27irl1YFGh09KWl9XodQb2pxH8VRTojkeWh3Sh
	 KRk5msMYIlRKw1BEs804nOas7nGyBBRcYoPnmzMsrQVIUKl6rRLb90X0BXbx0KKaN/JF/
	 l5apfV3tRR5lRLjn/8AiL54JGBvzgxGiHETuQEXsY4cqY4/cmcCuys9V5BXrCL2mY1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9+6X7RRdrneypz28nsTSwwkRnEHmJY138/Je56JtkYQ=;
	b=ZWsLCC+xKwxmu/qzB9WBDrZIKRah6snk96fc9hN9fdD+lcYFwuGlrPfBrBme86B+F0eT
	 BcvpXNWEs5Rnvlqd2TXQ3QA4BVjsRCgHqJ5XOgC1ZIvIimMkPADlD0nn3ZP1JjD/1aXGP
	 klLC1Vv/3ytl2f5oF48P+5P0WS8HxMnE4aU5FPnxSOFJwTbwS3D8Iba2BboNmkrTGPTKx
	 ZLT3QlohfZ5dPRD6bplOVpL5g5daM1lCQWQ5DkfxcjFpHk0NpUioLAGXD+k857Tb5i0iM
	 4bf1yCbEYGBqYMNRtXbjfY93BjW6meSJwffNFc01caCiDtiUbJhOzgk45BoHA45PcaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=az68RvYs;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577F606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 22:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E577F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=az68RvYs
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eafaeb8684so27712e0c.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 14:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793918119; x=1794522919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9+6X7RRdrneypz28nsTSwwkRnEHmJY138/Je56JtkYQ=;
        b=az68RvYs9TSfxEAx1Ab/bgoYpor4yX/LfV0UiAF2dgBPviQP8sKRZLh+jwbtIbAaER
         ke51Crn7r/ozgO/4nh0uL3xj41QniclZ6TVefS0sq/qXapRZFfVFdDkYq8n4sh8f0rZk
         /GZlFb2yM0J/tKAWNkSWGSs8VztSolil+KPVEamMz5MqeBjVon+h1G8UOVMyf++tSqGd
         Ay+9iyZpE21t7+n8A5QtZw36t0dFt+fRdBwSNeoQrukHmNtm+YV70kPgxUermSqu87qZ
         nl6BdqaBiZI1tXHofhueqKoexfj95rtGA9UFQ7/YbD7i1rJEIv1FcLwjhy58enuIcZgE
         UjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793918119; x=1794522919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9+6X7RRdrneypz28nsTSwwkRnEHmJY138/Je56JtkYQ=;
        b=anzxisU0yXALR7zgLVMv1ZnTE98Flq4ASphm+tLILCwl6vsBVju8VkMQP8hr8RPhDF
         +y2TEqy8YOFvOukYmh43IVUwocBcdsCTFACyLySenKbf2gu81TqUBRTshHy9978VCrrS
         TYcpmP+YLGf1udI3xL9ZqJsyA8mi5Ly2Cm9SMUE+0OyqBuQaSCaMZRUKD6C5eM78Bda4
         JaUmbQM+WIJXUTzpHOAk5+sKY2WPvwQiL0x2P+j7tMvstdpw6CSFiaxVlzPx4FDHMEq3
         +5Pxz+SZalLuiR6mgjqnATSFjKxJCinYaZAX/xpGwyY25BUuc9vQhU6Gm41lVHWhoyor
         NQ+w==
X-Gm-Message-State: APuU4Z8wwtyIJxsV5kufRBSfSvmIKbM/UjakSOpti8mek66DrskReGaK
	kWk3ZjWI33otAcBr4TWovqHgvFavgdxh4cQPn2ZwQQL4QhXPBrYrmyoG373FCQ==
X-Gm-Gg: AYBFou2Obmzx+3VVq7uAo4CdiI0qiGFptnlxtrXdp3Lb9HCTQA9+DEAbn24xP6/mZaz
	98PxTMW0CuorvbNQ1w20Ew1xIVQ2TKr+cJBDH+DntzsZrRHYA8ziGXUOEa5NXL+wERLBhkpGRah
	uZOJCQkIi9Hck8HbspyZ1PqtbQIlKrWEMw/VDsWDPP/sGuGZ5TXpg4w5xECu14l5Ony2dLE7SIM
	QPKYM8eZOWpKPT56cv4CQem6nmAdTS9X8HSf+fW80frtHde+9YaWtf8sCpdbOZJs5YxYUsa2FSk
	fihOkbZ68bDjJ9iFjWRgpLEXvMNmtLUXMh4ldovs+SVmpPInDVe9FIuWLuesFZFPmWL3aawDJq4
	sqfm38NtlE7f0vuBMlJbwW81WidfIJKuw/3EXscLWc60fmuST3383+xEvwk4KXFQObcKmXFG7fz
	UD76kAaWcN+saezkQRGkVBIu2Z1dyDWMt/Bgw2kV8B82X1J/TNI2PuJH1QirDlQNf+pL9BnQIyr
	GW13/ONL8j2K/nG9ZeF/kITgJj1IkvoRKO+jP8/wFP0jDQyfOwlTuTgfALCtWeyjoPh3YHoJJSX
	zbWx+0VATd6ApQ+qKidWJKBw3OQRUSYGHrfe4BWf2UPbJOLkd/yu7Q1mxB+5tIVJhuDRlDcqsB7
	ts7jAOcDbh0JW5e/9mZZa9p5pRPQDLU/vPXQHr/oDrbju0AujrGQf0JI/nvvkNUtme/HOc6YZ+i
	DS3uNY3QjhP+DXEN+PtA==
X-Received: by 2002:a05:6122:e149:b0:5ea:c77f:2f22 with SMTP id 71dfb90a1353d-5ecc4487accmr519873e0c.22.1793918118823;
        Thu, 05 Nov 2026 14:35:18 -0800 (PST)
Received: from willemb.c.googlers.com.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a6174sm43837e0c.5.2026.11.05.14.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:35:18 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Chris Mason <mason@kernel.org>,
	Kyle Zeng <kylebot@openai.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net] net: skbuff: uncharge trimmed zerocopy frags on error
Date: Thu,  5 Nov 2026 17:35:06 -0500
Message-ID: <20261105223512.3647504-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
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

From: Chris Mason <mason@kernel.org>

__zerocopy_sg_from_iter() accounts for the frags that it adds even when
it returns an error: it adds the growth of skb->truesize to
sk_wmem_queued and, unless the skb is pure zerocopy, charges it to the
socket.

On error, skb_zerocopy_iter_stream() cannot free the skb, as it may hold
data from an earlier send. It trims the new frags, but leaves
skb->truesize and their accounting in place.

Repeated failed sends to the same skb accumulate this stale accounting.
This can inflate TCP memory accounting past tcp_mem, and can wrap
skb->truesize, leading to a use-after-free of the socket.

Undo the accounting after the trim. If the trim fails, the frags and
their accounting remain. The trim only fails if the skb is cloned,
which is not expected for the unsent skb at the TCP write queue tail.

The issue was found by an LLM.

Fixes: 52267790ef52 ("sock: add MSG_ZEROCOPY")
Reported-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Chris Mason <mason@kernel.org>
[willemb: revised commit message]
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
Note for stable backports: before v5.16 (9b65b17db723, "net: avoid double
accounting for pure zerocopy skbs"), __zerocopy_sg_from_iter() calls
sk_mem_charge() unconditionally, so drop the skb_zcopy_pure() test and
always call sk_mem_uncharge().
---
 net/core/skbuff.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8da53d5b76fc..60aa4e1609bf 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1908,6 +1908,7 @@ int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 			     struct ubuf_info *uarg,
 			     struct net_devmem_dmabuf_binding *binding)
 {
+	unsigned int orig_truesize = skb->truesize;
 	int err, orig_len = skb->len;
 
 	if (uarg->ops->link_skb) {
@@ -1928,12 +1929,18 @@ int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 	err = __zerocopy_sg_from_iter(msg, sk, skb, &msg->msg_iter, len,
 				      binding);
 	if (err == -EFAULT || (err == -EMSGSIZE && skb->len == orig_len)) {
+		u32 delta_truesize = skb->truesize - orig_truesize;
 		struct sock *save_sk = skb->sk;
 
 		/* Streams do not free skb on error. Reset to prev state. */
 		iov_iter_revert(&msg->msg_iter, skb->len - orig_len);
 		skb->sk = sk;
-		___pskb_trim(skb, orig_len);
+		if (!___pskb_trim(skb, orig_len)) {
+			skb->truesize -= delta_truesize;
+			sk_wmem_queued_add(sk, -delta_truesize);
+			if (!skb_zcopy_pure(skb))
+				sk_mem_uncharge(sk, delta_truesize);
+		}
 		skb->sk = save_sk;
 		return err;
 	}
-- 
2.56.0.455.g6c5a503b38-goog

