Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785A3E5A09
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863412; cv=pass; b=LYbMhgEeaJFeWll+XHCimvkhIPEP8no8C/aa3pl13Pqmtx89PKRff46/rzBZD1iNPBNzgCLLAXg2IJWF+LFoP2DBKOSOe8plT1GcB8CtDOLON7JTk29kta37hc08ikSeY1kGvuiHPH2bvVTb47JgbOvRoXncZrwcBecoq+HORvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863412; c=relaxed/simple;
	bh=qlNVDBjLr3ZY4uqSXXboWV38S/5DYsKm7VLU/yyEiVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdPgGgmvG/unuLqoyDXfLvJ5yW9t64xefsKOe0uZGEPHG8IaSOqmWN3rbW+06xTEgjLSN3zYP/lMgQFsWTFxImr1QhpidkU1O4bcyyL4UaB6ZbwE9DgqczCidSVd1Fb4Da9LBhHfsD7Zl8JQkOqii03MyqgqQ/Pekndf8QjA9hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eec1unJ6; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eec1unJ6"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4ab3c6f7f44so8886b6e.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 10:09:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785863396; cv=none;
        d=google.com; s=arc-20260327;
        b=QSYQpd3ObPY6a8AEXYfTR8qzlcstow5vA3pc6gzLI+8I29+MDARyGA7pjp/tbixtz3
         T6BKOgclzyZ6Kt2XfXNNbZgQFOOW4epQupDNAR/yNmL6bpAd/eG27e83Mx8F6uTfRej6
         Bua29uFZB753yL/7FwyA/g2XXysgjSsSGZVYjYM0UzwK9avxTxgbNYZbPd3P6TdCWjtB
         SmAc7CBPgnka5sP9v177f9QTVzkUfboUFio3DfLKP2TAjYy7J8AIHbxc3tTaAL1poOr0
         5/3gMtzsxe59Bpehq7lQI+15RIBJQ+0wTKNLvHXsyPKeVZUZA8Y1f/nWgQNk4Xr6hu8x
         3aOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=resBrknXGwVF7We6VuEyfyRafwvNfm4i3nwr4XTNczA=;
        fh=5hojzL/mCb8XPbjzwu6FVia8VKCI/d7J4hj87T4AxRI=;
        b=WPbiGC6sp1ArALlo/w1/f4Y+18SDe/F0dFlLYQ0zm6hv9NcVm5rB61JKgy2NPacB9e
         mKRvlwrhy65yH09ISmoxlcI1Q+XsESZ0tOuGkXZ7xsC2MptOzpugcbtqpLLZOdt6O53q
         uWUKcGt1H6j01rdWmXT8bjUg1Oernw+0feGSkstqbpDZi4ozRjzLJqciDsmsvdkIgVMN
         1HQRhQQgg8+NcTrjQE377V1ILKabxad4OtiXvUBmJxd+GSa34SmpbsrOQFVo0KIFaj/6
         EdwPE3olnorKVnaGgz1Rf+qwW0CVRk69oFXT8cjKlndUorpDPGVuIwcvRXUiK0Ep4GDb
         bK1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785863396; x=1786468196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=resBrknXGwVF7We6VuEyfyRafwvNfm4i3nwr4XTNczA=;
        b=Eec1unJ6cD7LiZ9slbnIkpRWrNbwfEC/YTyz1oEmhdvtahTquI45v4epsnMbw3lXfn
         EPTxtz/GUVHEYa4ZRwCXhPzIkEfTnszpKNTzD9DygYLn12naCvsRt6kt+mGwMFBigKpo
         JGuuDDsC2xrttmQiK8YBNpKMxw8OAVUF3V6wT3Qcirh/VjIXKli5WqYNX4s9hIpYF0+T
         nkg4z+MqEZzLDJuYxGWc2lE1+PhaaZ1Va2ArKgGb+zZkzIMEn0F+hWaB+c/V0Od1c5qB
         3vNniq2GXYXpSOS/F1UZ9/faz9m3JuX8sEl0vsP+1uG3mDd3Y2ld1Wi/NzxrCdAO17Zp
         mGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863396; x=1786468196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=resBrknXGwVF7We6VuEyfyRafwvNfm4i3nwr4XTNczA=;
        b=qTLDmrTLlgiwBQxsolPaRILRVnbmTOSuaAJq/rIcyQ1mpCqXwOavEfw+bOeP49VSYX
         dMAaImWwwjm912KOEIqPBjObGnIOZDi4Bn3no4Txf/2PiGkUdp6xT0DJi9O6w8Qvk2Ee
         oa5Iz01KKxnji3T9fIaGKaK2VFE9849155JGdNNvGgANv2RgLIQ5Y3Z1igRqUL2/PS+S
         yujBftuWiVQCnoS35zgD+BUS/yjDMU6tyxC9l9gYX+F8XoXItnD0nAvSklw70SAIpX6w
         V8smH04uGhPTSxJzOGS/V1wDgrqTKrcbjXbAKH11/uZGAs+uX4Ppg/qTuzGX1SozOIwg
         U9Rg==
X-Forwarded-Encrypted: i=1; AHgh+RpbFYVG+uhp6yM0q8ZtU5KUlNoVNjSzDZ8y5nX4CNjHQcGBpVZ9p2LcrH67aPjwt1MRCJBG5i0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5tsKKozN6KBMCRq+R5F3VP5FWWfw3YthmnqC9NrRmu6fh85tw
	FUqdp2Wdt9XjBpXsz2nQE6/xBXhxMGbFH3MDFO7YJCR9y0wHiFwa3rsAaHshJXDIvrNA3tUST74
	akr21HNY8BJsaiAl+jzsXuUVimGu+a58=
X-Gm-Gg: AR+sD10g+BfdwAzfmIeNu5bhilZ7X2GyvLYavEC//CH/DlaR/gYeMdvsBxRCocGv6n2
	CkGSoNfk8MYrJz91LjTnlfBwYJjFqgDfW6oWM/gDywKlX0Gb/8iW+EmAyiKlckSuawsglXGh87L
	DyVRIe3dq207DbzfRLwsMlvl+AVBUiKQYvnReoxPsTbKoZ5io1Y/7gAZ6pi9ggy011x0rORpBZn
	Nmeu+KMTbVwvhJOGKlGMRcE2PXjh+f3CZeYZwGFKhT6akZqCY5xnYbBOnjqUuDDgPxFpqNbQwY7
	hRyTiUtMAVv/8Wsn4sNXRDu4XUecnVU1xHLZzRJffS5tb89E4kBCswEul6tD22RCBWuV9O9+
X-Received: by 2002:a05:6808:1588:b0:4af:5d69:1cb8 with SMTP id
 5614622812f47-4afadbf4d3amr100488b6e.0.1785863395341; Tue, 04 Aug 2026
 10:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-netcons-userdata-rcu-v1-0-1e5e6b62b75d@debian.org> <20260803-netcons-userdata-rcu-v1-1-1e5e6b62b75d@debian.org>
In-Reply-To: <20260803-netcons-userdata-rcu-v1-1-1e5e6b62b75d@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Tue, 4 Aug 2026 18:09:44 +0100
X-Gm-Features: AUfX_mz0x1sNnb8P41S_VG9EDQAZvd5FxVLF-LnA8kzMUMUHAspc7VDEE8Ne7Fs
Message-ID: <CAGSyskVKAwf8nb_3uFDbYUugR+dtO-cwSef8C9nSEgKZt_K=CQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] netconsole: publish the userdata payload
 with RCU
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 12:30=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> update_userdata() takes target_list_lock to swap nt->userdata and
> nt->userdata_length, then frees the old buffer. Since commit
> 7eab73b18630 ("netconsole: convert to NBCON console infrastructure")
> that lock is also the console's device_lock, so writing a userdata value
> from configfs serialises against the printk core emitting messages.
>
> The buffer is immutable once published, which is what RCU is for. Move
> the string and its length into a single netconsole_userdata object and
> publish it with rcu_replace_pointer(), freeing the old one with
> kfree_rcu().
>
> New userdata design:
>
> 0) Unify the userdata fields into a struct netcons_userdata
> 1) update_userdata() no longer needs target_list_lock.
> 2) writers stay serialised by dynamic_netconsole_mutex.
> 3) reading userdata needs an RCU read lock.
>
> No functional change intended.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 88 +++++++++++++++++++++++++++++-------------=
------
>  1 file changed, 54 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 862001d09aa84..c88c82f2136cb 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -135,13 +135,27 @@ enum target_state {
>         STATE_DEACTIVATED,
>  };
>
> +/**
> + * struct netcons_userdata - Formatted userdata payload of a target.
> + * @rcu:       Used to free the payload after a grace period.
> + * @length:    Length of @data, excluding the NUL terminator.
> + * @data:      Formatted " key=3Dvalue\n" entries, NUL terminated.
> + *
> + * Immutable once published, so the transmit path never observes @data a=
nd
> + * @length disagreeing.
> + */
> +struct netcons_userdata {
> +       struct rcu_head         rcu;
> +       size_t                  length;
> +       char                    data[];
> +};
> +
>  /**
>   * struct netconsole_target - Represents a configured netconsole target.
>   * @list:      Links this target into the target_list.
>   * @group:     Links us into the configfs subsystem hierarchy.
>   * @userdata_group:    Links to the userdata configfs hierarchy
> - * @userdata:          Cached, formatted string of append
> - * @userdata_length:   String length of userdata.
> + * @userdata:          Cached, formatted userdata payload. RCU protected=
.
>   * @sysdata:           Cached, formatted string of append
>   * @sysdata_fields:    Sysdata features enabled.
>   * @msgcounter:        Message sent counter.
> @@ -176,8 +190,7 @@ struct netconsole_target {
>  #ifdef CONFIG_NETCONSOLE_DYNAMIC
>         struct config_group     group;
>         struct config_group     userdata_group;
> -       char                    *userdata;
> -       size_t                  userdata_length;
> +       struct netcons_userdata __rcu *userdata;

With userdata now annotated with __rcu, it should be freed with
kfree(rcu_access_pointer(nt->userdata)) to avoid a sparse warning:

$ make C=3D1 drivers/net/netconsole.o
  DESCEND objtool
  DESCEND bpf/resolve_btfids
  INSTALL libsubcmd_headers
  CC      drivers/net/netconsole.o
  CHECK   drivers/net/netconsole.c
drivers/net/netconsole.c:1702:17:    expected void const *objp
drivers/net/netconsole.c:1702:17:    got struct netcons_userdata
[noderef] __rcu *userdata
drivers/net/netconsole.c:2689:17:    expected void const *objp
drivers/net/netconsole.c:2689:17:    got struct netcons_userdata
[noderef] __rcu *userdata
