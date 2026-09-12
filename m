Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86F2366052
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203436; cv=pass; b=UqxPwy4jOL02ARZxaUu5pgNh2nSypr8+NzTIpjE9ezaBBsLbr3IzsI1efZkbUX2GPs16DxgG1MiS3E/V2qgJZWJjLmKwXUfhLcGCc5VZA14iHM8Y81ZFW+B0xcLtB2OGUAPgwWAz0UuQBGxygEu+paGAWMBGXuS5LGVn2TJKSRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203436; c=relaxed/simple;
	bh=i8AG+o+oG2drX0eM+5FUXfPF6XzifyWqD7/H8eV3x1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXuPut4ie7t3rM7wsXdUdJf7uxQEqWKrVi/Ne8b8wxHh1Z2BbXxpnVb8A1tS+oCDb/2A5quSRYtMyfYUVpVDehUapOU4aWVltT92fdIclyDh4hvQZ7KpHwTp+S7q3eXhsR7WqVhCRyQz5Yznz1ZGtTUpggseZzsPLfCAfn6EZKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X6zb6CUc; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6zb6CUc"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5309d6188e1so8605211cf.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 01:57:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789203433; cv=none;
        d=google.com; s=arc-20260327;
        b=AUlkibBpK37L4Npmc05NR09mxUQw6dgpsf3CkFivdFef/FtI5XbClGr2UsURwjMXMd
         9BB47wDveR7R1RH+sbsG9+/s8DvN+NeyTkbRfbCaVtoGmZJmPM6eoFEiCQEctrgvFJZm
         gR3/1En7ny0+kqRsTbs1b2dn+4zysCF7UV9xqz/lsFI62QNZcudzj02aCuWwm/hL+Gi/
         VsV16PavufLBKzwZkexgAjC2CYO4y+WlPKRElavmxlGkXisj6LEhJOI5O7SOi+SqGokF
         OQsrUYT7ORiZc+SL/yAa2G65jdiBD/h2r5cB3adveuA7q3Em+EvUDNXaO14PimND059P
         X9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i8AG+o+oG2drX0eM+5FUXfPF6XzifyWqD7/H8eV3x1Y=;
        fh=ZDbAm4VzJ8nFLvZrc2kSs8sc9+kHCTfEOinddMTIX3s=;
        b=Q57pk3jk6duqUzszD/J8JKd9YkIiOyy7++wuWc70kPho+PUT3SkQKsOWyHpaf6031/
         BGlkFFEzMz7FXKwt+o+5HdPohSMVmdToQYmVb6WFTXWejGMssJVM0VdJSrx2w5pQH3Zi
         c4ValGsuoBZNq8z2aWf82eJZK7ApEyITsG8savE77FH3wRlYHeaJANxMrfL/qjwUImDy
         KM1wcK8AHCUP9JG+59b9YFrZlxP5nAloYbyPvNS+cyIx1atqLBYWGMh9m9XDPSk0mH5f
         +WBKCVLhUOLRvwYiTXMBWKAYThApHrJw612scMcThy0pjJWkJzsKpXXtveh4p3qOk5i2
         ayxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789203433; x=1789808233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i8AG+o+oG2drX0eM+5FUXfPF6XzifyWqD7/H8eV3x1Y=;
        b=X6zb6CUcmmGanRHr8GcOnxgIRBghSzgMiIK0t5S5V9LA0zKAvsOnwfFCcFLXnMCkiP
         LRd9PjMvIazMwB/LOfWdxLR2Ysjt0g+muhtnp8wIb4ceAFVloxJgYKvbBDOEIfnD6Fkv
         DZaYr6SC4FxLQTSRhv4kreU6IqeoNaNtTE6idSuapYo1b1EOUj6Sm0ig8cqMxcfcZLMK
         6CnCYaJcPC2h4V5YqrrejT3s4QhztoavMTwd/E7+OiN1pf6c+m4f3hg8CZceev1nuqmf
         T3tEkl+xX9cFNv7lrtkXTo3QUYLk72pCsXPrkj5XA8MZm303nIsIivxVJSiyePkyM+0A
         yguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789203433; x=1789808233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i8AG+o+oG2drX0eM+5FUXfPF6XzifyWqD7/H8eV3x1Y=;
        b=M2ujO3ArPzqffSXDx6hpm0Z80LXjWSu3CMhLdwwPdLk2VQQL1luIZ21uZ45sd1r8zW
         uZagGTNC+CUwh7jqXS78Z5aWb/xjq9Wd6kdF+PZ7KXoNn2kq+l79NRpK9dOH10WNKRpL
         pj+kelbEXvgxazwefamlVVIoSJS378I9g6i+/Y4ECjYNtD6XBI+i6qOdeZJI6Gr3mhZc
         Hdh2g8oq2SmB1pSKVOfQEPkVfacl+4k8xx+sZ3oX0LhTubnmr13JoH70S9aN98DGzfaT
         O2jQu5pZeoXy7DEDNEtP/qe2aTCEy8BxT/uCm0Fb4ev9GLeVQoESOITZtxjZa288WnXu
         gwpA==
X-Forwarded-Encrypted: i=1; AKwUvBzLuk6JpXlZMumAPGAunkhyWcTmurMU3w6fgTm9XJ7SX0/OObyNF7dqWlK7Y1pInqYOzuCBBNw=@vger.kernel.org
X-Gm-Message-State: AFuF++noWsje+nvKmDaEIG76lIHTS2pQAcgKiTObOgIzOh5QtC1YMqVv
	vIXABsR41dbyFG+SH7UwZweDi+QTeLOhsjrHXxxq9uL+d8AtFHYUEAx0unLp7VWShgtpa2bWgQ/
	sP5Gutb7Vnnt3/A7I/37iOhTmNF95i6ZG8lp8L67G
X-Gm-Gg: AYBFou09vBhakO4IHwbNY78brjFgZb4QAwTCnCnmP3eUM+Ub0mDWQxOsORSsKo+VQ+z
	gzLOKVidP81nWUWQqi0YfOzb/sBM0tDlkhqBILN84oNNCeOF34OfrN70uo8+JAYxouKUsu1i3Sn
	pMGfwVBU4VCy9BjjHAsNovagBR9i6zFQg1Pwzr28VCnW1Fd8MR824eOnvHPOrpxA30ZwV0rw2P1
	x8HjPHW58ldP0oi5SrM7LRvSNBys+Vn0+J71xxF3rZj4HtFC0alLKuH/YckudLOjggV1vxThE/v
	xLnaQOWhGc/MuaGVEFgP44AeSIZvGtbhxD5n7n7ogZhgL3FFLIvsWg1TMCHqyWmm2JyHLsr171k
	FBuZ3F6jfxrCmChnB5tzbLqUZVC67ExdLXadBOHIITdNwqt3kSSttqV18u3v/y4lzzYGHO5aiNL
	UFmA==
X-Received: by 2002:a05:622a:90b:b0:530:b2e3:86c6 with SMTP id
 d75a77b69052e-530c87afc8cmr136523391cf.56.1789203432809; Sat, 12 Sep 2026
 01:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911114922.621937-1-edumazet@google.com> <a53a81cd-88b6-4db2-a0e6-ee3dccfeef42@linux.dev>
In-Reply-To: <a53a81cd-88b6-4db2-a0e6-ee3dccfeef42@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 12 Sep 2026 01:57:00 -0700
X-Gm-Features: AcwNN1VGV2PYklkTQBMHr0GPZ_uipU9yOuNRs9TZwpxRiJ1EC10u4Gff-4dujMs
Message-ID: <CANn89iJw5P-wARumRgxdPaHXBJ3qF0zu6FNaNOFKonyww9AJpg@mail.gmail.com>
Subject: Re: [PATCH net] net: skbuff: do not leave stale header offsets after pskb_carve()
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com, 
	Allison Henderson <achender@kernel.org>, rds-devel@oss.oracle.com, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 11:38=E2=80=AFPM luoxuanqiang <xuanqiang.luo@linux.=
dev> wrote:
>
> =E5=9C=A8 2026/9/11 19:49, Eric Dumazet =E5=86=99=E9=81=93:
> > pskb_carve_inside_header() and pskb_carve_inside_nonlinear() remove
> > the first bytes of a packet and reallocate skb->head.
> >
> > All the headers that were present before the operation are gone,
> > but both functions call skb_headers_offset_update(skb, 0), which
> > is a no-op : skb->mac_header, skb->network_header,
> > skb->transport_header and skb->csum_start are left with their old
> > values, now pointing into the freshly allocated (and possibly much
> > smaller) skb->head.
> >
> > For pskb_carve_inside_nonlinear() the result is a zombie skb with
> > an empty linear part (skb->data =3D=3D skb_tail_pointer(skb),
> > skb_headlen(skb) =3D=3D 0) but skb_mac_header_was_set() still true and
> > skb->mac_header pointing far beyond skb_end_pointer(skb).
> >
> Could you please clarify how the MAC pointer ends up beyond
> skb_end_pointer() here? The carve helpers allocate based on the old
> skb_end_offset(), and kmalloc_reserve() adds room for skb_shared_info,
> so the new capacity shouldn't be smaller.
>
> The dump shows mac=3D234 and end=3D384. I understand how the stale offset
> causes skb_pull() on an empty linear area and triggers the BUG, but I
> don't see how it ends up beyond the new end. Am I missing another
> condition?

skb_headers_offset_update(skb, 0) is a no-op, so mac=3D234, net=3D248,
trans=3D288 and csum_start=3D288 survive and now describe bytes that are no=
t
there anymore. skb_mac_header_was_set() still returns true, so drop_monitor
does skb_pull(skb, 234) on an empty linear part and hits the BUG in
__skb_pull().

pskb_carve_inside_header() has the same issue, the remaining linear data is
shifted by off bytes while the offsets are left untouched.

Thanks,
