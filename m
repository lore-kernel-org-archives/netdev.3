Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03914A33FA
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335244; cv=none; b=gyUD7XX0MczLLwYooSz8CfcFvgn3b7f716aSqeJx0MqV9j689OH0jwvpNALE7rvmdNQMo8XT6/oWHrExrm6mUzoA1cuGf0AZkEo3ZuOwPSpMJWeskVt3AY1sqXGqXsnMohLuNip+jwiOH5EMF9aAbXl27Qi3TAyVoC8R6qpvXUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335244; c=relaxed/simple;
	bh=cSK35UhxS7x2Pk7Yv73KpzJYQwmuRBZT31oI2qSxdOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwStewzvC5sp02EDNGLUhQ7ZEISuzpxmiv8abArp+f1e5LwRuMLEj1Sehey2x5YwfNlrtu3iTJcZUTYSl+MJINvT/KhjNzPsPoItyeS2GpS+VmKJUhVLkJx49y1/jRc8xgfOpzGZWyhtqAFHR5YrxRRfWSUxbG0dHWwTVl0xgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR9bu6Yk; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR9bu6Yk"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9aea40d799so559230a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785335242; x=1785940042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q6TvvO09U4zGaQilxr2NjN4uQvkcCnEQhswilI8Rgyw=;
        b=hR9bu6YkOs2POj9OD+w8IgvI7z2zyItta7j1vHJpRuwgOdyDNjmkaG2WURuspgumYf
         72SKDTsmhQdnzIQR1BQnuNNT+sCx8++Fkx+uIqQORZzOIkYstI9TGrIuLFFpcSDyKg7/
         IiTdfnTZ8lYGKBzsYxNo7sHaTgBSw1LqX7DY57l8ODx8SDqbQZS9usxTQfBBLWR8+cM0
         w80z5e0IwpBpi4oLbkdkkL5bYwol6MG236SztZSTG8UFOPd4f3PUF9m12tebOw43crxg
         yQuz0DU3U1QLtMCKwyEijDuyzJhTDM7faSOTkt5Ovk31UHQsilRIwKdWbCxFnr87qlBW
         O6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785335242; x=1785940042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q6TvvO09U4zGaQilxr2NjN4uQvkcCnEQhswilI8Rgyw=;
        b=DltuBbKEpoEL9PP+Him2ES3GicabgvZ8123psV6YwWTu0XqM5wiiEyqEdTzG6+9xVm
         x53J/YaHw3Yfsgc03AFBxeQeFRLdPGTafC7ZKeXIm3/BWSgqMPOr53lCUGkuAsfPbdw9
         6G31BYEcu/c/vUIzK5fIxIFR7WCC5KHXWUftXiPDUtME72AyoQUIFjgzeMTXU8BnVa3g
         sOkxDQvF1pJLVxNgynWCRy7BizdV3Kl16iE4xeNcO8zXl2vh3ggAPGyfNNxFKT51P/vR
         bgoKXGEzSBI6E/M9d2WoQOIetm1qAlrxQD2Nk6E/pLzgUcqsjupA/sMg+tGeW5AnRl7F
         bqrg==
X-Forwarded-Encrypted: i=1; AHgh+RqGYdixpNnT0GEhCAsKA3b4H6B76zXQepi67j5um7+Q792y5R1hlCc4GTa9X575Bs5x3HyzAzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUCXGDom4+bWBxrNvl4G9jnc3y751ETCrGwz06Asr2PR2v31CW
	XeRIwbIKKCceUnEUTEW0ZEZ0iprQJr4JpBWH3rpKqERl/2Pf4LhzoQ0f
X-Gm-Gg: AR+sD12w/4ASa8UVUngMkIHz6wdhgb1gya35zGhVYE5aEyUEL0kaFhDitsqboNiRphS
	HRLeAEhTdVWtO3wSfJKjN8O2ZVC4va6EliK+tder7jvwuYhd2k+oF43m9k52oxzPfo+2uIZpbec
	uu5jlJd2qeAS/y2HyQlt1h7YgPrYsToRH+RikSqKifUI8gCA6HiyWmtaUH7u1SqMhojsFMu4KLA
	AOiqfYhhC7QbJpxXRe+UP/rpXQF5EHbIlqKfISZ7//BAzLGq/jqN5bq3xyxHYu+xTOBeLhaq9Q+
	N9Q0IhN26AcV1tXC4yEdLcidGTRwF0Bxf8fzsnuozb0jjcyPhEyyOOdT5zRKsqdJxg+yp5z6QS+
	gC039+mhQyxc23MnR96M//01AP36oWzdh1cZdKSBnv9i1J4jJ8H9Ngiihiuatsw+QeABVPVO/4Y
	lIigi4qlMbUInVS2AkX0AEIpBon2HGGxQZgVO/qD1HdpfK1A==
X-Received: by 2002:a05:6a21:490:b0:3bf:e66f:266a with SMTP id adf61e73a8af0-3c8ba61c214mr8223820637.59.1785335241938;
        Wed, 29 Jul 2026 07:27:21 -0700 (PDT)
Received: from ubuntu.. ([2a09:bac1:76a0:1a98::48c:10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc63f3sm9690326eec.16.2026.07.29.07.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:27:21 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Qiliang Yuan <realwujing@gmail.com>,
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
	netdev@vger.kernel.org
Subject: Re: [PATCH v11] mm/page_alloc: boost watermarks on atomic allocation failure
Date: Wed, 29 Jul 2026 22:27:12 +0800
Message-ID: <20260729142712.1568604-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6ddc5919-f001-43ad-8101-d118ad70593f@kernel.org>
References: <20260720-feat-mm-page_alloc-v11-v11-1-7376b02c27b3@gmail.com> <20260720163719.cf37f6be63bfd88a06965761@linux-foundation.org> <90ac10ff-55f8-4f07-8e1d-bb9f3a8cc546@kernel.org> <20260729131701.3354724-1-realwujing@gmail.com> <6ddc5919-f001-43ad-8101-d118ad70593f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiliang Yuan <realwujing@gmail.com>

On 7/29/26 16:00, Vlastimil Babka (SUSE) wrote:
> GFP_KERNEL can't really come up short in practice, at least for non-costly
> orders, which are considered "too small to fail". I don't see immediately
> what order is being allocated there.
> It might perhaps be looping inside the allocator without success if it has
> trouble reclaiming. Which usually means the userspace workload is
> overloading the system.

Good catch, and it made me go check: the mergeable-buffer path allocates
through get_a_page() -> alloc_page(gfp_mask), so it's order-0. You're
right that this shouldn't return outright failure - "still_empty" from
try_fill_recv(GFP_KERNEL) looping via HZ/2 reschedules was my framing,
not something I've confirmed against an actual trace. What we have is
an outcome-level observation: buffers run short and incoming packets
have nowhere to land during that window. I don't have instrumentation
that distinguishes "GFP_KERNEL returned failure" from "GFP_KERNEL took
a long time looping in reclaim before succeeding" - I shouldn't have
implied the former without checking, and I'll stop describing it that
way.

> So is it looping in the page allocator or returning failures with
> GFP_KERNEL? I guess the former otherwise there would be allocation warnings.
> Note that why this happens can be also 4.19-specific and not applicable
> today.

Agreed it's probably the former, for the reason you gave.

> If kswapd can save the day by being woken up earlier, then it doesn't
> sound like there's nothing to reclaim. But then it's puzzling me why the
> GFP_KERNEL attempts wouldn't work smoothly enough too.

I think this is right that kswapd isn't reclaiming anything a direct
reclaimer couldn't also reach - it's the same underlying mechanism, not
a separate capability. What the patch changes is timing: kswapd, once
boosted and woken, keeps working toward a higher target continuously in
the background, instead of each CPU handling its own RX queue only
doing reclaim reactively, synchronously, at the moment its own
allocation needs it. Under concurrent pressure across multiple queues
(which is the case in what we've seen - several CPUs hitting this at
once), that front-loaded, single-threaded reclaim may finish work that
would otherwise be duplicated or contended across multiple simultaneous
direct reclaimers. I'll say plainly this is a hypothesis about why the
timing helps, not something I've measured directly yet.

> Great, especially with a realistic workload. However I'd still worry that
> we're working around some old and long time fixed allocator deficiency
> from 4.19, unless it's demonstrated on mainline.

That's a fair worry, and it made me go check exactly what our 4.19 host
does and doesn't have, rather than treat it as a monolithic 2018
allocator. Two relevant mm fixes landed upstream since:

- c89cca307b20 ("net: skbuff: sprinkle more __GFP_NOWARN on ingress
  allocs", 2024-08) - suppresses the warn_alloc() print for this exact
  path. Our host does NOT have this backported, which is exactly why
  the 144 failures showed up as log lines at all.

- 281dd25c1a018 ("mm/page_alloc: let GFP_ATOMIC order-0 allocs access
  highatomic reserves", 2024-10) - lets ALLOC_NON_BLOCK (i.e. GFP_ATOMIC)
  order-0 requests fall back to the MIGRATE_HIGHATOMIC reserve, the same
  way ALLOC_OOM already could. This one you suggested and reviewed
  yourself. Our host DOES have this one backported.

So the 144 failures we cited were logged on a kernel that already had
your highatomic fallback fix in place - it's not the "already fixed
elsewhere" case for that specific mechanism. What it demonstrates is
that under sustained pressure, the (small, bounded) highatomic reserve
itself can still run out, at which point GFP_ATOMIC order-0 has nowhere
left to fall back to on the current attempt - which is exactly the
point where this patch's proactive kswapd boost would matter, since it
only ever helps subsequent attempts, never the one that's already
failing.

I can't make the same claim about the rest of page_alloc.c/reclaim -
there have been ~900 commits to that file since v4.19, and I'm not
going to pretend our host tracks all of them. But for the two fixes
that are specifically relevant to this failure mode, I now know
exactly which one we have and which one we don't, instead of guessing.
I'll still go reproduce this on current mainline rather than rest the
case on that host alone.

Qiliang
