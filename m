Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184940;
	b=XxBQ+Sc1S47tom9GZAkfBVc9k6jRu1ZlQ604ieF8itO8PvyGt1mDNPYVukRGg2YZyOto
	 v5QeHh1nN8z50X8x5mfzxhIUTAmpR143rEpGHB0W5qR+XNEbpNSNCsbngbqXSPwY/673g
	 4VmWPFtYXsiiWWfco/WZtLZlS430QyXFt5PrrrknVIFH8QagwuPrTH1KYTbQHCpAtLhdD
	 ms+2rwZhXy9CQ6yN3Jbn4JlAfqFC926HtCHFrcKIoAYVgqRPebQUtupDGH0a4eldej596
	 tttnHKDqhoQ7mZJeAfySKkbIhZWJHQMS2MaVtnXNHP+So3QkBmwQ+EHGj+lxSa3K2sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184940;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent:
	 X-Bm-Milter-Handled:X-Bm-Transport-Timestamp;
	bh=nqGI5iIj7DnVlrNFIVTngPrJ156e0Iy02VG27UnIg6E=;
	b=Bd2dTqg8TRuiOMYKzVR7TE6H8rxUAta97IW7FmxlGFIDywI8XBjF03Wjvatt7DEQya6b
	 bqT3ytxTsVEkrKceV2+vw8IdcaaMdK2RGATaNlKC+zF86O7Gs3xNZ4E139NxXC+xvuluV
	 rpVx7iZ3bEvHfcHxR5VmJ+ZMMDiNPcV9mDv67lClo+AbAA+dpYb01tf5ZbZY9c26AN7yI
	 5/BjrwxJnR06WBvmqD8CkuyzDhLLcilfH7yPCgkrUIfeoHRIrNqldvBk1UQ0UZpIpRpPQ
	 lGHg3hqmX0eAUcuaOhMegbe2WcJDtSTM8dRFEAsf5hPOCE4q2xt59geZVFttBPo+Z5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=proxmox.com;
	spf=pass smtp.mailfrom=proxmox.com;
	arc=none smtp.remote-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD8606A31A;
	Wed, 28 Oct 2026 10:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57FD8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5B1F342E5D;
	Wed, 28 Oct 2026 11:55:37 +0100 (CET)
Date: Wed, 28 Oct 2026 11:55:35 +0100
From: Gabriel Goller <g.goller@proxmox.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: Add NETCONFA_FORCE_FORWARDING to netconf
 messages
Message-ID: <auHUbzlVvz7dPJIb@luna.proxmox.com>
References: <20261023-ipv6_add_netconfa-v1-1-94d14b07d621@proxmox.com>
 <20261025131102.GA184152@shredder>
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
In-Reply-To: <20261025131102.GA184152@shredder>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1793184936511

On 25.10.2026 15:11, Ido Schimmel wrote:
> On Fri, Oct 23, 2026 at 12:59:18PM +0200, Gabriel Goller wrote:
> > Since force_forwarding was added, changing the sysctl sends an
> > RTM_NEWNETCONF notification of type NETCONFA_FORCE_FORWARDING, but
> > inet6_netconf_fill_devconf() never emits the attribute. Listeners only
> > receive NETCONFA_IFINDEX without the new value, and RTM_GETNETCONF
> > replies and dumps omit it as well.
> > 
> > Fixes: f24987ef6959 ("ipv6: add `force_forwarding` sysctl to enable per-interface forwarding")
> > Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> 
> This seems to fall under the "Not a regression, not critical" category
> [1], so can wait for net-next.

Agree, will post when net-next opens again.

> Also, NETCONFA_FORCE_FORWARDING is not emitted when it's disabled as
> part of:
> 
> sysctl -wq net.ipv6.conf.all.forwarding=0
> 
> Is this intentional?

Nope it isn't. Will fix in the next version.

Thanks for the review!
Gabriel

> [1] https://lore.kernel.org/netdev/CAHk-=wiSnTE9vBZ=5_v+3EEkdazCCbBM5YABRzRHUAeRdyd4Xw@mail.gmail.com/

