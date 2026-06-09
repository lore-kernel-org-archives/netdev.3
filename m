Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4D47ECCD
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017833; cv=none; b=PdFl2tlMOiQ13KD3WVjFzWFwkFMcXtDFdR68lHASiglKfIH28l0oqi/JNsVv8licTKag4kFs4v8GIeefzgBRsMFhFJcZqk/iY8NaU/86M0mkfdxcJYzLlxXpsdgrS8C0ioLY495fPHd6NBaOu4UamBN3HYtlaypRBK4+AKAOwoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017833; c=relaxed/simple;
	bh=mV566MgXZ2t+cW8+o7g9tK619DZ1iKXeayyk9v0IdJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSh9S748iiBWH7wtoEL889C0ZS/dRJObkTTzLGTTbn4/40TDDtZKZtnXEo6ArvOY5Lstf/cViOIkgtuBQRI88NFGNDo4k6jSECLCwSuSISb1dPv3hQhZl4p8v9RSkwnE/uo9rVxy0432qG/FhEPDXDxr8IZnVgfJtILnbeA1Zwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/oe5BD9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/oe5BD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00CC1F008A0
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781017832;
	bh=pNWcqo/4vTEd5yKcsC/I8rtVkQhQPo6nla/yUS6TozY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=l/oe5BD97cR5h3XGcr4EhhXuBM6bRe3t/BxllpwUsYSEJBbN4ZMvfe9Utk49vW+TF
	 aFI+pB9rZ5ti7hOGLR1pQb9HARuYcCsh2r7782S0kE9oXV6EC2NGyUe3ldOwOoPn03
	 8pxf9KorBijbfNIMJVreTqecsUyslbziMx55lGUNJ7jv8hA5wq4Gxqi3XRqE0xpYTy
	 Wnaa9Rgb8qTK0PoTiF2pgWUdlAEc5GbROY7QHi1bKCLRUeXh+PvHlczGfGcjZP3UAU
	 ZKGhTz/hk823Hn18rrs5mmzKYWhWoenQB6YMRIw3nlUfXcUAmwjc32Hj6HBgvMm9gb
	 LAhu2bvIFyk2g==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7f015f87fddso28181907b3.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:10:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/7jGArRixNHTTi+Thh58wA0S+PeFkNMfqLBzvReXuRqtCZhmGWi1zDNT33W+Uf1N0EFBwCcFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXnPH7vUDTPEzDVsxtQ72i0sfRt6rG322MyNgcZ63ogfXwAdJc
	WoizCmhVz/EQLL4M9fkrxn04u7hPBV1mghcyS+OYTahjFZMX6GnVyMEszdD2HV21kYznDLo67GS
	pCDEZhpbI5xqR7M6wUkZpedOE03zZrGw=
X-Received: by 2002:a05:690c:6087:b0:7e9:ea36:f256 with SMTP id
 00721157ae682-7ed526f0135mr136888977b3.17.1781017831290; Tue, 09 Jun 2026
 08:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608095523.2606-30-david.laight.linux@gmail.com> <CAOZdJXV=SwYFaavxpoxG=BPxpQAaEarHicaNG0osKDVeQCWGpA@mail.gmail.com>
In-Reply-To: <CAOZdJXV=SwYFaavxpoxG=BPxpQAaEarHicaNG0osKDVeQCWGpA@mail.gmail.com>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 9 Jun 2026 10:09:54 -0500
X-Gmail-Original-Message-ID: <CAOZdJXUkhJE0tpMn1BuVsqFi7YtOqycPHZEe7LL=ueaWz8-Q-A@mail.gmail.com>
X-Gm-Features: AVVi8CcLv49UQ7KvAWzFAPXf5FfhtjvKWhhPBESyzLpkv0jfG9pcRinn5aCa3a0
Message-ID: <CAOZdJXUkhJE0tpMn1BuVsqFi7YtOqycPHZEe7LL=ueaWz8-Q-A@mail.gmail.com>
Subject: Re: [PATCH net-next] drivers/net/ethernet/qualcomm/emac: Use
 strscpy() to copy the ethtool strings
To: Timur Tabi <timur@kernel.org>
Cc: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 10:08=E2=80=AFAM Timur Tabi <timur@kernel.org> wrote=
:

> It would be better to replace this with a call to ethtool_sprintf(),
> which already takes ETH_GSTRING_LEN into account.  And may as well
> update the ETH_SS_STATS case underneath it.

Actually, on second thought, I take that back.  There are no format
strings, so no need for sprintf.
