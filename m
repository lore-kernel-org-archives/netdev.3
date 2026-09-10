Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030F13BBA0D
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032031; cv=pass; b=I7EDag2RkPe1KDuWTmMIwzzxo9E8yL5buNwCQEFSh739OafbuWEbl5nVbk5pceJo3PedYSNaz4Qfe2xPJP2Ny9HPh2mdyhQnsFWDOJqKFViix8edRK9tgd8Be+F/vF99cCCK0Sm/Sq8ccRg2Eh5XIu8FDTTXYqkWmjhANjkwlX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032031; c=relaxed/simple;
	bh=vjcFsdx+OWmfN+e1puRAxR73rbMuw1qtGHYTYiVxuTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvjXb54CqkLlQh0npQQcUiaM5c27d9CYpPtS7DCy+dxPKvrn4KMwybnaZyda325iUvkLEmWYFIGzkClsv+5w+f1RymOfEbxoMGhEBlHxurya2Ux+SyLC9wyQP3eFTBVhcnR2IKJR+mW7oKaDxm9K4V1ilj3SB0Hf8OxRFoBr0Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net; spf=pass smtp.mailfrom=qrator.net; dkim=pass (1024-bit key) header.d=qrator.net header.i=@qrator.net header.b=iqUI6xYj; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qrator.net header.i=@qrator.net header.b="iqUI6xYj"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso8123831a91.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 02:20:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789032027; cv=none;
        d=google.com; s=arc-20260327;
        b=HypvAOm1TtcsijwszR6iH/tZQQMRXeKB7W2CMt+XDWD/P6bF+MUVrkBLxsxgArza6r
         cCoRk8Jl1pGZRK6cSvP9lT2vIgZLO9/At7b4jj2DoUdaD343Ocw4ULbOg6AKlpioqDu+
         Yk4J3ZuX98EHFm3uuZ2Ms3obCUER6UVCqesq/gvtWK1jcacYhXN61ZiB7TqqQ6RS15J2
         1/C0zDcKDNKcYK5TAFYZ/sszrLlsIjNmdQ6WKatkjy77r6+OFphQb/gXLeN0RTsGNbRC
         M9aYOsF9WWHzm9urDHFkcFiGHqP/uDhqEkkr0MceDyx2P3U7eLaG53IJalXcCGlMd2In
         BXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5a1NTf8f50RWDetuWbF6sPyLXhIutWr6cV/jB+Euj18=;
        fh=ZjiePLZAkocQpKo0AWedQskKSWDcBzt3zQnQbTW4rKg=;
        b=P6rCbX5WnQhYNDyOMiqqITlndIc7CERYK2nDv5qXIHGoAVA3Q/ZQJF3XpUaXSO0g6o
         8T7T7Ind+kJUp2s6BvqRFnlhJl/WoZxE+W5vG6HspLZmToGOoUR1i/dTLGIUuWlklNg/
         L9vIc0gty1XN2b7I0VB4tsqdhJ59gTUtxmWVgMtX/4HwBY2m4iVJs8xAS3cGTf4Txj/6
         GrSZhtaw/ddKqFK4jBmN5HH1l5rFo5JdGG7RKsMlJ1WbsMMm8rQ3nlxkVX9jI2n/mggY
         Xo4uPE36l41IUojCJ606vBvP61qM9vdwH6rjUgJPoLD/XTkEqxhA7j1JKDnHCF2lpxL4
         bjpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qrator.net; s=google; t=1789032027; x=1789636827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5a1NTf8f50RWDetuWbF6sPyLXhIutWr6cV/jB+Euj18=;
        b=iqUI6xYj41yNdEQa1yectThSzp98jNVQ89JoZs4cCMpuB2+4Cd7nRtHFaJ7FA29LDJ
         Y54oSsoKC95W3PmtzN4dLJNMeQP/pKKZ3Ik3/SNqZpZKT34vTr/mYSzZzqXylvmFrfB1
         wrA0abIXhaygq8yUB4z75/wZX0bul++biTzm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789032027; x=1789636827;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5a1NTf8f50RWDetuWbF6sPyLXhIutWr6cV/jB+Euj18=;
        b=AD7hfNSlHXrhkLy9ahDZMqmqm0ttL6pg2uwEQfFFh5xnxQQZ1HaWoiQu4jLRVw/Cht
         yR2Lzdrtt50OtWAnOHVDb/O/Be4O815/S07IkZ0QgDeBmjWzrAXZJNPU2ag8PyviHxi4
         7YL7a0ON7XQd8gDWw7wNfjY3Olf/aP7LTQLQAHPKKuVQDcFpkaiFmzyolwsKx50Wq7dr
         NodolPRSHlZQQo7xTw6QhboogEpV/Pe+5Y6K9N5uJqxnk2XacI0OtlTLfZWBxBPTl1TD
         y/HkBHF0sYhTEWQ8FsF6QqHBc880q+vGftnye7ASYzARlcC2BLqmINL1CNNLydtZF9sF
         5idQ==
X-Gm-Message-State: AFuF++nbJ+hWXx3Ofs6BShUMP6b1iPoOV1u/KWxQqELwt/vRZ3VS1mwn
	/SJdir4ijsKiVDkMMNfIiF7H1a5dyUHKR8TfvBxaqXImTFRPSO5ZIPtxs5wbee86JwcrKKvW9yZ
	2l3nKHZIbPQGIokdw4dQx7Bxkqos1y1wJf/CczA9N3w==
X-Gm-Gg: AYBFou2VnhADUesPksTdFxoil+sr4eMGOdbg5oNF9YEHR3xtEHbU/UJ8A2Y5IkrvEjA
	WqZhyTdnbEgm4DigH1dNGMMKVAeJdsoELnT/aqXzn5WYeHafacK4XrguM856L5xdRE4GqzO5Ve+
	kmvioIwE+8I4Eak5sIRV0Zi0S9rp0vgjNF3n4pp5xp3ei3rsT/be+mbKTN4uUoqHKDBaPRbzYzi
	3ywEHfdtK4So5V3emRS9VyaJIQYLMZ/WxZvrEFId8m8iI07hEZoWWF44qmavZfaadlAg7qAqgvt
	cAaaAIPWcaOluY9vQLJcGSyT1WHjDKXQl1c+7pxTyY9k976uEBnMiQC6vOxLDU7V0uBoecDDC9D
	ZzaNAlE8BL5YqO7VXE6ZixQ1iP11daQ8KdHUfpqPHgaFtm9DBk+H/LIO5XVmU9WyqkdZOf2paiQ
	==
X-Received: by 2002:a17:90b:5343:b0:398:e46e:ade3 with SMTP id
 98e67ed59e1d1-39b2628fc1amr63947624a91.23.1789032026811; Thu, 10 Sep 2026
 02:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830181949.1096-1-green@qrator.net> <20260908181225.31712-1-green@qrator.net>
 <20260908113123.16604ef7@phoenix.local>
In-Reply-To: <20260908113123.16604ef7@phoenix.local>
From: Alexander Zubkov <green@qrator.net>
Date: Thu, 10 Sep 2026 11:20:00 +0200
X-Gm-Features: AcwNN1Xgag9KeC-6xsVRn-m4cYhD0ReeYkF76y7Qirk49pMV90qUyqaq7uTJzPM
Message-ID: <CABr+u0badmsby4XGvEoa7h9ghbUk3W83dj3qkb6kMT9VN+hsNA@mail.gmail.com>
Subject: Re: [PATCH iproute2 v2 0/2] ip: ipstats: Fix statistics split across
 netlink messages
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Petr Machata <me@pmachata.org>, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 8:31=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue,  8 Sep 2026 20:12:23 +0200
> Alexander Zubkov <green@qrator.net> wrote:
>
> > The kernel can split the statistics of one interface across several
> > netlink messages, and "ip stats" formats each of them on its own, so th=
e
> > interface is shown twice and part of its statistics is lost. Easy to hi=
t
> > with "group offload subgroup l3_stats" on a box with many netdevices:
> >
> >     109: vlan859: group offload subgroup l3_stats on used on
> >
> >     109: vlan859: group offload subgroup l3_stats
> >
> > Patch 1 merges such messages before formatting them, patch 2 is an
> > unrelated cleanup.
> >
> > What the merge rests on, for whoever touches it next:
> >
> >  - Only the last attribute of one message and the first of the next can
> >    be two halves of one nest.
> >
> >  - A leaf is emitted in one piece, so a leaf attribute seen in both
> >    messages is a layout the kernel does not produce, and the merge is
> >    refused.
> >
> >  - An array is only ever split between two of its elements. Were an
> >    element itself split, the result would not be distinguishable from a
> >    longer array of shorter elements, and no reader could reassemble it.
> >
> >  - At the outer level ipstats_stat_ifla_max[] tells which attributes ar=
e
> >    nests. One level in there is no such table, and none is needed: the
> >    children of the two halves are whole either way, whether they are an
> >    array, split only between elements, or attributes indexed by type, o=
f
> >    which there is at most one of each. Appending them is then what the
> >    kernel would have sent unsplit.
> >
> >  - Where the merge does not apply, the two messages are formatted
> >    separately, which is the behaviour this patch set replaces rather
> >    than a new failure mode.
> >
> > v2:
> >  - Comments and commit messages trimmed, the merge reworked around the
> >    two border attributes that can actually be halves of one nest.
> >
> > Alexander Zubkov (2):
> >   ip: ipstats: Merge statistics split across several netlink messages
> >   ip: ipstats: Do not hide HW statistics when hw_stats_info is missing
> >
> >  ip/ipstats.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 258 insertions(+), 8 deletions(-)
> >
>
> This is a real problem (not AI hallucination) but the code generated is
> far larger than really needed. I asked Fable to come up with something
> more concise.
>

For sure, I faced it on our device and observed the split in strace
before turning to AI.

>
> The fix is right in principle. Per-ifindex buffering is unavoidable
> here: each enabled group prints its own header and JSON object, and
> l3_stats needs HW_S_INFO and L3_STATS together, so nothing can go out
> until the next ifindex shows up. Merging the raw messages is also the
> right layer, it leaves the show code alone. But the merge is about
> three times bigger than the problem.
>
> What the kernel actually does (rtnl_fill_statsinfo, rtnl_stats_dump,
> br_fill_linkxstats): a message is kept partial only when prividx
> advanced. The resume reopens the top-level nest in idxattr and, inside
> it, at most one more nest (LINK_XSTATS_TYPE_BRIDGE, resumed at a VLAN
> index). Everything below that is whole. Nothing at those two levels
> repeats within one message; the only repeated type anywhere is
> BRIDGE_XSTATS_VLAN, a leaf two levels down. So:

Thanks for the insights on the kernel internals, I lack this
knowledge, so yes, the original work was too generic.

>
> - ipstats_rta_count() and the na/nb test guard a layout that does not
>   exist. Drop them.
>
> - IPSTATS_MERGE_REFUSE guards a leaf on both sides, which idxattr
>   gating rules out. If it ever happened, copying both and letting
>   parse_rtattr() keep the first is no worse than a warning plus
>   formatting the halves separately. Drop it, and the -EOPNOTSUPP
>   fallback in ipstats_dump_one() with it.
>
> - With those gone the enum and ipstats_merge_classify() collapse into
>   one condition and the switch into an if.
>
> Something like this. Checked against synthetic offload, bridge VLAN
> and empty-nest splits, same bytes as your version:
>
> /* The kernel resumes a split dump by reopening the top-level nest it
>  * stopped in and, for bridge xstats, the nest inside that. Everything
>  * below is whole and nothing at those two levels repeats, so join the
>  * two halves at the boundary and copy the rest.
>  */
> static int ipstats_merge_attrs(struct nlmsghdr *n, int maxlen,
>                                struct rtattr *a, int alen,
>                                struct rtattr *b, int blen, int depth)
> {
>         struct rtattr *last =3D NULL, *rta, *nest;
>         unsigned short type;
>         int rem;
>
>         /* type 0 is 64-bit padding, possibly on either side of the split=
 */
>         for (rta =3D a, rem =3D alen; RTA_OK(rta, rem); rta =3D RTA_NEXT(=
rta, rem))
>                 if (rta->rta_type)
>                         last =3D rta;
>         while (RTA_OK(b, blen) && !b->rta_type)
>                 b =3D RTA_NEXT(b, blen);
>
>         if (depth =3D=3D 2 || !last || !RTA_OK(b, blen))
>                 goto copy;
>         type =3D last->rta_type & NLA_TYPE_MASK;
>         if (type !=3D (b->rta_type & NLA_TYPE_MASK) ||
>             (!depth && (type > IFLA_STATS_MAX || !ipstats_stat_ifla_max[t=
ype])))
>                 goto copy;
>
>         if (addraw_l(n, maxlen, a, (char *)last - (char *)a))
>                 return -EMSGSIZE;
>         nest =3D addattr_nest(n, maxlen, last->rta_type);
>         if (ipstats_merge_attrs(n, maxlen, RTA_DATA(last), RTA_PAYLOAD(la=
st),
>                                 RTA_DATA(b), RTA_PAYLOAD(b), depth + 1))
>                 return -EMSGSIZE;
>         addattr_nest_end(n, nest);
>         b =3D RTA_NEXT(b, blen);
>         return addraw_l(n, maxlen, b, blen) ? -EMSGSIZE : 0;
>
> copy:
>         if (addraw_l(n, maxlen, a, alen) || addraw_l(n, maxlen, b, blen))
>                 return -EMSGSIZE;
>         return 0;
> }
>
> The dump side is then: flush pending if the ifindex changed, then
> either copy the message or merge it into pending. No need for the
> err out-parameter or a separate ipstats_msg_merge().
>
> Nits:
>
> - addattr_nest() never returns NULL, those checks are dead.
>
> - Mask rta_type with NLA_TYPE_MASK before comparing or indexing.
>   HW_S_INFO already carries NLA_F_NESTED; your >=3D ARRAY_SIZE test
>   would refuse the merge if a top-level nest ever grew the flag.

This is actually related to an additional question I wanted to raise
later. The type is used to compare types, which should not be
different, and also to index ipstats_stat_ifla_max[], and the
top-level type is unflagged AFAIK. But I agree, that it better to mask
the type right now.

And my related question is the following. While preparing the patch we
noticed that parse_rtattr() pass 0 flag to parse_rtattr_flags(), so
the type is not masked there. And it seems to me that it is better to
apply the mask there too, if there is no strong reasons not to do it.
Because it would allow the kernel to add the nested flag the top level
attribute eventually, while now it cannot do that. Claude refered to
commit 0da4cfaa where Petr added masking to rta_parse_nested() only
and suggested that he might know the reason why the type is not masked
in other places.

>
> - calloc -> malloc, addraw_l() zeroes the padding.
>
> - The cover letter bullets are the comment that belongs above the
>   merge function, in three lines.
>
> Patch 2 is fine on its own.
>
> Unrelated, for Petr/Ido: in rtnl_fill_statsinfo() when
> nla_nest_start_noflag() itself fails, the message is cancelled
> (prividx did not move) but idxattr stays set, so the retry for that
> netdev skips IFLA_STATS_LINK_64.
