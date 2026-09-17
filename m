Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6833970F;
	Thu, 17 Sep 2026 07:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629070; cv=none; b=LmBytPqrxxxy1mwIN+lgh0psFlT0jAAIrpetA6HNagXHP6I5eHS9LzBBxie1v/xGoxmOKpWiLDln/hy2qq3YXjVt0UzWVe20NK/Eg7Zb85iXifluZXV9C2IAV7rPhtjSO2PfsUw7zDemLbK9cU7n8k7wkZ15dgykk7bcDacP21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629070; c=relaxed/simple;
	bh=kduyFj4uA1YolZIh647fkGFe6s6EobSdPK3+l8qGZW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eudagFZ/k62dzKAGuo1NWAlqxd07eiMcrTVNkEPUOf7lUMoaEmHOT/8jc/IyhGcmdX8L5ijQemSl1IbUnMeXqjW0hXKGRMmZ2qo28EvJtz7GXpLqZrMnY1ALIfvBFQxHkDoaaPBewbJCizOCM9NrGF8XCY4+0iJ+/gkRHSBOhS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.b=Pt9a8Tz2; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.b="Pt9a8Tz2"
Received: from [192.168.2.217] (p5dc55dbb.dip0.t-ipconnect.de [93.197.93.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8E2E24C442F868;
	Thu, 17 Sep 2026 09:10:01 +0200 (CEST)
Message-ID: <7107796a-a233-4ddf-9106-460de575f29b@molgen.mpg.de>
Date: Thu, 17 Sep 2026 09:09:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2 1/2] ixgbe: do not busy wait in
 ixgbe_devlink_reload_empr_finish()
To: Linkui Xiao <xiaolinkui@126.com>, Linkui Xiao <xiaolinkui@kylinos.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jedrzej.jagielski@intel.com, kees@kernel.org, aleksandr.loktionov@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260917065436.1181073-1-xiaolinkui@126.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260917065436.1181073-1-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1789629003; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=hS+daQcmSuh57lLpq5vbnK6PgZknYEP3Fmnjb15/5kI=; 
	b=Pt9a8Tz2IF3GKh0P1Pq85zeCW6wCNSiaDvzR+1JrOinqC65iPGgmXZOI46eoxoIt0qmZLfD3KSkv
	/YB23ECsoufSGGvwEXOHn78OjfKpST/Nym61pwSOYCbL3Dd0TB+le0iSCZyVNTcFGAXMBrEAcZQtqn
	F1xlGfmr28897Zr2C5DSFicekSAFYf19fOpHjqNqx2g1/XCyqkPll1XpZpuf3C0SB+6bbXm/7kaFFv
	eGPeM5BOx4viNkfi1NbgH8vDYPRRh/3iWWsfwd7ZsL61K4MNNwKID2Pm71jcZ8+KzO2dSI8eQbB2jz
	eYxgvlENNX+CsSIxZ61pGYiRbPyI4mKQ==

Dear Linkui,


Thank you for your patch.

Am 17.09.26 um 08:54 schrieb Linkui Xiao:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> ixgbe_devlink_reload_empr_finish() is the .reload_up devlink operation,
> so it always runs in process context with the devlink instance lock held.
> Its polling loop delays with mdelay(500), i.e. it spins the CPU for half
> a second per iteration and, because the loop bound is 20 iterations, for
> up to ten seconds. That keeps a CPU fully occupied while the firmware
> performs the EMP reset, and on CONFIG_PREEMPT_NONE it also makes the
> loop non-preemptible for that whole window. The loop does not need to be
> atomic and holds no spinlock.
> 
> Use msleep() instead.

Should you resend, please document the commands how to test this, for 
example, how to trigger .reload.

> Fixes: c9e563cae19e ("ixgbe: add support for devlink reload")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> v1:https://lore.kernel.org/all/20260914092626.263886-1-xiaolinkui@126.com/
> 
> v2:
>    - Reworded the commit message: mdelay() does not mask interrupts or
>      disable preemption, and the ~10 s window is below the soft lockup /
>      RCU stall thresholds.  State the actual rationale instead.
>    - Split the macro rename into a separate patch.
>    - The mdelay() -> msleep() change itself is unchanged, so the
>      Reviewed-by tag is kept.
> 
>   drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> index cf8908b82f8a..781f13240a0d 100644
> --- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> @@ -460,7 +460,7 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
>   		 * may be not cleared yet, so begin the loop with the delay
>   		 * in order to not check the not updated register.
>   		 */
> -		mdelay(500);
> +		msleep(500);
>   
>   		fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));


Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
