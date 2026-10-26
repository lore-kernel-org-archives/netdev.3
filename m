Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003827;
	b=ggjL/V4ebZIEJA1OmYXavQw6wqmdxId9pjW1gDtD3BPhP2+YYiiMAbcmp5S82t0zMXHL
	 3YJYRAS08ffPJGMAVXk0i/HR7w9L5wu8W1WZnEL6vjtASochtSOFo9jJWyTXLc8aqm+u4
	 OheL/zTX+XyRVPfsvF2wDLrbYHIBYSs3at7EMGGzlrPyDoUHbnFvn9OKDOwsdWcRnEzww
	 gQ7nQPMf1BQs9LE89QhJcWBaTHgHLjOwUTY/FIpEFo4dEr0+rAI9uINljEEtfQDXfYgQ6
	 suIxzE5+fER/QssNbDzwnTZ5FOv4MlFSoISJtXVLpvo3hFMcplzak2FvM0bZsqBVhdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003827;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=RUA86guEgQwbbO7ByDKrdW1/1LPSMKM8UU2NIH1n7P8=;
	b=stbN+rBb7Pq8Vw4mhKHQjSBE66WC4YCVKvO9zK5OqanAtFtGTWjSRbE5NcnQkirBBEMQ
	 WF95LlHKlPmts0mjrSxXsL1zd1wYM8kdttSU1OC661JYdPIvw91DZ+n5x2V1SIb1k3omi
	 pH4XSAjJ5koZUiyAq5yNF9gfTSLcyaPBBz9X5AZkcvn8Ob9HwEw0Ix/QoUhp/ELSyV5j7
	 SoYKIY12YgK2uYIDGv/7bBUxx1jLOtpupxgF4PH8i0AgPpPFATRO4KeeLYVIjdwSobq8m
	 6hc94IKrNZ1q8qszszgNbrM8X2LBP2KbLTYVMP8dikZT/OwWzyMhpokoI2K9nu4Nj4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA186606A320
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA186606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so3021641e0c.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 01:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003826; x=1793608626;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RUA86guEgQwbbO7ByDKrdW1/1LPSMKM8UU2NIH1n7P8=;
        b=Wxj86rVzZXyi7LHuNe8mQtuW+Ex6pY9wZ2NqBx14xARP0z/YmaZoaF3qH1rFFGBclW
         1hE1t8u/RBNOcRt4XNmyBEQQ1lzZ8+nRVNAxXrZedaJOPR8ZdCzVmDF4j7PndusX9Tjh
         KtW1fDvQyIrQyi7LmaqcgOTk3pS8H57LvtBto9pR9ta09t9IbWQInVYQOb7yKSHtnNEi
         lzozxvAdRTLe9kiEc0tgvzUnctpq7KJ0hAKT2z/rVQyTjjN+4E2zNOUagfA9CKXCni4p
         YyG5gDvXvBZdrW4QfavF/j2/yv+1bRaELKlqLCFwyjQGbld4WnZfdt6PdWDN6sUN52ll
         WF0A==
X-Forwarded-Encrypted: i=1; AKwUvBw9Sz0Ehjx1yJP6UaXg/iNo64XaRuwQjbOXVvPE5XqZvoHE5+GOvcGdZnSzDxKqKxMjc8fqtNY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAMDJb3sxL93taxGbGRpxp8xr9vcxOSc2Aobj+8B0FnDLrQR20
	0RLJu5lPqLTetA4f5YcARdJtqja3vzO0nd0MptPMRUdb/wx06ZnJWOrB9oD0sZrR
X-Gm-Gg: AYBFou2wsYZL48uvHWO/16l5kJiEoCsxdlIJ1HeXIVkKkyXQfNk5w9WmT8gBbvsSrdC
	yITdpcgyDAOvckLT3oqKbbsKDeIzY3BikphQCHB0IEa1ac+Byl9TRtumTWNjp/wAiKGC4iaPJ8t
	Dz223j5Pcm0LL+/MF+PpADpnWPuzTb+v7pHTKT11ve1Vv7UlyN8rjKsempFtE55ojZgBqWn8rut
	IeX0u9Zu7og4dJ3UcbD6O/yNJ5mNGkhBnGOz+xQKlePiAJSR2p31uV4CjfIzamk7Qmd7XqUBDZ9
	oC+sNIVC97mQ5H6wquI+YQ5sTxraUSD0GY6uUSqMmK+Qq6cklhVZIkUHnumgSqRsuJOm2F/NoVp
	irZkG6bEtynvXQm1LrWZp15v+7oU5sTUBq/Z20xhuUCAdu0KAbWfJfuYIxgYFzGOW1xnH8E+/eP
	MsWsMMtf7LwqJMRSHTo0Gy487YtSE0wQqtFt33UvLbGIu5eGvJAgkr4KeC6iXiebJlR9xCQsjFW
	iBFtUzJJM8y4qmL/0HyuPI9MnMw/Qptgm8OJ4BJMcWQclJDgEMNmm0pf6M2cNtHYuo65FCIfCfz
	wIgBuXC9tShIMvXYIg==
X-Received: by 2002:a05:6122:e183:b0:5ea:c90d:d1b2 with SMTP id 71dfb90a1353d-5ec232abc41mr2020117e0c.13.1793003825895;
        Mon, 26 Oct 2026 01:37:05 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234add5dsm7585056e0c.16.2026.10.26.01.37.04
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 01:37:04 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-98c78660542so2028806241.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 01:37:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxYy66in3MBZ2urWzLgyvkhszHzddFPceuSehpLOzQn2s7CJ2OWo/M7vuFUxJ8x8e8m5tK27fs=@vger.kernel.org
X-Received: by 2002:a05:6102:3308:b0:7c3:2168:d603 with SMTP id
 ada2fe7eead31-7ce5c6ba6ffmr2185044137.0.1793003823918; Mon, 26 Oct 2026
 01:37:03 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-dev-mctp-static-assert-fix-v1-1-ceef9913e891@codeconstruct.com.au>
In-Reply-To: <20261026-dev-mctp-static-assert-fix-v1-1-ceef9913e891@codeconstruct.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Oct 2026 09:36:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU0-3iyRFCvau7OmjZDmxqbLhTr3Bv8OmymS5yb2p2nMQ@mail.gmail.com>
X-Gm-Features: AclHuK_Mqm-AEJnYW3-6a7k7aCpVsfjR36Ni_iSj735r1ypyEyzR93mPV5Px40A
Message-ID: <CAMuHMdU0-3iyRFCvau7OmjZDmxqbLhTr3Bv8OmymS5yb2p2nMQ@mail.gmail.com>
Subject: Re: [PATCH net] net: mctp: usblib: Fix broken assertion
To: James Lee <james@codeconstruct.com.au>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 at 04:33, James Lee <james@codeconstruct.com.au> wrote:
> The expression in a static assertion in the kunit tests was not
> considered constant by gcc, causing an error. Replace the static assert
> with a runtime kunit equivalent.
>
> Fixes: 1e12f734afc1 ("net: mctp: usblib: Add initial kunit tx tests")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/netdev/CAMuHMdXTGGdGWZ9sKz5_sQF1237gV844cEhkXr6v_TUHPOb78Q@mail.gmail.com/
> Signed-off-by: James Lee <james@codeconstruct.com.au>

Thanks, this fixes the build for me.
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
