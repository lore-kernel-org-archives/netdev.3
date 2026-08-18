Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01CF448BAA
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046933; cv=none; b=tOpCVIXJriUjS1VVKCGGnkHZOWVc2FIOcsyjs7SZgoW8dl6/MwlqovbepOHtxPGLUkH49cCzXG46YK3c5/6diX93FBlnp8dCwY5KA/Y05uhUarI8H7uMXbZjzBcyLoxil9l1QMBG2uraIdVokV84ZwEBAisEXuh+rIohMCI3ZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046933; c=relaxed/simple;
	bh=G5N/1P4tgPKJiTNqI9LhLfy7EnqCoOt8XHEWqd8ra+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCNJpPIBTqhqAjI/dY6FYJRl6UBs+XzLy26g9B+dnGg2PcoNeCMZr4wmywwAYnjZqOUIqpo4I/UpzYOpSO5otk0L6xZRSOW4qKhxP7VD3xLrbsNIR7xjdzW7ZyruDur+3bOeyB416c3CWr7rorNkGg7gJ4+bRJmWHMmUJsYmNv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+lTtHOY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTABBtDh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+lTtHOY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTABBtDh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787046930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzLyV2lcKHHLoWDo5LKsA50uXz/DjTRarleGKzV+N0g=;
	b=C+lTtHOYTlyLPX3q12fEgbZTsC5Z13YyHoF+gyeVEalhfJLPIRvTfkh2Gu1LVjPJbkif8g
	L4nVizlUMxVWFo8kpZEopX3mURGbKBEAY0s5x4OyjDHhLm9fBD4Irytbi8k4C6k0sANq10
	v6kAfbrmU4a0eVGVygZWWk7RekLuKW4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-DGlRg-wQOuupUIkDQvB0FQ-1; Tue, 18 Aug 2026 05:55:28 -0400
X-MC-Unique: DGlRg-wQOuupUIkDQvB0FQ-1
X-Mimecast-MFC-AGG-ID: DGlRg-wQOuupUIkDQvB0FQ_1787046927
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f8398ed9fso3634558f8f.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 02:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787046927; x=1787651727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gzLyV2lcKHHLoWDo5LKsA50uXz/DjTRarleGKzV+N0g=;
        b=OTABBtDhE4Fx5/34bP5UO/K5x3Ci9DV/OmUOEYnQ/DUNVW7ClK63MOFyqTta2VfeHW
         +0RKVpcNwl8qRF7OVAzMi4gR87FwedmkV6X2lcnrW5jgQ46MCnBjoWD9cpvUaX9y6pOc
         jywZuABumLbfEDUZyT4vVhOakU3J8mcrilxkmexj4By3egFSFd2+l9N6BxtisgoY+dgg
         e/+xZU7quTGPSSn11/Z3Rp+IyuyTFdDW6m9bWid/WUdQAH8T6tr/Obrhj9twwedSbPBv
         OrjjSvOroSiH5r2sqIsKnGZ67MyOvpLs+IYI3mr6jcIzLwVHerOhx/6FKp8smMOcsrwN
         nZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787046927; x=1787651727;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gzLyV2lcKHHLoWDo5LKsA50uXz/DjTRarleGKzV+N0g=;
        b=B2CbRWenFvgB7ljmMKWQTwvilFA2Z2zPuF0sv0vQQZ+f4hMborU6DcXtyeTaQNPCDr
         XqWKwEz+UiWWrr34DqxkAPtuJwsO1SeUBlAa209B6HqVxUT/Mh/FIzH1JAEI8DlABvqn
         weO7dTWKmUYHt4gPzqy0JCQMlhn3bh4I++OZCym1AAZtiTbYQVI6wagJc1bZiTcPDq9H
         XM5LErkVoskVM0sdREV5FKOk/SRuL8wG7aulTu/KxY8sC3Y3SX7NLR4DDtsb49r+QPTe
         q2mEr7p7AVpuITmLmK/ps55+SQqF0fFPv/b56vM+ZOe2pwmY1pt/VSGpIW4pHsXdB6dy
         xhrQ==
X-Forwarded-Encrypted: i=1; AHgh+RrmFrA8evGFLSQ9+qFZw9LWz2ndn1i7xWYZzyy9/7Z+MYZOBBjidTenKie7YgiTOkSQxSpeytQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt4TF4LSY6ZB8pK0EXHwzpAg73EziYPogt57hWgtLlPgvaNivI
	Csa+3dIeW9jn8wABbZ8bxinPlfnAZMo9Yg06rA/83PnqGPjs3f0bV9I3tBFwWKFo+Zk5GYFJK4z
	BMwbj/U7Gqrrnxd8Za4YWtRbYZN9XddNS+CrdFg/TCxrzmKXpij2cQy3yFQ==
X-Gm-Gg: AR+sD12TB1khoqMnayk27KlG3Drugf6Esrj4lHK/DZkgZNJ/rTUpEoQ07r8jJy0WXtg
	6FXNfCc5LTUr2w3aHVbyshbPwKMpKEKXuSeHQo1kbanis1NgA3trAAC/XTGHHANshEswKa/HRMj
	So2DolaKxpUEUkEgq+kXKwKsFt+r9AgdsLnNuO1Fn3e5tWfNQQ6qCvTBkskLWY8OqFASD+eg+uV
	qkOfuDJ2TbLXGQDQMT+u5JtE4+HCl5ltyibg+3nDu2QAjPI3NksaamJOzI7WXgzosDRKD3gIGKl
	ngnR7Eimm4OQveo01roa2lBa8drAP+oS3n/lMoNWqktwnZcp8u/nsnXVDi+xPeMQ0Qfwl2C8KZ+
	buwuUX8fNx2VFy2EjdwFbc8yJksbZFzUdyeT2ctK0Lq57oIjha3VIpifL62b/dEBWWIKZIGQPRc
	w=
X-Received: by 2002:adf:e00e:0:10b0:482:aa2a:52f7 with SMTP id ffacd0b85a97d-482aa2a53ebmr7140786f8f.6.1787046927215;
        Tue, 18 Aug 2026 02:55:27 -0700 (PDT)
X-Received: by 2002:adf:e00e:0:10b0:482:aa2a:52f7 with SMTP id ffacd0b85a97d-482aa2a53ebmr7140718f8f.6.1787046926833;
        Tue, 18 Aug 2026 02:55:26 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7bc7bsm10156089f8f.23.2026.08.18.02.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 02:55:26 -0700 (PDT)
Message-ID: <9e4887b6-3bb8-4db8-a52c-67c1db345cc2@redhat.com>
Date: Tue, 18 Aug 2026 11:55:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/3] net/sched: u32_change() fixes
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "Hadi Salim, Jamal" <jhs@mojatatu.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "edumazet@google.com" <edumazet@google.com>
References: <20260813122242.1690024-1-jedrzej.jagielski@intel.com>
 <ccba8112-ff9a-47ea-8b91-a732e28b555d@intel.com>
 <PH0PR11MB5902885C0E23D5DEED9011C6F0A62@PH0PR11MB5902.namprd11.prod.outlook.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <PH0PR11MB5902885C0E23D5DEED9011C6F0A62@PH0PR11MB5902.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/26 9:46 AM, Jagielski, Jedrzej wrote:
>> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com> 
>> Sent: Monday, August 17, 2026 2:43 PM
>>
>> On 8/13/26 14:22, Jedrzej Jagielski wrote:
>>> sorry for spam, previous series get treated as incomplete so resending
>>>
>>> ALREADY ON NETDEV, SASHIKO RUN
>>
>> hehe
>> ofc, the above does no harm here
> 
> :D
> 
>>
>> for the series:
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>
>> --
>>
>> Sashiko has found one more *preexisting* bug, perhaps it could be
>> handled by one more fix in future series?:
>> https://sashiko.dev/#/patchset/20260813122242.1690024-1-jedrzej.jagielski%40intel.com
WRT to sashiko, please note that there 2 public sashiko instances; the
above and:

https://netdev-ai.bots.linux.dev/sashiko/

both are feeded into out CI, but the most relevant one is the latter, as
it uses multiple models and feeds in the result from the former.

/P

