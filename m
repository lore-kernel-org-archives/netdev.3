Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4626D2E6CA6
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420244; cv=pass; b=l3NbXFvmHqk1nA0scdPmE0rC4g7dhvt0b5JgrIUzX0KU41YpM3XZ11OfOVZjyoLSwrspLxQax8DgcutlT7xEExpibrCMGEBScQjlZ+GMTzK/64Vc03sYofo7b5YGgxbMSqwCOSU/+GDkAFwBeY7qfY4Rbuvk7OfTWbLyGu7DjiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420244; c=relaxed/simple;
	bh=pyUTRzztkNysAHz5zZ/m63bBk1seX3fH965UwrO0NQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7pjjuZpn/d27jW0zCfL8C7ty9MY0G2lojBlzyrSd5FfS/26xfCo6AZELjpWAr3CcpTE7NT2e/7iKCDlF50WEX/7PayKknne7BfGjSFmAKZl2N43dVars6FurdNXmyZftEgaDP1c8ZXmz8XxWVos5ofgSqV6WvPgSS0AyXK0s7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHIU0ax+; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHIU0ax+"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-930c0f9c1b1so220558085a.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 00:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788420242; cv=none;
        d=google.com; s=arc-20260327;
        b=pwXNs9O0Q512LGDZYzd6aDY2LfRdcR7tQ4z1VTdCsN+QWh8YgvDNGOA6L2RbC6Y/th
         Ai0w123etpdp8Z07KBJUXEVHIuS4J1KeWy0+ITFu/3jN3YaxyULSfqVMCF2LER1VE44E
         KGsr1nxu8CryCF5FtFGjDfUVNgppCbDFByDJ0KnpZAtY3S7qxSwiWuZuDbkMrmPDqfCP
         qI7QDBMJCXraI++LlvJBj7rdjusyLBFmj407LOY/ZAnqcIixo/HhGnhZyvnklusLfQ1s
         q26bfsuigdsYaRw2PIwFfyhzZd7dY1PmqI7N0Dw19K0A0aBgDvP06jT36F2gBZ6r/Y+L
         oFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pyUTRzztkNysAHz5zZ/m63bBk1seX3fH965UwrO0NQI=;
        fh=qVlL0dlo4rDjJr8nufSzWU/wLzVaGZunrRZ51FJRQ40=;
        b=q46wM36qMEM/nszOAFtz44+1DpZGjKjXr4DaQyTlZG461PLv7c6PlpJa8qM2F40TSa
         4CeQWhhJcMVqAoW4VnKXdChZUmMCS6qqlFblaKELgvcwoWf5HuNJX2MpwMQrSUCsarMj
         wA/9G7Pp5o/Y2FWbh722/Nx+duCG/Su5GHn5pBIwpte0xLD/6Q2fpFcCs8b5L2waaZIv
         eSNOypIMmCReVubCt1vwbV1RXqsEp1NNb15diGzhyQThvI9l6gYK9hIHaJtdrlkwrm4O
         euYrBQwFb5KxQ+vzFZsuaj+qP6l6YDRS/9uzyDwMLkAW/kfjWXqDkeGgsfcmxnWvgINY
         vcuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788420242; x=1789025042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pyUTRzztkNysAHz5zZ/m63bBk1seX3fH965UwrO0NQI=;
        b=UHIU0ax+dFKz3+nXUMjdrWoETwgfwvabCJd2N/McPr7ARu3wzMy1Ipt55zmnAWxt5I
         CmT4Ea0CMr7hM5vYINu2BU0ZYoPHe4gyZfPr+CrHaFV1+dCDuA8219qy136DhyS9KWzN
         D3u3gfJOlkhUq3Tta8YtlMJi4OrxjwGn3LZK+o905MeT+5nnXcAemJXBbeLkkE+pSFcQ
         7J8fk57TebuFaiTi7FFFnygxG1vIVcVeMbiH8m74QUkHM0ituIpQ9hulf4zgOwOolIsA
         E1+nJi+YfNAJmemRjdbWMr2sNDgZkRIwcJdC69zCGLgYHJbkOqcAjDCQPxagiVUI6KM4
         huhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788420242; x=1789025042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pyUTRzztkNysAHz5zZ/m63bBk1seX3fH965UwrO0NQI=;
        b=p000NvkcBqXfMydKflmM+6lUSQ5BaMou27v7qsEuzD2zRqamRDha4/pPzWNmAafkW/
         FSCM+jm8SXav3Fwewld4A6D27+529f0/dxI5z3JcxQJE8Ka+nNn02SUSzik/4oGuYyC/
         BerOKel9/M4C6lIDXgSzS6XsQ54kVqvN6bMVzFA7nYezRTRCLwkfulL4ClqHZbe1UESJ
         YZ0ZkdVb/U3JvzC82QaOCpwI88sVEMq096Be3xvC6SW5Fk82GWbc6EZjz1vvPq+C6hM6
         YzQR8jqs2hqvrmj1O2jGYAW04l4+7ubJA5cm/oJNa96UfawZzFkIc6zBVqaEXAKy1Rzg
         Utrw==
X-Forwarded-Encrypted: i=1; AKwUvByx9hI1lYLDAhtK8k3KDMceSN3aGXbhoSVT1x1F88AHCddiGXP/9xlVV01NzeXr5tJYl0qY2Zw=@vger.kernel.org
X-Gm-Message-State: AFuF++kd+ug/k3HO4S8u8lqErjb3Z0mGhmZ/kFVL9+h0UXWNEwmJh67U
	GshJxmkM6EELaqsRzbXjzb0zTX3eQqZxq3qwzbTZrWJK61rbqplEN3xpPp9vK47svr94ahvEHNC
	jrfRfvfH4BMUF2nayaSeO90Ood37/ziUr4OAwKY2E3FvWVL4ADZi0dl3M
X-Gm-Gg: AYBFou1EAzwsnqoEOK3Qs335gCa+2oJ6C74paq4hRMD1BhSK8NVMkWmaMO9Ec1FpATo
	O6899WjBG4fkMG4FrvZGpLnNzaiAL5ny9V6DGPCgxdYDz5egQoQweHedP8kPDj6YAQebLGOohf6
	+zX7kdJp2dJ70WJW8tEGMQgL/HspfIaUgjUbLMP/xYDVcR5txROJPA6zHfSmHKBcR5vbyrJnUI2
	xRYyzhFLUmfh87Rs4ApTiILaH6G8PfApsvuJ1/IAUesw+Ws2ZqFv+veK37rQ5kvkIYKukHZtTRQ
	AybZM0UadNk/cpHnybYpR/K6IxugiS9BQKWp3Z70gJzW0L+6h8YS7CuX/ikQ7Wcrr8RJcnpIvTl
	y/uEFDj7S1kgSafP/gYd9Y+7YZgE5HYEyoNn7MGFvAlxl0gxnkOs0Pq4FEw==
X-Received: by 2002:a05:620a:8294:b0:92e:520a:ffab with SMTP id
 af79cd13be357-93960fa6718mr932004385a.38.1788420241557; Thu, 03 Sep 2026
 00:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788415194.git.zhilinz@nebusec.ai> <83f8535972ff6e3741548476a1d50dec24c758be.1788415194.git.zhilinz@nebusec.ai>
In-Reply-To: <83f8535972ff6e3741548476a1d50dec24c758be.1788415194.git.zhilinz@nebusec.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Sep 2026 09:23:50 +0200
X-Gm-Features: AcwNN1XoUXMb4WoPwGziYZrhc8F9mKNLzZxiM9bXCdm8rAGbuw3zhN9HOa1rif0
Message-ID: <CANn89iJP_=EiwD_CRpr8b6zfcmJs_K5NA+Wif=7LO7-GLsMnXg@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] ipv6: flowlabel: cap duplicate leases per socket
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: idosch@nvidia.com, netdev@vger.kernel.org, dsahern@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 8:23=E2=80=AFAM Zhiling Zou <zhilinz@nebusec.ai> wro=
te:
>
> ipv6_flowlabel_get() allocates an ipv6_fl_socklist entry for every
> successful GET. The recheck path for a compatible existing flowlabel
> links another lease without applying any lease admission check. Repeated
> GET requests for one shareable label can therefore grow a socket's lease
> list without bound.
>
> Reject a new unprivileged lease once the socket already holds
> FL_MAX_PER_SOCK leases. Check this on the shared recheck path so reuse
> of a globally interned label, including the fl_intern() collision path,
> is covered as well. New-label admission remains under the existing
> mem_check() policy.
>
> Use capable(CAP_NET_ADMIN) rather than ns_capable(), matching
> mem_check(). An unprivileged user must not bypass the cap by creating a
> user namespace and a netns where they have CAP_NET_ADMIN, which would
> still consume host memory.
>
> Check the capability only when the socket reaches the limit, so
> successful unprivileged GET requests below the cap do not generate a
> capability audit. Do the admission check before updating linger and
> expires so a rejected GET does not refresh the shared label, matching
> the existing socket-list allocation failure path.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

Reviewed-by: Eric Dumazet <edumazet@google.com>
