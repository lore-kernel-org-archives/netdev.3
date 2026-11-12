Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450504;
	b=w79RWo30b1mCDtt3+Tc+CEb9N1v8Ft0xXtYe8r/VdtwH+atAyb+vAl7DxKRRxsWstESi
	 X+lTnptKfJ631zSorgT4dd4iibp1EwB25aJNbpN8D/7YX/GJ5J/Yzj8FQMJ+T5JWdNTsu
	 +oDafOOkFwj4b0n8AKOiLeKZ8lYfOpSewLvhSYpT1Dyu/oCaRoMqXRrnenpSckWJ+846r
	 iIZmbl7U+2u6kISr6cMspim7N8xidmfPpxb1aqHlvklwPhyAIjUtXyQe2S5z9jpa6YOwr
	 OhOXKQJ++sgB8IyjtJar831183kuhQojfrqNN34PRqT31aL12VdpDk+k/xCo7Ue+nZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450504;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=I4EKeLYusuwV9UZSDwAKboaaUngjXvxm9EAu3qSXbis=;
	b=t9Xi0E5E0sB058ZicnW8aggO77l1nRfEX2NqcBo87qGKaKN7GTofEDbxS2B7quFUBVYA
	 PqxF4YWa2UzAc3VkmIrn1j4jeoihjEy91yhzCkeHH8OH78q5GTiz5txMDgL+tf4G+LOmb
	 YN6R0bebImsijm773ebOG3bexwlEXua0SSj8mA9f9J8X0CVwrV/kKx8KRjt104J9Tbp0w
	 Zn8Uv+t89yTvgF8eFzI001hs/MYRglbIKOAvVmVMtha9ZIXCiQ87STQAh0+sczwgJhwpc
	 BLJoLwyc7ykDy5LlGIfe56yHf6PmDXZwgF45D82kn7Affpmxdaibz1iqwQuUhJs2z9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oiyhv3ot;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F5606A323;
	Thu, 12 Nov 2026 02:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oiyhv3ot
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFE51F00A05;
	Thu, 12 Nov 2026 02:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450504;
	bh=I4EKeLYusuwV9UZSDwAKboaaUngjXvxm9EAu3qSXbis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oiyhv3ot5t0hTyhk+LOCNGB2tDYfrjJmpw3GAUQuxaF5/i+FjJC+XfH+Ks40jnCRr
	 OAwtS+rwHxfwl3XxHbYmszltVWZXFd4JPMRitDyzuhT+k1QdkGk8XShwWHJTfkMOw3
	 IbNurWr+61zDP/H/GpSJ+3F+l7sIjCVhDizSFOZFJVOD8vCpPPxsuucikaduLzhl0E
	 AuZlFvmGum8z0qXl9GwDxWgCH+2zYQr3UGCdxw2HR++GMpn7wnnVKs2lH4yh8jIo7C
	 IgkEJkWhycNj10xwyajofSWMcnppyU/I/7DmlD94dhwdKVeW3h6I3GiEgoNfCEEJQ6
	 iuuQRXbNevbUQ==
Date: Wed, 11 Nov 2026 18:28:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: zhu xin <zxyan0222@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, muhammad.nazim.amirul.nazle.asmade@altera.com,
 rohan.g.thomas@altera.com, rmk+kernel@armlinux.org.uk,
 o.rempel@pengutronix.de, wojciech.drewek@intel.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 0/3] net: stmmac: dwxgmac2: timestamp
 interrupt support + Agilex5 fix
Message-ID: <20261111182822.580e871b@kernel.org>
In-Reply-To: <CAP7veT+buHRMu6f3o5RaKFdv3fABkWKgkO6KFn5js4PEeB8b0w@mail.gmail.com>
References: <20261109134506.2794160-1-zxyan0222@gmail.com>
	<179423231463.488859.16977464890948797360@kernel.org>
	<20261111152012.3506cf35@kernel.org>
	<CAP7veT+buHRMu6f3o5RaKFdv3fABkWKgkO6KFn5js4PEeB8b0w@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Nov 2026 10:18:41 +0800 zhu xin wrote:
> On Thu, Nov 12, 2026 at 7:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 09 Nov 2026 13:51:54 +0000 netdev-bot+sinfo@kernel.org wrote: =
=20
> > >  - What hardware the change was tested on. For driver fixes please
> > >    mention the device (and if relevant firmware version) used for
> > >    testing, or say that the change was not tested on real hardware.
> > >
> > > Please do not repost the series just to address the above. Instead,
> > > reply to this email with the missing information, so that reviewers
> > > can take it into account. If the series needs another revision for
> > > other reasons, please include the information in the commit messages
> > > then. =20
> >
> > You are at v10 and still getting these automated emails.
> > What's going on? =20
>=20
> As for what is going on: I answered the bot's full questionnaire once,
> in a direct reply at v7 [1], and since v10 the same facts are
> described in the cover letter.  The bot, maybe, evaluates the
> individual commit messages, where I never put the information,
> assuming the reply and the cover letter would count.  They do not,
> so the emails kept coming.  I will fold the tested-on and
> found-by-inspection statements into the commit messages with the
> next revision, which should settle it.

Read what I quoted. It literally tells you to put it in the commit
message on revision. How many times do you have to receive this?
Please either pay attention or stop sending patches.
