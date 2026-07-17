Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19B43F8EDB
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292252; cv=none; b=SXKeod3cbUug2XVbsaYTX/njj0CxX8WdNJxhX6/0VqaRjZcGAAfvhn4DmES9SGJXZ1u4peamLtGwSt83MJG200e/XDGqwpHUnCgYmMdD3hWUt19/2XZwX57fKN+lkW0K5889nj2XQiDQtvGsVjV880lL3tRPEzpnD+fBWkqqH4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292252; c=relaxed/simple;
	bh=huPV0bvapPbYMH10KQbV3TuHqNMdtv5h9UfrCwHorpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRy+DqXnL5UkM5bf9TyCuE8h45OHTEsMRZSHwgQzIKbNvhR2uhMvDGI/tIyz3fJ902t6jXVFzc8vLGXwNgAvmLrnAUa5nZhHJNeS6LLba8x9pf/UCsFoyZx3X2j7LcMSO5qksQS/GILHgkh2M+PyAsbpNVj3ghbL1Rd2ljjlMKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hxvA+cjs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pfwF5Gpr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxvA+cjs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pfwF5Gpr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784292249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJHxU0nZsS0jGtG1L8drSuZrAPuT2Fil33pvaZreEIU=;
	b=hxvA+cjs/ZUIbTgXxJRZBpRwwVDH5svbdhpu6jOS8SGhyG1fL2HluftFd3HrfPawyBmAJZ
	bc14RTti9VrWfNFgSlsEDKeuM3X674s2a2ITVwCc7c6Sgunzy9D1OpV1ALAN+tY5TvOH4v
	7H6J99u6FVcsXbNNP3MyQ1eT35uMlq4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-ltMNpJ-RNBGdNpAn_ZvDPg-1; Fri, 17 Jul 2026 08:44:05 -0400
X-MC-Unique: ltMNpJ-RNBGdNpAn_ZvDPg-1
X-Mimecast-MFC-AGG-ID: ltMNpJ-RNBGdNpAn_ZvDPg_1784292245
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47bbe3b9705so6881173f8f.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784292245; x=1784897045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FJHxU0nZsS0jGtG1L8drSuZrAPuT2Fil33pvaZreEIU=;
        b=pfwF5Gpr0ARbiZO6+MoEu/04kIOj93FQRB3nt0sK/Wu5o2y+BHW4CIH9mPz8j0M87x
         Ie0CvKGolcDJYBlRFnowf87hFv5iPvAwzynwx/6kr0pcuKN25njGvnQbbMc9a7tJv3/5
         uNmtYBw4c3cBVeVb/N2VqASfRpu9jM4qI1helr7SI7XKZlwuMbZS6J2s7t12ShobdXve
         DbfqoWGOu62IOmFbTFrqKohV1SPTbyvVvtLN84rVtnX0R7PGXrLT6MA8XHnB4Qyc6WCJ
         g1GYaVwn44FugcKEXbUnZCzISGGmuFhze82YGxuPVvHpTOKsXhuJOVhjzlfCJtp09dw1
         7XUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784292245; x=1784897045;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FJHxU0nZsS0jGtG1L8drSuZrAPuT2Fil33pvaZreEIU=;
        b=J1O93Cloi1Snw6os03Qtk7OlHWDp+4Q8xVYyyESAix3BTrbpCnYOjXWTo1S9aVSaBc
         lN7/p5oPlobtT2GrENHZ9QrmhxxSskYz87CrgT65LkitQEyP21/kbFupD7jedt9YP2/q
         AOv+a48gbSESvcB03PCl8QPYH5GCohEwG0DMJAuD0k0pTWnB8zLltXhklbdkLIys3OjH
         rYDhvuuj2LNcoCjL5nqZpjg7EJ9MIq7PofSaofM7HlnNajgHpsZwwww+QINZNjP3bTiV
         3ioHW1gor1kvBoxscHUEmtY6ZLSbC7hyLSg/C72g6U5PQ3MuWqoJpoKsLgvK9dkITO84
         1ilg==
X-Gm-Message-State: AOJu0YyijPMpCohv1xrbRyyr5Y735NCxSehjBC/FINnATH/XFZDvuKix
	vym9nbrb2SOb5I1aS3Jhg3sFgyXaKHs97MFpox89fXYl0dBxMTytHIdTXDQ6FdnCNkX6EKuy2Vh
	yWbO/R4QP4uq54dtcaQtpM4FJlilzf9FMXSAGjfAhJUTgLzExIjp196jrRw==
X-Gm-Gg: AfdE7cmvorNm3pazsjHc5ntMMdOlgP/Wa2TDPZ1K5t+GDMKylJ3oUOubKzvOaRTzADt
	FSt+rUJEiDThMhxG9gdLnSRLUjWvJnQJaijz2P1GrhgQdFuhr8MsGtMK4l9/Oxs5Klvgaw9AuCu
	qYSa+uHXod1J+evBc+fn5lbiiVIp+CPBLFRTVaSCS6OBR+1nICNQpCBfzvjUtMDkmedmWWgbzlP
	+3iu/+KfIENiBLhUDrUy8yt2r6RZDxWlmBeYpIRYqQBMknGEDQWT+vNsyc5MOuspqeiT5zgv68y
	mqgVwiE0gLiQCkMTLSBJUhbuNq83kg3uqFqDh41Zye7fxgibMC32R2OgRuxqk4oaAwzpK4JE4QG
	Xyem3mBgOfNc+4feuhhDAkg3OBIqcj80b+NARkcdkhFD/hTkjef3n6AoRP/ipJIM8f4jyQmE9ie
	BMfA==
X-Received: by 2002:a05:6000:25e2:b0:47f:4e46:e9e8 with SMTP id ffacd0b85a97d-47f622fccb7mr3285878f8f.6.1784292244626;
        Fri, 17 Jul 2026 05:44:04 -0700 (PDT)
X-Received: by 2002:a05:6000:25e2:b0:47f:4e46:e9e8 with SMTP id ffacd0b85a97d-47f622fccb7mr3285839f8f.6.1784292244150;
        Fri, 17 Jul 2026 05:44:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee926dsm3233222f8f.35.2026.07.17.05.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 05:44:03 -0700 (PDT)
Message-ID: <382033a5-77a6-4505-ac50-58120308507b@redhat.com>
Date: Fri, 17 Jul 2026 14:44:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dpaa: fix mode setting
To: Sean Anderson <sean.anderson@linux.dev>, Michael Walle
 <mwalle@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710143430.2276141-1-mwalle@kernel.org>
 <a5c5b8a6-85a8-7830-e19b-ffd5de750e3c@linux.dev>
 <DJUZ1VG8U9SL.2W0CJM7NSMK2@kernel.org>
 <2c8f63f5-f04a-4abc-9508-4c47a80da543@redhat.com>
 <DK0RLUBEKFVS.168UHY5BP8D4E@kernel.org>
 <26cb3349-5344-48c0-b0b7-37133b4e0662@redhat.com>
 <eee42ee1-386e-996f-b9d8-8aa2e820d311@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <eee42ee1-386e-996f-b9d8-8aa2e820d311@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/26 2:05 PM, Sean Anderson wrote:
> On 7/17/26 07:11, Paolo Abeni wrote:
>> On 7/17/26 12:13 PM, Michael Walle wrote:
>>> I've seen that, but.. that was the actual change between v1 and v2
>>> as suggested by Sean. It does not depend on the actual link speed,
>>> but the maximum link speed. So it is not relevant if the link
>>> negotiates to a slower speed or not. At least that now matches the
>>> behavior prior to the phylink conversion. If that was working -
>>> that I can't tell you.
>>
>> I'm sorry, following all cross revision discussion is a bit hard here.
>>
>> I don't understand if the 'link never established' is specific of your
>> board, or it a constant with this driver. Could you please clarify?
> 
> I think we should set byte/nibble mode in link_up as well as mac_config. That
> should fix the problem where the link never comes up (possibly broken since
> the phylink conversion). I think it's unlikely that this config is supposed
> to match the phy interface speed and not the link speed, but you never know...
FTR, the above does not answer my question ;)

Still I think (mostly guess) bringing the mode initialization in both
link_up and mac_config should be safer (that is, I agree with the above
plan).

/P

