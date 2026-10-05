Received: from mail-oi2-f42.google.com (mail-oi2-f42.google.com [74.125.231.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2986D47D468
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791200203; cv=pass; b=cwHoj8Vzyj8JLUpRJKogxnpU/7f2KDXyG945DUEKqeASuv9/+7KPY4u8E7hxkqtWppHaCMoTkSgnouI94PH2o5skMXf8WexMYucTDta4wJ5rXEwAF5nKxIUryT7QMiHbYxncZXVgkYFVR3rAFBRNKl6YqfVxOe6NqHQYyrx6X0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791200203; c=relaxed/simple;
	bh=iQs9u5Dxt5qA1L2dSEQtGGHrdemsHVwPrDyyj9Xyad8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwZQfXyEz/Zzuq+0qXxgVAGGyGQzI0ZAN2e94V9E+I1Hgk4+cNdPTBRkbmt7HGyprX7wyOKRZe9Ifl60QsNZOeKQ7Cc0BgU54H9xkKqp+xVnynLY35IgdSduNVad4ZzsvtpFH0tqgHKGa9Xguo5Be+deUMwO0IioRBqeP1s+XMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hD1eZxn9; arc=pass smtp.client-ip=74.125.231.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD1eZxn9"
Received: by mail-oi2-f42.google.com with SMTP id 5614622812f47-4f55cdca3d3so38610b6e.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 04:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791200201; cv=none;
        d=google.com; s=arc-20260327;
        b=MHBKrbJoSf7qnDUAlM2o7f+Lmi/BtZLmsFZxmuoKor/YkrsPt6MkXElvQPIaRRnEi2
         4jR8uYeO/Kb/Q5Ft6ijlkFpWynw/V9ilS8UVqHy4KZXeD4ixMTAAr/XfWhf4RfLvwH5v
         kJE3uhpHjgqORdZ2fdwT1J25vJ54quId5xbvAzLcafBNLm2DKJPafFh8eVC8uzDgpAHp
         N3xSuMqrsdUyuaYOt8radr2Bkhv38bsqxhHKAcFE56efgilyoMmqF+1nFrdWku31xYlz
         uwiO5ylyDIHa5D4ZvklamnKt7z0RD7JMvl8nHJhZJZHLt30um2VHBh79otT72P+3q9DS
         YQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g5J2HOgwSoitKKDvvN0FWjMcbKZZ6kViLYOEdGgUDcs=;
        fh=kVm3Lv7MedCjWRXrEbU7MxA0kKiLqvxjH4Bu89htS/E=;
        b=C7yFGSimxStxBOxqdlSyRxvcI12ypmpN4o3BhRrMaBp8/gwUHQsYOhxYSYjpoy/I9/
         JLwQcuPmA+19JSGX5FrP88bsIcgq61lTfgg+AUkWC5sSp96FJdtc5XT8AAfdjw59f1bb
         GgJOCkgccADn7CxlXxxnTQKfUH/vEgAD5OWgHrssjp/EbDzjQjo602/hPAZ2IYXoq4Kd
         oXTSekw52u/qACBnHg4Bu6bBZIDzFTb2xpYII0jJxiNTxgIKev+gQr/W1pYBaSS+VkMR
         b1t+lHkxDvenhq/QTR75VGQsG4S9ko57mnrqNrGY8suW+QUl7PBPyVj9zjQlRcYFaLLA
         AqqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791200201; x=1791805001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g5J2HOgwSoitKKDvvN0FWjMcbKZZ6kViLYOEdGgUDcs=;
        b=hD1eZxn90yb6czilSPxF01HfBGNc81p66NbWd5f/4SzKzYqfoSL//hJGe4tkdd7Qj5
         vhADNdXLY4tsinOKR5BeQo6GWyfR0JUc3xJEUDYxfcx/BNh6TbxDUGQ/np+tI7kV+zM5
         GWlnQ+9ukg0TuVNq/oopg0uCLKFShaBkk6rS4XQVqatcg1QS9vknmglhQi0F+6BPzZSe
         TkFulF3jP4IzxYTYtGXSWWYUUOMBpls5UhDWYxKhhcMxtnBHvbuGVRUGk9tBD9JF7z06
         XaXCZxguUxNe5IaM3IqrAYfgkswlVOZOfFX/3JfX+sCmMJSiMzLNK/hiT5D92YF4kpSP
         s3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791200201; x=1791805001;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g5J2HOgwSoitKKDvvN0FWjMcbKZZ6kViLYOEdGgUDcs=;
        b=D1zADMjPf1AB/2o9xliYqC7rdqxMDQTlQD8ZhrnGWbcU1iqbLLVvdu3vz1X3Djmmac
         mTkD1/2E635PwSlUEI64xDBec8kW2XozucHBUObRQPvpKsO6P285G1JdCeHq5NEOxrgH
         +2paEaTUAM9x4pi8nZ8nsKpeqjro7oviY5Oo9g0cQtJe+ucu7Zhfoe4y4YFnzl+nc/9K
         1AKrCY8p1xyzJdF+eWz+QjbGZuRnQc7K97dNOxJY2uwuuGb8AFeT6mLDgt9vwGwo5Dgy
         yEqxta57XbAAIGQnHx24xZBCk+bCokChj93Dvz4tAcKMP+ymxfeTw0O+37JpbpSwaCPW
         vbIQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/0XzbM01bUKnZlgiU/Um/HGRiwfkpOccFDOv+mYLfuq0d8ybOVA/iaorIYjTl41clSIWPtPU=@vger.kernel.org
X-Gm-Message-State: AFuF++mm3i/buu+fBHRPoYBTLDcOE8M8vnlVEhrUDk4QiuvaXvmdOEB/
	4i+W2Cu76A54pOwvglgOvUdEB0fpNEszwVlABxz+T6dwj7rQXqvixi26QXOl6HeiUi5OVYhurQK
	v+2DNxZD3mmGj3ohiohjbE+5EDs29sLk=
X-Gm-Gg: AYBFou18MY8eDgQnue41FjOSizwDidw2cuf2VaIXOqQekn7gk2sAuMICGuG54rW60WW
	3+GmHeH+uIGaYnRCT//3hS8HOyeQ7raU6oPZF3CO1Zv/PcFjYLOGMKf8R761lF9QmndQ0r4yEc+
	jbjjIxxtCSi+Pm3mrDwj3ykon7BXc2ULxP/hiR07VDUZ2G+RZ5azzxvzowCNoYvLtEL6Vt8oJyh
	HaKGPhVubXqXIddf70AwbKk3QtFd1P84TVZCNr9Eg+rToESHPu5hDRrWIkKJPTX56ooCqlr+Orr
	k5PWHv5tdwEhN+UIwnRN7OBOlkt4YjAF57nr5VJF5QEWDZ2qSPKtTlZbz0D1YEgz+c5CtBc=
X-Received: by 2002:a05:6808:3084:b0:4e9:73ce:e2a5 with SMTP id
 5614622812f47-4f52aea9cd7mr11914029b6e.6.1791200200790; Mon, 05 Oct 2026
 04:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-netcons-fixes-v1-0-bb5ffe5e698a@gmail.com>
 <20260928-netcons-fixes-v1-1-bb5ffe5e698a@gmail.com> <ar51wR0vG6QL2egY@gmail.com>
In-Reply-To: <ar51wR0vG6QL2egY@gmail.com>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 5 Oct 2026 12:36:28 +0100
X-Gm-Features: AclHuK-Ind_gLUAUpXypTDGhx5aprFrQV_UWxhirAUIPDoPPuFVwYJtBGqXQ9z8
Message-ID: <CAGSyskVS_OqLXNeDyBbdCGghQqh7SLVUg1FHUC_vHgDKof4rnA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] netconsole: finish enabling the target
 before releasing RTNL
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matt Mackall <mpm@selenic.com>, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 4:03=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> On Mon, Sep 28, 2026 at 07:00:03PM +0100, Gustavo Luiz Duarte wrote:
> > netcons_netpoll_setup() publishes nt->np.dev inside __netpoll_setup(),
> > then releases the RTNL and waits for an RCU grace period before
> > returning. Only after that does its caller store STATE_ENABLED:
> >
> > A NETDEV_UNREGISTER event landing in that window tears the target down
> > and we end up storing STATE_ENABLED with a NULL np->dev, leading to a
> > null-ptr-deref in netconsole_write():
> >
> >   BUG: KASAN: null-ptr-deref in netconsole_write+0xb9/0x7f0
> >   Read of size 8 at addr 00000000000000a8 by task pr/netcon_ext0/135
> >    netconsole_write+0xb9/0x7f0
> >    nbcon_emit_next_record+0x501/0x550
> >    nbcon_emit_one+0x10e/0x170
> >    nbcon_kthread_func+0x2ff/0x3b0
> >    kthread+0x199/0x1e0
>
> Oh gosh. Thanks for hte fix.
>
> > Store STATE_ENABLED before dropping the RTNL lock to avoid racing with
> > netconsole_netdev_event().
> >
> > Fixes: 2382b15bcc39 ("netconsole: take care of NETDEV_UNREGISTER event"=
)
>
> This should go to `net` instead of netdev.

I was unsure whether to target net or net-next because these bugs
require root to be triggered.
I can resend it targeting net. I assume the same applies to patch 2/4,
so I will split 1,2 -> net and 3,4 -> net-next.

> >
> > @@ -552,13 +552,16 @@ static int netcons_netpoll_setup(struct netconsol=
e_target *nt)
> >       err =3D __netpoll_setup(np, ndev);
> >       if (err)
> >               goto put;
> > -     rtnl_unlock();
> >
> >       /* Make sure all NAPI polls which started before dev->npinfo
> >        * was visible have exited before we start calling NAPI poll.
> >        * NAPI skips locking if dev->npinfo is NULL.
> > +      * Hold RTNL until enable is finished so we don't race with
> > +      * netconsole_netdev_event()
> >        */
> > -     synchronize_rcu();
> > +     synchronize_net();
> > +     nt->state =3D STATE_ENABLED;
> > +     rtnl_unlock();
>
> Why do you need to synchornize-rcu with the RTNL held? Why not enabling
> nt->state, releasing the lock and than synchronizing RCU?

My understanding from the comment above is that we need to synchronize
RCU before allowing netconsole to start calling NAPI poll.
And (nt->state !=3D STATE_ENABLED) is what is currently blocking
netconsole_write() from calling NAPI poll.
So if we enable nt->state before synchronizing RCU, it would regress
the hang fixed in [1].

[1] https://patch.msgid.link/20250726010846.1105875-1-kuba@kernel.org
