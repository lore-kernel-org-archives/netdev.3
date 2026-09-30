Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FD9472075
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790802065; cv=none; b=CjetIxfjotfY58ua7WnJZCQcRq3Et8OcsjodhT1pOiQKrB45alytC4QkxwaW6gI8FULyHShMANVHO4aGgdmbOQIhFPVYVbOqMyroOA1IwRYLc4cNskjXpsACb7GuDPasXDlZ+pctAcahUFBrEMxKKInFqPNP3d23FVZWzs33KtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790802065; c=relaxed/simple;
	bh=StediAXhZsd0+dDV17cqJ8iabgq10UbTEp0fAp69Bl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiE8K14f4G4ecDRfPP+Dxi4+DiYhjgQCkgbNxXY/lrsgY8RGPcefttvQGjEW9D/OxwlqP895DmcUIU2YVApb5nQ+1S6S1UzYHcYtYLIQXwqafaV9EssGzIojE1uRGVrpaDgvGf6CY9PuxVhJD15xDLdbJZhFkYUjO4NbPKz7wOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koKw7EEA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koKw7EEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC741F000FF;
	Wed, 30 Sep 2026 21:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790802063;
	bh=StediAXhZsd0+dDV17cqJ8iabgq10UbTEp0fAp69Bl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=koKw7EEA8SgqTVJpyccx+p2wc2h3J0foiTPJPsTGP8L/Qn2fvevD+ERTtDdk5flaZ
	 mK76G2GOhJjx74b9RFjbA8y3tDg7EWJSar6tZ5tWw2spMr+Kz3VMF3tBqY1Hn6UQi9
	 aU57DI2Ph9X5VTRpESUmRqnylG4DwVyE9LfdcNSv5kDwLFlnucaZyFNkyo2PMFdGT2
	 8z3+WvxtgDlCgKcQqFiJAqRuGaztUxDwR1+st76TSEzNC/9TlXt4uJbDjchAQTVUlP
	 L1TLn88arH0ciVApKQ5RqXv6vNpW1Nn6s7tDpSUZ/eDFrREwB+eYwc624JglyqSFwm
	 rLQa3qtcth93g==
Date: Wed, 30 Sep 2026 14:01:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Michal Schmidt
 <mschmidt@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <edumazet@google.com>, <horms@kernel.org>, <pabeni@redhat.com>,
 <davem@davemloft.net>
Subject: Re: [PATCH net v5 0/6] ice: fix stats array overflow via proper
 realloc
Message-ID: <20260930140102.05c4b4bd@kernel.org>
In-Reply-To: <e917c70b-a0db-4c5d-8fa0-219ee77b49ea@intel.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
	<e917c70b-a0db-4c5d-8fa0-219ee77b49ea@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 13:55:51 +0200 Przemek Kitszel wrote:
> I've replied to all not pre-existing issues. My ask is to merge as-is.

Ack, justifications seem reasonable enough.
FWIW I'll take this via net-next because we promised Linus a smaller PR,
and the errors here don't seem likely to hit in normal use.
