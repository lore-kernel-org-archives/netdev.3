Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793718093;
	b=FXOAWsn2Z3G3s0r4sNlE/LAjLk/EkXJHwmp2iFPEsx+kZh99Tlo1QSO7iadqsUnS9Wml
	 gM06Wor9WSy2Hgw3w5QqLgFlVju6tD3OrPOc8rF3j6cR2i2JFOegRzaDbTxHE3j4/tB1Y
	 GRYNiUYgWEv+EhLtDafhsvtRKb/61/BcS6dfdGsm6c5Tn62SwNm0HS89G+GvgZBMxy1np
	 ORKyWHlEovDzSjtLalFYUO/l0+LqZb9uYHzz0x+Qh2dRko4yvUXaC+yLQbSacltOAkP/m
	 0dm2BMx1gMGm159JygAKiwRGabMtH05eWarvJUk3enzxYyXJZuU/n8QwdEqUG5tLRFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=C5z4M29UxeONpK8o8OLGczvOOTRjyuOm2u6SOdS+0pI=;
	b=P74UJ/6gylmmNs3oyJgmi6L3Rh/Gx4ZPLDVwdFUMgvtYAmksRCrROeumEIpV6RkGLTeY
	 NDpF0QNwTC9joT/WQRN0l54l6rJGpuBfPe3kmzmPLDngfqAOsjblWJoduNku/rbG00Vv/
	 D1X7eJb8GAq8FAjI/0hMod7G4lZEb+glfwbT6S97/SZxLz3WFgOXCkGbB8gIUaZwqAOyU
	 1dPDZ35IqkO0MsYOrKTGyz4eYsJubM0JQWsYoqE3PH5pAOwfLlPDLbGSqxTMo6a76FJdi
	 x+5mWWGhvkJm1cOe48SfF+vZh1zBlnyKHZxthXkiitpAzdpEi5YScJ97okIVNVMp/nQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zeu/ko8D";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6746071C09
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 15:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD6746071C09
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zeu/ko8D
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so2533766241.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 07:01:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793718091; cv=none;
        d=google.com; s=arc-20260327;
        b=PWNvnjmSE5yf8GJYyWxhJrlmy2hydyr9jfeQipprtEHDtF38uqTpwcwAJsmAyZFZW1
         Szc5tHuAUGwQsa/MOOgK0sk9QJUPRX550MbA4hWCOWjFEhcVLiySAp7bvryEgBJu6pHm
         9+T/Qhh/AAQNj1hUbqoSAn7g7TYh7HwjYDQzzQXRd7zmwRwZqhIKuw++hN5eVDXs5UtN
         589qQmea3Ei7vVFFTQlUkZWBjKVVIy380TtvdlrbCHqJRrBpjrn1RJN77hoxBPOv3AjV
         FQPOTSkxeGSgoNdN6kcmhePuIzIu47I/2Z1ugO9agmL5DAljryEFZjNs/7IPAPrJQ1HM
         Sxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C5z4M29UxeONpK8o8OLGczvOOTRjyuOm2u6SOdS+0pI=;
        fh=JQVqM4Df+jeKAS8eSuQEDfiVK4dqByIOn4Tp9BToGxY=;
        b=LSHgYU/tQUXxSVYPSZ7HX9SNKXYObpWmFDk3DuNCj2JLT//dFD2wFoQZa6tFwa/ubH
         ULNJig/cZz7d+POPfxmYLDt5kioPnXCtPZqD7yQUdz+Ze8mFPxjRYKuWwg+aOwEzHyHf
         RaqlmIgkMFwzVU19haspVvwN+GKEkhs8Rb2yyJucOx42lQIX8dxgjwv/LC4XbReQurGD
         qG5Yy/rWnFk7BuFYzSS1dAdqI4dnEUyzBdKVibWUxchpPTe/iOFm+VGcx2F6jlZ/BRN7
         Zu7o1ECMw4pMoP8oVyXot8fWUMf3IVi4a1ARCvjqruFAelMx6wOkYNg0N5oVA2Ph9IDw
         ESGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793718091; x=1794322891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C5z4M29UxeONpK8o8OLGczvOOTRjyuOm2u6SOdS+0pI=;
        b=zeu/ko8DkS5rKNStf2MC93UcGfZbVP4uaoIt/BxP4yh5fKcoofKYazpLw1iRdh4Hc6
         lBQQOPUz8KJK7M/V6FBAp3wNnNA3NWoOh++0wBPgNw8VluaRTz4fZJnr2P3NRNOWGCwX
         3a5yjceA8ZM5Nxo6MHbYAetTo8JAgOoMwe3qhLwzrdqn8AGmIW/tm7mGrIcS9pl+52d1
         /zdUtCr0WDE6fcdEObwzSH+S3sri0cMB4LWHUZgnsK6c6eoDhiILmJpxyatrvdc61xZY
         oIPtrdD5JEpYDL3zhUGlUHnJ1Yf6THnbIcE96nUDMnVY3kb1wGlFuWpqqNgjfsnntGNq
         +yOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793718091; x=1794322891;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5z4M29UxeONpK8o8OLGczvOOTRjyuOm2u6SOdS+0pI=;
        b=n1+b+ZnemavoTh43swNW8mjWV7s27cGpB6S/AOqUOaYbRJZPrcIF4Qx+JBR7D0XY+8
         9Dnfd/k85/wsbzqncPs5eQLGKB8MCfF+W4qjmVFtWM7b/mez+AEkIr72cYvvOL2Ro13u
         5uSNXdg3b7MqSd+Pz0/igc/YNoeG7d5mYhR6oVcmVywjsCWY09ogKdCuTApOxNv+5yMK
         /PoIIMYq421E0hx7CpzccVHykvY0vNhnnfkjyqJR6ts9kDigm2D6n5hgudQ2Yp7XgOq8
         dwYJCeK/OSD4G8hVFqI9i51ZY/vAzgPRYN6NFFfLAwnOV4jGeBpHedcUJ/9GhVaSQDWM
         Zw1w==
X-Forwarded-Encrypted: i=1; AKwUvBzwbQdjzb7ITA6039kWSIIvr15cdkEqib5CVu/caZhZS91GvZK411Snm3k6jq8LhWQjMtwoaNk=@vger.kernel.org
X-Gm-Message-State: APuU4Z93RFMjOyafarZHuCU9ftWHL7NywlMT9r4q92AtsDao9GH00+T9
	KprtECtV0o8KDgXKLE7tdhqMLqrAMHcq4581FkFDMX/2eQgyJY4O/6B+DOEBNJX1ar8atEtPZVZ
	/QpXOjHgo36jKY+tojCoojjiGpVWyV2A=
X-Gm-Gg: AYBFou0XCp/tEwM1CQsRKM3IcPHR369GNXxa9wdU+sluB8mEXnLDCLYD7OdTDVb6wlp
	kEhNAk4FeObeD08lO1R7kPZ4CuQ7aOYvR9Id2mD5IBjFYrcyhoMtFyqK5iEJtTjW/hNRyDJ8rPW
	qoMYmeuGQyww4ehIn6PBb0MYFqYwfAFYP8QEBGl0zYYFL6CBy9mXIo+cON6bBmOEoDwMM5/kb7y
	oiyKQD+ykp1CU90d5fViSJinyuoYDsAukxNYV+ny4ErvhWHQLCrae21hJgJSj4QrfbrD4Jfb0Fo
	4SwZ3ERJvzM1p1zd+F3ZSZP7JEJ4rXg6P388B3CGO1CPX9K9dWK3yrtlIZD2bwci76c9FwpS4Ah
	27xIpUhsKvYdxvW61NWgrijPKlBV+zNMx0i4uo9Sm4dtLaWbYhvq1fuXxre+DhbVBYkd5l3c9p2
	FtLVIc0U23W3WrmMRY20U8FZ6aB6zCrCWuVKtxBQ==
X-Received: by 2002:a05:6102:c13:b0:7be:25d4:7ff0 with SMTP id
 ada2fe7eead31-7d072247a9cmr4891903137.4.1793718089861; Tue, 03 Nov 2026
 07:01:29 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029193454.1028626-1-andrey.misyrov@gmail.com> <179365071111.3131.11060798860349203804@kernel.org>
In-Reply-To: <179365071111.3131.11060798860349203804@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 3 Nov 2026 10:01:17 -0500
X-Gm-Features: AclHuK9nfSNUyCyqoDyvo9sP8tF53Z1JcsckJk3ZwF841Id_BliZCishdgjDQdY
Message-ID: <CADvbK_ctB+uPFZzpNF7dszEqyEQAK+GZJGtMo-tehoWUDQyeXg@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: fix ASCONF address change on single-homed hosts
To: netdev-bot+sashiko@kernel.org
Cc: andrey.misyrov@gmail.com, marcelo.leitner@gmail.com, junvyyang@tencent.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:18=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 1 =C2=B7 High: 0 =C2=B7 Medium: 0 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Critical] sctp: NULL pointer dereference in sctp_vtag_verify() after
>   plain DEL-IP
>
> Pre-existing issues:
> - [Medium] This problem was not introduced by this patch, but the
>   wildcard SET_PRIMARY branch of sctp_process_asconf_param() does not=E2=
=80=A6
>
> --
>
> sctp: fix ASCONF address change on single-homed hosts
>
> This patch changes DEL-IP handling in sctp_process_asconf_param(). A plai=
n
> DEL-IP of the transport that located the ASCONF is no longer refused, so
> the single-homed renumber case from RFC 5061 5.3.2 works again. The
> wildcard DEL-IP now looks up the peer by the packet source, and
> asconf->transport is either cleared or pointed at the surviving peer, so
> no freed transport is left behind.
>
> > diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> > index d64c3ae33298f..0f9538f8040f2 100644
> > --- a/net/sctp/sm_make_chunk.c
> > +++ b/net/sctp/sm_make_chunk.c
> > @@ -3153,9 +3153,12 @@ static __be16 sctp_process_asconf_param(struct s=
ctp_association *asoc,
> >                * packet MUST be deleted.
> >                */
> >               if (af->is_any(&addr)) {
> > -                     sctp_assoc_set_primary(asoc, asconf->transport);
> > -                     sctp_assoc_del_nonprimary_peers(asoc,
> > -                                                     asconf->transport=
);
> > +                     peer =3D sctp_assoc_lookup_paddr(asoc, &asconf->s=
ource);
> > +                     if (!peer)
> > +                             return SCTP_ERROR_REQ_REFUSED;
> > +                     sctp_assoc_set_primary(asoc, peer);
> > +                     sctp_assoc_del_nonprimary_peers(asoc, peer);
> > +                     asconf->transport =3D peer;
> >                       return SCTP_ERROR_NO_ERROR;
> >               }
> >
> > @@ -3168,13 +3171,9 @@ static __be16 sctp_process_asconf_param(struct s=
ctp_association *asoc,
> >               if (!peer)
> >                       return SCTP_ERROR_DNS_FAILED;
> >
> > -             /* Don't free asconf->transport; a later wildcard DEL-IP
> > -              * parameter reuses it.
> > -              */
> > -             if (peer =3D=3D asconf->transport)
> > -                     return SCTP_ERROR_REQ_REFUSED;
> > -
> >               sctp_assoc_rm_peer(asoc, peer);
> > +             if (asconf->transport =3D=3D peer)
> > +                     asconf->transport =3D NULL;
> >               break;
> >       case SCTP_PARAM_SET_PRIMARY:
> >               /* ADDIP Section 4.2.4
>
> [Severity: Critical]
> Clearing asconf->transport here can leave a NULL transport for any
> chunk bundled after the ASCONF in the same packet.
>
> sctp_rcv() allocates one struct sctp_chunk per packet. sctp_inq_pop()
> reuses queue->in_progress for every bundled chunk and does not reset
> chunk->transport. The asconf seen here through sctp_sf_do_asconf()
> and sctp_process_asconf() is therefore the same object that
> sctp_assoc_bh_rcv() passes to sctp_do_sm() for the next chunk.
>
> Once this branch sets asconf->transport to NULL, the next bundled
> chunk reaches a handler that calls sctp_vtag_verify(). That covers
> DATA, SACK, HEARTBEAT, a second ASCONF, or even an unknown chunk.
> sctp_vtag_verify() does this:
>
> include/net/sctp/sm.h:sctp_vtag_verify() {
>         if (ntohl(chunk->sctp_hdr->vtag) !=3D asoc->c.my_vtag)
>                 return 0;
>
>         chunk->transport->encap_port =3D
>                 SCTP_INPUT_CB(chunk->skb)->encap_port;
>         return 1;
> }
>
> The vtag matches for a legitimate peer, so this is a NULL pointer
> dereference in softirq context. For a bundled DATA chunk,
> sctp_assoc_bh_rcv() also stores the NULL into
> asoc->peer.last_data_from just before that.
>
> The trigger is the case this patch is meant to fix. The peer
> renumbers from L to S and sends [Address Parameter L] [ADD-IP S]
> [DEL-IP L] from S. __sctp_rcv_asconf_lookup() locates the association
> by L, so asconf->transport is the transport for L. The ADD-IP raises
> transport_count to 2, so D7 does not refuse the request, and the
> plain DEL-IP now removes L. Any peer of an established association
> can bundle another chunk after that ASCONF, so a remote peer can
> trigger this.
>
> Before 9b2854f86f0b this path left a freed transport in
> asconf->transport. The patch replaces that use-after-free with a
> NULL dereference for the same bundled chunks rather than closing it.
>
> The v2 notes already handle the bundled DATA/SACK concern for the
> wildcard branch by retargeting asconf->transport to the surviving
> peer. Should the plain DEL-IP do the same? One option is the
> transport for asconf->source when it exists, which it will after
> ADD-IP S. Otherwise asoc->peer.primary_path could be used, since
> sctp_assoc_rm_peer() has just updated it. Or do you prefer to make
> the receive-path users of chunk->transport, starting with
> sctp_vtag_verify(), tolerate NULL?

Looks like ->transport can't be NULL at any point. I couldn't find anything
in the RFCs about this, so setting it to asoc->peer.primary_path should be
good enough.

Thanks.

>
> [Severity: Medium]
> This is a pre-existing issue, and this patch did not introduce it. The v2
> notes already put it out of scope. It does interact with the new
> asconf->transport updates above, though.
>
> The wildcard SET_PRIMARY branch just below says it uses the packet source=
:
>
>         case SCTP_PARAM_SET_PRIMARY:
>                 /* ADDIP Section 4.2.4
>                  * If the address 0.0.0.0 or ::0 is provided, the receive=
r
>                  * MAY mark the source address of the packet as its
>                  * primary.
>                  */
>                 if (af->is_any(&addr))
>                         memcpy(&addr, sctp_source(asconf), sizeof(addr));
>
> However, sctp_source() returns the transport address whenever one is set:
>
> net/sctp/sm_make_chunk.c:sctp_source() {
>         if (chunk->transport) {
>                 return &chunk->transport->ipaddr;
>         } else {
>                 /* Otherwise, extract it from the IP header.  */
>                 return &chunk->source;
>         }
> }
>
> If the ASCONF was matched by its Address Parameter in
> __sctp_rcv_asconf_lookup(), asconf->transport is the transport for L, whi=
le
> asconf->source is the real packet source S.
>
> So if [Addr L][ADD-IP S][SET-PRIMARY 0.0.0.0] is sent from S, wouldn't L
> become primary instead of S?
>
> The ADD-IP wildcard branch, the D8 check and the reworked DEL-IP wildcard
> branch all use &asconf->source. That leaves "source" with two meanings
> inside sctp_process_asconf_param().
>
> This patch now rewrites asconf->transport partway through the chunk. As a
> result, the wildcard SET_PRIMARY result depends on parameter order:
>
>   - after a plain DEL-IP of asconf->transport (now NULL), it picks S
>   - after a wildcard DEL-IP (retargeted to the peer for S), it picks S
>   - otherwise it still picks L
>
> None of these orderings uses a freed transport. Where the result changes,
> it moves toward the behaviour the comment describes.
>
> Would it make sense to have the wildcard SET_PRIMARY branch use
> &asconf->source directly, like the other wildcard branches, either here o=
r
> in a follow-up? That would make the result independent of parameter order=
.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261029193454.1028626-1-andrey.misyrov%40gmail.com
