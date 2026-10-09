Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493983B0ADC
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548655; cv=pass; b=IMuDzVltAENaTkSmQs9WoU3y7vD7kEurRgLkc0kvjmh1E85j7+xmQHZQkYs/tTZxhoqiw6t9NSZA7Kd1VDvqrMSmzNv1av+R5k/jZxihr+iZP+pRwcqzbvon7L5ZN0Yv4OBnfzCs7P2cyVkVYT8BpyrJqTPHADLI7oJBvn2wu/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548655; c=relaxed/simple;
	bh=W+GVodrUTNH4Yy1nDEnsPN+ql8MzERFY3f4gbOktc0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k88d7Ap1fAZPK4gRictUS1tYT6splOicPIIe/F0C9jfCxX3lOZP1vqJ+D70Jip48PAc6YtTz4a5xqaLMU26HFVtMUPtKb/tB5VQSVIYopnudqrDmtjTIKLMFbPadbaMvMB1vP2M3YrhOUhC4TNUDwuqZqtIlIO65WVncazk04to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sQNlduzi; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQNlduzi"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33fb4680717so1193475eec.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 05:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791548651; cv=none;
        d=google.com; s=arc-20260327;
        b=oj83XRbkxOMVQJaJhYXAmp85psiOBagoWjvHax8pwqEW+EMlnehVEubAcv7xczx4r+
         /js9CrBzEK4M/26PWdc2tboPuasHQRSLxsxeodRnu8OvTfuIIUwybn4rAbXPr21aj9rM
         Q85xNQoJieV1fJEskKxt9rZkkgOF0BDFlYDRBLDT8CCScnuvvrz/+hjo+knMm9jcGk4q
         UULvXb941hP7WHr3j9+Wvh8JSRXcYIAgNIMOlObZAUH7QxSFrBQ9Td52N82gZ8rA/Cx0
         a2HY5V+mj6ezpvq4yjFG7VKcqBweR23jKBuFnfLlzdK9HzrvIAouH59rv6qlZuRj0FTi
         kYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6w7iXC+S7wuM/jPa5o9UtD+49O2Q2UL2gZUFw1fUahM=;
        fh=gBgR8gNaR7OSQiCIcbbAEGl6uzH0wlKzbf3k/EY02kw=;
        b=j/A12zToZvr7s7PvKuRcDsZ7WB5rbhj38wn81tlrFGvsM7OndmBMF79pdCxKxjLWps
         eoDsFVHUvjbHbh8WZQyTCkBWjtB3lOPiWNmi1UX5TpsWiUDU+hD719FcklvOXbUKuCVw
         utNRdIIFXB9seQ80i7LC6xW5TmPj2OTb5Y2l6Nt+lzhgL6ooL1Vjk5do4aR16qcXIPag
         YrA9H7qdxRwfEBj9NISWEJH4zBjAMs/gE7sgIQFmE2EOlwRze7dNeJ+5iyVS3XmVVHx3
         xZQkpSbgNH0/VqYnOjJBkD24WJYbOyH6HB/+1NA/5rYZjrlHGSNTM45ds3rBixiz+HFN
         2kGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791548651; x=1792153451; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6w7iXC+S7wuM/jPa5o9UtD+49O2Q2UL2gZUFw1fUahM=;
        b=sQNlduzi/63ZkkDCnIriT6G1Yo+AA3Y+4+9LPmjw/rerzugD3/SD+i/77xtHkd+qyx
         bY+lOjX0+YI7iKJxXPVNq89retWljHuBJJGbtaNmppRl/ucggm8qIZJEi6GUTLVnCWBQ
         WF4F+upwRL011bRU17x5wixbPPTqTfjHsDjBgeq1ELQeL96ZUrKCASVv6/3U4TZpby2U
         uJcqNgHjbLBNXdLN7cT17Sh6S8K82rrguw3XFZhUVcHXey2On6hP1BG/aNRwISvLIT03
         f/KTTp0ZspPJPnsdvofWi8P0mq1oR675EFAjpj2d5HqVvE7nCtIFx9h5Jxq5/bWE+LFO
         jdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791548651; x=1792153451;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6w7iXC+S7wuM/jPa5o9UtD+49O2Q2UL2gZUFw1fUahM=;
        b=h4gcdGLvJeO1xaXktGPUuxhercbzUboeROq0OQcUkRD+jKvfpd0wsB8D6rviiwbWUa
         BHNEfX1oJ1Yo97kAKHzdeLi1QN0hWSXm3RdhFqL65k5+USEabRoSG65z1b9KhojL/9Ke
         0mL+jUNHmxnB1ewtyoAUSLAItIenpCI67TIoQX/MjxcfDvrlhhbz1hAV/sLuZBZQYynP
         5EFxKsbcFFquSwH6bt79S9WNWcsYbpaaXsbjmsf4IpaFeRvTMW/a7efmsy5w0pT4+XPS
         ZYAbPV4IREJYZZO47ezmPDdTw7rfFMn/9FAP16MVeuB5HOQxdqPx8THL7OlUw+S2MKF0
         X95Q==
X-Forwarded-Encrypted: i=1; AKwUvBxANweRGEWGLBmY7O+Kjn4BGzRRVrFy455xky6/25FmJ01cRF2BLxtdFLLFqYuegt5L4nScVyo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYYQWq9Q7jVtwoW0zzifzDOdaXXG3NVumhXMLy0+O0o0coWJn2
	fjeq8VXuJSyn7sRSFQ9gz6OA3Nai4t9EuGVUSQhdJ4yoTO0We14ZafmSM4ncLzWseDsxVcLjXza
	vpFb4c9om17/iHtByVW+39f/j20/jmw==
X-Gm-Gg: AYBFou0byBbPWsW3vdllZzcDDGE05sRlYHul/LJyXX4gNJeXJ73lwM8bpvFOl1BRZ57
	Io1lV0U+Ju0PY/sk/WQXBUfmFawgCVwc8SESi8vN3haVt5oVUXzPsnGlbGdJrvsZn1GRfiTsh9Y
	nFjuIZK5IYAs96LHVjq1IZOjfAGhuM5EJU74VK3fivYjvt3a7rOpu9TJ7VKTTBPcExNTGwjG3ru
	8J5CGxdexObqFDmnhQT83q1oGKjS3vCdlZQnuTXixmJmjgEuWBwLZDfCOYK9HwnoJB320RUJelB
	sPUI/oaCsEQo/OlcTJaKpdzPQCHIdbOCBa9PWmWvga50wgAo82OPM+NrAyyjwpq53xx38aG/YN8
	8YYOX2Lh0fZw9M9pEY25mvhHpB4enYln+g4FLe/n6
X-Received: by 2002:a05:7300:cd8f:b0:351:75b5:885d with SMTP id
 5a478bee46e88-3537dfd8470mr3507309eec.17.1791548651179; Fri, 09 Oct 2026
 05:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM6_QD_PoTdwdM7DvzzgHRs-G5EvQu-c5oNGve=GuKV4wFYAvQ@mail.gmail.com>
 <CAM6_QD_xAyTFVvYKvCrrZmS+fV5DBBje9V=VdkDMMSpt2ussRg@mail.gmail.com>
 <20260928120343.49e02c07.michal.pecio@gmail.com> <CAM6_QD-CbYSsmic5LhpMi-aMXuC_VaniELBzaBeWO8SWm4UONA@mail.gmail.com>
 <20261002104355.698eaf00.michal.pecio@gmail.com>
In-Reply-To: <20261002104355.698eaf00.michal.pecio@gmail.com>
From: Dane Linssen <linssendane@gmail.com>
Date: Fri, 9 Oct 2026 14:23:57 +0200
X-Gm-Features: AclHuK99jZT_xKU3QNXdrk-r0fVYuUviUqc5tIgyboVM9TB_HTssMakAr2jlGvc
Message-ID: <CAM6_QD_z7eT+N6HieHyZhPmXqPxKqeSYKX8OK--M+rN2VAsO_Q@mail.gmail.com>
Subject: Re: r8152: RX stops until rebind after -EPROTO on the bulk-in endpoint
To: Michal Pecio <michal.pecio@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	Mathias Nyman <mathias.nyman@intel.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> You could try it. We may consider increasing retries in mainline if
> this turns out to solve real world problems. Though so far, in the only
> reported case of 3 retries not working, 10 retries over a span of 100ms
> weren't helping either...

Thanks, I'd like to try it. It needs some setup here first (signed
modules), so it may take a while before I can report back.

> Any results yet?

Yes: three more stalls on the same host in 11 days (09-30, 10-04,
10-06), all with virt_state 0x40, each recovered by the watchdog's
rebind in about 30 s. Dynamic debug was on for the last two. Both
start with a single burst, and in the 11 days there wasn't one
"Transfer error" on ep 2 outside the stalls. 10-04:

  22:36:09.251 Transfer error for slot 4 ep 2 on endpoint
  22:36:09.252 Soft-reset ep 2, slot 4
  22:36:09.255 Transfer error for slot 4 ep 2 on endpoint
  22:36:09.255 Soft-reset ep 2, slot 4
  22:36:09.258 Transfer error for slot 4 ep 2 on endpoint
  22:36:09.259 Soft-reset ep 2, slot 4
  22:36:09.262 Transfer error for slot 4 ep 2 on endpoint
  22:36:09.262 Soft-reset ep 2, slot 4
  22:36:09.265 Transfer error for slot 4 ep 2 on endpoint
  22:36:09.266 Hard-reset ep 2, slot 4

From there it's Transfer error + Hard-reset pairs at about 275/s
until the rebind 40 s later. 10-06 is the same: four soft retries
about 3.5 ms apart, the hard reset at +15 ms, then the same loop. So
here all the retries are spent within 15 ms.

usbmon, 2 s from each of the three stalls: every bulk-in (0x81)
completion is -71 (571, 553 and 551 of them), none succeed, and
bulk-out and the interrupt endpoint complete normally.

The other host with the same adapter logged no transfer errors at all
in the same 11 days.

Dane
