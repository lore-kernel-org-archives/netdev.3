Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18813D9556
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087292; cv=none; b=Qkd2Qt+UEzmScrW5B1Qbdcw0RND7SsR/2MrQPxau6ca1blYcGDKaMt1xTUP27S/gKfKb80I78cevhkJUMZxFIqEF6VJaKCQFlIVLg4oATw1gFDvdfu+CU8SGrWJNlC1PqVirSmWzauKKVM6ONVvG9usTLZzskvzWkpJaqGpsccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087292; c=relaxed/simple;
	bh=s/5B+FJ0WTn5q9EA5SnT0dqMlGOdbqpdeR+oencvaPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLJjm70E5uU/qSxT+KOxo89QoqhRAjtXvMtpQZUJp9KbDEq3/PNUcZG6ahvmcCoDV9VU3YcudqzIMI3MRyz/y35jitoAq9COfdINVvycqOR3grvUYIM0s/gBJgg0e+S2pyEDyPwbWcQADoIFxF8sWThgPIwkkJVd96eLBkrlK5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bzJpY6mG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTI31CY+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzJpY6mG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTI31CY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783087289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9sVudV1AmIA725DEib7SU1Ygw4pIBM5kk1omcc3FcUM=;
	b=bzJpY6mGMedUhUGhuduB2UCUbzhBr/r3o+Ie5sa9j2wFMssJpLhfml+qHncCNiaVnZR8Ec
	oFqOSTftdUOBJ736vfqTYt31BQb4SAiS5k8Z97iufN7cpfQzvZyljkqRbf4MwdMdLwwDb9
	JaK8mHHZCWHEsdr5m0qInLRDmyy1hnE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-nOkeRwe7P-GCO-Q_wqziQg-1; Fri, 03 Jul 2026 10:01:28 -0400
X-MC-Unique: nOkeRwe7P-GCO-Q_wqziQg-1
X-Mimecast-MFC-AGG-ID: nOkeRwe7P-GCO-Q_wqziQg_1783087287
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493a6fe9ebdso3453105e9.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 07:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783087287; x=1783692087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9sVudV1AmIA725DEib7SU1Ygw4pIBM5kk1omcc3FcUM=;
        b=jTI31CY+TbGonyis8mpz2JlDvCyo1I8iYrhVQ9H+48yWBe+D93/BhyxogySbuKYM2M
         bCET4YNcGvfNvOE2W7abb7LYggspVXKlh69sXDvziTW2jtiy+75i15QQD6hUugCVol+M
         qBB7YEiY9D1/3SJtTUTR1+BYwungez4A3GlBFwhqyXvhIRZ4gUanQiJuZSvttwzx2lzZ
         G59LB6z8LJqLn5e1vQI4IPcB3IU/4GXkLhUVNdnl233W+2RH5HwIfiw0W5ZgXLr0ES3K
         nf1CzxedlcdGuZvJA6bBwTTlIRhBu1WfaTIW+pYTi60YCpC452rpajP5uEMUkV/nx98Q
         xkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783087287; x=1783692087;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sVudV1AmIA725DEib7SU1Ygw4pIBM5kk1omcc3FcUM=;
        b=T1SSrYH6YTFIIej2Uc/r8SYvF/ZtCZOcC5YYtvhNjZ+r4n/ChcGEqE68RVEdVeHLCZ
         OU3ibUJ9x/i1e+avwqpNzLFjVbAVYxDUrYBcxanokdmb+3JOiK/uIPDMHXJsGgiA298G
         0emyHYo4Tgq16598BVHFEWuVmCwK1Bz3OHzUKtjz3uqbwhGALn3IT9uzKEEz7GqXEezZ
         BvdRyUAujtv635UKcHW5At6jlwkM6e4sJb5iMhyBqvpQJuh3zPsBLusVxrhhWBe9lZ29
         XAoYvxaRP5xxEDkzt2H9DwYTjFBgrnZ3tU+EBF/uzuXFkwWji91NSUrO80Frt2KYK/uG
         ESig==
X-Forwarded-Encrypted: i=1; AFNElJ92fgKQcK5ka9JG4f3LNCjDAnt/Oj6tcqaCSA80xhjP+uqUWFSDQf5lGfTp79iYYnOweIYhg88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY20GesuT1aMgPxcyY0nUuANPPYchdXUgOnMAJw7idCmAj/YzK
	1OXChlDtgS5wqXFezjjiBDBORDFSsOhu6DTKmVgAM1zupZK35Aa5W9pPvTocFpWLMMyA0iZUofv
	+N8MStPikdBcaCL/fJtb/4VoLtY6NA4h8E0JCbPMbFV90OmOxcEtadp+aFKiVRycmjg==
X-Gm-Gg: AfdE7cmhjWvcBnCLOvTNcCqCD8wBdzyKJqYJXTlPzt0WNlfj4JSDZ4Z6eCEgrP7pw9U
	SzXpNHdJAj1pBw9WF78872QyyVRDYnBY+q1OrD12UAFxFpv1NKaqH5YRD46/3oTn8diMYRxCEJi
	81XRLg4aoiZC2FNQRDu78LhCFFdxblcynYUG6MHNbPJUmiJI4Gd+ZqojMExMVPfkZ7wmSrnS6/3
	NRc2xKrVMEHSKH5m/Y+UhjXpsc0WG6YcAEjk7qi9Q6gm/Bm2dRwzsDVkoPRItINpf5iVsPwPdnx
	XY8YeoMuroDCh97TdIulxcK2fjKqGJZPlw1AFSwvtp8Y5O+Sopj/wPlSv6qjQdSuwGeAqQFOw8m
	6frmXgOie8RQ5D42h1MQXny8fHIjuSusCpvl+5BqQ6537Y89ae6JGr6hYZGsJ4fWMSL/p9sIGho
	kwF/EA6ml5eA==
X-Received: by 2002:a05:600c:c3cc:10b0:493:cfe8:5b36 with SMTP id 5b1f17b1804b1-493d0f09799mr106525e9.8.1783087286701;
        Fri, 03 Jul 2026 07:01:26 -0700 (PDT)
X-Received: by 2002:a05:600c:c3cc:10b0:493:cfe8:5b36 with SMTP id 5b1f17b1804b1-493d0f09799mr106015e9.8.1783087286225;
        Fri, 03 Jul 2026 07:01:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce040b4sm69568655e9.10.2026.07.03.07.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 07:01:25 -0700 (PDT)
Message-ID: <819d8e02-49ff-45aa-9eb1-25a631cd6ba0@redhat.com>
Date: Fri, 3 Jul 2026 16:01:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: sch_teql: move rcu_read_lock()/spin_lock()
 from _bh variants
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, jiri@resnulli.us, victor@mojatatu.com
References: <20260630150922.238714-1-jhs@mojatatu.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630150922.238714-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 5:09 PM, Jamal Hadi Salim wrote:
> This is a followup based on sashiko comments [1] on commit e5b811fe7931
> ("net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF")
> 
> Use plain rcu_read_lock()/spin_lock() in teql_master_xmit() instead of the
> _bh variants, since ndo_start_xmit is already invoked with BH disabled
> by the core stack and the _bh primitives can warn in_hardirq() when xmit
> is reached through netpoll or a softirq xmit path with hard IRQs disabled.
> 
> Moves rcu_read_lock() after restart: label + adds rcu_read_unlock() before
> goto restart (fixes the unbounded RCU hold across retries)
> 
> [1] https://sashiko.dev/#/patchset/20260628111229.669751-1-jhs%40mojatatu.com

I'm adding a formal:

Fixes: commit e5b811fe7931 ("net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF")

to try to avoid backports of the latter without this one.

/P

