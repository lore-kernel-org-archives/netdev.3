Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1A3955CC
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337771; cv=none; b=dLM3Gt/0htK5e65WVUOOiMNnKiwy/r+LqSyOjSSL6i32p1x+iQbOMwyrye+nLmueV+dOilenRYfMW7Mx9vW0VZRsyHsq9ix3DDgErU/FDd5XZz3m8EB5/wntpgG3Ta8h9FAj9PjzEUobiUFshXFlKtKVgdFflAYfGER2v/qCYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337771; c=relaxed/simple;
	bh=waGPtSzpE3lIXbhGjF91+oeOVlgMsJXlHWJmCr+kn20=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=msO7mYVgFeNEbOqU2M3FaqRbWa3RhZOBOsjyf8lfEspA+YDE0Zwt/BKlZe/vQTm7QitjtZ1WGYObPhW/oRXpp5j/xfdiFwTZjK8thqdoJxyzmX/c6YvnMcPGGhfxLKXGCqkFNAfd4Of+gzxdOV0JCZn6otaoZf0Tm5wC6BtEWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRyTK6Lp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRyTK6Lp"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so412520a12.3
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 08:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792337769; x=1792942569; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ikyHv0vTUgy0Xo2LWvfxOo1dUQuPKaqw0/RogLyXK/U=;
        b=FRyTK6Lp4t+55uA5y7cIlzu3qZQyU4gfkI6NhAWhpXgHbI3Quvys33pnGU439QrYUO
         nCLub49d5RDGVkPn7+Wl+g7kA2avadD1QfKrW8bB6/9ILSbcpv93oITPovLvhWDhpaWT
         zdFrRM8cCIVkoLcc0yDnvOSNhR+FO0keW8tcinnWNM/aMaTHetur4siTLO5kvSX17byw
         cBL7/DBy5KiG7sh5o8XWbuRVWdduFJ2G25wN1vtVQ6bxegBSnTpvuEG94Rf5OEDQK8DE
         mbpvJg5lfvghsYQdL25I1zi69TS9Qj5soJLrNpeGd9Bc3I1sOdtFjrwGvephnpRdObYl
         D7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792337769; x=1792942569;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikyHv0vTUgy0Xo2LWvfxOo1dUQuPKaqw0/RogLyXK/U=;
        b=Wt4gmspVjBnig/e91Z+FofGnfe84WXDsCUIGI9LTZJoYjUBNIqPS8DFwi/vcTz/lgd
         sC/i9/jV0D6Js2Tamnx4dfTuo26wC3LmoDjSPQRF2Tol3GamVTM5vU8m5cJyjXVx5Zge
         7bdVglSYzyolhexzwpxhu+IltNC0qC2lIJbIJAmB3EwCzmaV/KNwxP5NK1uhuRINet0B
         LL2C8IH3la7My9niBB5MuxwMD2AWX+exLwQcsKGfZg7cuuJwMjCXSwnmqmzFOU5Q5DVp
         yBjjljBt2dV3vlLH521wxoXWLpdgWhbnLD/vkc7D3dd0XPCLaq70lUv8xtwChFJ0AaSO
         W7aA==
X-Forwarded-Encrypted: i=1; AKwUvBwM14bexpWkEY4fpdgf03EmWs31ZJgvGMNXTDhhIue2ddIvFXWLtK400FKyf+0v/bTWQmuPuPU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPMrCBDnavqrXME8xale9ORUqwMA4e5IaSTFA1sqOzuCQH0uMW
	Bgu0YACH4fHZBoqf7JK+8PD1/0OLQ44pKbNX4NuPI6VOetoCLAfO+eeX
X-Gm-Gg: AYBFou0DE9ABQ2MZVhcmSzLP8pf+uZ7bq5sIwUt4mAaknPI7EiGwoYKLHXOgTiIILQh
	ON6TeTTItmrSg4ronIzWNzuo2N1nBY8xw/dDNhz/qlp68TeYF3ft4u/gdoTaxniUcZgoXBEL4A6
	knwlaX/PlstmltLxaFiD9Ak+L+iYDc1oJuGga8WQSMsvATgWaBQx4s/Rw6I4EkEiC+3WTpFF/1+
	089iS+9W7tse/mVSCm/Nqh3+AJP6WMOCjBg7LJhWP3zOFJuo0MGCRGI4a2xbSP1i3mexaxR+JmR
	hJXndkoY9uRK0uxwsbtUyBlETuuZ8wD0YHKo4xiQjAZ5MM8rKp2gGP8xtfTIhhkulQTfOOLUzrI
	82XPTUGy4VKOjoZkQGzOo43iVX6AQuR9RT+xPIyOX8LH+OtEUqCO3OMq6a/yVIQWGS43xEf/pB2
	W/pHnG7t7issn6UA5qIPsWQUUJE/iUl8TvaaJi9WRL8R4F3k8WzFe6Vr1ZsMITECVU8o62zxrw0
	eZ9AehJHG1AyO1vAaDWtnacd5k1izM2oVwwO0fQEa1HiZHyT7YVM9tbVMvq6cbborwCZWTwDnct
	pVQ=
X-Received: by 2002:a05:6a20:a103:b0:3e1:e481:747b with SMTP id adf61e73a8af0-3e22626fb46mr3823122637.24.1792337769231;
        Sun, 18 Oct 2026 08:36:09 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57e220bbsm3069177b3a.43.2026.10.18.08.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 08:36:08 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Oct 2026 15:36:07 +0000
Message-Id: <DM82PN9SLID5.ZJSU0JDPQAA6@gmail.com>
To: "Ren Wei" <weir@nebusec.ai>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <john.fastabend@gmail.com>,
 <davem@davemloft.net>, <kuba@kernel.org>, <hawk@kernel.org>,
 <sdf@fomichev.me>, <drosen@google.com>, <ameryhung@gmail.com>,
 <xyx2021@mail.ustc.edu.cn>, <chenyy23@mails.tsinghua.edu.cn>,
 <vega@nebusec.ai>, <rakukuip@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Reject packet dynptr slices in
 mutating helpers and subprograms
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <cover.1792222148.git.rakukuip@gmail.com>
References: <cover.1792222148.git.rakukuip@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 17, 2026 at 10:44 PM Ren Wei <weir@nebusec.ai> wrote:
> This series resolves the problem across mutating helpers and subprograms:

Not anymore. This doesn't apply to bpf-next, because it was fixed there
a few hours before you sent v2:

  a6f8a67c13dd ("bpf: Refuse packet slices for packet-changing helpers")
  19e6ca6b4a22 ("bpf: Drop packet pointers behind kfuncs writing an skb")
  589998616e0f ("bpf: Let bpf_dynptr_write() mark a global function")
  b7f97db88948 ("bpf: Don't take a dynptr argument for a local dynptr")
  1c19f2b3b2f3 ("bpf: Follow the head if an skb is written from a slice")

check_func_arg() rejects the PoC with "function access to the packet is
not allowed".

pw-bot: cr
