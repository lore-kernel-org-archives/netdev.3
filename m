Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB572511E61
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787500; cv=pass; b=u77nFkPeswqWTWA3BjuaJQrZOHtnd8TqY5W6GxviZQFSQMFI6NAfWGCLkt1qPSo6xfdGFipSiic0S5rZ8mTHEHansC+g53ELSpFFJXEel7i+mSf4KemVkXcyWePcNXcLiAgE9E0P9vNj4GID9lyxlxUnQpBX8I3QohJjmIwORds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787500; c=relaxed/simple;
	bh=PFVmbYn7wXum97HiWvItCdk8J0+FslrKg4VqBVCXr+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2LDe6TXWEOucQk1JcbKS8gJi1XutlA993zLZHt2tnDMDrpQlTFX50b7g6fWtvJqhGRRLZw+Gf1AhK9fDcp9aUhmR8ZwHa1XTcW3JIe0FYhhrvxGjI/aKRj+69pCt0ZO3u72F9NnrmnzPzws6ZRymxcR5KMlJ/hjginDaWN/Ghc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=0iyYpFzN; arc=pass smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="0iyYpFzN"
Received: by mail-pj2-f40.google.com with SMTP id d9443c01a7336-2dfaf76605dso17375025ad.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790787498; cv=none;
        d=google.com; s=arc-20260327;
        b=UrMsnrOd4ge1toN6rs0v5oMVK9jQBeo1eIB2wIujqmHlCwKBzBUl8dnJ8aZGoz/L9Q
         S4MazQz73usc3lCJGS0IyZuPgbXFyrQWnwr5btsyuXn94V856W4RhTCru2e1g18ED6wx
         nX3dyZt55jzDVE2XHUIMUUtNnza/L0NSSqgouzEGKsUKcQpPpn+bYaMDSDLOBVgo014y
         IdOftgLOhXi/v6WUsQpfxqEiK3Uee86uD7DnYSynWmV32iVVi7siBMYS9orZEvEd+cBl
         uNfcN7SoElKgBwRptJ5uXHgB90pg53nZn8lBLrbwp06+fXIPTl1+B96SS2HHo8vvKKN8
         CWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8tHU8kM38mvHPaqIAaeYccyBz2KlL0E8vxrWEOhOZSc=;
        fh=MQpfJMMUwNhn0Ql+YT6alHS4b95Exo7Nf7gUvAbexgE=;
        b=UINNIN8red+gbKY2w250DtF/eMT0WE9x0mBpJLTOxqLdqUnC2+710mzRjShj2t0hbq
         wR7ej9fSDBBtj4nOIjlkYcUK7ghdIUUEoX9RQGcSKYWrSk6xEERzVLFm5T0qfj5xODdF
         8nB0eSYN4gPCydb+NjV4l7f/737Z3ZxyQOU4S7Eh85Nj0rAx6uZC7O8sxFjT8IMHxsKC
         MgZakdpmZLvT39MvzsYs4bryY5DXSfFcXwmHJQtATOV0OaLE3hvwd5z2msZFuzaYR5tg
         wmAwvgyw8WrxeFa8NjNlahnqm7rBnvpg4ZmTh/Sl0SmqGRGvZkZiryddE7VmZdIrv9+H
         Uy5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1790787498; x=1791392298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8tHU8kM38mvHPaqIAaeYccyBz2KlL0E8vxrWEOhOZSc=;
        b=0iyYpFzNR/ZwfG4pxkOSw5wVbuqDlRBNsG7rLRw7FrCadsGu6EJr3i/tvUrfYMo2lF
         UeOPzbD0IwEVCV+wgJcj67Ybh+E3H0Z63BZU2hwPwLvG1YU1gea6NVd5AF8UbUrLRRla
         KNm9t/lO3UFBL4vNpSjCahfLGBiuQ6NOpPvPZkJ/s9wb5TzlVxXkOkpo56yPD5ihuYDL
         2af4aO+V43i0YN5FjL/NSfV57Du7eCjsGVvJ6KuoKefoft3y1/hzhqyxY3I3l6e1lYNk
         Hcxo50e7gpqXV+KOnpiTD/zurWT5zeF257S02oK/l0GEy27cfpSDaLlFkTDf1/taXa7Z
         nC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790787498; x=1791392298;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8tHU8kM38mvHPaqIAaeYccyBz2KlL0E8vxrWEOhOZSc=;
        b=KcONgdXqwvLCZkkRCSiWOIbSvcrePThVFdnCJrH4Vkt/FWGWELYhim+aElnm76+6qH
         annbuFyi1g9Q+OyQ3ItCwGC6YGxE8manjE55GYTprie6R1xzpL4Zlh6uL7rJgS0aTK4d
         lE0Pruz10fVV5/DhSk/47ps8EE/fltUlnPSiQr/LN3KxJaXTK8+JSEvFdNemnN1AX6vu
         MC42bmU8Q3gEjDngBA3vkVSqdi2QR+2iMeT6ToKDR2MFQdRbb12sH7RBDUphP1vF8Zja
         dyiVbUbo4dPiLtuAxeMx3m/JvdI29dnBuTgnIlfRN/OBSI19wvyMqVWXEkEWhsi3KK9g
         K9Mw==
X-Forwarded-Encrypted: i=1; AKwUvBwrmZMjsRqphV09x80Ea/BPKAlOiNTMXEhNgdNiYsGV+fzEFDEmZfKLGbYeXPbPbKCTTu7yZ3k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJLEJQ7UDAdnGnGienFWI+tJ71eWutyPSs2oQrFi4yJuMHIv+0
	GneViXDMpr/ziNmxEFETKnFnfvkMKphGuBzvtTTtLqCmSH8Xapo7Xqonwbi4U5PNsurMgO8n2n3
	UOU/kvdcukPQyvrQBVgbhgISiCWT9NOpXIfaAS4bHOA==
X-Gm-Gg: AYBFou122hjx3qVzVljggHlvK3eo9KccvJW5k8ZlSTqV9018dQHYuD6865xnsABUqBH
	IXbNyzpDDDqnavEJUv6tSiTqkYVxlj3iCPNps5njktk0XubS1TZQDyxD3eaccW85EcR7iYXxRzu
	6frQIDEkd4sK9j3QhOP+si1k20bDIPJ/a+j1KXpcf5HJafbbAHNaREZ1DLcQXGMKtLJiKdJYRuY
	nB/UI4pncR3tdALr6wruCisi5u4PGuQKFqAMoTeNSET6H8Q6f9xGjX8Bv4zTAqxEWhtp+9DdCRz
	WUz4UxdvqVbKZB4AGghPXDPeV10LVHitzNmdrWIAc3tzuIk9Vyz13V3Ghkho5rhCe9d14barKAu
	7pUYBkaB7x07S5ykP5B1LoWjGOJRD9m4PKzo=
X-Received: by 2002:a17:903:19f0:b0:2e1:24ec:df51 with SMTP id
 d9443c01a7336-2e2e4bf6e86mr18103575ad.53.1790787497948; Wed, 30 Sep 2026
 09:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930122305.293686-1-robert.marko@sartura.hr>
 <20260930122305.293686-5-robert.marko@sartura.hr> <3fa11f0a-3b08-460f-9355-72011dcfa7b3@lunn.ch>
In-Reply-To: <3fa11f0a-3b08-460f-9355-72011dcfa7b3@lunn.ch>
From: Robert Marko <robert.marko@sartura.hr>
Date: Wed, 30 Sep 2026 18:58:06 +0200
X-Gm-Features: AclHuK-zCx-hRo4FQHcXpEa4B7tZt8c59IzcCUddj-jkCNJ_V1CZ_hahpuYPcAk
Message-ID: <CA+HBbNF6Z9uSBbktH8oOCRrHgaOujqEaLozge3zAw4ROUXi7OA@mail.gmail.com>
Subject: Re: [PATCH 5/5] net: phy: mxl-gpy: support MxL86211C lane mapping
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, hkallweit1@gmail.com, lxu@maxlinear.com, 
	michael@walle.cc, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 5:35=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Sep 30, 2026 at 02:22:17PM +0200, Robert Marko wrote:
> > Configure the MxL86211C physical TPI lane to ASP mapping when it is
> > described in DTS.
> >
> > MxL86211C supports per lane configuration.
>
> I assume you have a board which needs these features? Is the .dts file
> ready for posting?

Hi Andrew,
Yes, I have a board that requires it, as pairs are reversed intentionally.

DTS is not yet ready, as there will be another revision of the board
before it is commercially available.
But I wanted to get the ball rolling on the missing stuff in the MXL PHY dr=
iver.

Regards,
Robert

>
>       Andrew



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
