Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8FA1A6835;
	Thu,  1 Oct 2026 23:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898389; cv=none; b=ggFt1WsUohRgaUYMt2KwiCAEmbVtg4NqMDAa38eLkEwDSslsCjebIuHU4Jpp0+Mzcqaf3yMKZ+bQgIWyUbUBL72ZDn3edzm+UucVyft+JT1L0Yoi/uRRboawdxp+JWnETo72CD50Z1bBFOrho6Puc8j23lWaP1xeqLITCyhcg5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898389; c=relaxed/simple;
	bh=lelPy3l37ARF0iLE+KruuBqH55rOgq6gLhjAXTiFQU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0YhHsFGgEamNnPho9VDaWU61jvRN7ZQqVefyExzfILaOnfvgWz+BDNcU+Yx2jNGCgpQrZWHIHgj9zvRReSy5MSTBCBPV4MxJmSH6+kXM8AJsbYFckaqxvhPo/8rRBfQl2H/kRti/+UuVoU13BoEmbdhEcb7CgKEiTJdtJmt9hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRDno6Tf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRDno6Tf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF981F00898;
	Thu,  1 Oct 2026 23:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790898388;
	bh=apcpNu6eZWUbgayhY1BqCRzrslGw9VANn8aB30+r3NM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fRDno6TfFVlKiS4IGIyHeR8oWCAr1bFOXiObpgnsdhCJ5Vl6defIjT8YMUd64W0MC
	 9xjCLV/W2WcV+e47z+Q3uXV+X7Tj0fiPM46p/RsLmBt+8EmCtnQ7zRJ/Fr5JiF4Tfh
	 hVb55gjqq2vOcEZGyDlOQpfylONR9Gka2DhFAeAytr7rYPH/LqvsN4b8SQUvZSl8Pn
	 vM2d0fKcFBxo2MLeSAMzuM8xl8xvOSEfvlBnw5ZObypR4tQAVOVdTBXGAZWyw5uDfA
	 iVYSsMLwf/FVGdzyvdkW+PWLdzYHd8vHfHraQDd4PDP+/t6+62ZG/R/77eG8HMJlEM
	 0224Ox10K9nFA==
Date: Thu, 1 Oct 2026 16:46:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: nshettyj@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>, Sunil Goutham <sgoutham@marvell.com>, Ratheesh
 Kannoth <rkannoth@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH net v3] octeontx2-af: Fix BPID leak in nix_bp_enable()
Message-ID: <20261001164627.005ba3cb@kernel.org>
In-Reply-To: <179057876428.31693.4036993774330437044@kernel.org>
References: <20260928065718.3378580-1-nshettyj@marvell.com>
	<179057876428.31693.4036993774330437044@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 06:59:24 +0000 netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

You should respond to this, lets you find yourself with some auto-ban
for having too many process violations :S
