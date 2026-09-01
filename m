Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33C73B7777
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270356; cv=pass; b=S2UWOdnYOGtf+rRnLYO2+63A/9NOiGxnYLuHRzYCDvUrNqLOrkDns9NM/zyshK+TH/RsgDkWbJMoy4nP0J/IpdNX3Sb8/PHoR0hLK41mUiJJ062X0Aj9jjR8qKD2iAptYk27HAbKDgtmNHSAjlQtiRaPjIgJ2xbXc0dBNvO741M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270356; c=relaxed/simple;
	bh=tKDbMMYPaNcmLVO2tAPonX0ljJNkNnM7cJ7pRD/D8BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QORZqVuvYFloxqwFSm5UdTTEQ2wSrobpfk4hPiZNeOciPuzrJ4T1OAxNkYuqdNOJSrAKtUxwRrl4RheHwWmdLQ1TGx02s5zYoicpI/QuiBSlDXfZUrK+i+/RidNX9Vuyl90qfHJ/lVNwfbIToG/hgAGH03d8xM2HwSfw/84X6FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p19Ux4+A; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p19Ux4+A"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso856599b3a.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 06:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788270354; cv=none;
        d=google.com; s=arc-20260327;
        b=ckoAk5ywwQ31LqnS+YV7N3BFjgwtbjDMgSVh/ND6dOo4wQcy3h09GDJjPaU109wB/M
         AqwxmWMeFK7+rMODtFIXCS3mdEscp2UdDJblg+ehNZT5nQmf0oSNTDI449ZSwHUVSlzn
         bN4DnSgEn55+6h6GeNfutFCpKCpjQZoj2KJ/+NV2cORVetYWjj1jdvpZHrqsReyeW3eZ
         VSmyvHLjOHJXuOtJsvB53oclTnGG+WBq8SpLRkpX6M5chfIv6mTTeYMidqKpsOtR344l
         IRh3nsy/9mklurhff45Irbs4I2cMQVf5xnJiPespfoxfyj5Yy8D6Z24OZOZ3URsXbFQQ
         IgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2cbbAFC+L3aZiwOHrWcyMK0kiQRKZziM6pyyIH5XpR8=;
        fh=Zl/rBMihXqopjvbnniV4N4qJS5dxr1m4iSIQ8HgXM0o=;
        b=KcC3/dUHs7RfN9MLl9Wz7oBHO1pboOFty+Q6qSIS5UwMX9uzHk+e/8wF97jpu/sKu9
         RsRTHa6mOl5TtfolWBSMzfss6uw7jC554AglLVmeb+5Xe5JPNoSCXHNck6TXi8iO28KT
         AX47g2mGLQqs5pXe4+Dzue5ezOhVY1iJPcaP2S8Q4kPEpUj/ta54LSjwPqk3SoxvCO9L
         HBGw2+s0Vb7ie6qaHSmW+9fcsM+9nuHRHBAaKOUV1Tcig/b1AL2SlHroSyQJMzvA5K70
         3AaMCYdWytFAbdD2Kxnrj7RgggG4wvDaHCNk1rmQjWLzft/iXQ+N2rF7NFvRnRO4InCk
         A1+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788270354; x=1788875154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2cbbAFC+L3aZiwOHrWcyMK0kiQRKZziM6pyyIH5XpR8=;
        b=p19Ux4+AIz9zm+mK6ME3VWxsjulezrSOBl/G4hum6mIVNhfP1QBGtJLbO5WfDxlcCi
         OsWginCRDOkTt/Zpbw9B/QZzi5voytUVrzcv5Dwn0S0n1/AsOOYt5KinpdBDdcfPpfsV
         m2JVD0X3d0vhkbC4TwoRE3GRw9tnzbpBFDz9KueWtW+eE3TpAnDmsDO6uPMgs/cYv5mC
         2yatkeUmGi3pb8USsL1UtayNvzAuxc9+EDxi8ez+viuG/U5vDaF/COzlRbSH5B8agOKh
         9DR78R1vya7RMStOugohc/sf/RB/qN9zqZGQtPs6p2hs5l0skc7MMkbrnS4uq1KwWtI/
         TDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270354; x=1788875154;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cbbAFC+L3aZiwOHrWcyMK0kiQRKZziM6pyyIH5XpR8=;
        b=Mk3MFCplqlMH+DSaA4YGcDm27G50dSc3fomSGnqPhQgknKhFo8xEmYuJ4A/HwitG6t
         PzPhz3BZWMTB8VBZrowaUKEhlCN4zu61IGBXXqfRBHIXkliqv71/PBvdY4POmVrDTq/K
         2OzlcRf4mjoPK2eOZ0xLOo0Dt9SusPebOTd85PLPtCnQ9xAGSIpZjtHnafkSjbSSjIY1
         9gMbtcf9ed0Ey2foiGg5eiBdgqtqa8Cz04rjdPrDrVE9A8LqqsfG9pCZH/nBVc5Fhlcx
         96EprfQPHiAlqg0h71S/qugMdq9R1kfzThihGY6Ysll1pF83zPzm8yJHk0CLZcNvsxKK
         lMhA==
X-Forwarded-Encrypted: i=1; AHgh+RrNyR63+rnzDfCWNzrauGSzw5ic70686klnM2OhVTEu9SfmJ3RLbCzET0iqC7+qdBQEzM8EJwE=@vger.kernel.org
X-Gm-Message-State: AFuF++kcp10z8jOkyIm0fTtFGGbsdPQ+ADXtbeRbOzyvD8A94Co4fFkv
	/12o8/j46QOhlp/S6R3HpEFSPyjmLNowurc8RKiH4NypTaY9UzBVy1nDnIgZxbV/GoqOWs0/6K0
	Qp2690YVFbvFBZ7hvIU/HoeIQ7frfnpg=
X-Gm-Gg: AR+sD112BbUa61FvqvVdI+C/sPxqa0LhRiUuDE2xXYOvjCgxehOaO/OcAM7nUDwpf6r
	e9HHmPam1tZNAxZltAsovZ00HGKB1dPHgxVypwfKzl+o3DEYQaoqyOQmOJxhD6fiztuyPOa9EIK
	0wbh4o1enF7gW0UrZwkA1HyarssmstGFglRVhOvgPQkl+RVJIYxcUdW0/ITz486lUzHq7tg9kIw
	P2YWnbMEIh1VO4d+iDs31vzzZwMl8oMupReDyQTALs8IsFfm+3zXgWBHIUYSkydBR6GHHBGvB7R
	Ocxo5JsSn+Ujz8P0vwHUhlEIE52Dr041c21TJGhWdiqTVFnUWDAjkITX9pOjZo3QBJMf9UgWcWd
	cy54iChGJ04mDDvVa4rwWjxUA9C5p2dhIFhl7aijQLFtN
X-Received: by 2002:a05:6a00:f94:b0:857:7317:cff4 with SMTP id
 d2e1a72fcca58-8577317d1bcmr39805907b3a.21.1788270354048; Tue, 01 Sep 2026
 06:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a7d8773.c5ad36c8.12f49d.002e.GAE@google.com> <68cb4941-3668-44f1-a889-6b2f023b2a08@h-partners.com>
In-Reply-To: <68cb4941-3668-44f1-a889-6b2f023b2a08@h-partners.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 1 Sep 2026 09:45:42 -0400
X-Gm-Features: AcwNN1WwADgnUO1qZ-igRAeF08FDzlcxT49ayOLVDUIzmVUCK8ZfNwVQ9ZdAm-c
Message-ID: <CADvbK_eY4S1HbdNHuNq9b=Va-TA_6rNFvnCvtOUZ0sF-AWN67A@mail.gmail.com>
Subject: Re: [syzbot] [sctp?] WARNING: refcount bug in sctp_transport_put (6)
To: xietangxin <xietangxin@h-partners.com>
Cc: syzbot+80dfcb1a2235b3efc877@syzkaller.appspotmail.com, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, marcelo.leitner@gmail.com, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, gaoxingwang <gaoxingwang1@huawei.com>, 
	huyizhen2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 11:47=E2=80=AFPM xietangxin <xietangxin@h-partners.=
com> wrote:
>
> Hi,
>
> I have analyzed this issue and successfully reproduced locally.
> The race occurs between the timer callback (`sctp_generate_heartbeat_even=
t`) and
> the transport cleanup path (`sctp_transport_free`):
>
> Task 1(Timer Softirq)               Task 2(sctp_transport_free)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D              =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> sctp_generate_heartbeat_event()
>   refcnt =3D 2
>
>   bh_lock_sock(sk)
>   sock_owned_by_user(sk)
>   mod_timer(&hb_timer) -> returns 0
>                                           sctp_transport_free()
>                                             transport->dead =3D 1
>                                             del_timer(&hb_timer) -> retur=
ns 1!
>                                               sctp_transport_put() (2 -> =
1)
>                                             sctp_transport_put() (1 -> 0)
>                                               sctp_transport_destroy()
>
>   sctp_transport_hold()
>     -> refcnt is 0, increment fails

This should not be 0, as the transport must hold a refcnt to start the
hb_timer.

Also, the delay below is under bh_lock_sock(), so it should not be the
real cause of the issue.

Could you share the PoC for this issue?

Thanks.

>   out_unlock:
>     sctp_transport_put() (0 -> -1)
>     -> refcount underflow warning!
>
>
>
> Adding a small delay  after `mod_timer()` increases the reproduction rate=
:
>
> --- a/net/sctp/sm_sideeffect.c
> +++ b/net/sctp/sm_sideeffect.c
> @@ -373,8 +373,10 @@ void sctp_generate_heartbeat_event(struct timer_list=
 *t)
>                 pr_debug("%s: sock is busy\n", __func__);
>
>                 /* Try again later.  */
> -               if (!mod_timer(&transport->hb_timer, jiffies + (HZ/20)))
> +               if (!mod_timer(&transport->hb_timer, jiffies + (HZ/20))) =
{
> +                       mdelay(1);
>                         sctp_transport_hold(transport);
> +               }
>                 goto out_unlock;
>         }
>
> Any feedback or guidance would be greatly appreciated.
>
> --
> Best regards,
> Tangxin Xie
>
