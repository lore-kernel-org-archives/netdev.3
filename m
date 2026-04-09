Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A309310F1;
	Thu,  9 Apr 2026 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775696523; cv=none; b=fV/4sNp+BmYxNucYjZY0aQTLOCzDMaFk0X7xsE8b2YoYtCoBD03erw9Nxa3NTJho0k9JBXc5Nh17tfB3i0pZ67m3jOVepbtXHXdhotqeej6iHmF9O6t3SfA/U39MnMTvkk6fe33NMEdf6stb2giWuqy0fyMrmSC6Kq2OPHXUNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775696523; c=relaxed/simple;
	bh=uIE7tOilWSjBMt+rLPPYYvZCKD/zIL5d71S5EQ89l2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTJxez82Lb+NGBsxhDfxktskFshK19Z5g+BR77MjXlA5AyEh+PoDRoqXn4CmhFg1YxpV2NTgJvFYsiNwFu5LeJ6aT0AzrfBkp9Hk2nBJvFjPCY3viwV4my18J8Ip/7ZAR1xfzhbBFs//pkFzCOlqbX9PamX0IissHr8bUOQ5ikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pL0PiHD4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pL0PiHD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C873EC19421;
	Thu,  9 Apr 2026 01:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775696523;
	bh=uIE7tOilWSjBMt+rLPPYYvZCKD/zIL5d71S5EQ89l2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pL0PiHD4qFUp4iEeiZfErA3XzV8g6va0dCuRyEuaXs+zRXbt7qLS5JMDUjMw6uJYe
	 pmxyoia00niOplH4x1cgoEgw56184HYEsOOWTGY8LNWbdmonhuCWZ+EH8STr6AJTgo
	 G2gjBqNULZI9bwGutbvYLscRMHFy5aF4t176I3WvEVxn5B8X2/Y8/m8xEZHDeuLo0V
	 2D65RGOxA0zZJ0NkRNnIxByV3oQs2xNEpCq5+UwicfiiDctbhcKIYjA3g5nYIUrXK0
	 8w1YCjWH2cjI+R1K0K0ddZuysYP44nusf4DUDHXDwoA/gO84aHVNvueMob3SlZ1C/y
	 /i0F9s1FsHasg==
Date: Wed, 8 Apr 2026 18:02:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Cc: satishkh@cisco.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, Breno Leitao
 <leitao@debian.org>
Subject: Re: [PATCH net-next v3 00/10] enic: SR-IOV V2 admin channel and
 MBOX protocol
Message-ID: <20260408180201.37e9546b@kernel.org>
In-Reply-To: <20260408-enic-sriov-v2-admin-channel-v2-v3-0-1d4999a03cec@cisco.com>
References: <20260408-enic-sriov-v2-admin-channel-v2-v3-0-1d4999a03cec@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 Apr 2026 09:36:21 -0700 Satish Kharat via B4 Relay wrote:
> This series adds the admin channel infrastructure and mailbox (MBOX)
> protocol needed for V2 SR-IOV support in the enic driver.
> 
> The V2 SR-IOV design uses a direct PF-VF communication channel built on
> dedicated WQ/RQ/CQ hardware resources and an MSI-X interrupt.

read this please:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pv-bot: 24h
