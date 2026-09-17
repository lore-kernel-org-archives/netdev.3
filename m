Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0E037204C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789630262; cv=none; b=NIlteBETgsOUzIhuuvjPkwhxKvopiHmugCJgKIGNTxrQvkJtmRExn059tWH6wPuRR4wGKdWzUmO7wa2ERuMEi95lsxZpXWLLBGTBSv+rGfiSRui17h9AuxkiIwnPSNuU3i54Kh5mxxebKRX08E/d3D66PuWWk0OCAPxB+4JqJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789630262; c=relaxed/simple;
	bh=jHVDXg6uJS1CC7KR9ws/SiajtVm6MZQwsIi0/MHWVvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVJrKPhhm5PUOlCPPHmBUR9/+z/Ukl+0M/+vQDIDrA2ro/to8GhFnYfy9hlhAT7LYru8WFlHcVlnxtinoc77xT6PWzHQxCZoiN+K1Y7ds0/aYjd+Ah+1xVQ6as9gJvV1rD993grOUs7aIjvR2ssIwKuwnINA2Zu3TJuYuGx+CmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToC1bB9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToC1bB9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD791F000FF;
	Thu, 17 Sep 2026 07:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789630260;
	bh=6objJweaZWpw7+NL7md5LD9eSBLoXaSePEDNW90ipzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ToC1bB9sSTU5A2aTCk4KtUEZTL4BKe/PIYRjNjhS38ybivA7nB/IvicEnudPosyC4
	 cFwm8izFtINWckjAmDdgnxyNfeDMoaN2LId40VozXasMRHnFM3wfU+Vjjdwkw0zVt1
	 eApUQIr4vhA24ko5FUI6uqcGE8X1SIlMRicQQ498JbwfDUDa991OcKHEBTM2FpEk4w
	 Kpg+YAplZZMpwSNsmjx/8STQgB4EXKGJcsjUxvKj7y1wZaSIb5JDjQZCtMzCC5RwfQ
	 MjpK57KROnG37XqqEH5R0QWsmqNUHNvwT9jcBQQO+6XG0JG7SbbDnB4llSN3nAa/cz
	 3ZHXePJmslGFw==
Date: Thu, 17 Sep 2026 08:30:57 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] ixgbe: remove ixgbe_ping_all_vfs() from link
 state change handlers
Message-ID: <20260917073057.GV51261@horms.kernel.org>
References: <20260915125547.3975992-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125547.3975992-1-aleksandr.loktionov@intel.com>

On Tue, Sep 15, 2026 at 02:55:47PM +0200, Aleksandr Loktionov wrote:
> When multiple VFs are brought up simultaneously, a VF can receive a CTS
> (Clear To Send) mailbox message instead of the expected RESET | (N)ACK
> response, because the watchdog fires a gratuitous ping right as the VF
> mailbox transaction is in progress.
> 
> Remove the ixgbe_ping_all_vfs() call from both ixgbe_watchdog_link_is_up()
> and ixgbe_watchdog_link_is_down().  Both paths contain an identical call
> with the same race window during VF initialization: link-state changes
> (up or down) can arrive while VFs are mid-initialization, and the
> gratuitous ping from either direction collides with the VF mailbox state
> machine for the same reason.
> 
> Link-state changes are already communicated to VFs through the normal
> mailbox protocol; these extra pings are redundant on both paths.

Thanks for including the paragraph above. It was very helpful.

> 
> This removes the last two callers of ixgbe_ping_all_vfs(), so remove
> the now-unused function and its declaration as well.
> 
> Suggested-by: Sebastian Basierski <sebastianx.basierski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

