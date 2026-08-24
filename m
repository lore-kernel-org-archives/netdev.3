Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89036F8E6
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584867; cv=none; b=TNW/xI61UVAoNhkU8LlE8j+uL8NZ7u0uf/UCRRnInJVb9i5/zaC32o5pEAdWF+Wzrd6VxrH+6F0mM+Avmpa/nToW1PXR1T7mZq4t74P5R5QViolakFCWz/T2xM+L/UiVUTqCIk2rUNmPFptmQzwBgw1T9eraHF7bkMMKp6F6gOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584867; c=relaxed/simple;
	bh=XY2OgZaePqMnmpH5RREj5/3sAFhLh/26g3/Ol4N3ewo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aoVgjJ7U5hfq/vxFpXUaSZsuRBqODQicOWhIdG2lj3HqFoY2E1Kl7ap3VqVe3dL4G5TcCKCv+6W7seCkF2DRx3jCvSA1Jk5h4KBk8MOA2xsiWZXCnrES39HVAznHpJFP6Qr0AoCY4FeqLhMhFCqCrbQWCCgmx+cWvwZz9rAGFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RALPA1WH; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RALPA1WH"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81fffc7e5dfso3021527b3.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787584865; x=1788189665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d5uQFclyHynCG/0FLEAf23P/Cd+g9q80jm8OGZqPvec=;
        b=RALPA1WHSXLP1JkVHUcJDsei1iEPqgWD0iiFuxtwm4WM7nrvQXlWkNENjFaObGAzSU
         r9McLzOd33bgGf5Uc2yr1VeqDSrKWLl/zluKCrSCZe9P5vddqgYi7nr9PvUnE94oI1et
         1XF8IGUEnIM8vhD3GOXE3/B/Bl/Q6XTMN2f1/cUvATabIkVV3Wjd7XVdiPfqukfUOB4w
         lTHL5V+mYlFz5a2Ci6vJmCIXsAq6TBdk6y4CEMhk80TMsMRSXJ4GmUGxtI6skml9jjG5
         1s7J7nHMoGC2hDnntkL0h3EpCQ9oytzOU9JL+TqUyxmTs9aRTb/fmsOZTf99Lh0j0tzb
         MzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584865; x=1788189665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5uQFclyHynCG/0FLEAf23P/Cd+g9q80jm8OGZqPvec=;
        b=n3WUA7FLY/cYeeVshefJf/ZKUAEkhrR2qwqJqM5KtPKZ8tqicTgaWZsi1Rz7P4XYsk
         qOUbP7gDwdHjIVKBeNJ4Bmp+W2SBdb5cYIGhgwBpGuPHnmIZ3hyzMXj4A2AzTHWdVusQ
         5k0l782ovmVYZ8b9Y39W+AMbBJ7X99QwlDc3GIgM03ZwNGb/pJCwq+6rVRpy5D5Jaa1I
         xTEhR11tj7YR86CRHIrClRyToNPlHqSA/5RiOxUWKos8uxuGtnrgekBA6Q0/WpdCtACy
         SfJrP6UGGM/yf6YJnQg4gm/0mZYt07RKrNTyb+dlKDfkEraEE6cNlXPSFnx3yVijtO/N
         PJmA==
X-Gm-Message-State: AFuF++mS8NqGi5vBuADxMC9+y0w8UR1UmMcq61r++fq7GaFPsTBCUkDg
	USRcTw6/LvOL6u0GwY2r+SNdIt1hdP6eRgPNniXGs6druPg4VTnWdO/P
X-Gm-Gg: AR+sD1174ZH7x7UBEm2mWwzb9cN4KecTZO3xRaqqljn1rs8Ld+gOFxJGOSTaTCTwL61
	YJWbwtJhkyDnrqyS8FD6jb3+Ap79FrW26JlFCuSJFNPVQgPhvwvkFUYyXMKec3Ik4ZDDvfv/01J
	7XrDeaDpKLQ6YsrjWBJ/3r/GasHz/XITaNBT5gr3LfTkaG8fG6qrRUxbLSMS49qiABYljrbEs9d
	5HSO9AWHEoWzaOMVZKes1qemp8xij/kCMRPu984GIlFUe/DENXQjtLknLY+fO28X4KVQJqDuseA
	FsyizzU+5FqAk6HcXHQ+lR6NDxmri7uXO86I8l1MNSIFnlIlsQK5m3fwUCpEf1HmCjpkm7nO1aQ
	LmGx1Bqz64X8zowIItDNEo83cNZerBOrOAsAFOc7B0Pi9jeogyHLguechY56jXxjZsiQMKtKyJe
	AV2a5ANC0cKduC1EbSyEmWrXMNvS8uEyJLgMn5Dc4gxqXbrewuwc3C6/1FVbCPbc9raDEs1ioeZ
	i023AP6mB33+DPbDNyZBtWBEs3pCiwBV4ys+TdlFdphxpArh9GxkVRizqLc8DQDIw==
X-Received: by 2002:a05:690c:4f82:10b0:853:bc96:d834 with SMTP id 00721157ae682-853bc96ea4emr10826257b3.2.1787584864959;
        Mon, 24 Aug 2026 08:21:04 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cacac4e25sm35572937b3.47.2026.08.24.08.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:21:04 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] xfrm: retry inexact policy lookup after node reinsertion
Date: Mon, 24 Aug 2026 23:20:57 +0800
Message-ID: <20260824152057.216329-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a newly inserted inexact policy covers multiple existing nodes,
xfrm_policy_inexact_node_merge() removes each policy from the old node with
hlist_del_rcu(). xfrm_policy_inexact_list_reinsert() then immediately adds
the same bydst node to another hlist. hlist_del_rcu() leaves ->next intact
for readers already at the removed entry, but the add overwrites it before
an RCU grace period.

This permits the following interleaving:

  CPU 0                                  CPU 1
  -----                                  -----
  reach policy P in the old hlist
                                         delete P from the old hlist
                                         add P to the new hlist
  follow P->next into the new hlist

The lookup can then skip a matching policy and make an incorrect IPsec
decision.

During concurrent policy insertion and route lookup, KCSAN reported:

  BUG: KCSAN: data-race in __xfrm_policy_link / xfrm_lookup_with_ifid
  write to ... by task 92 on cpu 0:
    __xfrm_policy_link
    xfrm_policy_insert
    xfrm_add_policy
  read to ... by task 91 on cpu 1:
    xfrm_lookup_with_ifid
    xfrm_lookup_route
    ip_route_output_flow

The per-bin sequence counter already brackets inexact tree changes,
including node merges. Snapshot it before candidate discovery and retry
after evaluating all candidate lists if it changed. This rejects results
from any traversal overlapping reinsertion while leaving stable lookup
order and locking unchanged.

Fixes: 9cf545ebd591 ("xfrm: policy: store inexact policies in a tree ordered by destination address")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/xfrm/xfrm_policy.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 932a313b9460..5d4e863863df 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2157,6 +2157,7 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 	struct xfrm_pol_inexact_bin *bin;
 	struct xfrm_policy *pol, *ret;
 	struct hlist_head *chain;
+	unsigned int inexact_sequence;
 	unsigned int sequence;
 	int err;
 
@@ -2191,12 +2192,18 @@ static struct xfrm_policy *xfrm_policy_lookup_bytype(struct net *net, u8 type,
 		goto skip_inexact;
 
 	bin = xfrm_policy_inexact_lookup_rcu(net, type, family, dir, if_id);
-	if (!bin || !xfrm_policy_find_inexact_candidates(&cand, bin, saddr,
-							 daddr))
+	if (!bin)
+		goto skip_inexact;
+
+	inexact_sequence = read_seqcount_begin(&bin->count);
+	if (!xfrm_policy_find_inexact_candidates(&cand, bin, saddr, daddr))
 		goto skip_inexact;
 
 	pol = xfrm_policy_eval_candidates(&cand, ret, fl, type,
 					  family, if_id);
+	if (read_seqcount_retry(&bin->count, inexact_sequence))
+		goto retry;
+
 	if (pol) {
 		ret = pol;
 		if (IS_ERR(pol))
-- 
2.43.0

