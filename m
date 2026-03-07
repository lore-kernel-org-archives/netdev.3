Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46D150276
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772842160; cv=none; b=GMi62o+U3TULc1O/XMtVk4aZPan7Bd8u6p1vieLFP5DfElYp8A3JoUEBDUOioORwrclckNNWprtItsU47RdoPhfC1toGfs2TQB+ra4E3w23+VgJHimOaJfC6NbsYXj5wq4rut12G1Lm9ikp3DME3RdUpYoXQprFmQBsTR4c8xV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772842160; c=relaxed/simple;
	bh=gB5EP4vC6zUFR05nwAKYIWGgLb1WI+GpsAW6ThGAdyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2lLLO+84n3ri57p1qZKtzV4fWdcRT5kKQtnSPOl3jS82Pfh99Xy2Do24NR3yFKfNLVPpOLIuI1OOIY8mp1mNB/9zw0R3gmFMGNoO6prmchX5lvKZCDzkLmD/srF1OuNIDNtfjAMwrGahlFaUkJrfmHhFphQQrlVFE0KkKlMBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXAOfiVj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXAOfiVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB114C19422;
	Sat,  7 Mar 2026 00:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772842160;
	bh=gB5EP4vC6zUFR05nwAKYIWGgLb1WI+GpsAW6ThGAdyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SXAOfiVjQsxEnqY3wzbl7TGOMDcvEg0Lzs+YRYw4p6w/9cPQEDtDFnRBF7H3y7u8/
	 FtJ+HUsJdioDpiZoxgi3SIG3j8rzRMGGX08+tukSQ1TJQ+mnTZnXsoVvvUiDkO9E4q
	 SbZ5kvStgDzvaRpSlsxwkve8EJQBGgM5D0VGNPSTWWDtjhC+KTOFuTxusAffoYe6pl
	 8tCSaV7S3S4UYbP1APziGcSmnUP0DuCvME4gQbiHDmAr53PyQpdKK2ODKCURp6Bfdf
	 jExq8S2XIboDm4ZgoFlPtwSsTmijdmQkmAM8sExFBu4CpFTEm5svyjv82uXzM/BiGt
	 ep5L3mcU6ugXg==
Date: Fri, 6 Mar 2026 16:09:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 liuhangbin@gmail.com, matttbe@kernel.org
Subject: Re: [PATCH net-next 04/10] tools: ynl: convert rt-link sample to
 selftest
Message-ID: <20260306160919.61588972@kernel.org>
In-Reply-To: <m2y0k5ghfu.fsf@gmail.com>
References: <20260306020901.524105-1-kuba@kernel.org>
	<20260306020901.524105-5-kuba@kernel.org>
	<m2y0k5ghfu.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Mar 2026 14:29:09 +0000 Donald Hunter wrote:
> > +	/* Verify it appears in a dump */
> > +	dreq = rt_link_getlink_req_dump_alloc();  
> 
> I see there's error handling for *_alloc() in helper functions but
> not in tests. Is that intentional?

I think the tedium of the conversions just got to me by patch 4 ;)
Let me add ASSERT_NE(NULL, *) in the relevant spots.
