Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417673;
	b=LMrJHgLbG6Sq16QWoYvKUegD8x0A8Ama+XvzsH1cWydXq2BpiSGaSQMpI4kx3hJuW/9D
	 CohVQo1QqoRDpx6tBohy65nEgcNryC3rp8f1xqdBMCnlG3mvtyMiIpJV2OrBPJ0hZB82o
	 fXPbGz1lsCWFFYZ0C6WukvTPC77adKMCIwyvPYn2jFV4TBj5JTZKBUeG/fRiRCW3+zHY+
	 UPdzoYrSJ/mG4lCb5U2Vl+S9IsvZ5FhdhYxEVeTP1xQqmMqgPXpXFQsWlqKvKmiTjuE0M
	 PZFkIXBCLnBeisH6JnLvtE91YACZ5uOeIcgnNz2iHYj8S22Zi9yUOZwzd4vd7U4H3xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417673;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EE8+MCsRagBoohqcIiB5gvCk84/vK5Bw9WsOjn/UPac=;
	b=GLg4VTfMvF5rrX9tPUNR8JzsOjkoKGxJjAeg1aIZpmDL03b+YVTt9mWNTLsy/pisnADP
	 9QwEm3waONXQ6dAAaXDNw5wKo0onAPjAZFUU0+8JNpcccbDcPePvYgFvTHrLQuAftgtKI
	 z0IX/yBYOdioOaKM9g8+O4gQ2H1SQaa7TCBVbwuH2PxqbxiO1vH4uFc5JLg38iMTISsUV
	 /5VXDWnfy0yuNfv2F7Sb4Uzy765v4VWtnyRp5d8eEiIcXeL2mBH0i/LFG6IJAWM+/tzcX
	 44T1yBvFG6R+8s/YEHmIlLjDSuv2znrM0AS19ydDXWPYxiOvuS19gRxsyWuUlVNvxWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ocsjFEby;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417CE606A326;
	Wed, 11 Nov 2026 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ocsjFEby
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E311F00A05;
	Wed, 11 Nov 2026 17:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417672;
	bh=EE8+MCsRagBoohqcIiB5gvCk84/vK5Bw9WsOjn/UPac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ocsjFEbyh9BoOTNj4Cy9BmB7U7bPo+QAuvW4Gs0cvMxQbshyxudiUz1zoJKnrIJqB
	 BLxEOAlryk+aoE2UEq+egeLHN586qS5bm9uzG+OmEG1l/8ruAcLk2E/alX6vOg4lcj
	 1OYQNUt4fKgZUXkk9XVa5+rS0laJLK71XdfFjCpR1dpxftdyvZuHagqM0u+de2Efmh
	 rU9ZNScve7e6MafiYeS/Y1hpF7Sod9bmxCpVc69HG9/Vx+5B0q0Sh0uY2857dzxJO0
	 Fr4whhPw0fLfkToYaYl1CyyF583QgSYk9KGXRMfpm9+/uDIxhT69ll3TSqfersTVuY
	 J10/36edbhDpQ==
Date: Wed, 11 Nov 2026 17:21:08 +0000
From: Simon Horman <horms@kernel.org>
To: Omar Ramadan <omar@blockcast.net>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] amt: tear down every amt device on an unregistering
 lower
Message-ID: <20261111172108.GH18859@horms.kernel.org>
References: <20261105232302.494171-1-omar@blockcast.net>
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
In-Reply-To: <20261105232302.494171-1-omar@blockcast.net>

On Thu, Nov 05, 2026 at 11:23:02PM +0000, Omar Ramadan wrote:
> amt_device_event() acts only on the amt device that
> amt_lookup_upper_dev() returns, which is the first amt device bound to
> the event's lower. Several amt devices can share one lower, for
> example two gateways.
> 
> On NETDEV_UNREGISTER, only the first device is unlinked and
> unregistered. The others stay upper-linked to the lower, and
> unregister_netdevice_many_notify() warns, because the notifier chain
> must detach every upper device. They also still hold a reference on
> the lower, so each is torn down only when netdev_wait_allrefs_any(),
> called from netdev_run_todo(), rebroadcasts NETDEV_UNREGISTER. By then
> the lower's sysfs directory is gone, so unlinking it trips a kernfs
> WARN, and unregistering it from inside the rebroadcast trips the WARN
> in __rtnl_unlock(). On NETDEV_CHANGEMTU, only the first device is
> resized.
> 
> Walk every amt device in the lower's netns and act on each one bound
> to the lower. On NETDEV_UNREGISTER, queue them all and unregister them
> in one batch. amt_dellink() unlinks each device but leaves it on the
> netns device list until unregister_netdevice_many(), so the walk stays
> valid under RTNL.
> 
> To reproduce:
> 
>   ip link add lower0 type dummy
>   ip link add amtg1 type amt mode gateway local 192.0.2.1 \
>           discovery 192.0.2.2 dev lower0
>   ip link add amtg2 type amt mode gateway local 192.0.2.1 \
>           discovery 192.0.2.2 dev lower0
>   ip link del lower0
> 
> Without this patch, the last command logs:
> 
>   WARNING: net/core/dev.c:12773 at unregister_netdevice_many_notify+0x13e5/0x1940, CPU#3: ip/216
>   kernfs: can not remove 'upper_amtg2', no directory
>   WARNING: fs/kernfs/dir.c:1784 at kernfs_remove_by_name_ns+0xc9/0xd0, CPU#0: ip/216
>   WARNING: net/core/rtnetlink.c:141 at __rtnl_unlock+0xb2/0xf0, CPU#0: ip/216
>   WARNING: net/core/rtnetlink.c:141 at __rtnl_unlock+0xb2/0xf0, CPU#0: ip/216
> 
> With it, the commands log nothing and remove both amt devices, and
> tools/testing/selftests/net/amt.sh passes on a KASAN and lockdep
> kernel.
> 
> Found by a selftest for our upcoming AMT offload RFC, which deletes a
> lower carrying two amt gateways, on our 6.18-based driver. The
> commands above reproduce it on net.
> 
> Fixes: b9022b53adad ("amt: add control plane of amt interface")
> Assisted-by: LLM
> Signed-off-by: Omar Ramadan <omar@blockcast.net>

Reviewed-by: Simon Horman <horms@kernel.org>

