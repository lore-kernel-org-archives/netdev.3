Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AFE2FD1CA
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110845; cv=none; b=Iv8t0bhCG+F34HEVibYdlFk4YdSG8gG60IaTHDGLTdWrV3PC88Ib5b40FpZ3eATOHIEXrviY5LaSRdTcSpsS+BDu8kvtTCPPcoa/X83+l+TzpkDWtr9sPWRI8o/PqCWdHCxxwql7XKeycYzCPe9yaGiZVYav0BVDLv5s2geA+hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110845; c=relaxed/simple;
	bh=MgAwadMOFavGwuSVevsFAWIWNhnmDhV/RcKahkJNtZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY0izKuDJS+TopohK7/H7HmnsBNofpAadP2Q8g/doVwaViH9wr8YPfumVd3IU1YT7pjRyx5c+mF5tBadmfxE3LekX7jCnW49TBp84XqI9dCl15+Gx+m5CVeHHw65ILFcVyPVGao3st9kgQa4URGB8Cwm5he4fC0k8YBUu1+UoHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oF+T8rlW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oF+T8rlW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D00BC116C6;
	Thu, 26 Feb 2026 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772110845;
	bh=MgAwadMOFavGwuSVevsFAWIWNhnmDhV/RcKahkJNtZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oF+T8rlWwuvVxDqJYoOuWiLh60Ya0nnl3FSHaCmktHNWyNoL1w1cJuMjxn5iFrqJA
	 1Ye4VgxQ92SXTpiVWS6l8fneWtcpIblv7jdF5XB3qvHcS5tuTE6DSZdwcgsHv0Hk0Y
	 aT2fDy37/HA24vsngDQXz+CwgXs37ZbjQFgLmOIFSPtPUIKWmKIiWWqX68KuvNGGNd
	 TXYgo6gT9hSlPBkXM3VXPDXTAfSOcaBHAe97ocRH2IceUAjRU8opq29dnktvi8V53d
	 jEsMY9zs/GaFWS4zUSWnebhJxuNm4JfF18AyzGBl1TrNPpK1Dfxd4NtuyQq44La68H
	 COwjibSxyRNzg==
Date: Thu, 26 Feb 2026 13:00:39 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] inet: remove three EXPORT_SYMBOL()
Message-ID: <aaBD906UWwECs_dL@horms.kernel.org>
References: <20260225134023.1176738-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225134023.1176738-1-edumazet@google.com>

On Wed, Feb 25, 2026 at 01:40:23PM +0000, Eric Dumazet wrote:
> inet_rcv_saddr_equal() and inet_csk_listen_stop() are not used
> from any modules.
> 
> inet_csk_accept() can use EXPORT_IPV6_MOD()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

