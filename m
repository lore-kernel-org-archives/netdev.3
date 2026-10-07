Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925143C1A;
	Wed,  7 Oct 2026 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791335962; cv=none; b=Ukw1Q/fM2UCZrOX454weZ3yDT0D8cX0N0g+OHzl9t7579GjwOEvUU7Ec3iOyOwIM0GYxQusm6/Pqg6DhhAxrvcG458pAGBfoXSv9fzpwRB0FJNXVUm3udIas2GKkka1o5xIe5jEy5b0+m1K6dSaNeW/L4q8hnMpiOeel4P/WYCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791335962; c=relaxed/simple;
	bh=jbgbuJaYSyuLKzfgqep3YH4oOuCJ1X2pKOgnOiXYI2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDOJ5aEzoaANaQGFk0J5ls7JHbVCsO9T5Yg/SiR+G2gRmtbzMfacPdYyMYpporYMuJWkNnhKAklfmgceJRHvUcBAPlAoieSQeZ+TDwl4OyFXjFaXMz4ZGyoUgmZJh1E5wf8/7wuzAhS+NgeAFSl39ddq7XjOP/4lWxrNmLxNHhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLAOCnjN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLAOCnjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2911F0089B;
	Wed,  7 Oct 2026 01:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791335961;
	bh=pBkYIUNYvodk3R8IiEtsIyBw2EY7Y328J+F3roMuJRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KLAOCnjNWluBEZdxb2VnT4hVc7ggeb/vHVHapVobn5MxR+Zkozz9Pla1TsTMDOq1C
	 vloa3pau6T000N9m+4hNUfbPH0vBrqaQs7bsGKBL0RFUhAb1E/4gje/Ep9pgqDMEJ0
	 W/ny6zuu6vIvqDT5m9eXfTWfU7qUjm1ph+Bc2CF4vi+hRrGOqX7xzgBwirrZFvGAdp
	 GgpwyFI01hJG5spY1L/vhISFqJ3GxVAwgWrM46NWi9/NpFwd16YT8z6jZisj8dFzdc
	 b5j/vUYjPyLT3/RYSIjv4IkjcC2kwTBrxDNnHkrbfAG/6K982mBnu3ZbVukoMluKkA
	 aPqpkJjulYUWA==
Date: Tue, 6 Oct 2026 18:19:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] tun: use pskb_may_pull_reason() and remove
 SKB_DROP_REASON_HDR_TRUNC
Message-ID: <20261006181920.05336269@kernel.org>
In-Reply-To: <20261003132340.4175269-1-littlesmilingcloud@gmail.com>
References: <20261003132340.4175269-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Oct 2026 16:23:39 +0300 Anton Danilov wrote:
> The errors returned to user space do not change.

This conflicts with some pending fixes. 
Please rebase and repost on Friday or later, when those fixes make it
to net-next.
-- 
pw-bot: defer
