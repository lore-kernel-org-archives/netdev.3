Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613848;
	b=Xe1SQaLdrvNSAburDZ0N4NkqV2xdCFKHGfCVwfTBPg7t+xNBi6Psjgx7ooWARHldakLF
	 QLRTsnjqlCcvsD6fXpzn/o/Itde/06xk45YSP+2pjdGyWBWUNsrRC3RpLYKenMj7oP+Hw
	 II1D8Pv+ksmg7nbU5vZ+h4sbMpCycAYJ9/XQSEGvXPTA8Mb/j9RzJwCNGCGt2CPdlYSZk
	 pspNBKYgqm6VFI4YyD8gY04y5aZaFCMknFLDKz69FcBhmjq/GdpgjzoLs7EmDFkJ4nz2H
	 JeJUyb2R5MpEXC+vECVFoab+PzR29OoolSTiQ1HniZQt/eTLQTwLEjLC+T1wna/5tIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=aW4OUjIIQjUPFcHTtnWclyPPg4R7VFoUgK4imjGVz3A=;
	b=zKLmd6cXUgrlTE4UPKCDD3IvCvK7cAui3o4WIpapNFEdMZEb6jBNrrSpyu4Vl8gWXjn+
	 DzHYJgQ1/g55FM3XmYvevIARMuvqU4vxMitb8lwH9IGRZm/d071ZcWJjkV+RBtAD0skj7
	 hP4Vr/WHNrsKtZaj7OZW2lQmTWzjhV8baOt8WCmqZpBu2C/wq5YuDn+MYiAbI/URI8TWe
	 1nElldXfjkUubPg/bdyAbrsXF1Sz/rKadWla1Y5LelzmozP7/DaTqdhmyTJ/UHXYGedZS
	 dP4sH0iyCZivzQESasLIX72yCv1SefF/Zcf0vGk11MJjF6YeewGRwU0Uygyu7MtAxsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v2faQj2s;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976D606A884
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7976D606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v2faQj2s
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso806755a91.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794613848; x=1795218648; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aW4OUjIIQjUPFcHTtnWclyPPg4R7VFoUgK4imjGVz3A=;
        b=v2faQj2sHjPThklo3kvSAsdztwwUVuRSFp3BgLG0TbuqHqTjQ0SRFZfLGVnHzRdt4h
         BPFLguLiU6iNuxLrBySq2qMcoIL3vedz6F9MaXkfKvqUDFhpuaNBtgnmkHiFN/1GspGh
         umudzPDvpiOKqZHDOz3xtaZuVQOO4OQspjSacvFJFWn5Vi5TqLdJZQRqwf36D8FOzL8Z
         JKLL6pd7Z1vDlXZYPL0d4CYDZ7Ev5uVq/MEIJfj5uYrgkG1M9zvh2KIFJ04OGhAwgJJj
         vFxiuvwsWIbcMUERQhKmZu2sg78xA3dM76/kDq8MFXa0ZnoAoeGo8sosWedpCZzi4SeW
         HQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794613848; x=1795218648;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aW4OUjIIQjUPFcHTtnWclyPPg4R7VFoUgK4imjGVz3A=;
        b=SQWnNacGLfVO4/9yI7n849OxVxxQe05Xc/J2mt4T+w4Q0wWrm6somf6h9AXdf6j93/
         OrlZBOcFC5ojoYqcknah3CVZzedx0GXQWNbVfoB8fl8dCC+GlNwbD7CVX0RKV3Y+HexD
         ZfxlcCF4Q3l6qBqxx9SCSmL1YdhIT7oK7gl/QhgvGKetivtrLCSqvzTuft3jVrZqOqwf
         4OfvatEBk79DYbubHRP6L1kdVr3XcqyEex34/gj+I6JAoXPNTiGILdewHO0ofGij2kdR
         HPp8ZJuof6cBhNIqv46ZSnWNRjBSFEgyDaz80bmUqBkR4v4S5h7w/GDEfOmpocHK7rA4
         AnZA==
X-Forwarded-Encrypted: i=1; AL+hErHAT27370/Hu6Eimiz8zXSj7zy/FON2iFgvlO0RtHsBus1UUu+7yraONXYXzP3DrPJ7Yj3/R60=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tdJNzPMqdEu0u2xZhYUND9GLQco2vzKhHyBoe9H3I2haexkcf
	CBdRFw3LCTk8fCISzK02mw2t2sjuq+7Q7vfuoGBTsZt1EmRktgWFs9gg
X-Gm-Gg: AYBFou3/3iXvMBTzmb3a/JWsiy6gNvEqex4mDGW9WJwsxDVadkI9YR8re4GgahRqive
	7qDmBhnefepps2L73rAYa7cum5dFphyK3hiqvdDcqQK9F2+AcQ0dkIc/xgaWcmWiFV8zdVqYbpy
	IPFvyHeawvTXT02AIXuWIv0SVQQlmmsuX5o4Ja5qCde7tRtO8BgvGBqQCxz9EAYlUP6elWoFD9B
	qCGxtkRavPBeHg7fb8gfv9j0/GlUsQu0DfYWkAT5w/pSk4LPaga2WU/UxIocsnkvl4R7Wr75ua/
	h6lh+Ec1S09LXdr3PxNMkZD1ZLVdfEnitJox4pTv8gWtfKBVRzGqFx/xpQbm+fxEI4TiQN1Qwvk
	r6fHq3oCWD9p5cHhrv87Ob7haGhaDEUQetxx8gyo3JNjsNUKFUYuocDirrWvAM5PLB0p2eLfhpV
	Sls85aC5+UydwOle+dApp+W5TW+u0MUW+XRCqgHxl5zV0oOWpgFyIS9SuiXM1D2PVK3wlEfs3ru
	gCbS/0IohhDk2jHdva/SKy5JNZxDqIfhHN443yHADUjzkpLx/5rKNAALHii5fcRs49Dp3qK4Tzc
	fxgQdTEWR6Fx1HKz6KD0q7+55vVcxqgjVEB5QF2KdukzIFmgYTf8/IuZu7CBqkdNPMZfxWBRzc9
	QzQo3Mq+I7NLaDs6odmO1NYkLnsIeY5VXARw=
X-Received: by 2002:a17:90b:2f0c:b0:3b0:8947:fad2 with SMTP id 98e67ed59e1d1-3b1b0ba0a4emr3788699a91.53.1794613847830;
        Fri, 13 Nov 2026 15:50:47 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c6c9c5sm11507001a91.1.2026.11.13.15.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 15:50:46 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 23:50:45 +0000
Message-Id: <DMUHIJ5FC8EA.2XFM7TJ6AH0YB@gmail.com>
Subject: Re: [PATCH bpf] bpf: mask speculative out-of-bounds skb helper
 loads
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <datrujillo@nvidia.com>, =?utf-8?q?Dani=C3=ABl_Trujillo_via_B4_Relay?=
 <devnull+datrujillo.nvidia.com@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20261113-cbpf-ind-nospec-v1-bpf-v1-1-764ac4c14573@nvidia.com>
References: <20261113-cbpf-ind-nospec-v1-bpf-v1-1-764ac4c14573@nvidia.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 13, 2026 at 12:15 PM Daniël Trujillo via B4 Relay <devnull+datrujillo.nvidia.com@kernel.org> wrote:
> Mask the load address when the converted offset falls outside the
> permitted range. This removed the leakage in the described setup.
> Derive the lower bound from the network and MAC header
> positions. An out-of-bounds transient offset dereferences NULL instead
> of a potential secret.

I suspect you don't have a reproducer and it's all theoretical.
Because if you had one you would have seen that your patch does nothing.
convert_bpf_ld_abs() inlines the LD_ABS fast
path with its own bounds check.

wont-fix.

pw-bot: cr
