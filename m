Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792717099;
	b=Ie5el3q7OgUoVRbIU3IXRfKdIarCFODtaAyKsAVTVOg1g7yGgj5Y4LXp/a1IM/5NiWuI
	 /8KD6VfVovSX/gakwLa4sBWKchQYPwFgMLVEgkIm38U9Xd1Smzs+VuzN/k+IMYNuBQtAu
	 7oc/MBj0wWSbgpefzTrl70B2cxwXCope9QrvG0GJFsrPIFnhCrwDp1J8Bk0kLjDnNcwy4
	 2WqCC88/blawVOYYOpGYHGsO6EBdOVhEg8c5DqMw3wFlVCQYzIaJVOezYWEWG62o+m9yq
	 9FQ/TVvslapYMs1q68MZDSNkQhoAZ5wp2FK7/Y9hTKgVv+0cZ835rc/Mc319SU+MUfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UHi8xI3uo9X5BO5X4q64aJReNB6P6u4CgT21Fds56PI=;
	b=JSL33wU/SAIK609TeX0GkR14vzqcnKnrLhmBANzy7orw6LoTqQ6RDKWTbfaEECsRmf5K
	 LSO1/4CZmfq8AI3RxRQXEi904xwjHrXhgVOsS8ywtk8hJ0U8P1cv7rs+1WLK54yCdzZ/M
	 3/cQJhCU7JxuLAUW5W6UbR7xXIsyqWyTy3dVPznKGn3qwOykpZ29LHNOoZUYqF420X8kv
	 AIYe7tZH6jRYhNRbCDuT7vrjP9Yx6d3Dl7bG/Q6dZ+W22US+fDcs7NMlWMjulS8d0b7Lc
	 B4Mjf71yJAOuTrZITnuZkN/bHFGL59gzNrdBsEtLNyyUBVnKZv62mXdpZqZwF1Ppc6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pillDvcS;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755E1606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 755E1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pillDvcS
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4550d8ab15so48013466b.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792717098; x=1793321898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UHi8xI3uo9X5BO5X4q64aJReNB6P6u4CgT21Fds56PI=;
        b=pillDvcSD67VZ47jbHqwIX6TiGDRjeR0YAvzt8CEbVvfLdD7IRZle9IpUz14Y9Aisf
         hg5pBDrXZ8r6LxV07q09XEAXFJ2erui2sIQai4PfDgKrRfW4LOaHQ2OMETBSu6dQSjvg
         EUpBnN+ce+AfRz864nE9Be2m6YqASu7ZrhecImPx7zaOBh/mUPYHGtfhLlU78sm01Xyb
         ZOZYNGLxjlastTPudFYI9Nv50Y9bXJ2xnc69yAtHJTNpD7rmuEUqamHm8ZRbUwQjCRnu
         pRR5+f9QUXDNzh3xFq9dcvPAVqn77f+eEwI20VFr5+tdKrvnUOeu2ZLQ6Bgs81rQPndM
         gbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792717098; x=1793321898;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UHi8xI3uo9X5BO5X4q64aJReNB6P6u4CgT21Fds56PI=;
        b=MjsCYFnEVp4HrSZ0lcm6Re6JNUm2BTOr9Fhk9ZXwxbhoZjG8V+lzuyZwmB1V/tmJ3Y
         HgLhYtMcImg9tC1J5L3vhL/5Tq/hpVQmbvwYXCDJ/hnj5/5hCHi3z+GM1K5VGEAg872K
         aSXm9Vqx/v1Fl5ZjowIgffM9AaU/dBqueTNvE4h1aL3qxZ3050CMAzPEURC6jyUsUNVu
         uESt5WniHFsYTLLeD/x10wlpuvV/k1sSyHAmzQpek8ESZB44H3WwgK34dvCUPH8NONEp
         svU2b1cuW7tlR8d89Vtz2bx2illmLGw6MgyyAqv7i6/kZcuN8J14YaXghEPzwAFrUftB
         SGrQ==
X-Gm-Message-State: AFq9FYKSWofgr0VhkKsDqtQIz0tX8blW/sjAD2YSwUB7mkxPld8vxFdr
	QjfG8ilKdu7ndphWaqX/lrmCthfEPrmvVVpttiBIkyLmFXH9rVfCvxrx5drXgVBL
X-Gm-Gg: AYBFou0+z0i5FBtOVzVSaoOdF9tsSoCTneoRX8+nzUJUvZ2OWvXvfMDybFsujkO7y/g
	1bICb/YWr+46lhgacR2M3FumwHypOHT8Sqy1FM7mr2DijJlMTWcsxCF2snvsu6SQAXJKXVYWIBG
	/GT06Ug2PjviBsuVvTMc1xIQT5T926+YTs3C+sZ5dfgXD4N9tKt/G3nqZAJz8+BN7WiWyKfl1wM
	Zz6mNf3Zo/REqGaEdBJmTJZNyqlQwzT1lzXb6rpItxdNuBpx2NKC0ToxhP4hBFwjrP0KRG+myST
	N7e8g1y035khO5sQmVX6v8563d4FV7hliunnru2S3tu6dMT/lh9mbfYaRhLmfVEC5jzjfuDOy7D
	+0l9UM9ERNQIB8gQIDW75pkH/IayXpSbyT8sK0Ev7IQz4HMs3fydVvGGTqheWY+Km6aBKdzHCsp
	59PQ1ay9YhsNGaovuvYBkBf9T/uHo0RPF4Hm/XR8HGPluoa0d8Tg0DQ7Fn80016yfnMMbTt0x/v
	rNcetuUi3sM5UmOqnc/+EA/OL4oJcHHygw1Es2jcpZvKH0s/fT07F+AfkS/LAVOOWQQMbl+JPpa
	q8P7oS75D9oPU0PNviuPSUgXpcjQ2nGrqrbB
X-Received: by 2002:a17:907:9305:b0:c46:8b87:c1f4 with SMTP id a640c23a62f3a-c46a9207e7fmr115096466b.20.1792717097907;
        Thu, 22 Oct 2026 17:58:17 -0700 (PDT)
Received: from kali (83.8.59.162.ipv4.supernova.orange.pl. [83.8.59.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5cadf3csm46548066b.54.2026.10.22.17.58.17
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:58:17 -0700 (PDT)
From: Kamil Sawicki <user148783812897@gmail.com>
To: netdev@vger.kernel.org
Subject: Re: [PATCH net] net: limit priority VLAN untag depth
Date: Thu, 22 Oct 2026 20:57:41 -0400
Message-ID: <20261023005742.1144360-1-user148783812897@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023003750.1133904-1-user148783812897@gmail.com>
References: <20261023003750.1133904-1-user148783812897@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I discovered this issue while researching the Linux network receive path for
Google kvmCTF, with OpenAI Codex (gpt-5.6-sol) assisting the code analysis.

I manually reviewed the affected path, reproduced the issue through
vhost-net/TAP on Linux 6.1.74 and current net/main, and validated the fix with
differential KASAN, ftrace, boundary, GSO and BIG TCP tests. The existing
Assisted-by tag records the model used.

Thanks,
Kamil
