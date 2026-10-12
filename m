Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE74A387F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822696; cv=none; b=hgc9FkkZAJOALL8+lFADtETlv+FUscYzixqt4KsJDO4T6YWGG8xqcMFPhUVmNivv3IiiuvlpfaU3lVGPlJTQ306r7+BH0XEI5ObTXssXlUxAs/N13ccl4caFQLMtj9KB5it4tltChAHhogUb8y7YAT9nZokK41G1l0e9TzqB8Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822696; c=relaxed/simple;
	bh=YE/cfgIkaWn4hLF79JXYi5jbj5uUcOqqXVzm0nD6Bec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOC2NDKZ7vTsUGUSpgGxWMYnF9LpOXPtRgtzaTNVEwdYif1N098jbJezQlaP6/8bnBG/NicaZrNYsKF5iTVdZwvH7J9GdR6c7zp9sZSvwK/XDFJTp5bCVhjSIDpczVLHlrDDW9gvkYwhf3gf7rYyXZpHxWZjY6qTNncPa2oLVzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9BMJ52x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKLb6OT7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9BMJ52x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKLb6OT7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791822694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gf4b89vW8YSS4mKQIDLy0PYDoLH7aFx+4KKasUNEWcQ=;
	b=Y9BMJ52xNiql1pz58g/wbhtbhCyNEPutaO40WN2hFPDpBCaPqa5i0gXfq7G1pAvngJSK80
	dNPPgjpY2U4gw7hsnRnmyb0pgrL1v0dee6f/rClkPqIh0hhtGKnIWLtJi3tLMIINiR6pkA
	LY2KYRbiDzZbsFnm33my7GtTubmT4Go=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-iJfOxlt-OuCvqm8OgxYoxw-1; Mon, 12 Oct 2026 16:31:27 +0000
X-MC-Unique: iJfOxlt-OuCvqm8OgxYoxw-1
X-Mimecast-MFC-AGG-ID: iJfOxlt-OuCvqm8OgxYoxw_1791822686
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cdc4080ddso16114605e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791822686; x=1792427486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gf4b89vW8YSS4mKQIDLy0PYDoLH7aFx+4KKasUNEWcQ=;
        b=gKLb6OT7g6iKDaMpVlWjCDh4kCkuun6tXvu3+chruwxDoYpdBEksVhwr8PZjlYJXTX
         wpANIsj4Lptt6m/icm7zX3P8uDB/BKM/zxmF5OWNbczUp+YpZoPpgucGwHBtEy/jSKTt
         Fp2fd9q0ZQr6F6K/PLBMU+iDUOwJmhWYm5pzsbsgYq0kxTt5qLXwc3hddmdKQ8SBLn2Z
         CdFyujWWpXCnC3cLYKvgnKJEABpIOTHz26ujuUKH/hrCvaMjbkTSvSCqxHGeH+rwrY7g
         cNEZVsQGNkEPYXBIOiiJA2MQISbeJcBems7xedb/ICQa2d6gNrGhK+T2glvnrGFZ4oO7
         3Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791822686; x=1792427486;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gf4b89vW8YSS4mKQIDLy0PYDoLH7aFx+4KKasUNEWcQ=;
        b=uz++EHqQasyR/SryZtZGjNLlP20ShyJy10x6bJY8R0uNcGWKMJe5OStERGBgwz6I1V
         cKjJztzmlFj5u5LpHOyvAe0FfoohPfyb4DbjmQZsWIj5DX9GiZpGyWag1psbpzBvN6Ac
         dASpSQQ7vyUPUBoaDEb85uVuumn0N7NZvCJ9EkIESKYmSE9h1MpzdM0z2nTJplPeJs3V
         B57HyvNWM3BiOAh2scfUbYfRWDqOLL4TUBcW855X7ScLIV+GZLsZdA0oqaF7/7W0jtNm
         dQZEDTMjHACIg8CNh9eQAU31qAH9/w/tamliKEgnWtLq8GAfE/nVE0sbur+VrcRELkeo
         Btmw==
X-Forwarded-Encrypted: i=1; AKwUvByBGD9lekOly1duR8N2W0EjfINnzNj5FGr17+t5EtydpBj+UNwVeg/jwWJscUU2K5YAVHTxoUc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyMP5LlTBCZl+T3mM6MroicPQ5ozkBdM/t+uJqdfahvE+1DqPj
	yke9pLVS39LXleVCP4ZjsYtymPJFFFG04aAJwCMpc9DSMZ8YKk7M8JzzNtju4+CAW0diR6BYRns
	H+fLLiDQ6KXxF+QHmUV0P6UldgNCeacfEAqkSbBIPy3T4IlkDyIie3EHslA==
X-Gm-Gg: AYBFou1UErWKl9BF2k/suUGk9tu+vQP7+Fhh29st2hBSuNkeXIJ344j7VR954hE2ItR
	4rSxh4zjL1fOrc3Ja+bMDlbOPnfkS8F1RR0RILd4yI11Rz5+j96th1k9VY9q5wR0whAQhiseddt
	C+rlguk3k9Xza+6Gk3VbA3I2dP+HwE0Xu493QDix4cg+Xn8wSSTX+prR8X8p7uNV+VkOm/p2VqK
	nDWU7mI1Y20unnk3hED4vTbVU64IFIHtntmBx5DF4a6QoDcyu0CApF6rO4GgLy5C+bwU0p5WWhm
	d3oJ3LA7w4u+yyotb5iM4lywvDvav9zGMamKDwvTcbuOIVklWmj4c9ueOLwz5Dyg2ysg7/bjwOS
	B7XZ1sIFmTAqB/4PqUOh+stAfMXcIdA8Bd5StvMI6GJ9w+GH8ejVnZp8p7oeR7Gq41HSt4j7WbA
	==
X-Received: by 2002:a05:600c:3c89:b0:49f:fc4f:9efb with SMTP id 5b1f17b1804b1-4a18e49105cmr187993065e9.7.1791822685814;
        Mon, 12 Oct 2026 09:31:25 -0700 (PDT)
X-Received: by 2002:a05:600c:3c89:b0:49f:fc4f:9efb with SMTP id 5b1f17b1804b1-4a18e49105cmr187992425e9.7.1791822685431;
        Mon, 12 Oct 2026 09:31:25 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf1358asm303662345e9.4.2026.10.12.09.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 09:31:24 -0700 (PDT)
Message-ID: <24dbe3af-8706-4369-8308-d3ad558fea71@redhat.com>
Date: Mon, 12 Oct 2026 18:31:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: Don't allow disabling napi kthread mode while
 napi instances are disabled
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, linux@armlinux.org.uk,
 kuniyu@google.com, sdf.kernel@gmail.com, thomas.petazzoni@bootlin.com,
 alexis.lothore@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261006141119.85562-1-maxime.chevallier@bootlin.com>
 <179142548474.434549.4875313383372623036@kernel.org>
 <35a238ae-0e06-49a9-8539-9139aeca1a30@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <35a238ae-0e06-49a9-8539-9139aeca1a30@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/26 12:19, Maxime Chevallier wrote:
> On 10/8/26 04:11, netdev-bot+sashiko@kernel.org wrote:
>> Would it be better to handle disabled NAPIs in the stop path itself,
>> napi_stop_kthread() or napi_set_threaded(), rather than only guarding the
>> explicit disable branch?
> 
> Hmmm maybe yes
My personal take is that the complexity of addressing the issue for good at
the core level sounds like a good argument to fix this at the device level,
one device at the time, as needed.

Otherwise I'll probably got for the suggested path above.

Thanks,

Paolo

