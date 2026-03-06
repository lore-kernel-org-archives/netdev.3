Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CF3271A94
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807651; cv=none; b=Y+EnM7unWcx6z5Njfj4QDjvAwHK0W4gk85zcKCaBtOEimF3Qw0w/AhuK277nHPv0nCEwCmHRe3DyAjlEdKn5A4CcxDThfTl9C5CNzNDyfp/LPD/XvMwWqlJ3kgQBjrfnZNaZsZFZZ0hPHlrbR/6nNsW6e2pMuou28nImI4FaKUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807651; c=relaxed/simple;
	bh=IUXM/V0vQQ1M7CEmIuWmH7ES1RuOyROTK/vGA3CMs0g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=p1GuJ1ewKJhWnlVbmm692wD7KY8iIFsF3lg4ObHnxPWHAY63EjeH0wHkN5ZPV5aKQCIo+zcANYnb3RFoEWYLqNCIq0rYQP+I7apbxyTnqIRLb5OpbraAHw6fHlEeNSTRWYX9dHw4YJ5re6l8ZA0GIrtcgiyHVtq0sBcRP5aZADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVAxW3uW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVAxW3uW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C96C4AF09;
	Fri,  6 Mar 2026 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772807651;
	bh=IUXM/V0vQQ1M7CEmIuWmH7ES1RuOyROTK/vGA3CMs0g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=WVAxW3uWpKc+RfvyxXUgIE45h44j635gcBEmXyENDbxX5zzQg4rWVlLec7XApxiHa
	 eQxHejONc1R0+gJZ6nhxUzij//j8mqBW2cfsPNEpxIBg0dr1O6pfZM2f2cfytYUn9O
	 Aw3yoAYd93TcpxAHnm+eUafrWJfpD3X9joUn5L9a8S6ZIJQD4U8bZjfC5wID/+t3xo
	 FMdhLlINnpBLZZsUDbnM/lPLFmd/VnhbbXiA98+psXozVJmVaum/yjdrXeDSagiD4c
	 XYqn+ciFNM0q1vIzkddJcQgPHyOiFnlIzptXytvo/ujHEvfBalkVTQ+r+Nvb5lAl0i
	 fTDIdJ4mUvmwQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id A6A3FF40068;
	Fri,  6 Mar 2026 09:34:09 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 06 Mar 2026 09:34:09 -0500
X-ME-Sender: <xms:4eWqaU1nrJoUkGZWuGnS_v25uA-FvzBB_tId48xBjXdlzQdR_cdo0g>
    <xme:4eWqaZ79wZwiS9rxF5C_YfFCqW8AcQYB2hEWvm3XDQ41a1s-dE7707wYhEGnEIZSa
    Q2qctY7rHy_eXzxEwJsd9-yhscROTX4hIKEvMt4tlJGzYVx40MKHp0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieelheegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:4eWqaXVeeS8QgXqC_JCYOXG0OdWL3lVuVgbNFH9dYkCPfqPSwseClg>
    <xmx:4eWqablTHqzuDsDlEIlH4dfoWPpZeWd94zluKAnahyYH580nu_jeTw>
    <xmx:4eWqaVkscafG_uYAJTd1CWBq3MOhoHdrw53ztWbp4skuoikQGMy-3A>
    <xmx:4eWqaTa4xzu6UAZMARiiiPAvV4lqdcBn36CY1yRFTfG32DjG8iO-pQ>
    <xmx:4eWqafTHbxDfQ2tPeN9BDZHjVcGjTXnk4oQrwL1f_rxsEc-skucuu9jY>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7CD88780075; Fri,  6 Mar 2026 09:34:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AmC1BHMyQyic
Date: Fri, 06 Mar 2026 09:33:38 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: john.fastabend@gmail.com, sd@queasysnail.net, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, "Chuck Lever" <chuck.lever@oracle.com>,
 "Hannes Reinecke" <hare@suse.de>,
 "Alistair Francis" <alistair.francis@wdc.com>
Message-Id: <34d8051f-b985-4d33-8e8c-52f6a6c1b445@app.fastmail.com>
In-Reply-To: <20260305141954.1f6eae5e@kernel.org>
References: <20260305211402.39408-1-cel@kernel.org>
 <20260305211402.39408-2-cel@kernel.org> <20260305141954.1f6eae5e@kernel.org>
Subject: Re: [PATCH v1 1/6] tls: Fix dangling skb pointer in tls_sw_read_sock()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Thu, Mar 5, 2026, at 5:19 PM, Jakub Kicinski wrote:
> On Thu,  5 Mar 2026 16:13:57 -0500 Chuck Lever wrote:
>> Evaluating a dangling pointer is undefined behavior under the C
>> standard.
>
> Reference?

ISO/IEC 9899:2011 (C11), =C2=A76.2.4 paragraph 2:

"The value of a pointer becomes indeterminate when the object it
points to (or just past) reaches the end of its lifetime."

For the next revision of this series, the patch description
will include this reference.


--=20
Chuck Lever
