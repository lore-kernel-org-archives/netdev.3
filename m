Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035AF38758D
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379522; cv=pass; b=qxl3poODo5Jxmv9qmLT/uZk5CxyQ6JDCUpfisR3Xo68KX3K4/8b/d/t0dJr5JgUAK5Yur4sDE4DmuFEUPW0L3bbvvHBJMfgBItgzd42Ce6QIM1zPT0XLYJAM0Ko0/j6gCryT2wiZP9ocWyIJWpgcDU7V+06BaH7+nWwUe3+Qk5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379522; c=relaxed/simple;
	bh=r4+e5uMoZNj7ZCkw8C4enM+dD5yuNoZmNknGMAbiFK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBDDuI2Mub8zCRIT9TcM4+aWNJTzvnqkOKM0yxfV1FTUf7HQzaVtzEs6NeCYnkMxt4LZSHnjY1UUX9YQaglN/yJizV690zbukPYvbnwYrsEQs3UBXU7BvghwheEZsgsP/znebyUOKDoQ873BZi8cHWHxAheKTPP9Z9cYDwVaiTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XK+mHN/m; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XK+mHN/m"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6ab0140ecb2so13116a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 06:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791379502; cv=none;
        d=google.com; s=arc-20260327;
        b=kqiS52J/nfMLWopaNAcPt9YFnE8lJX26X2drpfS9QLPk2HzPtra1KiVN3CP8goWfPg
         CNwQJRIlJjLfaO0+28GhnZhyFKWFx2tUavw9C6ONutPPy9NZiIBDPG6VQh7bMxfRCtnZ
         xFNX2begcMXKASGdWDt9W2yKvOfdlWXBDSFUVUMvdTQQYrJzSuv2tiLYTUTc1Y0P4XAT
         oqPIram1sBFjjQypXdQNKq22swA2Xh2QBeJAN2ACYE/lC8lHwcFIWjqnpggNmYrf6j/T
         EF1hnVEJWPNYl29/gLrt0CRTv31mgs38/GkCBcSQMmEsdxk1+WDIBhHxW5E4gTGVISTr
         p0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s+dZR8dpXP94j/qSyFaGO59voLN46gwiqCeuh+llQbw=;
        fh=UqHuQBL8RLyaHBgUNCqXqIDpRAhwDKgmt8Ulw0e3mvM=;
        b=lX97LgSDo9Zb+XODoSOYe+5aKgLX/bconooxq0PtyHuXBvUxjhZ5d7ejSzE3HubQT0
         tdl81U6Q6mf3275zYwD9iBaWUjjC2HMRzbDZZ/sbafTlmOUah0x5/9xO/kDQSF5v/YBw
         R98XCXISLlXSIz17BeYBThKnfG+mUHVL2SlkRsaHh1IifyGvJfsT9BmUOElkMZCJjQUt
         60yOZ0hm5z8HslQ1yxCsAdGWsZ285z7mmK6LCLvp12eX2KAvRiN52AgCIZyWRW8IaN6c
         6epwatQz4A8QUyurk/8KpI50I4aZ/NnxlCEhtLcK0PYikdIkxcp2+3VAKcDn1d8oOAZC
         yclA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791379502; x=1791984302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s+dZR8dpXP94j/qSyFaGO59voLN46gwiqCeuh+llQbw=;
        b=XK+mHN/m7/8PWCczVBf6jI9GNg8P5wIcvPEWJiSQ39whhXyU16GXTZxtoHP4bZILwF
         fbzHnnyusPhBuPJ9aPzAptHzCjJiIWe6m+y7N14H953mreW1xMYqR3xO/W2B+VOvIf97
         q0d9cy36G0RfmdM35f/Y7jTmLS+9/HGIb3r1n8nWrmNBa3ossJ0ioKWjk+qynEmXPxML
         5JhIvkmtbXxt2eJhBiUJT4omnSlWdkqLc8sbShJDKATk0jtb99o3Umc5A17uTfjCgjRN
         vDNhBbZe6+FH3YtQUYuhVDLis/gSgDVmOLZ6E5NlYr9OZyeL5mI1xj8GdKLCjrG5hnB3
         xhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791379502; x=1791984302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s+dZR8dpXP94j/qSyFaGO59voLN46gwiqCeuh+llQbw=;
        b=pHt2WTZC9GZrWl1AW0Z6RsOcPXjSUvPRXkbBLz1uuGveDUMtQnvcGMl7Pm8f13qDlR
         TrIpzWe8m4nqgb4NB3wafkH1j7d5c/icnHaghVU8//M9UhyGdkVk8lH99X8EUg2e6LgH
         rpZvLKpVwrQiul4HuU8BgULNssJUk4OVyMBi5WpqMYI53+A/rsguhCfjAmfwqovuYJo4
         d430dVRaZvpKmgkPHu71/sHUPOG0+AhhzfGMkFCooQuIE6bARi8w1T5ujK6VMKKyB0g+
         /k6U5acUV3ajjAlZnQO+Alj7orsZ/kBfnvRxU8oGQYkbV8ku4nf6UTSU+UVdfuZkbUy7
         FCLA==
X-Forwarded-Encrypted: i=1; AKwUvBwhBWwIBAI1q33QzdeZexsoM/mbSatBVql6P1dDfbLx0pWL9S+a4tXkpLQKsGcU/pE52MuzVXE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgt4ZLDWu9OgIBfpgLNRkIUA4fD77l2oOz5dgjBqI2HBilO0PL
	pYWO9Cpg+dCjMva7l5qIYz5xkFU+nKiak9XWaiX52tk5RCNIprnwjFJ/Ir3yB7XOcNZ4AFVa7G4
	UGm1PNq21M7juctLfBQnwS52oqT8rrjx3JdK6cNgid3C2qJjQOdSO3DS5gpo=
X-Gm-Gg: AYBFou2T9WAoQSWYTAEMuEkYmBNGGTUlyiKG/J39LNQGOUV6eWdfESGT7GBR5WKoWvF
	ES/5qR59RkwHs2KGYRzDKyN+vlcb2QGxT04H/ys/wuieS/ToSxZlAXlIgIjjbxWzhLrkOJCfoxj
	Yle2JcMh2WIu9JNn/9LBVspxu2ycrlSc6JqwsTfTQjRMEyenOK2pFC8D+Di9uy0fnED0uTPmezF
	ccLfjQhvaqlTv4fZsINLmsPDD5ijefJOLFi8GhCqoGIg496ebe/+gPD2YJ3ZcyZJ4IJpQMcfLLZ
	OuFYWgDAw01zwcWBh2DQAYuuFmpxfXvNNo7VXPNihKnlgAVFIe97CpHOMOu6ioFlU8DcBKiTvWi
	VMLZhKNdUYPL9omYeRKZtVeoBIgT5ey84NjgsmGThD3c9Mw==
X-Received: by 2002:aa7:d651:0:b0:6a7:ef64:8a12 with SMTP id
 4fb4d7f45d1cf-6afdce59686mr112735a12.10.1791379501100; Wed, 07 Oct 2026
 06:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001112948.322463-1-jiayuan.chen@linux.dev>
 <20261001112948.322463-4-jiayuan.chen@linux.dev> <20261005171227.2014f26e@kernel.org>
 <8a8241c4-0e41-4ddd-aeef-b9ecb4f55d3a@linux.dev>
In-Reply-To: <8a8241c4-0e41-4ddd-aeef-b9ecb4f55d3a@linux.dev>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 7 Oct 2026 09:24:36 -0400
X-Gm-Features: AclHuK_1-cUyFKx6jZtZU4vlXGTcJYuoZ3KG5mU-35Npv3ExhuQay5q_SWlPEsg
Message-ID: <CADVnQykSb=trXtxeC1zMDYH7naS_w0h7hkN=v2RSJqe3z0OyxQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] tcp_cubic: fix divide by zero and endless
 loop on bad module params
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 2:49=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
>
> On 10/6/26 8:12 AM, Jakub Kicinski wrote:
> > On Thu,  1 Oct 2026 19:29:43 +0800 Jiayuan Chen wrote:
> >> Subject: [PATCH net-next v2 3/3] tcp_cubic: fix divide by zero and end=
less loop on bad module params
> > if the LLM Medium severity complaint is true maybe also update
> > the subject? I thought there's an actual div by zero somewhere
> > but the commit msg seems to describe the inf loop
>
>
>
> Hi Kuba, sorry for the delay.
>
> The LLM is talking about (cwnd * beta_scale) wrapping, which needs
> cwnd >=3D 33M packets, way past the 1M limit this code documents. So
> the loop fix is fine.
>
> The div by zero is real: beta =3D=3D 1024 in "/ (BICTCP_BETA_SCALE - beta=
)"
> and bic_scale =3D=3D 0 in do_div(), both at init. The new range check in
> this patch rejects both, I just did not say "divide by zero" in the
> commit message.
>
> Want me to spell this out in the commit message? I can also add the
> READ_ONCE() Eric mentioned in the same respin.

Yes, please spell that out in the commit message, and please also add
the READ_ONCE() Eric mentioned in the same respin.

Thanks,
neal
