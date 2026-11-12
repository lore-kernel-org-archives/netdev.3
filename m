Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472366;
	b=2IUn2H6QH69EpjlHpGzdGo4ECKOEdjDu2D5sWVpwXCRf5eS+Mo+FVZkOtdTuPChNQ/le
	 r/mNdNqyH9f+U+AUrT4SSFwPUvINxIp6Pf2vJkOV18aXMO5hBjHGrqJQkWbtUCUoZyLuh
	 Zxp+TIKn5fg5OMdvnDho+2OfkcqAI78Vb6+xw35Oe74FuSadRNEYbVQYhh62Y2PKZ5Fx2
	 BRUAp//Z5LP9LNzFmvUF7FY7+6vRo1TF61VCObZ/aL9HtrhKxkxbN8X/RQBjP0Vmwr6VV
	 sLHxDzYjXT+KFeMlRaQ3HNMHeNaACevTHQ2iYDwq+wgG4C1yfSOPNO8gKE9rAu7j5kQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0l9eWNYt+4OdoC01Aa/h4I10jx5l5dY/DXFWNFAegOg=;
	b=W8SSrF5kzcHxH1JBzpJnTiZ3bilDvubCM+cGn5/7i9h6BfTMkSn6iadTEUVYd71apFp7
	 NxbF72LT487+oeFb6PVJlpDbjiUKiT5S+1L0ObTGB+Wp4/6RMm4xvjmvyOiu11m35P1HK
	 uhlMJgc4cjp5V2D74Y82ZPAn1tm0D7pPKAghbu70r7G/55vPwyTDE1kXOMfcUG6f/e4cI
	 YK1PudiFPkjXXJdoOFIJn5RcgHs3MHnUMUrrgVEvHl4SGuYjWwm1nsAumAT+ATBke77wD
	 Pr47czpqZephS1RoIzyLYpOfDkA1AX39FCFBKRe6dOLW2PcFGTB0jllmcMNZFrOzZcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IjZZzhPX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1464960A5BD5
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1464960A5BD5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IjZZzhPX
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b570ff3dfdso4336072a12.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 00:32:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794472364; cv=none;
        d=google.com; s=arc-20260327;
        b=en4/T96UpHZ+2mbadMsdq8chWohfxr1bdsqEfV1NVC0A7nmDADN5LlQOtw+foBON9c
         qG4RJtORFMNG5Gqw6ehIFbjHLoLJmVq50kmQSJMDcC/FtppE9d1PjSNGl7kcnTcAJlUA
         u96TlfOSb0jj59atCRsC/UVlL6yK3dUKXV6zPzfzR0UyetWBMEithaoJHd9mVYcVBEUP
         k+BjRGIL9dGzkuoDAbrTgHoIG17/Y0/7jL297pqYASnNgy0pKD3Zsp/AuaLAwjlT7u5f
         AGqPOdGvI24AbWMLhuyQSh6kj0GHEgra9t55vfD1c0XBKTmz/uM8TlYJusQ356RgfeB2
         ddXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0l9eWNYt+4OdoC01Aa/h4I10jx5l5dY/DXFWNFAegOg=;
        fh=rHiT7Cv9FVRUvSddWV1nuQ1eZD6Jv3BVY1+6SjMbfRY=;
        b=WjY/nDGO4LLhglDqGOW9hBzkabzXAzq4+8C97HFS1WuCPzDWb6/YbVGPy1n6VdJNYa
         XiRLrQryZJiTffAr4s/BMaD0tSd5HzpuGhziVxA2D2tQAP/zOHNL3CLRgvJXLtDWXVkr
         hhMEmM7e6PfiAor4FPixRQTtgn7og6n/Ly499Z5cG9Nee2p+UNXEXUJ4QnXl7Mgsb8cc
         NpE9pCacWuBUEYRG6v0mz799K6JBHmmkJbGpMdGoR34wqPdNhlpqWJEi7t4c2kVN/7hS
         guojb1MFKsFW+3Ich1SjHYjiirfEiYVAwI5/7V16FTxPqH/ECFYZnNfVbHzs/esmmNle
         eBZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794472364; x=1795077164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0l9eWNYt+4OdoC01Aa/h4I10jx5l5dY/DXFWNFAegOg=;
        b=IjZZzhPXrQb+C82MzXH+yaFZMdw3I1fS6f+ZKPUlu4rKAv7YGY/A4npfbHZ01BDx4/
         vehtR2RomeLqZqfjL08oP+6ImriXxgfvzxYVKbLJ5TeraSk7AGdN2BqZCr8Wfl8Y6rKb
         hLv1UqaQKCKAPrnqdk/3nPwU63dOGY6TlaP1LNzhv3oNk0/OxVEzF2RdbLEzQ5w9cEX4
         CDX3IJKXBPew0T49m9+pPKYVvmv1QcvsMgpSfZrVqfxCa7YIZusZzdVD8FqruquU+RON
         bGCSzVs/dSbZYdxZLgr3yfjig8gMvd2nyMgu+eUgDB2zpv7w8KhcsyyzDz+XmXgXnOt1
         V+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472364; x=1795077164;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0l9eWNYt+4OdoC01Aa/h4I10jx5l5dY/DXFWNFAegOg=;
        b=WO7CWcxCB0mxEzLzaIa+Tx7gGzxyzYMgMoKD+xLG4z4K1XM677jNYYpMGeHqPSWehs
         9/8mH20MYGmXAw449NncZwpXj3B5Ek0LuSLx1uyB2dApI34/EEwiqtqFgIJ6MSP32WnT
         J2WNZWAAuxtVDrM5Mh7EvFSDIKhy5QUSUoiukBGvp35SS5vsowpnYNXlSc6WOYua89yp
         6y/zJAjCGnhYn4w/v8PHl47D9Uu/pASegHVEteG8n6no8sVh+42LgeROcRLFqqF8QLBE
         //P7wXcQlt31GMjYzCzwNqVovxEQBZ6YDzrX6Ex4Q3JEaofjUHnh478MqASVQsopcgIK
         uQUA==
X-Forwarded-Encrypted: i=1; AL+hErEY2jIoFOO4m1ojzm/sUh+4cxxJofod9BTl4b/Zlf0wYULKF/dUx8+JH9GMRj6XonmfL+IC8cg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pA/wQthW/TVGkIJ7qLPTt396Pp2yr0lWBgKrj1vJFMLldoGwj
	GIEHR0DIn+hJXghqecJJk8BPCa2QNFOw7JUHRqDuw6EISwcka1ePL0iLrgI7w4dHSGOVSwI8tOt
	l1VP+u7a4uNcXmcBmt9G/etBGF9Fj23k=
X-Gm-Gg: AYBFou233b5gM7LYHbLifJfE+DjzoALxstCTG2raovZRub8KiCDpspEhfpJF5aI8AXn
	g3o4GYTzsAkRvWOPJL6jzV/AqYw8U57kJflqEg6O1tjPXRsi0AIiOWkmhBNfkkHYH2hOKfKfEfG
	lLDmLLTO90a92bTruikQfQhkhSuqXqvhuBwI3W6bIyxhmgY0vSY0YT0oHnTZIDADNnmJNd2hLvF
	Y+3rJ3uBECnqE9EtjavOm3TEOLezz5O/jvBfDko3aUO3ewNW55FZZBnzpgWnjyPTUkSdXyy/cjk
	LcGoeKdOqY9cjVbS+v+8OIbDfs3JHzCwu6SukgMM97nN0NpqX0HYIOqq6+JRPN63h/c/9/pTaw1
	ShD8emNoAD0njhLPnUC8Hu+ahDBDxnlFguxXovQYXWMuf+6yfKMyaRuoM70Gdwl1u7xab1Ic=
X-Received: by 2002:a05:6402:2711:b0:6b7:a357:375b with SMTP id
 4fb4d7f45d1cf-6b7a3573c70mr809364a12.40.1794472364208; Thu, 12 Nov 2026
 00:32:44 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110102039.1002605-1-bjorn@kernel.org> <20261110102039.1002605-2-bjorn@kernel.org>
In-Reply-To: <20261110102039.1002605-2-bjorn@kernel.org>
From: saeed bishara <saeed.bishara.os@gmail.com>
Date: Thu, 12 Nov 2026 10:32:32 +0200
X-Gm-Features: AclHuK_JmHtMGasdG1MlcgZSR9JInf5KlnPcivwlvNEZTX0IPHWZAk1Q01MwQ2M
Message-ID: <CAHfVqdVYBbs8zu40nEaCDvGVNeXHe2DXh0dGxEcgL3kP8S8_HQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 01/11] net: Get skb fragment addresses through netmem
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, io-uring@vger.kernel.org, 
	Mina Almasry <almasrymina@google.com>, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 12:27=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>
> skb_frag_address() goes through struct page, so a net_iov never has an
> address. Only unreadable memory should lack one: XDP and BPF read
> fragments through this helper, and AF_XDP UMEM will back readable
> net_iovs. netmem_address() also returns NULL, not a bogus pointer, for
> an unmapped highmem page.
Does this mean that skb_frag_address_safe() is practically identical
to skb_frag_address()? I assume highmem page is the only case where
non niov page isn't mapped.
>

>   *
> - * Returns: the address of the data within @frag. The page must already
> - * be mapped.
> + * Returns: the address of the data within @frag, or %NULL if the CPU ca=
nnot
> + * read it.
"CPU cannot read" isn't accurate, I assume that in iouring case the
buffer is mapped to userspace.
>   */
