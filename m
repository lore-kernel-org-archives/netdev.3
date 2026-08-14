Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274B4908A7
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734472; cv=none; b=QrMncH8fVEs72KNgx4S00y20xHbPuVzdK0yR3SoYBpJ8vPKexPm9I4Fv1MDLJItt2gsgMLlCMeAwXABG6cg+DaddwCjaP0U8eAgW2HqUL+2zgV5nDbSv6UE1ZJG2KVipH2opn4wCTyfljgo4LhbQzBkfabOW+M9WQg7tVeBGZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734472; c=relaxed/simple;
	bh=yG6PINZP6Ukmeh+3L91it9S/hmyQG5jrbvbrLs8jwbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQuJPdjH3Mf5g+4CeyD8arndH9zSyc5gw1rSpL2LKetdtb6upzul1tPdN9KE0BuwF876KpUgw4nzQu3OWAXvuJztHwrtBU/0KkNSZKwi66d6EDu4rPV+yq9pxCfFL+xUAH7HQZbvvjtXDI5BV1rB2OjuzqrQ82No60jk+vnn36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHKJhxOs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHKJhxOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D690F1F000E9;
	Fri, 14 Aug 2026 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786734471;
	bh=g3c/CEufHDsTOQBuJ5Qb4sAvxxqsFDZ2uVW1zrMkSz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CHKJhxOsn5bWxzyPLSdMTFtJ3gaeCbM1IUYxttQYiLSd/WjnJPJBjfCZg4ir7GHSx
	 F885rL+j/eRVzFKPUaLUljVHkeIT2UE5qITpAHvqhT/EdOc8qUQ1V5NNKJjGOC1Qve
	 uvZp9tnJ1GpZEq7i3JOudubAqddD4kCIXnVD1OqmgW47Y/xF6nnVNbbwOcTCZ/msMq
	 AeLVAVd9a8ey1X6mCltg8nKif3V2O4pBXdCZeT5bhaziUv+AXCD60QKruRXBmx0f4X
	 +coU3fQ+JNpWIaTKZVE02rMLnyLWJP6WOQdVmEjbjMdwfUSozgpWBJMGRW0f9PgFbh
	 6cEjLvh9hyYpA==
Date: Fri, 14 Aug 2026 12:07:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Raczynski <j.raczynski@samsung.com>, netdev@vger.kernel.org, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH net-next 2/2] docs: netdev: clarify expected
 interactions with LLMs
Message-ID: <20260814120750.420d75d1@kernel.org>
In-Reply-To: <an8OY1XeDr1ajATf@fedora>
References: <cover.1784884817.git.pabeni@redhat.com>
	<83360de7addb13a3b5f4d5e722148f248fdb2ae0.1784884817.git.pabeni@redhat.com>
	<CGME20260724115642eucas1p29f9c8bdc59a889ad66cb7b2a52cdaef7@eucas1p2.samsung.com>
	<amNS9/owsgr44v7w@AMDC4622.eu.corp.samsungelectronics.net>
	<68b50e02-c238-48c6-b2aa-98eb21077329@kernel.org>
	<an8OY1XeDr1ajATf@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 20:47:31 +0800 Hangbin Liu wrote:
> I think the ideal way is for the result to be subscribed to. 

It'd be ideal if y'all run the LLMs locally before sending the patches..
I understand that it's not always possible, but let's be clear on what
the priorities are - as you say netdev@ is already too busy, we don't
want the buggy submissions in the first place, _ideally_.
