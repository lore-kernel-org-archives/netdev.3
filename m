Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C643B776D
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070390; cv=pass; b=ZK2UHN1Lz4cPiEiuzRwuliFzBb4flmzFyBIqGr0p4h01AKt6+XUy1rLamS5eE4BJDTgT2oacAf6a0FOhE4EYsFh0Ztmprn0to8HgmIQst3lTdC7CRG82Z2g/S9cIpkv5eFPDVHdl1GfWxvDBGc0eWZXBSpaz0AmAZOKRIFwZ3rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070390; c=relaxed/simple;
	bh=boxmTyMFq29LCfG4VMNLF0pnUpUmPagiT8ecsCV/s6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfiDqtHc4GXV398S5cacu8imh0ue0zMBs5KyxqjVnZw8zDwY862eH8z0nATnOtOZCwM8ttrO36A8Q4jTEWt3uGh3WNl36eMaWRejS+rmGOiIoO/bzE17Uhwe6mEEze/Q5Oz9KCO/YrJKsKekjk9lCybO1yqP72gZw/Dhzg+vRJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbMdr37i; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbMdr37i"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d3b440b97aso141845ad.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787070388; cv=none;
        d=google.com; s=arc-20260327;
        b=ElPzRHAXep9vb9lDub5QC1hewt1eYE9pBWvSl7Arnv2jcgSiADPIOyEqzUjqQB284m
         vpkpdX+PLIboAnC2aKzun9fdp9xqdAHY6C7KPdNc1hflVnK+Kzi03n6gyKgUNDY/DQBu
         KWV+2pVPP+0dgOa2UURvTpImG5i/zx5zUIecNhPnvYaMEqPVdQ16PCl2Y39shFrQutuI
         XzJdYzQ97+Xme05qnLNrKvPLi0MI06uzg6A+YUIA7hPwUbYpIm70atcUPBjzDR647PQ0
         9EwSPON/+dnOnjlC/Fxt9Zx+//NDDb18LfQtPHqoqEG7XWIxjrzoN5FyUWn4Y621hSAF
         GvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=boxmTyMFq29LCfG4VMNLF0pnUpUmPagiT8ecsCV/s6Q=;
        fh=Q1AmbVPOB0SqTw2/azb8bmVpWw4+ESfVbAPYgLwtMBs=;
        b=Lx6e3A/6XQeTAXoM5Q6I4a21Z47r+Rf534HkfEWKozlqaOelnlUA1OVkRgTVuoj3as
         Rr15v7Ifc+tCfvb50LQNI1mhk92NrwWgKdzbMd1hlrMQ//4ijrYjwbpgFGt5petySAHH
         HsziivPYvLvvAkchCp+MMOcFG9jcsyCK+c/77Ty8MOSa4eciE499cpuCyuj7+VV97s1V
         sgEVME426negqTNZgKYZBiWtXU2ESr4D3LEE3Qj7nBx+lVRrJ9rGBfS6Rh9orUzsAKwi
         0SN2kjIDW54s7Vlsod0N8tTXILrPMZQBYnE2vxY6QL/ikJDV50hyBGLiOrU5efqj3/KJ
         u4uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787070388; x=1787675188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=boxmTyMFq29LCfG4VMNLF0pnUpUmPagiT8ecsCV/s6Q=;
        b=cbMdr37ipLubWoECADncUh9dMoO0uC7oXVvBXb7iWd+rwMv0K1jbw9SXP0DkvBhDs4
         1cYtN9/AnegPBycAcXWZnpH67kbD8nYDnt0tlx4FnJwjnyCX69zSEveaqf4Z8NVLg2xM
         axMzU3y5qx3DZJovyTcP7k8l8hEOXagUFSBvb2JIlahCzLMqy/aocMkCjpMkIWO5L6JG
         IzSItWdZjsigrX6B4rB+ydovDN3nkLL9ZUV+H/c4l8STyuJRSov2fgIBQegVbjhULvb2
         1QcOTg3K1nnrQdJ9l1rnvq7bJCenoABdk0WW6qPWLRAGcj0yv/edvOYtfIML0UDUWjrr
         wyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787070388; x=1787675188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=boxmTyMFq29LCfG4VMNLF0pnUpUmPagiT8ecsCV/s6Q=;
        b=SCpzloHItVfm37KD3CEfOV2ihNU83oe60CgkR/l4NjxguYZCrhuyKtGAg4K5HoxtWc
         j5udN88symiyPjLpOjXBgHBpGSmTmGc28jaZFIGS0UoOmXgeqio9ZHYKcDygKY4Xq4sP
         te9Mva8KAIiZnSdGLAc01cMlQXByQbtpidTTwnDVImxiyy+24Lho0SP3kdBxJqs/deGt
         ztyRxoyYQ7DR2agY2lu/eVFFElQUbGnhdaQn3/44968Dojc5ruxteZg7eCjDVHWauCow
         BAeKiD2QlWEZCSyH4KXHfEKIqV4DBSKTjk28eSOQ6p1HGPoKVXZnXaJwgBYMHO9ZpDeB
         qX4Q==
X-Gm-Message-State: AOJu0YyIRAMiZx2vI+FvWyPFS8MBAK1q1bqvEfoJzp9NVjr8A8bDRU4W
	ZxNUDWd2A0qHCE7V0NMXQL3/5EJAEBYN+7EWC97GboyHrz/orLFHz9AZYJ3Cykpu8xRMhopKaC/
	71j2NQYcusWIh+6Y7iflgSOfJUGLgxp3eCotCGxQQ
X-Gm-Gg: AR+sD13YeiBgmN8CdYeoqG/eYGkcG09eafLaW3ODS4bL6c8tmuTtGf1Xs2U9VNwhr7M
	LSY05XqU/6m9oKMNXA9VFp0laYQ3wNgIpNqYeDKfdL5fxoUmY27zbilXIrna85bVB0heD8iIzaB
	FQsX09NOlmxRqr0vu0v8d5RzXskdY48+7q3raRG0KAcaULiNYa3IpGv/Os9V40C+VOjoORavoEm
	hhDSrMG+2Gc9TRebBd1FNkMd1ZlAPxozh4lWiqwA+a0oILyOk2o27KIhPvFqrTVEPyDSKGm+20B
	GeBJjYKYHgdLrwu10H5vC+mxm/txyssFKhXOAMi/ONYuEriQNUZQ/UF3uYeeybe47Dat54PiAa9
	Dmwv2O/arx6ZsAQ==
X-Received: by 2002:a17:902:f682:b0:2d5:db38:8013 with SMTP id
 d9443c01a7336-2d5db3884camr4553885ad.18.1787070387689; Tue, 18 Aug 2026
 09:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
 <CAEAWyHerP_n3ucJaEqrCZqVFQTPKzydYXOPYZkk8d0iKf8UWow@mail.gmail.com> <20260817183904.6e0fd5a5@kernel.org>
In-Reply-To: <20260817183904.6e0fd5a5@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 18 Aug 2026 09:26:16 -0700
X-Gm-Features: AcwNN1XvAvV0q4175YkxzKnksGXpJuWQyNr6fD5SZcYJFVMGRRHl5k4ZnrMHHXw
Message-ID: <CAEAWyHehCR6+mV1d1JJz=wdsT-LrUyowT2v0CsFR8cw3CVqYhQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 00/15] gve: AdminQ mode related refactors
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, jordanrhee@google.com, willemb@google.com, nktgrg@google.com, 
	maolson@google.com, thostet@google.com, jacob.e.keller@intel.com, 
	przemyslaw.kitszel@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 6:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 17 Aug 2026 14:45:08 -0700 Harshitha Ramamurthy wrote:
> > Sashiko has spotted a few issues - will look through them and fix them =
in v5.
>
> net-next has closed. I'll take the first 3 from v4 and the rest has to
> wait until after the merge window.

Sounds good, will post the rest when net-next opens. Thanks!
