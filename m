Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6103CF976
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945846; cv=none; b=QvM3WAEk9n1S5BB82NUMm/f+msLwUYYI2C320Qz86V061fBa5S6KnlbRRyi+YicGEnTPceZ7UX9JAxNUdMEccPyUn0qVtq7iStqrHf1DkoB70FnOuo2GIMY2DoeV7m6nnpn/TUez9L08aLiV1vOVDFel6MWJ1xjXg0YlEGjH4OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945846; c=relaxed/simple;
	bh=9SFZpVjJ/5Q7xpeZwJSLWpZQ+Mc0bTdMvBSovkokiHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlVovzcuB/lk+2a/25Tu3uG05jolrTPljNGqm7wY7CpfdKN/Jg0aFJQf3YJ8ae8XQXeVoagzJkGGCIt0R0igqE9ZYbCmoFucUmvoj1QP1iOotpg+/O+K6ulEkt2KQSHQWJG7noB4fuWdI0FCC+gpOxLfO9ULg5ckPs/XfkzHqTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Px7oyReJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mtigvtdE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Px7oyReJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mtigvtdE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788945843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xAOShxB9t+buyg0EW/QviVQasOYhqW8TPGaUaX/0INk=;
	b=Px7oyReJ7aFD0mYJDuttNvUtrCQoi4w6jmwuVz+Nlg1kyW2BxC/PVqmwFG0Ncw+GrK+34+
	mldzm0hfBXkh98HP/EOzwk7HmjeFCPMbOXcI58bda4nDTfc4Bi9BUr8PUHV/NfcpBiQVY6
	XZJwl+LwieVA5b9qrHNSfA4sZ+O5uRI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-RVPBKWLRPE2vzxfGkO9Ksg-1; Wed, 09 Sep 2026 05:24:00 -0400
X-MC-Unique: RVPBKWLRPE2vzxfGkO9Ksg-1
X-Mimecast-MFC-AGG-ID: RVPBKWLRPE2vzxfGkO9Ksg_1788945839
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4858e4b3e92so2498793f8f.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 02:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788945839; x=1789550639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xAOShxB9t+buyg0EW/QviVQasOYhqW8TPGaUaX/0INk=;
        b=mtigvtdERwtXZ0S4HlxrtBpJorI596wxoRewie9oHMxK3lZKYHdVoVX2o3xV1I9MqT
         2TVRCBaCVsRCdO0ITW1CArc5YuPlT2Wo1cvbfqFHQllcDHtBGaBsVxT13bQNOoGGByvq
         TQRoY3nGeULUjcRHsAbcueCQ0TWgNwRIBEGRfWXsEmtJwJXVRpUdBqADDOFqHLiyv/Sf
         YMwdX4okpLy/VYQbccUuoDkqjh3gDS6hp+VIlOiF8ou2dKtUcUdFhNSS1VARTjaQRC+Y
         NY+VHiDzz8oTWK+zvukbvpCOq3GoOtdm65qmCuuZqRYZTGb3XObZPgPM8p2UcaXOgyiH
         x9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788945839; x=1789550639;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xAOShxB9t+buyg0EW/QviVQasOYhqW8TPGaUaX/0INk=;
        b=RyUAGAZ2LPCGmp4f4wr5vrhLf/Q1yn1YQUr+N5+SGq8zlY+FvzG8a5WefrklRenZry
         uBx0fEHvuv2pRJ5jgnUP6dF1gPV1QKdIRbSJlnmrlGIKCFXiUo23C+reVTSRr02MIbBe
         FJM2ch+jiiPdG6I9AfCdCdSCNPkxs4wNz27zekTIJQysRb/rjTD2x4+dHCZYYjO/GGEU
         mVXEJcrzELXktX/6uiuDTDLMUYkjyBloZx/BJiYkhsY0BiAESLgtfHmZpn7hNzaBjAe5
         9oxWCyDRyTCCiKH2e3NLUEtgX0qYHyNeb9kf5My97ETMAa/MBHdUUUniGEl/ckc9DeE5
         bj3A==
X-Forwarded-Encrypted: i=1; AKwUvBwNgmpceK1yfdxTGjwum/kY+n+t/klM5DZ60LTLg+bAr4vwDIi0Aguq2XyVLgJELrK88Ms9w9c=@vger.kernel.org
X-Gm-Message-State: AFuF++lLcr1Vug79/ehWI1PmYLmEy3yUYUjCdUb0EhNtIHj2k/CwNtLv
	NHV+jPPT8E8vzqA77opK+SYtFPJM0u3ZCabMOdD8Xr0ZaD8U5aEUhYTKwbA1qh/yJP+G+Ilk01a
	HspSZ8KrJuThpFu1LTkS4SukRfUumLv31wRIX6cnD8PVUsCPHObWPqGA2gA==
X-Gm-Gg: AYBFou0qhxSVRS3UB8IC1NyOSJ1ZaeTlkX53N5NXknwGw8f/YbeMo6kBtwtAuyyB6Cu
	s5pP4Ab498/WONB6LXRCKuaIekMokpOAmHxQFnds2zuNGCgNsTHpW2zdCq9A6+39ibaycGzsGcl
	YhZY/tIIu6I8SM3vmLJDHAbgGz8XMJV2vQr3oZLd48F5bLSF9x8ACmPeneiko6SWvg3ET54ndaG
	1B7AMT4Is6nde4uvG4jlx5tZCSARu+rfCZ9z6bu+DlBET1XyOuD7ZVUzNrVI9mfa4N69odtdt0L
	TDqJusxLDbpOfBCCjmZlSQgoe/rvlskwwlF+Qt/UfwwLZhqziBoQRpbQTHWumwUqYItEkGZtAS6
	W1I6a/fBJw5lO26XykNXcWSGBn2Pq9Rmles6YYAROQ/KzulAtsHeqjhdhBDwiU3c2fNK9H/cPNA
	==
X-Received: by 2002:a05:6000:2010:b0:482:f270:65c5 with SMTP id ffacd0b85a97d-485ba5ae772mr172469f8f.9.1788945839014;
        Wed, 09 Sep 2026 02:23:59 -0700 (PDT)
X-Received: by 2002:a05:6000:2010:b0:482:f270:65c5 with SMTP id ffacd0b85a97d-485ba5ae772mr172429f8f.9.1788945838576;
        Wed, 09 Sep 2026 02:23:58 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm41537162f8f.23.2026.09.09.02.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 02:23:57 -0700 (PDT)
Message-ID: <70d0048d-694b-4348-a6a5-de87a767b8fd@redhat.com>
Date: Wed, 9 Sep 2026 11:23:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Some clarifications on the upstreaming process
To: Steffen Klassert <steffen.klassert@secunet.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
 <aqD-_cBnIOMEpxVh@secunet.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aqD-_cBnIOMEpxVh@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/26 8:38 AM, Steffen Klassert wrote:
> I need some clarifications on how to handle future ipsec patches.
> Since we have the AI-generated patches and patch reviews things
> changed quite a bit and I have problems to upstream ipsec fixes.
> 
> I have the following problematic situations:
> 
> 1) Sashiko found nothing in the original patch submisstion,
> but found an issue when I resent the patch with the pull
> request. I think this can be solved by asking the author
> to send an incremental fix on top of the ipsec tree if
> it does not happen too often.

This is usually the correct approach, with some exceptions i.e. the
newly found issue is impactful (the new code is exploitable).

> 2) How to treat preexisting issues that are not introduced by the
> patch under review? I'd say that's ok as long as the bug is
> completely fixed with the patch. Is that acceptable?

Yes, pre-existing issue are generally better handled as follow-up. With
some exception. i.e. sometimes sashiko says "this is a pre-existing
issue, but it looks like the path doesn't actually fix the pre-existing
issue it's supposed to fix..."

Or when the pre-existing issue is very strongly tied to the issue at hand.
> 3) Which severity is ok to accept? Maybe this:
> 
> - High, only if the review is wrong?
> - Medium, only with good reson?
> - Low, ok to accept?

AFAIK the above is the current general guidance.

Note that some brief comments on the ML in reply to sashiko feedback
would help in all the above mentioned cases.
> 4) Some patches for the ipsec and ipsec-next tree don't get Sashiko
> reviews either because they don't apply to net or net-next, or
> because of some other reasons I'm not aware of. This is the biggest
> issue, I see the Sashiko review only after I sent a pull request.
> This makes the upstreaming process complicated and delays fixes
> quite a bit. I requested some infrastructure from the LF to get
> this fixed, but no answer so far. Any other ideas how to fix
> this issue?

I think are 2 separate points:

4.1 missing sashiko reviews on edge cases
4.2 difficulty to reproduce the sashiko/clashiko review process in advance.

WRT 4.1 things should generally improve over time, with the exception of
patch that do not apply. I think we can't do much for them, but they
also should not matter much, right?

WRT 4.2 the current guidance is to run AI reviews before submission.
Sashiko could be installed and run locally. The nipa instance (clashiko)
is slighly more effective than sashiko.dev because it runs several
recent models and its result are indeed hard to replicate locally/in
advance.

Clashiko currently runs on (very significant) meta-sponsored budget, I
think it would be hard to extend it's usage to netdev's subsystems.

/P

