Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD0F3BB11B
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784622175; cv=none; b=giqPD/T3eXLvMqaNfg6VQAsLJFnajPckmWXjOeFO5KQlSBxq43GLEZTN3Xhtnn9ES9UlOPvoo+SIOLBQvBdaGkzEfujNafxsPTBls3TlZOW8q0TUCPGsmI+0jg2gf9X4Sb3GhUxpV8A7SpHEhbSq3BaKo+DnNkNkPy99ZpjPtgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784622175; c=relaxed/simple;
	bh=o5j77Bq0MP3FonEGQB6VnHbhGzvDr0LlTWGrk9yAIWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cj+aM5pusVouWYZruOsFn6fVz9v/jtI5/H35An+tMtZBi0iGyOAHdliZ+W1EF8YojsubiLOY0fuQxXxG2odgwqWuDxxSBGVb38sTN103F39MG06A1TBSzeruBW1MZWwslkA0JkBqZM8pwubtxaGsd8dBKL0S0YygavmwvjGPK2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=PMtraDXE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="PMtraDXE"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493f75f7172so86454205e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784622171; x=1785226971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HZLBncTezuOyuzKSD4158HItl5HxfBAC2WajnXsaibo=;
        b=PMtraDXE1EGOYMbBzo4e/B8Dard32OvkCqxol4pW4vA74fFau0SEIy3D7kH/aZwXkf
         XeQxU1dBlFj/mp238o4y3VT3aRyfvFuoXpTEowKw+FiBRKtZSjLX0PTk2rFOkgWOxjiZ
         OyFZYlRRyCB/7Y3ObKQmFDIOZBXLd2p/JDtxKtaojb4jGjH/B/aiokI7dNXFpG4RR78S
         WutbXGMht5+6ZssxCeHQ//7AF52Y1Gdkhyt5+5nAoZAiiRl5pNGH6HHgbsCCqDHYT08s
         LQcSCWPnyOlLnAko2LOxyj9htS+l6e8hbwLj3WqkSjLr1P4bHaJ6JWi0Opk7pa4FE0C1
         feAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784622171; x=1785226971;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HZLBncTezuOyuzKSD4158HItl5HxfBAC2WajnXsaibo=;
        b=KGHGlPWawyNrpe0PDT0ZpB7ZLJ6A2OSkFf4yySXnICqrkkrDGBa5wLwQK6FHf/Eb2s
         PpzMbJSOivyGuKIMK+q/r0yuMJZ3WPWd/4kCKSVn61Z/H0On1ImytZksDUN0rKujwIQO
         C4SiuQjvj5mAo36kzmWkceqCC2khIf0nW0TbgI+lQu9j3o00dr5Gb69omJtFH/orwIVZ
         mvMUamow36ciF74WQArhLvKeBYtxWf6IRkwKssJa40vsNJkl42aPTgsULbvgFOAA098W
         TepAdRmw5PnqtiuhDTyq8sRA3z8ETWQP6Q/OD4h35V/UWFHN5WqeZlYcJFjH/pW/U3ca
         2JcA==
X-Gm-Message-State: AOJu0YxK0rWhuVnF1eF87ZPW7TPuz7F6dVz3E3tWavsu6ATAilBXJoUr
	vDUscCSQTLVAW1rl4464D3EtKPxf2sxhj28Wcn1GjMfDtaa+jPo+BISYhdRY2XyNURw=
X-Gm-Gg: AfdE7clPagYMER8a1n+zknD+TTld3USYkt16nQQtnsrU3QHj8w4DzEQQrwFDNRbztxT
	QxnVgMhOIgd8FmNqMRdNjGsJpXzyni6o3AUtPpeKCBFi3jcZ8/SiIUz/z1l1OE4IbftzomrbdPF
	webODrI0ANoKtg8f5fNh65MLlSfXNE9p5+qPC98IC+C9Az3NV380TwU4ysKqH41DfYjwDHOV/oE
	pxW4MD1FdH3MSQRQ+jjC8+ALphLH54CrYeJ2FKWUCA4gfFHnI1AlH3RCe8/9zzouBimzoWK/vSx
	sfRgoXc/pPLII/U2/CLa8fAxfZ7aO4yYg+pTeVnIw4+r1gQiZqzi2Ch9BskgjT4nMFfXNMrVRuY
	9xX0lwRrkz4GODEjHVXylyUNHyzElHo6jY1eaVZ0ISXgQoJD1UZzTvOqhFe8/S70BPGC771jjMK
	UmICYZyRiWJAwGydWxcy6f1ABD/5yQQd16
X-Received: by 2002:a05:600c:4e94:b0:495:571e:e5d3 with SMTP id 5b1f17b1804b1-495571ee75fmr120630625e9.36.1784622171154;
        Tue, 21 Jul 2026 01:22:51 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956547af7esm57940625e9.8.2026.07.21.01.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 01:22:50 -0700 (PDT)
Message-ID: <55429a5a-c9c9-4cbe-850a-ae983674df02@blackwall.org>
Date: Tue, 21 Jul 2026 11:22:48 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bonding: alb: re-check primary_is_promisc under RTNL
 in bond_alb_monitor
Content-Language: en-US, bg
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com
References: <20260720223400.1939998-1-xmei5@asu.edu>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260720223400.1939998-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/07/2026 01:34, Xiang Mei (Microsoft) wrote:
> bond_alb_monitor() reads primary_is_promisc under RCU, then drops RCU and
> takes RTNL via rtnl_trylock() before undoing the promiscuity it set on the
> active slave. In that window the active slave can change under RTNL
> (RTM_DELLINK -> __bond_release_one() -> bond_alb_handle_active_change()),
> which already drops the promiscuity and clears primary_is_promisc. The
> monitor still acts on the stale decision: if the slave was removed with no
> failover, curr_active_slave is now NULL and the deref faults; if it failed
> over, the stale dev_set_promiscuity(-1) underflows the new slave's
> promiscuity counter and pins it in IFF_PROMISC.
> 
>    Oops: general protection fault, probably for non-canonical address ...
>    KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>    Workqueue: b42 bond_alb_monitor
>    RIP: 0010:bond_alb_monitor (drivers/net/bonding/bond_alb.c:1600)
>     process_one_work (kernel/workqueue.c:3322)
>     worker_thread (kernel/workqueue.c:3486)
>     kthread (kernel/kthread.c:436)
>     ret_from_fork (arch/x86/kernel/process.c:158)
>    Kernel panic - not syncing: Fatal exception
> 
> Re-check primary_is_promisc (and curr_active_slave) after taking RTNL so
> the monitor only undoes an increment it still owns. The other bonding
> monitors already re-read state under RTNL in their commit phase
> (bond_miimon_commit/bond_ab_arp_commit); bond_alb_monitor() was the only
> one acting on the pre-trylock decision.
> 
> Fixes: d0e81b7e2246 ("bonding: Acquire correct locks in alb for promisc change")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> ---
>   drivers/net/bonding/bond_alb.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index 2d37b07c8215..70458c5b23cc 100644
> --- a/drivers/net/bonding/bond_alb.c
> +++ b/drivers/net/bonding/bond_alb.c
> @@ -1535,7 +1535,7 @@ void bond_alb_monitor(struct work_struct *work)
>   					    alb_work.work);
>   	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
>   	struct list_head *iter;
> -	struct slave *slave;
> +	struct slave *slave, *curr;

please move this up to keep the reverse xmas tree ordering

>   
>   	if (!bond_has_slaves(bond)) {
>   		atomic_set(&bond_info->tx_rebalance_counter, 0);
> @@ -1597,9 +1597,11 @@ void bond_alb_monitor(struct work_struct *work)
>   			 * because a slave was disabled then
>   			 * it can now leave promiscuous mode.
>   			 */
> -			dev_set_promiscuity(rtnl_dereference(bond->curr_active_slave)->dev,
> -					    -1);
> -			bond_info->primary_is_promisc = 0;
> +			curr = rtnl_dereference(bond->curr_active_slave);
> +			if (bond_info->primary_is_promisc && curr) {
> +				dev_set_promiscuity(curr->dev, -1);
> +				bond_info->primary_is_promisc = 0;
> +			}
>   
>   			rtnl_unlock();
>   			rcu_read_lock();

