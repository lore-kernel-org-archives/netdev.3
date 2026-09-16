Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2D3939B3
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789527800; cv=none; b=spXVYOZ/OzSaBNYEDL30apK0ygRx/UXb39YrsfJWWIoHy5P1Z4KLa9DqoRT1/Tk/Vpm+W9Zp/SmYJEpODZJuyfk6KmZBNpMQ7QHMs7NuE1Ru6rUGl7Xgj6VfdfFJxhpkD6ei/xMnHaxxWyc/KcMcO9iYE0/QTN9/asN00jJq2OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789527800; c=relaxed/simple;
	bh=auIw74FqdoPNfuRz9L+dD4ZCX/M2JkSMcfAb30fwSy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pt0LPaYQXTZVEEsoO6Ap4ggshiok0AYsZZM1u/r3WT83TRtTxN2zXE4hgGHQSyf3Mmzql2+6xfJjptP5W5xrO30U9aJYX3OPU4Sr1r/9vqOYZnrxgoio9Nn1gxmsF2aeUSJbhhdbMStz2KcgUwmK4KF52J+c12cSTlpgp+EOiY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb2uDaqs; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb2uDaqs"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso331790a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 20:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789527798; x=1790132598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jpOGrX484naXNHhBhX07Xsd42OHdTu+Vf3Kl8MQsdfA=;
        b=jb2uDaqs3gRYP2hYyFWZPqTcxwlzDu0HYIEDaVQ35v2vqXnZEtVMYQ89FbLKg5OypB
         81f5CsevcRqSZGYXMg30uJD7CUot4j7jJLpJgb5Dzy3YotGJj/fvtZjBxEUI1olH6Z/6
         6aHxzxBOAojiW38uk+dSZa+rQws5oDpXwL43GEd12PozweLs0XNnVZgGL3QhU8W4Njud
         31HLQhPnuXr+CoiM/1VtS0Rwoo+VgoK2nnfyMf0zs8eeX6fVF4eynKrJkChVbTgKRxak
         yrHpaE1p7L8CFe+UojwmSm4xMrjW9D+5zNvF0Nqnn7JvkZcNv3nLZNW5ah2WZIxLLMjp
         B6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789527798; x=1790132598;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jpOGrX484naXNHhBhX07Xsd42OHdTu+Vf3Kl8MQsdfA=;
        b=d7WGPz6Bv76yGztNz8kYJtvUo4CvyuzlfHvJ3TlRCATinCZjqUnJzkackMtk1cbx9V
         3IWw/1njUwPN2iByyVXgaxiffWd/emcJwpox1QN3jbK97TNH8ddnragofQiSS17F605W
         ZD8Yxp//e7z1T5acVuVRA21tr9L1ByV9cRCcJovNa/O/XNQxL6ssaZ/cNXgZ8p2NZ8Gl
         9q9HrVIYXlNTjMmj3bcd29Ha31Bt4RN39CdSgyXBYp4TzVkzeUG9o/brtfc3G7fz6+L3
         ibGJsSs/22bGwl6O0Cit3l/uEn18qkfrNfQJMpfqsjHiFztlEJUABQzN6UDqroYnwdoU
         5Wxg==
X-Forwarded-Encrypted: i=1; AKwUvBy/CS+++E06Rr5aH9CVT8B/8/WrocaiZJD519l/M1k8WOu5LIJnJYp7LJvlSmCEDvFH2VMf//w=@vger.kernel.org
X-Gm-Message-State: AFuF++mZ5fiIEJxlN/n4dye2lh1n/anKnDGHkmBDRa7INLgw4oSbTjRh
	wuHSH0XYbwaTk+5hy/Q0QwhUjSmB3FWrgZQwvmtdEiSicMClattrwR2I
X-Gm-Gg: AYBFou0qgpEwqaThY0ni7gUl/U/zW6qL3Q02+O257B3sO6dtg1J2TvL3t8Lu1wS2pl4
	u8rOYpu2i0eQo0BDTRB1wnPQa+nJvdsIPBCMDmDO11/cLbGy0/qrbvJQBxZWXwKBrggBoFdqkiF
	uJ0jKdruXL++yp0kVV58Ro9qCOuTR3vOpBRvBJYjRtIuWfqNar5wfPfHSrsyHzMsis4Jx/FfO19
	Bddz4v5nWnYm4TDQgBDuNl5kKEKu5j948M9sL8cFfr5ZpV9uRTSBHWIEFfifLyDsGbmpXCJaSt+
	bgHHGmSC+hlwgv9NEcuwfBdVV6tjoxHb4AQVPdmAqqLxlE7tLXbuJfXGgPs82YlKN9JMcY87Xmf
	KfNHrkl7Rh5yormgqFaLFx2ov7L6pV9irPuIk96N4HusStE5Rjv1uu1aQVMZmOHWwt9qJvLRSYz
	r4GXDsxbyHHeY5oDTfSK3IVLpoAVJQY+r0BqgckBQoBjyv+GE7PVqaJTV2auKnzamcwNvIk3xvf
	0SURmGRN/My0GAcpr2J2YhFMRw9xpTrcicpunpjmBkZaSHNXD7Tz6Rho05wQI61ERat1dIuhw9y
X-Received: by 2002:a17:90b:2688:b0:39e:1c2c:1d4b with SMTP id 98e67ed59e1d1-39e1e31d67cmr2581210a91.11.1789527797617;
        Tue, 15 Sep 2026 20:03:17 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:13da:4baf:148d:4ebb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf56d7e5bsm3319570eec.0.2026.09.15.20.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:03:16 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	hemendranaik@gmail.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	tahiliani@nitk.edu.in,
	vishy0777@gmail.com
Subject: Re: [PATCH net-next v5 1/3] net/sched: sch_fq_pie: add per-flow statistics via class ops
Date: Wed, 16 Sep 2026 08:33:09 +0530
Message-Id: <20260916030309.6194-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904231756.4082402-1-kuba@kernel.org>
References: <20260904231756.4082402-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi @Jakub,

Thank you for the review. Replies are inline below.

> The changelog says the new members are appended so that "qdisc xstats
> offsets stay compatible with the flat struct fq_pie already shipped".
> That is true for the offsets, but does it also change the size of an
> already shipped struct?
>
>   nine __u32 counters          = 36 bytes
>   + __u32 type                 = 40 bytes
>   + struct tc_fq_pie_cl_stats  = 64 bytes
>
> A consumer that validates the TCA_STATS_APP payload with the usual
> iproute2 idiom:
>
>   if (RTA_PAYLOAD(xstats) < sizeof(*st))
> 	  return -1;
>
> would stop printing fq_pie xstats altogether once rebuilt against this
> header and run on an older kernel that still emits 36 bytes.  sch_fq
> handled this by having userspace copy min(payload, sizeof(*st)).
> Should the changelog mention the size change so this is a conscious
> decision?
>
> Related: since fq_pie_dump_class_stats() reuses the same struct, an
> iproute2 that does not know about the new type field will decode the
> per-class blob using the qdisc layout and print nine all-zero qdisc
> counters per flow.  Does that mean the stated goal ("'tc -s class show'
> reports per-flow state") depends on an iproute2 change that the
> changelog does not mention?

Thank you for pointing this out. tc already handles this case safely:
it has copied fq_pie xstats into a zeroed local struct bounded by
RTA_PAYLOAD() since fq_pie was added, so neither an old kernel nor an
old tc will crash or read out of bounds: only there will be zeroed out 
extra fields with older tc. You are right, however, that the size growth
and the iproute2 dependency were not mentioned. In v6, the commit message 
will state the 36-to-64 byte growth, and reference the companion 
iproute2 patch.

> Documentation/netlink/specs/tc.yaml still describes tc-fq-pie-xstats as
> a struct with only the nine original u32 members [...] Should the spec
> be extended in the same patch so ynl-based decoders can see the new
> type discriminator and the per-flow fields?

We would prefer to leave this out of v6. tc does not need it: it parses
TCA_STATS_APP directly, so 'tc -s class show' works without touching
tc.yaml. tc-pie-xstats in tc.yaml has had similarly wrong units since
2014 with no issue. We are also not certain that ynl handles a short
payload safely, so changing the spec now could break it against older
kernels.
Hope it’s fine to have tc.yaml updates in a separate patch series.

> Is this a uAPI regression? fq_pie_change() has accepted flows == 65536
> since sch_fq_pie was merged, and after this change the same netlink
> request fails with -EINVAL [...] Could the class enumeration simply
> stop at 65535 flows (or the handle be computed differently) so that
> existing configurations using 65536 flows keep working?

This cap was our response to a Low-severity comment from the v4 review, 
which flagged the same TC_H_MIN(65536) == 0 display quirk and offered 
"document or cap" as options; we chose to cap for v5. We agree that turns 
out to be a regression. We would like to drop the cap in v6 and document 
the display quirk instead, so flows still accepts [1..65536], the same 
as fq_codel today. @Jakub, Could you confirm that is acceptable 
before we send it?

> Does the exported delay wrap here? PSCHED_TICKS2NS() yields an s64
> nanosecond value, but the cast to u32 happens before the division by
> NSEC_PER_USEC, so anything above 2^32 ns (about 4.295 s) folds over
> [...] Would keeping the value 64-bit until after the division be
> preferable?

This is a real bug. We will fix it in v6 with div_u64() applied to 
the full 64-bit value before dividing.

> Can this multiplication overflow on 32-bit builds? [...] the product
> stays 32-bit and wraps once avg_dq_rate exceeds about 4396, i.e. rates
> above roughly 16.7 MB/s [...] Would a u64 intermediate (or an explicit
> saturation) be better here?

This is also a real bug. We will fix it in v6 by widening the value 
to u64 before the multiply.

> Are these READ_ONCE()s paired with anything on the writer side? [...]
> vars.prob is u64 and vars.qdelay is psched_time_t (u64), so on 32-bit
> builds can a concurrent read return a torn value? [...] Should fq_pie
> either do the same [as fq_codel's WRITE_ONCE conversion] or hold
> sch_tree_lock() over the snapshot?

That is a fair point. We would prefer to treat this as out of scope for
this patch and take it up in a subsequent patch series. We are not planning
to reintroduce sch_tree_lock() to the class dump, since it was deliberately 
removed there for performance.

> This isn't a bug introduced by this patch, but with cl_ops now present
> the missing .tcf_block becomes more visible [...] would adding the
> trivial .tcf_block that sch_fq_codel provides be cheap enough to make
> that dead code live?

We would like to leave this out of v6, if that is acceptable. This
series is about statistics, not about making fq_pie filter-capable,
and that would be a separate change deserving its own review. We are
happy to send it as a quick follow-up once this lands.

> Also, minor: there is a stray blank line before the closing brace of
> struct tc_fq_pie_xstats in include/uapi/linux/pkt_sched.h.

This will already be gone in v6, since that block is being rewritten
to address the first comment above.


Thanks,
Hemendra

