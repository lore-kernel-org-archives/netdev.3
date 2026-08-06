Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD2311946
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785976145; cv=none; b=VQD1aZ62goStGi8zpTPsMiSuw5xl+f2GiP1G+umY0ZQAzd5QyP+q0Dg/7Wv7GK9VrWRwgtiMPRH2enzerWyd0iYH0yinGBxtRO7VYyK1gwJliOuHPm0frF78Z+aUibQ1QQOubI7IgJopJjNFqnHKATIj8OWJIRaDCm4CBinV0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785976145; c=relaxed/simple;
	bh=uqDyb38dl3c3zdarMR+FFYNMLE4/gw/UR9MShuLGSdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cH9W92O+zZwzL4vUlKAJBvuT2HMP183HJnZf84DXWH/Y8i/tqplDAIirk5PgIR3KJPLlAzzscJdnzpt6g3ym9Wtt7iyFTuyUn6a3lt1cBVRRkDpVwbhuAe56/qKsA4cLMZ/BuJvZ+h9Tzf7vAiKfhLJh0QbKKbW3RURj7G09b1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6uoWEN2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6uoWEN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452411F000E9;
	Thu,  6 Aug 2026 00:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785976143;
	bh=uqDyb38dl3c3zdarMR+FFYNMLE4/gw/UR9MShuLGSdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k6uoWEN20F8nBvzbKP8RAqgaY3BVEVTCyNC3bm5d1dWhRH8vPjHWh3nmM6CRvKFNh
	 E1tfdn6AX9ZLcg7BBUuS5E3sirM2cdUYX6NUZ5HYIZM3JMApi/CKsrdgQ9rTqmT56A
	 KRknHeR3goc+Ft+hvQKS6GOO9pwltw5AvVrhUnj7GLvzUW5x2bSOTaUU/pe0gK2AVT
	 2YpL0aNbFFbfU9qqtLFRw7HwBnF29CoPhsOkKY+z+qFcCCrfKLg4osU/TbLRmmud13
	 z86xqCkNizZMox5fRCYrg/JlhrpkBZpNH2HajF0RURRO8Z3r8aX5jP5u0Rg1lThy7T
	 FQmhOeA9/AuMA==
Date: Wed, 5 Aug 2026 17:29:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Zhiling Zou <zhilinz@nebusec.ai>, netdev@vger.kernel.org,
 dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, tom@herbertland.com, vega@nebusec.ai
Subject: Re: [PATCH net 1/1] ip6_tunnel: use skb_cow_head() in
 ip6_tnl_xmit()
Message-ID: <20260805172902.27c9bde0@kernel.org>
In-Reply-To: <20260805090721.GA1364862@shredder>
References: <cover.1785734738.git.zhilinz@nebusec.ai>
	<7f099879785257f4d57d6caf9b6308fc76c7aaea.1785734738.git.zhilinz@nebusec.ai>
	<20260805090721.GA1364862@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Aug 2026 12:07:21 +0300 Ido Schimmel wrote:
> __gre6_xmit() and ip6erspan_tunnel_xmit() already call skb_cow_head()
> before calling ip6_tnl_xmit().

Probably just me but can't they all be buggy?
PKTGEN likes to send shared skbs around in funny ways.
Can we get a good explanation in the commit msg or maybe let's
keep the check?
