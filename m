Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322A0175A9B
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780708888; cv=none; b=KynxltYH8FPFiR4hgbqR80HPb/O1sDUfHquZgqPW2C7Fua8roUAO2x7D320QXTFv25w+/Fir2IUYYjH5AIj0zi4zugsAOZpH+EQdxsckZk1jQeTkgzVx9qVpGav6Ad+/mKO2hMnlQ7NpW7qC4tsUQEcjPRbpvAC7wT7XC+gFfkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780708888; c=relaxed/simple;
	bh=/45MFbrb8WjX0Pp9mJAvlujFxvvf0f6AShSCADq/MtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mURilzv7NOEAs8fHDgjxIYJ+iRexwJc5DMvoKl7s3mZxgf3BJ4r/55AM0WnXkTj/5idI1jC80tnDvKups4fchY9j5dYERspICqLs77kNfD1aFhKiGgjkNAiee+1rhYarnQaP0dDOfZ/vJoeWcIWEZslQ9a7nKvpqErbdm3giRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR/Gmd+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR/Gmd+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BCA1F00893;
	Sat,  6 Jun 2026 01:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780708886;
	bh=Cax/1CBjUBiawOMBuDy0o/PIXymFaB42BvqQDOkPLL8=;
	h=From:To:Cc:Subject:Date;
	b=bR/Gmd+xogF/DhDKqBX65OuJV6PhXP1joJ4KYN8Q7JpY5a+C+PyTwjUwUIhpjxndW
	 kVMMDYzpZYzyQx7ZfriGjmz9I433FUeveW/1cBjmK395ZdB/wQXL/cxQNEKHI1ML3A
	 nwOcc26RDIGgKQ3rC+Otlcf6YqmVUv/LLhTlXCUbdFnT8ekeKgSo5oZSf584EbFAmn
	 o/5PCMARZpns3ylyQYoWWlRUS3mHcMnpqSxopwz9wbYjp/eSrMJL88rKIBq1Hyhurv
	 Dq5/cN+JZFnJSPZDPvI4RacGACZlUlAgXr7Ixz9sQF9/IaM4zLctJTRREur7G5H9aN
	 XEzawXsP8t5MA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	bobbyeshleman@gmail.com,
	dw@davidwei.uk,
	daniel@iogearbox.net,
	razor@blackwall.org,
	sdf@fomichev.me,
	willemb@google.com,
	kaiyuanz@google.com
Subject: [PATCH net] netdev: fix double-free in netdev_nl_bind_rx_doit()
Date: Fri,  5 Jun 2026 18:21:24 -0700
Message-ID: <20260606012124.4060950-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko flags that genlmsg_reply() always consumes the skb.
The error path calls nlmsg_free(rsp) so we can't jump directly
to it. Let's not unbind, just propagate the error to the user.
This is the typical way of handling genlmsg_reply() failures.
They shouldn't happen unless user does something silly like
calling the kernel with an already-full rcvbuf.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 170aafe35cb9 ("netdev: support binding dma-buf to netdevice")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: bobbyeshleman@gmail.com
CC: dw@davidwei.uk
CC: daniel@iogearbox.net
CC: razor@blackwall.org
CC: sdf@fomichev.me
CC: willemb@google.com
CC: kaiyuanz@google.com
---
 net/core/netdev-genl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index b4d48f3672a5..11b0b91683d7 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1095,8 +1095,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	genlmsg_end(rsp, hdr);
 
 	err = genlmsg_reply(rsp, info);
-	if (err)
-		goto err_unbind;
 
 	bitmap_free(rxq_bitmap);
 
@@ -1104,7 +1102,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_unlock(&priv->lock);
 
-	return 0;
+	return err < 0 ? err : 0;
 
 err_unbind:
 	net_devmem_unbind_dmabuf(binding);
-- 
2.54.0

