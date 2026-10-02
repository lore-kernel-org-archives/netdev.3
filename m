Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F07440A2A
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790931725; cv=none; b=ZQwGnucLy1spwuZHdftJjTRIf6uFCTukO9ZXbA7Xlzl2d63ygdMCO0jeEqTih8kTgceEdQf6GE7Mshp/iqaMAvR3OYqMbE/vkb7TveSWx81peW7JDXevWlMY2TWLu1SUqhwhd91eoaezJ95OUaTsQAseHFugLGsHZkNbDcXShnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790931725; c=relaxed/simple;
	bh=J6nxKAAEKw+aHPU9GPBs2hJ7kDpqt8utl/LD2YL3l4g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OTiYFT/0w2b/7Ucyl9RjW8471h2IAC7SCIauVVblBE3rJuAmPdZF9ovGnBgZlu+/pkus68RU4+v1YzqvgBBxdc5SD/qnrURI7x8LJ320kh5I9XEttTBPMXV/yWczFF+lsgGJCNXBXrX/wVg04taqCwTzUy+FkaM+ZaYe89sBwZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=bE1TDDON; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a/VHqhqU; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="bE1TDDON";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a/VHqhqU"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 6CE5B1D0007F
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 05:01:59 -0400 (EDT)
Received: from ams-imap-09 ([10.64.2.29])
  by ams-compute-01.internal (MEProxy); Fri, 02 Oct 2026 05:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790931713;
	 x=1791018113; bh=TlO7bPRWIV3zM8WpMmI37lkXyRzUKRg+EDK7Z7eZe0w=; b=
	bE1TDDONdR3OeJXpRBFCR9/S3TKdcKRurjQ75wWfQQCO4NlFPuyjEQ9UtQ656bNh
	4rFhkwG+tdr0YzqEiAMvSUJ8tvWsnL5NYQqpTh9NtApX4G1yjnXptJzLHGOipoLS
	KmVmuGnVEvbtRBtwAr0bk4LwOT4S6PSOHTFEXWUv6tvV5Q3jjyhp00tY+I4On10j
	P194gArfF3WIZ9pHITNCj5M51i3PRzp3Is7+piqXEL6W+4Fi9x99zwAS9LrZ5Rdo
	7+geebEv3N6J2M+JLcnqcgsmb/XtNivr7gDotqrZThSmFEH9hdfB98saQkACmxfx
	8Hc43LyQ8HRRXNS2hA78RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790931713; x=
	1791018113; bh=TlO7bPRWIV3zM8WpMmI37lkXyRzUKRg+EDK7Z7eZe0w=; b=a
	/VHqhqUWXJeC8HZU/aM1FXPTUhs7pZT8aBegC8TCRXcVFaNwGpf8wPSrtb6dewaz
	ZdQK9tapTYvWptuQGGwQncvuUTlva9TjvRU6dddTOmSUBmm0wT2c58yYvD6Evh0B
	55K3I5ior8Ebs+rKeqHRM0N67aXifvbefpUKRlgUJLIx4FFeRCL4y+jJBVcZY3ak
	9yLCTJJQs1x5bisDgf7EMD5UhvUfrOx/hgpPikGPUmcKVGEYO9GQxUMb5N3e2w3z
	0Sw7LSEB2Kuy4wKqgl4RK/M5q+/ejfRV5cBFaFTXPc24WSCChi87SkHzEVw8pPat
	QS5Xtw33VWeJLp6qGcY8Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790931713; d=fastmail.im;
	mf=PGFsaWNlLmtlcm5lbEBmYXN0bWFpbC5pbT4=;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MkGz+9UL4U1itzcakXEGv4wBuFT4qpAnEmU6VK1ObtRAS4j
	Fmu9RPJP8R7YyL1SyFHGxyID/IdizhT6POc0dRfzsHLmGrjLZhJc1xdOU1gdNyhG
	fDuzb6IRfTKkXB8Xgt/pCGwO0t3ftRRi5y2IOJO0+bm2XDo8oOrLAOnWaINco3rZ
	WObT0UhFYdUIM816Ti0xWMRuayjZdv+ow+9SAK5asAvvBW6O+26xO1JW0VObvqrN
	Qw1DAQHuVv9THneQ614J89CH7KST3WocjkH4FYPPfwUxWWIvxKy7ryFvQdUC4siB
	pzerz2umXUomJx9bBEQiNf9Mfe+uCr61p1ZaLNA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fHmLiJkMboAy2jOdq138ATeM394pYEjl8w0f38CPcYA=:J6nxKAAEKw+aHPU9GPBs2hJ7kDpqt8utl/LD2YL3l4g=;
X-ME-Sender: <xms:-3K_ajLee_yJ_woYNBLl-I5Jle-c6TDouymKYbq3KF52VnFEp9lx0w>
    <xme:-3K_ah9bBdhubf9NjpSc_Byf9lfoeNJzwIZaiXyh4K6YrbEQWXELnfE4aqPXovzqA
    l-ZLLHHrOFnKvxPwXFaSA-x_Gq8HqB111QriXgq9orWj9oLdaYDv9g3>
X-ME-Proxy-Cause: dmFkZTGG9H6Xol9ZcTek8Q1fTDRKF4K3xzVyOjVKS9WE31+SFKlkbnX+pbW3oMh9sqqodh
    umhWEj3tgpuK31HRjHAoP5dVlu4xwKOZyEuVGvJAnhxbFyV0EO2YwgjvbjBxqhmtI9Qpu6
    f+v2d07bo3k7qhBxqJLmvavVfbZj+O7+yDYz787oFDkVIKj8f4Z7sRcs2M7UV2HTlkxhEX
    PmPUxDXYY5KI4+xtlrmIw86VKF7Ae1EjYUcV+0bL/hkHqU7fk4vjVu3m85jeYjdI7Omrl6
    /Fo6KI/cd1L0n8OjWCKCvoilKE2pVto1vgJMX0VFt6mD8dKtSlt57JBK3puEo0MJQee3jb
    RrCEeO9Mv6DbLR+A88p0SwRxG8Iy8FcpdxuQqKLWoXCgjzV7SLWzQyO/rctuvfa0K+j5qx
    zJhIH5OmjhiJThMpc1LCIKoS3oM/XxF/dsAfHgldNwdWo6wSTXBgxgQSa4n+nurZZCAfX/
    /h7slqGD+8XY35mJpWDh8HypaC/C9XeWU4NxKfe73j1l0iYfBRAgZ+PYv1flMGXz7Z6klP
    DNQN6FB2LiRSmQ2IegQ0TcAhufI0pdI8FMOaohiy8L5L6/rwYPeAtery+Ry5zj9+OlS8EL
    50BNHKAPQTdk9zrUtuwjze8t5lVAjLaIu1/Ri8hcs1ettPXAPME3MayOWCPg
X-ME-Proxy: <xmx:_XK_atqb2hyKojLNXUIbj5XmOdPRYyiKtcEc9-jPAxrwmuOQyflchQ>
    <xmx:_XK_asMe3uGfRKgSCzlXaAIDbcEwosOKOrOUxA_Tl1qROAnV3B7rFQ>
    <xmx:_XK_auqDoKT4rIw3wuX9QznAWqpH0heBGLMPRZhAA3-dQYL_cl6pgw>
    <xmx:_XK_avtnCQd7QovyNTGoY4kPxRkLvDTylQ40M5S8Lwbq3KvaoNlHnQ>
    <xmx:AXO_arLtcnj5UrHB_K3gRv3oCpamc_RrGsXDDucyeOqR65n0gj1tdvS_>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 704F518008E; Fri,  2 Oct 2026 05:01:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ2OsyNbRYnF
Date: Fri, 02 Oct 2026 12:00:45 +0300
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Haishuang Yan" <yanhaishuang@cmss.chinamobile.com>,
 netdev@vger.kernel.org
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 linux-kernel@vger.kernel.org
Message-Id: <12e098d5-18b1-4b01-bd55-ccebf8a78bbc@app.fastmail.com>
In-Reply-To: <20261001042336.224343-1-yanhaishuang@cmss.chinamobile.com>
References: <20261001042336.224343-1-yanhaishuang@cmss.chinamobile.com>
Subject: Re: [PATCH net-next] bareudp: Enable BIG TCP packets
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 1, 2026, at 07:23, Haishuang Yan wrote:
> Commit f3d0f753f066 ("vxlan: Enable BIG TCP packets") and commit
> 03ebe91b0f61 ("geneve: Enable BIG TCP packets") allowed BIG TCP on vxlan
> and geneve, after the preceding patches of that series made the common
> UDP tunnel transmit path handle GSO packets larger than 64KB.
>
> bareudp transmits through the same helpers, udp_tunnel_handle_offloads()
> followed by udp_tunnel_xmit_skb() or udp_tunnel6_xmit_skb(), and does
> not fill in any length field itself. Bump tso_max_size up to
> GSO_MAX_SIZE so that the admin can use BIG TCP with bareudp too.
>
> The default gso_max_size and gso_ipv4_max_size stay at 64KB, so nothing
> changes unless they are raised explicitly.
>
> iperf3 TCP over bareudp (ethertype ipv4, IPv4 outer) between two netns
> connected by veth, MTU 1600 on veth, 3 runs of 20 seconds each. This
> was measured in a QEMU TCG guest, so only the relative numbers are
> meaningful:
>
>   gso_max_size/gso_ipv4_max_size 65536:
>     4380.6, 4404.2, 4354.5 Mbit/s, average 4379.8 Mbit/s
>
>   gso_max_size/gso_ipv4_max_size 196608:
>     5509.4, 5454.7, 5497.4 Mbit/s, average 5487.2 Mbit/s (+25%)
>
> With 196608, about 90k to 100k packets larger than 64KB were
> transmitted on the bareudp device per run, none with 65536. Without
> this patch, setting gso_max_size to 196608 is rejected.
>
> Assisted-by: LLM
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
> ---
>  drivers/net/bareudp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
> index c3b5ed52d877..fcc33e302b9c 100644
> --- a/drivers/net/bareudp.c
> +++ b/drivers/net/bareudp.c
> @@ -589,6 +589,7 @@ static void bareudp_setup(struct net_device *dev)
>  	dev->max_mtu = IP_MAX_MTU - BAREUDP_BASE_HLEN;
>  	dev->type = ARPHRD_NONE;
>  	netif_keep_dst(dev);
> +	netif_set_tso_max_size(dev, GSO_MAX_SIZE);

Acked-by: Alice Mikityanska <alice.kernel@fastmail.im>

Do you mind extending the big_tcp_tunnels.sh selftest to cover bareudp?

Besides, enabling BIG TCP with fou would also be a one-liner, the
basement was added in "udp: Support BIG TCP GSO packets where they
can occur":

https://lore.kernel.org/netdev/20260710134242.216538-4-alice.kernel@fastmail.im

>  	dev->priv_flags |= IFF_NO_QUEUE;
>  	dev->lltx = true;
>  	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
> -- 
> 2.43.0
