Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA217382287
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761112; cv=none; b=Vx8Fdy3cUvHWxPDUH+EyH+LPIFFeavRUNwh0R/pZQIM2Z+CrR4ZmKCeWB3uqsWHDSJjC+MwkYNvlD4Zjprhc1ybRHY/qHmpksOUzHIBa6vxwWeA6cT1HnnJslwXG6yZS47SIHAXqpcsvIFv1Mp5HtjtJ3Gl6PGRNfJP0lRz2YDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761112; c=relaxed/simple;
	bh=iCLiocdkZA0odzzCw9wXF78QhEzSAQXVgEyCqU3/s4U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ppumijok3adjTqiXXRXNnybc/WSEvH/mUaboBcOaq6d6zlJfnQVdY06ExggMeECLNkSHX4ZYQPc9uUQ5TDRub9GH4y7QupvMluC2DFg5xR4HvLVWfK/gXYHNSpx7Jno3dLWDbPkzh4SaKRYgH/PmxeTAPE3gEabr8SgAbsyEDS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnVDxjah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnVDxjah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576531F00A3D;
	Mon,  7 Sep 2026 06:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788761110;
	bh=7kVWr9dPymC0VdTl0d3eHs2YGrPYNQs6pK61IyXhPjM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XnVDxjahExSI5ltuFWN13PScutV5troxFp99px4UYCWYwRVL2KvpeMDXC3oFWo1IG
	 qc/1I2hJFFDvI59+Fb9YBTc4N5+IwxO/XXmHGdeyuhzxMPCC9Uk/7y3hY0d4zo4PwR
	 zvquYUzc9QLERiIOvl9rPqO0GacS1lvxy2K2DEjCrXZWQ1AWtndSx0/FF8T1py7i5g
	 AuJvm909YsFaDuiFd6PvjqYNn9yZ+NQEDZt7TbD1v/9bgWOAzvDiVmm/722dQSlgdH
	 D26GdPxeA2OuBkaNPD2EVWIhRZ8cRMUKN//ghH5ktdud87GjeL2hgvibZxGBOs8JfS
	 WRLDMZnd56mmQ==
Subject: Re: [PATCH net-next v2] selftests: net: csum: filter packets by
 source address and port
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com
Date: Mon, 07 Sep 2026 06:05:09 +0000
Message-ID: <178876110986.219967.12438774212046389670@kernel.org>
In-Reply-To: <20260904030624.3833721-1-willemdebruijn.kernel@gmail.com>
References: <20260904030624.3833721-1-willemdebruijn.kernel@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The newly added source-port filter is silently disabled for
  the `-Z` (zero-checksum) configuration in both receive paths, leaving…

--

selftests: net: csum: filter packets by source address and port

The csum receiver now verifies the source address (and for TCP/UDP the
source port) of packets read from the PF_PACKET and UDP sockets, skipping
non-matching packets so background traffic does not fail the test. It also
adds a 20us inter-packet delay on transmit and drops a stale comment.

v1: https://lore.kernel.org/netdev/20260831210128.1359978-1-willemdebruijn.kernel@gmail.com/

> diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
> index e28884ce3ab39..5c8f9d175dd32 100644
> --- a/tools/testing/selftests/net/lib/csum.c
> +++ b/tools/testing/selftests/net/lib/csum.c

[ ... ]

> @@ -571,15 +570,38 @@ static int recv_prepare_packet(void)
>  static int recv_udp(int fd)
>  {
>  	static char buf[MAX_PAYLOAD_LEN];
> +	struct sockaddr_storage addr;
> +	socklen_t addrlen;
>  	int ret, count = 0;
>  
>  	while (1) {
> -		ret = recv(fd, buf, sizeof(buf), MSG_DONTWAIT);
> +		addrlen = sizeof(addr);
> +		ret = recvfrom(fd, buf, sizeof(buf), MSG_DONTWAIT,
> +			       (struct sockaddr *)&addr, &addrlen);
>  		if (ret == -1 && errno == EAGAIN)
>  			break;
>  		if (ret == -1)
>  			error(1, errno, "recv r");
>  
> +		if (cfg_family == PF_INET) {
> +			struct sockaddr_in *sin = (void *)&addr;
> +
> +			if (sin->sin_addr.s_addr != cfg_saddr4.sin_addr.s_addr)
> +				continue;
> +			if (!cfg_zero_sum &&
> +			    sin->sin_port != htons(cfg_port_src))
> +				continue;
> +		} else {
> +			struct sockaddr_in6 *sin6 = (void *)&addr;
> +
> +			if (memcmp(&sin6->sin6_addr, &cfg_saddr6.sin6_addr,
> +				   sizeof(sin6->sin6_addr)))
> +				continue;
> +			if (!cfg_zero_sum &&
> +			    sin6->sin6_port != htons(cfg_port_src))
> +				continue;
> +		}
> +
>  		fprintf(stderr, "rx: udp: len=%u\n", ret);
>  		count++;
>  	}

[ ... ]

> @@ -647,6 +672,9 @@ static int recv_verify_packet_udp(void *th, int len)
>  		return recv_verify_packet_udp_encap(udph + 1,
>  						    len - sizeof(*udph));
>  
> +	if (!cfg_zero_sum && udph->source != htons(cfg_port_src))
> +		return -1;
> +

[Severity: Medium]
Could the !cfg_zero_sum condition in recv_udp() and in
recv_verify_packet_udp() get a comment, or be replaced by computing the
expected port on the receiver?

As written, a -Z run keeps the old behaviour for UDP: the only remaining
filter on the PF_PACKET path is the source address checked in
recv_verify_packet_ipv4()/recv_verify_packet_ipv6(), and the BPF program
installed by recv_prepare_packet() only matches pkttype, nexthdr and the
destination port. A foreign UDP packet from the peer address to the
destination port therefore still reaches:

	if (cfg_zero_sum && csum_field != 0xFFFF) {
		fprintf(stderr, "pkt: zero csum: field should be 0xFFFF, is 0x%hx\n", csum_field);
		return 1;
	}

which bumps bad_csums in recv_packet() and aborts the run through
error(1, 0, "rx: errors at pf_packet: ..."), i.e. the same background
traffic failure the commit message describes as fixed ("non-matching
packets are skipped").

The reason for the guard looks real but is not visible here: cfg_port_src
is only rewritten to the derived zero-sum port inside build_packet_udp():

	if (cfg_zero_sum) {
		uh->source = 0;
		uh->source = checksum(uh, IPPROTO_UDP, sizeof(*uh) + cfg_payload_len);
		...
		cfg_port_src = ntohs(uh->source);
	}

and build_packet() is only reached from do_tx(), so a -R receiver keeps
the default cfg_port_src while the wire packets carry the computed port.

The receiver has the same inputs as the sender for the -Z case (same -S/-D,
same -l, fixed payload character, and randomization is rejected by
"Cannot combine zero checksum conversion with randomization"), so it could
derive the same port instead of skipping the comparison. Failing that,
would it be worth noting the -Z limitation in the commit message and next
to both !cfg_zero_sum guards?

>  	return recv_verify_csum(th, len, ntohs(udph->source), udph->check);
>  }
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904030624.3833721-1-willemdebruijn.kernel%40gmail.com
