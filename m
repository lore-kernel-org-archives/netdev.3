Received: from smtpdh18-1.aruba.it (smtpdh18-1.aruba.it [62.149.155.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6443B6D4
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277112; cv=none; b=IO2mkBmTNZfl3sXwQHwNW0mIXTFwJo7e76a754PRLbvv1JaR0q+uXbtFFn0dwQ8p6oirelq16T0QMSX8kr5ysHfdlfiJfOWq2RR8990J6EjOKX2TnuSO6SKlOC2hgxbk2iUA5xuyc4FXUPnrbTg66FpGpqdl/O6x913P7xqIR5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277112; c=relaxed/simple;
	bh=icHhi8LMg3aQsejnv9tHFEAqc5mNze1gn55TAzmJq9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYG5/3UmTHXfEHfSQIFiBvzNgyUOioAis4VzD2iKiQFxmXo38aJYtKriL5vstlUzlu/qMkGC48bDOVNjO+8bR0Dx03cKebcla0Phr+InsLkAs/HzITGVdXw5O8MpwK9ch/wPJF04aF3BzKfmGOccCC8sD6MigJMNuI9Q2n0tHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=ZJrQyesz; arc=none smtp.client-ip=62.149.155.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="ZJrQyesz"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id 1QWHxKgtH5Ste1QWHxBgj0; Tue, 01 Sep 2026 17:35:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1788276929; bh=icHhi8LMg3aQsejnv9tHFEAqc5mNze1gn55TAzmJq9s=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=ZJrQyeszBevxlf6nGwPUNIT7nmNIQU7t88VAPvezvTcpKZewM4+ektkUhCORL7VLB
	 7yIoRTrsuuMK+Z71Ky4XXYeDrSxTlBdRIQnwrMVzXRU6M8DicxjtGSLfV3HAo0O8UB
	 EzURKc6xfrbPjBmAsVxtWifpiI/jq9cdEijkK7WEbvPyG1LXyOtYtp9i4PY8/RKpp9
	 zaGT7YDn16H0tX/l2oSX/q2F20pF9PcYIZTN/5k9cmSGXWuH/lFt3Tj4n5RD0w3LGq
	 40JFxcV7JkQ6tzqK7NADQQ49CgUcxB3uJKtJlTP2gngf83EOdfC4CipmehxgecoMZt
	 zFCcj+XDlCVtQ==
Message-ID: <920a2d70-c1ec-452b-8fc4-aebf1f6af412@enneenne.com>
Date: Tue, 1 Sep 2026 17:35:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] pps: Always use ktime_get_snapshot_id() for
 pps_get_ts()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
References: <20260829210041.40649-1-dwmw2@infradead.org>
 <20260829210041.40649-4-dwmw2@infradead.org>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20260829210041.40649-4-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPYvX0rybfqI6NqftGha7UFGR1ICXr+Kh9mAAobozR/eSq9+SrNf3t2VjS6SwzLvWHU/TUFvFdbR2mboRIi42eoUKKyFJ/H0UryoaOo3dEFK6gkDPyXo
 u8j1nnGysGu/D9CPl8AN5r4CD8N/pM6dnAaOiEDqqnNrXqUZyy1uDgl8nLx7tDt6GXEMdILq8AmgZOnbSHZWghtKgDuIfPnBHgj75rZgUAdrInGhqirOlGeU
 uFF/b3DAsOcMuztrDgFL9KVHYvES0plQJxpuZK2mL5Y62SVVH6YDJKogieuNyZlST+Ghwn89OMLrfOsx4fP7eXEAyojAjf38U2WYAAq7taVrJXF8RRpu7jCk
 XVKlZJOmtRPp583zuVmA5Aots/RL+oMruWcffl/nfihEd/qlqc1ekpoDIkXz+OP7hlYzAMFnYcslKhRXPb2cyxX8DRmgkZ7G9kiZQe8c6VJ1Wo+RcmUTHfHE
 749ljUfY3353e353QhbCp2iWBXxHaQVATwRCNMMFoqJC6q++XgzV6d62eVr9QqiKXd6RekZi1VdEpT2eKiXZubqN42DQAYj8Z3MS984NNplhII51MXfZshnu
 F0nXLGSkjNhKiTUg/CbM4mXg59GPSFjZZCUOaSsOqVgRNQ==

On Sat, 2026-08-29 at 21:57 +0100, David Woodhouse wrote:
> Rather than using that more accurate timestamp *only* in the case where
> CONFIG_NTP_PPS is enabled, do so unconditionally.
>
>  static inline void pps_get_ts(struct pps_event_time *ts)
>  {
> -#ifdef CONFIG_NTP_PPS
>  	struct system_time_snapshot snap;
>  
>  	ktime_get_snapshot_id(CLOCK_REALTIME, &snap);
>  	ts->ts_real = ktime_to_timespec64(snap.systime);
> +#ifdef CONFIG_NTP_PPS
>  	ts->ts_raw = ktime_to_timespec64(snap.monoraw);
> -#else
> -	ktime_get_real_ts64(&ts->ts_real);
>  #endif
>  }

Why are you removing ktime_get_real_ts64()?

The commit message says you are using the more accurate timestamp
unconditionally. What the diff does is delete the !CONFIG_NTP_PPS
branch. Those are not the same thing, and the second one changes an
ABI: ts_real reaches userspace through PPS_FETCH on /dev/ppsN and
through /sys/class/pps/ppsX/assert, documented in
Documentation/ABI/testing/sysfs-pps and unchanged since 2008. Until
now it came from ktime_get_real_ts64(), the same clock userspace reads
with clock_gettime(CLOCK_REALTIME). After your patch it does not.

That needs a good reason and the commit message does not give one.
Give me that first. Until then the details do not matter.

Separately: are we sure that calling ktime_get_snapshot_id() does not
introduce much larger delays than ktime_get_real_ts64()? pps_get_ts()
runs in hard IRQ, and in pps-gpio it is the first statement of the
handler. Whatever it costs sits between the edge and the timestamp,
and that is the one thing PPS has to keep short.

I would like to see that measured on something other than an x86 VM
with a TSC. A small 32-bit ARM board is what I worry about.

Rodolfo
