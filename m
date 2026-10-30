Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398067;
	b=OIMfnX6bDdl6M0jr+qZ3y9/8biaQVhnwBwSrjj5hOSVs9vUYn8An2DAKmJbhHRW1c6JW
	 qBxV2D619aUcpnGH4L7/nhsLsKFCpvWlTKo2ublSgTc/a1wl0lvU19r0Xdt7u11oS/69r
	 3RzPv26L1+s2g/7xUkjJp/4TsmVVxkFUmsF+t0wUI6uGSde12a+ue/CiRa4CiKvb20sS5
	 6tJm8LCLYJhiv8Gtsa+lDNtDDJZVsfilsmrFOk2taR/h1jPfGlDcdFdtobLP/WKYEStmW
	 xOWu6jI6w3VmjBE48O8G769JaoSTPveFCwbprZ1LX+Jx+3wVi4G2FoDOX/sIJf4pLyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398067;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=O6rbWDigYZwy4ez11pR5lpAnfy34Kwiy/oawBy9xKVI=;
	b=vYvuFf5w5MwqQ7+/APeWxl/zl1qtp5muPs/biK0PCrHss2Wao4mllf0r2em8ZHZ1mkkS
	 1lZfydpMdQMRaQT+3O0CKOAd1cvklNfaBRlWk0uwYQl0To5Gt8Eo6sy1YlX/WBcjAVNm0
	 uTPfVwodBUB5nuFNp4ectnxdR5k2i+L154pqZk5rZTB+Ye2fl8AvFV87YqhrYI566XSqN
	 wpySdKYAa4oE94P/WUP1J3qsMP1qz3GgWYorZHMRTllo78x7EVTZyqouFZe09pHObEo5O
	 9KWo6R+S5w9nqXzzbBe5Jkj9ZAepM5YCK7p4FxWJwGa02OedoS8Lp+u/PCabsSX6SnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btuk9yZ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8720606A31A;
	Fri, 30 Oct 2026 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btuk9yZ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB061F000C1;
	Fri, 30 Oct 2026 22:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793398066;
	bh=O6rbWDigYZwy4ez11pR5lpAnfy34Kwiy/oawBy9xKVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=btuk9yZ1nNBmCgVPjsh7CLx9+WvtSC+FnMwN8Dpagy7CK6g4vKn6AWMD304OekPOo
	 mmokEZMtoB7ixV/JK1AupnicJiEPUwaO5FfHKuNWICcQCmm/MyZm4QuT0k03ugoOPb
	 wi7ynpdcCLxnuLqP/nLWFgS2ga/gxsTtf1BDNGxa87i/HE0uMeY8k0Qd2k1e0b8d4o
	 61tOK4qgNvYNAMdxXWIAGp/U7Eg7pxl8txlOvEa64inVXIT7UTcwjMlp4arQVW4OP5
	 xCMZ9pT3Vts+olezqIjL4cIVUvXyw3SeO9tUpsbIdMM63zZJysw+qRTwTL+O1Bv/l4
	 FcND6cDtQLF0Q==
Date: Fri, 30 Oct 2026 15:07:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Tung Quang Nguyen <tung.quang.nguyen@est.tech>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jon Maloy
 <jmaloy@redhat.com>, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] tipc: raise the minimum bearer MTU to fit tunnel
 and crypto overhead
Message-ID: <20261030150745.50817de7@kernel.org>
In-Reply-To: <179338105585.65961.17235832504055289741@gmail.com>
References: <179322942644.17111.4355153262478871713@gmail.com>
	<AM7P189MB1137B1760C380E81E5A3CD8AC66D2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
	<179338105585.65961.17235832504055289741@gmail.com>
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

On Fri, 30 Oct 2026 14:24:15 -0300 Joas Antonio dos Santos wrote:
> The only items in that checkpatch run are about the Assisted-by trailer:
> 
>   WARNING: Non-standard signature: Assisted-by:
>   ERROR: Unrecognized email address: 'Claude:claude-opus-5-5'
> 
> That line is there on purpose: it discloses that an AI coding
> assistant was used, in the "Assisted-by: AGENT:MODEL" form.  checkpatch
> does not know the tag yet and parses its value as an email address.
> There is nothing reported against the code or the rest of the commit
> message.

Hi dear bot,

The Assisted-by tags are deprecated.
See commit 1e035297ffda ("docs: remove Assisted-by references")
