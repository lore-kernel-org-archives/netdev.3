Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630323AF645
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278278; cv=none; b=DRWC+2QiOOZFesE6yqsN2Bbeua63J1Ktm2A8XKQV2flxy6d6ow/ko10qdP8G38Sk1c0rIeBy7CuGn714luxN8syj39hpNS3I1aaje0ZBiZgzrKEPrbq7aL8MctRXBnBdRxbQ1pU+svurjhI3DyZ/9rcwkMenfH1UoMQ4MhccXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278278; c=relaxed/simple;
	bh=frEgjw0erdjxTrqiFxMGCG/YbjLLl2VDnjsr9+K6RZ8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RZ0OfwnFwBGpwaEqOojn9UIDSL07ZShKydQapw38M01EN1hQjT/XyZE/8QT8PE0HEHrahNX4/VRyKCOTUQr67NLPT9hr57nsBOn/Tl+XoPtBNPpkm+OgjR9mIUrXmZFypV00R9zBpqCqrb2/Bmuen8AYAX1uyvLfGoqnGxUxQVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aW9g4cS9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aW9g4cS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D179C2BCB1
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774278278;
	bh=frEgjw0erdjxTrqiFxMGCG/YbjLLl2VDnjsr9+K6RZ8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=aW9g4cS9bpMmpYsH/HTNdRP9rUsqPXP1eiX08fPXj+NSzMBhPlr9MnEVNdR+eIy7c
	 aKJZEdGtMgr5FJsaPT6zHUkvGBPBz8czDPWrd7wS3uk0UrZKAXbSQHLbE/J2NpC5On
	 RnuIlg6so0bkFZdbO2lepNUgC3gVNFa4Zq/4UXaot/wRXwbt1Bkx5zWB6vH5coD0nd
	 t32Xw7X/PbSLGqJinXweP71GfkewyqW65ntKPGn3BPZo4e7TN6w+QTG7TBPSAtffKN
	 P5mAIL88unI1G2yb6puYaxwK5jm7VoH+l/jQ4eavpNfzmLDufabEGX7IDKXbNNg5Cu
	 08MeYKjCIzc+w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 21F20F4006C;
	Mon, 23 Mar 2026 11:04:37 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 23 Mar 2026 11:04:37 -0400
X-ME-Sender: <xms:hVbBacUYLEtu6WTBTyu6FpPGK2fUAkPiQyMOS_vVD5DAGf420hYDnw>
    <xme:hVbBabZdMicpyuVktGTmtr-g5vjqwUh4O7plxplxCoHvwwhIjKqkJMtu1N_p8zJCe
    iYjovMqBMd3ylyKOMsk0KynH8uU7uEbuWc66AhKIyU3mbr_HvLKYzI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthhlshdq
    hhgrnhgushhhrghkvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegthh
    hutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehsugesqhhuvggr
    shihshhnrghilhdrnhgvthdprhgtphhtthhopehhrghrvgesshhushgvrdguvgdprhgtph
    htthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hVbBabxkS5feHi0rkuBJsxGL9VDNrdeKzlfcSyEbWe_DxW8WnWMYdw>
    <xmx:hVbBaa4nxYCwk1dneeuEVzTiWWPjc-Yfw76LTC6tkuLbx4kL-yMIsw>
    <xmx:hVbBaS80afxtp8VnAqUfxKcRGY5jhdrUcFHYlc9TPicgSotMZbQT2A>
    <xmx:hVbBafovjm403Mv6MCXQjUk0byaD9n-7W5OAzlVszJC3uKAZdNQENA>
    <xmx:hVbBaTonBk0KXUypAlCE9n8JZU3qaNgHCqmpgdwYMreYwMvAuuS1p4Sz>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ED8F8780070; Mon, 23 Mar 2026 11:04:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARm2f9X8njS-
Date: Mon, 23 Mar 2026 11:04:16 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Sabrina Dubroca" <sd@queasysnail.net>
Cc: john.fastabend@gmail.com, "Jakub Kicinski" <kuba@kernel.org>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 "Chuck Lever" <chuck.lever@oracle.com>, "Hannes Reinecke" <hare@suse.de>
Message-Id: <5190a4bf-cc66-424e-9c67-ffb3ddb58030@app.fastmail.com>
In-Reply-To: <acFK4DWAD5h_Oc0f@krikkit>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
 <20260317-tls-read-sock-v4-8-ab1086ec600f@oracle.com>
 <acFK4DWAD5h_Oc0f@krikkit>
Subject: Re: [PATCH PATCH net-next v4 8/8] tls: Enable batch async decryption in
 read_sock
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Mon, Mar 23, 2026, at 10:14 AM, Sabrina Dubroca wrote:
> 2026-03-17, 11:04:21 -0400, Chuck Lever wrote:
>> +/* Bound on concurrent async AEAD submissions per read_sock
>> + * call.  Chosen to fill typical hardware crypto pipelines
>> + * without excessive memory consumption (each in-flight record
>> + * holds one cleartext skb plus its AEAD request context).
>> + */
>> +#define TLS_READ_SOCK_BATCH	16
>
> I suspect that at some point, we'll have a request to make this
> configurable (maybe system-wide, maybe by socket?).

I appreciate your careful and close review. The series has
improved significantly.

I will admit that the current value (16) is arbitrary. I agree
that someone might want to modify this value. At this point,
however, the constant is straightforward and it is still quite
easy to promote to a tunable later if that proves to be needed.

The right interface for this depends on kTLS consumer needs
that aren't clear (to me) yet. But let me know if you have a
preferred API mechanism or a specific use case in mind, or if
there is a netdev policy that should guide the introduction
of a suitable API for this purpose.


-- 
Chuck Lever
