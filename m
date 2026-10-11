Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863A53932F7
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791745832; cv=none; b=oo2VreaJqRXdJzvKRTcf3qM1xEYN9c80qRAJ5oMt6OzqMeV7srwaNyCSMJoR4oh1JyKg7bxoKyKzULDSZQh0QLMm0jurF0OaLPF5YXLmqSuIP9iZUV+gFcKcE2ky7elT8h9Sq00rD1denFxsBUog15Lzis6lrfKce/Q9Tjoky+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791745832; c=relaxed/simple;
	bh=RjdAH3Y9wwiPn80wJQYztLmuKKN61VaF2ABE+OfYkgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwbZ5SgXPq9kO4WJAxfic6VSVf1KZUxrszyP8BsSTC34V3Q6lagoJRxxTlsN/qDa3zVfuIffg/3ZioRgfhAwukWC6kXMh6ekhyu6bxrpnBOPpw17GWm7mxuwJMNAlwC5HiFq7bVbTsYs6AhslLt2RzyYB7jaZY2JtGZIbI28VLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9+4JP/U; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9+4JP/U"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48b060ec084so645861f8f.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791745829; x=1792350629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QTR42Go9m+6eVHpUpw7SmlR7Yrf00JHufO82pWXeBX8=;
        b=j9+4JP/Uj4Dl6xmXO6DoyVkVC8LvFhEAQzdApR4lBDZAhKq22zR3/L1p4h0BtNCpsW
         c96uqK7y7U4zKw5UP+oQWUqOE7z6LSJWoo4vmhdZmdxLiY6RjFlaTr4cLJkrC+6LPkOE
         HYmYmj+CIkWcynQZV/AwOAd2U0wGu0UHuJM5PzAP7ghGsO5CetgQ8SlPlFMgKgqYPuAk
         uiU6K1cRwSU/L6FQzX+EY0QCMm9BinfbyONx+BK7PMujjw7JOpbMMtx6YXaGmk5CxKBe
         EZx8JQ9COk9mHWVZ/ImzeI6+VXp5RpcsUg1qsOZS1zCbgRgBptxohHBCuDpd4/nnr0So
         jGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791745829; x=1792350629;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QTR42Go9m+6eVHpUpw7SmlR7Yrf00JHufO82pWXeBX8=;
        b=e0tdsUekf5/zFz6J9gfSxW9YAkcuE3QF5GWmyWWRo2pRfjThjt+jFp050LkzFPudG3
         ITKG338cZsJ2UILIIbzKbm7qZkP0MWyt4GvkfLszn/nFrSETK8KE8W0okGS5+1wS+KGV
         C79ImPE0FAQmLT5GYRIS1m2SJkHzIXKoPxb+UNCz1G8FIDQeh012bXv/sWBP4vzTrk8u
         2HT44h1pLheyyu49MmG9iY5qJZjKvsYGff2WWipTMqvfJ+Pcc26GG9PjVsWIRXmSEhOG
         vzw527mqikJPfhxOdIs7Ju/IzwKBEMDgm3Lq4DDPdGYxlqsEIjBh9ex5+YWwUnExtIKg
         zLbw==
X-Gm-Message-State: AFq9FYL+soe8y9jnQqPvfvEzm0a6X/TPGGdiZLANLqpx/ZijVnb4f2j7
	jvE8pJgNb2MmFw+LPQ0LPG85XE5s837P6WDQLzntFjKf+VUvkpB1O+M+
X-Gm-Gg: AYBFou0LQeYzkKoTgoetRzfj/d4J8wDKqVgUIgpWdzrB5h0dT3E6/UsHsciNSmrbmFl
	zCQ7BIkIYlA8wPZ9mbjg8pywFpLtEIeyBTLqPx3Lgb9MJEHWUt3rv40x/DYJhfC5S1shh1V1hx/
	8hQd8SN2Vgab/iqa8Qn4unbygUDgys29YtQ0cd6F2gjaMkNpV7O5EmxX6e7TOW6XX60Cr+1/cXJ
	Ipg/BS8+d2WxmWflfmQnz7T/xlO7AEufnS5FkqdttYcCiOrkoj8S6VJYy0S/yaRmiO15pAU9IYb
	lBE09MzH8w4bTQt5fBaD0B8fgKS5Z6MdXvUys+qlMf6RapldkVvLxgJszXDRfwdEIZVX6N0CP4S
	5Slhu2fN9YigzYmHcz/FEwK8w8ss+rU95fv15UI+LjwRRMw2AY02wqPm07e+eGjBvFSxGdGbUtO
	m37r9arcvoBa59lANk6/jLGPH1ouQCejKGsS03ekac6p3P9BjiAcAA6AEUTqfpBJUErelvLB4+g
	/63CHOMn1PHv+w2Vb1w9MOZ7l3ljIdR/Mft5UENiAVPZhkGL/W3OB76OIJTZ0avExiLHYHgPR4a
	lHhf84ch3bvznWa0exPtyFjSgiMMvhPYBDQPEMEHwWDQlmsFdkzUYT1oFCT77Gh1h8xU/CUxu5Z
	bIYna
X-Received: by 2002:a05:600c:8518:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-4a18e4a8ca6mr128648855e9.12.1791745828643;
        Sun, 11 Oct 2026 12:10:28 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a124-4001-d491-d32f-6b9f-21c5.310.pool.telefonica.de. [2a02:3100:a124:4001:d491:d32f:6b9f:21c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9adf5e6sm15237808f8f.56.2026.10.11.12.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:10:27 -0700 (PDT)
Date: Sun, 11 Oct 2026 21:10:23 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH net v2 1/2] netpoll: use a raw lock for the deferred
 transmit queue
Message-ID: <asveuLDEf6a44bkD@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
 <20260930192103.62973-2-kmehltretter@gmail.com>
 <20261001074819.gQ3w8q6P@linutronix.de>
 <ar7sTVun7mF-4nl6@gmail.com>
 <20261009155225.6Uy7b0wd@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009155225.6Uy7b0wd@linutronix.de>

On Fri, Oct 09, 2026 at 05:52:25PM +0100, Sebastian Andrzej Siewior wrote:
> 
> I would suggest to untangle that local-irq-disable assumption. Then we
> end up with the ::write_atomic callback on PREEMPT_RT which will raise
> warnings. But those will appear only on panic() and as the last console
> due to CON_NBCON_ATOMIC_UNSAFE so everything will go according to the
> plan.
> On !RT the whole __netpoll_send_skb() will be with disabled interrupts
> due to the console lock. On RT it won't and I don't know if anything
> down the call chain assumes that.
> 
> To illustrate my idea a bit
> 

I've got a candidate based on your sketch. It keeps interrupts enabled
for the RT printer thread and the deferred worker. IRQ-disabled direct
sends keep their existing path.

I have one question about retries. I've kept netpoll's retry budget of
about one tick, with BH disabled until deferring to the worker. The
IRQ-enabled RT sender cannot poll, and with the BH lock enabled the wait
holds off local completion work.

Would you instead defer immediately, or enable BH between attempts?

So far, the RT locking tests look good, including on hardware. The
generic change also removes the sleeping-lock reports with macb and ENA
on Ethernet.

Panic handling and record ordering remain open. The non-RT console and
IRQ-disabled atomic paths still need to be addressed.

Thanks,
Karl
