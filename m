Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793309465;
	b=n2Q4H3RgDvjttc9cDR38JTF1vLbQOSHQ6Dw1xY1hH32i4xH94bIxQEvg5X9yeIkkaePE
	 ZbHJM+/q70a/IR+VXgqCskH6kIvKljDK+0rljt1yavOykqN09wkh2TdVUBsdDq1m1NVIV
	 L/JSkr8cjIRJbLKzgcCCiPy76yJix8xthiihmFG/Tsg29kuRYhM5U3OwabdhRoMfl3bXN
	 9i3ClJOwWeuN4wWJc+A6PIt5VlNbpoPy+Hi9sazB01BaHxfjAtFeWNk0kYmxiRybQTmmm
	 fnS8E50hO5TPvVf2t3FQxSMXZAaoaqX6qAwTRIVaVt4rMD5EwMhIegXmQgdiIw2tg7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kreUdF0uNoXIPwkvrEWSR7P/OzeK9mmS/iNz6Eo8YyY=;
	b=nuhE76eW4G9+8HeeYHXfp/WAuixo1zjMU1BpYnHPonKuQcThqLoRl9umX6ccvo8v6g97
	 fWv5r+47WjdrgI2PpTvPJJBO3pVph4PD7uOzM9MXTHKOBp26zchJ+VKBMNPttWS5EBi53
	 4vScKTqDxfNGnsdeBF5Po5Bo7o88oNNuhjTB7sdtJUXjsAD7HeStjahlJPftWhsxVfnYf
	 gNEMdxra4PS6Lyb3pTU/bnB8GDZjM8COa4gFicRiY/osSuDsctOpS5nXUEQOL5ZwmpQF2
	 2qPI1Jt/za0MTWESB1Zc3jkKCkMs9sjvs/89/5KG3vgKcBjpHTuKUv6uDCzQEMxMCFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JjvhkShp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E166606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E166606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JjvhkShp
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso4615a12.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793309463; cv=none;
        d=google.com; s=arc-20260327;
        b=CDcXJ7I3/SUSP4FFKswAdccqCIwvLbid2D+F0yZszSTHFqkDCKjPDXrk+h5oAlEuTj
         ZvNwnWrRMT8+nMdW5vpoTR+8/5Ib2dr1VZblfxWIFhjX1Zh59wLIUKp0c/eCplgYtw1C
         TiBfDxCf9CYzARXTmaV3vY4DjL5F5l58ANTB0s94sp9ZuFlqbNkyW3YOoF8U1lv+pfzr
         FTTFkhYEvU+dqDxg92w/gFX+EAD/jy6ay+bczEYXL3s9imDwCVvTRaKX6Knst7BVyIjD
         zFgh7H21NEdKvIHcEKRCjTi7cnzJCqE6BX6qo/pnOd7KYKFm8MK7iDYPFw0DrUl76XUL
         vEJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kreUdF0uNoXIPwkvrEWSR7P/OzeK9mmS/iNz6Eo8YyY=;
        fh=F/cyUJX3CqS7eYQyseBiBLIZR6Mx+tlSGyn9q2rwzv0=;
        b=L+iXZ2nllHHxy2jekFNKOBhN3aaUyF76kzfsNGjQdlAZGqIClB5Lz3iRKcHi5Vo3K8
         4EsZ+cJym+wB+f1H2kWPVT5m2obPk9HPjkj660oRGXgiBR7o8MqyzXOl6gXQVPrDzeOO
         lESIY+jKu1uHBQ56U4d6Pz4aGQgenDemBvBf3imQrOPU5NzTBnF8+f+JeBaILXlxueZC
         40RUBbZgPTwdriLTzQXfirNIseuWoW0UKCmGqCHAYXWvnWZtO2KnmE7GVI91zlbgid9+
         udvE8OYHqbtfPwOuyz7SWivKTrlwagTq+BzCeNbqw8QLJeLb/vWjIfLURummpGqjoqFs
         RpCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793309463; x=1793914263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kreUdF0uNoXIPwkvrEWSR7P/OzeK9mmS/iNz6Eo8YyY=;
        b=JjvhkShpcb3GpCFXbSH1IAJrf0j/UpNbINjWXDFCd4+FHeIG9pHB5F9SJglCN8x/Gf
         QCmnkBqxmErXD8b5BTZm02C/YC3WcMEmUFB+ZuLM1vlNSaoMwjIo6LlOGfKQ9XqAyKII
         cXSAcDBsyoL8wcF/++DQes0WkYNOCq45G0Hsr8GwV7+p9MqXqRBOAZPfGDz9koKjqyx4
         LveDl48qfQjqa9ExOTMvwOFDJFSGQyqmQu0nmWaBAEJIF6UmvwwfTyphePxwMl+o3wyw
         rNG/evM9ekrlSZ+PidqGoLTG67P7IyrY69fNce5W1gG4a+aYZ5xCtXqeImniTOiinS8y
         4n0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309463; x=1793914263;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kreUdF0uNoXIPwkvrEWSR7P/OzeK9mmS/iNz6Eo8YyY=;
        b=W258xtrBxAifzR/bARdmXEbAZ6Yr/4YAEJ3fe9540tA5T+Gr8rSOV+QPK7vLL48yTT
         PDDXB7AwNCkb2NPxG918XSWXwY7Uz2OcqVgdXPWh8COQ3iSPg4JXRQc8MCRF9RLsaqWB
         lmn5tt4s1nqX/aNmKECjjbSamDXrmkqY5mB/XnLWkF/wbyzLRj7WRdLBLoTRffhYe3v/
         ha2pJJ7wg996cQpRI01j9z1ZSJ81GO8VYBnpfJB4a16y9dLOQzRDz4pXSWAxVA7rqiBj
         NPcKykEqslYvRJW2NgJ+lszshdQBb3ZEjXmfiUveWzQD4Qrv23+FUnKBCJRTUuCQw3ih
         W5nA==
X-Forwarded-Encrypted: i=1; AKwUvByBc5C+cAjfRG5ILlvhEj4uxeWlRUh4aUL3AkqqZzeKB6qHYDoxjMO4voBLberyjutb/opX9XM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcaHNrn6KVcIUDfMke2bJx5oPkqf7//BAalBXdDa5fWxc8ts/A
	4Lue5gEmaOdKC3zxv2qr1YblRk1D1+RAcM3dNqRFmtN6/kuoFtxBfagGEVdcahc+hirAaf7yj4K
	GbOU1lYMKtQGD92IEL/iJC6pCbztBujndVgUZ45f+
X-Gm-Gg: AYBFou1TCCvShc3roxmJVgz5999L1CBrpLzwTu6wOttVeXm5F6kv4NIFlABO81oCLJn
	zE0acHpHLp4O2qf1mdGjLk34pUppv/YvcjMno/srO9siwjuhK/fGeK6Bfi26hPWs1qrC9Iaz3F7
	OOmUdrnbRk1GTDsjl6fyyWhFnuhAKXotsCroJXQBg6DrX5ax9navLZcl1KXuxXxYUuzZkgXh0FA
	PNoeTk8f4KSBI+Hhd4sxbUzrG2+KhSK5HKq+mgh7Fgk8Wt7B4GZ1MY7WUa8eI2sJHTlXi3aKLYS
	qMMPgyU4KGyeVWA2ZuZA/SBvQVrkw+vpaiaCiilsbJfeeEzHOMvYJiCpDM9v6zLieXTGry/URaO
	T8dqQQdLMP93U7XqLHGxO53WpeOzKW6fJ8fU+6SKJe8AE6tJBCqQnYIQZVBylY8IONgg=
X-Received: by 2002:aa7:dd17:0:b0:6b1:d80d:396b with SMTP id
 4fb4d7f45d1cf-6b4b40b8186mr104372a12.14.1793309463143; Thu, 29 Oct 2026
 14:31:03 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029145844.231018-1-omermetekaya0@gmail.com>
In-Reply-To: <20261029145844.231018-1-omermetekaya0@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 29 Oct 2026 14:30:51 -0700
X-Gm-Features: AclHuK9vwMToW08OTMztQpW3bR5sve3bLoPc_H7WIharriRZuH5COTSWDbQX4kE
Message-ID: <CAHS8izORg8OR8TyWBHmZsgFBtM3+qh7gXCJxifk1QGs13Q=ygw@mail.gmail.com>
Subject: Re: [PATCH net] netdevsim: reject port addition and clean up ports
 after a failed reload
To: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abini <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	syzbot+88435e204734072bf39a@syzkaller.appspotmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 8:02=E2=80=AFAM =C3=96mer Mete Kaya <omermetekaya0@=
gmail.com> wrote:
>
> nsim_drv_port_add() does not check devlink_is_reload_failed(), so ports
> can be added via new_port after a failed reload.  nsim_dev_reload_destroy=
()
> returns early in that state, leaving them behind.  nsim_drv_remove() then
> hits WARN_ON in bpf_offload_dev_destroy() and a subsequent use-after-free=
.
>
> Block port creation with -EIO when reload has failed, and delete any
> leftover ports on the early-return path as a safety net.
>
> Fixes: 75ba029f3c07 ("netdevsim: implement proper devlink reload")
> Reported-by: syzbot+88435e204734072bf39a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D88435e204734072bf39a
> Cc: stable@vger.kernel.org
> Signed-off-by: =C3=96mer Mete Kaya <omermetekaya0@gmail.com>
> ---
> Tested with syzbot C reproducer.
>  drivers/net/netdevsim/dev.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
> index feb88ccbbced..61f0824ce4d3 100644
> --- a/drivers/net/netdevsim/dev.c
> +++ b/drivers/net/netdevsim/dev.c
> @@ -1697,8 +1697,10 @@ static void nsim_dev_reload_destroy(struct nsim_de=
v *nsim_dev)
>  {
>         struct devlink *devlink =3D priv_to_devlink(nsim_dev);
>
> -       if (devlink_is_reload_failed(devlink))
> +       if (devlink_is_reload_failed(devlink)) {
> +               nsim_dev_port_del_all(nsim_dev);
>                 return;
> +       }
>         debugfs_remove(nsim_dev->take_snapshot);
>
>         if (nsim_dev_get_vfs(nsim_dev)) {
> @@ -1758,7 +1760,9 @@ int nsim_drv_port_add(struct nsim_bus_dev *nsim_bus=
_dev, enum nsim_dev_port_type
>         int err;
>
>         devl_lock(priv_to_devlink(nsim_dev));
> -       if (__nsim_dev_port_lookup(nsim_dev, type, port_index))
> +       if (devlink_is_reload_failed(priv_to_devlink(nsim_dev)))
> +               err =3D -EIO;
> +       else if (__nsim_dev_port_lookup(nsim_dev, type, port_index))
>                 err =3D -EEXIST;
>         else
>                 err =3D __nsim_dev_port_add(nsim_dev, type, port_index, p=
erm_addr);
> --
> 2.56.0
>
>

net and CC stable for a netdev sim bug is extremely overkill. move to
net-next with the AI-review comments fixed, if any. Thanks!

--=20
Thanks,
Mina
