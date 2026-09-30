Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A23A3816
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756078; cv=none; b=jQyxk9a1KMuPn7gvsnVdTFkDG0cGpvOwa3tJEa3eM1KGKsTunQeUP6Y8ER3AyczBif9FapTWZICQd/lpLwumMyUYKN2zi33sYeeoelrdZKKiRpPyUVi/SXUVr0/E2RXNyUbWYOP+iybqq0XaNCgjp86TaxzTGvGC/KVhqPTg0CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756078; c=relaxed/simple;
	bh=0CwyzJUN3BbTBxQSvsp2s5l3yFClsluBsogv5Vh/aZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C91nkJ0/wmn0fHbkfw3KOT8pkTtdZyIH/mr5GalP3fg9uWOzX9Yz4Q47lYPqhxNkMpetBO7xl2q605I+QIe+Mt8sa6pSKB8OuyYpWIe23MM/rA6Q9s9QmlZ1qoa6YZ1wNRYxy8paq3C32RNU5YNXhonf/WLoSbsprRNTFT4p6R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=OiblmIny; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="OiblmIny"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fe8bf173aso26622745e9.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 01:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790756075; x=1791360875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=diLtsNdDHMKrpPgz87hzjRxf6XvS+RYwcS8M4g1Fruk=;
        b=OiblmInyYwN1N+pVptmmz0qq5tHndl3t7+P1feOAOZ2A1CjmEa5EUkmT1XjO2Z99vQ
         2pFG0SZxnbLe/stOvwD8XodTSVuhbDWHxop9hhhQHtNT5m018EeKdbQ0bDmzK5NZcInQ
         qNNfHvudxJdZ1jgivH/hkMLnq/GTZDQEe95RWS0fDcnxVul+CCkiPFaZQAlWvnwItBN3
         mwNRBm4sJU7G/5oig27ysHzEdjffvxH/PxOXiJfI/C9BEoSzhrrWeGQtcxjt5cXf60Bd
         INW3B77Q7adzgX22UsuGPQ8xXcpkqJS3zlzuAg95lukFtVxKkYeyF3RdX4+NIZBOmmti
         HWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756075; x=1791360875;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=diLtsNdDHMKrpPgz87hzjRxf6XvS+RYwcS8M4g1Fruk=;
        b=HKkYlUZYFzfKU8A6R7TSN1whN005K4Jr12N3AQlbU23MIVd5eHt+rFJxRhL+QsCYnK
         OjOGpYsi8u+977BLRbRySNQfY0APfZWoqQYj73xQOGKAMuU2mBdwsz3oZBWybVuz7EI5
         S9rRQ99vcvXX+zOr4cJOUiY3FSqCySmQ1kgIL6lZggy567oWF41H8Cr2K/IGZEjDas6L
         7vTsfd0VjOY37IpsMtlYK3eqI5BUT2mRGwpSz2rgYXWAL6HyHkJsrI6OcjozoOs9i45c
         A41atjWd81zhLrPHEUohnlWzH72RS+ahlgZAUR5TmvtTQF7HwWM8tQTrqoL33BH/GlBO
         b0cQ==
X-Gm-Message-State: AFuF++nG7ecxH7FcEs+ZCcltAHXQ4hVy7gwu9tcUOoosgrl9tZNH+ZaG
	kVB8IKP2odHzQ5/j33s+jwPYnGrEeWT27mlrzqi1nycCpNs6OcAWyUNNgmOEnc6jrjYP1jQgqQg
	AjAEB
X-Gm-Gg: AYBFou24/ySqpXZjWtVpdTXyEXibBuMSj146P0ghbrZGg6yNhJ82w05VKvg0dWjGU52
	IvXjQ6jrOkj/dnqz3eS5rjyEuq4VilmGAvVMmPHMjhqyFj9yUyY08txNJI5B/Wb0BWx2/S0D4Iv
	QUdW9HenPpGUtkCuABoszR5lN4yVT5VDMb845+P7U/+5ZnW55GrIstyxl6F3WyNSVHw09jzZS4E
	duTylufaT1/TdatwCwVJhLSvcf3UZVwJJHbTTtH2c7NzvZ6oWSSIINE0w4oETWj1aiz6qcRow41
	FKn9+qPbEdZKfeK/PaoizGwTzPDbOsWPEXEWD4eu6/Ys5cY09bNfvphJqyCuPKRH1nJOnIFYcV1
	rWSFQ8YnPWZdh6qeup5sMXYMhnsYrT/dL3sXGoaIv/WDsc41dMyRxo815LhL6++wPCyrNlgNrw9
	pqTbkctLj1yFHxh6izHLyRqAyR9uhggNhaGC2nSTAn933FSdzeWDHn8hFe1GU5gqCUG4lensz1w
	vniBWwqStTMYUPVs5xrHAs3fEtv6bZJ0+OU02E=
X-Received: by 2002:a05:600c:a45:b0:49f:ff73:9971 with SMTP id 5b1f17b1804b1-4a01b113993mr7834315e9.18.1790756074812;
        Wed, 30 Sep 2026 01:14:34 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a015a1e77bsm34439575e9.0.2026.09.30.01.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 01:14:34 -0700 (PDT)
Message-ID: <9ec493ae-b41f-4d03-babf-2a4c5a24269f@blackwall.org>
Date: Wed, 30 Sep 2026 11:14:33 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: only give queue leasing devices a separate
 instance lock class
Content-Language: en-US, bg
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, dw@davidwei.uk
References: <20260929191543.3295633-1-kuba@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260929191543.3295633-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/09/2026 22:15, Jakub Kicinski wrote:
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
> ---
> CC: daniel@iogearbox.net
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: sdf@fomichev.me
> CC: razor@blackwall.org
> CC: dw@davidwei.uk
> ---
>   net/core/dev.c           | 48 ++++++++++++++++++++++------------------
>   net/core/netdev_queues.c | 31 ++++++++++++++------------
>   2 files changed, 44 insertions(+), 35 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

