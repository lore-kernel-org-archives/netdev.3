Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811452F8E98
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455000; cv=pass; b=EirQAJJlR7FG4CdTrJDyP+NsBRUz5nrvSsIS1VZ+1cY/zPFzwQBixbtjhe8bcJH2jSYEsELxcERLbBYko3syZriO38tQGJNF11VM+fcxx2yyxC/2j3L/m/Vh5f9ABpWDPhb1nFngcNjFNN4erPaLW8eX4LBNJKJ3pUVG1v2hCh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455000; c=relaxed/simple;
	bh=ViAzSCEVPyGnpT0l74viYf9vMOKI+hAiW8VZA/P9qQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThDdfRIV1FBT7y83ddt6gSE8UmlXn36ns0Ew74RIvQ/h69Aj63xnwHgSYegi7lKu1Pr/heajGuZ6nyueib1KmpLQgM+ytJheHoIzjkv7HcaBb3vRmhtvcSVEgIW5ssrXy1pcax0LvxZo6l93qvO4JpO4FGcdcj8RD3s4H1en1T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/DyzGM6; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/DyzGM6"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e9faea93a1so634834a34.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786454998; cv=none;
        d=google.com; s=arc-20260327;
        b=qUPZ0U1TkJDkAPjXX4YFQqkNBPl3l/wXc/kUgArf7/N72ACgVoaDl1unarFvC29edP
         Ojjkcxs7qAoF6EpEzyeRsju2A+v3NhmswdIr262lP1fUgA7SxITNkF/2hDtk5wnrXr5E
         0HyJfbNJoUjmFYKP74czMSlOAAAlozh2AHO5wZStGWcCXqQvsd4xd5ONem63XmxGwqxq
         RHd2wotnpps1SUMg7CFjdAs8fpW1Z6sAnSz2B5bzuZN5x3j+ObzJmC4cFiJsDoYtuT4c
         dwURHsmcap+BUlkhYdbzveX5hKC6mapCYv6WcmnB/6Kmu1TtFOBWXR4d/uETt1xrjTOg
         2aNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ViAzSCEVPyGnpT0l74viYf9vMOKI+hAiW8VZA/P9qQc=;
        fh=xpeeX/TBcBwVwVF0l3mKscCtKgUAk7K0qaN2AJT9HQ8=;
        b=T6AhnmbBDqW31xhhX0/NK1AOT2MkQQbTNNOwFf1u6yRLORGkvWvNa9rLf7Gz1goCMT
         KFgg2seMKgsG9V1qNxkHxVC275Q0QV9E26p4BJcCHWymJgpoX7GGDK8OfP4rU+vJNYk2
         8VWi8pApA96Cgh1uK0vqZzGyX2ghL8yS6EZjd2x/hC/ZKKPya8kbmvgFHqvV5Ibjx4hQ
         bc/PwZOYR5zDYTaX5g0k14ajeou+okbSDq6iDkmCeC2NjNAvibLV9afIgtbdiEA+UGEY
         A31ssggapoa6eh2huFYZSKLaGe7ghmSVawHIpZHhA4To0d4A/LiZ4FOC9HO4rzK8/6mW
         0kjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786454998; x=1787059798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ViAzSCEVPyGnpT0l74viYf9vMOKI+hAiW8VZA/P9qQc=;
        b=a/DyzGM66u2p3eH4EJsgui4wVDoclDvEwc37wnwGiA4i8D7sPQGOF7nzNB8WyMsnjY
         +sHz6O4zqqRDMbD32B+1PM78Dq8/5hLy7mcgLdB7H8FQHD/8LRwjKHQ7bgWtWBsrfs0r
         ovpO2kljAGtjMqsOgQUJkkLNTuADOJofMOzgQ2gebXQvbTZi9vt28E4H3VbQdVFXUFIU
         xwij4w02SRWFLqzP+jCOLSYULWEzm+y6xUOIhleHJXd7D2/fp27VI/UnEhmOywLp+eox
         CiXpy4cT9GX8vov/kw7KEqGARsTTmlXQ1lLvWBkhI7Tm5Y/geYblswhxwX8PffpUMnGt
         RE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786454998; x=1787059798;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ViAzSCEVPyGnpT0l74viYf9vMOKI+hAiW8VZA/P9qQc=;
        b=KVqKUbBCKLn8kw7nHfp1PhrRxZoKQjXgxFnNby/VeWhM1ym32rNn4DCjcE0Dm/2kC4
         1paaoDu4bgoYr3ML4E15SvAv7d1C860gP62thHvE9pRD8oqlo+OfaR+MDdp2KbP8FRQE
         aBWiwWX6Zx/CYfqgFyWjPXS6tTaY8NFmqj4yXKGOHcjOGgkCK2gTo1v3NICDaanPpFgD
         nsiOsOaNOGJT9CnKCqW30pDrPGsnXLgO72XQIvvsUX3RG1lyRHA8i8BFGmiH9KWyWJ/p
         WWHdRGCuW2UYKJlRpEkDaA84RsPhCZacHTSS8RlRpchL1tvTdM9stCZ7+3pPXUYZ0K3d
         aIkg==
X-Forwarded-Encrypted: i=1; AHgh+RrPwEyUqVqoJBSOGN8ounaZSgDTcnsrnYJqxyRLFZYe+zdPRn2xjG0kcDMFu5Xdz1AiBu0y0yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZXFhiyulUwV85+v6/HxrxK6jydZ7TUPT/3apJJCCFwLxX1o0x
	e0k+H/Lasw7nCk+Jl8SFDGJIu1d/YrrEW6wkm6ejS7Nd5Eks/4+mqWGTdGO0oFKVY4rQ7H5TOwF
	KElUipmmgEmPpzlQU13oiWuefe6Lhk+c=
X-Gm-Gg: AR+sD10CaD0xeQ0nV/lyoEy8mFu+zveGRe4TUMcNtEF6wROD0X02NCrXTDAZ+S6aw4t
	7pIYPFELS2ny6HK7YvhrUuNhkADpDqWcveMYb8k4cPBe2H4HUOhQAHLpC5Nbv/uMVboZDg+LYDD
	MRQFT4j8qVEctzozASX6o9I6nJE1R8fcE9j10KTtaNvA8KWpPH2rUIsF1R5nbco4U9QNIExSO4L
	09MymOFSnZNT2454PQ6VAh3ROH/3EUmkkUeuIWTlUN/Ejc8730I3Q7r2lWcubB8suaO4XW28z3/
	4iatStkykFjR4YqKszZtgyRw21WHT4p2cL+ixhFSPCHN3itD6RTi/ha332F9Tyz0/zWsehY=
X-Received: by 2002:a05:6808:14d0:b0:4a4:866:c1c5 with SMTP id
 5614622812f47-4b1fd7e4969mr1277655b6e.2.1786454998187; Tue, 11 Aug 2026
 06:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810-netcons-userdata-rcu-v3-0-f65557f769ce@debian.org> <20260810-netcons-userdata-rcu-v3-2-f65557f769ce@debian.org>
In-Reply-To: <20260810-netcons-userdata-rcu-v3-2-f65557f769ce@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Tue, 11 Aug 2026 14:29:46 +0100
X-Gm-Features: AUfX_mz0vefpeaC2fQ95LgAql-KWU00OZpOsox7mA5epPek9asPJpJDhvdzWgoQ
Message-ID: <CAGSyskXtFf1nQXtu=ndA0BsP9yHjv0mJQneqLopZJr2uPWMzEA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] selftests: netconsole: add a userdata
 torture test
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 10:36=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> The userdata payload is rebuilt and republished on every configfs write,
> including while the target is enabled and messages are being sent.
>
> Add netcons_userdata.sh that runs random tests with userdata.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>
