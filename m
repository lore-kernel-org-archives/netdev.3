Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380259D62C
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892297; cv=none; b=CJH8z+UmN/Qb9fjBkXBTeJ7aWCwDMWgCny0nTV9zLGt77QLGWyXbgl49fyCKWtw3BtMwsxrZjmGOf7UbgllhXtl2shXCq7vTJRuT5v32G9GCdtpHuebFzqXqMm/JWqqdMfBih+7Eh+zvyMFULKMdwV88Pe5JDddaK4fbNdgHhEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892297; c=relaxed/simple;
	bh=rxKASCvoXwkLz7cGjpScgfFjWOva8rKIl83DdYdEAVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agxfIJIXXtkKO2A/bCGOtNvNxjjp/hXKUbzzzmYCCP3vbfN/kQ5dlfh3Y4hMHM3bjHMgK4D+tRtczVDXvPZsSrlZcAeaIbAbmqwnjHJHxk69HYwyUTZWcEnScf2eYjvzHEdsCzoWdebDsBO8s+PuE8Diar7n9VraG4f03zPywv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=lIs+FOve; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="lIs+FOve"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc891373e0so52232345ad.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 11:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788892295; x=1789497095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1xjyEJHBtmdDh8u+kavyW8yoRzck49wHqiKYhfW4XEw=;
        b=lIs+FOveSxOo0gVRet2M5RfWIx2HgePnBEXo3/u80DD7bQyfusdLaNLlPqZdd8Qqqq
         0FkACmcOE0K2pw20lm62OMPyAplCYElGso1KAZrtU20b1ehg/C8yjrJnI/ZqRYeuhZ4z
         m7B+lA6BGdqm0z8sZ7x5wxACy4BQUyRzm1y/9EspHYrXF5VpwQGIo5b5xXrqJ+ES8FJk
         uDlIt9oOvtqUK0J+f+32xwRtd2T6C3wsGiijqabls4V/R1jZzK1PlrOesY2lfC8mpTAL
         d7F3M1OUHgLsv+1b/83PpgYm0FER7N+rXSIR6+kP/5cjLwBObOkp5sm6vuWH/itDvGqP
         bsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788892295; x=1789497095;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1xjyEJHBtmdDh8u+kavyW8yoRzck49wHqiKYhfW4XEw=;
        b=eGlzVoDxmPt+I/u5Ylk8li3CUrvne2jebkqfT6f5L27NXKYiE7khUOsoCJk8d6Mb4W
         zTWsC6W6PSkcaXt3bJgY7pSA7HGEHPiGARopncNjoSV2n9SNT1eWSMKflh2xdNYluRsQ
         YA8kCs43mQksCxmEmH6VyfAA9o6asLLi+Lz7o5AchFWNNIn7o7Zf7hEb76y58rWQ2JO0
         ySuxPscV/WggvNXrqOvttnF8xzNmdjVU6dNjKXax+lYwmcnoQXkSZ4WeTufPOecRaPh5
         0Y8zQW6Pls6DZj90yqtXLm06V+duYOsnT+I02+KzDqaSajyFqCmezY8kdCRub0OfBhaK
         EQvA==
X-Gm-Message-State: AFuF++mSkK/5GmJ9IrstZLCOo3jNN5VwCg088bO6xhuC13Rr8f1vPFTn
	lHMPM9MAoMLjQA3pZyffryHsnEeiBpKz5Q2jWZsYlXkCmhV/je6Gzln7aazFREWRBcA=
X-Gm-Gg: AYBFou0340Ma6bb4WkK7FIhYoKd7SKG0aQIa+eq01xtGnSQyIeOUJv9+ia+ywJydFpu
	mUQs8wqVIgnsM9OnZg1P0jwgNP4VfR6dpxn820tNTw1gcX4ncONZch2mThmugYPhGuSZ7wYDF3L
	eN8xa2rcfij/cGzPb1hhzXgaFK419gS1uAqUy1Xo3o+nv0GkjE1tZaxtDWKY/tK1OVGpcNUYxuA
	Zy0Sjs8+gV6CG+PbMsUQCMB1DOrYVnpxxrW5eANYS/2uTcfnIZaacG2hJE0koQgq5dx1AruPx4R
	/9yBL2cv6/+frr8WxdM9gzeE2lnZ2e1qix8UI6jS8SfJHbLMyoWl2H7oc6iNBmM2NHGew4TeMxH
	hXVL5oYbCVu+om6Xb7q/V8ksBvrLcO2GtH5XcXjX9Q4UNcVyxrtt5sR7A4nV5EugFhVBJfMa4K8
	kH/P8xplWW4Ss/tMKAI7lAvkLE1LDvW8ijuvY8xx8zQVN0GQ8PPLECw/tcBg9ZXK0Ooq3+MZX4x
	ITmUxMYjuqvJM8ZK/F3TnnvXeXQpQ==
X-Received: by 2002:a17:902:e805:b0:2db:3b35:1ac6 with SMTP id d9443c01a7336-2db3b351c2emr285537295ad.5.1788892295153;
        Tue, 08 Sep 2026 11:31:35 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1483de0asm61349875ad.11.2026.09.08.11.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 11:31:34 -0700 (PDT)
Date: Tue, 8 Sep 2026 11:31:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Alexander Zubkov <green@qrator.net>
Cc: netdev@vger.kernel.org, Petr Machata <me@pmachata.org>, Ido Schimmel
 <idosch@nvidia.com>
Subject: Re: [PATCH iproute2 v2 0/2] ip: ipstats: Fix statistics split
 across netlink messages
Message-ID: <20260908113123.16604ef7@phoenix.local>
In-Reply-To: <20260908181225.31712-1-green@qrator.net>
References: <20260830181949.1096-1-green@qrator.net>
	<20260908181225.31712-1-green@qrator.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Sep 2026 20:12:23 +0200
Alexander Zubkov <green@qrator.net> wrote:

> The kernel can split the statistics of one interface across several
> netlink messages, and "ip stats" formats each of them on its own, so the
> interface is shown twice and part of its statistics is lost. Easy to hit
> with "group offload subgroup l3_stats" on a box with many netdevices:
> 
>     109: vlan859: group offload subgroup l3_stats on used on
> 
>     109: vlan859: group offload subgroup l3_stats
> 
> Patch 1 merges such messages before formatting them, patch 2 is an
> unrelated cleanup.
> 
> What the merge rests on, for whoever touches it next:
> 
>  - Only the last attribute of one message and the first of the next can
>    be two halves of one nest.
> 
>  - A leaf is emitted in one piece, so a leaf attribute seen in both
>    messages is a layout the kernel does not produce, and the merge is
>    refused.
> 
>  - An array is only ever split between two of its elements. Were an
>    element itself split, the result would not be distinguishable from a
>    longer array of shorter elements, and no reader could reassemble it.
> 
>  - At the outer level ipstats_stat_ifla_max[] tells which attributes are
>    nests. One level in there is no such table, and none is needed: the
>    children of the two halves are whole either way, whether they are an
>    array, split only between elements, or attributes indexed by type, of
>    which there is at most one of each. Appending them is then what the
>    kernel would have sent unsplit.
> 
>  - Where the merge does not apply, the two messages are formatted
>    separately, which is the behaviour this patch set replaces rather
>    than a new failure mode.
> 
> v2:
>  - Comments and commit messages trimmed, the merge reworked around the
>    two border attributes that can actually be halves of one nest.
> 
> Alexander Zubkov (2):
>   ip: ipstats: Merge statistics split across several netlink messages
>   ip: ipstats: Do not hide HW statistics when hw_stats_info is missing
> 
>  ip/ipstats.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 258 insertions(+), 8 deletions(-)
> 

This is a real problem (not AI hallucination) but the code generated is
far larger than really needed. I asked Fable to come up with something
more concise.


The fix is right in principle. Per-ifindex buffering is unavoidable
here: each enabled group prints its own header and JSON object, and
l3_stats needs HW_S_INFO and L3_STATS together, so nothing can go out
until the next ifindex shows up. Merging the raw messages is also the
right layer, it leaves the show code alone. But the merge is about
three times bigger than the problem.

What the kernel actually does (rtnl_fill_statsinfo, rtnl_stats_dump,
br_fill_linkxstats): a message is kept partial only when prividx
advanced. The resume reopens the top-level nest in idxattr and, inside
it, at most one more nest (LINK_XSTATS_TYPE_BRIDGE, resumed at a VLAN
index). Everything below that is whole. Nothing at those two levels
repeats within one message; the only repeated type anywhere is
BRIDGE_XSTATS_VLAN, a leaf two levels down. So:

- ipstats_rta_count() and the na/nb test guard a layout that does not
  exist. Drop them.

- IPSTATS_MERGE_REFUSE guards a leaf on both sides, which idxattr
  gating rules out. If it ever happened, copying both and letting
  parse_rtattr() keep the first is no worse than a warning plus
  formatting the halves separately. Drop it, and the -EOPNOTSUPP
  fallback in ipstats_dump_one() with it.

- With those gone the enum and ipstats_merge_classify() collapse into
  one condition and the switch into an if.

Something like this. Checked against synthetic offload, bridge VLAN
and empty-nest splits, same bytes as your version:

/* The kernel resumes a split dump by reopening the top-level nest it
 * stopped in and, for bridge xstats, the nest inside that. Everything
 * below is whole and nothing at those two levels repeats, so join the
 * two halves at the boundary and copy the rest.
 */
static int ipstats_merge_attrs(struct nlmsghdr *n, int maxlen,
			       struct rtattr *a, int alen,
			       struct rtattr *b, int blen, int depth)
{
	struct rtattr *last = NULL, *rta, *nest;
	unsigned short type;
	int rem;

	/* type 0 is 64-bit padding, possibly on either side of the split */
	for (rta = a, rem = alen; RTA_OK(rta, rem); rta = RTA_NEXT(rta, rem))
		if (rta->rta_type)
			last = rta;
	while (RTA_OK(b, blen) && !b->rta_type)
		b = RTA_NEXT(b, blen);

	if (depth == 2 || !last || !RTA_OK(b, blen))
		goto copy;
	type = last->rta_type & NLA_TYPE_MASK;
	if (type != (b->rta_type & NLA_TYPE_MASK) ||
	    (!depth && (type > IFLA_STATS_MAX || !ipstats_stat_ifla_max[type])))
		goto copy;

	if (addraw_l(n, maxlen, a, (char *)last - (char *)a))
		return -EMSGSIZE;
	nest = addattr_nest(n, maxlen, last->rta_type);
	if (ipstats_merge_attrs(n, maxlen, RTA_DATA(last), RTA_PAYLOAD(last),
				RTA_DATA(b), RTA_PAYLOAD(b), depth + 1))
		return -EMSGSIZE;
	addattr_nest_end(n, nest);
	b = RTA_NEXT(b, blen);
	return addraw_l(n, maxlen, b, blen) ? -EMSGSIZE : 0;

copy:
	if (addraw_l(n, maxlen, a, alen) || addraw_l(n, maxlen, b, blen))
		return -EMSGSIZE;
	return 0;
}

The dump side is then: flush pending if the ifindex changed, then
either copy the message or merge it into pending. No need for the
err out-parameter or a separate ipstats_msg_merge().

Nits:

- addattr_nest() never returns NULL, those checks are dead.

- Mask rta_type with NLA_TYPE_MASK before comparing or indexing.
  HW_S_INFO already carries NLA_F_NESTED; your >= ARRAY_SIZE test
  would refuse the merge if a top-level nest ever grew the flag.

- calloc -> malloc, addraw_l() zeroes the padding.

- The cover letter bullets are the comment that belongs above the
  merge function, in three lines.

Patch 2 is fine on its own.

Unrelated, for Petr/Ido: in rtnl_fill_statsinfo() when
nla_nest_start_noflag() itself fails, the message is cancelled
(prividx did not move) but idxattr stays set, so the retry for that
netdev skips IFLA_STATS_LINK_64.
