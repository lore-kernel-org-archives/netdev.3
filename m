Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF05F3438A0;
	Fri,  2 Oct 2026 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790981580; cv=none; b=Wn1QcaiUatxGoGW8qCqrDwsYC2ga2MopjHxqmbKe2AeXeaWOZGGm5183pRRoOAGfFzlI2e1nTBgmjPUw7PoVl265DzlH4NaIEl7uKTglmDhsrKcGTgldIvFhVND040lrj0s0kdHplKKpprccmNJWj9NbjC1GW7NEvE7QT8KCcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790981580; c=relaxed/simple;
	bh=x2GGwuEyPxoeE58a4f+VomP2LJxuHLO2xxByMZSioNo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=t5rb3XkRyInqb0qwfdkSWG7vRhEEZaX+cYwNV8OTkTQE28c0QZ7XlY7072m4vICpo2z0K/8QDtQAykdm+sy8CZXTWHdt6DWxi4ixjE+K+R/r3vAk2CkugX7qd5xVH7BYcciqqsL1NKAu1Guba3x3cJnHolgWMAzrnX5vblvwi9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=5XSmGmxD; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=iuQKT63R; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="5XSmGmxD";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="iuQKT63R"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 692MqFA3024022;
	Sat, 3 Oct 2026 00:52:21 +0200
Received: from lubuntu-18.04 (host-95-234-228-71.retail.telecomitalia.it [95.234.228.71])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 362F11208F0;
	Sat,  3 Oct 2026 00:52:11 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1790981531; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wuX6sXxsGm+xKYyKZxk/IWod2kEm36bV4CD9CG7o2fs=;
	b=5XSmGmxDGQuSBiN/gLwzqqamFNgYkg1pAbjayp4KIxYJXN97eDsi/WuqcUcKPJV/GWennH
	Zk2W7j9zUbSjOcAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1790981531; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wuX6sXxsGm+xKYyKZxk/IWod2kEm36bV4CD9CG7o2fs=;
	b=iuQKT63RKuHHE/8H2qrZynkbiox7Y7W3sBrBqhLtRFipF2X9t+rbjvCCRLUINHLRIRBecn
	DzX7Of9q/bdrYqPy1PoGm/1hh5GVqqL+zghKqi5cxiCq+dn83ZyGDx1xG/Dix+whgdkkuD
	6O8dQ1FrVSdbaC/PfPiyYunUTVUCa4xtyRpN6CAzGf8P/Bkl9fGt58qVEyNdpjGtlb53Go
	NjUKhi26yGm9kMDoWOyReEH32aRvetwhgqQbfEckqdkfXuFj3HhmU5XNCj63YyjVcieVsc
	3eMrb0fuklf7xNY6QDsHhevzw9qn/eiEJE6yUeKYK4JslKr9tGlInmQCIQ2xBA==
Date: Sat, 3 Oct 2026 00:52:10 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: netdev-bot+sinfo@kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
        Ido Schimmel
 <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuniyuki Iwashima
 <kuniyu@google.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Hui
 Peng <benquike@gmail.com>, Sashiko <sashiko-bot@kernel.org>,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] ipv6: rpl: unclone the skb before modifying the
 packet
Message-Id: <20261003005210.d9b3b56c46144fd990259e7f@uniroma2.it>
In-Reply-To: <179087934758.1402591.6992807182585473895@kernel.org>
References: <20261001182136.33-1-andrea.mayer@uniroma2.it>
	<179087934758.1402591.6992807182585473895@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Thu, 01 Oct 2026 18:29:07 +0000
netdev-bot+sinfo@kernel.org wrote:

> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
> [snip]

Hi,

Yes, I triggered it. I reproduced it in a VM.

One namespace sends pings to fc00:2::1 through the RPL segment
fc00::2, which belongs to a second namespace with rpl_seg_enabled=1.
Each ping arrives with destination address fc00::2 and a routing header
with Segments Left 1 that carries fc00:2::1. In the second namespace, a
Python program opens an AF_PACKET socket and reads the queued frames
only after the pings were processed. For each frame with a routing
header, it prints the destination address and Segments Left.

Without the fix, all these frames showed:

  daddr fc00:2::1 segments_left 0

These are the values written by ipv6_rpl_srh_rcv(), not the received
ones. With the fix, all the frames with a routing header showed the
received values:

  daddr fc00::2 segments_left 1

To reproduce it, I did not modify the kernel or use error injection.

This is how the packet reaches ipv6_rpl_srh_rcv(), with some calls
left out:

__netif_receive_skb_one_core
  __netif_receive_skb_core
    deliver_skb               [orig: users=2]
      packet_rcv
        skb_clone             clone queued to the AF_PACKET socket
        consume_skb(orig)     [orig: users=1, cloned=1]
  ipv6_rcv
    ip6_rcv_core              skb_share_check: no-op [orig: users=1]
    [...]
      ip6_protocol_deliver_rcu
        ipv6_rthdr_rcv
          ipv6_rpl_srh_rcv    writes into the data shared with the clone

The reproducer is a shell script and a Python program.
I can post it if it helps.

Thanks,
Andrea
