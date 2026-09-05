Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C655478D
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 04:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788583930; cv=pass; b=mMVNRFrMcfqKBc1yKklwhDaXpWgH/gxqu7iV1daAGhRQiD9uA2s29cycRUiEzMJJKRqVtL4oWCpisL9jaKuE+Vv0P+QvgIh32PCYSCc/a03SsmCqKFW0r8wdGmyqiHD9J6FKOGAbpL1Bj3WXSLlVMJoIvpubxJbOmX3cV1Vnei8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788583930; c=relaxed/simple;
	bh=y80Px4pt0OFCmExi9dcmWZaGDzftiuP0nopqUMT71AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0JXOjE1Lj/Mcb9/uY6DkyJRW8e8sV8r9hlf2UNY/PgL7lGB6TfxloeClPGqpn7kbi6TOePoICsUT8D6XiAUz+70fpJYpcO2015bjaqV3N97CNijktIZZlnvhllhAq7Il2IsDjeR5N/wInVa5luALxKonQy81/Vn/5kgRAn9SXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZyisZo7; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZyisZo7"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1cbb64a1fso1736569a12.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 21:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788583929; cv=none;
        d=google.com; s=arc-20260327;
        b=TQT1Pz/eUxNVMLywH3giwJyLQR3tZp5nxW24hIm8zvxtZBZJvopPwiPxmyYisJXjnU
         MUeMo4fczpfSzjzb3noB8spYZlhp6n77gm5VR2qVW0spmwgYBFYDI9i4OiTRhdAabDvJ
         SX8TtOp7m9VsgjAG2mQR3gWo4CNEXWLq+UPFTLkW2bEeQmVJtETxSHiUGTF04FNkK29u
         adybY673X2MFdAc9YlKr3v96Lc9imvuB3K/ujupZ3kyjzGVlyFC1xtEJ/DV/FOzJfo/d
         ERrzAAJFIy0GsFdGdvJK+qQbZLA2+8ho8DrqbB1YlUv4ZD5sPqt9wzq9G5nd13CRLSKm
         yaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=33DyaU70fd75I1kACblOtNYboJUgdYnVeSkoXL4fGOk=;
        fh=ZSRsrhygOyhCxlpNn0BqDCSSXarxrdSWnb9q3YBrCTA=;
        b=h0f+1OsIULckJ5Ej/s5a09AoTOn82yRLmOTQFzYBjrk+RBWRMGNwhUvF7oEVxyGi9Y
         IH8x8bQgoPsgZGdV4XE04YEnFvyrahbHeVPmErqzSkEYeX47g8JSSpndZRPn9lvdMnt8
         qU36zNDGcmBVQywyzxNGEeZ239KDxu6yh2pv7v3H299zbrc4rcseMIG3OUsme/MQM4Of
         T5jQnrebn0r8WZLcc9JjtARgU6N6DLQlTPMeV4jaY1YAAQmaN7JaD6Y4TaPUBF0/Kzbq
         FgOAqDDhjW9WU5zycur8A1wTToL5sx4HGi8ifKZ0MYeptWmgAO3kfOtWqBDGsvH7Rxaw
         eUBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788583929; x=1789188729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=33DyaU70fd75I1kACblOtNYboJUgdYnVeSkoXL4fGOk=;
        b=FZyisZo7GF9P5WachfEiDsD5HEXyqYZWgk7d6c9l4EzbGvTmZ4iOphq7yf7+uOWhUt
         ixZEPhaKaB0tLoqk49jYkWzu5wA4EO1lvXJZp0BstuoFliAn1esE8HWJF4TTYHsp8Ejw
         ESikorwhe/lPoOPUwasBSP08Wj4NlnlXQpQPdYbEUh0IQLVnUWihbXuI6ezCcrgZ/pda
         JhTeXCQ3NAlkm6QGjxYfaYlGGvT6HGNHAfEwo6b/yigfSke+8VNFYT47PRNpurm59jjY
         AWPAhK7OsHaVJ4xiMJAcfjhmmv4CxonZTfk/F2S8bgdVHALGFBI3mp4YWO4nlznXO72S
         vnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788583929; x=1789188729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=33DyaU70fd75I1kACblOtNYboJUgdYnVeSkoXL4fGOk=;
        b=nKXEniutpSkEJRwWWYe14vmlg8jV3n2Oa6JcdkGdxAzi09AH6cRLzJ0m8MH4XIU0+N
         nOWlJBu1MXPIXoCvgaUXt815/dByrGbXuU6Xlwi2iq5pL2U1OJBaK3zo6D6m9P0PjZph
         n64Xu3fiv7SyNit9hjUXsLyDS0Bp0yZtwLMyccmxEIkLVZKRtV9hJqRfx2b3Sf9DyHSZ
         RL6ZfyFPgeUjkuCoa7Ywe8uTLghKLWlUMW9IqPWH9w3pXXHdgUdLwq4jpfsQDebrnDzE
         alfFA+34zjhOH/ohoB9JsyzynNsIOSmY07BG87OJdatNvnGpk809kyooGBt2dKpxbikg
         /nGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDVSIuotDdHFF7s8wt5HZZ0KZCc9Ddfyq2w2+IEgX//D9l1+6g4OKgVudV1Tf+U8ssdBVSQkM=@vger.kernel.org
X-Gm-Message-State: AFuF++kduH0/xXyUVCF7fNtjbSed6T2lRq5MUGEp2VqIYw8KaxNA4tBP
	WqVWNUKas5kft0/a/pU5fNZHq7V4t4NDwF6/zTj1JJsJxUj/MvoIGkYzHs8JByzQyu2xrgcDJcb
	QU3Yqi4TLt37QCGmvu5RfOdmBAv/6Q7QJTVmVXR6L
X-Gm-Gg: AYBFou0M7k10Cw6eKj7krCdzAsBcIQmjXUE5QiXaiqGoLcjbhPXSariU/+MxvkYMXp7
	aXfg5uQhp90+4eZt2tGNqQca0wYAdLvAX2JQ+jxyRMEhrZDMt2xWrExNyw+UMuN5rbm9aQ2tdA+
	ACx84K3QkPKDw6Qz8xNiZFQt3BSfKXZsc2rCx/xR55FP9o3GVo7lbPlPk9FMsW5fOEysOc/kLWz
	dGkELvq96yvvVYWG7I9fTzr4MLkywNmzr/J8a5heSPTGwlW9FJO/HqdJEicjdR/XLERQ409G8+U
	OmNndN29OpoWkUrQr8YsjlNZoPI7LvQXBYsp31LvAAAK12l26DYIZT9B6H9k7D6l0lFg6JWede3
	B1QLGYWS+SDwkyLq3tcvINOvzTnpuMb5Gu2wBAkrBpGbCe9VYlaFQcMUz8Gq845e/cn2n7jFA6L
	85u6S/wVnQ2plL
X-Received: by 2002:a05:6a20:9d93:b0:3d3:ae40:51e8 with SMTP id
 adf61e73a8af0-3da3a104d63mr14705883637.28.1788583928109; Fri, 04 Sep 2026
 21:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com> <20260903120840.1024153-3-edumazet@google.com>
In-Reply-To: <20260903120840.1024153-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 21:51:56 -0700
X-Gm-Features: AcwNN1UY2BkgE2VICFi_D2_Ru-jI9EYMN4LYrDuDuo-fA99gIoTtXaanktyM3iw
Message-ID: <CAAVpQUBdXcxpGob6roJn=MbV+AZHmUKPE0=ferg9a4jGpc2ouA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/9] vxlan: vnifilter: free vxlan_vni_group via
 RCU in vxlan_vnigroup_uninit()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:08=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> vxlan->vnigrp is an RCU-protected pointer accessed locklessly under
> rcu_read_lock() in vxlan_vnifilter_dump_dev().
>
> Currently, vxlan_vnigroup_uninit() frees struct vxlan_vni_group
> synchronously via kfree(vg). If a VXLAN device is deleted concurrently
> with an RTM_GETTUNNEL dump, vxlan_vnifilter_dump_dev() can suffer a
> use-after-free when reading vg->num_vnis or walking vg->vni_list.

In unregister_netdevice_many_notify(), does synchronize_net() after
unlist_netdevice() wait for the reader to complete before ->ndo_uninit() ?


>
> Fix this by clearing vxlan->vnigrp with rcu_assign_pointer() and freeing
> vg after an RCU grace period using kfree_rcu().
>
> Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata de=
vice")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  drivers/net/vxlan/vxlan_vnifilter.c | 3 ++-
>  include/net/vxlan.h                 | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxla=
n_vnifilter.c
> index dd94085e088656d27b62420a5c8c95c609510a4c..ddfa24ad16f9303d7796e4a19=
9b16dd5cc62047c 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -902,6 +902,7 @@ void vxlan_vnigroup_uninit(struct vxlan_dev *vxlan)
>         struct vxlan_vni_group *vg;
>
>         vg =3D rtnl_dereference(vxlan->vnigrp);
> +       rcu_assign_pointer(vxlan->vnigrp, NULL);
>         list_for_each_entry_safe(v, tmp, &vg->vni_list, vlist) {
>                 rhashtable_remove_fast(&vg->vni_hash, &v->vnode,
>                                        vxlan_vni_rht_params);
> @@ -914,7 +915,7 @@ void vxlan_vnigroup_uninit(struct vxlan_dev *vxlan)
>                 call_rcu(&v->rcu, vxlan_vni_node_rcu_free);
>         }
>         rhashtable_destroy(&vg->vni_hash);
> -       kfree(vg);
> +       kfree_rcu(vg, rcu);
>  }
>
>  int vxlan_vnigroup_init(struct vxlan_dev *vxlan)
> diff --git a/include/net/vxlan.h b/include/net/vxlan.h
> index 7b82075055237058d231d636698f640c75c521af..f41db72e9229d9cc8460ddbe2=
65c6cd07890032d 100644
> --- a/include/net/vxlan.h
> +++ b/include/net/vxlan.h
> @@ -279,6 +279,7 @@ struct vxlan_vni_group {
>         struct rhashtable       vni_hash;
>         struct list_head        vni_list;
>         u32                     num_vnis;
> +       struct rcu_head         rcu;
>  };
>
>  /* Pseudo network device */
> --
> 2.55.0.970.g62bdec98f9-goog
>
