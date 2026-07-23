Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514C3803D3
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795059; cv=none; b=M37M67T73Ka4t2Zu7AEsNspJFfWnVOR6KhxeiIrUZ3ZgrvUQaH84HN6MrsnpvKt//lZe1I44AJCV/8sPnBd59Pe6PEK4dQx27J3V3vDe/jnBJ0ibFC4NqpkS8Wh8xjDBeiUiBhLPEAzJgJd5QAFbkeHX3zUGr9yUtBaEBrsSrY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795059; c=relaxed/simple;
	bh=0rqfheA5EIXH0AMcWpDhTeseyxtr6Y8S9xKkiNg2LoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2lsJxX6cr6sTxwibGj3rEaqcBP6eRxW/5nIK+zQbuHhNbo8QlwO4TFmybPHa6XQqLGuU1qcO4P2EKm4gTmcLON8SachFnopUVk6mYTW/uroD7NR+7K/7y87vWpejh9l6kMSC8q3dbVhUKiZ17LsVpVxwTC/n3iOMYCscKPZ+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZScKSWS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q8fLYij1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZScKSWS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q8fLYij1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784795056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c7H6Kr57Rfp4anc7zWKfgtlCWOPHxbgtuQqU6WGrAM4=;
	b=UZScKSWSHFDI/9suaCSppejppn9EimMe/5YrC/Ix1vMONQNWBdqqaIJ9W1ajgq6FAGbDmO
	1at9j6G7aKm/dCeWHvLneDmqcTH2fgMPxI3CSD82NSGVl2RdgU5WepUQdBi5A8P0yw/zYm
	u24IpAu2cqNdG3LDZ+KylLok6qKZ0tI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-TPfkhoG_MVyqa_CkVY8glw-1; Thu, 23 Jul 2026 04:24:14 -0400
X-MC-Unique: TPfkhoG_MVyqa_CkVY8glw-1
X-Mimecast-MFC-AGG-ID: TPfkhoG_MVyqa_CkVY8glw_1784795053
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f6db77430so218964f8f.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 01:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784795053; x=1785399853; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c7H6Kr57Rfp4anc7zWKfgtlCWOPHxbgtuQqU6WGrAM4=;
        b=q8fLYij12f2AiX07UvtcP8HeJtzWbHJhQBxU4b9up9ltue4x/fsbVINcRxDL60zX71
         E7K9VYUKNUUAs7C3PozipkOjGvRw7a9OMgDtFCjtdwNTxt25a9C9bRGyB3VrkWlbLTor
         F51lJa7mg8zK0pwfsrGUeK6y6Ov2fgKuP0D3CHHdibGtRAzvRd7+mm3CTWzDG8SHJm9D
         JL7BVd46Y2AgbWheSxSUSjGo43idpDauxmjE526i4mn9/xKf9ox+4czlpy1e/3saZDwd
         tVNn2fEsdfcY3EgfQnc2ZlHPu90g1J11iGd/hABrRyQrjNfmi41fNvPOSZHK2PKoA6Oo
         +qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784795053; x=1785399853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c7H6Kr57Rfp4anc7zWKfgtlCWOPHxbgtuQqU6WGrAM4=;
        b=aeHrqPro7oGqjqx7Dee6Dg8j2NsV42cHr675iv36Aqm1UjSHYa2zFs1i1AXAjJhCfS
         Z2CC0j52LAIZ8hXhAA5TAmc7tUVRGTZ18LDbJqcr9rmVJ8ALQnBCjatP0ZUSKz4xaiTG
         Dzx3HTtKLoU9Kdjo+NBMs0bk1TvaHM2/dSAWlAm0fCIR+Ft6RTh7jG7Io22E/9ze/B2D
         6ZmkhtR/yOSNft4qWa+nCwIYHlQFIJwRHaUp+bWZIdtiV4cSjN+afOnUd1NwdMMHKJke
         Lzb8ovCH0coauwgHeKbSikQVSiX6/ldDSN6XVuHz+MX+mECyYLujTuWIvblbsxUwaIdu
         nYsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPTP+mtzB80T97GavioCVHX7r8m1GY8tBMfSeFragaNuouR1y2MOAF/tHBrnrQDcLDO6KQ3y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo9lEdZbAAa2DIhJemn3S8agPTraww70TEUngFR7wOOHiAVNTL
	r4+cza7DRwlxziXbKE5BPNz+Tjo5XfxyHSq7DhnVfCfU8N6M1e7xfIAtyUNjZ8jk1b1M8dIKUFJ
	6IccTNU80+r58pIiomYbzoLCm9SOUDllUURR6XgnWDLkFeRnIFFCGtjhK0g==
X-Gm-Gg: AR+sD13y0AFA8DAjTobdu7cprNOmcQcsKxO1VQJv5jEpcDIgW8WO8yGdfrqzGpym27R
	0I31eHsUZ2fkgDJCfwUldLa90gCS5KQVGQHdUJsIYb1blVhc7BgQiV2EFv9pJazRxr3n+aYYV+q
	88gVky2LZZq0h1LwcsjVRhSk5slPYO0Ba4t2vlEtvpsxjRk7s2OAJ87E4E7VbAPCYeSyZV+GLAY
	hUymqFRSBp0IDXBT5DOtQhsJfrslqXmfmI/lXiDaFEzncCjZCPXpAlrWKa25cY9Yw1m5d/tDPp1
	G71V1eIcHRDYtY7oFYF29e069YosqVcvFixf1TQ4jF4nCdbyNssq2ZhcQWiELG5ZG7cERF37Sr8
	dWLRc0NY+lJp2qLxONQuiHaK4xFUsKaQUP8O6lqjEEedoJVPj0Q==
X-Received: by 2002:a05:600c:1c1b:b0:493:bfad:9d99 with SMTP id 5b1f17b1804b1-49573c9af25mr21718195e9.13.1784795053134;
        Thu, 23 Jul 2026 01:24:13 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1b:b0:493:bfad:9d99 with SMTP id 5b1f17b1804b1-49573c9af25mr21717795e9.13.1784795052528;
        Thu, 23 Jul 2026 01:24:12 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653731b2sm208346055e9.4.2026.07.23.01.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 01:24:11 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:24:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
Message-ID: <amHN9mOGj7oMak4-@sgarzare-redhat>
References: <20260719220103.684489-1-phind.uet@gmail.com>
 <al3UuvBhfxp82krV@sgarzare-redhat>
 <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
 <amB15TdzPAEk9A9C@sgarzare-redhat>
 <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>

On Thu, Jul 23, 2026 at 08:00:31AM +0200, Michal Luczaj wrote:
>On 7/23/26 06:14, Nguyen Dinh Phi [SG] wrote:
>> On 22/7/26 15:55, Stefano Garzarella wrote:
>>> On Tue, Jul 21, 2026 at 01:34:03AM +0800, Phi Nguyen wrote:
>>>> On 7/20/2026 4:17 PM, Stefano Garzarella wrote:
>>>>> On Mon, Jul 20, 2026 at 05:57:47AM +0800, Nguyen Dinh Phi wrote:
>>>>>> After vsock_connect() exits the wait loop due to sk->sk_err being
>>>>>> set, the error was read but not cleared. This left sk->sk_err set
>>>>>> for subsequent operations.
>>>>>
>>>>> So, is this a fix? If yes, we should put a Fixes tag.
>>>>>
>>>>> Also, can you describe how to trigger the issue?
>>>>>
>>>>> Because I see this in vsock_connect(), so I thought it was in some
>>>>> way already handled:
>>>>>
>>>>>         /* sk_err might have been set as a result of an earlier
>>>>>          * (failed) connect attempt.
>>>>>          */
>>>>>         sk->sk_err = 0;
>>>>>
>>>> This only handles the case where the function following the failed
>>>> connect is another connect() call.
>>>
>>> So, can we remove that with this patch, or better to leave as defensive
>>> action?
>>>
>>
>> I prefer to keep it here as defensive action
>
>Is changing how vsock_poll() behaves intended?

Good point, but IIUC __inet_stream_connect() is also using consuming the 
error with sock_error().

>
>I.e. if sk_err should be kept after a failed connect(), what about
>`sk->sk_err = 0;` in vsock_listen() instead?

Yeah, maybe this is a bit less invasive.

>
>>> ...
>>> Yeah, we need to handle that part better, I think it's a leftover when
>>> we generalized AF_VSOCK to support more transport than vmci.
>
>Speaking of leftovers, I have trouble understanding where does vsock set
>sk_err on listener sockets anyway. If it doesn't, why vsock_accept() checks
>for it?

I can't also see where it can be set TBH. Should we remove it ?

Thanks,
Stefano

