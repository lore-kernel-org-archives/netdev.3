Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2DA472092
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629773; cv=none; b=Wi3EgaQjB101WhhwzuXxxDlR8pSs8LAlAWXZ46rVpiYuqP7BqKCPUbEm+WKwgtZp64/5K/1rcHCZe3H7NXUts9sIFj/6E9o+186SIdkRSVlaJPI+2J2VwXAOI4QTepBB382e+U0CTbC/hi19Z1GFeOPxEO2kEOExjdcQg3Orc4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629773; c=relaxed/simple;
	bh=cYbK+iFcA/rHB+b8Sla87g88LXLMoRAm5V1nqvPUbZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eFwGdMDtcBk3aptsZFxx+5dzFT1VymdhO79GP8EXdqLFD0VmamDu7DMaLUfSIXfJE/NzYxAKHAtkLDoadiZomGuHo2Nl3NXsjhBCZ9tgNyfE7U7+/qArhLlMScIcEc9j/wCw0AomEndkOnN+BE8amddGFE7b7K/R5jqpHr5gQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jl7Qevi0; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl7Qevi0"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c034a769so43842a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 00:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789629767; x=1790234567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LEz5AHj50hXRMoOhzaQCHtJ4fdUwgfjyyc+kMNRjsig=;
        b=jl7Qevi0ZZA6Yuhq1qJ/n4RadUjYtKfXsiMwDOTDg1rsxka5X7JJfsk/RzpAT3mvXS
         ZLEj8YMBAK7PrulF5VFq2FMV1GqR8PXhRVcLunqrwRj2VN5/4qB2294RmPNy7KUSVdEm
         Jw7HU5LoIHRWk1SugUPLdfgYCXHhBWEi6TujTRMaNnBSBn2I+85i+ayb5ml9utjkYutb
         kWD59fYSg8MvYK0nibKkn2zgCtazNPubWiMAcSomvmackn0n2WD90/fxy49jXf9ASSnU
         HsStYYx51EoQDhPUr0PWuqG5fvvDe23bcLxrQz4EgMoLfJBmLJ1Wlpl3nTGBg/vmZKzh
         CMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789629767; x=1790234567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LEz5AHj50hXRMoOhzaQCHtJ4fdUwgfjyyc+kMNRjsig=;
        b=Ci1Mt+nwB+vMyLq71qevUXIPx7wOH1iZzlYb+JOan8TeGJ0xXAX2PWfj9Ys/n7nRwn
         A6/rci8gM6h5tDbtAZWV9X9qwRKzK7Bei6khTbCytaHIgkX/LdokrXQkk6sO2rY2idPp
         ErOfyQlT2EpFlYMwW11sTCNWq13xfKJZt4V02tuxJYHMx3EP7sosN6gtr98j4v7EaNiQ
         ceYoXYIMWReyPtsb74xMXCC9v9MzRAs/02rMKlLquC4yvJ8CzGxCL8xvgPMOyAfux0YF
         h6v4DSgv8P1IKqsK5QLzUlKukMOtQzrVEyX9Ralbly2hk8+wf2LHzDXQtDUgsRrTqP5q
         katw==
X-Gm-Message-State: AFuF++l2ivbh77ad4RfQWStXUOeNasXX86L/fio1E1EGHXFQKOUIQIrN
	byyaQ3/WpACQe1DxSwtfJFSfxQmev4XDErwmQwa0sTliWZHxOrkpLReK+6rovA==
X-Gm-Gg: AYBFou2aADoxXajNKIWgZ9Al8XbalfdgvvS04GfG8Qd7D0Sk2K6QYG10rqVz+JczU54
	fyF4kEPxlywxow1n9LD7YmLA5b7eCg4bYb6bbPb+wmNrqecuuiV94Vaegrcjfvhk7HGHs749gI4
	BLJ/AItFCZJ+L0N13Bygkvh8+ecI8bi+JlgpcVMNapHh7YWkXHyTL9RiuYANV7nHnRdOZ2s1YYB
	TLuYp963mbUNXo7j+hZWKFr0qKf7UFGeOPvrLaZ5KWUvjCS426hGcHYxMXKw/kH3JHStXV2Zs4t
	oh6ycL7htwLRb48j9fqHXnTCL9WrugiuZux7P9cEUvikyiz0XcqQmjKeJX0NJGyMeOBYPToGXHy
	8fsTYb/f4HajRqpH2K1Tcu+DR3MQidLjQldSDVGTYGaLYtzoICnovIW0Alqpo+sSJrT3QorUyQ4
	3i2Nkdf/BQjbaOVZwL31YPqR7SXrNbCgYc1ie/nVWIblHr2j1+T5NYyIvFH1FKmag6I3lmpAQyC
	pnp5OJPiZQEf8oFTD5VseRJyFfidZjs7fGbvkWGKLWTeLw4Cr2DgvSENEs/aw==
X-Received: by 2002:a05:6a00:7110:b0:871:3a50:638f with SMTP id d2e1a72fcca58-872367ed514mr5780054b3a.1.1789629766747;
        Thu, 17 Sep 2026 00:22:46 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87200d4cb44sm2463091b3a.13.2026.09.17.00.22.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 00:22:46 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	Qihang <q.h.hack.winter@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] xfrm: validate ihl in xfrm4_transport_output()
Date: Thu, 17 Sep 2026 15:22:26 +0800
Message-ID: <20260917072226.80788-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrm4_transport_output() reads the IPv4 header length (ihl) from the
packet and uses it for __skb_pull() and memmove() without checking it
against skb->len, so a frame with ihl * 4 > skb->len underflows skb->len
to a huge value.

Packets injected into an xfrm interface (e.g. AF_PACKET on an xfrmi
device) reach xfrm output without the pskb_may_pull(ihl * 4) check that
ip_rcv_core() applies to received traffic.  The underflowed length then
flows into esp_output() and the crypto scatterlist setup, where every
length in the underflow window ends in a fatal fault (BUG_ON in
__skb_to_sgvec(), or a wild scatterlist access in the crypto layer).
This is a deterministic local denial of service reachable by an
unprivileged user through a user and network namespace.

xfrm6_transport_output() bounds the header length via
xfrm6_hdr_offset() and the IPv4 tunnel/BEET paths use the constant
XFRM_MODE_SKB_CB(skb)->ihl; only IPv4 transport uses the live,
unvalidated value.  Reject the packet when ihl exceeds skb->len.

Fixes: b59f45d0b2878 ("[IPSEC] xfrm: Abstract out encapsulation modes")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/xfrm/xfrm_output.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -66,6 +66,9 @@ static int xfrm4_transport_output(struct xfrm_state *x, struct sk_buff *skb)
 	struct iphdr *iph = ip_hdr(skb);
 	int ihl = iph->ihl * 4;
 
+	if (ihl > skb->len)
+		return -EINVAL;
+
 	if (!skb->inner_protocol)
 		skb_set_inner_transport_header(skb,
 					       skb_transport_offset(skb));
-- 
2.46.0

