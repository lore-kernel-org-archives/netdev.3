Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698FC389E07
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620055; cv=pass; b=PGfw0tcPzVLumnbmTAl7wuFj34t2Jk6jfRwn/lsYlSBEQWuX6P4Xp4Jt9mJthchno0iRwr8jLt9n8Vv8s25k+NeUM2285WB5bbfeR9CXSHnrI9bnbIPw0brCfZAtxgzsrwTqRhcO2KUPHHunLOpiuo2MAs/QGx6YecPFWdEL/pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620055; c=relaxed/simple;
	bh=0p+1FcM4auFFpjb8JK6RspsnLEFEVKSBlFLSX9Qj6YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpBZ/mnGDPMm/0pEHkaoJRBkuinRBplyTJ6pN8kMfmOaKhh5RjxkF7CCDNhD3Q/z3B0njPZoHkOKRvW06Jq0k8AGZbSpqhyIufO/C9X+Y/8QCpzD0h6J00Hk6lnHsOJarWj/jVvoRwEDzzZOpnqZ3RFHrZpngciOlGMeQaUcHk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yvrv/DEY; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yvrv/DEY"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939ca12ab70so430798185a.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790620053; cv=none;
        d=google.com; s=arc-20260327;
        b=I4f9RjyuZOhL7eyaUyzCLzfJQ4WZC3Z6KkaahyAISoQoopwxFjAoCVNQif45Ma38P6
         aSqg6/Fss2FmDDcxZOVxzfFkb31tcpknqemGZT+7dHyh8fv5kKL+JbVmfvOFHqBZPqfy
         LlnkmcivWjAqVbIWONZk10UVtLM+dCYfSlv7v5MK7gi0RBalRVsMSZi6zi7KGib33IO4
         +t0fr4wBI57M2lu0+o74z8wxYAU/YMlQ/ZSQlEpenrzVEs7LJ0VbU19E+HvpWbFDxyHM
         gy3i8ojsM7Kx2YqKvcN8M1CLbsieDtkDAUlpqNDl34WxgC1r3OXwmaJ/ftEYy0rkRMfr
         3z0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0p+1FcM4auFFpjb8JK6RspsnLEFEVKSBlFLSX9Qj6YA=;
        fh=bultddj7DlG5m2zPfGObSpVXHmtUnCn7OTfZZ5ruN7M=;
        b=pFsRJnBYmoo+A25k4oV9YZOAclBIUjmaljpBbyzNXsoDRsjEaaIReB95ePwYZa3Y2E
         1R7rUMGV4YxOKb8pOqvbyywNKTiT/3B/eEoLM8eN99i7i/d0WlaLjqEE6ZS9v08Erm84
         sftb9O/bJnUj4P6sE2VI7mOy8UHwWRzbmYxvT4/2gQvJekY2FMKmlOC/PxsDsT6QZO0c
         ffvdgGtDUxx2UloLH/NQ7g1TTZvajxhp6Aluvw8kCX9Olo0ww0bjHI392cgXcysBvKRT
         PkMpHGTrqbDp7ra/zQ2OXV5oHqJfvwvbL9nJJn4CF/pIS99pRDKTI7OBDcKub7SzUQWe
         bsFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790620053; x=1791224853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0p+1FcM4auFFpjb8JK6RspsnLEFEVKSBlFLSX9Qj6YA=;
        b=Yvrv/DEYZi4ZR2fjeZ7XWootQGnar5vMQsG/k+FhKfOnbAJojdvHwohTCJ481gK+Cr
         t9h34anbhwuySEc2dcua6We7mBR5izCp4/c/8abOmT5i1dEIccFSi7Ax/Vg8wQyIkgDf
         3eLwDV/7JT3+YgCPrESS/vwuWPGI0x6D6JnJzjquGbHYAyAl6e5WRYMj0jScAf+un/xZ
         do1VtP3TGaPrjJFsRfpv1V4GtGefJRKRzaFfL53uhtsxGwUvNmPoVKenLMJfGsBEmQZ6
         EkU4bD+9LDw61YrXaoBsJPgHw4unRKpdG+XO9K3jVkwDpiOHFylcXUsCdCmSukxKQQHH
         M92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620053; x=1791224853;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0p+1FcM4auFFpjb8JK6RspsnLEFEVKSBlFLSX9Qj6YA=;
        b=BL2P1mmlV/DrrmhLqlBMyrheuLlbKn5sSiqCzri+oVGAVtDODOLqY/dctKH16FzGZr
         dYItMIPzBqV9ndBr2eEFP8ec8eCBKeUvzcKry7He0Vlv+D8u1EABXO1ZLNTga4+/iQRd
         Pk3a2iSKc6OASNZYxQsOStSV0JnjffsM9Iyu+qPPe86jxblAT7vbhjCMhqKbYXMVxez8
         HJs0zTJF52Og44sJM/36jLOMpei0a6GTVi3V9VpbSSiuIeqqwchprIWxPWmGe9fnb/3W
         rcpKpHgNaMQa1GQmdXf2mxdJk2kQeBTnXdSb1NcDdD0yg8mnAiG89UJFHrwMQ3EFIK0O
         XRnQ==
X-Forwarded-Encrypted: i=1; AKwUvBw69H2mYlh2ngti9jE9RrFvwYkgey8tKOPTmuvjIulGwyGVkBcEBXyPHK4etktb9PoJt/n+f3I=@vger.kernel.org
X-Gm-Message-State: AFuF++ms44zDbI+GbIY3xdgaGojn4KVkfhAzevU1HAwOJn0Zsq89UGzO
	Z+FRBiw3uf5YHMU4BG1mWqyOaXTS5oMLrC1Vo5rw9ADtyJTOLIbl7Ay907RV5h9gTvK0d0UjbWl
	ch9vAPMsa5EKEP6x49mG0e8BgL9URNyleyiCbadzR
X-Gm-Gg: AYBFou0XswLViIUEnNexFGLqRixlJ+B5Q7fw9QuIv48aXYzsQI7DwXbw2aSFQ9M7lwL
	84uvxo4ULNCJ4UNWfkT179NQ2UBzJkukaPPndmoUs2MlPgksiPKi4qEEGQdoWgoW6abUS3auqo3
	huJKUAV1+eSFAsCL/GQ+Xty8cUA4Bb5MJQgfWdp7T4aV+/CB7lu92YUaR0XZPVexTkKdHpjJ9Ew
	fvoR07OKIkynQxVu8Ovx+C7bLEsAfxbc/Q7oslHdXNmmqd5K5Sw4pcSGBrFB/vkI2R0SKFlwCB4
	3tpww50xK6OawKiYD72uw89tSDxV+w6R55Rh3SrkBIkpH18HsGFVTUk+FrZrJf6r4cc7AjVL9MT
	NxVOuXxNiwiBI4Tzlk7K0LqibS2oxtNvHmjbB3vm7/24SxsR2ABbxfy5/kT23KnKuhYbc
X-Received: by 2002:a05:620a:40d6:b0:932:ddff:1241 with SMTP id
 af79cd13be357-93c4738cc70mr2120552685a.26.1790620052603; Mon, 28 Sep 2026
 11:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925135244.3715196-1-edumazet@google.com> <20260925135244.3715196-3-edumazet@google.com>
 <CAEA6p_A4Rgk81_=b+osGxV-0PmcBDkP2H98=+bgp74jraVNueQ@mail.gmail.com>
In-Reply-To: <CAEA6p_A4Rgk81_=b+osGxV-0PmcBDkP2H98=+bgp74jraVNueQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 28 Sep 2026 20:27:20 +0200
X-Gm-Features: AclHuK8BMrAWgBDXT_SPHKWMKPh1oaK_tvecrWK9nVzMAc3o3ngcIFqgmsZOpcg
Message-ID: <CANn89iJzxemnDsN74RCoEiwcz=NbUzb+=-WbXior_o=-=5H9Sw@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/2] selftests/net: add SO_RESERVE_MEM test
To: Wei Wang <weiwan@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cai Xinchen <caixinchen1@huawei.com>, netdev@vger.kernel.org, edumazet@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 7:22=E2=80=AFPM Wei Wang <weiwan@google.com> wrote:
>

> Should we add
> #ifndef SO_RESERVE_MEM
> #define SO_RESERVE_MEM 73
> #endif
> for systems which don't have SO_RESERVE_MEM defined?

I removed it after sashiko rightfully complained.

https://lore.kernel.org/netdev/179034054266.2160803.16187930067723490774@ke=
rnel.org/



> Add a test for check_non_tcp_rejected(_metadata, AF_INET, SOCK_DGRAM,
> 0, 0) to validate that non-TCP socket with val =3D 0 also returns
> -EOPNOTSUPP rather than 0?

Hmm... I feel the test is already quite lengthy :)
