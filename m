Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19772C2363
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786868427; cv=none; b=r9C3+kO2CC5jU+tKfcW/PRl2DgFkh9cQi2zC2Jciz1xdWtoO48yC8ZwryYk95DK9t5Pw6oz43gmZZ3sHFtVyx8jcHV2GKl1MsYxioxAriIf83W9smzIjT4WBWtUGiqYKwdBUmk+hlXhk7JgOeCbXlpwC2u//9Im0VQKzZfXtq7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786868427; c=relaxed/simple;
	bh=oqmqmq+uz6mm/NU80WHXIL/tdCLKQOzi8f9AE3QURdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PRgUz0Uf52+dU/sAY+b8jeQ1C8u2+NMt2yaTvOOphZ1IP3tClSSF6nLP4nrSMm4py6/ibrnI9IJSyvxhl9XCyVCFfsrL0m0ocgWl+Yvg3uGchc68aUYvnWdqK5Uf26xkO2YhQ95lLjnyVbzBupW7I4R0poE29Op6br+DoaAORTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=QhYP8WEH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="QhYP8WEH"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so19815395e9.1
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 01:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786868421; x=1787473221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dWpc8mSAb0Ps+eqxqppAUahFxDXBRTVvYVd6wme8rOo=;
        b=QhYP8WEHRIwiEYPCJIkDWNepAXB6968UVtQGzZoLkdJdQKxIyst9kRXtHl8OywWl/a
         pj5vywKdyVRSbI0vc51EahTrGI1RT7anwbmNT3sSiFlVM1qWwi1cQUmeDRkXSkO20Qk9
         Lzd+9s3r8PMd/yuVC8cdGWY+T+l9KyH/fbm6af1DodEC0aXsKiv3p5uyQkIqkvNofe3/
         o9FsVGuvg3gyn0la72VdL257O5c30mjCLBpIoIi8dSDVhw4DnxPnLulbzeeXoI/EFM6W
         WZrbN7ZQ9+r/8oSgqSjSXB+q5QPr/+ela/6DLyzGKPpj46UJRUz3YoGN7vd2JMxdCREA
         tqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786868421; x=1787473221;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dWpc8mSAb0Ps+eqxqppAUahFxDXBRTVvYVd6wme8rOo=;
        b=pnC58Jb0PeUAySz2XvAye9OQIMRAyz2DjSYpbF2AqenEbWdArJIDQIzYPHaM7MYp36
         cKSuC4GXdlKktqrgB9FPPqCSMHIL76c3gRTNfg/J72QsJSrMSbj7GYMXOpUTe3i9LrB7
         8pvmJUyAMF131IrmYNFKy0PclUdkVk2xTlqXeNUQXMMZkixeUAZFp+f+0ukcX5jG6/DM
         HCDHFMWtwyxGEJfYEIBVoelQDB7iiO4iCmEQeGe+s4ZZysUKFoIideKZPoBBefz6006v
         xnezjXcSByfyP8H5N4zF8u2Nfym/OZT425LNumTRF11FlcEAlA7tHAVaGhATHwkGVmP0
         OKMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpz+6QpEWSOb23oVZ/lVFTeeYvRHUH6YsS6c1q27LBycjc2VeSIJsh8S4YMlO9CPjpEVLtE7G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwepdkjdPh9uBIUy3zukg4dseuBMnEJ23BIGIGWffYkQpS1DtiI
	MfAEtxf/HSXP++fYoxgfBnVdLIsI8u5BuNMpSSZ+QZD0znlWfmap/9IUsFnvcKiHUNM=
X-Gm-Gg: AR+sD1399nNaaFag2FunUoG3bl4nCNVaols6oUFxZyUueDbmOtCUdKiLD/7Y4eq2cCQ
	7/teTDFpjdpTBgV8WBtBiEtODNqBJt0/1BYH1Jn6rNovuOookE8KuudF4vngaoUX3ddg+eutvAU
	lZhXOBtOsl7FRcvDG+LZKXOAfNRQQ2M5NB3f5p4eGY5qkTTnHPEe4nx/I3Rbx4qmU9PsJYd9tTG
	nKMmqHsfhM4aSjwAd7hRIkEtRxDh/GpGzRIVx6S2lT8P2aozfLQ/hbJdSBh24J3a+mURx3p0amc
	8wYn6fBGM0vAs2tXpTqpOOCakhD2hJk/YthMDyyS1V8dg37okmVcnqKwwv7lcvJSApaI9mGy4Bu
	i0C/QBoiLyp8JgQgxG75QV8ykTGt0iFR5nS3zODVHoTI2oDd6WbXzmpVKPQty7wHMm7EH9s3lgX
	rJQ6A0aOUNkFD5GBnHv9w45rh+m6sl4W94XoBG3eCw7MZVwle6FrNE/WSHWq94/AFM1O8WKFUPx
	i+uU6TmzXUrDwSF+7U=
X-Received: by 2002:a05:600c:4e14:b0:495:3bc6:d381 with SMTP id 5b1f17b1804b1-49987a4f03bmr274724285e9.2.1786868420491;
        Sun, 16 Aug 2026 01:20:20 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b3a6dcsm85352655e9.1.2026.08.16.01.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 01:20:20 -0700 (PDT)
Message-ID: <fce70da5-d607-46b3-b462-caab0ae6234e@blackwall.org>
Date: Sun, 16 Aug 2026 11:20:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vxlan: mdb: Fix use-after-free in vxlan_mdb_flush()
Content-Language: en-US, bg
To: Baul Lee <baul.lee@xbow.com>, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: idosch@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 federico.kirschbaum@xbow.com
References: <20260814153547.29567-1-baul.lee@xbow.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260814153547.29567-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/08/2026 18:35, Baul Lee wrote:
> vxlan_mdb_flush() iterates over the MDB entries using
> hlist_for_each_entry_safe(), which only tolerates the removal of the
> current entry. Contrary to the comment above the loop, the removal of an
> entry can trigger the removal of another entry.
> 
> Flushing the remotes of a (*, G) entry also removes the (S, G) entries
> that were created for its source list, once they are left without
> remotes:
> 
> vxlan_mdb_remotes_flush()
> -> vxlan_mdb_remote_del()
>     -> vxlan_mdb_remote_srcs_del()
>        -> vxlan_mdb_remote_src_del()
>           -> vxlan_mdb_remote_src_fwd_del()
>              -> __vxlan_mdb_del()
>                 -> vxlan_mdb_entry_put()
> 
> Such an entry can be located after the (*, G) entry in the list, as
> vxlan_mdb_entry_get() returns an existing entry without moving it to the
> head of the list. This order is obtained by adding the (S, G) entry
> before the (*, G) entry, the latter with NLM_F_REPLACE, as the addition
> of the source otherwise fails with -EEXIST. The (S, G) entry is then the
> entry saved by hlist_for_each_entry_safe() and it is freed while the
> (*, G) entry is processed. The next iteration calls hlist_del() on it
> again, writing LIST_POISON1 to LIST_POISON2 [1].
> 
> Besides device deletion, the flush is also reachable from RTM_DELMDB
> with NLM_F_BULK.
> 
> Fix by re-reading the next entry after the remotes were flushed. The
> current entry cannot be removed by this flush, as source lists can only
> be configured on (*, G) entries and the removed entries are (S, G)
> entries. It is therefore still linked and its next pointer reflects the
> removals.
> 
> [1]
> BUG: KASAN: wild-memory-access in vxlan_mdb_entry_put.part.0+0x328/0x588
> Write of size 8 at addr dead000000000122 by task ip/327
> 
> CPU: 3 UID: 1000 PID: 327 Comm: ip Not tainted 7.2.0-rc7 #2 PREEMPT
> Call trace:
>   vxlan_mdb_entry_put.part.0+0x328/0x588
>   vxlan_mdb_flush+0x1d8/0x25c
>   vxlan_mdb_fini+0x8c/0x100
>   vxlan_uninit+0x1c/0x7c
>   unregister_netdevice_many_notify+0x954/0xd4c
>   rtnl_dellink+0x210/0x530
>   rtnetlink_rcv_msg+0x434/0x4d0
>   netlink_rcv_skb+0xc4/0x204
>   rtnetlink_rcv+0x18/0x24
>   netlink_unicast+0x4b8/0x548
>   netlink_sendmsg+0x29c/0x560
>   ____sys_sendmsg+0x390/0x3ec
>   ___sys_sendmsg+0x114/0x188
>   __sys_sendmsg+0xf0/0x178
>   __arm64_sys_sendmsg+0x48/0x60
>   invoke_syscall.constprop.0+0x58/0x180
>   el0_svc_common.constprop.0+0x74/0x140
>   do_el0_svc+0x30/0x40
>   el0_svc+0x38/0x98
>   el0t_64_sync_handler+0xa0/0xe4
>   el0t_64_sync+0x198/0x19c
> 
> Fixes: a3a48de5eade ("vxlan: mdb: Add MDB control path support")
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
>   drivers/net/vxlan/vxlan_mdb.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
> index 055a4969f593..385889c001d1 100644
> --- a/drivers/net/vxlan/vxlan_mdb.c
> +++ b/drivers/net/vxlan/vxlan_mdb.c
> @@ -1422,14 +1422,17 @@ static void vxlan_mdb_flush(struct vxlan_dev *vxlan,
>   	struct vxlan_mdb_entry *mdb_entry;
>   	struct hlist_node *tmp;
>   
> -	/* The removal of an entry cannot trigger the removal of another entry
> -	 * since entries are always added to the head of the list.
> -	 */
>   	hlist_for_each_entry_safe(mdb_entry, tmp, &vxlan->mdb_list, mdb_node) {
>   		if (desc->src_vni && desc->src_vni != mdb_entry->key.vni)
>   			continue;
>   
>   		vxlan_mdb_remotes_flush(vxlan, mdb_entry, desc);
> +		/* The flush can remove the (S, G) entries created for the
> +		 * source list of this entry, including the one saved by
> +		 * hlist_for_each_entry_safe(), so re-read it while this entry
> +		 * is still linked.
> +		 */
> +		tmp = mdb_entry->mdb_node.next;
>   		/* Entry will only be removed if its remotes list is empty. */
>   		vxlan_mdb_entry_put(vxlan, mdb_entry);
>   	}

The patch looks good to me, but I also think a selftest can be added.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



