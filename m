Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787713CB2C7
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699500; cv=none; b=E6tFN8zlKXtP+/oKnhQTZ5PyTXoRtSJbtWHwyMhpq8ICMPhyTYmJ5U/ydldAxYiz5z0uDaTHzmDvlA916CK2rryI8Zg6Fx4wMnWZdVoOTm0sDip3Y+T2/WVH3VvkjJ012wGg6dy6Wh6QGUiGm13dffJmfwZABWJg3BMDy/O9S3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699500; c=relaxed/simple;
	bh=lnpKMnLuqv+oX44Oz2gq1nLSEgp1cliwREafqFlWmDY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YQ4Wxp5ETdAou1Mh7DrPP4RJ4H56FrxOl7CnGSSI697JJQYAlComTSgOvFlq7VBQ7OcteNRLzVmjVOWHCNXTZbDYRijgJjCCKuVdl6e0ncbyeyboQEh9DjK9f2UjaBUU2d1HD7cpbqi4VzQ0/G36FuwBuRLg1xBTdwNik/5cUrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXLZnBkh; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXLZnBkh"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc794a06e5fso2267779a12.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699499; x=1791304299; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vWBRVFg3TNII9e3JzDYA1qiuNTLpJveN/yke9DPuJTk=;
        b=WXLZnBkhaQdF/n4yC0ECg3VUQDF1tfB5yHqnqXisqAp9F9pakdePCmKAKHtu4mZ3C2
         5h7bRYuW4CKnad0F6ikmUcR7KhJECVan+A4XYV9UIm5yacC94ktORqUpxiTu85MNUbw6
         1Zte8PAEukPCRYONDX3xeeZZVLSnhoKgEZy4zgl/7RAG64hMciGhHjZmCmn63j+e6q+e
         jAGLTztlNpk2eHGxEhzoiMRHr4N5ZjxGrMVoVZHGRbtKyuwVTr48tfRk4RMwavxJXYI/
         /K2C3CzsFVsSqE1nr7BqgZ0nw3YG0jIGSWml4hDAYj6mbslFeGojuj9f4tmkBu7bxRrh
         JGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699499; x=1791304299;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vWBRVFg3TNII9e3JzDYA1qiuNTLpJveN/yke9DPuJTk=;
        b=znIk34B5jKe6p3PV5U2ZjuJSnOwcJmTASq/V7bmo3j3BCmbUK23F0XpSn6yRcxhdRh
         Pyk+hLTwxnM67eF98Uydu0ajImSm9akpwvmLmSVodJ24I8M+CvgA9KF/gaqe6utoxr26
         LElQrh5htZ8wgxW7IQkVlm894aKzfasBVtawA51ROgXNgq/V88RI9gjHbfsrpy2zKiyn
         n4MCFQOZdZ5ELghHZRwKaWU6YXHv7nzXSSdyL+h2FqbLwS6Fxt9ZaTZ8X7pbOITdybc8
         CDzM1VDefB/ucT5DkSIrhNuaHmYyPKWZkq304mJwiUovkxfnkNP+uKmdoYmoAx4ZQOp4
         ah+g==
X-Forwarded-Encrypted: i=1; AKwUvBzd+T+3I+sAEfwSMjlWGx8rb+3dXlPQ+AF8PqWT/p5vtGl4HsvaVu2KsUBIhtwvIKJI7dHVD6Y=@vger.kernel.org
X-Gm-Message-State: AFuF++ma8pONYDZlrNBreRMmSBTyX5mXTJv1jTbSLY6n8H34fL+B+Y8r
	l9qIZm4iy5M3gGWguTZfn3SdsVUZ7Gg/L+bN1K8jc13rn/jtO5rFSBPe
X-Gm-Gg: AYBFou3MnOt96ejMnRIhBXS32BxmZtJGAvOeWvULJB5Z90EKqMg+OkKmcLf7XjhOysC
	Lxv536J1xSOJJyXkpgy2gE1bz4EjaFrDMUtyH7kpn4UDS0Nz1WpDarDAgV3Vnr7d4RWqo0wHK2b
	fgGCdtbLvSugL7Do8avscfmf4WNtjcj60Sf1WF3CQLv/ZFCOF0OIqSeNkLzWFKD1KjKyjVyFmaw
	0X3jB0DpyBjkAE5QQVTF8/WaQKg95aWIoZk1UPQ75ZL96J1nvoPAS1YPx6JfnN58v4xF9zx7HDq
	LllKz4xX5cF2fD3xXrD+0YU8JPoZhMQAWl82ElruP8zJo1fJckNwvaD96/6BWJbjtssC0QJwW+d
	oMwdKQhyUkXEAtbwVrWENt132cTs94MNgAt3HWgcAnWfGBKEGnRdeL7COVtLqhRg8F9YqbK02Ku
	Ov1DVnMHsY13EfSH3D8qRYWPXzMPxQT/PDH3f1U8OVHlYrFM0o87JUaGL6RVa8yiBJu02uQ7qi4
	esSq8D4GIXdGVplNbAd3ZGkVDkjVDSs2Tn1dSQLYeMshKlD7x7bbFvmvYoqJZVji+gsWff35oYi
	Pn4Y
X-Received: by 2002:a05:6a20:9e4c:b0:3dd:a007:cb2a with SMTP id adf61e73a8af0-3de26db5242mr11967568637.38.1790699498710;
        Tue, 29 Sep 2026 09:31:38 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7d2b562d8sm109617a12.24.2026.09.29.09.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 09:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 16:31:37 +0000
Message-Id: <DLRXZSBSYJ2K.3UN9IME1MKDD9@gmail.com>
Cc: "Florent Revest" <florent.revest@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Linux Kernel Mailing List"
 <linux-kernel@vger.kernel.org>, "Linux Next Mailing List"
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mark Brown" <broonie@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Eduard Zingerman" <eddyz87@gmail.com>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "bpf" <bpf@vger.kernel.org>,
 "Networking" <netdev@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <arvRs4KdojDnW1O6@sirena.org.uk>
In-Reply-To: <arvRs4KdojDnW1O6@sirena.org.uk>

On Tue Sep 29, 2026 at 2:56 PM UTC, Mark Brown wrote:
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   arch/x86/net/bpf_jit_comp.c
>
> between commit:
>
>   17637e1a581a2 ("bpf: Skip detached progs in trampoline images that are =
still in use")
>
> from the bpf tree and commit:
>
>   29fcf9ce4bbdf ("bpf, x86: Use global buffer for trampoline size generat=
ion")
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This

all correct. It will get fixed when bpf gets cross mereged into bpf-next.
Likely on Thu or Fri this week.
