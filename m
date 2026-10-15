Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969BE497B8A
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057357; cv=none; b=XXPXYkZwmpxA8uPaRAVyPGaWtmtM482p+4PQospBgXFBGDvZfv+YPmGF1Gwc6j9NtHgTcSNAvWJb4WVhfUzlpdTke+OeCIKFw+bBCLCzwe4GymF4n5rsFDxgxFnE9V8Kop24H99laXjDhMPyXmo5g6sfD7S6jh/Kj4Td7cnTJ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057357; c=relaxed/simple;
	bh=yvq6ttRHPiAv8pkpttwMQSYUvX9YzAAnSIjoqjDDjuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXyVNFy0VZFZ2bmCq1/Iuj7cw/tcFFd5VQLU9/hdlbBlYxrYOgWRaFdoqF/n4SgMiDOVrXqe5dV5HOHfepd6dCf/UbfUokRQq4l0jSuLDx072JaR7GSCEIsYMc0Ac1MvC3bJduAWvtaWsePSk43m9MOv4jASDqAYN9ergSvJ2Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZzoEPUm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ep9xo2KN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZzoEPUm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ep9xo2KN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792057353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zn1wkXYiN71d87RqqidqsthvjRH9zSTMQzZFpbrX5PU=;
	b=fZzoEPUmDywv5Fw2nn4zayyQ+SsSZCa2QsV0JdNA5LJ/sXep2Er8kdKkoVUD5Beg9XOXbi
	4NALI1vfxXW3nqhnp8Pf2aZyFlXfTfR3HPZyXncn6XYXaQvEsR3jskjvecxlDWVJgQOfdF
	DV7TnpFL24QeH9darmPOZUHAkD7yDbI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-rMvSVBDQO7W-EPcRhM7TSA-1; Thu, 15 Oct 2026 09:42:31 +0000
X-MC-Unique: rMvSVBDQO7W-EPcRhM7TSA-1
X-Mimecast-MFC-AGG-ID: rMvSVBDQO7W-EPcRhM7TSA_1792057350
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a170fa0879so40210735e9.3
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 02:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792057350; x=1792662150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zn1wkXYiN71d87RqqidqsthvjRH9zSTMQzZFpbrX5PU=;
        b=ep9xo2KN+TLkHQiQNTDv4VWEzskqg2eJP8x3bhYMpkG3c7AeAAFx3iCLBb7Fy/Fj3W
         8u6N+ntLMANLrbO9iTC11eEg1onAeHFn5x55qTdg5GUgFmwxzV9ZXReQ2I0rDo1+i1nO
         g4i1iwJ80Mt4BFZju0Z5XQIMEzn0+N4Z/6SykLIXMDPFUVQUvsW/LPt1uRVAA5mEPL22
         OAI1pLyRdrvGV8veWV0+ew26gJMri50nJyJLYHoKcKFF1Y3l9AoHUfWk0q/VYlOxQl6b
         3R+G3yrOsLyaJss0AM92noPfrE+Wb2MhZodY9w5iEdEdYrHZfsw5gBBw9TfQSdX+Rd8p
         DKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792057350; x=1792662150;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zn1wkXYiN71d87RqqidqsthvjRH9zSTMQzZFpbrX5PU=;
        b=ME2yk5XA47YRl3Cu5zT6GBxkZVPID5ZAI93YIF6CfMYuzXfcwBe2BrTdA4Ly/QQWK4
         JHHOrhP9YIfq+gdmVZ6W3bjfOMerYuUND7PbabdjGl4p+ocrMtUtKpvRU3q4lcK5GC9p
         +UkAke0CO7orQd03NWePRfBLiyFfVXa1Dp55Ot2GZVpFsLhR+++6etZCUUQO4ExiFAlZ
         V0Y9dy3q3rBYjq97MCemQYg6uJiZHQ3QJTD8MpcnVouDFikJ8E+vWhd/PD8DfOAUK31M
         JScoOUyLm9d2InYv1prd78T41vXBfCemaZYbXuCemQLiaQxwJnhSFdhWcEP1qQJwrVjH
         CfKA==
X-Forwarded-Encrypted: i=1; AKwUvBy7/9d661vIzuCKMes0aPXXJmIkDRqIYNfHqpnaGcg9WbZcl5OYDm45LdOhLYnhemjRoZUBcLA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLN9eHV8Kjh3TK3KKUqE0n9TaUA4/blwi7l0d88Nsu8Ok6YWebu
	QqoE8Y7/7BdHdafVn/ZUf7uF1IHTo9Vl+y0uHR0rqMGYqImylZHialpl9BifyVwlpevhvOFVpNy
	6YdRlvWDoARzhWtpq9AuzXqp9YuxEV6xJEGLTgX6rJC5KueTSf2vOPaYz+w==
X-Gm-Gg: AYBFou1AytancrNzkeBU0Hr8QQA/bNr+6f10myBa6zqnRQZyXVGsolhDKbyhqpfBLxy
	vhPpLWN/ZdVoc3zJHmxwnumEpaH42rxDSJB6CBv//OGjxUSD1KAvXZar1vkj1GHY9GXvgDkgtIH
	ldub+/fBvrAo1uGgsXJ4XhUsGi07p73Knf2IBxzAW+oaby6Ttar87FUK8Lq68E5XwlUaPwiG+iw
	Mjnj/k7LHMso4KEH1NE3D04kmwJT3OCFHgqiNZsUSpg4I8M3yn0PP71r1mS5852VdvWvMfZ1a7t
	Tw/CwZRnKCrvpqRNM5utcyzfr5TR9GeJCQKBurO/ZX17yAw+VhwZqWft6MMjAolGIwXR1heZHjp
	cmKsFd90uRrujg6fm9JC3vSuXfV5Xma1nkYCJQtx9wSvfOtVoFFrPxIcfyfYdPbxjV/C8auG/mw
	==
X-Received: by 2002:a05:600c:e549:20b0:4a1:96cd:2f6d with SMTP id 5b1f17b1804b1-4a196cd3280mr199460155e9.1.1792057350230;
        Thu, 15 Oct 2026 02:42:30 -0700 (PDT)
X-Received: by 2002:a05:600c:e549:20b0:4a1:96cd:2f6d with SMTP id 5b1f17b1804b1-4a196cd3280mr199459865e9.1.1792057349833;
        Thu, 15 Oct 2026 02:42:29 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bdc036a4sm65355755e9.11.2026.10.15.02.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 02:42:29 -0700 (PDT)
Message-ID: <5277963f-c6ab-4fa4-884f-82fafd98cfb0@redhat.com>
Date: Thu, 15 Oct 2026 11:42:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v12 00/15] rxrpc: Miscellaneous fixes
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261006133011.531806-1-dhowells@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261006133011.531806-1-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/26 15:29, David Howells wrote:
> (This has been split from "rxrpc: Fix CHALLENGE packet handling")
> 
> Here's a set of  miscellaneous patches, mostly found by sashiko.  Note that
> a number of the patches have been reworked and reordered after the last
> sashiko round[10].
> 
>   (1) Revert patch to rxperf to expect the magic cookie at the end of the
>       request.
> 
>   (2) Fix the kvno on rxperf's test rxgk keys to be 0 to match other
>       implementations.
> 
>   (3) Fix the update of call->tx_pending in rxrpc_send_data() in paths when
>       the call lock has been dropped.
> 
>   (4) Fix rxrpc_kernel_send_data() to loop around on a short send.
> 
>   (5) In AFS, fix various callers of rxrpc_kernel_send_data() to abort the
>       call on send error.
> 
>   (6) As (2) but for the rxperf test server.
> 
>   (7) Fix the use of len vs msg->msg_iter.count in rxrpc_send_data().
> 
>   (8) Fix double IRQ enablement in __rxrpc_notify_socket() when called
>       indirectly from rxrpc_end_rx_phase().
> 
>   (9) Fix error handling in rxrpc_kernel_recv_data() to distinguish between
>       end-of-request from end-of-call.  Upstream a return of 1 is used for
>       both, but we mustn't shut down an incoming service call at the end of
>       request as there's still the processing and reply transmission to
>       come.
As per off-list discussion, patch 1-9 are good to go, and David agrees to
move them to net-next.

The other will be reworked.

/P

