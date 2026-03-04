Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2FE3D75A3
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654018; cv=none; b=B3+VGhfLuMsCgJVGkkBFvlL4ZHni9jkN7JptXA4Xqq6WFSd1IEeD4z2zTzj+V76Y7popDd7nzM/db/jmOI30d4t9UJvh6VxOBct0Q/4phATK0gRrYmHE+dzL4BkYbt6Te/BI1aUNo34jlFptzdVgeZ4EkHDs0LCpA5LJmK1D6sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654018; c=relaxed/simple;
	bh=WMg2xwt3XRriVpTldqilmWaOTE8Ab6pi8h0vTQu50xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDJv+94t6Z8amT2soe3d1Spxg0LdHXfZhTMh6vpjlk+nQPtZq8XWBozD8xGiQVoU8rcB5MzBDBhTtgo3oTmrrCZjjx66ZsSl+EFhneHjwYMoEJoInI7V3KYBRAVfeQNdOrj1E5ByXfDMirMujKq/21tPtGegG55Urjq/mScrR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 762466010A; Wed, 04 Mar 2026 20:53:33 +0100 (CET)
Date: Wed, 4 Mar 2026 20:53:29 +0100
From: Florian Westphal <fw@strlen.de>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 00/15] udp: Retire UDP-Lite.
Message-ID: <aaiNufodmq7l94ZN@strlen.de>
References: <20260304193034.1870586-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304193034.1870586-1-kuniyu@google.com>

Kuniyuki Iwashima <kuniyu@google.com> wrote:
> In 2023, syzbot found a null-ptr-deref bug triggered when UDP-Lite
> attempted to charge an skb after the total memory usage for UDP-Lite
> _and_ UDP exceeded a system-wide threshold, net.ipv4.udp_mem[1].

Thanks, I think removal makes sense.

I'll followup with NF_CT_PROTO_UDPLITE removal once this has been merged.
