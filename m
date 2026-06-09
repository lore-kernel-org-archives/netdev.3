Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB083168BD
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039957; cv=none; b=IpffOIdXr8xFzQ+r1cJ1vEUIdy6UJVhdnmV6zcGQZkzgIzolnT2qzcNRuuSq2tp73oHnqqWyb3vbBj1KVVBHI+cmkujpTLZIe656nPLSj4tPa0xMIqEmU7EN7qHqMKja1J+LaWchH0q3yRILxLI6H7bjzV4EojUYdk3uuRa52W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039957; c=relaxed/simple;
	bh=Uu/VLAYwovDRZw5IA/bQxpqgrQF6/dN7Qn1UZ4h9EjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXMdKswvH4InpuQ7GASQuaopg45SZ+k248e2MDtArahfVrVY4FCf+wrue29JqfEDrPIuOYvkpx6Sh74TJ8uPv7GhlN2FR5UxzklYfhfH7VdxJL2yQoqcop0sWCdiLZS8mHL/yLPJkxkEfzl2wZzzy76VHiPNpBnxDTzWwMThWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAp/pDUV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAp/pDUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5A31F00893;
	Tue,  9 Jun 2026 21:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781039956;
	bh=Uu/VLAYwovDRZw5IA/bQxpqgrQF6/dN7Qn1UZ4h9EjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cAp/pDUV7Z6JdeZvCDfXMDY1C6ZTrAlHEqHq60YalxUJoIftmfurpscOfiFZUZwcq
	 Q5k3bfjZVeV2UAZma7xwRpryVvoyACMGR3C/XAbei0QwyFMAY7OBgVpAD3QPD8YHVo
	 i3sF1IDrrg4dDVZO9niPi1jMefAk8ko5KV9qdYxuPXFInhZWc+OkVtilxhVAA8qGNO
	 QCavvvzWQypPifoRwJ8XDgnqwrPnVRAdwwMEVA9Or1uN7MAA4y/9wk17y7I5CFMM8C
	 Qfp61bsb0VjRPEYPWTo5WPM6N3g3XMhbqLT6rtErBEt//nGQWDq/IbHGoLvd5CUIKf
	 Omm9roou0dg0g==
Date: Tue, 9 Jun 2026 14:19:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, dw@davidwei.uk,
 daniel@iogearbox.net, razor@blackwall.org, sdf@fomichev.me,
 dtatulea@nvidia.com, bobbyeshleman@meta.com
Subject: Re: [PATCH net-next 3/4] netdev: avoid skipping objects on race
 with device disappearance
Message-ID: <20260609141914.2957de35@kernel.org>
In-Reply-To: <aih0ST30H9rlKX2f@devvm29614.prn0.facebook.com>
References: <20260609190804.1137085-1-kuba@kernel.org>
	<20260609190804.1137085-4-kuba@kernel.org>
	<aihwlI9A2TKktq9I@devvm29614.prn0.facebook.com>
	<aih0ST30H9rlKX2f@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 13:15:05 -0700 Bobby Eshleman wrote:
> I just noticed we handle this differently in rtnetlink with
> cb->seq/dev_base_seq/nl_dump_check_consistent(), but it seems like
> netdev-genl.c intentionally does not use NLM_F_DUMP_INTR?

Intentionally is a strong word, but yes, it's "known".

My mental model is that DUMP_INTR is required when we are dumping
unordered lists. In those cases we just count "how many objects
were already dumped", so if we dumped 4 objects then object #1 is
removed the dump will resume from object which was previously #6
thinking that it's #5 and #5 will never be dumped.

In netdev objects have ordered IDs, we don't count.

But in theory we probably maybe should also indicate consistency.
Nobody seems to care in practice.
