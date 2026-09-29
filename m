Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CEC2C11CF
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 05:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790658342; cv=pass; b=CZKlMVuKIgecM5dRE3ISVjKOmpJ2x/C9aMGYbCODFGQ0ehZebPogPtX1ub50vxl/Ap/+g+l203mC9EHrjf223JQzxn+rrO3mPLNBe6tx70FCh3JXdpTNgLrzGMiIk8AjaS3f7t+9PWoJQYkIz7diKYQ4zWchM9PGl1IUSlPK8O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790658342; c=relaxed/simple;
	bh=OZGwJxvXGlzvtcJC5LTGmTfsd1RyY3scQQJFUPKnA2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qM8W66KAj3LNDuEiMKH1O6AuvLLJyVtD0fJ6PAallaticC5LKI4eTuBQxLoPqvlKrXlzMVBT2rLDwZLA8xrXzIUb7nBMU4PxB+umAkGHImsYk2Iye3aNEyC8DDB9ZsHtBALEo29SDrk8CiWySrRJM0BcnjRGs6r6XEVXDf6TNFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aznSFZZg; arc=pass smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aznSFZZg"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-533245fd18dso21117941cf.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790658340; cv=none;
        d=google.com; s=arc-20260327;
        b=WUrPIQ350ZPbYmFT1lqPYJztXrMUzXTOMqz1aT75mwmjQYrAFifSflNxNmxrCp1phF
         BYf5tqJoki6/nP95IEvdVbnawPalRa3cdauJ7izwHKghFTUIC2XyCN8Q5K9We145As54
         Yfs90Jtu5RGfdyMaFUNCjHRJ1ojLoCg8RNkApZRA1dP46ye4uyF3Tsj8QdkEbBylBzsh
         bOmz4kcsmEIfX7+bNzlJR+RYJA7e0iGVazx/SlBxQWbVcfqqwY864GzEmmrFFpd1kKal
         FfNj872/D4G7jm0RQvz2J3LOppXPjBLRy6iVduCQ38qFOapve4BeBiFetjgkcdvAZ/Bv
         T4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bc5OGVcjd1h34e4xLBzYwlsH1awYHKwjkeVOY24F3Sw=;
        fh=hZMSDBH3AMsLydNLWIvzIqNWChfYg8yLsCmsQ+ec2c0=;
        b=SHs5HArXagO8T5qgkfFEmH4JLiWVzh29OG3/JGdMS1ef9Xf5tWJ6aqk4Erf32ca17C
         M4nva0lcQVS7W7dlchdNKua5z03HyMFmpIKez6t7YsQrF2mXUJVoDks6yBic5U0EMYIZ
         HvAIVQX7eBX9V9IDca1FD4i+ybZPHfzDLdOmjnYh26CH7mJa/NYWB4wQGAYsD0j7TdCy
         WL7i242sxvkRcDP8XIYs6bZhSruDUkHGt49u+AOJ7RgHiQ04c/c2iJ9GQsum0RA1bAVN
         yMzLVi733ly1eIpwrpwXcu19y3EosvKNqgLlcsgY9mhZ0BWX7A8fmVc6ss81iyOhmUwV
         LQYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790658340; x=1791263140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bc5OGVcjd1h34e4xLBzYwlsH1awYHKwjkeVOY24F3Sw=;
        b=aznSFZZgB/2kcXVNA+Jcn7UHtCxb1cCzR42xzZSN7x6o+evCR44W1GCP3OKG/xUnMy
         kDxHBdVHzQZ1r+zrrcuEwWlNUrsUjVdq/nPe/tDPTzD/iKz4TjVJWuAOykvcNVRxv/OS
         SS7SRt2FmVHHYnQSlhehUbUf4mRj2Fqi350P6mKM8g7+7pscRX0PJzdZW/5m81XnT+Vr
         7ebplkcC6/WVYSkeJhSPabAmGRRg6p+9IrgKuETjfC6DDuwANg/axzgOtlsG2S5DSBXj
         CAvtBwA3sFlgKD7+GJP6Qmf56lTzVBOwDpYAWvgxGNpneUXT9lco5tnaNTr4654YoYUd
         J/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790658340; x=1791263140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bc5OGVcjd1h34e4xLBzYwlsH1awYHKwjkeVOY24F3Sw=;
        b=1C840eJ1WnuCA/Bj/zo9xK3vunxH8LWlaMHU85lQaEv5cIZR4n5wN59sn3ZA8f00zk
         oQosA5InkB5ooEsvemCrneRvz5lxOWIFtzQ1Xo7y2a+U/3A8mr5Eab7Vm+kQqamNI7h4
         Dh7/1Y9VIMlNelDIsFtDaohURzLe6EDANxpS/OteJtdAEnhyBDbjKzCebPh3XaDfkDLz
         6UQ6vO6xvwEseaaoOB6DrfFjePTtKb7gH180DFULivabw7yN5VtZIigImN/kt3rv9NY1
         v98hZ1T9g0yyu+7Qaz/jBlby87h9oxYNGkY7y9JSbA4fTRgUQf+jO8Z844sRjNG3j5Ve
         VhSw==
X-Forwarded-Encrypted: i=1; AKwUvBxezpUmacZwdM7iyQxiy9Eh8GXHRhel9cU7wgWUo4muklm/rRyy145WO1up+Zry/6wqV+No/o8=@vger.kernel.org
X-Gm-Message-State: AFuF++mZtXcXeB3DjSb2Ln8CEIc4NrNqpT1ck+lVjb8uxHDi3dxUIdFi
	QluyzMCamdd0vfY8vmkJnONdM6aOU6igRr/YFJy979fKANP71aVlHsAe/fqnaXLxlhs0H7eVt7S
	KcdHqbDaHQKNIXCTr0Y+wt5gjikChH/RYGRd5b8s6
X-Gm-Gg: AYBFou1LH90Td8/5VM6xaCVG9AWJoEO6hLv3j+shs60cLwIzE9L40SgCObpR2Ey8gcB
	dXxP50taTt8vE81wVoKv2V4xfBmUAXr13oL3YvbMamI5ZyNGXBI13xy8riMo/ZNQ5MG3UdWMrIa
	K3o06PdfPUjJoWPM6V+wp5ksEiibGQUEn3kRN5Z4hUK6NZS+27IuRmqzCkXY5+a1EzYkoMYRgZs
	CfCetNS+aMsS/R5vxhRx5JkkjO8hv/qB3qxYEw7q8sKvomDNCA5G5GTX/ziJJetTBLgqlikVOFY
	1vpDpGpYchK6HA/9Lm4yq1YrC/RevwFwqIXW4NubUhr1lyW8Aov7x0YP5QavPhGSe1fIrL148Xz
	1oZVK3WjGiPWnli+x3k/DeEaGxCmpF2T8D7plpzz4eMl1hY2reQ8dObPkBiuEBxcf41frv7gp4R
	YDtl0=
X-Received: by 2002:a05:622a:156:b0:532:9eb6:8498 with SMTP id
 d75a77b69052e-5330b5f1b5dmr247699041cf.22.1790658336811; Mon, 28 Sep 2026
 22:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928210508.2645800-1-kishorg@google.com>
In-Reply-To: <20260928210508.2645800-1-kishorg@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Sep 2026 07:05:24 +0200
X-Gm-Features: AclHuK9rlweGa5LfZkECvSpI6VBx8IK8F4pmxelwJsp0a3K9tTEuA2Bo7ZpbcHg
Message-ID: <CANn89iJG8jhgLV3e_tj9cBWaDAWVHL4mrEroT2FHse==OJwTSQ@mail.gmail.com>
Subject: Re: [PATCH] ipvlan: no longer rely on RTNL in ipvlan_nl_fillinfo()
To: Kishore Gummadidala <kishorg@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:05=E2=80=AFPM Kishore Gummadidala <kishorg@googl=
e.com> wrote:
>
> ipvlan_nl_fillinfo() currently relies on RTNL being held because it
> calls ipvlan_port_get_rtnl(ipvlan->phy_dev) to retrieve the ipvl_port,
> forcing "ip link show" dumps to hold RTNL.
>
> However, ipvlan->port is already initialized in ipvlan_init() with a
> reference on port->count and remains valid until ipvlan_uninit(), after
> the net_device has been unregistered. Both ipvlan_nl_fillinfo() and
> ipvlan_nl_changelink() can therefore use ipvlan->port directly without
> dereferencing phy_dev->rx_handler_data or checking for a NULL port.
>
> In addition, port->mode and port->flags are updated under RTNL (via
> ipvlan_link_new(), ipvlan_nl_changelink(), and ipvlan_set_port_mode()),
> while being read locklessly from the data path and from
> ipvlan_nl_fillinfo():
> - ipvlan_queue_xmit(), ipvlan_handle_frame(), and ipvlan_skb_to_addr()
>   read port->mode,
> - ipvlan_is_private() and ipvlan_is_vepa() read port->flags.
>
> Furthermore, ipvlan_nl_changelink() previously updated port->flags via
> separate read-modify-write calls for IPVLAN_F_PRIVATE and IPVLAN_F_VEPA,
> which could publish an intermediate value to concurrent readers. Since
> ipvlan_nl_validate() already validates that only those two flags exist
> and are mutually exclusive, replace the bit-manipulation helpers with a
> single WRITE_ONCE(port->flags, ...) in ipvlan_nl_changelink() (matching
> ipvlan_link_new()) and remove the unused ipvlan_{mark,clear}_{private,
> vepa}() helpers.
>
> Annotate all remaining accesses to port->mode and port->flags with
> READ_ONCE() and WRITE_ONCE(), caching READ_ONCE(port->mode) in a local
> variable in ipvlan_queue_xmit() and ipvlan_handle_frame() so the switch
> statement and fallback WARN_ONCE() observe a consistent value.
>
> Finally, add const qualifiers to local pointers in ipvlan_nl_fillinfo().
>
> Signed-off-by: Kishore Gummadidala <kishorg@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Please include the target tree in the subject ([PATCH net-next]) as
instructed in Documentation/process/maintainer-netdev.rst

As a follow-up, ipvlan_xmit_mode_l2() and ipvlan_xmit_mode_l3() could
read port->flags once, instead of calling ipvlan_is_vepa() then
ipvlan_is_private(), so that a concurrent changelink cannot be observed
half-way (vepa from the old value, private from the new one).

Thanks!
