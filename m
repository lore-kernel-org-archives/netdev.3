Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF97826ED3A
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773968653; cv=none; b=WLrqsp8nENxQxKBCPkcZ8RHNksya5JZlmEnTePApiVVdOntWDrvEBpq4DFE+tssW4TIB1jpKpAc6tt0BTCWpVg9r+Bvt/nGGIBYh1zAWQAZZVHGePGLbTXymwv7Pkg1Hce9Bj6V/eHDAXzVu79T76ufiUu+ts0b8n+m0c0/FWH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773968653; c=relaxed/simple;
	bh=7RyVtDEp2frpwWJXV8qua1VPrSBDido9rjx1E90ngrs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TSVaM8YPSZy0bheBw5yU+y22gCjHZmpOAHpwnnNM0+Jnq6waQE7LX7j5FwYZt2UIM8gL4RoyKUNSe28nG869oxrsDvYh0H9Wwph9fP3X9keodM6z9E75O9VHpQiAFwDTAm0nd0XD26QQpzhTO0f99oAGKesGmsf1Qr6Ks/f+qGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icXP7hwx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icXP7hwx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124AEC4AF09;
	Fri, 20 Mar 2026 01:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773968652;
	bh=7RyVtDEp2frpwWJXV8qua1VPrSBDido9rjx1E90ngrs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=icXP7hwx09PiOBuBhqv0h04DQTKBZtcDYqF1x5+HOS61xIzsagbadytztaaYwvrvb
	 a4RXT9hRCVtCStx+rr8eBIUxNULyglCSeZmgNNn25dTSTmJqAOHxmp5upYsK0fQvGF
	 +QZjZ1lIl/6VmJr7wSxcOjJXrKx+jUbQPkOKoY+4ZU1ykbwMNiAwOml49ncBFjbpfc
	 iIxCyk9gCMBAgVpHW0+0dczXiZWJbTYWOO2pJB5LdxQ9N3GbtloCOab4M8G0WU/rj6
	 kMDBh82vcIp/+vdwhvDQ29/xlydGjd+ri9Fbre2PVBnEk/nFXwMe3R8lhiYQK2L+0u
	 zSax41vDJ5kcw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8DD15F40069;
	Thu, 19 Mar 2026 21:04:10 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 19 Mar 2026 21:04:10 -0400
X-ME-Sender: <xms:Cp28aftAmSyEvlo6LcZhvAnU8FgXj6DOJA-eTp1vc0P842n0pjIAxQ>
    <xme:Cp28abQAlRoU-Q0E81g1ZJYXTVe0IpjDGKSy1l7TfjaGywYbB3eyfvFIFuE92xOcc
    zbGYgWCsbyeIz78PB2mf2XCr5p3WPLQ1X_84E_Il45BaTt25ymbfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthhlshdq
    hhgrnhgushhhrghkvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegthh
    hutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehsugesqhhuvggr
    shihshhnrghilhdrnhgvthdprhgtphhtthhopehhrghrvgesshhushgvrdguvgdprhgtph
    htthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    lhhishhtrghirhdrfhhrrghntghishesfigutgdrtghomh
X-ME-Proxy: <xmx:Cp28aTPd-1b6h5JygJN4qw7T28ESN210JqRcmAYeL4glBf6K8zRAMg>
    <xmx:Cp28aZ_-tFeHtUAxuHTtVJo20Oz8omipMVdM5BJjhhHXtOte7DbJ0A>
    <xmx:Cp28aUeUKhRgjp-3-kfWohOjIAerywejnmmyweiglOFksNwDJM9rAQ>
    <xmx:Cp28aYzMgE222idMPLaUfdYNKQJThH4WMNdL4qcV6VWNi9vZ_BrITw>
    <xmx:Cp28aZK0yjcKiexUj5gbNEN5MrKd9uam5Y0AQ_QNUdMQy-XPR0gwRRl5>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4DE64780070; Thu, 19 Mar 2026 21:04:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ASczzVKs9p-7
Date: Thu, 19 Mar 2026 21:03:50 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Sabrina Dubroca" <sd@queasysnail.net>
Cc: john.fastabend@gmail.com, "Jakub Kicinski" <kuba@kernel.org>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 "Chuck Lever" <chuck.lever@oracle.com>, "Hannes Reinecke" <hare@suse.de>,
 "Alistair Francis" <alistair.francis@wdc.com>
Message-Id: <a522e156-334e-4c3b-844e-dc92b5ccd358@app.fastmail.com>
In-Reply-To: <abwwf79GJ69X1Wim@krikkit>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
 <20260317-tls-read-sock-v4-1-ab1086ec600f@oracle.com>
 <abwwf79GJ69X1Wim@krikkit>
Subject: Re: [PATCH PATCH net-next v4 1/8] tls: Factor tls_decrypt_async_drain() from
 recvmsg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026, at 1:21 PM, Sabrina Dubroca wrote:
> 2026-03-17, 11:04:14 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> The recvmsg path pairs tls_decrypt_async_wait() with
>> __skb_queue_purge(&ctx->async_hold). Bundling the two into
>> tls_decrypt_async_drain() gives later patches a single call
>> for async teardown.
>>=20
>> The purge is kept separate from tls_decrypt_async_wait()
>> because other callers (the -EBUSY fallback in
>> tls_do_decryption and the tls_strp_msg_hold error path)
>> need to synchronize without discarding held skbs that
>> are still awaiting delivery.
>
> Sorry, but why do we need to keep the encrypted skbs around in the
> async_hold queue once async decryption has completed? I guess I'm
> missing something.

Ah. We don=E2=80=99t need to keep the encrypted skbs. v5 will address th=
at.


--=20
Chuck Lever
