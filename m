Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A752F4A05
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768545; cv=none; b=QFWxqcZNzI/mhVBWPQ2boHPkIWqryxnrjuCSWHAuY7nEFTvAj0lbDvkhWjFkZkYCL24EzKaIV4vhCK9n3CA+lOZ4kWWHrXlvU25mk7hXVOUe+ZMHh8X+FJmysZKL5fBqQGC3Z/2xz/OLPcPc5SExp7EILsFNiTOBV6GJVrvzFaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768545; c=relaxed/simple;
	bh=iGDF1AsD2KJpuWxO+fbz1RvdVuHCSmIG/cZ/UDE0V38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMfibS+fOC0MbRMsQD9bQgiOlzZqJCG3HMWtKSfPUz6ASz7/LQmbVMBtRpnZx6re1FpF1cEyvO8T1rBoBsyNdF5zEzV3Kh/P/HDbVHL0Y1fw6Eb1q1DVxX2DMoIMPobTBv6zzq8YJyqSaNzwGXm/U49wvg4IUKRnoWMnQq1huEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=i3gHzfEH; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="i3gHzfEH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mFhEEXMGfM/+f6moC5+h/DpbPtYeaZXpVs2fuqpnrbo=; b=i3gHzfEHZJzgBMuPngvxIpJZgw
	Z77QeJEtOJ51LbG+t2tGla0ZV3IaL3NlRYDv3uIj/CVr97g4nuWeSGjnWWd6k80mXTA5Nera/S3YK
	MVaHvUicCsc+8NxxX6bjUZqTayzQFwurqr0bAy5r3UDiBulHyiwSG4ySgV/DNaJKEmG60MFRunxFH
	RnrfptCxDamXU/VcEsa10ToICWh6qPA5MBn1y0oVr7/EC3ophlj6aSvKgy/kuvpCgYl939KfcWXOw
	/zj5GU2HvdI98YzSBfAJo4OflUoAns/eMEZRIjDTpn/0rIiAb06O5Vxp0RpxGcoE28qcOpD6eri2p
	nCykBiiA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xBshK-0004fb-0f;
	Wed, 30 Sep 2026 13:42:06 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xBshJ-0005Hd-0R;
	Wed, 30 Sep 2026 13:42:05 +0200
Message-ID: <cd08320c-1c82-4af9-ba54-20b62c8e1a26@iogearbox.net>
Date: Wed, 30 Sep 2026 13:42:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: only give queue leasing devices a separate
 instance lock class
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, razor@blackwall.org,
 dw@davidwei.uk
References: <20260929191543.3295633-1-kuba@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260929191543.3295633-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28139/Wed Sep 30 08:24:18 2026)

On 9/29/26 9:15 PM, Jakub Kicinski wrote:
> Commit b6f74dff6d26 ("net: use two lockdep classes for the netdev
> instance lock") put every device without a parent in the virtual class.
> It also restricted the locking order for the virtual class, because
> queue leasing has hard requirements on the exact order.
> 
> This bites us back on bond, which is "virtual" and needs to be taken
> before taking the locks of the lowers. NIPA hit the following on the
> new test I recently posted for XDP+bond:
> 
>    WARNING: possible circular locking dependency detected
>    ------------------------------------------------------
>    python3/18635 is trying to acquire lock:
>    ff11000120b8ce30 (&dev->lock){+.+.}-{4:4}, at:
>    netdev_put_lock+0x2d/0x1a0
> 
>    but task is already holding lock:
>    ff110001ef77ae30 (&netdev_virt_instance_lock_key){+.+.}-{4:4}, at:
>    netdev_put_lock+0x2d/0x1a0
> 
>    which lock already depends on the new lock.
> 
>    the existing dependency chain (in reverse order) is:
> 
>    -> #1 (&netdev_virt_instance_lock_key){+.+.}-{4:4}:
>           __mutex_lock+0x1ae/0x1f10
>           xdp_set_features_flag+0x2b/0x50
>           bond_xdp_set_features+0x1eb/0x360
>           bond_netdev_event+0x13f/0x300
>           notifier_call_chain+0xae/0x300
>           call_netdevice_notifiers+0x70/0xa0
>           bnxt_xdp_set+0x2f6/0x620
>           netif_xdp_propagate+0x503/0xc60
>           dev_xdp_propagate+0xa1/0x230
>           bond_xdp_set+0x234/0x700
>           dev_xdp_install+0x592/0xd70
>           dev_xdp_attach+0x355/0xf50
>           dev_change_xdp_fd+0x176/0x210
>           do_setlink.isra.0+0x220d/0x2b20
>           rtnl_newlink+0x9f1/0x11b0
> 
>    -> #0 (&dev->lock){+.+.}-{4:4}:
>           __mutex_lock+0x1ae/0x1f10
>           netdev_put_lock+0x2d/0x1a0
>           netdev_nl_queue_create_doit+0x801/0x1a70
>           genl_family_rcv_msg_doit+0x206/0x300
> 
>     Possible unsafe locking scenario:
> 
>           CPU0                    CPU1
>           ----                    ----
>      lock(&netdev_virt_instance_lock_key);
>                                   lock(&dev->lock);
>                                   lock(&netdev_virt_instance_lock_key);
>      lock(&dev->lock);
> 
> Let's narrow down the "virtual" class to only the devices which
> can actually create a queue. More LoC and complexity, but that
> is what we actually care about here. The rest needs to nest
> under rtnl_lock, which bond does (famous last words?)
> 
> Take the instance locks in two passes, first the netkits then
> the rest (matching the queue leasing order).
> An alternative would be to make sure the close list is sorted
> correctly from the start (queue head/tail appropriately in
> unregister_netdevice_queue()). I think it works but feels
> a little more fragile. Happy to change, tho.
> 
> netdev_can_create_queue() will now be used on paths where we
> genuinely handle non-netkit, so we can't always set the extack.
> Unfortunately, the (recently) added tracepoint in extack fires
> even when extack is NULL.
> 
> Fixes: b6f74dff6d26 ("net: use two lockdep classes for the netdev instance lock")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
