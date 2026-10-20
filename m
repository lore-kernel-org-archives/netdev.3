Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502653;
	b=eogiZ84AjUXqvbLQHqe8I/SJrY53zmPRemQd9ROBuGLkFj9bG48tNkXzHnq6IhwVgyEz
	 cUJ54nVxMm2tCK+vlDtjbbAcLb/EzA017wXqrttqoOQDIzTTiAjX2Mz8smv396z1f4B3h
	 s2QrMIH3EU6Ygq/vN3NRWVBbTAieTGpMQRflgQ7ZIopbdpM/zBBGQIbVEsbzR6DV7vFlT
	 NTN0QvfI6HZzg833jme7AerL5jotssLItTPbYldYCZtVbTMAcH9S7s22KYmfpwCDFn0xi
	 dIBxOANT4pXZV0TzE04KdkDtuP/v0VSFjehWhFtH9uZ7+pfwGkBFJBnmOUa72Ydyi5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XRtR/3LEKCT96Cn332o020ioqbbOJSAYNYdI1pf8JNI=;
	b=wIZfMOCjWE0JtghF03IExQ/vpe39QkLhEd3kKQ9U7NIg5KVjK24koQCtajUWzkTSevO4
	 1wsj4rTWNhEMdM+kJqIcWbdsKmIdzUp2lQbamhw6oAH+iO0dLpmsgzyULBtF/T1kF4aEl
	 IlPC9sO+NIeO1u9V3Yb7lz1FwiJvadVE+t1bRDcffABgcAbcHGW0J1BY6gzXyn7T4f04n
	 QE0t0wlEYwYeNjRDv+Z2E+2TWK91KIWH97rZAS7DkvG7ARcyIR2YgTmbLnQ949SHI3ICM
	 ISL4qVm66WnezafUoR9nnaI8+R/cxXrWm9pQrVvZkVd6kVQW/2Lo97LYMOp37OO5wjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EWJBmoPi;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986D606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8986D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EWJBmoPi
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so2831536a91.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792502653; x=1793107453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XRtR/3LEKCT96Cn332o020ioqbbOJSAYNYdI1pf8JNI=;
        b=EWJBmoPiTzgM6kfVEl+EtqoPCzocUVxgwjVlaA9tBeRdOEyfbSlWaNCHaymhCC7hm9
         NNAwloBqdpuX2iRcQvH8EPAUjQix3RolaxQ9KYXKNvACAg2VaeOKy2DMg9FENftE/PCG
         UoCnA5vpsfMfL3G0dO9R7pGOCb5m2tulus4DHYsvrYFcuFOh6E4PFEh/WX5OhgOm7fLj
         M3YveFmIqZ5mvjjh26FdsZBGx0o6t0RcIz7IboKGT0ccfIsh8zSQBimMVjQ28glI4sSC
         riAyJ/C+tcb85fiNGCNlmlht+s6OH97nSzoe3ih8jTP19629AfQ2wV+wzsTOjNHfXJQS
         kv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502653; x=1793107453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XRtR/3LEKCT96Cn332o020ioqbbOJSAYNYdI1pf8JNI=;
        b=OKaNqawITqpOVUwzqmUC9x+2ff9oOM5otRSkihvXc3a59laN5OsCdoni/nYGilDPEj
         KWoPaq/6CxcMsCpLVrnoavAq8aENEfaBAVJsqAsWWEBedFfXkNdlE3chF0uL+1qybhKQ
         daHukYaxXQ2SHMsHIj3tOQZt2r0TbQNGbXyJTvN/t3MK81AS8CCsBemWKz7b0etT4Y1E
         uU/sd6ZzIj80vVzcOWF6StRALFmyQMqIJuAz7+Q4rHbmhIkWZQuPC19Ghu3eRyDjybME
         MVoXn3O7H70McGsSBYmWP0p7qi9Wyjz+t/SHeH0NbVozCTeCnux9riLKSmDwecSe/vrD
         6FvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEG4Kt6zS0NFh00VTLoTDlI8fAVf+cwCdgSSU59YMbtDaydpjDGmGSq9kln5F7bKIpu6su8QY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRU6dHDFOobRSnQRbJMRZmg+sCAXbTim+kyVyeW5JS+m7Gy8tg
	WixwOfjcsop7tRRX4lbzv0zMBqkcI5sR6pB7b1cRnAJwlku+QeU0Jxwy
X-Gm-Gg: AYBFou0k/KpSrmsNBlnxsbr9mfMbcJpQtAa6L2Hc1lnpcaTt8EiPODpnOD1zfYpgMOe
	E28TWZm5Thm4DWBFE5GFQDSujBeEtkAV0dt0KSaUrTR1HWkses5YebV4cbx3NFyPr3XIr23LfZR
	bCTNXib5Pr4JWjt1VHmPsKORTWAUMa1KatUphIsEfdPedLZTBxav466xqx25R7ddtpRWSO20PeH
	zMrME9/XhiOxpNnhuj8Z0xy0nD+7qTmXLO6xWjb8g0dwFV3rwA+IJIYpQ17gLT/z43dPRAYJp+O
	htmqciwcoFkazYbeIrWF1erOEFlIJTf0yJqwD4Uh/CohRL4Pq6G26LAnamyMgxFpCGvYtwP9S7Q
	GE817l7vEs2sZhnYoZ/Jc+R8alo9Zqbi+xyGVNOhPZYaTXGWvWdAc53xNPQAzmNKibCJq/MVeMm
	U1rMKSbGYwqydmfugsRkqVAzaprtXf02zGgQb6ea52R4P5Fi191g5Odoo3jFiCmZGGjKATJoUR5
	3bWyM5kMmlyL7k=
X-Received: by 2002:a17:90b:4fc2:b0:3ab:f2a9:cacd with SMTP id 98e67ed59e1d1-3acef5700abmr10872896a91.49.1792502652945;
        Tue, 20 Oct 2026 06:24:12 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60be992dsm3550434a91.2.2026.10.20.06.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:24:12 -0700 (PDT)
From: joonhoekim <26rote@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Joonhoe Kim <26rote@gmail.com>,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	christopher.lew@oss.qualcomm.com,
	deepak.singh@oss.qualcomm.com,
	pranav.phansalkar@oss.qualcomm.com,
	andersson@kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: qrtr: ns: retry service announcements on -EAGAIN
Date: Tue, 20 Oct 2026 22:23:58 +0900
Message-ID: <20261020132407.968-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <atLkH_D2JrYdzacx@debian>
References: <20261016124600.31-1-26rote@gmail.com> <atLkH_D2JrYdzacx@debian>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joonhoe Kim <26rote@gmail.com>

On Sat, Oct 17, 2026 at 09:24:38AM +0530, Manivannan Sadhasivam wrote:
> This loop is going to block other nodes. announce_servers() is called from
> ordered workqueue which only executes atmost one work item at any point of time.
> So if any other node queues command while this loop is running, it will get
> blocked.

Right, the loop holds the ordered workqueue for up to 10 s.

For v2 I'll drop the loop and retry from a delayed work on
qrtr_ns.workqueue, requeued every 100 ms while the announcement still
gets -EAGAIN. I'm thinking of keeping a time limit like the 10 s in
v1 and cancelling the retry when the node says BYE, but the details
may change once I test it with rmtfs started before the modem. I'll
post it as a new thread.

Thanks,
Joonhoe Kim
