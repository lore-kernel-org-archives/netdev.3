Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794325556;
	b=c6iUzZktdjjOQvwDzNxfVSp4eStLEoQeQ0u+swQ+wy51dpDqPLE0ELz7I9DnSSySeM+u
	 EYVFaqSzHoZXh41Kz3x2sP95hmPHcd8vBa+LhnaIqU8Wagc8D/lG/q2qTDpT5YdHq4ST9
	 YlVCjS6C9/E2vGm/DiSels5H6zU60PnE1oyRhFwR4rmpoUUS++AVbqcV3vr4lXMvoFQuu
	 Mb3HGxwQH9jboPVI6Rb3v5wFcJh66Grmgic5Jl+fu8xIyC0YzAuYWPpXKtINEhX/pf46W
	 CdSh+dDLVCpmRhjvrgxJfaeYCLPwqqafUefsOwEir3O5QgmLyHTuNDYdiz397bUZ0Jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=4joyfckgOzoxD1v9F8y539Lxr07wRquNtozOKKoNpYs=;
	b=aI/8W7h2fQ3Z9i5RJj8A0UEW3zBMJrG3k/01Q/BDfW2J8c5BY39fKyYdCwK790D+/asJ
	 BmakSt2YTwSkvcvbdWnansds2Sg+mPp+RfAh9BMkraE3UtulsI4x4Dkw+S/sPizQggval
	 l3ErvZmKtvG5g2oQEClbt/aB1a/3Tq20hf1oS3rIXIJ5EYjXwi38jdfszUvLW9HUmbhFY
	 QPE9gDNefhK4hJCOSQx9wDFMrEf78z9xacW06Me8U+vluliZ1+ytEBLvXs/KbBIUouuJ7
	 MBHV8BMViCrN+JhC1IKDxOFT3PIUWHyeVgDvmqGBQzUMhuySTNHM6CQ2zRhyhZuyaLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=eZLW2NkF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43727606AB5A
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43727606AB5A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=eZLW2NkF
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-702dedeb70dso1098740eaf.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:45:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794325555; cv=none;
        d=google.com; s=arc-20260327;
        b=JlogVZBe+e02zRq5+dIvL+8yhAjfcT3/VzWRnmBW1+NggA/A5tRHQvydDlxz88Oiv5
         ioPiIc4Y0lW26RZP+xCPMCTWFWI2eAlJhJ9xs81KV4G6LJL9W+C/QebNMp11d8gWRIB0
         3jUM6C78gasrNSE0ohVutG+GcQTUtvbxF23wFzV85eKWJpEtgWBQM2Lu7uqc0AtfmId5
         7w7Ri3dAedp5YICh399I2MwRfEXTfDa+OavlCLZhd/vAbXoka1wQXUiwrH+nFZXb2dmS
         TdxTWlweGDkFNA7qfDArKwlCuREHvQHHDEgVKrN0sOb2/GLSkE3QfP4uBPRrSSXXPKpb
         +fYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4joyfckgOzoxD1v9F8y539Lxr07wRquNtozOKKoNpYs=;
        fh=kgG3Zm4cZX30qry6Z82k9tt/zss5tzUTrb4wpwvs6Ew=;
        b=FZme1rXC1qWOgyeu2xV+oNn90w7T7C/RL3+z4T/x36uFfx73TC/jEYH83OdZWA7dL9
         7K4JY/9uxqoYJRWo6npt9t0ud84FoARTdZY5g3B2thnICqhrRg5gM1zMARRcSVHnapk2
         Q5KwLa8rpa1wz/n47UA7zvkwyrAnDhleF0hQ18EYPH5OgmZ3vOEDnM198cwtizai3jwz
         QmiHAWaa1rP1iA03QsmglKspyfSuOD//SEZetnrVN8jLU1aidSXc890+ZFUnw0Pi52PB
         QEo/vgS8eRhya5giuhhWbW4JDZCm5hFqPezzojyRGNH4Ipri35uFc6QN4aj9MgUqHK8a
         8i+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794325555; x=1794930355; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4joyfckgOzoxD1v9F8y539Lxr07wRquNtozOKKoNpYs=;
        b=eZLW2NkFr/j9icFxNcvCAM88kGStK/E6aBuXF8X9PTB/TJstGOhvTD+oxnr2K/CFip
         LcDYPep9GKsBbabgbijJK8fW8Ri7k+AQgTpbE0lfmYbq++4uEecMHCP8cJy+ASy5Fn1C
         Z7cmYFLcw+cxPvYec6ZFIcz9h0hx9GUCZQNC8nte43cm5qiHbXRbnTNHTBl1+VeMbkIY
         uqoY4pDGStIpFAnESbzX/o6nCQkRdYtqB95sCYlkXriJV8MXiOEX4NtIJW6wkeAwE2IJ
         9SnQ/rTMEtIWDIXK5bSkmaqWrqOPx8mk6cdC7zj82UixmIlP+udjnEbIS9a3pHbUWS7o
         nsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794325555; x=1794930355;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4joyfckgOzoxD1v9F8y539Lxr07wRquNtozOKKoNpYs=;
        b=Df7/QjTv5IaHM4fLajHddRAWvJNhWK/6AoTetnndYqdOmfgRR3p1gDX/y/xJEtU9RO
         DijcoROGnQogz+Ux2JP3Mv5V7x5cwQOXiWk/OsXeWdawrN8X3Da0/U054n1ONQ8Zgnnn
         GpiMqDUJ7S5lJMv3uFA4JWXuGLqSutTgPr6BrSE+4efHmLOT/9crpb/U+GD5hMJ1Myfi
         4rR4qontBM7YM+eEHobkkSlwEHwz68PwpCqiB2Ef+UPGFZtPoxkD3rsfZr+hYM5LLWIW
         pIVVSnFPhgdjt8xibeNy9IgNAGe59pI/guAfmMbyd0U85I6MU1cAsfb7VYNZ770Lbwmj
         lD8Q==
X-Gm-Message-State: APuU4Z+YWN3lolaUtqb97v8Hnp3ZRgonY7e/ICMyi/i1xYfjOxssNTqW
	lMf+/Ypogjzt0jrpaGkld4eWeyowniVc1ko3BR1Ta1hx1JsYTFNJl8VyzG9S01Pf9wKxeBuoY+O
	ZLZNWNhDf3Q4D1f4wrU+329c0cQmCr9xh3Cdh/cm0gA==
X-Gm-Gg: AYBFou1kQDgWOL0hAV17KuqswvnX9H+/27Y5FR5/1f8Ykdiw+96ewOEdD4mCdsgoeG7
	f1r8SoRktxpbuy2gda1Nt38+RONUVSniz328xsWnlRKrlNapENk1cQcUsWM7FvMwSzppYqGUC4c
	SpaepYDk19zkAa1O7rHtlVHGh9wyWtU8EW/4Ffe/uqm5fHWtmQcr/EoFqKE+eB/wPh1wjJ6rzIT
	1daPXPG7Q5QRFyZ2U7ckDcBm9OSxIEK/4LcOcfTpfDNBIwdJoEwMtIKbkWyu4j+lw3cEZIaaSbj
	OCyKXb8zU/i+9pocunmmPkMXxcqeDrZUg1Z5plE8gkldRjOQyv1N0vGQGwK1vr/NA3ft1+G5yQ+
	jqA8ixShdNP1E4oXxmNZ6KyTeBwNQ/k1fGTH0TWWaKVv2TLGvWm8QITVZE62jUWMhEsvXrMlJ9F
	bSF9i0ktLqfQ==
X-Received: by 2002:a05:6820:c2c9:10b0:716:ddaa:40eb with SMTP id
 006d021491bc7-718a4f92ba9mr1015097eaf.28.1794325554928; Tue, 10 Nov 2026
 07:45:54 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794020868.git.tianyi@cloudflare.com> <73b9d23a4190cdd02e89d3a2ce8a1a21ad5feadb.1794020868.git.tianyi@cloudflare.com>
 <20261110073807.2fa62e6c@kernel.org>
In-Reply-To: <20261110073807.2fa62e6c@kernel.org>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Tue, 10 Nov 2026 15:45:44 +0000
X-Gm-Features: AclHuK9D14tZ4FX3CoGnuGmDbJMM4Y36vINL_kHffGczXiZfZcX98tAF2DEPmTU
Message-ID: <CAG4wq-fJfKAiCY2Z0Hv_nCBM+8gKSBq-N2Xc2KfKREkRL-VDvg@mail.gmail.com>
Subject: Re: [PATCH net-next 8/8] selftests: net: tx_extra_headroom: test veth
 peer at creation
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, David Keogh <dkeogh@amazon.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	David Woodhouse <dwmw2@infradead.org>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Nimrod Oren <noren@nvidia.com>, Alasdair McWilliam <alasdair@mcwilliam.dev>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Breno Leitao <leitao@debian.org>, 
	=?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>, 
	Danielle Ratson <danieller@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, bpf@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@cloudflare.com, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Tue, 10 Nov 2026 07:38:07 -0800, Jakub Kicinski wrote:
> Please use Python YNL directly, we don't want the dependency on iproute2

Thank you for the comment. I will use Python YNL for v2, with no
dependency on iproute2.

Cheers,
Tianyi
