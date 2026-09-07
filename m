Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE63C2796
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775531; cv=none; b=hSHUEaxzcOi8EPjqa/dCeapwoFuoanR2tWUnohM9m0oVDwkqLv7TYj4DVkEG0kbLxRj4JpubwnljQ2PNNgKYuajokf3K7G/BTIFOX0ixp0ssvky+0PodunFJ2y5w2GxrVZlFNs/WPzkJieM3xOg48wKq5MPI6fknU5GR759fhrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775531; c=relaxed/simple;
	bh=8fL1/TuwSuiKgrq+V+wAxzOHTf/B1zVZLTDTjrFfMNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5VlVcr5XZwPUuriwjw+uXu5k0P3LlZIEajceLG4Y18jUlUa4BOwK3KtnI2HPKQZw9ASgqaweWWtnuyB5z+eBkPH+++bHmD1aBK5dDyFLzLAC/m7P/xSp7rkzZGSwnRv+2hz3YOGtdzp2/ZSWctn0VpCfbkGJ5MEZwWF+B0BdkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=T1f86OC4; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="T1f86OC4"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843703c170so206143f8f.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 03:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1788775528; x=1789380328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wbcjeKhq7aPSDXOzQm9/s7rXNeLZx1wkXYSSHBPi94M=;
        b=T1f86OC4O44xYdpMV8caAopS4ajUuqFsp2dC0+/uhS8zgZmhu6A2e5UNYcgH5g1jq2
         Rq0+Kx57AkyGfeItHHr/mLBMsEUnlChdnF9x+PslA5l5mffINayg2ZwURxVqYwOy3lzo
         88xsRXcLx548Q7ZhjpRoh8bpfNxKVXjwIVdMw/DXDdOdDNRVDeujdJWOjlN4ZfHIjQQZ
         UPQ4wKJuZeQpOK3K3Ox1uhoQUJh3U0XJJQKwFT6DJ68KsrCRyV6ruh8Ipjnrhpg3y5T3
         RSpEP/0xHMgXN82djVBAdksk7803MO4lAJ3NHtsDRNdFxRX32bHNp598Gi/FYXuxLNF5
         LOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788775528; x=1789380328;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wbcjeKhq7aPSDXOzQm9/s7rXNeLZx1wkXYSSHBPi94M=;
        b=n8wiTAEsiIb0o9Eu8unSEnvYacGhVj05aUrihoa7kFUgcqhZfo3zLLnyiJDtbn19EH
         VLIGyIKc5jCedO0QkkBxLmuyTzr7C1lHDJ4hw5A5er1XN7UYI96BMbs83uQ048EM5fGG
         /LYGFQaexwWCagJ0OwlS7W0haIEn6E45phm57fsbb/rrNHcf9i/ZUon1TQDycqxjE1+Q
         XZF6YbJsd/17kMBYY4PocOq7Z7yRqvjq8klJNmcKitC7UiJBzvh1WNcH6OgJiQzchW72
         cKxIpVrzno2Aeu/HlKOWTOngt7CnIUhrYJ4RsFlnjCJzjEzgutRZLgcWMvMKNihZ6UAB
         oSMw==
X-Gm-Message-State: AFuF++lDmcFuHZxlhkgLS6TZWrcBXrVq8y3BAyu9NN6b8afHDuDhbgmz
	LhK43hwarxWDiL4feFlhCUvBavfTpQNgCogZ4wnQRfrOEmHvMGL8IcLe1AamK6/WfG4=
X-Gm-Gg: AYBFou0QaYEKQX4LlqEXQo8X5GoBRC4ETFQdTmFF0qrPfePUBZw0pN+TUDjBZHlqMAr
	jh+n+WZhMqrHht4CDx9hB1CxoM5edvO+9p50HxN5dEkluepTq7sj25F84lC/H+Scv5BLgJuuYVc
	45GkwyCDhlQ0Fm/FAq/EFOtrTEmVy2JXXSHDo0Bmu0OJO96Ml6w8D3uCGyAbS3c6dC+cA4PDGuX
	91gQXV93nVoLbnI9J6zm72OCwvdT5ozqhzAtUqoAbwsRb7R3CWbQSVE+x2ipE0wxvtni47e2PSv
	AZbETv0is5zRb6v2ghdTDWRmtr1a7h5IGzYk17IMZZvxf0hNHdvXkW1hlQXb0REes4ExVH0G36w
	8r6UuEfGPKHDG+KrI5DsSzhv97Yn9EuvSbuLEvy/mRVCcO/vPycFzS55NqFzvcglwmEw6RjtLDI
	HpxxAy6ojg2mXqdQNBX/hqIMxwbUowYctCALUnkqqeCgYKF+JU7olTbb7oCxYhGj9zUVlPxlka5
	aDZyz5RqSOUHyHAXcers5FwiouQDOKs8mK9iz9j8g==
X-Received: by 2002:a05:600c:530d:b0:49c:e363:c66e with SMTP id 5b1f17b1804b1-49d01dce86fmr120239785e9.1.1788775527873;
        Mon, 07 Sep 2026 03:05:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6158e9sm382778955e9.12.2026.09.07.03.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 03:05:27 -0700 (PDT)
Message-ID: <3d441c88-65d2-4ce1-9b30-a829f84b0d16@6wind.com>
Date: Mon, 7 Sep 2026 12:05:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 3/3] netlink: specs: fou: link the type attribute
 to the encap-type enum
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 kuniyu@google.com
References: <20260904191412.3872344-1-kuba@kernel.org>
 <20260904191412.3872344-4-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260904191412.3872344-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/09/2026 à 21:14, Jakub Kicinski a écrit :
> The spec defines encap-type (unspec / direct / gue), but no attribute
> references it, so the definition exists only to emit FOU_ENCAP_* into
> the uAPI header - while FOU_ATTR_TYPE is exactly that value space:
> fou_create() switches on FOU_ENCAP_DIRECT / FOU_ENCAP_GUE and returns
> -EINVAL for anything else. Python YNL could not accept or display the
> names and the generated C exposed a raw __u8 setter.
> 
> The global policy entry becomes NLA_POLICY_MAX(NLA_U8, 2). For add
> that only moves the existing fou_create() rejection earlier; del and
> get ignore FOU_ATTR_TYPE altogether, so a bogus type there now fails
> validation instead of being dropped on the floor.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Side note: the field 'type' in 'struct fou_cfg' and 'struct fou' is a u16.
Having an u8 would be more consistent (:
