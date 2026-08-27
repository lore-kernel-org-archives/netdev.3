Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B843B3C9
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787836788; cv=none; b=OAsWXomGfcaaHShfLJs/dgAeBoCUNBIYAutltbjponxEkByTASYSwGBXNvHeHdXwB/VsDEuYW1kGpDDk71zYw6So4qfPfQ3BpaCGwPzab+Ph4F95pEq48kZkUvtLiaoyeLSpLQCXOfmdCysoKSH+wNLbEZc4KfbqlYYXN75DVcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787836788; c=relaxed/simple;
	bh=5mn21hBIoxPeRo2MkrlYKNds8bYroM3TNKQhYAk+j1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbxJDLfo0GhdSRh94ym8uyXJLzTYL+uLJ8SufDEkySzDdqpn1DQQn8OXWefR8hIelVU52+bpWBfP21kmUxrB7YmEYqvaZVMbcwY2tpW0vE2IRB9TAA5wXYYRi3P8ORYbu0+3K8YbSB9+PHbLRWNGIFsYOHjOi0xdX8vUki2nIz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wr1nb1rI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mJICasWL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wr1nb1rI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mJICasWL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787836774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HynypMkWwm/Ix+imjLh8fo+dakQbHeB+2VX23TDHhHw=;
	b=Wr1nb1rIOg2bgAMR2QJtKmKtYZW29mcxfZ973flPoUQ/jRJSS5QZyBRcWYQgYQfo9hMw5U
	mx7iKauK0M8IyhBbV48GyVQW7SyUybKAIaf+QAM9U5W/NnE9rjZfDZMHE97eyC12f81zCT
	JFC3UJdgzpf+UjQvsFiIitBez6d701g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-b0ly331PPe6VbPL5arFXPQ-1; Thu, 27 Aug 2026 09:19:32 -0400
X-MC-Unique: b0ly331PPe6VbPL5arFXPQ-1
X-Mimecast-MFC-AGG-ID: b0ly331PPe6VbPL5arFXPQ_1787836771
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-499a8039ff5so20732875e9.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787836771; x=1788441571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HynypMkWwm/Ix+imjLh8fo+dakQbHeB+2VX23TDHhHw=;
        b=mJICasWLCacGfDQ5+L/aruw3VcvxULrcPPA+oYs2ee082DUkG7wN6m5InfqKeMl9oY
         Evqi/SQ8afiuRZSg1Mr1Z6KWTXPXLpicYPDNF7xxJcxql1Buk7X+HGjg8BFlR9R7RcBq
         HIiK4wH0KgOebTn0KKJlJhPQty4MYzVx57I8GSeNqtcbFxWnQ5QwG23emq7nPVYIMQsr
         LSxf4GLgKLUJsD8i0nTiS9CiVuVcrJC09ZzHYDwdBn1Jl7GbhIhc7VWbARaIWzglaCzE
         Qo0JOdQcI1y/5gH1osGbUKGSejJ4DVuAf2PSjyY5OEjedU7iBhWPB3zDFBRMNuyQtC9v
         Bb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787836771; x=1788441571;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HynypMkWwm/Ix+imjLh8fo+dakQbHeB+2VX23TDHhHw=;
        b=JeDRITc7TFAjIRUI4oxZu6cxpjlEGUJytaGkxh1p2J/U6B8BHdjQ0/Hus6OfDvt6Bg
         3cRr7kW3FWqQN5ha0lbTvngRVIh3nBMZwrSKLJ0ECH7rimLfA+2mD6/R8077Qb9zWVr6
         v/q0MFCARHF/kf4aVTSLKKgeLGkSycvIQmvQawP3MdhfIwtaAZmsW7KVmhIZTqM1ObwH
         LEX2CdXufmzDEoNNWBEG48FhsSFL5fR21GjotQmcXLNC5jK7YaHEa316YPkx/YC0b2bu
         K67FNzzMGlasLu27qeJbVMlPYMsYCYm2tOuPheRTos7mUIsKJ+bieTOCktc+yo7Dqhon
         Wacg==
X-Forwarded-Encrypted: i=1; AHgh+Rr33UK/c9k4vUXbHZX/QHV5/tk00liosPu5c/KlF2YISo5t1AhkgeyxIdjW/cp4VifjVWyHklE=@vger.kernel.org
X-Gm-Message-State: AFuF++kTQ5reeNHaNOxX5iKNaBg/QJTsSnITwVyDt9ajl7HASyJ/sSf/
	Q/OYdFIuiNhTes9v+ELxvuZ6i0/bUF3o3anUBCT8YMh2jB++FVHnR8QjdjvDoWCIOHP2t2O+Hzz
	5j1ljB1jxP+qR7RsrvJGAMS17FyjZoMEOZAO4MSNn4v+7RhBv704ds7JgNQ==
X-Gm-Gg: AR+sD12i/GlacJPg/VkpbZPACM+1F2rIsiNTE6BlLXYBmL9/Izfa/axdImy5wDsEewR
	wX6uuBg6ybYDlyOQ/5usNcta0DGKDcZflmTl4kW9BIMbyNo0kNMOH4RPK0WLm2UUX9z0UWiin0W
	oDv2Ac0A8Z+LicrYESfRPoSz8GT+sXR885moFNl4U+pRbX1WKVW3oyUOTTxLl4/fM7hrd6QAfFm
	fXzzexfH9KoxhwyDOKp9gaMfpVpXJDXcLpgext0sH+z3yol2G1rd1eQeEaOh6PzL+cQkUJ9hSUP
	ZlGC0r0C8e5VnG2g3IIXurO7mtTgIgpI9Klr7IAAOFCYIAXXlQ6lEk+S0BElVtrCWRT9A3C6SG7
	iajWS/s6kR/2j9Kkey72U9+bl4RRrk8VN23tINOelTBOXVHEnNPg+7nashSoZkX/ANdEruJ0=
X-Received: by 2002:a05:600c:4f55:b0:499:78b3:7b36 with SMTP id 5b1f17b1804b1-499dc720beamr188748255e9.11.1787836771223;
        Thu, 27 Aug 2026 06:19:31 -0700 (PDT)
X-Received: by 2002:a05:600c:4f55:b0:499:78b3:7b36 with SMTP id 5b1f17b1804b1-499dc720beamr188747475e9.11.1787836770830;
        Thu, 27 Aug 2026 06:19:30 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dd5ee752sm40645445e9.1.2026.08.27.06.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 06:19:30 -0700 (PDT)
Message-ID: <a0563aec-0ac2-47da-b03e-2e991a2aeabb@redhat.com>
Date: Thu, 27 Aug 2026 15:19:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v8 00/12] rxrpc: Fix CHALLENGE packet handling
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260824091645.415423-1-dhowells@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260824091645.415423-1-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 11:16 AM, David Howells wrote:
> Here's a fix for AF_RXRPC's CHALLENGE packet handling, addressing an issue
> raised by Sashiko[1], plus some miscellaneous fixes found in the process of
> fixing this, plus a number of things raised by Sashiko[2-8].
> 
> Firstly, the miscellaneous patches:
> 
>  (1) Fix rxrpc_sendmsg so that it doesn't return an error if it queued the
>      last packet of a call.  After that point, the error will be returned
>      by recvmsg() and returned it twice in two different places may
>      complicate userspace cleaning up its own structures.
> 
>  (2) Fix the use of len vs msg->msg_iter.count in rxrpc_send_data().
> 
>  (3) Fix error handling in rxrpc_send_data() for if ->secure_packet()
>      returns an error.
> 
>  (4) Fix the update of call->pending in rxrpc_send_data() in paths when the
>      call lock has been dropped.
> 
>  (5) Fix double IRQ enablement in __rxrpc_notify_socket() when called
>      indirectly from rxrpc_end_rx_phase().
> 
>  (6) Fix the generation of notifications from rxrpc after call completion.
> 
> And then there are the patches to fix CHALLENGE packet overqueuing and
> simplify RESPONSE packet generation by pre-creating the RxGK application
> data up front and passing it in a user key (thereby allowing userspace to
> partake).  This is split into five patches:
> 
>  (7) Expand the abort trace enum to be larger than a signed char as the
>      number of elements will exceed 128.
> 
>  (8) Add a refcount to the user key payload.
> 
>  (9) Make the AFS filesystem generate per-server appdata keys.
> 
> (10) Pass the appdata from AFS (or userspace) to rxrpc.
> 
> (11) Change over to using the appdata key to supply the appdata.
> 
> (12) Remove all the OOB stuff.
> 
> [!] Note that this entails a significant change in the UAPI for AF_RXRPC,
> with the CMSG types and sockopt to support the OOB queuing being removed
> and replaced with a new single CMSG type that conveys the user key ID.  I
> don't think it likely anyone is using this outside of my kafs-utils
> package.
> 
> This also involves a change to the user-defined key type, making the
> payload refcounted so that it can be accessed and the length read, then a
> buffer allocated that will hold it and other data, and then the content
> copied.  The problem is that the user is perfectly at liberty to change the
> content of a user-defined key (which will RCU-replace the content of the
> key), so the length might change when we drop the RCU read lock in order to
> allocate.  This could be got around by locking the key->rwsem sharedly, but
> that might be able to deadlock part of the rxrpc protocol engine if memory
> reclaim occurs.
> 
> David
> 
> The patches can be found here also:
> 
> 	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes
It looks like  some of the comment raised by sashiko are new,
especially on patch 9/12:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260812110129.979970-1-dhowells%40redhat.com

Do you think later follow-ups (i.e. in another series) would be ok?

/P

