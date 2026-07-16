Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C48C326942
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784189742; cv=none; b=Ndm2CGUNdNtAV2gLeXponeh9NvmCN+5XkDbscBn0Q1qjj9mA0B6FJIvd6TtsvL+TKh3ACKuiLQ0EqaNgJcARuqFSE/cj2gFkd9EHfoglnc+wjdItq+0xH/abknctTfw2us7VcwVx2yhF/pOhmunTMAZ7aNTeu73Qz8e27i92FsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784189742; c=relaxed/simple;
	bh=0tgd4pGkh+b4WcULIJcDcxAmOTx3fcVp4oGsXrQcs8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtJEeUFCOEOjiXPSon7LfUmNN1qYDgUKrO7eXdLXJpPPY2YByWQxZ/o82lBrL8BlUcY4wwOEqyeHGrXtoeQ3J3G4OrSa7wRbp3WHInLrK2eAVAg5/4fG71/8bSEsI5Up1kRgE7XcmoHRSKlaAMwdBHjay/Ydb+YZF07/muyAVvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L885Lpws; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sKuk6/X/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L885Lpws";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sKuk6/X/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784189739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0tgd4pGkh+b4WcULIJcDcxAmOTx3fcVp4oGsXrQcs8k=;
	b=L885Lpws75RBNbIlVLgWkQpMwQ/XAxgRlCCNEodvPq+Ew35XLCVomH3B93PCWbguLhS6/m
	kmfj5PCOcGEiphiwXxxF+u3lmdFg3iafVBiG5WyR/uILZJt9RFa95xN2AGbV8uY+ZT5EGQ
	YpTscqq4mmE1i13BgEtITEwhUv8uYbs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-gIYzPd__M2egem4fmp2IBQ-1; Thu, 16 Jul 2026 04:15:35 -0400
X-MC-Unique: gIYzPd__M2egem4fmp2IBQ-1
X-Mimecast-MFC-AGG-ID: gIYzPd__M2egem4fmp2IBQ_1784189734
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-69afb1d30f5so28929a12.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 01:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784189734; x=1784794534; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0tgd4pGkh+b4WcULIJcDcxAmOTx3fcVp4oGsXrQcs8k=;
        b=sKuk6/X/DpH3MkR5DsVjT0kglp/AvApMJ+mcB+96yjxXm9LggzCPGNBmm8jwYqiigi
         kZ2h52bn7W0YCHJYWEv0rhIeXAxnDwJrsyo1wNbDEobphwDYUudDsFq3YfukH3SK7lph
         uOfjnp4eq0VpQPcACaPWapMg6DF6+E71VwFR8WAQmjvRP5CWQElw7jABCl4yKB8ajupr
         Yo8FdYxq91G/o98q5NNuddmrvbTunVez+UpHGIWsMZET8ZrfjZ+NCvniFA4Dn2YX+N0V
         4Q+IT3VilBiOP0ksIStZEnW+vtBoYVS0zZ2nJJXNbRjRLZsiZNoltYNDuyDjKziOhje3
         Gyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784189734; x=1784794534;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0tgd4pGkh+b4WcULIJcDcxAmOTx3fcVp4oGsXrQcs8k=;
        b=mfsZRY0v0FJhEYruDn1YVR6LY9VEfY/uKXkNOK1FQDmEwqlQialwn2i/O8ZFeE0/0F
         xPcTqltys77hEJu4U/LtvduUcbsxAwANWodWEKFmXJxlnyh6pUrz/2IVb+f3fgyJ6r6d
         XQ0GY7CqrQg8wOkUw62Xwm1JU0CtnDrFKODpgMOgj8DemSpCEbDzDutclv3CPhjHMNl0
         lZ71f1bGtruhGDTZSOlmY4k+KDl0Aaxo8P1BF/B17vt8/6Lvu2n+OZeXjzYPM1tdjaVe
         E3Bvvv8U4NvyzS1xZK8xj2CodIYIUcqLXP97fsilrcJGYRsa4Mwpk1e8NG0YCbvRaTDA
         T6kw==
X-Forwarded-Encrypted: i=1; AHgh+RpTMg3lZv9l5Qbl8ROqf7OdO0kITjd8IcNXYJwUAxY+FgU7uHT+ds7+9N1kMetC8MvT2dzh2r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTH61NbRo7Hv9SyS0IpCJuSE3rKHRoXfxcNkpwdqcQ9yeS2r3F
	uOMt5yKRhFHmsVe4rs1pOkTVWmhnqoCNCw85kz5qabkrPIrqXetV8AoA9YZB3E1Ly4HcwJ4SgZd
	YRju4CoN896KNZl+O4BxB8kbErpQyufV7ki+fyFwKQA3DmrIEcyF2jhEPoA==
X-Gm-Gg: AfdE7cnFXiigLp1J9n3hd4739WqYKX/ZbGxaGXDCsZYnf/Ffi3NlHEet1i7l7ZZU/DS
	EAaLUBBfNYDWHB56wIZYQ0NWnAM+317+oZa951XZatAQ+eGQEIUoSyrx+up8EUX8HQ4a68aPXUK
	F5vnqktXHNCv8l4EEXtXynG4T6GwFNr3H095BOtkE2j2YWIGe6PaF7/Js2MkSYmgYcrmC9LGXG5
	7jBPgqf2uTQJKXBLxITIDwPF4u2e8jWioqBRy16zLuShjm6ZcqzCRc8kF14rq4coBoQCcuvDIrt
	JpoHuAO1580sJk7aAHu3S89jdEuSfB2p+GjMeq1E4Mt1VgO1OYVdmSYUcacCoJ7RXurJoRfSyv6
	sCYnS1tL6u0H7MG0IbEtXZ8MNni+jylk5qbjwRj69bxLO0Iwu
X-Received: by 2002:a17:907:25c8:b0:c12:91a7:9cc3 with SMTP id a640c23a62f3a-c1692114fe5mr73195166b.13.1784189734024;
        Thu, 16 Jul 2026 01:15:34 -0700 (PDT)
X-Received: by 2002:a17:907:25c8:b0:c12:91a7:9cc3 with SMTP id a640c23a62f3a-c1692114fe5mr73194166b.13.1784189733558;
        Thu, 16 Jul 2026 01:15:33 -0700 (PDT)
Received: from [10.44.34.17] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2878eaesm4243784a12.2.2026.07.16.01.15.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jul 2026 01:15:33 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 dev@openvswitch.org
Subject: Re: [PATCH net 2/7] selftests: openvswitch: add config file
Date: Thu, 16 Jul 2026 10:15:30 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <454FC9EC-8F3C-4999-BE7B-91EADC392EF7@redhat.com>
In-Reply-To: <20260710-net-sft-fix-containers-v1-2-a2915c294ef5@kernel.org>
References: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
 <20260710-net-sft-fix-containers-v1-2-a2915c294ef5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 10 Jul 2026, at 20:04, Matthieu Baerts (NGI0) wrote:

> The kselftests doc mentions that a config file should be present "if a
> test needs specific kernel config options enabled". This selftest
> requires some kernel config, but no config file was provided.
>
> We could say that a sub-target could use the parent's config file, but
> the kselftests doc doesn't mention anything about that. Plus the
> net/openvswitch target is the only net target without a config file.
>
> Here is a new config file, which is a trimmed version of the net one,
> with hopefully the minimal required kconfig on top of 'make defconfig'.
>
> The Fixes tag points to the introduction of the net/openvswitch target,
> just to help validating this target on stable kernels.
>
> Fixes: 25f16c873fb1 ("selftests: add openvswitch selftest suite")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thanks for adding this Matthieu.

The changes look good to me, and I've tested the configuration and
it works fine. Note that the config cannot be used for the OVS
make-kernel test as it's missing some modules. But that's fine for
the purpose of this kselftest suite.

Do note that when adding new tests to the openvswitch kselftest
suite, they should be validated against this config, as the upstream
CI uses the net config, which has more modules enabled.

Reviewed-by: Eelco Chaudron <echaudro@redhat.com>

