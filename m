Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B03B71D8
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273333; cv=none; b=eosQM7obV4jcbK2WehLfjDCJ+ruUK2Xne11aaDXGfpKvhldjqPQHLa0Gr4MYM02+ucEBJk3dzUtBEQYxQhp3zlFyQO+Pkz/dwVGwE3LWvr/EPFZ/gRKAKltiTw1SmkUoW8amYetWLjWcY3xnINIVud8hxondla2K1fElhjlex0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273333; c=relaxed/simple;
	bh=337HFZz+bQ1i1VtRCTa9268AZ4iIQczmq7C/N3wjRoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1mntB8kbTGgpSQvQ++CNJQ37EmOETqscs1ovkf+ALuKJ2+LoRgQBr/p2zxr+CRWLep/Tm1bGs+7kYUpby2Wqg26EInwSKKPyYQ/Xm9Bb5BsdiDKYrcfEAJgdjWXO47MkRfW86jXWCb6BHos9OyBwaqRwzEqChY7y66rLHl2HSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWvQhX+d; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWvQhX+d"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so10846335e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788273329; x=1788878129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ybO/GPr2/hJm9IOXOpb1c3apJ1A9Dmdvx+NqcPUdbWE=;
        b=kWvQhX+dm20cmZd71GlJ/SNjjr3GJDQkseI+JaUXyAf7sVmjLhE3I1W52hu97/ySnG
         iCjRgN9vpxrUu08I+UZTPtOynKtoehoV/CL1TH8hk5ksOXA6LwYmgf/4sB7O2IPPSNej
         UwVnolzIqKyYotsMdigsxjnu2ooMO/wV9riEmKDuGKMF42xSoQqEPNqn10Xg8K6lAUyU
         8yjVnBZ7ywHY9l8kwv023ziAOMJ2ffcJ9wbVRdsP0K+uKasl1MBvyk79mwGUvz57ZljP
         TQ1hioEe1lwnR6YbIz+zpjR057pJmYUbSC58RAGjixZ1Wyl9iZMlwf3y9qwE3R+R8iU6
         gFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273329; x=1788878129;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ybO/GPr2/hJm9IOXOpb1c3apJ1A9Dmdvx+NqcPUdbWE=;
        b=VmSKs+fVniVqyRhsclv7sF38VEIDEcbH2oUXJfdLtoGPQqg5U/OgOls8yx5FlNdqrB
         BqfasC0n0LMz3Xj8/RX3vVOWXXu4zyvchOsJZ0jzV1GxekrWgtmfBPFDUvtudsT1qcPm
         VJb9dUTXnSjfd5+76Jb+vNpSUrR4irKYNsoSZTI20DvSl6YY7TIAufBIxLOpp87UTY77
         N/JLWeIyzFp10DJx2WnZQLECm24TPkl7KCoSo70j3BlfPK2qSTIeV7+//Bx0cjPunSO9
         vbIhkGnVAErejIp5eklfvsdFT+vUylb86NwGgTyx6g//qFLyXvOHGhSj7E48PAjMHQJK
         KAXw==
X-Forwarded-Encrypted: i=1; AHgh+RoGIAarIDkPV9PDkIC42HdtyJ1SKSkOwhvd0Puo+G40JvAn3fDBsukuV0ts+hC+Vu0n+hQFHMI=@vger.kernel.org
X-Gm-Message-State: AFuF++kwxLfKxwZ1mmA9A3lKy0YunDH7oWhv3980sjgXwl6RYPq0jXPA
	qa9MqC0mYdOC5jbbA3CjUj61ibzCGfAuEbqQK08W7bIJivgphVpHNZXf
X-Gm-Gg: AR+sD12St+OL5/UMMnElQ2MAQOTaJ4dpUNqH3d9S5OPdVUeIw5CYpl+iQfKoxUByK2q
	3oeS5koXrbMZMcFCOS7w22Bx5ukB/lNoMHc/5U0qpp569PoQyjN4r10Kk4JX+pBzzQBlYzvOiUw
	ity/i4f2hRxnRCDO082wb+HBBx9P6yRFMVHOsCXoJR/MZBQBSQO64kbW/oiMWeMxoEViG78v+3S
	SiMIHEoUTTcN1fiFvwfJEGLMZ1xFtnIeaHaybyZJ+lIW7fhgmidnSGeBTJeGb81tmZSjI6Xd5eH
	4iWzPM1FcDCUiGuv/fkvA22/EpveifByiT1/kUlXcwZULxTUHjP4fSDOQPr5V9QMBLqWfNfwy8c
	8sR7R/uttukIJXz6vqvRr8aIcymvZxt9uMM7oU/JXpHmyfX6t3OY0OpAaZJJcKUZuM1zTPwEGEI
	M19tApIPv3/9LrAzGcDR/v/Xt705SYcpTj8DZx5eZwMEyhP/Hxd8IFZN00wtup+Uwkhyk75HbJM
	hCiunwaHnWoNQeSeCyVZOLA6g==
X-Received: by 2002:a05:600c:1d1d:b0:49b:d45:703e with SMTP id 5b1f17b1804b1-49b91c2dfecmr525571945e9.8.1788273329280;
        Tue, 01 Sep 2026 07:35:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b926874fdsm360366475e9.4.2026.09.01.07.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:35:28 -0700 (PDT)
Date: Tue, 1 Sep 2026 15:35:24 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: xietangxin <xietangxin@h-partners.com>,
 syzbot+80dfcb1a2235b3efc877@syzkaller.appspotmail.com, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 marcelo.leitner@gmail.com, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, gaoxingwang
 <gaoxingwang1@huawei.com>, huyizhen2@huawei.com
Subject: Re: [syzbot] [sctp?] WARNING: refcount bug in sctp_transport_put
 (6)
Message-ID: <20260901153524.3e92df3a@pumpkin>
In-Reply-To: <CADvbK_eY4S1HbdNHuNq9b=Va-TA_6rNFvnCvtOUZ0sF-AWN67A@mail.gmail.com>
References: <6a7d8773.c5ad36c8.12f49d.002e.GAE@google.com>
	<68cb4941-3668-44f1-a889-6b2f023b2a08@h-partners.com>
	<CADvbK_eY4S1HbdNHuNq9b=Va-TA_6rNFvnCvtOUZ0sF-AWN67A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Sep 2026 09:45:42 -0400
Xin Long <lucien.xin@gmail.com> wrote:

> On Mon, Aug 31, 2026 at 11:47=E2=80=AFPM xietangxin <xietangxin@h-partner=
s.com> wrote:
> >
> > Hi,
> >
> > I have analyzed this issue and successfully reproduced locally.
> > The race occurs between the timer callback (`sctp_generate_heartbeat_ev=
ent`) and
> > the transport cleanup path (`sctp_transport_free`):
> >
> > Task 1(Timer Softirq)               Task 2(sctp_transport_free)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D              =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > sctp_generate_heartbeat_event()
> >   refcnt =3D 2
> >
> >   bh_lock_sock(sk)
> >   sock_owned_by_user(sk)
> >   mod_timer(&hb_timer) -> returns 0
> >                                           sctp_transport_free()
> >                                             transport->dead =3D 1
> >                                             del_timer(&hb_timer) -> ret=
urns 1!
> >                                               sctp_transport_put() (2 -=
> 1)
> >                                             sctp_transport_put() (1 -> =
0)
> >                                               sctp_transport_destroy()
> >
> >   sctp_transport_hold() =20
> >     -> refcnt is 0, increment fails =20
>=20
> This should not be 0, as the transport must hold a refcnt to start the
> hb_timer.

Isn't there one hold sctp_generate_heartbeat_event() and a second for
whatever 'task 2' is doing.
When hb_timer is started it is given another hold (does it actually need on=
e??).
So when hb_timer is deleted it's hold is removed.
But the del_timer() is happening before the the extra hold is obtained.

The RHS (task 2) would need to hold bh_lock_sock().

Try giving sctp_generate_heartbeat_event() two holds.

David


>=20
> Also, the delay below is under bh_lock_sock(), so it should not be the
> real cause of the issue.
>=20
> Could you share the PoC for this issue?
>=20
> Thanks.
>=20
> >   out_unlock:
> >     sctp_transport_put() (0 -> -1) =20
> >     -> refcount underflow warning! =20
> >
> >
> >
> > Adding a small delay  after `mod_timer()` increases the reproduction ra=
te:
> >
> > --- a/net/sctp/sm_sideeffect.c
> > +++ b/net/sctp/sm_sideeffect.c
> > @@ -373,8 +373,10 @@ void sctp_generate_heartbeat_event(struct timer_li=
st *t)
> >                 pr_debug("%s: sock is busy\n", __func__);
> >
> >                 /* Try again later.  */
> > -               if (!mod_timer(&transport->hb_timer, jiffies + (HZ/20)))
> > +               if (!mod_timer(&transport->hb_timer, jiffies + (HZ/20))=
) {
> > +                       mdelay(1);
> >                         sctp_transport_hold(transport);
> > +               }
> >                 goto out_unlock;
> >         }
> >
> > Any feedback or guidance would be greatly appreciated.
> >
> > --
> > Best regards,
> > Tangxin Xie
> > =20
>=20

