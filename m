Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8072C2472A2;
	Thu, 13 Aug 2026 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786586606; cv=none; b=N7FOOoUQm3gVPKTnZDzykvQbzAGZnzs7jDeJrVf/gCkN5aw5nz8g4q2cmQGCvy1NXvNnH8ixTWy++9xzIxV25dL7JjndWkusF1bIfrGcfhz8Xn0f7OIVlEGBy5gn9TVRJMpGH/ITLtxehdQn7aPkmDfkD9v0+i3qBsMBn60HeZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786586606; c=relaxed/simple;
	bh=Sug8KQL5r7vr2tsZGK8XwknfZm9N2ooxPpUTKZoeKsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLC43A7SyygijJNi3ITT9ElOQUBq0AXXnVuf0hebrZQE3SxCry306fiJK1db/KdHIKnbNNB1kRTxi+1qb9JXn1nzVMEiGWQVrOxSBkuqDncrs2T8Hd2GxxuP3zS6qWuV/eezGQJ1AoK7fQmvWVEBB1DyZRY7eYFU4xsmagltvec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nki8BIcp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nki8BIcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40191F000E9;
	Thu, 13 Aug 2026 02:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786586605;
	bh=jCTUMArY1H0zB5+3CAoeYELF6mW1rF1l6Auu9xSrBw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Nki8BIcpLJtYv/nNK2haI7WsCC3tnHaueKUnpdZOfV9RiCMLVCBcvC+QoN8fVuA9U
	 WXpHUponWZlw5t5tJMy0336KF9I719BNOgLCyEtPJBU+7HZRZGzC9nXv6f2mgYVSLN
	 NU/U/8YkFQsqY9E1Ty7aex6yY1wHYCeLjbsBdxijz5vSVbnB+BfInDxzqVUmCfvp7R
	 sx/hnWrLf3SFqXdwIanRT0ptICuuw/jvHz9GsmUseVCzwQX2fTzFb6NUU4qnIKZJl0
	 1frRal9l3ha9rcZJxBpwqTmHALuO0n8YdJnljCIGHRTFOk18DG49qiG4V2LMdVgnQ8
	 LLtPkvTF7m7ig==
Date: Wed, 12 Aug 2026 19:03:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Li Xiasong <lixiasong1@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com, weiyongjun1@huawei.com
Subject: Re: [PATCH net-next] net: core: avoid WARN_ONCE for stale RX queue
 mappings
Message-ID: <20260812190324.74c7330f@kernel.org>
In-Reply-To: <156834bb-8e40-496e-9443-9d515fa18eab@linux.dev>
References: <20260810125029.1567742-1-lixiasong1@huawei.com>
	<156834bb-8e40-496e-9443-9d515fa18eab@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 14:58:31 +0800 Jiayuan Chen wrote:
> I just run ethtool -L rx 2 on my host and got such message..

Looks like veth fails to restamp the queues, tho, doesn't it?
If so it's not an accidental race, the drivers are buggy and should 
be fixed..
