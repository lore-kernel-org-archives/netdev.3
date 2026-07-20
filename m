Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879E399360
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 03:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518697; cv=none; b=bc7kV+gaoy8pFN2wIdv5r2iHar1jRDvJPAjZ6C4YOQm6gbNjoANXx+V8RTBj45R4JMWpjxwrIF/248efqu72S/vMwI3jl7OtWaZshrT51nZdXpo7T314gyy4p6YElnlieZBlalrJV13+nYqGEsQtt40iLvKcZex2tO9gJZi+RYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518697; c=relaxed/simple;
	bh=2IYPYAaWLt0mLcr+u21OpJLddua6jvE6TZ5CKvfA5kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cuzjm+DsSKljNk6XflU1bhXKllPiXufjOyXnVKoA+k9v8GO1ohqTcz4VWMRagSBT3AmLwYqM/rFOz8YJKt83/FtPGfbMrYCQc1KK35x74u67rR5UafbIZban0H8IyxR/tyH8+hgOJIgurvLWDxo1JhVMZOfWa4tsTaGnoLiDVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPBkBtWZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPBkBtWZ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caed617615so106734045ad.3
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 20:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784518693; x=1785123493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2IYPYAaWLt0mLcr+u21OpJLddua6jvE6TZ5CKvfA5kU=;
        b=lPBkBtWZF2wCNviTunI5arUeBcn3MZxn4z6NQWDyJWe9kl169F5MWicasKH9xqrxf3
         zsIZoOSmOEYV70Ue9GnrlTVtD4BAOI9g+v0w8NK2UIbPNN+gSxK6rNKr8xRkzJrDy10O
         ghRj2jT+ewtssWQoEJYYhES4fLNbRVLdYX81ta+drVGTJBQe0a9QLyauk0lymjy4AYls
         4poKpo90Aj7q1T1KVLCnsHze/uS1pvdiRjQClFXtaA0608GFn1R1W30V/Op9kLbXOPgA
         WKRAacldbC4tfewACjdvusDPk3Wbc43Cx22D8+hZ6Ig0nZzitqobwjj79YoS7dVpQZWt
         1ZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784518693; x=1785123493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2IYPYAaWLt0mLcr+u21OpJLddua6jvE6TZ5CKvfA5kU=;
        b=sZ0jp83+dnMpnyFkqt03k3MrHe7zOxup0zkJFziZoR2Fs5zpWkxo097L2xrNeWjHNi
         fT4N9z7MzUsj1Pa/laONamFIrz6OMZLGTZngGeF7YXOvbgPXJnDg/+41+lB4aSPFQZND
         h0A1nJWtYfkIKkcSo1YFAhl2p7VlKNSb2usaCnqn8optSqAF9FparM9NbG2dh78BFyNo
         TMeSp3ohNAVkFen41dubUQ9EhSXTVDFQTM300CK6CG+A0UB59/I5gJcYU5bisNPwLeW5
         F+BHgO/x0+1Xbjnz7kMApK0nTZ/Tx0LHetKrVlLKy4V5w3iaQqPUxrOditnQDF/DRD8A
         AuxQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZsHFqE9TGAEIX8aHtVDPQhx0L6W05FvSztJLPuscfVm2PhTtp3VJuVgnER0YygLM7Hzs9IwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG5LGzeUDJcnLi/ye+hnc7bEEp6iGKD9iyT26zPs/7ELv7eCX/
	RlJkUqL06EQlgjWhc3c5jO94IjbBLq1NGLN3szC08rQbkwQWfieFQ1XW
X-Gm-Gg: AfdE7cnV7ZLM1KK+HSqbdqIXbMOPIR39UK3sINNwSg7g+g3YpQEtW1pNx/qymfRDVtl
	tMjrJoinOX0+pi+lyI0rL5sc8dc4KAuH2wnvTBLTOkwE/ax+vfMUOsXBb2HrI+pv21oa5z2p8qv
	MtFuKZbXP1JUfdj68/E47TkqXET/DUa8mcqno2rQ/PpUFcAlf99/6kCDVSMlKuaEZjt6AlT3YhQ
	QflL+oQXFds3qvhg0BV9j264xgGjbRAy4NH3m6iwpcjWfvTrZe6E5QFg2DJgm1QNVTmHS3QmO3J
	q4790YEEvc5EBCYLGQRG+Ocv8H7sUGL3ZOZD0YO6x4XrKFbLXPIr4/KgpFWM0O/UXBKppt7e/Bz
	l75lxS11D1RibDW6w2dTpkcqTxL/0QsiaD4TcD3eVpWb1DX2P1uOsQt5AlMnPpaIBx045IKs=
X-Received: by 2002:a05:6a20:2583:b0:3c0:ac0f:6558 with SMTP id adf61e73a8af0-3c3ad677d0amr13026984637.2.1784518692673;
        Sun, 19 Jul 2026 20:38:12 -0700 (PDT)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2ddfb35sm26535048c88.14.2026.07.19.20.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 20:38:12 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Qiliang Yuan <realwujing@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v10] mm/page_alloc: boost watermarks on atomic allocation failure
Date: Mon, 20 Jul 2026 11:38:03 +0800
Message-ID: <20260720033804.3862547-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e011c6a8-cda5-42ce-9d42-b23d1c81b26b@suse.cz>
References: <20260214-wujing-mm-page_alloc-v8-v10-1-bdfea431fd97@gmail.com> <e011c6a8-cda5-42ce-9d42-b23d1c81b26b@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiliang Yuan <realwujing@gmail.com>

Hi Vlastimil,

Thanks for the review, and understood on taking the Ack back - the
v10 changes were substantial, and I won't send v11 just to drop the
tag. I'm folding it into an actual update instead. Let me answer your
three points directly.

1) The Ack

Yours is dropped. I've kept SeongJae's for now since he hasn't said
anything to the contrary, but I'll understand if he'd rather it not
carry over either, given v11 also fixes a debounce race in the atomic
path that nobody, including me, had caught in nine prior rounds:
last_boost_jiffies was checked and updated outside zone->lock, so
concurrent CPUs (e.g. a multi-queue NIC spreading GFP_ATOMIC
allocations across several softirqs) could all pass the
once-per-second check for the same zone before either updated the
timestamp.

2) Real-world benefit and side effects

I don't have a clean before/after deployment number for this exact
patch yet, and I want to be upfront about that. What I do have: a
production host running a downstream 4.19 kernel logged 144 order-0
GFP_ATOMIC failures over a 4h15m window, every single one through the
same NIC driver RX softirq path (bnxt_rx_pages -> net_rx_action ->
__alloc_pages_slowpath), across several unrelated network-facing
services on the box. That's evidence the failure mode is real and
ongoing - it is not evidence that this patch fixes it, and I don't
want to conflate the two.

On side effects: the mechanism is bounded by construction, not just by
intent. Each zone accepts at most one boost per second (the debounce
timer), and watermark_boost is clamped to _watermark[WMARK_HIGH] / 10
per zone, independent of how many zones get boosted in a single
slowpath call. Worst case this adds one extra kswapd wakeup per zone
per second, and the ceiling on any single zone is 10% of its own high
watermark - it can't run away or starve unrelated allocations past
that. I've put this bound into the commit message itself so it isn't
only visible in this thread.

I know a bound isn't a measurement. If it would actually help, I can
try to build a synthetic reproducer (fault-injected GFP_ATOMIC
pressure under load) and come back with before/after numbers instead
of leaving this as theory - let me know if that's the kind of
evidence that would move this forward for you.

3) netdev

Cc'd this time, along with Matthew Wilcox, who asked for the same
thing on v1 and was never followed up on. Sorry that took ten
versions.

Thanks for staying on this thread.

Qiliang
