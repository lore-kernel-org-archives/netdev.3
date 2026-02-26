Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFC3275864
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075015; cv=none; b=T2QtPiGe84moQSKupbpRsp91rdki5aV9mYCbcpSJx49tKOMgUQNbgy6vRm5bNIg2kjVaV7fLSfSrHLjkvF0SbvVpa/ibDKEO+f6/9sSiQwg8hazu3uKchDKPgJgVABPJW2sIfB5wn9tUM6cx/ouR3rAhzbHkwfBMO4KBpnd7IEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075015; c=relaxed/simple;
	bh=8/zvNA5dAigHhsz7FmPuCCDSPkwRrlVOoyH8r7XhSWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blaIcWiFZfvSufZF/jwOfgAXLDKJK8BI5eEjxcc2TRydkcVgLcRhKl64asM6CqDNvzuUIkq5tK4espsv27chm5x7E32+HdwzQTzdAHC1qJOhlh4HrweCoihMSqHrHpE999AHG16e3cyNf8WPGcsPZ4ByUW7IrmD4RJwwwEY1sA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcNiUV2T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcNiUV2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF51C116D0;
	Thu, 26 Feb 2026 03:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772075014;
	bh=8/zvNA5dAigHhsz7FmPuCCDSPkwRrlVOoyH8r7XhSWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AcNiUV2THO5uTIc1m/jlw6O41AaK5ny9wqf/TYYRFQ35m0Ks++DP2UbvE5k+KjMKo
	 lWOFCP2u1xTLGQoZ7kwM4bWCnfclS5/AQymaD83nmsRt0HQN5KGUuOB61URrxOqS3q
	 1XbDCUbfbsTNm5HppVPr7Ld8lu8wp0NFGit50xqqbdZLIe7Nkrm/mN+ARvI6qN3bzK
	 bQOnTSfEm3Jz20H+m6TlyM0P+2yGa39Cbmn0BBtSfTGlIQwrr5ra+GoNDCr2abVi32
	 QXjKX1CE2oWeoy4+olI79SveFtK+IrzwWOyZsylK6hUPkxmTGyvO64rsx3IAnNTKFO
	 APC4TFxQjkF9Q==
Date: Wed, 25 Feb 2026 19:03:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>
Subject: Re: [PATCH iproute2-next] iplink: bond_slave: print actor and
 partner churn state
Message-ID: <20260225190333.16fdb616@kernel.org>
In-Reply-To: <aZ-rjaU32FbTbn9I@fedora>
References: <20260224020215.6012-1-liuhangbin@gmail.com>
	<20260224020215.6012-2-liuhangbin@gmail.com>
	<20260225132239.34fba967@phoenix.local>
	<aZ-rjaU32FbTbn9I@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 02:10:21 +0000 Hangbin Liu wrote:
> > You should use print_uint for unsigned values.  
> 
> Thanks, should I post a v2 version for both the kernel and iproute2 patches,
> Or just the iproute2 patch?

Just iproute2, they aren't bundled by patchwork (please refer to 
the netdev maintainer faq for the correct way to co-post iproute2)
