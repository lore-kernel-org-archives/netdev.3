Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794440811;
	b=EjEq+v1r4BEq5TMtlp4jfQYOCM6/V71/1yQnFcAmcg4GCCi7JZOhNNl1swv1AShrZHuD
	 g4YXflwgBaPUkfxBxPjxih9ihnoV6jYBb0jrViJi7P1PvEiiGziCAWRE1hpatGjlZkv07
	 1RJrJ+i3Wnn5T6J4LSvRyh5jFvi6NNjZrys9eOqtGWjBn561yLC8PQX8Bld6csW7hLhwy
	 aBiEi5ISo8212d519oaNI+yBE5sKVhJKWKa2VjrZ4A77oS92m7W8ENAb6MtgLlmfVhRka
	 s1vs30DJuA78jn7nEmkEAlz21+CNO4oCPENuD7CSnLUkywlJjTWMj4b34ehtW4Zz47w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=qNTqvp880V1AzQPjbJWvL9f9zomucT2LF6ZlJcI1BTI=;
	b=yOkBONcaYLeMZhXLQdmwTuhQNpjR6LCyOf4XF7F9jKWop9Y3L7bcIkwzRFSXbAeiUzon
	 KF7qhR1+qC4D1WsTUpBUzgG9LbTz50j5quL+IwvwrLX391mtuZI8q6wz66AD1CdYpDPYU
	 MlcBkfeH0sO1aTT69ylVFXWi/4EMtlvvuHPJKIVa/rOT7clHugArN+XdWJioyXyZ1aZ2A
	 uOUFkV64Y0YmzODsOVF35LSSptuUfNLhf1nlmWgyVJ0/ja3bxo/4DXCOpmz3BWbWXC5GP
	 C5EnWOwxLWfSEDWsdPvOjHoE+C1oUn7wSqnnoCkrPB+kw1M8frybFkaavmYGPhALBzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NMzD0TqQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48323606A88C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48323606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NMzD0TqQ
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6f8a519e215so389301eaf.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:46:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794440810; cv=none;
        d=google.com; s=arc-20260327;
        b=kvoglSM2ujR20jpw7cQulKdhaUJ2c449xvebE/5HAdzGQlusiJigTDdy8IEsHcGYsl
         c18YWgRsz3QuNVSf3w9jVeSfmuPzj232/Jv0348QWEIAmoqRVh0UYobA2iLPIrFK20ZB
         rWn5cXs9KDfFKCsGoBeG6mF5huegxUmLNj+H/AEJYzz7L8XvilVM7Cy5Wb1LNPLexjkj
         BSEzttwRSORtYQ5nd9qnP4WX3m6z2bL+LqBpnRhGYvd73lgMIqxdxEI/5K9weCQK3k88
         SuOgoZc8l5ACUpkEuElDFbqPnd0FTUnBGpVW+ioBocIgSc6JBExcaG66Z+AQNUBoSBHi
         PR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qNTqvp880V1AzQPjbJWvL9f9zomucT2LF6ZlJcI1BTI=;
        fh=cBU9PA24bKvg9Zh99izShP2PrFO62EbE539xTfKCj/4=;
        b=JcKpyrad56JR5tiWM7trMnj86tWtwh/U4iL8OzuTVUN8xDwtkhYVATbP1OgeEp9PrF
         toaQaJzH6ADXUmimiQhd8MVKSDxlwF8V4NpB/4qghOHsVYxgzkvkLMkfBfuvguGtnN3/
         mhgsD23AXDJTCOnvUJzUya6IqgL1lZAUm/wGlOzqQWwIxjX84np7NihZZ6XPjBrremn+
         Hh2XtNWpUX5+IzYvaaUFXvc9suePEqJ7HX8hpIEZUpqc/Z3rhirVkgIJxxfZ7NKj8IZB
         jtQQjmdNu9w9BjvZ0LzuyLYtneScZrp5ezKpsn+/udcSZpsdajEyiJk7Z8K2XhAK8X9M
         kkMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794440810; x=1795045610; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qNTqvp880V1AzQPjbJWvL9f9zomucT2LF6ZlJcI1BTI=;
        b=NMzD0TqQuwQhNFF7aHIeC3SA22YiAV6mClPOc6MrGmoClNILecdh5gv9EaYatBhdKE
         S1H4sFNblnlve+OJ5uv+CLBpCh3zyK3uPT9kEdQN0l12HoIbPqEJlOF9UoFWSkvyP+rJ
         3mNTQlsFv1mTjxeytumNxJdr4WJuHO33aTEDzdBhhksudoGOfutqWottdoB1bfhO6aSd
         y367fAjCvv3590WzqeHb+Op5WihluIRpLNtFeGoYDaTL1OBZfeAsuyTJH/7XQqQHlccp
         0Hkjf03LWm6Ft/NQ3NDaVlRkGHvuDpIkm3elkOCI9vAVjkFFQnT19iVmrD5Rtd8pjCBp
         EfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794440810; x=1795045610;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qNTqvp880V1AzQPjbJWvL9f9zomucT2LF6ZlJcI1BTI=;
        b=0/kaFYWN7xtg6KkkcIjWX/9wDgRcTThxhnJRx+7TddVPWNsJGbLzT9/IuIYrh5ebN0
         i6oExL878Nn8h8LR6nAzRGah1tuMrlM7WLt6Fntb1l+HJ//jOyBa+gxWpuTBmXnmTfWl
         Xif2Kl9QDA7zgokLC/zO+umOPkUyKnJBazTCuSL3Hbjr+1PCp0ohTnaPQZoQwyDCCvuV
         8ALmY4JGDifWFtPHps4cuEdUeZKX7unIG/44Q03IXowG01nQI9ESzeH0dIyg+GuLTw5O
         PuYMyu2UphfgcahjDDpvPqZG1h+YJ5PHG2DBqRYYepuq8q27sQlCmfB4FIUW8ZXCFuv1
         Ub6A==
X-Forwarded-Encrypted: i=1; AL+hErGdLhjPdTsmqkHjgkROgzlAGLA2Mz8qIXJzsC0nRCzpbeJSk7ptRPiXW5pkrVPlAksfnNt2n+E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/AA/obewUKWO7MVSpprAUIBC160NKXtaURBIlUOKhcz4KDuzK
	waE1u2EliJNZX3a1U213K545p6yJ/Lrt1hQAu6Gk0lvPAEQFFsztLUfdWrgfKVnOtf5F7GkZK0F
	11oPTyWTx4JOrMpfcqHizGUQBICJ9Go4bpsAhhMf5FA==
X-Gm-Gg: AYBFou3ZqhwS1ezg/pGJnluVct3UYMtC/b7dqQGTKyonr955CglmJeV2XO0UPTnP4n2
	umNmGgZG9vCEQJrjh9qsBJeyhyKkoeE5BA9/lOqjq84nQjprWvcMBjwEwMRn4JtVg9XjmIK4gze
	ixEgwLLi0pCquwhK3kY01BEC4/S4Mo/l+rwDoTBnIjSWywEi+8AzmpCQYvfxT5NgeQbOpLboIxp
	8aSkN3HOCWNKfYpKu4XiC1st30Ko+8an2XGwRDO6NBwi+RW/j4cFWW88XisYdVnvo/hFVzDwFSR
	DbVlc0FS6h4iLPqMLtC2vYfvP8rAVr/2hkD9Kb8I4O50Fu5S41qBe5pGla+JCXnhUcq/dkKSil/
	VGqozgydeNuTx2JakmkD3QRVG2+aguOyasxZh0jW9RWkcCl0y7CB+oXEW3H1AQwGbxEYL02eS/L
	A1EMA1Xv+KiQ==
X-Received: by 2002:a05:6820:f004:b0:719:1627:6c16 with SMTP id
 006d021491bc7-7196b62ab2dmr743911eaf.12.1794440810117; Wed, 11 Nov 2026
 15:46:50 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794281983.git.tianyi@cloudflare.com> <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
 <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com> <avTqb--WfUNBcEyN@devvm16445.scu0.facebook.com>
In-Reply-To: <avTqb--WfUNBcEyN@devvm16445.scu0.facebook.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Wed, 11 Nov 2026 23:46:39 +0000
X-Gm-Features: AclHuK98I8l2CyqIug_hRhhYiDHFe7Xrim7_SwhM5rRiI9ms5coKAG0rV8Jl2JY
Message-ID: <CAG4wq-dw8VqiVTbi-fSJTnwj+amkfE_56ndKCYk4v31z2ppcTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Vladimir Vdovin <deliran@verdict.gg>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Tushar Vyavahare <tushar.vyavahare@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Madalin Bucur <madalin.bucur@nxp.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Chris J Arges <carges@cloudflare.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	llvm@lists.linux.dev, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"

Hi Stanislav,

On 11/11, Stanislav Fomichev wrote:
> My main concern is that we are adding a lot of code and one more
> special way to plumb the metadata (and another metadata area), another
> set of kfuncs

The RX metadata can be stale on XDP_PASS and lost on XDP_REDIRECT.
There are already separate attempts to fix it:

- the RX hash and the VLAN tag [1],
- a checksum assertion [2],
- the checksum invalidation that you suggested [3].

For me, the question is not whether to plumb the metadata, but how.
It is not great to have fragmented mechanisms. The skb core extension
area aims to unify them.

That is my view. What do you think is the best way to solve these
problems?

> and slowly creeping more features into xdp making it
> more and more like skb.

I will leave this to Jesper.

> For containers in general, and for fast af_/xdp, we seem to have been
> moving into netkit with queue leasing. Maybe that's something that
> can help with your veth performance?

Thank you for the suggestion. Unfortunately, it does not fit our case.
Our XDP program decides where each packet goes, from the inner
headers after decap or even partial decryption [4]. Hardware queue
steering cannot do this.

This series also covers cases without containers: XDP_PASS on the NIC
and cpumap load balancing.

[1] https://lore.kernel.org/all/175146824674.1421237.18351246421763677468.stgit@firesoul/
[2] https://lore.kernel.org/all/20260630191510.81402-1-deliran@verdict.gg/
[3] https://lore.kernel.org/all/amEojEGsIGkUjIWn@devvm7509.cco0.facebook.com/
[4] https://lore.kernel.org/all/ca38f2ed-999f-4ce1-8035-8ee9247f27f2@kernel.org/

Cheers,
Tianyi
