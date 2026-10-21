Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792605217;
	b=pYy+qFbSSIzIDV96c6L7JNXDOpDjBzFQ1XTC5ZXs/Tbo51WNB+rNzykNWwW2NSxNsw9a
	 KKvKwUivk6Mk4vlUcC6Se7iGfaVma2yT53KhGu3iXUUppotympxILmCxIDDcr09fhPrpi
	 QXcbaS7hQAnRJK9Ao/On47uHqjJSYL/OjTJWJPhNqK31tQX+qNjCZiadNKC3d+dFExouY
	 sgKz0iHnrF9ozq3EHAtDPAH/sILFKbDq2KluQVV6yO/mEpfOBOJ2ztTXku/YOQhDtxR8A
	 jY14cIyF+a0sD7vR+Kb4lrPuBeiuAE6uv+W/2eb7+z1faCGJdzsHHnsHK2ch2q5vePg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HRzIKbKLO9ua2/xR6UHeXwPGuH+fej2x2QAgvQV43mY=;
	b=yqwIaaZNzlr2idudUxGf6o54qxNEj/faUhAEgcN5N8tnfBTGZU3X9BcvRIKC1uz+V4P9
	 J3vLY4L73ptSyML+B7Y+akqoEupdipl2WAF5sUjq+jl6H0s7kIAs0H+3AZc+1x17thABa
	 PAXpSErDX5xnojmNjLpnwk6PR08OGOgo43M38Pvxp5yej09iE2vw2iIADz/pF0v4WxgsK
	 ECuizOjoYv8FLtZSDuof/Fd+ZMqEobvGA7v00fO8s4BtsbyBAqxfypTjcLMyqVux9R36M
	 qAmfAZzlXC/qajvyrNoXY/5dM0Yllnnzck055tSR+IRa3oAquE+/33tUO2Sn1AVHARw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bbx+Yu4t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBED606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 17:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FBED606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bbx+Yu4t
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc502d509c0so327532a12.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792605216; cv=none;
        d=google.com; s=arc-20260327;
        b=snSRaXqwa4WlGiJ6z7pz/a7pauaboeyLJTLS1fKY45sPM0U+N0Zc3u6fRdBArR0PvH
         bGCd3B6dIzWWLkvIL4I/HYt3KYQGrU76itKe7tEv8MWJmtK5u+YQKiv0oxyM1ceaXt/I
         lQChCfzVenwegU08DEjV4MkXO5lFa72V1+/LrzqjHduV+E3uuRMNPDczqomMw9mwNTLM
         SQnCKx5Yk/PVRKT+/aFa47/iyHEqwECDd2K0ZRnTK5gszaFMcKxA7j1AhYSFE9Q0eJ3C
         F+WjnYRn9khiNWwW18RtSUvf+TyTPAH//DlHSecmkqDeG2Oo/ndTFe8fRwrScw5kAPmP
         Ff9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HRzIKbKLO9ua2/xR6UHeXwPGuH+fej2x2QAgvQV43mY=;
        fh=qiJ4bl5nZ27SG7PHE7wMw8l57QeCKWyTaYcbtEDqhwE=;
        b=DWSTxnz05ErpadvK7CVDSGpDUhRILVwPS43doVknkDoqKb31/zP683vhJnof+xfNFn
         topKiU6d6N7wq0tCtW4sbkG5JJeBXmLELJUrIaVlajIDakU4rgk/dqIda91fd/WKftfA
         WciLCAcbWWODNVegXd4WQbd3wM2UYu/PMu7aQt2wpgH+A8K2J8vxqjWHZVGr/4f2MlQJ
         xq0XzDxp0GqAxr3E3XVJ7buLUQPUZzAhB1E7aqp4sl5POPfNx1MWr3dSJT94NFVS7LAE
         8NU1OySi6sEYKAFvoawVwmqkqoLteinB0MwEBCUg25qq3as5gLB+eH8HcNHCQEUBPz0C
         NcZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792605216; x=1793210016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HRzIKbKLO9ua2/xR6UHeXwPGuH+fej2x2QAgvQV43mY=;
        b=bbx+Yu4tyXLlbw4MnlGLTvddW1yf7vyK8FTcqgruyy9PZUNHGwqV6UtNX8F5po3in9
         wLR6thuruF+xn5xbrbi4KJtXndc46ra1yeI2RRCvABOrzb1qbuj0V2eyRLPapvaEg9HW
         8/4Pw3rVD/HRGHLXrjgBoc6MXDKiqBzBCeDchiNen2q5Z2aGwfzoPtdYW9fAoa3RuMq9
         AVm3AA8ZB80Jixd7Yxbzl6uqA9QARcfd64L/0KppQEZMbjIV1LTBqwoTo79Q8o2wgurA
         HDJTKkOcWyCXcB+0jd3gnzpn/iu5m4sX+gw+rLwcnUFYB+yyh+O7uZ3wfplsV9eKat6+
         ceaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605216; x=1793210016;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HRzIKbKLO9ua2/xR6UHeXwPGuH+fej2x2QAgvQV43mY=;
        b=t2UHBd5Muq0P6iIdEbWXu60x1XmXRQJXokCgsTjxCqO6NKnT3eTTprQS5rGlQ7TcYD
         dd89Fpz8bYcebPMCv6Ulv5SKW10+MrebYGPbOV2hXjax9h+DIDOB6zkfqsgNpOq4/V/x
         xNN7A2svWwZPvkRI5vExnobnCCHSXHdWdEUhrLN6HYyfmYUiqvgq2DbgZs8lgtxq8Kji
         NxHlg4mWGRgG/zps9CIi9xnjpdErkDSurnocMbJxhJVRc8nzjrCqV/xI3pzcgwhYKeA4
         nq5XmAm/UcGXuRPjzMDTgmbrRljTDvfkj1dYDJYRSKAtyi+65j10i/VTjJmC5/xjx4lO
         tTeA==
X-Forwarded-Encrypted: i=1; AKwUvBx1NtsmdpbgL9LK3pFP16Oh+BGKsb+QfqRmGhUyUbMFmT8VhQ3EmAHYQev6YN3aINTsp5j5Df8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHYe50SHk7gso33oWgvCeqt/VYd5bmNSqRU/VbfffTl1es8G2e
	GpOcokSJDXV9BhxsvZo2l4+8WJBzj69tJlvtEcq1/HJ+VRyw/higpPJaVjJJgYF5nSvSNSRTRbg
	JQNGA64yaP0SB02t++1q2pkxjO/JZTpE=
X-Gm-Gg: AYBFou3GD8UuI//WMvnYJ7p2A6pk2r+0A+6OdywW3PrbO34Q6bmzOXkFgdC9WAKonHo
	9TXe9ItPHTvVUmmo7fN9UxQm3jTQZLSxOahcTCwoc5JQ2ELct3racRFLeRDFKKlFeVUDAbnnUCk
	IjOnJAdHYYBhEYjhdYul6fD9cpfTpRJF2fn91BRYkT/UbdWqtEu3EB2XbkueP/SjgedR9gCLlKa
	6bA1tZyJB9Q4a8N65aq5SAY0prloMYcoKubyPw9wS+dMOVLslckaSylLa8TO0JMCLFQmgPC68ij
	waOUDtVHM2x2LNgA9y2aQd0tt95LSLAiQ8Z5jY2rlyaF9EKAb0KV17kBKA8GjQAZ1Z+S53ob24e
	tfc47z+VxW3QYoi6SXdpMKoneUydihn/xTtivGo2eRP3ogXo/9tW2sYCOi8CUqmmT88a2ahXT0s
	MdKOyB/buxD6n5RpcTF6SUuNbhFd9vrz8b3RXRvFgHiPFQ38Lb9Ds=
X-Received: by 2002:a05:6a20:7486:b0:3dd:85aa:4524 with SMTP id
 adf61e73a8af0-3e287dc99abmr2330743637.31.1792605216458; Wed, 21 Oct 2026
 10:53:36 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021152455.71524-1-leon.hwang@linux.dev> <DMAO0T9BL4YQ.2B3YU3ON26N6L@gmail.com>
In-Reply-To: <DMAO0T9BL4YQ.2B3YU3ON26N6L@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Oct 2026 10:53:24 -0700
X-Gm-Features: AclHuK8_cFMGa7PixGohqfLm4WTItvsVIneWtEgSW9zyjr0DgVTz99PynKBUK2Y
Message-ID: <CAADnVQJLcDW5HyZO0GEYY0yWtERkULZxYEQs8hEzG19_WogGvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Pass extack to bpf_xdp_link_attach
To: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 9:43=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
>
> CI is right. This looks odd,
> but instead of CI's suggestion:
>         case BPF_PROG_TYPE_XDP: {
>                 struct netlink_ext_ack extack =3D {};
>
> do something like below:
>
> sock_map, netkit and nf links will probably need the same when you
> get to them. They can take &extack too.

We don't have time to do this back and forth.
So I dropped the series from bpf-next.
Pls repost the whole set.
