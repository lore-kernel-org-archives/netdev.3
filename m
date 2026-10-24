Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879443;
	b=5UlVxRQn7zTXn5ZnHxNTjC25vWHUxq0hcvA9OKYnCn5AdwYA5TGRPKi1mk/jRbq7FIqy
	 J/rMPj9od9kfMWcKy7dfe6IFhvRjDYTIlEhDLDh51Lwk8VdXvn8ENVJJSZ0a/mRN8Laqo
	 8wRX8W1tqqctsj5LFEvxvV/rFcRokBA4zDCz+pSGoboBaJjc/muA3hW1CekZLco3A13+o
	 q13d7hxDtGxwyeVGu5p5o91aNOETlUzXTU1nad0I9DwerbxIuuwGmfNzNCM4Gi7CShJEX
	 SWihcExbjJFcZSfahVup3skyPl+1kPOsCmCFUT0lQCoIMiQaQ0oW0rwenPWFjym0Ldg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=feA+qfM2JT212n+bZvJFkoTE7dwa45VjU7+TBhyDFMc=;
	b=Hf06aSAL6C3in9/NRfTwNpcsjTqnBje6//Q2URebdwne78v8sxAffkH8ysrbVlnRp8yn
	 9xFv3ZddZZI+AS6WRS7HT8A92NM9bxFHS9cvXHXbo2pKlm/DBBhN4IMBgwZCSbQzMrQm7
	 04+W1blxgorp1GLCPhDa98Z84Nou5TL207c2pMsjE0J5atCPTWh69vJrR9mr5GxSNxCz6
	 xtAvO4EuElFWtVo7M5gqc3NLhdPaofkzadX2Z7duQuK63Oo85YuHmQjUuBD/sidZsvK3o
	 35RpYDycgRc7ewmX8X3J8ceswEM3FsP5vCMYxaN3zEevt1X/vTNW6UqN3Yt8M/hE6kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qpurg3WZ;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A22D606A31D
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 22:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A22D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qpurg3WZ
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7c2f48f3a96so641419137.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 15:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792879442; x=1793484242; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=feA+qfM2JT212n+bZvJFkoTE7dwa45VjU7+TBhyDFMc=;
        b=Qpurg3WZlVKu/5kUAgA3mUMtBMev8bft64H4KwHPRWTz7VAGhMgBHfEU/UmjoBky6m
         2dn6ym1ynQ6Fr4C5gKOHTfJXH3etTBaq/8bvvGEite2/DQ1cSStxBHJzguex8DVYNEju
         rfatDNsVtGRzFbxWBzRrJ+rJRn5ptLdr2ISd9WjIximFOjOkOEDMImxDlQOuTZCtvtUQ
         Un+s+U3s1b4dkc8RqpZ6+jk+RZnNbE0p1eQIajJNCQE2v2SUD6SFnVltPL5MN4Blb9Z+
         w0capXhjjTmqrLIVjooEoHKPlgtC+qlQ2yZCXxTrxm+kYILlfbNR8EhzufLP7a5c6Exq
         p6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792879442; x=1793484242;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=feA+qfM2JT212n+bZvJFkoTE7dwa45VjU7+TBhyDFMc=;
        b=2YbaGKmbj16ePhjb6PRQ3Z857nrIUq/dho4SiEcWy5uQ0VwzMvWrMBOUaah2Opw+yi
         svnhCPZEF8oBy08/ZG6LJFN8+SMo7U6IrdRRqSzttZC/K8M6iMYnZrCE1om34D9jLvwk
         xTl/pfGC+K9OTPbAs09IQnTrzOhC+/IpxWsfcDT4/dvTCTbB/pCu/F4g7pLO8dqZmZgN
         wj6HSK4DUoIv80ix4unAcEq4YTuZLHsk9iIVcNSo5/n8PAOkDberIetWozpc+WYMBUJ4
         Od7D4Md+axc/E8zsJo6esentpoN2vUYZSR9ll9T6dj8x8hSNYFr8kc8J56eBWjXBE6me
         hWqQ==
X-Forwarded-Encrypted: i=1; AKwUvByF31rguR7N0kWWF+QiJm5syFQhbnySE9ccg2Sm2DzUNZO5fINurcJea/hbW1vbLQo4V5BYJo8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWPjUvAPbbG7Gs7+KABRWhRpc8k8z/Lt/rVZL7xEOut/qoN09E
	o7CC6svFRGU0XgUdQuIgrwZAmlB21s49CmuuoarQlgPG91jjStKS5JqG
X-Gm-Gg: AYBFou0+/It3veQTGUuY2e1QoyZy6ow4L13u1yH/6sKaV2ImTaol1Pqi3PA1x7Zx3Rc
	mWTHp+oyo/hTlm/y9y/ysnuJGmzUk1W/bVZKCumhxOndLq6ztkFgPUVlE7Ia8g1PUZJU99LBIcG
	WjsBxKZOFPkqqU4Fv/RlUJpGO3H5FPkm2fDbj0oWLJSB7xLJvTsPRvd7OH2rIYLE8IWy8Ut5IDj
	B7t9POlHkrtBtwivWf7JcGNww0+qibCdMfnr5CBdAmDdHqiue/ns9T+dqBluuohoQIokD/Z49OX
	47qoKyUZanswsxCITvr4/hfCcBEqTbiY9qRLzYJ9sx/7xJXPqILpu6rrI/i13uxpDZeHM6szIbZ
	4inLTjchPnHy9zXBvcuxksxRoE6Nl9HiuPnGd7Dmk9kpqWMQFBCmhXgMhmb/7aMrHDfemLl2LoC
	xQ+NiNSaW26k3UOLIzvjNje52DXFQl1vpozzuZ5AavIhFxMyhAnz+7mDLkOgCUXIKskVx8DOms+
	0WD2r3Q4wcIZ4yZpiTLPVfogfAaHBfs40REZNRpsCcBgn72Eq58VGfgCf5qp37gE1epu4NbwWi6
	BYuoaLVjJepEGsa2q/Hl7RRl5tIqQeH2MKPve6EOa90+gG9UnCg=
X-Received: by 2002:a05:6102:604e:b0:7a6:a24e:8140 with SMTP id ada2fe7eead31-7ce5cd16fefmr631925137.14.1792879442011;
        Sat, 24 Oct 2026 15:04:02 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([2804:7f0:b101:277b:c08d:c9f9:7c08:79c4])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910e80e2d6sm3701696241.12.2026.10.24.15.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 15:04:01 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>, Weiming Shi <bestswngs@gmail.com>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 [PATCH nf] netfilter: nft_set_pipapo: skip transaction elements during GC
Date: Sat, 24 Oct 2026 19:03:55 -0300
Message-ID: <179287943591.17355.17353179557993329094@gmail.com>
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

Since nft_set_commit_update() runs set commit callbacks before processing
NEWSETELEM transactions, pipapo_gc_scan() can observe elements added by
the transaction being committed: nft_pipapo_commit() calls
pipapo_gc_scan() on the clone, which already holds the freshly inserted
(not yet activated) elements.

pipapo_gc_scan() selects elements to collect using only
__nft_set_elem_expired(), without checking the element's transaction
state.  A new element that is already expired at commit time (for
example a short expiration whose delta elapses during a large batch
parse) is deactivated, dropped and queued on the synchronous gc list,
which frees it after an RCU grace period.  The later NEWSETELEM step of
the same transaction then calls nft_setelem_activate() ->
nft_pipapo_activate() -> nft_clear() on the already freed element,
causing a use-after-free.

This is the pipapo counterpart of the rbtree fix in commit 86b6471e690c
("netfilter: nft_set_rbtree: skip transaction elements during GC"); the
rbtree scan gained an nft_set_elem_active() guard but the pipapo scan
was left unchanged.

Only consider elements that are fully active in both generations, which
keeps transaction-state elements out of the GC scan.

The use-after-free has the same shape as the rbtree one:

  BUG: KASAN: slab-use-after-free in nft_setelem_activate
  nft_setelem_activate net/netfilter/nf_tables_api.c
  nf_tables_commit net/netfilter/nf_tables_api.c

  Allocated by nft_set_elem_init / nft_add_set_elem
  Freed by nft_trans_gc_trans_free / rcu_core

Fixes: 1e3b9e1c77fe ("netfilter: nf_tables: call set ops .commit when building new ruleset blob")
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
Compile-tested (arm64, W=1, CONFIG_NF_TABLES=y): nft_set_pipapo.o builds
with no new warnings.

I demonstrated the precondition on a KASAN VM (unpatched 7.3-rc6): adding
20000 fresh elements with a short timeout (so they are already expired at
the commit tstamp) to a timeout+interval pipapo set leaves ~0 elements in
the set afterwards, i.e. pipapo_gc_scan() collects the not-yet-activated
NEWSETELEM elements during the very commit that adds them - exactly what
the nft_set_elem_active() guard prevents. I did not capture the KASAN
splat itself: the free is call_rcu()-deferred (nft_trans_gc_queue_sync_done),
so the subsequent nft_setelem_activate() -> nft_clear() races the grace
period, same as the rbtree sibling.

This is the pipapo counterpart of 86b6471e690c ("netfilter:
nft_set_rbtree: skip transaction elements during GC"): same root cause
(1e3b9e1c77fe runs set .commit before NEWSETELEM activation), same
scan-without-active-check pattern, same nft_setelem_activate()
use-after-free shape. pipapo_gc_scan() was not given the
nft_set_elem_active() guard that the rbtree scan received.

 net/netfilter/nft_set_pipapo.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 978bb0c01..4680969eb 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1745,6 +1745,18 @@ static void pipapo_gc_scan(struct nft_set *set, struct nft_pipapo_match *m)
 		i--;
 		e = f->mt[rulemap[i].to].e;
 
+		/* Skip entries not fully active in both generations: these are
+		 * elements inserted by the transaction currently being
+		 * committed, since nft_set_commit_update() runs the set .commit
+		 * callback before NEWSETELEM activation.  Collecting such an
+		 * element here lets synchronous gc free it before
+		 * nft_setelem_activate() runs on it, causing a use-after-free.
+		 */
+		if (!nft_set_elem_active(&e->ext, NFT_GENMASK_ANY)) {
+			first_rule += rules_f0;
+			continue;
+		}
+
 		/* synchronous gc never fails, there is no need to set on
 		 * NFT_SET_ELEM_DEAD_BIT.
 		 */
