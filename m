Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8949E3EFD24
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374292; cv=none; b=nIPj4B4KjYahrV1isdg97DpD/lAc/on712z2p06kNezOiMHAIkmcoMtqkXzxBZpnP9Hd3erdoFWjvZIsO+7xKOHqkvgFZ68erf2N+l0XHFOWyzOl8YZrFAkNvxXOHBxzjXvULV1671L+z+D+Sxs9SG1FVmN43+EW8uRdiV/imRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374292; c=relaxed/simple;
	bh=zER0wkYX3iSzsm40MvX7Nxqogzjt8Sqal+OJ9BrC1f4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Gn2w1otRat2aiYeT3adFIePIGyktx54nazRKossnCRZyIT95jVMPpE3lL/E3wQiz6HAnp5yu36XjMbOVMTf7GfHl4rqmAwtkhNYAAmWdJa+EZqveS3HPYe1Bs7dWhDPoZsv9tv/JXpKPxVZzRFBitA/mAatrGkhH3CfLTYKJMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r66c9XBQ; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r66c9XBQ"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e8004d60eso330376785a.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 08:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786374289; x=1786979089; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A7cjWhwol8wJn8aBMNX9NVOJq20sc1AbVESHzoeztM8=;
        b=r66c9XBQVU5TuhqGCvsw4xFlFpvnYrSVC9dP2SM6G+tJxbqig7227NsPqElqrm7XL1
         so+9RB7snYsb+oMvS6U3xget3HXFsDBQvKMxTelV3r+nGkshnKtT/+16SAGXuyTOE34W
         vjZkUcwTK8QOsadQVodSmBngiC0uIPQvgzrJ5yuxGKWZmCtfK1gJoQVe9mQkidC+hSAm
         jPzohvEI2aPcJIftqbH+nD9xUsB/jwcpn0Ab5KM+WfW3/WDDV3c46N5H7aYJepjjv0MQ
         wQuH/JNoprfrGlHtnaPZMxTsSfSXHagotqyYccFrNO33DevTGPpy92rXNikGrXJVzMFn
         mTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786374289; x=1786979089;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A7cjWhwol8wJn8aBMNX9NVOJq20sc1AbVESHzoeztM8=;
        b=dotpCa8DqQdmG2e6hB+MsJSwX9NDT2ZbRhglQKZeZH5hKQToCyqLN+5iiLv9sLcrVK
         BE3uAA+XowDRZL6wI0KUF4ZbENwSL204j4GxkBL6LbJhNOb6uUepTzNgtfyInCD2+FB0
         or82hqgwex7ofvyTbjXawuywuCfFkPWnHYsiDYZTpWOup6P9C2jpv1LKDZAblTmEVAAA
         /F1JPAZ+hbWsCrTdNCcp0eU0RMK9Le0eQI0oI2bMKhlOpb/QxQzmD0+8whzvfp5x78fs
         hiBYs44lL78ZabAlkomHD+/5/2C7JuMDIbbImhrWrZd1Tta6JoNR2u+mmRY5+p7ObJIJ
         hA4A==
X-Forwarded-Encrypted: i=1; AHgh+RqGaDS0YiTjyOr7JSfmBq1J7evgSy4RHH9O3kJWi8hQV37aDE9d6CvGUkogYE8U4IdgkXYGpP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0c8OU01ziA+VxC3UpWcHzQPowMLUVZXF/3XSY2PxtppQq7SPy
	yy/m0qZeyWCfZEClfoUZnomtH9jY+S6wiqDGDqdUoPAEkD7km5ck7Bc/rDE3yQk9H1gSM4tE/FP
	rEhSxxNesdVO+HQ==
X-Received: from qkkk7.prod.google.com ([2002:a05:620a:7e7:b0:932:dbfe:de8b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:440d:b0:92e:9ceb:24af with SMTP id af79cd13be357-93666624388mr2881390485a.41.1786374288646;
 Mon, 10 Aug 2026 08:04:48 -0700 (PDT)
Date: Mon, 10 Aug 2026 15:04:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810150447.1220864-1-edumazet@google.com>
Subject: [PATCH net] af_packet: Don't send zero-byte data in tpacket_snd().
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+30b93b6845b19cc38581@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported a WARNING in __dev_queue_xmit() triggered via tpacket_snd():

skb_assert_len
WARNING: at include/linux/skbuff.h:2753 skb_assert_len
WARNING: at __dev_queue_xmit+0x21bc/0x4970 net/core/dev.c:4781

Call Trace:
 <TASK>
 dev_queue_xmit include/linux/netdevice.h:3448 [inline]
 packet_xmit+0x243/0x310 net/packet/af_packet.c:276
 tpacket_snd net/packet/af_packet.c:2907 [inline]
 packet_sendmsg+0x28d6/0x4eb0 net/packet/af_packet.c:3134

When sending 0-byte packets via TPACKET ring buffer on devices with no
hard header (e.g. dev->hard_header_len == 0), tpacket_fill_skb()
populates an skb with skb->len == 0 and returns 0. tpacket_snd() then
forwards this empty skb to packet_xmit(), causing __dev_queue_xmit() to
hit skb_assert_len(skb).

Similar checks exist in packet_snd() via commit dc633700f00f
("net/af_packet: check len when min_header_len equals to 0") and in
packet_sendmsg_spkt() via commit 6a341729fb31 ("af_packet: Don't send
zero-byte data in packet_sendmsg_spkt().").

Return -EINVAL in tpacket_fill_skb() when skb->len is zero to reject
zero-length packets in tpacket_snd().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+30b93b6845b19cc38581@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a79e807.01d0871a.3a0d52.00ac.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/packet/af_packet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 435756877abaa1ab4c0edcc2346bcb2de3625605..103025c4625fb317e0ecedd12c15857af86b7a65 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2660,6 +2660,9 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 		len = ((to_write > len_max) ? len_max : to_write);
 	}
 
+	if (unlikely(!skb->len))
+		return -EINVAL;
+
 	packet_parse_headers(skb, sock);
 
 	return tp_len;
-- 
2.55.0.654.g21b8a5bc05-goog

