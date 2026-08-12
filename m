Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42BA42376E
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530342; cv=none; b=YUzUnJSPaAMninr6bXy7+xNxustdL3PWby/EvlxUeNFLS2Kl+WCxPS2aBJAvNwszKccHvZEZHqiYX7ISgB+ij4d2ZFVQ0lkljWxdkR8ogdZ0BS12zjJcJqBhQhypz4yeufGbvWaQdCfEo2MMm4zdZGcUDabUe6RZSPHL4wSdKTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530342; c=relaxed/simple;
	bh=i3Z0c1eG4C8OKKyeR1gk2MEKerI8zwHefe/oxp0onkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCrNeMib6uLb7OxanSlGFpAW7Dph2BUvtOK9OMoiOkTsVylldIA01aAvPcEtDCoY0l2e3a8LLxif/4B7/57a9DFN0gBYc6mginpM9rz8L5HSdcWeT4RJDvK5jatzovoqd0snvuxoEcOhRoqBlv9AraGN3KvJcymBOid858arZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9Joyu9d; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9Joyu9d"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so6423495e9.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 03:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786530339; x=1787135139; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oe8dRxLTv2e7yq5ZrL4Bpp0DEMKWFxsHcdUWwRLEBqs=;
        b=h9Joyu9dOcAIUxpygvdwu2JC7m2/HgavgRCSGskufZGwxymLFZdrtjXP+t8kW7Ac37
         0Le06jc8LA44+JEgj/KLfzxEeQA3+/IWMad4r2rGM40fNb7o4nXzdEq4pqdm+QADIMrE
         3KULxaiy7rdl1c1YyDbzhG8mmoGiFYVJpicBCyzXM6W06CNB8PWRnsohQaTH/cUpw8UM
         PTW71mGl8ecat+iyuZ1n7AmitmqIac8PvM74Ir2Tk8vocSgJr4RKw8O1gJ86dmM9Bx7L
         XopDiVCi1hXoRPmhBkELajgwj/gtT1LcYXg5x+jBN/myrztqHmIyfPhTc9avDCmXtxgj
         XKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786530339; x=1787135139;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oe8dRxLTv2e7yq5ZrL4Bpp0DEMKWFxsHcdUWwRLEBqs=;
        b=BVktbghX8VmI+YKxTodVx79zeDBXcka5EOF/g8NroQBEY8eTD39cEwjWECTGOIw0tp
         p6pWxCtld7GPMIpSss3xgZIUtEfFTwLA1mQ2feX6dExXmj39Ot/qAsVge6DwnEYfi56p
         VLzSHoGNFRs/3H0J5bOP4gLRqZqw8IaCSAc7W0CvCml8GMO+PQARB2hdszHra7Hkn1nw
         HtJwbdwdsALCvnlC1HBOQTMnyr2lxbHI0LVRrHXt1LuwKij3XtY605ggUckgKgHnigJa
         tbz+lyQAFCRNMUzfEKmDyYjnnJyKENHoOlO9QZzk2Pi2839EkaiAKuqS+v3GqJHv/jWl
         g56A==
X-Forwarded-Encrypted: i=1; AHgh+RpjL6QEcWRhguT5ziEo241FSjEmyKwTePp057SZ6xnm9aisF73bbknrr0vutG/+rtyCBRTriaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66iOdvs5MWxJK9jHdbgLP6guT0f2IbwNmDKHpTHm+I+CeuP0o
	NH1RB+Trq6k/bP1DlIayk9A7aV+t/3glNfCxY3oUiVaNZuBBc9AicE27
X-Gm-Gg: AR+sD12/RR02REBzA1tTS2n+T4rPqildVBWhHZoAcEYr8p07t1Cl78XZOKPCFNK7tpz
	xmIZ72gMBf6LMkm5Zc8Y574iODAU/8zl+XXbluA8i0Fw7qKEJE0sriLtMiILMJKSbYXHpRl7/L8
	HYWA9a9PxsQAmQ/y4jJQX3K0Gxf6wZj6FGphxQcXzys6i5kawdnfPheimrtXIawxyD3HtW16wKB
	OSAhMxNei9qXXlEooIE7xkzmEw+Ibbly88KsAdcm5Qhilcul8KuquDfCMdweukdFb7WN4yylDGP
	krkLn8Q0DTC2RMXm5DidFAeu2/0A/grrEv0Fsz5sWdqlR8AqXJxIvwkK32jpklONr1GWqTvTnh1
	Wdjco8PdtMc98Kq05Gyl9Inv0pqiUoRQLndE0diBUj/z148wAm3fCkzV/fZubF28fb6A8Jz5Ec6
	DUWmwsr4DiI80mxzqjdC2R0aYfWGp3l2QIP9yhY0+mkVUdGxNi2OUHC6cmNhcm9L3gQTW2A/Kb6
	Hs/Qivc1qYY6BMHz8lu
X-Received: by 2002:a05:600c:5020:b0:496:bffb:fb7b with SMTP id 5b1f17b1804b1-4997c13420bmr54782195e9.10.1786530338799;
        Wed, 12 Aug 2026 03:25:38 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150bf412dsm6829626f8f.6.2026.08.12.03.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:25:38 -0700 (PDT)
Date: Wed, 12 Aug 2026 12:25:36 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, ameryhung@gmail.com, memxor@gmail.com,
	jiayuan.chen@linux.dev
Subject: Re: [PATCH bpf-next v5 1/5] net: Add connect_socket() helper
Message-ID: <anxKICgNbziTLtsy@gmail.com>
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
 <20260807171532.125149-2-mahe.tardy@gmail.com>
 <CAAVpQUDcckytw4Y9S4mK8T75DniD+_=stL9BOo7Sp70OFAOjgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUDcckytw4Y9S4mK8T75DniD+_=stL9BOo7Sp70OFAOjgA@mail.gmail.com>

On Mon, Aug 10, 2026 at 09:01:18PM -0700, Kuniyuki Iwashima wrote:
> On Fri, Aug 7, 2026 at 10:15 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> >
> > Add a helper that connects an existing socket while invoking the LSM
> > hook. Reuse it in __sys_connect_file() to avoid duplicating the connect
> > logic. Other socket operations have equivalent helpers that trigger the
> > appropriate LSM hooks that can be reused, this one was the only one
> > missing.
> >
> > Acked-by: Song Liu <song@kernel.org>
> > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> > ---
> >  include/linux/socket.h |  2 ++
> >  net/socket.c           | 32 ++++++++++++++++++--------------
> >  2 files changed, 20 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/socket.h b/include/linux/socket.h
> > index 2a8d7b14f1d1..5a5eb1250103 100644
> > --- a/include/linux/socket.h
> > +++ b/include/linux/socket.h
> > @@ -461,6 +461,8 @@ extern struct file *__sys_socket_file(int family, int type, int protocol);
> >  extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
> >  extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storage *address,
> >                              int addrlen);
> > +int connect_socket(struct socket *sock, struct sockaddr_storage *addr,
> > +                  int addrlen, int flags);
> >  extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
> >                               int addrlen, int file_flags);
> >  extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
> > diff --git a/net/socket.c b/net/socket.c
> > index 63c69a0fa74e..8f18f124d92a 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -2103,6 +2103,20 @@ SYSCALL_DEFINE3(accept, int, fd, struct sockaddr __user *, upeer_sockaddr,
> >         return __sys_accept4(fd, upeer_sockaddr, upeer_addrlen, 0);
> >  }
> >
> > +int connect_socket(struct socket *sock, struct sockaddr_storage *address,
> > +                  int addrlen, int flags)
> > +{
> > +       int err;
> > +
> > +       err = security_socket_connect(sock, (struct sockaddr *)address, addrlen);
> > +       if (err)
> > +               return err;
> > +
> > +       return READ_ONCE(sock->ops)->connect(sock,
> > +                                   (struct sockaddr_unsized *)address,
> > +                                   addrlen, flags);
> 
> nit: indentation is weird, and

agree, ran clang-format on it, should be better in the next revision.

> 
> > +}
> > +
> >  /*
> >   *     Attempt to connect to a socket with the server address.  The address
> >   *     is in user space so we verify it is OK and move it to kernel space.
> > @@ -2119,23 +2133,13 @@ int __sys_connect_file(struct file *file, struct sockaddr_storage *address,
> >                        int addrlen, int file_flags)
> >  {
> >         struct socket *sock;
> > -       int err;
> >
> >         sock = sock_from_file(file);
> > -       if (!sock) {
> > -               err = -ENOTSOCK;
> > -               goto out;
> > -       }
> > -
> > -       err =
> > -           security_socket_connect(sock, (struct sockaddr *)address, addrlen);
> > -       if (err)
> > -               goto out;
> > +       if (!sock)
> > +               return -ENOTSOCK;
> >
> > -       err = READ_ONCE(sock->ops)->connect(sock, (struct sockaddr_unsized *)address,
> > -                                           addrlen, sock->file->f_flags | file_flags);
> > -out:
> > -       return err;
> > +       return connect_socket(sock, address, addrlen,
> > +                                   sock->file->f_flags | file_flags);
> 
> same here, otherwise looks good.

same answer.

> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
