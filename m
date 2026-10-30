Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368277;
	b=T24/st3LysyFCkdRuzrTodpfF75wSjiYxPOus/Dir89ndjA+3JnCnQHNje6GZYM+kDew
	 FSLEylmNAvIeuOfpwdfCbwMRvWd62FFVdMqR7CPBr8WxF3grIKaVexVarEA/Qj+bpkd+Z
	 2/Tv3FIOPcbBye9CRFioUFblW1gKLbyz7tkKvLDtQ2dTYOEBQiVmu78fyVC9zT8vdW0v3
	 qVNM1IhHLrBaanb9AZMmbOjk2d9slnxBDr9FloiJXExmuThcvJrgv61m2E1YOsGsJRcm1
	 5ZN66YCjeVaNXl9pwhWlxzL2dQU+wz5V8A16brPQASxvFpB7qHq0kmQJ92Fknr2yDsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368277;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=28nCSEvhlsnWDh1U08MOT7RrXgp6P/j1+6eqZ0qC0cg=;
	b=IQHOTJo+d2lB/v5tNQ2Rsly7On+an22PZXFmS/L4vMEwQHc5zH09qkP1RchMDGOVpg8g
	 e1lYO1+HfZZ3/q2n36cKAljZx0hWS8aEtIb7GRcdeGVkYO5Q1SMR7/U1iyXcT6bD+0Zzp
	 xiLg1U+13gy4DvZtm+TAFKvKeBLrbFxVzMRR4ZqJamTg6riCl0eybMqYQZ5r5vqzb3aUr
	 ZbBpzMP9L31IPpsGPwomqYn5/MK4P+244UWr4QFrfg8wI1gUfn/W11nE3inkwjaYYtLEx
	 mIsm2GrPZznQ5PX14LyJICOTgbiNFxw+TN7pE/x7Iv/U2HGDCIsI8+lWxSIsjGIRC2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=USkFtrcy;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1B087606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 13:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B087606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=USkFtrcy
Received: from kero.packetmixer.de (p200300C597124FD839580c360d3Ed6f6.dip0.t-ipconnect.de [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 77E09FA010;
	Fri, 30 Oct 2026 14:51:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28nCSEvhlsnWDh1U08MOT7RrXgp6P/j1+6eqZ0qC0cg=;
	b=USkFtrcyMOqYC1d/dtt3DHlLDTIxeSO9r+PHyPIFuRt4VSeTwwnOzOqW+LOFD8aNxh+fON
	SKOj+NTTvt68WSA1/DzSo9wOGqcYZyTxHyWIlNGUNBSgoH5CfApd49uIcqf18ti1wDyOLg
	JhPco0wJVu/DyVlG8gaqzjyQoUKdUxG9Av3aZTFsMkBa2ckeNML0o8KJlzVilomWEj+JKv
	mV0LTX6NexMp5wFZMSU7U4GwKKMYQJzedxrvG23TOygefHpzBi7yseRt7y551bpiuUr3bG
	rv47sWEQ6CZF+J2XFedhnBNOUv1JsVL+uuLKKxIw29GpyPdWLOsFPQiHQmgQxw==
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
Subject: [PATCH net 01/14] batman-adv: avoid WARN_ON for orig_ifinfo allocation failure
Date: Fri, 30 Oct 2026 14:50:52 +0100
Message-ID: <20261030135105.2555887-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030135105.2555887-1-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
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

