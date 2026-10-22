Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695771;
	b=33RDn/1P5747gLQX0gbNdMc2piWikByklC82D4LrTurtCafsZVEQkRRnrQeT0P4BDrVw
	 tdiUzRPuAFSWfqYqPvQ6nNzyrKZciitLDtchFVQU4FdSbSQTCqueYSbsGB45BLE6/ITqa
	 dslZMnBjfOaJor9/oySP89e1vRso3tfdzCQB+ACkGkM1EL6QphwfP4aWk6osU6lrkNefD
	 gwpvWt/pu0ADffb/lws3l95LbACgUBKRlbUbU3sGs7RQe57lHzya9qS/++/D3byhhVpjF
	 kKwXoNo45dbWNpxiGLPy8JcONM5Z0IaIqfo8ma50fbwzoFJ6pSaO1K1pBhcUc1T5tLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695771;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+zwGxarJ/1S5oxQIZwD2h80em+XqZO5ZdW0t4BXY10Q=;
	b=IbpJcP/fRPnuEPweb5hgMd5iA5HdFRxG1EBTR5Jkk3LB60CK6O0Srs0DXt/8oj6VwsdH
	 hOxRN1p1vyWt3N1YbPqou51Dpyt0eldAU7xcw9Wkz7GUCnhLWHUGKOmZpK//8bs/IK+lh
	 jCJmb295tTH1bXT/hLF2MpyxnlJM3Wg7AWRjL2KDGHVouhXPtrFn5gsnOMUEKyZ/BG+Ks
	 m7GNAI7saX8SY96g4kO4/FKVArHmscOmca0Zf66sTngB0KzvCuwo5JSkdP4wRpiyup4Kb
	 KI3K0uVvIUF+/NbfL2dNUQithREJx2BOOaD3UqcsypYJ7ppmFWHQikLlquBpJ18pfhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRLHXFm0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5BB606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRLHXFm0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8753F1F01828;
	Thu, 22 Oct 2026 19:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792695771;
	bh=+zwGxarJ/1S5oxQIZwD2h80em+XqZO5ZdW0t4BXY10Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PRLHXFm0Gy4EcHngiLErKKOcNnStE7sASc+Hha9P3I+qBGHvc/JSGGFAh17pssInW
	 V72HagFTAPNo0PnFf9hyX6amXfWE9AD1cYf+mnKSux8C+YARV9ZZZDRUXyIZ1V4Au8
	 8cXwLrBCFqdYvvwIidjKsHElzybtZacHyhhYNQ95gKVHnlIWt7BzR3QycNrhlkgUSB
	 PfPvjvkt0njUCu+PLgR0KOQjBthytGqlgoGHiKQitpm2WG6qdOeApSaNcxTGmPnIjQ
	 qATF+ws6E53V6h93431sx//lT4XbqGgu+JUzyuZd61I386LzdOJ649UfCVWpQKMctD
	 tShOZSEi7y+ZA==
Subject: Re: [PATCH net-next v7 1/4] net/sched: cake, fq_codel: return the
 classifier result to the caller
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, toke@toke.dk, bjorn@kernel.org, sashiko-bot@kernel.org
Date: Thu, 22 Oct 2026 19:02:50 +0000
Message-ID: <179269577009.3135.5221412623031392098@kernel.org>
In-Reply-To: <QDISC-BA27.v7.r0.20261019115505-1@mojatatu.com>
References: <QDISC-BA27.v7.r0.20261019115505-1@mojatatu.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message body opens with the heading "The Fix:", but
  the patch fixes nothing.

--

net/sched: cake, fq_codel: return the classifier result to the caller

This commit changes the external classifier helpers in cake and fq_codel
so they no longer compute the flow hash. The cake helper now returns the
filter's flow/host overrides, and the fq_codel helper returns a 1-based
flow index or a request to hash. The enqueue callers then do the flow
selection themselves, in preparation for later accounting changes.

> The Fix:
> cake and fq_codel run an optional external classifier from their enqueue
> path and then compute the flow hash inside the helper.

[Severity: Low]
This isn't a bug, but is the "The Fix:" heading accurate here? Later in
the same message it says:

> This is preparation for the accounting changes that follow. Packet
> classification and flow selection are unchanged.

>From the diff, behaviour looks the same as before.

In cake, cake_tcf_classify() returns true for exactly the actions on which
the old cake_classify() returned 0 (SHOT, STOLEN, QUEUED, TRAP).
cake_enqueue() then calls cake_select_tin() and cake_hash() with the same
overrides that were used before.

In fq_codel, the old fq_codel_classify() returned 0 (drop) in three cases:
a terminal action, no filter match, and TC_H_MIN(res.classid) == 0. The
new version returns true in those same three cases. When it does not drop,
it hands back the same index or hash request as before.

Since this is a refactor and not a fix, could the heading be dropped or
reworded, for example to "Preparation:"? As written, backporters and stable
selection tooling might take it for a bug fix.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v7.r0.20261019115505%40mojatatu.com
