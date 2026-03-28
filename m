Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE529CE1;
	Sat, 28 Mar 2026 00:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774657571; cv=none; b=YSlkj9iLhlvooSGb0ENsYgewb1Ueh7PNf7OI4E9EEEGgVsIO5JKhKvv4O/sAg+2mrMsS+R9WY871G7I0qV0hGqfnqGvGXewtGk5+Hih/JcG4zyCxiwHkAMl0/0FXlniYAK5ScKZT5qDWaW3ZNz/5Rxen5CdAlMF8hKpialtINYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774657571; c=relaxed/simple;
	bh=On3JLPKP5M4KBigXQBxIRUwwWe4X/XKC7AZ+Vp4kLyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAZy2p0ASh1moAlwaViRwKyyfW97TXwqRzV473v/7YtfmYt5hsjs7yNlPw2hCUVf2rj+MBpqsOqGtKWNjW7CsC50U0/Z7B9BIkAe6FuicPwGdyJWc3JNEF/SWQ2oONmdf1n6APocC6XHQ5coQEbycSYpaiTaJ15s4KJYAiJw26Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+PuOpZG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+PuOpZG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3857C19423;
	Sat, 28 Mar 2026 00:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774657571;
	bh=On3JLPKP5M4KBigXQBxIRUwwWe4X/XKC7AZ+Vp4kLyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g+PuOpZGW2JtAseTNOwv/pMlZhrhxREkqtN6RWlKTMzrVVWciJ7J8xbWce8lk/jrq
	 n3u2RjHmCz3JrLOS17BoT4qv8K/mEXUmwCz42ne+58B7aMpH9v8KjdTeH4MgZv/2Bk
	 nq8f1p6T6Dpf48cnv5ZsFjp2kPhvdx9ZGhcRdxgZZYierLcKEmQDNu4XS95s6l8aED
	 MkTUeJtq3xtiMONmvodcMBiuv0xtbm6cVEO54DPCfHYpgdDv9h1Fhg50dWiUFxBz48
	 jwgLaYY4V6oSRW3NvCHy3mSa4YYzTkbi5fDWKr8nUPsTXOLzjkZz9bzaYEhuThDX5B
	 0WdpGuFHoXANw==
Date: Fri, 27 Mar 2026 17:26:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Chuck Lever" <cel@kernel.org>
Cc: john.fastabend@gmail.com, "Sabrina Dubroca" <sd@queasysnail.net>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, "Chuck Lever"
 <chuck.lever@oracle.com>, "Hannes Reinecke" <hare@suse.de>, "Alistair
 Francis" <alistair.francis@wdc.com>
Subject: Re: [PATCH net-next v6 0/6] TLS read_sock performance scalability
Message-ID: <20260327172607.1ae2bde9@kernel.org>
In-Reply-To: <722ffab1-f3d8-4309-afa0-482d64ae3a33@app.fastmail.com>
References: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
	<20260326175430.7ceff326@kernel.org>
	<722ffab1-f3d8-4309-afa0-482d64ae3a33@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 09:35:09 -0400 Chuck Lever wrote:
> On Thu, Mar 26, 2026, at 8:54 PM, Jakub Kicinski wrote:
> > On Thu, 26 Mar 2026 09:50:45 -0400 Chuck Lever wrote:  
> >> I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
> >> NVMe/TCP) to coalesce on the use of read_sock. When I suggested
> >> this to Hannes, he reported a number of nagging performance
> >> scalability issues with read_sock. This series is an attempt to
> >> run these issues down and get them fixed before we convert the
> >> above sock_recvmsg consumers over to read_sock.
> >> 
> >> Batch async decryption and its submit/deliver scaffolding were
> >> dropped from this series because async_capable is always false
> >> for TLS 1.3, which NFS and NVMe/TCP both require. Async crypto
> >> support for TLS 1.3 is a prerequisite for revisiting that work.  
> >
> > Please repost the remaining 5 patches  
> 
> To make sure I understand your request, do you mean the TLS-related
> patches that are pre-requisites for Alistair's KeyUpdate series?

Oh, no, sorry, we merged patch 1 as a Fix and shipped it to Linus.
I meant to ask for you to fetch net-next, rebase and repost.
Patch 1 should "disappear" (unless I messed something up)
