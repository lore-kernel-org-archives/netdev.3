Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19CE35B62C
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039151; cv=pass; b=jhvA9M1o9mVmvNGknK+KBKdSjZyqWMeB0R1juglaFtah+bHRHp1dYvY0hv2Ct2G2qMpwOIuzUKYNRB0oBcWLW0z0n9j/3tr3udGabfrNLag7fgM1TeHZ1SzGdJB7MdeTFzIuyWxztZI3APVn+I2z8pUEd0zCvckJ1UYO4ZerYHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039151; c=relaxed/simple;
	bh=5PLZoppNuezmUjK3pbdRmwtd2xFYPVB6yaluiFVADWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rg15vR9iIzS9hxGNFn+QzGeqORu9RSZRJtMBh21d0cwOFfC1IMIj7g5H68Y29Icqy/dCvBUtcUw6iWDj4naJIEjc56LGIqncA1wlr6yv6uRDkU2RK7Tl1704FIlmYhAx13PASwUKRKPH/Uj0r+nW3cIImuiQwAkYeB44M6nKIMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GZYOsOLe; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZYOsOLe"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2498909a91.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 10:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786039149; cv=none;
        d=google.com; s=arc-20260327;
        b=UPactzjGaMrgy3irhzXZvY9DajJnapxmgONMQFPsMAUrEvdpBolTQaqmvM5Gkwys0u
         X1chEEn8zixU+kKCL1XYcnTymryzKP6F4ev4Ku+gAKLOzRqUbAveOrZjWYccwS3QtN/6
         VFvFuy1eBEsL2BbIqCmg6RKrjOdU7/17QWpGNYNozdPbTl8m+yvIMxnij5yUXSQpkN+3
         aCd+Z/9kHkWHxT/VpRhzsN82B2HUv/Nw+RAwzz1HT28xCZYlgaCRKJRUL7vVfuwsUjnI
         KhUeB+c2lAlgo/j6++WMzf1mZMoBi4jZfAsth8ydvbYGU3mDpSNmMVS/nCCkqyw7puIa
         BmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q9h96cH2CRxVg+lMjWr+Aq9I6QjQk4gezSERd3fjzvo=;
        fh=+GCivXPrbIPZEbiqU3o9DLUzFEqHZSIcjoTU2wmrO0c=;
        b=mVbA09mxmcY6oaFCngnC3vyzDo5F4SJRIzlYpOJJXU4YnTb633gh8aLpVfg0Pqk15M
         cRgHT8SWN74TRazsD5Pvulhg3KDe2P93FuIE1fj09iqEBV6oHsh+8kgRAhe16jFeJAdn
         PcAmZ7gXJhmkBIH8q89WmFXLzky/zjdQU64rlOZHetwwx00IjPjEUp0qnw6+kcyDUMQm
         rp8YwdEYObBFW1cv47ATDWXlsuF6uzUVIrTkT25cO1apSTf2XIRtgbbQEldvl7dvzret
         1o8JB9Wk637CALDhoqYbvZg0xD0yeNfy5Weax98gQ+USmg/tei2KoFSAgqRxwxW3o9gm
         X4Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786039149; x=1786643949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q9h96cH2CRxVg+lMjWr+Aq9I6QjQk4gezSERd3fjzvo=;
        b=GZYOsOLeJfFOaXzbQ2sDqs2/mwCekfIpUHO2etthePzrcv0DLlEKZrJbBdQac+gGOU
         Gkk/jX22NLlaRoVZecSf96SvNdZFVIk6rxfd2r0cVVIPg1Z4gQjFvZmlFpP1DxJRuSWl
         S/N7IImwLDZ0pIY9fkn01GK3zYnvTiGh5T7UQjo8suAVpdG8N9qurVFjkpwfGsi1GrxY
         AQ5nvWb5roIOTFLWs0023jZwluoL32yomEwVuhePEEVJ5wgD8XDK2wEgj38iFAl9odl8
         Gk96xBZpSPkmsI29JKhJ5AlN8YoWVfuJ81rawMi/b8OeDebFdlAFEjm4+xasVhBDlyfJ
         isjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786039149; x=1786643949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q9h96cH2CRxVg+lMjWr+Aq9I6QjQk4gezSERd3fjzvo=;
        b=YT6uEQlVQF3VvFVz76IiQsv5Mii1iydd5v/RVtIbcE45BLJDGSdIPitNy9Orp8BOUO
         9OCcB8BIbA9xE1fU5TL3j3G4qq2s+4RZpY2kPza7w9KuTplSqSvx6cjusWxiJ7UKjtPu
         +FLEH/lhKk+3u1/udC6hP7GSLRtVk2Ebsud6mEfpBgskvRhTvUbhByxF0Ig6ENCl+Es8
         7BLt9IpTPlhYvN9YFDBtdFTmUOSuEGy0Lz33Yyl+RPYGh91M/NlV7KPvtORhaM6EKATO
         HmvWJ222wn+sW/uTYnw9g4tnErjMqdGOBxYc7Md9bHN9eoFyZXBSfch+YVGYRAmXm4g3
         bw0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrU8a1T02pHzkdxtIC46MUZeBV8VnRTfVTLnb5xATy9Jls/iTvXHwW0l7aWWxW8gY2xRtoVboA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVCemHAv/C8L+oq0dr8qAO/jbgfoC8DEobrt8e6LUUaN0KlSc/
	SZJWZe57yG/lqZdHskKFiGug6DRCwLqTOuqJS5WqtS3yHzQEHeBiYcNcwJK2c+2ZVOUgyWEM3UC
	m8B7fcMRn10s3Or4CpUHahhiJDVNWqtzEady3taEp
X-Gm-Gg: AR+sD12Ib5sM606GwAiLwt0c+zbhzlD67D8L0N9vi+NphrIiNQNuRFK2DT5hfXhT00j
	Ph6MJIgnn+2cA5LJRXdU3wO9MbomJv3mMQiS6yTN9KhMmGGxh9a1Z2M19HlrPR1MZuR9l0PKVAH
	1XJBwG6+yerBcTj2UbVLbUU8V7rvPj2ODkGcW92gq5DbsMRc23h4THhJjNkvdg4HhvDWNYJx3sG
	Adx/SHbds9A4Kn48yp77cUyDWVCygkRvDasqg96DHGXLQrKGthXyCf1A8pycmOD/LKhui9o1Vi0
	GhTvM5AzNnDD2DrtbF8OHhSNZPQp3rA+X3WzUXclXoH7l4kJU15g5ND1NUGUspeQXpVDA+069k1
	giNGRrdfm3vDhWZUku0jN/aVdnpvoPQVu8BShqp9O1z/KU4ZZhTSqYG2p5725v6ekdHLzXGMBhl
	6oY8m1yrvNf255ClzXHraWOe4=
X-Received: by 2002:a17:90b:2245:b0:38d:dfd1:7c1 with SMTP id
 98e67ed59e1d1-3903c542a40mr13637693a91.2.1786039148302; Thu, 06 Aug 2026
 10:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804002155.2233594-1-kuniyu@google.com> <20260806172900.2962014-1-kuba@kernel.org>
In-Reply-To: <20260806172900.2962014-1-kuba@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 6 Aug 2026 10:58:56 -0700
X-Gm-Features: AUfX_myaAeobjzjV8PUjySDiPcvb2aGCigevFCfC36oF1x4N6dAb_srAhZvir50
Message-ID: <CAAVpQUACUFcdUV_TURigYp=-wDamvN2PBQ+c+njYxAyDvmq8cg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] af_unix: Unlink scc_entry in unix_del_edge().
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org, 
	kylebot@openai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 10:29=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email says "I meant to send this yesterday, damn. This is completely
> separate right?"
> ---
> af_unix: Unlink scc_entry in unix_del_edge().
>
> A vertex whose out_degree drops to zero is moved to fpl->vertices and lat=
er
> freed by unix_free_vertices(), but it stayed linked in the circular
> scc_entry list built by __unix_walk_scc().  This adds a
> list_del(&vertex->scc_entry) so a following unix_walk_scc_fast() no longe=
r
> walks into the freed vertex.  Reported-by: Kyle Zeng <kylebot@openai.com>=
,
> Fixes: 4090fa373f0e ("af_unix: Replace garbage collection algorithm.").
>
> Two questions below, one about the changelog wording and one about the
> cyclic SCC accounting that the described remnant vertex feeds into.
>
> > af_unix: Unlink scc_entry in unix_del_edge().
> >
> > Kyle Zeng reported that GC could free a dead SCC partially.
> [ ... ]
> > However, X's SCC forces the next GC to call unix_walk_scc_fast(),
> > and it iterates over A through B's scc_entry.
>
> [Severity: Low]
> Could the changelog name what "iterates over A" means in practice?  A's
> vertex has already been kfree()d by unix_free_vertices() at that point, s=
o
> the fast walk reads and writes freed memory:
>
> net/unix/garbage.c:unix_scc_dead() {
>         list_for_each_entry_reverse(vertex, scc, scc_entry) {
>                 /* Don't restart DFS from this vertex. */
>                 list_move_tail(&vertex->entry, &unix_visited_vertices);
>         ...
> }
>
> net/unix/garbage.c:unix_collect_skb() {
>         list_for_each_entry_reverse(vertex, scc, scc_entry) {
>                 ...
>                 edge =3D list_first_entry(&vertex->edges, typeof(*edge), =
vertex_entry);
>         ...
> }
>
> The summary says "GC could free a dead SCC partially", and the words
> use-after-free or list corruption do not appear anywhere in the message.
> Since the trigger is ordinary unprivileged sendmsg(SCM_RIGHTS) plus close=
()
> on AF_UNIX sockets, would it help stable triage to say explicitly that th=
e
> pre-patch behaviour is a use-after-free on the freed unix_vertex?
>
> > This itself is not a problem since the next GC run will judge
> > B as dead as well and free it finally.
> >
> >        X -.   A <.> B -.
> >        ^--'         ^--'
>
> > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > index 0783555e25266..9fcaaf55cba5d 100644
> > --- a/net/unix/garbage.c
> > +++ b/net/unix/garbage.c
> > @@ -186,6 +186,7 @@ static void unix_del_edge(struct scm_fp_list *fpl, =
struct unix_edge *edge)
> >       if (!vertex->out_degree) {
> >               edge->predecessor->vertex =3D NULL;
> >               list_move_tail(&vertex->entry, &fpl->vertices);
> > +             list_del(&vertex->scc_entry);
> >       }
> >  }
>
> [Severity: High]
> This isn't a bug introduced by this patch, but the surviving remnant vert=
ex
> that the changelog accepts as harmless looks like it unbalances
> unix_graph_cyclic_sccs.
>
> __unix_walk_scc() only counts SCCs that are still alive:
>
> net/unix/garbage.c:__unix_walk_scc() {
>         if (unix_scc_dead(&scc, false)) {
>                 unix_collect_skb(&scc, hitlist);
>         } else {
>                 ...
>                 if (unix_scc_cyclic(&scc))
>                         cyclic_sccs++;
>         }
> }
>
> so the {A, B} SCC that the full walk judges dead contributes 0.  But the
> fast walk decrements once for every ring it finds dead:
>
> net/unix/garbage.c:unix_walk_scc_fast() {
>         vertex =3D list_first_entry(&unix_unvisited_vertices, typeof(*ver=
tex), entry);
>         list_add(&scc, &vertex->scc_entry);
>
>         if (unix_scc_dead(&scc, true)) {
>                 cyclic_sccs--;
>                 unix_collect_skb(&scc, hitlist);
>         }
>         ...
>         WRITE_ONCE(unix_graph_cyclic_sccs, cyclic_sccs);
>         WRITE_ONCE(unix_graph_state,
>                    cyclic_sccs ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLI=
C);
> }
>
> Using the exact scenario from the changelog, with X's live cyclic SCC plu=
s
> {A, B}: the full walk collects {A, B} and stores unix_graph_cyclic_sccs =
=3D 1
> for X.  Because the purge runs with fpl->dead =3D=3D true, unix_del_edge(=
)
> deliberately skips unix_update_graph(), so B survives as a self-linked
> singleton ring back on unix_unvisited_vertices and the state stays
> UNIX_GRAPH_CYCLIC.
>
> The next GC then takes the fast walk, finds B's singleton ring dead and d=
oes
> cyclic_sccs-- on a group that was never counted, taking the counter 1 -> =
0.
>
> Can that flip unix_graph_state to UNIX_GRAPH_NOT_CYCLIC while X's cyclic =
SCC
> is still present?  After that, both entry points bail out:
>
> net/unix/garbage.c:unix_gc() {
>         if (unix_graph_state =3D=3D UNIX_GRAPH_NOT_CYCLIC) {
>                 spin_unlock(&unix_gc_lock);
>                 goto skip_gc;
>         }
> }
>
> net/unix/garbage.c:unix_schedule_gc() {
>         if (READ_ONCE(unix_graph_state) =3D=3D UNIX_GRAPH_NOT_CYCLIC)
>                 return;
> }
>
> Closing X's fd does not release the socket while it is inflight, so nothi=
ng
> calls unix_del_edges()/unix_update_graph() to re-arm the state.  Does tha=
t
> leak X's struct sock, its skb and the pinned struct file until some
> unrelated sender happens to pass an AF_UNIX fd to an inflight receiver?
>
> And if two such remnant rings are found in one fast walk while the counte=
r
> is 1, does the second cyclic_sccs-- wrap the unsigned long to ULONG_MAX?
> The state would then stay UNIX_GRAPH_CYCLIC, so unix_walk_scc() is never
> selected again to recompute the counter, and this makes every fd-passing
> send take the synchronous path:
>
> net/unix/garbage.c:unix_schedule_gc() {
>         if (user && READ_ONCE(unix_graph_cyclic_sccs))
>                 flush_work(&unix_gc_work);
> }
>
> The counter and the unconditional decrement predate this patch (58b47c713=
711
> and e29c7a4cec86), so this is not a regression from the one-line addition=
,
> but should the accounting also be corrected for the remnant case?

Good point, looks like Claude is now better than Gemini :)

I'll change unix_walk_scc_fast() like below.

if (unix_scc_dead(&scc, true)) {
        unix_collect_skb(&scc, hitlist);
        if (list_empty(&scc))
                cyclic_sccs--;
}

Thanks !
