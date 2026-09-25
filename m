Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296813777E
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790357035; cv=none; b=c75UmBzlfVQvWJ9zJ8oKnAaRJfyMe1DRE8WwgVANxWhlYZtpNB3tMBXvGJAx8W7ol6lOHDn10w3UKUbs6kouGlC+f2J+uz7gQal4wJlK9wjam3KIAgGiw+b1t7csu1GAcKmCa8oEoTIsyferdHZfn5YJ4evuCMsdE89Dl5urBMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790357035; c=relaxed/simple;
	bh=ptyVeTmPyBNRWxHFPjAC1DcfuFuFILVH8Cqj5rTe1rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtZ2Tk0v6aBHqK5H7h+um1o9FuZLpZvCq8kJU7/rTSIwsJmLiOUsPKsx7nCknlxgiaPpqidrqE5+DP+y3AZFFxUkrukdzxO0GVzqMb+VT/3DhSEtCwPDLXT0CwSCJPTjt22Kp4WAwV4BYWbeRMTGAdCzOO02zUNf9skt73Kkos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6UNWIR/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6UNWIR/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E381F00893;
	Fri, 25 Sep 2026 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790357033;
	bh=zoyaNA6T61X6vQ7cMUVM+bxkczwSb4dnx4amKb8ytNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N6UNWIR/ZRNqMlzQmyZitR6+n/yh741evX+jHCccwsDcg+Z2Jgw2QA0PmA3p2fOlc
	 bADggcbepsmFcHBbTpTf6/CMyOE0QlSktqAw2DoKV9o8W2kjWwXJKWDyZm6nh8gtr+
	 mlTfIuAage+ZdrWckz1iXGouBf0hfb8+25dew4Dsqc9X9itcigmFx52Zm0AxMsIteP
	 /CLx77bOHbnjCdfWYxZJtthiBPGvsAOTjNEZCwVQy3D1Wa68DCrha/2WMVFdxIhtbR
	 +TGtuG4XJJ8ZS/mV4T1eQYqr5ZFgIdc3169jxGtvSuaXMAXaSFKh9MWf1DZIAJBkdY
	 QXRPcPTySuNKA==
Date: Fri, 25 Sep 2026 18:23:51 +0100
From: Simon Horman <horms@kernel.org>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 3/4] ixgbe: Restore previous XDP program on
 ixgbe_setup_tc() failure
Message-ID: <20260925172351.GU13925@horms.kernel.org>
References: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
 <20260922113558.2288111-4-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922113558.2288111-4-sergey.temerkhanov@intel.com>

On Tue, Sep 22, 2026 at 11:35:57AM +0000, Sergey Temerkhanov wrote:
> When enabling or disabling an XDP program requires a queue
> reconfiguration, ixgbe_xdp_setup() swaps in the new program with
> xchg() before calling ixgbe_setup_tc(). If ixgbe_setup_tc() fails,
> the adapter was left pointing at the new program even though the
> reconfiguration did not complete, leaking the reference to the old
> program and leaving inconsistent state.
> 
> ixgbe_setup_tc() may have already reconfigured the queues for the new
> program before failing. The XDP ring layout then no longer matches the
> previous program, for example when removing a program has removed the
> XDP TX rings. Restore the previous program and rebuild the queues for
> it so adapter->xdp_prog remains consistent with the ring configuration.
> Otherwise, a later open could run XDP without XDP TX rings and
> dereference a NULL ring. ixgbe_setup_tc() handles the device having
> been left down by the failed reconfiguration.
> 
> Fixes: 3fe1d0a48d21 ("ixgbe: XDP: fix checker warning from rcu pointer")
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

