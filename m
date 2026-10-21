Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601113;
	b=JFRH8PQJVPDC1HBj6ecuo+nTr1+9JggW6LVW0aAglDntzOTsVWG1eLZ2eUTK5e5H66Sq
	 nhplt+umGO+9RbZg2RoR6mE7vuh1O+rm90SgyJFAqJaku5fMbfF0wB0erFK1qlub/5gKA
	 raCRDWWQFlSf1sFnydomIbum8sceaVA52V7wERNmjG/rKB9fekzv39/GaGNCT9j2/fNf9
	 iVAbLOIGY5A6ApvA0bvr3MAmrjHIcQO/uNFkAGCYj96/7FsTQf2klEoZjXmW1xrHvTX7H
	 uEIYYe1itcP0WfXFtYvFPScuO7kkZ1XDXJA++EWRc+BJ1G/APmvmu0q+Q/TU/MeqFng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Y299WPPaxWRE9ha0hJbAEz/L7is2XLFDnYowFbrmq1A=;
	b=WatNp0xGlwePgLfutpDCnWHawL31qliEU9aw1/8fnJArKgg6KdMxIGaxy5me5vaSmjIy
	 hubXy/EGheYgyC00r4zCYSpvu09gXYdk086WQ/U1iCX5HhZtQeN01vtDag+nVUxb+8200
	 7lPvru7eKEwcle64K8jj/d42kJ2v8W20frBWMhKvLvxdt4HOnhgh/psVwI1LuCoqJlt9W
	 CcFmoUoqtV0S2teZAu65mW1MGMVzfmgYBnkVLKS5q8G2pCwfewEZt5TRDbopEm6odckGT
	 /StZMSnpJ0HZ7+MQhKAupU2PVegsPfLlZ99kUJY0ZkLWZqhC+/q34m6+RXXQSxb9EPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nMsOImcV;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C75606A31F
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2C75606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nMsOImcV
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so787628a91.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792601112; x=1793205912; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y299WPPaxWRE9ha0hJbAEz/L7is2XLFDnYowFbrmq1A=;
        b=nMsOImcVkm/FZH/V0VjYQmpbt2YaIMt0P0dxfSN1jZ6h6rCtW5BuNgoERp+DqxUTeK
         W+y1TT8vcfcIem851lDwk5ixlioQhKsY4qlqP9HRAG/eaigUSRGZZRM0jjLYKlbu6mC7
         M843aU6fyX0neTfZUimBqUV1d7r+HTOx8ZnvbXphOsMblz0e+5aLp+7tf7hvs5VrjFRq
         4LA50+/PSvpFa4rN+8mADRHkfFuL9UMG0XRjJUpkxCz9JGYLd23ruh9jBpegPycYFugE
         XeqEvtNBYYb7ZnjoezBOTEQJOHKvnasTinHSYHr3GrApogq8luAek1jMLoGP4VLGQldm
         NW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601112; x=1793205912;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y299WPPaxWRE9ha0hJbAEz/L7is2XLFDnYowFbrmq1A=;
        b=tlZCpcJ4LYhxy1uf1oZ6brO9ylvOSlZ81b+pbVYHskoVwJWv4u38ONjMK5+qoxRfJt
         dgfRKPF+ejuOhZiAOQX2lFgGGN40DN8mSOTLlIuR48M2lX8YfcS6W61rtSwP+qpmfNOR
         jcF8W8vwQ8hN7hQ8S7bLEBlgGeHgCow3Ra8gcJnZAaoQhqOqo8x+C4ILGUC5DQt66BFw
         7xiO1wusR9wWmQ6gi7IGGaePv+2cIKwgkcm7ZgioBf746XGbY9E4pCKLpHSN/QXDT+OE
         k+cayKk8N+OPBd/ljdgSYDz/z5H6jKqydj4kJY8wSVOOxe3ZHjrs29b/hu0hF+bB0aBE
         XWGQ==
X-Gm-Message-State: AFq9FYKK0UxTUmfMLorXvjMIv8W4EVeFj5YJkQzk4/74Xqm85pfP5odZ
	KRUG861A1VYsLatJ4wUFntKcJyKcdAQ8Qv421hChwRXWB4uXP/KjIhgx
X-Gm-Gg: AYBFou2EyD1orB7r/bgwYLHuAajJGlGNgXIkYY+AA4R7zuerv3ia+pL7k6jNVjXrrPD
	PI2NB+ft3TD2cKOJg8O6a4uTI3YcwtNH1mhV+0y7vFiL5K6D2b1HcTzsXrWhziaiPe8BU+Xa5Zs
	ZFpRfuYeZ/DTm4l37SJnrI4YhRcgV0MCePRhmKyEfRYx8exSx+u7vFAUKf5ZKswA5gtv9lQgN/S
	kV7Mvgih3tcRgyG76wgmD7dxMiLrNYw2zu+blGT21SeqT3Van7flCYSISw6oOkiDPGvgZ8prby0
	+B17+IkQVF9lJTdpXYICSYWrGuA4enIhExxSHwazBLqmXG2KExzTbkn8KN+uYRb/Vtt9WsepFjJ
	JJya+jA9dcgXvnjqYqjFtSNprnj89EYmZ31oFA35wVIlqMKazHcvwj90L4zfhIo0kg0KP5/rBQd
	EEGs/l+t/LReIxvcp7FSJEagxAZTdIFJsCoJ9HWFIXkcfDBxcVaczggZ/cZ0/b1k1fnDJ4aIq3+
	sfy81HF4sa9ZzghqD8zVBAyA7tiXsxzDoy2WD5hcrMg16AMvt5czNzEV7B2HplSJkVQbHiD9h0s
	lnecux7dFL2HWBCnQ6xrK4+zTA2wTs+GLQ6eInqNMBQ79iObnfv7VxARulxn
X-Received: by 2002:a17:90b:17c5:b0:3ac:adce:60be with SMTP id 98e67ed59e1d1-3ad86f44ed6mr2508283a91.21.1792601112182;
        Wed, 21 Oct 2026 09:45:12 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6b8645bf7sm265815a12.28.2026.10.21.09.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 09:45:11 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 16:45:10 +0000
Message-Id: <DMAO25C5MTPO.1PS8C0R1D0KP2@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, sockmap: use READ_ONCE/WRITE_ONCE for
 saved_data_ready in the verdict path
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Dudu Lu" <phx0fer@gmail.com>, <john.fastabend@gmail.com>,
 <jakub@cloudflare.com>, <jiayuan.chen@linux.dev>
In-Reply-To: <20261021155629.68813-1-phx0fer@gmail.com>
References: <20261021155629.68813-1-phx0fer@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Wed, Oct 21, 2026 at 08:56 AM Dudu Lu <phx0fer@gmail.com> wrote:
> sk_psock_stop_strp() uses WRITE_ONCE for the same field.  sock_map_link()
> / sock_map_unref() touch the same psock from another CPU without the
> lock, so KCSAN reports the race:
>
>   BUG: KCSAN: data-race in sock_map_link / sock_map_unref
>   BUG: KCSAN: data-race in sk_psock_start_verdict / sock_map_unref

sashiko is right. KCSAN will print both with this patch applied.

pw-bot: cr
