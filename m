Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307024908B1
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901710; cv=pass; b=e5NJTXZhKfte3Q1dM0a8AOy3VdQLo3FsttsStee+VYVGVRALPuN39/jsdie3SqjupJngnqqwnozdw2YwviJKXImAnW9RQEdrjm51Q91an0FP9r3eXwKzDickKqGCteD2mMbDL+CQ8m1Vti0W7XCCnqSDKTJMCwg9Cn5F+BcWku4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901710; c=relaxed/simple;
	bh=RNkMswzXCUbZJSjcK7ZfMRGBh2bZqSqSROVIdTNj5DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luxSWXqCJ4bpLiEJ6WpGNzpIfq4EdXueCjZqQQzC6d87DkMeGuOc7FBUTm1l0kU3uskh/AgEwN3W1EqDefgyJ/AQhrhueAC/RMCTEXYLiO1qjzk7h7nugTlHDt73UPxc5e4j2EIsUlTzt6fMBHe4ETJhkGFLyfvpgjlmPXGTgvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTn0aHmr; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTn0aHmr"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bfa99f8ef8so1002499e0c.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784901708; cv=none;
        d=google.com; s=arc-20260327;
        b=VqKEy9p2eF5EFQHE9QhIGDJ9AoS+XK0keOkli7alWtNz7NUw2jWDaJPM6WZEk0iy2h
         KNp57+VR275h4gQJQQ06FTMfLmuul6v6JrVE7yOGlZbXEGopdkxh7Oz5dPP/12Yb92SE
         inBW3v3HCfFVlHUK3dCTjcJFtHJzAIx+GToOTUSlL1X1AdwzaedT41aLQtCNsKZxrhAQ
         +SFgJutfryYktopkPKAeR5/ixDTI1t7zKH7yR+6RQ43ZYqqL26pKruhXDBwVSZU+HB69
         EvlGOvKBWBxAhROEOW/lO21E7hj46366b+gyzfOwXzaKybWSN5AYgrS2sUkQuZgQxkfy
         TcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Erx/gjJX/HGhsfdLWkM39VnnaSw2LMfwn+KeNH3C3SE=;
        fh=91pP0r9ehyaiSu85ZB19CN+LiKMpy6so2WpPkLrPbgg=;
        b=DnSEnhJ6uy1LYqIQf3tKp8kYUiVFsAlvGDWSHEPMQm85YBepISIK8+NWT5hEGxtmtr
         TQaO7V2k3YXqxj9jQWzLVnfvsSPQZDUK+e07iqzpSl652TU0Q225ACtCpCsj2yBvm37n
         KJSfM1rHEybh/90GxaP8gouS92X7VzB1Smn0b66npB3Hl0ySdxwH/dZ7nwNM2Sy3ujby
         IttTBhMZllq/oxlCZQi74SId7drsjt+62p4Wfpy5Wipg3CVAH9ekoGrYR8P9inIpY4V4
         GcbVBfJFXDwL+OJXD0OxLeriO2T5pGGbfX2fT/xUwB30THhV+a8w03qVQVoUJZP2dO1F
         5Xog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784901708; x=1785506508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Erx/gjJX/HGhsfdLWkM39VnnaSw2LMfwn+KeNH3C3SE=;
        b=PTn0aHmr94cN3cw1fROy402Nh2Jy69Zt4n3YUOfz6AvokhB74LnwIuYmbtLi8M51Md
         VEqFA7gnwN0nJU5IPF9KSMNMFvrWowS9FmlyJZ7qmRIv06k06QvIg91byatgboSp28s+
         wuyoE/A0EkrVcdu5FLcGFLb3FcAaOxr2Kqa73KXOfvh+Hyb8O+GMvuDQzXufuqmvzxsv
         Mn5/OazA/Yg3NQAzMgjbQqEqFaMvrvrqnbTCYf6hjOLP/XY4E5G1ltobVoD6OrYpL+t0
         5GbcL6fni5mRNFTm9dwb2uVnoPghdz38nTwlUgYoxA/Ub+E6WVRVsBz1pKxuSEE5oNgX
         YZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784901708; x=1785506508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Erx/gjJX/HGhsfdLWkM39VnnaSw2LMfwn+KeNH3C3SE=;
        b=dANkvxxzGQ+krFHta8Kpz4Dsvx7Q4bdiYamID406z1Vzfw3A6MV7bSoQ+mcyuQwx3m
         hK1oOa54bF8bFtKYLh5Y3feqjpD7ZvcqvAtNNQWLIViJUFD5HqjC6bQoib18CXPaN9wu
         sj8fjXazOmcYBxDGLnGsthZH+9jvG43DWOfKiTX/DFq/jqcgcr4rYpjM0Uv45nj93OmF
         3UhSQdtOOO2Kz/B5nK0tkgL1TZXdvNGyCaTL2/UbNZyQUJzvufqNAYoRldVxQg6YrGAl
         uQO3+CuG/B83PLCmho7yZQqk9HxtxrjBT9kSi0yQZEBvwcq7quDqD+DbbVZ69oI7FpXZ
         SjEQ==
X-Forwarded-Encrypted: i=1; AHgh+RpxmdMhgrV4HWjMo6La5L2yse1hsghtDSYyqaS2R+dfgqO8wXUamxm0aothsqqct1rP4/S+mXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB1RuON3W/ybufz334CKX9mmrF0tk6KEtWteZAey43G4EFo1qr
	a3FM32X7iWCz3iOlTv4hmFRp4BZbpzdu3OL1aCnwlxg6vCV44dCRMUQHtxyG6llK0YWTd6dGhdD
	8BGhPaQ1nINnJQIwiPGft8/bk5e7MgG9FoQ==
X-Gm-Gg: AR+sD10DQmqnZ+ISjuR3tsDRvHgnW7ZkF61GVr3tF29nsWMHN1W1XeZKTtn2gfLglZt
	khAuAQm3s/t/NR3sawfPGwvRqXVoRHAAjF/q90B/TNnZWD1XFtxVUVTcfmGAu+JQt6pPlHLxbBy
	PbM1kW0PhGSwWQwuiQ41pwL2su5YTJvTg5EVTnP/4i+g4bnn9u6vjpvNXU2dGsV6hJb7x2fPlHw
	RREvIJYWktSgjd01B7p1N/J2dEIm05KIIecwi85/y7M9oshMAkYW9IsMpU=
X-Received: by 2002:a05:6122:180b:b0:5bd:8dd8:146e with SMTP id
 71dfb90a1353d-5c2fcccc3a1mr240867e0c.4.1784901707847; Fri, 24 Jul 2026
 07:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722090931.2637025-1-dnlplm@gmail.com> <20260722090931.2637025-3-dnlplm@gmail.com>
 <CAFEp6-2UiSja11A6nLKqRX8A1eE=P4euEs+fbpKZxPE8fTX2QQ@mail.gmail.com>
In-Reply-To: <CAFEp6-2UiSja11A6nLKqRX8A1eE=P4euEs+fbpKZxPE8fTX2QQ@mail.gmail.com>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Fri, 24 Jul 2026 16:01:36 +0200
X-Gm-Features: AUfX_my960aM3h0o9ZfprZhm3t5D8G8015RZ1Pel8tYqh1ypl4DaE4SHdcMFGp8
Message-ID: <CAGRyCJF5y4WE6OtA0HS73yZOVpi8GWe-6uQim3A9=uPz+3=veQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: wwan: add exclusive open mode
 capability to AT and QCDM ports
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Loic,

Il giorno mer 22 lug 2026 alle ore 11:41 Loic Poulain
<loic.poulain@oss.qualcomm.com> ha scritto:
>
> On Wed, Jul 22, 2026 at 11:10=E2=80=AFAM Daniele Palmas <dnlplm@gmail.com=
> wrote:
> >
> > Add exclusive open mode capability to AT and QCDM ports to improve
> > compatibility with user-space tools using the Qualcomm diagnostic
> > device (e.g. libqcdm).
> >
> > Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
> > ---
> >  drivers/net/wwan/wwan_core.c | 30 +++++++++++++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.=
c
> > index 8168239e52c3..8acb09dcb83a 100644
> > --- a/drivers/net/wwan/wwan_core.c
> > +++ b/drivers/net/wwan/wwan_core.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/termios.h>
> >  #include <linux/gnss.h>
> >  #include <linux/wwan.h>
> > +#include <linux/tty.h>
> >  #include <net/rtnetlink.h>
> >  #include <uapi/linux/wwan.h>
> >
> > @@ -79,7 +80,7 @@ struct wwan_device {
> >   * @data_lock: Port specific data access serialization
> >   * @headroom_len: SKB reserved headroom size
> >   * @frag_len: Length to fragment packet
> > - * @at_data: AT port specific data
> > + * @at_data: AT/QCDM port specific data
> >   * @gnss: Pointer to GNSS device associated with this port
> >   */
> >  struct wwan_port {
> > @@ -98,6 +99,7 @@ struct wwan_port {
> >                 struct {
> >                         struct ktermios termios;
> >                         int mdmbits;
> > +                       unsigned long flags;
> >                 } at_data;
> >                 struct gnss_device *gnss;
> >         };
> > @@ -748,6 +750,14 @@ static int wwan_port_op_start(struct wwan_port *po=
rt)
> >                 goto out_unlock;
> >         }
> >
> > +       /* Check exclusive open mode for AT and QCDM ports */
> > +       if ((port->type =3D=3D WWAN_PORT_AT || port->type =3D=3D WWAN_P=
ORT_QCDM) &&
> > +           test_bit(TTY_EXCLUSIVE, &port->at_data.flags) &&
> > +           !capable(CAP_SYS_ADMIN)) {
> > +               ret =3D -EBUSY;
> > +               goto out_unlock;
> > +       }
>
> I would recommend simplifying this by relying on the already existing
> wwan_port flag introducing a WWAN_PORT_EXCLUSIVE. This would also
> eliminate the need to check the port type in the condition above.
>

Thanks for the hint, I'm following-up with a simplified version.

Regards,
Daniele

> > +
> >         /* If port is already started, don't start again */
> >         if (!port->start_count)
> >                 ret =3D port->ops->start(port);
> > @@ -769,6 +779,8 @@ static void wwan_port_op_stop(struct wwan_port *por=
t)
> >                 if (port->ops)
> >                         port->ops->stop(port);
> >                 skb_queue_purge(&port->rxq);
> > +               if (port->type =3D=3D WWAN_PORT_AT || port->type =3D=3D=
 WWAN_PORT_QCDM)
> > +                       clear_bit(TTY_EXCLUSIVE, &port->at_data.flags);
> >         }
> >         mutex_unlock(&port->ops_lock);
> >  }
> > @@ -1031,6 +1043,22 @@ static long wwan_port_fops_at_ioctl(struct wwan_=
port *port, unsigned int cmd,
> >                 break;
> >         }
> >
> > +       case TIOCEXCL:
> > +               set_bit(TTY_EXCLUSIVE, &port->at_data.flags);
> > +               break;
> > +
> > +       case TIOCNXCL:
> > +               clear_bit(TTY_EXCLUSIVE, &port->at_data.flags);
> > +               break;
> > +
> > +       case TIOCGEXCL:
> > +       {
> > +               int excl =3D test_bit(TTY_EXCLUSIVE, &port->at_data.fla=
gs);
> > +
> > +               ret =3D put_user(excl, (int __user *)arg);
> > +               break;
> > +       }
> > +
> >         default:
> >                 ret =3D -ENOIOCTLCMD;
> >         }
> > --
> > 2.43.0
> >
