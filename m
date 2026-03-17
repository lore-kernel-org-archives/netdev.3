Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C791B2DECDF
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783287; cv=none; b=X9x3hRhl6Dcfrro8Hpz9g1KlbvxO+KcGocmUCTuH1xsya3VdHnBzQ1psP3v9XRykrwBozWEUlYEiJoIcXEgUs9k9eeipQqnpnXYz50IO6gkaLIcIqAvSHsmvFYA6dYHaQBfiyGjeYVS/VTx72A7Ttsg1jqUSfhdr+Bji/aC9ncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783287; c=relaxed/simple;
	bh=d0cwXvOjI11ZY13nW3X2ya+7wrMvgoGJkq25vvIj4pc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfqrIqPwjSaqQAh5ASTmvBMNQ+uAGU5OGXWgvthfE5sWhLSdiw5YAr/hTQ6LSly/gOrIS0W0NbdlD6vDOYlQB7CEmLEDl+/WEk0bZX9lf+tMB+acIuriZqTr0wmwgpNhm4uTsEGCErqw9Erc4MLe3/9E96EPBEfGRvxoQxVEGsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTEyT+FV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTEyT+FV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1381EC4CEF7;
	Tue, 17 Mar 2026 21:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773783287;
	bh=d0cwXvOjI11ZY13nW3X2ya+7wrMvgoGJkq25vvIj4pc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WTEyT+FVRbDebvIEc8eunY63FzQAh9RqFry5DQ15FwD4cL4p0ig+Kw5pMGvvJnztu
	 S1XN2wpyhYRlNRCFcXxv25oiZAA3jtNcNHccx6eaa0lKdBOIolbuBc2omzmb7kNHtd
	 f5X5hxEYRSJgZME3eKBUY5MY8gOs1r74JoPse8CgS7BjMCV6Xh0bONXqKtJxHCwJfS
	 9JbesWbypodYJOEGty6S6zi5/3iKX7g6FL/w/xDHLyA7i9a2E+vzb+qUa6wOPsm3P8
	 ebn18tzaAUMH2gmsJ3HVWngscGpgnUNhB5FAM1vXuPpkbWBqDpED2jHb80WOj6Q4f9
	 gU1jPHsz4JOwQ==
Date: Tue, 17 Mar 2026 14:34:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Zinc Lim <zinclim@meta.com>, willemb@google.com
Subject: Re: fbnic qemu is open source
Message-ID: <20260317143446.4afabb97@kernel.org>
In-Reply-To: <CAHS8izMBx3j1nJwJ=b+ctGoJuEgTtMx8WsH2y-W=Sine+wo_3Q@mail.gmail.com>
References: <20260309113852.2c654de5@kernel.org>
	<CAHS8izMBx3j1nJwJ=b+ctGoJuEgTtMx8WsH2y-W=Sine+wo_3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 12:41:39 -0700 Mina Almasry wrote:
> > No plans at this stage to upstream it to QEMU because TBH I don't
> > expect that QEMU would care to carry random HW emulation drivers.
> >
> > Sorry if the announcement is a bit self-serving but folks expressed
> > interest off list in being able to test the queue API and zero-copy
> > Rx without real HW so I thought it's relevant.  
> 
> Wow, very cool! (Sorry I missed this announcement initially) I'm a bit
> of a noob but I'm a bit surprised a 'real' driver can work no qemu
> with a bit of magic.
> 
> Is fbnic-on-qemu about as feature-rich as fbnic-on-real-hardware? Do
> most of what it can do on real hardware it can do on qemu, or is it
> just really zerocopy that fully works?

We implement the driver and QEMU side by side pre-silicon so the QEMU
should cover what the driver can do. Keep in mind it's a pretty simple
NIC, even "in the flesh".
