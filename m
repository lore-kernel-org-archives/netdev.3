Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D313EB11C
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906743; cv=none; b=np2nT9hspBHtwUHZw4cuhOvpqMdFcqD+MBksSIjOSXzgtNnTlPL+OgezWk0C/qDPSF/CXDBVUa8sn2u/srWJjyQxwbvU3gxlMyS+9mQq5v0PqATTdeRHFcjHrO80TebLARCWzjbwOSM8gkmZOYfnSz/U+FxjpHqCk66UEZnSNlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906743; c=relaxed/simple;
	bh=TfjIGFks0uKjHUIX+/R/64xRNRu/r3cOpp0rCkVNphA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cAn049l1XvqHfz88lSedzfXnqO1oWr3cpDP0foeHw0ehSn7+VNr2kYwzEpk1cY5hyY6p4c8iQk7aD2GQjY4pQbYBq4M+oFEqRoBEAePU7sxOjPXkiOL9EwgJUDTgp4v6izY0zOqHx34keiFn2OifQebdE4Qj9u+pzFSuc8rtlvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=svqhnmXH; arc=none smtp.client-ip=209.85.128.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svqhnmXH"
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-836c8fc09cfso10820567b3.1
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 01:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787906741; x=1788511541; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UxyhAKbChfLsRJB69A5919kruouQEI3EF/tFzKGu6jw=;
        b=svqhnmXHshM7sf4lUgCvScpf/mAztmYpRLYF/rSKSjfMvS3M/WrJGa+KAU0h8WGkCp
         DeauJnmlfqezSJNoYPZ374i6lAr34VgxFQ1RFjRfzeXk9asY9PmtVzwTi26PgjYeXLgv
         sKtN/MDKd4nKbTW2TIPU778Zaz68gU8ASuRn9FIn1JnTkSJg5mxl+P1DW1xpafPNNR1c
         lJQx+YaNQd1Pw/10X6NJAYmVqxL/klJ1gnZ2ulQiDZDxJLwlPjItnCx1fzPmrgo1xJtF
         +WIS1OxQObbH2I2PMYgAIjmwnBnsbB6DTqS1N7M4wYUFnHJ44AGmBGdDCuJLxCorSB+0
         LA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906741; x=1788511541;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UxyhAKbChfLsRJB69A5919kruouQEI3EF/tFzKGu6jw=;
        b=k3Clb6/MfPzPX3ky0FF59C8LCKktrtbh+pqC415cRX8zqwZFb5Ac1Kgk7/LBAXWnzJ
         6b4PdPYTXFNrH87OH7IY+L4olnrBZEjcqOYeZsRIswQYhOuZmSzsQ2HLdrynC/UxBuCe
         JBzN9xyg8CJf18WjMQIMBnAT6cNLoho9sYkOtL61NLufFIf4nM8Z8dCK9iG+Fcsvpour
         /eZwZ04KlwOSGm1QsLlgjPnHCOl9dtE2iGvo2eq8iRNlZPYYTW9+6eGacb2MiYTRuOeH
         NV2YOQ3sfpJYMpys7TpiYQd3cdKFjBe8pxtpV1bcothai5PJxnEcixZyG/GJWYuek7op
         l3LA==
X-Forwarded-Encrypted: i=1; AHgh+RrcPzveYe8XEPL9+ZhcuFaFJp+Ac7j33+nD2RwngyhZRyPNjz7uLrfjwRVDxXoeI6jYnjqwKlc=@vger.kernel.org
X-Gm-Message-State: AFuF++n83Cy2sz4hOo6l5OUF8HQFsdmDqFMLcGIVa7WXYHRBCWiE4xvw
	A9RUd9Qy3BeDHdJEnopQRqrkgQwPgV6Z1LSxkRUCaSL0cRy2ZEo2V/cBSGntiFumcTo+3zAjbDN
	mI0NTNv/zfAALMA==
X-Received: from ywzz26.prod.google.com ([2002:a05:690c:a71a:b0:85b:762d:a27d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:a7c3:b0:81f:889c:2078 with SMTP id 00721157ae682-85d660db898mr21732467b3.7.1787906740390;
 Fri, 28 Aug 2026 01:45:40 -0700 (PDT)
Date: Fri, 28 Aug 2026 08:45:27 +0000
In-Reply-To: <20260828084531.1826790-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260828084531.1826790-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828084531.1826790-2-edumazet@google.com>
Subject: [PATCH v2 net 1/5] ipv6: mcast: fix RCU list diversion in ip6_mc_del1_src()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Taehee Yoo <ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When removing a source filter whose count reaches zero, ip6_mc_del1_src()
unlinks psf from pmc->mca_sources. If the filter was previously active,
the code moved psf directly into pmc->mca_tomb by updating psf->sf_next.

Because pmc->mca_sources is traversed locklessly under RCU (e.g. by
ipv6_chk_mcast_addr()), mutating psf->sf_next before a grace period
elapses diverts concurrent readers to the tombstone list. Consequently,
readers miss remaining active sources in pmc->mca_sources and improperly
examine deleted tombstone entries.

Fix this by allocating a new tombstone node for pmc->mca_tomb (as done
in sf_setstate()) and retiring the original psf via kfree_rcu().

Fixes: 4b200e398953 ("mld: convert ip6_sf_list to RCU")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>
---
 net/ipv6/mcast.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index aaba4c2aae23ef378e6328e6eee880ee1e52a76b..ec7fac511c8d50da7125ff1c4cd23af46875791d 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -2351,14 +2351,18 @@ static int ip6_mc_del1_src(struct ifmcaddr6 *pmc, int sfmode,
 
 		if (psf->sf_oldin && !(pmc->mca_flags & MAF_NOREPORT) &&
 		    !mld_in_v1_mode(idev)) {
-			psf->sf_crcount = idev->mc_qrv;
-			rcu_assign_pointer(psf->sf_next,
-					   mc_dereference(pmc->mca_tomb, idev));
-			rcu_assign_pointer(pmc->mca_tomb, psf);
-			rv = 1;
-		} else {
-			kfree_rcu(psf, rcu);
+			struct ip6_sf_list *dpsf = kmalloc_obj(*dpsf);
+
+			if (dpsf) {
+				*dpsf = *psf;
+				dpsf->sf_crcount = idev->mc_qrv;
+				rcu_assign_pointer(dpsf->sf_next,
+						   mc_dereference(pmc->mca_tomb, idev));
+				rcu_assign_pointer(pmc->mca_tomb, dpsf);
+				rv = 1;
+			}
 		}
+		kfree_rcu(psf, rcu);
 	}
 	return rv;
 }
-- 
2.55.0.897.gb25b4bd76c-goog

