Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197281;
	b=TqJWUJdBDnbyg9jAjBLXCX3vxN6pM92kxvfjJNQPoklJEzimPoDGbBR2Y1sxCaxJvPau
	 TJgnoczpXgH0DH2KqHjB9yz/91MwcFY6KKgNbrkpamPHK99TfJ2K/j2bySzxFBtNVWsqM
	 NcII7eB7WUqDghmEL3PKKP24IOYeGb6FsySyaQJq34HbR3h/tmJiaY/su4lV6cUgLZ+TC
	 KgOAfq8blidnVizXgu3N9yQR/BBT06n9qLJhmnROjX0+aIg1HuewuthA5FG0sN+IDef0S
	 PpupQcqi/HepftViEOMsKC8clP/fSeU256lsEsFyj5w4Sxn55IKHNQHvtHq01K+uvJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197281;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=X/GPT3ZRi1oIBhHTumY1f/yu9iHeKcY3ZDJ/rlFukao=;
	b=1EB0nqrKS+D9NG9Sy2Nx6tC7BO2a/EL7VkmrjtKUxbPPSL1irCOCTfU/F3s4LC+F5sMX
	 nEHb4vTYX7ije6RdF+Y2xIXSS3SaSVlaMrMXqRfBdbn/ldk7Oo/MBlr4PP8yFhtjP6JQZ
	 L1lf5meBLILqDUtNTPpMTjf4a9JJ2HBUha5+j1RKfxLsE/N3IHynsLXFtZowhGPxR1UOf
	 LBxZNjr3EXI5xOw8N0BBEzjbGixg3fQKoF8F9Nof0R1J9ZA4VkgcsUtlqs38zATGpEhQX
	 FGpJdOMYUCvYXG/G6fVcdK874FBRfyom+0eXzdNPbqodu4MRMxwVIs+tK9r2pLiCEtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B1dnG8Zk;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=i7mElj7p;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119DB606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 119DB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B1dnG8Zk;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=i7mElj7p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793197280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/GPT3ZRi1oIBhHTumY1f/yu9iHeKcY3ZDJ/rlFukao=;
	b=B1dnG8ZkeDZEuQ13c0LlFvjfalnaZ8ezNirXWu9Cm65qcR1CFTMsyIjgLzBBDQa89wGofm
	m85V/TBl9VGE24fdWABH+nqRQmEgDJRwM9mD/xZuv2zOcPGg6RuHtw8tsVXcnyuHNJLZdP
	jA0h7dznfeVCW8syH3oDA2AN2mu4iWk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-kO2ZgwgCOPyYGbaQU7wD3A-1; Wed, 28 Oct 2026 10:21:12 -0400
X-MC-Unique: kO2ZgwgCOPyYGbaQU7wD3A-1
X-Mimecast-MFC-AGG-ID: kO2ZgwgCOPyYGbaQU7wD3A_1793197271
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a17741243eso7645205e9.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 07:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793197271; x=1793802071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X/GPT3ZRi1oIBhHTumY1f/yu9iHeKcY3ZDJ/rlFukao=;
        b=i7mElj7p9ES2Y5k24rCRBYGtlAyh3GVi22/PH5sEO7IhbUAO4R9hY0SH29hk50GnN0
         sA6ZFTxg9/n07CmCk2xv6OC+mXZYu/W+lwgXLK3L0cM6G6PEz6ALoEFPtyXJeldp9YrJ
         6qCy4+PRKiOjlbTOpPORVomxSjJI5tNWA4IaW9vSMI+BpQWYwB9cSIZpsJ5TYGS46T6U
         /v22CUZ7EwpycopNgbpvxzEwj88S0CX4xsNlUpTMDg3CRJ83yQZVJ7gJqkZVcxgDDC/e
         5m5qR8NLHgtuH2FQ9+KQRAEPrwyjVnDuhCLIa8Yuq3dS5PKU3L5567VRhZFNlwnjKm+U
         Fz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197271; x=1793802071;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X/GPT3ZRi1oIBhHTumY1f/yu9iHeKcY3ZDJ/rlFukao=;
        b=geN9fkqFXCTrmq23odbEPEF3SYsxjDY1fIlKH+mOiKmw7SB2acCQiVHm0q/SWYtWst
         ZfQbsND3Upn431suzHv7EEv/+SIkLRGMJx/QAcPp29RocCrculyVrNiZs65Kl01pnKUZ
         AT7Uw3cqjSQmv7uyRulb+xu0X+jZFdXMhCTde4NpOsIJKSbGpI9iq+YEFbAG55BMdJC4
         dFsbrrTOlHcX/G8AJT7TbGlVM4mrWYouwOidm3W/D5Drt4N/dP+wEpP3eWZVMefWjxeC
         rOwCGIE1kbUNB6MPVTpDsTTYGdSYXVoG6Cxz3uHZsgkM79hiyKsD7ZmEZdf1HAt0IhY0
         Y52A==
X-Forwarded-Encrypted: i=1; AKwUvBwdK19cWqNH+9ja7zOKdgKDDI70ARhuAsk0h7lGd7+9/rHyG0fQQ6E8LUxa0nNV827+/Zfbvpo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5EAMJrsHUgyKFx4NUgAr2RSv+VqPUg+Dws+Rb2K8SVFcRPk+m
	HkvLsA5nsfcxcy5Irh6Qaw/ciERfY67r6J7RfNY5IwQ9pmFQCo8JO4Y9oeVyRRElO3OgjgXeDeU
	vkctqZ1ZMXcPvT3DSvft4xT3nChhLSBbaVQrwKW3jUAr6DlQtESVJpLWi0Q==
X-Gm-Gg: AYBFou2j5r8QrPCIow9AUVnps6eLXtNjlrIk4CUlYVWG4OeLlYBu0ABcWpw8MOcNbN5
	B6ILvXT5kRchragqvxgZ5tDJFsm2/TKiSb2BH7T+h4THm16B7LSxsMIXw/4CI01Opa+s3Mz5iyH
	P8jtZLmgWhddr5i5pSP8Q3PedYM7F42HLxTOuQ61fbDdSF5PrOJDzKKjkalyLnXLsqv80LMBhnI
	wc2+Ms/gUrUDlYsbFq4NlY279+kLmLXLEDAdgwXEMn/yRr30Cz1y42U+Xhtf+svx7TIQ/cIUEz2
	d3wS9u9iOTJ3yJfqEOeT27dkB+9XhulqBMftxnTQJR7LQcX94qrbyeZUr5f0EgL6odwT1JKNONl
	QSobz8OmC+9zPYPQC2Q6Z3MivYYs5O/BFeCs0jw+uEh+KIQE=
X-Received: by 2002:a05:600c:1f87:b0:4a5:1cf1:b7bd with SMTP id 5b1f17b1804b1-4a966a563ebmr53082115e9.16.1793197271171;
        Wed, 28 Oct 2026 07:21:11 -0700 (PDT)
X-Received: by 2002:a05:600c:1f87:b0:4a5:1cf1:b7bd with SMTP id 5b1f17b1804b1-4a966a563ebmr53081565e9.16.1793197270639;
        Wed, 28 Oct 2026 07:21:10 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:60e2:dbb5:afaa:94da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97d38c583sm46318375e9.15.2026.10.28.07.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:21:09 -0700 (PDT)
Date: Wed, 28 Oct 2026 15:21:08 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: Boqun Feng <boqun@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] lockdep: Keep dynamic key hash nodes in
 lockdep-owned storage
Message-ID: <auIE1OXQi8HMx8Dn@dcaratti-thinkpadx1nanogen2.milan.csb>
References: <at9eq_3YUIL1ACEK@tardis.local>
 <20261028114449.161185-1-vlad.wing@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028114449.161185-1-vlad.wing@gmail.com>

On Wed, Oct 28, 2026 at 04:44:49AM -0700, Vlad Poenaru wrote:
> On Mon, Oct 26, 2026 at 07:07:39AM -0700, Boqun Feng wrote: > Yeah, I

> If the qdisc case should be narrowed anyway, net/sched could skip the
> key for pfifo_fast, the only qdisc with TCQ_F_NOLOCK in its
> static_flags, as it already does for ingress, clsact and noqueue. 

I was tempted to do ^^ this in the past, but then I gave up because 
TCQ_F_NOLOCK can theoretically flip [1]. So I was afraid there was one
(remote, but still possible) situation where pfifo would use the qdisc
lock with no lockdep annotation.

> takes q.lock only around its requeue lists (gso_skb, skb_bad_txq) and in
> control paths, never across a nested transmit, so I don't think that
> brings back the mirred false positive from af0cb3fa3f9e, but netdev
> would have to agree.

maybe this doesn't happen for real, because only non-root pfifos would
have TCQ_F_NOLOCK bit cleared. But I wasn't 100% sure, and also afraid
of causing troubles on qdisc dismantle - so I decided to settle with a
better though sub-optimal allocation of dynamic keys for pfifo. If we are
sure that pfifos never use their qdisc root lock, I'm ok for a patch that
avoids registering dynamic keys like it happens for clsact.

-- 
davide

[1] https://elixir.bootlin.com/linux/v7.3/source/net/sched/sch_api.c#L1198

 

