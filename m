Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385405;
	b=EeP0NqlyvLQ8ThNJFp3tYCPlCVEYV8rYJviabEm+bvlfcrBxFCs8w2UHEBipYbMMMD6h
	 NQkqQVjrGFFrsoy1RSpEXrRQjYxZIL+P03O+UohAJ/xAzlCW+mzxbJU6TtoWxlUzhfZ43
	 ALJ3t/lggiMffItfAKoWvN+vVaVy4L7K4+ZRx+US2gYEKwiM1uIY0waxZ5/GhjBjDBqGl
	 xtH9sVv8Trx7D9FadG1m7kOlkUgVNeTmaZuOz/2TKA8FPt5+Yi5s8tSBFqVwhb5DRIc0r
	 ddvR2rS551EctvP3Ml4gir1xnOneBsUQbZxq5YZrYLKglZPISDpf2DI4u+L2NRwJ5eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q7WNoDNvK27nmUs1OscOlkdJptRoBsF44ZsXFn7l1eA=;
	b=0jyaYLxoX+1iSTxsXJGSUg01MUgicWC2qjM6T7DlcFd0RDP4rSgtO4qGuoTuN7CNJY7d
	 5pu5AVwz86Ixq5PFoqLcmwZ0LO3HYq7cpZf7Gaju3lVWdf0nrtq2aAv/JkGa1uIpcYjdM
	 Wqn+pP9A3RpQKPQPU/Wa7JMs6rlrQRnzhKcMnq+b7EPPLigDpeNsOint3NJhPkmqmbweC
	 C3vTX9Uj51aoEjWRCZjhcolj2VSK5gShWCLf3lHv6PweEZoWw972/NPMO6ix4+bg0176d
	 r0d1gXRIdAcJ4OaM7yxl9kmfjtBhwGzBwZjfifrF4EGfu0l88BXmeCMZqyYbzCSZLBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mGqefc3N;
	arc=none smtp.remote-ip=209.85.210.65
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214C606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A214C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mGqefc3N
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-85a6c747dc9so1891788a34.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794385403; x=1794990203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q7WNoDNvK27nmUs1OscOlkdJptRoBsF44ZsXFn7l1eA=;
        b=mGqefc3NCxerrmYCjjLVfZT0mIT5UV90VtP0gRC7dXQKyP/reZlPLbjZyQzSZuOOiO
         iumhvcJGZEbx8jFYMr6oTuRXXdUyikQOINICli7utWsLokxwlckuh9OLDWKm/Egmu8+1
         ywhtrHxx2XRqa1dQVCvWfzQZVuhTFViTynRuR+Z6Xwti8yO/hVmLMLFgdx7g1UDz+cCq
         KivpOz6YMcrPaI+GY7FQak6ObCPeWFEm9ftG7jAQsHy/YlVDG6G5qmszxW1gcaf10T37
         CBdHlMAguWXqv1I41VjyVKdeocbCfhCqFL+wWxgwHP6s93JsAEMeS3i+mXurOovwdFTs
         7Ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794385403; x=1794990203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q7WNoDNvK27nmUs1OscOlkdJptRoBsF44ZsXFn7l1eA=;
        b=GNAkI1pBT6aeEch5K83dOSMmjHkZs0Bg0PShHjMmmljyj1Oa3SAqRWuO+J9LgEEGW+
         R52L0yy/ywDND16dYiksCUSbMMuQvSG0FQXJNwJKn3CcMJ/zYsZZzXgplu/uThTkzAzx
         o+UN4uhsIvfmtH4WrOTbqycBRmO/G92/ucEMEHajOWKMkOqANF+GeXFl8m+C8mhCt0Dv
         /IjmpUuEdDVTVZQE8VUvIfDAyrnlp2d8l0eikonWAn5OjhHo7+FWbdcB49e4rRJsRpne
         yiid8rCzS3UydjjFhtzJ91LmCWH4Cqm6Y/eOUZxzEVssq8PaE4DVsz/fPZ/touNh3p48
         hnhg==
X-Forwarded-Encrypted: i=1; AL+hErFRGMHUIkjtmLV95MnEjOwd/3qE6yHOL7nGwDMii407tmiCsH/ncQiroL7ECd81gM96mnqr7PE=@vger.kernel.org
X-Gm-Message-State: APuU4Z86m3RpT9bsYtQRJIxDbwQmca+c5lFJp7p3KcnhDKTNAPNxvVrA
	su9tYuulzGO1EqlXrWJVTu2EEmJc17y6rp2aMu27epDrm1wRTImY9eqX
X-Gm-Gg: AYBFou1puDTTb+B7asBWo512GBiSuYlwVRlOOneo1byhVakdu1zyRNnKQHL4IbL2X9v
	T37f2EtjHaIUvPRuZ6+tGWYdFAnoTxo6zhCAvs85vXPBD34eUUbAtdNH1OisOGaLnU/vlm/nZ8F
	awA4Nutpb13pQjBs35u8pEaftITSSBdiZkKrkoyCX6x8n3VVBcfhSE1euKCMmtR2eU74TEfW4DY
	aobJPyltKxc3a/t2VcBLxz2qDRHazTT8p2haItnETdj4HBAWLsXin/tpYDRLRfcmVYC/MFa921h
	W77KBBmf9dogBt3+EnUL+cE0MPOtVpZrbnhd2bi9mnMqZKZ9ema+osRVPlWYkMSkVS0b3c0uK6C
	6kQ1sdrnHnYfqcC0tGNcGej1uQ+bU+nEa0OLN/Y1f+4JABYZCA2xCWvg5P0j/UmDFY/DHHuCxAi
	g47H/bIinzbEgA+YgFVPSLyFw0GPc1pJdjex9ZVaLTqVepzLH10Wl00gq0QwuxDPChCr7fBI8Y9
	g9hPm154M+lMD3ppXlhBmAs6ZTYXS5jVJMjN5c5UEG7XXAZwNR77LK5Rjep2+VsQ7wXtW3bMTfV
	UIg8dKguz0CQ7QMWRFUgx2NXSRE3ZtDA7xjn7CYmgPgSVF/R2kBpMqB8mQTiOqEB5hRS
X-Received: by 2002:a05:6820:290b:b0:70b:930f:9a9d with SMTP id 006d021491bc7-71915c19d90mr1375796eaf.31.1794385403379;
        Wed, 11 Nov 2026 00:23:23 -0800 (PST)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcbfa976sm4056000a34.21.2026.11.11.00.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:23:22 -0800 (PST)
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
Subject: [PATCH v2] sctp: fix skb_over_panic when adding addresses with a pending delete of another family
Date: Wed, 11 Nov 2026 16:23:13 +0800
Message-ID: <20261111082313.1606366-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <CADvbK_daN6zZNPckkGh=r70ooNwTz59VViJy5jPp1w18SDPrzw@mail.gmail.com>
References: <CADvbK_daN6zZNPckkGh=r70ooNwTz59VViJy5jPp1w18SDPrzw@mail.gmail.com>
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

Account for the pending delete with its own address family, as the
write-back side already does.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 8a07eb0a50ae ("sctp: Add ASCONF operation on the single-homed host")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
v2: move the pending-delete accounting out of the length loop and
    drop the del_pickup flag, which no longer guards anything.

 net/sctp/sm_make_chunk.c | 16 ++++++++++------
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 90de272842512..b8e4db81636e2 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2870,7 +2870,6 @@ struct sctp_chunk *sctp_make_asconf_update_ip(struct sctp_association *asoc,
 	int addr_param_len = 0;
 	union sctp_addr *addr;
 	int totallen = 0, i;
-	int del_pickup = 0;
 	struct sctp_af *af;
 	void *addr_buf;
 
@@ -2885,16 +2884,21 @@ struct sctp_chunk *sctp_make_asconf_update_ip(struct sctp_association *asoc,
 		totallen += addr_param_len;
 
 		addr_buf += af->sockaddr_len;
-		if (asoc->asconf_addr_del_pending && !del_pickup) {
-			/* reuse the parameter length from the same scope one */
-			totallen += paramlen;
-			totallen += addr_param_len;
-			del_pickup = 1;
-
-			pr_debug("%s: picked same-scope del_pending addr, "
-				 "totallen for all addresses is %d\n",
-				 __func__, totallen);
-		}
+	}
+
+	if (asoc->asconf_addr_del_pending) {
+		/* The DEL_IP parameter is serialized from the pending address
+		 * itself below; account for its own address family, which may
+		 * differ from the added ones.
+		 */
+		addr = asoc->asconf_addr_del_pending;
+		af = sctp_get_af_specific(addr->v4.sin_family);
+		totallen += paramlen;
+		totallen += af->to_addr_param(addr, &addr_param);
+
+		pr_debug("%s: picked del_pending addr, "
+			 "totallen for all addresses is %d\n",
+			 __func__, totallen);
 	}
 
 	/* Create an asconf chunk with the required length. */
@@ -2917,7 +2921,7 @@ struct sctp_chunk *sctp_make_asconf_update_ip(struct sctp_association *asoc,
 
 		addr_buf += af->sockaddr_len;
 	}
-	if (flags == SCTP_PARAM_ADD_IP && del_pickup) {
+	if (flags == SCTP_PARAM_ADD_IP && asoc->asconf_addr_del_pending) {
 		addr = asoc->asconf_addr_del_pending;
 		af = sctp_get_af_specific(addr->v4.sin_family);
 		addr_param_len = af->to_addr_param(addr, &addr_param);
