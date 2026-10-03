Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DC848593F
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791053165; cv=none; b=DlLlrdSI1nwNz/x1QZyFi3sNxSyVjpqL9MdM/4EGQCJKW32U4atzw67HCGrd7rEU/sO2J8kCa/YLNhTqODPA3Z4RmFZ2MfzgUKqmNyVokzOLCbbsBL+hKGItclH6+G0stu8sUkMPBPf/MuAz7LiB9WziV2vgeyV8sqPSJ+y9cMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791053165; c=relaxed/simple;
	bh=3k8bcdVBIAhoDPxWjS3p7hxuvGKrzhfMPJnh4k0lM/E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bsN3LttT6+GvP2lrvqCxwxGrFCeG6qc/ir8jePz56rJgqz9Q+xxwCBc8l0BKxr/JRotwX8Tf6PucW69EoX21Sc2ld3tIfoC6pKs4/2AtXynAf5qEODrB1KZVsUfMjRzez6XdJe/NUSVHpOmkWSclHaS8nh3jJOkuhr0JvoHbgQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKSQgP2C; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKSQgP2C"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-677c1fc082bso371095d50.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 11:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791053162; x=1791657962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1SeUYL69haKduQdWnDZlkXgvDumnTlQll9VenS7Z1rw=;
        b=kKSQgP2C6abiM+NwvaukOlpy8PWwYLA+zKfIB54hS1SLgJXdyHe0T6/vLvGWk6M2ia
         7fIgeWz9A4mEcj1v0bnca7w0PYLh7hBXq71ytxavqi8QGWy/j6CNXy+WnEawWVx/Bn1T
         01l0WjBP/3i9apZAsW2uOTr6TtFBWIAwBBEx8sJeDGsd8CW/xh4DHGTbaXbHHu1pDFrY
         Xmo2AyJgfuM7IKlGY4J493RsUCWQ57YQeOjtnZ84vmKSO867zaZMWs+ej+BOC28Vv+uT
         84eyrqEbs8ieIRzP594OWn+2jbXYbV6CxXas1gNy+R8JjeT8UUoBsgIJ9xloAMFCMPp5
         MsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791053162; x=1791657962;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1SeUYL69haKduQdWnDZlkXgvDumnTlQll9VenS7Z1rw=;
        b=wbIiRUMF4eQfaQX/qK9hT/rM5+VaGKkupuAUPnHMrFiaVzeFJEUcitA1iXwnMg77rL
         CR2vPInfY2Rcdug2B9YmChd4QqOZjb5TmezstW+j4Eaw2kiAeSuDufn5KYYUFI3YII9s
         U6C1ougOG7kFg0+3Gu+tDKGVPMWvbcsGy7cxlC8yZ0qM8QBr06cpWOzneWw0/uF9ZT+E
         Rn4i51VOvSh+yjlWgLJV1ExgXF5Sbk/jiJkzD4Uk8K9X6fICOitt2qH+iqrPxM854b9U
         yOj6pUGtFs1kjHKO4cqHvjEx+eNUbFYA8b/dVZ0LcOAC+cQZ9fTELoTZK+LX2AW/ahmT
         0VrQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3tYuSNW5rLMLiYXO+Uuk2c8W8Lszc2no/KbIgjh2nEFaHKmBmopZPJIuBYqs7x7T3c6nK7CQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiHdeObaknEJ8Y6+w/u3dLtePUjj0MKTiFnT5Fm7zpzg7InuYx
	ChnYRlQB2gjYgXqI9kZ00H2WF7RZBcHR2venpREUYy8JDPZR+iKQ5IHt
X-Gm-Gg: AYBFou3/LgyHYHjniCCmA2OTJcTmY+4p2W2E0RS40ZzhV9R9QrKaM4Q5nTBb8zmr//s
	MBt+JINBs7ugcCH+vh496YtM+1pv87QGTVGuWJsQo5gcE7ubQ0wf7unJMMN84zKRJPx4AxDsWp0
	0OLDtGMZKtZo4KOOP4V1Chw8/qhdTcUH485enSBljBK4o3QFu17Texrq0bceNH06iVeRYV3vzs7
	37x9zHEdaRc7ORY/qMF0gRgr5wBZ4fndgKBZInaPv2Gi/FRZ9aJuRVu8wjb+k95UtSyzboMwrno
	EKdkZM56q33FTcVJ1iZlXJMJxcVBHBKa708pR5MtG9FPjCW05q0PQ18frZw8Q6LPRkqTsacGLLh
	yQnHOUPRpbfnJu4krZTif1x5qde1hylfKgtNS1LMx6EsheZg2QXeQ4Oj3RyPbEA+q8J+uLGFpQg
	WvZVjH2AXEJu+s3ZP3OdroNWIBrklKVGea1tQP3TQlqMdUt0x1aoBgpVWTbH9kQDock8xY3EgJp
	bbHLdJmFtxwblTuCFbaVmX9DAlDiX5AtMjO2w7jxHRnBxt0ns8R
X-Received: by 2002:a05:690e:1486:b0:674:20d1:fb28 with SMTP id 956f58d0204a3-677bd1845dfmr1097544d50.5.1791053162592;
        Sat, 03 Oct 2026 11:46:02 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1bf815fsm931987d50.21.2026.10.03.11.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 11:46:01 -0700 (PDT)
Date: Sat, 03 Oct 2026 14:46:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rongguang Wei <clementwei90@163.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 Rongguang Wei <weirongguang@kylinos.cn>
Message-ID: <willemdebruijn.kernel.12142fb57567@gmail.com>
In-Reply-To: <20261003063859.136895-2-clementwei90@163.com>
References: <20261003063859.136895-1-clementwei90@163.com>
 <20261003063859.136895-2-clementwei90@163.com>
Subject: Re: [PATCH net v4 1/2] tun: keep a kernel copy of the socket filter
 program
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> TUNATTACHFILTER copies only the sock_fprog header, so tun->fprog.filter
> stays a pointer into the address space of the process that issued the
> ioctl. tun_attach() reads it again whenever a queue is attached to the
> persistent device later on.
> 
> Rebuilding the filter from that pointer is not reliable. With the inverted
> check below, a failed read (-EFAULT for an unmapped address, -EINVAL for
> bytes that are not a valid classic BPF program) was not fatal: for a new
> tfile err is overwritten by "err = 0", so the queue was attached without a
> filter. And when the read succeeded, the early return meant the queue was
> never published at all.
> 
> Keep the program in the kernel instead: tun->fprog_kern holds the
> instructions, and each queue gets its own program built from it with the
> new sk_attach_filter_kern(), the kernel memory counterpart of
> sk_attach_filter(). The copy is freed when the filter is detached or
> replaced and with the device, and tun->fprog is left untouched so
> TUNGETFILTER keeps its uapi behaviour.
> 
> Also fix the inverted check at the same time when tun_attach() returns
> early when sk_attach_filter_kern() succeeds instead of when it fails.
> Neither change works on its own: with only the kernel copy, every re-attach
> returns 0 without publishing the queue; with only the check fixed, a
> re-attach that used to succeed without installing a filter would start to
> fail.
> 
> sk_attach_filter_kern() builds the program with bpf_prog_create(), which
> does not keep an original program, so SO_GET_FILTER returns -EACCES and
> sock_diag omits the filter for sockets that use it. tun sockets are not
> exposed as file descriptors, so this is not user visible.
> 
> The inverted check was discovered by manual code inspection first [1], and
> the review of v1 reported the other things.
> 
> [1] https://lore.kernel.org/netdev/20260923025653.59348-1-clementwei90@163.com/
> 
> Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
> Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>

Reviewed-by: Willem de Bruijn <willemb@google.com>
