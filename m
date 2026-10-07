Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02D3D7D69;
	Wed,  7 Oct 2026 05:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791349206; cv=none; b=WD+PWzx6316sCLGwiP5BDAezRP8LgF0LjEw4NeJpHpMl5Or639tMo07sXzoe2pjHVHIQre8nxih9nPNBlLtm3BYoe0N+gP0sqJXdga8nR25XtjGX1jaQoapMcj7J029tE7IASuPHoLEStwBCYCnUIuyyvLV5PgKJVZDHRcG7GaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791349206; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WrKt8NrCjyWd7gEly7cAXPMRi9BMDVD6za+MK7AXkFWCZtMQXKe8N/cyJh4qtqvgBzEu/RU7MfElp0yv6miX1K6qOf3l6lgxRR0+ufqbbD/B4rx1DUOYo9GJd9ZQNhQerbC4mGOVzr6UGfdsX6zwiClGKPdf5g7gRJ2JH07U8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPPtI7F2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPPtI7F2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC431F0089B;
	Wed,  7 Oct 2026 05:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791349202;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EPPtI7F2gyA76eZuBBvcSPzeGSkLbeGq9bO8HSAVYVBhMWSuyz23ExXwtx+rkO9u+
	 oxN7+OZXNomYrUpzESG5PpXpnqdGkTFOR4iAUn/pNNbRtTUzdNA9oJsj2SLIiCVcKX
	 11lsPxOiAVj/xbjVNKKfDwMoIQNXywouLbTpfry/bR+3NsQLwzGhVTvSwJKlwiyb3X
	 EyQl/QH3PdaBQxyTh6t4MHrOg/CzLfpXyT3TofpCosaz2Bedid159LIY6x9+RprUfm
	 E1VlsuuKC+KXg+tJDc7EKGOmBBAkiiCEQsX8msnsG12+QLDrAz2mU5CakI52BbmyzA
	 ifyfWRtgJh5cw==
From: netdev-bot+sinfo@kernel.org
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Amit Cohen <amcohen@nvidia.com>,
 Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: do not warn on route notification size race
Date: Wed, 07 Oct 2026 04:59:59 +0000
Message-ID: <179134919973.2527009.18433178993344012690@kernel.org>
In-Reply-To: <20261007045410.3806739-1-4ncienth@gmail.com>
References: <20261007045410.3806739-1-4ncienth@gmail.com>
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
