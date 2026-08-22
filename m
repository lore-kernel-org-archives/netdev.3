Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A11835975;
	Sat, 22 Aug 2026 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357392; cv=none; b=n4F9D1REi594d7olUAc+2qDRBpAMHeqLkJnuq9kWVIjkeStFbRCENBFEhAsLQF1ZqwnJzoxe5aZ0i+woH7RwYBXtTLae4+zxut7OwrgGEwvjo6RFAUxL9T0F6ZJYWcyT7U1rbbQunA9W+uGu5vW/w+1gHHDt+R97b2I22xUgUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357392; c=relaxed/simple;
	bh=WrCr4YC0296g9BLq5T0GUO8apgmfaBqIuaPr8JYGYcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9v6j689QU9APwJO/zdShTJmglWr9YvQ5yJh13xsnsc9UZqVZkwMinBnda4D6fIPPpQ9Ap0W1Qr7t0XQaZ5TBvT7fRc3wJ5+BCv3f5+gfdYD+osQm3mduxXwMbI5zGFY6aK8HYLjKqPjkuJRQ0HYY6geaqnnL4H0RyJk1GrT6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLhglvGx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLhglvGx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880561F000E9;
	Sat, 22 Aug 2026 00:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787357391;
	bh=WrCr4YC0296g9BLq5T0GUO8apgmfaBqIuaPr8JYGYcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BLhglvGxzxQqA/gUltIaLqbbLiIu1dh5uJMDXfjCYyHJdVCfrsLSIfbJvDQvTDvCp
	 3STQ0labDg2YOnf4EVt+PNJLq0VmfewwisqhanXB5fjrls5QFMPQTdJAOkcipnyFXQ
	 2GFKuHydCSKbbJ0Ixcuug4PjJleOV9wsYMM4sc/S9luzo7FKoshmR7qQ4C4WO4oNYv
	 tQ63CHz1ptqwpmfx19uVAI/6NkJOlMGC7HtVayVU94yiP7+8IgqPso444Igxp1GVyN
	 71ErMHo2lVU+85lvBJMTR4/Z0dowkSIExyZQePSnAU0EyT8ZC9eaPibv8OXWQoNZ2D
	 S3rYMLisYGfDA==
Date: Fri, 21 Aug 2026 17:09:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Aaron Conole
 <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, Steffen
 Klassert <steffen.klassert@secunet.com>, Kuan-Ting Chen
 <h3xrabbit@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, dev@openvswitch.org, Jongmin Jang
 <payload.jang@gmail.com>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net v3 0/3] net: don't strip zerocopy frag markers from
 a forwarded skb
Message-ID: <20260821170950.3e278b1f@kernel.org>
In-Reply-To: <34c64d08-0484-4f3b-b61a-ed68115d01a4@ovn.org>
References: <F3B9E5BA-0AC1-4AD1-A7D9-F38033304270@doyensec.com>
	<34c64d08-0484-4f3b-b61a-ed68115d01a4@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 23:45:41 +0200 Ilya Maximets wrote:
> Unfortunately, this needs a rebase now that a conflicting change
> for skb_zerocopy() was merged:

Ugh, I was supposed to merge this first, wasn't I? Sorry.
I was hoping for Willem to TAL since skb_tx_error() is a tx ZC
thing, now I realized that he wasn't CCed :S (please do so on v4)
