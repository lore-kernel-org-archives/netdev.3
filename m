Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755903;
	b=YDIHmTghhjYUa4Y2jEW1cH16Nxm8Z3fZ1sO8lkuEjFzP7she3aKzdKhzUJv3GmJtLH+L
	 hyqHxI+FmVz0CerG1QVBxBdh4Fz1/K+Yl2h/PwYhzTJGF4atFvQrBktfaWaPu2v//s3Mf
	 zXSY1AZ82VWIzx5g2Ntp9DwpbgsmguN7PwQbIIig9V8HT0AP7YhVSQa8YiSco7SzDAhx2
	 J2BCF/MyAArJmyN6Riss9NuaEVHQof/Cx7QCzdN4Sn4AR1Z+7ceqjCeMRkGtRPJMjQCHk
	 9qLUKhki9u/nIrWrcJGw6waFh0Nty0rueqlEgaCNuom+wF5vdZma9IUV2nX5NOF/FEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kSc7WJfr/T2uxVIbPPCpTk8TyN99fu6QCnpTLbLAcUA=;
	b=l6jQA3mlrb8rdUvTVkE1WfX6lo5ilSlZvI4BsV2594Z+YNs8H/D14safRN5Fzt0OjM8P
	 Qk75CWaRa9LPUXWaZ5NNdwfLj1AH4oLjdSoBGP+b5mlPirtJBNJMNliLAh2XCc+ln/UUU
	 BFVyF4bEzMMYnG7PK2PJuQL4VljmbAFO2Eb1FT1t/xm7tpijqhUQ138k/mPEmGrbk8Au7
	 Eict8RjnwPbhe0l+sGOt6W032M2xycqUohcUbb19uygDdUF+LXeqYcRkjfSZdLKkRCuYH
	 R7NVH5P124zGNyZvoR6ArZFKAyi5lzR1Ua9sBHUPI4ESlNMzoYIX6TSbodFCZ068XMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HaYMDP7r;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0CD606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 01:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A0CD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HaYMDP7r
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so270135eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 17:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755902; x=1794360702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kSc7WJfr/T2uxVIbPPCpTk8TyN99fu6QCnpTLbLAcUA=;
        b=HaYMDP7r1WSFV3r79Kxck3kkLtGkk996HbG5nAXEJx4T7nWUUB87lzMz6cwJUy78N+
         Wpj43JrLAlYeVZeShaon33yoWjzgtbw6zwJ8TmlTJAy/NU2wUKCAavA8BHyrql3Tf7Hl
         6eo+nwTqBTMYYBfMLzTiVN8QHcZt039j7VNTdVGbUqHEcqPForUIKbYNgbYcXqcJ492w
         dbZsQJs6IcaLVw8pwY1/o4ErUZ3d91fRTqr+QebjgGbe0JkJM4NP81ja403zAFVZboCm
         KE87uab/D6Sc+JMIdwaRCUwDRoYS4qTNTqLak7uQt3UXSaPhnm/P4hVtaZoTKHqCd3WZ
         BucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755902; x=1794360702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kSc7WJfr/T2uxVIbPPCpTk8TyN99fu6QCnpTLbLAcUA=;
        b=bwFYQ6SLW27oTgrjiCsG3tTZacY6TjCe5OcgZ9mf4bHiJYs0AyUsJpFJBCdzYqMI2q
         w+e5sLPaXpI7fn+NySvhTrhj3XxX33AcMcQZ6BomkYkKoNDw2X6AfdBSzp+S9bmjL0YH
         Vyqng4CO4iKC0uA9j3DwTZlPnXOHtqs2A1RZEggv+dNcl2/+iQGWssrKEAj4KYewrNbI
         kTZL87pilEe2PPTt4d/NIHdvJtNgfHmqDiJGy8MUnLfnSNhYgSjFNcGv2lhfowXGnnBY
         yWm8xT3rnlgVtpsL86TsiyMVSxDsgOkcFcCFfKqwUxWEVqCL4ec09ae8ntSqM/kcIucI
         ucnQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8hnHhiNaCTA0DLfnKXNGxhC+j8kbgYB0PJHt9CRgXXircM5sB2kMX37fSmd8NNYdo5/PRhQM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OUPqWyczpTCKK3LXEyEIAFNaFo9SG6zd3b7eyXev3bRzY6q1r
	Vv/l/Vq0FFH9p4NV9UIcoH6MHGdqTRCixM2GmVUe9lq3e/COJhM4xoZg
X-Gm-Gg: AYBFou3R09G+oc38HUzumlazKWSYHn4iLdr5jEP8sFjGuUn77/F8YCWehU5sPS9p8ZG
	0i30sp5YdhdRka/rIwwAyVd8QfiY6OMOFZ2gMOCr1NYfbjLsxPxBv0cl68AZ5Tm0MYLcLGKoa3Z
	zQLTVhVCj5iVti38mULmbDhh+A2AkCqhOVo8UpZ8NKDTD6PDDqlYQM14Ak5weALxJXKe6QCIlpI
	GqX7OleO9ojiy3Dtz5t081XZIE3GDWrUiEe+nUpR9fG3e3jHQs1iaSMqxhW1NoZj/uCpkEIVPCo
	6QeioFr8HRmiXl9Y/M+gVPeLMBhfLbGtx+s6RDqasIwWzgaBSA/+ZTN55EMv18RTYu7mdYEGNaM
	lqg3iPZgttu/W65wDqpFMWFIQLm4hxgj96saogc1bgHqVICJ5RXNFOkE4OGjlztIQbcCRgsj79E
	jb8LHLhen9SqutWMxRQsls3LG+sOeFQzSSw12rPh/UyjRUAuqDUUAZ0S8CFeGI+t5MjBJO7inqI
	SypHiAx0NXWiVlfgbrR4+UhrWpxsRSKHHPCMiW3xEDxGkSvG0WC11l0rq1rTdE+1jhHGjMyj+0a
	0WsEED14Nu+aUHXrn2d4dD6XReiA2Dw9QpE12Ib1/67Fu4AwysbOp/Jyo/j8/4HG6dltkoiF6n3
	2Gz2+e8M21rA=
X-Received: by 2002:a05:7301:db8a:b0:36a:279:c93f with SMTP id 5a478bee46e88-36a423fda77mr21589967eec.33.1793755902092;
        Tue, 03 Nov 2026 17:31:42 -0800 (PST)
Received: from pranith.org (c-67-164-4-239.hsd1.ca.comcast.net. [67.164.4.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca394c2a3sm2149230eec.20.2026.11.03.17.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:31:41 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT - CORE),
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:\b|_)ptp(?:\b|_))
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH] mm/rmap: use release ordering for small-folio mapcount removal
Date: Tue,  3 Nov 2026 17:31:38 -0800
Message-ID: <20261104013139.1341582-1-bobby.prani@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Removing a PTE mapping must precede lowering its folio's mapcount.
The COW path relies on this order to keep the old page from being
reused while a stale translation can still access it. The mapcount
update needs release ordering for that edge, rather than the full
ordering of atomic_add_negative().

Use atomic_add_negative_release() for non-large folios removed at PTE
level. Leave large-folio operations fully ordered; their path can
queue a partially mapped folio for deferred splitting. Update the
COW ordering comment to describe the required guarantee.

In an arm64 page map/unmap microbenchmark with 20,480 minor
faults, simulated cycles fell by 1.54%.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 mm/memory.c | 4 ++--
 mm/rmap.c   | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b65b56fe9714..9e23c64bc743 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4158,9 +4158,9 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			 * threads.
 			 *
 			 * The critical issue is to order this
-			 * folio_remove_rmap_pte() with the ptp_clear_flush
+			 * folio_remove_rmap_pte() with the ptep_clear_flush
 			 * above. Those stores are ordered by (if nothing else,)
-			 * the barrier present in the atomic_add_negative
+			 * the release ordering of the mapcount decrement
 			 * in folio_remove_rmap_pte();
 			 *
 			 * Then the TLB flush in ptep_clear_flush ensures that
diff --git a/mm/rmap.c b/mm/rmap.c
index 1131b76bbbc2..62e623d7563b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1794,7 +1794,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 	switch (level) {
 	case PGTABLE_LEVEL_PTE:
 		if (!folio_test_large(folio)) {
-			nr = atomic_add_negative(-1, &folio->_mapcount);
+			/* Publish the PTE removal before lowering mapcount. */
+			nr = atomic_add_negative_release(-1, &folio->_mapcount);
 			break;
 		}
 
-- 
2.47.3

