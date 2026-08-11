Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5085F43DA20
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445494; cv=none; b=TegtIR1zo6oUgKkl6Fdayu6OL2Mpof3Hr5CNj9Jv2C2baRbtR9vmAxEhwG2nXYg4vt7n2fcK3rTK6CSc83xEOKV7p4SbpBQUOLAAx25hLij/cMNA1iuJWchnG0zz8hCvODIh9xsR6wWlRuV0BZ9XWaNr8cEzgSf2Pbt9rNHCSIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445494; c=relaxed/simple;
	bh=/MubWxJ1tXR94P9IK6a/8KwbWxDi2MshgX1xSuHnqGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHv9GMD2jqu5gYM69WA3hHjxNdb+aTgWe+zHfrzPbnsrkKiRPYy06ZyLtx0C9ulkNuz9U+KqK/J1MwFPeb7x/8wV2eBVACoNBSEKF0FI2z8B5eukGWu3ROflHTLAtpFkWSwjsB+C8hhGVHs2L2jZVgqC99DQdGGFEFouFumjsqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e92yCGuR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e92yCGuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4112D1F000E9;
	Tue, 11 Aug 2026 10:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786445489;
	bh=jOXAXkWGRd+QY7vdidEatiVOmUG+dAjvoZREUpqlq1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e92yCGuRBf9KUGlGiE7xyk5RYmR3SREgtA3lonoTOep/msZiuLLw9cumaieu/tOjV
	 RRKubBXL/n6Dm+Pg5UyVm/agIZXiXKz2WSG/1V8KLHixVr3NT56JC4zN6rEJZCNlUs
	 pDQ0q74llnkB9107xdje1DSqqZF35acLi0phKfLNFw4AbdcMAoGYs9Hgx/TEpHkc4u
	 gIG8aZAu4q/n6BKrp7ufDcKl/1FHXyRRT9QKHhb5SdsXIr9ZLZ13rw38odUcuVQd0J
	 Mi+5O8frHc6qQscE4bdr3dRqQn4Rwjd1zN/KYwedPxpYL+rdYScZe3wT6UvOX13zEj
	 jsEYaEgsriiog==
Date: Tue, 11 Aug 2026 11:51:25 +0100
From: Simon Horman <horms@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 0/4] pull request: fixes for ovpn 2026-08-09
Message-ID: <20260811105125.GB51943@horms.kernel.org>
References: <20260809212142.2249027-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809212142.2249027-1-antonio@openvpn.net>

On Sun, Aug 09, 2026 at 11:21:25PM +0200, Antonio Quartulli wrote:
> Hi all!
> 
> This is a resend of the patchset from Aug 7th, with the
> alloc_workqueue() warning fixed. I hope I am not too late!
> 
> This batch collects four ovpn fixes for net that I considered critical
> enough. Anything else has been postponed to after the release (or will
> directly go to net-next).
> 
> All patches in this set are from Ralf, addressing key-slot and workqueue
> lifetime issues:
> * a NULL dereference when killing a key that is not installed on the
>   peer;
> * crypto completion callbacks that could continue their cleanup after
>   releasing the peer reference gating netdev and module teardown;
> * deferred work running on the global workqueues with no driver-owned
>   drain point at module exit;
> * AEAD transforms being freed from an RCU callback even though
>   crypto_free_aead() may sleep.
> 
> The series went through six rounds of sashiko pre-review on
> openvpn-devel and should now be sashiko-free[tm].
> 
> Sashiko will still report pre-existing issues, but like I said above,
> they are not critical and will be addressed later.
> 
> 
> Please pull or let me know of any issue!
> 
> Thanks a lot,
> 	Antonio
> 
> The following changes since commit 594d905195024b228c962627ae5ae7c17bd582a4:
> 
>   af_unix: Unlink scc_entry in unix_del_edge(). (2026-08-06 11:52:48 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-20260809
> 
> for you to fetch changes up to 2da3dfa1ddfe55a065f484750c83660e3bd4ac00:
> 
>   ovpn: defer key slot crypto freeing to workqueue (2026-08-09 22:47:57 +0200)
> 
> ----------------------------------------------------------------
> Included fixes:
> * release key slot crypto transforms from a workqueue rather than an RCU
>   callback, because crypto_free_aead() may sleep with async or hardware
>   implementations
> * run all deferred ovpn work on a module-owned workqueue and drain it on
>   module exit, so no work item can still be executing module text after
>   the module is unloaded
> * finish crypto callback cleanup (key slot release and leftover skb)
>   before dropping the peer reference that gates netdev unregistration
>   and module removal
> * avoid dereferencing a NULL key slot when userspace asks to kill a key
>   that is not installed on the peer
> 
> ----------------------------------------------------------------
> Ralf Lici (4):
>       ovpn: fix NULL dereference when killing missing key
>       ovpn: finish crypto callback cleanup before peer release
>       ovpn: run deferred work on a module-owned workqueue
>       ovpn: defer key slot crypto freeing to workqueue

FTR, I reviewed this and it all looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

