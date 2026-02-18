Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD02D77FF
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424751; cv=none; b=pNsSnL/2TEmlgQRAKDk2H0Hag4g9yl6ybmclJN+Se9mmpJiDH9QAV+cgGglZT3I7QELEvcxhei/7TVZvPg/HvU6TXEo+fR1fBr4WHE/FhK830F73wQFXaerX7t3NmeOsy6IZvl5SQ7SZgCsBAfA+wKGtYtf6xh/Zl2lLAW/p/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424751; c=relaxed/simple;
	bh=pUpoFGINLo9aS9A1DdpxywKOFP90fgFX3NaG2GEySq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvZcag60/M5EwD6OyLHf7BL1Qp/zLHBKK2UEnq5C177NfsG/wNnTyq27KScFee6dx+Ag5PXIgW39QWfOOjnizrgFm6OJfJQJHQyN62lBBR9jfbpbeUrIHSPrAKkPUiWICmAtvLgi4agVsUTGYL4gxZ+9SHsvCpvWxXzvKavKiuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TODNYAf0; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TODNYAf0"
Message-ID: <3c9706a3-92c6-414e-ad60-4bc29c5d621d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771424746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2cwoMTGMgzuhudjpkuM8A87/NNsgOeoOSddCO2QE4YY=;
	b=TODNYAf0wacId0eKqV47z1fXrCoUGgXoWce24OXrGeqW5ux5rGmmXP0FifUifhaJTS0Hgl
	Nj7xdhFVmF7sjwyqD52ZyeM+J1MhxZsJ9c+3iA4mRIEQRI9gIwysUsutx5xOX4E6ivwN0P
	b1Fzml6BZPqKVyuD2iBp/We0rHGzKBE=
Date: Wed, 18 Feb 2026 14:25:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 1/1] serial: caif: fix remaining ser->tty UAF in TX
 path
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org
References: <20260215025141.1106576-1-shuangpeng.kernel@gmail.com>
 <20260215025141.1106576-2-shuangpeng.kernel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260215025141.1106576-2-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/02/2026 02:51, Shuangpeng Bai wrote:
> A reproducer exposes a KASAN use-after-free in caif_serial's TX path
> (e.g., via tty_write_room() / tty->ops->write()) on top of commit
> <308e7e4d0a84> ("serial: caif: fix use-after-free in caif_serial
> ldisc_close()").
> 
> That commit moved tty_kref_put() to ser_release(). There is still a race
> because the TX path may fetch ser->tty and use it while ser_release()
> drops the last tty reference:
> 
>      CPU 0 (ser_release worker)         CPU 1 (xmit)
>      -------------------------        ------------
>                                        caif_xmit()
>                                        handle_tx()
>                                          tty = ser->tty
> 
>      ser_release()
>        tty = ser->tty
>        dev_close(ser->dev)
>        unregister_netdevice(ser->dev)
>        debugfs_deinit(ser)
>        tty_kref_put(tty)        // may drop the last ref
>                       <-- race window -->
>                                          tty->ops->write(tty, ...)  // UAF
> 
> Fix it by serializing accesses to ser->tty with a dedicated lock. The TX
> path grabs a tty kref under the lock and drops it after the TX attempt,
> while ser_release() clears ser->tty under the same lock before putting the
> old tty reference. This prevents the TX path from observing a freed tty
> object via ser->tty.
> 
> With this change applied, the reproducer no longer triggers the UAF in my
> test.
> 
> One concern is that handle_tx() can be a hot path. This fix adds a short
> lock-held section plus an extra tty kref get/put per TX run. Feedback on
> the performance impact, or suggestions for a lower-overhead approach, are
> welcome.

I'm not quite sure we actually need spinlock here. It looks like just 
adding simple helper tty_kref_get_unless_zero() and using it in 
handle_xt() will solve the problem?


