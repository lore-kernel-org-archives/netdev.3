Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6932D52ED35
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887920; cv=none; b=eFFuMmuxzWj1NSQls7UAN8jL40u4oBIKXOxm/QUKEpiBDu5pY8LdDmPGOkk1KsWWMNbSKEqfkrLq3hOvaRIgqwkInZZW3cbTeYVgOaUR+94Edddnk9NJSPyE7r/OIsyp2iHrVP3LaC9V+Qql10l051R3YEt8JiIlfZHjJEbSfLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887920; c=relaxed/simple;
	bh=pK3v8GX0nntcLuATnAiIxLnfZjvCqyZw+OLGxqqCRRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoMWdN2DkaBY4eqiRNeFB9zaHu0upvXcSKsZ6zoutusrcrOL0PpjuCNirDFpZ44cS9jRck9yo5f9+wgOrL7VGXAPK6d1MyfGKNuY1vEHSWG3w/aZmU9vm4qEC+JjaQDYyeCNlqbJ8xZc768hV7Bd2mtHa81cqzJe4/18j6EWduU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xm5+4Eea; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sPvVFoxq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xm5+4Eea";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sPvVFoxq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788887917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kXXbhFtHbfVoqpSVY8nkO11mcdqTbDX0R7Npj3gEJs=;
	b=Xm5+4Eea/lqSvojEPRDZWvrJ4z0nf5F+BorbByJsfY6OGsGNQ9NvKApuIq1tFYjw1B5h5k
	GEk6oiw7GwK24VIrtRUYchtWhxL5r0Ulfm3ONAH2HrMRRpN4Z6Zk5UqHFSUmxbPxj3REbc
	CmhjJPqHIqr+V4FQgH3njpxCtbalD2k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-5S90RvpDMT64u9f5Shp0hQ-1; Tue, 08 Sep 2026 13:18:35 -0400
X-MC-Unique: 5S90RvpDMT64u9f5Shp0hQ-1
X-Mimecast-MFC-AGG-ID: 5S90RvpDMT64u9f5Shp0hQ_1788887914
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cd55ee2f7so41804335e9.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788887914; x=1789492714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9kXXbhFtHbfVoqpSVY8nkO11mcdqTbDX0R7Npj3gEJs=;
        b=sPvVFoxqQfdmsks/4smubW4dDAcnNH2QFw2/4KOkIiP5CJzk5iiyTk9IwSkYzkU2dD
         vkgZ93b7MS1KixzJxA+PfVTG0BS2afwHFL3kVhe06OO4tupCiHqCDs7cNbT5yrfNvFbp
         1Hq7b5yilHZTProhJflqR0ZsGxqeAmosNOPwi5mqrxc5CAByRKs/qOQhX8RnoP2D+PlE
         IWpr4MNzgQgeMGjae/FgKd0WpWAEaSrJt7xCsHudLZ5CkK8EhfkYFELZz3KmNsA+pB4Z
         ZnFvX7Mmzs4eBSq40sw88IfgxGzWzxYZzKevGJCaCXRQnnoNIMkBEoQDMXwEX2UJ5pRF
         GemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887914; x=1789492714;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9kXXbhFtHbfVoqpSVY8nkO11mcdqTbDX0R7Npj3gEJs=;
        b=UtW5JMyVv7repwvmmMpRYKgU+ZotAMGQ8o9kFCGDeKWDPVg89b9SGPE7iTq0CTSwcc
         vCrkEG4GMjH6az2f2uF8SCEfYRHM6CvMRybmG/eyDr/EjO/eF6cHa6CIXOucIcRY1aVU
         PXmvlCFcmTnynIg9r7v8yjXwchz5rlr780Mr/55tqaUIYai43Cg9Xe3QVjRBeECrLrGK
         9UxJJIC2knmbWOAHSNQm33PmnHFZec7jYACYclxvivtsf2y7jpB+CLp3p594nLdXKHuR
         GBWPn7tIDKOJMJM/4ym6I8eTVzjtb2y5+KUzckCDErJC0irqZnWJ2HHajqWRBDfQOKwX
         GptQ==
X-Forwarded-Encrypted: i=1; AKwUvBzzHMQhCWCiW0VraG7reUK3lZHZEHY/9Hd6f3bJddGYS5SMlr0nAys4uTAGxD6LPipsBlG+0sM=@vger.kernel.org
X-Gm-Message-State: AFuF++lzdxeBGZ7PHG6+vuLw1+dmnq9sU1HKbD1srzmQY8j3TKvNoJcF
	YfH+qY8+33VGpA61qAPQE3ear5Z0L4SGFTJZbFHJW1FFbDepLovkdPV+WUk7rXqtX4NUqI8xrAa
	sCasci1W+AjoO27lRECHlbbSaeBzS0y3snZV+X7ob9uHfBOHfam0+ETRJ0/HSEpZXGQ==
X-Gm-Gg: AYBFou00Gsl183poQl0Wcqmlq5LYXyulzxi5Xeo/apK8cKKmE1o+W2qpnR0hQuofrjp
	3UEy2qWHztStziRA+wDwVGUMo284bjoxgnYaj9i5n1et+2D7meB2k04wq8TlN/fsCjrmgyoRHm3
	MRZ+ghr+M2NfGBQU9dP+2fF8iJVpf0bYWzd9kK0hPlh6Y6KjAlkQwSqMWNEqfTo6AjNG2V3umfB
	Q7X3+D2sh1wWydusDvQrnv+RIrgEsgyKKX8/uuXRdOWnASvZsBwzmwAFqR6xHrNFT8LKFuw3AeG
	J7JYqzhxTySncxlCveU9wdKF4SVF/WxlRm6ewZGEDJhKAgXb4CehU3Hiiy14gV6ZqhSK6aoeSOc
	fpPLB5MM3rXdSaPkCRYhF7NvkrhZ1lVneyUu6yWUMz15BnXaIpm8MEl+Qbn3EPNrbPjp5Gzy2kg
	==
X-Received: by 2002:a05:600c:198d:b0:49c:fa21:1c7c with SMTP id 5b1f17b1804b1-49d1ed0b452mr11152325e9.17.1788887914421;
        Tue, 08 Sep 2026 10:18:34 -0700 (PDT)
X-Received: by 2002:a05:600c:198d:b0:49c:fa21:1c7c with SMTP id 5b1f17b1804b1-49d1ed0b452mr11151945e9.17.1788887913941;
        Tue, 08 Sep 2026 10:18:33 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff81c9b5sm283339925e9.4.2026.09.08.10.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 10:18:32 -0700 (PDT)
Message-ID: <f3ac2cb2-7ef9-4faa-8c55-a898dc1f57cc@redhat.com>
Date: Tue, 8 Sep 2026 19:18:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: macb: zero the link settings taprio reads
 back
To: Aleksei Sviridkin <f@lex.la>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux@armlinux.org.uk, vineeth.karumanchi@amd.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260903123652.23900-1-f@lex.la>
 <20260903123652.23900-2-f@lex.la>
 <6cfd72f7-b6da-45ef-886a-7703027a55f9@redhat.com>
 <20260908153253.4144665-1-f@lex.la>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260908153253.4144665-1-f@lex.la>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 5:32 PM, Aleksei Sviridkin wrote:
> On Tue, Sep 08, 2026 at 11:44:55AM +0200, Paolo Abeni wrote:
>> Not blocking the series for this, but note that you should actually
>> specify the model you used.
> 
> I took the bare form from coding-assistants.rst, which asks for
> "Assisted-by: LLM" since 816d9992d9ed ("coding-assistants: simplify
> attribution"). 
I actually I had to sync-up my own knowledge, sorry for the noise.

/P

