Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76082D8390;
	Thu,  9 Jul 2026 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610303; cv=none; b=YWmPM/fdmdkW7D8Gnx0OEXxEOy6eJQFwngVp3lH75yB07suqbZdssI8bT7R5quTsQPTV2buXlbRPB2uwa6rUJP/Ca2mRjRic2tgwGLJiPazJAbgmCAZqPrqEOKxbaM4xz+U6HlU6pNOO9MKeNsoFIPajyA4x3zeAMHPGcXbjlGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610303; c=relaxed/simple;
	bh=ozsi8af3eKcUNLT7SWEsOWvjgBHajmHy5YipXpm1PSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIxYML6WP+QMHVbn4wqdRBh0N7RiSjmnvjyf8QQBrvyCqiOyJDX1ciKeAP424YgnuOVvT/hbi4+CeqPZ+XDBqEAux4FI63ZdteITFuG1D44IdKoM+dxyI8wiW0huF3hLrsfoDcvBXCGsSaYZe2ZJlhy8sUrn7jKv23F+I2gh9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkuFkuBL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkuFkuBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE71F1F000E9;
	Thu,  9 Jul 2026 15:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783610302;
	bh=SfuO/pPdjlZJQxgkFs93iohn5ceq66H7Sq53ER4LnqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MkuFkuBLNaqeXaHYbNDHtzySuWTSo9ngj9WS9N57rZlHh3nPgemFlTnfjkyGGmxeb
	 j77hSrLhXVX8zOmO5DCmJO1h+xOxo3HKHycHpddbAgAezJK2lShNqRsYL9mIs9zPmL
	 dENkOpo7/yPJXervBqHMt5gKC+0G/a4kMNcH33qf9xKsP90AAa76D+QeRAYBiX1lOi
	 C1tER6kmYnl5AiCWbq+Y2HViFwHXaNB/DwYfkV3L8TQ5qJbbkvv6ooF54MAHi8ukJo
	 2NZ0Q9wUabX8ORFW7slGMuPN0NvfA2pNW8gx107nAlTkgrB7ZS0u+md9EFRVrNGk4M
	 R5JPL38ESYmCA==
Date: Thu, 9 Jul 2026 16:18:18 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas Martitz <t.martitz@fritz.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/1] macvlan: allow source mode devices along with
 passthru
Message-ID: <20260709151818.GP1364329@horms.kernel.org>
References: <20260702065642.1783764-2-t.martitz@fritz.com>
 <20260708164350.1513604-1-horms@kernel.org>
 <4ffe7fe8-fdbb-42a1-b2b1-d11a351b2e16@fritz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ffe7fe8-fdbb-42a1-b2b1-d11a351b2e16@fritz.com>

On Thu, Jul 09, 2026 at 10:49:36AM +0200, Thomas Martitz wrote:
> Hi Simon,
> 
> Am 08.07.26 um 18:43 schrieb Simon Horman:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> 
> Thanks for feedback. The remarks are valid, I agree. I also begin to better
> understand the macvlan code so I'm a bit more confident now about which of
> the existing "macvlan_passthru" checks need treatment. I'll send an updated
> patch.
> 
> General question though: The initial posting triggered an AI review (I see
> that now, I didn't know about https://sashiko.dev before). But it did not
> trigger an email. Can you explain why? Because I accidentally dropped the RFC
> tag from the mail subject?

Hi Thomas,

If I understand correctly you are asking why the sashiko.dev review
wasn't automatically emailed to you.

If so, I believe configuration of that feature is on a per ML basis,
and it is not enabled for netdev.

In principle the sashiko review(s) show up in patchwork
(although, perhaps not completely reliably). I would
suggest checking there.

...
