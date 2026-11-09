Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242480;
	b=r2s/hSiDieTYLkmkqVRcUeDJ38FYGyIVTWa+Njzb774Ye9QOqNr3VfqzOa5SLVtLO9B2
	 KDD8MbK4II2KPGKA1fmf/qgc4tMxaRLLLe1QeNVNNqbTNej2i3ZqJZ6igUeqg80hDQltG
	 BKJMy/xYZA07xgce9dTIPSl7cNdl5sqw0OHkyhlEBoBMTMZ4AHNT3OraIRPuAmbQtf2HD
	 4kWb0iXoYFNoEBuG6iMA7D9cQXcmtOTVgkJOpr8t/M6Tu3WYvJrkyq5TcedZdsC75D9w7
	 duVGLHLwWotWTiYenY+Y+17na1RhSesBh0lCsJZngEOb2rVW1O4pnBMfSo4NlhDuE5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CHFTJhwk8o3vbjDfAurOi0s726zv5dR5BwHLDpqnADY=;
	b=Ux8KqO+16R/nkPcOVsHsN2XIr4al4Q23sePlBnFeNWP3+9fpJJeLLPb74XsYvm5qP00F
	 0OvA7XFD8V3rKNbRXL+Qs31ox1Op9wAn8H9JyRZZxIiK8xZsDcXgI6hqGaOkrzFleHvIY
	 Efbf2FeAa4WayGBu7eUvgoEpYOCAGbhxkIKyx+tuX7e0h1RpcKugN87x0ixizXMg6ecGl
	 vgbkSbGIoQKdHq0yZ8QCyMrS2XyJiPaUT/Ceu2dXQ7wsnCvVaOObtCyV9zrJW86GA1BGE
	 2ZQiSeRMOfDHG3jaeSwB5nXKbXBU3hVJ9T/cKUTJuXLmjv9uoPKd1RQ8vGDxb6XVyyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GhGNCRc1;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CEC606A331
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23CEC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GhGNCRc1
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1307325eec.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794242479; x=1794847279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CHFTJhwk8o3vbjDfAurOi0s726zv5dR5BwHLDpqnADY=;
        b=GhGNCRc1kVQjOY145xHfkbiKQEemuUsh9JpsTB3j6UaZ//X/1MLY7PregsdllFTAeT
         iwWxnHieWaedwloAFeos9JaftimkMPel6oAranE3GeWKRrRHHZrodbddI8/8n8e5fZrJ
         eykLu2eknSvYQqG8AFnPgrWUFOPI+w33k3Q4Pj7uoxAigSoOTF8XJN0k5rapzBm5b2Th
         pE+0I9Teowpi5RkmWe3YcGK/gR2NpsfagdhfiOdXAbEiBPmBPsbNxuj1qXvlQ9nenWNR
         UyiCBVq24CP2jdyRGlstC8VXwt9lC5QqyWNMyIioMoPs7ug04M5p5EPFgnu4Omamx6hg
         7Dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794242479; x=1794847279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CHFTJhwk8o3vbjDfAurOi0s726zv5dR5BwHLDpqnADY=;
        b=zA1v7EvbPxSLscCH5joWGWrsMwxh8pMmZ4Wtou1vgAbHOZNpu34e+Yf9WESlZ1Ih29
         skGqYzjUw+1OE8raJLMzLXNwU4TTWqtb6rKt2dN77Uc9pByi0FEfkSJx+0iZgI4I0o4y
         7iAImMwtzBMspPGeLw2vJy13AD15tv4RvhiO6VTlQRbnpJzkjyLanZHxqzQpvpWVXF5n
         lRmBqPmA+N+Oqv58P3TGos09Hcz1TseRb2xUTW+obd8X1Gxc6VXObZsFWnk5506flOm6
         p/FAcHhfPoeStneujqVZmnulJQ2qMk2KHY665uYnIHFMvUYNyTZxD5bHCHZsZSYunbtB
         LO2w==
X-Gm-Message-State: APuU4Z/g+K4abWlnL/HYXjiBtsSr5uLPNi0p43gnDm04VVMh47L34eIS
	W9xH4pP4TQxl73vmlFr3joFccNAIsduSWiAtNeFWmTJ7YRA7SlgS17Pc0/brqw==
X-Gm-Gg: AYBFou2CcKtE9o8jMqLQvXo240WmbMmVN1hpVSiLwP7OXER9RwUqzllAzqXn4pos1de
	fuAtuuLGpzLbF9djUF7PB+3MlmF06WKdSpIJzh80/7XAGthyhAhaPxl2DJS0X4Hwze+Ku7lm+so
	54GPxEXrfGfgpIJaAUYhTIFcPo1moJFdiLaPfoajUc8ltIuBoA0SaxoJ+4/G0T8DPKiY9tkEW1l
	AbhshSzmtT7DTPudhRsDypmtG4zyuMdqyPBBcz8ifN26cpSAA+htD6hWBW7VbBveOgJgOsWgcK3
	xtU6DBh1h5fMCUSO5pHjfaU63GbVt+g28VOPPXjB9Pu6V9UFnfjoQLQCOiOsV0L+9tBM/F0ajZ+
	XJsgigaj8WKU9qcrOuuJTO20SPq4KsyT8c8XX5rRiRR6Aa8hZvqgyl820p0H9yvCnWWYyG+uqxY
	HsQvZgX1FfmHRbzOzXJNfV3b9A2aEZ/210jbCwAYZVPtIg3toxYv6E6zjacF/wp5vnSqyKTbdVr
	TT6KapHZuADM/AMQn9mgfuOXXR7gzG7IBH3kcloIW/XoQYLUPYQ+RETV2NLvVSD9ARnoW8VKzJW
	CAdzIN6kofykqTvs6U652J1pVj0X2nowMIGRNAZguYa1uJEG3WQpyaX4bbCVmnW67vvlwh96vOq
	p1iLadECha1ujgKDglFyDEfm6CFNhP/m8+73nnVGvr4x64A==
X-Received: by 2002:a05:7301:f29:b0:36a:50f4:ed0d with SMTP id 5a478bee46e88-37256035489mr8959716eec.25.1794242479011;
        Mon, 09 Nov 2026 08:41:19 -0800 (PST)
Received: from l ([2603:8002:ea00:6800:9863:3329:170e:7401])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265618e11sm13634066eec.7.2026.11.09.08.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:41:18 -0800 (PST)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: netdev@vger.kernel.org
Cc: Dave Seddon <dave.seddon.ca@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2 v2] libnetlink: zero padding in rta_addattr_l()
Date: Mon,  9 Nov 2026 08:41:16 -0800
Message-ID: <20261109164116.2637408-1-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.56.0
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

rta_addattr_l() copies alen bytes but advances the parent by
RTA_ALIGN(len), so the 1-3 padding bytes are never written. This affects
every caller that passes an unaligned length. Nests built in stack
buffers (lwtunnel encap, RTA_MULTIPATH, RTA_METRICS) then send those
bytes to the kernel. For example, in

  ip nexthop add id 53 encap mpls 101 ttl 10 via 192.0.2.1 dev d0

the three bytes after MPLS_IPTUNNEL_TTL are stack contents:

  05 00 02 00  0a 7f 00 00    MPLS_IPTUNNEL_TTL, ttl 10, stack bytes
  05 00 02 00  0a 00 00 00    with this patch

and valgrind reports "sendmsg(msg.msg_iov[0]) points to uninitialised
byte(s)".

The kernel skips padding when parsing, so nothing fails, but its own
encoder zeroes it (__nla_reserve()), and so does addraw_l() here. Do
the same.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
v2:
 - Drop the Fixes: tag; the gap goes back to the initial import (Stephen)
 - Cite addraw_l() as the precedent
 - Correct the note on addattr_l()

addattr_l() doesn't zero its padding either (07f9436201eb added the
memset to addraw_l()), but its callers zero their request first, so it
is left alone. I can send that as a separate patch if wanted.

v1: https://lore.kernel.org/netdev/20261104052901.2735000-1-dave.seddon.ca@gmail.com/
---
 lib/libnetlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index edf3a8ba..c4a8e694 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -1502,6 +1502,7 @@ int rta_addattr_l(struct rtattr *rta, int maxlen, int type,
 	subrta->rta_len = len;
 	if (alen)
 		memcpy(RTA_DATA(subrta), data, alen);
+	memset((void *)subrta + len, 0, RTA_ALIGN(len) - len);
 	rta->rta_len = NLMSG_ALIGN(rta->rta_len) + RTA_ALIGN(len);
 	return 0;
 }
-- 
2.56.0

