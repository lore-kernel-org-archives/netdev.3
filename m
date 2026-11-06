Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991133;
	b=G8wg6DAmW8HKxOP1ZdCAXRJ6ev+fyHQ+KbF7EBXhzbr8HdT1ffB4pEgr2iqTfaAje7Dx
	 g1hfeRVt7xB1YuMJcPFr70wVzp5g7qNs/3fDfiqXTYQ99ctxg8ENx6bSELKYnc9m60Px6
	 DZ83V/os1fbIVRFeCTgxyURJ84xXq6vcWM8buPZwyOGwMVH2vOuMIIom07USWmt73gZSy
	 EwtKV1pyvnwMw3cBYViJzXiWfUz/rDIc8CHPMrMJ8QWl/t6ub/H+mzJIVerKi0McubHJ8
	 rYXsqIWRO+FoIgcrMV4N5y1q7zoOaO7257AOuT38XW7HXbzQtS6Hcd/nUgDOcJlvY0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jkr/vXjba9Z3zwOiGq9O6qe7GzW0wTcrHSexSQcxSGE=;
	b=YOWo+IEr/4CboyezmogzJYZs8s1hUPGEfTFGhg+x8PCGQOJo5mY0NExFQktwmlZOlpoX
	 M2hHBrc48WMIQcLdTWBeezlgfZ7Il6K9kqiJqIZy3VnMPJZBw+JJz1GRlkWQNwojCTh+S
	 bxwqHbi/m2FBdDBXqksAxshOU9IexCU6cEPmuAvWdgv/MfLTkMU1rBKmj3tPT+5vXK2sd
	 TNAXDyT46TiH4rVC4qvwA0xI7iOqlH/8k9AlGYQkX/ImSC/2LvFdOVcHAvCoGb07Cjuwr
	 7WMwyzTfCvqpz2/49M04E6vuj4oYarniiZDr0YwsXl5UYCZ1J6gabBUxHNOcG9jke2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jySbVnZm;
	arc=none smtp.remote-ip=74.125.231.139
Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863A9606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 18:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 863A9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jySbVnZm
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-853d57a81easo267933a34.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 10:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793991131; x=1794595931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jkr/vXjba9Z3zwOiGq9O6qe7GzW0wTcrHSexSQcxSGE=;
        b=jySbVnZm+1AV5VJLdKjudU4bDQgXjripk4/WPWfN2IuT9kWha6DIBZ51q8fjTnB9Za
         5IKiHFgDtEP8JX8Eak9CbaB3xjArWYIjugVii0/OTMMDAWg3nuALGDp390U86YyhCrs+
         iNeIRpYcGn8SCy5c2vQzO9OCT3viYYjrqkLxW7xOrjJUrEqA9uRo9lWHmEb4eh3ugiDn
         5sV99QblolTqwccSQYAM5pwlZNmBYW062mwK7P/n3HYD1b7KJA0LLoZV4/GaXXJg03Z9
         Mo68HwOiGl7ge+H+PLNAfdXKRV/Szg+dUh11bLP5lSnueAc7qo1icq9qeykO3tWLHB+q
         A+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991131; x=1794595931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jkr/vXjba9Z3zwOiGq9O6qe7GzW0wTcrHSexSQcxSGE=;
        b=umWUrEO68y1OIbwZoJGj6vcLpHSZ3VDFqbKGR78Cuz0NoKnqtMx3Rnckm406IUN0I2
         oRZu/NLgxYI1m21H3uTOzuar+sl1L4QS2lvTEci7yKM3aLv6SF/7CbXGRZT1PEUaG4dM
         V4MZXtleVl/7s3koQWbb5MB3nBRCYLJoC0YpV7UILyS+iGlL3ZiZLZA3TCjj1ahzfyQj
         ROWGLSYJewNk2x8c5gKQBtkSnp1RCWHlCcqFPPvezu4fVp5K//dS7/5P4mJeooDekf3d
         QsPQcND0kSNEfBGffi+HlEk6gvjLLY58TylOOXasV2u9uDDvkwiGRxlt2sFn8yzpuzHv
         OK8A==
X-Forwarded-Encrypted: i=1; AKwUvBwkj42us76aupkSx4kM5mhtmXaz9LigjBCMxvxxmw06eNKVuF0YwZk2Sn+bFSvRsUjMjG42LjI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9oPesuEktKksR1DzbIVhsTSl4MUlAVOtuznTWOdFaumyUwJcCD
	/ezV4cLahNo2Gh6AAa8LyAGwcf7wgLTTmrvP363mLLQT6JqCNpXwGUOK
X-Gm-Gg: AYBFou2pApfa9OqOkMYUawSK6XB5kzAlBZHVNz0oZVyA6RRhpQWAboZL97UaRQIJYFN
	JkwFGQby+dE+/jJvvlB9Omam+BFyf5bd1mpgWF1rL9+5Mk+DPkzJ0K4AjVDktbM+EPZsvf5ShJ1
	Cs7D6SuJaJwT3Tds8GzvFOCPKSbcEN421wYD88wM0xpKuKlXHWkmVj/G2+cCBZlnHRFWzqv+n4I
	JCrdUzCCFeCJ0VSD+UmahD7eTvHO3Z7nbsQNimCywkiyp3/lP9Xxf6eCl87kBuyEd9A0NaBSV7s
	DrsFim/rPeFGcS+AtgcJIJaIVSeR3TmRUTBKrc27jgGZkDzjcTq7tpKRkjQdtDEhlsmHLlyp/5h
	bCBH4oEeljnYIXMN/5mwqzTlpIwFqRepart2VvBzO3cYqajqM++fpbS0WdK3zAVIbb7v4pYZpy1
	nAUwcKvTytSW4kqM2kz9uiObTM4J+LLSEw8bvhf8bj6q2BSMOHsadtr9Ql2yGkwpcFeFAbjaeHQ
	w6VUrIS/r7SV7cYofNF8cw1TbhV+IdLOqROC0Ggn7sEfCvRKXYdBh6wZmGZpKRWrh3sWpJqgKdJ
	8zZy25Wvcq3NMpnrCx8kqpb7C77CPM/NjOoz1AVhySW4b/8AKrnrGv0kDJi58B/JCRbG
X-Received: by 2002:a05:6830:7192:b0:818:56c:a8f6 with SMTP id 46e09a7af769-85f1d04dc99mr3163517a34.26.1793991131373;
        Fri, 06 Nov 2026 10:52:11 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1de8fdebsm2533411a34.25.2026.11.06.10.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:52:10 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	edumazet@kernel.org
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] sctp: fix skb_over_panic when adding addresses with a pending delete of another family
Date: Sat,  7 Nov 2026 02:52:03 +0800
Message-ID: <20261106185203.3326303-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

sctp_make_asconf_update_ip() accounts for a pending DEL_IP
parameter by reusing the length of the address being added. The
write-back side instead serializes the pending address itself,
with its own address family. If the pending delete is IPv6
(20-byte parameter) while the added addresses are IPv4 (8-byte),
the chunk is allocated 12 bytes short and sctp_addto_chunk()
writes past the end of the skb. E.g. on mainline (05441d697f7f):

    skbuff: skb_over_panic: text:ffffffff84859c77 len:392 put:20
        tail:0x188 end:0x180 dev:<NULL>
    kernel BUG at net/core/skbuff.c:215!
    CPU: 0 UID: 1000 PID: 379 Comm: poc_sctp
    Call Trace:
     skb_panic
     skb_put
     sctp_addto_chunk
     sctp_make_asconf_update_ip
     sctp_send_asconf_add_ip
     sctp_setsockopt_bindx
     __x64_sys_setsockopt

Requires addip enabled on the endpoint (net.sctp.addip_enable=1).

Account for the pending delete with its own address family, as
the write-back side already does.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 8a07eb0a50ae ("sctp: Add ASCONF operation on the single-homed host")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/sctp/sm_make_chunk.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 90de272842512..18947ec5ff9f9 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2886,9 +2886,17 @@ struct sctp_chunk *sctp_make_asconf_update_ip(struct sctp_association *asoc,
 
 		addr_buf += af->sockaddr_len;
 		if (asoc->asconf_addr_del_pending && !del_pickup) {
-			/* reuse the parameter length from the same scope one */
+			/* The DEL_IP parameter is serialized from the
+			 * pending address itself below; account for its
+			 * own address family, which may differ from the
+			 * added one.
+			 */
+			addr = asoc->asconf_addr_del_pending;
+			af = sctp_get_af_specific(addr->v4.sin_family);
+
 			totallen += paramlen;
-			totallen += addr_param_len;
+			totallen += af->to_addr_param(addr, &addr_param);
+
 			del_pickup = 1;
 
 			pr_debug("%s: picked same-scope del_pending addr, "
-- 
2.43.7

