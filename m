Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793075586;
	b=PHsSPFOYc9B17/vtR4SQlApOPEyO145RctSm58Y+5/xBFV6N79EkJmbEdPzFNgDy+Xe8
	 lsiuBJJJNBIQxrslTMplroxzpEUF4pFiFK21gHHmpLHr0yuENytoHVs8YjSUY07zGeraH
	 Dt6OBlzFwYe9Wkuxz44UZgPy4ewjTv8ddqntmolyAYF6dWEpqqswv/uDO4JROPPCKZzqn
	 XAckzlwpspo+g0ASgtCI8BDGnJNd6ULpjmxE+aVd/hd8mw5C+yHGsVnFuZsZWWO1Gl+Mw
	 ctQBiaxU3ktlPV4EFVlhKgCqvpc2AN2u0Z7+WaW02b+Z62M/LNzLRNoBxvd1eYaYg+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793075586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H/s0trxcoPetBAGSZ+WWadHRZGNAdrAL6Ec2NNam+Gs=;
	b=Lu7rAzjNIsZfuL6yFrZWh8izaO6iDVmZUUKJEX3/gJAzotnmvLByvg3j6Qw4jOfY9JOX
	 VZRnon7K48c++Q/ewr5xF9GdC7V1sFeIRxldDXcIez/lzsM/G/lWZbHIRktk80IJztGaY
	 Dn8BqplKkWZw3Z6g6kVob+/9XjbORj2zOrFLYHeFesyrgxbUf8G42y9nEP6hNy914N7B3
	 PQcPcJK2IOw7cGb1aS17FjQeDKfv4mXkf3W6xMVyPQ+VWviofqVIhbKw/P7/m97VqbOGZ
	 obZM84vNV2lHYT13jY+2qxaIH0s3q8atM0o51N4D0cMYxG1SCxbgHMHnAvhGL3MFFOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=jE83P9bc;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F8606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 04:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C5F8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=jE83P9bc
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5365b48238dso29717201cf.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793075584; x=1793680384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H/s0trxcoPetBAGSZ+WWadHRZGNAdrAL6Ec2NNam+Gs=;
        b=jE83P9bc8Zo7JrdVi9yiwbcWoVzzLiZYRUEI1oy6Gp8JPjdKsglYJSOq1sa2qhlAQl
         XH8Gi7aqK3EK55fnhaWmjngmjiNEthydJ3hjJol1yT8eHIc/CWJE3nrWqZT2bL5Vi3yO
         7+R5oQuLDxPfnfQj/rjOHt+jSpUdcvYii+97Tw3VlmleXHmNq0KHwG2amyY5IBvssV6A
         f3u3+oeBKrA0ufVzr3nyrwZh7J3LeZzXkxu0mdnERullr1XBxeUG/9xab1IIRRjrSZ0u
         h4YkBJTlR6Wizn8yjUlk9rgjBrzrFnccxlWxYQVWQxPx8w657VL0fgXfhdOMK/YlpXVG
         TPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793075584; x=1793680384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H/s0trxcoPetBAGSZ+WWadHRZGNAdrAL6Ec2NNam+Gs=;
        b=dXBmBGtHN0jMiJu3ijA+g0tzEpmMgtQxbGfgWuDU+F9CLFLjI0kI016TkvJqB/ari/
         hc+yllKpa2d3DQ1Keu3rf+miPkbl066MhtE1tO4KHoUbAeHwaqZeVY+CQxjEpVs+Wt6J
         htGxRRhkmatuGpG9T5X6J50L/lCyCyE2VG1Z+Sv0HKiEJcMrw62Q7pLcFrVzolIqZ2GL
         nt5Tyw19EWAbVAECncsKtv2ONNSw7yDpN++nIzKlbznjrX18QfAEfdvoIeTmJTh9/ckM
         7eC4zGbyBxOyWxqSYOQvsoNlJUluOjxqaTDOETyrmFquAfwkiAwBTKSQSs6JtRgu2GaR
         gjsw==
X-Gm-Message-State: AFq9FYKfh9tP2sUrtiq4l3gqn3yov9iUig7zifucnqtMIBM0VWvJSQ+C
	0NYnfKvp3Zrz5316gyj5r2bk3TsbqLatTQgX+1CWshx1bymomGNNkHZvvadq4Mo3Wg==
X-Gm-Gg: AYBFou3Uyai4oPQ1rwsnaUVRpaOg0DLcc6p5/b6g+t8IbucOg4e7xP8a1ZDIFt94YUd
	Xcj/vZ2Xiuin7McPkVGjvUZF/hDdL0uLQ8ki/NCjad7yqYoNgD6vN20YCzisza6mZ6jaFrdjgvz
	Npe+wsQQrCjgtvkT/WVVJpYPC2k1mTlXL1OXqOgLXr2dpNjmL3XJXBmelKfFcl7VXVAeaRpWSVY
	TSfs32pytpxHltUfRHW3zZomYnGjtlPbdFhChGvd074jSSt/m0LxKrpjoDSl0FqPV9GuTbr6ySf
	UwIEsZVeYBjrjwpQPs3Rons/c/z9Tu7gvHITGxwgHlG2+aKrUYRiQLbmAsQE1CzqqyHPxHIQ+nT
	3oz+xpMYeXdNCFQGXKETxFY5HXVq8g7d4ruh9ben2adrACRWuOKt0fUW1I7IC7cOxSX2GDMB+Ac
	AG89JgulbGyDn/KPSLXNJdMF8ON8/6UFq332d/NAC++3I5vitgCy9vUjisS4ebABzNe4v04iEOs
	BR5aG4RvWEMgeCoaIhEO3pVIKppLsvyHB4zMTSpj8mQFzPXwphzLpoOo8I6CciyLpHTfFPaBlRk
	MA==
X-Received: by 2002:a05:622a:90b:b0:533:972d:ff95 with SMTP id d75a77b69052e-5383b52d4bdmr142446991cf.34.1793075584132;
        Mon, 26 Oct 2026 21:33:04 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53c26e27c24sm43592911cf.19.2026.10.26.21.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:33:03 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: gnault@redhat.com
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jchapman@katalix.com,
	tparkin@katalix.com
Subject: Re: [PATCH net] l2tp: only return sessions of the given tunnel in l2tp_session_get()
Date: Tue, 27 Oct 2026 00:32:54 -0400
Message-ID: <20261027043254.3763123-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <at-F69h64Ineg2gp@debian>
References: <at-F69h64Ineg2gp@debian>
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

Hi Guillaume,

Thanks, that makes the intended semantics clear.

On Mon, Oct 26, 2026 at 05:55:07PM +0100, Guillaume Nault wrote:
> The correct approach would be to pass both a session ID and a socket
> for any L2TPv3 UDP session lookup. But the netlink interface currently
> doesn't support passing a socket fd for SESSION_GET, SESSION_MODIFY
> and SESSION_DELETE operations.

In the kernel the callers already have both. They look up the tunnel by
ID and pass tunnel->sock to l2tp_session_get(). The case that is missed
is a session ID that has not collided: l2tp_v3_session_get() returns the
IDR entry without checking sk.

> This last operation could maybe be simplified to a simple tunnel ID
> check, as, in my understanding, we have an 1:1 relationship between
> tunnel IDs and their sockets (but I'm a bit wary of such shortcuts
> given that code have proved to be brittle in the past).

In v2 I will compare the session's tunnel socket with sk instead of
comparing tunnel IDs, so the check does not depend on that mapping. It
does hold today: tunnel IDs are unique per netns, and
l2tp_validate_socket() returns -EBUSY for a socket that already has a
tunnel.

I will also reword the commit message to describe session IDs as you
did: unique per netns, and per UDP socket for UDP encap.

Do you have any other comments? If not, I will send v2 with these
changes.

Thanks,
Hengyu
