Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E602BF3F3
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788579735; cv=pass; b=KjENH3OgY6xJxfPFSVPHICOjwomxmMn+xhGLyzIzGoADOUgH3GU320OyarCm/ez74SrOkVKpc9f7829FajHbDhHmJ/Z/rinPgbaHDbK6BtxesrYGjGZFn4cryTrMMw5vBnVUO6H6L9rferej47TfCw+D9qUVa5aBnzUUyWtOwCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788579735; c=relaxed/simple;
	bh=eL9fn1W4He0UBXOtT+mMOXnqac2e+1+1H8CntfVIB8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXVBtX2A84CwkR7k7dC61TCKIOcvVd8o7d7hiBJ8Kpu1UDhTKpWGAHW1eT6S/Cd4Bl25njbuctQa42eOwMCW+ZA1qyCho+J7z7gOIGhtKPhnGv9xwXMIYkG1hr3zJVNZuYJ2GE1vEuoInve235GM4h0WvHozTuz+DAEAPU6KH1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=glZzxDI+; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="glZzxDI+"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1622979a91.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 20:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788579733; cv=none;
        d=google.com; s=arc-20260327;
        b=TjRXnXRvsRP5ayPKuVa78t7zyvnm8+D2f5rEhIONhEe5Ym53DIeul4W1ejdPkLLNWT
         P84FUD/Sp9RYQJ+nzzyvW4OFsNHHRxLJXDcyYz7yEEVgGAYQ8YSy8niXULhzkzoro+G/
         zxRACGiRoPxYX5FXRlvd376lAaMv0a1VhUUQOL538GumkidVBnU6jOh3cqMETYtil3tX
         XSZ1UUM1JkxosTPou9rIvd6nLNyGmlREuVXF4vm294/dSop8wpXe8+nqAnYT7yOxuCit
         NHY9l2ARCeus0fwzKBWEEprueyAK9zXs7RosirjjOUa2mV70v9nK78UPuZMdtNaw7a1i
         PPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lFcNtl/9lEV/H1t2gJj6LU/0VdwFqrp5ZU7Q9VoluHM=;
        fh=ijep2JJ7HrL16sjv8hVFPfEPsjxRnwEa4pyLYqKJTSc=;
        b=GHntyuxk2gT02IbncydYOISefY0q5UC1/fMAagrhxwCrohdNu+Yc8OWBmMRw7XRlXv
         74ZDrpY/7VhnKjDjtwREMjJjjP9wh67FZh9NVM4xYqhgS7yamdNzweup7Bs5Tg8B66yO
         FY3lLuaZU8s0NPpWTUx5xiVZ/5ksPDPb92hoiz345xc0Tk6D/p/DYSLWRQarT+3tSVm0
         8eYl1p8I/ALF08Pak55H1ki0zsQW8V0FzXf/cBtrGxpMN6Cg5pwyajJBhgxLLcCAZcod
         c84xUHlWhDbXtTfGOBh/Wz/xou4Sk4d9wmZA02SnhtUDJx1oIhmvp2910ezOSogRjdy1
         V7SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788579733; x=1789184533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lFcNtl/9lEV/H1t2gJj6LU/0VdwFqrp5ZU7Q9VoluHM=;
        b=glZzxDI+SbxkKYqqHbYlXDNwLoZDDGCILiaM6VlifKlnymnBFlwu+ACidQf5/oVkYa
         8jHwMjFDLlSnPdgUob9DZC434GYak2QWs+U/uaFNFOziwIRFXkwc07H5WEd3Xe+5NVuV
         /y+SW2rWIuppUJT5sLqipLJtUEyld6VbIfpAVVenjGcp1PO0PfCHubs5fhTXGxmDmhIq
         b0T2gWp6xa71okcVR/fHiyV/GbyPTuuMgLLtMihOXcusVJ5zF26eeWjF82sib11Wn2ID
         o1G6fsAWMmbELWjHB7xHzEr+fQKQDqFv6LpYFUXBySjMD1X8RP/pUWB/qhoZ9gdo2XWs
         L/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788579733; x=1789184533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lFcNtl/9lEV/H1t2gJj6LU/0VdwFqrp5ZU7Q9VoluHM=;
        b=lGdT9ndOPwzJSxK1x72SsE+PxjPil5fcXHn+bQpRzGsDW+SSmRfjq9uyHTawq9rTET
         AfHl3xfVQ7fuFGlrZWLpcrS2A4zjOeKYBQsz9gKf4RaKYx4R2mHJiInUF61PUaA74Dg3
         6IplJUp1udPYn4pLHaYUYZZQVc7ip7UM0wJiVcBck9UZxRu6ig+HOzKwzrZ08+x2MFhh
         qG6EJrsJxvFksePhXbM9a4zpM+HbGCaZmXwepew3Wfwg6JrMbim5/OPEli5N8Cm/OfDM
         2VbeeTiijs9DGsYe3DVENFFuCr1AVM2upwkLrmMqbogrw4+cRRK9DM/pJgZjmNxejqrU
         JfzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxUuV0vlLlZ+CPL+mFV8i+xjhOHYJANTt1HRZuyouaW6gI/OGFpRAdQdUqwTtS+XShsiLWuhgY=@vger.kernel.org
X-Gm-Message-State: AFuF++mgM/uhLOVdHO91ARL3iDeSpRUxlH5C40kmXNtAHoxiN3zRopb8
	DMO6P8PSf/o5ONJbB8c+A/Uufyi9hfJmrwHZIO+Ca0vrqANcuWUW4HwGxnpMKvqrnWzRQyjQKcA
	IrkzDh8t49vpP7b93Et+RcVMviFuepGQ45Hxkx2wg
X-Gm-Gg: AYBFou31PoKa1covXHpP+tU0A97J2842jwwFimyjV7/0g64Djtt4x51XC3bJaPR+jpv
	2GpFaRK4D0BisbOCVZwJO+Qcp1DyYmY1Kkku/Go3KKS36aBgsCyUnuKhA4eKJnvxhQ2E7t1mhZC
	t5JM8dJzJqddCpx3kg3R3ulvT63OGIZnMUlWSkf+2pT26bveaFHelQRjLq4JG5KSual6dhk+ow9
	LINSP91dpLKBfa2ygJ/a+mjDIHhKp1cFyvQjgysla/tmT4xrk3yJmgvOfAJ0S3Vvy+qvWfxXwGk
	b9WCExhc1yHB/VqulwsZI0dpU3unmdzKkEzgMnFtbzA6zgBcFiYnev76yqnkWuoZ+2JOqkXG3kY
	rTeMVdGv/FbWxPEQxyCOa9j0MJsIcxXQ/5PFGP/6MFQimvgYaNTnPkFQfGZooJe95DxswLURu1t
	+zTIZwVcgztqdV
X-Received: by 2002:a17:90b:4cce:b0:38f:240d:b857 with SMTP id
 98e67ed59e1d1-39b260dd4e9mr16333642a91.2.1788579732462; Fri, 04 Sep 2026
 20:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com> <20260903120840.1024153-2-edumazet@google.com>
In-Reply-To: <20260903120840.1024153-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 20:42:00 -0700
X-Gm-Features: AcwNN1VgGs6CNnTG2Y9L_7L3wqElcu5kNBH8bk0V99N3ztxoP4hckj2J0q1riO8
Message-ID: <CAAVpQUDKtWUyfms=sEQ=-iXHOrygutEuSkj7573upE1LFUE8Sw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] vxlan: initialize _md in vxlan_xmit_one()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:08=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> If a VXLAN device is configured with both VXLAN_F_COLLECT_METADATA and
> VXLAN_F_GBP, and a packet is transmitted through it using an external
> ip_tunnel_info that lacks the IP_TUNNEL_VXLAN_OPT_BIT flag, md is left
> pointing to the uninitialized _md stack variable:
>
>                 if (test_bit(IP_TUNNEL_VXLAN_OPT_BIT, info->key.tun_flags=
)) {
>                         if (info->options_len < sizeof(*md))
>                                 goto drop;
>                         md =3D ip_tunnel_info_opts(info);
>                 }
>
> Because IP_TUNNEL_VXLAN_OPT_BIT is not set, md is not updated and remains
> pointing to _md. Later, vxlan_build_skb() is called with md, which
> eventually calls vxlan_build_gbp_hdr():
>
>         if (vxflags & VXLAN_F_GBP)
>                 vxlan_build_gbp_hdr(vxh, md);
>
> Inside vxlan_build_gbp_hdr(), md->gbp is read:
>
>         if (!md->gbp)
>                 return;
>         gbp =3D (struct vxlanhdr_gbp *)vxh;
>         ...
>         if (md->gbp & VXLAN_GBP_DONT_LEARN)
>                 gbp->dont_learn =3D 1;
>
> If the stack contains garbage, this causes:
> 1) VXLAN_HF_GBP flag to be spuriously set in the VXLAN header.
> 2) gbp->dont_learn and gbp->policy_applied to be set from stack bits.
> 3) gbp->policy_id to receive 16 bits of uninitialized kernel stack data,
>    leaking it onto the wire.
>
> Fix this by zero-initializing _md. If IP_TUNNEL_VXLAN_OPT_BIT is not
> present, md->gbp remains 0, and vxlan_build_gbp_hdr() returns early
> without modifying the VXLAN header.
>
> Fixes: ee122c79d422 ("vxlan: Flow based tunneling")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
