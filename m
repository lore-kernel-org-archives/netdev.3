Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793479971;
	b=J+Ka+vfZHFGY6yt6t5OKhPvwvCM+8vmQxWqrwhNqGGpPOcGFElqhacqbqkDe7jniKI7j
	 nR2ikxbsvvrvgmmh9iUw5HXf0dhwsHVGu4YZ23RjT7SfT8Lgba8msVSftLcgG5+fSy4ep
	 81TRimCgCxQvizy3HX6y+k2Cdj0Gd6KozFqMGXc3tyY3StChVpIljq00a3dejdxCbSFna
	 Rkwf7ZG9EuAZLBWxGb3hgY6njAaaEtcnhO3NguDADfhjksP9XIXaiqYSG39on2q1HuUfm
	 8jKhSZPxZNHP4YVK5zcQfUJhf7jXmNBD1is+EX63heg+Mk9irP6Nd3CBbH3FzaAD/1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793479971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=icWN3ojVey3UJz1wKnjFg1vmnm5rM6DbNVOsG/C6lg0=;
	b=XAKkAoebhhKLjb+cYr9cbgwmeBWpjAs60lwZPjqA7NKx4PviBQ3C/1z2ivmO18pq+jay
	 HcS0Me370hLElQ/eRcM7ngxBCUnBFE+JuhNxV2NbRo11DA0LtFQGiyfapeatovVtk1lVa
	 W3cNyv4IlRAhcGmsmZ+C98EZgNgAFf7XCXnMxBjWloaBW4S0MDiWB5kLfawP5jk60RgvO
	 HxsD5PML2cJprh692TlGT93xn1so4egWB4LPG+toR78WHUY+uCWdmaGiwX3emi+j1ljVf
	 jmgrYPAb4y9mXtq90A8KQ5g4pKmZM8YpHcDlh/pkDX3/oCoyu/ISfB9AY9jZ1DBk9AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JFRaYJYW;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96254606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 20:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96254606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JFRaYJYW
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so754448a12.1
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793479970; x=1794084770; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=icWN3ojVey3UJz1wKnjFg1vmnm5rM6DbNVOsG/C6lg0=;
        b=JFRaYJYWcWvVTuMPIHDNfHW5cO1myvPNw8qm7zKdksl9asXKdRL5Y1lcuTsaTuSK/U
         LaDnk9h1oGuzA8qtB430ysb28YWho44jdiUmY1xTne5OhDWrormWHWRk9XFBqB5wjsxq
         1IUJTGn/qhD8nRgoGngaf7zx3O85hWtD9HgwsSE70gqaz/VS9TvZyJ43UgXBhMgnXOK2
         LvQrPvVCQaIT3OAL5eeIACZNi8jRe/kCkJCp/CRCR+lwh86UQ5zt6agNrI5HC9ZfKWFI
         RYhoKf58O+4sNa5zL/MnEIWowiygs5mGmYibwHqy6udPQBL0FNFcMDG65Jele+6B2VME
         k7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793479970; x=1794084770;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=icWN3ojVey3UJz1wKnjFg1vmnm5rM6DbNVOsG/C6lg0=;
        b=hPDaZIK7NBvL21oC+aAz4xLKnwAhXON1wpznzcA8lOo8a/RjZB5Zias62Ke7jPFH0J
         spHa8DVVpoKirR5w7aoiyaXJXTF+tRD7AUdVuZZ6lEbjmyR1pltotZhWUEugabmhca5l
         tPer50DKSlJwTBrz2MlhbTfeb6UdY8bS3/Y2iZZJOqC3NjnrFqrqfmHjEGRgolpvXr+P
         vehOKL8PeDJIY0HffgP48IZ98dKDAgFJbwmA9lpYwP+shHHSo/Rpa9N0MtR1ds5eLH2d
         dohQr9S/8IJ1FRSyrmdyFOImVIdnAsFUYFtMcSmudWzWflR3MSZoRTVz5mhnJES6SZvj
         vLoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzW0OlA3fyvrnGt7QYOsxsVPJkyHj9LHNIunOYbxY0UX9qCOmF967tRtELZX50yFwsycKrhInI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhVEEvpK/h6t9jslpBZ5AEYyLzVh/XMkIBRUJ41/AetG8VIpgn
	0KuTMz0ZRi9Gw3WEtduCHukdLCL9/Rh+iLD6y8EBX4g5CUPOp5ne64pd
X-Gm-Gg: AYBFou1a182gNtb1a1o9AfUSOfWkRcmKsLwlrWGwKL843te5OqKILDTekMap7fTktON
	mINhlimpakKruy6ujvRyJwQ3PlBOoqR4LgIeJ6TmBqKu0793S+KXOChplP17AtgWDrgjnoKqn0F
	OnQHx58jNGwDIbByIcPBdToOegjipy7yKRcL5i24b0bHdMwQ3lu/vf6iVbBMfd45rRN8seiFg5N
	iX/pSVRLJ2ptmAbVwrrm+9V8r7H3kXB2r52ez+sOkMMP7lzuTFnGap/CERsdqDYYpS563EXIfIm
	mKRtooAy4lnKFDvNv7sFlCJ1RO5K2rE98gffk2kDDrTGqr0kAtA70evQsxolcdzgkcOyVmQtKZ/
	2IKbRXsMAGT+CcpJ6W/gz1MOPTb+Ygdnj126xe3/P8S59zHa5rfqJH3v/B2RC+uuqZo1ByfN27W
	CKEXdO3ovoOK94OrXMR6HtazC8jsYEvA2KmznGYr4yaLfmADZp1zNjoYTVyhOr1bPaJ1XELJOlA
	bMgxpdUkreae6B8f5fekTW59/e4mlc78PL4oS60lkC5nT8/qBw/7Kdy/HcrvTyonz0YAN2xW6kf
	qPrS1CehlpZCapBsZkm2xmvW8y4gkxCNMM4ykgARvZVD+jxXHWPe25CCssIYbrSzjTHUvHMdYtr
	oqMslnofuGyxRUhAHI+RsffbvnQGZMz5/SQ==
X-Received: by 2002:a17:90b:3f84:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3ae89776af6mr4824088a91.11.1793479969985;
        Sat, 31 Oct 2026 13:52:49 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8454327esm8389084a91.4.2026.10.31.13.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 13:52:49 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 20:52:48 +0000
Message-Id: <DMJBL7GLZGTF.CLA7HQ8IGYF3@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next 0/2] Fix psock update-side data races on
 sk->sk_prot and progs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Sitnicki" <jakub@cloudflare.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>, "Eric
 Dumazet" <edumazet@kernel.org>, "Kuniyuki Iwashima" <kuniyu@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "Willem de Bruijn" <willemb@google.com>,
 "John Fastabend" <john.fastabend@gmail.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>
In-Reply-To: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
References: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
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

On Fri, Oct 30, 2026 at 05:01 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
> Follow up to the thread at [1]. See individual patches for details.

Thanks for taking it over.
Applied the fix to bpf tree.
The selftest that only triggers with KCSAN is imo not worth it.

