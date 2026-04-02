Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB271332EC8;
	Thu,  2 Apr 2026 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775096566; cv=none; b=oesFRe8/gBZo0127BQ0RHeOOx4yzCzvA91vShXL8rKWlirJCfoD4Bcd7a05JodJRtHkk1ac+6bP+YGvLrtNECb3oWTucxmRpG85Qm9MBQIMtlEsXwx1wPRhbNVEbKtkefiCo7z03POFGAzz3qSHBiZSA0UQEy8B4XKin0hZ9F7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775096566; c=relaxed/simple;
	bh=Cs2W10ZanYvXxPiiu247FmbHfFbydHY8JNJIlV6zew8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWqUa90LBRkQ87sBxdTqSIN94IrzXbGK3GS3QyEhivugKF4Tw+k3FkQK/rUMHfnY4KKhh4p/+MgVPcHmWQytwKf9e5Oezx5ukpGnPEoSx6+TaMjxOj/QYUD36BMxpUaAgGEkomCESpGOac2ddBHMvvdhV1bYCqV8ltwYYXYD47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBXuljxB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBXuljxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4614AC4CEF7;
	Thu,  2 Apr 2026 02:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775096566;
	bh=Cs2W10ZanYvXxPiiu247FmbHfFbydHY8JNJIlV6zew8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IBXuljxBubnNXF7cywUR3XH5sqhG7unN0yADGLRvAQwr+Vg7i13YKsu79VVLfuqBY
	 azNZJZZv2xEaLP3touajdNrBOgJmqHa4x1Jiw8OQrl1X9t1tVy/kGXovGByIKJRHIe
	 wpnjuCaKjrKNU8eKl1A9SYH/vZjZPJRVv9Sz0A8IGv3C16sYn07toDLGhF81HHqjSC
	 kFRtnp0fcU9F+H9WBtnpCi1WeDWiZwHmpq+FLe5RryhbjImEn9JFsiCQJhb/Hlh25R
	 qJD4SvXdmgudQj6WpBT9txX0kJDz+ln/JFgyMB9dpKI+FkiyVcOycWjIT/HXVYAZZU
	 GYZQWBQgMMJYA==
Date: Wed, 1 Apr 2026 19:22:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Anderson Nascimento <anderson@allelesecurity.com>,
 netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, Luxiao Xu <rakukuip@gmail.com>, Yifan Wu
 <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan
 <yuantan098@gmail.com>, Xin Liu <bird@lzu.edu.cn>, Ren Wei
 <enjou1224z@gmail.com>, Ren Wei <n05ec@lzu.edu.cn>, Simon Horman
 <horms@kernel.org>, stable@kernel.org
Subject: Re: [PATCH net v4 15/15] rxrpc: fix reference count leak in
 rxrpc_server_keyring()
Message-ID: <20260401192244.6ad86fc9@kernel.org>
In-Reply-To: <1938758.1775071956@warthog.procyon.org.uk>
References: <aa7aeb86-2430-4c67-9d5d-bb27ad037865@allelesecurity.com>
	<20260401105614.1696001-1-dhowells@redhat.com>
	<20260401105614.1696001-16-dhowells@redhat.com>
	<1938758.1775071956@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 Apr 2026 20:32:36 +0100 David Howells wrote:
> Anderson Nascimento <anderson@allelesecurity.com> wrote:
> 
> > Isn't this the same issue addressed by my patch "[PATCH net v4 08/15] rxrpc:
> > Fix keyring reference count leak in rxrpc_setsockopt()"? Just asking to make
> > sure this is intended.  
> 
> Actually, yes.  This is a different way to fix the same bug, so I'm happy to
> drop it from the series in preference to yours.

Would you like me to drop the last patch when applying?
And in return maybe you can scan the AI output and tell me
if any of it is legit? ;)

https://sashiko.dev/#/patchset/20260401105614.1696001-10-dhowells@redhat.com
