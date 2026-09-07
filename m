Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8342E413
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796349; cv=pass; b=e5GEKao3OiJPdKBhUZ3GYSbE5mw7CRzPJlrnaM1TgKySCBQb9TdZy6w7/HXYOmy1IIdYqjyNfcZNfYHwDeKL5i7/IDUA1ZV5F0jFhF8tTNbBTAowrMuRy8bN8bI/Tm5y6OztG3i+dBD40FaR10YLEyEnKpwBrjPFsJE9sCA6Qnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796349; c=relaxed/simple;
	bh=3sHMsy2UjqzYCgl+C2yC910BzPVXDrOBCwPlt3+j93I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rks9hdqNKBRpRpTYV8ZZTmRHSFFwmL5pIh8AW5WeWHmzGhc9LC+2+xYxPhIfrMR564YWLLjx7dLxu2T+dZ7YyH1Wl+SweqzP9deKGWdLZHpUPZnBjzzuGO+iWv+FImN3hvuvc1TIO6N7y1HB9d089RCZAvoEaDqEQ0tpy7Y3uog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BR0i2jEa; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BR0i2jEa"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92edb12cdf2so247136785a.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 08:52:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788796347; cv=none;
        d=google.com; s=arc-20260327;
        b=MnorA88OpF/vnJUXMpKTML5sEP+S1+7Dv1pvkAxCTnia4bLltiCPZXAUDy86FhYVvJ
         2jhhxqY+FP2tInAyqhh8vqmd1BpgO1NbgVa+U1SE2dGndvYhy0yil54jy+7AN1VLNK+j
         LmxVQvoZpTMJ3D5uDPKSfK8duMhj/xJzqNYXTWtRGSEo2Y/Bqt1ZQaggtZzQ5/X0Lipc
         NHAPCC8Etkih4/7HXrh0ed9v3EOTjO3Ua4Drk4StrhhvC1de689Wqs+q+EWgWxh65y14
         WXkk06fl4fjYImsBG8kg5vTZOdEJaMpiz5Y6iUxlZ15riTf1RXqra7xPHWTElxWppLcU
         ZhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IidEmauyWVWzyJWpxVrjh5qYTT4K6xHCWOktMtWsnZU=;
        fh=eQp5FnJbkzrSGmvhd5pyKbB+aQzemQ2BgXVtlssGVbI=;
        b=izLcInLaGl0+gqoVOKrJKQeqNvP/TjzwOs5QepuUgzokUdUi6kTpPBGd0OTLZgEAKl
         UqjFOUOUTy3yXLI8A4XM4eiygj8D26AddH2Zvkmvn1xOBwNXzWEs3F7pZ7mnhA4CEMBz
         KRcusp/edWb4LipM5qxY+TZbW27Jx/sgJzJwQaM/TzBIH74bhj9y5qLEabUBgjNdgxja
         bWF8AKXeo4X7XFHFC6ouHBD0kPogpqtNnEfqRu0BHMUQUCLoQprIGvFMHxvZlT/YkMLC
         +mYZvkwqIaYDXGx1oJCzCtewe+sRCz5z5HHIE5nS8CT1loJpls/ddZd9Oy5uKkrLS4vx
         gyKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788796347; x=1789401147; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IidEmauyWVWzyJWpxVrjh5qYTT4K6xHCWOktMtWsnZU=;
        b=BR0i2jEaBjKjZEU3gJGnOFYBFBVmglau1I+EyP4Raj0rXFuhQnHmTAclG0P0ncue6E
         8MLiRb/ROKIcMMfLviB/SepDl12v9I39ymf49QNy5Qw8q0SaNBJ0nC8uZbx4EPcSq4Qq
         GGuRmWEUH2Q+59Ahjm/mxa86ms2NxTJBw6Y2sSqvDwJxDxOnhHavXh4CiFR8iJHUeUPO
         IjPp6Nv9oTP/tusf8I0477/iqS3qlFmVoY0I9iFd8omwasVqihUaHApkmEJERRlVvFQj
         MBtcgx9Rf2qvdcdB5s2L3N59Q+I3DIgnuP/3TjRYc6Vw4HEVloTgtk6CA2mHfS3Pzife
         Tntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796347; x=1789401147;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IidEmauyWVWzyJWpxVrjh5qYTT4K6xHCWOktMtWsnZU=;
        b=JPIbrXtdXJDqtN9UA+feS5vTLueDPaI2Bl+cnrJdddtN/YvAPirJmMR23AwUW7q5uc
         6NheM06Kwe9qeADpbdQTdd+VRV9v7JcE7Pw90cDnmSCQtb+WiZH6nTMlT5lTRlwh9per
         D6cN9//pt21fVzoCACPYJ+WFq4XhADpGT5r5C8JMGNBpOhLoYNTKXpZPNheiS2fLjuar
         SvaWe48jdXX4cXPTNjNQ/bLFMtlk5RW3QeYTWMn+ZH4jREEHkZ2EnSECFk9r6bJajRhh
         ke+d5BX4XByS9n8ZkKAgzZPl+HcYX9CQE4edY2VukVxNldvaymI+P09FzzwlKeb3XxIZ
         FNHw==
X-Forwarded-Encrypted: i=1; AKwUvByLGiBer+9i/D0jWonra1Rn7Jqtvc+cDBQiDdVVtJ2x4zcwlr3Dhek30l1kbn3I1b078Y4lOSY=@vger.kernel.org
X-Gm-Message-State: AFuF++kejFm4oHR4m34dY0IzwS3wrycSJzqVIUuNAI1x19Qxh4TXiDPT
	Jp8LFmgF7gQduxsITU4BBel3ZIpZfY/MnteuPgu0a4e/L87cpH2WRbGcMKUiQVqk89jCScttJqw
	z0ZbXJCkm3YoyN/zeo7CH5vxpzq7672HGrn00iUD5
X-Gm-Gg: AYBFou3kmYfQR6wwMErH3yJx1zY/yhUCM0akGFJjs2HTTiArTTMWNlK8PZH0cSbGwG7
	slwMDPi4HAaMcFs4ELjY1eQMUIXJum1iI3D5mMlEbVhmWMVKpmCqpTqMQKIX1d8u2dxqI8HHZxn
	BG1/izd0HG2ghI1cO3W6D/Fl15wFeG1t440GeAQdIqAe47VD9iAemyzZc9CVGN1Xrqas5CIub5X
	78Vjo37Chu2bzpGrv7jWdat1fed8aIwBzA4cyw76tKDYtt3JAzIx4AoWX6K3N+Pn1VWS6IEGJz5
	4F1zDDA5vj1ZFEl13EzSujp7IHM/60li0NXcxJq7MH9QEO0AIROQOppzfZQPcV/kZtbyTMAlbES
	YLAVjniNAYlMIVIC49/SKxCAT1xDKdMSp+wj5u/e4rmC9Jyip4DyzJTIPWQ==
X-Received: by 2002:a05:620a:800e:b0:939:9f3e:81ae with SMTP id
 af79cd13be357-9399f3e880dmr1289676485a.43.1788796346277; Mon, 07 Sep 2026
 08:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907132423.3353361-1-edumazet@google.com> <20260907153733.GA755346@shredder>
In-Reply-To: <20260907153733.GA755346@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 17:52:13 +0200
X-Gm-Features: AcwNN1WqSebVhZS5kg8-reBW5ZE6KNhxfo6Pj-qZ0NKzl2yFcelA0y5GA8I2hs0
Message-ID: <CANn89iKAFuAKgR=pZSfNWtNj9aT_PgmZzfu04mt14S1UFfeN=Q@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: icmp_redirect: remove xfail support
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 5:37=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:

> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> FTR, I don't think cd51b74bdd0b ("ipv6: Fix redirect exception creation
> for UDP/RAW sockets") is what fixed the xfail (I never saw xfail, even
> before my patch). It's more likely that it was fixed by commit
> 0e02bf5de46a ("selftests: icmp_redirect: IPv6 PMTU info should be
> cleared after redirect"):
>
> 1. The redirect message quotes an echo request, so it's going through
> icmpv6_err() which calls ip6_redirect() using the correct oif. It's
> possible that rawv6_err() later called ip6_sk_redirect(), but by then
> the exception was already present / populated.

Ah right,  I will send a V2 with an updated changelog, thanks!

pw-bot: cr

>
> 2. Both 0e02bf5de46a and 0a36a75c6818 mention the same test case: "mtu
> exception plus redirect".
