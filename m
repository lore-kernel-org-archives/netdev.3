Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3B3148AC
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366502; cv=none; b=ET9Pqe6Mm5vfOkBGJ3j28JMLU1Zw2G+uE04RIFjLsj2BROaNtVwyDq5JDLkyiKXf3tn2PS86LVK6V0DpdtKWD1ATQTGClz7BmMpM+FArpfVDFPTvDS9VdsslXRUZ/T1vZHYd5gZJrx54i8VzJKnT3b1jcpU0QDERG0B7kO37DXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366502; c=relaxed/simple;
	bh=RGsEEAf3fe9o1b4Xmh/yFSBg989GwNii5JhVr5MAnS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nF6YsMnpi8uwh7b8/YhEQuvHj6F9O4GehrvQyQ+lQwF+x6TFH4vAQvN+mBNq6tVa6yrhqPgKTAx4lGDer2B/ApvG21RCsRNAi/6i5CwxTxAqQXixacgwQMBncKJ6yMR9J7Hdh2tifMevN04IeaVJD3zVwiIGofp3P1jcOTCCWwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkGHQ3aA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkGHQ3aA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48C4C4CEF7;
	Tue, 17 Feb 2026 22:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366501;
	bh=RGsEEAf3fe9o1b4Xmh/yFSBg989GwNii5JhVr5MAnS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mkGHQ3aARG/4ZJ4FSKoD0eLBtN+G20kqEMb3TSl5T6J3hqFltQ42pS8QdxZPtQ/B0
	 rFSlhhwbpDAhR7nDJjoEin/KNFUIwQDXlo+Nkci0Ai+T0McXs9ZIZPC8j/+sSnYt00
	 SQ4j2kgo0WJceZ2IdpBEL9jCFt+adq7Dz0tGOV457UJLW2pBBnde+4KIj/IJ+lXfx+
	 t0e61m3DQDbjW9PEnFkEAxlQ1Zu7h09ktDYpVmsCHLFV4qEzjDsL9AEVUFjU6dFBlb
	 nlbW9V9ARSnO0Vlm92JyQpzwoD/nzwEZfrjwsx5Dn7R4D07CLzz+PEZF0JmMsuKWLy
	 RKjpgzqv3JgHQ==
Date: Tue, 17 Feb 2026 14:15:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dawid Osuchowski <linux@osuchow.ski>
Cc: netdev@vger.kernel.org
Subject: Re: [ANN] netdev development stats for 7.0 (and some AI review
 thoughts)
Message-ID: <20260217141500.00c3fa2d@kernel.org>
In-Reply-To: <d3e7fa70-4035-47e0-89cc-92d636497198@osuchow.ski>
References: <20260212124208.187e53ae@kernel.org>
	<d3e7fa70-4035-47e0-89cc-92d636497198@osuchow.ski>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 00:31:08 +0100 Dawid Osuchowski wrote:
> > One more note on testing, we have completed the migration of NIPA
> > to netdev foundation machines. Due to DRAM shortage, however,
> > the shipment of additional machines is delayed.  
> 
> Just something I noticed that might be connected to this is that the 
> links to "Raw output" in these announcements broke for each previous 
> message you posted.
> 
> It is possible to use the new link convention/format:
> 
> 	Raw output: https://netdev.bots.linux.dev/ml-stats/stats-7.0
> 
> to go back as far as 6.18 stats e.g.:
> 
> 	https://netdev.bots.linux.dev/ml-stats/stats-6.18
> 
> but beyond that (6.17 and older) it doesn't work. The "old" nipa links:
> 
> 	Raw output: https://netdev.bots.linux.dev/static/nipa/stats-6.19/stdout
> 
> are completely broken.

Yup, this is due to the NIPA migration from Meta systems to netdev
foundation machines. I can regenerate the outputs if you need them
(modulo the JSON format changing since), LMK if and how far back.

I did copy the "time based" stats from old machines (3mo, 6mo etc) FWIW:
https://netdev.bots.linux.dev/ml-stats/
which I suspect to be more useful for actionable tracking of activity
than the release-by-release. Release stats are mostly an excuse to send
an email to the list and thank people :)

> P.S. I am using a freshly setup email client on a new machine so 
> apologies if the formatting is wrong on my end. I did send this message 
> to myself for testing and I think it's okay, but I might be missing 
> something :)

Looks fine :)
