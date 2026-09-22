Received: from mail-qk2-f26.google.com (mail-qk2-f26.google.com [74.125.230.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41923E49ED
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 04:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051589; cv=none; b=ZeDjeTj1QkV6Pmft5vd5KJkjyvSQrGlesM4jTcDI6TZf/dNLA1yzdxp4EZPdFccyGcyFQSBukJpkw9m63g2o3wt3FYbH4eyRBPgy+3obMUsmX2pVoZmJRnsLNNtbuGw6blgLklypZAkylaHl57h8eGNvUQ8NDb/vWlkskvO5qSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051589; c=relaxed/simple;
	bh=jOsq6u4GxP4+4otPjCoyuUQDELVcpp12xkpbUnN0QYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7CaCC3/YpC4EUhudzf9Tc/RABK8FJ9KqaeWBcEydPcG/kjjZm5hfJNb4Pf+l7e/MovsG/1p66DebGCXeCx7i6tyQi6OEd0QTJTAeFIEoBZOQrqq+JO/dscB3RCqdMpGAaA3EQIXzlCaQCJLMBKMh4+PxbC5SddvT5ebj76syoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=SwwFKotn; arc=none smtp.client-ip=74.125.230.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="SwwFKotn"
Received: by mail-qk2-f26.google.com with SMTP id af79cd13be357-93a0299c787so278348385a.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 21:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790051586; x=1790656386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jOsq6u4GxP4+4otPjCoyuUQDELVcpp12xkpbUnN0QYI=;
        b=SwwFKotnPBXyAbiOip6KsvyrvaAEbPUrIfT80hNkZjo47vt2S7zb46+DsrO824Kju8
         puzQblb2Wd8o/O/NwysSgAn5MJOykWDfo/D4/aXt2o756MdsFmrk6Nu/TEZqUeAYjumz
         MzUTkori8hd3yjHDVyWBCSicVhkOnCraKpaS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790051586; x=1790656386;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jOsq6u4GxP4+4otPjCoyuUQDELVcpp12xkpbUnN0QYI=;
        b=jLfp95Sr25ZJBfAuEp6KNGIv7Al2aXeKuDavP22JTvBDplWmFZZZT5YdHV/zK5f2i1
         dxBTgFojWek47tV5mToDI67tVVn6s715GiGLg5JJxKjBA0PuWuspHlWQqXJfBnho2gUF
         B6wkr+LidtkE2ZqcqIH44jMB6S+xHxQJ8iU92fK6uGI8LBLV3u/onYLrII4Vv6rdCXji
         6ytMZ4PISQgZKcuBox9vWCT20r/1w2a/6e5H8lbMrWm+MiEYVhfqK2Y79Dj43vWN+6Ge
         rndq7VoOExbLR4hj+jSd6TT9IuTzW+DsCkczXtdW4i30KoCusu837Ry5Sb9BpvJNnu9i
         /k6A==
X-Gm-Message-State: AFuF++n9erF0f7YBLwo8KaaQ3+3CW0Uwuhz+LoGgkD9OVprgOy4rBwBq
	1L5I6DGSssHF5P/p8vh1XG2oNNqIsxHJU9sSeN8a0b1IL1vY9oLW1EVP5NOooxAKMpE=
X-Gm-Gg: AYBFou2RI4OJs98LEKyX0kY25PKRuUDcO8kf8A0CJeaRbHy6r6KLla819TOc3LKBkP7
	RZxv8Eb0FPWnc9cy1Mp15tgee0xhykW9GmJHocAnWWi7baQQU3ANqSLqrTw8Wkzr3UqxpDXvlI4
	JjHwqUhFvvwTi3Q17GvnOoMvGAYq+MWrJCW7RwmN7G03AaYtMeUi99w7w5miEILbKnYSBFcxwEY
	xWS4fDF0rVa0NfI23r4WxQZkVg8pSglrfgQt0KAWa2nGuEj1kDSTUm9bdO8H2o6i3edJuf4Hc7k
	1ieD7B2kMnLSlslWUcBTeHWyKblPqtGdEAAFUGYmwJJhzAd1+5fWYIBLkHDPVD029W4IM6gQgHc
	oSrMfBqvw8008RRIY1PbPpWDxCvuYuCdCqUyemoQuQ/OIBXVzvy2/PxxWIKOFpdPJdkZXJhcAGY
	WFTYNUvfH4Mv6/0ArCpCLKxORcISj3WleLGg+OUFRldoHAwpF6aiw6aIGWkUqtzSKEVcxXDsfdR
	XJ1LFaKNs8B6X2Y54R69J22Wm7cvnlGijS/HrFNs7b06q9p9PxUPQ==
X-Received: by 2002:a05:620a:44ca:b0:93a:10b8:4c3b with SMTP id af79cd13be357-93c15d583a0mr373213285a.2.1790051586610;
        Mon, 21 Sep 2026 21:33:06 -0700 (PDT)
Received: from com-94485 ([199.47.143.14])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1cf0e6bbsm45125785a.1.2026.09.21.21.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 21:33:06 -0700 (PDT)
Date: Mon, 21 Sep 2026 21:33:02 -0700
From: Jeff Jo <jeffjo@openai.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: net: check timestamp echo after an
 old ACK
Message-ID: <arIE_i8Ysz5nOI2W@com-94485>
References: <20260921222609.50824-4-jeffjo@openai.com>
 <20260921222609.50824-6-jeffjo@openai.com>
 <CANn89iK00zXGA8sdpH9Y1CkFK3n=uKG9Bci3+=69fGV0UDQ80w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iK00zXGA8sdpH9Y1CkFK3n=uKG9Bci3+=69fGV0UDQ80w@mail.gmail.com>

On Tue, Sep 22, 2026 at 02:08:47AM +0200, Eric Dumazet wrote:
> Note: Even with existing packetdrill binaries in the wild that don't
> check TS ecr,
> tp->rx_opt.ts_recent is still directly testable in pure .pkt via PAWS
> (tcp_paws_discard()),
> the same way tcp_ts_recent_invalid_ack.pkt works:

Thanks for the feedback. I'll send a v2 series tomorrow removing the
redundant SYN_RECV check and replacing the test with a plain .pkt test
that uses PAWS for the assertion. I've verified that the revised test
detects the bug with unmodified packetdrill and passes with the
simplified kernel fix.

For the PAWS probe, I used TSval 300998 rather than 300999, since
Linux's one-tick PAWS tolerance allows the latter through.

I'll follow up with a separate packetdrill fix. How does that sound?
