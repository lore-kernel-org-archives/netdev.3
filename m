Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636333;
	b=zNLvgHD8Ns1JPNIOj7P/muNY49GktEaA6j1GqdZnV6bBhaubqpKneWueiuXU3wXR91iE
	 bij9fMAtKocp/j9gFDZL664oggRrP8g0Ho3oN/6sPeJaB8aClEtf4IOvaMinC07qbviy/
	 +h9q861+R3kutAXAUP9ymEsEjxhb2TpUJOb9UWV/qi63p4awIefUz5gqDggl+wmD20PWZ
	 m24V7ZRgng5vvYlnsce4IHyB6kZOCFTsQgmhQ1BLvo3gZsAa8y4YXDaW6fONM/oKTcfhP
	 jR9fynxBY1UBpo66R8AYgxqYe3le1tJZef5D1mq20GD+rckZzFY4T0WCn9Y4TFSkbvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=FmIcFldBwSvZofS3KE00AHPHUf+fTzDL1zSxVEgBLFU=;
	b=oyPoYdcvoXeB83GrVP5EBL6FKgVNO0E57YsDmkm8HsbEfu5ayqeMctqezcgGQTvZxkLA
	 dEiltFDnzANNkaHlRZuSVrseVZ5bJ7aojZGi+iO7kqxnPJ63pYwrb6gr8TMOsAK2EPgwY
	 FK8lWxNUdiOQmMojdib5AJIvhMumSVhLhHKIzxLG104dOjqn+PDzTSsuNRhF6qtip4ZX7
	 5MfMlgFITNEpnhg90lAJsCpFQjuztnKMiLXDhjPf0gbOVfDbMmhY/t0whQzQqhFPasrMu
	 co95EwdQnSgqFINMdxeSH1yhurU4kB73hjC4V9UqMax9Xp+z1Smvdt11VhqJHC3qCWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qr00LX+p;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30724608362A
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 16:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30724608362A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qr00LX+p
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso1113748a12.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 08:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793636332; x=1794241132; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FmIcFldBwSvZofS3KE00AHPHUf+fTzDL1zSxVEgBLFU=;
        b=Qr00LX+pev5ohEtqTqwX9gkiynVq25vhLr+e0eaMDZhfvf9ZZ/ckaoGlLeNVkzsn3U
         z3fECQAfpsWMzOpsx+WeUPEk0FHoQSB1IbeBGyH0MiEMgIuRfCiaKZ50Mms8F31V0Y14
         RETjtUeT68Su92/VmC5kW8OcY2SBCFj+HCwWUzHeuGPGaBmkVk01Wep04XpjWv6o4TTl
         DSFaAXBHP/MnEQMMLPrWOJCglF5fKifuNvjPw5SIwmd+il1bYxcuhUr744SmNd4Kqa9e
         MZM76Wa3aQbJcisGnBZWgh2q5LuyGJrx1He8Yfi+4wNbGPjfO81TOTxME4lmJ7dFz0Ke
         6CPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793636332; x=1794241132;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FmIcFldBwSvZofS3KE00AHPHUf+fTzDL1zSxVEgBLFU=;
        b=PNGpjfne47iGf61H2RycduT8+Xk845asXhB5FyxEcHVwJ3TXT1lZDHoBzvZZ0BRrlm
         rpILEkL1o6TSMeYHiz33eWgxSD6N91BOC+mq0gTjKtgNlbhiYdgy8wpFCGl4YHlUl7dM
         XFZkJBG1nlV9J5GLhHc5XIvSn9MjOXN8hRluBParGkmlusTAiAB2+wDJo46E7HZlioO7
         SnrMhvq1tWvU/Lv/MsU0aWYOAxBjUAM41jrfZtu+Rf1/7eS37ZeaFqgF2U16pd3dsO6q
         SMnz4aOJUrnnaZdwS69aj9nzl+VuhXg+6N8FBgeTCtHXT7P5gggxUabXCiqj5uXB8MJs
         GYuw==
X-Forwarded-Encrypted: i=1; AKwUvBxRxll5dkPjcZRKH0kR+qgQ7N7cnlGj7ETWIta6tZn2jkoDSHWw6dHAfAK9GsTSYf/CGijw3B0=@vger.kernel.org
X-Gm-Message-State: AFq9FYItOgwVFHP6vkgBYE3+2V27cHP9whNL1twhPIwC+IcWskFhRyJk
	nKRX0v47DZnIJxF4mfo/2M5nNOzYmVhiOdArThyez+Iy0t8qi6nebfzf
X-Gm-Gg: AYBFou07LdSUMhmxwHehet24SETm8XuYjuVRYnA+GaqpmHzpy5ZvzaMoQt0pgCmhALu
	THfCVP7d+W4g8GqpbLkb4uBKfso8/0MWmNSIVT/zjXUemiuYFprhCtvXxLA7bOTlDh5qj5qjAOC
	ihfckneP+bRx68lvWMfQUAPhu+V8dnBrOluBciryftrtPKBt2/H65p8mv0ka4JcSU8J8I6aH59w
	yzM65zMF/YgwbvGJaGxJz51ryYvDQAb471IZRe0e9TNl2I83OfCIKx7o6ZqdjQrGkRwwxbQkt/O
	LpVAMzmf54EBDJfFD3Tgbgz1/4m+eEUkFn3rkjpv1Tfxbln8T7i33yomeLkr5apODyj5wTqheeH
	MP29xVJnUg8Ouhw/1Ks0dxBSbrxt89J3I3va6VxDRqW5KbSZuHH7DZKR5xM7LfvZPGe8hkw1SJl
	pgtVUy2w8Bu7LVrHRndqxDlhVjXzC1aZ8KiLRJu5Yv+fpmaR4uMDM/4JRAEtPLDfxdAbcoiRjfF
	yum5EfdVIXBOdF5mbPwvuYheXaRjBzmM5dd/qaeWD8UMg4fZwHJQHgnOkaoCGq1db0bmPEuVmmy
	Mz1xLYkSu9+HddEzNMc67Vj5baxwFTrEMjPjOXZbsQNyXkL3IXrcdqQdgIu52uyHMv6Q13GBaHa
	zaXg9djsV0g7tNBHEC7n29ZcWFRJI0Ln5D6lYgkQ9svrnSAgHqT13XTI=
X-Received: by 2002:a05:6300:8047:b0:3e1:7b85:5a95 with SMTP id adf61e73a8af0-3e928ce91b7mr8254146637.28.1793636332340;
        Mon, 02 Nov 2026 08:18:52 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d03424sm2308383b3a.24.2026.11.02.08.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 08:18:51 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 16:18:50 +0000
Message-Id: <DMKV0IW3XAU1.3KSPCJSXR3Z3K@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@google.com>,
 <willemb@google.com>, <matttbe@kernel.org>, <mptcp@lists.linux.dev>,
 <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 07/15] bpf, sockmap: Check the target of an
 egress redirect before each send
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>
In-Reply-To: <69e66c9c-f2ab-41a7-972d-d1562a6387b8@linux.dev>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-8-alexei.starovoitov@gmail.com> <69e66c9c-f2ab-41a7-972d-d1562a6387b8@linux.dev>
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

On Mon, Nov 02, 2026 at 04:32 AM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> I can trigger it by redirecting data to a non-accept sk.
>
> ==================================================================
> BUG: KASAN: null-ptr-deref in tcp_sendmsg_locked+0xfb8/0x4550
> Write of size 8 at addr 0000000000000008 by task repro/488

Thanks for testing.
All patches have reproducers.
I didn't share them, hough it's a weak defense.
Anyone can build a repro from the patch.
