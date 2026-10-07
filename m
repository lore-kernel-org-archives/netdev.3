Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC9F3A59A3
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791391242; cv=none; b=ieSH4RmQPrgyeCxX5AqLNEDKPRikB+g+3xN8f+TiuXl8hFIplIgy2c5yQts5h2xQZHtOXrzKGJXNT12LHm9jVyzVewbDtomygPjgC3393W83sEZBZH62lYu64cicNs6yPKmfZ6Jl662G6FwcQ/QPgMAt3SfW64NhMEypIhjelmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791391242; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bkdkTE35gRD1DvkN3L15+5+30W1g30pEdyry2vHyutMvy9Sd/lRtLtHhmoba0p52RCUmuBNrmqWaJOoKU1sisYRLKI0J+johpaMzmSph2MhWx0GfRSrFFmm61ZUV///edkVOdJgPHgpGzaN8QuNPCOUsrwDdomnvKx/GS6S8v2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGZCIgjq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGZCIgjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658D61F000FF;
	Wed,  7 Oct 2026 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791391241;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MGZCIgjqyqvmCuRObbkMOKgDFG91XAGhYw5z6LiD1f3jPVMf/3eZrskT+GmyjROGi
	 U9YDIrmrJqIu1jJ/Fe4xmCdWbiWSvzq7i9xDVGKA1HwHlFhrzDlbLknc3t4c0EZFEW
	 Lrr8gNEsDg8Ese6c/wShf6zGN/MU4jAf48rAQVJRkVJAp41agAWMZXjNjFV7iZKruk
	 ssYyEJYSlV6k9Z47U1agloL+jA71jY2VKWzwocOb+ERJa61I7+b2Tz1186mJ5B1aPt
	 aVv9UNsTF07Nw42sEYXkFnp50aWhQW5A3RlMYYy5Dj3vPzvwEtsgPWgCttUpa6JbNJ
	 ZJ9p33O5c4jNg==
From: netdev-bot+sinfo@kernel.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, mst@redhat.com, jasowangio@gmail.com,
 Willem de Bruijn <willemb@google.com>, Paulos Yibelo <habte.yibelo@gmail.com>
Subject: Re: [PATCH net] net: extend virtio_net_hdr csum_start checks to VLAN,
 IPv6 and IP options
Date: Wed, 07 Oct 2026 16:40:39 +0000
Message-ID: <179139123996.2527009.137247187640502878@kernel.org>
In-Reply-To: <20261007163819.3041710-1-willemdebruijn.kernel@gmail.com>
References: <20261007163819.3041710-1-willemdebruijn.kernel@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
