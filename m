Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793174368;
	b=BFdDCs5aockJqWsm8RpBWvcZ4i4Te+JVPpIOw+LvqPSTXXBdxrh370BWkHGR9IKvZg/C
	 6xHuzhkmLewhieHqeWl1LH9M6QF2yUKiiMyfpgJchgMnMincrWn6enysWu7HsWkOTtbxW
	 +IJe6rgXsGC1nLaGod1jvZscM2mDZjh4p8VQZu0k2L6nxQcLRkrFiaJH4Zjd/CwmE2/2e
	 i43hE1kX+yhanWhxUSG5bjCXtRJAoWrM6NCISFXBXvplvzwiIfc1HVic9OplDvAI98ShQ
	 V7JoXMQDpUBAcpiA2qIODJh/cuzI9wT0GPSmkijANJRCBQjKFSL6UIzDHkXKHhtqD+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793174368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=msuWLQXGOh6jOPZD6wriEwJopuzDt21S4GJ/FY65JWQ=;
	b=I+z6vSI0/igYbqWUm5cNaJGMkOZ+kmamdy6o95MoHgoW1Beqq9rM6erNJcAJoxKUbAl7
	 S4Vv8Xg1jFHso9PQiMKURe9LanI0+xnJSsWeYPZrCpn45Nq3r1K5JZMehlXnW5z35XNiG
	 ASyDBg5pcd4E4dswXonQlT8D4OppgcD59YXCt4rNNqedHEt2x6eZEcMAZptZhs4NtTt3h
	 sD3zrh3xJKz7swaPwZ2WI5e+9NC0YbydIa7FZIRTb701qptySqHx5p9kTT6jIb3ZmpKJL
	 FC8lKm5fV35dja1jFgOTwok1HIcBPy6/WWagfMtufzaCKmTFURB0DH4mMlES40Eio5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=fail smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC1606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 07:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EEC1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-85a5455bd3cso403389a34.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 00:59:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793174357; cv=none;
        d=google.com; s=arc-20260327;
        b=D4BpSyD2C4bMrpGkW2XUB5E3GcdNJ7NlOSfd/Wx/wGy6lW+rxroJCuFwVBAgikBw9v
         oW0YpDSBik5DJGfc0dTcNMxSxosd54Qp1D6rWeIJf6/d9a+Hgz3DoGqGfOqqZ5elwaB4
         tCxPSQ8oZY93eQYkSqw2UyGsz+2TSe9yGNDuhj+MymQD41YdYujx39a+x2ZJ7nDZwOFO
         1mjPZcKdFvwFqtt1lj1oXD/MHeqeSknxyOFDq+Y7t8zoHEi+gZ6x7iX6lCVRfeyXrNBl
         G13odq+uk0TC39M64c0GlGBQX5jJHdj6iaAKPWySe/NuBey1ARe8Z1EkLVNWdPL60613
         U4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=msuWLQXGOh6jOPZD6wriEwJopuzDt21S4GJ/FY65JWQ=;
        fh=apboHd9+R1dvvCkJdZDZKmUVNsbKVTk7ZyeK9b5N4V4=;
        b=blpyQdoCiVkqZluMLoZDWGVK3Kf6DoJFLduqQOVcZys+2WzSLdpqZVzXQ4BLuzOJhj
         hFkWABxJCI9toXMpwx45aYvxOnI+QgCyciSIwqdy39u5HHpn7SB1KK3IA+MHtwGN//mT
         RR8Tw602AWPO8x5qIBiwuyxyKO9HTMru2AYgGAUMDoFHz3FoICGqW5sgntKL6oXFReHi
         XDEpiClVaElplQHwf1ebLxuc9sTaLcg47UTFeL27AqDuMbZxxd/qtKbZCqNy9lCL/Zr+
         kpNhEq3xiYaOhICAR760zZQN1kj3EnAz4BfM4CRdNcm5oI8Uju3uzy+jaPOc+qQWnYQZ
         lTdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793174357; x=1793779157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=msuWLQXGOh6jOPZD6wriEwJopuzDt21S4GJ/FY65JWQ=;
        b=R9NvQxMhaGhFSUqcgGV+fpdOYOsi0VJ4fJecDZOPzbqfdBUXTqicx8p9/Z3VNJUQHl
         be6O1vD3lYeJnMBMA3L7kgc5anYmZKKgt2pJPOF7RwBIDgeXeRvVqm94utgRAYIMLINQ
         Zy+dIt4pus1n7dPcVrza8X2MdOCtjEing1GhsKnNosmGRJhBEE4yOQFlbURFFsGzriwE
         4lbklRvdh9wrKadvH3hAT8PEzVWesaZBjBwd3fcKgN2xnZoy2VQg6HS3WbXnxV/J+AD0
         tBmXYnaPp6KrVhEdPnJ6+J79QS4chTEdTlI0cCRYLUfwuv9yh8sEAV73ZraWG7gZ8Npg
         +RzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793174357; x=1793779157;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=msuWLQXGOh6jOPZD6wriEwJopuzDt21S4GJ/FY65JWQ=;
        b=Eqj4DXhqn9+ryEX5emNBwIWGWZRdWStWlQlmy5T+zYPD2GJZNQrkXnDctKrjj4vStQ
         K9SGS74woHa4SFxZQp0wW+mkD72VDaGtaBn1F3AgbmjdftQy4nwTNNM7SFnlTdyi4pD1
         dBD49M6lvjRBJNwiwLg8xoHjx8lMhPJnPfcpd2iqEfKjlmnSTB6yW51KqAXZa8NlTAlg
         /GxGTrcBBqtcDpNvoOquBjwxrMFxM7U9dm68jz6/d/JYQ9GQiGzoKBeTMgDcBDIaK9Gc
         8iZmTTeJFjF3r529LMtvUoiuNd9sHkXC0VXUb5AcPKMTuSPCY5d1/mLX1XCrQFnQmmDY
         uwlQ==
X-Gm-Message-State: AFq9FYKKKo067wnpYudZLU05AQTjQbWisRXOtZwyOHz1dvb5SzcQiTc/
	nyTDLqazb+XQdznk+JbYzysR7HL2zAV8cS1vm95PKqOLwHSt+NV1Vo1221d7vpCNcr6nCB02kSj
	oiFF04xQ7yZRKmmcUMeb1yYKq9i+V5T0=
X-Gm-Gg: AYBFou2Nqx+H7cp1g/Eop2OVs6olOaLXH5ey06eH1vExXm5LJUVkMi/qYNK86cBAYq8
	BhOcy6OPEw17PJQhnUzT4dUlQQIiC4tBfMe//2zeSDDuZC5qswcDrfhiSTzJYkAHd6G921qWb7I
	2adg3n1faGeLBtxS5x0zL3xkmT8eqOUECWW5u/rh6AEXpeYoHagQNvwWLs/MBnsY4XJ1BcZG60A
	wfkHuIzPChLr8oZMdzEXVqCf1qkfbOq81AELcHRKZBpbOgklKBi1e7Fgkw7VOjTbHNTSdnYy+ia
	b+1W71SYdOnCgzCjWjBm7iikZS1ClFR2kMeg8OvUzefg4ze8mwCmb5/7zZqzSLl19NO1KHfQPe5
	N3ikxq1h+MbFcXkRs2chLcklNmxzMRb8IzSjWej9v4hpQlIv9Uj9bgdD17MNXSYudYDS7FA==
X-Received: by 2002:a05:6808:2229:b0:4c3:6d56:77c2 with SMTP id
 5614622812f47-56382d8e3b4mr1018296b6e.41.1793174357044; Wed, 28 Oct 2026
 00:59:17 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026230300.1108190-1-mmyangfl@gmail.com> <179305591469.3327.15926756079213213876@kernel.org>
In-Reply-To: <179305591469.3327.15926756079213213876@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Wed, 28 Oct 2026 15:58:39 +0800
X-Gm-Features: AclHuK9cEbASpRdFT7CBMyjhIOqfOiryiWSEaf3aWW8MiKpQ5g6wl8MbD5qJiSU
Message-ID: <CAAXyoMPaA3UH=pWaDN0OHKaHDqdFXhnm67GN1b7m295=pqwrTA@mail.gmail.com>
Subject: Re: [PATCH net v3] net: dsa: motorcomm: Isolate all ports during chip setup
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:05=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

HW Tested.
