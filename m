Received: from mta1.migadu.com (out-219.mta1.migadu.com [95.215.58.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2602DCC13
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908219; cv=none; b=k5egFLw3+EadTVlsFl1yV1cLr+RH7e5dRtEvofhZMFXIGIxWFW2taR91sY5I5KZHFyfw7/aSKehSMO5iPahlgkORVufLsuLaWoLVUKpEE4nmPFDmAMqRL2MODR85UR1bhTPhxnT4jWxGcfbRIJ04CFNwnouXwMt79SFnqcL3Nwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908219; c=relaxed/simple;
	bh=NQQjSsx7MDadVDc7TngFEjnUA3fUDa8WYM/oWjHn/5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICgnokT6+04LRU0v/FTYdoZIdOebrHdZGvBiO39lYi/rJWIo+UNLL7/uhuPSLTyoimGJDM/ysdqIcUSOoSq6Qg7eL8Kt0A8ADN5SSHJytPVN7Tn3qKAFMMA9dmq23acPiP4fhE2klJtDhPDbHOwqLOWBXvxRi+s+hVL85vAphX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C7FFUdrc; arc=none smtp.client-ip=95.215.58.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C7FFUdrc"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NQQjSsx7MDadVDc7TngFEjnUA3fUDa8WYM/oWjHn/5c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787908211; v=1; x=1788513011;
 b=C7FFUdrclWIjlGAUHNO2RFOoZppux97O+f2i75p3h7hbmPKv9Z/2AsTmW9+p9juelQiTTfp5
 qw54w2ZZ8qY5D/rqk6pN05UBdkxw0OkbhR04Io7sdCcsjbMxIDoI6/Dmgf46ebfxPpL2tCnAaPZ
 MEVtvYURXC8ohQl6eq/p94Ew=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 17eb4ab48f81af9e;
	Fri, 28 Aug 2026 09:10:07 +0000
X-Mizu-Trace-ID: 17eb4ab48f81af9e
X-Migadu-Flow: FLOW_OUT
Message-ID: <ddc21a8e-b2dc-41a7-8390-5642664f08ea@linux.dev>
Date: Fri, 28 Aug 2026 10:10:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] iavf: add missing PTP adjustment callbacks
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>, netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, richardcochran@gmail.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, ahmed.zaki@intel.com,
 mateusz.polchlopek@intel.com, saikrishnag@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 stable@vger.kernel.org
References: <20260828015837.2759-1-xuanqiang.luo@linux.dev>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260828015837.2759-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/08/2026 02:58, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> The PTP hardware clock documentation requires drivers to implement all
> callbacks and return -EOPNOTSUPP for unsupported features.
> 
> The iavf driver registers a PHC without adjtime or adjfine callbacks.
> A userspace clock_adjtime(2) request reaches ptp_clock_adjtime(), where
> ADJ_SETOFFSET calls adjtime and ADJ_FREQUENCY calls adjfine. The missing
> callbacks can therefore cause a NULL dereference.
> 
> Provide both callbacks and return -EOPNOTSUPP for the unsupported
> operations.
> 
> Fixes: d734223b2f0d ("iavf: add initial framework for registering PTP clock")
> Link: https://docs.kernel.org/driver-api/ptp.html#writing-clock-drivers
> Link: https://lore.kernel.org/all/20260826101004.100979-1-xuanqiang.luo@linux.dev/
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>   drivers/net/ethernet/intel/iavf/iavf_ptp.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> index 87b97e09df14a..fcb273828bc1b 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
> @@ -252,6 +252,16 @@ static int iavf_ptp_gettimex64(struct ptp_clock_info *info,
>   	return iavf_read_phc_indirect(adapter, ts, sts);
>   }
>   
> +static int iavf_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int iavf_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static int iavf_ptp_settime64(struct ptp_clock_info *info,
>   			      const struct timespec64 *ts)
>   {
> @@ -326,6 +336,8 @@ static int iavf_ptp_register_clock(struct iavf_adapter *adapter)
>   		 KBUILD_MODNAME, dev_name(dev));
>   	ptp_info->owner = THIS_MODULE;
>   	ptp_info->gettimex64 = iavf_ptp_gettimex64;
> +	ptp_info->adjfine = iavf_ptp_adjfine;
> +	ptp_info->adjtime = iavf_ptp_adjtime;
>   	ptp_info->settime64 = iavf_ptp_settime64;
>   	ptp_info->do_aux_work = iavf_ptp_do_aux_work;
>   
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
