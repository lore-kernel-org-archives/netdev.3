Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8183BAD91
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628318; cv=pass; b=UFAtX5FhZOGQ0HbGh4JWBc4xIa1xdNGaQ6YwsufNLmrk1ILMAN0SYgfFNdKETKvJIBvWODekEMUUi3r4OIFvdGiOjs1uvMNh0Ry+pdgLO3TpYZKV9/cm6R7pQhjgjCX0p7xPrVD/N7L2PHJZGaU/bV7SwvlXrfwuTM4UL7A6soA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628318; c=relaxed/simple;
	bh=exEDqOaxrRTmAcxNcCUFzqeg0z8yanawx20U+TDaoaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EU14ViAdm763HHh8l/N+jN2hpMvkjdt2DmOsmIaVu/86n2FWXVb0+DiceTRzzT0cimE7ZyyhfVwtz5bS0qC5MthJvmUfzNhtf1+x30dmwmd4zcTPyHOf2FLve2VddMyS1tCW1Hm+/7a98N0oA9uAUBBDMj/nl1XcN9Dy5lblvLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OegFmodI; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OegFmodI"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51bfa429aa6so38821211cf.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 03:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784628316; cv=none;
        d=google.com; s=arc-20260327;
        b=S2vVVHjKvaYwGEulCgapEkNB230QaEYz9UouEUKqnkV3ag+UOhMQ1UVaZbIh+tIloQ
         +txaetE5i8bfdW0SweIvl22pT5Zzuz+HXPxB4rYlapOVHfyCvTF1ZwuRdEeLi6bZgDKK
         27n6Mvg+DK8uR4lZ1+BQb7Q0WaI8mqP+P9KGKw49LRn3EgYeswHxCom6dCGFgYZYh5R+
         81Cj3cwzx/2XeAocvBsGGeL74+WrP1sPxpUcXRgRlOXUMMQg5H489Xjyjv9OdIfkQmXw
         fll2cLUguW9ds1X9DtMYy87wZ3we8tWpSEEvl1bxJnQVQdDHsNiQmjsu3V46jbuHWN+b
         FcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NPO59Q2dqTHSG96YUwELf+9FGgvMNgYXNDatHj27WPg=;
        fh=U4PTUYNCVN9R+mFbzEslLvLmKXVj4cmhCms7Pz78A9c=;
        b=C8T9XBjJOAHG2poUjP6AIcrUqWHfPqJT6G/+rP94S0c0f+CLqlge4xH5plwKvn42vr
         oR8NzoqvV+JPigwQ8l/yTLILZMFd09xhaxTUfq8bZJIaYfhX0MP4z5eOTWSgI6P/xkxz
         4p0kSkIGM+MY0HlfcQaazhssLgTjYWqFyUYwCW57It5nJKWxpGTO9vPm469o5vCWXWao
         Te1DA0aRBsgSELNp7APDTcXvPV4uKW0dQR4ouz6l+CZ0/H11deYNA+JHSGozNawL57bi
         Y/lRz+onrZHia5d6yyb32/XMbtQU+ZNhs1pcduA3U2ta5q1Yf3xtpdZM49e3MNEnhWCo
         xxHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784628316; x=1785233116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NPO59Q2dqTHSG96YUwELf+9FGgvMNgYXNDatHj27WPg=;
        b=OegFmodI4JMM9+S+oeCIyX3F0akmLWyowD7OQOeggtgish36PbXd/NXjXl0pXX9FWi
         ZA4PGUJWe497SZFeBzBk3Ya8Bc2jw/WC0cHQVER7msoGWmFoElgM09vXSyDoUMpTrj+6
         ghewufCrigBxn8Z0B7XNK05oXFwybnOcZwLGoLCtuIB7T90sLI5SGkM0TpdSyYexEBqQ
         d3o6eCFpjz+5eZ30KWpsq1XsgOg/cQoj/cc8iKLT7YI3ZFchYVaoej2nO5An8QNMCnBj
         G/eGKsQh0b1O0p7xIuyu3LB3u2M9BTm0V5kvBbyuuSWMhzOaN8Olf2cWrDrS5WuLWAXN
         v3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784628316; x=1785233116;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NPO59Q2dqTHSG96YUwELf+9FGgvMNgYXNDatHj27WPg=;
        b=YydrwIQtLd8/Mnfy+72iqg4t6HsAnRElRvoZ89gCvQh/E9XNjaGOlZPF0VVp1lMR6g
         4Drtj0xlYLTNQjheADl80pwGuxhKq07pwrcHgl3vGVn8UOFWHrlOBQGbNrrEIWQ3b94X
         FyDF3ZSs9iQoXIhu50l3pYYdapGNIieDoD1bWjiMmgbKrCgSMT+rYZYyPfb1pcWN6o6I
         1FIkuIUXQktYc7NhImzvd+Xolf/Vus//x+6W11YHmpUlhuSnWycJgxdXOJeJ8Sm/daP9
         WxMGCOLlW0V387UP97AzRzzE0t7Fq7WqKN/nbNssxnxyU6BXYLqzps4j42iiO+Mcqecu
         PEqw==
X-Forwarded-Encrypted: i=1; AHgh+RocMFLu6UKoXxSOOUJO9hLSF4j1of46+nH4Md5+ARoTeS2mVUweoJevcrS78lV59pgOS+SSqys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+EVxtYC7KcuGkSfY3Fdc7ghrMuBBbyLkyB8nZqESuAezuLoJH
	Ds/Yqt8p9UZfz685peapB0hwHljwe+2M/B1S3b2nPzGyAduQqw2Bg1I9HQxGpDwtcuzt2mHluLs
	J8IbG9XXcEZmHYs22WDgxxZtNXQgoPEsKz+hxkFoB
X-Gm-Gg: AfdE7cnfZsbrm/9/QLvUZLCbxVzHpOina6VAvTcDHehAaFkVSGjS6GrQsr6zBV72yH0
	yg690VTEXkzhOjt+P0TiOow6Cd77iTHw+FQo9eRy/fM+M1C80oxJ96KXCXd1lBrl1i/D1UagLcs
	lf0BRbHVdVUWwbKYHJScLtv9zdf11QsweeG1iN3eyyHwC5mrWckt01hfsnCHLOkhrVrUlXtv4vt
	w5oCE+nLSDTXi/gQ0RJbd48/0yDlGn8ztwmsjQGELGWmlORgdNZt2KZJtIEIF7ExCXeoV5zsG7V
	07g73G1P8SBgChWZFTpNBHIDJQqRYmioPCtKJWGD6l2tWmPYPBFW0VyMIdZVVJLy0C4nIIirmg=
	=
X-Received: by 2002:a05:622a:549:b0:51c:7aa7:e0ed with SMTP id
 d75a77b69052e-5212c7fe928mr167277761cf.42.1784628314859; Tue, 21 Jul 2026
 03:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707082327.3238690-1-edumazet@google.com> <178406192459.16306.5204629050926533917.b4-review@b4>
 <20260720181259.4e5f976f@kernel.org> <0db18429-58f5-46de-8cb4-0a934ff4d650@redhat.com>
In-Reply-To: <0db18429-58f5-46de-8cb4-0a934ff4d650@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 21 Jul 2026 12:05:03 +0200
X-Gm-Features: AUfX_mwFGJ5JAsokH6MGYEbt5mFVajam4LXgp-otVit4d21T2InBoetVve54RKQ
Message-ID: <CANn89iKHQWQxiwCiSZGHyos5c15et60rQwX8rW1RqpPaY2ykZg@mail.gmail.com>
Subject: Re: [PATCH net] net: hsr: fix memory leak on slave unregistration by
 removing synced VLANs
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Fernando Fernandez Mancera <fmancera@suse.de>, 
	"David S . Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+456957213f32970c0762@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 10:59=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 7/21/26 3:12 AM, Jakub Kicinski wrote:
> > On Tue, 14 Jul 2026 22:45:24 +0200 Fernando Fernandez Mancera wrote:
> >>> When an HSR master device is brought UP, it auto-adds VLAN 0 via
> >>> vlan_vid0_add(), which propagates VID 0 to its slave devices.
> >>>
> >>> If a slave device is later unregistered while HSR is active (e.g., du=
ring
> >>> netns cleanup or interface destruction), hsr_del_port() is called to
> >>> detach the slave port from the HSR master. However, hsr_del_port() cu=
rrently
> >>> does not delete the VLAN IDs that were synced to the slave device by =
HSR.
> >>>
> >>> As a result, the slave device retains a refcount on VID 0 (and any ot=
her
> >>> synced VLANs). When the slave device is destroyed, its vlan_info /
> >>> vlan_vid_info structure remains allocated, leading to a memory leak.
> >>>
> >>> Fix this by calling vlan_vids_del_by_dev(port->dev, master->dev) in
> >>> hsr_del_port() before unlinking the slave device, matching the cleanu=
p
> >>> behavior in bonding and team drivers.
> >>>
> >>> Fixes: 1a8a63a5305e ("net: hsr: Add VLAN CTAG filter support")
> >>> Reported-by: syzbot+456957213f32970c0762@syzkaller.appspotmail.com
> >>> Closes: https://lore.kernel.org/netdev/6a4cb6ca.57639fcc.86d58.000b.G=
AE@google.com/T/#u
> >>> Signed-off-by: Eric Dumazet <edumazet@google.com>
> >>
> >> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> >
> > Just to confirm - is the sashiko review a false positive?
> > https://sashiko.dev/#/patchset/20260707082327.3238690-1-edumazet%40goog=
le.com
>
> I'm sorry, meanwhile PW archived the patch; a repost is needed.

In any case, I think Sashiko was right, I will send a V2 incorporating
their feedback.

Thanks!

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index d9af9e65f72f07b1997b80c85db16d812fbda488..01c73b4b50ddd89afa74defa37f=
a83d40c401cf8
100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -242,6 +242,8 @@ void hsr_del_port(struct hsr_port *port)
                netdev_rx_handler_unregister(port->dev);
                if (!port->hsr->fwd_offloaded)
                        dev_set_promiscuity(port->dev, -1);
+               if (port->type =3D=3D HSR_PT_SLAVE_A || port->type =3D=3D
HSR_PT_SLAVE_B)
+                       vlan_vids_del_by_dev(port->dev, master->dev);
                netdev_upper_dev_unlink(port->dev, master->dev);
                if (hsr->prot_version =3D=3D PRP_V1 &&
                    port->type =3D=3D HSR_PT_SLAVE_B) {
