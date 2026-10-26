Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004800;
	b=EAgBgeidnW0dlgPQh6Z4uyHmvL7TBqnB7637udhlZx7a7Yy8f+iU31De2xi8NB4+Jwut
	 gXXcORN3MIGyLLoeXsRyaLLMLB6smp+OlgvvjK6ryhMtUcXOz+OxnuKZvRtHQnL7yV68J
	 y4JCfucdPZ3S5l/BONdJSf6dOKkSxw5C9gSngGi5Ki4GpiYnZdvxbmTsxLNYYdSQINGq9
	 KErvlDZORqJEoNytNRO1nqQR3ScziIur/Fbz1+BqW8xrsrV5YzkJmfEXkUSR3og+9uxne
	 jxaje8TW1F6ZetV2J+9Va2KRSlHAcl87XTXWZlpSG4frUDYPfVSpgEgGcCGL3StA0zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004800;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=28nCSEvhlsnWDh1U08MOT7RrXgp6P/j1+6eqZ0qC0cg=;
	b=JYPCfDFm3sJomfecoypSZx/hs5rKfimLkgzDpNb5eyVlET493bRqa5apmTpXSaCt4BDe
	 ZmTlAWAYlf9wflF28xz6RI8qU7v8rzWzRREKzJOQKZndcskAoFLUIr0yvP1AdHfL1lbeW
	 ivIl7kP006jWLQ7Hfvhe8QSh+eOov7C01Bi8A/EKx299SPUgVsUiXvgF3ewFtmhkpfjHE
	 EUmQ+1pMPlUdR9O4r8lehLC5oWPYrO+c2e2sQ4rnB7WFo4gjEFM77FDvSgxUEoZ6hR226
	 lxGq9sWJ056c5DOOvvgYHfrmRYvY109wdcupERolWQzK3mRQvBB/4AGON0224D3PAeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=DUS83EQp;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 641E3606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 641E3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=DUS83EQp
Received: from kero.packetmixer.de (p200300C5973ce5d80Fc8DfE94A24022D.dip0.t-ipconnect.de [IPv6:2003:c5:973c:e5d8:fc8:dfe9:4a24:22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 60C96FA010;
	Mon, 26 Oct 2026 09:53:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793004791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28nCSEvhlsnWDh1U08MOT7RrXgp6P/j1+6eqZ0qC0cg=;
	b=DUS83EQpn3JUfEDeMQFkHHPjnfm6S6qogcn05D220PmqBZ7CcqP8a3/jGWfQGB5cXejj6b
	Ut/M0ORE91NFAi+0L6PVWLi1AHXSIb66wAE7qTfi1UNfIXsSmFbOGEf+JcklEACBt8WpbT
	GpVKr6p5k2W7BHH0dYX/R8ASiqoxw+vrU3wRy9ZwQqZrlggvdBfUkOF7NS55/dBZxXWP2R
	ESiQRfb/TPPU3rruFkwxeI3D3b3tEVGuxEaxadX096AFAqQwTUKVAZQO/bHcpCRfSpzUlM
	/ktLMOAgtdBSAVoWMryX+EsIfAyC7IlDfJ1HvVVm2cnerWhldkc24qdwJJ9e2w==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+a079f084653164a652d1@syzkaller.appspotmail.com,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 01/10] batman-adv: avoid WARN_ON for orig_ifinfo allocation failure
Date: Mon, 26 Oct 2026 09:53:00 +0100
Message-ID: <20261026085309.1074911-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026085309.1074911-1-sw@simonwunderlich.de>
References: <20261026085309.1074911-1-sw@simonwunderlich.de>
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

From: Deepanshu Kartikey <kartikey406@gmail.com>

batadv_orig_ifinfo_new() returns NULL only when its GFP_ATOMIC
allocation fails, which is a normal runtime condition and not a bug.
batadv_v_ogm_forward() already handles this the same way, simply
checking for NULL without a WARN_ON.

Do the same in batadv_iv_ogm_update_seqnos() to avoid a spurious
WARN_ON splat when the allocation fails (e.g. under fault injection).

Fixes: 7351a4822d42 ("batman-adv: split out router from orig_node")
Reported-by: syzbot+a079f084653164a652d1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a079f084653164a652d1
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 89b499f7a37dd..158d2b8f04036 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1410,7 +1410,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 		return BATADV_NO_DUP;
 
 	orig_ifinfo = batadv_orig_ifinfo_new(orig_node, if_outgoing);
-	if (WARN_ON(!orig_ifinfo)) {
+	if (!orig_ifinfo) {
 		batadv_orig_node_put(orig_node);
 		return 0;
 	}
-- 
2.47.3

