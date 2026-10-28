Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793186117;
	b=hLjypYdaa7Ob4e4mlJxdAU58pTDbklCoF9pr0GlrSPXwRs3J7om1Dd2VaXdszV3rKCT8
	 BOkFhRMu/+7IWgjxpgIOOTMIl9/I4b6sQ1g9B6FxurEO6dreLW0CjGVx+SAs7Ya1rx5hA
	 9QycWYIWG/mVBwSsvjrTcJUceBl+42Gsl9pBM9ZGc+yma+DvRf74OS+eEx2A7UiMXeaY4
	 hpo5vq1he3Y0zBgTqFa43uSbxFlYViISDyr3zNedmTWUaWXLDo3snH7ZOKUqgpoTklOxt
	 jzFCwMbxTF7W/gPzMDUjwoxE6uJ9f7PqLLADTFkMijg1hoULp+MWK95N4WCUhIJC0gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZOikoK9pLB7UPx0y1qeQcSSrhrinRq1fypsrrRrVk/s=;
	b=K7JCgEye6XFhFxzWbweFNN1V+f49tS+gnU8EVnYpq9cinWmXkpauMeTDBrJT5XbRqIgb
	 AZsj4tqvY18JAOWIBhRENMeSA/BhzXc00W49ac4kWxNU1XxhqMm1GgoRVFWbJip3ruyXO
	 jvBK4zh9uFt4lD4YhdpOEi6USPaMjAeJlSrIcNj20r6PPsl0YUFOZr4hzL/ZRhS744h79
	 7I6Z3Ibo24TGB5Zt7Q5EPP5dHK9SpijGmfo1aYB705FdMKY4Fpet+A2cIC0Z+QpgU8bfs
	 xWxgiOC9dMm3l6ViQ7qVamA/QTU1WNe3v92nj2/jHBNcozWGq4ZNfmk+0Vp1gm07pNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rzQIsDwB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.68
Received: from mail-lr2-f4.google.com (mail-lr2-f4.google.com [74.125.230.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D831F606A31F
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 11:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D831F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rzQIsDwB
Received: by mail-lr2-f4.google.com with SMTP id 38308e7fff4ca-3ac4f373d3bso5849741fa.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 04:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793186115; cv=none;
        d=google.com; s=arc-20260327;
        b=ANuzObvoVZy0h9MmlTtJuGwV55srh7hlyA3uBZhka8JdwXE+en6tLO0bVuxCkPH2qZ
         c14h6/l6yGDFOKIzWxAm9ZcDc6XVNs0KYwKW9MlHEYuNnZurBBiycqxEWzMGnMg3Gfm9
         KImVSf7aSuVhhgwZofTQC1cDPkqCy0cU93NIKK6Zlr6TjLmmqfmMbUMg0UkfQCns+aYF
         f9bVNYNbQpGSrNbiKB4kwmrvITWbTUtp3b0J51al3V+HvxxgKqS+9hjVzi7wuut5wcRi
         JWmqfbvLVDKx0uy93XOjnH9bPF3vARaHvOQQE7dW+bcIbGjy1t59FaWVxf5BVo/GD31h
         iGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZOikoK9pLB7UPx0y1qeQcSSrhrinRq1fypsrrRrVk/s=;
        fh=EOHxmNQOMujleUciJrvUZnwEEIiA6D3UMns0+p9Exkc=;
        b=pMEtYhcTpSdCDeG6ZLNXKSOuHA6fcLJnJlYG2cYTP1E6i9TQcIBURVflbJm21m4Itc
         2K7zocScvL0lWp0L6Gqnw0tlNuy937yJmzwNlrhpqOF6Qj3vI5p3vD1WJxTfEm2/4QcT
         tv4w6j+q1S+6PByO50GUkHnfpc/JkP8sVnRQucW4V7v+dl1N1itcwDWI4BQNgLFRdGdx
         XTna050oMa+3CZhxMU5R++BHmGWFnQr1SHwrBsxwDKtfwrQyDOONAvCwKvaZ2wKBgCNY
         kqcfbEjNnwQqkhg897BXstz9DGYHMeTKb3BcpKd4m91OUrnjLNpjuP/TL37xNGwiLfmw
         2OHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793186115; x=1793790915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZOikoK9pLB7UPx0y1qeQcSSrhrinRq1fypsrrRrVk/s=;
        b=rzQIsDwBwCplstVYmf5uOTdn9PRKLTHQCl4xktYTsC2nDiNY6PdT8wz8JUCpSipCYG
         eqFFyKXB8JR/Z3Te4Ex5Bm7IbzJv3ZJ3ruW+9pqqLXveqoq1708QblL3TWSS6Sltj1ad
         Uwbf3So308mFMpVjzWgeyghzTbvqngqt2gplI/3WQpbfmuXu+pHieXQM99KD+rljsvmb
         f1sK9gYFJ2QyLBmr41jRCS/iGO2ZrNHZWziGAT5sfDHwMSoeppJ7OLcIqHU6dXX7IiQR
         mb1jg+oUcUneR5JfP9ncSKbHIZgEn1S7o51xBdlbry/rZ3h+935BfLUxGItd0rN573ML
         KCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793186115; x=1793790915;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZOikoK9pLB7UPx0y1qeQcSSrhrinRq1fypsrrRrVk/s=;
        b=0NSEwTOOSrBmZc21AL27WsQ5luu/FDKenIFQAlCIL7JdyjrdExpZ0JLqtGgg1nIywU
         5yT0yYDp0p4Nm2bmppAcuQXPAFI+g9zkmEIeMD0YHgqCdJ5VPXqay5jB/3lRrCcCY80+
         RS+xdq6CDnqMfY7KQYJ43IdG6qQdEBcuFxd+B2pfyql7YlIlB0fsl+rJQ6aeCuZtZrKO
         fFc94p/8Ce2IjmgKHMFO++b4aWyBHYVGxMP099YzEAZwncklF3PKXqiyZ/lNPVjLy3rC
         j6zvyYkOXvf5UR/jV5H7LoMPqDczJ2VDhS2xEXSP4GcJtF17rlNM9LWzjP4TVBOti8Xd
         Efew==
X-Forwarded-Encrypted: i=1; AKwUvBy1KJA1P/IWueGmZf5UklZtnZ1vEaz0Hxrdj/VuA2GRi7Z1xmrj8Ju4YaU5uRgAIewpuWuveWM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmLhSWayHT3MBdTrEnqJbUlHujAFP92QqcxPHepy0y4NmkxwYs
	JrW9Ay1Q0oSnE1IP7fi/KaJvctgFJbcpRQYMziwoENVQ4Yv5PBw16KUR6c0wLlG2PSY/PL7Fcqo
	4Bha9PmWMr4KE8BjHDJFDlzb5AFNYA8M=
X-Gm-Gg: AYBFou1oXw9fnYXIXjRi51cHCdFJbP2C7p3Hylo85cejr7Lqcz0Q67PEk9Cm+p6lmGf
	uRzDohkZ94uSkC6tP0S33rg9ZwOdll9HUXwgpEiH76+nzYVLtL1ve7Lr0MIxSuazWDOVs9JJmfq
	yKJfAh9pSu5YSYlzFQyfqq0XyEDGyxxziiM1d07fbigBfd2/diJ0V3XzFneatjjJm4P24LCApLz
	aCHtwTdSvBQapk0b41hZ8t1oeUVMNfDS6Jco9jYXCK/clo9svibMA4eNGOT0YZ6e1TPqxwtCJn4
	Fe87eJnk89vRZRbcL+Q0NUKjBfMD0I0Onzd5azCQdXhtuYTkMGYrPj0m41wEAHacz7+rmGAsj09
	apf2G5x2rK/B3DsdTeUC0u0EBNWkvFyEPPrV6bw==
X-Received: by 2002:a05:6512:401a:b0:5be:50d7:60f with SMTP id
 2adb3069b0e04-5bfcad45638mr900808e87.27.1793186114373; Wed, 28 Oct 2026
 04:15:14 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027104713.328028-2-bsdhenrymartin@gmail.com> <202610281752.nKGCORKp-lkp@intel.com>
In-Reply-To: <202610281752.nKGCORKp-lkp@intel.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Wed, 28 Oct 2026 19:15:02 +0800
X-Gm-Features: AclHuK-ZGaxYqXYmXJ3b4_5omqV-rK1XApFuPnTHkxfYrM3u6ZjLmyd_d7Xp8AU
Message-ID: <CAEnQdOq52vUT2gw9SeD=Lo0sf9Oesqs=dLCV1yYK2zrfyW6MHQ@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] vxlan: reject VNI add when the default fdb
 entry is nexthop-backed
To: kernel test robot <lkp@intel.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Ilya Maximets <i.maximets@ovn.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Petr Machata <petrm@nvidia.com>, 
	Ferruh Yigit <ferruh.yigit@amd.com>, Antoine Tenart <atenart@redhat.com>, 
	Seungwon Bae <qotmddnjs@gmail.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Build failure confirmed: vxlan->cfg became an RCU-managed pointer in
current net/main, so .cfg.remote_ip no longer compiles.

v5 uses the function-local cfg pointer (&cfg->remote_ip) instead.
[1/2] unchanged, both dry-run applied on net/main, checkpatch clean.

Regards,
Henry

kernel test robot <lkp@intel.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=B8=89 17:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Henry,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Henry-Martin/vxlan=
-reject-VNI-add-when-the-default-fdb-entry-is-nexthop-backed/20261027-18471=
3
> base:   net/main
> patch link:    https://lore.kernel.org/r/20261027104713.328028-2-bsdhenry=
martin%40gmail.com
> patch subject: [PATCH net v4 2/2] vxlan: reject VNI add when the default =
fdb entry is nexthop-backed
> config: riscv-defconfig (https://download.01.org/0day-ci/archive/20261028=
/202610281752.nKGCORKp-lkp@intel.com/config)
> compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 1=
da436a23e613c425fc9b868fc8deb979ede47a4)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20261028/202610281752.nKGCORKp-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202610281752.nKGCORKp-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> drivers/net/vxlan/vxlan_vnifilter.c:846:33: error: member reference ty=
pe 'struct vxlan_config *' is a pointer; did you mean to use '->'?
>      846 |             !vxlan_addr_any(&vxlan->cfg.remote_ip)) {
>          |                              ~~~~~~~~~~^
>          |                                        ->
>    1 error generated.
>
>
> vim +846 drivers/net/vxlan/vxlan_vnifilter.c
>
>    819
>    820  static int vxlan_vni_add(struct vxlan_dev *vxlan,
>    821                           struct vxlan_vni_group *vg,
>    822                           u32 vni, union vxlan_addr *group,
>    823                           struct netlink_ext_ack *extack)
>    824  {
>    825          const struct vxlan_config *cfg =3D rtnl_dereference(vxlan=
->cfg);
>    826          struct vxlan_vni_node *vninode;
>    827          __be32 v =3D cpu_to_be32(vni);
>    828          bool changed =3D false;
>    829          int err =3D 0;
>    830
>    831          if (vxlan_vnifilter_lookup(vxlan, v))
>    832                  return vxlan_vni_update(vxlan, vg, v, group, &cha=
nged, extack);
>    833
>    834          err =3D vxlan_vni_in_use(vxlan->net, vxlan, cfg, v);
>    835          if (err) {
>    836                  NL_SET_ERR_MSG(extack, "VNI in use");
>    837                  return err;
>    838          }
>    839
>    840          /* A default fdb entry that is backed by a nexthop group =
can
>    841           * never take a remote; reject before the VNI is installe=
d,
>    842           * otherwise a failure in vxlan_vni_update_group() would =
leave
>    843           * the VNI half-installed.
>    844           */
>    845          if ((group && !vxlan_addr_any(group)) ||
>  > 846              !vxlan_addr_any(&vxlan->cfg.remote_ip)) {
>    847                  if (vxlan_fdb_entry_nh_backed(vxlan, all_zeros_ma=
c, v)) {
>    848                          NL_SET_ERR_MSG(extack,
>    849                                         "Cannot add a remote to a =
nexthop fdb entry");
>    850                          return -EOPNOTSUPP;
>    851                  }
>    852          }
>    853
>    854          vninode =3D vxlan_vni_alloc(vxlan, v);
>    855          if (!vninode)
>    856                  return -ENOMEM;
>    857
>    858          err =3D rhashtable_lookup_insert_fast(&vg->vni_hash,
>    859                                              &vninode->vnode,
>    860                                              vxlan_vni_rht_params)=
;
>    861          if (err) {
>    862                  vxlan_vni_free(vninode);
>    863                  return err;
>    864          }
>    865
>    866          __vxlan_vni_add_list(vxlan, vg, vninode);
>    867
>    868          if (vxlan->dev->flags & IFF_UP)
>    869                  vxlan_vs_add_del_vninode(vxlan, vninode, false);
>    870
>    871          err =3D vxlan_vni_update_group(vxlan, vninode, group, tru=
e, &changed,
>    872                                       extack);
>    873
>    874          vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);
>    875
>    876          return err;
>    877  }
>    878
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
