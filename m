Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360414E0B68;
	Tue, 22 Sep 2026 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068345; cv=none; b=VCJq9k81/Xy27G0uXd3TX0/RpcGvy495XZu5Dbsurbog/7r8t3uV1oyxeyzPT1kzc7hfloqfZR2c1cOskQsstBewHoXQEBmSbQfKjXOM23Awe/Cqa/ZSMteJIfkvM/MuwcakFKzTECAawCF9u+8+RuI6PQJVdfFTwyal5AOLdW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068345; c=relaxed/simple;
	bh=H0WC2f2axQ4K85ZaqjCHRua8MLT+Rbu9nuzLRuMvsOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+bfas4PPnUHE2hNfQH3efC3IdcjXn3lCEJRwXLf86t520M9/TgdJyD9jkajCv3m0p7IhP0NHFnfPtalHnHLTkBGqMbqXCGDzelCtJq3rvTzMXNbR3hqiH9mA79cEoeu1Cq0zyLmGIRUITnOZhkLAWBAry2rT7QFQLw5xRPeHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id EB5FD421BC;
	Tue, 22 Sep 2026 11:12:19 +0200 (CEST)
Date: Tue, 22 Sep 2026 11:12:17 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Roopa Prabhu <roopa@cumulusnetworks.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ipv4: fib: treat an unbuildable encapsulation as
 a nexthop mismatch
Message-ID: <arJGLBXVpPTe3J96@luna.proxmox.com>
References: <20260921130736.210845-1-g.goller@proxmox.com>
 <20260921151120.GA2269691@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921151120.GA2269691@shredder>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1790068339079

On 21.09.2026 18:11, Ido Schimmel wrote:
> On Mon, Sep 21, 2026 at 03:07:30PM +0200, Gabriel Goller wrote:
> > fib_encap_match() builds the requested lwtunnel state and compares it
> > against the nexthop of a candidate route. When lwtunnel_build_state()
> > failed it left result at 0, which is interpreted as "the nexthop
> > matches", so fib_nh_match() continues to compare only oif and gateway.
> > 
> > So if there comes along a RTM_DELROUTE which carries an encapsulation
> > the kernel rejects, it could delete a different route with a different
> > encapsulation.
> > 
> > Report a mismatch instead. This also covers LWTUNNEL_ENCAP_NONE, which
> > lwtunnel_build_state() rejects with -EINVAL, so the separate check for
> > it can go away. It used to claim a match for an encapsulation type the
> > kernel refuses to build.
> > 
> > Fixes: 571e722676fe ("ipv4: support for fib route lwtunnel encap attributes")
> > Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> 
> I asked Claude to check if this can result in routes that are no longer
> deleted and it came up with the following scenario which I verified:
> 
> Before:
> 
> # ip link add name dummy1 up type dummy
> # ip route add 192.0.2.0/24 encap bpf xmit obj ./lwt_ok.o sec xmit dev dummy1
> # ip route flush dev dummy1
> # ip route show
> 
> After:
> 
> # ip link add name dummy1 up type dummy
> # ip route add 192.0.2.0/24 encap bpf xmit obj ./lwt_ok.o sec xmit dev dummy1
> # ip route flush dev dummy1
> Failed to send flush request: No such process
> # ip route show
> 192.0.2.0/24  encap bpf xmit lwt_ok.o:[xmit] dev dummy1 scope link
> 
> The flush is dump followed by delete and bpf_fill_encap_info() doesn't
> fill enough information for bpf_build_state() to reconstruct the state
> and it returns an error.
> 
> I don't know if anyone is relying on this behavior, but AFAIK nobody
> complained about the issue that this patch is fixing for 11 years and
> according to [1] you didn't hit it either. Given the above and the fact
> that the modern alternative (nexthop objects) avoids this issue, I'm
> tempted to keep the code as-is.
> 
> [1] https://lore.kernel.org/netdev/arEQHeBlqKWCu3l5@luna.proxmox.com/

Ah, I missed the whole `ip route flush` path. Makes sense, we can drop this
patch. Notably because ipv6 also doesn't check the encap value :)

Thanks
Gabriel

