Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA72D94BA
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271987; cv=none; b=S610OOn/xuCjtjqARKt5P5g9lAfdRTGsQZuXigiFpasKmax5Ra9zzLfaapYLW/A0UyvBbKCA+ca+AHsRDhLsV1+oHrGy7FiyYK9Mr13zpMXe8Br31lzYUljVf4L46td1eGFJ/e/Iz9BvkaCu4/HxXiwhT9DTtCWikWHr8g0HkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271987; c=relaxed/simple;
	bh=IltVHAz+Mn6oml4DOxg1AW3CNrdZRtJVWUv0t3UQxMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFqug+l2OPgTY4YsuZY//wi5c1k4+8jKjL300YKcobvsiYm2f/R4mQEThiQQgljUyFxZRaTSEPVYRfjBGImOsoWxO5+yAuuexaLxeiU157gtvF86JekGO27IJIDGehofPRqjRVVucGXvHbPwsJyd/FAf9hNNZzHeY4H3WcUOtGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dotI8cEo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZaDDVjmR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dotI8cEo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaDDVjmR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781271985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IltVHAz+Mn6oml4DOxg1AW3CNrdZRtJVWUv0t3UQxMQ=;
	b=dotI8cEooPfVcjmEX3pB5NJ7oQeC8iQC7I0/pGK4m6D76eItEpM/4rzQlfUZh1EjCvnm/0
	lItF527U9v/rjfXScl9aTYzXs+j9o7Qn8QoZLQWWflQJvOiOBVfYLSMSNcPtrGLWoaylc9
	a0xuqHi8SYahKPKLR0rmWm+sgP4QW4M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-zCic8LeJMBmKfK4-1LMt4g-1; Fri, 12 Jun 2026 09:46:24 -0400
X-MC-Unique: zCic8LeJMBmKfK4-1LMt4g-1
X-Mimecast-MFC-AGG-ID: zCic8LeJMBmKfK4-1LMt4g_1781271983
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490e547f3cfso9885615e9.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781271983; x=1781876783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IltVHAz+Mn6oml4DOxg1AW3CNrdZRtJVWUv0t3UQxMQ=;
        b=ZaDDVjmRYGZ6Onxt4rM9Z5z/tuSHDZnVCn9E3ROtKv7WqZb6r+Or2key/nmzGIf1QB
         mNj3DrLjf0ZoTLlIGax71DXVFi+ycfIN0wybdTS4LC6zvGK7zDwi/PyAlRIE8mmdElqL
         YXiFa02BM2ZSYu8AXDsGNOkVMJBanyrmffIDOg6NK5P3CNoGQAJC954koepODzJ3lewv
         d7flOK54NnhO4Ynyc82jAqzbJnkP8TxnjmtlwlwZxkDf3rBY7jokVTo1+awIZwUzUAgK
         oGIWWLwUkLL/7JInzW8m0pe55IVV9DyMFZwutTx3iUqqTjWfPucHDRZqA20BVY7M/Iu2
         hUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781271983; x=1781876783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IltVHAz+Mn6oml4DOxg1AW3CNrdZRtJVWUv0t3UQxMQ=;
        b=Wp9VHdDvdutq99X30zqgzFEhclGvNDOcXOVe+WLBsJnnjh7p/neiaewxxq/jRImUc+
         qyfUe17hHTDxgI1bUIfatSv8axZyUbkfsAiySDCDXNIpKAZ2wUxbAiXS2iYr6UEYI70o
         cMga5OJ0WIy+38rgFYpLiA0vX5cp4Fft5V8BaEki8YjuFPcJ56z70bkzn/i6W14N8HNw
         ESCeJgn6LYhkYq/l/5YSDfaW9r4zvdsZpz+S+ETPEmn22x4VtTbrwGtllT3bRKratirt
         KX7ImPEEdsuE4Ekg76ksfUk+eXOri8JLUfIjo3dgRNzmqJi4UgoXcGFMyWHr9uUGRItt
         2Duw==
X-Gm-Message-State: AOJu0YygvkZRqm3fHc3ozoDsB9WfGBO9ncRcO1JvqZscZ0mHwOT+Um12
	wiHG64ps2msNQDGdqKkgYRVPMUL7xaNcqTuOLc0wXdi2rvL/SU2QEiy9lAL4HtHJL/iYmJh/dTT
	9M3rG39wfwVoawBHR/xqQ9ISQVQIJuqTjMhq1LOWiigCnRK02EC2M9JRyiQ==
X-Gm-Gg: Acq92OEbheXOtGmKI9lvkxKYiDARzKx8oUeUe9t7yGs93LH6MkH1n85PfrKa4ncqOCg
	3RcM6QCV+GSRT/RIqcBWLkk4UWYzPNM4TR9aw+u2wnpfsAbkKtj84DocdePD+WzqKDrb+pPPQKV
	TugcFks4ycpquvxKn1WYvRjPd1JQd6JdhJu/nNM7NK/liD+AnmvVZTZ6svaOCHYgQjOXiFg82wX
	22cq4KTLO3/y6lDeT4OxXJUfH38ykgkNPU4dHKH5GBOW4p6hqOJFPLmy+1cRVjhiFXR06nIENdX
	JIW1vTlL+W/G83N3JksvidoezUYEVakJO6ndFnqKyVC4IVYCJ3+KF7mabSYpsvtN3dFQa/cATdZ
	ZZp7Z8LuJOlpVkXTKDtlfju+z1detAxqgoW4WeolUdSaOvHodYzkyGFruwBI=
X-Received: by 2002:a05:600d:8498:20b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-490ec4b5ab6mr28510105e9.9.1781271982995;
        Fri, 12 Jun 2026 06:46:22 -0700 (PDT)
X-Received: by 2002:a05:600d:8498:20b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-490ec4b5ab6mr28509685e9.9.1781271982509;
        Fri, 12 Jun 2026 06:46:22 -0700 (PDT)
Received: from leonardi-redhat ([176.206.21.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0bbfsm5941295f8f.23.2026.06.12.06.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:46:22 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:46:19 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	bobbyeshleman@gmail.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 3/4] vsock: fold sk_acceptq_added() into
 vsock_enqueue_accept()
Message-ID: <aiwNjEuYu9y9pwkM@leonardi-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-4-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-4-rafdog35@gmail.com>

On Fri, Jun 12, 2026 at 04:52:15AM +0000, Raf Dickson wrote:
>virtio and hyperv call sk_acceptq_added() immediately before
>vsock_enqueue_accept(). Move the call into vsock_enqueue_accept()
>itself so callers cannot forget it and the accounting is consistent.
>
>Suggested-by: Paolo Abeni <pabeni@redhat.com>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

