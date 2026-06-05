Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313C478E4A
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644314; cv=pass; b=bqMCP/+Re89hNc5g7pu0rv3Tj2NuCJWN4Q3QyDKoz60/1Clmnr4w2+kNiX+z5yULNp1jXOs3WEN927oPlQjMvu1FKr95kXVV8DBTbFFm0gyfbhbk+f0mgKrIYlpkIwyyDsWXibIuwiHOFUubULle7YPgz1yRfNu/NQ6e3VHeK0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644314; c=relaxed/simple;
	bh=HJ6nNLxZW17HnlRUaGy/Sxke2oo2S9hPN7kv1Q8CyYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b56CKrTcSGLTwcKHXh/vNOXTlKP+Jrd3qPp6jx9XV9rbeyS+w2YQuSafKdPFrGV4V3vjddHjrqcbC0zbc54b6nwlHan7GImCYrUZl5tkb+yCnMX0uElX1KAPwgbi7NKMx2MLwqLJN9QXB5kh3B/10Gl87O4E4wITY9mYFgSRbtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CPP36oFc; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPP36oFc"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-517760dc3c2so9656651cf.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 00:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780644312; cv=none;
        d=google.com; s=arc-20240605;
        b=jar6XA084BpRAM6iE0VXkn/ZEBXytJmdyjBiZhceC8k+Rd8K5OPgfwovtoyxwmm2vA
         KB3zArxT2KBGfxkt9WXOEXdTYjus3NEqI/te0YKpuMHag/H/y1T5WmfE95BF7du7XgmZ
         vHLz4eXAd7L7jtQGm3Etq4T2SmIBik3zXMlTmcETQWWpAht8QEZ3XfolBCCfQmiMY446
         PRnTD/y5olbMp+0Vp4A6EPJqNe42VVrpgzVzEtp6dLtf74vGbIpCbTQRsgNFZk9UcPq3
         /aHKmd5NBfk5KrH9/E75aptQQ6vf5D+3qiPtx455DSjUv3ApBhDQHSF8OIo7b1chUQxm
         yBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qKU63sZNkKiVuh/MwJ9Ce0lsts4Qigj8G34ohJIexYE=;
        fh=PZV6zRaub6D26KWTjB30cloRcJgZCSoB4S4VxXc7hGI=;
        b=PRfrc+BsddwuLdxpxiwjBVT0r9vOQKqkEH2uWdoWqU99oVEgE0Kywod/bQw1a0pHo2
         EYSqdaJVW4RSqc473pfz+1PPz9mpLBoSqBCOuUJVmANS6JnDDZoIIwmoFcs8iOYE189t
         bAPs4XIOVI6/5JFKFLvJIz6tc1AOLDG7OC2IgwfQhyL/rU0ASEMvgYIycXtOBCk+HuD2
         B/L3LQb26JHc64XLjwXzQTkKsuhMj7FHFL1WAtrekbPPw/y0Ajqnd8g+BNNpqmhGLov7
         1Ai8/4YdNSCwgcGJAEkVLxhDVMqTIyXI5tsl1I5YVbJrWoEfONR5NB69j9hA9QtV0lpZ
         tfDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780644312; x=1781249112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKU63sZNkKiVuh/MwJ9Ce0lsts4Qigj8G34ohJIexYE=;
        b=CPP36oFcf4HCXQh8/BWzgdta8IVWrE2/LtI5SluagSi/rVsQ8dEt1dbiGLHfhbgY6b
         J5L2kuByM7lZRCKPJYSDtX0B+WCrQ4nTMiRTM9lMzpnbf3fA/0TRLhGyzdQpxcU3sDM5
         BzqWGJFmV3MMyl0CzFtIRQc2dYyW2zqgkA+xslVHhY7cgR6qZEx5jm5bLjktvj8e7BEv
         NqbGztjkY+ogFoN/edJac2qKDr2rOLEGfEX9jiB0LlYVFvNYKC+7+VIJKjwnu17I3u3I
         zxZqzbiN9mpP3IVn2x3kf8Zsk0/jFttZ8tV1Rxs5EXcNjO7HLVaQsMmh5C/6NhGkVAls
         Vl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780644312; x=1781249112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qKU63sZNkKiVuh/MwJ9Ce0lsts4Qigj8G34ohJIexYE=;
        b=kcelmPOoICKLwPj+8ffGe/VPjsXEYtlThPn/trx6bvUQPOJBO1Z//zzf85rEEBvLip
         iaVznQn3br16ON4PWkIxu3Qc2l9C5+yZd05F314EH/MdeEFPeiSZV4S0Qo+FiZbZbg90
         m26MwaGFGLOA++O8Ub5puzF05RACmmb0PH1ZIkYNVSclN3qDAiPzDNVuEA6aJAKFWf84
         zLuI9Po5oBDVFzn7RSIveCcDBEl0YzhW9AK/Kt17u2Gz4/3jYgKgblsoVZb9ShGcY7HM
         CpWJMEW3h51RYsljcP4XX/TVrlPnjRxZMNAWjDgj3LMVRHbsj3P82nrp/+mmqmlf5coE
         2YDw==
X-Forwarded-Encrypted: i=1; AFNElJ+f4dnidNjZVZ+S933CSxeicnMPFApDa+vCVGGOd7DtMnZDebWBVMrJStws1m8Q4iHIsuh0ou8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVepKywMP12c9O6CmZtZgXnmUt4Os7hH9mnQOWebbyRVvH9wRJ
	VX7S9mQY1DgKOYUG3nUcIem596Ee8JpzgQsQ7dfs8NfW7XR/+qlhS5pRmmx1tvMQanwMy1A6ON8
	dMFZCCPXUQ16CI5l4wlkCmcNQlWpt2WgyH98srl09
X-Gm-Gg: Acq92OGwSnjZORrEkci9hzh5+XMbKgx0CaLdLvn6fKlb7EaH17lqyG3KCD74s2IkGQg
	nlb0ZZAbxtwhAoPt5mngHs2CtkaRCiDiBEUoqpEmKaoyER8/ecm+vC64aUgVZgYUTssnjVVK6gV
	xBYmorsGq+FO1HTf3ndGU1pqm5zFRwbozz/WJMU5jrTSmilfF9h5r7fl8ZRCSLsD9o+N2U3NN7L
	/ciBqKNxmSRyJv9zyQl+UOqBqjClOV+NdQvaIySKM8zU7syJPagM65L9tOOEeytiv0FZJ/53kT+
	v8/emxEu+wpRBIdqc2fIWsu0ZeD5kfBIN0qdYuiJWb7PayGHQBaJ6oeltErUh4VbUFxSdkJ2CLO
	Hl9im67p/JLYyGglpwE6rYFqVjeyR5poF+8DOfoY=
X-Received: by 2002:a05:622a:4d09:b0:50d:65ec:a071 with SMTP id
 d75a77b69052e-51795a8da05mr40394911cf.5.1780644311231; Fri, 05 Jun 2026
 00:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602183122.747759-1-pfalcato@suse.de> <20260602183122.747759-3-pfalcato@suse.de>
 <6d70757a-a849-4828-89e7-f3d51bf8c9f8@kernel.org> <aiHIQ4ZxnMSifhmi@pedro-suse>
 <0198cf7c-ba09-47e9-abc3-dd230c1183dc@kernel.org>
In-Reply-To: <0198cf7c-ba09-47e9-abc3-dd230c1183dc@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Jun 2026 00:25:00 -0700
X-Gm-Features: AVHnY4Ljnr1fO2_Ja9ct9TI0Ly9oIHrrXA2zxGwHDZ7iMunMRBy7qMI9IIG7ZO8
Message-ID: <CANn89iK_4g-2_U41CGYNdmBLCXyOARGdAakj26eigDhaL8hkCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: skb: isolate skb data area allocations into a
 separate bucket
To: Harry Yoo <harry@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:45=E2=80=AFPM Harry Yoo <harry@kernel.org> wrote:
>
>
>
> On 6/5/26 4:12 AM, Pedro Falcato wrote:
> > On Thu, Jun 04, 2026 at 02:30:34PM +0900, Harry Yoo wrote:
> >>
> >>
> >> On 6/3/26 3:31 AM, Pedro Falcato wrote:
> >>> SKB data area allocations (as done from alloc_skb()) use kmalloc().
> >>> These allocations can be variably sized and their contents can be mor=
e
> >>> or less controlled from userspace, which makes them useful for attack=
ers
> >>> that want to overwrite a use-after-free'd object from the same kmallo=
c slab
> >>> (which often just requires the sizes to roughly match into the same k=
malloc
> >>> bucket). [0] is an easy example of an exploit that uses netlink skb
> >>> allocation to target another similarly-sized accidentally freed objec=
t.
> >>>
> >>> While other mitigations like CONFIG_RANDOM_KMALLOC_CACHES exist, thes=
e are
> >>> probabilistic. Use the existing kmem buckets API to further isolate t=
hese
> >>> allocations in a guaranteed fashion, when CONFIG_SLAB_BUCKETS=3Dy.
> >>>
> >>> Link: https://github.com/google/security-research/blob/master/pocs/li=
nux/kernelctf/CVE-2023-4207_lts_cos_mitigation_2/docs/exploit.md [0]
> >>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> >>> ---
> >>>  net/core/skbuff.c | 5 ++++-
> >>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >>> index 44a7f8401468..1f6c6b531ece 100644
> >>> --- a/net/core/skbuff.c
> >>> +++ b/net/core/skbuff.c
> >>> @@ -594,6 +594,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size, =
gfp_t flags, int node)
> >>>     return kmalloc_node_track_caller(obj_size, flags, node);
> >>>  }
> >>>
> >>> +static kmem_buckets *skb_data_buckets __ro_after_init;
> >>> +
> >>>  /*
> >>>   * kmalloc_reserve is a wrapper around kmalloc_node_track_caller tha=
t tells
> >>>   * the caller if emergency pfmemalloc reserves are being used. If it=
 is and
> >>> @@ -632,7 +634,7 @@ static void *kmalloc_reserve(unsigned int *size, =
gfp_t flags, int node,
> >>>      * Try a regular allocation, when that fails and we're not entitl=
ed
> >>>      * to the reserves, fail.
> >>>      */
> >>> -   obj =3D kmalloc_node_track_caller(obj_size,
> >>> +   obj =3D kmem_buckets_alloc_node_track_caller(skb_data_buckets, ob=
j_size,
> >>>                                     flags | __GFP_NOMEMALLOC | __GFP_=
NOWARN,
> >>>                                     node);
> >>>     if (likely(obj))
> >>
> >> What about kmalloc_pfmemalloc()?
> >
> > Good point, that looks free as well.
> >
> > Sidenote: isolating kmem_cache_alloc for possibly-aliasing caches could=
 also
> > be useful. skb allocation has net_hotdata.skb_small_head_cache. It does=
n't merge
> > with anything for $raisins (odd size, plus I don't think usercopy cache=
s are
> > getting merged?) but it feels too... accidental?
>
> Right, we never merge caches with useroffset/usersize.
>
> Hmm...
>
> /* SKB_SMALL_HEAD_CACHE_SIZE is the size used for the skbuff_small_head
>  * kmem_cache. The non-power-of-2 padding is kept for historical reasons =
and
>  * to avoid potential collisions with generic kmalloc bucket sizes.
>  */
> #define SKB_SMALL_HEAD_CACHE_SIZE                                       \
>         (is_power_of_2(SKB_SMALL_HEAD_SIZE) ?                   \
>                 (SKB_SMALL_HEAD_SIZE + L1_CACHE_BYTES) :        \
>                 SKB_SMALL_HEAD_SIZE)
>
>
> What are "historical reasons" other than avoiding collisions with
> kmalloc caches?

git log/blame might help :)

commit 0f42e3f4fe2a58394e37241d02d9ca6ab7b7d516
Author: Jiayuan Chen <jiayuan.chen@linux.dev>
Date:   Fri Apr 3 09:45:12 2026 +0800

    net: skb: fix cross-cache free of KFENCE-allocated skb head

Note that MAX_SKB_FRAGS can be tuned.

config MAX_SKB_FRAGS
int "Maximum number of fragments per skb_shared_info"
range 17 45
default 17
help
  Having more fragments per skb_shared_info can help GRO efficiency.
  This helps BIG TCP workloads, but might expose bugs in some
  legacy drivers.
  This also increases memory overhead of small packets,
  and in drivers using build_skb().
  If unsure, say 17.



>
> > Maybe passing something like SLAB_NO_MERGE and making the size
> > standard-looking would be nice. I have a size of 704 bytes per object, =
and
> > this probably causes some weird wastage for each slab.
>
> Yes, unless the "historical reasons" do not make it infeasible to do that=
.
>
> And I wonder if net/core/skbuff.c intends to always prevent merging, or
> only with hardening configs like SLAB_BUCKETS.

We do not care anymore of merging or not.
