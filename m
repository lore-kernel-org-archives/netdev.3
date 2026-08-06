Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27004570E9
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014571; cv=pass; b=bGFKHtugd67APaKO6deUz5p5bEmnP+w0R9Jp0rQSlKkPpqGtdKBPOAktMpk/4GQUaMUYc5I7hlirb595gz+p4XC3FFH5ur1hY5vUwxBAcXj/U3P2uhj95tF422eWuYmJqMbJbZM58AqYLNSr+djS/54/T7tL6lqo9i84771BaPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014571; c=relaxed/simple;
	bh=jvNE2PIdNbuOmT4y0duOKZpH1CxmtBSnHQhxUMLn2Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urNnY5aQqI/4jI8PI3/Ug2/vLtzQ+8BCQjxM7JHPyHNUfRuh8dBSlx+xNaqWANZ7iNvpMWLRpeMWVqUvt3z2vlMfRB4uQ14w4oauE24nWNRQC7/nnUPEr+9SKgBa21d4/Y7pGQGopYlw7hCgwZKA8iaqMxkwkwaqoS3zhB8O7PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBDyNIhF; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBDyNIhF"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81ed2a06b9eso20100397b3.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 04:09:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786014555; cv=none;
        d=google.com; s=arc-20260327;
        b=mjNvIzIQyBJ0dYeyVMwob3yXcWPqEbRc1BjWCeL2+GdE2TyvDjQ+tEdnWPvewsv7Rp
         hnoD4MDXVQJ7lWYj/3X2KVzyXTyyDkMWaDPb+m6kjGgqzpkKBtYcdOuaYoczYDxvXAyz
         /Z6an8w930J8Vt1Hj2do/JNdivDOJ6ZY5fX+hl+GFTgnqpPUninlC7x1bigIYMoXpp2n
         ZbWV4834+6BhHL8XIcJb1VsxcmpvlNIyvjCv6JkTiGUlg6sKfjBV9JlgBl0Bn7CvUtiF
         VPFTsUQ+i/P1Ju1DyWZNoSAhWxf44P7HoWW1Ua0gzmFca2Qh2eIbFiPbOO3tCIF+mX/s
         K96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9cQUUGYPqSh7uXBM4YMRyXpKWlqYEKV5B3vtEohmK/w=;
        fh=YA4ruJqmU0x2ctdkQfZT1ZCqihWBdkSFa7pEHv7dJKk=;
        b=XuR0v0A6+rCKxXR/LPpaFJDKFituDIDocQQqeCb5SVmD4vgqjH9nSa5pBkObFS7YmK
         7+QXMvz8JNgByN00ULvn9f7RwMi7qUPYuxzIPY3eE+so0Xjh+MhyU+/4fqoh+BEa6nX5
         t3hU6vpmlhKuJuNBen2x9u+lQYfnW5HIV6Zl2dqg/Vg9nSafYJDkbOMCjyJe3ijLHhdI
         23CYgEiFA4Z9vKIdKIubV7BQ+lLKuzTZPTp5/ldzpNf53PXrKalemU14tD4djS4iYIBB
         MuwxAVL6ZeZZBni61GJbBqMqR+YNw71R5iZ15XnB4tpyN7NMhZ/qVLEYXBMhYBE302Pc
         oQBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786014555; x=1786619355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9cQUUGYPqSh7uXBM4YMRyXpKWlqYEKV5B3vtEohmK/w=;
        b=QBDyNIhFc2ueoyKk+xUYl6N6Ad14wzGZ7Gp53SK+V/P+LuE6mLOvFsnNmEjXhNNYGX
         oX4z1BMAHxzfFlBVW8H9eGbUboRwEoJwRrQS336fPwkPKP7h5XqjspChO7Yqjw6d6fA/
         kvgy3LML/xVckaKTXl8140OMRdsUY02zHo1xVqD6q+PrCg0ytKlb0AgAOJk1R97+9psz
         a0oIjxTlKaJ+j+hU2P54Kz94ssB3cYgbRotWZPEr8GmiRHOczzRDFPM7VwwSWqFPd8r5
         +mWTT65yIq8NElNVkXp7psvNDyybz+VUdKCLcIZFX+57sTAx0VYgh3+/5zIpV4imqqXs
         QYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014555; x=1786619355;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cQUUGYPqSh7uXBM4YMRyXpKWlqYEKV5B3vtEohmK/w=;
        b=KcL/d4TFbaOXcymohIW8YWBVVDBnYXNJK6VcAlVGnmOIh6uftq/yCeVCUmsROX7XY7
         2l4xIkv31W0puyChpxLvZcw0PSL2BBdroBffLfglOjg6TsF1tq70VNoVGaX8lPwTU75o
         C32rzlqNmbqNB8CyB9h5SoKd9Rbusz3IWcZq+5hhFhjH+chDhQlncsJXUMp+z5qUSoBY
         7HFk0ItqtuScJKdgFM16ytYGPKfduCHn9eu34mWVQPxyueabcfWIyV2tMOvrKSt8rojx
         16LgfufGp7xaR1KV9my9Nu02iMzM5ESVxloZmr5tzkvedmvuTon4513E0fIT7z3bk8NM
         S3Rg==
X-Forwarded-Encrypted: i=1; AHgh+RqDMcq+RURdRgWKTBZZWvwi/QLcllmllXTqE09KDc6LN37uoGYPIqBtUGrLqcGXvZP3gJOcFoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDQ29rpGYJLmQV1w8DyYrUDtbhb4x0VymiguYv/tCFumNZwR28
	8+ZKdxFeygPDD+yrdeh4rdeImD/+NFMbjYlzlWw6r6JP17sOxyx09lJcQOpddyWb9cITMd1G9Vw
	NO69VIra/OCwJ0SbXlnhGbXLAOi+SGbw=
X-Gm-Gg: AR+sD11E0L3TUtXPLZcCr7gf2PREE/Kzw1Mvop8frDztI1tDdRGlT1L4XM1iTrLMe/H
	Px1O+SFqBIRVWOz866WPzPGM74dbMPe/M0Y/xxCjwLVXZTuFfZsiOPK9NUSTd6fhH5sgHs5X2do
	O9QlQfOdST4ug22QZwGgY+zP++nGH8VrJIDb/9/jyxZasHgrZeuLrsciCbCJVUqI19mVi6Pb8Pj
	GlZwYod8ruaei06sS1gNda5J5aygzuLGgXzZlzFX8vSmumRDLSD1uT/0WB30bXRx3tYxbPK7plL
	jgGB6S9/n+fdlOfxBBYS8xRHYgVr5F6GhVYHsfHStPFfD4C7Mko/uH9jUot1pxl1e7PbmUSEXSH
	vtR6G1e3QGy810aPe2EhA1nI7L0TAOeK69INivohLXydCsY7z45gQdJhJPaWKJ5aptg0Z4MNhGH
	FzDSzOy0/zAmv2bzJzMuw=
X-Received: by 2002:a05:690c:6983:b0:80d:ab06:cb64 with SMTP id
 00721157ae682-822584bad34mr3629877b3.8.1786014555082; Thu, 06 Aug 2026
 04:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805072641.402-1-strst.gs@gmail.com> <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>
 <20260806102327.wrig23oltjzogyi7@skbuf>
In-Reply-To: <20260806102327.wrig23oltjzogyi7@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 6 Aug 2026 13:09:03 +0200
X-Gm-Features: AUfX_mxopR7GB3Ojlu79PEWCg8s-EepDtmB4ZlVsxxuMgl9-7seiaOPsXE2jtgA
Message-ID: <CAOiHx=kqmZSM2Vzusc_bcpJfTjJC=jYPgU3wnz_xX+_nnuiNtw@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: be VLAN unaware when not filtering
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Semih Baskan <strst.gs@gmail.com>, florian.fainelli@broadcom.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 12:23=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Wed, Aug 05, 2026 at 09:44:51AM +0200, Jonas Gorski wrote:
> > While SVL is active, any ARL add/remove operations ignore the VID
> > field/register and force it to 0, making existing static ARL entries
> > with VID !=3D 0 inaccessible, and any (static) ARL entries added will
> > have their VID set to 0, regardless what the software entry said.
>
> Is this a hardware limitation, or is it because global state
> (dev->vlan_enabled) blinds b53_arl_rw_op()'s attempts to look at FDB
> entries of the other type?

This is a hardware limitation.

The hardware hash function to determine the table index for a {
VID,MAC } entry ignores the VID field (or rather treats it as 0) when
filtering / 802.1q mode is disabled. This is done for all ARL
accesses, both destination port lookup on forwarding as well as when
doing ARL table operations.

You can manually write entries with VID !=3D 0 as the VID used for table
index calculation and the VID of the entry are two different register
fields, but the entry will then be written to the wrong index,
preventing them from being matched when looking them up on forwarding
in filtering/802.1q mode.

I verified this by writing entries with VID !=3D 0 with 802.1q mode
disabled, and then looking up the MAC for VID 0 with 802.1q mode
enabled, which then found the entry with the VID !=3D 0, and looking up
the MAC with the entry's VID did not find the correct entry.

>
> static int b53_arl_rw_op(struct b53_device *dev, unsigned int op)
> {
>         u8 reg;
>
>         if (op > ARLTBL_RW)
>                 return -EINVAL;
>
>         b53_read8(dev, B53_ARLIO_PAGE, B53_ARLTBL_RW_CTRL, &reg);
>         reg |=3D ARLTBL_START_DONE;
>         if (op)
>                 reg |=3D ARLTBL_RW;
>         else
>                 reg &=3D ~ARLTBL_RW;
>         if (dev->vlan_enabled)
>                 reg &=3D ~ARLTBL_IVL_SVL_SELECT;
>         else
>                 reg |=3D ARLTBL_IVL_SVL_SELECT;

This ARLTBL_IVL_SVL_SELECT bit is only implemented for a small subset
of switches (bcm5302x / bcm58* and bcm53134). Additionally, according
to the register description, this also requires enabling "per port
IVL/SVL" mode, which is not enable by b53. The description of that
also says that the VIDs used in SVL ports must not be used in IVL
ports. No idea what the consequences are if they do.

Best regards,
Jonas
