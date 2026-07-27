Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FD741B8DC;
	Mon, 27 Jul 2026 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163641; cv=none; b=YoPdgXuPIXu6ZcWBvTMG11Aah3N+UbU4dlAbjS1+SGdMuUEvI7afdC4L1OKG0hKBv0nFE1z9D3rg4A27Etn8qokd0LWFqVdpvVOoUx6RBgZ36S1Tvrht+1zi+MQXCutDbmFOUgHntcikLemAp2GMhukENMRXGBqG9lSCpA0h75Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163641; c=relaxed/simple;
	bh=KPZUzUP2ppcXQ0krnCRhLvC6gZNE4ii9C/jMU3ppoEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/yNg2NViXM13DVnifTAxZN7n3k8e18/heag/fXbunvQlF43ZgjsYKt9sy6h5XHdtNrfN7PQ2Hs9SWzmds6ahgBkpkqdCOVxJFQ0cEj+h8TO2tZ4Hgdl77G0GWa+ZIDicf9xXL2NRCqgNnyNZEx9KGMO/Nwq52uc5lVa6jH2SKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxlWssoX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxlWssoX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E341F00A3A;
	Mon, 27 Jul 2026 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163640;
	bh=1B432qyY/MpnjPPckN29PSOluxxxTLAr73fp4YIVH34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZxlWssoX2nxj3euO4/V1PpJXGL76ZbIVjVo2AeMiuZl9+/Q4oN2uirisnnFtNVBVX
	 hXpuNfNtRcGRWqrxQzacSKsu4LUWYiBFPI2fd/cd8DnZqV1Pcd8gIVoAiAypE7PuRB
	 b+JSqS5wsjK34rJ6iktSzyLWPPNg4TBFW0gvkJDZ1gkPVmT2pv/iwxa1fM1Q46e2Sl
	 aiF8Of9GwDe+2BsEGBBJumBoBtEfYoSym/JB3c1K6aAu/cPi5sFaXVu36cKH9+lZCE
	 z6d7+Mq7Y9VeLVQQnMpiBYPcskwWRhTKmRxNRn++/CWcqaKav0wDQagmoKMwM+cm1a
	 e+mog1r9FsyLA==
Date: Mon, 27 Jul 2026 15:47:13 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
	netdev@vger.kernel.org, przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com, sridhar.samudrala@intel.com,
	michal.swiatkowski@linux.intel.com, maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com, madhu.chittim@intel.com,
	joshua.a.hay@intel.com, jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com, jiri@resnulli.us, corbet@lwn.net,
	richardcochran@gmail.com, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/15][pull request] Introduce iXD driver
Message-ID: <20260727144713.GO418547@horms.kernel.org>
References: <20260715180042.1972010-1-anthony.l.nguyen@intel.com>
 <al5Lr2Qm5pDa-yOF@soc-5CG4396X81.clients.intel.com>
 <20260723061526.38902608@kernel.org>
 <amcX1fyBBKwzwMUu@soc-5CG4396X81.clients.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amcX1fyBBKwzwMUu@soc-5CG4396X81.clients.intel.com>

On Mon, Jul 27, 2026 at 10:33:25AM +0200, Larysa Zaremba wrote:
> On Thu, Jul 23, 2026 at 06:15:26AM -0700, Jakub Kicinski wrote:
> > On Mon, 20 Jul 2026 18:24:15 +0200 Larysa Zaremba wrote:
> > > I have looked though Sashiko feedback for this version. A lot medium+ comments 
> > > were things that I have addressed as false-positives in v4, so those are left 
> > > out, same as many of low-severity subjective issues. Unfortunately, patch 4 does 
> > > need a fixup (see Re: for the patch itself), but hopefully this does not warrant 
> > > another PR.
> > 
> > There's gazillion patches in the queue. Just fix the bugs and repost.
> > This "we will follow up" attitude is getting out of hand IMHO.
> 
> I was suggesting you could apply the fixup that I have posted under patch 4 
> ("libie: add control queue support"). If this is not possible, then Tony will do 
> that and send another revision. (please respond)
> 
> Other feedback does not interfere with code working as intended, although 
> Sashiko's feedback was pretty valuable in getting to the point where I can say 
> that.
> 
> I see that Simon posted only medium+ feedback, I could address it one-by-one 
> once more, if anyone would read that.

I realise that in the case of this patchset I forwarded AI-generated review
which somewhat overlapped with your own efforts: somehow I missed your
emails and I apologise for that.

But I wanted to make a general statement regarding commenting on
AI-generated review:

I do try (and as we see, sometimes fail), to take into account prior
discussion on the mailing list as part of my review process.  And I would
like to think that I am not alone in taking this approach.  So to that
extent, I think that responses on the ML to concerns flagged by
AI-generated review have value.
