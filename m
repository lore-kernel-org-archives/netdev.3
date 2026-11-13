Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597025;
	b=HgXyejjdYT283y5X+ocepnZNUxhU0CKs9M+EUF4xa6OQky+Uuyw+/raDcGRdv61ZPqhB
	 moARtUtX87c4EqdIXkg2hYLldCOCZf+NnW/+uSmCdVR5oesWAT90Wu1hf3XlT2oiIAb9q
	 lqpn/Sv7u8mPTDvOempZDf70MfGm4yRziPd+vKQonsrrqwW8MkPdWOlgh0MPxL6dxPC+2
	 ab0/NAhM8otJHFhKjsvEp0JewvQDN26IDvJ0zxcJUgovIpNmVuqxf2KEgonKF7EGFQOVZ
	 oEftGwgQA5HimkGV6lg0wer6Vq5Uxe+nVQHBIblZrLpqmNXgnptURPJmPoySWWwn5QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=RosMjJAtVlzCJc7rs194wMep0aU6Akxfcz1/FiHQrxw=;
	b=1PN0FpEC9BtAg8jsDfhxhaIPsQIVXNLn+wTGOgfowD8+L5lq9dQHgmeW72F+azz2zb8P
	 AN4JElxMsb7HQu5k5hqF/+/GjMFBM1oyBC7PHUllTpDIq19OLcRIIh9sLbzZqeUHgEgtI
	 Z48lcKYKtqxc0R3+v3/eKatzZecoAFdo7uCIbpZv6oD2Kkw2wPJwrdR6adHfEqZlkkQnN
	 WCRl3Sk/zknf/8Yx8kDGBvfvdL3Q/4WE64knavvIktlKlZpWij18WgKql8r00wBMEmgg2
	 tjmgll47UoIl54lUrGMbkRvB/Tu5k7xIDYVwQTTP+DfL/n8AaJGr28Wb4K3lvnOOAAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QvDIz5Kb;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670EA606A8A6
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 19:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 670EA606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QvDIz5Kb
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b315dd057bso10209547b3.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794597023; x=1795201823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RosMjJAtVlzCJc7rs194wMep0aU6Akxfcz1/FiHQrxw=;
        b=QvDIz5KbGJg05TGxTHjOW4S7RdmOFLPBTWxImY8Kse59Tmybc8rNnvpmSPpEpBcWM9
         5waryxaNFDoesNKQu/80hF5ztJjQfY9Q0qeAulqRThNEDMzIoaYC6jSqfqgqftj+jTc8
         nJfR9FY55gr0yT60iQbVK7Aa/or+3iI22n32w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794597023; x=1795201823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RosMjJAtVlzCJc7rs194wMep0aU6Akxfcz1/FiHQrxw=;
        b=qCIf6+Yb7eANFGlrWb8ndnQF1h75puNXCygOGSJP6AOl+4zmRmhHIJqbWG30PF5Qhl
         eDb11cWrKyNFTzdXi4VcMB9Dx45NTTLb7wYbrbQyMdXJrVfYyIXLXEhV4khvnM3AkAiK
         V8gn+ViFNibn5IF+eR1YiJ7GpHdlalLTaELATKtnL4VrAfLlr35hRNF4BPKgSMQUcaZq
         JHE/79q2h8mX8s7rOIxC4oQfTv5HBpsAxvs5+MVhLFGVB5Fs94PdPgaqc5Er+5Ec+vbE
         t/OCusaD96EAzptycDTcm7NRBsh/0Is3ps8dqn+mL/3byPfaP0LYyKLu3kwDWnrXs2Xa
         WMiQ==
X-Gm-Message-State: APuU4Z8HcJTaPrTmKFzSXKKlKyEcBwYzbquj6a1w9x3P278d/qA09QjS
	7XIB8pW5Cf2wKPeKZLV1h7E/hEcaPY/xjNvcfQXazGMq9XKnio7tlZ3/keBNE57TJtqGpiuvQT6
	cRNk=
X-Gm-Gg: AYBFou0KsAdX/jiJm5uIjcJN7YcNTBwx++IiHg9cm+ndcnDz+d7ii1tZm9mHEcNXnY3
	MR0C4S0Xd9DW4guMgIjxQJWeHMC8dqCPxxSczouIFGB1oZlnS/BWuyMZzvV+/BcJEzJxXKFQwuC
	xPV5gWb4EWLSj4Mk5SNyR8hnTjMBolBa9J/4JnnFqXiy1R2XHb2Www9Dnrav+vUaU88LMAzHmrX
	AZT5u18e4si2/qDsJJTK7VvSC/0IvUJskZn4tqWxBpnJHuXNoWCXjvlzTKh+1IEwsYVIBBzm3gi
	4XX64vHYdi2ncDbCdV46DFoQ1MjmCrX5lJ/yBRD2kLrrUSosQxpQELIr8lM88GKlwZllLat5Uia
	hUg4ZjTxmhWBN8mM7j9Cc9/I2YKr6JwhtkMag4YfehDehI/T/S2GWirfp8Zqx7Oo78MxKnGZMgX
	mT1xTkr0VIWdCrmwtr8E8g+mXQlLGQkMDmjOX6Mw8wI4vWvcZ/5Uj7Kn0cEsXAw8scsVPUh67tz
	RL3+y0Hcg0bFxHidXHM8Locwjt2zhGdMIlGeDjtdRskpW4zmpEPe/nWyIuMY/bbiMoE1jGvPv7t
	L/xHUpoayT8x
X-Received: by 2002:a05:690c:f02:b0:8aa:5af3:e420 with SMTP id 00721157ae682-8b4aa295b19mr23146077b3.11.1794597023153;
        Fri, 13 Nov 2026 11:10:23 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4d67::1c9d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa9a7db2sm27282257b3.30.2026.11.13.11.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:10:22 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v2] net/sched: em_text: pad the text pattern in the ematch dump
Date: Fri, 13 Nov 2026 16:10:03 -0300
Message-ID: <QDISC-7SHE.v2.r0.20261109072128-1@mojatatu.com>
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

This is a followup of commit 9c572a83037a ("net/sched: fix potential
stack infoleak in em_text_dump()") as reported by Sashiko.

The issue: em_text_dump() appends the text pattern with nla_append(),
which is a bare skb_put_data() and does not pad the attribute to a 4-byte
boundary.  When pattern_len is not a multiple of four the skb tail is left
unaligned.

tcf_em_tree_dump() records the raw span as the ematch entry's nla_len and
then writes the next ematch's nlattr header at that unaligned tail.
Userspace walks the list with RTA_NEXT()/NLA_NEXT(), which rounds each
attribute length up to four bytes, so it looks for the next entry at an
aligned offset the kernel did not write.  The ematch list is therefore
misparsed as soon as a text ematch has a pattern length that is not a
multiple of four.

The Fix: append the pattern with nla_put_nohdr(), which reserves
NLA_ALIGN(attrlen) bytes and zero-fills the padding, so the following
ematch stays aligned.  The emitted ematch entry then carries the padding
in its nla_len, which is what NLA_NEXT() already assumes.  em_text_change()
only checks that len covers the struct and the pattern, so a dump replayed
as a request is still accepted.

A padded text ematch is the same size as the request that installed it:
both sides carry the 8-byte match header and the 24-byte configuration
followed by the pattern rounded up to four bytes, so a tree that installs
can still be dumped.

The kernel has no explicit bound on pattern_len; it comes from the
request. TCA_OPTIONS carries a u16 nla_len, and for cls_cgroup it holds
56 bytes of nested headers, the ematch header and struct tcf_em_text
ahead of the 4-byte-aligned pattern. So the largest pattern that can be
installed is 65476 bytes (65532-byte options). At 65477 the aligned
options length wraps to 0, the attribute is dropped by
nlmsg_parse_deprecated() and cls_cgroup_change() returns -EINVAL. Since
the dump is no larger than the request, the padding cannot push the
dumped TCA_OPTIONS past U16_MAX.

This also removes the last variable-length nla_append() caller (sch_gred's
is a fixed-size, already aligned struct).

Conditions to recreate the bug:
- CAP_NET_ADMIN on the target netns (unshare -Urn is enough)
- add a basic filter with two text ematches whose pattern_len is not a
  multiple of 4 (e.g. 1 and 2), then dump it with RTM_GETTFILTER; the first
  entry comes back with an unaligned nla_len and the next entry's nlattr
  header is written at that raw offset, while RTA_NEXT() reads an aligned
  offset three bytes later

Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260918133953.12494-1-bernard.ladenthin%40gmail.com
Link: https://lore.kernel.org/netdev/e0f4776a-0457-4069-9f79-3c97de2a54d0@redhat.com/
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
v1 -> v2:
- No change to the code since v1.  Sashiko (nipa) reported that the added
  padding could push the cls_cgroup TCA_OPTIONS nest past the u16 nla_len
  limit, and Paolo Abeni relayed the concern and asked that it be
  addressed here.  On review the premise does not hold: a padded text
  ematch dumps to the same size as the request that installed it, so it
  cannot push TCA_OPTIONS above 65535.  The changelog now explains where
  the resulting pattern_len limit (65476) comes from.  A guard for this
  would have been dead code, so the patch is unchanged.
- A filter at the maximal accepted size still cannot be dumped, but that
  is the pre-existing netlink dump skb limit near 32 KiB, not the u16
  length, and it is unchanged by this patch.
---
 net/sched/em_text.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index bc45edb8c03b..1e7b41e579e2 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -128,8 +128,8 @@ static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
 
 	if (nla_put_nohdr(skb, sizeof(conf), &conf) < 0)
 		goto nla_put_failure;
-	if (nla_append(skb, conf.pattern_len,
-		       textsearch_get_pattern(tm->config)) < 0)
+	if (nla_put_nohdr(skb, conf.pattern_len,
+			  textsearch_get_pattern(tm->config)) < 0)
 		goto nla_put_failure;
 	return 0;
 
-- 
2.34.1

