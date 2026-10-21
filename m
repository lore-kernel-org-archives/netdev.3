Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625978;
	b=3e0vfbUbzH++rLQ2zAgsQWAx4QAv75JFieGKv0MiBoZ9sP4l45JnfYoDJD26mSVM9z8E
	 HEM+nP6SweKjk6c+EDlHr+pYQR4flX+L6mZd7I2S1P6jSR6rOLtTZ8cY163U2hLHa7C0D
	 0BApeqVpsp7RRTlHrCVBgDAEjRxdEcpbH6+U9EPPstMwO4orK/LC9oq3xF1pPs1tt5QGv
	 gS1IChkD06gfp0Z+qTQsTSPbe3PTNDji3aoTdBWb4lopNey8G9F7JaoMPJgNHOUG81FNa
	 LlOTK/oN7Q3kXD5KChMAjVN/G9LtGc50LLAvyWrkwyin8V5Tf8nS9jfqbHH1ih9J2oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625978;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ufbJ183tP34SgR0FDlI0u1es2B0WfhYWPPBpDNIda+E=;
	b=1B/RJCOZBx26PQDBkKhmmUCY7DZ+t5clwZsKuteMO2yMhi6lyYvCciuCDRkgFkW32xdn
	 SLKEjO5PaY3cfsOdGEVN0I/Ssns3fYk1zeG/BYZWkzBNagFt1Zncjm+0sIcD+9B/+fNti
	 FkMOMUqKdW3UH+BsPRRToKFPIft/K042vxE3z0XzrszYcB54slCaBl8wKeZQrbV8MWBmx
	 aSLKCcsEZ2cbRO8hcZ+9R0jSEGkxpfFru1X3L33Lmhmw6KM0REFCltI5YnHG2HX7mLwgD
	 ARu+vVLJwdJ1RsoD9KKBMYsjp+Gn2oKzz13gt3p6QfFi/UNNVh+EiAINqQGOIVxF2uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rj5BUUWN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA03606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rj5BUUWN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966311F000CA
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 23:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792625977;
	bh=ufbJ183tP34SgR0FDlI0u1es2B0WfhYWPPBpDNIda+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Rj5BUUWNJxnXcorQ4PznDdW0JGTFWzfj1FiSS4S9E+773NOnqo/YWll3Mvh/2JmCz
	 A6jvA3y9JHDNFCvgCGH93sbBXUKbIMwcbaQfX3VGgerAGF9bRFBvQqzD/ktMJmPqfc
	 UxBpVEJy3sALUHEmS14kpZOI6/Tot0RZDYWcUTgneG6Aw6frOuttRJO7emaygC8QXc
	 MvvRqyvpkt3s+Yk65UzA/orPc24dGMw7lwsoXjxEFRSHwdVkfoFNY6tfhN/eTxFkTb
	 JJVMIWK49y0UUi5aYDC/melb5cvKh8cvOO9uOK67IJsth9YFuFJQx3KCXTqcFbT+PQ
	 weYD38Hp5A+Ig==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ab46699a09so13099011fa.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:39:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwpa/ry4oiMOpht9vZTXn+xduNA9nDAt9wKNL0tL0F9iQqvEpO+jCpy8i2oIzGCkgrDeJUPit0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKu5HZ1sXhgl7IrgcNJdF+SuWLwaShDYz6Ys+aof7lpBudJyfgB
	v/IQFj/8vzcpLCBZpA0Wfj356iWvj60cluJBmH0CqSwEFctjXV7fcQW+Hs5bBiXYu1yHNsD8h4S
	tG44klsj9kJhGoc7F8EQsu/lTpIR4gEM=
X-Received: by 2002:a05:651c:54a:b0:3ab:4014:883a with SMTP id
 38308e7fff4ca-3ac43fd0bd0mr9868901fa.0.1792625976316; Wed, 21 Oct 2026
 16:39:36 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015-gemini-ethernet-fixes-3-v5-1-b5c9e2f7b8a3@kernel.org>
 <179243092325.3135.5534691456764566511@kernel.org> <c67725e6-ee8b-42b1-973e-534814712ea0@redhat.com>
In-Reply-To: <c67725e6-ee8b-42b1-973e-534814712ea0@redhat.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 22 Oct 2026 01:39:23 +0200
X-Gmail-Original-Message-ID: <CAD++jLn6xnLn1_U0prb9LDCv5zKxJQ=8Eq_Zsw1p=onCmSS4Dw@mail.gmail.com>
X-Gm-Features: AclHuK-pIlzXtHc2xaIXEPApMsgx4rDGoKkFMqwZrcHtiX4z3d_eHLBkfPreKfE
Message-ID: <CAD++jLn6xnLn1_U0prb9LDCv5zKxJQ=8Eq_Zsw1p=onCmSS4Dw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 01/14] net: ethernet: cortina: Keep shared
 free queue parent-owned
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, ulli.kroll@googlemail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	mirq-linux@rere.qmqm.pl, mhun512@gmail.com, edumazet@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 3:17=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:

> > - [High] At this commit, gemini_ethernet_remove() calls
> >    devm_of_platform_depopulate() (line 2689), which destroys the childr=
en=E2=80=A6
> > - [High] net: cortina: MMIO access after pclk disable in remove
>
> This looks relevant and legit.

Yes I will look into them, it's fun because the gemini back-end finds
different stuff than the gpt back-end I run the patches through locally...

> @Linus: please note that submitters are expected to address the AI commen=
ts
> on the ML.

I know! I wish I was as quick to respond as the robots.

I'll update the series and repost for v7.5 once net-next reopens.

Thanks Paolo,
Linus Walleij
