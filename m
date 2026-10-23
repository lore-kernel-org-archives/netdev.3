Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789792;
	b=J7oq0JkPWXL0TMkYokIzcnYuViVrNQln1cYGlGt7iWx8R1mHHMeiLugF0kqfp23f/SBS
	 fbJfvw4XBoE954/K/JaS6nTm9fQ6fD2jpQrBcQzjRWWADqHacOxK7YLHNkDbxBhMIKQQ2
	 bm1wCtqCImdNEYp7kr0tz2zFcCsU+RpZ1RYWLDDyW+ZkPiPG15ESbrCDpxPBVzLPohSLE
	 bIsy519A2DDSDEDB6bocsyaIYVqK6V8n8lxHMjbmdlVz8hGZ5nFwbKIQb6VYLigr3Fshj
	 4fJ1e2bAeNLu3iGLNMt6/kIeHtnj/d5ApNVnaSL61JT4GVifg4NOd0BOVmsPekK6fMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789792;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=L9ueMUWnDux2nt+/nfTz+Ix7qemPLUygViRTEGpdFBU=;
	b=YxTEvZMFH9IUMBHAEh2ppav+zHwwYeZKTIbpulYnif9zo5lJUFdxOTK2IU09uZM3VOai
	 YhPAS2F6S9hrUEK/rIE7lcFoiWjvRn3BBUq9bT6Z+u4mnTHlRFKQGBb0AlbSlel5h73aP
	 voEkqcHZEwLkWIkiiJFe6J72oH0y62algF7vvHLSQ7Ty16Ixu3GWpDa56E569M7YrXcnl
	 cAo5C/o9kRWpmRB1Vxud5/Ik9nuQLTLZ4hzCkQQh+qmuiyE2eMiGAk6sHZFFItg9OUJgD
	 d6wVZNW8QmHk1WanXVJJ8lLYFg6/LcwVzZFwf1fL1F33mo8auW03bWGT7wclcJNE+Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXliCkz1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD19606A31A;
	Fri, 23 Oct 2026 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXliCkz1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDF51F01825;
	Fri, 23 Oct 2026 21:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789792;
	bh=L9ueMUWnDux2nt+/nfTz+Ix7qemPLUygViRTEGpdFBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hXliCkz1nfBk+W2FUvNxUgD9XEU43opXx8prAfMelLZ++wDCrJP/cg+mpo26B5JWn
	 e44FgVbdW9i/9YDDU6cv4cHrwhomoSKor/DQfp7LIDz2TyDTH9HuaL7KGrD08jA4Vi
	 cEfHYC2ChrueR7pqxgPZnCsyLR2FribkfiXcCKiR0h/m9n8LXvBZPKr3j/9XErVVZ/
	 8KNgATqVmZFtSzjD3MpkL5P9G12c/7PVJzXfRuKcI5yaTQmbg1oj02UPOdN7V4op/z
	 zQPm1y/4cYhzBdQwm+kLTvTxnHoPiGz6IuwSbMmUx6MSSJjgck8W9xFvwDTtP/ftgc
	 zvJDp1GtX5/wA==
Date: Fri, 23 Oct 2026 14:09:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, John Fastabend
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] tls: fix the open record check in the max
 payload size setsockopt
Message-ID: <20261023140951.5ce950eb@kernel.org>
In-Reply-To: <20261020121240.29082-1-jiayuan.chen@linux.dev>
References: <20261020121240.29082-1-jiayuan.chen@linux.dev>
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

On Tue, 20 Oct 2026 20:12:39 +0800 Jiayuan Chen wrote:
>   - no code change, explain why tx_lock is taken interruptible, in the
>     commit message and the comment (Paolo)

I dropped the other comments and retained only that part
The remaining comments looked obvious (please try to avoid that)
