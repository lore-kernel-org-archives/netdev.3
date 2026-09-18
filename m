Received: from mail-pj2-f20.google.com (mail-pj2-f20.google.com [74.125.227.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C93C1D5E
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 02:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.148
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697454; cv=pass; b=ns+EX0RL7fLs1Jw6RLfzETrKpK75qIfW0Go7zW0C99o5W7sZExvl19EVF9FGM7dP7qw75w8mPmJ6ytK5fZ1gIQFq0jZp4MaJYj9ObqGU+m97W3bge5AZVUT7MbacbPrrUijGyWYOSYuDXBk/HiErGDhKQ6yvEdFp3DH3bCUJaMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697454; c=relaxed/simple;
	bh=1sQBP7SrkiTRTrgayl1ZMm59v8E7DacBcXYFi37yUzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGDB5kJygRLwQxZfl8fleAkQyziVwWCytNvRu9ZVYVExua5MjSRvvip9ISJH2Aa4AohfloSgR2pznHfBjhuqQvu02efOBDoLkprIjRg3jEtLzO71rK/iGGrVT1ihu2CcK8wyZBlZ5FwYNRHn6Vl4ir7Qvj9JdhEQFOCEw0hwlg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHl6crkm; arc=pass smtp.client-ip=74.125.227.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHl6crkm"
Received: by mail-pj2-f20.google.com with SMTP id d9443c01a7336-2d747ed9866so1950315ad.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 19:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789697438; cv=none;
        d=google.com; s=arc-20260327;
        b=HtoxzsE2T3uAlMraR3RPiqyf1fLI/MHNCegXvd5xAdZTlsW5gGxZapo4jrNjNoczzw
         G88mEqDxY7MIjSm2PdkjiEI8SLA0ZIpZjTq3/S3tltbicNQx83xCR/IFyhZA1tSicL+q
         T+BYXKWU4vulA/HJlMfauAK72mIO8rq8EuaeRCijcO/GYwaNQRTlJ0ohxEzdlrwMItZw
         4K69LUxewItV3lJA2X8tJOtNzJKY/EqbQ9N6i6PtDVY6ufTkBEo+TAE/EejxR1Y5ESuE
         LkTMZpH8CgeSOXKa6RW406oQ49BJ4LdSHzfjG1lKM0pQ/CEGFBnsl12WvtUDHu408F29
         mRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1sQBP7SrkiTRTrgayl1ZMm59v8E7DacBcXYFi37yUzk=;
        fh=9UIrh8OwhGRpN1sbqYJFQs2vVE8ECgjWyNL3CcB1p2A=;
        b=cd0xC51GaNTAfar2gXrXzeONSEulYCwrhXUPlLSZLSfHi4TGtmF/f1aFw+LKW9WxGA
         gkJvDW383jl2iWu8bO77tgazu2dYgcRz8084U3Km+TvEx2fXSZ7AEzW4N/yztMS2bIby
         rfVLct6TN3fvBsLhQiIgXMzdbvHZYPFMRzZOhtT+/KpXhtKMUiD3qJxt5CAcOa0QvCSD
         Tj+7S7AKj0rjWsNhV/vh+Gk9ff5EF3vnsjR7SDjxd4LH/T6OkKL52n2psnwpBg0CVDpr
         6Naeowu3xI5K2pYWjQTRr6n+uqGOcwo2lnO4nzd0gJnR4VcOsj5nUj9uD/Ox3SopI2aW
         zaTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789697438; x=1790302238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1sQBP7SrkiTRTrgayl1ZMm59v8E7DacBcXYFi37yUzk=;
        b=PHl6crkm73fjSPV3qwbNtdvvgUWfbFJUu75vjkG0WS8aNCEeA9ORcN7EEAakPNDLZ5
         YB0c1l6muddfY2jMfAQbqpw4I4dWROiCXZF1IOOVHmkEtTxJa7U1UFn9/7Rjzgsq4gqj
         mGosE/A6baJb9wFmCGHdBM8339JPjthQurWwpUx8s1xPYo7g5HZRuOKQzWDUcuPv67RV
         gcwXPG5GYg9XVP9gBkTahTWAq7ffG0ho0Oe4OAspYvF/cVgFb4gtmCith421CtJ5jkNj
         D+sOxmb3qQRRU1EFopCNaNUCXF6nV8AU0QoV5yzEmMUQo5QRJMI6Bav76IMMwcKU4C8x
         vbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789697438; x=1790302238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1sQBP7SrkiTRTrgayl1ZMm59v8E7DacBcXYFi37yUzk=;
        b=EeGVEsOHbjY0QWurCwNqfJ1a3W/YIBrqpl2p313QNSUkL19YAnZqLVvKFeBzr3YRLs
         CF2DhTRKgA2LEdkf0Bav+bALQoyYUAarL9q6w+5YxW0f/Ul/s+FveSfkJfdSQxpVcYZJ
         sMT/hA+llH6ksimTfMa7EWfRI4imNJGiAMla7gs4nYk9BaUuqij61N7kOQV/k/L3HkLU
         dXGS9q2xrShgerUr4Do18NDQdETBAxMFrLkPFZV7HVlxjO5nWjQx9TFp+CvVQ+IwI+Vb
         24YHbQwOaYBLhnECvaX91d+EKO6tjkfpLfH3liVy/ZPBXx1XZ76sWt97sdiHyYtGMrt4
         zSBQ==
X-Forwarded-Encrypted: i=1; AKwUvByyz+xszknal/INHsqk4/rkwZjrnQ08GLQR2LccGjQ39y0wmQpfeZY886G0SEyZizwYI35bFzA=@vger.kernel.org
X-Gm-Message-State: AFuF++my2KzO9Xi8/aZ+wLbizFAwPrTSQerw56eph35qm+hH3Z8IDH+Z
	2cNQKN7d+oZot4eCX9N7ZP5DkyjQqTRDcc60NGgofn/aXTbLh5URnDrNFtWRzxQf5UiEA5GzZDH
	p5fM61J8pJ6Tr/zXPf0DT6QO1OSzNaDk=
X-Gm-Gg: AYBFou2z15fyxa1I3pFoInWrp0Tw4ucPSHuzCVdFZCny/bYihdQ+UjftllCY9VDC1vv
	GBS6ZTVXHU095L3Zn/ujcpjDeF9JfEpoUOHJwL1u30QKIbaZ+2Dirn6AUZT9fHWvvVKBk89cxPX
	VC9dc59eic65DSrsS7MsPfvjT1SmeSEujjVl0gl1oP5NDdng5uFY7HkCj7FieldY1Y0zAboPmI+
	PKACSC1lPXa4UzlT1hPyCpUqzzG0A9j5lideeTpY4b5VaT0XnlOLqjiCVVwevVracoE9bp45QuI
	4wstBfzha1zM16p5zmxjPvI4R2tk3TDF6Oee8U6TYbE2a6Mj80nPLLAHtUfLKQa3NAPI6nohkWt
	XdU+72a50K6Rq+btOTd4rbSzmat1WFSVhqlMobPgXCRKDzxZc++7DZgStLwy+5C7RgtKji7B9VQ
	==
X-Received: by 2002:a17:902:f68b:b0:2d6:fee6:65ae with SMTP id
 d9443c01a7336-2ddb1ab3983mr24249855ad.4.1789697438293; Thu, 17 Sep 2026
 19:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911135711.109338-1-jiayuan.chen@linux.dev> <20260917185926.1bb7c430@kernel.org>
In-Reply-To: <20260917185926.1bb7c430@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Sep 2026 19:10:27 -0700
X-Gm-Features: AcwNN1X9hXr2f0Sb6Klu9W7uMPQkOFPox7maFcjw4UGshBodQT-bZgDlH6jEEwg
Message-ID: <CAADnVQKaXUj2uxgqerh7N_CDxneg2AgF9VJ2SddG=rgn1de1sQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/2] net: xdp: fix bpf_xdp_shrink_data() page
 handling on generic XDP and veth
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Eelco Chaudron <echaudro@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 6:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 11 Sep 2026 21:56:50 +0800 Jiayuan Chen wrote:
> > I'm always confused which tree(net or bpf) should XDP target.
>
> Selfishly Id prefer net so that all our CI would just run without any
> manual effort on my part :) But perhaps BPF folks will disagree using
> basically the same argument.. :S If not perhaps please switch to net?

yes please :)
all of xsk, xdp, veth can (should?) go through net tree.
We can deal with sockmap poster child until it's cured of bugs.
