Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689777;
	b=IuzgFvTvbfk8fFvMBnCyILr/YDn8mEOvwL9keUp/bTGQlVPK3C6GntERknEc7kPS1r8M
	 kutPsByJg8YPMXx2d8M5m+x4WGE/GUPWiXDUHiUwEWgq9xANQNRMVfftVcy6GmkuJi+hh
	 tr2OqaRBxGJ//u+Bgy5CORQ8Eb+xlDJlbMZNe4jqSvZoIdHyt1hrzXBittTA7SiqQ1bjC
	 /ViNAOcEyVceaRjySu0NIKXloa/sK2+0rbEoZ8rg3hmA2ManW/Xnkq2rE9j/Ar+NjcCz9
	 7XMpnc95r2ubCq6xP7Wq30tKyjFDSL9rg2zPEMj/aD9gu4Ej6VB0LKZBjSg7BNwe5VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3Fxnb+tmDz8vD/RCSb1yDfS8uHLVRtbiJwimxAWXwl8=;
	b=5iPmM8LhyQhKDs2zxR49Q3Y6DF9ZZc5rP1KjhwIX58E57/yOWVI98t6WZPi5ODiA5KPl
	 loGc5tp8KwZX5cI5tY7OIICTsVxMUFLrrU0baYn5gbXPGkOeHZRbnvBAsdG6tEOyiE0mV
	 qCnV5Edx6L9+dy5HGIKDY0ooGLbryusNnK550+OZnYj2LFGWP8yJ/T01B473/Kwjxypvx
	 KerBP5qIWthH5x+SW1yO8Bl1TE7fzqP/dR8rUXZw6rtcbf94ep1eTyKYJDlwbL+5bmnUn
	 UQSjPxbjnlFkMGTqUfCTO/G5r4yDR4E+5WG/eA7S73LJJ/w13auDidbZB9u80ZirpsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D7y+e548;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A765C606A321
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A765C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D7y+e548
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8246b13cbso16947675ad.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792689776; x=1793294576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Fxnb+tmDz8vD/RCSb1yDfS8uHLVRtbiJwimxAWXwl8=;
        b=D7y+e548RrVflPxq20p6GTx6fhtREdk3YQuLBVSgVzBv+bTswPoGTzj3iua7j9o1dk
         6YR/zzZ5fm9OmD91z2AUk2nEWIDH5+2Hv5gClEbE+knloO7Y4EiOheYnaoQc81H9Zp4B
         XWFsHK0v+nRiIcSyej8SvGnzPruFGf0D/+D6vPIJU+ZOQ32+dHKDgWBYjAnfpK4HXygv
         RzeRMc5jur2GRVX5+GDojE4Dcyy0ZLU5AHJxovZSFddDPdli05xu93cgEXlL/d0ZXMVw
         2TxF61j6SxekpAzrwUvE9mm3i8GCMX17RUE/tqzyT2Hc4OjX32M0fY2ovHrIRIHpizwn
         4S1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792689776; x=1793294576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Fxnb+tmDz8vD/RCSb1yDfS8uHLVRtbiJwimxAWXwl8=;
        b=XAKAQjsJ9+VLoJZN86bqWKTHIpbZMdeEv0wRB9SouqXtiENon7UpJ0wIKeqZYvEkUI
         ZDPpINGGabgnZxDISXMYyhhIlNuMPJP9skJFg+2u6TlOWRtXUqOHTlaUx3fko4FfenjV
         1Lhc4CzhmvnMUj1uDxM/FWCgQsTLJSaHL0urxwLnFTU3CWM2wIuXrJhJqFVGpeRtqfJl
         Sp8YtgPsot6zfzyGwlMFWvTU5MC7gk+iOruxIJkZRpaOBQfBzK6Z5UN+FRl9ShvkqgE2
         ZT2fKcxM+XJI8YEp5uUKIt4hqfo8EolrdVD8WyWsl5pKEvzmjzR7kFgtOoyubpCBHrXC
         GncA==
X-Forwarded-Encrypted: i=1; AKwUvByBQqNGdxM1YiiZZ/cXC1GhmlD0EtdZY49LYFwBKkiH72d1rKlS5+Ft5r1aTyKsawDsd0Dfg6I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuNgJHM/zaCZjYMeo5A/uMvdqIPSURCjn9vIuDJT0G9hy38oBc
	CSAujbQcW76yUaw4a50Kwu3n59uLuctZEyP7kDjPyfzghDnWolZmktlv
X-Gm-Gg: AYBFou32U9CrJLmkzNbdcvapa3EirmjbV+FgH0b5B0+obKuvHBMyWF7ma2HoZTDBzBx
	I8blYsoowOfFVp/QGmR4/PkZV//huzqgGTp26FBlF2/r23419cqKxLeEhM4Dt+8ZUhDkDm4EP3G
	PMsbCaQ/KdQGEPjEmJglrQToiCVz1edTNliPpCUY150NN+lvFCD/WSnriApdKsfBwqmyzj+scYc
	Q8hxvjd2fiIUDqCerOHtaP5VCh3piOJd2GDfBMskBDFn2DBFs1xXtd5JcOqIBarVFDJxpjTfLO2
	S0AQNCEVlOvW+SC/QwMv67KxUQm0tVWGuXYD2aYrYxdgEnUX9UUj8Csm1wINJGvt+2zuzBb4gLZ
	agCmxmuHDjZojPMhuZHtMPktzPMkZKyetWsqiRiCeMMYWSuCPXRa0rwTm941kay2+zg54ktHcRY
	c2vSlHB98grM5amsB9hlU22LyueULo1iG8gw6GK+MquZPChN1TViNSKCBib9hGMRyWJeTDOvHWP
	+T3pk7ygSaqo43yCPRR9x8c/GsN+VZPFEHX7fSZhs6cumvpI6TNO/AgReXRUqFd1jd8o8FlwDMW
	kf0Wg4Z9sLcwWnkPaIqXYjD1RVcZgPe//I9FLH7n3+3BggtmtpmBmZ6EYQjt1ddyxcX+IRD3vMD
	9OpU0nsd0Ce4=
X-Received: by 2002:a17:903:1acc:b0:2e5:cb1f:898c with SMTP id d9443c01a7336-2ea43fb8270mr49485025ad.46.1792689775940;
        Thu, 22 Oct 2026 10:22:55 -0700 (PDT)
Received: from test.. ([118.68.116.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b3bc816sm1217915ad.51.2026.10.22.10.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 10:22:55 -0700 (PDT)
From: Duc Anh Luu <luuducanh05051995@gmail.com>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: netfilter-devel@vger.kernel.org,
	phil@nwl.cc,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Duc Anh Luu <luuducanh05051995@gmail.com>
Subject: [PATCH] netfilter: nf_conntrack_sip: fix out-of-bounds read in ct_sip_parse_transport()
Date: Fri, 23 Oct 2026 00:22:48 +0700
Message-ID: <20261022172248.554687-1-luuducanh05051995@gmail.com>
X-Mailer: git-send-email 2.43.0
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

ct_sip_parse_transport() compares the "transport=" parameter value against
"TCP" and "UDP" with a fixed length of 3, without first checking that the
parsed value is that long:

	if (ct_sip_parse_param(ct, dptr, dataoff, datalen, "transport=",
			       &matchoff, &matchlen)) {
		if (!strncasecmp(dptr + matchoff, "TCP", strlen("TCP")))
		...

ct_sip_parse_param() sets the value end to the surrounding limit when no
';' delimiter follows, and that limit can be the end of the SIP message
(dptr + datalen) when no ',' is present either. A Contact/Via parameter
such as "transport=tc" placed at the very end of the payload therefore
yields matchlen < 3 with matchoff + matchlen == datalen, and the
strncasecmp() reads up to two bytes past the end of the message buffer.

The value of the over-read bytes can also flip the detected transport,
so this is not purely a read: a crafted short value can make the helper
classify the transport using out-of-bounds data.

Both call sites (process_register_request() and
process_register_response()) are reached from attacker-supplied SIP
traffic when the nf_conntrack_sip helper is active.

Bound each comparison by matchlen. A value shorter than three characters
can never equal "TCP"/"UDP", so this only rejects already-malformed input
and leaves valid transports (TCP, UDP, TLS, SCTP, ...) unchanged.

Reachability and behavioural equivalence were verified with a userspace
ASan harness built from the verbatim parser functions: the over-read is
confirmed as a read past dptr + datalen, and the fix removes it while
producing identical results for all well-formed transport values.

Fixes: f5b321bd37fb ("netfilter: nf_conntrack_sip: add TCP support")
Signed-off-by: Duc Anh Luu <luuducanh05051995@gmail.com>
---
 net/netfilter/nf_conntrack_sip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 64bc440b1181..1f9cf75c7bd5 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -701,9 +701,11 @@ static int ct_sip_parse_transport(struct nf_conn *ct, const char *dptr,
 
 	if (ct_sip_parse_param(ct, dptr, dataoff, datalen, "transport=",
 			       &matchoff, &matchlen)) {
-		if (!strncasecmp(dptr + matchoff, "TCP", strlen("TCP")))
+		if (matchlen >= 3 &&
+		    !strncasecmp(dptr + matchoff, "TCP", strlen("TCP")))
 			*proto = IPPROTO_TCP;
-		else if (!strncasecmp(dptr + matchoff, "UDP", strlen("UDP")))
+		else if (matchlen >= 3 &&
+			 !strncasecmp(dptr + matchoff, "UDP", strlen("UDP")))
 			*proto = IPPROTO_UDP;
 		else
 			return 0;
-- 
2.43.0

