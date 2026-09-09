Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470135867F4
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964354; cv=pass; b=Urq819fl1yXhqATDSmIaJKcAqKl9YwxldRcjHofKmX0gz08nT24iEqmP5uDpBQ9k/R1HiYTBLlNsTme4ca+ljCTh2HcCAp0hPIqSAKBQxdww5ZkU42SBM/OG9wqexQ22mMoy7p1buPD571HjVtFx+rtHbBM9FOS2q4/t8PjfW3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964354; c=relaxed/simple;
	bh=pD9TXcj0deCwIDSY/gHovc99tumuugoF4IfHylmVrlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVrWREk89UvkDykoSHFDpkpE7ySwQGbP3+x6//5iPvxLvYjcXBlRo+MQntf++G8n6ehbrqc+GWQR+t02PkRXFbCsExC8RbOgcJdKY5n4vcakazzB95qwMPWwE1642tO67xhE2MlOdb+4gsB/Z+L4TClHlip5B+6EXKA1FSHcLLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1R1ZLO9; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1R1ZLO9"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b778bcee05so615631e87.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 07:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788964350; cv=none;
        d=google.com; s=arc-20260327;
        b=BxxLNRYIBU4lbNraHCnrEqOpXvfiGLUfNqqafD4rcTqzgJvLMDNPeaanUwhVK00W+F
         nF+fXvkUCfya5mxVnRwTbbI+XD0+EL/gUwT2V824HbsAr3y84rocWvo1nsOXyfx6KIbW
         U28SukO0/1Pc70ni9nqwClfhWYqQLDYr8mHqTKu7Kkak+NO4rgD4Z7dpa4cnGMSMiRMk
         opanLW4pG/xvIUUCn8PXtSwS2DowMgEYXlZSrh8AwR29lRLGNlYorcb7Aw7+texLgYSV
         4xJ6CGU4wl1EHGfhmmWTKuOwuEJlEZXocrLw3HDlneTcXa0UxT5LR3KmGWHtC1IlDoKW
         yxYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pD9TXcj0deCwIDSY/gHovc99tumuugoF4IfHylmVrlQ=;
        fh=JekRt7EvLr3NbkdtSN+xBqzAwBT8ZTDHc8OKlc2d1B0=;
        b=Ys1FzC54PUh5dg7WtEhoSKQWb3+LEqPlbiPPVhwL2HLsvlcyPmHI+9mMhYvzvxkxoA
         m9k1U5wILqvoTzBUIupxOeFvGODw6jxfyPgi0XLrFxNWO4w3v17mtuylBT7oUbXHcJ9a
         rXaLgbj5P3s2n3dF7gdhIXwJ8MtDjJdC7qL3a79622dXUSQJZHcU6S5rH6isYBGOZ+RV
         T3grDVPL4j1lvXkT+MSBPkGJP0UnR1RcpjtpefSDbiVuvLhZCCmMkcZsIhtjDFIa+M/g
         AAGqA7Zyltk1zKhHoxrKYLG2ncBhzvHTZFfTbIvTiS8DyzGmYNHNSL5z+M2gYs4xj6ta
         KAbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788964350; x=1789569150; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pD9TXcj0deCwIDSY/gHovc99tumuugoF4IfHylmVrlQ=;
        b=Z1R1ZLO9tIz1bQmwyqzaZ/GAiWR5AnitqV9Nddx0whC5cxMRaIIsDA7EA4xsINKKXP
         MZcCewVY1Ye5iqum1Qz7AYnunCVcnnYpqr3ctUmQ9iwZCrwNxpbMhy0mhhiDnX6JP62f
         /RZnfha0AuX9mSKCzJb47a+mhAsIHU0763L4AF0lqdmZ5gIzQrPfEgQeI59/VRIzW6fY
         09xrBJcsqbtr5Wxdt/jb0MvZFsIfxhjmbildZUi2H7xCbYBlhj5aDld7B+deiluQJJ1j
         p9nGsFmUoYifuG9Bx365VPdnIaWiO6dzwH6S1XxIbcXBOKqN5xDKSpI6e0Jp+913wEvw
         OIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788964350; x=1789569150;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pD9TXcj0deCwIDSY/gHovc99tumuugoF4IfHylmVrlQ=;
        b=XihdVwPAA9mV3hY1jw2dmv04DprDOX41Tzzblgo2ZxWLu+3OKl9ejQbauFjnlffDbW
         Xhw1137P6ri84NLEXbkUN8vHlDr99DHl+Zpu/7luSmh9NoWbcIfbbmw7BLZ8SZSmDyJL
         XdF5HUo0qJLtkZOGUtCHmPsvG0RIw6fyHXNkVneEnIjnB7ZRaKl52tXZWcM715XeXkEY
         kuKWplDJMibils6g/xox8fRmqLL+dfJxbnHtkKoxWBwpczkPV7HreVSMY0xqNtaz9EEQ
         OgrhnK2Ja/TyV1diP8wu1yMyAFCYepmZ4DUk7sFSD2k2AOS1/3HAEDXsE62V3uODWcWi
         jrzA==
X-Forwarded-Encrypted: i=1; AKwUvBzo0NLYKxDyuNLvfX4jWovIcr0anr6CM11paTu5j+QIfrKB4Lga3xku22Shd1mxs9/PAIJH4JQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n7qvdRMlrFLlQJwZJHBpQ/kdrFrJh8AdLh2IOZboFW7cGHGRa/
	ESe77DV+CcAcitVZ2IJLZX3zMzI/2nfMmb5dhRs/9Uu6vjSqlUwcIURmTGYWRwiCj4M4vgHnHa+
	e9cQNcoy/lBZvbB12VZGGERt+iuu1Yec=
X-Gm-Gg: AYBFou1+snwrSc04DR0oq03JzEw5zj4iZhhsgy7WORdn2Sel6kIWYlBJvKSYgRB3kZO
	4C5rH92tbh7mJwdqqwwJEWB/6Ej+OC5vhEXYOFlaiLGqZeDYh2OqbOD+9mrFmNGF0Iq7eoOWeQ1
	A3iQSVjSzgm8FDEh/oLjZJwxao7TNzJiQRqdCLMfAxsKpb6bHTyol015cxr5zaG50vfUCDLS8wT
	vvCyqAIkzh95F4LsdKqWkBXLcH7JbH7XEL18XmrAow8RkWDA+poRReXQPdKcjh6ylV//PnFxHFv
	0uUDeUSC3WQROc76isbf5Jj4a4jQEoRLvelM9+0bfWKqVuRginwE5zopmj+nKoMY2AHl4BE2R5M
	071GafctvzUPO83QYyaQMbFs6Vo0sK9h5SPQyUipQyms=
X-Received: by 2002:a05:6512:2245:b0:5b6:186e:b79a with SMTP id
 2adb3069b0e04-5b6186eb973mr6080393e87.54.1788964349854; Wed, 09 Sep 2026
 07:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909133247.113923-1-sigefriedhyy@gmail.com> <ab826712-6255-4e9b-b6fb-f6f8c380e779@6wind.com>
In-Reply-To: <ab826712-6255-4e9b-b6fb-f6f8c380e779@6wind.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Wed, 9 Sep 2026 23:32:17 +0900
X-Gm-Features: AcwNN1U-zJe9KiEEMqLOKTFtdT1jP5RPoJOJuwn6aNuKHcG4DvpUskIblRkLEwA
Message-ID: <CA+7S2vLDaZG=VGzCYWbGUybE=fJyzPoBdM-Wz0T0qp4Sa_EvGg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] rtnetlink: dump link-layer multicast addresses
To: nicolas.dichtel@6wind.com
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Nikolaos Gkarlis <nickgarlis@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Please, wait 24 hours before sending a new version:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-netdev.rst#n15

Acked, will be more careful next time.
