Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D64DDCD
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772676446; cv=none; b=fsAuv0Xi1CXHQEh/dvb/zTjmKWjYKJ9L60DTdUx/2+ci4z0yAa0C4mAXoMfFfPgws0At6gf+3s2o6SrtcYzkGcJTQP9zsZUVfV8RwkjufZrv/ngLuOZIR7fg8sezp+ELmZJHIkgHZ/BisZVosJp8Hf/g65C5ghpZeriUVNelaLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772676446; c=relaxed/simple;
	bh=kIeMBm8JQY/tVg5Mu9eqWpnymN9wjg2e8dBFvrtDX5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/qR8B3S7V/49isSMU2JxrQO+5WghxEpfLsHi8nJAbLBUNV8ccPL341aQqEObQ3eNTUV9rVYPKmhv+/PPtyCiYxgTauR2F8C5H40DiQC11siXI7LYKN1PKBoCXkNuw3ul8/4uuIkBlVyU6D3IC3DDkz0co0B5ZUxWAmDq1sMALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu/vSVfj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu/vSVfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D70C4CEF7;
	Thu,  5 Mar 2026 02:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772676446;
	bh=kIeMBm8JQY/tVg5Mu9eqWpnymN9wjg2e8dBFvrtDX5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bu/vSVfj0+7wDE9lrPwHm6yQZVOtaReQKgZWJdtsn5w3yLKM6kaN4xW1KLCKrq5K2
	 BWAwiKlpl9YxQS4KXN6bbhKOdnet+yjR1NRTd1goHxe/nSvVwIQfIcTu6KhAmTwQKs
	 NQUoIaQJNJf66Bc1EW2E2AtRsGWY125lvskR4dW1siNx6wI4iBDaE/cOsKTMb1LHIv
	 87Ktga601y6IZwucuBi+MoAmbkAM92F9ZA0OGQdTtRf8qV30MCrGqoYkmIlldgRRW2
	 n0fUy23PEh/5j1R3jC9JnBAmHprI4uqd74AcrZo6yMKF8wWlj03VgCPsF6PZefA0MV
	 EY3fA97uMoxmw==
Date: Wed, 4 Mar 2026 18:07:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, davem@davemloft.net
Subject: Re: [PATCH net-next v3] ipv4: validate IPV4_DEVCONF attributes
 properly
Message-ID: <20260304180725.717a3f0d@kernel.org>
In-Reply-To: <20260303124038.5886-1-fmancera@suse.de>
References: <20260303124038.5886-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Mar 2026 13:40:38 +0100 Fernando Fernandez Mancera wrote:
> +	[IPV4_DEVCONF_MEDIUM_ID]	= { .type = NLA_S32, .min = -1 },

Don't we have to set validation type for this to take effect?
Why not use NLA_POLICY_MIN() ?

> +	[IPV4_DEVCONF_ARP_ACCEPT]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),

This one should accept 2 as well? 
-- 
pw-bot: cr
