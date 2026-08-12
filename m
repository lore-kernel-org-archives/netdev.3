Received: from mta0.migadu.com (out-191.mta0.migadu.com [91.218.175.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238E358399
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529159; cv=none; b=sflDt8lsYz1ccgUw6w2kRqUgMyjtaEitonf6KGkTJKWJn8y/88VsVxxbSulZYAeL8uQ8Wn4JlvizSchcBgPXQ/A4D1lRsmcD95+DWFSgFf0CpMUJVnAOn+2MvePg1QHflQYeJ2mVUgwk/D1sKfYdxXI/exVe3ixRX0P5wzCUwTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529159; c=relaxed/simple;
	bh=CZkiz6vLX+dQevDtX1mEJjBU1kNDEQ3un6l+FtA+J5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBrNhMP8xuyqUxD+KinLb7C08fQ54f2ZN0Zi7ocZIY/GYqejUvq4HojUFqo3A79NvDTVgtpKD3NzzxrjZfKvdhjdU/P652F7VhhlMUBt70UrtAVVlmth+EehAOprTpcb9BzZmm7PsFwf/h8qWChUkXr36//KsCdyv4asa6QkqUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RN84PRf9; arc=none smtp.client-ip=91.218.175.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RN84PRf9"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CZkiz6vLX+dQevDtX1mEJjBU1kNDEQ3un6l+FtA+J5w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786529155; v=1; x=1787133955;
 b=RN84PRf9eAvYFcBOtMdMHdZIgeXFCE6D5O+A4jjvrIfvje8P1lgll5D8hOpnyNKBO5KznZFG
 9604p4MWOjfRWLHNmIcOsik+j5jWNOm62jxeDt2hJAdh+t9/qNCixhbu6gRtWf1htWGhkisqo9h
 j1IJMrgne8HszaNoyPJp/Qes=
X-Envelope-To: netdev@vger.kernel.org
Received: from [IPV6:2a03:83e0:111e:2:c6:2f62:38ca:59d8] (2620:10d:c092:500::5:4188)
	by smtp.migadu.com with ESMTPS id 0bad5567c72d80c5;
	Wed, 12 Aug 2026 10:05:55 +0000
X-Migadu-Scanner: mta11.migadu.com
Authentication-Results: mta11.migadu.com;
	none
Message-ID: <7178de38-aede-48d2-b6d4-031ce09a21d1@linux.dev>
Date: Wed, 12 Aug 2026 11:05:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/3] dpll: zl3073x: scale poll interval
 proportionally to timeout
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Min Li <min.li@microchip.com>, Paolo Abeni <pabeni@redhat.com>,
 Petr Oros <poros@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20260811134700.1211010-1-ivecera@redhat.com>
 <20260811134700.1211010-2-ivecera@redhat.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260811134700.1211010-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2026 14:46, Ivan Vecera wrote:
> Replace the fixed 10 us poll sleep in zl3073x_poll_zero_u8() with
> timeout_us / 50, scaling the sleep interval proportionally to the
> timeout for all callers.
> 
> Testing showed that existing callers (mailbox, HWREG, DF read,
> frequency measurement and phase error polls with 25-50 ms timeouts)
> typically completed in low hundreds of sleep cycles with the fixed
> 10 us interval. With the scaled interval the cycle count drops to
> single digits. The longer PTP-related timeouts (up to 3000 ms for
> phase step) added in the following patches benefit most, avoiding
> on the order of 10^5 bus transactions per wait.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
> index 5b2d77f2c2288e..2e8b52c8de5e26 100644
> --- a/drivers/dpll/zl3073x/core.c
> +++ b/drivers/dpll/zl3073x/core.c
> @@ -322,7 +322,7 @@ int zl3073x_write_u48(struct zl3073x_dev *zldev, unsigned int reg, u64 val)
>   int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg,
>   			 u8 mask, unsigned int timeout_us)
>   {
> -#define ZL_POLL_SLEEP_US 10
> +	unsigned int sleep_us = timeout_us / 50;
>   	unsigned int val;
>   
>   	/* Check the register is 8bit */
> @@ -336,7 +336,7 @@ int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg,
>   	reg = ZL_REG_ADDR(reg) + ZL_RANGE_OFFSET;
>   
>   	return regmap_read_poll_timeout(zldev->regmap, reg, val, !(val & mask),
> -					ZL_POLL_SLEEP_US, timeout_us);
> +					sleep_us, timeout_us);
>   }
>   
>   int zl3073x_mb_op(struct zl3073x_dev *zldev, unsigned int op_reg, u8 op_val,

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
