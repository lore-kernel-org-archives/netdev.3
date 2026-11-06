Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793984074;
	b=JjLtFNrJut1byMrsl00tkjsQ/rj2/0zsrJ/uw21aoii48AV9c3220UNB3fJEjqpPZedz
	 3VzOVBipJ1n2Zj/L5CepV2e+WykT8gWBD0nA8JsBZh5l9bBWLvAWb7JqDzYFbvBufkoCL
	 jFjGBxXWPW60a8M5RD7e5f8QlixiHYeNj72ge/8H/3JQnwvRPUdR6caqcK7fWIRsvAqb6
	 rtLWDQV1CTrC77+ljkPjS6PU61wgqnhOtiKfqauoZy1+n96dKKlRw49jZmqskzBwzh5HH
	 TWo4l3b2tkmuzKaMIp/clFyt8ukL+gWKoFSRNa6YltZKrv06Zj8Td3OtII2lBJkES5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dkFzuHJuzHv5RFwHabaXe83i/n2wBUC3b7ZSZTt+kHU=;
	b=vawqslPA8/H55Uc2c75x1roOQe8jfLLDK0YflsfL03HnuHUnFMLGyEUEC2x+WAqFOgIY
	 5v8DG4cyfFNJMersrUS+WOIH14/wxgNKgXZnND5FSpABtlbrFlW6s1mMy9gDVIwTSU6WJ
	 clpeVhlfpL+9BDxdD7sO4bAyds1B6oQfUzr4kvNq8FG41H2khSv0at8WDwVN3mbn1MhEp
	 q9n3Rqup2dqvkUm607W0z8SwKBplBqLgwxmzvKSGVopT8anWacFWKxTsHVustNZjMeymJ
	 H6UFfUL4Fylu5uRYRahTwr3XuOdLf3MBoYDJeqSdZ9JPD7WiA6g/QkREiyWVza8VoZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZZ+ztJPy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54629606A32C
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 16:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54629606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZZ+ztJPy
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bcb0f245e0so805821e87.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 08:54:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793984072; cv=none;
        d=google.com; s=arc-20260327;
        b=rmXatFv8YXSMBVzGmqWq3V6F0USucbmY85z38UvfaT9t21u6qN8b90K/euANR8fp9p
         HXiFU09wQmw/FvFgSTyrNeFB1vxzJfnq4znKdEoSDtXuU/jeUl9UewL4xtXcuimOGbJ4
         wqMK5jT9yx2hgfpuekYIUHZHleP1TBOgDiCB1x85lk4BjjS0QKo44dQapuLWhkBvXEFS
         IisiuMwYyF4TnkxR2ve2tqIn3bLoXcozo9TDfH6DPO7V7Nf5bC/PynOSfNRKbmsSCkAz
         3kzfAVC+G0xjn6X9n48X0bNlX85nS8arhI4zSpODNDTt019uSm1RSXxWcw3snoWU67qS
         +S0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dkFzuHJuzHv5RFwHabaXe83i/n2wBUC3b7ZSZTt+kHU=;
        fh=te7d+hCgypL+OAUpe+pjkHG8GJYYkXFJdzhPNyFMPtk=;
        b=kqanLjtGwsmFDK0s1NZvIdKBcyaNOStR61FYkmz2mc6F645ZWxom3zQeWhAvKfSNpj
         HHRTSGY7WJBqJpv9Ye37Af8hPYz9Vq8eM/XcaABoDEi3SmGwQi9v9xaHboOZp5XYoVWL
         Iv2qoLeXQeKbBJJAbJ1n+Nr/H6R+l0be9zOznnb3I8bFPYJW7ck5y9popIIMIQDTokPF
         vjNl0rX1SUslIStBQtMRcPMu23RXr5iDBHB5WK23Cppt/LGTDaf0qLYu82tmY0njq3BF
         8aLPrb60b5PXWAW+jN1QsKoaXFtqbUGmNjBTwHCth79jJfDqbATpoODO6jsn00AIdyMA
         2L3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793984072; x=1794588872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dkFzuHJuzHv5RFwHabaXe83i/n2wBUC3b7ZSZTt+kHU=;
        b=ZZ+ztJPybuGEZDjDgu29EnZYCNLMrx4Qz1zhAInaF2quJFv+yTeOBJR5AcJy4dV6FG
         DArFOitNv+XL0urRRS7nw8DyBASOAfCylSm5S3BraKZ6ZlyNoITijzVDXZAJf1qr8RuG
         A2umrMt2opRiqasRjGPe3srtriCn1cAdYRz+qMHy0XttlZqHLvVqbs2CWwgAFxkXHWtJ
         Mx9x9X9vkX339h/aZilD3laE+ec6c7hw29LPbLcQUVpz24Xcx5ncgtNZMrLAkFuATTHS
         xLCJUuBcIE55Z4gSObocZC+ZeUnyXeXY6Dj2D3CHoXu0cOMKM3TdbMOEkf0RQMOWm+cj
         gYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793984072; x=1794588872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dkFzuHJuzHv5RFwHabaXe83i/n2wBUC3b7ZSZTt+kHU=;
        b=pvYTBNEtWUyDIklsYNMqcGclcm7gi4A9pD5TgJTGETnqPy3C58K7G0ykGAu0dS+0+E
         G+ET9F8zDS9RA/ICZx9WFjW8uIiQTq5syEL2P72HrfkjJ43pkz9UcdEKgVPAj7ug+l5C
         GzAmciJgpKvi3XTKJiIvEionf/ISBZOqbRS0R+PG3cU+e0P65F8+tivYZ9V9S/c3Ccws
         858KeI1XbHLT0wgGMJxhO688MJqfTnJyzombkfoFWmTNxKySHEr+QK7QEqB7gLpQ/GSw
         2bwKVly0Y1W5CKMcw6IsiRZwJHQrF5hxvh5jKghCA7gC0oBqPNtEpmqDoEzL1md9oJQP
         0h8A==
X-Forwarded-Encrypted: i=1; AL+hErG027p6pYmnonanKWBevH+5zRfQwAjE7m/yODIReidth8hrQ/sSrrZFR4nAGgGHwIZ8b1ocakk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8N1/7a7LLjT9hpppXI/EwktyFlQvNDvlw18G8GbumIjiyQcZuX
	wlfmPDkW2evhEyEWtF2TMsSbfa5/2RqT0T4liPY1tCnYLyjdN/0AlyaXQLhjj79QaI4U5IK9V5X
	MMNjhuQzaSyiaRfG3DQezeysGf2aLp3Z+RZCxZO6Y
X-Gm-Gg: AYBFou00j+vJp++9/rbh+XZqywiAU5ugR1Vjqnr75I9+2oZEz+KRxlb911XUvtFPaPS
	6BemvmfrbOEPrCPWJKqxe2eFqN/8MOYEwLsBSgMCsTri2DWecRMchQTVDo2J1HAHoPHolkAhj9W
	BupMcOyuddnrpypk1PEFU4N7VuugFtaVgvSzzDgp2xRYEdf6410q02U8BeFOGIO3j7ZnCM+IE8J
	HWexo94C1Gp1A5Oyrcx7b4Qe4u/Bd2eq2ysj6AAg9VSLq5kCxseXihGrsVOKJmCwuRhhLKK0sHr
	4/G+ZyPhX6PLQGs6pcNU9vBdfI9dffcJ2+CeElboiEXrj3+fuofx94s3wnoLRgIvXC0q8mBtr6T
	p/BMSLLnnh5XvWzAy3sNd/9e8IcnhjaCzwh/Y2D+XE0PxigIPJsO1oYKQymPkE74W1jOg+RxCFm
	oUurWoJhL6r11tNse3HdZXlxfuh8OUD28iDrTRgh1WRkfEDY+WWRfkyju+hDvI62+KA0m3a1KmD
	OucwwxzE2EIkTd+
X-Received: by 2002:a05:6512:b1e:b0:5be:3720:1393 with SMTP id
 2adb3069b0e04-5c003adf778mr1037616e87.51.1793984072100; Fri, 06 Nov 2026
 08:54:32 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101092219.1278751-1-skalpesh942@gmail.com> <20261106142421.17793-1-skalpesh942@gmail.com>
In-Reply-To: <20261106142421.17793-1-skalpesh942@gmail.com>
From: Willem de Bruijn <willemb@google.com>
Date: Fri, 6 Nov 2026 11:53:53 -0500
X-Gm-Features: AclHuK_c_DfsmI33CCc1Uir_OkECB369Wp3N4hEOCBGMuQ9y0dY5VqQSiKnHFFY
Message-ID: <CA+FuTSfzzoJN+wsVekOWcn18RKKYgp5AqCOpxh4taG=YAOQ9kg@mail.gmail.com>
Subject: Re: [PATCH net v2] tun: disallow setting IEEE 802.15.4 link types via TUNSETLINK
To: Kalpesh Solanki <skalpesh942@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, 
	alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 9:32=E2=80=AFAM Kalpesh Solanki <skalpesh942@gmail.c=
om> wrote:
>
> A userspace application can set the link type of a TUN/TAP interface
> to ARPHRD_IEEE802154 or ARPHRD_IEEE802154_MONITOR via ioctl(fd,
> TUNSETLINK, arg) because tun_get_addr_len() explicitly recognized
> these types.
>
> However, TUN devices cannot function as IEEE 802.15.4 radios (they
> lack wpan_phy, channels, PAN IDs, and MLME operations), and tun
> never initializes dev->ieee802154_ptr or dev->ml_priv.
>
> The IEEE 802.15.4 subsystem operates on the invariant that any
> net_device with dev->type =3D=3D ARPHRD_IEEE802154 is a genuine WPAN devi=
ce
> with a valid dev->ieee802154_ptr context. When an unprivileged user
> creates a TUN interface in a user+net namespace, changes its link type
> to ARPHRD_IEEE802154, and issues a netlink dump request (such as
> IEEE802154_LLSEC_LIST_KEY), ieee802154_llsec_dump_table()
> unconditionally dereferences dev->ieee802154_ptr /
> ieee802154_mlme_ops(dev), triggering a supervisor null-pointer
> dereference / general protection fault. Similar dereferences occur
> across net/ieee802154/nl-phy.c (ieee802154_del_iface) and
> net/ieee802154/socket.c.
>
> Rather than scattering NULL checks across every site in net/ieee802154/,
> fix the issue at the source: validate that arg fits within unsigned short
> (rejecting arg > USHRT_MAX to prevent upper-bit truncation), disallow
> setting ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR via TUNSETLINK
> by returning -EINVAL, and remove these unsupported types from
> tun_get_addr_len() along with the unused <linux/ieee802154.h> include.

I don't think we can do this.

TUNSETLINK is a weird quirk. It never intended to fully change the link
layer. IFF_TAP still only supports Ethernet (calls eth_type_trans).

It was added in commit ff4cc3ac93e1 ("[TUNTAP]: Allow setting the linktype
of the tap device from userspace"), seemingly exactly to be able to process
other protocols.

Kismet would write captured 802.11 frames into a tap. The device would be
labelled ARPHRD_IEEE80211* so that tcpdump or wireshark interface would
see the "right" link type for processing.

> Fixes: cca8ea3b05c9 ("net: tun: set tun->dev->addr_len during TUNSETLINK =
processing")
> Reported-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D9ea34da5ca6100593c90
> Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
> ---
> v1 -> v2:
> - Instead of adding NULL checks in net/ieee802154/nl-mac.c, disallow sett=
ing
>   ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR link types via TUNSETLI=
NK in
>   drivers/net/tun.c, as discussed with Andrew Lunn and identified in Sash=
iko
>   bot review. Virtual IEEE 802.15.4 interfaces are properly provided by
>   mac802154_hwsim and fakelb; TUN devices cannot function as genuine 802.=
15.4
>   radios and lack private 802.15.4 contexts.
> - Add an explicit bounds check (arg > USHRT_MAX) to prevent integer trunc=
ation
>   bypasses when casting 64-bit ioctl arg to 16-bit dev->type.
> - Remove ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR from tun_get_add=
r_len()
>   and drop unused <linux/ieee802154.h> header.
>
>  drivers/net/tun.c | 45 ++++++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e60..f2915e929e3 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -70,7 +70,6 @@
>  #include <linux/bpf.h>
>  #include <linux/bpf_trace.h>
>  #include <linux/mutex.h>
> -#include <linux/ieee802154.h>
>  #include <uapi/linux/if_ltalk.h>
>  #include <uapi/linux/if_fddi.h>
>  #include <uapi/linux/if_hippi.h>
> @@ -3183,9 +3182,6 @@ static unsigned char tun_get_addr_len(unsigned shor=
t type)
>                 return 4;
>         case ARPHRD_ETHER:
>                 return ETH_ALEN;
> -       case ARPHRD_IEEE802154:
> -       case ARPHRD_IEEE802154_MONITOR:
> -               return IEEE802154_EXTENDED_ADDR_LEN;
>         case ARPHRD_PHONET_PIPE:
>         case ARPHRD_PPP:
>         case ARPHRD_NONE:
> @@ -3362,22 +3358,33 @@ static long __tun_chr_ioctl(struct file *file, un=
signed int cmd,
>                         netif_info(tun, drv, tun->dev,
>                                    "Linktype set failed because interface=
 is up\n");
>                         ret =3D -EBUSY;
> -               } else {
> -                       ret =3D call_netdevice_notifiers(NETDEV_PRE_TYPE_=
CHANGE,
> -                                                      tun->dev);
> -                       ret =3D notifier_to_errno(ret);
> -                       if (ret) {
> -                               netif_info(tun, drv, tun->dev,
> -                                          "Refused to change device type=
\n");
> -                               break;
> -                       }
> -                       tun->dev->type =3D (int) arg;
> -                       tun->dev->addr_len =3D tun_get_addr_len(tun->dev-=
>type);
> -                       netif_info(tun, drv, tun->dev, "linktype set to %=
d\n",
> -                                  tun->dev->type);
> -                       call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE,
> -                                                tun->dev);
> +                       break;
> +               }
> +
> +               if (arg > USHRT_MAX) {
> +                       ret =3D -EINVAL;
> +                       break;
> +               }
> +
> +               if (arg =3D=3D ARPHRD_IEEE802154 || arg =3D=3D ARPHRD_IEE=
E802154_MONITOR) {
> +                       ret =3D -EINVAL;
> +                       break;
> +               }
> +
> +               ret =3D call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE,
> +                                              tun->dev);
> +               ret =3D notifier_to_errno(ret);
> +               if (ret) {
> +                       netif_info(tun, drv, tun->dev,
> +                                  "Refused to change device type\n");
> +                       break;
>                 }
> +               tun->dev->type =3D (unsigned short)arg;
> +               tun->dev->addr_len =3D tun_get_addr_len(tun->dev->type);
> +               netif_info(tun, drv, tun->dev, "linktype set to %d\n",
> +                          tun->dev->type);
> +               call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE,
> +                                        tun->dev);
>                 break;
>
>         case TUNSETDEBUG:
> --
> 2.53.0
>
>
