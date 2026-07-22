Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6DC368D4D
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719232; cv=none; b=Rh7L3mv6/5+ye5g9HuIZ2WiO4TD2J42tFVi4Qfssw042TEOWtHvORJ3zpqctUi38xpGeREkMVDt5gpugdNQhusv0P5zBbCzCfQG+chWDygDJn2MvmdzU984gtfoNS47MDLWBcmAqCjMyrb6bajNAOkIo7KKOr7FEG/0kaRFDtT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719232; c=relaxed/simple;
	bh=W2TdeQNeq7i+/uyTAxS+2kWrb/b6vdQWxchYtKqEbLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1pXxkf11lVxuQPkXvmv1QCzZ8Jvx0Dqzv7Gz5Wzd6ImCaF1R8jN8TDMhYIH7ME0kiXACEUJdyLZ0rSBw6chg7CymyfaSd5XO3esI/eB0ZQpwicU1cPWAgxgmu3qmvdX7cQtZYIXQIoQ+E3zAVRiODq6TcGYgzoTb9mDxLydtJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdPr9QcI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JC+I6ipV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdPr9QcI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JC+I6ipV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784719230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZyQNVRyVBho1vLKLkGI/Hhy5gfGBh50MnFg8zsHdAYU=;
	b=FdPr9QcI6/k4kYIK42R5YY73+5MsAGzsaK1eG+lgNL76HXCeb1Pl/grPO0D+Fk5q3sqzfp
	MrLj64LJ/Fm4hn1u6/uzCerA7FJvEkB90Av7O6tQf4H6nkJDPmDTW4NXWhyz1jEvZYzDK/
	Msqyw3LAn0PKtQx/nSxXLxEOidUMdZA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-sjaEOIY8OWmd81n75EvLvQ-1; Wed, 22 Jul 2026 07:20:28 -0400
X-MC-Unique: sjaEOIY8OWmd81n75EvLvQ-1
X-Mimecast-MFC-AGG-ID: sjaEOIY8OWmd81n75EvLvQ_1784719227
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4955843c6cdso39723655e9.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 04:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784719227; x=1785324027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZyQNVRyVBho1vLKLkGI/Hhy5gfGBh50MnFg8zsHdAYU=;
        b=JC+I6ipVjDXt1qKuSiJXu1KwvDsMC79waBsNND5CUtY3RREsl5DlFEZrYqC6oE2Uq8
         PQNP48QOLXSLUIn+syyEObjLqZ4sBme3dh/XSsjVFb/1rU08ZCFZH18tzLRM1FwiHCAW
         d04N0dH76V1RaVw8m7AIst6FHktLtjvXO/0dvej0ls9tWx7abQaqt2EIuaDgbdH/VHft
         5DtR//fdS57mvA7usOz/K6paeo0lYVmiZobdn8Rq3a01oQ5lf6jXTndqHPil2Wb66q39
         as8wF+DcgOHA7D9Z6g/17S76b7szkQZSzhSviTJVQfmze9qg+AEb8RHkwzRunrZ3QxmL
         hStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784719227; x=1785324027;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZyQNVRyVBho1vLKLkGI/Hhy5gfGBh50MnFg8zsHdAYU=;
        b=RWyprcw3gWERdcTw4BAJ0UsLUvVs8VUC88gYhhXkxlgIQ6GO10AJWJnpeEdGqX5kRz
         Ofg0b7IXRLbJd+XTw2bd4h/zO4yGw6agYjyXWXNDzqgFvAQ/RZGiCOxIYH9xI642zdUT
         OPnBsq8fC4+XUeGsyeK3yEqSm0neG3iNIZNIzPsnbZTN/JaiZy3BQXlrB0RmJctMh6D7
         RoYQXlJmQxNBkwTM9KsIu637KOlhhSo67BolCJnpf6TYmk+i2ReWS9BZ0RVe6txiJvYC
         BJ470hRHVTu5RLbGaqTvmXmlAD3/ZOOe2jONEnQ+39yal1ZYtmOKj5MnqaWSXFIdLBnr
         beRw==
X-Forwarded-Encrypted: i=1; AHgh+RrMEywzSIzRVS+eaJ/FYAI2vFm+OqEUtt1Yr4L7p7Cbp4ySLAAEM6urm2H5lDFpCc00mY6twRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI69kVuxJ7blonVA5tTU7kru8Rwk0nHxvNfeCY0cyg3TfeI3Tq
	b41kd897ieqwQbMuFdB1HVgtaBgqG3Hca7aV+dftlN/4aZwCVlZBiGXdtSOZwV12kedVP/fzZF7
	mfQ0bw5Dgv3z1fANWTZtV+z+06IFmNqH+7LUlDfRExT3OavBnE+GCvEoxtw==
X-Gm-Gg: AR+sD11dXXoVqSY2DKSww5slJnwM+4Z8XQBXqBlXT3lqwP5NsefyUeslcpg9vwRFxPb
	6h9q2e6/3hTusThgZy9wFNCAcQymzS52I64kGq2nlH77vTKBOW8Jv/io0YFtTbnJMK42jQmE8JE
	RipL2juUAbSoKajuq4wP7vu2PlVxCIpLsQ7hfLfb8Z1Fgaz396rlJEBHI5/Nrmhoz0zi0oIKZHi
	uBjUwk980gXP7B8v6lnIEmKGHgY7M8B5rQrH9ySipSN2HaTzCHmR7wGao55jyCylfVQRgU1z/80
	1a82ryBC0IL60Z3J85hVqLQYAGc7uETuHdBI4oWJYPqRJXtwEtKBjIojDAgkxuORO0bYFgg//gV
	zluGvwMTuypnP8o5VupVtne84F9Sq64uFHjRH1gE8mzeSSxZyOBRlf1wJfZ+YR/6cAigjPi6SkA
	LfsQ==
X-Received: by 2002:a05:600c:4685:b0:495:4a77:1327 with SMTP id 5b1f17b1804b1-4954a771521mr268353905e9.33.1784719227335;
        Wed, 22 Jul 2026 04:20:27 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:495:4a77:1327 with SMTP id 5b1f17b1804b1-4954a771521mr268353355e9.33.1784719226924;
        Wed, 22 Jul 2026 04:20:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5a2sm5592723f8f.7.2026.07.22.04.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 04:20:26 -0700 (PDT)
Message-ID: <d66c1cb5-6201-4390-a7e7-0a8461bc069b@redhat.com>
Date: Wed, 22 Jul 2026 13:20:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 9/9] selftests: net: Add a test for BIG TCP in
 UDP tunnels
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 Alice Mikityanska <alice@isovalent.com>
References: <20260710134242.216538-1-alice.kernel@fastmail.im>
 <20260710134242.216538-10-alice.kernel@fastmail.im>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260710134242.216538-10-alice.kernel@fastmail.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 3:42 PM, Alice Mikityanska wrote:
> +WORKDIR=$(mktemp -d)
> +trap cleanup EXIT
> +setup
> +for tunnel in vxlan geneve; do
> +	for tun_family in 4 6; do
> +		for traffic_family in 4 6; do
> +			for csum_offload in on off; do
> +				setup_tunnel "$tunnel" "$tun_family" "$csum_offload" || exit "$?"
> +				do_test "$tun_family" "$traffic_family" "$csum_offload" || exit "$?"
> +				cleanup_tunnel
> +			done
> +		done
> +	done
> +done

Not a blocker, but a possible follow-up: in the past a few GRO/GSO bugs
were detected only when performing GSO, GRO and again segmentation on
the same data before actual reception, see the "GSO after GRO" test-case
in udpgro_fwd.sh.

/P

