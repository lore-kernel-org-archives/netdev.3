Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A6399CE9
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166036; cv=none; b=h0ANfaDk0y7swUwpAGA68mi3r0/qhSpmeGkwawDb4XWyQ46HCOsS614oIGSnk4+oMVqBByYfNtFatSdDdTNJ/JLy+33vJywljVWSP24MiFPMZYxy6Oty8ROyWfKJtOxtQbcgYI85YWjmZ4pa/gjPyAdZdXoUPZPVCIbO5z8i72k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166036; c=relaxed/simple;
	bh=1XeOmQjiCmitTcAp2U7m3O2xukG+U0k4mys23LN33m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+eqg5qLql96FV7nVI8jRL/VUk+ZjZlRC97Oc96x6vI3DJ7kjBXa7tkMiUBxo+AKSc5gaihQcnYXGtZHUgnA1Ois1ZtPFbWqF7NoJiZi89569zpK77b3mX3vq+k7gZ1NlXo4zEUp4NJkyQn8gRbm4I4EiPy5KWMbI3QpVWkdlfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDdCgNVt; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDdCgNVt"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c9fe62e0da3so949744a12.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785166034; x=1785770834; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PA2a81BeXH83G/BeP/kggUZUVWwJJJOgGGWCxqitXXc=;
        b=XDdCgNVtCzEAe4yqWh+ezwqETD7BGhvrYizMdhpblNwmZRah5lPcDCT4JAmYrLyDJS
         gi+ESZzsTA13ceDM+gHnIaUNPlQuyZhSUZx8DMJEV0hCtsWtdLSxCGI2CTf4kGBHWumQ
         mbjp4BbzDqNWx8wY+s5pW8UvEXIlAY9C1Bbhxdo71h6kBDOhVEbqUJqOlsAVLxGSB+X1
         zO/VJ6Sf3+LpM3IggwbKekKkhAqgsmc9zif2NT4+Ds/2C7t4OVUG8BVuAooF8UhVL9oO
         eueQO7QcvPz2qaG4aYDdC/aV1W3W0JV6Nrldt55gj+iGNa0KNWSKkYQE7xm4ucKowKJm
         DA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166034; x=1785770834;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PA2a81BeXH83G/BeP/kggUZUVWwJJJOgGGWCxqitXXc=;
        b=EEBrglE2Hh3sGvgu/H5gcYwLQRM7x4fXCOe7pk9mh4dS7iowFM7fAIR3Dw8nvDv5x4
         TKGVwds6/4Hqy42rHlYyJktV/8VluT49OMfPKmR/iGAvvGcntWH8znhIlT5WeZWQIzPF
         NjGcrp6rVRkjFH+BJGD24arg0lbfcKPpvSZOrTxVW6JJgpbbT2/2uFLXugKC9hDHNOx7
         Apy6NGSkc+Zcf1mvStzBCzn1QwNqTGIwwGyWUpIbNgzN6XfTz6ewjJlGHmODnDP9J7b0
         P9KPUju42JpOtaejB9ins0YZCb236tk5QJTkp4FJnVr+FSRPM+GLN2edQzJQHVyvfN3w
         U+pQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqzn5ywYbXQDw1S8nkYAFcHMwwLyFsUJuV3hfK4+gH7AaIwH/JTAi7OvXRrK3mM+LZgSOhUJuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa4InWwdidOHqBgOnX7Bupq8ax7wTVW09nxzQgf7QjTD1U7g69
	Bnlq1mhthvPrycBHqEMwFLt2HfcmG6GDtfJpUIQ0nvh3aGmwgxc+ogTA
X-Gm-Gg: AR+sD13rC/JKV5/1CxYhhKyFJAXYZbUYTyzKGRjhxzNr6mXF2KdpPYy8nMToZq1QROU
	Ls6ouGYTxSU89B4MlqvUWlcGJrtn1A0S9SwyDQ6g9hTlmKwsK+if7qgt9aooQk5arJmMJpUH6YY
	umB1Hoqr1KHiG3wUWR/u+V3d3c2dx+PWHu818mKtpBKionKGFjOVFTqLdQyzT6j2VAuxdOxrQxv
	MyRnCleE12f8fdSyu1NVL5oU6ik95OWJ3/B6gGqGSX4vbb0fzBo4qW9bNwZUNMzGdP1bW1k+xw/
	gKTVxX5xRERwjOJ8KoI68c5mwH69zSQHG+fIGxzAJijWMcQFdbiNaCOW7FiIhhaUZ8pzCpKCON7
	qe511q77z6xU/KAxMePtTRAHEzrEm7nEKwalc2a/YRPF6evAyW2Y4f9S6GXTGwfVSelYsRb8=
X-Received: by 2002:a05:6a00:8018:b0:848:41e1:473c with SMTP id d2e1a72fcca58-84e595d13afmr7024673b3a.72.1785166033675;
        Mon, 27 Jul 2026 08:27:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66b2cc2sm3364331a12.17.2026.07.27.08.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:27:13 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:26:16 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi.denis-courmont@nokia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com, =?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>, 
	Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v3 7/7] selftests: net: getsockopt_iter: cover
 rawv6, ieee802154, phonet and tls
Message-ID: <amd4ka3u1X80rQsZ@devvm7509.cco0.facebook.com>
References: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
 <20260727-getsockopt_phase4-v3-7-e89627544639@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727-getsockopt_phase4-v3-7-e89627544639@debian.org>

On 07/27, Breno Leitao wrote:
> Add fixtures for the newly converted getsockopt leaves:
> 
>   - rawv6:      IPV6_HDRINCL / IPV6_CHECKSUM int paths + a SOL_RAW
>                 unknown-optname case that reaches do_rawv6_getsockopt().
>   - ieee802154: WPAN_WANTACK dgram int path + non-SOL_IEEE802154 level
>                 rejection.
>   - phonet:     PNPIPE_ENCAP pep int path + non-SOL_PNPIPE level
>                 rejection.
>   - tls:        TLS_TX_ZEROCOPY_RO, the TLS_TX crypto_info round-trip at
>                 the base and full cipher sizes, the NULL-optval and short
>                 buffer EINVAL paths, and an unknown optname. It skips when
>                 the kernel lacks TLS or AES-GCM.
> 
> Each fixture pins the returned-length / errno semantics across exact,
> oversized and short buffers, an unknown optname and a bogus level. The
> semantics are unchanged by the sockopt_t conversion, so the tests pass
> both before and after the leaf conversions.
> 
> Acked-by: Rémi Denis-Courmont <remi@remlab.net>
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> Reviewed-by: Joe Damato <joe@dama.to>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
