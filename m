Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC2732AAA7;
	Thu, 12 Mar 2026 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275168; cv=none; b=jCBZws9XIIaFnyOZPmVw/yKfpMdAXYkfSNDIGbq3N19Dd+Ej7ysC8nQ3Nvktt4uH0fNNfdIk7+PKWJZ+BpDtgXHXxP2u36q6j3suc6oGnT+kty7BIBfzkk5CaDNP2D5BJ1IogbYHdUPNlzs74wj2sGek/pP0nB2Tlr73ObeZfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275168; c=relaxed/simple;
	bh=yAqxgCiaL/PbIercs51cQybjiF/dUfLJWosvRVyOFD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BSBL/sXbZL9+gwpaFBSHBcqkPjRB6pg3uNlxGSmYYWrCiC8fq1I9aMbZJbR6Q6196yIDX73aFi+aliR2eWhKcN1XsvAC5Y0QrOAZkUkfhCzsnkvGK5trESkseIMuB6H1u+xPIiNSNOI8owPz+4Yb34HwDXaFHBebvhAUtOmIi9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcNvn/LQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcNvn/LQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41588C4CEF7;
	Thu, 12 Mar 2026 00:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773275168;
	bh=yAqxgCiaL/PbIercs51cQybjiF/dUfLJWosvRVyOFD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FcNvn/LQPf+OP/jo6ihg8Cs07rXHB+i6jX0dIhHU5VkoAjDaHFqT+nJN9q4YffFFr
	 rTJB7FMO7ZXtEgVkfGd/TkJ2SbVjTFSkAC8xtkv8on894lVvakFQKxnuE9uMFtnMwm
	 zGkEavTanMm6ApxOU9v3xrNuOGC/kWA/51L1bMVuj06oeRaU9nSoyb4unv5Jm4oKUL
	 NukKw6GjMSi9BKb5RDGpB3KvFX4xXqEXLUPpx/lDyDzTTFwgyS1CAYGnuh3A48sP9F
	 9lPxSox3ANCJ2JaYZBP6jbmlGFTVK/acGoYcpnbJGtVRhJqqsLvL8WZPllMKXcKUg3
	 eSVJpqiSIHWLQ==
Date: Wed, 11 Mar 2026 17:25:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ynl: ethtool: remove duplicated unspec entry
Message-ID: <20260311172559.7d7713f9@kernel.org>
In-Reply-To: <20260311-b4-drop_dup_unspec-v1-1-e0dfa47b5981@gmail.com>
References: <20260311-b4-drop_dup_unspec-v1-1-e0dfa47b5981@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Mar 2026 11:22:29 +0800 Hangbin Liu wrote:
> There is a duplicated unspec entry. Remove it.
> 
> Fixes: 0187e602c03c ("ynl: add missing pieces to ethtool spec to better match uapi header")

Does it break some user space that assumes no duplicates?
Otherwise I think we can merge it via net-next. (no need to repost)
