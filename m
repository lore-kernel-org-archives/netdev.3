Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3A937757A;
	Thu,  1 Oct 2026 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896206; cv=none; b=X34QemwMKC4AwzNLhQAy9uIh9xcH8v+pY4r3866f+qRy0BhVh17Seuv4hVohDTe+xoKJoHo/PvqKi8Ic3y8LDdAg9UVUK3r+F/NtdkeswoXoMyCB74fZgW6W5yEvgaeTUAKVFDXOPbz1kUSn0QetmgJwIc+Trb/xrNEmwm6+en8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896206; c=relaxed/simple;
	bh=z87w8MoZ+Qn6OBvig5boJ6C9unMCjs36MFif1Xp4Kg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBDUWHffmD4LRh7s4qZ7YmY9sWW/dRJ7vQWE2LVjfwBEH2fFephJmXBkQM6TUGsSq/V6bO4jDYf4gNEFEVk9/K52pljCMyyrx9pjmHEhRNVHK5Z0msCaza+9nC7wdTNpwa1OTOdCEtERHzyXOB2SXvuI0Hs+kTYBD820RNrFIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOIGjTeO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOIGjTeO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405061F000FF;
	Thu,  1 Oct 2026 23:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790896199;
	bh=44WkaQv27G9pRjfZNgJv3aHgXLvLm0g/fnbEbxkv8nE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NOIGjTeOgvMbXXAfh1ffs10D9b52ZHW8fKCA9pYW2nLOIde6PpjaQhXEtAFCfQGS7
	 OkH6fOnirrdG93bG+OZIi/CE4DOaiToMPh+QubVAri2bSXwPelcGTEpYPVJPgi1ArA
	 oEsg2tigT3qVeEeZnAXaRfnKMYC14BYXwPx+jukxtykGg/4O2S6mVWHbUf2rQ4xxVK
	 JMlP+KeXbL4QJt1TGVYuHzizkEJy8q8dFXqE1+jfonjO5U088B2OzTCuDJfI1VaywH
	 c/YwoEHvDXPQuBN5o/rIqzqzTXYDQ18GYGpUtUscvw8uTLwR0pO2OZdkVcIivu/mqd
	 +pSNEU0YF9+LA==
Date: Thu, 1 Oct 2026 16:09:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 co+2cf741c3005abc20@bugs.sh, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2 0/2] net: team: fix transmit skb ownership
Message-ID: <20261001160958.00a95918@kernel.org>
In-Reply-To: <20261001182326.572045-1-bestswngs@gmail.com>
References: <20260926090039.1714460-1-bestswngs@gmail.com>
	<20261001182326.572045-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Oct 2026 02:23:24 +0800 Weiming Shi wrote:
> The queue override path can pass an skb to a lower device, see that
> dev_queue_xmit() returned a drop, and then reuse the consumed skb. Fix
> the handoff decision separately from the transmit result.
> 
> An AI-generated review of v1 forwarded by Jakub identified a separate
> broadcast-mode leak: bc_transmit() returns without consuming the skb
> when no port is txable. Fix that in the second patch.

Do not repost just for this but, please, DO NOT post new revisions in
reply to old ones.

See https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pv-bot: threaded
