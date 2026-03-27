Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEF33EB7F1
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774618531; cv=none; b=pKoSm2EEuPNczuACQismqove4UWnUzbK+ND0jh0bqZjN45z2YzNJ7RBTxXF9UCX3xo1UbPFmEpy+UO/fL3q/1XzfLTeJ9NAEvfVtqqMwZ34vT2eYPCDDGA5rDk+fRsAaa32pXeUz0b7fok8tpBOtzOlxdZkNO86JzddpMdQS7x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774618531; c=relaxed/simple;
	bh=2TbzwF5ZIPUJDVk8ccrQeQtWoeR8aD2t2U7FV88ABPs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YEyi7LTGyYXD0Rbsj/BsGZew/1s0WArTH0fESwr/6w3U0rS6ocJqh4oEszUa+Hq1jXTP32knjG4yngTds1GRpC6ngv3+Zokz9HjiiDFW2EyBT1dfAl7OmFSigHdgSCyEi8ALaatMJnRfyWbeYnILvbSet4grN7lru9nuU3JF2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqJicNG3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqJicNG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92DEC19423;
	Fri, 27 Mar 2026 13:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774618531;
	bh=2TbzwF5ZIPUJDVk8ccrQeQtWoeR8aD2t2U7FV88ABPs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NqJicNG3+QeJ+zTJW4/29cnPlhMnp3GQWpSZ5yzb3XdaeYU43GD8GekQoEXatFr3/
	 YEixfQQq7YhFh/f3CQqxc+cTKjeyFiMsQx8TwYlHoPJr9dYizGpoWq9LZP5G8nSqCj
	 q3UG7TjXhl3nMtYar+ySe3O5DjBy1EvskZ6Zpsz08YS1x4lEpTdsXoogABM6wG4SMF
	 5z0rtaqepMIXafqLdmHNvRVWOekpP+279axny7gWachdaci0FOaEW4FBEMgiY/d/rq
	 Gg+LtBYcHruBzkB/J5D7eLTFJg1wG0pHXuFjeD1UeL/TgRI0rY2An4MfuPzAupfEgq
	 CYdzmOHy8mksg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id BC682F40068;
	Fri, 27 Mar 2026 09:35:29 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 27 Mar 2026 09:35:29 -0400
X-ME-Sender: <xms:oYfGaU7KGPf5P4AERkumW7ccvNc4adLZl-gkntNHBejPAg9CmpWFXg>
    <xme:oYfGaQsLx3oQXZ6MM2NgG9SKg2fToGFcHmSidmcPdBoVaQspx-hG-6ckQ2xxD56y4
    VmzOaTvUbUebqkNNq3qjjWlFNe25rbDCq_4y0C0fEUi_d-jukuVkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
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
X-ME-Proxy: <xmx:oYfGaS4SknQuvo_bsOe98Gyq84MDAAo7duxoilx_CWlVuWjKDckNLg>
    <xmx:oYfGaX4Pp2XOdmhKThzzi76GR1G1qeHxc2F1eLEIJnp-Bonvo9n6og>
    <xmx:oYfGaTod-G5H1kpBHblAWCIl7TRyhyssIFACZUuTGVwxhaThCB_lHg>
    <xmx:oYfGaQNuEppg081DLrGJQtsQCu_zH5Lp2JBBkr8T0MaQJv22HcN27Q>
    <xmx:oYfGaT1ekbTGiyyxeSi1Ccsu1AqOr2XpDoKCXpLQnLMIrTJXAQ4CDf-R>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 93CB4780070; Fri, 27 Mar 2026 09:35:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZMYyhYVmGo7
Date: Fri, 27 Mar 2026 09:35:09 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: john.fastabend@gmail.com, "Sabrina Dubroca" <sd@queasysnail.net>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 "Chuck Lever" <chuck.lever@oracle.com>, "Hannes Reinecke" <hare@suse.de>,
 "Alistair Francis" <alistair.francis@wdc.com>
Message-Id: <722ffab1-f3d8-4309-afa0-482d64ae3a33@app.fastmail.com>
In-Reply-To: <20260326175430.7ceff326@kernel.org>
References: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
 <20260326175430.7ceff326@kernel.org>
Subject: Re: [PATCH net-next v6 0/6] TLS read_sock performance scalability
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Thu, Mar 26, 2026, at 8:54 PM, Jakub Kicinski wrote:
> On Thu, 26 Mar 2026 09:50:45 -0400 Chuck Lever wrote:
>> I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
>> NVMe/TCP) to coalesce on the use of read_sock. When I suggested
>> this to Hannes, he reported a number of nagging performance
>> scalability issues with read_sock. This series is an attempt to
>> run these issues down and get them fixed before we convert the
>> above sock_recvmsg consumers over to read_sock.
>> 
>> Batch async decryption and its submit/deliver scaffolding were
>> dropped from this series because async_capable is always false
>> for TLS 1.3, which NFS and NVMe/TCP both require. Async crypto
>> support for TLS 1.3 is a prerequisite for revisiting that work.
>
> Please repost the remaining 5 patches

To make sure I understand your request, do you mean the TLS-related
patches that are pre-requisites for Alistair's KeyUpdate series?


-- 
Chuck Lever
