Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD347533C
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791861015; cv=none; b=Iv184+30gf0SxDYuD3z8I/nBWAXqT/FPweuW24/teqmnnpFHuSy+tId8mWDpBN6mOD+TX2L3s7sXO4JEcGXnBGCO/AxK4mJzMH/EuqOvq77FEAxMtdIh0adAab4jUcM3/fqAlKebWhVgAzDaZqshog1ae0fZRVd5Hxfps7GC2s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791861015; c=relaxed/simple;
	bh=3OTy30U9zaA/EoJrB2LEVikw7T9erylLWW9kg7srSqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OTOepXq/OP76ru3YrA/bZMf1hhPlnuwPZZ7ps5+O1VwFmAThnH/KOxObN4vrstomcIul7SA3IkmrHnNv8y/Rwq4VBzZnVFy5EWpfbMWDzKzIycdWPJe15urD9Np1oq+zPDbYMBwBpUPnTavukwmBH56L6dNinGsDEdHFHWVz0BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CW9LDfkx; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CW9LDfkx"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1438151eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791861013; x=1792465813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uV/uHpIyvSDg1rMqWOrJjW5nbbNl8aiS8yrcLtotir0=;
        b=CW9LDfkx5ST+t9PXJuJ6WeI66c5rw//HS97b7Oc9iAXK0jIOsoqUC+XSWLoUp2nQ45
         Dj7E+ZPDm69HHJumLbEQlIu+RgI978X0G2oAawC8x2TQKa2ZLS7G0jUzFgp+8QVeW51D
         9OaHl745qs0y6WaIaPcdg/pQg9L0TtGjC3eRSOAoFSuEbl+ixZt1K4DOvsaXkC/T9ZXK
         5lIQL4sBpaLCjCzPp5AOSzOqYiOQrePcF+KQbQkzBqEcFdwt1mo0qphEcPz+VD2pAypQ
         Uz20usOE2hqDLjtQmBV1gO12pq8rh1sx0kiXRTsjq/dtltvi463Dg4bwHlhwsbJiM+Np
         VdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791861013; x=1792465813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uV/uHpIyvSDg1rMqWOrJjW5nbbNl8aiS8yrcLtotir0=;
        b=Iilma8bo6bjdchC/jZbhPosphlce+Whp9ifQ7Ixbb9NH+MElSgUrb/zbx3y9jKF6Ez
         yWj9rpvLs2H/Dnojwh0vTDd9vtXZa8cwbwKga1+D05k9AAAd/4R0MprKq7okUI5YjdQG
         ju9finJEnW8vIzZW1fnIsAWbsEzjdA8KXht8eU56EFJY2pHX26y5eis8LXOug1YifVS4
         vNIA0bQg7/bwmLfJVA2wvk8EivOem+EL1nzv3B5G37XPwiDgnWyeIQKSjCVWRHQbHixs
         KoBXrp2hvFOTWDCGQ56ARVzGbbnwj+JB+0AZsT3BcG3Uq+/uL+cBR+DCb5wdul3ggsh9
         k/fA==
X-Forwarded-Encrypted: i=1; AKwUvBzzaxjcJdKxoY78wxkpQci0H10s5++NyAYRJ45IFpgRBrPN+NtpWGIs8YU623JuBwxTRJhGvB0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLk4Ii+1cr+tYXS3zVj9p0ecSSPTn55SNWAr8rKhPNoewmTQX/X
	cayRzkU2PzRZ6h23XaVb0b0+0GdPRHyL4wZN9JwfT0633bQ2Inspcipz
X-Gm-Gg: AYBFou1JK2mbA6PkHn+vagZ+zDDbiTQjIs3eoZlMW77brUNOoBLRzH4dOYfn2b506oh
	xMxAFjODWYO+8WkcmUSCNsFYY08gW7Fb3kGa1JUXsxCbGUaBfgyS475ZYOJRPOwfaHgaLiOuwYC
	TdYw/4KpYHVnYeslFj/w4NNyHuqMw+sjEvIqJ4xsA2WLndAgbgZhpE/tieNt37xxQVF564XSSY4
	snUFeEtFxY9apbv+t8pF3qcmN1s1oxba+OoS5prVtUhiT0E4KGZk5Vcly17WaLPM6CmnBm86Rm+
	/f7Nm+3MMw37SlLFAvNxO3yU42km9P5c66cfT0+FTO06TSXqZ1MQnE/4dU1r7jSWTa7qOZVhbQM
	1FQ6oYW0Xtxzxz/iTkUGu9YhBn1xkBpTxhI5+q6d15qMDEsULOTLdRVjcZL34G1Fv+581Kqfxio
	9l+1HwB2iimhy6F+5FoDpS09e+fgnDfF4iahOdsRtvLTE7rivJBo/1YRA7kuk9r+yE9aTECOB5C
	BGJuaeIW87p1nJ4mzXjY7RUJFNgoRaxo/Mtu+YCMEoIEVEz6ZDhYwm7aqxA4y2CGXisZg3h2qhP
	htecJhQcKnv2tZ2N6YYV8tDSJsS1VCJLiZhqiM5oSJElARpgbgf3Ng==
X-Received: by 2002:a05:7300:aca5:b0:358:1f59:48c9 with SMTP id 5a478bee46e88-3581f594a27mr17419754eec.24.1791861012821;
        Mon, 12 Oct 2026 20:10:12 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e02asm41129053eec.27.2026.10.12.20.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:10:12 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net-next v6 1/3] gtp: set a valid genl command in PDP context get and dump replies
Date: Tue, 13 Oct 2026 03:09:58 +0000
Message-Id: <20261013031000.528393-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261013031000.528393-1-anilkaushikwireless@gmail.com>
References: <20261013031000.528393-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gtp_genl_fill_info() stamps the reply with the command its callers pass
in. gtp_genl_get_pdp() and gtp_genl_dump_pdp() pass nlmsg_type, which in
a genl message is the dynamically assigned family id rather than a
GTP_CMD_* value, so replies to a PDP context get or dump carry a
meaningless command number.

libgtpnl ignores the command and is unaffected, but parsers that check
it (for example the ynl tooling) treat the reply as an unknown command
and discard it. Pass GTP_CMD_GETPDP, as gtp_tunnel_notify() already
passes a real command on the notification path. No uapi change.

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 drivers/net/gtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 4aff23bcfdd1..99836b773e5c 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2279,7 +2279,7 @@ static int gtp_genl_get_pdp(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	err = gtp_genl_fill_info(skb2, NETLINK_CB(skb).portid, info->snd_seq,
-				 0, info->nlhdr->nlmsg_type, pctx);
+				 0, GTP_CMD_GETPDP, pctx);
 	if (err < 0)
 		goto err_unlock_free;
 
@@ -2326,7 +2326,7 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 					    NETLINK_CB(cb->skb).portid,
 					    cb->nlh->nlmsg_seq,
 					    NLM_F_MULTI,
-					    cb->nlh->nlmsg_type, pctx)) {
+					    GTP_CMD_GETPDP, pctx)) {
 					cb->args[0] = i;
 					cb->args[1] = j;
 					cb->args[2] = (unsigned long)gtp;
-- 
2.25.1

