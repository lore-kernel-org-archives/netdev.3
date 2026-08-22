Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7870F31B130
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385817; cv=none; b=nT1JgPbbDD99Xc9ANinYYouc7Pf80XKPZWuHx7TpQaN8cY2rBA9q+xzYwoxZxfHKaQ4nRy8iQbwabCyDanzIPaWAum9AyjOthETgEaB97beC/D4+rxFu/qJ9idAjTNE+PvwFYYLzPIkKXxoNwXAR5jvStMmQ0tvONT/F/I7v77M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385817; c=relaxed/simple;
	bh=rOHctsflP+p77cI+xebyXbGhaBom3LEa7o0fnox+cY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knSmz4VCCGOtAsYBFbeEwAq1RUfGOCfPSvVpH9NGV8LIgALpxZZZvOmA1hNFq7sdJqX5xM7dWcf9JRIet0Hik29nYC9ix7pYoigqzC049tYoOyaR8vm4ei31jRv7lySe/cng0rBgMxXoNKLYYBs7mAJ8rdZklpIgqgFR7PQ4858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id CCE456051B; Sat, 22 Aug 2026 10:03:32 +0200 (CEST)
Date: Sat, 22 Aug 2026 10:03:32 +0200
From: Florian Westphal <fw@strlen.de>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, victor@mojatatu.com
Subject: Re: [PATCH net 0/4] net/sched: reset conntrack after packet munging
Message-ID: <aolX1DFk8wRzrxK5@strlen.de>
References: <20260819204210.23722-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819204210.23722-1-fw@strlen.de>

Florian Westphal <fw@strlen.de> wrote:
> This series removes skb <-> conntrack mapping after pedit
> altered l3 and/or l4 headers.  See patch 2 for all the details.

pw-bot: changes-requested

Not yet sure when v2 is ready, if it happens at all, mostly unfixable design afaiu.
