Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BA538E8B4
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 05:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215859; cv=none; b=GXUifJBH/x4tondArOhqCjeSE4Cmtf6GtoXuWs0z08M+Ay+t1804HJc3+OY0Chn5aHkWxgaDfV7G+bFokUc6eCcWJQWGmw4kn0pBrp5wtvuYfF4Bps24Piivr26cEbKaR6jMk5Nvba2eW0x6Mu2klIx5wj+xulxgHOv67rP1G1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215859; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I/EGtlyqq6IqrfVQuySWjDBdpjx279nwOgAM0aFoUzSU9fjKuFGIPnH9T7G5+M6W5/POi2NmEz1VX8mWHzd3hY6mnN9evzaSqaTmg8daM7bNFCHLR41iGowrpn6UWXTgqlydq8ITdSLyxSarhFLNzG43+E7n/qQ+0zmzISg9N6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9IULcUZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9IULcUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2940D1F000C4;
	Sat, 17 Oct 2026 05:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792215857;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F9IULcUZyIrEwEuOvu5XsNAIwM6SRBvtSiVD7kyjAvb/IPpEzeDwX7E0zX1pXmugI
	 xz7FJ3KRfWU5u17/NLGmei7jyIxdcNihWS5LgnoVO1zDjarEgMKz+6MWLPjuvlRqpp
	 e0sSa/BYFOwCEgk6GtlBkGBakKvg0KQbmlkMMl8W/uJZfLFpt7ogGMGXIGrjyhBsri
	 OvbzeFRgiSULT8ElomYedIlJ54YixSvXgA/dslOoBhlJAJ+WLyOeU1TJO9++rh3hnW
	 Lvcfs0Iq/PxRFb/3K90adlYEextfFErjR09m0FC3p+NCIHzJih0ENLhQnk0+vUk0j7
	 +fU3Qto6OF+hQ==
From: netdev-bot+sinfo@kernel.org
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, dsahern@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 leone4fernando@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v5 0/1] ipmr: only copy pktinfo to cache reports
Date: Sat, 17 Oct 2026 05:44:16 +0000
Message-ID: <179221585668.408196.2364094922032134255@kernel.org>
In-Reply-To: <cover.1792215075.git.zhilinz@nebusec.ai>
References: <cover.1792215075.git.zhilinz@nebusec.ai>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
