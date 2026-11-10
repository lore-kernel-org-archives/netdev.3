Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341913;
	b=243Y7FTi/WQwprGTM+/fPhXskemlOiEABsnjfVk7Zsu7m6g5bV009y2wF36IuuHG9okM
	 zMOrOFZbN4kOpEEyqWIDMViNXjelP1Z97qdjk/miqoY3pQC8GzTd+V1X5R8aaUp55eY74
	 rngCn88+RMrtAmCAyZha0emsyAcdZCLJ4zUpzOoj6ufE2OT03O3fTeR5BJbqTuR8UttcS
	 3X3fD/6x1PWEAssj7Q5eQAvan61jHGNGSCGdlA4NLKh5HrwP8Tfdohd92QlORxRqSrUzv
	 vcRO/J74vYCinOyT7yIfiX7hDv/Iv3PATI1I/aelCbdd2vax8x0GkCehc2/A9+aZwHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341913;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TxVuIEOGQmZTsx8ngNcKeGQ7erzVJ0HzNh0Tj25sa3s=;
	b=0JKbF+guraZI7iFg+VgLcrPDuQRHaPNrYJtIZjtrZAL8ZmThk+h9yDqniZiG3DDsww2D
	 Yd4k+SbIrjMIkyQ463NLikOzo4GKgtI9suwkHmF45SEpffteWCVlwFZlR3+/NQlnOpkrs
	 n216c3lWlEFyVEtmzhBHOmul/Se0jQSzrEVoBztA19GqDB1QBTTzHAE9THVY2+n2MkLom
	 hm3S7rlVmZ89fzarqjggsO1fSR1lzIJI8zff1QY8nu41k8NcY3696I2qdxTSmbNqomFqa
	 Y+Mo9gon1+Cb2cDfAAUrWf9UKKjUJ6B94AFctsalOMyEw7BfKoDzJDfoXmVEWaYR8Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Tqo4/OpT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C836606A321;
	Tue, 10 Nov 2026 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tqo4/OpT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304901F0089F;
	Tue, 10 Nov 2026 20:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341912;
	bh=TxVuIEOGQmZTsx8ngNcKeGQ7erzVJ0HzNh0Tj25sa3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tqo4/OpTuC10duAuZLgLVydNoNEgDijjEoa3zYu+8MU+rfTQZwyHJwawOi/aDtgKx
	 smrQuqnYF6tH3nXG7l1wlbICDFemYExKwnqFgsZWOt4SLVy/n1ecW0nbGd9pRDIowK
	 JqCon1e1flBxjtsHUqi6j85q8YmXeSTkcFAwI1w2+Cz4CqG7oZB7CpB4bye4mWt6gy
	 a7/2tiZ1ODesTARDwm/TE1YT2aX5/ptKQIlO2n1g9FmO2EdiOlASHg/W6rhcRK7GSf
	 PlyuM7A5opC/mWuaa62MfRZxfWEGgdNDAWrmK4CFaA/puzVIZjqpMkUwscBNESVWUN
	 ZxBwv38k6hleA==
Date: Tue, 10 Nov 2026 12:18:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Nicolas
 Dichtel <nicolas.dichtel@6wind.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Florian Westphal
 <fw@strlen.de>, Mat Martineau <martineau@kernel.org>, XingWang Xiang
 <v3rdant.xiang@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 2/2] netlink: Check a group again if it was
 released while joining it
Message-ID: <20261110121831.01412fb9@kernel.org>
In-Reply-To: <20261104092125.211537-3-anilkaushikwireless@gmail.com>
References: <20261104092125.211537-1-anilkaushikwireless@gmail.com>
	<20261104092125.211537-3-anilkaushikwireless@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Nov 2026 09:21:25 +0000 Anil Kaushik wrote:
>  net/netlink/af_netlink.c | 110 ++++++++++++++++++++++++++++++++++++++-
>  net/netlink/af_netlink.h |   1 +
>  2 files changed, 110 insertions(+), 1 deletion(-)

This fix is way too ugly to be accepted
-- 
pw-bot: cr
