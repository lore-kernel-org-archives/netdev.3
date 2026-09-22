Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3B453A8A7
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076235; cv=none; b=BEFcy8MAWA0FhKcxW0EvSmBXKqzJxpSFFtsPdp7A0gQ2LNzH8HxFrKqBF/GZ2SvjTiilqUGBRShrlmRWAzryU7jfCOpvr9y1L4DkY+KNedqacQoMHGNBVWSx7m17XITlrUBAh19EzR8XfF5FP8ZACRn9xPBKGz4KkBTk3W2cycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076235; c=relaxed/simple;
	bh=jXl1ULK454nM60julbrVhY6nJFLqiQco+Mtsod5YpsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cqj2ax5E536888g7Z9QFN3E5mGu9hYYKZGnKlo8VBDL4wn7lhYaoz99ndt/xxDl4h6kB/dvKufZThuwKNCMQffliK3z704zAHvJ6JoKBouhDErmR7gXmdXWCvMzxW0KHbreHCYgfPpkMSFaTeQR+4/as2bKrAERQQsYu2getbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUY9/seU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPUfLCxo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUY9/seU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPUfLCxo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790076228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jbma20fC3+gm45sO3uCEYISexy2c3xSdJhJmJ0JgBW4=;
	b=DUY9/seUO3+s788CEMxIoQCeFgKkU9DBLuqI6k4jipBxl3b1OtUpoHbOmQ07bRF/rsHopN
	ELK464OD8GKy0w7Nlepwp87f2VKSdwSw9TbSz5lIo5p9Cp4xs4e/o3KhK0fLLhBpqLATaT
	h+uJkPc1fCdTPB+MCnWhQRjJoKh5/pY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-97qwYKZnM6eaGJpbPbVJUQ-1; Tue, 22 Sep 2026 07:23:47 -0400
X-MC-Unique: 97qwYKZnM6eaGJpbPbVJUQ-1
X-Mimecast-MFC-AGG-ID: 97qwYKZnM6eaGJpbPbVJUQ_1790076226
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49fcc575709so31594275e9.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790076226; x=1790681026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jbma20fC3+gm45sO3uCEYISexy2c3xSdJhJmJ0JgBW4=;
        b=dPUfLCxoeUwW4ibOjCLxZenxL0IU9Zr2x1z/Ugp/aL3/r10ySb+McoePIwUZsO61Il
         HYcWeG7tWbPcB5Egg8yZXLx02HWfmVaggfBu4PjQ3EUeM++R33FI+VaIQuWYZ/9EdRp/
         FgEGWdhYSC5u0vqwT6fWfIkMrb1tFQouZGOQX1ndENVjwYqnKDcF1Vua1E5PJi63K+U3
         QnclGTtuIjpO9I7l5FJ4yPWQN160Ud1Lq6WbZ/ax7OCwbrOM464eBrBr6uae5+s6DZvZ
         EGt4AUqTuT+HbVyzMtstfbZryj6Ols9Qu39O2bLP86woV3XYB8NWZ0AQCCwQs3NtR1DE
         XiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790076226; x=1790681026;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jbma20fC3+gm45sO3uCEYISexy2c3xSdJhJmJ0JgBW4=;
        b=DpkKRu4W8FORfrkEv3BXob64w2zKKqHRqANTzWzKW6S0JK6MB4Uh2vnaxzIRdniShq
         YBgq1joGlcFntndSbsqBoYFfJeWkar08+DV+jukiAps0IgRojBJiZ7ofmvGdxlbZgz71
         vlolmDEZysuwp3GCqqra+ECL7Yb97VSRHHu1djSP7FxDPRKBQcEgWXNHvDOxbmmw188c
         l0OrYCi3PYo8r8SgD1UZTfILrmOu2rB86Fh4car5keCL0qIfJ9/D1HEWVJtcekqQlHkQ
         pkP/MqjHgNw5lF/th/6DyGhiIfvhpTxH6Rkba0UgoJqVIZNGeU8AAFoQK5K3ojjPWmks
         71Xw==
X-Forwarded-Encrypted: i=1; AKwUvBwlInr7Cl/5OeXxbQaOjzE5zSs0sY6Mz0mDZ9ffNnw2zPWDDAHftR4/C9+IAhQQUWPpaoIWt9g=@vger.kernel.org
X-Gm-Message-State: AFuF++kTG8vERZ+Rji2SPdu4VZhif2Zia8nP5tlQ0XFsJnpBtMd2ib/8
	OFoeuheSFT2eHcqxqLjUGXl3f+Z1FaQWFV6taJeBB4IDQISCtP37ZUpkTsyzwFkawKRYuPD22k7
	cJ7gr1s0BabGyVZIFeItj0IzbEWfpWQZrd7+qGvcO7JOaXmpbk0E7B2M+k36vr4Pgkw==
X-Gm-Gg: AYBFou3cO+G+dp6PCpOht+AzMXSfhshvWae/Z8FZqm+/3e7+ePdFLPQj3puYDRzOpHX
	BOr47w2QUepmbMBggnJIncMSCzs5rx0Go2KartSuoirP8oEf/7H2hZED3FscLRwwe1bZNH8GWjp
	GtW5DIxgpvmZE75kh/E/NI9eSeEtXwarsfJUTShpxn/K/3Hx9DUwkkgA1AwAArs7fvluyA0bfUx
	hEq0TcEf0gQdAIcSsLS2KOVyjDXrDtExmQsXtB7Sv1dHJc1Jmyw1d03GUhriNwrra4VvIAxNp9w
	a1TJbhr1Sfgd316hSrIAVSF4GBNJJxoJwqy8D38+mDUhLWLSv05l2+dO1gwLsWFjMFPYu1qNzxK
	G1ZRwTAmchP9TiXfyLkXXTLU8bnn3QGfHupI24PlwhMSni8tCX4pKZypa+6h20GF4yrDKu7lMMg
	==
X-Received: by 2002:a05:600c:c8a:b0:49d:433:c3b6 with SMTP id 5b1f17b1804b1-49fc5743da1mr201398775e9.27.1790076226281;
        Tue, 22 Sep 2026 04:23:46 -0700 (PDT)
X-Received: by 2002:a05:600c:c8a:b0:49d:433:c3b6 with SMTP id 5b1f17b1804b1-49fc5743da1mr201398405e9.27.1790076225869;
        Tue, 22 Sep 2026 04:23:45 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdace76e8sm58905205e9.1.2026.09.22.04.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 04:23:45 -0700 (PDT)
Message-ID: <d1293e11-ea27-4141-b085-268847d6f88e@redhat.com>
Date: Tue, 22 Sep 2026 13:23:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/8] net: dsa: motorcomm: Add SerDes PCS
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20260917185010.3189199-1-mmyangfl@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260917185010.3189199-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 20:49, David Yang wrote:
> Support in-band negotiation of the SerDes ports.
> 
> v3:
>    - fix build error
> v2: https://lore.kernel.org/r/20260916164310.3168269-1-mmyangfl@gmail.com
>    - Remove YT921X_PORT_MASK_* macros
>    - code style nits
>    - unconditionally write BMCR_ANRESTART
> v1: https://lore.kernel.org/r/20260909190541.466476-1-mmyangfl@gmail.com
Sashiko's feedback on patch 3 looks like relevant.

Also a slightly less terse cover-letter would be appreciated.

/P

