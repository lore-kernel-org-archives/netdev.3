Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8283EC2CD
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814314; cv=none; b=E5DwH3+AUBpCNBZA9dRBKVSZeOvvhOClgYbiNXYXAJlHhPnt91KQ2LtucaFXxRvF/OMcsz80fmEFhRXPQ8qjHWMgLPN5ZX/Ml1Du/dDoQowJvsPC0b+wjkstIAo3ZvUr9D60tFHl4PRcfVM8H2D/dec4RNgxQ1qimGjr3POr61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814314; c=relaxed/simple;
	bh=XfRleHMUovWIjm4DpG0PsGrRaoHoqM4tmy8AzHmPy2g=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=EIahYrgbo3f5klf+iwVnwXkZ50EWNNw20LgCUGuWmg1txRKIaXbCxtJznwtOLAUTk0uAPJJdrCxE88RH827mxPGjEWB/PJ7Z7uonMgphD3t+STYirEigx0U1gm/OuEgKVxxf3lR3NVXBmoOlFMKn7tpVPXvLEnMuvc2TpObwwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9j6Upgu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9j6Upgu"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49270caa5c0so33886195e9.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 03:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782814311; x=1783419111; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oh2sIHEkWOs4N4EQPFl12aKFh/osLo/Az6500T2/QHw=;
        b=F9j6UpguLstXLAbHs1YEGFCFYBXPnMznTmoLDnyiPsZtmVuD8ahTY/XKbRaI3TvKUV
         rTioeKf4NylQNk3/g4Jn/xJFmAqRTWv3oL1xlbSg749M6z2yCQDIH2tJSbbUXdbSqH4u
         VLPNP7bz6u/rnID3jnLKUoWp8kglqymlDgXgrahEdDXrEP1yXV7oueI6MhatiSMptOPq
         cHtnaPGefHie/JGA8JZnlmpPrwDv8VBjwcoYyFyAAJlWWOSXarxQLJcdcfBMl7Y8js+a
         eabFj8WXL7Mi52QNUBl2OgjRsE0qJn30Bw6QIVyriPcskGTEGckuY4TuPw3tpeQuUPq+
         zWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814311; x=1783419111;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oh2sIHEkWOs4N4EQPFl12aKFh/osLo/Az6500T2/QHw=;
        b=tUeiEULXmJSqXxCimir7aUEpUcYQ9VFOpRiFOui8Yn7h8NXoA0KHwa+jtWkA9BUi8f
         oTdoKmirRvvulPOLSX8FV14yJkolR4BkJkhByTLH/2rmwfM9SrediKnXxJIzTAx30bjb
         xJESuY4yNRY00ySC/V/PWzRqmtALfmwxtva/HqdoPo/VqLy58OT+A0Cf2zZgfXF9fLEU
         /4iEqXjq7hobAaDY/gs00VvmranTw0D8+pmJdPS4wajnRXa1Q2h5cZTOymtdELh4B7uB
         X9dgQpQVYUOHi7h1Au4JzrJTcYVUMjLfUhi4ym36R/T19t33GphuHnOK4Azn/qlm0BFG
         oaGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ijyuiioaHhQCqNbzx9CYfJtz6Xl+Cw/i3/kAxVbdEASMUpZYWELewt8k+KWenmCWIe0dXMP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGF5hoXhghwdWFjLWTXo7JZqdklMY4d4PiQRhb5HyskDMDULm
	mt92MIvIfR0bCd0xHKG5Nh1Bli9ZxQBURs3yQHQkQd9axBQwoMWXciPU
X-Gm-Gg: AfdE7cl2GHHZrJvjkHWqxKEUit4lhnARe/FGcJaS53W96rFhOlBk4Nlo2e58GTxpXjT
	+gqmpjUnDFMX+qwbTVgcg+BGzZ6Eye+3YRtCN84KC7YnhNPxzAJK9ppUkzuZiuOHy1J/TYIsP2u
	+YaVd5aWU/Z69BBu9rlwbU+fzZkY7b9ANP8TQupDZhNXhw8YsQ6Y0oAjWhRrzuDZ7Nf73Nyu0Ku
	nwOBRnwbCiwguEtJVH31Vjt6aTfMkAbJ1oyC1iekJDqKAZy8OJWaqDlGhurLpHiq0sdZq1l3l3s
	NoW1x3/GFC+bwuvdxjrjfochvCopEKfUZbZTy22jCuXt0K4VlYxV3fXao30+g11gOnrwrvXahrS
	Kj6/MYrk3qSwsxcy4FtAUBSoun3kE5+yTNHiQOCjrkkHGBNmbQO3NDCJU5xYtQACg+AnocxFoWt
	Wrl93K9gxUmS1oYBqOqtJnHR8=
X-Received: by 2002:a05:600c:6387:b0:493:a8eb:5142 with SMTP id 5b1f17b1804b1-493b827e953mr45816505e9.5.1782814311047;
        Tue, 30 Jun 2026 03:11:51 -0700 (PDT)
Received: from imac ([145.224.90.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d19ba6sm5836529f8f.6.2026.06.30.03.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:11:50 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  sdf@fomichev.me,  gal@nvidia.com,  jstancek@redhat.com,  ast@fiberby.net
Subject: Re: [PATCH net-next 2/2] tools: ynl: pyynl: pull the --family
 resolution logic into the lib
In-Reply-To: <20260630001432.2204298-3-kuba@kernel.org>
Date: Tue, 30 Jun 2026 11:10:30 +0100
Message-ID: <m2jyrgcp9l.fsf@gmail.com>
References: <20260630001432.2204298-1-kuba@kernel.org>
	<20260630001432.2204298-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> When packaging YNL as a system level utility we added a --family
> argument which auto-resolves the full spec path from a well known
> path in /usr/share. Spelling out full YAML spec files is at this
> point only done in-tree, for example in the selftests which need
> the very latest YAML. But the selftests have their own wrapping
> classes for each family so test authors aren't really bothered
> by having to spell the paths out.
>
> Afford the same ease of use to the Python library users.
> Move the path resolution from the CLI code to the library.
> This simplifies the pyynl use by a lot:
>
>   from pyynl import YnlFamily
>
>   ynl = YnlFamily(family="netdev")
>
> Unless I'm missing a trick, resolving the /usr/share path
> is hard enough for most users to lean towards shelling out
> to ynl CLI with --output-json, which is sad.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/pyynl/cli.py          | 53 +++++------------------------

This breaks tools/net/ynl/tests/ethtool.py which currently imports from cli:

  from cli import schema_dir, spec_dir

Otherwise, changes look good.
