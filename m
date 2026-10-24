Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792861404;
	b=1+hnNK7zaR+xaUQosf5Wp41CKgclYdUYaJ+CSkM3qHOZHtt+MFSRWT3OoZYKnuM4ZaQf
	 mXopR6lNS7qtvIE+4zChdJ2S4C6zqhwD0aPOewcXwOQyWL80pIsVDOsnRBm91DNMebHLt
	 o1F9T5KlWtM/2brQe9y1qQ7CEWbK5ZJdpuGzSSpSlIFYPLBLKGF1ryyUj7HSUvXqfW+RC
	 P9KqyWsAdwvPisxmg8AVyWxpjSD8MiqT5c0BFDC92Bw/7ArPbUfVFAvDBuxkuf7YKmpkY
	 +z3Gki4O79iXOHmGo1yT9lDh8UdkcnrnDQ4g6zmzz5Bo5rMQtvmHh/cgAdSauCywh1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792861404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jo8gmaFEhKj3JngpBjGb7fjIKG8buSADfQD1SD8Q+M4=;
	b=ncKMqhJcsr5KEcCWzCJP7tRV1KWMxlljFmFQ+Qe3BVLlHDrCYImhB3OSj7ZNr9BvTEVS
	 /DPhEYDE7L6yLJBfQgKz42CTrXlDXp4XaOGPO8ijzmF3yxlvs6/lPl1JhlQJ9TFO5B4c3
	 esXWyXVYN+8yY9UH9pFpVA0BPY2rmwFl2SCbhKr7g+u38WSTi0tjhwkd+1aMS/pAyCCsq
	 kYWyNDP9bDbB63AxENjzgweUGHeHfFWuhcV0nQaj74dRqYgbKSTIFKZtC4TRFJ1bxCpC2
	 ISsf4G0ImyAQ2QJojW+Zdw9zG4hdUIzAgdEKRFj/fLx13QV0CRUqWgivHL7I+vRk7iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bLV5+rK3;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E094606A31B
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 17:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E094606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bLV5+rK3
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-99059bdcdeaso511783241.2
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792861403; x=1793466203; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jo8gmaFEhKj3JngpBjGb7fjIKG8buSADfQD1SD8Q+M4=;
        b=bLV5+rK3XK4YT3V2W+IonkQsuEwFvajZnI4HZcQTFPYUff3uvQA3FjTu9QJd59qLLu
         Qt6p8wJbbIQfurLx0x7pNWMLGcwEGCnmcpl97UkPjDLgiIYPQWXVGeifujDTKCxGnAFN
         2Bbh6ANBdrNtIovjYSp2qgEJs09rnSsCLX9Sm1iIrTHRmbX3apzk4SDxqBCgnA235r9L
         +1xyXQ9J24YbQryNaMTeU97ew2Z5eVwIY4vOCNnjqEoTgqhR+r2n0z019QyRGv/+I/cK
         SYj5cOsMPjf5QMBab3y27Aygy4xhW5Y/i4+wLPPLaJhrSZplIsGPp2hAyVd4Hdt3n4La
         RKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792861403; x=1793466203;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jo8gmaFEhKj3JngpBjGb7fjIKG8buSADfQD1SD8Q+M4=;
        b=SmZX5L7+vYMV5g1J8KEImV1egZsGTgFjB3EpQ0YqxTk0KbQ64nJuGG54nn83UIz44h
         MhTNia3G7U8PvHbheFKNCNNmgHqAdqdaivgGDcS0vdKH7m9b1ZbHspbfuDsSLhFagiM8
         ugQJKPGyiSQ3XGQB62kg+yqElv0+CN8OiH2Ejojy9GZfBZqCb3dtPjLZfBHiTYEEhB/R
         YletzifiatFmZm7mvsdx2KqYza8LETIMp95utcarAeJNgcIjKya95KQt4HacXmhmu8Wk
         HwcSc79WNjNMMhxtBX+9Lchrfvvrn61Gf8Dv6IG1gZqIJU+7wOIz1AtsR69L+0whi+QB
         7Yrw==
X-Forwarded-Encrypted: i=1; AKwUvBzfdX4rIzCELh46RUCNvqLS1MwizPrKduWwG4HcTnq2uQ2tkhL9xIE/zmlFa5aC1SvMtYsuqsY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLE5d1IwI+L+qPHEL0MRbxvEjRe8UwFUMh40FguLh3NHewl3Fop
	TBInqAs4fCCiDMzKO+ybDC7o0WesmMJy3FQ38LeG5taiPtY2TVtUEZDJ
X-Gm-Gg: AYBFou2t59bX3TLLybB43Scrc/RNVIyDg6+lzTEPof4oYIbT9oBvLLWT1gpMRVQyPm8
	LuavITcgmPyX4Ln6Tq0tTvm8rmqQ6VhzpBGF+tjzHw+qeoJeZ4IABD8rlNaVQeLSneB9manhdsO
	oH/uFxi7wYq5gPOW2nV4DKvhN9vr/BV9RBLMVXAxfmUC5FZn3WQ8ncd6UuASZ4hHWz837/KAsal
	mbM3ieyIH9+LV2WeQLvd5km3sYg+rCScd5UJKlZ9ohvEoQC53lEfLP/fgVYG12u0Osa8ASL7anu
	pFvZUdI4pRo3k0gU6DUGhOiy+Y/RrEMVt0CxsR47aJphj/CJyjmJLLsCc9gfHAfdXignDY/Ae7c
	3zCShyQdp+Zt2WUD9SihQVer57Ngh/RrXB9KfpDXSGGERWVYkT6HBWgNyfi93G+84fnGoQcvtiA
	qjn2VZFziKu3qgxWEQvYa5ihQEbxNzs+nY1EQF4KNtty5TWiXmNW4nRw5l78m0nIGhlWsIX5XCk
	0qqLzmgGs9EtfgCOYKPUqpTH2rSxV3QmOAPkCFAVBxU/GKr8Em0vRfImnOZ9tQ/u4s8UwYMn0eJ
	XBGLONwBumYYNWuUgiMPiapYPEx9nrn3gYbgrDH4GChUhN00iJ+NmbBZ9gBEBOiE6vqZGY1X
X-Received: by 2002:a05:6102:c46:b0:7cc:c7aa:106 with SMTP id ada2fe7eead31-7ce5cd91867mr658536137.18.1792861402974;
        Sat, 24 Oct 2026 10:03:22 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([2804:7f0:b101:277b:c08d:c9f9:7c08:79c4])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ce5df73970sm2525746137.1.2026.10.24.10.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 10:03:22 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>, Duc Anh Luu <luuducanh05051995@gmail.com>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH nf v2] netfilter: nf_conntrack_sip: fix OOB read in
 ct_sip_parse_transport()
Date: Sat, 24 Oct 2026 14:03:17 -0300
Message-ID: <179286139765.93379.986858959213810476@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

ct_sip_parse_transport() compares the value of the "transport=" header
parameter against "TCP"/"UDP" with strncasecmp(..., 3), but it never
checks that the parsed value is at least 3 bytes long.

ct_sip_parse_param() returns matchlen = end - start, where end is the
next ';' or, when there is no ';', the end of the payload buffer
(limit = dptr + datalen).  If the "transport=" value is only 1 or 2
bytes long and runs exactly to the end of the payload (e.g. a REGISTER
request whose Contact header ends in ";transport=T" with no trailing
CRLF), matchlen is less than 3 while strncasecmp() still reads up to 3
bytes, reading 1-2 bytes past the end of the linearized skb data.

Add a matchlen check before the comparison, mirroring the
sdp_media_type() pattern a few lines below, so short values cannot reach
strncasecmp().

The bug was found by LLM-assisted manual review of the SIP helper's
parsers and confirmed with a userspace ASan harness built from the
verbatim parser functions, which reports a heap-buffer-overflow read of
size 2 in strncasecmp() called from ct_sip_parse_transport().

Fixes: ea45f12a2766d ("[NETFILTER]: nf_conntrack_sip: parse SIP headers properly")
Link: https://lore.kernel.org/netfilter-devel/20260815133104.50369-1-joasantonio108@gmail.com/
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
v2:
- Retarget to nf, rebase on current mainline (no code change).
- Say how the bug was found, add Link: to v1 and Assisted-by:.

v1 (2026-08-15) got no review comments on the list. An equivalent fix
was posted on 2026-10-22 by Duc Anh Luu (Cc'd):
https://lore.kernel.org/netfilter-devel/20261022172248.554687-1-luuducanh05051995@gmail.com/

 net/netfilter/nf_conntrack_sip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 64bc440b1..b05dc8858 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -701,9 +701,9 @@ static int ct_sip_parse_transport(struct nf_conn *ct, const char *dptr,
 
 	if (ct_sip_parse_param(ct, dptr, dataoff, datalen, "transport=",
 			       &matchoff, &matchlen)) {
-		if (!strncasecmp(dptr + matchoff, "TCP", strlen("TCP")))
+		if (matchlen >= 3 && !strncasecmp(dptr + matchoff, "TCP", 3))
 			*proto = IPPROTO_TCP;
-		else if (!strncasecmp(dptr + matchoff, "UDP", strlen("UDP")))
+		else if (matchlen >= 3 && !strncasecmp(dptr + matchoff, "UDP", 3))
 			*proto = IPPROTO_UDP;
 		else
 			return 0;
