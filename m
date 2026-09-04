Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812F3FBEA5
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513415; cv=pass; b=f4my29+Ksl77kpSVIzcji5GogMVrkk9IbkrCJqouxadnoncbOADaR/KO8WyWRKYMAjujoRUnddMtL3tvcnFLG4U9r1XREVlx0SonHh7wM57mCLT1tNSdMG7h0nXaHWB50Z4NFFcQO6jusPKpjCvbCnTFJi5zsS3Ba6nT+mjhn70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513415; c=relaxed/simple;
	bh=U13rcRq5LNpQ6vBXGnXyY3FhirpLd2dEbsFMBIDdyT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kF2PC0SP87RYj6owG1opXqfB6fGvs2RuMV/EC4eKn5Uyydgp6hbwIxR8/0ZhoGYR/eLmP65PG82KTllsfW8DprcX6Vw8csnC/G8OsKacKDI45hE+o9KPkcWJBFAFj6UnMVeCuivZtP+Jjb4v76nCqyJaxd/RpHst4iXNvxLZnz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5aNv+MM; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5aNv+MM"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-85c9a79590aso837334b3a.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 02:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788513413; cv=none;
        d=google.com; s=arc-20260327;
        b=jhHcIvggmn9dBGxgoJMBGVRsWIYg8j1KAEe35dlF/w5LAobKx2IY3xzVMazDfKX+86
         ir55tbuEhXC3d8PdYfpx2vgPxrvbEpq6gfzTjzHPVQke/IL2LyNitIYi2wKMEiSyqBZo
         df6mg+kvK4qAOxLrhQW20X3dZh12CnhBRZoJB/51i1/YymAw0wcIHdmNPbgMZBdZx9bh
         KTrDs453yDua9D/O3reIwpgA8kjYY/7A7cqaGF8bfx4b8kMKa3YsJppUhV3tBqcIabUS
         q+BHfl91LjrxxJMMXK9wqOlwmDQYqBF5PrU3IqORGQVPdtwfn9Zfkb2fX0h6TBCp80fF
         wbPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=U13rcRq5LNpQ6vBXGnXyY3FhirpLd2dEbsFMBIDdyT0=;
        fh=AIbK4IG8GnQKEMVyk0UBGt+pbkZfwXXz2OaxELMe2JM=;
        b=mWSSVigwGlRi1H+fOCYC6xEHfXcRmEUwdOmxizU8iUQO7tTKHLFPD//9vuPknEeh7J
         z6SrSanhqDlVPGBZknnc2kiZ+P3mONwnl2fdnnC+8A+NkqsYe6sHpYxizNaoFm3kyICw
         QdLMTdCfIgq9u/flBwUkDDeUuFLDdkzsYCh9fbT1Y/1h0cPshZWA4CMTbej3/ZObXz0W
         yMxKSwpH4MZE9nMDtRkcrsU1qd/8rXbAa/kVMAgCgD2gVM+e88Jf6HtqfZInJ/AOYGw2
         s2It4ffRG5IjmKRkZZRgcOtFmuLMis/YkUMBd6P0U9cPJQEansMahBAAk2J+AsMVkirE
         PFzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788513413; x=1789118213; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U13rcRq5LNpQ6vBXGnXyY3FhirpLd2dEbsFMBIDdyT0=;
        b=d5aNv+MMj6WJx+K5xCoriHMX5Yz0Vmiwo7OOyL/GTP0Mqx+RKxBhDy/8UbqSKeZ48D
         08WfOVOqW8C9c96LpO3x2u7VUy4imfnuhzFYhUz1q/Qxk+pXY2ypkDYoVYGV5VZzCmAh
         MVAJbPrqbYWLLlrFCFUlTYX7nwC7NR6MZWqLl7L1S2PcJbr75NxECcGUlKROsosz5DQ4
         bWDYsTjSQnQoi0zN0YQ/B3invtckJL5XXge07DArMdEBRY6P91CZvrmYcPMZ/zZuMqV7
         I9vJEAJ/cIOVgX01YgVe/7AWIMsfOKVQujGVWrXMPuuoXRjSK/HQy6yG/Oc4/g7IA1pv
         XFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788513413; x=1789118213;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U13rcRq5LNpQ6vBXGnXyY3FhirpLd2dEbsFMBIDdyT0=;
        b=PxQXS/RI0rzRGuvZy0C5JcfHtkGF9QZA8Z0F21XznKIu1kGQUZMU1J/4RiRvwTjgdW
         GMlGbnR+Rb5JInGCG89eBU2/mjaVw5OhRJy8TuYRzm1Nb2Mt7LbfHxKTTkg5ArBTDU7I
         DHLiyTmJkDCCNL1j+7JN6AggWaMoDu9oEj+ZpvybRNeJkJBeeRVW51QwIpasilRLiytW
         KXavDjmBdkqLwcD4aSz0ya+W2Nf+p3CZ84UEoFdJ2B3feuSJkP2nlVRSR0F6Fevw/KL1
         AXHXtGu3bMuZCr2XvfLsArdyty6T37vVylTgwRDR2ZKOzcCXTjbi+FSOLQpe2IdpHSn3
         qm8A==
X-Forwarded-Encrypted: i=1; AKwUvBzDUhr/Tt92z2GXa6DE49SWV15XxB7b8uQzoaXaag7XfdPAcO7H6ZYK14NRSEpQvsHlV7bb0K8=@vger.kernel.org
X-Gm-Message-State: AFuF++mZ8YM+d1t/S0VVUJcMSEHuFBwN/g6W4AEnUsb5cxps+G6FBXIp
	VkFmQGuh90AsHxrSVo4OTupBXgNGa0TeX1acy9GtAAqoNSjgAHcSBd8UMwce6sV28mloBZbI/zd
	PILPFMhlzk/qJhxQyHfmz27SDsLG85ns=
X-Gm-Gg: AYBFou0PEP62FMT/c2EC3+abmSJuCP8IZ7Ol7a1hAyYtTkXisFlmkvZ3wWHMtGlE6U2
	3ThKu8b3HAgmjrRMLTyvHSM+mGHLdbH0LbLQo54HsG83KKszFf0sgn7+UrqjaCQ4YffS+wPc2/S
	FjEPLaFeDsl5L+3BWMuOZ9ukkZCeciyOmHWyVpWsYX1vipVdY0FfnqYMZd1xnVpSdqwe8MCPRCg
	lO2LdqiC160cWnLZVRS1zG06zsGbNcWtqceBSFv7Jn9aYf1lwLZf7BlhIe8VlMD+Z2itA94NgQR
	Brm1JunIZI9qrUCAPxFkOKlbX7S5w6USTF1l/15uFatXkgV7BBGIXIOUmnTehsR9510P97EDTZI
	RBZB3sCYg08Fm+g1HKaAGkSi/Sj1U12KmTtwX7y4o7ET97xaO6IMRpK2H
X-Received: by 2002:a05:6a00:1910:b0:853:5152:a3e9 with SMTP id
 d2e1a72fcca58-861692844b3mr6680817b3a.11.1788513413233; Fri, 04 Sep 2026
 02:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903092430.354186-1-phucduc.bui@gmail.com>
 <GV2PR04MB117394049F412AAAC59FE93FE88B62@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <CAABR9nFD1+GJiWdyxiuGVRzKjpCUfu3TQHYOLnOym3hHzOM2tg@mail.gmail.com>
 <GV2PR04MB1173931CA07AEAB48339FF71588B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <CAABR9nFi06-7=uHmOBFGZv1eUYCskv8WspOdUxbDuQ6vMk68Dg@mail.gmail.com> <GV2PR04MB117399ABD55B1D65AAB8EA42E88B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
In-Reply-To: <GV2PR04MB117399ABD55B1D65AAB8EA42E88B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 4 Sep 2026 16:16:41 +0700
X-Gm-Features: AcwNN1UyZz0SrSd2LGz8BgfAH26qtAAWc51dgQLrq8UzEPhnn0559XUUTa1qyZ0
Message-ID: <CAABR9nGSi5mty-4AQv_vYz0yqCKE5ALh8ZC7bcFnY99VBfq_CA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: fec: Propagate PTP initialization errors
To: Wei Fang <wei.fang@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Anson Huang <Anson.Huang@nxp.com>, 
	Stephen Boyd <swboyd@chromium.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Wei,

Thanks for the clarification.

>
> It is a potential issue, so the target tree should be net.
>

I will retarget the patch to the net tree and resend it.

Best regards,
Phuc
