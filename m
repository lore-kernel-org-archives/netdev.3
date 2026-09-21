Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEEE3E315C
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000375; cv=none; b=Sqe6UAdTflV0bDe3IW+S6hNiWQ/Y6lS7zXyNxplAWto/h2TUtw2UeGdk2dQlb+JH/vzN9cGMn5Jt8E4erjTy42BO7t4VHGId70fzgvZ8x8ARhxiy3Qc4OFN8/a3pqvdZjFbfy59DG+r8QLYB8W4RaBG7lpDKKAd7TwnJl/nMe+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000375; c=relaxed/simple;
	bh=h+OVZyz5n0qqoElrwdKuQtV7J3Cxxe3NhZOWag3SWrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQv+eqk590jccHuVPqqZAsk6h44CWSDv3kjWfRow4/8QKVsUmDNMJVYVZCMtxDozBmynllHdqa6yvKhEsuYWL80ZBJHD947UlVuwUdFzNjU6K+Zyf8/FTkBqg8fRGzTgJqaMRblknIZ5c2QxxZ3r2eE7gSlsqCm2GWaFwAdMtCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exDntT7R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exDntT7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2E21F00898;
	Mon, 21 Sep 2026 14:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000374;
	bh=9pZqmiWn61ItGF8y5ww5UwHxjIOErc/ctQgUFUZ8frQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=exDntT7ROjzoXXM5pa3HJBRowLZNlEF8TeFkTUQySPe2wSoKk8e1L6oJUVpha9laQ
	 SO5LTEDi6W0bMnrG9w49r8IrksEfhZGGV6mS+KAhIcmqAguDWN2BWNc9ZpxVHq+zHA
	 SI9LARuhBbaVzQh5tt55MXhxtnvr+DsRWeV7gfe2E85pEKmYJBTaNFB11HuvATCV8t
	 9zQ6EwYi1aYbsX+T6Df0hs7xHViO4w5t5vm4rW88x0a9/kJ2oQOs7qsLhhqkm8saiu
	 mDepiPjLrkTsmmSMfnCRZ7aBcpxbRfmOzACwYSEk5Wrw3hl9WEWVd7TGtGtOzCDWLK
	 ZudEy6PGZgrrA==
Date: Mon, 21 Sep 2026 15:19:31 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [PATCH iwl-net v3 3/3] ice: support RDMA on 4+-port E830 devices
Message-ID: <20260921141931.GS13925@horms.kernel.org>
References: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
 <20260918133234.4169074-4-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918133234.4169074-4-aleksandr.loktionov@intel.com>

On Fri, Sep 18, 2026 at 03:32:34PM +0200, Aleksandr Loktionov wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> E810 and E82X devices do not support RDMA on configurations with more
> than 4 ports. This limitation does not apply to E830 devices, which
> have a different hardware design and support RDMA regardless of the
> port count.
> 
> Narrow the RDMA capability disable condition to skip E830 devices.
> Move the 'RDMA functionality is not available' notice inside that same
> condition so it is only printed when RDMA is actually being disabled,
> instead of unconditionally whenever num_funcs > 4 -- otherwise E830
> would log a spurious warning even though RDMA stays enabled.
> 
> Fixes: ba1124f58afd ("ice: Add E830 device IDs, MAC type and registers")
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Thanks for the v3 update.

Reviewed-by: Simon Horman <horms@kernel.org>
