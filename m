Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD43FFFAB
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380067; cv=pass; b=VY8CMVVRFtnGMlB73zJpEP/VLF+wcEKRdj/XQfvTTQXa6bGT4B49j8r2fuvNMrq2zZ9ulyXh4qln9ZkjCxH4WrfyMkC/2iQtnFdExXW9OVyxndat2SwHf9zEvSW65O/zPr7QXU3JuF6jDFX74DXEaCWwNzjZq5VgGSo6wz2jZ8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380067; c=relaxed/simple;
	bh=zD1nz9FVNtMUeJtdOWfkiJCLM7hpCKvd9Ocg3Udeak4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e028tnFe+MKwYUVv/Avf3BShTtJW1LdT4j1Qdh3wWUOVCjHY3a9JfZ28ln4hTgq9AHTYFqhaAMTG2N/unISvdsSuFfNLR3gMaDzjVWx1d7hlDTkyz19RM6YiqSlU22OJXHmTzQ7vtN3wgtVzCJD7JDXjZkKeIZVDQHqukisAIoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VpLZUcHc; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VpLZUcHc"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c01c79467so426001cf.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 09:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786380064; cv=none;
        d=google.com; s=arc-20260327;
        b=kCCOHBRUd8zwjWjQsiUdUKhRp8TGi30NEOGvyMywRlJpRNKjQHGrXHZAUNp9YQmRjs
         wyvEJxclaeQQzgm98laPHil6xz1C6Ivw6KMYKJs40i24JBtrC+D2p/YshhqLYiAz01PX
         rIoghqfneHIN2z9aFZkXoieUFl3rqBJStUVJN95kkPbiP6PFcBXIiUvCVy7n3dh/aFNb
         iuR+KhEeHIIpprfPJMYPtgxj7dnWO6rvapuG6MwxCm4YTrkYw/TlROwFSyz3bxrzMLA5
         /DznlOVEsWRdf7jqJir+5uK83vFwxwpdRY0t19tukG/0nI/i5qKY/B9PqY+LsMEeWCnH
         QNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m17UbQGMqxi7cFAb0MblsfMgzscucpvWwE8sKi+3QSo=;
        fh=x4/Rl8LfAFvsjd/+Mr2FqpGQLdJxZG6KLpBAkHEwIV4=;
        b=agcBArD1KDElqdXPkVC9gpRThAB1QJCBHe7tl98StJasDOqBkLJoGF8JB7ylC7OIK+
         Tdcc5Pqvtq5GNmROCLQlIna4yqmt8Z1BU/CIkiUVV6eQtmifemWGk5pAghIPa2Fmcrtl
         Kik/65VoShMRWfNpDPj1Jy7EOuAfDIFqxMrh3ZeFZq10fa7jop7Oo/eCe0lH45AMzY+F
         7kB4iPYUX50neUGpi+j+AzhcZYv/pcKVCYEFGmv4eXidCxKWI29cpb5NnC+YbHUOqBhE
         Il/fHb2EWIVC2Cq9yA6cUETqNOcHFfBHvNZGNqk4nrYArmqK6ILp5Sp4/jkQysdXWrza
         QDPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786380064; x=1786984864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m17UbQGMqxi7cFAb0MblsfMgzscucpvWwE8sKi+3QSo=;
        b=VpLZUcHcjABrw5eNDpVUbVnkPRdn+imJ/Ho4nbp5560yA8Z4rv+TKlFEXH632XShms
         2zbPheSoPnMFEXrexq1quJR+cySrLDX+jSdMNqx7johFzhNcDGPs7v1wXYcIJZalz70w
         6iNDYICbkx3QspXKCySvkaHMFip6VjtXukiRDNJLvRjyiCT2r47yJSnycdCJ1csF2f16
         I4pYfqP381QNsuCeOhxflE7KVdbmhWlk9zub4rpbznUaGSR01i2RDtC6YuzuVCQmDgOY
         RHm4WruzQdmxyuFigbC7jCjr56LfP90AlOFHgKKLhmX5L8wSBJPJWrlpvz+fpNPISzDw
         qCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380064; x=1786984864;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m17UbQGMqxi7cFAb0MblsfMgzscucpvWwE8sKi+3QSo=;
        b=EhDAZ25URDoOmzl67+r5artEiUpF746eI4DgD0FheZMTzVCGvJAPjB4W3mbCzHUGF3
         76Rdkz1fLblBTXS8uqQDreX8leD5vVKGRCFG3M2+WzIytIlD/Insg0Pz2FkLB3e0j5GJ
         z3Bv5tgcH6ZX1+5Qi4GiJr7XOP81W19eIo9V66nw0WrtIwj0/vLBVBoeJsXEtVzf4Nxs
         hTEsWzSE3onA4IVSssQyS2ghbBwY1QYwuaRWHi77DGmszLODNBn60/apo6KcRzm+0NZr
         6+VgX1sW5n3svDSMKCBzmyIt9tbjgM8gYm61jH63QjKhNiWsan7KRWAoLsDAi9ZjfnAY
         E1og==
X-Forwarded-Encrypted: i=1; AHgh+Rq4q/qX2ce3kQ8gwNgbvj4ozwAn5EkQeDnYbiqMzqrAurN43mnrU1VV2FgqQbcYU3N+1iCyLk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl6mtcUknesjTxXUWS70liY7fK15FR+LH84/xclMvdqpdDWTGY
	6onsfcbRb+Hvvs3zXQ3w0v91QiXvHdZUcVNgAK1lns6cSxEyI/dvfv3Zvra2MVLQmusxJECWCnP
	hRbju9h9NxFqJlvUneX5Rb5QfHIW0ZdlL72u9zApU
X-Gm-Gg: AR+sD12dJB+tLavDc5RGmFfEje5f9zTiFV9ceN9ln197K/TvRbq6cN2Vnx4Y4nxG+/9
	eGyph+35acV/Ue7kzvOw0XSF3RiS55SdSmFBHGuF7j2O3SOxdC4eCsGWsPVpCfkZroF41D22VJ/
	N2aI7SEPdfj+a/Kk8qjTeWZZ8c4J+aj44VeSlGRHcdxRUnsBnDtlPcISyk8WEm1XRkZJJzAAthf
	XPKo3G7JcRMQelIjNMm8/bk3eK9+Oqi5VXF7XebQbufRupjvckTjhr2uNn5r5Gp6Kd5+7VydwVP
	4AAI0XQMveDPNEMTKdAQt3O9cTPdLu7UfhLxWLPjDpA=
X-Received: by 2002:a05:622a:4a8a:b0:528:38d6:71b4 with SMTP id
 d75a77b69052e-52d28159aafmr36460991cf.11.1786380063820; Mon, 10 Aug 2026
 09:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806200548.3124802-1-surenb@google.com> <20260806200548.3124802-2-surenb@google.com>
 <anaCkrk55EQoE2aS@casper.infradead.org> <anmQIeQIGkZdCKVU@lucifer> <anmcwYilggkd_-B5@lucifer>
In-Reply-To: <anmcwYilggkd_-B5@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 10 Aug 2026 09:40:52 -0700
X-Gm-Features: AUfX_mxHsauyQeZO29u25G5ulMG58oqaTVi8Qutjp1dLMmIvZ6xLXUZCqjxNRn0
Message-ID: <CAJuCfpHngcCttUaUtAJVxF5J4-WGGscx+mEu7LPqd4K61kLOdw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] mm: Make per-VMA locks available universally
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, david@kernel.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com, 
	aliceryhl@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 2:43=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Mon, Aug 10, 2026 at 09:52:11AM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Sat, Aug 08, 2026 at 02:12:50AM +0100, Matthew Wilcox wrote:
> > > On Thu, Aug 06, 2026 at 01:05:44PM -0700, Suren Baghdasaryan wrote:
> > > > +++ b/kernel/bpf/stackmap.c
> > > > @@ -272,13 +272,8 @@ struct stack_map_vma_lock {
> > > >  /*
> > > >   * Acquire a stable read-side reference on the VMA covering @ip.
> > > >   *
> > > > - * With CONFIG_PER_VMA_LOCK=3Dy this returns a VMA with its per-VM=
A read
> > > > - * lock held and mmap_lock dropped, so the caller may sleep.
> > > > - *
> > > > - * With CONFIG_PER_VMA_LOCK=3Dn it returns a VMA with mmap_lock st=
ill
> > > > - * held; the caller must snapshot any fields it needs and pin vm_f=
ile
> > > > - * with get_file() before stack_map_unlock_vma() drops mmap_lock, =
as
> > > > - * the VMA may be split, merged, or freed after that.
> > > > + * This returns a VMA with its per-VMA read lock held and mmap_loc=
k
> > > > + * dropped, so the caller may sleep.
> > >
> > > I don't know if BPF is compatible with !MMU or not, but the comment
> > > is inconsistent with the code.  How about:
> >
> > <requisite nommu rant>
> >
> > I do think there are components that simply don't think to depend on CO=
NFIG_MMU
> > even though they do.
> >
> > In fact more than think - have run into exactly that before.
> >
> > It's another thing that speaks to nommu being a legacy barnacle that ba=
shes us
> > on the head fairly regularly for little to no gain (and nobody is testi=
ng it for
> > tip kernel AFAICT).
> >
> > </requisite nommu rant>
> >
> > >
> > >  * On NOMMU configurations, returns with the mmap_lock held.  If the =
MMU
> > >  * is enabled, the per-VMA lock will be held instead.  The lock
> > >  * should be released with stack_map_unlock_vma() which will release =
the
> > >  * appropriate lock.  Once the lock is released, the VMA may be freed=
.
> >
> > I mean I suppose it's accurate but I don't love the idea of essentially=
 implying
> > nommu+bpf is a thing and also treating it as so important that it must =
be called
> > out here.
> >
> > I'd rather it be inaccurate for nommu as are most comments in mm and mm=
-adjacent
> > components, it's kinda implied in general. Those who care can look at t=
he code.
>
> Actually scratch that I'm wrong, firstly Suren's series explicitly does s=
ome
> nommu-specific logic in the bpf code and secondly BPF already has nommu-s=
pecific
> stuff in it.
>
> It seems nommu bpf is (kinda) a supported path.

Ok, I'll change it the way Matthew suggested then.

>
> >
> > >
> > > >   * Returns NULL on failure, in which case no lock is held.
> > > >   */
>
> --
> Cheers, Lorenzo
