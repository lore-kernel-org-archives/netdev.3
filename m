Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564531;
	b=b4j+fl2QWn5Fwi+aFwSInttRQFVO7hbBrrIllu7D3yisAmfBmZvWuFNqFYJ9k6gxE/gw
	 s9pDmekfwz3rTMGwAhc0p+2imuURXS5MyNV0PvyTeirDaP3cp5FmIH1izKG7v6CAdXN7k
	 XGMjCOKhIROZI8YcUbVtewb8SQlyOfrdhC3cfiBSXJE9vudd8ZxaMW1fFumfZwdvR5TVo
	 WPEVBtA0gTmT6+vWXhRdSAxwwVC+4xnOXOjYBfWDiEGx2vMYxMcQjenFSiad6hYtf1Si9
	 AbgNvr0vaRPvPxb/ICbphJlzZn7yBMa0vM7MtaGPmeHFMqib7tph147z26/9V5IjDow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564531;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=A7+cdFdnHLulC8I5vnxAKY144rHW+m5zUKdUuFDknw4=;
	b=JnPKoPHD9gcE8VtjenJycBEN4BxUUDYiM7uRSBXixBv/c3HCx0rK2Hq7w0Hy1WsfmfZ4
	 X9vAR/pum6mdV8hR3nvZmWZei7axPcOTnWg09mWZwZsbvz2lqsbDZkPI1U4Z/5TyPyYKz
	 yfL9MNValGCAfvgStGI4f5idrKXOvX1lEQkj5Id5vimIiOqgZ8EhzrTRNf1OjLzPRihOP
	 5Hqjr4KXijFxoLsBys2jbo4Sn5uTLtwbpKScMAW9SLCuZ7axzKX3ZtCU3gt5ixGzUL+ki
	 QP7RvtToc+VxykagLQPdMFgMX1x2s6u+oLR4mlE/dzUukWnNomMNqRNupWQiSCGIQxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QVkhOzVZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD96606A887;
	Fri, 13 Nov 2026 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QVkhOzVZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE0A1F000C6;
	Fri, 13 Nov 2026 10:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794564531;
	bh=A7+cdFdnHLulC8I5vnxAKY144rHW+m5zUKdUuFDknw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QVkhOzVZgmJB8YGkVo7kPFvhsV195Rk8Y4679MIM9FDnoMf+u3RbaJHh0M0Nth5Bo
	 3lzWperzFrcfYMLX4F4ioBPcaT7lLe/Mv4+/gs/TpUdN5rkuPEIJfx/CBfKlnJ6AAp
	 bIJ8MAXhe97zSv3Xn/r6DorHvyhwdGPBiDlkXYl6NhCZt3TAaiWOi+b5ESJvAF0wxq
	 xHY5JlxGXMqFVeg94Gneh17NknLedhZfqKqhJKIqZ2g6e9ps/5OBdgIQUE1ar52S9o
	 PuGSmqILF+r6yhFFCVkxLqZaJYCEAOpsfY3l990EOo4h3bYDwreDQ/ZOPIrbWKGNBJ
	 faOrrX22lbcQw==
Date: Fri, 13 Nov 2026 10:08:46 +0000
From: Simon Horman <horms@kernel.org>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev, David Heidelberg <david@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thierry Escande <thierry.escande@linux.intel.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Samuel Ortiz <sameo@rivosinc.com>, linux-kernel@vger.kernel.org,
	yana06070@163.com
Subject: Re: [PATCH net-next] NFC: digital: fix target leak after Type 1 Tag
 discovery
Message-ID: <20261113100846.GJ18859@horms.kernel.org>
References: <20261109031832.37642-1-yanxia@cmss.chinamobile.com>
 <179419447430.488859.5809759694387881043@kernel.org>
 <20261109035234.47231-1-yanxia@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109035234.47231-1-yanxia@cmss.chinamobile.com>

On Mon, Nov 09, 2026 at 03:52:34AM +0000, Xia Yan wrote:
> Hi,
> 
> This was found by code inspection. I haven't triggered it at runtime.
> nfc_targets_found() copies the target, but the T1T success path returns
> without freeing the original allocation.

Thanks. I agree net-next is the right target for this change.
