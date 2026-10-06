Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A443914F5
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791319411; cv=pass; b=cVM2idLnA+UzoMuWxCUn+gn+U/lmVPvN1x9UzocjxYUtFizg4gZ7hOdcwKdXCiFnnJnk+5PclVZ1e4GbjDjLYhq7Qrn5saaVdKmDtskq0sQTL1gCCwQOEnnt0k8monHcInXm1fbc7/dDULwxHHaZdxhxNlDhuXHlJLgiSXbHHDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791319411; c=relaxed/simple;
	bh=XfDOqwl6Iw7dv6BhzcIBSwIFStzO1lcl+rnJERqVgQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGTkq5a6ELc/PnCrXt+7Ar5dFtAmDDKKmabEzpQ50ZJF+nn8pHPjWD8J2Tb3SB6IEJmU31qwMoDwmYOIBc8JkFv/LwojcZAn7K6Re05Xg+EyEnAhxkppyxny5SVMNbzKXgBn7w1gQhZ9TLjbsF1Edv6TokqFEO80nIT3RF2KAZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5S5XvZg; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5S5XvZg"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8917c712f32so266632b3a.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 13:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791319409; cv=none;
        d=google.com; s=arc-20260327;
        b=hJx5MAaAWUMRJCQuvyF5ZBScvWDlfkU0NFI0dl2HbmF1TL6k4DKm5L2RPlF/QMt7TS
         QPgtEe+YmbexHCbJPh7R/QxKT4GyI5E0ApBVTULlYT4zy36hKB75xhMNl/9cDThb+3bh
         iTrPo317kvkC5ebVXbP5SxIwnJO9RpbQG2amjM6ZmkqdwIYXAwWIu47g4EuG1HnL3ILd
         QNpeRy0Lv35d2B4emTIFoXnzp2nFUBEHSmlUTRZCL5Vds2+1zmK+Xtl8C9/9fP5VuBVg
         hVFraA1Dp0VaiC0yWiYE/ltbG3sb+l8Vv0U3O9FoDztJdFpcDkOpn8XLlMlhpo2pTY6a
         4+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pYLtJa497tb3khpaP4kumzUEgLsH3DJmAXssXxTU2u0=;
        fh=FVWdGp8AlV7AtrHxsMBuel4h1EPxjEu38n+5KZAspQg=;
        b=sgSk27rtimng6DGkCTQm6vjAOHkhBiV6kPhfgI4J4/VahxjwIOn2uz+EACAMfOzbj2
         2g38YADUEz9iHt/2CyNpzdZb6vV2z/PrKo8lKMvK9sc7gBZIp3jrZ4W16OhEoMQdy5Mh
         S0lCccWSkXWWhDFXp9xBEUDixAtrzGF7nftYQuXq09NLW7g53b//VJNg3QI6B3m8Fm1V
         Z6njKPmDvBXOl/JND5tIHadIhjicmCOQZL5Dgs9CVVOa6qgam7ILg1ahzDXWNfzYYsPu
         WZgYIRlsGMAefiHXPP/TyJ/mMCpSCUxHQTaayU5+iO2zS7LUO+JJXYMTzlCsOFqJ2OtH
         VVuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791319409; x=1791924209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pYLtJa497tb3khpaP4kumzUEgLsH3DJmAXssXxTU2u0=;
        b=V5S5XvZgo8p3OD2UQE5HmB3owC4iF6nZhK0gwdQBeSuUzaHaOAmiPhuLeXa2ZRiqgV
         z57lVVHxrdlCGXD2W9nrUG41BnA7nIwR5YWUv3A6uqcGY+cUNFEBanbaYgdhUfkdZxnz
         YkIFS4WBrMaR3s93a7ST+8kyJjcOZ7TRhTroav9XXp6EKDcZGjHx1oJIXRvTxOu53HMt
         BazxFrkgAWzA4a+lVg8RpbHxDVcupTz5B3FGtgFZTZQZI4Kd2KoMfVpwLyA38bxR6IRB
         9zNWYEfZyMiO7M87dhvBrQOn4umqv7QvW8/7PBULbE0zc7SYfXJJzOKp0ewFcTz3Wffp
         ZRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791319409; x=1791924209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pYLtJa497tb3khpaP4kumzUEgLsH3DJmAXssXxTU2u0=;
        b=kG8vYnOwZfrQVfIdi21W6AV2+vIATTuWkzF13NTIavjqrAcinCNO+PhUf6389O9zL5
         9s/2wyiZ9lLdKGa8ugVVrhs+VrBgD9Z7htYfwU38WW5Vwu10u1t3iicRENQqGDthpWhu
         T6okI3ObscP16F0joHnMH8pyGnFvSNmq89ylDbpkH6wSPJLEjZWO1FTqlBuf8oqNPu27
         JnYiqxbpvhmJ3cXN6DWHi72pKPw/LrVmdf9M9Xp1Za8htRstiHo893OPhcAzxZuegzhP
         tlTBeUSc1fd16I9BwgtXaO38GxPnX9ndZj82UVEY93khDIcsMZiIXl93UFUEPXZoThY0
         DRwA==
X-Forwarded-Encrypted: i=1; AKwUvBzh15rZIHRfVPflvt15JxdXD9bPttAf+4JeTrZUie7eBj32CNSZWbc7dCojI3IQo6Ytzqle+YE=@vger.kernel.org
X-Gm-Message-State: AFuF++nI/B89LXokahfYUKiyFmp/7w2TVFsH5qvklJJjB/F0QoI3q5o2
	ugz5KoLFpTwifmVvtrXzczwPmKYDtzK2FYN2zSqB19D/30XD0g48eTj6nZCP0HZFSsXGF1Bphce
	ONR7VCZmGNgdWKMB8PYpImZ+iMHwQTwI=
X-Gm-Gg: AYBFou0fNiq9iUXIqQWWa6OOknR/QyLJeFMPa5D+IXUSBea8M5iWDGcrWZzbK3WtbtN
	X/tIfvB76ePFfh8flcXwrLYULqUkCKbM88tZoQtDjlfiuIO1+RpTZehYJ9iKr5TLvy+O8X6eKK/
	qUrU2PJUSebkpujZcgIpCKN+O7M0mIemzdPkOI8LtJTagFPbuOVbRUl1AJBdVYrGf5onVysM6NW
	AguQZkG/3PAphyNQEMfpN+jlOODxsWgRhFV7PqSzcelgvbLBPv8VR0Z00rgFJcUslGsjuIOSPze
	4uR+2Fg3RJ0+BtXPrkz4bqTK5t2xbD4gBiMwviJnwzJhkODXXm6cv+3uoOJxkFYSv6EdBejM38t
	QR+vnWfw+4hnxBSi9od2n4Bkjsza2EgzGCiOS+LJzfT1AhU5d6jiRnw==
X-Received: by 2002:a05:6a00:32c4:b0:877:d02a:42f2 with SMTP id
 d2e1a72fcca58-891b1195350mr273315b3a.7.1791319408388; Tue, 06 Oct 2026
 13:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002010449.3689454-1-4ncienth@gmail.com> <179124882160.434549.10169630192303444846@kernel.org>
In-Reply-To: <179124882160.434549.10169630192303444846@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 6 Oct 2026 16:43:16 -0400
X-Gm-Features: AclHuK97XPKuX_Iuayb6nolJMGLhL_ExO0TZyJKCzoxjc8sL4n8F-xIlo7P6KTI
Message-ID: <CADvbK_ed4ruZjf8CV_jGN=JPkJDHwwZ_9vx+q3zdHnFYiW8dLQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: revalidate output stream after association
 connect wait
To: netdev-bot+sashiko@kernel.org
Cc: 4ncienth@gmail.com, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	nhorman@tuxdriver.com, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 9:07=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The patch only partly revalidates state after
>   sctp_wait_for_connect() in sctp_sendmsg_to_asoc()=E2=80=A6
> - [Medium] The new -EINVAL in sctp_sendmsg_to_asoc()
>   (net/sctp/socket.c:1851-1855) is returned only after=E2=80=A6
>
> --
>
> sctp: revalidate output stream after association connect wait
>
> This patch adds a check in sctp_sendmsg_to_asoc() after
> sctp_wait_for_connect() returns, for the message interleaving case. It
> compares sinfo->sinfo_stream against asoc->stream.outcnt again. The
> handshake can shrink outcnt and free the ext of removed streams while the
> socket lock is dropped, and that used to cause a NULL dereference in
> sctp_outq_tail().
>
> > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > index 4652fd90d9a6c..394d31cb698e0 100644
> > --- a/net/sctp/socket.c
> > +++ b/net/sctp/socket.c
> > @@ -1848,6 +1848,11 @@ static int sctp_sendmsg_to_asoc(struct sctp_asso=
ciation *asoc,
> >                               err =3D -ESRCH;
> >                               goto err;
> >                       }
> > +                     if (unlikely(sinfo->sinfo_stream >=3D
> > +                                  asoc->stream.outcnt)) {
> > +                             err =3D -EINVAL;
> > +                             goto err;
> > +                     }
>
> [Severity: High]
> Is the bound check enough on its own here? Could the stream's ext still b=
e
> NULL when this check passes?
>
> The code before the wait checks two things:
>
> net/sctp/socket.c:sctp_sendmsg_to_asoc() {
>     ...
>         if (sinfo->sinfo_stream >=3D asoc->stream.outcnt) {
>                 err =3D -EINVAL;
>                 goto err;
>         }
>
>         if (unlikely(!SCTP_SO(&asoc->stream, sinfo->sinfo_stream)->ext)) =
{
>                 err =3D sctp_stream_init_ext(&asoc->stream, sinfo->sinfo_=
stream);
>     ...
> }
>
> Only the first check is repeated after sctp_wait_for_connect().
>
> While the lock is dropped, INIT-ACK processing can shrink outcnt:
>
> sctp_process_init()
>   sctp_stream_init()
>     sctp_stream_outq_migrate(stream, NULL, outcnt)
>       sctp_stream_free_ext()   /* kfree(ext); ext =3D NULL for sid >=3D o=
utcnt */
>     sctp_stream_alloc_out()    /* only lowers stream->outcnt */
>
> After that, outcnt can be raised again without restoring ext. One way is
> for the peer to send a RECONF ADD_IN_STREAMS request, either bundled afte=
r
> COOKIE-ACK or sent right after it:
>
> sctp_sf_do_reconf()
>   sctp_process_strreset_addstrm_in()
>     sctp_stream_alloc_out(stream, outcnt, GFP_ATOMIC)
>     stream->outcnt =3D outcnt;
>
> The other way is for another local thread to call
> setsockopt(SCTP_ADD_STREAMS) while the lock is released:
>
> sctp_send_add_streams()
>   sctp_stream_alloc_out(stream, outcnt, GFP_KERNEL)
>
> On that path, outcnt is also not rolled back if sctp_send_reconf() fails.
This is a separate issue to check.

>
> sctp_stream_alloc_out() only calls genradix_prealloc(), so the existing
> entry for the earlier sid keeps ext =3D=3D NULL.
>
> When the sender resumes, the new check passes because outcnt has grown
> back. Then this runs:
>
> sctp_primitive_SEND()
>   sctp_cmd_send_msg()
>     sctp_outq_tail()
>       sctp_outq_tail_data()
>         oute =3D SCTP_SO(&q->asoc->stream, stream)->ext;
>         list_add_tail(&ch->stream_list, &oute->outq);
>
> Doesn't this reach the same NULL ext dereference in sctp_outq_tail() that
> the commit message describes?
>
> Could the full pre-wait validation be repeated after each wait that drops
> the lock, perhaps in a shared helper? That means the bound check plus the
> !ext -> sctp_stream_init_ext() step.
>
> The existing outcnt-only recheck after sctp_wait_for_sndbuf() seems to
> have the same gap.
>
Please add a helper like:

static int sctp_sendmsg_check_stream(struct sctp_association *asoc,
                                     struct sctp_sndrcvinfo *sinfo)
{
        if (unlikely(sinfo->sinfo_stream >=3D asoc->stream.outcnt))
                return -EINVAL;

        if (unlikely(!SCTP_SO(&asoc->stream, sinfo->sinfo_stream)->ext))
                return sctp_stream_init_ext(&asoc->stream, sinfo->sinfo_str=
eam);

        return 0;
}

then add or replace the stream checks in these places:
[1] at the beginning of sctp_sendmsg_to_asoc().
[2] after sctp_wait_for_sndbuf().
[3] after sctp_wait_for_connect() in asoc->ep->intl_enable branch.

> [Severity: Medium]
> What happens to the association when this new -EINVAL is returned?
>
> sctp_wait_for_connect() only returns 0 once the asoc is ESTABLISHED. If
> the association was created in this sendmsg() call, the caller then does:
>
> net/sctp/socket.c:sctp_sendmsg() {
>     ...
>         err =3D sctp_sendmsg_to_asoc(asoc, msg, msg_len, transport, sinfo=
);
>         if (err < 0 && err !=3D -ESRCH && new)
>                 sctp_association_free(asoc);
>     ...
> }
>
> This frees a live, established association outside the state machine.
>
> No ABORT or SHUTDOWN is sent, so the peer is left with a half-open
> association. SCTP_MIB_CURRESTAB was incremented in sctp_sf_do_5_1E_ca()
> and is never decremented.
>
> On a TCP-style socket, sctp_cmd_new_state() has already set sk_state to
> SCTP_SS_ESTABLISHED. It stays there with no association behind it, so
> later sendmsg() calls fail with -EADDRNOTAVAIL or -EPIPE.
>
> The commit message says:
>
>     Return
>     EINVAL if it falls outside the negotiated range.  This matches the pr=
e-wait
>     check.
>
> The -EINVAL before the wait frees a CLOSED asoc that never associated.
> This one frees an established asoc. A peer can trigger it just by
> advertising fewer inbound streams than the chosen sinfo_stream.
>
> Failures after the wait from sctp_datamsg_from_user() or
> sctp_primitive_SEND() already reach the same free path. This patch adds
> another way into it, and the peer controls that one.
Please set err =3D -ESRCH; before goto err; for the check [3].

For sctp_datamsg_from_user() and sctp_primitive_SEND(), we should not
change it now, in case it may break any existing applications.

Thanks.

>
> Since the association is already established at this point, should this
> case be handled differently from the pre-wait check?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261002010449.3689454-1-4ncienth%40gmail.com
