Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753412;
	b=HnTG+tf89e1sAEHN/lRMMpSRi3VeB1t/sTK8PVggfk+UKZ6GszS8Xd6RrXDi5JhtkCZN
	 6pKQHnBs+7TNr8s9sGM1++dMaK6/GwnsJz6SKEKCXX035yMElgBnPRLOZQphh9k6mo+Vk
	 /vsgUuW7UlcBCgBo63E6Dg/7BxQ1Ov0u19goagRJPNl968mxBBbfpdDWnvs4XH+tnkA4G
	 Tc8pvN9MDtdohENeu5E3XxKMgdpMfGpfl+4e9pk9sQG3eoPaLP3siwC5ANTAxjjeKvzKN
	 PjGli/TnS6bX+kX4Fd/bxc4AJUwKeZthQCOZ0ZgJIWvkmK88XedPN/Y/+8NfqDZu3eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753412;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7YRX/enVQAzytukMCM6+WSBuOlJEKJvpnpxugZ2I9TQ=;
	b=LbyG4r9HGw54j4yaXnOvHfCKu7TD/T9Wa+yX4vTLXpA78yEpLM2lqlIe41tRkpoynls9
	 iVqQnmXqwPHiWrnbb51FPPGqncatLBWDux9WG793ZLjZ7eAVYGi7l/v7bCHaxkTJ0rijv
	 et92khZ/45Qa7F4QYY7GfUyMXrLty/cyN7AXfcKowzi3hqZqLExF8ssP39xH5H6DRBaRl
	 IhqaMCRho7QVTGfLfE+5PT/RSc59Ci17qXF/g/fO5bgNu33JjbfuT9qXsYwFsGJZ0FjB8
	 4GpyLrCG8b4i/9uuliHqIj0Eac3YpvaeVgfGnuYQ9Ha2jvyRBXEQExNFphCHD5nDcIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcNu7rMa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C130606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcNu7rMa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EFA1F01825;
	Fri, 23 Oct 2026 11:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792753411;
	bh=7YRX/enVQAzytukMCM6+WSBuOlJEKJvpnpxugZ2I9TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YcNu7rMaHhRKzOuX9bm6hR0e10LK1rzV6U19WMN1z5m4+jqHtQQjxALQ3GkhwiZBj
	 YA5gkHtOyGv3pvvwhwM+NP+h160x3hU2VdCz1JGkuvrqDxxY/E362kRmskaCWW9EKN
	 C+9trwNwMDfQ/kvFyKbvBifR9ArubCNaOgCrqisrnDSCARD2pWegkK3ZZz+nRPytIp
	 MhXZWNTjC67TsZh9Fr0Z+BPWVFJWMlwlTEF9vbXgvxtLCtK000YMIC4iRoNeIBFK8b
	 DuO6HoH2lyTLC21c5YuaUgQELdtplAfgATRc2UvgJjWO5Ldyf9ybx8O+I9sX+7IrcH
	 3kzxiIXx37M0A==
Date: Fri, 23 Oct 2026 12:03:28 +0100
From: Simon Horman <horms@kernel.org>
To: Dudu Lu <phx0fer@gmail.com>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, jiri@resnulli.us,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: etf: initialise the sock_exterr_skb
 before filling it
Message-ID: <20261023110328.GL708417@horms.kernel.org>
References: <20261021155401.65997-1-phx0fer@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021155401.65997-1-phx0fer@gmail.com>

On Wed, Oct 21, 2026 at 11:54:01PM +0800, Dudu Lu wrote:
> report_sock_error() clones the transmitted skb, overlays a
> struct sock_exterr_skb on its control block and fills in the seven
> struct sock_extended_err fields, but never clears addr_offset and port.
> skb_clone() copies cb[] verbatim, so the errqueue entry carries the TX
> skb's stale control block to the receive side, and the ipv4 error-queue
> reader trusts those bytes:
> 
>   net/ipv4/ip_sockglue.c:556
> 	sin->sin_addr.s_addr = *(__be32 *)(skb_network_header(skb) +
> 					   serr->addr_offset);
> 	sin->sin_port = serr->port;
> 
> The gate that is supposed to guard that read only asks whether an
> address was requested at all:
> 
>   net/ipv4/ip_sockglue.c:484
> 	return serr->ee.ee_origin == SO_EE_ORIGIN_ICMP ||
> 	       serr->ee.ee_origin == SO_EE_ORIGIN_LOCAL || serr->port;
> 
> SO_EE_ORIGIN_TXTIME is neither ICMP nor LOCAL, so for sch_etf the gate is
> decided by serr->port alone -- by the stale byte pair.  When it is
> non-zero the reader dereferences skb_network_header() + addr_offset with
> an arbitrary offset.  On the TCP path cb[40..44) is not zero: the
> transmit path stored delivered_mstamp there (tcp_rate_skb_sent()), which
> is exactly where addr_offset/port sit in the arm64 struct layout.
> 
> Reached with an unmodified 7.3-rc4 (arm64, KASAN, in-tree modules): a TCP
> socket enables TX-timestamp error reporting (SO_TXTIME with
> SOF_TXTIME_REPORT_ERRORS), a sch_etf qdisc drops the packet, and a
> recvmsg() reaches ip_recv_error():
> 
>   BUG: KASAN: slab-out-of-bounds in ip_recv_error+0x970/0xa0c
>   Read of size 4 at addr ffff0000158ffdd5 by task A-227-A227-1_S2/113
>   ip_recv_error+0x970/0xa0c
>   inet_recv_error+0x94/0xdc
>   tcp_recvmsg+0x378/0x408
>   ...
>   The buggy address is located 149 bytes to the right of
>   allocated 704-byte region
> 
> Zero the whole overlay rather than the two fields individually: the
> errqueue entry is handed to the receive side as a self-contained record,
> which is what every other producer in the tree already does (sch_etf was
> the only error-queue producer that cleared neither field).  This does not
> change what the in-tree selftest observes -- so_txtime.c reads only
> ee_origin/ee_errno/ee_code/ee_data/ee_info, never msg_name or sin_port.
> 
> Fixes: 4b15c7075352 ("net/sched: Make etf report drops on error_queue")
> Assisted-by: LLM
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> ---
> Tested base
> -----------
> Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
> Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
> is unchanged between the two, so the bug is still present there.
> Checked against linux-next next-20261021 (commit 9a482184d910): the
> affected code is unchanged there as well, so the bug is still present in
> linux-next too.
> 
> Reproducer status
> -----------------
> A reproducer was written and executed on an arm64 QEMU guest (dummy-virt,
> KASAN kernel) against unmodified 7.3-rc4 in-tree modules; KASAN fired at the
> claimed sink.  The reproducer source is not posted here per
> Documentation/process/security-bugs.rst ("do not publicly share a reproducer");
> it is available on request.
> 
> Triggering conditions
> ---------------------
> CAP_NET_ADMIN to install the etf qdisc; the socket must opt into TX
> timestamp error reporting (SO_TXTIME + SOF_TXTIME_REPORT_ERRORS); a TCP flow
> with a non-empty retransmit queue.  No out-of-tree module is needed.
> 
> Notes
> -----
> Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
> (commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
> it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
> 0 warnings.

Reviewed-by: Simon Horman <horms@kernel.org>

