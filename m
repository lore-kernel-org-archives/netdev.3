Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC61397
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788825753; cv=pass; b=fJN565Bbf3tHCsc6JlDQO3srvLhNTW+7eCNg7tNwCsmrDvtNGGR2auiTts747r10Xc7DkpGnO9+apPMALVyZgzv+KMMT1pPQaL9apGsXlAFPJGAykkuEltXiZ4acZKs0r6PdKPa0OGtcBQnccJSl+RPzf8d3z+5Do2O0OkXoFgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788825753; c=relaxed/simple;
	bh=Xmcm8X/5seMCMO/KWoCq9clpuwpr3ZBW/uEB2NhzfyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZDQcyzNDP8S6ZYoYe6e+SasO7fi25pI2JIlConCGRBRwqVKN9OYu6wW0+Ikmyw+Soif9gdN6KjNcfDysk4tN++XBjqDKmeLv5BMO3lUPN1XW1BQK0D8dSBvvazDQ+DDnm7bF7kRPpxEKTdPHNXWedB6wTSUyPRsKiKHbNPDxmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YRMZOJfZ; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRMZOJfZ"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7f4cc6797b7so2163168a34.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 17:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788825751; cv=none;
        d=google.com; s=arc-20260327;
        b=X+74+ym95Xq5OYSfL5VvcjGOtZAeaJVAYaNwb0kshFWwx4a3CF+19M6Us4EmYbUKU0
         lyXHUpyclVWxgiszU5ruQReS+U7A9BlZcthzdjBEtlYNCrNphv26zs0Cke3i/xlt+P/j
         WCc5MNmzihVRevj3ZAUCu6xUJE7dLEdYV6JBGqlfnsa+B1SFCACBt4PNSzBnxJIH47kC
         N5Vf6NPhJPIj1EzHv5IpDgYL3jD3LuZ+Zk/WGk8m89JOTuVqajsMEXhXA3FTf4ifCZBD
         7uVplD6bVvHjTDNQreTdA+eK9MiWGlNdWF/PLxcNydBmu9qRHrqQYXuLBML54WJPR/vM
         AXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVWeYFxmU3z0HgB9lGrsIq5mzPaYw+pve5WVBxETq7o=;
        fh=1gm6T5KEbvOj6IkDWjcRgnzjh7j+9bkmRzIp1h1fXsg=;
        b=oN0Xi+zl5pYpoLOJFzmyy8LjUcRn8AQGQYxdGs5EO8j3h69HQngK7EBLIPCtX/0Zxk
         ebTocmrhjHQ1TTp5K958iD5Ctc/6zLcwAG0SAJTOZ1Ppp6yTkZFNGNlyoYIepix7SnWK
         bE2/rOdgx4TR3KIg8DhZ1o+bZEl36kyPJ7H81HtQt96DTDqdy3waK8Z0lfFAoz93b1ON
         kGmWNBPPD7VnjaTa9AwfOI8HPfv5V1FLlH4eJyECa1dU5mbHdPcbb4muQ7Kv61Pmewtq
         VXzLbP+ojx3b67h08IbE1rmqUrRGhFvmEf6Tb3O/RRcQEX81N5Zs+/SeM0alWs3iVU71
         +wxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788825751; x=1789430551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eVWeYFxmU3z0HgB9lGrsIq5mzPaYw+pve5WVBxETq7o=;
        b=YRMZOJfZHTLKpicOjojKPXVCKeY+9tcJKRixYunI08SAbJPax+9/X3KNN5yw+BGQ11
         QVUKWnV3rfU2EWXyvsT2tRWbMKjMBhyTq9tMrZ0lpHeqTkWFg4ylAoUX9lBe6yDjY43e
         rvVWKOHQoTAA+YxJXtXrzj3Xt0mN9JPh48P+zv9bYVxe6ylP38xKX3RwYx6D/IaLziGK
         +8HQK+PZ9FyzejUNh5nbQa2XVEJIvJuA0K77IcVN7br7uivl8x+zyRD8LaOM9sMckBjr
         G+hnli621spSSH/wZAOJBPSUq+8FlSCofoaWrWHAG57vvVk/GdNt8v7C6urADptty5IE
         U7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788825751; x=1789430551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVWeYFxmU3z0HgB9lGrsIq5mzPaYw+pve5WVBxETq7o=;
        b=KPwYvXywd8HrkCN03+qtv+iOjvLV37BE1RHQo3OrIoLr7BI60DEi7cw4ZAUxV4Fkid
         HMCGkynAahDgPbtd04cKVxfzpJj0wchdm5bqJmkndfJRgIkaY6rQt17QEO1sN504sXr9
         b5i8bTRBCTjtf/ZoX+RYoYNfAl8q7ws7hIeOo0yQ1+2LFthmx65GdvvDXKMhJsXMOJVh
         DlY7I/evh/uWz09bYJ+Nr+nt8CzomvKOlr0xXJwwHwqe4UVAg5h4iHZ54Z6enqYUrLWz
         +qVlBtJVZrl0XpsWFTJkRPLCBeLXVVFvLUyRvvtY9DvEjeaD/nXXWgTaB5/biZmbh2ww
         G9eA==
X-Forwarded-Encrypted: i=1; AKwUvBw5xHMuSfb6270uPaOtZ58AnCMjxoLDZzGL6JrHCZdmRSBN+Zwi6x0uqVBNzoqKd18IWnZBPAk=@vger.kernel.org
X-Gm-Message-State: AFuF++lltIxuc8Aq7Sip5kPMfhLg4dGJqnVu7lfRb0aVhTdAFzwCthRA
	7LWWtqzAmL+k5gW/jD0kseI62Nx03UHwazwYdbdMYH6245f+fRZ4QyxeP/QwmmYFBhxsJ6b44A1
	LdnRbPu5uCkZOmmW/hFJH6qfLq1DCKg18MAvmpeYH
X-Gm-Gg: AYBFou3oY76Edu/n2c601txXN/xj7decd6dwv5y8sytYEtVoS7Nmz317DJ2yNDh6bOG
	u/a/DvtPovGDstwx2eubBxiI5T5XkAn8MOcrf9OCGvvLYrspVoZ3ZqyfpcCLoGP5yC3jl4/jeuA
	Thre6XM0axuqjRuPtlGWGu+92KUIAIxCmN0dCMcQMLbU01Wd+EcY6IfIKMoogfXdQukAlscj9yF
	9+bKtIOwLQbfTyZqh0TuX0EBLk9grCuMJnkqaDFIB4FeydmyhCHo8wS4w36DOVVYMW1OGt8qo3A
	tjPQRGWjoNEzpL+fhdeRJSs7MuLWBOFTxWCGmyldzivRueRlh9jWMDk8p075bHducMzorJ7JPDV
	Ntky59bUzHRkjjSS0P/TOS+eC8M4LZN0vIIdQj5lCOYuI5tPhZN3bsVG3CiOYuv20FMI=
X-Received: by 2002:a05:6820:c96:b0:6b1:6c11:686a with SMTP id
 006d021491bc7-6b6fd6c5cb5mr12850616eaf.29.1788825750222; Mon, 07 Sep 2026
 17:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902202202.892676-3-kuniyu@google.com> <178851031352.4131868.6534018713303595286@kernel.org>
In-Reply-To: <178851031352.4131868.6534018713303595286@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 7 Sep 2026 17:02:18 -0700
X-Gm-Features: AcwNN1W5Xi_4KsKdfxfVBq0FeqiBzKm27Xp3oVQyos_Ska6aqo1KkZyUHY8nTkw
Message-ID: <CAAVpQUDdCiYexxgP_8taMyuPEe9-MTs+27X+rhKkgksjYLSC0w@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/3] af_unix: Return immediately when manage_oob()
 returns NULL for 0-length buffer.
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, fahad@codepure.com, kuni1840@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 1:25=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [Medium] Zero-size early return is placed after the queue-mutating
>   manage_oob() call: recv(fd, buf, 0, 0) (zero-length, no MSG_PEEK) on=E2=
=80=A6
>
> --
>
> af_unix: Return immediately when manage_oob() returns NULL for 0-length b=
uffer.
>
> This makes unix_stream_read_generic() break out of the receive loop when
> manage_oob() returns NULL and the user supplied a zero-length buffer, so =
a
> blocking recv() with a trailing MSG_OOB skb no longer busy-waits.  The st=
ated
> goal is to match TCP, which returns 0 immediately in that situation.
>
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 6861370062df..2da1017f8873 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -2976,7 +2976,7 @@ static int unix_stream_read_generic(struct unix_s=
tream_read_state *state,
> >  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> >               if (skb) {
> >                       skb =3D manage_oob(skb, &last, sk, flags, copied)=
;
> > -                     if (!skb && copied) {
> > +                     if (!skb && (copied || !state->size)) {
>
> [Severity: Medium]
> The new !state->size condition applies to every zero-length read, not onl=
y
> the MSG_PEEK case described in the commit message.  Since it is evaluated
> after manage_oob() has already run, does a plain recv(fd, buf, 0, 0) now
> destroy the pending OOB byte and still report success?

Yes, but AF_UNIX and TCP work in the same way.

AF_UNIX:
socketpair(AF_UNIX, SOCK_STREAM, 0, [3, 4]) =3D 0
sendto(3, "a", 1, MSG_OOB, NULL, 0)     =3D 1
recvfrom(4, "", 0, 0, NULL, NULL)       =3D 0
recvfrom(4

TCP:
socket(AF_INET, SOCK_STREAM, IPPROTO_IP) =3D 5
socket(AF_INET, SOCK_STREAM, IPPROTO_IP) =3D 6
listen(6, -1)                           =3D 0
getsockname(6, {sa_family=3DAF_INET, sin_port=3Dhtons(35281),
sin_addr=3Dinet_addr("0.0.0.0")}, [16]) =3D 0
connect(5, {sa_family=3DAF_INET, sin_port=3Dhtons(35281),
sin_addr=3Dinet_addr("0.0.0.0")}, 16) =3D 0
accept(6, NULL, NULL)                   =3D 7
sendto(5, "a", 1, MSG_OOB, NULL, 0)     =3D 1
recvfrom(7, "", 0, 0, NULL, NULL)       =3D 0
recvfrom(7


>
> With queue =3D=3D [oob skb] and SO_OOBINLINE off, manage_oob() takes the
> non-peek branch:
>
> net/unix/af_unix.c:manage_oob() {
>         ...
>         } else if (!(flags & MSG_PEEK)) {
>                 WRITE_ONCE(u->oob_skb, NULL);
>
>                 if (!sock_flag(sk, SOCK_URGINLINE)) {
>                         __skb_unlink(skb, &sk->sk_receive_queue);
>                         unread_skb =3D skb;
>                         skb =3D skb_peek(&sk->sk_receive_queue);
>                         *last =3D skb;
>                 }
>         ...
> unlock:
>         ...
>         kfree_skb_reason(unread_skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
>
>         return skb;
> }
>
> so u->oob_skb is cleared and the byte is freed before the caller ever loo=
ks
> at state->size.  The loop then breaks and unix_stream_read_generic() retu=
rns
> 0, after which recv(MSG_OOB) returns -EINVAL and SIOCATMARK/EPOLLPRI repo=
rt
> no urgent data.
>
> The commit message says:
>
>     In such a situation, TCP returns 0 immediately regardless of
>     blocking or non-blocking.
>
>     Let's follow the behaviour.
>
> Is that comparison exact for the non-peek case?  In tcp_recvmsg_locked() =
the
> found_ok_skb path computes:
>
> net/ipv4/tcp.c:tcp_recvmsg_locked() {
>         ...
>         used =3D skb->len - offset;
>         if (len < used)
>                 used =3D len;
>
>         if (unlikely(tp->urg_data)) {
>                 u32 urg_offset =3D tp->urg_seq - *seq;
>                 if (urg_offset < used) {
>         ...
> }
>
> With len =3D=3D 0 used is 0, so the urgent-skip is not taken and tp->urg_=
data
> survives the zero-length read.  TCP returns 0 without consuming or
> invalidating the urgent byte, while AF_UNIX now returns 0 having dropped =
it.
>
> Would it be equivalent, and non-destructive, to test the zero-length case
> before manage_oob() mutates the queue, e.g. break out when
> skb && !state->size, so the empty-queue case still blocks the same way as
> TCP?
>
> One more note on the selftest added later in this series:
>
> tools/testing/selftests/net/af_unix/msg_oob.c:zero_buf_oob() {
>         sendpair("a", 1, MSG_OOB);
>         recvpair("", 0, 0, 0);
> }
>
> This exercises exactly the destructive non-peek path, but only compares
> return values with TCP, so the difference in the resulting socket state i=
s
> not detected.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260902202202.892676-1-kuniyu%40google.com
