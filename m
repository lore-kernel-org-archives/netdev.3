Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5720838F64E
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551589; cv=none; b=U6hHv9GLcjHI8QXUvSj0HN5GA68Pde80jnUqh1GcPnx9V4P8D9VTQI+BRVBlJS9z4qTQ/3a8cPKimYm4fFODqwPZ2AweX9o6wmQsMdtbDU9WRV6KsRSns/7pFgXztI/w/Tdvi4zb4focM1WB6c/mFc+W9TY+Vxes8hovl53O2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551589; c=relaxed/simple;
	bh=ODqUEGP6tsnL1ThwmZZC1AqV0iSvLOGuC+8v6XhyXbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJmEgTYtE8FHQLiy+30/9+n3Ot8w2BoaT2VqlqGr3nQ63cB8CCBImUHUJkDXH44IRqEeFWspPU2Srl5J9GEKMe7wG9BAAHQI/ggnoB7eaBwIuBZozYAPlbdx+z4WDl3m4aoV/0LDyfxhSHQ3i49DNvZ1z9r9djUZNl0E+eUaKXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY9huG1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY9huG1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F311F00ADB
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551588;
	bh=ODqUEGP6tsnL1ThwmZZC1AqV0iSvLOGuC+8v6XhyXbc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KY9huG1nNoRnvpCqjTFQgjBSywJRL/pB7MU/dPm08hgYzoS+Ieb9E8cEOHa+kAN8r
	 hpP7onJznN4TSYCa0plW4G+WA+o0rXCaPfAiuJJwCAz1jwRfjTaD0ZI16HxNNwR7xu
	 CC8Gd3E/kSJJMeOsi0KqyQ91UsrvslciFSqeKc6I+n44zIh6ir2sZ/V1u/426WCfP+
	 ppCHv+lJ/DixN+6mNR8pq9R0vPNKxmcp6q599RxrCVdQM+n0OSA0iSAd1hfj9WGU/R
	 eWqjLhjj35tszhnwQiQiv6jEEQ8jjtLxe8FIVBk1DWKmZSwAmhDF5XZlfofUzXr6OR
	 s18A7FxD7ICog==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e7c6ec9dbso45766685a.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:19:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpC7DXpVfPiuOLntII3QgKsyREQYEOUYJb6UU5hrWJQZAoSyMxfMTJM4FdkYplAr1HKytslDq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkiux97bxDedB4ZSBdMXsnapT7g+eek8xEB+LjhNC95mfp9poI
	bwS2IeTJ/w5jFd6tuUkM3bBcVy6Lix5+QkDGoOhRaRmiKPxKGFZ+F1aCZny6d0u0dO3zJ8196ZI
	cBRP+vLYNuVKWDMQ+rqQoTrVVpngNbxc=
X-Received: by 2002:a05:620a:1196:b0:934:9f6d:8a0f with SMTP id
 af79cd13be357-936b3d3a56emr437784985a.36.1786551587351; Wed, 12 Aug 2026
 09:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812154328.72834-1-mahe.tardy@gmail.com> <20260812154328.72834-3-mahe.tardy@gmail.com>
In-Reply-To: <20260812154328.72834-3-mahe.tardy@gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 12 Aug 2026 09:19:35 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5MrfNwV_gwvP=uCWop46vuahyR8oXJsX2Wp70SCB-+uQ@mail.gmail.com>
X-Gm-Features: AUfX_myN21PcR5YwnQW31xiuSFAARvbx_9wPWczbCsBu5zLhf3mf8-CknypXsJs
Message-ID: <CAPhsuW5MrfNwV_gwvP=uCWop46vuahyR8oXJsX2Wp70SCB-+uQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/5] bpf: Add ksock kfuncs
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, 
	liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com, 
	netdev@vger.kernel.org, sdf.kernel@gmail.com, ameryhung@gmail.com, 
	kuniyu@google.com, memxor@gmail.com, jiayuan.chen@linux.dev, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 8:43=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
[...]
>
> In bpf_ksock_create(), we copy the arg values to avoid TOCTOU races
> since the kfunc can sleep and the arg values could be stored in a map
> that could be re-written by BPF progs or even userspace programs if the
> map is mmaped.
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Song Liu <song@kernel.org>
