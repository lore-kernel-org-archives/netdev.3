Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB24353B60B
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191043; cv=none; b=swz0QQwC078N6EVCxgHSTOV2lGBvX4cMbi4KjQA2ey+p8yfQKfKRuxhSi+lWpno7+rOObSYBFXwhFC207U4R9bI1lSVKaSCJdRDgToqYJ8EWaB+cE0XAI+PXM9XV70CxPTQ8LEeTZ+/zufLsIjuwRvmS+O1RIOMKInJ0pkkvnEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191043; c=relaxed/simple;
	bh=kPsQ+aoUYJ38tIVUBJNBGJdeGCtb7NRRC9lorO05/F0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JqV0cnOAVRr8LB3AyxEXE2rvk3Gfdbg4knsiD4M6g7rr8WwPYmXZJ+phH1Wqtlk7svx1GSMTerOxnRwTiInjZJ+TszAlIJ+8IQsPgtik8L8Bh5LMgHSl/36DAVwJbjiAkMMZlbmKuHqXmUA12nzQo8F7je6PFktgrBHtG+1gQw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=TPaaASxU; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=IJbAPGSq; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="TPaaASxU";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="IJbAPGSq"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 68NJGeke015028;
	Wed, 23 Sep 2026 21:16:45 +0200
Received: from lubuntu-18.04 (host-95-239-0-205.retail.telecomitalia.it [95.239.0.205])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 919971228FA;
	Wed, 23 Sep 2026 21:16:36 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1790190996; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K56EsZ82P2QqIiLvX2mYoBfEjNvSxQGlya336DnvRWc=;
	b=TPaaASxUL8BweDGLfUKRLg1A04B8SJ/vuHqDNkDJWEPey2rt6oa2xW4ZJBCDB61Tjj7szR
	MgjvMnV42gqkfIDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1790190996; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K56EsZ82P2QqIiLvX2mYoBfEjNvSxQGlya336DnvRWc=;
	b=IJbAPGSqSfAZVFBxPGNJEB5yKoAiSwJTDvs/pW0hywg1jf+lxzARUv0wHLNDg+G7GYTEKQ
	f+GcXh7mdGTgp3h7C+xF8lR4t0UGnVWInK0ERbH2km7Lz3AuahW1hczat0OH5JOr8A5kpB
	qbNN6NeiUHCPss4tDco3EG+ujk0/2IrO/3GZoHyFtx3YqmwJDAP2j3O87GrlBKL3nGCHXi
	QbUWSxNc7oX7CSD6XXKgJ+Py/l6CyXepW72c6OhVMoZCE1T5kMkZuSkSvKewJ2h0NmVDoZ
	yz7qvy87Fu0SdQoV239DU8hLYkp343fIpezh4GzYIW+WBvKAC7jS2LeMFSX8GA==
Date: Wed, 23 Sep 2026 21:16:36 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
        andrew+netdev@lunn.ch, stesasso@gmail.com,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] vrf: Stop corrupting skb->csum when capturing
 CHECKSUM_COMPLETE packets
Message-Id: <20260923211636.a6786a11f3199ebb61f31714@uniroma2.it>
In-Reply-To: <20260922131239.2509494-1-idosch@nvidia.com>
References: <20260922131239.2509494-1-idosch@nvidia.com>
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

On Tue, 22 Sep 2026 16:12:39 +0300
Ido Schimmel <idosch@nvidia.com> wrote:

> The VRF device is an Ethernet device but it can have non-Ethernet ports
> such as IP tunnels. Before the cited commit, capturing packets from such
> ports on the VRF device resulted in these packets being detected as
> malformed since they lack an Ethernet header.
> 
> The cited commit fixed it by pushing a dummy Ethernet header to such
> packets before the capture and pulling it afterwards. In the case of
> CHECKSUM_COMPLETE packets it also updated skb->csum with the checksum of
> the dummy Ethernet header. This is wrong as skb->csum should not include
> the checksum of the Ethernet header ("checksum of the _whole_ packet as
> seen by netif_rx()").
> 
> This also means that L4 protocols receive a corrupted skb->csum and
> potentially drop the packet, as is the case with UDP packets whose
> checksum was completed by software.
> 
> Fix by removing the unnecessary call to skb_postpush_rcsum().
> 
> Fixes: 048939088220 ("vrf: add mac header for tunneled packets when sniffer is attached")
> Reported-by: Stefano Sasso <stesasso@gmail.com>
> Closes: https://lore.kernel.org/netdev/CALtE316UtL3x7LL6uxfXzx8rW6AbzYPeDOb478hqJCr_-dj=Wg@mail.gmail.com/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vrf.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Thanks for taking this, and thanks to Stefano for the report and the
reproducer.

Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
