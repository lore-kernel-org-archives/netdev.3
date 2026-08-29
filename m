Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542BD33A70E
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788018293; cv=none; b=eG1ZzAk3VuCxGy3oa0sFPLgCt2lDEwAbj+6hGIemyvQ9Y5mkn1RuVgMhOxNqWgFLf6th5APkfB0a0KLBkMeJ5vpLAiFGOxBDdIm4y+Ip4ZIpxYYRuT+I9gtHDQPDm9xSlMlCsLCP25efiiPN0NaQBSDyie39sseMqvZ9nmNlUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788018293; c=relaxed/simple;
	bh=qnYuNWXPWx8BAyd6/fLT8Sc4Ovc4ZXyzB+e5OWmxQRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0/NaatzTTA6CuCaBJTi+l+wmso86QZNfUkmWRXDSOB/i6D4Sik8pl/LPVtsMBxCurWzZOrJRVw5DmmLaaq4CLjKefOyZSxfbtpk6gyXi1dPvStdktOojDsgqQ8dDgplggxUAZl/M9yqaixr/8MQhaekw48PVwKiyERjJe5Iv5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=G9DZg6Xz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="G9DZg6Xz"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d53197d8b5so16172685ad.3
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788018292; x=1788623092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zaaPL4nakUaVQoExSkOsXcL6Epmn7yeHAqDZf3EV3cs=;
        b=G9DZg6Xze9iSsVoh2IOXqa4yLFHPpIyYFzD0jW8C5VBejYE15mUgkJXd0Il8QtP18u
         BXBTJkaqcwEGNNu9ppykBFJsjPHJOIhx9KzSrzbF6MVL/G2LrVteYYqBc4FYqYKt9fOO
         6TFXpmXVQ54MUD3Bo0Pxc+uVRespgbFDQelluWnbh4u4+/2MW+sq0MFDP8v4sQ1MHVyx
         ortGPh93ojB4UIb7blfr/9p6ki055yoG8kgTbyaLueTSbXTYwoHzDn0B4hRy9nelL/lp
         NoG3nNb3M5xf750qDt/nAbJyJADD/TM4juarOc5BvDsP2tXkw9gcLGhBYBONhaq5o25z
         IMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788018292; x=1788623092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zaaPL4nakUaVQoExSkOsXcL6Epmn7yeHAqDZf3EV3cs=;
        b=SI5ki+R/j+5GauxdvJacuwKH044KD5Pvn0uB0Y55xQfdp5oydUACFLP/BaX41gKt9x
         c4C2c4VdxjccpJFgGqNRMCGMgGDXowl7RhZuaLEYNtMdrrr0u68Z9x1l3rBFq7wTIM7n
         PYaFwGYPQZ4C2zCPcEegR+anhC0Z62EluR3jup0Lc9odrNSmt285f6QSrhjIs5ZnAy+x
         bwnnJyc1xC9FxW74Kizea/NULo1bBMsI/JwKlKLW1NNqPHoMFjQC1fidgAz0hHUpPde9
         qDAT11p9Ob7zB6Cv7ztM5ZOVgSPkqArHUZuNibqKwQRVqp7s0gd1MHiaaPJGgD/ru4oD
         R04A==
X-Gm-Message-State: AFuF++lhU6AKzp1+RlO82Xuil0tFi50cFdsk97e5f2Lo+JyqPo3Jbf58
	vjyI2iAZNcSq7kPL6qEkntumwiMcSeCF2kF7ENiz5AqOvhMBuKuSJT9YptrCLvPo9K156qQc6TV
	8ZwyiRSaR
X-Gm-Gg: AYBFou1C1+3WPF5smLnxzcX1xJvj8w7fZFiyHJk5shYuMGtgAuEB+qaABPZCQLzNUmB
	6M7iKaJs5nNwbKE+qfv6/hEYwv7wsnq3IDbDRrDlSdqR+MxOSXvrVvZUfkhJumRGXmtAtbOGL+a
	sU5N3EnTafviB6XJfxVmBxA+7iOb0NAWUKkm1e1vYCfAuw9mMKXgZsr3kFHnzTW/Py+u3mT4RX9
	l/Qa9tA26JjIf//hJk40ehwQTpPBosmaPAadJyErd8GyRt21yWYhitglKPY+iHHSAv1i712VAyL
	LaWk4MDwzlKQ11W/udioZb0V9eYOjjfnY/w3ycTLYFumi/1dRz4Hgdkl+3ZAjqNWmXPXbXPGrN4
	/H9BhbJCoJA1QSKCUXOmZflzUhU4DQTQLpFkzjh3urdttk4gQeFYN4RJoXLRhdciPCkdht8lp4a
	2V/RaFm0paR+b1nUe3S2q4qc0xw5lUINgFSk52KTBFkpoZsPowAMPM71RFbSrvxsVi8u3HB2o=
X-Received: by 2002:a17:902:d484:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2d74ddddc11mr264007585ad.7.1788018291618;
        Sat, 29 Aug 2026 08:44:51 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759869283sm14999675ad.43.2026.08.29.08.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 08:44:51 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sd@queasysnail.net,
	vega@nebusec.ai,
	wf.kernel.dev@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 1/1] net: xfrm: reject unrepresentable espintcp transport headers
Date: Sat, 29 Aug 2026 23:44:32 +0800
Message-ID: <d138815e0f52e8898e83c5db62b3938993f813a2.1787986691.git.wf.kernel.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787986691.git.wf.kernel.dev@gmail.com>
References: <cover.1787986691.git.wf.kernel.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wyatt Feng <wf.kernel.dev@gmail.com>

ESP-in-TCP can hand xfrm packets whose transport header offset no longer
fits after the stream parser trims the TCP envelope. The plain transport
header reset truncates that offset and triggers the skb warning path.

Use the careful transport-header helper and drop the skb through the
existing XFRM error path when the offset cannot be represented.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <wf.kernel.dev@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/xfrm/espintcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 674aedc5af5a..3e72b9f067b9 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -30,7 +30,11 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 {
 	struct tcp_skb_cb *tcp_cb = (struct tcp_skb_cb *)skb->cb;
 
-	skb_reset_transport_header(skb);
+	if (!skb_reset_transport_header_careful(skb)) {
+		XFRM_INC_STATS(sock_net(sk), LINUX_MIB_XFRMINERROR);
+		kfree_skb(skb);
+		return;
+	}
 
 	/* restore IP CB, we need at least IP6CB->nhoff */
 	memmove(skb->cb, &tcp_cb->header, sizeof(tcp_cb->header));
-- 
2.47.3
