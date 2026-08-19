Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB5E3D6CB7
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125487; cv=pass; b=VNbHOhTIp3R6ZWhw8sIn6rH0J3BX/KAO/pgobIw9LjUPmXR60dGQ4iJXq/p7dw5ZVRFH3bFc3QZlNKRDF/7Mpy13Mf7BR5sfTX87jf9CQs7XlGQnVaHfbYDeb6/xgoru2s0j7AipsNlzQeM5FFKronbWgGTLaLxYFPKCfKPSlaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125487; c=relaxed/simple;
	bh=EFj4ywjnNoABg9PpmlJJuRPjzwJmad/AZLU+WLs1ZWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIAdygoN7eUoOY6LSGjDDT+uGGVBfdvlbtbhmetmRHUSWyHVHZ8zPXJUu2INdSg/HwlwLayX7pKBPWsKaD3znQyEKT3s6uf/XrzHeqltTnCVxD/s1elHcceVMhdFFYJTE5o7E+XJXDuuVXD/F+HeEbJ5/kzmcabWg0wxSY8Cj/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AU4YaZuU; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU4YaZuU"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso1158626a12.0
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 00:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787125482; cv=none;
        d=google.com; s=arc-20260327;
        b=IK082gzkkPheqbhewYW8B10zPJpM12VtGt/2ZOrPPlGHiipS2REC2ltGbb++oij20T
         CHr5RKtsa+vwyNe9m20M6MXhnTXlgdny0AWmPBVE5gZFSGSboWeIo2U17u6DXYNEQNm9
         FP8G1gN8ri7GRKtyaclA2ae2iPRACA7+7sFgv6YaHqyYYJYUSC+g+v166LjAixkoGQr9
         VRIRlV2aOEzyf9I529xLzxKnCo3bazqXeDD6YdgCBb6IZSV2eGjOJWVylgU6VZ1b8ZKn
         fTUwu0uYe434c5Q3ukGP2d7QD7+G2RqdQl9/P1EGex8GNfBLiBI9BbV4Z2vRYBFDUV+d
         3D7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EFj4ywjnNoABg9PpmlJJuRPjzwJmad/AZLU+WLs1ZWA=;
        fh=8xT0gbG59wYhfb2jsqKq6AAuuQN6w398YdKg9lhcGHk=;
        b=DO+cNj6ADdyIJqSPMY0Q5MXdBj3uSujLaB/sNeRsWRcOq5enHUn2kqEv58vghidL0C
         3yUGbY9vXhB5vPtPfQS8uobR51muavO8K7SbAVoT985jFyeNreTdysnhK2TPDuLk92gz
         v3LGodgBZPGZHIdPe8SkRGtai4mhrcBWhH7b+Kd67//xArQ97H3jnnmADTsMZGNnrK1Q
         Lem3gJreLcujDz1lz1jmRHYOxTUROi21jyF5xMZj2pOi/EgrJyLtHHeRnaTMZ/7jjE8a
         qbn0MoCRVac0ddVaqNpz8eTUmCuCatcSpMthP9oaK/wzD7E9Rnf5ED3XBT0eVyeqkdJZ
         sI+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787125482; x=1787730282; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EFj4ywjnNoABg9PpmlJJuRPjzwJmad/AZLU+WLs1ZWA=;
        b=AU4YaZuU+zfNYz5b4IMZWAJvG9hQZPPIQj+5edlYj9i6g+ATx6t2uTIpLc5U0+BNGY
         PLiAOsvMm3dXTACE6a77X0ExkSYDYrmy/zW4GAzL+ToFnByeJfuFSl6xP7FvUOzYBC47
         DXOFJhU9doLhZHm+uPoionwrI3az9zdCrR9EDUu8jClb2KK/Rm4N0P8ED9R0jKXMUOxu
         +9v/EZd9y1m/aNEjbL6fAYU51Mf8F2Z7rUAhiHYnnwhJiZROfYw7I8e/FuzeQPCUw14+
         ArDdkIsOlwFKIhzwfGL83hFe0AgBtpr4tr2aOM7r8fVZAuBSgdiCkS/8ioH1ujBdyt0L
         6yTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787125482; x=1787730282;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EFj4ywjnNoABg9PpmlJJuRPjzwJmad/AZLU+WLs1ZWA=;
        b=OWXIZsnGXZfu00DQEpkclUnJrp+L40ANkzHyu97OvZoKzXTZqsiw+N7xwopYMXHcEf
         wyDjF9wlOmEfhpCbHBPsVVI5N/UdNa0Ka/72eTE8H0eY4pK7hRlH2a522o79XrsHcoCF
         crJYLKlj8wbr4fidh6g+Vcjo8tROyqQXPfM+bf2k0gSlSIfGtCb+En3ya+ha7sikPR7V
         jLEpXrA1WQRzO3XF8FhH1RXqvn1QA1Ny8orRnDyVKMLEdBSBWx6FcAFJHZBSHBkd9QVX
         +QJ9ITDOEyxDHNSJYe69n4+Y//0wVpy4IvKsy+GmhTp9S4xHiOJDB7RWDtmbMckfCceT
         dFog==
X-Forwarded-Encrypted: i=1; AHgh+Rpl/sFHT15ab9xd8h++eKQsqAyCWEKVxrk5RiUs5SK89qcAws17G5LwJO7OoNCvt2FKOBIu/fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4N3JCgvJaDbQ0+VltSioMBBXTLOseasD+aD77x4AiqvlmELk
	3eRTEYApcLdlm9VVKVnfoGTEoYXPpG69BR29BCLTj0dDyzXblS2On8ivsTux7HOI/c0c6KqDdZL
	aUbFXkPN1mjBnga1WpeTgmwVnDfJiFjc=
X-Gm-Gg: AR+sD11pcldTLam6CE6BvPIdtOZcA9C8RVwgRTrzi+aptBSNjwC2FwKTtQS35ZiDF+P
	NZDI558LSTRUf8liV1RXB/nNofLc//6mPBlT6ghiIzc5x38eW9QfYprHpzoPFWIjMtIKKJPi6UX
	4oTiWSeAvyLjj+gH1ewwHjB28RtxjfY5HzSfQe3XeEOOvBw8c/j/3zndm7IxrNLrTsXRdMeZM+3
	3ZoxEwwolVIzGvKCaODX2VQudB+NxyePocJvbLNYP2jiFwoUkxBpfmM2Abb8rsF5/eYdQy3G9Sg
	a9yK9NXB3rmg6BRZ2dgoIA3luhFtWWkoF70JK0hB36aUxQ==
X-Received: by 2002:a05:6402:e9b:b0:69f:b347:a681 with SMTP id
 4fb4d7f45d1cf-6a4032986a5mr1376623a12.4.1787125482415; Wed, 19 Aug 2026
 00:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819040913.109367-1-running910@gmail.com> <e84bc7b95374bbe76234bd56e819ba5b@tipi-net.de>
In-Reply-To: <e84bc7b95374bbe76234bd56e819ba5b@tipi-net.de>
From: Zhixing Chen <running910@gmail.com>
Date: Wed, 19 Aug 2026 15:44:28 +0800
X-Gm-Features: AcwNN1UrllQ-Fqsfe2ItKeUjyVLzHK2CuQQo-pSd2obG2-3qXBfSB83QJldjOgs
Message-ID: <CAMyuFdX_qGq5E8TfuAuXtgy9AwLTwegmvMNXYSmjLXgOd5rhRg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: macb: fix CONFIG_OF=n build
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hi Zhixing
>
> On 19.8.2026 06:09, Zhixing Chen wrote:
> > macb_alloc_tieoff() and macb_free_tieoff() are called from macb_probe()

>
> Nathan sent the same patch a few hours earlier [1]. I will follow up
> there.
>
> > [...]
>
> [1]
> https://lore.kernel.org/netdev/20260818-macb-fix-no-of-build-v1-1-f2a009616384@kernel.org/
>
> Thanks,
> Nicolai

Hi Nicolai,

Thanks for the pointer.

I missed Nathan's earlier patch before sending mine. Please disregard my
patch.

Thanks,
Zhixing
