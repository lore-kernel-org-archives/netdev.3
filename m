Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE62B3C3F4E;
	Thu,  8 Oct 2026 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791484361; cv=none; b=W8r1uUF7MonA6CiQz4JfVcCXPdS/uUGBoRnZOMOztixCX/bUnsmOUX7klQqv8FHGxP1MD4uYH3VBGDEMjLbCySUMnhcbb58+VS/0X1ryM2xYgUZSav48BAPLbAlj5mkJ/ETINzw7bKgjKsl3+7TafONzDlxwrtpMj+XiQmx7mVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791484361; c=relaxed/simple;
	bh=SRpyipBgTY7eOSwL+Fm3m6DKRCc4kSXZb3lbXGp2m90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8PYck8T9GgPIZA4RL4/6fdRHZC5+4VZolLRgPdrfVrkLcb10olhjiwEGsKTubyMxOOFVO98B3UDy2km4ye5IERN/bd0jDIITwjZgZcQ26wpQ+26aSkTTIlwp9y/1UCGLliRWAGADuA854g+9+3fjjMtIAUdQHsktIN8Sh8VOzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.b=D08YY8lU; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.b="D08YY8lU"
Received: from [192.168.0.150] (ip-095-090-241-211.vkd79.pools.vodafone-ip.de [95.90.241.211])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 04E314C442F941;
	Thu, 08 Oct 2026 20:31:37 +0200 (CEST)
Message-ID: <07ee6c66-034d-4cea-bce9-91c63a1aea86@molgen.mpg.de>
Date: Thu, 8 Oct 2026 20:31:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-net PATCH] idpf: wait for the reset completed state in
 idpf_check_reset_complete()
To: Brian Vazquez <brianvv@google.com>,
 Brian Vazquez <brianvv.kernel@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Madhu Chittim <madhu.chittim@intel.com>,
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>,
 Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 linux-kernel@vger.kernel.org, David Decotigny <decot@google.com>,
 Li Li <boolli@google.com>, Emil Tantilov <emil.s.tantilov@intel.com>
References: <20261008173334.2881475-1-brianvv@google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20261008173334.2881475-1-brianvv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1791484297; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=yVP7nsKdhF71GwWHA3GbXkemcPwhdJ4dqV5UW32uEtI=; 
	b=D08YY8lU1Jh4VjomGE1Py45b4kGOPmalwHrDgeqM0me/JLsVy00EsMZ3eNOpyae2N5HmBetyHo0N
	WqQESdogj92USlgSlHjmoaFCIVgQ6B8ydEi4WLqStyidIvxqj+Bu0xbN3Z+r+vlX6aOczm8SYrgk0n
	IKCa5KJ6425UC3ihFkTUAvMC1dChKVO/hhljARB13/c2UOs6CheAK8HoRPO2g/yhoLI/+UgcQVwNxo
	Oauw+K+4KZWIl2r/OdO+g6GgFzeV6ATHTXw6nggF9F8YIUSWxUavePbEoQtDe1PWY2H1uZJBiLi2pB
	S8dB6JCKVAkfh9G4kM9Dlm1cM6KiFvKg==

Dear Brian,


Thank you for your patch.

Am 08.10.26 um 19:33 schrieb Brian Vazquez:
> PFGEN_RSTAT[1:0] / VFGEN_RSTAT[1:0] (PFR_STATE / VFR_STATE) encode the
> function reset progress as a 2-bit state, not a flag:
> 
>    00b - reset in progress
>    01b - reset completed, written by the control plane
>    10b - function active, written by the control plane once the function
>          has completed VIRTCHNL2_OP_VERSION
>    11b - reserved

For me it’d be helpful if you mentioned the datasheet.

> idpf_check_reset_complete() tests (reg_val & rstat_m) as a boolean, with
> rstat_m = GENMASK(1, 0), so any non-zero state is taken as "completed",
> although only 01b carries that meaning.
> 
> That only works if hardware moves the field to 00b as soon as the reset
> is triggered. On the devices tested it does not: PFSWR transitions
> PFR_STATE to 00b only when the field currently reads 01b. When the
> function is active (10b) the field keeps its value until the control
> plane finishes the reset and writes 01b, which takes a few hundred
> milliseconds.

Please mention the device, so it’s easier to reproduce. Also, the 
command to trigger the reset.

> Consequently, on a hard reset of an active function
> (IDPF_HR_FUNC_RESET) the first poll sees 10b, returns immediately, the
> driver re-creates the mailbox and sends VIRTCHNL2_OP_VERSION while the
> reset is still being processed. The control plane tears the mailbox
> down underneath it, VERSION is never answered, and the driver sits in a
> 60 second virtchnl timeout (-ETIME) before going through a second hard
> reset which then succeeds.
> 
> Make idpf_check_reset_complete() wait for the state to be exactly 01b.
> This is the stricter reading of the register definition and it does not
> depend on how the field got to its current value: functions that are
> still in progress (00b) or active (10b) keep polling until the control
> plane reports completion.
> 
> Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
> Signed-off-by: Brian Vazquez <brianvv@google.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf.h     | 2 ++
>   drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 ++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index 470bc23c844c..ce8a1bd0ec8b 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -166,6 +166,8 @@ struct idpf_netdev_priv {
>   	spinlock_t stats_lock;
>   };
>   
> +#define IDPF_RSTAT_COMPLETE		0x01
> +
>   /**
>    * struct idpf_reset_reg - Reset register offsets/masks
>    * @rstat: Reset status register
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 2c148377540c..a827e0fa67c8 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1870,7 +1870,8 @@ static int idpf_check_reset_complete(struct idpf_adapter *adapter,
>   		 * register for us yet and 0xFFFFFFFF is not a valid value for
>   		 * the register, so treat that as invalid.
>   		 */
> -		if (reg_val != 0xFFFFFFFF && (reg_val & reset_reg->rstat_m))
> +		if (reg_val != 0xFFFFFFFF &&
> +		    (reg_val & reset_reg->rstat_m) == IDPF_RSTAT_COMPLETE)
>   			return 0;
>   
>   		usleep_range(5000, 10000);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
