Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015579;
	b=oBLv9hE79VlO+0pRAwTJ2ZL8RcQDjGmn/kEHjDmp0rf7OT7j5c4EWuo/Et6hR61oT2tJ
	 EXBi5m7ASWYqW+7n7/tzng/4wicJulalzbXRS4WlgL0WWBIzcH3XBhz8hZEtDgILrKFFp
	 7pff065DP29o2NMs/HHVB8LysjxdM5k/0fqkM0LlwX45XZKz9O1ch3QJEQPnT57/Bg9TV
	 0/FqNTjrV/ZxrDn80QRXVLiVABl1LNWxiu93lL9feZRUFCoaHqFIP8vm5TXGab6bGLpr+
	 qDlZP9K6P5M0jLgWwFufLnqpGuFDj6R+TtjfcDh43u8kWeZBwqo77r3ZWlJpXAZqakQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015579;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=muRBYzWWqUsiTqMXGBh1F+ip6DW5FQ1L0G5hI7qvkU4=;
	b=BMyoxIE1TiVIjM8Crx4nSYOczFMAV2iGVw+r38cqqnpgg0S2uyR/DPmuK8W/9dNfLjQ/
	 NVYWP1X7nDzF0P9iH6YqxbxidOopg3CD/Qt08wlJT3O+YGwc6YhG6EXouvS7PFfVjgr0x
	 G46sL9WORknfJnv7FWrUU6b57dwTb/0+1FwtajcKcSr1eI8XM0VZt3TpTfn7ozK+Ngfuf
	 Db0VLiKR32DEs/Hk9aF4/PeixqAdXBJbZ5Wu/vHIbbBgOkUD74LruMFYxiSgv702YcdNF
	 9ne5ArTbucy46EUuBzaMFhtkUR4qNFa723eVIJ+qTVqVuOke3qI1YpPcRfi84QMdbSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="vj/FpkW1";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4396606A31B;
	Mon, 26 Oct 2026 11:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4396606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=vj/FpkW1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=muRBYzWWqUsiTqMXGBh1F+ip6DW5FQ1L0G5hI7qvkU4=; b=vj/FpkW1ZOQmSYvYZLBvez8zkK
	wzkdQ3yZs32dv+fHFQBTaautS364nQ0U1Jj9dsvorR9vH2HBd7uEbESCzHBdwFoBJPJkVHJH/vlrg
	rE5NgklBGoG77Uxyv26qtMuGw2k99CdxaQ94uUmSqAPL/Pe0QkKjCACjs8yYlrhEUMF/1LTc8oxyE
	RDkVesG9Ets6BZnyu0nwm7SluaetDGsilC1Tpz9I1QliMFAdr7edKyKmxH32GSWk419yEj1biaG+k
	fe4Z08+pG49TY72+avc+RU8T+Xb+rN/BIYB6emWxwquC01AkEd9cZGpTGHeQVsPU4zCaBiMduSAfc
	WPEbfvdQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xLJG0-000en3-38;
	Mon, 26 Oct 2026 11:52:53 +0000
Date: Mon, 26 Oct 2026 04:52:48 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/3] netconsole: read np.dev under
 target_list_lock in local_mac_show()
Message-ID: <at8-E_EP8B3x6BFi@gmail.com>
References: <20261021-netcons-fixes-v4-0-3857120c6340@gmail.com>
 <20261021-netcons-fixes-v4-2-3857120c6340@gmail.com>
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
In-Reply-To: <20261021-netcons-fixes-v4-2-3857120c6340@gmail.com>
X-Debian-User: leitao

On Wed, Oct 21, 2026 at 03:19:06PM +0100, Gustavo Luiz Duarte wrote:
> local_mac_show() loads nt->np.dev and dereferences it with no lock. It
> can race with the interface going away and netconsole_netdev_event()
> eventually calling netdev_put() and freeing the device before we
> dereference it, leading to a UAF.
> 
> The window is only a few instructions wide, so I could only reproduce it
> with an artificially widened window between the load and the
> dereference:
> 
>   BUG: KASAN: slab-use-after-free in local_mac_show+0x4e/0x80
>   Read of size 8 at addr ffff88800e990458 by task uaf/130
>    local_mac_show+0x4e/0x80
>    configfs_read_iter+0x187/0x260
>    vfs_read+0x453/0x5a0
> 
>   Allocated by task 116:
>    alloc_netdev_mqs+0x78/0x830
>    rtnl_create_link+0x53b/0x5c0
> 
>   Freed by task 121:
>    kfree+0x159/0x420
>    device_release+0x77/0x120
>    kobject_put+0xb5/0x160
>    netdev_run_todo+0x420/0x850
>    rtnl_dellink+0x259/0x5b0
> 
> Two places can free np.dev: (1) netconsole_netdev_event() moves a target
> out of STATE_ENABLED under target_list_lock before netdev_put(), and (2)
> process_resume_target() releases np.dev under dynamic_netconsole_mutex.
> 
> Fixes: 0953864160bd ("[NETPOLL]: no need to store local_mac")
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

> @@ -888,10 +888,23 @@ static ssize_t remote_ip_show(struct config_item *item, char *buf)
>  
>  static ssize_t local_mac_show(struct config_item *item, char *buf)
>  {
> -	struct net_device *dev = to_target(item)->np.dev;
> -	static const u8 bcast[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
> +	struct netconsole_target *nt = to_target(item);
> +	unsigned long flags;
> +	u8 mac[ETH_ALEN];
> +
> +	eth_broadcast_addr(mac);

Yeah, this is much nicer than the bcast one. My only concern is that
this is a fix, and it changes quite a few things beyond the fix itself,
which will make backporting it to stable harder.
