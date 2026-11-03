Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707744;
	b=0HHjVHE9O8A7ZWd51dnW9hjdUt/M+PBEGEGgiDoOe+70/ycPSAFQBtV8T3r1nqnvyNQB
	 EldPJ44YriSkZNtgBa9007OKdT6+TDdSvLW3Y0LTyaYRbDPBj7cTVVrSCn6VwEF74XVe+
	 udh6xFuXA9CoLx6pnSDwfGG3doX39DyqYe+dLu85HeRfFjRACyWvlmB4eayGLj6a2onC9
	 SLa0g6iSKY8bjmNOWCjwz6v2KO1ygxTwt8e8l7krySgGGEfUTts+kecbmePgUY7t3L+U6
	 nJa1bPVofjrcOFGkE+Gmc7UcPj7IoEU2Hgl1t4nYWBropGTr2Yet3tapJLCwsJqevbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707744;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=eZc0hYex0KzI0Z54pU8RsaeZFamyJIJK55zZ8egZ8No=;
	b=Fut9ch5toaN9nsd4nyhWyjw1iOQvuZwf9/K515XQh6NgCqhtxkAVa4T+1zjTH99Gv8V5
	 vCwoyAYcFgYgT6+1hG20hP1IHQwWr3GK9dtv/IYwV3hBTspQwaUIozEtz/Kd+tDW2OLX1
	 6XdVidxtSToOeSN1OpPj1JljL3QPDEO2LJbylcbxZUA8G3x0qDxB7CAuZ07l7iwOWbbE2
	 5KxuAbtQ4J0dqtD3d5IzdTUyeM9HKN3T9Ta0Z3l60QW30kSwexmTlVZ+qBAdSd9unlpGU
	 Y8bXtpwH4c31GD56Fzwuh6OvwwENLlHumflK5tfmTlRytzl+8lwjjQWQzrbV5+ibXWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=SJk4Zm9k;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED66606A326;
	Tue,  3 Nov 2026 12:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AED66606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=SJk4Zm9k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eZc0hYex0KzI0Z54pU8RsaeZFamyJIJK55zZ8egZ8No=; b=SJk4Zm9kLgK8isXPedday4Xgas
	bpAPr3Dxp1wKxTBSb2WT6HRKT6rUnXKqJ94PF5QXN4nfIaJhiKg+vQ20t8M6MhErq7jVHDNjJWmtM
	g/Pn7vMyHlVSYm4yG5sPfiuDVP25nezsPuQJ+/wPn6XBxdLluZwog2iBAyd+CxABPxT5vIdiLDhDH
	qxCZlv3ACkYxUlttPdDW0koSQNs1gAZXClxQNkXYnJKsOjwL/lus1IS/p2Z8FQN520ACOCnT8ADFI
	CCaX+UKYuj5rmy+/Ppn67XD5J1Q77Ggl/wnU5rbISsS9f+52//NSd9RKLiP0l37jRDdIZjbxnu8B0
	TBLhKwOw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xODJx-006vIW-23;
	Tue, 03 Nov 2026 12:08:58 +0000
Date: Tue, 3 Nov 2026 04:08:53 -0800
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 2/4] netconsole: read np.dev under
 target_list_lock in local_mac_show()
Message-ID: <aunOzXgE-kz6twvK@gmail.com>
References: <20261102-netcons-fixes-v5-0-bdada2f03563@gmail.com>
 <20261102-netcons-fixes-v5-2-bdada2f03563@gmail.com>
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
In-Reply-To: <20261102-netcons-fixes-v5-2-bdada2f03563@gmail.com>
X-Debian-User: leitao

On Mon, Nov 02, 2026 at 07:54:50PM +0000, Gustavo Luiz Duarte wrote:
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
