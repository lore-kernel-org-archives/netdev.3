Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072961EE7B7;
	Thu,  6 Aug 2026 00:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785974874; cv=none; b=eqXLD1a60BFg6X4KyDEKqPNf+hGDn0dc5Nii4GqTcxHIgVu9RYnSiG0kC5txRRYflvWO/rJEr6szCIpHo7ep2asfx6Wy9Qyren6oe0ZZ6IX4jR7fniCYmvUCXHvKCWvu5+GI56s815Z5+XY6hAZNXSZcVhQpJ2508hA/ePtVxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785974874; c=relaxed/simple;
	bh=0qDNsI83h8yFiAYO/2SiHEtghw4bG1XTt+H7L1BxM9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWpnGvgNvW8MjEVER6K0Ky0Rp0q/FJaghw7PsdTSEQYlNiGHZhg9rdWJak1CX31jtqhjBLoa9XVsCgzAr4iebj+jNNFWe3LUXNMEH/uYeJAmJyV3m8mjBtjXzaqSW/eea6pXYivkr0I3I+wkt/q4KpONLaBpT0z5PrWFAV74BNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/0umUnf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/0umUnf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BED1F000E9;
	Thu,  6 Aug 2026 00:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785974868;
	bh=hTk8je2wGthjyEsh4xq3MqDkN5MlwBIDEzbSa5r9mGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W/0umUnf2hHeSrYU5jMxwtT8me4QVcEmxY7fJLzFEzOIJ4Ao39NHNla2cM9ZpDubc
	 K1AzNkrb2VQHl8rSCZI4GSANxasl7TEtAPDFW9BE7qeGF7z7yihCzIwv7EwI4UcSl/
	 QC0+B+QOFwzqcsdN0HE91MPmIdbvBcfMvXexse6mDTYj7kuORlKmlFzFwhEdcVp5vN
	 uJZWiWwjLpz29gHRo6+B4+3DiwiJiFSnVttTVy12fN9or3J26JXNu4lWylgfGdXJPL
	 WgAf5WjBs604bdM9kAh2A4lG0H7KOV7ZRc04G1HI9zQ72S7wIz1XKs66wGc3HVbfXs
	 uEsoRC29VaOeQ==
Date: Wed, 5 Aug 2026 17:07:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thaison Phan <thaisonphan@google.com>
Cc: ast@fiberby.net, davem@davemloft.net, donald.hunter@gmail.com,
 edumazet@google.com, gfengyuan@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, matttbe@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, stani@google.com
Subject: Re: [PATCH net-next 1/2] tools: ynl: check for null ptr on dump
 free
Message-ID: <20260805170747.52f4dca9@kernel.org>
In-Reply-To: <20260805131454.3364094-1-thaisonphan@google.com>
References: <20260804142553.6a67fff0@kernel.org>
	<20260805131454.3364094-1-thaisonphan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 13:14:54 +0000 Thaison Phan wrote:
> Thanks for looking through this.
> 
> > What's the tool?  
> 
> Sashiko (LLM) reported the issue. The path it reported was based on code
> output by print_dump() where since the dump state is zero initialized
> struct ynl_dump_state yds = {}, yds.first would be NULL. It then pointed
> out that in the call to ynl_exec_dump() that there could be a failure in
> ynl_msg_end() or send() that would result in `yds.first` staying as NULL,
> and the code going to the free_list label where the dump list free would
> get passed NULL. I may be misunderstanding the code, but it seemed
> legitimate.

I see it now, you're right. Plumbing the END markers in the list
construction would be a PITA.

> > I guess we can do this but I'd factor it out to a separate check at the
> > start of the function. Otherwise it reads as if there could be a NULL on
> > the list itself.  
> 
> Factoring out the NULL to be a separate check makes more sense to me and
> better shows the intent of the check. I'll update that in v2.
> 
> Thanks,
> Thaison
