Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491026;
	b=jqtZsua4egKE+dT3mC7DNODJvk+HAioXMUt3BLwZtJOciyTDXQtY16NQhBhgVXWEOqLh
	 rw8jyeAzxJEsYVLDrlHII2mugBtb2q/A4Zp3aWYmYSFuecnfO8mkARgu1oK6T45LEuYS8
	 6gqc0WTymI7nfoydjV1Yx9pNJ/lOj6GSzFA50wAzgdctVHw84gLIm28UtkvQq5rWVKtql
	 SawwRd3wVi6FvYTCIA7jsbyIg0qNqrr26zJpCkwSxN+W8Jm3bCss+myZxJJslXUBWp3jl
	 5FZInMjQ5Rt/Sjmlh1VYy+hvgKPd7IXttm2eiUk+b+viyeqXrjJJ0C3wLzZ7mFgsKZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491026;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:User-Agent:X-Bm-Milter-Handled:
	 X-Bm-Transport-Timestamp;
	bh=NRCmlz9UIpzLSIl8G/BYxNYMUmX8i/GH+eW+zCSkzcA=;
	b=HeOcA9DHEzlIVTH6ihCTpNyoRH9g5JlRL3xM20PIA6PZoUxliHiDQrQwub5RhjeX48qN
	 fJmjy5IhzxxesOWjWheeKM7WF+3j+JqjY7JmW5+OpTEdIU1dLVC/q9X+s7qVIWjAEZZO7
	 +TLiBCmbyBAcF7vJlitv3vGo1sw79JZhlbosXxP1Qj4JaFjZgaXFRKPwWHXrQ10I752ZC
	 iqpIRsi512K0Kb/shQk5G72cYcLTbqw7lFJcfAIkWXmXEaPKFWf+gr9Ywni7hFsA5VHZL
	 wnEmraRWrxLBJ1wuGR1nD4Ijswl1DUWzCRZPIf5eJljXhIrm5Fq0tIESuKREw1EASPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=proxmox.com;
	spf=pass smtp.mailfrom=proxmox.com;
	arc=none smtp.remote-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860BD606A31C;
	Thu, 12 Nov 2026 13:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 860BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id DC04746C7C;
	Thu, 12 Nov 2026 14:43:43 +0100 (CET)
Date: Thu, 12 Nov 2026 14:43:41 +0100
From: Gabriel Goller <g.goller@proxmox.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ipv6: reset all.force_forwarding when disabling
 all.forwarding
Message-ID: <avW_Yn2W7tSHTMaq@luna.proxmox.com>
References: <20261109-ipv6_reset_all-v1-1-815dfd508246@proxmox.com>
 <1eb85d22-7d2b-460c-82f6-2af15a4875dc@6wind.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1eb85d22-7d2b-460c-82f6-2af15a4875dc@6wind.com>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1794491023021

On 10.11.2026 18:34, Nicolas Dichtel wrote:
> Le 09/11/2026 à 16:53, Gabriel Goller a écrit :
> > Disabling all.forwarding resets force_forwarding on every interface, but
> > leaves all.force_forwarding set:
> > 
> >   # sysctl -wq net.ipv6.conf.all.forwarding=1
> >   # sysctl -wq net.ipv6.conf.all.force_forwarding=1
> >   # sysctl -wq net.ipv6.conf.all.forwarding=0
> >   # sysctl net.ipv6.conf.dummy1.force_forwarding
> >   net.ipv6.conf.dummy1.force_forwarding = 0
> >   # sysctl net.ipv6.conf.all.force_forwarding
> >   net.ipv6.conf.all.force_forwarding = 1
> > 
> > Writing 1 to all.force_forwarding afterwards is ignored because the
> > value did not change, so the interfaces are not re-enabled.
> > 
> > Reset all.force_forwarding too and notify netconf listeners.
> > 
> > Suggested-by: Ido Schimmel <idosch@nvidia.com>
> > Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> 
> There is the same effect if an interface entry is reset:
> 
> $ sysctl -wq net.ipv6.conf.all.force_forwarding=1
> $ sysctl net.ipv6.conf.ntfp1.force_forwarding net.ipv6.conf.all.force_forwarding
> net.ipv6.conf.ntfp1.force_forwarding = 1
> net.ipv6.conf.all.force_forwarding = 1
> $ sysctl -wq net.ipv6.conf.ntfp1.force_forwarding=0
> $ sysctl net.ipv6.conf.ntfp1.force_forwarding net.ipv6.conf.all.force_forwarding
> net.ipv6.conf.ntfp1.force_forwarding = 0
> net.ipv6.conf.all.force_forwarding = 1
> $ sysctl -wq net.ipv6.conf.all.force_forwarding=1
> $ sysctl net.ipv6.conf.ntfp1.force_forwarding net.ipv6.conf.all.force_forwarding
> net.ipv6.conf.ntfp1.force_forwarding = 0
> net.ipv6.conf.all.force_forwarding = 1
> 
> Maybe the new value should be applied whatever the old value was for the 'all'
> entry (like for net.ipv6.conf.all.forwarding).
> 
> Note that, it is the same for ipv4 forwarding:
> 
> $ sysctl -wq net.ipv4.conf.all.forwarding=1
> $ sysctl net.ipv4.conf.all.forwarding net.ipv4.conf.ntfp1.forwarding
> net.ipv4.conf.all.forwarding = 1
> net.ipv4.conf.ntfp1.forwarding = 1
> $ sysctl -wq net.ipv4.conf.ntfp1.forwarding=0
> $ sysctl net.ipv4.conf.all.forwarding net.ipv4.conf.ntfp1.forwarding
> net.ipv4.conf.all.forwarding = 1
> net.ipv4.conf.ntfp1.forwarding = 0
> $ sysctl -wq net.ipv4.conf.all.forwarding=1
> $ sysctl net.ipv4.conf.all.forwarding net.ipv4.conf.ntfp1.forwarding
> net.ipv4.conf.all.forwarding = 1
> net.ipv4.conf.ntfp1.forwarding = 0
> 
> but not for ipv6 forwarding:
> $ sysctl -wq net.ipv6.conf.all.forwarding=1
> $ sysctl net.ipv6.conf.all.forwarding net.ipv6.conf.ntfp1.forwarding
> net.ipv6.conf.all.forwarding = 1
> net.ipv6.conf.ntfp1.forwarding = 1
> $ sysctl -wq net.ipv6.conf.ntfp1.forwarding=0
> $ sysctl net.ipv6.conf.all.forwarding net.ipv6.conf.ntfp1.forwarding
> net.ipv6.conf.all.forwarding = 1
> net.ipv6.conf.ntfp1.forwarding = 0
> $ sysctl -wq net.ipv6.conf.all.forwarding=1
> $ sysctl net.ipv6.conf.all.forwarding net.ipv6.conf.ntfp1.forwarding
> net.ipv6.conf.all.forwarding = 1
> net.ipv6.conf.ntfp1.forwarding = 1

Makes sense, aligned the behavior to ipv6 forwarding with this patch:
https://lore.kernel.org/all/20261112-ipv6_always_apply-v1-1-8df846631005@proxmox.com/

This patch is still relevant.

Thanks for the review.

Gabriel

