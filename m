Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.161.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794359279;
	b=a9d5tk62Wbcf9AFrcPxhFmE8VlyaYvD1pbBbe3M0zw0A+QwSOP60gxEs/fbE3UCeMed3
	 YqdYY6nrgvD2kiaQfZCKtGMIs+BjsF4JHav+qA6oDH89vGSoAm1UQjhMujDEC6tR3GYv0
	 mInyA+doBu2i3LQ6JIKCdxpVn+q64PRO+ZDmFxVuoage9rGLel39n3tCgwDOaaw1thXWH
	 vK9AMDa3a+RO+WF/Ccp34CIP2IkRrYe5LPRlCxz4y1bYsJBEjB/eU0uAP1nkGxHwMfiIC
	 VyAXbd8kE6SvbPPeNAnpR/YsE77oduOVbmFI9YqJYfqO33vYvQ0WygZNTXDDuxGciiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=8MFwGdApl0d4OiJqtJrDFLzpxo7TMPDirGuojCnnp6s=;
	b=Hd84G88Bmba+gN8KyVegHR51Oeu6/Nsiy+B4ITWLJR6nvb9fHBBl0fw3MpbvwG1Gm8hp
	 bUDM5GG2mB/1BmX8FcxKi9zHG+IdGSu43WWW/hBVT93sL9rswyWdfz/yzs0GuDvz3HtEt
	 jT9j4JXt+9mn/I/EMN4bxMq8V/OUpXlg0H38nX7wizEEvOPuox/XaI5aXkeB+WrnbB970
	 qjxhD5Bryoe2ATBb5M401V/mV8foxBDP9Gxv4ucNzDZ2gSjLv793cCxI2EXNLJ0HCcc+D
	 J4Urrq0mK9Mqnt21pZfcoah1qZJAb5QwVsZ+JeqMw4uIxy6xz6tdELahsk3HQB8mYAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=EjLXsw8R;
	arc=fail smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A966606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 01:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A966606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=EjLXsw8R
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6df5e315bd1so2070706eaf.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:07:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794359278; cv=none;
        d=google.com; s=arc-20260327;
        b=YSOYo2B4stPN9DGM/YOmH7rexFhfmfERqPD6w2Fow1+dcadSkbi0WqWDtudBpxRZ6t
         clHXqUJMzkrL9eS3Lxk73srxqIu9QrwLPZBtv1eqtgpvM16iGOnFabHr51yuCt42NU6O
         jqRuu5MSq3886QcvNemE6UeQA2aXoz/V2pUTIfMcqA80xPGOEBOt7WmrkWzHeYpg7IyN
         F1zJlrp9fe8VbM2r+O4Dfa+JThYE7MLLscPBbFANttmCdk+3MfuPmXtXRckU7TRiQG+3
         3fAS+UFy5KcSOdEFDLpcnSe9sZuXlv/MG1uuG7glUwRA0jjTYlaPGj8IGem2OUv33bbX
         ze1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8MFwGdApl0d4OiJqtJrDFLzpxo7TMPDirGuojCnnp6s=;
        fh=jTbZm8D1oOs+R8mmwvGFFhmoF1C5PxcjKpX0ZcG7X40=;
        b=TFw5FnpJwMSccUaYjE5yv8DPiA6lV8DOvYqvrZYt06mK5asSbUQmFcRdAoxQyexYKN
         VlJ1aDbtSJthfm0H4JbH3tS4N/4+c7RjcovPGcU+PRlGwkgfer/8uPzA7yOmhYW3EEqX
         LPGzOuzt0IDIMoPGAOp+EfS3kXOvaqQrFy18Ykh3zr4abG/S5iYBcVxHuVk1H9JxZ9Sy
         /8gvq+hl1LK0kfWoh8bUMxJQvM4GTqVQKDV7GX8bUV3LZzV10AkSiBVrGyGP0Q7zJVEa
         JH+1mIdiIsLajNqPCMcAmWJwA2wWiLTZP0g7VVbdKX16NJFoRjaj4PAvcGkADCiqoVRx
         NVkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794359278; x=1794964078; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8MFwGdApl0d4OiJqtJrDFLzpxo7TMPDirGuojCnnp6s=;
        b=EjLXsw8RYK9LddS4DSnzgL5BG+S85ls0lQHexUCxrrgOE8c+nbSlDaIhvMJmh3Eer5
         vXDdlz1/G98drqKh2hlkTWXUSxGkTgmok0qV2/fAFr71FqSgI1rOfEqm9I91pXhGhN+a
         fGhndmMZH5sQtIcdP2A7UiHMpAinpCQNyPuX/7J16MOG6BqZ0YCXUzkwK1YtUfg0GrQp
         Di4IW2RD0lI82lG0B9Mjfd+WCIP8XIOqnfufvF5iAwcdpNhJDSJ67VHK1ubTbL/9PMK+
         e61eCud7B1dK+MmTSNY22IE2hj2vuMWWhpkIMajTHeoeI5K75VM17Y4BrNZH7Z8DDmLy
         3Hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794359278; x=1794964078;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8MFwGdApl0d4OiJqtJrDFLzpxo7TMPDirGuojCnnp6s=;
        b=27Yat8kJPJ9rceBskV0TBpUcPIc5PAE/kA6BceR7tPru5nBM0TFmcbYAZtkWDokDXc
         gcOP9DwsCMzU0xObTaCYIAmD0rDjBdKXNFJ6zgvYlXu2lk+2gGttYi784WioLVvOR5BM
         vjoOIve0cVQi3TsyAl42LSxNIbhut0iZrhCrjmWwV+c7DBnoTyYPqtNxAsnH/SiP/jx/
         KdvwFpxWHWjKPzyHH5MQ8oFdqVBGPZozm4W+597xnQ+EyuM3e2heQoLnMymhm7jUzTbj
         aPahlBIhj7ApVl2cg/GmGRKadSa9E1LhsNKr2tEVCvBD78hJu9gIOfdf1PRSD7o0wEtz
         sYVQ==
X-Forwarded-Encrypted: i=1; AL+hErHsrWc9B4DEoKGLgme9Yel2mJy5QkNmlyNSF+Cy56u+0PCD/ncpQyfiMlAQBJ5NSfZrAwv7jrI=@vger.kernel.org
X-Gm-Message-State: APuU4Z80CW8XeTk5ff3tWO8P4MGtt9g0NPMR9jnWnhYMvoLmHuNN7t+O
	wf95KZ7BWJtF5cEP4JbXkoEhRf04BnCr3OGfmkuLfKb2/C8QjhULP47d7JfDmEh/FWD3QU3Erzz
	c03VG+BwHTCkZKcQGN//HcYCJ7LU/ViwTHmmc/Puosw==
X-Gm-Gg: AYBFou3oBNvJ6KRyPu1duuKdm5PRi5wosunLRRjuLCTJjB0umrue2FR6x1cGBM3qDtC
	jHgMc/PiiiygEiU3g/p7rtkEeHzTSDQm8KMENqrr1LrBLKHFACcmujtPNXBNKyAd0OSTAMeqUMS
	rkYekIIUE1B0y08TcsOzxtJGUvYWvQbXhcmPgXdUuGa+Klqkv4XOtxTY6GacOTKSTtiCclruYG8
	/ToXGDdHsjU0ezfz8NByJTOXZtuGz0e5ivccQn69WDaHT/HDtroocN+LVlSJyxbijDAqKP47PRl
	1R2VpAq+kqI1A1qSQNTWjNoFOmphaHc9nJNInUKFO5NBwwNuUm8Bm97LzosmxUmc35KjD+kFh34
	5XEF4cpMN7Y0dHxzcbgCAQPay0HWAYmF0tCWyDsvEzeKTo9qI6KPaJL9X892of6JufGosGTaY4i
	X9JqZLUObAWQ==
X-Received: by 2002:a05:6820:16a9:b0:716:c04a:4771 with SMTP id
 006d021491bc7-71917858218mr598043eaf.24.1794359278033; Tue, 10 Nov 2026
 17:07:58 -0800 (PST)
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
In-Reply-To: <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Wed, 11 Nov 2026 01:07:46 +0000
X-Gm-Features: AclHuK9OIHzq1A_ViLb9jLKzo-flUIoCHThbTHbypb5m7BOmw6IeVMdp_ZFoAAw
Message-ID: <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
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

On 11/10, Stanislav Fomichev wrote:
> Awhile ago we discussed the alternative of adding setters for xdp
> metadata. Then the veth (or whoever turns xdp frame into an skb) can
> apply whatever metadata it needs (and there is some magic behind the
> scenes that takes it into account when creating an skb). That keeps
> the layout and most of the code outside of kernel. Have we considered
> that here?

Thanks for the reminder. Yes, we considered [1] and [2], and took
parts of them.

The alternative setter model in [1] requires a program on veth or
cpumap to call the setters for the RX metadata. We want to avoid that:

- On veth, an XDP program removes software GSO from the peer, limits
  its MTU, and can copy skbs from the peer.
- On cpumap, each entry would need a program only for this.

This series achieves the same with only the XDP program on the NIC,
which stores the values with kfuncs in the skb core extension area
after the xdp_frame. cpumap and veth take this area into account when
they create the skb, which is the "magic behind the scenes".

[1] https://lore.kernel.org/all/20250616145523.63bd2577@kernel.org/
[2] https://lore.kernel.org/all/aGvcb53APFXR8eJb@mini-arch/

Cheers,
Tianyi
