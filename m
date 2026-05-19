Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08905305693
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219968; cv=none; b=hhcV5JuVpWnO8lB7XeKHAymkfbHlTwr5i7jttEjQcofXk0rHonxh5rE3Il/D++4eALhgaO3kz0ckl0z4hKG+HoP4NJdW51TR0/oGB/hxuJ0YSr/fztplvn7L/vWdIz3k+ziRVz4nnM1cG237p2qAADU1Tch2MKw1YQB0BFDdL8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219968; c=relaxed/simple;
	bh=eIdSbpCOE2tEp4vI10CL0o7hq3T4MveO/HhVOdB1Fwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3FuBfGaQWu/QfhAl6EOSShUpvD1ZD1PrDEi+s1eCfgY3j58iMg/9+fKhcZRB/VuZ1ZGlrxMRH0LPTB7BshlZigHEO7XM38BIUJodmQQT9WSC71vyk+noF2od4dTP93VQ9UIlJCenspkKV8xEqnhF4avkS13S0B6nFR98w4fZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9as5wua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9as5wua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2281F000E9;
	Tue, 19 May 2026 19:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779219966;
	bh=9/gISngu1YBPhlTCpjdF9NeYFRX29qtCBzl2K8u7rMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B9as5wuaORLXiWK4cLkWHmh5uPzJYl+P8FtQ2E1SQffGs6a0SzEn6BHGjiRf65qif
	 lpj/RKDO+K/77WnitPgMAJMyTDPHgmUJh9ToHgZjjG7fDvYc/A7freDBX/NSuEi2LW
	 EMzcq4uma7zQLPsWsmdfw0OJOBZnNjQ7sHboJCjG0kn/Amk8eA40PERiCjsft5EEYh
	 LGmumH61snkjbrhri52tzT1wzyKMxwAwGA+w+URk1Lr3qhJj3gRe7y0FvSyaZZwjez
	 LlRkM6KA3fnZQdI84YA+LDbjGhWLr8qiy1lUAXgvf53Uns4JJcSc8Mi6x6GwAlUV34
	 ruD1Oc3TqNORQ==
Date: Tue, 19 May 2026 20:46:02 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: add missing xa_destroy for sched_node_ids
Message-ID: <20260519194602.GK98116@horms.kernel.org>
References: <20260514-jk-fix-missing-xa-destroy-v1-1-de437bf52347@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514-jk-fix-missing-xa-destroy-v1-1-de437bf52347@intel.com>

On Thu, May 14, 2026 at 09:55:21AM -0700, Jacob Keller wrote:
> Commit 16dfa49406bc ("ice: Introduce new parameters in ice_sched_node")
> added a sched_node_ids xarray to the port info structure, but never called
> xa_destroy on it.
> 
> Since xarrays can allocate internal memory, this can result in a memory
> leak even if every element in the xarray has been removed.
> 
> Add a call to xa_destroy the structure during ice_deinit_hw(), and one to
> the unrolling cleanup path during errors in ice_init_hw(). While here,
> remove the overly verbose comment explaining the nature of the
> sched_node_ids xarray.
> 
> This was caught by Sashiko during development of unrelated code.
> 
> Fixes: 16dfa49406bc ("ice: Introduce new parameters in ice_sched_node")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

