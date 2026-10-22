Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792683717;
	b=oIQNcSZP2tCf5Yfz7LZzB1YCXhWZpGdkR993DdKKVu6D61V44Q+UxO5Cr+XNMyTFJRwO
	 Ruxk30v/M0C1Iq0OJY7rIKUhqaFGSxVVdW4Sj12o5bGbLRetwzx7oQndflMTxfiS03YOb
	 ccBI6QOyMmE+7m7O/oTI7DfPxxwOQiGnOQInkVBpi8nEGkCRRoAkaACTBtz6Mwuc+qCWX
	 bfcl84g9GPSZiLZMyvcqfy9RCeihPcm0vTjUNDXoHjhsalKvyRkd5h/7vF9GW0n9FJpxq
	 wNi18W/z7TfwGhH2QLYaJYUkBFh5I/NrSQtw0e5+Aizq9gkHpA31/dvkI/IBiZwoCIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zA/mm9rb6v0PXkga2C3gcDW9NUOTKUUtrwcsHol3f4A=;
	b=WuLTBgIhVBFkUWd3wJkQfd7FN8p+NnlNw4Msf6FGmqYHXUJ7qZ03qxLtprYeMfGTB9HC
	 +1OiCllrBYnI2sWyczlR1c/Im4x991KZUGXYH6taAnCUkbf+BxAYA8nGPWYjNiwCf1GP3
	 w6UmCJXYvHbNAb5vpjUrq79/rMkyzG/cqqkh6nobUOxY7BsPxNhT+w6m0FOjL1H1vEwBD
	 yFmKSAJICtKbU5o6UwydqDJ/txfEsFqxpzQ1pzlf4d4aRjzZ6hvb3BkUb+GhrQRH7VovJ
	 +PXzMvDQXfMNAzYA0B2Z9CsN0P9Rqy+ES4/rPDkvZAT/EYsj7DbEFjfi0N5L+3SYJ/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZE7yvOJA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2732F606A325
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2732F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZE7yvOJA
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so14893a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792683715; cv=none;
        d=google.com; s=arc-20260327;
        b=UQ68Nh6NRhAM5oiXHX6NijyGoZS9oUoZ8DID7q+jx8tHj64ypRXE/M3aNmjsFDK9bq
         i8F7x2VoKhL8TG5Ha3QjW8A1bUjtXFQ1MUJAd7WZcRrfc4Q7ZKbXs9UuvuXUBkolmIK3
         QSw9Q1qaXkuXc22AHbbDvIqUiAjStwEN6Vpt37UkAmy2TUF1wYNn3K+LHfSFI+5pwzI8
         33mpyf7PM5pNqzOu8hdWH5cVk62Z2ldLVgS3i2ETBxGVV6eZD4bYya4+ryVrdxQd6ssl
         JazB6no9Sv/bkMcN3UM//+Mlp/ZQYI4leR2GsZOBg4RdRQjuDoBV2vmE9SVOXlMyn9Ky
         OVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zA/mm9rb6v0PXkga2C3gcDW9NUOTKUUtrwcsHol3f4A=;
        fh=rLpC2szsJsKYvjGe0S99LDrTxEq8SuKcPrfnIcB5MVs=;
        b=JB3e18WC5HoDqpGcCjpdLdu3ILkcbY83IEVTt9ieidoibz8Dpx5vtdSH71ZS84v6Wm
         UNwmDtnz8KL7qDb0a5/Cncd5u0Jf4KovIU+kVyG7gO1gp0tUbxzy80nmCQuga1R6BuIQ
         jCQ8rT1OOAgLTE2Cn/OMMT+HPm0PyLbo1qugIQSxEJuSl4YjOQwK8zbHPPV+S+ds+6ta
         T7IiEuCVXuxwVbxev5ySCXLUYHy75lWVxJJLSlwalU8fz/NIw79XETq/pDYZ9ZyBuyqv
         Y+gySVR3SguSAad/7fx+QHhV+ytUgRej3RgbqqHBUW4RyQ2dEOwexO2Zrbp9ncnCjC/L
         p0+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792683715; x=1793288515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zA/mm9rb6v0PXkga2C3gcDW9NUOTKUUtrwcsHol3f4A=;
        b=ZE7yvOJAXvirByTnY1Vkt27fJmKkbeM5kXZgy9I6V8zc3FR5ZUPfim62uiMjPuAUOE
         6SPRwRldc/SKrFbkdXf4hRf1/c3O03pzePfvS0r71ba+enBaOiJAbZPPhMOVNCWBHZ/3
         4tVMMjYEO5ZMp0D2z+Ije+fZYXBCho9JUorRY966hydJ1JMEmhe1Q61r8qlwZrET6WFD
         +Vf85mxjx/J3HPmeM6cqVMjUUHo/y5qg8EXcl++6krOhRkzZ7rzWYua95XHaGKgRYIU5
         tGft8vrtYkKSv7UR7+/AfReVLt6gzEKNR/8xFbF0uvf+i2HNlZavauOVkq5m0veX/JjR
         FWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792683715; x=1793288515;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zA/mm9rb6v0PXkga2C3gcDW9NUOTKUUtrwcsHol3f4A=;
        b=d0ZsLXfHVnyFaqPkD7mt6W9AVs53rh4ZX1aOmbascYL/EXZ/1NgxmUde7xPzE8ni/h
         CCCTak5802aHp+VdIl/vtRMMeknZ8o3O7FuxsTjjSQL1hE6ZznfQ5qwa7X8LKv7czVZq
         uO+HopmlQk9GA+2IlbBHiFgKrAaMZgtC3lo48EspuVESGZAszUlUGeg8oG7pgIgz0z5i
         baJX5fDhL4YrBO1J9zUSufB5DbuCxnyv0BNr9cttSvczDEPGCROnV+hnFDLfhUbh7joi
         MLp+ewr9f5XHRi1UJPO8rK4SPZ6sybnkC6BxJqwNobKBBNPrpDdoseAmb5iBWtIsCk2q
         WArA==
X-Forwarded-Encrypted: i=1; AKwUvBwydVDurOhm+y1C8Z+RD9MbLg0txsbOhR4AxpDqEcc3xbMoJbf6ea9xwZXcIZKFEM77wVhMoZA=@vger.kernel.org
X-Gm-Message-State: AFq9FYII5gUEgtftFex+Ejmpogn8qWsXb3P8lUbuGnbT1h/v1YC3RasE
	kIwD18XSZeEvgwF1/QJqZOAPp0TlJrp/Y4h02RJw/MaFYMLdea7Our67wrewax21yxRxfViHujJ
	zFjcoGs9H+uad/YEgtRtc/yN/T6spCh5t49xiXASk
X-Gm-Gg: AYBFou3vNHrZ1xWqUm9/n9B7FSrxtqhj6WAeA/Sog+LQltmM6GeQNNv+w4Mdzhzchey
	ApqDNiCBCLnzn5Voe6d1jKaCSa9RihnjdlSiqZF7Q8YKVzz+iAO/osm1g8UUv/ovjeSyNOgNkHZ
	7Zqk5wufAh2K1+gEBVpVOeQeNcQ2EPnkGU8uyTYnc1bOfuu0Ckp91CmXd5eGFGEGgaEDY4eYxBL
	+qxAVPlI850mXtsvbqeketCHXeTuLd9L1pQmqtGxCqxXxEwJDKXLMDIoSTHMdZY01knCTjUoHyH
	6pU+rCH7htHL4pdIciWwBQ7TLG/Q++xq5vp2ZGVlpZLax/G5T4ZXPmH9Sk5BfLPGEmOvi1LSHLJ
	ScDmsBTzkRJF2cy2AxnOw5vP1lQs5VIC3hFYbQkMksg2/94UdVcT02+M4EEbfnGohb+d4ACOCqv
	tsHkTiwYbH1Dp86w==
X-Received: by 2002:a05:6402:8d8:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6b42037090amr51165a12.15.1792683714889; Thu, 22 Oct 2026
 08:41:54 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-4-almasrymina@google.com> <20261020121858.3b9107c5@kernel.org>
 <CAHS8izPwWT+vbgAe49m5vXsRxT3unbfjLTkVZBScgAPdQTo2dQ@mail.gmail.com> <20261021132304.23e0a4e7@kernel.org>
In-Reply-To: <20261021132304.23e0a4e7@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 22 Oct 2026 08:41:43 -0700
X-Gm-Features: AclHuK8XnKCgw_zM2po_QzMrph49LXNIEmHOTKG5LdhHg2Whq1BLNJdt4N18LfA
Message-ID: <CAHS8izN_N25mm9vALax+P+W45gyxVoMbZoTXW3r6nPC2Z0A7JQ@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] netdevsim: support devmem RX and TX bindings
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Stanislav Fomichev <sdf@fomichev.me>, Taehee Yoo <ap420073@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>, 
	Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 1:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 20 Oct 2026 23:17:34 -0700 Mina Almasry wrote:
> > But on the other hand the test coverage is nice, and maybe one day if
> > we add enough devmem support in netdevsim we'll be able to fuzz the
> > data path or something. Is there a way to get the best of both worlds?
> > Like put a comment on top of netdevsim that this is test simulator
> > device and any missing functionality and/or bugs in it should be
> > medium criticality max or something? Or is it too much trouble and I
> > should drop the netdevsim support and tests?
>
> I already strip Fixes tags and apply the patches to net-next.
> But it's still a burden. If you're signing up to fix the issues /
> review the slop we can try.

I'm more than happy to help but I'm not sure what you have
specifically in mind. What I was going to do is put a comment/readme
in drivers/net/netdevsim with a note to sashiko and LLMs, "this is a
netdev simulator, used for testing; do not call out missing or
incomplete functionality as bugs." And then hope that the LLMs and
sashiko pick the directive. If not, I can tell patch submitters to
ignore sashiko code review bug findings in netdevsim. Is that
sufficient, or do you need something else from me?

And we can always revert the added devmem supprot in netdev sim if it
becomes an issue.

--=20
Thanks,
Mina
