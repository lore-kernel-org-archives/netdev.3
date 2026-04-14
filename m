Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D23033D6
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188785; cv=none; b=YS1fCpZ8G3BRh88ZuhPgGb+dapjq7534Oufq0gqLs2liYcfiV0T8ga/IhDapkpDqNHmqUze5xiLdTbePPX6pDNxckmsaluIL8Exkgo6+Mkbn6vWXggN+5yApzVsZR7WqLlMOG5vxEbRiIqhdYiiiuKbkMssDfumlwcZUP3FBdt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188785; c=relaxed/simple;
	bh=xmt7s/twQSu4aPxzKgIdkdZzdmbSv5AWDgrjt5WYi8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAEC1X8WzY/0CYIwzAT6kWfrjFOy6Yv+6pPFT2f6gTDhWfYl4XXLzoSwnZ/8P1rJl6GhELNnHc1Sqbz3jFQXf4u81wK+NQ9FS7GgFSTqY9aChawnNPnaoukD7NQwCXfqf/5l9Nuuh2V5Z6W7pm0GrBGpBxTuXCqSlX9vA/KNs+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RiVso49o; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RiVso49o"
Message-ID: <cbe3bd2a-4cbe-43db-bb19-37b2d8890eb4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776188780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRLMPgmEQNtIZ1+s3R+uauqPySY8kfsW8C0JvL3DnhI=;
	b=RiVso49oHMRT5XG/F91j0pD7x6IqHgQbtqMpyhzFq94sPN9gPK2R0IIVei0IypZxTRX+gm
	V5lktbqZR6nixC7Y9yTwLsbbiY6dFKpoiDW8umfx64qbPEV8/QPr23d4zqt9ZqASRACHpw
	v6g7f+YNzBMV/iQr+TX1hGYRmmMzc4U=
Date: Tue, 14 Apr 2026 18:46:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/6] bus: mhi: host: Add support for non-posted TSC
 timesync feature
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Vivek Pernamitta <quic_vpernami@quicinc.com>
References: <20260411-tsc_timesync-v2-0-6f25f72987b3@oss.qualcomm.com>
 <20260411-tsc_timesync-v2-2-6f25f72987b3@oss.qualcomm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260411-tsc_timesync-v2-2-6f25f72987b3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/04/2026 09:12, Krishna Chaitanya Chundru wrote:
> From: Vivek Pernamitta <quic_vpernami@quicinc.com>
> 
> Implement non-posted time synchronization as described in section 5.1.1
> of the MHI v1.2 specification. The host disables low-power link states
> to minimize latency, reads the local time, issues a MMIO read to the
> device's TIME register.
> 
> Add support for initializing this feature and export a function to be
> used by the drivers which does the time synchronization.
> 
> MHI reads the device time registers in the MMIO address space pointed to
> by the capability register after disabling all low power modes and keeping
> MHI in M0. Before and after MHI reads, the local time is captured
> and shared for processing.

[...]

> +	/*
> +	 * time critical code to fetch device time, delay between these two steps
> +	 * should be deterministic as possible.
> +	 */
> +	preempt_disable();
> +	local_irq_disable();
> +
> +	time->t_host_pre = ktime_get_real();
> +
> +	/*
> +	 * To ensure the PCIe link is in L0 when ASPM is enabled, perform series
> +	 * of back-to-back reads. This is necessary because the link may be in a
> +	 * low-power state (e.g., L1 or L1ss), and need to be forced it to
> +	 * transition to L0.
> +	 */
> +	for (i = 0; i < MHI_NUM_BACK_TO_BACK_READS; i++) {
> +		ret = mhi_read_reg(mhi_cntrl, mhi_tsync->time_reg,
> +				   TSC_TIMESYNC_TIME_LOW_OFFSET, &time->t_dev_lo);
> +
> +		ret = mhi_read_reg(mhi_cntrl, mhi_tsync->time_reg,
> +				   TSC_TIMESYNC_TIME_HIGH_OFFSET, &time->t_dev_hi);
> +	}
> +
> +	time->t_host_post = ktime_get_real();
> +
> +	local_irq_enable();
> +	preempt_enable();

PTP_SYS_OFFSET_EXTENDED receives the amount of samples to read from user
space, you can use it instead of MHI_NUM_BACK_TO_BACK_READS, and in this
case it's better to grab host-pre and host-post time for a single
register read.

Also, PTP_SYS_OFFSET_EXTENDED was improved and currently supports
multiple clockids as system time, it's good to account for it.
