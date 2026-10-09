Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9117D3AE706
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533801; cv=pass; b=gEaLnHA+CEQpK8fQjphMiBw+nwidgochEvpZ/UIva/6rePFP90fRRsZlnNsrM7F6PQ7P+R897HahBwePgk0sXKMMIKv0zaR1VwJRFZNsO+XiypDPMMgb23bEsVtVrSIsaMKN5yXVAvWYwRaRa9jy1uoKMbPURT1Cy3FX8GMDJXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533801; c=relaxed/simple;
	bh=NpIcuZOQQpzUnJT19iUeQsJOL/msQ/TH2ZDF8RC1IVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWEiqrmi3l74SUSJb4FGwN/3cifCw6Bxz2jayxNpkYZInSskIEgSJ2XRptabszQBakefTyaLXEopHxbjq8R6+ycPViZBnySfCl17CbUsKNbZlE3GNRMZhJATPrQYOiB43eH/iUHrgIAzbSzEHcS8SNQsyKgd4x0bBmQMjHxGpOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dd5XMitf; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd5XMitf"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8abd68b3937so60946727b3.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 01:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791533797; cv=none;
        d=google.com; s=arc-20260327;
        b=QpFTqn5qpg9wkoxayC4f4Iumowa4iombEKBR0oN0+VrGX4/wwpLTNuRYvgIgwjadmG
         FfV+KE4yVB3lQ+E+wyf1zXdBUSrYX28dUq48hSbrPCRGkdLJjeCLqjTnq99kIambx76f
         phjInMItYccUZ0gdiwDhlyX9Lr3vOuxnecARTqM3yhCCY6RlSxt91zdq1i1KLMKleRBJ
         osb4NxKh7duxUwkTWiSs8sXEQEjHoo2KvkzRmy1hMF2nqsTOIsUBaOD4fsPlbUYqxyjO
         vTFR8g3OFwafe9F8B7HcEzjfV56v3FdCgxHONDxxpSuXWSO2q7NhEnEnJa12hP1Yzqlu
         1HlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t8vA3N8qc2Td5LxcOddOJwMiY2+zXYj7uffeRIVEV5Q=;
        fh=n5EqxscuYMl1rrJ1IBUrlyernVchIJzH+4k79HbRCFI=;
        b=fIY2vhX0/F/3WfV4cxEltbco8QSjYbZ95B8DPzSam8HIubLJi2t2212dAgtmxhua41
         jJeyjeHFM7HswKEWk/NnZmz3BT8n9R0AF079Xw4wOuixm9kuYBqO47Mvx8sbwtD0XObP
         ppi9sc7dCX0FxWx2dN6VCCBbzuUYkpAsexHs7+GavwEshL2rIcdjmRT9NvMcTPsdjUhE
         QVg0UPHCt+z2Vbh89OjbZwhqYG4oC7cvjz/ihR074CX1pVCQ1fwmO05xtUTcVTLfHCqi
         egIEn9eaEGj4E/Vzhnj7xiXugTo6edeki4ig6Z7EmwIlfii2lJjfJbiJJGRqsdLJ1Fdp
         he5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791533797; x=1792138597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t8vA3N8qc2Td5LxcOddOJwMiY2+zXYj7uffeRIVEV5Q=;
        b=dd5XMitftoxnZKWlAP9VuovuMevKr8qRHbZ7iFr0MiIjKmlqTvGyTRPlr07yjIBNDb
         q4fd6qijxVD1U3OxrwJljCv+YvGccOfJsyviZWFyyhE5q1HU98y6oa6DehFXLLIKrLk8
         9tctwGakXjiaFpopcNidgOQeVRboHQMgA2Gxu4Jl4pql/pbKEGEfBHc5+HvyKlizsz/B
         eA8X6lQvWrxC4b2k/P+l3NI7f27TmX+gkBV1DFjIJsfHRpuiBNqpjtKA3B6iMCs02LIa
         HD8pVUjn3TpbipPCJHbK+wbOE01mW/vj8tY/wVtxs44ioMb8UVZBpzTLkUUrwwHMhXBo
         XxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791533797; x=1792138597;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t8vA3N8qc2Td5LxcOddOJwMiY2+zXYj7uffeRIVEV5Q=;
        b=HIZnqzItYr5GpwDBR4RAVAciHdFlAf5M4PZX1YwT2PMdYxUEWN03b7Bhr/0uRIfceU
         vvOlkPI+INDw02enl00VUYOXUzyDhBqhWcmCfhua+OA5EnO4NjfgTqP4jshz1JekfYZe
         wrFfV3CeLZSDfc0ULAcC8nHRiWTer8F2Uer0bhqW/oQO2IlVlqQl6QQ5QW4Y4hr6bml/
         iiDm48XtmSiFjJqCNuQUtNr/bBEGcCTqHN/rcvagH52SEXSU4qSbuRuEUMuQJ6LM9Ash
         i8KtXAxMk1bWE3WcNfKhGrE09qAMWnUOfQmy3foo/EjNfhak/jFYhhZnodOnv6JnANTN
         +vzw==
X-Forwarded-Encrypted: i=1; AKwUvBz/zqa++TWu+fdCjxkpApMt1HyuRmAWltECtmi8+v/kV+qApjD6yvJvoMcqkm9tmg0ZgJpDBVU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPPpIHPDZrGW2D25iipn1dgHHMRqWR2uWhj1Hc+10DJHdR8i7+
	8Do+OkEVMwwskSNSTQcdH0urrFr6olHNkZ7qXGwouvckPOMq/BPq4NfACHlToWhiYlGCQkvYk/Q
	h53ibcxZrpXg84zacB6oAjCFPtzk4tpU=
X-Gm-Gg: AYBFou2pbuqsBW3mrwYOY3oelL1nd9EcQXfbz9djn1N7jvY3oJywTOpCtmtO8oS+bbb
	PwfJEYx2Vt5Vy55HhsGGoY/tQAeifN9v0+vluune9dAfWDU/C8sGtf3hpTkQ8Ry/02Bu5FB3+OU
	bQ+DTT5u7WxdhsrBaOmHdtgL7F7C2J7OwsYelDNRwGdn5E67e9AVt0qssaqhATMHP1+FHnplFzd
	ggcGigY0P2dAJjzB8uu1iAB4yXmQJ4RwOBSSLpec+4dj04zaFPtjw/QZwcGEY0a8fnwsAWq0KDY
	VcG0+UbFPj/fBCp5h5GmSITyUOosjM7cnXUKew2a2yEmobUjBwIIeZIZJQ==
X-Received: by 2002:a05:690c:6b04:b0:8a5:af04:fb1d with SMTP id
 00721157ae682-8b07eeb39efmr4856347b3.55.1791533797388; Fri, 09 Oct 2026
 01:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-ip-core-objects-candidate-0002-v9-1404514d79dd4560c571@gmail.com>
 <CAL4WiirhPWmWCnPLHJVp8vXUvPGo6CQ6HC0ZmaEzYXmP8uZtzA@mail.gmail.com>
In-Reply-To: <CAL4WiirhPWmWCnPLHJVp8vXUvPGo6CQ6HC0ZmaEzYXmP8uZtzA@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Fri, 9 Oct 2026 16:16:23 +0800
X-Gm-Features: AclHuK_t-b9OH289lEm9prObkL3pHfGUf9zGubc5FVuGfk9n831yycBW3bIqDD0
Message-ID: <CAFRLqsWNWhVA4k0Ox6yJ284iVAot_E29qr3cb-fNwCug4T=jLg@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv4: prevent in_dev_get() from returning a dead in_device
To: Eric Dumazet <edumazet@kernel.org>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, baul.lee@xbow.com, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Eric Dumazet <edumazet@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=BA=94 14:54=E5=86=99=E9=81=93=EF=BC=9A
>
> This is very confusing.
> The changelog shows only the KASAN splat, which is really not that
> interesting here.
> The refcount_t: addition on 0 warning that must precede it would be
> stronger evidence, as in the IPv6 commit.
>
> So this looks like a modified kernel or something like AI hallucination ?
> Please elaborate
>
> pw-bot: cr

To Answer the robot's questions. I found this issue through
AI-assisted code analysis,
then built a test case to actually triggered it. I were not aware
of Baul's earlier submission at that point. The triggering run first report=
ed:

  ------------[ cut here ]------------
  refcount_t: addition on 0; use-after-free.
  WARNING: lib/refcount.c:25 at refcount_warn_saturate+0xea/0x110,
CPU#1: ip_core_fixture/498
  CPU: 1 UID: 0 PID: 498 Comm: ip_core_fixture Not tainted
7.2.0-rc5-pmb-bt-functional-v1+ #1 PREEMPT(lazy)
  RIP: 0010:refcount_warn_saturate+0xea/0x110
  Call Trace:
   <TASK>
   inet_netconf_get_devconf+0xcbc/0xe40
   ? __pfx_inet_netconf_get_devconf+0x10/0x10
   rtnetlink_rcv_msg+0x7b9/0xce0
   [...]

Best regards,
Cen Zhang
