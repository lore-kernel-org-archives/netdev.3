Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06F3B7746
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786172416; cv=pass; b=LqP5MF991iNMGTTZQBgxLohwZsdZ+R0SI2Cduzdep6qoDnNl08RJ7V1wRyUO+YeGaowp0vwxNynbomx2G+r/oONCUVQhIDzSjbzojkCXrP2COrqMhhKqNtHl6+tzDj44whfr+kcD/Cu3kFxaqGVzJKitP4R5SfQf9ZC6dENvkNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786172416; c=relaxed/simple;
	bh=9H8bxirkZyL2BdQN2JzSybWbJ2Mt85TIL5xVBn743NI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gomXH7x6hREeguHNuM3NeoNhvivWJdIj/W/ZzwLI61lGDqXVSIz46CdH8qkZk73O/4fec4a4lxCwDZan41ashSPvpCLHNipp+UaM1eI9jImhiwc382ESv1t9aU8Ti1uwEx6g/HtrQ5VY1+CwQ8ukiRY85sJV6mIPMJuE3KCFIgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MDtg5by2; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MDtg5by2"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ff88549786so2009236d6.3
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 00:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786172403; cv=none;
        d=google.com; s=arc-20260327;
        b=CM1PciouJUgkXs+WvXKm/7/w3UGVLmNrdMEllgeC4Z/TzXHZlqodN9pyRIpneVyKkz
         Gj4jjBeNpWRWO1wYe4UeXuMR910Rp3HQ4llaEnnq1FyemywkjhGjy6+ayx6HElXKrXqI
         k8/vboTEmeZLBLzCT3yUkFe8lkJ3ZBteohNJINhTXJAPjUom3kUmORqB2WNcOMSzAKtI
         bmNAg4pTHLGk/MH/VypaJvuVF3LIYv3N/NeWYySYtRQuTrlXMKdcaUSnTgDoMWzfbrId
         rZy3ljPCQGzVAIjPabp9P1SuFadHaXvhJNzBw5Kkj648Lm4CTbKBsoGwU3KmpgW0FVzg
         kKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OCoQ/BqwhJzxKbqP23vELa0j2NE7X00OdRwlilQKW7U=;
        fh=OVpcSpyYDT8dm3E0SSAmkwiBws1CwEJvNboTUi3yMws=;
        b=XR87/FBTSJtQkESwLtIm97a1trjRniaFj5iYZYkL2kAG6ymoMH9/KW+u51xYYropS8
         c7Z3GoPgL+m1p2mt2AxSj5yLbdHDqpMwHH26sm1AEO2w9fwEtHsmgBAwUKPLfr1NOPZ9
         KmsMMPeX7+LQU5PKSJByB0KYdhhPg6RpRbFl+CRTRbV4ybQvRJWheY78YP3PveLvkRwj
         9Qr77nY4XLkh5Qy/A2U9ZlB75AiHhpjqe/NnOCukv8QCazSV17V7qS/jRXVwqmfJKpV6
         Qk2/GuiOeruUH7GL3Fs/X9weXGxnX2jadQzhIticONXDVzeSIi6NXPX3eIZYepHekQiM
         BxVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786172403; x=1786777203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OCoQ/BqwhJzxKbqP23vELa0j2NE7X00OdRwlilQKW7U=;
        b=MDtg5by2MJNkoMYS2hQ7+HTs8QAKtkWO0LC8EMhS45J11cixdthF3BnI79mTeLN0AQ
         bwnlCkuWr9QanR6Rku7cc7PbToHMtZ3qfHTLKGboWEPdDm1/UH9QbmTQoLnTkBsPwCWh
         muihZcKEwcXNv16iFH9+c1p2dL0Wigm7KGJotVewtHSrFLVds6GVUKp/Fph+2UhxQDYB
         3bf6plIxNBiuGkiVWcLSZUoFmCntb5LklHP0Yx0BSdK4Xfz1O2K8k0dWGGW7a+8gvWNK
         drBLj3XySd3C8Ng1y6f49t+KQA9QYVA2OV/21VrzSa5x7Mdqs+oksHcUnHAhYBJ5AMnZ
         T4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786172403; x=1786777203;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OCoQ/BqwhJzxKbqP23vELa0j2NE7X00OdRwlilQKW7U=;
        b=e7GzmfG8H3CAoR7BBziOCFjtsDXR2v+bEjF1yFp4jqPsfGTO+AXmP0xr4JQOFMVOe7
         oDmPSO4UfGk5BIYnEGQbc0axP1TospKU3EbCxFCFr2OTSzRGp392bR0Wie4azFe8MkWd
         Xf5RUFrBLfACR5VVMluTDtH3rc9WKGelBIHN83NgTB1W/z4HW/nKhVYuuF0ejfj3thdB
         loxa9hlqxfNiCrUcaLmpoSfVv7gqa10FLc9dG2I/k97eR6G9e6aye+OlFd/AMdxMkV5t
         SowBOEeLYiqby9Q9Zq0/oltLGqLhc7PRj3AZdDyTzTWlfnu9E6zF9s4mWLXM87IZ9Llw
         ZNyw==
X-Forwarded-Encrypted: i=1; AHgh+Roll6YZqzztXEjGHJJN4bnhlMvntpEgTNR3pTntH+xv25Fkn8+DA5xT8EK3g9ImICjci4uIwXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxui10bY71iT8WNfqf/14KRPasBdMClMExdX1EdsQ9635zUYAIK
	MMyvt/1L5oxqQU4GTbbm+RWxmpxfsKGD7D8nK+4x4lzRF9/+buxPrlbBKRyWOEzf24CFEWba1v5
	tzdt11usrPRR0oVfJ144HDVuHh2OzBtLQNrA5wZH1
X-Gm-Gg: AR+sD11I3/ZCBGoxza0sT3lvwIXrZSd6PuNf1cqN1XB+Av2EPyrlY5tXTL4kdJNPrmk
	Boa0Xmj8qa4DYt+SUm4WgfgBnq8xtpzmwoimWqF3PV4cW+RzM1Yn8WCI/rTob0YBlJjBD2GkZ/y
	qYlqzREd3i5qaY/+blfCeoRhTV5UnV0xuIn86f68IF3gCDYtMCyJxuPhGTPXjKKyEjdf1VsOHFM
	crojtu4QxmdjUTjOhny1rP+f5dVRx3NCrtaDs9s1D3zOcUJocyLH4GAU6RXpeDk1FsH4CbEgQ6P
	oJ6vol8OO7QBXqs61KL4Hy1eirj3xiJWoCKisAeIpoQLmYbd75sw7mR3S2iS/bu5t7k6fDY0xUB
	cEOR70eo6WqR/EfL8m7gyVJQaqqxIe6aXIbmALCnnwruGSC4+nXxlnqQ=
X-Received: by 2002:a05:6214:2423:b0:8e0:16f0:28ab with SMTP id
 6a1803df08f44-908811f0d91mr284473576d6.11.1786172402394; Sat, 08 Aug 2026
 00:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807171024.1897860-1-edumazet@google.com>
In-Reply-To: <20260807171024.1897860-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 8 Aug 2026 08:59:50 +0200
X-Gm-Features: AUfX_mw0AmXnxL6-8lm-j-7ba5RvNOFRZBxSaBp2oX3TptdUfoceyAzgEGuDOzc
Message-ID: <CANn89i+i1gL5WvmbkedXm03NcoV0RC7ATd1GiLt=Mj5Y_tSDwg@mail.gmail.com>
Subject: Re: [PATCH net] l2tp: fix tunnel and session refcount leak on
 seq_file release
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+d6fa74e3f19d6ee01e3a@syzkaller.appspotmail.com, 
	James Chapman <jchapman@katalix.com>, Guillaume Nault <gnault@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 7:10=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> In pppol2tp_proc_open() and l2tp_dfs_seq_open(), iteration state
> (pd->tunnel and pd->session) is kept in seq_file private data to allow
> iteration across multiple read() system calls.
>
> However, if userspace closes /proc/net/pppol2tp or /sys/kernel/debug/l2tp=
/tunnels
> before reading to end-of-file (EOF), any tunnel or session reference stor=
ed in
> pd->tunnel / pd->session is left un-dropped when seq_file private data is=
 freed.
>
> Fix this by dropping any remaining pd->tunnel and pd->session references =
in
> pppol2tp_proc_release() and l2tp_dfs_seq_release() when closing the file.
>
> Fixes: 0e0c3fee3a59 ("l2tp: hold reference on tunnels printed in pppol2tp=
 proc file")
> Fixes: f726214d9b23 ("l2tp: hold reference on tunnels printed in l2tp/tun=
nels debugfs file")
> Reported-by: syzbot+d6fa74e3f19d6ee01e3a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a760f32.01d0871a.3a0d52.004f.GAE@=
google.com/T/#u
> Assisted-by: Jetski:Gemini-3.1-Pro
> Cc: James Chapman <jchapman@katalix.com>
> Cc: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/l2tp/l2tp_debugfs.c |  4 ++++
>  net/l2tp/l2tp_ppp.c     | 38 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
> index b26986fda9d6cf096519d56032fe3deb5034c7c8..c12d5e1ee550ccc2608b6128c=
b653ca373280373 100644
> --- a/net/l2tp/l2tp_debugfs.c
> +++ b/net/l2tp/l2tp_debugfs.c
> @@ -306,6 +306,10 @@ static int l2tp_dfs_seq_release(struct inode *inode,=
 struct file *file)
>
>         seq =3D file->private_data;
>         pd =3D seq->private;
> +       if (pd->session)
> +               l2tp_session_put(pd->session);
> +       if (pd->tunnel)
> +               l2tp_tunnel_put(pd->tunnel);
>         if (pd->net)
>                 put_net_track(pd->net, &pd->ns_tracker);
>         kfree(pd);
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index f8881699e1cad88e6f312e6ca47ae0af94c6137c..24e5bc06f65c6134974612294=
e36dd13c1608607 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -1597,6 +1597,40 @@ static const struct seq_operations pppol2tp_seq_op=
s =3D {
>         .stop           =3D pppol2tp_seq_stop,
>         .show           =3D pppol2tp_seq_show,
>  };
> +
> +static int pppol2tp_proc_open(struct inode *inode, struct file *file)
> +{
> +       struct net *net =3D pde_data(inode);
> +       struct pppol2tp_seq_data *pd;
> +
> +       pd =3D __seq_open_private(file, &pppol2tp_seq_ops, sizeof(*pd));
> +       if (!pd)
> +               return -ENOMEM;
> +
> +       pd->p.net =3D get_net_track(net, &pd->p.ns_tracker, GFP_KERNEL);

Oh well, we have a dependency against CONFIG_NET_NS for this stuff.

pw-bot: cr
