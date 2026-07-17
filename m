Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58703ABD95
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784269728; cv=pass; b=P1WhnpesGaenrlyX3grcCAF04bWW1X5vlHcz5PrbNO/wWYMXaQ3xRJTCwdgD/e/ANkDWDEq2ksZsx8pZlAEt4QSRUz+VNvck3fKKGOw9NhDunw2nbaSxww/NFShhIdrMOfBRGlpS0YgvAxz9fuyT0FeRnUqcrhyrgvtI6RYszUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784269728; c=relaxed/simple;
	bh=bhRgODpHz+FKT0ULr5bfkIJQG5tlEx/n40to0ZYuwaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqTEREgdqjSQvzD0ol1jVOD0lVadFOhRJ7CLWzhAEriVTf94LS7u1djQtCVN2lkmFwQ/Izk6f6I0ph0SAAe5rsRy+GTypl2QY11+qhukHkGYtv5LLe0y5xmUc36CbEeVRCiJrLA38QHI/ae0IJIYVAsymIrVc1/N0VlomuagYS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIPRUvrD; arc=pass smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIPRUvrD"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c15be3ef521so85571266b.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 23:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784269725; cv=none;
        d=google.com; s=arc-20260327;
        b=qu6fXKBtgfB2n7RxpqOAGR/bEam/w/xmrupaqhyU70alfqUaKFbK0PU7yAX3h8iRrK
         Tu9oriprCHgFtbDck/0tj7UBCCeoiKKzGtyHRfEem0+RiRFgdSIsZHu7uw6siyK4XIrB
         MnzbQCIkHC9tz9y7jm/L4OPVB59QyXkQP1ZPyevYuseJMPZVkMOGUbvU8P9Shk0rRElB
         dqzNeLXDGs5gyfpunAWA8cBKCkK48hM6mujhnQNA92H20DdvIjfcz8SstWWZ0hzrMnsX
         AbRecmexXGXooEpKR/2q0CitP/2TdQdlZz00id/XNw/qXjhr5HxjoHK3xzZ1f2Wl/h7y
         ddAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YHiP6evwjPbQqK8L1EQutQLTUMUz7gccfKbMReIBbck=;
        fh=xk5m47Mki2yVxx8HqbyWGNb3W7Iqa/HNLgXZqnVQaDU=;
        b=SjrBsu7C2EcEa9WfVYtf69U94U0RNfUOFK9hpXx7rVJbqUeDiyxoySpyJ4A1bPYjtw
         Ki0svp5ldJxWo0G024jE9uFspI60hEaklMoFSdn+IE8XVoaKRAczgTaF/qp4cDSrQm2Y
         9BAAeIpVHmwmk0uNyTnzUVuE9DzPin7CFHIeKb9Jj2cjDpJsfUVaG3xk0oxI5d9rC6yM
         LlvSShzsi5kdeaW7k+F/s4DD7ZZHNILdEwT+asylBoFhnxG5qO3nVHw4yZsY9q6QUXBO
         4eLgWXrRJ+//4Ck7V56T0idX6OLiQpZOV3fgWuOFv6VC54qz/LvU/CoKiEEZZqQHtjWc
         i28g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784269725; x=1784874525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YHiP6evwjPbQqK8L1EQutQLTUMUz7gccfKbMReIBbck=;
        b=dIPRUvrDMeow4KC2lew6MhHrPpECEFpTuYNDm3MGDg+WAmwgu/Bwa6e3eP1H7R18ZN
         5Gl0t6w+V5eHQjPR7KpJ1eGmDDm//FZ7jyoCCI4qOw0zknK+R+2vCVoOHWbCFN6I0Wv3
         uOvUmM9y58g8GfqaQLCSZj+F232jpJGTVxCT1rA9x3uHnr5S8EYHQVRsOf4oWlmtzuoT
         ukfOHL/bIv71VX28QmI9xWJXHfq522R60jfGVPs9FTPugBoZnIauy8RjZ8utQL6zJxIi
         4hexyzzH8e9be3cs11OH4aIRI3kijnfheXzEL2pFPUABemUERiHVssRUBQqCy9CAwO5x
         iAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784269725; x=1784874525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YHiP6evwjPbQqK8L1EQutQLTUMUz7gccfKbMReIBbck=;
        b=o2R4Jjpn0l7X6LxNBA+niCu+vZ9KYikrQt4gVxVVV3rzti0vjN0taO5lndr8JAiQWs
         tVCr9uuSOfZyzkzXdDD6OupBUfTvwlA7gXEOsAkke3vDUvq1HAM5/mSMOHkTNl2fuH44
         ZmOGn/WubmFZY2ytjT+ie+s5WdONKVxUyPbUP8EkqjsG8MJMNC3O599n/GnhRMtyFhFA
         gH5pUgfcJLPR9LYG6ajGu6z33OJMKsCD4FU+yJcGuXvuwgoPnkXnOFH6DW0WztneihzN
         lUezdBsEhSFy4I9YyEx6F2Xd7x0l55lDNLnZh2s8U/vmt2K+qiJV1u/JXuhQ//T7x8kQ
         pUBA==
X-Forwarded-Encrypted: i=1; AHgh+Rrnidql4S29wn4F7Age0Rd9zW++fN+8OW1pgRt+VuK0r3/84o+i2R71WuYFssuX4TodsVWhG2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyUYzBUX69HTdyt5/n+NueUy8M6YiN9Q65bkyTwxPcUSPApX+p
	vKneYbqoMtAbj8EvnJ+/xCmqTTMyvvQM45O1AtbzlFqGknEpFHn6MTExnhblIfa/bfUZpHGHbu1
	OOL8IieDBgOI2wE9yOGGB50p7lf2axfw=
X-Gm-Gg: AfdE7cl/0vU/ry/ZV4I68KnOQlD5BeEjhvb9BKB1MhAUft7j5lk6pEpvp1g9o6RAwks
	ujiclFLp/VwtfK9C4nAl2ODJXwX2ym41nbD4XtCO94uD1wkbWjrohy/2BrPn45x/02TwIfaaPUJ
	qMwH/oPjkjdyzAhXNdcjzoRH1gLrZdYICmsRWzfN+3OBhlu9ecgBijq0BB4i9tqHOuY8Pc+oLJx
	+aUjI+xQgT0dqitOwnUqyJ5dCVG8c1s/CQEtkJQBodObQsE2zkyQV04dsA4RBWV
X-Received: by 2002:a17:907:c248:b0:c0d:7c31:26a9 with SMTP id
 a640c23a62f3a-c16b4002edbmr59028266b.2.1784269724589; Thu, 16 Jul 2026
 23:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714191341.690906-1-coiaprant@gmail.com> <20260714191341.690906-7-coiaprant@gmail.com>
 <464cbdf3-2e9e-43ea-b30a-75b3d1b8a188@lunn.ch> <CALj3r0jdkDEjpO+7NOTGs+wgukKvD=fzFn4ewpurxxPswCE5GA@mail.gmail.com>
 <000c01dd1593$2ac0b0f0$804212d0$@trustnetic.com>
In-Reply-To: <000c01dd1593$2ac0b0f0$804212d0$@trustnetic.com>
From: Coia Prant <coiaprant@gmail.com>
Date: Fri, 17 Jul 2026 14:28:33 +0800
X-Gm-Features: AUfX_myHBcwddy6Oo5pOOK0tb7eS6ZkIgRUXXggid3ZrYcHNKgmGXLOcuUDQTlg
Message-ID: <CALj3r0hH=mF+8oVbisoECYo6HRuSdfSt_nuhFunHowyPsw2srQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/10] net: pcs: xpcs: improve SGMII AN state handling
 for Rockchip RK3568
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: Andrew Lunn <andrew@lunn.ch>, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	robh@kernel.org, krzk+dt@kernel.org, heiko@sntech.de, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
	Mengyuan Lou <mengyuanlou@net-swift.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jiawen Wu <jiawenwu@trustnetic.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=BA=94 10:23=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jul 15, 2026 7:05 AM, Coia Prant wrote:
> > Andrew Lunn <andrew@lunn.ch> =E4=BA=8E2026=E5=B9=B47=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=B8=89 06:44=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Wed, Jul 15, 2026 at 03:08:34AM +0800, Coia Prant wrote:
> > > > Commit 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII =
mode")
> > >
> > > You do not appear to Cc: the Wangxun NIC people. It would be good to
> > > have there comments on this change.
> >
> > I apologize; the output from get_maintainer.pl is very long. I=E2=80=99=
ve
> > heard that having too many recipients can cause the PATCH to be
> > rejected by the LKML mail server.
> >
> > I have added Wangxun maintainer (Jiawen Wu <jiawenwu@trustnetic.com>
> > and Mengyuan Lou <mengyuanlou@net-swift.com>) to the CC list.
> >
> > > > Fixes: 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII =
mode")
> > > > Signed-off-by: Coia Prant <coiaprant@gmail.com>
> > >
> > > Please don't mix fixed and new code. Is this a real fix? Should it be
> > > back ported to stable?
> >
> > I am not sure if this is a specific characteristic of Wangxun NICs, as
> > I do not have any available for testing.
> >
> > The behavior of the Rockchip DW XPCS IP core matches what is described
> > in the commit message (even though phylink brings the link to down
> > based on the phydev link status).
> >
> > This appears to be a bug (at least on Rockchip platforms) or Wangxun
> > NICs features.
> >
> > However, I cannot confirm whether Wangxun NICs behave the same way.
> > Therefore, I have kept their code as is for now.
> >
> > Could a Wangxun NICs maintainer provide some feedback based on testing?
> >
> > If we can confirm that this is indeed a bug, I can submit a separate fi=
x.
> >
> > I would greatly appreciate it.
> >
> > Thanks.
>
> Hi Coia,
>
> I have tested this patch and it works on Wangxun NICs, thanks.
>
> The commit 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII mo=
de")
> is too long ago for me to recall exactly what that thought was.
>
> The log shows:
>
> "On this device, CL37_ANSGM_STS (bit[4:1] of VR_MII_AN_INTR_STS) indicate=
s
> the status received from remote link during the auto-negotiation, and
> self-clear after the auto-negotiation is complete.
> Meanwhile, CL37_ANCMPLT_INTR will be set to 1, to indicate CL37 AN is
> complete. So add another way to get the state for CL37 SGMII."
>
> I tried to reproduce this issue, but it didn't seem to exist.
> In the current logic:
>
> link up -> read status from CL37_ANSGM_STS -> CL37_ANCMPLT_INTR not clear
> link down -> read status from BMCR -> CL37_ANCMPLT_INTR clear
>
> It also works, although CL37_ANCMPLT_INTR is not cleared every time, and =
AN
> restart is absent. But BMCR looks like it only wants to be return as 0, i=
t is
> weird.
>
> So I think Wangxun NICs also can be applied to general code as well, for
> getting state in C37 SGMII mode.

Hi Jiawen,

Thanks so much for testing and confirming that the patch works on Wangxun
NICs. That's a huge relief.

You're right to ask about the CL37_ANCMPLT_INTR clear and ANRESTART. Let
me explain what I observed on RK3568.

The key difference is that on RK3568's XPCS, we're working in the MAC
side (TX_CONFIG =3D 0), whereas on Wangxun it seems you're in the PHY side
(TX_CONFIG =3D 1). This is based on the commit 2a22b7ae2fa3 where you set
TX_CONFIG =3D 1.

> However, I am wondering whether CL37_ANCMPLT_INTR clear and ANRESTART are
> necessary.

On the RK3568 (MAC side), according to the DesignWare XPCS TRM, the
hardware behavior is as follows:

- After a software reset (BMCR_RESET), ANENABLE is automatically set to 1
  (the hardware reset value). So auto-negotiation starts automatically.

- When the link is up, CL37_ANSGM_STS contains the negotiated speed/duplex
  and the link status.

- When the link goes down, CL37_ANSGM_STS becomes all zero, but
  CL37_ANCMPLT_INTR remains set to 1.

- Crucially, the PCS does **not** automatically restart AN when the link
  comes back up. Without an explicit ANRESTART, the link stays down
  forever.

So on RK3568, the ANRESTART is mandatory to recover from a link-down
event. Without it, the link never comes back up after a cable disconnect.

In my current logic:

1. If CL37_ANSGM_STS has valid speed/duplex bits, report the link as up
   and return.

2. If CL37_ANSGM_STS is zero but CL37_ANCMPLT_INTR is set, the link is
   down. We clear the interrupt and issue an ANRESTART to start a new
   negotiation.

This works reliably on RK3568 in SGMII MAC side mode.

Since you confirmed that the general code path also works on Wangxun, I
wonder: does the ANRESTART also work on your side? If yes, perhaps we can
make this the common path for all hardware, not just RK3568.

If you can test the ANRESTART logic on Wangxun and it works, I'd be happy
to submit a standalone fix that makes this the common code path.

Otherwise, the current approach (skipping the ANRESTART trigger on
Wangxun NICs in c37_sgmii_get_state) remains safe.

If you're comfortable with the change, I'd appreciate it if you could add
your Tested-by tag to the commit. I'll also make sure to include you on
the CC list for any future revisions or related fixes.

Thanks again for testing!
