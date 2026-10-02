Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E805935E1BD;
	Fri,  2 Oct 2026 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970966; cv=none; b=qUAbp/IPdClp2esVinI+PxhmS8mjz5Nj20S5s2uR/WHFf4wgxrrvHQEVmoM+JtVjMIZRIz563HQPdwvPffxa6pRev3jSCDO6bf2Rll0d9QmFw6ac7p176dNGrtFMlo2DdPodmvAkTPVW1bXD8LAw5xdL7K1E0XO3XSIKmQvXtRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970966; c=relaxed/simple;
	bh=IGTj3X2piRH+rWnbyHzW/Di5UBUy2yphMefe4WahUts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I11ZYH5jDUEoDp2D0kjESMefnDoQfiKtixdrWcXZxT7aY95ZkrHz3BwsKLQHmXY8Jqp+hoW3ZqbJ2QZguCGbrV1Zcf4y57GUY3Sp7hKaQxy/AtAVSK80Xb059xNR7j2lqUJ/64nhOy2X6ux4/ImDD/6EA49GQhDfIXxNsVfTPzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5CSp6V6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5CSp6V6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564331F000FF;
	Fri,  2 Oct 2026 19:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790970965;
	bh=DGs9M5fLEQVRbRqAcZOi4M9bTLV0n61L8UueZgcoILs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k5CSp6V6p4tCmChxwNFfy79UZgpjWeMAT0idDRvH5TvqWzi/gesUw2m2maWhhLuRL
	 5CYJLVCftK58sbEI7voKTtIbtv2tgzosfaVPSUPGfwetD3SswwSf2opKlpAIQ+5PED
	 ZWx+VQTe6YsVdjg7MIIDm9XHUqLJa7ts4dbfihYBffiSsr14OzoACjNsTlErDr4rrQ
	 vOqL7nDe4J5JamsTS0/ltTQ8iEAfiZOtV/wI7jDnM22RX3GsJTXGrRhMPXqvd6XECm
	 K0mVHdxh6zL07DX1ONvbkKr+gKhJYPcOxCr9cg/GcOa+VwfvHLy9oq0olOboqQ32/W
	 kVCBKO7nuvt4g==
Date: Fri, 2 Oct 2026 12:56:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhargava.marreddy@broadcom.com,
 rahul-rg.gupta@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com,
 ajit.khaparde@broadcom.com
Subject: Re: [net-next, v4 00/10] add features to bnge
Message-ID: <20261002125604.25c300ab@kernel.org>
In-Reply-To: <20260928061307.1172344-1-vikas.gupta@broadcom.com>
References: <20260928061307.1172344-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 11:42:57 +0530 Vikas Gupta wrote:
> This series adds ntuple filter, RSS context, and flow steering
> support to bnge driver.
> Patch 1 is a pure refactor (no functional change) that relocates the
> filter and VNIC related code into the appropriate files. Patch 7 drops
> the refcount usage from L2 filters, also with no functional change.
> The subsequent patches then add the ethtool commands for configuring 
> ntuple flows and RSS contexts.

Please respond to AI feedback, even if just to say that you will respin.
Saves maintainers from guessing.
