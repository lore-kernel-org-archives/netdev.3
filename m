Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684F3582BBD
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963381; cv=none; b=pr4mRvbVOO1G7Y+tT9bTHNcuNEESOKQkVLbCE+8UZ5E5Yq0mRcKnHVf5yC0YetRqAMXrJ9SAsnwclOMRxq9igTVnXlytNdxFMNP6HUJhCkap3tnMjllro2Sihb6CYYSNlg4ixUPkYeLn1WFJgr3+cSeNA80vnQui8slv4coMoXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963381; c=relaxed/simple;
	bh=QJJaWfahQvLd4eSRNO5aQhD0l9pbZ++jwjuV0ILwaQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUChk2M/o5rfx7ioC0TFgRb9hS03Olk6ugJE+vNZO4XI1Atwkog2LqV2s+ioneqY6XshRSBDiNnyB1J4CGprYkpntmpQ1bOLMqY7XGMzGID0QvIfKP5GNY/VTbTg3Y7hloqljPSkxqYMMYernYj2FtAPBC3Yxx4t2e4hf0xUnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vqdKoGkM; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vqdKoGkM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4gJWK0CsCanIqr2CcAL6KVdYWNAlhC1u6+5ypr1xDm8=; b=vqdKoGkMqI3l0Mzokkdx6VXH/n
	foZpguuW3YclQ/ZVT6v840i9RDe+kEtQW5iJM3vrIKGKgo6CuD2y+ltV0VhDLSmVk0IIof45Ckxi5
	uTcLhbRP7My87tHahpjnFL8YWY22jLZaC/m2qsb7XQi2k3mfSeNHclDqvC5krIIERBVDHQ0JFJtHS
	PoLcGpstJQonj4MyTYpbJGuZBLIXod3xZgW1NTf1reMs4Vmzb68udEyO1xBLpgY5rPMS9eLqL5ZRY
	8PBvZuxjXQ453EXgtMHq7+wkCctHvAICvFd1UAYIfwUGx9IFv18kNglsbtwVevcaZhza8uM8D+M4X
	vmPdGyBw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x4J5n-00370r-18;
	Wed, 09 Sep 2026 14:16:03 +0000
Date: Wed, 9 Sep 2026 07:15:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: anthony.l.nguyen@intel.com, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com, 
	jbrandeb@kernel.org, benjamin.h.shelton@intel.com
Subject: Re: [PATCH iwl] eth: ice: don't dereference pointers from TP_printk()
Message-ID: <aqFp78nsYmT8gRDO@gmail.com>
References: <20260821020201.1337338-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821020201.1337338-1-kuba@kernel.org>
X-Debian-User: leitao

On Thu, Aug 20, 2026 at 07:02:01PM -0700, Jakub Kicinski wrote:
> After forwarding net-next during the v7.3 merge window we started
> seeing:
> 
>   TRACE EVENT ERROR: Event ice_tx_dim_work has double dereference in TP_printk: REC->q_vector->tx.tx_ring->q_index
>   WARNING: kernel/trace/trace_events.c:420 at test_double_dereference.cold+0x39/0x4b

I am seeing this in one of my hosts as well.

> this is due to extra checks added in tracing subsystem in
> commit b5cc230af5e5 ("tracing: Warn when an event dereferences a pointer in TP_printk()").
> 
> Printing happens long after the event was recorded, by which point
> the pointers may be invalid (the ring or the dim instance).
> Copy the eight scalars into the event instead.
> 
> Fixes: 3089cf6d3caa ("ice: add tracepoints")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>
