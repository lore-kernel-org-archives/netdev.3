Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516486;
	b=x2uWQqmv6Z55mwbD+6f2QGy/AC3hFFq1l0PRZ142mvP5k43FfQucNFaTzJEMGqxFq28N
	 WX5EBIvWW71peLCa6Ap1xN3SvQhLrySm6tDn6vAznee0Z+kDIK8rGZk2nu2nDjkGyiRar
	 SHkqauS4SNGj2kAEyrl4A/tFcptzLMGRFLLBV1V3iajlqnxTxVUrG9w12hIDtHDmJDz3A
	 ESAOhPmiLto1t4LmXAhmyEvFj/+qS8sLUaCOSMiN59PjfQ7rwHYbhEeyGouJ83woc+bcK
	 oiV/PNJXEOn4LgkPGrBmfSikg1Qc0ZuPSeDTWgnQvzvvGO6ymHmHhGM+DdLl+yxPBpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516486;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lOwnGQXmS8evHlFVLwX0xtuDnhg6yBqOr9ZK8AmqtFQ=;
	b=wEM4hfkGPLiKbz73mFL7g88/FHYJJ1/IwLxtw9hxtV9kNZmTdkevCZLEq1XCc6B+w0IM
	 UjvbbmbQ6Fd8yVJa25Nmb7L2Kx6eyFJ6QpmMwgiy5PoeQ/ucvBhptTOR9bTeGqJlDWXYw
	 CJJJcWfQFcuxTDRoiTSskvqKuTEyMzaXZH7nmlZKBNMMmehBf218yki87OQLD+MBeBBm7
	 Ff1G7S1YN1uLJrGIw+76/RMpNR/duZsvQHtJTlF9EgpkzNz+w5pFLIxnbBSQbWCbQfH6f
	 3i7vO+u/XRGN0+6TzrhTOLeUmlw+zkwYLuc0Yl3M+3mHxG8nC2G7j0Vgalw0J8H7uZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="cWQ9MB/S";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XrcILpcV;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25636606B306
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25636606B306
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cWQ9MB/S;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XrcILpcV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794516485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOwnGQXmS8evHlFVLwX0xtuDnhg6yBqOr9ZK8AmqtFQ=;
	b=cWQ9MB/SEV27c61OtK0XDaZhXEyPRk9nvugbvwcyhPM/lTzPwqGXApHVKcoYQ3HTkdkBDy
	EyM429DPAKfjzq+8yWSO9I7z3cDfnoKEUh0Dh3i25uRqXFA/9XF/6gNQdbk0lj4pH7Q9Jh
	heXh81knuYiSFewT3wdrfpJRqpvmsMw=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-OYPpTJjOMsKguaak7uxlRQ-1; Thu, 12 Nov 2026 15:48:02 -0500
X-MC-Unique: OYPpTJjOMsKguaak7uxlRQ-1
X-Mimecast-MFC-AGG-ID: OYPpTJjOMsKguaak7uxlRQ_1794516481
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-4943ed99826so204424fac.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794516481; x=1795121281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lOwnGQXmS8evHlFVLwX0xtuDnhg6yBqOr9ZK8AmqtFQ=;
        b=XrcILpcVi768ekJQkiC6az4W/O0HPMyYmAmrrucrjsC0hI5lPjWzPKtGVXVrPb/dhf
         mKJi3hUwD03+UV7Xy6OaeqHZ6kiYXq2Vi/JdrO5CCIpD7aYGwqcz40MxDbeO/GCduMho
         Ht6+Jb3yfMALIrFojQBCuihl7Po26goyI6uI4KHe0JLu2KNCg26Ys6jEvlFyYKSJPiMa
         B2cRnWyz0uXpBoMNCUY1kPpGuPVJ4MjYYqQItmrW0/chATCt5G3ehy/53eSqR2tmn4Sx
         3phun0NRzswUh+bs3xHt6nj8cJ4M+0cdfSlxpR66cZsU5LP0emccfjnc3SwylUeytqQl
         QMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516481; x=1795121281;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lOwnGQXmS8evHlFVLwX0xtuDnhg6yBqOr9ZK8AmqtFQ=;
        b=yE19AUmIe3mla1EuvG0Aj6XcKIIWiP76+Yt6VqA1bHdUhCFdxtU6KFSrlQhoPYtcBr
         c1QsSxx9ldjL9bdWDAcy60e0mmndcGkoyFKjzk/i8l1kPdrYPVNWSMj7+KPfNKxiIqDX
         SyeYf9bNaJiO0nSNswn//SIG4KTEa7f/f9HmxQdXoR+fhsw4j1bhtSP2vA5DnJW1+od9
         XfV7BLcNd6GeOJZ7cERdDUGNmoX9cWxK3KMo2vsPjp/SAfsNWt7olGa4RjrjgqUMWh4h
         RWSzsbjPtbRpxjYsJ0QICsxqW2rod9qGjPQUoCR7atxBrmLj2tdr+mwhFEceJ+3Q5rb7
         vMgw==
X-Forwarded-Encrypted: i=1; AL+hErHKGtXPDDbU39MbVfu0+tH0PNW7mGt0B14N/oaExJGsN7xCNDk8XeRp5Fz01Og4K1h2VS2UdUs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/h1SJTcBb8enrUhsy3sZOZGTkkPZXL45NCAYdtEbB7rFRdqf3a
	lHB/HqVuce9+XElbsOx2gyapLLPKysl7m4c3msfsjYYSLyx6gkqCwex+zK5//LE8FHYneW8gXmc
	3DvbbJr9U4dxFAcfqvQjGferBbhQrwbvioyGPy4hbKml6d2BoMKY9o0Crqg==
X-Gm-Gg: AYBFou2/6K6zct80bdVTZmZYS0z3tgUKGyod3mvSYM5/bxnmh+/wxmxGRcTjEG+yA96
	RGwDwj0Tl5mZf47BsF9IuweWMTaJh1gbFETHFnykEMCTCzcuXfhUUjGoPr8+kUeWNIJpnBSEYhr
	KuZMNWU2iAT1/jzIDX3pCPREofXcljA6ekosTC6vKb1U4tnuvMfHh4hzwz6Ft9YNY5B39l5Kis1
	foZwdGHFjdDeCgwaff4eOkvVmHoTf4iLpUqmKCCTjPxddW4yE1M6jEeYB2TycBTAvXLveSJVsC1
	SZAeu2MXuGUR1ZE/TMvowtod26oMt6mXfRUFk5TlaD98zM+2kcAjpkVCUYvFtnsEd1qQAGNjldz
	gQkRLr3Tf9X2m0A+5XcxmyEv/IwzVNu5CI84N93kLvG0yDUraferB
X-Received: by 2002:a05:6871:7b0a:b0:49d:ff8c:205e with SMTP id 586e51a60fabf-4afdf2da638mr911057fac.29.1794516481378;
        Thu, 12 Nov 2026 12:48:01 -0800 (PST)
X-Received: by 2002:a05:6871:7b0a:b0:49d:ff8c:205e with SMTP id 586e51a60fabf-4afdf2da638mr911021fac.29.1794516480871;
        Thu, 12 Nov 2026 12:48:00 -0800 (PST)
Received: from sgarzare-redhat ([69.196.88.181])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8628813465esm686251a34.16.2026.11.12.12.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:48:00 -0800 (PST)
Date: Thu, 12 Nov 2026 21:47:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5] vsock/bpf: release sock lock while waiting for
 data in recvmsg
Message-ID: <avYllBVgJg2AHYc0@sgarzare-redhat>
References: <20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad@eldare.de>
 <avXyzxvIN3ngFepE@sgarzare-redhat>
 <179451283622.7.13355395779239029915.1767743913@eldare.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <179451283622.7.13355395779239029915.1767743913@eldare.de>

On Thu, Nov 12, 2026 at 07:47:11PM +0000, jrmmhm.kernel@eldare.de wrote:
>On Thu, Nov 12, 2026 at 06:23:00PM +0100, Stefano Garzarella wrote:
>>On Mon, Nov 09, 2026 at 09:08:29PM +0100, Jerome Mohm via B4 Relay
>>wrote:
>>>The loop
>>>and the zero-length check belong to the fix (without them the reader
>>>returns early or spins with the lock held), so this is one patch;
>>
>>I don't understand why that fix can't be in a fist patch of the
>>series...
>>
>>>+    if (unlikely(!len || (flags & (MSG_OOB | MSG_ERRQUEUE))))
>>>+        return __vsock_recvmsg(sk, msg, len, flags);
>>
>>... I mean, why this change ^^^ can't be in patch 1/2?
>>
>>BTW I'm not asking to split it (at least for now).
>
>It can: the loop is needed for the deadlock fix, since without it the
>reader returns -EAGAIN early when it wakes without data, but the early
>return isn't. A zero-length read with data in the psock queue already
>spins with the lock held on net, and as far as I can tell from the code
>the early return alone fixes that, plus the MSG_OOB and MSG_ERRQUEUE
>cases. In v4 those reads were patch 2/2. They went into one patch only
>because Alexei's diff replaced both, and my v5 sentence justified that
>badly. You said you're not asking for a split, but since the early
>return isn't needed for the deadlock, it would fit as its own patch:
>should v6 have it as 1/2 and the lock change as 2/2, or stay one patch?

Yeah, I'd prefer 2 patches with this change as first patch.

>
>>I saw some comments from sashiko, can you reply to them?
>
>I'll wait for your answer before sending v6, and I'm replying to the
>Sashiko comments separately.

Great, thanks for that!

Stefano

