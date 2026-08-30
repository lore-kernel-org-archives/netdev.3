Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663525F988
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788114976; cv=pass; b=fDo1mduK9Z5RLXtt4V+RwpsJ/UemT3LzimTZx7etMfRX11vQ/ojsHp9j4CCkH4RcUtUF+hCU1mulYLV7sCJTw4fLH2uu72dpaogPH4FYSii4B9xiEqWPLJjXpFiMRsDmMh9aEsudekEbMEnQmHknZSTefzgewgXRXg7t/V5F3/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788114976; c=relaxed/simple;
	bh=Kvf+lrZRkjzxTsCjIQEa1qQ/ceDVmhK/wc53ZlrMtpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CK1qdBlVC2GHAQCbZtetvxL4JMk1iFxTg3ZQX+dlh8X6zFoymMeX3cvA6Y+jSsYLK6tovvj6YNDNIL4bzb/5LRWPKHydb1IHjO+idm/e4dIvxBgfknPDxSRq+10+A3ZJteCdiTeJ7eHegeITyefEcrAAYq8QaHEF8ZjlC+/Ga64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZPFYTC7q; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPFYTC7q"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc1c7364550so2841406a12.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 11:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788114974; cv=none;
        d=google.com; s=arc-20260327;
        b=Qg+pNFcPdUPBY6PqiOformUZanyVkhXwwH0YVamuTKXVmFb3s4kLHaKd0DosntULqm
         XoYcy5Qjh83fwV7nuwbv+IyDKk3C9rAGqPitmFq+9aupZ1ksXqotF0PEZ/LNAZJRh1u4
         mUdWyX+YX85TE458Tw66ANUuK/SufhIk+32XdQUjqU/CFz0f3tKBaSQZ45LI6qZo6bwh
         rjuUGwI6WGs2DJckF9+fggrU7aemProSMJt2IUXcIFNmvTUwGNqlOL65sskuv94FHb4x
         Spr/accspn+nO1U3GYjIb3PF6jyvqJc2ZtD7XO0PL5WBhc35eDnHyQALrhHGgzsUSqwJ
         AYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yI65d1Pj+WBRmzGoc7MgKM40FI7afGWFtJ1MOWUd/LQ=;
        fh=BJ1Fttd5BjIwH5XmjPYdfTUCvU1DlMPt2u/iPIpLG4E=;
        b=s0MSH1QWctmzB8hoMP9pGIji9sRTY6C5Pvl5DK3kSRmk86sBgTBS7hOgvmJ/+cKcMp
         8M5bgVeYnWqz8Nz1nIm7l3ul4gUKWWCXn9I16hmizNkyM7OOGjeqV8AJXami7rQUJhrO
         JpVklngLcvBI6YiFy9nXZCJPoTTOBNG/gBICD9OKQIP8TjAJ+tusQkhxHznvfjaTdwaR
         R31KFNnES/Zk1UTbbaMjWZHzAJXdZ0OW4DgNmVnHxVtWg0+fIJ5mzE7f7ZoUkvQ1RrMK
         LJQHR4QdrwpBNRE2R+z2XL4U0NcQr5K8PVUxSgUjM3Dd290WTn2Nuq7ZI1SP9oIMdcyM
         UEyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788114974; x=1788719774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yI65d1Pj+WBRmzGoc7MgKM40FI7afGWFtJ1MOWUd/LQ=;
        b=ZPFYTC7qAws88ytbYnS3IAvnzA45aDjR69lkZ0W3KjFIam8KtpFR8+dj8OKaRNzRHP
         KOvRJCQeP6zfBg4CE1O2ByHB9PZFfsoikaNJExOfJiXhqnmQFbicQw9u4fp60iD99DnJ
         UbkzqWoUyCQ6mzqVvl0ht0WN1DE1bFvXkFi6jH1375eoCxks4tv3xDKI71aZFL61xctr
         dos4ZNz6m+H5eBjZ3a6BJS5Lse0vgKjloDiSQzq5OYCpf+aKIPLtTgFVAvmKwNdTWxDm
         KQoUqyxcwIup6aHSW6iN0E27T2yH/cBWfyl8jqfoGn0Gab0OfiQQq5Wgm+knjaSGxdoC
         Jh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788114974; x=1788719774;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yI65d1Pj+WBRmzGoc7MgKM40FI7afGWFtJ1MOWUd/LQ=;
        b=YcRvjeyyA7spkiYxjpCOFT28+SPv7WtQeUVV58hyZZvrWN+wUV5xxDh5xAm43Ozcqn
         MVZhXWBV88zHBE8tlwh8gXFWz+KljVlhkkNp53ucD1HbMxuvg/mA0nInYqAH8dJvZRIy
         56mNuSq+aitwlH6GGGqqvI5muu3fAdNbY+H/3mE/7GuRPkBWBlpMqJvTwQlq6Ryr/bf0
         U+YNk1ZtLApySUodNMPUKcrWN/z5OGlnUrIRpenCnMYBnWSr5htQqW8CkR55dSfmeWdJ
         ahMjE8nMnzzHhUozzsw6RrlaHgIbSPNlXVvGkvgZMxQSaH9pzezYmKsVRTUAE9vnPaY1
         Byvw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2U9Mu9xSoYMD0T0ZZk9KMlxCtKkpzLG6xaNTl1EZeJ2DKZT1nw9tIC7R1BDCoXODcY5cT/YQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kqOPquVakh4cvDhRl1BIeSJoMNHzBmamXvOib5s6PzC7J3bGG3
	ewSdmcKhLxljdxSfhHhaGK2eh57Y9gpbzxdzGtR4KjIVwYgvOnOlOXWXIVDEZHwbO2KaFTvmVer
	0/WNFvEHVV9d/sFNQflUgF5hqQfAVbmAdX3G3hBEZ
X-Gm-Gg: AR+sD10LNVD6Bp57FW7bElaoXl1LoKEduVhh/LmjnY/CxXATt6cXR9QovsH3eygP01t
	F/pufgd/ykUe4V2AHgFUiQFY/ZtvSqW6U75Kl+0PLQtLD2uCtrkpg0XjbL1KLlMWHblv0SHsZnN
	IP9SSYwsd2hBDIDNpvyVYruH0sQHz2OkdPRqTz4fof3IKYtQ+b9/fvmqv6dfV5whQBL5d+NurHo
	0Eklqi1jgQetWcpIG1cE8nRRGq6qf2VbPfIDsLuB7L2hh57Apt8hz39rZTYSRVO7J4d5D1+3LhF
	sdlQQ8Y/zacQbeYHh/6WnqX7rSQ53vXDmKEmalqbxC05aQa6tsEJjruZUXOgjS+Ss9JCstJQS7d
	E6ZdOfUSXFYFuCywL/lb9H9V3zp6mKCTy0i3fzY9nlafMj82FYUaB9vLa
X-Received: by 2002:a05:6a20:72a3:b0:3c3:b57b:627d with SMTP id
 adf61e73a8af0-3d2686a9adbmr31899025637.12.1788114974092; Sun, 30 Aug 2026
 11:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830180915.260225-1-kuniyu@google.com> <CANn89iL9ujwPmw89acUsU-xQtu0_jUcJy+sRfuj=b0-k8Qagfg@mail.gmail.com>
In-Reply-To: <CANn89iL9ujwPmw89acUsU-xQtu0_jUcJy+sRfuj=b0-k8Qagfg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 30 Aug 2026 11:36:01 -0700
X-Gm-Features: AcwNN1UndGN6l-q3d7y5nIkxwFRD_t3VEdJriJOHoNlfqxz9PalIbQujWLhqAvw
Message-ID: <CAAVpQUAk8G50Gm1JYtZP3dAvJ-PMp_F4oZGfRW2AfGnR2BCQYw@mail.gmail.com>
Subject: Re: [PATCH v1 net] af_packet: Don't cast tpacket_hdr.tp_len to int in tpacket_parse_header().
To: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Johann Baudy <johann.baudy@gnu-log.net>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+73df3f89e1e13089e466@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 11:25=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sun, Aug 30, 2026 at 8:09=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > syzbot reported BUG() in sock_sendmsg_nosec(). [0]
> >
> > The problem is that tpacket_parse_header() casts user-provided
> > tpacket_hdr.tp_len, which is u32, to int.
> >
> > If the length is larger than INT_MAX, the following condition
> > in tpacket_parse_header() passes,
> >
> >   if (unlikely(tp_len > size_max))
> >
> > and any negative value can be returned to the caller, up to
> > sock_sendmsg_nosec().
> >
> > The repro set tpacket_hdr.tp_len to 0xfffffdef, which is cast
> > to -EIOCBQUEUED (-529), triggering BUG() in sock_sendmsg_nosec().
>
> Patch looks good, I wonder why we still have this awful BUG_ON(ret =3D=3D
> -EIOCBQUEUED) though.

I think we can remove one in sendmsg() at least, syzbot will
catch the same issue by the same BUG_ON() in the write() path
in fs/read_write.c.


>
> Work done in 2014=E2=80=932015 by Al Viro and Christoph Hellwig was compl=
eted
> more than a decade ago.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !
