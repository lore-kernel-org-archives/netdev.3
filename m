Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793637238;
	b=VdWFnYC5qKz7tw7d13AVsAF2Sfz+St//3RM7Zke8M/7qG2iRe1i3zlnt0kHD+XCOS0VW
	 v2FD5pBNJdoE5InBaR/NfJrjW2PNGHZ1KnqG5zJG/Kj7UN1yOdCFMX+2/N62E+7wt6X67
	 Gb3/34waO2zknGdaxZ2gKLfgOfKp03Eqx16vpaBHBhDX1rJb0mLmmlVtZHlSF+8g2SWal
	 MYet99aDsTjcRWfLtCs1samBT7shRpwZvmcnbOxVtTmtDQ+BIOnIMa8sY1VYeVowgAX8j
	 sDTCFSFtlZSwHVMaNVQoIsjzV3ZIcZGZqiiFWPps5ZN5/fFCCJ5TbBhY7AmqPQe6RwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=b4Epp6GXX29wADp3IHwfP+1qQXTUzuhpYxT/2bZApoM=;
	b=ILLOqQ1qu+D963g3PcEP1z+dTtLGWHgVc0Ygyq8PyUxjqEkKFMI4cUo5u2eSmfGZrAyG
	 Z5V6H4BqJH4aEApCdvLkVb1R4qDMqd5ecjEKsRofZpwTJFCf/zEcb/n5zlQtcWVSRxktw
	 4U710k/nv4H8DXK43//tV0PY+clHcjpXYGeZr9u3gGZ40ReGNJk1ud3DnUciZ0TF30yNB
	 aDRx6JL7g/S0T3cFWRpH0MYgR3WL57sM+Vx6LX4NBTqU1FMf/g2QPaJH5uYi/7HX3xVzH
	 4QH3p6/08rW4cAOzFRestS8zIwOUbAoWlOxVxlmVG31gTgbjlF17k2z3M4Fo7jsXCGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZkD/WsPU";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128560A0CA5
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 16:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6128560A0CA5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZkD/WsPU
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so28952095e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 08:33:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793637237; cv=none;
        d=google.com; s=arc-20260327;
        b=XUOHad1bk5SKbEH8Md19dRUK3weJAiE1d2hDQe2pLqCQM6xIQTSU99D8QgPoKUSytN
         4OZlXRFBG+Gf7Vo3Z5t/rbq/dQ7PFcClk7UjVbR/jv6El7/TCKDyxNJKJOhRVWFWnKIS
         WyjgBRC3SW7aWm3wSRk/1FpdTCStVVCsG4TJw4mgURR5R2cn5kSn5THybrphWm9gJEZI
         luWnTuEO84KzD0INs04859HbDGELDL4Gh837mswI5WeTLiAKKBdGSoeawrqAqCST+y4N
         YtPrM74k6Qa6M5ahGahCHXMRr6RBdDrI2q8XeY0PfoXKG+oar1ToufWRD3jJm36zWncW
         r1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b4Epp6GXX29wADp3IHwfP+1qQXTUzuhpYxT/2bZApoM=;
        fh=4kbNhq/hHkO8vhMTMfApVNiLQejzT56O8xS6LgQH/w0=;
        b=BFaDqozj3KOuK8TrmhkuUYiLknIDruKjBC/F1PpJDQBUpruDJ3J9qSDWB3yiw70dIF
         /34OwZriTp61F0TDUafDlylzVNOm+liWt+8hbBMndmWeo1g6CoPp7fIn9r2nd0yLQ2XK
         K/POQs43EFAg20GPuIGdUpS8nTUV2xglFpwCUce/uTqzry3QX6I+4kL9XakzriK0viK2
         pvA92eZ8WaqvS/Ll2V2wBB10uhHsVP7mF7ef1x1kodtfLU1z8qgrCnf86jLdhPstgkrt
         3kXnFyobDV7wzYWUNaghZPcjokEMQF7eb8DHDSSNu7cLn2/REs4uVSgsoZ6Xi5o7Oj0F
         r8Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637237; x=1794242037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b4Epp6GXX29wADp3IHwfP+1qQXTUzuhpYxT/2bZApoM=;
        b=ZkD/WsPUfQqqb0Ko9RW5x/5QAVS7r9isZSz23PjR13GeVO/T4ALeRwb8OCo7NYh66J
         Q5eJMIZ2fqgcnM7QoJ7l2ZA8BMizlSsxYOQniYp3zwAqPxq6Bft1vWGIT3dvFdtx+nMz
         vVVr9hUxj9WHOk9bWMB1+BHYEIGDK5MCnlsQkYZsMwfy1qRC8vv/FX/4dqgl6cpAOY+1
         Ef5ZbeRkkWKKTakPB2EB3xHOmkHs+3kfDHaTY0iLlpP/dvp2v89RyeICsJZm9xu5uw76
         sS513+jN968BmCNohD13d1fYUrlPuLdY6bdTTqJfqyq2vm3s14AwtjgkKKobNgtLwwH3
         akGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637237; x=1794242037;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b4Epp6GXX29wADp3IHwfP+1qQXTUzuhpYxT/2bZApoM=;
        b=S37S4ylCmeCAiqnc5mYQ8AbXmf26tuUG6WFklHbqp9pAe9GIUiqLc3dg7UpkaC1vB7
         GV63HImubw3C3g4GgQ+MOMfQct66Nk+bLwKeDHPhifkFQims8fZp+nCG9Ae92ytTobgW
         ScjeKB+vdIC4sQR6mMvJPKhV1Vm14cvask1vLOpqbzMtrtlyhAHEFtRqXtBPQS5SBDOH
         FveyKGKX2BjlHvkznSQUy1jNmn1/4nAl5vBhn1oXd0n+C+TChs5KBGNLcl6P8mjLkj45
         cG5Z8zdq22WjW+jgdT/T7VxNFXq2SbhrO+N8XpcUJmMUIwu1EirpEbgmTpT0CjDtuVcd
         y4ig==
X-Gm-Message-State: AFq9FYJ4LN1ibAIs2w3M7l0rH7PA8yxNRdInIQKmLHoC9rWIYZTfUEDV
	SOpZEJaC1E7vGzzEcte2qdR3nq5YMfpGTqeYJkQqueygaVEs1AqT2h88EZs0XFmqvlmBrHIgCGw
	NsTROKTWnbcfG3iUjlEmWJrzOciWJjQ9gLg==
X-Gm-Gg: AYBFou1fClPZ3m8yDl1Qxdg0J74dfx7/NJzMOE7YjknOmpWrRlEsP5+PdWA1Vz6j8Il
	y2SZsdwBfrR32aP3mwB4PafX/PDS3GNxgUAhqo72CbKYMSisJ2HIvpND4ztaWkRtWec+j4uFj5l
	iNQSajBS53iplUurkVZ0hN4JQtPoN1LP3kwVNGS67UZbPTz6VjxKYXDwYD7oxmHxjsJIzArUZLX
	UZUyBS9QL5Rinmub9RW8/5G1f/mg7+LWQ5mnIL2aXu03O5uMI5to0EeT7S9rjSM6j3E0BufJGlC
	XndQIpUl5GGStjO80H7XT9ciVbpeiU7wDd63wZgUWqxNpuIv0phfIsD3m5cf/M3eJraZZg9liwJ
	6lzG3iO0QXWjdslL08Qqv+ulwky23i8dUMLmcU0OilJrJR/bbvAiQupDyNI2wdRKHKPAMzPX5gn
	n/t8xKH6uGKbdoR0A2/bxxKlAbOmYiqmYGnSGmz1oWWpchZJ02AoA5iQ==
X-Received: by 2002:a05:600c:83c3:b0:4a9:18f4:925e with SMTP id
 5b1f17b1804b1-4ac174711afmr236632205e9.18.1793637236634; Mon, 02 Nov 2026
 08:33:56 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 2 Nov 2026 08:33:19 -0800
X-Gm-Features: AclHuK_LEJ3H8DEM-8wdkuerMwl07zVW412F-nyfFBxma7CYkAr6UtVVxAbMH6E
Message-ID: <CAKgT0UdcmFz4VbaO7wJKqqt9OqKonCu=RHkwjsHgqM7Waky5pw@mail.gmail.com>
Subject: Re: [net PATCH 00/13] fbnic: Fix BMC filter, FW crash restore,
 teardown and Tx flush bugs
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 2:35=E2=80=AFPM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> Review of the "Rework the BMC state pulled from the capabilities
> message" and "Remove BMC routing rules when the BMC channel is disabled"
> pair, d261a371e3b7 and db99b6fae21c, turned up a number of bugs in the
> surrounding code that the pair did not introduce. This series fixes
> them, along with the order of the ndo_stop path, the mailbox teardown
> and the Tx force-flush.
>

[...]

Based on the Sashiko feedback I think I am going to rework the set and
submit it as a couple batches of patches instead of just this 1. Seems
like the work necessary to clean up the BMC/MAC Addr stuff will likely
need more patches.

I will strip out the more direct stuff and submit it as a set onto itself.
