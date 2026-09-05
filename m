Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD1830EF86
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 04:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788583496; cv=pass; b=f5ELBrsyiQvYafIQTfgOyfrnuSWJXG+1Za1fc670Eo07E662gKmkQPhaD7rwm6WZZLZZksRLm9nEVN49NMD5Cu+daJgAwZZVPNIlV0IiO8TSErdL2wAoLUZGrM5tJe18lvaHDfiHwKVVMPX7UPk+Dt+0Ufk502N7vfXQFs0rdho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788583496; c=relaxed/simple;
	bh=9eBQmLiZz5/aIsksAJCPFLDlWwhNxnchlE34WUEIKlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGAC4bgHfp3N1HVh6335+89aCqioVNPYHNsnjcbU/eXy0RcPGIwy+/PhAjespuhwUhKCYoB1OG3s+aNQsq4+AXlCr25E7yvxL9cRX6DKJkYRKWlorV8ygvkWyCE69+hpU6fpKLWONNs7PqdiZfTiTL2xgff1ABm3jcU5aGXAnik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R7CXzKoK; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R7CXzKoK"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cf452def93so26087705ad.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 21:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788583495; cv=none;
        d=google.com; s=arc-20260327;
        b=mkmTZKHvs1yotx9/+Ep0OrczhdUZpTfSJxRpZy4/v2VcxoKX8zhUS9C3gLUUo8Uzq7
         xZ54b6kqHJw5GPDSK4CvbFuHiGMr2Iqu1hl1soazqHPYqzwA1V5a5+htcOMtZfXzzYak
         HrNzMuGSiBxee9N3cFyQ7IqzwG23BLftIonv69dRpkLDuTozugAGowk9rklS0r6BZvaj
         +jT/AyvG8NALQXnNqIOrZwB6zXY6XJ0zGrQFe0wDJ0jDPvdgzKxkPjZBzSs+ufy8bFCx
         ZnjrBC3ljOWscuZ8t0fdna3nnICXjjw8rIaYjhGIr0RUna36DcoBTE6ETxqecp9Qv2sc
         cHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yec2wkYTI62TuJYXEQ0+8mdDG1PAJLsBp2g6HxH5N28=;
        fh=g16rNoxg+Xyd8R39hjpULRJEAcbT4I0AS8U5NZv23Lc=;
        b=RSt75Q3OzXv172iGmftiq10xR/vqJh7fMFhEetcKzdIp+7/v3jxiYtmr5mM6OSglGo
         VgV/Lrs6vRFw8Wbat1ZHQfQaIaE68XLSwBBU3D7qgq3jkVkY8DEZ6HynqqtXryboSKCh
         BGWmQcm0sCojCYnjaauI51PZ2l3VbSggf+9CPOUIAQyk2J8OtWWdYZAUF1ZkMKABXbq9
         f1LfHdYC2m0TWpkMS54+ohKz9D04owEcMcPliXjGMcY7GDp5Oj87MDvNHPKIM1CpnucK
         EriOzwSEC71njuYyMjmZdlVneCXxHIlzgNzCkERZ85q6/6AEvq2FENGOVtXiOOSHwUA+
         aDIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788583495; x=1789188295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yec2wkYTI62TuJYXEQ0+8mdDG1PAJLsBp2g6HxH5N28=;
        b=R7CXzKoKqY+vAPpvjSQp51Rt0BjviEZy9MuHBa73uyWICqhim2wKTPbDFXlb7ZC48j
         8qXgzqTue2VmDe6jKaGPefYs56efzXVega+cfuj3/6EkkMHXeOZzcOiLf3ybm/WKHQeD
         NOPmLiQZzm48HJB6daAH06sDM2XDWw/ZkVLFBn9D3sWoO2Yv+1MAuLPP639pCmALsUNy
         bttAV9xFjKaguOHGdsIFspta4ARAFEzmqeWOxaLD7KkS/ufeQd4hb/iQHrH69AMn+T0N
         OdHwmlogr2puqC+HdTCzzaRDHySR7h521zmNWQWP2WCqEkGNp01PLRVLiCp2ZPhpz6hi
         t02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788583495; x=1789188295;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yec2wkYTI62TuJYXEQ0+8mdDG1PAJLsBp2g6HxH5N28=;
        b=nJznnEI7n01g95PaB9RGY69wYPP3B5KZuWTsLa6XPiEWjSn8GoBK9pf4purJWXrOyD
         szOU751d/a5ZhPMEicX0EwEnwnPBCQ9OPVnAfcR5UcC045zfPgrYzL9KVMdA1FE2dTdR
         Hf0al6L7ms5m0TfEdGmK6VH5d4m/+EgglUxzy7lnPEBEXhhwtWC2PUZ6Z9SWyJ3ejCbT
         Aj/QoGPTN/quAJ/SdIe4r2oOPi9Fad27y7JTRkQ0VdjoKZousBK3HcTctAN1n/6/+xX8
         ctIL3/rZNCNBxVQ4ONGUxsANkU/4wNjs+WzHPzrh7OK+JutYEHH5yJyzt+5Pwkt6UhtB
         nHdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGIMTImMXcEJKRKo9ZOiBgUHh3vM2ilfT796ADomKSsuUgi4DHesDUwCH5F6WU0qQqU9Yt8SM=@vger.kernel.org
X-Gm-Message-State: AFuF++nJAd3hFbvfmvFK4Z7ntavCvUkSjxgn7GIJNIsV/Eb+XvWMOhp/
	jY1OHQpStqoJzKTXRj7KXZFBQYAA03RbJgtbgsmOu8f5Rb37aGaghmsr592TmSwZDe34Dy4bC0T
	T8sr+mAgxVNNYoEXSVrHtivaz0n9/PIUgcOfq8M5c
X-Gm-Gg: AYBFou2Q7LdSz6JwcoS4m+dYBJKJUSkBIh7UQwh0PNQHSfYAv3qzRsSnnZvSGcYpBy5
	PeBXEj7BjEC1fuuLj/7Ip6+LSgAXLVhxI91duEiVanU73IJgqpBt49UJg+Osav5q7L2442TcMEB
	CjRU3hWfouqJOQVnjePOghpnq+II4EJgzsDs6CiAQylrduY+xe9OMqBdRRNcOjJnCbCWJ1y0KDs
	ngxp5Ts2G7WeoZpL3l+CE7MpxzWA6n/DrMdaz/u95wCz+pcrzUszYQKDEyULPYhFwA8JVO0Qbv6
	pqE8U7L7H+LfUcsE2MnUFI2TlKJTOIYQ2sYzx7tQrceXC2t/nojkWt0RH1l04AvxU2CiqiOl3mZ
	UJhq46ycJO9gb7Y0zVMGzTmdgjtIXSO+OD72QumND1lNtvr/uB82MRk2+htBxdNG9Z43gTGulUn
	CjGg1VinzQvgIh
X-Received: by 2002:a17:90b:2751:b0:398:9bd3:d6d4 with SMTP id
 98e67ed59e1d1-39b27ec580fmr8390995a91.14.1788583494164; Fri, 04 Sep 2026
 21:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com> <20260903120840.1024153-9-edumazet@google.com>
In-Reply-To: <20260903120840.1024153-9-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 21:44:42 -0700
X-Gm-Features: AcwNN1VB8pU_JAAzeF0Z4wCpW7VzTr7qv9a0o0m-5Mg8CyFsHzbqaZq-AJ8q0OU
Message-ID: <CAAVpQUD598wOtXKYus=8q_9u2abASFA8zSH1GuFwAy3jSGBmRw@mail.gmail.com>
Subject: Re: [PATCH net-next 8/9] vxlan: remove default_dst and use
 vxlan_config and lowerdev
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:08=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Now that vxlan->cfg is an RCU-protected pointer, storing default
> destination attributes (remote_ip, remote_vni, remote_ifindex) in
> vxlan->default_dst is redundant and creates potential data races for
> lockless readers.
>
> Furthermore, several fields of struct vxlan_rdst (remote_port,
> offloaded, list, rcu, dst_cache) in default_dst were completely unused.
>
> Replace vxlan->default_dst with a 'struct net_device *lowerdev' pointer
> in struct vxlan_dev to track adjacent upper/lower netdev topology under
> RTNL, and switch all remaining users over to reading configuration
> attributes from vxlan->cfg.
>
> Also update mlx5e_tc_tun_get_remote_ifindex() to read remote_ifindex
> from vxlan->cfg under rcu_read_lock().
>
> While updating lowerdev handling in vxlan_changelink(), avoid clobbering
> lowerdev to NULL when unchanged, and properly unlink and clear
> vxlan->lowerdev if the lower device is removed.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

[...]
> @@ -153,22 +158,22 @@ bool vxlan_group_used(struct vxlan_net *vn, struct =
vxlan_dev *dev,
>                         continue;
>
>                 if (family =3D=3D AF_INET &&
> -                   rtnl_dereference(vxlan->vn4_sock) !=3D sock4)
> +                       rtnl_dereference(vxlan->vn4_sock) !=3D sock4)
>                         continue;
>  #if IS_ENABLED(CONFIG_IPV6)
>                 if (family =3D=3D AF_INET6 &&
> -                   rtnl_dereference(vxlan->vn6_sock) !=3D sock6)
> +                       rtnl_dereference(vxlan->vn6_sock) !=3D sock6)

nit: if v2 is needed, the two indentation changes above look unnecessary
