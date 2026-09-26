Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB593288C2D;
	Sat, 26 Sep 2026 01:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790387331; cv=none; b=YwPl3Bdq/mqEg/ZBGYRxbiiia/mRkZAlJmZOClv+kVqcoHzjtNZWIrT8cy1tNAj8Tr8BI4F44lasvfluS23dWQywIdlkhf7SMXSGwhqmVNQpVoGxkzt8P8gGvO05ilzee+dYIm8Rvps86Q53oZjfHgyGXTmMogN2UANRpfANAlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790387331; c=relaxed/simple;
	bh=y8eZvRIFP4c7aKdQf1hRsNJ6pQpC2oLnyrPr5yBYrYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NP5VDYAhZEcXZw8QFLGgxRjrFKIwOrggsmnI0ziOHAVBKwtOfMc3xQ/xaASQYV1eCynBgWt3E1aOwE2u5z9KAT1gEPB6JVFOMvjEJyOSuSGxTJwKB9KXdlQOilFL/Iemc/Q6s+zn7zmRcYhRxnNL/AKDHeBwNqLciw0H+oRns/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/voftPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/voftPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C30A1F000FF;
	Sat, 26 Sep 2026 01:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790387329;
	bh=Uo025O9H1s4JpC252yYksSrMRmfaaKJ2+LbHv7M10Gk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U/voftPPYmPs4DqVmjfxJMGOWYB9Pjfi96SIBSYyIus28wpWLXaHNyDB+oZH2H/S2
	 f2D0Eu5voWk5ya+IFdS2UoZCDVRcWqlyu7FJthmimqVKurYy0u0cB2eI8rWsOG2jbY
	 h8HitcuuKu43G5qKpVF4NaWGKPsJC7jnsLKKN35Z0oVYhkT2HArs4yUDi0RtTRFHf+
	 Zpp3Vnmcm9+zIDVQdeCq92C2mC6pAleXuEoLk3sszR1XoXgMkeiaRlDlzurC71i1ew
	 jhL1bNNQtkLXKCtnU98HbSJF9Eughv7lU7Czvhhye0zxjLLEdYHYkfAWvPfh5+5jQC
	 btACbRUoKbICw==
Date: Fri, 25 Sep 2026 18:48:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: satishkh@cisco.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sebaddel@cisco.com
Subject: Re: [PATCH net-next 1/6] net: add netif_rx_mode_schedule_fresh()
Message-ID: <20260925184848.770e0aed@kernel.org>
In-Reply-To: <179029090875.2160803.9750318118693297771@kernel.org>
References: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-1-67a0a6e08d43@cisco.com>
	<179029090875.2160803.9750318118693297771@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 23:01:48 +0000 netdev-bot+sashiko@kernel.org wrote:
> The kernel-doc says the helper is for callers which need "the complete
> receive configuration to be replayed".  Does the helper on its own produce
> that replay for an ndo_set_rx_mode_async driver?
> 
> The queued run ends up in netif_rx_mode_run(), which snapshots the address
> lists and then reconciles them.  __hw_addr_list_snapshot() copies sync_cnt
> and refcount, __hw_addr_sync_dev() skips entries whose sync_cnt is already
> nonzero, and the reconcile step then computes a zero delta, so addresses
> that were already marked synced are not pushed to the driver again.

I was about to say this, the kdoc promises a full replay which is also
what I suspect you want. but the callback delivers incremental updates
by default so if the device was synced calling this does nothing.

If you do want full replay please fix, and also call it _replay()
we already use that verb eg in udp_tunnel_nic_replay()

If you just want a retry the kdoc and name should be updated..
-- 
pw-bot: cr
