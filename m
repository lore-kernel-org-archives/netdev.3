Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435917;
	b=N5ilDJgF4+MqyolzNlI6qDkqFvl3N9yNWDpxvhqKGcT+ZHPw8CM1ZkUQc5lxGgPKpaFm
	 9wuK9Qq8fVJ072KEFmGRwAAyBjBhpr13fGBZrvG9YvqY5Wb9/urlFAThqlspEHOwNEv7t
	 Mb6mq5LhzAw73yz8yLkmo/2is2qR/DgEdtQyPvmCgfGXj2PQLgRhJ1Zd43oZ0NEK5qkyp
	 ZJN5YLg7Kpq8ml6eUXVR7p1XokFzECuRBp6aeBwWKxlMuvw76jjKqwKqCdnU9kiqYXcbm
	 ZxwNNfTIR5zztPzZBK6wlmX9ajL08I82B+dqlAeOI4z5F64OK4/S9szmN77J/WM8Gog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=LcIgSNREManU20T5ds32E1qosC1xbF0e9vbPmoZw/SM=;
	b=GS+2d9b6Z9MQXbxflTHEEDMS8qKJ2iKvIeeNVDMYD/0y++HMYvB5M7J3fJ5TNzCCMbmX
	 2NXORuFNg5YBdobjlPx/3ZYCKnzLAvoyQ1Tvr85WQicCRm53czgHW4F6QSIjgxZ5X6Fw8
	 ie/A5qN7hPgZ90U3r2Sd4p4jUKnJiX9xvf/u3nJq8QvyAo5SBZzgwT6lrqPzUnMX87bfA
	 EpK+5ghxV2tzzTKrPh9hdXP6fzNoukfgj12jkNOndSxRbm0AHiAjV/Nh9gDMNCMyXdc8t
	 9qehvFD4NsLOtk9dZ9TtfUuM1kJ0JumjgOWnkVi4l1Kv83GNQflDLj4Rt0+mmpg4MQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="WRxwN8/y";
	arc=none smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE38B606A32A
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE38B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WRxwN8/y
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-13985f8229aso3309004c88.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794435916; x=1795040716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LcIgSNREManU20T5ds32E1qosC1xbF0e9vbPmoZw/SM=;
        b=WRxwN8/yRQXnBMs79H4zEYpeGEdBg8BnKhaHIb1pRpEfUeouvtNDop9d5/n4XDIsTE
         bS+RCTNz2dFaoNvhaPgORvboxzRWa6ylYl/nYhEZ5DewOd9+xQHb3ySenQgqSb3A3aAB
         EQy827yfXzHAx0VVyQT/26oNznABcK6D66SnLGHhy387O11NbSMNyPxIFHGmHX1Mix2l
         6mNwh1bPwiaWQ0K4p5tC9qsb/pgi0MigrZTf6G2BFqiTQ/4H1N8FfNfOVZccC6GSxP3g
         +lo10dqt1ZyMjXI9qhOjp9SauzZgLfWXaLHu1tPrqDh+qWL6hHkpxkqYzy3Mq2Asx7sU
         qu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794435916; x=1795040716;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LcIgSNREManU20T5ds32E1qosC1xbF0e9vbPmoZw/SM=;
        b=1zJ9EnQahmtPc5YixR27D6XZWmtW+NFDSYG+lcolBQl4dX7XvZgRfw/VwMlj3Bn+qs
         w53b/Ie5gTKd8cZOJMPWwAFrQ4anCEG7DdjH0RVpTOFhd3Xm3mtYzgvKMrHr0rndDxFQ
         rkjHctxz2w/qfdTuNr1vqF7iDkvLMd4SIVOcJrSg18xQs3gnsk8ltfY4y8oREXVizkCv
         wzcqcsCR6s8LeC3qVFkBvcEp00TOjYfG0j983xLguRTwIgM2Z2tVNZWk4LisBHLuCLdf
         guLq2PNZCNCE/IJDpWY9MIRUFQaFpH5p/HYg9ERij6mTkVXNO2su410XmsH7Gy7GZ6YJ
         uKsg==
X-Forwarded-Encrypted: i=1; AL+hErHj/+8c/XKnSVilotZLYZQHadrYVAfCZ0vGZz+6bMwAwQ1BtuP7rts1i9gpmc5UFggdx9JGCZE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nVAQIfKp/SLJ27x0n5Cu00/wIxlCVxF/o+1anNH2ipMayk0o+
	nkpAG7xrDHPEIU2PsuBbsl4xFCLVno6bZ+gzZeFLAA7Rv0RJZ9YMTNx/
X-Gm-Gg: AYBFou2rUzKfaLhPJhmqOvOoMBQ3lHvBIpqXk890XCqKOQB52MchqkAhvQGegdYKLgy
	8xup9RpXY46QZPgOiltqzU0zuTszPBgihmK9pyg62ha1jV3jjo4PRhLfQo2D3hKt1xh2AQJCF0+
	Lpbw5D/JlNidPwpYWFUDb6MgXbWV4dWAUErj1c2rbBt015VnEcIfXbTzI8lvu1zojBymsQ/UY9a
	022TgTSN57Ndg+C0gxPfaWj0uEP8EicUh+B45oFG3o3ubyIBMoAQ7KF6lYmnVELvlmBBQQD6vNY
	6a+Ztk8+W2rKjPVxcak3hn1R8r0uy5RrHdyT7fCTY1sc8Djq3mVkql80rRm0KCskf4+3cHQIKnk
	HGuyHumhnTeOvM5BhXaArGd+34QUJR6Wl0ywgipFrj2zkCQeO70YH4olGnBQmdqa3hdXSe4bhRt
	ACbCtfS0SCvjWB9rKVkazf45sCZuK7pVUvcdXHR3Bcyp/hE6C0r20O/DIuoidvhIehmu23OBmFQ
	dowVlj5DSspWqQrnxMcyCAd3gEkJxkkbGdhIR3M8992pLpwNPBmdNHmCI5drX+veJ2JcmrTWuOx
	sKHQu7+tBQWKhZ1lQc9OwEQ=
X-Received: by 2002:a05:7022:286:10b0:1b3:a23a:d1f3 with SMTP id a92af1059eb24-1b3c03037a9mr3351998c88.18.1794435915687;
        Wed, 11 Nov 2026 14:25:15 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:43::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890584sm20682923c88.3.2026.11.11.14.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:25:15 -0800 (PST)
Date: Wed, 11 Nov 2026 14:25:09 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Vladimir Vdovin <deliran@verdict.gg>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Tushar Vyavahare <tushar.vyavahare@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Madalin Bucur <madalin.bucur@nxp.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Chris J Arges <carges@cloudflare.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, llvm@lists.linux.dev, kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
Message-ID: <avTqb--WfUNBcEyN@devvm16445.scu0.facebook.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
 <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>

On 11/11, Tianyi Gao wrote:
> Hi Stanislav,
> 
> On 11/10, Stanislav Fomichev wrote:
> > Awhile ago we discussed the alternative of adding setters for xdp
> > metadata. Then the veth (or whoever turns xdp frame into an skb) can
> > apply whatever metadata it needs (and there is some magic behind the
> > scenes that takes it into account when creating an skb). That keeps
> > the layout and most of the code outside of kernel. Have we considered
> > that here?
> 
> Thanks for the reminder. Yes, we considered [1] and [2], and took
> parts of them.
> 
> The alternative setter model in [1] requires a program on veth or
> cpumap to call the setters for the RX metadata. We want to avoid that:
> 
> - On veth, an XDP program removes software GSO from the peer, limits
>   its MTU, and can copy skbs from the peer.
> - On cpumap, each entry would need a program only for this.
> 
> This series achieves the same with only the XDP program on the NIC,
> which stores the values with kfuncs in the skb core extension area
> after the xdp_frame. cpumap and veth take this area into account when
> they create the skb, which is the "magic behind the scenes".
> 
> [1] https://lore.kernel.org/all/20250616145523.63bd2577@kernel.org/
> [2] https://lore.kernel.org/all/aGvcb53APFXR8eJb@mini-arch/

My main concern is that we are adding a lot of code and one more special
way to plumb the metadata (and another metadata area), another set
of kfuncs and slowly creeping more features into xdp making it more
and more like skb.

For containers in general, and for fast af_/xdp, we seem to have been
moving into netkit with queue leasing. Maybe that's something that
can help with your veth performance?
