Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794229720;
	b=sp566638zToWLQkRxahCLOu6FWUXyWErVcJ70GeLl/2z6rwn8YsTmWul4Z4t/5Bzgt66
	 aV0IGh8WyQ6zRVMZOGm7+vbXs85+XrZI0CHgz8UojIsxOPAE7iA5W3lbog11lFcCYTI9w
	 bttjPQnR1cg2RWvNU5lTGWMjcPNZa3gEc6YUgu/ri/uISV791TM25Zn8CaAYPKT1q7dp8
	 F/qCVyTB9P1meoc7TwAv1LCzLpz4mnQb55EXyIXbt7Q6cf7io5aMVJgTcm80QhshGmyes
	 1ZBkVSZR5Dx7EW7MA90utwTFnH5Ll/qrwhXI/5aC+JT16ur7pczoATN18bq6YvXQLvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OKEddP/ZtNdVYxAML2vua9qtIab03bP2/fkLZgAxazY=;
	b=lb9OVK+QFJgWbvbkX8vUNykexMoaFM5Nlmi1nCV/5fO7F5OBSKOIEeC30vYCNjCkKa7t
	 jkPLJPBow/QmEaoVuVSIkanRP8Aw0SpsiI2ZJNRSsoS/6FPsIu2dv1sLxqi1vxinRZNp3
	 WOmdO8yfk7G9iWWPFDKTgCjAmQ3tIBZEUxtBfOVR9D5T496UnHQoTM3eaN49aidkovi/6
	 ZYt/KS46I2nIUxoQH8n2bnmXzK+1ic3gdu4IWRV4gUSQsGp8wN8dBBBFmblilChypvejk
	 eufcbhMCXDx8+mkR0g0PdIXGhb0vTpIBnqt71ErnsuJCHr79idc2v7X6SmpiWK+QG8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p4IxYHNy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0BB606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 13:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F0BB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p4IxYHNy
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdd4dafdce9so283604a12.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 05:08:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794229720; cv=none;
        d=google.com; s=arc-20260327;
        b=o3j9v+80qk8CrY0RXSU3zNv1uHg1rdnKwHfUkVllFFcDXKjGxsYjhD5rHLxKdUKBbh
         3Gyt9+lE5Xu1mRM7nSyxUi7WVoOfW56/mGAhB2G+7wJ2kLgEVifA5h8qbCFcD70wj9fe
         4DkDCVe+ecMJMNM1SekseBCUCW6CWAakIZ65k+lyxWZ77EIEyFK4r9TcViHTuOTXryCa
         wWSwbpiifgix/Tr5uxlT3icSjCqkHZ+Y2uGxSLDV8v6xuyStyoePQIEELE/VIWyHY0RP
         14FZKq+R37nR0F4cbNZZHUvQ46eMH0U8UKxM9B2fPAfvhooU4m1AjWUL/Ba8y3ISBLFw
         CJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OKEddP/ZtNdVYxAML2vua9qtIab03bP2/fkLZgAxazY=;
        fh=/plBHkLvoWY2y3qarenfwP9DO43UQ6rPZ8tG8ifzMtk=;
        b=PzR9mWzm1XJOLVcaGVFHvGzkJaEXp/qPFrdsay8jK0h08JNzMSTJuogYZ3z5YVGO+i
         UN0F5ttCYrTr4pf6Nr19IlFgKoMaoBKP78N3Z3cIr/AsQdDcEslPJXIfHk3wBcOiLNKo
         KYJhevCbOvb9iheOVcUxE2wKD9FGNyECeaWfCAaPwuRUQzGad9B1keIjGT7d0BM+/OvD
         2W4LAOI1PKSpVci+QuHyH77btWltE7iyUTB601ui7c4X2TFBugUoY8WLKYdYg5mzRrgV
         8V5+q9zCje1clSYu27SwL/GFhWpowOPO6rYWMuFx9yWAfZ9xFb05MpdqxyQsW/PHOGcJ
         BgoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794229720; x=1794834520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OKEddP/ZtNdVYxAML2vua9qtIab03bP2/fkLZgAxazY=;
        b=p4IxYHNy9MYAUzxRA1Ns5JvNBAn14iHWe+Ip41mYevrzh+ZYDSRy8qTiTXh8gb8q59
         vwenErXfWOavA+8b9ARCNbggSoufzK4ehPa8VbSbMduMoEeJ0kwRmWsrg8KwtasfO179
         u04BRIUXeHWJqfFaysiwQESkMmNfF/8pd7pht3Lgx64AFQ9gEW+sJQnAoNN9nhApzLzZ
         nAn4MX9QJdnl2F7b5J14XfU7kHVwtknCsniT8rGJyNm7Oqk+KpRBQX5cio4HmnVfbYXc
         edPPfcGkonxoODDNFBbJ9f7TrfkHb31v4nb947/KgsVhw+nmsYf1isDDmN6+JS8rUwaJ
         oB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794229720; x=1794834520;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OKEddP/ZtNdVYxAML2vua9qtIab03bP2/fkLZgAxazY=;
        b=ikM8OjznIhG53XRbAxBTPkkQYm9jUvKNUAd7ndpik+osmSgo4Y1YUYocuHRx0npIiu
         bTDA+45dnVoemeXfRsGVPa3Zh8F/Yd9LGkA135bj3hRoIIv3V1Yot3CG8V/ZVnnKkSF5
         cBz7oHgfhtrWiiJuAQxXIpjQ+FD7K5Tmwab28wxzqFGs+s4lYEPo8uJE1mxs9j1sxzMC
         R5KWwx6kJGB3q4MCXjBZWHX4VwHkep6nVnrI1wE3w9QHNyX1VlQTpg82i0hGlxQBhcSr
         v8FqdWN7BJIXOjig2/3+Q7egqSPOgh1hPnQQuBCmEvt0oyH8586V92hkCNgLOwAnvmau
         T7dQ==
X-Forwarded-Encrypted: i=1; AL+hErE3hVWLtu1kC2UOD/FhTLKP2PtD9Wfjgb/1UAXTKN2zVGikwcASMAsXGRE/qznGKRpmYrQAHeQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tZkly5gFhoZqJ13nsfw+RjR1C0TzSoT/qclcUMnuXJ1lWGHKA
	o5T3EJU5Kz2DiWQioVApmt4aESdEUv0/VCt9cDBWImzJb0zClgT76zZ1RzK/In89ZuQ8PjyC6GT
	TZg9BfGeLdfU6PeUUtexEgjVWCApSLYYrEn2k
X-Gm-Gg: AYBFou3fpV9bIww17huWv4ggCwHKjVw9mqMgVKLBUABXDuiIDSlwMz06QaSytdOjroY
	m6jtNwRYIEt7tpSwxnIghDCwN/awLs6PrqrPyt92Z2R+q8hwK9J+jiRwDYyZYJMe0drX72edQ8X
	JyYWtoxFcZIpLavmEEAceQXkRwlV98LQ6BNaldIpmjQ0CVqwyJn6Wv6Ja/bqaGgNGOIY7YfVCAY
	/IraHshjgcQDOdUwGU0y/KlyEqUneIE6jmivBGft6nL3ghpfJHYjH5PKuwewxzQCwaf1H/xhcT9
	bobl6I4M/0hivO4xS08PfnvgFhhk9qEIq9mRtRKxk3FOPnbx7CJR8bq6mE28XafjrH+hfC6i3RF
	dnpQOM8wgOfSNXBE5PqaKVyQ0vwf6+rtc7YrhlA==
X-Received: by 2002:a17:903:3890:b0:2e9:9524:b004 with SMTP id
 d9443c01a7336-2ed83793651mr35834995ad.59.1794229719514; Mon, 09 Nov 2026
 05:08:39 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109125312.2208874-1-graypanda.inzag@gmail.com> <179422894695.488859.13925819352934947141@kernel.org>
In-Reply-To: <179422894695.488859.13925819352934947141@kernel.org>
From: Junyoung Jang <graypanda.inzag@gmail.com>
Date: Mon, 9 Nov 2026 22:08:25 +0900
X-Gm-Features: AclHuK_r-BhklqLacdFk7flA9saDqgS8hhdjYf5Wqi5mheW7AFHXSdxfF9SF8I4
Message-ID: <CAO7ntTRXoVY11BPcVD849enGM0uEiSD5mZtNr-Gc3fjpyGNW7g@mail.gmail.com>
Subject: Re: [PATCH net] igmp: use the joined device when leaving a multicast group
To: netdev-bot+sinfo@kernel.org
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This issue was initially spotted using an experimental code analysis
tool we are researching, and subsequently confirmed via manual code
inspection.

The bug and the fix were dynamically verified in a local QEMU test
environment by reproducing the condition and confirming the patch
resolves it cleanly. I will include these details in the commit
message if a v2 is needed.

Best regards,
Junyoung Jang

On Mon, Nov 9, 2026 at 9:55=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
