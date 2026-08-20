Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53EB401A3B
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219369; cv=pass; b=LtjziJ3I6tyTaKpyAXPqrEzGGQYcIhBuyV4XCqDihMFRbKIB8gL0MJbLLAxVmY8TVgNqejc7MBWusvyA07/c7HGSjNHA6dS8KQRZBjiYC7gTeQSFbFg3RnahpzG94ANHHX54WUExYJMWZnOMvIn9jaaO2G/J8/J4SCVn/qp9Lds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219369; c=relaxed/simple;
	bh=HCwVrBof0dVQNtk+UZyDfRrTC39+LwScfAMZ4G5YI2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcwLx0Y7MDWmMnOfOTM2pIyRj/AxKZ3E8++xTrytrVxbA35xqQAWAfLmaa3tgSRhWZybWmUtRui05MYFQHByRDDlP7Gtwb+lmOSwO+Xp2KAIEoiKGSv/qur+sfv3mo2CR6nZv6c4oZVUL7/qwYoTzBHIWuPAQYle2EKjpoWy1U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QRZr/RaY; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QRZr/RaY"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-90c776f6c13so1218636d6.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787219361; cv=none;
        d=google.com; s=arc-20260327;
        b=Eb8Q63gwHCwysYT+3sApVi25KueJtqoi2E1iDUcXSFYOILb5R5jf8eyGXNDYkAp03z
         0jgZmPxRPlgU6VEoPEBgPjidOJ4wSHC1yowhSMvb3jKlut4sMcJ+88Q3XRljRpLPN1jg
         1vTz7KRkwY7lgeeLm4NXEmHDgAW9KXz534xhAuDedcr/a7uc2xwrhtwDgxD5UbHXWFKG
         Mda6cAtBPLy/5P7eXIPShXaO3YBjjynXay3QMhm1AnKVsSBRWmx1b7B1pw8p4Ne0/+eW
         IG7C5aLLzjg0facMcB2qgk8hFhgRkAQ1xf+gVvG8R9WHJO18KUV2p/p8X8SN/hPrRwiF
         aUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m6T9C8LYxnNmFInI9xCJwV9moXIUDwxB8yfrtB/ikgc=;
        fh=3y5IIQeUbik3HJ5OG/00i7Mma5ZfYy9Vf+BkLxnga0Y=;
        b=AJe+oNCeXVTsVkHyJ2DQzncTxThaL14V9IFJ8+SG3971xO59HjVhjaOelpgrPBcoUX
         j0fpMYtE6WOLPDyn9D2Em+g5HA52hRTV5BUWLNY1hln6QMQcyxdBwdcUd01LdZ/R39FQ
         ozCGcbUdygOYlTXd2jjVHDsp9D19wTt/JWlRVA9kh/VYs/dujG9XyiwI1bZEXrXnsv1l
         i+k3R/65lJQha9oqd9azXlm9pi8PXwzeZ8QEjiQ73FSWiGzzkebcervoKinEr/4Rg6e8
         iLAYcf+fSMc0I9LkmwoYcFnbGM40TGycn9ZnYjjNIaxCUVLaTWoEfVYcVsIFKGGfYMzb
         Ux7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787219361; x=1787824161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m6T9C8LYxnNmFInI9xCJwV9moXIUDwxB8yfrtB/ikgc=;
        b=QRZr/RaYgO0QLCb+fqjAGsd3tdd+2c4dZ4M6GyDXLh6gChbZg7vku6GpiuGId39jwI
         xpZ1ShA+df6YduLSy3wftg3pSwBftI61MMF0WhswZTQfc8bggQLaouiN4bKFBkdHqh1E
         RgifEhV6w5U/nclvTnguymhgrlii3G5apqk9fFYS6JzicRSUr0Askcf5fYh3/gxVEpo3
         lE8ae5wUJcchlXSqqUO860KMJQ0/cWF3EMkNwJMls7haqyTXGiKSY4Pg1Xxk8JhSqrA2
         2tybnL7FU2G3c+7w3PtS9EWbU/ozKCGuNKXaO8pEVb/ZbFCh2vBytjFVSpQpd8k/SzPK
         90Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219361; x=1787824161;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m6T9C8LYxnNmFInI9xCJwV9moXIUDwxB8yfrtB/ikgc=;
        b=hYqZfTV4s/o0kHR1FJbhWRbi3cb24BixhWLKXLUNy4hRrbb0TQohfjr2xVECKJiQKl
         mbFl0gOm6rVer2L9rqYTFqkVIjFpyT7dFvPbqee1OyJlWad3aBZG1CpG+fRvGl5dbafQ
         HnC+QLOD6VQ2Ru5i4/Fao78JkFDPpRVGtgOgqXkR/xdXKyIe9xxT6CmAG7iYym/IbKoy
         CR0VyF38d6Toi9Z/Dnp9sPAS17nHBYQ0UbJP06xpXt00+hPCQ/2SJxzoI5cOcVCv+tlg
         qsyspgyHzt5RNr33KYaTwpeLhUmx02JSf+hC6Z7M8hXecML8fTEIQdZxDA/GGwDF5jPq
         XV0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqacmea9FvBN/LyxxWwF0UOayDUg+2jJhFhtDPrVqu77snqOtSHi8p7O6Xzw4Gn22n3xwXwT4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzABuUy+rL4WM1fJiZEMShJUqUllBWJuVZVcQ78d8O70XggI816
	rCbd8cSeHc9Tl6iaO1oT3VKenvwcwZsfz3mpjmOnWcxtgFPMdHymPQhfzLy5vgPdTDlqufO4d5q
	uRubCpWZyimenOD1/QPPi+SmgH2JpPGahvdCsieiAC1uV1mioVntuvrfYoLs=
X-Gm-Gg: AR+sD10nTZoSAu7zXEoShljVcyjfMTw4U0+8+1UfL6zvsbvLjLS5DQPyO+SaS9g92dp
	0Z1MMof5sd3VPQs17Jx+OqBPAF7N+XPJT59qkV/527yTcaP9KtsQGpBa636eZ0tPClTpt5WMMo2
	ReZ9OTvwlbrWgSDuhlCjqw0YMpba753ZlwFtkseqDqLF2jsRS6KKw6tZVA52Z/oEZvKFHcdx2nN
	R2VHc7+DJbGW9RlgvIor6WZAcFOo62pLVVXZYJoK+3UPS4CM0KaRdKw6JXjoq9YuQhu+nwBEDeJ
	iT9IWesrTkpIDjiZAhd3ydY2f3U4WSGAdKItTZXOz75deMktrxV1E3M8b9Rx7f3q4BGuNTHKk0v
	CHhmx0cDpzs5qPcorQCE6HpxucDi+/O57I25jo5Ir2c63yFuRjoKRo35qeA==
X-Received: by 2002:a05:622a:2298:b0:51c:1117:c79 with SMTP id
 d75a77b69052e-52dd5c4291cmr113956241cf.24.1787219360336; Thu, 20 Aug 2026
 02:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820081111.1586932-1-xmei5@asu.edu>
In-Reply-To: <20260820081111.1586932-1-xmei5@asu.edu>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Aug 2026 11:49:09 +0200
X-Gm-Features: AcwNN1W9iv06yw780xNy-WoYQdn4aQ_OltMhBquIWBtgDkSX3vq-Bx_D_JeVndg
Message-ID: <CANn89iK39fwq3hLAdEKPk7_G-dN-rxrhWnpoiGh3dkQBttTucQ@mail.gmail.com>
Subject: Re: [PATCH net] net: qualcomm: rmnet: set skb->dev for deaggregated
 MAP commands
To: Xiang Mei <xmei5@asu.edu>
Cc: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>, 
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	co+4638111fe2a12980@bugs.sh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 10:11=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:
>
> rmnet_map_deaggregate() allocates each sub-frame with alloc_skb() and
> leaves skb->dev NULL. __rmnet_map_ingress_handler() assigns
> skb->dev =3D ep->egress_dev only on the data path, but a MAP command fram=
e
> is dispatched to rmnet_map_command() before that, so rmnet_map_send_ack()
> runs netif_tx_lock(skb->dev) on a NULL device. An unprivileged user
> reaches this by unsharing a user+net namespace, creating an rmnet link
> over a tap device with INGRESS_DEAGGREGATION and INGRESS_MAP_COMMANDS,
> and writing an aggregated frame carrying a flow-control command to the
> tap fd.
>
> Assign port->dev before dispatch: the command was received on the real
> device tracked by port->dev and the ACK must egress on that same device.
> The non-deaggregated path already has skb->dev =3D=3D real_dev.
>
>   BUG: KASAN: null-ptr-deref in _raw_spin_lock (kernel/locking/spinlock.c=
:158)
>   Write of size 4 at addr 00000000000004b4 by task exploit/144
>   Call Trace:
>    _raw_spin_lock (kernel/locking/spinlock.c:158)
>    netif_tx_lock (net/sched/sch_generic.c:497)
>    rmnet_map_command (drivers/net/ethernet/qualcomm/rmnet/rmnet_map_comma=
nd.c:67)
>    rmnet_rx_handler (drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c=
:125)
>    __netif_receive_skb_core.constprop.0 (net/core/dev.c:6103)
>    ...
>    __netif_receive_skb_one_core (net/core/dev.c:6214)
>    netif_receive_skb (net/core/dev.c:6474)
>    tun_get_user (drivers/net/tun.c:1966)
>    tun_chr_write_iter (drivers/net/tun.c:2012)
>    vfs_write (fs/read_write.c:687)
>    ksys_write (fs/read_write.c:739)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> Fixes: 378e25357ac7 ("net: qualcomm: rmnet: Remove unnecessary device ass=
ignment")
> Reported-by: co+4638111fe2a12980@bugs.sh
> Closes: https://lore.kernel.org/netdev/ijg79FFMfIvKJbivdJEKvTO90Q9dTvyBkJ=
ck@bugs.sh/T/#u
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c b/dr=
ivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
> index add0f5ade2e6..3944925566fc 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
> @@ -79,6 +79,8 @@ void rmnet_map_command(struct sk_buff *skb, struct rmne=
t_port *port)
>         unsigned char command_name;
>         unsigned char rc =3D 0;
>
> +       skb->dev =3D port->dev;
> +

This works, but the suggested patch is cleaner IMO

https://bugs.sh/b/4638111fe2a12980/patch.diff
