Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4CB26F476
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464243; cv=none; b=FdBC0LVU3N8m4VlZmXNmo4Zvo8WVbPCdAimZXfhLthD8y7GKGBCQpxmwF3+iyMYk9j4eq+x7jlXubCWAt5otr/a6SkyA4fxfeGcEnW5Q3O93MsZW7jjJY7MhB09zMjNsFSRr5+4MXKFrbyBRkpeTmf3x0aFYPGAUU9K78g3OyLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464243; c=relaxed/simple;
	bh=dAVPQzoE7fh1TzfulR4lmYyQOSA3wGyRLDqpWp1jUF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rB5V9r0NoijGr5aAdlSOqZTwNuQecfQOVUHlcHG8nRPcaecujF7J2P8v+6m+0efoMS93t4Sf+GlF84XEQMfF4j1tNrUarFUSpID+FZ+rbmFqdIPI9wBGUayjWOAiP0hLjnZvB6l8+ImyMaBpDQl7X0mrPUHiuombtlaG2zRzi5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZyUdBZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZyUdBZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED9A1F000E9;
	Fri, 31 Jul 2026 02:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785464241;
	bh=dAVPQzoE7fh1TzfulR4lmYyQOSA3wGyRLDqpWp1jUF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CZyUdBZKqMIT6u4+QPcM2mEW1sJ8obY6wi7GMUvRgvv9QnEFr8ehOQ4EREupunuus
	 WodU0gO/amj/OFQQlY7OTqDPBJka0+diLsUDDd7M6ayeQRHFJ0SFMoyVPmcfAkoikK
	 Pduq9XDsHpTUZsUFm6SsjKNqczgnwN0cv9H6nMdVm7B4zmlJTmhhb+ewKskTO+HiUt
	 8BZaL5BlFSJqT+abulsv3rU7ri5wR4vMyKuutvO5dh6f1ls1u+2Z7e2IhFjUvwin+3
	 f5YnvGG2LCDo5l9jMYRqhmpL0LKFSbjIgZvM6KFmLmW38sBU0fLPIP2aZ0sNfVF2U3
	 zSg3wwNEdO37A==
Date: Thu, 30 Jul 2026 19:17:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Herbert Xu
 <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/8] pull request (net): ipsec 2026-07-29
Message-ID: <20260730191720.2b585d44@kernel.org>
In-Reply-To: <20260729065035.1591985-1-steffen.klassert@secunet.com>
References: <20260729065035.1591985-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 08:50:10 +0200 Steffen Klassert wrote:
> Please pull or let me know if there are problems.

Sorry for the delay, patch overload and Sashiko found some issues.
I haven't had time today to investigate either, so I just sent them
out as is - LMK if they are not real but AFAICT both models said
the same thing here.
