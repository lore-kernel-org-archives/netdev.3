Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26286350D4A
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770835761; cv=none; b=tHQ57L3RL7XdEDWwqWmM9AzopsxI0nikznD5Egh01K+rP4SIdfe86OuwxoT5FLlbbhOAJUUQAXG9oBAQgeW1avQ7FmJH0RKGQ1GHz6BzJvW8h/0Phk50dPIS5YARuZ7OYYN3RAeKGBMdHNmzTQNtY7V0mV7gUqVAyD/uRXh4IS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770835761; c=relaxed/simple;
	bh=+y0LnP0LIcQSKKzvdN2I8uR3/dU7gboEg6FLLGJ2tEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTyR0pwXo/Vt8TMQwwP9HZdPRtpZRXVUVYteKE92NlBiJpRsG2pqskOujJVqi7oAHjMcCbQIXRyC+ZxDYs3kAa7L24xdhjIgvjJXgLXgK9OMeQdelVwOLhg9G3mv7mQLZglcT7+tXdYnZP3m3EHFj5sYiFOJ1xziNco/WlFq2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkiuLrdg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkiuLrdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833D9C4CEF7;
	Wed, 11 Feb 2026 18:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770835760;
	bh=+y0LnP0LIcQSKKzvdN2I8uR3/dU7gboEg6FLLGJ2tEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rkiuLrdgIKUR7vWQf0fWp72iBuEm3EiKpxUv2rZxhxr9jVZFBQubSh2zt0Gu1FmgX
	 iMv82WMreX25+Do8ellT0z3auNyzv7flMgLzYW5i+Ygw41buYfbRDPgTw4AcDHT2qE
	 A5hLgLLfZaNeG4O1lsTYx/FGwAyxaSQ835JY5K3kCa4pY84eLkjBQ+gDgc5JaNJl8f
	 KeQH7htPAWS1Ie1Bq0Q30dn92rVJyZhYQoGlSu00XVtMjhloa4jMQ35F+q+U2HLcNf
	 2e+4n8r3EqXK0Gpdz7zwC1ZQa2z01vazOkZGVdsjgB3rs4yXmzYqy4YHmU0vgPBtCZ
	 FdqsD7XxeE2PA==
Date: Wed, 11 Feb 2026 10:49:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Sune <marcdevel@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/4] selftests/net: add no ARP b/mcast,null
 poison test
Message-ID: <20260211104919.2c455de9@kernel.org>
In-Reply-To: <CA+3n-TpV8pg9exk15vGpPX3OW1-k-pLSiixUZ2UEvbFOgcc0+g@mail.gmail.com>
References: <cover.1770399836.git.marcdevel@gmail.com>
	<19761bd8088ea7bab2b8c37461aa77be08082fc4.1770399836.git.marcdevel@gmail.com>
	<20260210181106.0f4a305a@kernel.org>
	<CA+3n-TpV8pg9exk15vGpPX3OW1-k-pLSiixUZ2UEvbFOgcc0+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Feb 2026 19:29:01 +0100 Marc Sune wrote:
> > The word "poison" is misspelled but both in the file name and makefile.
> > I guess there's another typo somewhere.  
> 
> Sigh. Let me fix that, along with your comment on patch 4
> (TEST_GEN_FILES vs. _PROGS) on the other thread. I will also fix some
> AI review warnings (error traces) on patch 4 that AI reviews _now_
> highlighted. It seems AI reviews are non deterministic, as
> ndisc_send.c didn't change since v2, and the patch didn't even change
> v3->v4.
> 
> I guess you'd like me to wait till net-next is open again, correct?

Yes, let's wait for net-next.
