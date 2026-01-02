Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185863B1B3
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767395678; cv=none; b=HeSnNTg6iKnd1jyTNLstJmcK0EKGAXb1Je3FyTid6UDUS3RmaryyY37M2HNbKCvHeRnwPUUEKdqpw6L3QyDWcvMnJuzmaKQ5LEdHgq3ysg+LtCjQG+LP7HjjE4HhQgmFpx7yolOTD48n/yp3f47zdCRWK9r5RabPkpnQIIYzPtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767395678; c=relaxed/simple;
	bh=HmmPZG6IS8uigjEdW6m717qkKYszywP2Y3h96XbzDgU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKE2d6sVB7pUPcHOMnTRf3mK6m5kSa0EvBwe8anyV3pXG0PUgPtxYwQfjVvmH+mCQe2aIWPQsk+++31FEWacJwa+pbern+KknJ8hhd/WSzVPKCgxOfs0Qx3jyMsXxF9XQ7yBDho+sJnAIeRBu9gVqPhKbQTtwhr/OSwJ4kD9D5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpYhdAt0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpYhdAt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F27EC116B1;
	Fri,  2 Jan 2026 23:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767395677;
	bh=HmmPZG6IS8uigjEdW6m717qkKYszywP2Y3h96XbzDgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MpYhdAt06I58zPvsTr+ruUk474xZAavWv8obyE/EHysC+ZuXSNJhMpRIg2MDzz7XN
	 Btb46Mt7OMwpxT+ImNvObKBzM5VYh60QCy28hlVLTnUmrAXGys/IFiwnOin58aE98P
	 n74Bs8xsJmJ2rTCuqPME9cUEc2TZZwEFvL7yjKj9Lnv5ynisojYKGKtCxBzm5CvKFj
	 LwOWfbqBbpwLetkbPTGd9AEBdmrHFmu570/H/JcVamPt0D2EZb7YtYCf2PRmzrOBtK
	 Nss8r32IB8SlbhqSXR4Tq4bs8WQ1xt/JijyY6vEE6keUDt8PvDaQrVHaHZYIbP2UoQ
	 aIbRCRwwcflfQ==
Date: Fri, 2 Jan 2026 15:14:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: mheib@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, davem@davemloft.net, aduyck@mirantis.com,
 netdev@vger.kernel.org, jacob.e.keller@intel.com, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net v2 1/2] i40e: drop udp_tunnel_get_rx_info() call
 from i40e_open()
Message-ID: <20260102151436.767bde60@kernel.org>
In-Reply-To: <20251218121322.154014-1-mheib@redhat.com>
References: <20251218121322.154014-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 14:13:21 +0200 mheib@redhat.com wrote:
> Fixes: 06a5f7f167c5 ("i40e: Move all UDP port notifiers to single function")

I doubt this is the correct Fixes tag.
The locking was reworked in 1ead7501094c6a6.
