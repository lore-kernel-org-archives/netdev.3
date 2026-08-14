Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240632B10E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786704331; cv=none; b=bfOljt9pAbTDZY5qaENqbd/ERf5S9RZ1R0fGzqpOLvV+6cITRm3icheDq0bXHiLydMx3gi4SLcmbCyZ7Sk+xuxNm7GOPKGtE3siE2iC9oOOoz0KiHVhqzA57VdmAfohCugVUY4dFK7lWEMIMe6DlxTS0x7TI9rL6t2+EpxihAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786704331; c=relaxed/simple;
	bh=cfQ5psBdFupVgEA/ciXkWuRtVmhgxSgdnNDh4pIrvSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ehHY39Ajjs7mpRGRswEtf94rOXTJ8yXwBtT8esZp4yLobzdcqZOJmtC+NQPQ+ElbXB9zjtoNai8KpWdLx+BckefcPk9FfUtiQjFvbiVZrESJt5wE8f/Rm5dl9ZYJJI7YYQfAXnejpb+59MZ6eZXKb6BIknXDonxzgFq+CYMk3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RQ1JRHOi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RQ1JRHOi"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso126530966b.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 03:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786704319; x=1787309119; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cfQ5psBdFupVgEA/ciXkWuRtVmhgxSgdnNDh4pIrvSY=;
        b=RQ1JRHOiU5EIR6nJ+NwgjYLdkCx1rJZfxxTkIBOQTnpSa0PQ0rRbm6JrIS1vIC2C/x
         7zvY12zx0UzqrKx6rYc2suzs5KcTGA2QIJNNZ96F2rBC7OO99BCmyrsNEkcoD9X9nxw0
         XJShp/RZUWbsPaLFaZACpW5jx++/VLttd3W61yUdfjGe2ltqGS0phh9yagcusjWw0GRz
         3RMtsIvVgTvPaB8nFxx9O7ZNYvuTZEY89e2Cz48HFFQldYIbm2cyxb5odLrJewofGwoT
         FjLqkwlmZflfrj/pOA2T0cAHxHEYI9EhFnq4wruOHDhzQZ2V4p4VneyFu2tfd91XrMr4
         +TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786704319; x=1787309119;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cfQ5psBdFupVgEA/ciXkWuRtVmhgxSgdnNDh4pIrvSY=;
        b=bHjgUxVpjfBULVVzuC4zCjHLG8iCIASJ21HFJUSZwFFjmzG/3gnvboBQSl9l/TpIez
         toGixcsGEWOxe4vi5xH4GvCKPXzQz19OOv2IACMqgbmNMCT0szIuO3rbHUXnjbdgUxSU
         MBpGzEBWBg56tAniWP8V+WDklg0X8bOewC9+h73orZPxnPOxgRV0sAa3Owr2qv75L3VK
         ijVKBwW6E/Tbwacih2nDVUf5fjwUO8kBqOmA3aFoDXVSH9QhJd/DjE9PsdoXD3enSxWu
         Ze5POfiFhs6WhgoXPPxtzCafRjKeH60WpL651FHIGI/NWQU4Kos6IuI0+pSk9zuYJg6w
         j7fA==
X-Forwarded-Encrypted: i=1; AHgh+RqJbwRoEw6FhqQrowzn5ImybYbD73sjaTsnIZ+aaLpSgs4vzVoI38VmUgqnyGbJFDkOHzGTwvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkQ+/fSdZb7vijCpq5DNPzFiq/oSWaHBvDpnB4t8Eor7ikX/2I
	s8rvLh2f96/IS4V4dl1Wrz5hhjXI5rINnM5iVMykbspil9c2bxB7e9xXAG5lqxYS32E=
X-Gm-Gg: AR+sD11IbeLgapfkcY8/OSC2fp0TNZHkMbxfR9zneCOjLdURN+gavOrPSCUtIOV1skR
	joPGyxj5RSTwvpBiBreAA+HzXx9U2DHTc7vC6Z+2B7qK00XEMo/dhEzAN5WY5z8TM0bVMLFl8MK
	PGcvBJy9qTI3q7rc7YcD+mJMBdTKJDhmwC+W7zS0xEXDQGN86wJpUPskFiKHn+2kWzas793g/5L
	QXG1Owp/PUTYB9S1Aw1bzuiB2U6j1CW1Njyzyr+7AZ0UTDemTJyAZ+tGAnyxfdGvibCgJTnryUB
	gQEIoMqy1TI8pA0kPQ3oTa74nS7GICJRYdzNAoYoyLC20O3+SHnyJZTdJ030uuNQKpvGae+ZhhZ
	Ile3LAliXOQdeZWoKNbr18qRhLpnW+KD7pr+Hj71gn5fwl+Rw2peLS+itTPG/SfMSQttnYC920v
	KuEjQ0/4I33HNiP12FdlL1y6NnMXYOiezvXF4eQW8QHhbUOHJNjo82dl4+y70U2r8=
X-Received: by 2002:a17:907:3d0f:b0:c20:f913:9337 with SMTP id a640c23a62f3a-c212a265c29mr206885166b.20.1786704319537;
        Fri, 14 Aug 2026 03:45:19 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c21233a08f0sm94381266b.11.2026.08.14.03.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:45:19 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  Ihor
 Solodrai <ihor.solodrai@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Jiayuan Chen <jiayuan.chen@linux.dev>,
  Kuniyuki Iwashima <kuniyu@google.com>,  Willem de Bruijn
 <willemb@google.com>,  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] bpf: Cleanup & optimization
In-Reply-To: <20260813-sockmap-lookup-get-ref-v1-0-31f5d55f44ac@rbox.co>
	(Michal Luczaj's message of "Thu, 13 Aug 2026 14:41:58 +0200")
References: <20260813-sockmap-lookup-get-ref-v1-0-31f5d55f44ac@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 14 Aug 2026 12:45:18 +0200
Message-ID: <871pc10ym9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 13, 2026 at 02:41 PM +02, Michal Luczaj wrote:
> Non-functional cleanup and a refcnt bumping simplification.
>
> Series extracted from a fix attempt[1] currently under discussion.
>
> [1]: https://lore.kernel.org/bpf/20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co/

Discussion seems to have stalled. Or it's just vacation season.
Anyway, I'm fine with fixing the refcounting your way.
Merely wanted to offer an alternative idea for consideration.
Thanks for working on this.
