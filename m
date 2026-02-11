Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38326E702;
	Wed, 11 Feb 2026 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770853210; cv=none; b=kNLbW0i7HsRytnvJzoaZz/1cde2+nOSJpoEqKpD2jnybJ88eex6XHHMr4GefkhqoXWPucFvaMcOhsOeRGRSa8g2AZR7xJvVEhQMnta8lqcfAQcQ0qZCIf3GiVaC0Z07O+CfDvOVNz/ivopjI9RQaD6DWyfT7nnY6Z9cHLfdkRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770853210; c=relaxed/simple;
	bh=ddBI24TzByyQrBmJ+i94mPyjpj07qC/uOHRxXKZlids=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhknmwfYt6w96K8oFCHuQGrnU8rgab4taFxbwv0MFoJlFPETtPfurgQsAIvVko2fn6jP3qqONptcDz5QuWDy1LvNqp1EVs/b5OQoWJktTomT0WXjnKnJtxjNP1BAO+L+cERVqYhGq35RxluaUSHfLbSmZ/3cHJ69J4Rc10eC28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFTnailr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFTnailr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF6DC4CEF7;
	Wed, 11 Feb 2026 23:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770853210;
	bh=ddBI24TzByyQrBmJ+i94mPyjpj07qC/uOHRxXKZlids=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LFTnailrYLLmCaAyciikcRWP23vURUAEA5FGRoq2sZM/MDXU+uoI2eP4ythkA9GE1
	 JizdXdVeNV0+ZIPaYKBqkTLzEOHhJ6a2xsgJmeIK6JpWTRzrQC81ckwDaZ6+qNRglP
	 I23td9XxHA/0Jhbv7h4tY/jD+vPvleGx8gZhvYfdKN6ITFRhn4Ov+Bz+i/IpQ8zS6r
	 8v8Ft1pfq+VPfyHAX7+b3w5MCQoRrr+GB4LwAbhdW5kHqeiRC8bRe3BaAomzck9Z6D
	 s+BxpkJktkxzcLoes//GiplYX24AYMElwMVM4LckaqZ6AsskLz3Ps5Qdtz7YZV1gzp
	 4KRevyejnALWQ==
Date: Wed, 11 Feb 2026 15:40:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Networking for Linux 7.0
Message-ID: <20260211154008.24db40a7@kernel.org>
In-Reply-To: <76e6b68c-393e-48d4-9ee5-9e8d511ab308@oss.qualcomm.com>
References: <20260211173015.327542-1-pabeni@redhat.com>
	<76e6b68c-393e-48d4-9ee5-9e8d511ab308@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Feb 2026 15:07:18 -0800 Jeff Johnson wrote:
> On 2/11/2026 9:30 AM, Paolo Abeni wrote:
> > Hi Linus!
> > 
> > I'm not aware of any conflicts with other trees, even if this includes some
> > changes to printk for the sake of netconsole.  
> 
> There is one conflict between the refactored ath12k driver and the char-misc
> tree. This was correctly addressed in linux-next:
> https://lore.kernel.org/linux-next/aXD6X23btw8s-RZP@sirena.org.uk/

Will there be an effort at some point to improve how the MHI "bus"
is structured? Maybe this is not a great example but we keep seeing
patches that touch a driver + the bus. Clearly indicating IMHO that
there's no proper abstraction / separation between the bus and its
users..
