Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0A42D2381
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 05:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788930541; cv=pass; b=OfGjev/yrct3yVFdb0OsllKKtT15Zm7g+j6etTzOcKaM3j7er/lsdb++TvKPepnea2VApq3sJAZXdXVwBCjdFmC9/bYQKgAEIyO33oO0aW9jRD7Gdl+dmf+6E9ZIEqDTe1Ynq9HLPQE/OL1OkthTyh4Qgw3PZZoRQ7Z7jCAYXQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788930541; c=relaxed/simple;
	bh=HezRIAx0sXtEI+YT3JY2PBlp5lPNNul4wM0VNcCw+wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIlnrUnZkR0Sml8aGA++FAwdRiJYtasR8txxeTK0ihDBOq+Gq4Ye8D+EwfvabH3fbSoCnmJ96ws3AxWWJDrvEpmfxccaZxO4Rm8eksYWUv9Af6QXFWilvE8aQs/FYUh23zM5rh0ZwqrJWG8SlmBiRJjYK8hrK5IzSgsf3n0AbOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1BsHc+S; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1BsHc+S"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso55183995ad.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 22:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788930539; cv=none;
        d=google.com; s=arc-20260327;
        b=fOgnPR78EPc3Kd8or9ko/swu4nnBhXqGhnwbf/EJW+xwNp5OPj1ew4xx6KzzTx+Jzp
         Cy/QOu6yLujEfCKSCW9/XWIyTeaifKMY8Ho5FLXtJa6Hb6iZbF1CWyZwLs+cDkt9fqmy
         b7SPCBlHYEcq8ncFZEnb7KWCI8PU416fc5arNm90L8ZmhZgcepy3/ctF058tHbvZ99P0
         kB4KbgDzVc0jtBtDWB2p12zdipKoD2v7gwGsz7D9f6ZFBl087ICJ4aB9IDIM35IFT7/t
         Rgc0kNbKc7PKOW402K4fnhdiZgcFpiX71MvQcbFq2LqIRHaxcxXiBn7zl/HZtl0tGbYn
         J6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b/lw5mO4gsU3bTOqtJwjVuYg0yHunzGXi2m1syQJ2Qk=;
        fh=Uoe1+YVT2W3rPR6OPNhdwEulx5/D9rFgh7WEqwX0jJo=;
        b=Ol0g0iD1f7xBW/LvoH4wuSOP1w5SYTW/Sq4raOzN2MK6E3vnz4+VsBJa8TKDnOvLhM
         WPv2vPvnF+/GxtbDrI8IxhJQVaTvQgWPuaBpPSCwO8MuMlYasioisGNjBPy+zoQ5XlPv
         sGDKQnrawVsvWMwrTEtl4HeggFjyOkzKFV2QHP7Nt2nK8jwcQbVwhfz3yjF+AHQhJtid
         shf7UvxZnXFkFfYIekwHbtx8SrhX31LvmikbGqGftKUHlcWTEcCAlN9Tdxit5FpEXEMm
         +MJ2bCIJhwnSihbJzVa8rKfklkE/sKf7j0XSLCOLYQpC/gIJOe60E3IfRAqpGju9hMlP
         mfwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788930539; x=1789535339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b/lw5mO4gsU3bTOqtJwjVuYg0yHunzGXi2m1syQJ2Qk=;
        b=T1BsHc+SQdk94m28uUKbjgUzkkPvEmLELkLDd95mqwOr0lN4iXQAdZXDSzV4SISC8u
         aHCatXEMmQsWPR8TqdhSL/ud9uo7IXK4OZd8+lOK869Rz1uMA0p+lq3d9ZPpqHXmKVtc
         dqMFRJ/kXeG33O4hI8/W+eBHycPLdUdmTHpcqYij7DE7eDUc5WeNLl0jLDk2dW6tg7nH
         ahCbNgFnD1tfkpksGg0GgpVZQMyZfo8iET239Xq/SaBldHmhYB0r4wTbjJ2IKb6qK/xR
         3j9TgCdkEnJKICt+AuOp9MIhluAEcRQ6gxl5ZDfURuH9cwalSAEqq+ZiDNle1lQxAcVq
         PZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788930539; x=1789535339;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b/lw5mO4gsU3bTOqtJwjVuYg0yHunzGXi2m1syQJ2Qk=;
        b=T47yrfDfieEDq1BrCITreahwsPWDSO8So/070aNjQk12/IJ9kuZBGfI88qZA6TaDRI
         0HOY1IhS07dqXsDEXY1Tba4B62kWkeLcoO198nfashRVdUErjyZSOtpzRafsSoReHuO7
         1DGlErYS8yJ9ncqGhcVA5HE7dbGy++qscUf9PTE4i5JnadQbpp9i1XC+s5Hbsef9erkV
         tMWDAfNLOHrejmp+1USlpWJKbzGsh/hjqSSNl7jPj2f4CpAJZO0V7nibANXqX4II5/P9
         R66j0Tme/rQUHtW3BUN0YIYagQS+WFc3FtBaf5rqdgrnXM3s2tw21LGYuwaM2yIJPPKB
         m//w==
X-Forwarded-Encrypted: i=1; AKwUvBz+aIXN6rdjyWiT3DqHQhPY2IgdY+ybzom55aWrvStZYJV4n3nBXrq+M58FeNbtNht0PDJ1hxI=@vger.kernel.org
X-Gm-Message-State: AFuF++k3jh92D3MJPbAL3HIXOa56dEgsHhDoWGdaHcszfXpU3c91H8ax
	PGyPPTnw+MHsTP7h7eVpFGVsiQqmpwWb2JrPy6WCX8825FwMNZhvy0aMhX08RX+wzYgRXE4HK1q
	pKKbuD6XsF3EtlpggHfWvV406xx1sWUQ=
X-Gm-Gg: AYBFou1sVr148Tup0oT29UdDCcqHVvW8FqBxk37y227SNuRrqrjFui8oDdGOv3Uhn0K
	WaS2ZMwipFsZQxRpb8v7svYFwTEGzrglcqwqUjOoretCFuQr3cAZQRreTeO4H9PWDuNJ05XdEm2
	KkodE/tAJve2r2K8SKBCQYNKE9waqF5eJ2AlLo6d9MPWlJ5jXeXsK0oj07Es9EahnoF75Dox1VC
	iXyrRxNLDLA18QNLjb9qz/K+OHn85B1vALyJiDHjLMykMkMwv9gAcIPIo7XwBOKeYLb777kUMWV
	T9bDLCUTKvcOXBa2KxvDrjPeRJWAFssedYuHo2PqgnJEZ3cqir7AA/QOVvXnw5D7b2m52EYxYo8
	7V9h/9qgl8omkI8HLlZjej+9WB70GvC0MrsviW7rW/dd6+9+W2y9BcH+ANEEfoRxcgj+xPupWCY
	3+jwOJoiZPILwnO1kF0xQ9
X-Received: by 2002:a17:90b:3fd0:b0:398:d6e6:4671 with SMTP id
 98e67ed59e1d1-39b262981a2mr47513999a91.25.1788930538817; Tue, 08 Sep 2026
 22:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906030429.2085375-1-xmei5@asu.edu> <CAJwJo6asOVa21T==+n7qdso1DBvH6Y3rXo24DdieAQS6XeTutw@mail.gmail.com>
 <CAAVpQUDuHr4WxEOUwikYqdG9FncoY09LOMGDPciHex2bQ51ePQ@mail.gmail.com>
In-Reply-To: <CAAVpQUDuHr4WxEOUwikYqdG9FncoY09LOMGDPciHex2bQ51ePQ@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 9 Sep 2026 06:08:47 +0100
X-Gm-Features: AcwNN1XYHOLlrXffZ4dyL2xhSU8WgL5jBkszIuyqQKj86r-XafJfRNUfbGQgShs
Message-ID: <CAJwJo6b72cdQixQ9Xodx5mhWLVvHgnaULvZ0JFjFhSwDuGvaBw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/tcp-ao: don't dereference NULL current_key/rnext_key
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Xiang Mei <xmei5@asu.edu>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Salam Noureddine <noureddine@arista.com>, David Ahern <dsahern@kernel.org>, co+2c72469dbbec34af@bugs.sh, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Sept 2026 at 05:44, Kuniyuki Iwashima <kuniyu@google.com> wrote:
>
> On Tue, Sep 8, 2026 at 9:31=E2=80=AFPM Dmitry Safonov <0x7f454c46@gmail.c=
om> wrote:
> >
> > Hi Xiang,
> >
> > Thanks for your report and the proposed fix.
> > I remember I wanted to write tests for re-connect() on the same
> > socket, but never found time for this, as it's not really used in BGP,
> > as far as I'm aware.
> >
[..]
> > > --- a/net/ipv4/tcp_ao.c
> > > +++ b/net/ipv4/tcp_ao.c
> > > @@ -857,6 +857,8 @@ int tcp_ao_prepare_reset(const struct sock *sk, s=
truct sk_buff *skb,
> > >                         return -ENOENT;
> > >                 *traffic_key =3D snd_other_key(*key);
> > >                 rnext_key =3D READ_ONCE(ao_info->rnext_key);
> > > +               if (!rnext_key)
> > > +                       return -ENOENT;
> >
> > I think this is quite a big hammer to fix the re-connect() issue.
> > In theory, we could even restrict connect()/listen() after TCP_CLOSE,
>
> As there were too many rehash issues, we disallowed it.
>
> 8cc3aef0cb19 tcp: Do not allow buggy transitions between ehash and lhash2=
.

Thanks, that makes sense! Two tricky-to-handle corner cases that no
one uses less to have in mind :-)

> > but I think I have an idea how to address it "properly".
> >
> > I have a draft of a patch; I'll test it today and send it for review.
> >
> > >                 *keyid =3D rnext_key->rcvid;
> > >                 *sne =3D tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sn=
e),
> > >                                           snd_basis, seq);

Thanks,
             Dmitry
