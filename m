Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8414A37E2E4
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301331; cv=none; b=dDyfpSoZnWZwB+vHy5jgqsLI5fWGnYTA61HGLGIZvdMiz18nIxqyF9PNpwVfLxIhSsKfVzxElnS7Zx1CAkjX17IZVrYEq89LqasdBp2Q/kydo1Fe3jc/NOi2uB11ToCCtuWmtety55QUzCmU3L8R+l+8qz+wq++zPPHVn7RF9Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301331; c=relaxed/simple;
	bh=iFHXYqvRBdwvkdXNooRiDzrtFdJnqwoA5J3JKRxhbt4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZpfuUT5nImdJ3zPSINPv4AO328WaaNnDVv/rKN8i4aHPdmqtWCnFjeZGOsyU6+8AR8EG6bOQZsfL0jV/7hFBYtFj6BO/AdOJ5K3lCS3ew/LDx63HGtht0/H+pyGB5zQlG4gCqdvrrfizPyuIdgBpSZOI2pXpF+U5t+IKRbESp+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fx1hQRVe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fx1hQRVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0674C4CEF7;
	Mon, 23 Mar 2026 21:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774301331;
	bh=iFHXYqvRBdwvkdXNooRiDzrtFdJnqwoA5J3JKRxhbt4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Fx1hQRVefEPEvVdpj9D3Jd6lfzTLqDSC6l2s+CNz05wFT+9dzGgx4yjEQQjAQGtw4
	 9m4562/j4RZInm6taI8ES3qX0lrDckBEL3wE5tJlDLaEacMAL/McJmncSEVDUHbrzz
	 0x/KuQhjk4/7QtLzLrXBXYoKvqvDjsR8W9AFbdcfwhlXI4s2Xec03bnlXwmsi9oUQB
	 N6jB0nwotVXDEFLtETE5MGmkm+OMEJQxkkhicOANWLNWsRWeUHZBkSditJxiwMGlbk
	 Pu6wtoTYfxLV81K+WiOMNlY7VZ+Uxrw56dJDmCEx8Y6ZthRBJdt3j+DzxqT1GCpbFl
	 D53hj2l8SK7zQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D4FA5F40076;
	Mon, 23 Mar 2026 17:28:49 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 23 Mar 2026 17:28:49 -0400
X-ME-Sender: <xms:kbDBaZBGAEx0if9XPit4xnIN2-yaineJCjfKBIHCy3w4RRL2CgedUQ>
    <xme:kbDBaSU_0mMfroYa4X9flqWBRC8bQXnXjYR8Trlq5NvQ2pRW-PtbmuDoKUmqPQwgl
    Z3HibakafuepzDbCAEia1jml7xYgIluxBp3C9YY8ORFIcivomAxDnk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeljeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:kbDBaepUC7dOQqZLSNnrSLEtbuMES0oFkCWiIV2Ug1T_DcNIDE2n-g>
    <xmx:kbDBaWvDIqTJbjItXokbkaNSFx4TEXc8gW3qATx2U_taYSoNiGc17g>
    <xmx:kbDBaTGy3YITxmie1cvlAXGAVeRQWGoi0nj7OR15k7QvVcGQ1vhlCg>
    <xmx:kbDBafbfEThgcZdyruZX6tw0H0uUtMfABFdXCoYp0_Lu6JbLVQZBaw>
    <xmx:kbDBabUdKE3nSooAftRofX394xerMJLzWJ4amc2C1drKZcWBlwWiWeJu>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AB55F780070; Mon, 23 Mar 2026 17:28:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARm2f9X8njS-
Date: Mon, 23 Mar 2026 17:28:27 -0400
From: "Chuck Lever" <cel@kernel.org>
To: john.fastabend@gmail.com, "Jakub Kicinski" <kuba@kernel.org>,
 "Sabrina Dubroca" <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 "Chuck Lever" <chuck.lever@oracle.com>, "Hannes Reinecke" <hare@suse.de>
Message-Id: <0cf288bb-6ab1-4f2b-8a7f-727b3e1fe0d2@app.fastmail.com>
In-Reply-To: <20260317-tls-read-sock-v4-8-ab1086ec600f@oracle.com>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
 <20260317-tls-read-sock-v4-8-ab1086ec600f@oracle.com>
Subject: Re: [PATCH PATCH net-next v4 8/8] tls: Enable batch async decryption in
 read_sock
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Tue, Mar 17, 2026, at 11:04 AM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> tls_sw_read_sock() decrypts one TLS record at a time, blocking until
> each AEAD operation completes before proceeding. Hardware async
> crypto engines depend on pipelining multiple operations to achieve
> full throughput, and the one-at-a-time model prevents that. Kernel
> consumers such as NVMe-TCP and NFSD (when using TLS) are therefore
> unable to benefit from hardware offload.
>
> When ctx->async_capable is true, the submit phase now loops up to
> TLS_READ_SOCK_BATCH (16) records.

It appears that async_capable is always false for TLSv1.3. Since
TLSv1.3 is a hard requirement for both NVMe/TCP and RPC-with-TLS,
patch 8/8 is moot for us. For the moment, I'm going to drop this
one from the series. Once Alistair's KeyUpdate work is merged, we
can revisit.


-- 
Chuck Lever
