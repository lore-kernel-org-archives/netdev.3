Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8801038E13F
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334845; cv=none; b=gHSbwLpoCUCoKkP1GIzdczerhryyRHcPR923ySixbQtSBmcITiVwcpBQZc2XrrvSiEKx1Kyx8GOQCV3l2r5RbLoNPvov64ZNJqDKs6mWm+dMmPhcQXj3WQy3Ci/4DQ4kDt81W1pdVz35kIapPF94w0JMSklXiZDuH7ExZ7s1lOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334845; c=relaxed/simple;
	bh=sCTvzwMNeW7mLvozVZaAsW2ArPVwb4hUthriXKM9Peo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRKyYL5GkAjiZZNqL/a7GMMONcbNgQQG//7cgttCxBnhTdpXFYRuw6rBKlwac70CdfQSuqPnSy0RBPzZG6CZBQKPhFkI+FLO94UF00wvmmvoNi/3lvcqgnj7DUyOgJsIcGQHoToPFKOR4ITDMmjoG6KC/a0Bp3UJGtxeLi3u4O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mo0Z1iNv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="mo0Z1iNv"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso5092525e9.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 00:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788334842; x=1788939642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oUZ3VgmGI1wTXcVPmH/fxu4IpXzRuDeGuD61FDWbZHI=;
        b=mo0Z1iNvHkW0Uwl9rBWEbzJDfVy6HrlXJd/FNOriKMgmjIDIjGnfH9R2IIEM1vHM1u
         VtqTDdcqBK0baJ0d5S4XSa9StyPYCLEzaYSeP9CLbRN16U4AQq67rx+7QRIh6GfaD3eJ
         TzXEv5sp20VrtWT3yjSs27oBe8WK8rjwSwjba+uUxzXZGAgwU10DnthTLRGOfyEl1wOG
         GaWCgbtRA+xiYSabdBoSKPqzFp54urAYD1mrenM/d73n2tTAA0v3jCAGdoqZTQBwMTWw
         qfdJjOD3LUNkwDC8vHEWsrXfBIvsgS4w6vQEPOc4P3g/kJJ+cIEdjB7A59UMc/smnkCK
         RRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334842; x=1788939642;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oUZ3VgmGI1wTXcVPmH/fxu4IpXzRuDeGuD61FDWbZHI=;
        b=H0XpL3WbXs5PKu0HtZ8oJ4AMwZMrXtjbPFe/YsNkiNRBeLoR3Q3NF+O6ESrCgo0k0Y
         SLVPcx/PIkACMJDHsR735b82kKOqaPXhs/4+juiGLGC+og9nFkFHr8QKHgqUkiWnchxq
         ADGwTlMeXflqDTULCoZQNFAdzTXzduCKHSliMUo/pbFBTDzaQOKo67Nw43XIrTuVKyE6
         /64FgsgEsH3XGKO6W7sRwiSyozPJYFj4w4yMDSyqwU/wOlKtlN1Uf99ZTXMgVIo0qTbM
         KyGLbjUEY9hnG0wgoID0jwY/OQoeWvL6Z0gYkxTp9VneZ3Wipi4Lc1QYHw14OrodQBY8
         mudw==
X-Forwarded-Encrypted: i=1; AHgh+RrsFdF/8zN3zZH07Hfn/tmxL6gVYIvNZ7wprG++9sUlKHaMGszm408dDYn3teLr+6a07bENNTI=@vger.kernel.org
X-Gm-Message-State: AFuF++lWatBfxgsCvLJK/z60JgqI9R7Ed5anMAVcGwkoIl2DjeLqS8xQ
	p8zVzS++Vgi3VHh3VMTOXFwuCVQ+c5FcQJToQveL8VpSYQjfqR4oFUqP4KUAXUki/k4=
X-Gm-Gg: AR+sD11HytETfVXGnp5kqVEUBRgcJPqvhmahFrgFNmAsRCluw0sHKhMcszOrAOnrE29
	POd4qIlJX/PDEevhzX1s2NzBO+r5o6JmAjmnE1uHUpZqBe8PuSvvUNF3p7fJpYUD+o4hjMCTBTV
	XVPcOIx4eAN38O9A3QVWhKaDlwUA9VLDCfoNtyJvk5AV6Yz1Wg1FZlVsX53X8V2vNSRRNo54bzK
	meATGIPJtTATGAkvwFEIzZ6O02YFEiHWfV519JZWGLUCYnldJWAzdmazZ+QXHZu+ki+OmCDEezX
	oivESA6EBUr26Tt5GCzeNedaku+SRuYxiB2rYExGsnV7o5x8blkqm6dhbZ8kp35mKXaq71nSgIV
	9bu52dPpOJd1hxX+uWEWaQZ7aNUz4b51uO+xBSMjFg375fqQOfokVRTj0tpBy97rJhvDIz/vi1T
	TRFZB7C9M00eHNHLEk56mLkfEqwUF9askouuoG9vClYXxTp2cGEW88LiwLWVQ86Q0X2zFk/t/Jh
	sGcmTsq6nRQ1C73cDI=
X-Received: by 2002:a05:600c:a417:b0:49c:eb04:1c49 with SMTP id 5b1f17b1804b1-49ceb041c7bmr1035545e9.13.1788334841462;
        Wed, 02 Sep 2026 00:40:41 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce10148sm126778715e9.5.2026.09.02.00.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 00:40:40 -0700 (PDT)
Message-ID: <359ae5cb-af14-457e-995f-bc03422150fb@blackwall.org>
Date: Wed, 2 Sep 2026 10:40:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bonding: do not clear curr_active_slave prematurely
 when releasing all slaves
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Jay Vosburgh <jv@jvosburgh.net>
References: <20260831203042.164466-1-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260831203042.164466-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 23:30, Eric Dumazet wrote:
> When releasing all slaves during bond destruction (all == true),
> __bond_release_one() unconditionally clears bond->curr_active_slave to
> NULL in every iteration.
> 
> If a backup slave is released before the active slave,
> bond_alb_deinit_slave() triggers rlb_teach_disabled_mac_on_primary(),
> which increments the active slave dev promiscuity counter and sets
> bond_info->primary_is_promisc = 1.
> 
> Because bond->curr_active_slave was prematurely cleared to NULL when
> releasing the backup slave, the subsequent iteration releasing the active
> slave evaluates oldcurrent as NULL, so bond_change_active_slave(bond, NULL)
> is skipped. Consequently, bond_alb_handle_active_change() is never called
> to decrement the promiscuity counter, permanently leaking promiscuous
> mode on the physical device after bond teardown.
> 
> When oldcurrent == slave, bond_change_active_slave(bond, NULL) already sets
> bond->curr_active_slave to NULL. We only need to avoid selecting a new
> active slave when all == true. Replace the if (all) branch with
> if (!all && oldcurrent == slave).
> 
> Fixes: 0896341a44bf ("bonding: fix bond_release_all inconsistencies")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> ---
>   drivers/net/bonding/bond_main.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index c23cf18a996a..1e5ab3454872 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2517,9 +2517,7 @@ static int __bond_release_one(struct net_device *bond_dev,
>   		bond_alb_deinit_slave(bond, slave);
>   	}
>   
> -	if (all) {
> -		RCU_INIT_POINTER(bond->curr_active_slave, NULL);
> -	} else if (oldcurrent == slave) {
> +	if (!all && oldcurrent == slave) {
>   		/* Note that we hold RTNL over this sequence, so there
>   		 * is no concern that another slave add/remove event
>   		 * will interfere.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
