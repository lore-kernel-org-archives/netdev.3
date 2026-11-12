Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492876;
	b=qN9gDUxfVie1J6Ii8YDmJkk650PTrlgEQGFAtzp5gD7VqSDd/0DyES8uT2IXG6uZ798M
	 h7q56uxPTs3d6y3EQklITk14ZLhIMhHiqJ8PGWEvrh+wzSHCmX4zCJBt3vcXlabTlvc9U
	 4u0Ir1Y3Opk6ogERf3iYNRYDayiAHbZRYreRM3WlE1PErAj39sCCaHMSitduiMh4g3W+W
	 zPU6KXkmBW0aRPlClMi2rLZO1DlaEsEenUoWbru+IMb0hT1GmhNJMps4pBv9dYqp+84SI
	 tOeQ9RbyaIv9xr+LqPI8jc0EYQ4LHsIsYzV9NTaJC0SlQDpLRz5bzgc7lBz3m7M5VRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gmse3RVh49alRNIAIKdytqedLYNbhBmce0YGEzTfNVU=;
	b=rfqvw+2pESY1jyRIWteAiO9JhXLT/x2RXa9FTg3uQfNqsdN50p/cwKQN84frPf8qNqB7
	 H/Lp2xp7t8Cwb3Es9jRhCQgTFVmOCU7GQALSKzXfFhyXqJ63qXQn73OHEAq6v3M8orOm7
	 LzuJmtgjiqwaqef57zCdSZvRzwA4IrMwy0TH315wgFuhG2WUCNWZSlzP6yyQj1MqTaWF9
	 uUjjCRCf1vx3Bku76F4PMGZ0vOO5hnCehMF0zRYigArStxL9hgw+CwMce9DaosxOdu12D
	 NsQ+KgvTtaIgdws4UaENhUrrDP96NIisCZt5p5KinIoES76IHE2J0hAI8LETR2oX01A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D3YpAHRO;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB8606A327
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CADB8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D3YpAHRO
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ed1414df17so18670785ad.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794492875; x=1795097675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gmse3RVh49alRNIAIKdytqedLYNbhBmce0YGEzTfNVU=;
        b=D3YpAHROn2pVaGCLSNeVX3f9qvU2l8XQkswjDMpoqNvLwbCTRWJCL9Yr7vRh18U2A+
         qatH82z3MV0p2ID33vtftENJEzqEVXyMhQr7J8gT79VdzLmwdqsJHw62PJJ6yXBNWSwL
         WMHkVd/zbbgqGKS8iif9zKDdVJE3LNbJ1Jh/846BeKOIt5QFQuytv0d3lzA0yHSFeul4
         dlelEyW2QvSmUT/TCAP6rdrTApmC3xNODo9lkFxIG1ytTPn9ZGofP2z4aIL08CGt3LlC
         dpoDdKQIJxmXI2o9KW1PkafQM5O8VVqgATYN3HJAPDSY2s9rZf4nt3tEu3jFpUBN9wfM
         2Uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492875; x=1795097675;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gmse3RVh49alRNIAIKdytqedLYNbhBmce0YGEzTfNVU=;
        b=cfM9YxiCyxdsUuvwZolt1Gosy4Jzki2YPMIFdgkFjpMRSpXeREUIxyxCoBmohxo4c0
         7nRekQ3HXrAFn4oLZ6tARTgFN8tLNkP9vA7bAty7S4VrPflDyWuam3zgdiGGp62QGPg/
         saxNaJJrVHOLfVe3QklOD+sMcKolfQDEnS+LtLEn4RNnh/CEDJFr4V9Sz4LxLxK2AckZ
         VoEO4OG3oqro4m5DTYG5Yh3h7stgBpQcOdQxi7wIQ2bFzsgYf9zxAEE4Punh215ZmlFJ
         6azIubM9N5xfQi7SNpujZC0fauEhtg2yYmFew2lgQzQ6LwzSVBie+m2rslsgVH/fwHBA
         L+BQ==
X-Forwarded-Encrypted: i=1; AL+hErHpNyJUbJAnO+jpPfSbQnorNAlspRyPdskelJuxxaTgoS9lve4EvbiffXzf36treKAJGkaKAQI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+m9Vx7MXu/wEHQB+Y80mSZibgE522eNXSDwLAWM7VA+aEWmCBG
	hglojmJFf8Ud/qYPjlH6P43RQHBl6Ab5tsravJwfVy/4N77NiFPmmw7H
X-Gm-Gg: AYBFou0ds3xnt/yAaXa962O/nW8Sm/owuihIsMz2OZ8SYuZcCEPOY5v7ArNLGzOenWA
	d6k5MsHAKt1n8HTT1NWPVN43VrbZpcYv1UwF2n3A0K+rYil417wkLlDVkpgZ+fYiGv6Oe8kgDi7
	sf/+OVMIGdhosCtioXWSsk3qzFzm+TEa9wDb7oLDKJjXYrw6nfUZi+ksWZDbi70Sz8IQ+Pm4NZy
	2zpaQeOjf/8IcMR3+/lBcSpBFapLNoiWT4Tqrk/pCmojSdFCowRP0979PwqeZ7iPQmYkAnO067u
	WnBZCJYyU6q5kSaqaeX46WGHJ+XWiWfKebTlOJpg7yhuoCpfmy/+adqvdnxH5eVZtGSwwkQRNL0
	AtIbHtve2UfVSNOSaWiReD8DIqoJqFjh9BdWKq3yqmz+x+Y/N+8qqmXDAoZGSM5ydFbVGvjWGy4
	V/SzDa2ktPLDNSY0NuLIb5o8lIoAoiWg2WDucQRBj06pOTnuN0GHS9B3GGusqCTdJ6tgzsJJjD5
	g0okN0LUZ7poieP9xZmjDI0USFjVd4VnY+7eZTabJ6/9cEjoFN7QklwFLB6jQSmf/zaAzDHOHzQ
	0+Qj3HNLiyG3PrsFfcLbnRIBIZSS2rW9bKYo
X-Received: by 2002:a17:903:198c:b0:2e9:cd03:b432 with SMTP id d9443c01a7336-2edd7ab1e07mr62652975ad.60.1794492874759;
        Thu, 12 Nov 2026 06:14:34 -0800 (PST)
Received: from [192.168.122.1] ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4a98esm35378835ad.19.2026.11.12.06.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:14:34 -0800 (PST)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net] netfilter: nfnetlink_queue: use verdict sender portid for
 expectation events
Date: Thu, 12 Nov 2026 23:14:32 +0900
Message-ID: <179449287223.132952.1536491080157978119.c244-nfqueue@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

nfqnl_recv_verdict() checks the verdict sender using
NETLINK_CB(skb).portid, but nfqnl_ct_parse() passes
NETLINK_CB(entry->skb).portid to
attach_expect(). The latter skb holds the queued network packet, not the
Netlink verdict. Its control buffer does not identify the sender of the
verdict.

Pass the verdict sender's portid to nfqnl_ct_parse() and use it for
expectation events. Do not change the queued packet's control buffer.

Fixes: b7bd1809e078 ("netfilter: nfnetlink_queue: get rid of nfnetlink_queue_ct.c")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
Tested under arm64 QEMU/KVM with SIP and registered userspace conntrack
helpers. With conntrack events enabled, NFQA_CT/NFQA_EXP verdicts with
NLM_F_ECHO panicked on the original kernel. The changed kernel delivered
the UDP packet, created an expectation, and sent the event to the
requester. Both kernels completed without echo. With the default event
setting, a multicast subscriber also reproduced the original panic.
No deployed NFQUEUE program was tested.

 net/netfilter/nfnetlink_queue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 90d887546f7db..9fe2e85a2b3e0 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -1771,6 +1771,7 @@ static struct nf_conn *nfqnl_ct_parse(const struct nfnl_ct_hook *nfnl_ct,
 				      const struct nlmsghdr *nlh,
 				      const struct nlattr * const nfqa[],
 				      struct nf_queue_entry *entry,
+				      u32 portid,
 				      enum ip_conntrack_info *ctinfo)
 {
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
@@ -1785,7 +1786,7 @@ static struct nf_conn *nfqnl_ct_parse(const struct nfnl_ct_hook *nfnl_ct,
 
 	if (nfqa[NFQA_EXP])
 		nfnl_ct->attach_expect(nfqa[NFQA_EXP], ct,
-				      NETLINK_CB(entry->skb).portid,
+				      portid,
 				      nlmsg_report(nlh));
 	return ct;
 #else
@@ -1863,6 +1864,7 @@ static int nfqnl_recv_verdict(struct sk_buff *skb, const struct nfnl_info *info,
 	if (nfqa[NFQA_CT]) {
 		if (nfnl_ct != NULL)
 			ct = nfqnl_ct_parse(nfnl_ct, info->nlh, nfqa, entry,
+					    NETLINK_CB(skb).portid,
 					    &ctinfo);
 	}
 
