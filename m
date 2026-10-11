Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339D312831
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791733891; cv=pass; b=c3Co3zkb71ZIg1yWvuNStzcImkGKlexz57o1PWAcRIO/G3DNmcggHWmtStJ2N+CocYJsCUpQtLTBLhgSN17ma+N53vIphI6qGzbP91OICvH1TaZNKz/j9UNfYphHLmWRT8E9daMgUk4Xche0o2tbUrjebmRnSpiPEjEw10Bhkpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791733891; c=relaxed/simple;
	bh=IV3UF1ZbgbEHaaPEvCc2BzMnZwlILj8XNq4mL7GXZtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/rHDe1TS1V/BvO1rhsKmM/EcHdUlvQD6Wp42kFPwHS730gR1TdrbhRECOJd0hiUkINWmM/CWNSsAq6i16ED5VGmPSuB4WGpqFz2J8bqR05MT6z4LmtkmmpvMYMDcvGR0LMJQdicEzcxuZqDbKViqNGvDVVv/Q7eyX0W3s4Pie0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhlTg/q1; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhlTg/q1"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-144e1b6d52cso2870c88.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 08:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791733889; cv=none;
        d=google.com; s=arc-20260327;
        b=F4X2eD4lloc2g4/nr0UzZu4WC4zBgBh9HagUJQGB8MAR/0fhvpK6F8GSishwuUu51L
         M9sL3CIfn+2tZT+yHxchNO3HOWHeyPHiqqmKKT8SY5Qd1kTFuF6XO4m7BicFimapUMfC
         Sn+lmzHZYl0nMMLVZt9XpQNGoua2nOhu+ZHq2nlWOtN3o2+ZfyyGScfY0x++9eK1wmft
         TJL8H7fB386wyuPbTSTgTa6HVPbc0IrWOjSJWbbw2TOf/2V//E4CSWlGXiv2GYzm6skV
         +VrvX5jMtfi0etLnodcn6NyOeNW8gaYLmU1PwlUv+oLfZ54rTNcIShBrjkCJyjotntiM
         Apyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PARpiAioxVcNkPOHU3+6w0RqdWPgrhBEQsd+ZWP6NEs=;
        fh=LsPpz5m4rJ/smk5Ch8eeUl/MMicLh6g/tYIWwW2Qrjg=;
        b=g4k0ElBkj+7BwhKug1rfsi/BHEVCx6QJNGtHTwJH8anyuSas8Uw02UfJlUck+ykbMr
         kVxGF15xXV65JxgTGuuNq4DARNCcRdbPOb7EcPk9mngarI69dAFs8U23XkB/wDLLk99d
         qU/QtRBpgVCTq2T9WxdoY7qLGiICs4VFNJEm85SsjgWHxB4iLAouzGU6qtHXQiBOjJky
         QUWY1/TpdBW0mcUtgLoo2HD/MUfDwIHQUAtdnQUL6uaKFPgeyyqp7ZQowXNERhWBIMs9
         Mr4ff+v6xH5spNedwpY9eBf/Jc2cTqNdOkXThSX2CHXpK1DJ8w0IQu1CK0hjJJk3JZl+
         iI8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791733889; x=1792338689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PARpiAioxVcNkPOHU3+6w0RqdWPgrhBEQsd+ZWP6NEs=;
        b=EhlTg/q1JI8aymjKR6w5G8AsCiAK462hNBGQEStU9+bv8njp/0Vjl9cY74RmLQ7eIs
         2zPLm+9r7RnXfMSMi9cZJE7V/i01PiJ+UUWl3THnXs9MgeAevQbrTdto7l3smmL+d2pN
         CbmQVWLR3im2KSzIb6YID0GGIa2J3SiN96vHWrr3eH9uIoG6Q7TesSlm4h61HWZ/46ZE
         BZlaECHRHFSGe2jQZ8Ox0au6B24Vjwhx9852w8hHfydnD4P2ndvEdKVOcH7OgpbXDgH0
         HtakzC/K7ZUlVXkdWoeHLG3/83WjWFShF8utZ0lE3w62m4KxkkzZGt8O8WRpLVqyNkPX
         fUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791733889; x=1792338689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PARpiAioxVcNkPOHU3+6w0RqdWPgrhBEQsd+ZWP6NEs=;
        b=biWSt4qEzQfhfHcQKa5YqDitnr9i4s9VvZYIXrmxuCuGW3VLeFWo0viy+nUV2MqL03
         gTXqhwy62JR++hvulYPMQytwHBDsogNmGj73YUZH1MVHkTi0jlg09vEeuG+DAlqn08wk
         g+DwR46z1deNpDWBICplE0Qk4evf+wFutDVpwDUMqjs/7GZ9aqTpt/OW5G6t61VCNEl2
         WJspAexoS91i2C8Gj/ot5FPeEK5Zgb818ZevetFwfCH5ZMD/k5lhrmdEcg0pPkP8wJsA
         rocSesPOWny8vyNjjrvwfJflbz/7q5Q58sLHTplZFYVWkNOSNMcpUV1Bd9f3YT7+2ta8
         A9BQ==
X-Forwarded-Encrypted: i=1; AKwUvByqYuV5Ds2POkhC+euhTEzAfr9M+cTza+cAEbY9TsK3DFf9YKeQUeVmb5xERVSYchqiKBx/dvY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcrlH8fxNLDYbwpaRQZYeMdOZCy/UWpe6XCuAfC2xwqs7G64xF
	/d9yxbUIzS+LHYU/jtwFl3anwWMkMShEQYKOeaf4P9xcYm0QoQmYiyU5hPmVqo73R6mMk+qObER
	XsOXPaDFOksHAuDLktIf/GyPrdACXniRJ7hmwm0Ia
X-Gm-Gg: AYBFou2c9IEtZwxTibznt7MKKhE3Dzb2PDhGZR4tUJyoIu60l5ypgH8XUrDMX5lYHZp
	HILH3Egp1aaHRJV9XAqzCUR4UWqBguGD11+xY3RK6dgGZxBu5J6R6JCDZ4elQ2RM6B5zTqsD3xF
	BGt1fLK76xtl8pEOZY5so3DNNUjRXlemUUMpzUPlQyKSrBXmy8zrQ5/ATvk30zkJ0yvNSmQioc9
	6bTX8z0XBq38n+KiZ8PNw/hv5epHc+DV4vzHRv3F93xxmW9qAqWGIFrRD81kuBnhwSvxtYDlwAw
	yrBF9JSDaVRsRUkRgrfdQd4L2Muj8uTcykoZUDeLeqBfpOyK1+s/yg==
X-Received: by 2002:a05:701b:2506:b0:146:85b9:974c with SMTP id
 a92af1059eb24-16e81b7bcb1mr124139c88.18.1791733888132; Sun, 11 Oct 2026
 08:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010025532.839559-2-almasrymina@google.com> <179168989611.434549.16378879758158058625@kernel.org>
In-Reply-To: <179168989611.434549.16378879758158058625@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Oct 2026 08:51:12 -0700
X-Gm-Features: AclHuK930gGDDJHBRZhLwx30RqRng6RPlhHFuLPE0htp8kvWdbnGSu8mFAUgs1o
Message-ID: <CAHS8izNWaWF5-Zo=rqaUzC3joNkwoYnrxawUUVn73BJEaPSGFg@mail.gmail.com>
Subject: Re: [PATCH net v1 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: netdev-bot+sashiko@kernel.org
Cc: kuba@kernel.org, dw@davidwei.uk, asml.silence@gmail.com, 
	ap420073@gmail.com, sdf@fomichev.me, pabeni@redhat.com, kaiyuanz@google.com, 
	bobbyeshleman@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, horms@kernel.org, shuah@kernel.org, 
	sumit.semwal@linaro.org, christian.koenig@amd.com, daniel@iogearbox.net, 
	razor@blackwall.org, tariqt@nvidia.com, kaifengw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 8:38=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 2 =C2=B7 Medium: 0 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] Incomplete fix: a binding that has already been unbound (netlink
>   socket closed) but is still alive because a TCP socket or page pool=E2=
=80=A6
> - [High] The patch unmaps and detaches the dma-buf in
>   mp_dmabuf_devmem_uninstall() as soon as bound_rxqs becomes empty.
> - [Low] The comment on struct net_devmem_dmabuf_binding::lock in
>   net/core/devmem.h still reads '/* Protect dev */'.
> - [Low] The comment on struct net_devmem_dmabuf_binding::ref in
>   net/core/devmem.h still says 'The binding undos itself and unmaps the=
=E2=80=A6

The findings look legitimate.

pw-bot: cr

--=20
Thanks,
Mina
