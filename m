Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD63D378D8A
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025721; cv=none; b=uWZc63OvrqHDt2z3Nt+rjpEyQ5avZSvHQtG5idQwwbpa603nGtJeOGY+nUPMg103s/FhggoxicVWxv6AVTWkkyjRWAdZRrkh/tPDnF/wwSYAMQJWb0e7wCBby3yCXHLkxYiQTUE3/U52BEkMpwkjj/MaIBLF8RMpXW3zqzB3JpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025721; c=relaxed/simple;
	bh=u2zuK/HNAcnf6WPNTpYq2EyjgC4S4xFOQoD7odLKQHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9pzrz0Y71SEfFQnHm4q4epeHlwxeO83JTMGxiAvgjQl9cxJkiUjCygqJgLZFxreKe1duvOQmlDWCReLgS66c8aqg2n6Bwzrqzrg2bLvt/VtWKrIKOw5I502idXYO0n8vsEns4FL1bW8C6ZUy4/ijyMa7uYyhNQqsaxQwhFyUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPYPAhI3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPYPAhI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D7F1F00A3A;
	Thu,  6 Aug 2026 14:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786025718;
	bh=3KiDbqseCfcmYqL7PGKFGETEHd9/l1HXzdoXIYkaItQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mPYPAhI3AWeyogYshJKtvX2+4lBj8AaUbdzVbWYsysO6hUp8VqMQE7wxodb/fDZwJ
	 RjxifdxUDd+3Q0fbAmLzGB8wEa7X7Bjoqp1Uu1cTsqy8h9vmkTHiqwfAiiR3kRU2Og
	 NX+mduAgYxnNLG2ztrmPT0SEk+M3xlTU68gwweX9YeBXZKCItyiHEREqr9AHFzXXMq
	 bfKkX55NFA09H9kNcaiQoeyCaEhqUYdR6cXWhEzQjMf94tyvr5QCMJH/u/77dKw/wT
	 kSwqxQFXCCm7cvK1MoubU73TrUZAZN2hrZgI/ugF9AlgJEWOQUzgAWAM9KvNTUO91W
	 /fOpJct69y8Bw==
Date: Thu, 6 Aug 2026 07:15:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, vega@nebusec.ai, edragain@163.com
Subject: Re: [PATCH net RESEND 1/1] ipv4: reject RTAX_ADVMSS values below
 TCP_MIN_MSS
Message-ID: <20260806071517.06ae9713@kernel.org>
In-Reply-To: <a2e93ae9003f33bf49b789dbd537f4a6c10f26fa.1784972917.git.edragain@163.com>
References: <cover.1784972917.git.edragain@163.com>
	<a2e93ae9003f33bf49b789dbd537f4a6c10f26fa.1784972917.git.edragain@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Aug 2026 12:13:38 +0800 Ren Wei wrote:
> Subject: [PATCH net RESEND 1/1] ipv4: reject RTAX_ADVMSS values below TCP_MIN_MSS

I think you reposted this with an identical message ID :/
We use message ID as the unique key for the submission, this isn't
going to work.

*Wait 2 days* for feedback and then repost again, using a normal
client, which understands email header semantics.
