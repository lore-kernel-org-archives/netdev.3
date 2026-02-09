Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F823176EB
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770677793; cv=none; b=X1+wKLNnRhofv4Pm9AcEQzJ6/oYiqpew/EYkK8klGxrBRSioejdXCCDEc7e9iDcHNLk0adMZM83GodM8Msi1PF5RqFF1FiaaI0EJ5coKV4LxmNy8oQjCvxaoeflJEdEcstr6d0LoGVhhrNY3kkRND/GBqggXmQI9t4w6MNRaDtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770677793; c=relaxed/simple;
	bh=trw4gZg3u5netF1WY9Edyh3HqtUonFyD0wBYk7S4QxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XOZW2YlFZEJFTtnHHel1VwlrL4/S7sICuDmJGhLrVzoEYqr3IapAd/ecP3kWvax4WsP/3Ez16W135tZERtrpmqH4b/X7UsfoqX1gGOjl09EXICMFwcW7z7Hm95aROuKZWpepLqs26bc/sK4qxMn0XBTnipHJNBlKf0vMKrUaHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5kEeuHy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5kEeuHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A334C116C6;
	Mon,  9 Feb 2026 22:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770677792;
	bh=trw4gZg3u5netF1WY9Edyh3HqtUonFyD0wBYk7S4QxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=r5kEeuHy3lfzpJAInS+BRw3PmZL6CXsXz14Urxz8g6Z5va/QaUMHUDabPMIGZ+oYl
	 F2tdFDYonNJcgd172JM6S7+/wpqy8viblrbx9bSbjsspn5MZUQa22gKskjS+mNZZu/
	 fEVmEEhQSRGh2sV5RjCGbVzSNRAeQukzkotxIEahoybo78CIOrPSwok3BFQ/wiJC70
	 MI/p/2hl38F+smbf6l/zw+2brV89ESzA0VtL+phuesuY+dJX/HUHtHikHIA1eCUfZq
	 gewriuu0KzRb+bIJlXW8EJ48pn7DnAM40x70avjyMyJYDb3CnvimyA4pzCQiynhKQh
	 rMHmHEx+jjP8A==
From: Thomas Gleixner <tglx@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Subject: Re: i40e: Fix preempt count leak in napi poll tracepoint
In-Reply-To: <aYpalNvTIiD4nym4@devvm20253.cco0.facebook.com>
References: <87v7g8zv2o.ffs@tglx>
 <aYpalNvTIiD4nym4@devvm20253.cco0.facebook.com>
Date: Mon, 09 Feb 2026 23:56:29 +0100
Message-ID: <87a4xhbk6a.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 09 2026 at 14:07, Joe Damato wrote:

> On Sat, Feb 07, 2026 at 11:50:23AM +0100, Thomas Gleixner wrote:
>> Using get_cpu() in the tracepoint assignment causes an obvious preempt
>> count leak because nothing invokes put_cpu() to undo it:
>> 
>>   softirq: huh, entered softirq 3 NET_RX with preempt_count 00000100, exited with 00000101?
>> 
>> This clearly has seen a lot of testing in the last 3+ years...
>
> I'm the author who introduced the bug. FWIW, I did use it quite a bit when I
> had i40e devices.

Right, but always with PREEMPT_NONE and no debug option which would
enforce PREEMPT_COUNT ...
  
