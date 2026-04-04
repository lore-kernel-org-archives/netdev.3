Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0688396D28;
	Sat,  4 Apr 2026 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775296230; cv=none; b=NcHmdkTuf8AR0mfKSPX8vrIlN2nLEzHj9cqiN7ANW0CCwsbJ9jmUKzktmY44d1bBdVRI7o+wStoW0kPrMUNxnILsP1H/R6k6sCInLQ0YeY1YrSGil6tMaf7eEHzusth0+EtMcEKk0KNBrG2yt2LtOSLihL8e5qs9LOwnd/zHl/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775296230; c=relaxed/simple;
	bh=yWI5JomHHzvxtJ/Mwk/xCtfGhnNhMAcHtdonhondQAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sA+zfKZpJO3PVbWszGp+8tALBpzaTsdoWx+VijWu7v2LwswGrHzjG4LdcbK/suseeDKKO2L/KnTU6O1/Rcj+JiDe4ulv8yZhq6WI3uxqhziRaWDSxiWfokMwo/E/aeHZb9dYlgoY0iqjZezue6OpPiffN50ej3rsrOqNNON2TU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAp0SPo1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAp0SPo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C2BC19421;
	Sat,  4 Apr 2026 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775296229;
	bh=yWI5JomHHzvxtJ/Mwk/xCtfGhnNhMAcHtdonhondQAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pAp0SPo1ChUJ6IK+nXmhC0HHtTEPg75jSsLLw4skhF85jhxSwpBhPoWz5oI73bppL
	 Itl/7zwlJ214lyuzEVLCKmHEd2CqQEbmbguJmPCzTW2n7h6d515KgrxnH8ZXRmluhe
	 6oN+vw57vQKgHqqmbh4QpQmKTZ2HERlnbYUGZhL26/U+1lQvjcruWC02Y5cJGrfnqP
	 yk9NysoFeI3qUodR2FuQ8zl+QwclvwUhmGftEOqMh22AdjM8298+Po6Isb8FcCVm1L
	 7LpH5T4uJeR21nCcYxy16qmp4MhanTtb9B7D6eChiuBEgPpb2UaE3cJtlg61Lm+uH0
	 FcuLfsKz+Q8xQ==
Date: Sat, 4 Apr 2026 10:50:25 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 2/7] net/sched: netem: fix queue limit check to
 include reordered packets
Message-ID: <20260404095025.GW113102@horms.kernel.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
 <20260402202037.176299-3-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402202037.176299-3-stephen@networkplumber.org>

On Thu, Apr 02, 2026 at 01:19:30PM -0700, Stephen Hemminger wrote:
> The queue limit check in netem_enqueue() uses q->t_len which only
> counts packets in the internal tfifo. Packets placed in sch->q by
> the reorder path (__qdisc_enqueue_head) are not counted, allowing
> the total queue occupancy to exceed sch->limit under reordering.
> 
> Include sch->q.qlen in the limit check.
> 
> Fixes: 50612537e9ab ("netem: fix classful handling")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Simon Horman <horms@kernel.org>

