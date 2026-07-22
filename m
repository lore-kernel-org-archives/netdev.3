Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACB230ACF2
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709634; cv=none; b=TpkMOpUJUCsoX2EvpJgtquTFZJ0m3TFYJW7+OgrwmAtE8WRbC1Pejzp2ikOViHeXLyQmuNqU3hXAZHl8K7pxD440Pfw0XWuzni4WC+c3CPb9OWzBhlU6LZxo5MAH0G5IH5N24jbZA6HGm25OCVTUdfAFDkU68eiAPBt8lSRlspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709634; c=relaxed/simple;
	bh=HX5Nl4e2E/LxL4JXJQQ9MtBDtBHJ0k1zH/XUfeue/O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VvZ/+3gwkCEKE1Ry3WJJeRMnfS5PenO/Wka4wFplN0F8ZyhyZtrDSxjO1/OC/1jA32XXHGJyO4I61htPA1rvDsBqfVj229qvhWy9SY2pynTpmYU9YggcD3ItsKQYWvE8wVowRzVBH+j/4L92AB/GL2aa8F6cAcOJ7XAzdRa5u+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I/dJ7PzN; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I/dJ7PzN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784709629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mF7ikNFrNNC6k6eWd8Jf2SRHYFj6WIMA/yRnEJXoBo4=;
	b=I/dJ7PzNv3AofpFgywvaG8jGskJ1P3831fmYNBX+lv2k2Q5/34AXPaAPTQukvh5csw+IJD
	kHzhqsdZqyOr/ZFBpEG58KBRaOgQtX9dKAWvizwYDLjkYCjHrku0BXvP4o3rNLvuFcmi35
	o87ZEB5aqXdGisuwvp+FcOI+K1EwDLI=
From: xuanqiang.luo@linux.dev
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	idosch@nvidia.com,
	therbert@google.com,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v1] fou: Fix use-after-free in fou_create()
Date: Wed, 22 Jul 2026 16:38:58 +0800
Message-ID: <20260722083858.182506-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

fou_create() publishes struct fou through sk_user_data before adding the
new FOU port to the per-netns list.  If fou_add_to_port_list() fails,
the error path frees fou while it is still reachable through
sk_user_data.  A concurrent receive can then dereference the freed
object in fou_from_sock().

This ordering issue was previously noted in the linked discussion.

The failure is reachable when local port 0 is requested.  Each socket
binds to a different ephemeral port, but fou_cfg_cmp() compares the
requested port 0 and reports -EALREADY once an entry already exists.

Release the tunnel socket before freeing fou so sk_user_data is cleared
first, and defer reclamation with kfree_rcu() to protect concurrent RCU
readers.  This matches the lifetime handling in fou_release().

Fixes: 23461551c006 ("fou: Support for foo-over-udp RX path")
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://lore.kernel.org/netdev/20260502031401.3557229-12-kuniyu@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/ipv4/fou_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 865bd7205122d..ab09dfcdecbd5 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -629,9 +629,9 @@ static int fou_create(struct net *net, struct fou_cfg *cfg,
 	return 0;
 
 error:
-	kfree(fou);
 	if (sock)
 		udp_tunnel_sock_release(sock->sk);
+	kfree_rcu(fou, rcu);
 
 	return err;
 }
-- 
2.43.0

