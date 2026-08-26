Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5140DB31
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749010; cv=pass; b=RHd0dPe5NB0rAGKVl0pAUCBu+5MpL5c24QRN4UqIr9qsmKRdMGF98nx1ZYOD4lIqJBeWV6lb4olHSqD+rKmScoALBw+FLYlpwG9IvL7uwMY3gEkAJShSxdfZHw+xXGUOl7/G1r+KfDbOrNzr4GwpFsvMOsOY2jXHULF/gHZV37o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749010; c=relaxed/simple;
	bh=T3EdywQ0FnSZ9/V9O/5TdzWtrn0QpysuhP3PC+q6xFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkRzz5ly9sWdTowJaIHgLP3qx7M/3IRG014EEZD/oqBkl1VAiKvGORosbYFMncgER8FDnalvqeE9Aw5seJVLawV6Ij5JYNNVjsrIg+q1PxIUhNhaXhpukQBS4M4e1owuaeVcS3mIDzZKJs22XX2bDQN5nLJY2nIECVcaqzsOIps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=es6ZK+x/; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es6ZK+x/"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-43b7e186a0cso514458fac.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 05:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787749008; cv=none;
        d=google.com; s=arc-20260327;
        b=d0/q1uiHWddUFPmRXbSC0rVFn/s/mikqrZyLSO7vEPiDLdj7r2sz7F1MhyK9ZBuJm7
         XSDRDahY7pX4rsbSr6BGR/Fn0Umt+33M1JuwCY3Mj7bC+P+JzzWmi3OMExOG7aHON0HB
         SOnVzmI0An/HkgU+bGUpdPSHkNHAyjHgOBxd+AIkxsejAPr1XR6PGdZfYkaej0Zf4kzf
         Fz+m7Obx/y65ET3lhQKZcIMckbekUCQ9wELjHAb7xh5W4Xo2Hh2NSFPbpb1A/kGbPVcQ
         eVwROuVLSksvcezTZfA1GSLKF7Xo0qcSwooa3xx3xKaixxNIrOmAH2lkMh2ED07vTnSH
         NjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oJ4O5COMcliAWQ6BYpejpwUZKPJeoT5vCsuDXQei4XU=;
        fh=MJMnVUoxNDiiH4IOQBRLkP8k+BOwXC9PaYpCn/buJHQ=;
        b=kBzbvdYAI8BA9hK4JdZFyCLezfed09BKrqf1yem7XsiqI62rkCecoQ63TZLzIuWzgg
         KHHCjJZgy5awkm4D3SexxVlhPONVzzDkH75wiymZBgxjNcqG05+4auYra7Xi82F0b1ty
         S7NXasG01Lwn5EwOEsmD0mMIDTeA1bkBEHZugSP0elUaBlgYKavp2anxnRS2WUt/13Zt
         +w7i9NQGt4p3xtE+81mwzjKVf74JcfxrTWBKB85IYlOq6ATRiRANzq0x1nv/+o5CmwSp
         5tR6S9XSuiLzylf2Rn3g0uXXLzjmVWGfObHhmnqiGdhA5zKlyh6ElBhLoql20qa5zVrQ
         2I9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787749008; x=1788353808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oJ4O5COMcliAWQ6BYpejpwUZKPJeoT5vCsuDXQei4XU=;
        b=es6ZK+x/1VQKZ9vTmvzd42wZdUSpPXt5rXm8aaY7fNOFb3HZMmKRxpfLQLSgQloXTM
         /HVulg4ZrTb8oH7WemXhWfw0Nc0ozccc6hgQcA7RNG3KOXjb2KCgLIBqPV6iJzzPz7A2
         oOO2Yq97bQDKrq+HVNpqj2sRWpMPywXOpIJfw4mx329mSJmLNbUqkM80mYit3d/pbUo1
         RysSVSuGNZAaKhOXZtU8QSjYxqFn0VO0QaEJydWdOYfXCekadCLP+5O8cQTX7PkWVNep
         GAYP3gkOA32Hbryrl8azxflkyK5KVKHjigUiAfqFlgvkVfTntT+r/xyM6ftuXnmm6QLn
         b86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787749008; x=1788353808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oJ4O5COMcliAWQ6BYpejpwUZKPJeoT5vCsuDXQei4XU=;
        b=CmaZa2gc3APVVMuQyLom3PhvLe72heAgiLw3LViN3b6+jCpqF1OZnpgag0sErb/JnW
         F/EKX62oF5bLakzDevh9nPyopHV3U027qtDero7eoAYETgcD925eKapBU74OxQalVT04
         07BmfccwQNy69ZEPaHbRbz2xzFh4QEj7E9D79EG/cPNfE9cBYeY4rKFVUoHD1BWGD3v6
         m4fGKiadjN3TX+Otq3dALkH923AVFe0+ePd9zl4DbZQ3azIRM5L2Fedm1mHqVVx2sgzb
         17DUfOy/JxnZIyRRjlGyYcNjKpBUudoeQhgEeVgTKcpc7RxTndFpWCmLBx9gGUMcCbwm
         kxfQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNlqKbvvvsH5lR/jnb1r29MdRihFD0lT4KofS/3tz2DpoN9ZZsGxV7Pf3tctCBcWuaLbNxUhM=@vger.kernel.org
X-Gm-Message-State: AFuF++lPmsWvYxRPX8UMRpVOQEJzAMPwd3brxi8VHG902dMRi34omGbC
	EzPuDwsVlfQsZWZdghToDSht5jUh9Z+QL7tAsQrf4JLukt0Fo2Jui0qM4SxLhgHCdcu+Y/84R5S
	VfDxAMIRQdT1LfKpiNTrI1MA7+fb9rws=
X-Gm-Gg: AR+sD11uUhDUah+xMOeJEUcCuUeZEtG0S+p/nmAujBF4+bH0jftKrKfVE6ugWi2NETj
	ppw/AQgC4mp3+R+nJA8P6hNWdckqR2JeIxxGTMoMgg2hlQqjVmfdNuiOu66snC0oRHslxqopjbb
	JsoVBOgYMNZLUOR9NlbJFyZPZD5O8nUWim2PQK8yJlLX84c93CyxRjWrRfZGaQLUzVHfThVe8jY
	0W9L4oLtse8dkp8q2+QsgVEEw987u9mNWYOqtWAbeWZUJOHzEFCm3AVvPA/IcvGBj4JlnB1/dUP
	WnOsWHNNSA45qyILErXyXm1IJdDPHU4Cdo3YjWgAVBx1HA==
X-Received: by 2002:a05:6820:83c2:10b0:6b0:fa2c:f0ea with SMTP id
 006d021491bc7-6b1a04c6f3fmr4670154eaf.24.1787749007328; Wed, 26 Aug 2026
 05:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMArcTUmACRn_h2sthPwsi3jYjKWRM6+Pnhg=tN4jn4VZThHCA@mail.gmail.com>
 <20260826041529.46139-1-blbllhy@gmail.com>
In-Reply-To: <20260826041529.46139-1-blbllhy@gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 26 Aug 2026 21:56:35 +0900
X-Gm-Features: AcwNN1Vi8H79S0z29kMqK7_R4gmv5xxfbnqc8ycUo2O9t8HNIzqq-v9TctzLfhw
Message-ID: <CAMArcTV=zbS=XAPsBAEP7j9yzHiAjri44XmDK-a78JrOX1yv=A@mail.gmail.com>
Subject: Re: [PATCH net] amt: do not store tunnel pointer in skb control block
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: AutonomousCodeSecurity@microsoft.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	kys@microsoft.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, tgopinath@linux.microsoft.com, xmei5@asu.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 1:15=E2=80=AFPM Cen Zhang (Microsoft) <blbllhy@gmai=
l.com> wrote:
>
> Thanks for the feedback. Just getting back to this thread.
>
> On Thu, Aug 20, 2026 at 10:18:43PM +0900, Taehee Yoo wrote:
> > This looks like it adds a per-packet linear scan over all tunnels,
> > so I'm concerned about performance when there are many tunnels.
> > Do you have any idea how to avoid this regression?
>
> I see two possible approaches:
>
> 1. Keep the v1 implementation. It is the simplest fix, but changes the
>    Query dequeue path from an O(1) pointer access to an O(n) lookup. I am
>    not sure whether that cost is significant in practice for two reasons:
>    this handles IGMP/MLD Query control packets rather than multicast data
>    packets [1], while the hotter multicast data path already walks
>    tunnel_list for each skb [2]; and max_tunnels defaults to 128. However=
,
>    max_tunnels is configurable, so users can set it much higher.
>
> 2. Add a small per-device bucket hash keyed by (ip4, source_port) to [1],
>    while keeping tunnel_list for multicast fan-out in [2]. This avoids
>    a new linear lookup cost, but adds a second index that must be
>    maintained during tunnel creation, expiry, and device teardown.
>    I am not sure whether that is overkill for this fix.
>
> I would appreciate your further feedback here and will prepare v2 after
> settling on the approach.

Thanks for the investigation.

How about protecting amt_tunnel_list with a refcount?
Currently amt_tunnel_expire() frees the tunnel immediately, but with a
refcount we could just drop the reference there and let the memory be
freed once it reaches 0.

What do you think?

>
> > I think this comment is not necessary. Please remove it.
>
> Agreed. I will remove it in v2.
>
> [1] https://github.com/torvalds/linux/blob/0f23d56f17fdfc7db69d51f64c8b91=
bbab947aa9/drivers/net/amt.c#L1261
> [2] https://github.com/torvalds/linux/blob/0f23d56f17fdfc7db69d51f64c8b91=
bbab947aa9/drivers/net/amt.c#L1276
