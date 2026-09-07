Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DED940EB81
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763182; cv=pass; b=fj92hqR6dBvUCulaDwtQ9sUPaetwrFa9K5E76uGN0WCN6BRNZuVaPh/mrjlWnjIg8x70H1rIBdi/tGLABKkSnAl7Fd+VzU5G/ZzH7NZd9V3Jtg9nZueZ4jT7EsFhW4Hm25Q7uSp24PBzOqzkUxPv1L3z3mdFNdtb2fum4AMfNr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763182; c=relaxed/simple;
	bh=xTia762Vvba4AjG+dbVzWcBhFiY5w5JJuSUhfNUmqBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvRT78dcpt42egkam413ReK3Gw1EmcQC0A7P+FSnVdXruAW9cakaeq6LYyz9WiMlAynRzBPDfKu76adwzZzXaVtTLaoInzCtn8xkykV5o1dPe6b1C1I4SCZh86IBT2xcwJMEwGgKTlkUko0YNa8h1cZ26VskhMIAlpyY3cVafak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhvKe78o; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhvKe78o"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53024149d40so15550531cf.1
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 23:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788763180; cv=none;
        d=google.com; s=arc-20260327;
        b=NCd6Jp3uWqLrDf0CONVKqXN0rqPPBdayJsg3SxxcLcMhU/ajiAIFF8eNT3M+zdkn1M
         nNcMCCHhlnSnRivgfFrzjZuQ1Av7fVYkT0KLVL4tlmROOILq2XoR23a1g1Fj0uaihUu7
         zjWNfJe8luz1br/1p3hzbF5+1E8dtrLQdvRHKPlrxfpEswHyjpCTNulEgtXiGA51yTiN
         /OLgi7dtUw5+ylPvShm9vMEPV5gWFFOjRTepbTuQYM8mifwo/+VF+VH8F+N8DpyTrChz
         k6PT3eKW3ae8y55FQy8xHbrbJILIcx3d2mjCmO+XjNjhGw4/uaUIHFujbyTGGeDLd9HS
         Dbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=842Z+5Q9VhiQaGsYCUO5ThRJsGbGQOKT50TCjOqqFxM=;
        fh=zTitgXbw0+YN5RnegeJ3a0xtk3jPxBzaRt5ZcSpWBSM=;
        b=q3YPK7CA7RI3RvHwrXLP81spz+eoNPRK9GAfuFiKDb9KQLblIt4b4gUG8tJJVDOVwk
         eFmNwAVCwCgwtYsaQhq/gs4AQhBJKt80lv/P707twn0sCxpSR5SYbXc7Y8nsOVpwhTWO
         FS2zV2Fq9OMQ6D5gP8jjpCCyk31GEDzjqG+89/QxI+PPj2ewuaZtCJwYGA0bDujjG9zR
         fSoI6m8RTYm7uNUf2/u9G86VGSjpOXHxc4CN2m3z5rNafngU77oIsTLp/SxQMxoWqzbn
         GXdUdjFOpWa8xmaieW6rCruh3ab4Ji+mij+s5nIAfN5RzlTLb+8LQ3yef9EMdzs3WGnp
         +2qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788763180; x=1789367980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=842Z+5Q9VhiQaGsYCUO5ThRJsGbGQOKT50TCjOqqFxM=;
        b=PhvKe78omUNzOM2IbClrMOwSBizGjXu1hWHpRXYDn0TsYfgdUo2Q9K5P1Bs9nZDM66
         3jR+AfSU0tvqXTQAN51j9nwnN8pntc3Nheul5TanzRpbJWzwuTiCZipsyrYIAOZxVIXf
         4dWrdaHubxta8EYZEFqEINncEdup4wmFPoMvk3XJ9j7YpKy7d7hIlp9rH+8Mmk+1rWh7
         UGGcbQEf4EMapR9pdjpixfThmwPPlYu8fR9frY/YvROxdQMHvCGcCPLvX6G1g49SIFXC
         cHY69V+xMqJnBJC/ZlIMH+7M1Nr7C56BJr0EQTXaRVYT8h6Us9bWSSvqoAj8J713jeej
         uZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763180; x=1789367980;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=842Z+5Q9VhiQaGsYCUO5ThRJsGbGQOKT50TCjOqqFxM=;
        b=D2JEmtEVv30qL0FkJszvsPpJVOxOMVI9Yxu9q2+kWHi1GBY6ZaAoiJU/kb7kcx1Obb
         NFSwvbP7y0+AxU66RKsVcIRb6fDsOEUQIuVjYOJBdnrzxPAa1KLcn2FOMlkD2/GT8ka3
         xOCBNXWQf2ravUFtg0Vc34CWbuYWoduVhyyXRJLw/qwG+neVTxt46CiUpZjimDPsQ268
         VUINr1Qr+5mqn3SeONJvJPZ97DJjJV9yD4XDh3VVq9vHbBMZbeMZjDwwbTgmTRZ36R3s
         cWioCW7i+xZqK7Q8eRVGBVG8tDgxsU3aNuyUZh/qvkj9LEhla3FQoiKOzoR8G0sGKM0a
         o5Dw==
X-Forwarded-Encrypted: i=1; AKwUvBztD5MH1gzdNUjx1rGQ9I4lrJEzoM+/UW5Ar5W+ieAgUGz48a6XWA4I+KilWAN9whpnrJrNudU=@vger.kernel.org
X-Gm-Message-State: AFuF++nvjdgDhpDBuR3AXhPtXDzOyneWXa0ZPBLcC5l4MVpMJHfcBHZx
	jxbIhzm+vtoHyKBprqo4AGiA9JVnyIMf9qole/RzBFuDp3SCo0k69U21t7h6IADNwYzpia4I8fv
	CyKU3qk2jSsrfFRJ89BOR6GIPsfuuvpmxL6OkYZX5
X-Gm-Gg: AYBFou3FvCV1h6jqTqsfHPeaBwibV2qomiZs2zW47Lt+JEYHCbK5xjTZzhJAyrecIWf
	gKik36vyrKZOsfE1DMA9al1mSZIUnfDIZPXeQ0755o101Yyv02tYQHuAikc3vIvC7OrYfQk/Yh1
	9Too5wAhu2/IBum/tT1bv6lSsFXkbD7RGk4x8cf4N5nXAZAL4lRll7uKOfHQCVzTwhdZQQGzEqJ
	o5aay3q6xuWfW6pTZimse8qOF35PpQ+QGs413lVI7G6yVCUdlCOOJuK89mdhHnehutG7105sgcj
	fuggcUjtYvUrsSVRdull9SMFsDTXtp0FuXJ+awC+noZpHdyb6OaiTd92/2jPW5EDKhctPNQhH9b
	xPbcwtIZ6R9l66nH+T3SF3lSqmmJhb/fZIZA++AOuO3GqmKCbpJza+FR+CbDUx8hM26hD
X-Received: by 2002:a05:622a:1f90:b0:52d:6afd:7d9c with SMTP id
 d75a77b69052e-53054955047mr224853321cf.29.1788763179614; Sun, 06 Sep 2026
 23:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903120840.1024153-7-edumazet@google.com> <178876148532.219967.4493447289054249092@kernel.org>
In-Reply-To: <178876148532.219967.4493447289054249092@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 08:39:27 +0200
X-Gm-Features: AcwNN1UvQCTps3MrE3RLI2uyzpyaMgVKFcccgso4BE1adua67GBs_jTVW_8XjX8
Message-ID: <CANn89iK4RUxLxbiwiiRTTZJfwHEfq5cuqYV6dj=PYiATZVksNw@mail.gmail.com>
Subject: Re: [PATCH net-next 6/9] vxlan: dynamically allocate struct vxlan_config
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuniyu@google.com, idosch@nvidia.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 8:11=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 2
>
> - [High] vxlan_config_apply() publishes the newly allocated config with a
>   plain store and immediately reclaims the old one with a bare kfree()=E2=
=80=A6
> - [Medium] The new configuration pointer is published with a plain store
>   (vxlan_core.c:4038 `vxlan->cfg =3D new_cfg;`) right after the payload i=
s=E2=80=A6
> - [Low] vxlan_encap_bypass() adds a `!dst_cfg` NULL test whose error
>   branch (`goto drop`) lands on the `drop:` label, and that label passes=
=E2=80=A6
> - [Low] The patch introduces two mutually exclusive assumptions about
>   vxlan->cfg for a live/registered netdev, on the same code paths.
>

For the record, I am ditching all Medium/Low reports from Sahiko.

One of Sashiko's suggestions led me to write an unnecessary patch,
which was a waste of time.
