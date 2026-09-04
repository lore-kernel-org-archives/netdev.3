Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BA84FB9B9
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561323; cv=none; b=qY5Xuc9cM7DoZUkq4IiL9TGICm/QMMgyYFfFQlA4liJGoCCPPxzHpNSv88bz4uAEz/qFsTtxSpaA6leVUNLcrnUQvSkyWjVonGByu62j2Vz2GcZ5qjENyFyeeWGnZUKGHbVXHskIUJWYqGcTyQ9h8ryMWNTWILcGJmMhypYf3HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561323; c=relaxed/simple;
	bh=8yr9KhiXPz+7kpFmn7dNCSjKVXIx4oNAi3Rj5/0r0S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGL20vRT2HaxfkZRPEKnvsKAazRvWeRqSdzZVhPijY4dYAA1i89B/2N3sN2UDdrUGfdQPAtSy0TKB3RAF13/Ge2yglPZfe3JQNSv3QqRRQA9x9MF3wt94drqgxFSS3FrQD6HmVRDGLHJd4LqQlf1s0bQtjGBY1b0n1BP+6CrXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1cNquca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1cNquca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C3E1F00ACF
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 22:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561321;
	bh=cjShX4oY7YbHcAVM4iaZJGTrGB0SElIHdue6RXDVlyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=S1cNqucaFHW6mj1AqtTBLFjH4Cf6LX5zm/BOYie6CBytNUQRVA+DFOwR+bf8ajugM
	 5WxLAOBcHTa1qrIPmBbZ2Y5WjEKx7z1vltSxkB/Mtwn+7kANpK+2zJLQZIIxMKup6u
	 qfGglqjzGDhAY1fmIqFMZSVmnzXb2KLlOE9fsbormEscl/1/PpOmnAnNHJUIFl5ckN
	 E9jPBLynaz+haC7aPqJgw2QuY9UmDNTOWxkJ3l9eo1od2a26CQvs/J1+AF1Da24BnM
	 3ckO8IpojGE+yYGzbQ34mObs8x4CsfbSFj00+x3SSRUlr5SFpwgzWwL/QElS8/rRs1
	 F8WF4ng8vY7hQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b6188a2c0eso1053321e87.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 15:35:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw/1wP7y0s+GZNbf6uP0lLR8kwEUO3U5H6KzKWUsqMn4wWSz31dRURpyvZLV/TTfAxFbToI2Jk=@vger.kernel.org
X-Gm-Message-State: AFuF++nJcwF4gjhRVXVDeOXblNh0vo5JO+r+gZ5MUyRrwrZcy/yDE5Oy
	Nx3WOQPzex1yYN1aT/ZAJwegjHcPbKWWYqHX84RvOBQZZbq0dn2iUhnENPwYgQit5T51wIvdtoO
	N65PSVkZJe7bQ8FG3EwuLML0ma6U6Wqc=
X-Received: by 2002:a05:6512:124d:b0:5b6:1a7c:fd93 with SMTP id
 2adb3069b0e04-5b61a7cfe67mr1005642e87.57.1788561320389; Fri, 04 Sep 2026
 15:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904115917.13695-1-hemanth.selam@gmail.com>
In-Reply-To: <20260904115917.13695-1-hemanth.selam@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 00:35:07 +0200
X-Gmail-Original-Message-ID: <CAD++jLk6Z-xuq0G9+f_P7q6d=Ztb237FVNO_FOVn=vq0EgFp6g@mail.gmail.com>
X-Gm-Features: AcwNN1WkiKWdoB-SHKS8eBdhTV4jKHtcnkd7zW72aQm4tmI1VLdCqZKMV8LqvFc
Message-ID: <CAD++jLk6Z-xuq0G9+f_P7q6d=Ztb237FVNO_FOVn=vq0EgFp6g@mail.gmail.com>
Subject: Re: [PATCH] net: cortina: fix typo "trigged" in comment
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 1:59=E2=80=AFPM Hemanth Selam <hemanth.selam@gmail.c=
om> wrote:

> Correct "trigged" to "triggered", reported by scripts/checkpatch.pl using
> the misspelling list in scripts/spelling.txt.  Only touches comments, no
> code changes.
>
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
