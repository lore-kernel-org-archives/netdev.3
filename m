Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B378C9C;
	Tue, 10 Feb 2026 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770692430; cv=none; b=c9dhymz6g9KTmYe5LPT4cO1Ifb63kVTXbL/fhph+8SZTk+v5whjCbnh7uC8akaa0pZvSQTafQTloI3k1SmN4XKpOHhXKTB/jSnI6Si35pkMdwZQjOfvULnDQV1YOn1DD2kZXrzncWDSKuliPfHdKxRFknmtU6y70tpB0J8k3adM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770692430; c=relaxed/simple;
	bh=asJbDwuIOoPjIvRT8fUzPHU5gllkGxp0Xui+0rHEvSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ti/KaCCWF5gmato33OvSEPe5ZzqLhMI4by58/3YfD3B+XGzXvqXXOXuSVlgtdg7K2r0q5VHgsEijvjWD4i4eJ1WmBXQHAZtklpWdXu5qLtcX6qs0JF2cPWT9FIl9+NtdIrG1UDPexvrs8ygNm2e136AXci4YGzuCGicJx7MTRdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=[192.168.1.226])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1vpdgJ-0005vb-Vf; Tue, 10 Feb 2026 02:40:52 +0000
Message-ID: <e44af88d-2a7e-4caa-b5a2-88ce1b49a8ec@trager.us>
Date: Mon, 9 Feb 2026 18:40:45 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbnic: close fw_log race between users and teardown
To: Chengfeng Ye <dg573847474@gmail.com>, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jacob.e.keller@intel.com, horms@kernel.org,
 "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260209163854.521415-1-dg573847474@gmail.com>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <20260209163854.521415-1-dg573847474@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/9/26 8:38 AM, Chengfeng Ye wrote:

> Fixes a theoretical race on fw_log between the teardown path and fw_log
> show/write functions.
>
> The fw_log null check was performed outside the lock in both
> fbnic_dbg_fw_log_show() and fbnic_fw_log_write() (called from debugfs
> paths or mailbox threaded IRQ handler).
This was done intentionally. Initially the log buffer would only be 
allocated if DebugFS was enabled. If a bug in firmware caused a log to 
be sent the driver can reject it without the lock.
> Concurrent teardown in
> fbnic_fw_log_free() could clear and free the log buffer after the check
> because there is no proper synchronization, leading to list traversal or
> buffer access on freed memory.

fbnic_fw_log_free() is only called when the driver is removed, after 
DebugFS has been disabled. Before freeing the buffer the driver sends an 
explicit message to firmware to stop sending new message.

>
> fbnic_fw_log_write() can be reached from the mailbox handler
> fbnic_fw_msix_intr(), but fbnic_fw_log_free() runs before IRQ/MBX
> teardown. fbnic_dbg_fw_log_show() runs via debugfs and seems to be
> not synchronized with removal either.
>
> Possible Interleaving scenario:
>    CPU0: fbnic_dbg_fw_log_show() or fbnic_fw_log_write()
>            if (fbnic_fw_log_ready())   // true
>            ... preempt ...
>    CPU1: fbnic_fw_log_free()
>            vfree(log->data_start);
>            log->data_start = NULL;
>    CPU0: continues, walks log->entries or writes to log->data_start
>
> Move readiness checks under the fw_log spinlock, and clear the log state
> under the same lock in fbnic_fw_log_free() before freeing the buffer.
> This makes readers/writers mutually exclusive with teardown.
I can see how this makes things safer but not sure the extra locking is 
truly needed. So far we have not seen issues in test or prod during 
driver removal.

@Alex - Up to you if you think we should always lock when touching the 
buffer.

Lee
