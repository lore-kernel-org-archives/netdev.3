Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476773B47C9;
	Mon, 27 Apr 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284849; cv=none; b=ce3FuO7rVVxXE4/K17xaLaHseutW7Z3G3MdS+AIG6r9FwnvKnZ1IJwT0rZElQkm+Vbw22M/Elh9FrqdKN69JoC6ZGyOS/Ev4mhJYXi6z70iMo8KXQUfWTTbQd08mboWKDSSNwhfWFZZQH/cQynU3GfjHHz7rTtW8Cs3MAe7mYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284849; c=relaxed/simple;
	bh=UzA5WMzcWv2xbAxpYjnWf1tULuDCSUF4xceawOiR1fY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtPq1fzJkRpL5m7jowKXH9lka0Vxx2RpazFbSlq+3TP736FN5xA9+FMGPaTsoqPFTVB03bn653ctZ7GMJ/O+UxdF5DXbHmH5k0ur2WivEAcbTOQkIrr3OX9pWg9jNmzgoenzllbTIAybgKMh38u8lFagTt6iROMfOBzUMGVrH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 478B74C2C37D59;
	Mon, 27 Apr 2026 12:13:05 +0200 (CEST)
Message-ID: <0d1ef57c-7ab6-4ed1-bc11-323aeeb12eac@molgen.mpg.de>
Date: Mon, 27 Apr 2026 12:13:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2] ice: wait for reset completion in
 ice_resume()
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akeem G Abodunrin <akeem.g.abodunrin@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 intel-wired-lan@lists.osuosl.org, Kohei Enju <kohei@enjuk.jp>
References: <20260424030345.1140665-1-aaron.ma@canonical.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260424030345.1140665-1-aaron.ma@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Aaron,


Thank you for your patch.

Am 24.04.26 um 05:03 schrieb Aaron Ma via Intel-wired-lan:
> ice_resume() schedules an asynchronous PF reset and returns
> immediately. The reset runs later in ice_service_task(). If
> userspace tries to bring up the net device before the reset
> finishes, ice_open() fails with -EBUSY:
> 
>    ice_resume()
>      ice_schedule_reset()          # sets ICE_PFR_REQ, returns
>    ...
>    ice_open()
>      ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
>    ...
>    ice_service_task()
>      ice_do_reset()
>        ice_rebuild()               # clears ICE_PFR_REQ, too late
> 
> Reproduced on E800 series NICs during suspend/resume with irdma
> enabled, where the aux device probe widens the race window.

Please document, how you reproduced it, and also paste possible messages 
by Linux or NetworkManager, so that people can easily search for the commit.

> Wait for the reset to complete before returning from ice_resume().

Please mention the delay length in the commit message.

> Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> v2: reword comment to clarify best-effort semantics (Kohei Enju)
> 
>   drivers/net/ethernet/intel/ice/ice_main.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 5f92377d4dfc2..a81eb21ea87c1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5635,6 +5635,15 @@ static int ice_resume(struct device *dev)
>   	/* Restart the service task */
>   	mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_period));
>   
> +	/* Best-effort wait for the scheduled reset to finish so that the
> +	 * device is operational before returning. Without this, userspace
> +	 * (e.g. NetworkManager) may try to open the net device while the
> +	 * asynchronous reset is still in progress, hitting -EBUSY.
> +	 */
> +	ret = ice_wait_for_reset(pf, 10 * HZ);

Why not pass a delay in micro/milliseconds?

> +	if (ret)
> +		dev_err(dev, "Wait for reset failed during resume: %d\n", ret);

Mention the delay?

> +
>   	return 0;
>   }
>   


Kind regards,

Paul
