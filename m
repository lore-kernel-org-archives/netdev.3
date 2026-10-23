Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792787515;
	b=kzEopkiXkTTn/91xu8XIHizoxr56YEOMI7FPrzQlnV6A6fzcdrWo/MMoT9IF0Y8QSP4z
	 4tuvVTjGbNueILY+gZqMi5B8TScezWbagB6i8qdtpnCkeG1dzA8a6X9WeG5NIw4VzF/hq
	 JEGaSpV8DtU1Z5m7ETXO1kwt+NihLSllT8gRqrxfUTB+eZoyN74xQ98gdNZ4yj65dcS2l
	 C6AnfaHZ4mX7He17UCoPMAJhuEbFjV7lhgXd1phPlM0LZ/E4t+j3jabo4EugjPk4GDkS6
	 Rkr1LkdrP55FxIAsiWqqYAnfNJxYGSzY63yuWZbjxO8lRyQJtT2uwJqJKbOzzc+1D7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792787515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=QTgB4kfQHMo1JtqTVcHUgwBg9vx0424sVbKNR4g7dac=;
	b=fVoFow51yNzhwwG/6zeH9mA/wFa7dssHO4JwF8pp9N5eurIcXOouH6qLlqUIOBUby9cO
	 GI7SYcZghgrCE0vIvXhagO7kzTWIYqag5XFL9bQTRhlErFApKhz9c1m13fctJfYCrKgkg
	 SI6Lohbr3VAKfG0gO+6fckaKILF9b/HXDC/fUMHUVVP4XoLXthIUhrti7JeLGvD2sCknI
	 jwdJ+xPKTsr4mtLJ3fCW05rNCAQ2rYZXLkFBti7Sgyse9DBzpANczW1pjiLhT09DCNzR9
	 6t2GrMP7f6WO/v+RaSJ6e9cmPQ6z9KLmScQ34COn2x36PKOWkxp1nlVuUwJUq4XDD7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Gn6ph6TE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBC6606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BBC6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Gn6ph6TE
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-533202fe429so70761cf.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792787514; cv=none;
        d=google.com; s=arc-20260327;
        b=OxQxRKRZP9l2wxy8E8UiTZRKjpa4aZY6xg91zUMauR5SCmTZycifDGKiRZTDzZWlys
         ulkRcDk6BtllW9uwrvtOmNeOlbo82wKG+CJBX7/5Fk9eWjbvx9DMiTJsa9KZ5O36HU5+
         gBgpF7cZvupZAnTKXi2pMvq6ogwXzfK0qF5TGKk+Fpvo1UZsZ03C+eaX4XuSsJ9QWOPy
         G8kKhQthEonEhwwKEDijqNAghOHZT9YO9ecVlUhmICXYMVAcFXeSYz2Xpu4QydxrF0VY
         jNem61GF8Qg/FZj98E5+kK3FH3d3pMsWNFmeq+lgEm4878Qv+ft9syAw64fagTeuEUdZ
         /jHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QTgB4kfQHMo1JtqTVcHUgwBg9vx0424sVbKNR4g7dac=;
        fh=4G/yCsxwqXWw7rbKU+Zfb6PdANYEWbUe24Grt5nGCe8=;
        b=XF2/m7RpCdNtt++aPxlUUhSGqNQBG7f2J7sRnB4zQP2Gxs1+89N7Mk8xKghIfV2caG
         l+DJRZMDLHOJ4NUZd4mFWZYLYF36rxutvyEbtoN4qyVxo9oXmm54hik/3ATH7QjDee0Q
         75/FYlIBD6011uSomiATFJ3nNjuRi05PtFL7b5Yp7D6v5oXLxdfxP6KujFMvixYj5jms
         yaBsmRMW/ZuxB7bglUmdtvJwWD6xKhGbIgCUPQmBduZ9h1SGskisIPCfNrGx71ZErw3/
         aqAkX76TzFG1tlt+chSr6s2HShyY318njE9UHU5MIcUBcO3TvSiBs5wgzg3/UyP13pe1
         APYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792787514; x=1793392314; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QTgB4kfQHMo1JtqTVcHUgwBg9vx0424sVbKNR4g7dac=;
        b=Gn6ph6TEJ+S48dAaQvwye0CboxuQj6aMnYC77u+eG2OnnzuPfQ7DUGLngpWFduYVH/
         QWejVM1ml66bEwG86PGv6iLBZB07bLKxLHtyiLCiIHf25REquD5NoeB8y23He8TfUly9
         QP+LYWjlhha0J78/KKTAQbdwcI/4nlEVUUvsk11RvCgayKkoUCnCfoYnurkUJtJK1UXs
         JlCcMNubEMmvOmIj4bUhz4cBkrve64AC5F9lCVKz3e+IkJdt05KqIV+R3RM5dMXP1HCO
         4sr65LpX2Px6JnWpDFXVlbXJ2CLAP/TGdUni+CIFBsM5hLNracCTs+tWL+n33aKgTotz
         5AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792787514; x=1793392314;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QTgB4kfQHMo1JtqTVcHUgwBg9vx0424sVbKNR4g7dac=;
        b=otdsGLTvgdAcVFdhxv4+ZlfA+zMtVEOqqdqbyYQtTaBcCASybMddi1AC79q2822BjL
         6aPaq8svbYl82eXPLqzPubx2ibgyV0Je0K9PoXYSaUUXHTpHU/7weBEoZ141v1mSX0ms
         V7NoyWHLxf2COfw8t9pC3JpwwyT3KmsxWoqGRYnVb+C8v1MEX3+1IMgd4AG0yFc11K1/
         25UngEYsv63koJgAufjRC7Jg1Fq+uRXk5lN3lJ86CWMKwi0ON50pw9460TNOxs97Kucb
         K/0A62Fs16CYHKoAjc4Ob4kjUVxt4B3kqSkwvJZvT78j6OuGTyPrsMy5bMTm1DotqDab
         dqeA==
X-Forwarded-Encrypted: i=1; AKwUvBxxEJrGemuULSCroa1VRdmv7eXNvOocohv0G7dJ+u7Z/8ioBEH/erNYo80xYZ4vMQ+uzm+MM64=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEK9+z66xLmfyUrPcptMXOj06LeE50UUNmubn+6nMumPGEkX+n
	vHo0TA93jLVY9jAqdE1Uc/j5rwuawq/l500vAkfgLYhwu2z0lpgdeDD9D3n9wYW6rxk1Cxc2UqU
	d7d3kQEF3yoLirsW8m8QKyAiiagaYyPqxnsDcu1BC
X-Gm-Gg: AYBFou0fQKMtoeIOR4jxJA949lfUHM3CKKQOgr1Rzw+Aa29f9xS8Qkc/AdbMI2p0rpG
	KeQ9oIZd80JnF6DZFF5MFlNwCBxgYY9+Ccvu49oLvNmtbUICHp4M1kyOwaeKLDXzcA3hOlWNGIp
	lkV17se+p6l8hh5Dkl1K0N3eQwCK2sFtvMquiqfu9YYstCtgvNEawuYEmBJMRMrjHw2sV+9smyu
	nYjm57xuQ1DYJJyYK3fBNk5QPWMdiJ0eLFQvD1UuRSDhIKzQS9hEjr3pdYVk8xbWpW8m2bwcQEJ
	0Zz0WPmT6Cqx8R54TljNObXGqAWFqCaCkMi3DKoZEsIipAKUkTeq1OwkDKb57JGYbMj4Xcdrrpn
	k6s6iuoxskZ1LZuVLQTSkZGvn7LdbVrNCkqeHNJj2aKaYMOdQF5hB7yBVkpbpkgiJtUum1FXoTr
	MXWSMXPcr3dXY5EOawCQADoA==
X-Received: by 2002:a05:622a:1f12:b0:535:30a:76c7 with SMTP id
 d75a77b69052e-5383b47236amr293821cf.3.1792787513225; Fri, 23 Oct 2026
 13:31:53 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2ab9dc5f5b5e9f50d7a4aa02a6b6759fc86314c7.1792658454.git.gnault@redhat.com>
 <20261023161013.3079347-1-ncardwell.sw@gmail.com> <CADVnQymSV+Z9T_XSELAeoE46CNVAK2XveHb4s6ntLvSn8fw_Pg@mail.gmail.com>
In-Reply-To: <CADVnQymSV+Z9T_XSELAeoE46CNVAK2XveHb4s6ntLvSn8fw_Pg@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 23 Oct 2026 16:31:34 -0400
X-Gm-Features: AclHuK_-H5pWZ4MKSXzjwh6KEienLEACd6fhCFV61seGpNOGIqVQFGkL6HmgYmI
Message-ID: <CADVnQymwmheLwtwieRptBJxMQhPJnnUt7-bAe48UcmXV2vv1Cw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix dup-ack detection on non-SACK bidirectional
 data transfer.
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: gnault@redhat.com, Tom.D.Williams@morganstanley.com, davem@davemloft.net, 
	edumazet@kernel.org, horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, ycheng@google.com
Content-Type: multipart/mixed; boundary="000000000000e3f71f065e87de85"

--000000000000e3f71f065e87de85
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 1:04=E2=80=AFPM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Fri, Oct 23, 2026 at 12:10=E2=80=AFPM Neal Cardwell <ncardwell.sw@gmai=
l.com> wrote:
> ...
> > Below is a proposed patch, cooked by a frontier LLM and lightly edited =
by me,
> > that should factor in all these considerations. This is compiled but no=
t yet
> > tested. I will kick off some tests for it.
> >
> > ~~~~ possible patch:
> >
> > Currently, FLAG_WIN_UPDATE (/* Incoming ACK was a window update. */) is=
 set
> > in two places even when tp->snd_wnd does not change:
> >
> > 1. In tcp_ack_update_window(), flag |=3D FLAG_WIN_UPDATE is set wheneve=
r
> >    tcp_may_update_window() returns true, outside the if (tp->snd_wnd !=
=3D nwin)
> >    check.
> > 2. In the tcp_ack() header-prediction fast path, where tp->pred_flags h=
as
> >    already verified that the advertised window is unchanged
> >    (ntohs(th->window) =3D=3D (tp->snd_wnd >> tp->rx_opt.snd_wscale)), l=
ine 4357
> >    unconditionally sets flag |=3D FLAG_WIN_UPDATE.
> >
> > This causes two issues:
> >
> > First, on the slow path in tcp_ack_update_window(), a pure duplicate AC=
K
> > (ack =3D=3D tp->snd_una) with an unchanged window (nwin =3D=3D tp->snd_=
wnd) still
> > satisfies tcp_may_update_window() whenever after(ack_seq, tp->snd_wl1) =
is true
> > (or when ack_seq =3D=3D tp->snd_wl1 && !nwin). In particular, when the =
peer sends
> > an in-order data segment of length L > 0 with sequence number S, tcp_up=
date_wl()
> > sets tp->snd_wl1 =3D S while tp->rcv_nxt advances to S + L. If the peer=
's next
> > packet is a pure duplicate ACK with unchanged window, its ack_seq is S =
+ L >
> > tp->snd_wl1. tcp_ack_update_window() therefore sets FLAG_WIN_UPDATE (wh=
ich is
> > part of FLAG_NOT_DUP), preventing the ACK from being counted as a dupli=
cate ACK
> > (RFC 5681, Section 2, condition (e)) and inhibiting Fast Retransmit on =
non-SACK
> > connections.
> >
> > Second, tcp_in_ack_event() maps FLAG_WIN_UPDATE to CA_ACK_WIN_UPDATE an=
d passes
> > it to icsk_ca_ops->in_ack_event(). Because both the fast path and slow =
path set
> > FLAG_WIN_UPDATE whenever snd_una or snd_wl1 advances, CA_ACK_WIN_UPDATE=
 is
> > falsely reported on every cumulative ACK even when the peer's advertise=
d receive
> > window is unchanged.
> >
> > Note that when an ACK advances tp->snd_una by less than 1 whole segment=
 of the
> > head skb in the retransmit queue, tcp_clean_rtx_queue() breaks out earl=
y without
> > setting FLAG_ACKED. Previously, such a pure ACK relied on FLAG_WIN_UPDA=
TE being
> > set in order to have FLAG_NOT_DUP set and avoid being treated as dubiou=
s by
> > tcp_ack_is_dubious() in TCP_CA_Open, and thus avoid calling
> > tcp_fastretrans_alert().
> >
> > Fix this by:
> > 1. Including FLAG_SND_UNA_ADVANCED in FLAG_NOT_DUP, since an ACK that a=
dvances
> >    SND.UNA is by definition not a duplicate ACK.
> > 2. Moving flag |=3D FLAG_WIN_UPDATE inside if (tp->snd_wnd !=3D nwin) i=
n
> >    tcp_ack_update_window(), so FLAG_WIN_UPDATE is only set when tp->snd=
_wnd
> >    actually changes.
> > 3. Removing flag |=3D FLAG_WIN_UPDATE from the constant-window header-p=
rediction
> >    fast path in tcp_ack().
> >
> > This updates FLAG_WIN_UPDATE to match part (e) of the RFC 5681 dupack
> > definition: "the advertised window in the incoming acknowledgment equal=
s the
> > advertised window in the last incoming acknowledgment".
> >
> > This updates FLAG_NOT_DUP to include part (d) of the RFC 5681 dupack
> > definition: "the acknowledgment number is equal to the greatest acknowl=
edgment
> > received on the given connection (TCP.UNA from [RFC793])"
> >
> > ---
> >  net/ipv4/tcp_input.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 99baf14afdfd..1feb370804b1 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -107,7 +107,8 @@ int sysctl_tcp_max_orphans __read_mostly =3D NR_FIL=
E;
> >  #define FLAG_TS_PROGRESS       0x40000 /* Positive timestamp delta */
> >
> >  #define FLAG_ACKED             (FLAG_DATA_ACKED|FLAG_SYN_ACKED)
> > -#define FLAG_NOT_DUP           (FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED)
> > +#define FLAG_NOT_DUP           (FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED|\
> > +                                FLAG_SND_UNA_ADVANCED)
> >  #define FLAG_CA_ALERT          (FLAG_DATA_SACKED|FLAG_ECE|FLAG_DSACKIN=
G_ACK)
> >  #define FLAG_FORWARD_PROGRESS  (FLAG_ACKED|FLAG_DATA_SACKED)
> >
> > @@ -3959,10 +3960,10 @@ static int tcp_ack_update_window(struct sock *s=
k, const struct sk_buff *skb, u32
> >                 nwin <<=3D tp->rx_opt.snd_wscale;
> >
> >         if (tcp_may_update_window(tp, ack, ack_seq, nwin)) {
> > -               flag |=3D FLAG_WIN_UPDATE;
> >                 tcp_update_wl(tp, ack_seq);
> >
> >                 if (tp->snd_wnd !=3D nwin) {
> > +                       flag |=3D FLAG_WIN_UPDATE;
> >                         tp->snd_wnd =3D nwin;
> >
> >                         /* Note, it is the only place, where
> > @@ -4354,7 +4355,6 @@ static int tcp_ack(struct sock *sk, const struct =
sk_buff *skb, int flag)
> >                  */
> >                 tcp_update_wl(tp, ack_seq);
> >                 tcp_snd_una_update(tp, ack);
> > -               flag |=3D FLAG_WIN_UPDATE;
> >
> >                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPACKS);
> >         } else {
> > --
> > 2.47.3
>
> This patch passes all of our internal tests, as well as the new
> tools/testing/selftests/net/packetdrill/tcp_bidir_fast_retransmit_nosack.=
pkt
> test that Guillaume Nault posted in this thread.

I got a second frontier LLM to review this patch, and it assessed the
patch as correct.

During its review it also found a TLP-related packetdrill scenario
that shows buggy kernel TCP behavior with the current upstream
FLAG_WIN_UPDATE logic but is fixed by either this patch, or
Guillaume's original patch in this thread. I have attached the
packetdrill test.


neal

--000000000000e3f71f065e87de85
Content-Type: application/octet-stream; 
	name="tcp_tlp_bidir_dupack_nodsack.pkt"
Content-Disposition: attachment; filename="tcp_tlp_bidir_dupack_nodsack.pkt"
Content-Transfer-Encoding: base64
Content-ID: <f_mvlfc5fk0>
X-Attachment-Id: f_mvlfc5fk0

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKLy8KLy8gVExQIHdpdGggYSBTQUNL
LWNhcGFibGUgcGVlciB0aGF0IGRvZXMgbm90IHNlbmQgRFNBQ0tzIChlLmcuIHNvbWUgbWFjT1MK
Ly8gc3RhY2tzKSwgb24gYSBiaWRpcmVjdGlvbmFsIGNvbm5lY3Rpb24uCi8vCi8vIFRoZSBUTFAg
cmV0cmFuc21pc3Npb24gdHVybnMgb3V0IHRvIGJlIGEgZHVwbGljYXRlLiBUaGUgcGVlciBhbnN3
ZXJzIGl0IHdpdGgKLy8gYSBwdXJlIGR1cGxpY2F0ZSBBQ0sgYXQgdGxwX2hpZ2hfc2VxLCBidXQg
dGhhdCBkdXBhY2sgZm9sbG93cyBhIGRhdGEgc2VnbWVudAovLyBmcm9tIHRoZSBwZWVyLCBzbyBp
dHMgU0VHLlNFUSBpcyBhYm92ZSBTTkQuV0wxLgovLwovLyBCZWZvcmUgInRjcDogRml4IGR1cC1h
Y2sgZGV0ZWN0aW9uIG9uIG5vbi1TQUNLIGJpZGlyZWN0aW9uYWwgZGF0YSB0cmFuc2Zlci4iLAov
LyB0Y3BfYWNrX3VwZGF0ZV93aW5kb3coKSBzZXQgRkxBR19XSU5fVVBEQVRFIG9uIHRoYXQgZHVw
YWNrIChTRUcuU0VRID4KLy8gU05ELldMMSksIHNvIHRjcF9wcm9jZXNzX3RscF9hY2soKSBkaWQg
bm90IHRyZWF0IGl0IGFzIGEgInB1cmUgZHVwYWNrIiBhbmQKLy8gbGVmdCB0aGUgVExQIGVwaXNv
ZGUgb3Blbi4gVGhlIG5leHQgQUNLIGFib3ZlIHRscF9oaWdoX3NlcSB3YXMgdGhlbiB0YWtlbiBh
cwovLyBwcm9vZiBvZiBhIGxvc3MsIGFuZCBjd25kIHdhcyByZWR1Y2VkIChUQ1BMb3NzUHJvYmVS
ZWNvdmVyeSkgYWx0aG91Z2gKLy8gbm90aGluZyB3YXMgbG9zdC4KLy8KLy8gV2l0aCB0aGUgZml4
LCB0aGUgZHVwYWNrIGhhcyBubyBGTEFHX1dJTl9VUERBVEUgKHRoZSB3aW5kb3cgaXMgdW5jaGFu
Z2VkKSwKLy8gc28gaXQgY2xvc2VzIHRoZSBUTFAgZXBpc29kZSBhcyAib3JpZ2luYWwgYW5kIFRM
UCBwcm9iZSBhcnJpdmVkOyBubyBsb3NzIiwKLy8gYW5kIGN3bmQgaXMgbm90IHJlZHVjZWQuCgpg
Li9kZWZhdWx0cy5zaGAKCiAgICAwIHNvY2tldCguLi4sIFNPQ0tfU1RSRUFNLCBJUFBST1RPX1RD
UCkgPSAzCiAgICswIHNldHNvY2tvcHQoMywgU09MX1NPQ0tFVCwgU09fUkVVU0VBRERSLCBbMV0s
IDQpID0gMAogICArMCBiaW5kKDMsIC4uLiwgLi4uKSA9IDAKICAgKzAgbGlzdGVuKDMsIDEpID0g
MAoKLy8gU0FDSyBidXQgbm8gdGltZXN0YW1wcy4KICAgKzAgPCBTIDA6MCgwKSB3aW4gMzI3OTIg
PG1zcyAxMDAwLHNhY2tPSyxub3Asbm9wLG5vcCx3c2NhbGUgNz4KICAgKzAgPiBTLiAwOjAoMCkg
YWNrIDEgPG1zcyAxNDYwLG5vcCxub3Asc2Fja09LLG5vcCx3c2NhbGUgOD4KICArLjEgPCAuIDE6
MSgwKSBhY2sgMSB3aW4gMzIwCiAgICswIGFjY2VwdCgzLCAuLi4sIC4uLikgPSA0CgovLyBTZW5k
IDIgTVNTLiBUTFAgcmV0cmFuc21pdHMgdGhlIGxhc3QgTVNTIGFmdGVyIFBUTyA9IDIgKiBzcnR0
ID0gMjAwbXMuCiAgICswIHdyaXRlKDQsIC4uLiwgMjAwMCkgPSAyMDAwCiAgICswID4gUC4gMToy
MDAxKDIwMDApIGFjayAxCiAgKy4yID4gUC4gMTAwMToyMDAxKDEwMDApIGFjayAxCgovLyBUaGUg
b3JpZ2luYWwgZmxpZ2h0IGFycml2ZWQ6IHRoZSBwZWVyIGN1bXVsYXRpdmVseSBBQ0tzIGl0Lgog
ICsuMSA8IC4gMToxKDApIGFjayAyMDAxIHdpbiAzMjAKCi8vIFRoZSBwZWVyIHNlbmRzIGEgcmVx
dWVzdCwgd2hpY2ggd2UgQUNLLgogICArMCA8IFAuIDE6MTAxKDEwMCkgYWNrIDIwMDEgd2luIDMy
MAogICArMH4rLjA1ID4gLiAyMDAxOjIwMDEoMCkgYWNrIDEwMQoKLy8gVGhlIGR1cGxpY2F0ZSBU
TFAgcmV0cmFuc21pc3Npb24gcmVhY2hlcyB0aGUgcGVlciwgd2hpY2ggc2VuZHMgYSBwdXJlIGR1
cGFjawovLyAobm8gRFNBQ0spLiBJdHMgU0VHLlNFUSAoMTAxKSBpcyBhYm92ZSBTTkQuV0wxICgx
KTsgdGhlIHdpbmRvdyBpcyB1bmNoYW5nZWQuCiAgICswIDwgLiAxMDE6MTAxKDApIGFjayAyMDAx
IHdpbiAzMjAKCi8vIFNlbmQgYW5kIGdldCBBQ0tlZCBvbmUgbW9yZSBNU1MsIGFib3ZlIHRscF9o
aWdoX3NlcS4KICAgKzAgd3JpdGUoNCwgLi4uLCAxMDAwKSA9IDEwMDAKICAgKzAgPiBQLiAyMDAx
OjMwMDEoMTAwMCkgYWNrIDEwMQogICsuMSA8IC4gMTAxOjEwMSgwKSBhY2sgMzAwMSB3aW4gMzIw
CgovLyBObyBsb3NzIGhhcHBlbmVkLCBzbyB0aGVyZSBtdXN0IGJlIG5vIFRMUC1iYXNlZCBjd25k
IHJlZHVjdGlvbjogdGhlIGZsb3cgaXMKLy8gYXBwbGljYXRpb24tbGltaXRlZCwgc28gY3duZCBz
dGF5cyBhdCB0aGUgaW5pdGlhbCAxMCBhbmQgc3N0aHJlc2ggaXMgbmV2ZXIKLy8gc2V0IChhIHJl
ZHVjdGlvbiB3b3VsZCBzZXQgc3N0aHJlc2ggdG8gNyBhbmQgY3duZCB0byA3KS4KICAgKzAgJXsK
YXNzZXJ0IHRjcGlfY2Ffc3RhdGUgPT0gVENQX0NBX09wZW4sIHRjcGlfY2Ffc3RhdGUKYXNzZXJ0
IHRjcGlfc25kX2N3bmQgPT0gMTAsIHRjcGlfc25kX2N3bmQKYXNzZXJ0IHRjcGlfc25kX3NzdGhy
ZXNoID4gMTAwMDAwMCwgdGNwaV9zbmRfc3N0aHJlc2gKfSUKICAgKzAgYG5zdGF0IC1heiBUY3BF
eHRUQ1BMb3NzUHJvYmVzIFRjcEV4dFRDUExvc3NQcm9iZVJlY292ZXJ5IHwgdGFpbCAtbiArMiA+
JjI7CiAgICAgICBbICIkKG5zdGF0IC1heiBUY3BFeHRUQ1BMb3NzUHJvYmVSZWNvdmVyeSB8IGF3
ayAnL1RjcEV4dFRDUExvc3NQcm9iZVJlY292ZXJ5LyB7cHJpbnQgJDJ9JykiID0gMCBdYAo=
--000000000000e3f71f065e87de85--
