Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155094B203C
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275329; cv=pass; b=W24GtxXROLWrKNQ12FB7zQ7NGERQXblfOe5tjrZKYAUNkrdyRzUNt0a6oJQVhrY2OQEJBdyi8bJuOmrmtjGEk2m6xb8K2M0fOcCKscWQUwp+AmA2T1Na/YcpvZpMTprqP9qsvtomh12q8Amye39/zm+4/3quhBrLut0LVDjuxbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275329; c=relaxed/simple;
	bh=a1+M2nqlK/ZhoVJb/YUYrssmHwXM7ChJkAv3CzqMLRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSKlwwSJLKsPoBulqNEbzq8vrqWqZGcTIf9oiGahgnVIISxiO0zX4XokO61gJht2esuw47KsoYeDDs6zy6T/NnTKkqtgGd4Tj2wLygZQWHXEuD+5mvXi3/ECp3jxluesTjqYJgfrLhu/20ZZi4b9bQQconC22UbLTRU9Emv3CIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5i4BqVE; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5i4BqVE"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8633a38df87so117649b3a.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 11:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790275319; cv=none;
        d=google.com; s=arc-20260327;
        b=O1xfnKtfvmalaPzeZv9/CVqubeoPhVFYZjTR1bZ9Rzno6Z3fzeacEIIkEXgYXzIfpM
         jk7UWzFpXcNNNixucpjAlW+DyN91lvhhO0lGq1lgP2zJhb4dDiLJkvAL4zNQqX8QprHi
         fXh8WwHaOAOntYdLhParioI/dNMLNFeVqguIxVS62XpeuwlzXIuYdBfdeSfx50j7v36n
         inIRkWh883BZyPHY0uCJ5nDONliz3F2gbZaGIV6dRUDKkocBo+p1oSQhYUK7/aJARNhT
         WcJ3OGkFxk2hUnI/zatvwmomPR0gcCilx84gPKhJBh56Z0BU6UvJQnS/Gg6mEzFeGC8D
         flaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q77KuLpE+oIvbADaLPu5DaDb6SG+K0Y0OUtgLbqd2OA=;
        fh=vwmLnP8yLubjlaF5yNv8u8ALyZ1vHu3vN4C+jCijqS4=;
        b=fZd1Bp7Ok0VgjIlxItRcKLYMdmndigyPPZQjlRBOa+CqXzk1FwleuklVp+/3+F24DA
         duJYKVuKB2PdL9fWLpXCl4FN5D3UbgJtKb7vt4M9XyD4JpmL6q3ko+Qf6a2rbpc6Eak9
         ijWf1y+Ffbt58uUydortd1nxfd/lo7asoOS8vAhHtxw42ATLIQmCNEKUgcpb0aIUV0lG
         6Y2NmfXhH4B7GmZowTCx99zVd4mpByYEN32dDuRzS8F9Z0815sw42peFhRYopR+MsQ8o
         2OPAEkL3rCO/JuHviOD72n60VGsR+lHhmmrmktP8rl561WNcS/IlPKwZY+oiHxa+ipAM
         ZsMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790275319; x=1790880119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q77KuLpE+oIvbADaLPu5DaDb6SG+K0Y0OUtgLbqd2OA=;
        b=Q5i4BqVERy5wqd6rj6aaEB1HiU2xkmdWnvOcA90iV+4qJotGV1Nn1S5zudOoLY+Zpb
         IzAB4bYHFYccjaW6T4y/+Kz5gBOykMpyYpXpR4WpP0Rln5DmCEN5LDWh4CNATKF0oH+C
         CZ5sPtSknuYjYmoSlnlQXo1ZefaFEBXTyoUYkBb6lG1itSkZFMlKixJaHpNm4nzWtBnm
         hp1d9Y0g5prcTUOUg6jJMTyNGoYHNFnLkfdkX285tL+Jmuk/w2nQhu+1WFa4iOszcEpw
         cRCB/A24QArhVJNv5uDYzMjUXon+GogHOxNSm7OYoGPQUydfQm5x1JLYqH7SlPRRpjO9
         uLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790275319; x=1790880119;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q77KuLpE+oIvbADaLPu5DaDb6SG+K0Y0OUtgLbqd2OA=;
        b=CgCsVnp+COEiM0qHrN/Yp0WYtclLX7+IBtJX5o5YU3sMdg5DjTaZ2D3Wtmi4atXgKV
         F17pQXeUSdhRvmtw8mUEhMnoiIejOD3RSoi2+ZFa5N06H8tejDbIWiYcDoPAx0VFfLFi
         1U61SnTbv+0hcRHG13Z86S4sFwc2W+3GUt4k1BANRKPBC7zpQzGq6b8fOE/I+BnppCcV
         AgDx57paeeJkup004jlw2zxB974iNMCV5/YoCBJScou828hA3ni8Y7+HLh0IIq3HKgFW
         ryE6b0aCwxo9pBpUeJ64M0KijEuMHO5tSSbkAZQjnIbr+H3VRp7ZK719/pLjZNg0G+6X
         olqw==
X-Forwarded-Encrypted: i=1; AKwUvBy4Ke8rGvEXXa6qFWoSHEFlv/LvqnbaVcIPJl91fylGA+6R7aDMCsDEl7bFD+IiONBYaih9wUo=@vger.kernel.org
X-Gm-Message-State: AFuF++kViOsUWgCa3+OE8/MKfrhHBl7dNvvw4BmDYhg22S6mddrlbwol
	vTbYke73TrCR9tI6vr4CovQ+V9EQAIdvHQkfPW0uffnmfzyG+pnvAIk3bw5NR1CyNEWXfKjDwyq
	yEMW+z+3917UopFSCavOZ1DkYTddOhg0=
X-Gm-Gg: AYBFou0K9ao6o8YK3OS3LKPq3aQvMXlcJVshLCYBUGXF+dqX3sOKQY8jOHzzZMJ6308
	crlcfzeGeohliu81D422XJ77iWxpfwatLIvo+Cbx/dvdZ2curSMNXpQ/vHKuHFbeqJtEy6HPwmC
	Ln0YMEWw1qXuW0OdInWzdYq7JEQfD4TWSY8rX+Po+okc/cOmc8SvH6HTHOqrcqerdTHkUDMBen+
	OwXCaKSbEyHVHNXSCHwB+EHl0+hTOK2rllRPJR1o8fbkSJraUhb+XIcArNQqroa9KLrF5oMHhc1
	6HXWj2jiuIsfEa2z33dLUjegOqB7A1jU+3JT96dY6MaQmnoqpX3QOp1SISCzqk6wW+KimTCd4ST
	n/SMHlNYTh9OWKoZvRC9LrcKH2veDPbFpdI/xPL4vTqHfGgCWpITLeq7a23F1cgy4+JnJoDvk2I
	XyAEOZ9kvEpO2hDuomxr16LN0=
X-Received: by 2002:a05:6a00:1c8e:b0:871:c970:cf37 with SMTP id
 d2e1a72fcca58-87e9b79bdb6mr2949251b3a.24.1790275318834; Thu, 24 Sep 2026
 11:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921135733.577647-1-wbriggs@cellusys.com> <179021514567.2160803.16218616091479610626@kernel.org>
In-Reply-To: <179021514567.2160803.16218616091479610626@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 24 Sep 2026 14:41:45 -0400
X-Gm-Features: AclHuK8z6qUlFPySpQuVxa2B36vqznwgXhIE0LtaQcRcr51cD7D7-DsVZXtcS1c
Message-ID: <CADvbK_c2P-qxJJ3sCDLJMpCQ4g6PaKVN3kiLTiXYx8UREmCZWw@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: carry peer capabilities across an INIT collision
To: netdev-bot+sashiko@kernel.org
Cc: wbriggs@cellusys.com, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 9:59=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 2 =C2=B7 Medium: 0 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] sctp_assoc_update() (net/sctp/associola.c:1114) now copies
>   new->peer.intl_capable into the surviving association but never re-=E2=
=80=A6
> - [High] sctp_assoc_update() now enables peer.asconf_capable
>   (net/sctp/associola.c:1112) and peer.reconf_capable (associola.c:1113)=
=E2=80=A6
>
> Pre-existing issues:
> - [Medium] The collision merge still does not carry
>   asoc->peer.adaptation_ind.
>
> --
>
> sctp: carry peer capabilities across an INIT collision
>
> sctp_assoc_update() folds a temporary association into an existing one wh=
en
> an INIT collision is resolved, and today it only copies asoc->c, peer.rwn=
d,
> peer.sack_needed, peer.auth_capable and peer.i.  This patch extends the c=
opy
> block with prsctp_capable, ecn_capable, asconf_capable, reconf_capable,
> intl_capable, ipv4_address and ipv6_address so the surviving association
> reflects what the peer advertised in the colliding INIT.
>
> A few questions about the state that is derived from those bits but is no=
t
> refreshed by the merge.
>
> > diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> > index 4521be3bd85aa..0bd0a662b5463 100644
> > --- a/net/sctp/associola.c
> > +++ b/net/sctp/associola.c
> > @@ -1107,6 +1107,13 @@ int sctp_assoc_update(struct sctp_association *a=
soc,
> >       asoc->peer.rwnd =3D new->peer.rwnd;
> >       asoc->peer.sack_needed =3D new->peer.sack_needed;
> >       asoc->peer.auth_capable =3D new->peer.auth_capable;
> > +     asoc->peer.prsctp_capable =3D new->peer.prsctp_capable;
> > +     asoc->peer.ecn_capable =3D new->peer.ecn_capable;
> > +     asoc->peer.asconf_capable =3D new->peer.asconf_capable;
> > +     asoc->peer.reconf_capable =3D new->peer.reconf_capable;
>
> [Severity: High]
>
> Turning these two bits on lets the surviving association accept inbound
> ASCONF and RE-CONFIG, but the receive-side sequence counters those featur=
es
> compare against are still the survivor's own.
>
> Both are derived from the peer's Initial TSN in sctp_process_init(), whic=
h in
> a collision runs on the temporary association only:
>
> net/sctp/sm_make_chunk.c:sctp_process_init() {
>         ...
>         asoc->strreset_inseq =3D asoc->peer.i.initial_tsn;
>         ...
>         asoc->peer.addip_serial =3D asoc->peer.i.initial_tsn - 1;
> }
>
> sctp_assoc_update() copies asoc->peer.i but leaves peer.addip_serial and
> strreset_inseq untouched, so a COOKIE_WAIT survivor keeps zero for both.
>
> Can the peer's ASCONF then never be processed?  sctp_sf_do_asconf() now
> clears the capability gate and reaches:
>
> net/sctp/sm_statefuns.c:sctp_sf_do_asconf() {
>         ...
>         if (serial =3D=3D asoc->peer.addip_serial + 1) {
>         ...
>         } else if (serial < asoc->peer.addip_serial + 1) {
>         ...
>         } else {
>                 /* discarded */
>         }
> }
>
> With the peer's serial equal to its Initial TSN and peer.addip_serial at =
0,
> neither arm matches and the chunk lands in the final else, so no ASCONF-A=
CK
> is sent.  Does the peer then retransmit until its T4 limit and give up on
> ASCONF entirely?
>
> The RE-CONFIG side has the same shape.  sctp_process_strreset_outreq(), a=
nd
> equally the inreq/tsnreq/addstrm_out/addstrm_in handlers, validate agains=
t
> the stale strreset_inseq:
>
> net/sctp/stream.c:sctp_process_strreset_outreq() {
>         ...
>         if (TSN_lt(asoc->strreset_inseq, request_seq) ||
>             TSN_lt(request_seq, asoc->strreset_inseq - 2)) {
>                 result =3D SCTP_STRRESET_ERR_BAD_SEQNO;
>                 goto err;
>         }
> }
>
> The testing notes describe ASCONF and RE-CONFIG appearing on the wire, wh=
ich
> exercises the outbound counters (addip_serial and strreset_outseq, both s=
et
> locally from asoc->c.initial_tsn).  Was the inbound direction tested too?
>
> Should the merge also carry strreset_inseq and peer.addip_serial, or
> re-derive them from new->peer.i.initial_tsn the way sctp_process_init() d=
oes?

Makes sense, please follow the suggestion, and add something like:

+       /* Re-derive sequence counters from the peer's Initial TSN */
+       asoc->peer.addip_serial =3D asoc->peer.i.initial_tsn - 1;
+       asoc->strreset_inseq =3D asoc->peer.i.initial_tsn;


>
> > +     asoc->peer.intl_capable =3D new->peer.intl_capable;
>
> [Severity: High]
>
> This bit selects the chunk operation set, and the merge copies the bit
> without re-selecting it.  The only place asoc->stream.si is derived from =
it
> is sctp_stream_interleave_init(), reached from sctp_stream_init():
>
> net/sctp/stream_interleave.c:sctp_stream_interleave_init() {
>         ...
>         stream->si =3D asoc->peer.intl_capable ? &sctp_stream_interleave_=
1
>                                              : &sctp_stream_interleave_0;
> }
>
> In a collision that ran on the temporary association.  Neither branch of
> sctp_assoc_update() refreshes it on the survivor: sctp_stream_update() co=
pies
> out/in/outcnt/incnt and leaves stream->si alone, sctp_stream_clear() only
> zeroes mid/mid_uo, and the COOKIE_ECHOED case calls neither.  asoc->frag_=
point
> is not recomputed either, although normal negotiation pairs the two:
>
> net/sctp/sm_make_chunk.c:sctp_process_init() {
>         ...
>         if (sctp_stream_init(&asoc->stream, ...))
>                 goto clean_up;
>
>         /* Update frag_point when stream_interleave may get changed. */
>         sctp_assoc_update_frag_point(asoc);
> }
>
> So after the merge peer.intl_capable is 1 while stream.si is still
> &sctp_stream_interleave_0.  The INIT-ACK extension list is built from
> peer.intl_capable, so the peer is told I-DATA is in use.  What happens wh=
en
> it sends one?
>
> net/sctp/sm_statefuns.c:sctp_eat_data() {
>         ...
>         if (!asoc->stream.si->validate_data(chunk))
>                 return SCTP_IERROR_PROTO_VIOLATION;
> }
>
> sctp_validate_data() returns false for anything that is not SCTP_CID_DATA=
,
> and the callers turn SCTP_IERROR_PROTO_VIOLATION into
> sctp_sf_abort_violation().  Can a peer that legitimately follows the
> negotiated extension abort the association this way?
>
> There is a second effect in the send path, which branches directly on the
> bit rather than on stream.si:
>
> net/sctp/stream_sched.c:sctp_sched_dequeue_done() {
>         ...
>         if (!list_is_last(&ch->frag_list, &ch->msg->chunks) &&
>             !q->asoc->peer.intl_capable) {
>                 /* pin stream.out_curr */
>         }
> }
>
> With the bit set but plain DATA chunks being dequeued, stream.out_curr is=
 no
> longer pinned mid-message.  Can the PRIO/RR schedulers then interleave
> fragments of different streams on the wire?  Before this patch the surviv=
or
> kept intl_capable at 0 and the pin was taken.
>
> The reverse case looks reachable too: a restart where the new INIT no lon=
ger
> advertises I-DATA now clears the bit while stream.si stays
> &sctp_stream_interleave_1, leaving I-DATA and I-FORWARD-TSN installed for=
 a
> peer that did not negotiate them.
>
> Would calling sctp_stream_interleave_init() and sctp_assoc_update_frag_po=
int()
> on the surviving association after the copy address both directions?

Outqueue may already have data at the time, we can't just call
sctp_stream_interleave_init(). Let's drop the intl_capable update from
this patch and address it separately in another patch.

You may add a note for this in the commit message, so that the AI review
won't report intl_capable update missing.

>
> > +     asoc->peer.ipv4_address =3D new->peer.ipv4_address;
> > +     asoc->peer.ipv6_address =3D new->peer.ipv6_address;
> >       asoc->peer.i =3D new->peer.i;
>
> [Severity: Medium]
>
> This is a pre-existing issue and not introduced by this patch, but since =
the
> copy block is being extended: peer.adaptation_ind is still not carried.
>
> sctp_process_param() records the peer's Adaptation Layer Indication on th=
e
> association it is processing, which in a collision is the temporary one:
>
> net/sctp/sm_make_chunk.c:sctp_process_param() {
>         ...
>         case SCTP_PARAM_ADAPTATION_LAYER_IND:
>                 asoc->peer.adaptation_ind =3D ntohl(param.aind->adaptatio=
n_ind);
> }
>
> and the completion path reads the survivor's copy right after the merge:
>
> net/sctp/sm_statefuns.c:sctp_sf_do_dupcook_b() {
>         ...
>         if (asoc->peer.adaptation_ind)
>                 sctp_add_cmd_sf(commands, SCTP_CMD_ADAPTATION_IND, SCTP_N=
ULL());
> }
>
> For a COOKIE_WAIT survivor the field is still 0, so is the
> SCTP_ADAPTATION_INDICATION notification dropped even though the peer aske=
d
> for it, and on a restart is an older non-zero value reported instead of t=
he
> new one?  asoc->c =3D new->c does update c.adaptation_ind, but nothing co=
pies
> that into peer.adaptation_ind after the merge.
>
> Note this field is a separate __u32 rather than part of the bitfield bloc=
k
> the changelog calls "the rest of the block", so it is outside what the pa=
tch
> sets out to fix.
>

Please address this one as well by adding:

+       asoc->peer.adaptation_ind =3D new->peer.adaptation_ind;

either in this patch or a separate one.

Thanks.
