Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6484633D6F9;
	Wed, 20 May 2026 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321469; cv=none; b=n78lkFCG2U5oFtEdB3p+G0osToRA5V0DHJMsuY62MSXl99jxQYf9Bh7L74zgU92BX9yANU4Ow2XdOEI665JE2juL+LmjxTOBB9uGd8aS4coc87A6u4MmnyIThNgcVwIIlTtwR3PdLpFeXUQrQ4mQ6ub+pe0T6gCTIxiIs2CnQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321469; c=relaxed/simple;
	bh=WtG8EcmArf4Z8gLZlLF6rKwPdtxzneEuWsXigFBwDAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjuhkF9YcEUv6eK9zocVhQeRjW1qFvVcZuIpYCBGgvv8mI5WNA9jw2MGwY3FMJgzhU4WHnolTePq1SGqaVjLpp16J85EkDFm8c+gTfOXLHMVYaqE2sHI0XyWwoFnrfsHComenCpEB07WYHKgu13iToEK1az5+1/Tzes4pssqDGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obytBnlW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obytBnlW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391BE1F000E9;
	Wed, 20 May 2026 23:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321467;
	bh=X6DI7mmqfvXQdfna5t6z3c+phyO48RHga9a4FKW2Iyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=obytBnlWNgsZNdo2sqNmjUBgAKaVk2zKmsmXf/v38/izx3LAqiK+wrSXbbfzw2JPr
	 8nlQNOBRsV0RNxu5IzcMr+btHRta9VIM+x/As9ZpMVth6XXLO5wPcUSVVRvctovCmq
	 KgkH7/z/mqEHiLyNwxBpAeXaKs+gGVlTyppSvUGFTgPHnmzhrcwA+ZpmVd7Yfa2YQ8
	 yFi+hyec+6ZhZSgTV7566ve+EbcM357QM6PLMmUFQbn4b0WtyTOuth1xKd9YUsK+Ya
	 x4tqQ2TRpRWlCCj5k6SG9pyzMrYQ9XcekzLn55ijpN98zKffmj/lPNb0vq9QhIvY4F
	 mdQ/opjZ9JPvA==
Date: Wed, 20 May 2026 16:57:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linuxppc-dev@lists.ozlabs.org (open
 list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack
 handoff
Message-ID: <20260520165746.7ed10c7b@kernel.org>
In-Reply-To: <20260517192856.3925-1-rosenp@gmail.com>
References: <20260517192856.3925-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 12:28:56 -0700 Rosen Penev wrote:
> Collect received skbs on a local list during RX polling and pass the
> completed batch to netif_receive_skb_list(). This lets the networking
> stack process packets from a poll cycle in bulk instead of handing each
> skb up individually.

GRO should be even better.

> Speedup tested with bidirectional iperf3.

Please mention the platform / board as well.
-- 
pw-bot: cr
