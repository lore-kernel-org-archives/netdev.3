Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16414A689C;
	Thu, 17 Sep 2026 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643667; cv=none; b=lSMMsivScx6joBPQh43dBYt7gkHhZBMIelROx2S+626w8AQkiMv4UXbs+wdHwS2xB6wPuj3MU/jJpK5i2pGbuQB4Cm4Q8BNMZrN3mjCp1CWRmBGUnlN4RGIGOV0aOQ6kXjwfp9/pfxwxzzM9KkYxrZqAZ1oMxQOKdEFHqD3bE6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643667; c=relaxed/simple;
	bh=Eh1kp7Vh9u2XwfP67rB8hZGCjl701FbziCDAThPuEg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jI1ZW7ElEL4RRTq9c0P5x33YDmAsNgkAHUkuSfut4psrsf2/td6UE5kHvf13JnVsAQvnPp1bD0MsD/3OcrRDhNdRgo3qq4ZRYqeyvF6rqoz3KuQqzGlLDPcrkcp8YAphUEBgvZsmlxDzxmq+X3zWgM/oChQJMlWa6deWCpApI0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=KgxfjJ+i; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="KgxfjJ+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=ugkZvHY8M4baNm0OaUOuPZx4bPzR30VWOKhrqoA5hX0=;
	b=KgxfjJ+iEtCX4qom4lWLCyTIaSTYcPC9+BlixsqhbCdTu/CD6kmAkeXuFiPd7h
	MT8pi2rch9R1FnlLOrRhroD3sMYjHiaHTNDdam/WauIXrUCzroGVBckyHjp9x5cr
	NNuDJbrLFwf3/16EuLO3aQSlZ8Fm2Un4aCKUXAyFBBhtA=
Message-ID: <44959d96-2572-4dd7-a79b-493110cc002e@126.com>
Date: Thu, 17 Sep 2026 19:13:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2 1/2] ixgbe: do not busy wait in
 ixgbe_devlink_reload_empr_finish()
To: Paul Menzel <pmenzel@molgen.mpg.de>, Linkui Xiao <xiaolinkui@kylinos.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jedrzej.jagielski@intel.com, kees@kernel.org, aleksandr.loktionov@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260917065436.1181073-1-xiaolinkui@126.com>
 <7107796a-a233-4ddf-9106-460de575f29b@molgen.mpg.de>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <7107796a-a233-4ddf-9106-460de575f29b@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PikvCgD3v5xBy6tqbW4wIA--.23370S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr4UtF43tr1rGw1kAw48Xrb_yoW5Ar4DpF
	WUWFn8Aws7Xr1Fg34Iva18ZasIva1Ig3yYgFyftrZ8Zas5Arn8tr1Utr4Sg348Zrs8Ww10
	vF4Y9rs3AF45AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZeOXUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqAKIX2qry0JfIgAA3I



On 2026/9/17 15:09, Paul Menzel wrote:
> Dear Linkui,
> 
> 
> Thank you for your patch.
> 
> Am 17.09.26 um 08:54 schrieb Linkui Xiao:
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> ixgbe_devlink_reload_empr_finish() is the .reload_up devlink operation,
>> so it always runs in process context with the devlink instance lock held.
>> Its polling loop delays with mdelay(500), i.e. it spins the CPU for half
>> a second per iteration and, because the loop bound is 20 iterations, for
>> up to ten seconds. That keeps a CPU fully occupied while the firmware
>> performs the EMP reset, and on CONFIG_PREEMPT_NONE it also makes the
>> loop non-preemptible for that whole window. The loop does not need to be
>> atomic and holds no spinlock.
>>
>> Use msleep() instead.
> 
> Should you resend, please document the commands how to test this, for 
> example, how to trigger .reload.
Hi Paul,

Thanks for the review and the Reviewed-by.

I don't have an E610 adapter available to actually exercise the devlink
reload path, so I can't provide a tested-by or a verified test log. The
change is a mechanical mdelay() -> msleep() conversion in a sleepable
process-context loop; the rationale stands on its own, but I understand
if you'd prefer to wait for someone with the hardware to run it.

If you'd still like the test commands documented for reference, I can
add them to the changelog, but I want to be clear that I have not run
them myself.

Thanks,
Linkui
> 
>> Fixes: c9e563cae19e ("ixgbe: add support for devlink reload")
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
>> ---
>> v1:https://lore.kernel.org/all/20260914092626.263886-1-xiaolinkui@126.com/
>>
>> v2:
>>    - Reworded the commit message: mdelay() does not mask interrupts or
>>      disable preemption, and the ~10 s window is below the soft lockup /
>>      RCU stall thresholds.  State the actual rationale instead.
>>    - Split the macro rename into a separate patch.
>>    - The mdelay() -> msleep() change itself is unchanged, so the
>>      Reviewed-by tag is kept.
>>
>>   drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c 
>> b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
>> index cf8908b82f8a..781f13240a0d 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
>> @@ -460,7 +460,7 @@ static int ixgbe_devlink_reload_empr_finish(struct 
>> devlink *devlink,
>>            * may be not cleared yet, so begin the loop with the delay
>>            * in order to not check the not updated register.
>>            */
>> -        mdelay(500);
>> +        msleep(500);
>>           fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
> 
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul

