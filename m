Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26854746B1
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044275; cv=none; b=BRwLdO882ka76vqh0U68m82GsZOVeyky6nbHFoSLF4qsAXsN9hoggH0DIxMIL1ThsVcP84JM2z9OLa5S2FNqS5ob1Kmtxfbq9hAQ0sLsl0hCbESuuDESwUbXf/fegzCB7Rig/OdFpxBqulBL9lT4Qm2eIXcdkajrdsU8lXIipaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044275; c=relaxed/simple;
	bh=qi/XtlmbEO8s/Kjru2891+qSMXrQ/XBaMKX6ap4IfTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QI0Tyq7ZWjvVta24/N25iypQRRaLfTc3e15tP56t5WxotezPi2ZZZC5pW6etVSZsEFJZOwHig/R2DWJ9MrzAV+Kjl6hnODaM1Dg80gHK0jOltkcNWI01O3psJazdCQ7Y4Cp5NGVwx069cZRdvFP9ZelxLD7FW3h+gZEq5bxF2EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzoZWb2Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pgzuKw/Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzoZWb2Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pgzuKw/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789044269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5R4tbNQ0lfdCRzGCDdQuLi/5U+jTDR24RinEX+4r3gs=;
	b=MzoZWb2YUUFTZo1T9OcEAvRseBSwtRpVLiXyfvs6kvEmIVC7aCVSCKgYKqK971iZrsQmYb
	JyeZjlLzY6LVhbp+5tsN7NwfwSyg504lP6ij1vPYi59qbPUauHaAeDZbOacK67HIzEFCCI
	EP/Wh4YisO7KLVzi0GZGF53wOiVjS7c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-X1W6ehhuObyP4R9zEUqPkw-1; Thu, 10 Sep 2026 08:44:28 -0400
X-MC-Unique: X1W6ehhuObyP4R9zEUqPkw-1
X-Mimecast-MFC-AGG-ID: X1W6ehhuObyP4R9zEUqPkw_1789044267
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49ccb223bceso6466125e9.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789044267; x=1789649067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5R4tbNQ0lfdCRzGCDdQuLi/5U+jTDR24RinEX+4r3gs=;
        b=pgzuKw/Ygz3UrOddEkOibdJG+2jW2p76kPWfFl5Wlhf0zM4AyRHG3Cngqm4nEVU90V
         laORJUBG97gqRYZKoK9K0cAgbdbERFPU2yrYNZXUzT8HO8Z/k7m0wme0u8RU8hkjIbRV
         6C9d39BwLOcwppZYNJSdGHFI32lCn8vkf/eh0jnoD0XzCe45f+VLnbNaFB7TUa1azSy8
         pZ/E7BVruvPArqgESOtKUysbgrOg+j1+6cwWzDjT9F7rJoBopcXE/JGXKSq2vuWC6W4O
         CyXa4hiRpbzwtcEirLfQApVYa1ISHjrhzM7bU4lUsFU186u1strbHoYbAmAiTLWHB9cm
         uVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789044267; x=1789649067;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5R4tbNQ0lfdCRzGCDdQuLi/5U+jTDR24RinEX+4r3gs=;
        b=Iy2b1MCj7+QCwCft0GbcGwpEQkyM95g+c6ATfk05Mt2lrgVXh87H3cN3z7ey/EPpSj
         t3RJ6VWgw5rDiklXUGdTNaPw4DIUAsPuOgtc86PwdakqTQyF70Z3ckASIAZVuumQJU/t
         NDt0NU9740+4ltPCBXBAgh/K/SR0c+hzuAz5Dr30iDeeAkOdWaZw7xADzKjAWDO8FaMS
         o4T4dntyJbd3hWvBXELfSdyztgKTOKvyC5Ot/VhVMv8h/fdU8r2p6AAMJoxLf78FGiXw
         PX8gmH/jb2f/v+xA+FnYIDz76p67Wmgukxlx/A74RVnU/bHTNkksbvGXFT78kfD4gHMw
         FLAA==
X-Forwarded-Encrypted: i=1; AKwUvBx9YcqG6edpjSbzNJe1yY4hIHK85M3gHiI5WKCmaPg1sEoJtl/vB5coFx144rZDw7F/6iH3OnI=@vger.kernel.org
X-Gm-Message-State: AFuF++m4E6mEhyxQbC4csov+pcxr6JV4xenRn8cBZAPqQVd/HYGRXmK0
	U8wlasR3BbasFFbtd1EBTf3+zLggEiSAPSyS8jjc8wUYTPmXQVZwvQT6YVbT0pWa50j/MbbmPRq
	SsyIZj6x5OY+QRB8602qIOtjdWB3C/MIw/cIlo4LxBygeNLNVRr7uYfU96Q==
X-Gm-Gg: AYBFou2KdhSxMoiu4j+nJe/RPlZzk/R2IyUM4Jd96dWyWFL8smVWr5BmdRljo7wNqFI
	9WUkyV5cTw3Pj4WsGUA6Qt1rwtfUOszdXIbcl69XPOXGdycbo9l6oPP+MQgv0LOCPhfONKpRBkg
	5fyi60kazWQS5yTMsDLOtmfcmMX0H7B/7aKYbV2WYXDKeSNwrW6Z64xlaxIRVBLHPe/77O6F/wW
	oqJQeTa7Bi8c8sLNO2Y31S/yHWsXnNURLpCGpPviFciHpIY+k+3CKgcQ3pZu6YEAXGp6sUlFSGn
	EhaJXLMyViP7JhS1X+4xcWVrVWx2wJdxcL9dPIIwtuoLb1Xbr+vwwADIdzehsXnAoXkkzKVEM1a
	JrCUkeT/ZGJYCOdGoNHxdwfZMtKd6BzBq7efKIoFRcMCe8iuGBzXXKySruKQlULc+2N+9YrhYsA
	==
X-Received: by 2002:a05:600c:c4b8:b0:49c:f13e:e52 with SMTP id 5b1f17b1804b1-49d26dcbc5emr51128225e9.15.1789044267095;
        Thu, 10 Sep 2026 05:44:27 -0700 (PDT)
X-Received: by 2002:a05:600c:c4b8:b0:49c:f13e:e52 with SMTP id 5b1f17b1804b1-49d26dcbc5emr51127875e9.15.1789044266654;
        Thu, 10 Sep 2026 05:44:26 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26bfdb4asm68440655e9.11.2026.09.10.05.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 05:44:25 -0700 (PDT)
Message-ID: <0f6f412c-e33c-474f-acd1-ad70a50b18ec@redhat.com>
Date: Thu, 10 Sep 2026 14:44:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] tcp: reject non zerocopy devmem tx
To: Mina Almasry <almasrymina@google.com>
Cc: asml.silence@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, netdev@vger.kernel.org
References: <fdc2478d8f21268d7078556409887d8e6ba0ad32.1788529053.git.asml.silence@gmail.com>
 <178896152268.219967.2387243409101048587@kernel.org>
 <CAHS8izMF+G38GorV01mxnvjMPGjPCDKJ1fFPiRNeK-thW0eB5w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAHS8izMF+G38GorV01mxnvjMPGjPCDKJ1fFPiRNeK-thW0eB5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/26 5:57 PM, Mina Almasry wrote:
> On Wed, Sep 9, 2026 at 6:45 AM <netdev-bot+sashiko@kernel.org> wrote:
>> Would it make sense to also reject dmabuf_id together with
>> MSG_FASTOPEN/DEFER_CONNECT and with repair-queue sends, or to teach
>> those paths about the binding?  The commit message mentions neither, so
>> it is hard to tell from the changelog whether these were considered,
>> which also matters for backporting given the two Fixes: tags.
>>
> 
> Yes, I think we'd need to exclude MSG_FASTOPEN and DEFER_CONNECT.
> Those are set by the userspace right? So it doesn't matter much if we
> don't support them with devmem. Not sure how to correctly exclude
> repair-queue sends.
FTR, I agree that the sashiko comments refers to a pre-existing and
different issue that should be addressed separately. I'm actually
quite surprised the model did not mark it as such.

/P

