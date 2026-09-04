Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A8946A61D;
	Fri,  4 Sep 2026 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788557034; cv=none; b=NkEc+WI4HdBF25pd5mUy5zO/FtLJzP4X+aKsFnlnwyl4pD6S+zhnpno8mr1g8JZ6UsWrM7LlxkJTyJasx8cYDKqnrQ9Y9TGpVoDC8sBkkZyn2Hstgw58huV2Ssi1f3bojWFd0SzEuPJPJTvBuEjDZO56MXvDwEpAfLE2o1qud68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788557034; c=relaxed/simple;
	bh=0IDiW7tZ725+bY7QCphrS/LSmRTomhev4MAlzs3WGrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkp/HSBwq+33ZbxlCgCzgaiJddIsARHnixP6Oysy0KT+cvUAslyjIpSgxDN+e9YDImc2+rnIAhqr0uId1dSanNRrEYgaexI/4wZG3uUkT8U0fMoCki/n/ALmaSbotRY1a5vWnqqMG4YihVMkmRxrak8unni8jMMMvjz59JmG2Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gA5yGJWR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gA5yGJWR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68441F00A3D;
	Fri,  4 Sep 2026 21:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788557023;
	bh=GM6payoZrYOXHvrthKH8vU/DymLRePAplWGpbdS+6D8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gA5yGJWRbX+0jomIMXkzBU4b5Wuzp9Zx1ZgkbXyug6hOOmnHW23wmh5Sv+tOVWinW
	 HN43XWK2I7nS8fS72lHsuqmgMLfdf6GNW0BQqfrf9nGmSUi92BGcNFT2/OR8U1qaPV
	 /pYkTm/5ZudRL5RcaBRWVtjbb+Zf92UZhFFuIYAoD7fjrXX5n0kRBUD/JoUp1SKanf
	 FdJKaWXhBZML+yIab5Vv7Nidun9PxOeI3vBZi2Z+xOZDISLeVDVFlW3RA5tHIRfLZE
	 NktkvDVzVkXE7gNfmDR73qGVni63Sc65vMhhzsATAMvPMwDahmf4m1tM7MA8gvT5TC
	 Y06vjVUFaeerg==
Date: Fri, 4 Sep 2026 14:23:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, Hannes
 Frederic Sowa <hannes@stressinduktion.org>, Wei Wang <weiwan@google.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: yield the CPU on every exit of the threaded
 NAPI poll loop
Message-ID: <20260904142342.649c4ca1@kernel.org>
In-Reply-To: <20260903231253.292576-1-sochnev.v.74@gmail.com>
References: <20260902154836.19a497e5@kernel.org>
	<20260903231253.292576-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Sep 2026 00:12:53 +0100 Vitaliy Sochnev wrote:
> So this fixes the architectures that still have a non-preempting model,
> and the stable kernels, but not the tree it is posted against. If that
> makes it not worth carrying in net, say so and I will keep it
> downstream. If it is worth carrying, I will send a v3 with the numbers
> above in the commit message.

No, do not send v3. 
