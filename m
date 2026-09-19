Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0F538F920
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789841557; cv=none; b=A3WKRPTWMCUNqVcUOK5o5aet8CgfNPdtXgpNf3fvzgnhyujCakyKVpmNeIXIUg4YYNdyuRi11kNH+EtbSHy9PjdxynyJu05n1uxE3QOxQpPjYF9oxCNhG7S2L4P7zWldQ3WKa4/5T9QdvcX2R8EiLps1SYoM/B3tML2zfuqNANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789841557; c=relaxed/simple;
	bh=/2hT6zgP+mOS8MJpGIqUTtaf0kM1o48RlJDVs7oiUU8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aAbyus5/yJaCsf8h0W3q9zCwV48qhaNw2qS1thiZzlLbF7iATeLG8ogSNK6jlALjrDCJ0PuMqTtKLISRJDuXvAzNkjNcaBWKsUvDKmTx5BMH3O5chZajZSNRsJ1aBAZOEzoaqhXXRsyfncP7Uuempg6ERI/pRKpEqDCkikYc25M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hlj+FH5p; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hlj+FH5p"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2d747f0135fso17175355ad.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 11:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789841538; x=1790446338; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=091mGJb963fZm7TN81QDLSJJlLLidQRDCWzb3G3L/U4=;
        b=Hlj+FH5pty3MgW9dhXqZ4rezBLYI9J1ybtdgEvkGYQuFV9gd5xWcQpxYB1uMlnKHYc
         7v+osd5n1XNmTBdcfYJSDWQma371G1Z0KeYo8bkuv50CYJ1a3Q70vRTQWgB6wnJQjhjz
         I8s3Il6wiIkQm1GACBuzn6tBbPqxMiCK1vQ6wibbuHTfkZHqsjc7Ou483h+K6485x5ZX
         TlyAgyMLrorDwvtMqfPR0pW0S2UAm4g6npucd+Ai10OgS1Y/Rb/gA0k9nlm+gawDMf2I
         DkqnKumGLjhk728cJhyMJlIeeJm6GB4TVDc6XpoVNznu8FxGbKsI2zMZ8Gbut3kilgdf
         vpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789841538; x=1790446338;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=091mGJb963fZm7TN81QDLSJJlLLidQRDCWzb3G3L/U4=;
        b=pnbokbqAqf6VPl2SYhggtumDHAFbOloLAytZoIpgtXqG5rWt3mRzg2+DrUf09rkR07
         lQUvKx2pvSOMYtAR44lgot9mabyQBAX+C3QiaS1tFqnz68Dfqz3DEysdYYKuEzp8slvJ
         1vGUiUBdV1rXzAEyhXt+lUAjS4FrUTokbpXD6iOTMgA4c0Ugnlp4urY3kxeyoCJoy667
         2CeHRQVFjEurtl0B/hNRnd/RWhFQ6HIcYcvME0eBkhKwOf44EV9chvmNDYWKLZazhIl+
         A/efO/ej+0Iw1Yaf06znkM/cJ61ooxed1N7sahYZv/C6NhQcvHGgHvvkqyggw/27OWu9
         TDnQ==
X-Gm-Message-State: AFuF++k1C1xzjt2erbWGd4V8LqxpTxLTI8UqsoKy820Ap2Iog0ypplpw
	M/bjfDF86tlT8mPh9qLGLCOsuKFlONrCjP7bcbarmS2eB+EKJ+E6GOC8
X-Gm-Gg: AYBFou3/6fVEVFCejAhpOnmWyOfFBGakWB+aQQXMkLO755VCQdHrHKAbji09/oVf2L/
	vb90la/Wcq86285d+7i6aXJY52pi5/lAmwb8OhQ6CYi2oNGgxxDMNh1oodaf+WeLdA8yE/TLU9d
	tW3/t8g5nRwIDtfLA1skE67Shf65ul3sTCbqljIBU5HFMHzNMwIym1zkLS6b3BjkhGXN4jiJBgB
	rcJAC+EHj8erfjOrntOT7XIRhO6bBOPAz6OJFyzpFaeGAaJeJEar3mf/CsKPt0DRbNEoxoNHgqB
	2A2rvwF3bmYqYOa5ST01vu6I08adRR/lKcjCHwTlLHBQHd9xOizUfegJM2d809GV1b53EWDoHO1
	pn8Pr2NcIIUNeoUWP10T+r9aTxzYyPUBMZhnUe41TfttpN/3ZLg3aQ+Srtrw2EcmpJGPR83qtPR
	lnbgVxzFQrbpdsstZMQ2VnOPPltRMO8anNuWZoYXl0g5aAjriS+Bq6rn+5sapwj4iVf/Pz7JyAb
	25YYrmVn+OlXhet8+hg7JXLyJhf89YKQtDF3K5sHZMvZx4aXUOA3kCpYg7Tb90Rd2kBnd5GX3a+
	kQ7f
X-Received: by 2002:a17:90b:2681:b0:39e:6c6a:657d with SMTP id 98e67ed59e1d1-39e6c6a67c0mr4274816a91.64.1789841538426;
        Sat, 19 Sep 2026 11:12:18 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a02738654csm3624279a91.3.2026.09.19.11.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 11:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 18:12:17 +0000
Message-Id: <DLJHVEYXMZ6R.1YX59HGMRMYO0@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, "Jason Xing"
 <kernelxing@gmail.com>
Subject: Re: [PATCH RFC net-next 0/9] net: BPF Timestamping 2.0 for TCP
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jason Xing" <kerneljasonxing@gmail.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <horms@kernel.org>, <willemb@google.com>, <kuniyu@google.com>
X-Mailer: aerc 0.17.0
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
In-Reply-To: <20260919143732.11772-1-kerneljasonxing@gmail.com>

On Sat Sep 19, 2026 at 2:37 PM UTC, Jason Xing wrote:
> From: Jason Xing <kernelxing@gmail.com>
>
> Greeting,
>
> It's BPF Timestamping 2.0 that aims to observe the packet latency
> more efficiently and simply for different protocols. The current
> series is only focused on TCP protocol.
>
> At Netdev 0x1a/Netconf 2026, the history, background, motivation and
> rough implementation of the feature were exhaustively introduced[1].
>
> History
> =3D=3D=3D=3D=3D=3D=3D
> - In 2009, Patrick Ohly implemented the basic infrastructure
> - In 2014, Willem de Bruijn enhanced the TCP latency observation
> - In 2024, Jason Xing proposed its lightweight BPF version
> Detailed slides from 28 to 32 [1].
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Even though BPF Timetamping 1.0 is comparatively low-overhead,
> transparent, it's still complicated due to a few points inherited
> from the design:
> - Inflexible/fixed reporting phases (qdisc/driver/ack)
>   When we confirm the issue arises from the kernel by using attribution
>   ability of timestamping feature, we need to further minimize the scope
>   until the issue is fixed. That means, we then have to resort to write
>   a few complex BPF progs with the similar functionalities (like skb
>   level tag) which should not happen.
> - Not enough low-overhead
>   Serving the sensitive applications, an always-on latency observation
>   platform should mitigate the self-impact as much as possible. As we
>   can conclude from BPF Timestamping selftests, there are some blocking
>   and time-consuming points like where reading/writing BPF maps happen
>   in the extremely hot paths.
> - Minor flaws
>   There are a few minor flaws inherited from the initial design, like
>   missing tagging the last packet[2][3][4].


All these "issues" sound minor and on their own do not warrant new uapi.

This RFC don't even have an example of how it could be used end-to-end.

So soft nack from me for now.

pw-bot: cr
