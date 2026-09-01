Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E73C108A
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265729; cv=none; b=nUrHp3QEiaGdgPNn/psch+bEGxbpdHH6Rli3BukFEJu49Z4WZpDZHA9UnxyH7TUcny/5m49g1RjvHXf0L34gfucdtP4DQZG4zMz9Cp7iO8YY2iuNVNvAXeo73aqgaDO30l69rJSbWvhw7+zJkhHCDNHO+fKrTC9/SRRNA48ODh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265729; c=relaxed/simple;
	bh=uW5IpcCfdHEQSmaxthsTEiw3Xy8qTsaPJxs6r/lEbKY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BkOmtE8sXREr3IxdhmCuVFcP1J5S0KzPxyjSES2F6BkI7aVAE6VrdHRQ0TjlXoUlmR9GTj6LUrS4d021gN+3ogb7sc/psoOldrAMbgkgYaRHSvaezDsREj7pl3R7VF8VKpj5gpkji0qaGO6aPDSRyAS9XsSrqNrJeizo2HKg8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1A19Ay0; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1A19Ay0"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e85499ffbso81747385a.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 05:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788265727; x=1788870527; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uW5IpcCfdHEQSmaxthsTEiw3Xy8qTsaPJxs6r/lEbKY=;
        b=G1A19Ay0IvK0ilLps6KXsH5d8lS1ztFmCAmnMd1cNN9AyVe3W7junVcQi+dKwyBm6y
         Imwe2qTJhu1dUwoCYTgFULB03k9HtBQOk7xzdwEXPQeH4OkrxVXn4j9IgF1y6CZ0fGXZ
         4vNRPXx0Pg7RGspNCl54yBZPya2DvfAiBwKJVlIJkxB79hWFQD7S3WeP8c2wB9uYrC3v
         B04TeCkCgBIeVIrJ9DJyxA1/5itZqsy++1yIhNmPXIMBBPNH1aH2iaPh4Q/xfWvr2G8F
         J0zHkPccp32USE/IyDIUpPdJtwhAGsLomyByKNLVLVuMaqiMIdEYQhAbTv665hTmkerT
         /dJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788265727; x=1788870527;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uW5IpcCfdHEQSmaxthsTEiw3Xy8qTsaPJxs6r/lEbKY=;
        b=hwMlsNKEBRwzIvqpEoAj0xj41tsnDUf/3+JHwSzA3vYlbEbHPFxcnu74hEV/HeDK0a
         mrguF89rgk0i4PkJ7tufV30W47VT+o5UYo6YvtSpbngOCfrTed7LWCqNsH2s7/XR8rGk
         gJJHwHS8fIiMs3IYFtQqZe5ysT2qMrFuDemBnddP2/MYGFnOHH5aJNeWe/6k7o0orE40
         exxGQ9+QmJsTxkIg6oxxjJ41pcExnMxNVvJ4cNoS4RHbUimqbimEGEhjxP8hzw98Vhin
         pXE9Q8KhpJM24hv1GjnnfjISLvxn4B/vlvypTJw7EtpuPtQt5mBBz2tYDQO4wFGasGkj
         V8Eg==
X-Forwarded-Encrypted: i=1; AHgh+RoC/9QIkaOaJ2+4el9P2y0l6svMzcBe2Hkk9e5u+JzS0hKmNoptW1mCrdBGnW7qYFQzF6WRVVc=@vger.kernel.org
X-Gm-Message-State: AFuF++nD+JXj2FhzTd0o2Um/XOvGLJUdSZmbXzeLSxMfoVdsC/6l8Z3N
	WYzOxngATv1Qp+qqGUW+lq2ALm+d6nWLl/zOCz+u91JaXQmRGPkujRBA
X-Gm-Gg: AR+sD12y7xYBOte6kB1lORMGQCyl+Q/goCnHquOVJcnrDp3jNzNjf2qujA349hF82U+
	WFN33C2Fm0ARGOjl5nJ/HEjwOWeMtqkEYdDTEmEZ+5XEhKB7Gq8SX1DEOp4BKOAYf70d/BLY97b
	i9z695cUK7kFn9jVMPF5pYX27tSgZOTfkdB+zoh3nuyzc/thL2z6KTnQme0lQAUxplB961DeKU/
	tiQgvV5ZqXeVcbuq0ogKz8zCdVYuXSiRDytQDtklDWpqlZNuRWxunE/P4/l1t1mjqZVrTrgy2r9
	HVt4T3P8SnXT0A2oxnCXOhobthT3F8GJwEEQIWuSvVMzBd30Jc5EE/TZXZRsrI89fnMVKeMQnxR
	SUNmsETpz9KwoyxnKT1PYQUyGwOOHKgpasMYJlWqNs26QLi+V5UCrAr3hFsHJVPWx2Y/TU2iKwc
	OOKnuIQo1+KSjUDu3T++XRpt7Tsrq2cNw7zWYQfBepAufTXL6tJTXorQNlmstfAWISpA==
X-Received: by 2002:a05:620a:a0cc:10b0:930:a26a:fb2a with SMTP id af79cd13be357-939137af782mr2940063485a.2.1788265722830;
        Tue, 01 Sep 2026 05:28:42 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939170142fesm1016077585a.7.2026.09.01.05.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 05:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 08:28:41 -0400
Message-Id: <DL3ZAJ3NEDKQ.2ZUNLEUPN0JIF@gmail.com>
Cc: "Eric Dumazet" <edumazet@google.com>, "Kuniyuki Iwashima"
 <kuniyu@google.com>, "Willem de Bruijn" <willemb@google.com>, "David S.
 Miller" <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Simon
 Horman" <horms@kernel.org>, "Daniel Zahka" <daniel.zahka@gmail.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: psp: do not inherit the Rx association on
 clone
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Paolo Abeni" <pabeni@redhat.com>, "Norbert Szetei"
 <norbert@doyensec.com>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <BC10EB92-ABB3-41B2-AB16-266BEEBE18C0@doyensec.com>
 <924455c8-9f62-491f-ae3c-ea2127f46769@redhat.com>
In-Reply-To: <924455c8-9f62-491f-ae3c-ea2127f46769@redhat.com>

On Tue Sep 1, 2026 at 6:01 AM EDT, Paolo Abeni wrote:
> On 8/29/26 6:56 PM, Norbert Szetei wrote:
>> sk->psp_assoc sits past sk_dontcopy_end, so sock_copy() copies it into
>> every socket accepted from a listener without taking a reference, while
>> inet_sock_destruct() puts for every inet socket. psp_twsk_init() does
>> refcount_inc() for the timewait socket, so a child closing through
>> TIME_WAIT cancels its own put and leaves the association with one
>> reference and N timewait sockets holding the same pointer. Closing the
>> listener frees it, and the timewait timers then put freed memory.
>>=20
>> Rejecting the association on a listening socket is not sufficient: a soc=
ket
>> can acquire one while established and then be turned back into a listene=
r,
>> because tcp_disconnect() leaves sk->psp_assoc in place.
>
> So rejecting the association on listener, and clearing on disconnect
> would be enough, right?

I think that would solve this problem with sk_clone(), but clearing out
the psp_assoc from the sk anywhere other than the socket destructor
makes me nervous because of the risk of leaking cleartext to the
network, or admitting cleartext the receive queue.

Specifically about tcp_disconnect(), the write queue purge won't save us
from skbs already queued to the device. I suppose if we clear out the
sk_validate_xmit_skb hook we have for psp, those would at least get
dropped first. After that there is still a hazard of the psp_assoc
cleanup deleting a tx key handle, while tx descriptors in the driver
ring are still referencing that. That is something for which we rely
upon psp skbs being socket owned until the driver tx completion path.

All that to say, I think the fix here is the best option.

>
> I think that would be preferable: it's a pity to add safeguard code to
> the datapath due to a syscall (disconnect) used mostly by fuzzers.
>
> /P

