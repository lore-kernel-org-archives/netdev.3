Received: from mail-pj2-f25.google.com (mail-pj2-f25.google.com [74.125.227.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40C3BA25F
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260018; cv=none; b=DlAugzWVH+3xTTv0WqSII4QVNhFh2lGW+isyUEyu+qweXFCid9YajhqTtpw1/hBXqQm41HdTH9lJyYh7DwaR/Tp6ZGtxT6iUQy6SGsm9pSe+L/zM8AZrH1qIqb3bwhHWK9ryItAoGMU7qodwhItn7kLni4VvURct3yA3UVZAlq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260018; c=relaxed/simple;
	bh=uUj/7pfRqNTrc58rMcrNWZ1ddSBdy5zDMuW/FvBckfs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=k5X9z6Mdr5EXl1VkDjLQIN9IoPVThAtRNWu27M38GJLGgB7bXlIl0fsn5D/mXdfbRDV+uq+XJKX/Vo3nud5GlDwFQJQrOH3bqn2eZgJfGs18wOBZdT92+viHUXn8zTbxMZQh7Sf5FklL/CPxdOF/3DwzjVkYuX+CMidc1cx2z28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIolqGrs; arc=none smtp.client-ip=74.125.227.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIolqGrs"
Received: by mail-pj2-f25.google.com with SMTP id d9443c01a7336-2dd4b43b20bso10565955ad.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790260015; x=1790864815; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uUj/7pfRqNTrc58rMcrNWZ1ddSBdy5zDMuW/FvBckfs=;
        b=NIolqGrsxUle2ezYAMv9hMr6r1HrMFs7BaRBtC3ipYoY7HBgZ0dl5O3dyIuufCKcsc
         zDiAKTtnBYySb4q9KK2NaU+tKf+2aoTDaPDTxlUvefPLQtd6uElbnZUmXVdeFBUKbMhs
         +Nd449TBjWDf1/DGJnyiqSSKQ1Wxc4tfjvOLxFeY4F0e4fBP5Y2Z6IDmbGCqj1626eyF
         e7hzi6K2ygBncvU3KaZDfeOUxhpyNiDyOJRZo3/kpbL8OFquopqNJar6W4pTWc8ZM0cr
         svwj0gNkB7LKgPXMin00R/UekUFqEiX02pEoVAdZLD6h/Pby7sgcCoQq5na0KZDl6ots
         ktZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790260015; x=1790864815;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uUj/7pfRqNTrc58rMcrNWZ1ddSBdy5zDMuW/FvBckfs=;
        b=JL7ccL4jAoVMLOVbwtxM5I9zbFBfFD42gUXpqDCvDNpg4Y9wB+3rGAxzEd/FWuZmjc
         nqwCesMgWIGL4nFCM71gGKcEi00MpfLyWi5+rv0WvEf8fLdlNBlxPyXfjUgikidSh67W
         fmTFotGNT7bOaBW2drvzvWCStUyuojmOrfGh+rsWgB9cPuuFBKQs0EvHMC7R1gJ4UYFj
         6DLntqeWx/vTqVL2yTIEujb5ZMfDxsg9A3r3qK2bN0wMyNBLOWyaccKzQiYeYGBqOcdl
         oCN65Z+NE+mwn89SrVy8YtBzChpJyVoAteVGt3BXc6R+g/2Al2MQSFaMVAzM/HSjKtt3
         g+JA==
X-Forwarded-Encrypted: i=1; AKwUvBxk6z6gdOqYd49lyj0Tw43RBvA0ZtYCZC0ZbrHpXqwNfPX/+7rHA0RpOc6PZEZyTbfNi7I2IPc=@vger.kernel.org
X-Gm-Message-State: AFuF++mUbwIdLwtDRj4Wz9xtxYFKrMuXHSSoJ5IkH6LHot99Y4zfTt3S
	ICqUlNBNPxn2kbf8TwR6K+dUYwy+K21Piy8iK81Tt6ltOBZsmWAF+Nvu
X-Gm-Gg: AYBFou3WvYG/1BCr7wM9TTOtVXygM39ULSeOVSWy5dKiZi80yeSWYCTsRpQcVq656ee
	Xxcd6TnUY0XOrddxSXGCMgg9YhbkQPaMMtn2teXYhASL+jfEr4NNMWfaatbS2WA+6coG/yh8p/R
	cY/imEm6H4ViuZcAwP724VtaFomcT0tMX9IK+wKPPO5yyVAqtMXO2el4yyLr+qZAwxgpLp8hp0Z
	igMAbqTQHR5OoM8Fh7by68Ids+3D9eaq3mDOMc7/nNeadm8RzqOXhKV/FfvO8ewoLLF0UrJ1Klc
	btpQL30PoL4+jDF4U4s0AS+/W2NVpBu9wUmcv7/pldf9fVVUBJM8I1DY4g0subNgQo5ObwaZYwX
	bxfvKJCJGfKZPsgDPvjS8CVLRjPOnNdWDSN8XcYUF1JzHHpcqTXC/qIreA7Jni0Eq0xFfoAR165
	HsiyJMySNb3x4YagUObxAd8O87WaQkicARrgfHAzzYXBqVWVM1LVA4uGuLehSS3vPcxsc12qEdz
	6VzB6El2IwjH2kbd7ukqKbH0qFWx/IaxsS/JsWANrGJRn8IRckfwxULDq/T45cHuXt7Vebgu69p
	Bmg=
X-Received: by 2002:a17:903:1447:b0:2dd:ad74:ac35 with SMTP id d9443c01a7336-2df7e11ca4emr22565155ad.30.1790260014607;
        Thu, 24 Sep 2026 07:26:54 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a517069sm28507785ad.3.2026.09.24.07.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 07:26:53 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 14:26:52 +0000
Message-Id: <DLNM7JR51QLJ.13Z4D921BZOJD@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf: cpumap: fix use-after-free of dev_rx on
 netdev unregister
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20260924081828.26575-1-jiayuan.chen@linux.dev>
References: <20260924081828.26575-1-jiayuan.chen@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 04:18 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> The notifier has to ask every entry, a cpumap entry is not tied to a
> netns and any device can feed it. So an unregister anywhere drains
> every ring in the system, once per device, with RTNL held. That is
> bounded: qsize is capped at 16384, each entry consumes at most one
> ring plus a GRO flush, and the kthreads do it in parallel. Those
> frames had to be consumed anyway. Nothing changes on the hot path,
> the kthread reads one field per batch.

The code is the same as in v2. Only the commit log changed.

The number of frames is bounded. The time is not.
wait_event() has no timeout and sleeps with rtnl held until
every cpumap kthread in the system gets cpu, including the ones
with an empty ring.
flush_all_backlogs() had the same problem. See
commit 2de79ee27fdb ("net: try to avoid unneeded backlog flush").
The bug needs a kthread that doesn't get cpu during unregister.
With this patch such kthread blocks unregister of every netdev
in every netns while rtnl is held.

pw-bot: cr
