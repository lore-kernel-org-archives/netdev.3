Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F5F40DB45
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822861; cv=none; b=a4QmNOb7ZJ/7FSrGiNmfe4ujcQKKTsWN/xuxEcbjT64rE3y1IX28HLEWoQbl4SuqH9OamTdOY1iLJDZWCZc7vZzetRpEtIsWZ9G80PGT90Hx6DHqsaii9+tZXmme/BdKntnZODP0hPPWAuWcjU91lw9gpldKWnY9ZCFtHAMlsJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822861; c=relaxed/simple;
	bh=1VjFw/56NuSowpcuUYzd/nD9k558sNhksml+YK1vqMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHoBo474oOw5pfChIxTI+tSag0HBHEosOh92dMQq/l8XSR+FLMDDXODDhq1gx+vA5Vhvc8AQGyi9NqlThAMZ/md9hVC4Fg7hZUXEaq4ckZ4NsEGESvisbeZEBjdS41rb7QsyDd+jTAun64gBogT8NObpJ244rRK/3g2CAh6/Zao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iiu9aVc0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iiu9aVc0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so7575475e9.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787822858; x=1788427658; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c6Q7JMT+N70vQ8w6VpAgBg0C75T9CAYCWBKVG27ZBGc=;
        b=Iiu9aVc0IVApqmv5LfWP/IKfEeKMlkYUhV+0Diz9JwnY53vBirtmQr/xoTFCQUrEAA
         9a3YwYfkEPvjpXCioPot/3CapDaM2Zpk0IH+A4lQeTloj86gqqPCdgwCntFT2F8tFWHw
         m0u15H7xKa3BpbVQy3iReynuBZhXUrIIPVFraut2qGpAHnlueNFAqdjJ4feBoTUPFbyv
         5p/ish7GSf9m/EQ/5B8KOArgUhutXFuIBpMWp8Omu2KBBNsj9+4450MO+ObOQtm88Uw1
         HsPL4uqEDeLQjj6rW8FLeEncvVpNI+pPJCErevGxWgLKOKi55D9FE8b8OMBSLHXn00Id
         1cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787822858; x=1788427658;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c6Q7JMT+N70vQ8w6VpAgBg0C75T9CAYCWBKVG27ZBGc=;
        b=ibkoFEOgPpH62iB56u02/JIdhQLCAww1KOWdX0FCRokGxt4le60z5olUubpNablB1L
         5tAbecjXBQ5TMtXIsxKi86a8onMjQvgs+OaqReu18+WLpM3vy5h9Z0WumPU/IF2AeJKI
         /AQjiGGd7TUhKLYrKEpxoOecfOGQyTEztufUDZCfQ8mfMQXay87dgLm0IOjVhJvHoEou
         yfIFocUFsWavLvxvovwcnsXivTyWFlLd+4MG46mPH6X8reHt5HShHlmZ9l8enFOFwTYT
         TRGJ0v38Lk570Ztp83VlYG7FcoWJ9WaUzdTSAH89VnPDzme053ItS67va6ZGwebQSwTG
         CtzA==
X-Gm-Message-State: AFuF++lmmkT+nQO/dg16yKEqoPf8hNpf4lqmEdYV1ZXnSYuoyHsLaD2d
	ysY6X7v/+AqnKppHCtRPk3IV0fsN0gE9Sj6VHdsb00fY/NbYNL2vKVB0
X-Gm-Gg: AR+sD10OPOZ/a0XF0atQRUmFudFSoAm/eunnkWBnqCdinVt0peidM8evV5z3fgaB1pl
	qz921Kp8rvZckH86fof5YNHWBwJsq2pjae1TB9hnqDZv2vc0obHBF1STPrjlwgsgkYXSeLbEcf0
	tv2V8RCY78ZmSySz9vSKs8hs6LoUy4Mb0D06JnREsqNsftKpXin2FsjF04SDPCepEAADFm+GvYP
	qx2RzU1GXbagmGqquK9Qj2kjw1Ou3UOTjLUWTUTXQewlEMeFqt4yvxzM1gxt97pBg/iJA8t6bK8
	4Tu6EH1Xy/eM7accorsLFolTKMOTqUm2eO3MzukbN/26G47I1RZ/hXGKdrmHKC820uM28TLDLAm
	23eI5+Gp1MYAQkz1i/SVv2OxBiTsl3qMtTLFllZdQJmNKdiZ/XjqVQ21Zs3UO1eQ5aqHdMXWR+T
	ExjfCqgwsrjuIxxarnlw8UJBWdxpo4JjumW7nJN3GMC57cnZnHB9/BfTZrNYkUDWngy5lBx3ZAk
	yr4o74FSTc22KCqVSdhpSHOdXUxWd5k7GzR
X-Received: by 2002:a05:600c:860b:b0:499:726a:a017 with SMTP id 5b1f17b1804b1-499dc6e0040mr162156525e9.1.1787822857788;
        Thu, 27 Aug 2026 02:27:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28e8fb5sm7550544f8f.29.2026.08.27.02.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:27:37 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:27:35 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Marcelo
 Ricardo Leitner <marcelo.leitner@gmail.com>, zdi-disclosures@trendmicro.com
Subject: Re: [PATCH net] sctp: fix a TOCTOU race in SCTP_CMD_TIMER_START
Message-ID: <20260827102735.4fa9a5f3@pumpkin>
In-Reply-To: <9d8f1b5c50329d5ea7c642128d35681abaa9ed20.1787773744.git.lucien.xin@gmail.com>
References: <9d8f1b5c50329d5ea7c642128d35681abaa9ed20.1787773744.git.lucien.xin@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 15:49:04 -0400
Xin Long <lucien.xin@gmail.com> wrote:

> The SCTP_CMD_TIMER_START handler checks timer_pending() before calling
> timer_reduce(). The timer can expire and detach between these operations,
> causing timer_reduce() to rearm the timer without taking the association
> reference required for the newly armed timer.
> 
> The timer callback later unconditionally drops its association reference,
> which can leave the association reference count unbalanced and result in
> use-after-free during association teardown.
> 
> Use the return value of timer_reduce() to determine whether the timer was
> actually armed. Take the association reference only when timer_reduce()
> successfully starts a new timer, closing the race between checking the
> timer state and rearming it.
> 
> This issue was reported by Nico Yip (@_cyeaa_) working with TrendAI Zero
> Day Initiative.
> 
> Fixes: 20a785aa52c8 ("sctp: Don't add the shutdown timer if its already been added")
> Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/sctp/sm_sideeffect.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
> index 94716406d602..0d99b7e8c082 100644
> --- a/net/sctp/sm_sideeffect.c
> +++ b/net/sctp/sm_sideeffect.c
> @@ -1545,17 +1545,8 @@ static int sctp_cmd_interpreter(enum sctp_event_type event_type,
>  			timeout = asoc->timeouts[cmd->obj.to];
>  			BUG_ON(!timeout);
>  
> -			/*
> -			 * SCTP has a hard time with timer starts.  Because we process
> -			 * timer starts as side effects, it can be hard to tell if we
> -			 * have already started a timer or not, which leads to BUG
> -			 * halts when we call add_timer. So here, instead of just starting
> -			 * a timer, if the timer is already started, and just mod
> -			 * the timer with the shorter of the two expiration times
> -			 */
> -			if (!timer_pending(timer))
> +			if (!timer_reduce(timer, jiffies + timeout))
>  				sctp_association_hold(asoc);
> -			timer_reduce(timer, jiffies + timeout);

Doesn't that just add a different timing window?
If the timer expires before the hold() it will release the reference the
calling code owns.
So you either need:
			sctp_association_hold(asoc);
			if (timer_reduce(timer, jiffies + timeout))
				sctp_association_release(asoc);
or to hold two references across all the code.

David

>  			break;
>  
>  		case SCTP_CMD_TIMER_RESTART:

