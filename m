Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E318F4FC33C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664398; cv=none; b=eVbPVbSNQ29kuSUNAAVCQrN5FSAQOqm4EWzYzpXjN0J/ZRIVNdRxnbfB6y9hB/bqDCElPxaTDbZa5lz2v1y0p153mw8hDvML3qLCISLmrAbuiA2d92qR3aV6YXZ5u5q2TlWKyTejqLrWd+fmZ+sMAgDWWvNezpSd7corAAehHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664398; c=relaxed/simple;
	bh=o6UqOTY41tuRkO5AHdjDRDEciBrken1pog5VHjo2Pt8=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=HFy7FSB9Hen0Yt99xjo8GPFD8OR2KhGg81GRNjgztcpgDKYJbjEwJhBIpt5mKs9okrQh6rEhEV+PviVUjVgRV6J/jaHxXv0J1aYsr2GKkmP7X7ypBF8cXy9+pOpcdnxN+pXW2hbYBVhYPFuvYkTvv/M8q7SKUkeZ9gfp2X9acBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUNNdsM2; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUNNdsM2"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db18fe433fso9620965ad.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789664396; x=1790269196; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CU2rNOkPTWonMJ/LHusUbLASqrBVu1PgH/m6EZ16kLk=;
        b=UUNNdsM2rI/9aR3nQbwgFzURukDKRivhAOaPQpfmkcwWcKHJFToXA4gfaI9t/76+sh
         40UmK4s2vN7/wHygqTM1GAEEAwnOolto6T3DVYVJlsvZn0CbHk4Do6moY9caSy64ndVr
         MJDfJPnBzJKqE/92dkIUWgNx9qV4EEpXehm1lG3I91IAF7pi09A7EwutiUkDydMjVItJ
         TcLymoginJcxEjDs19qykRWCztgTZrWMJBjb/oTGd7zulTYAHZu2CHRt+Mqa66kg+pI1
         ifSKnjtO4iBeGFjEMkdOuDPQM58JR3FAp6w9eIdHK7tNctnz7UB43LmYXh7yPOIhw4Ay
         zI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664396; x=1790269196;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CU2rNOkPTWonMJ/LHusUbLASqrBVu1PgH/m6EZ16kLk=;
        b=WX6dWTY8rxSEleoBR6fYUhiOXu/cm8VB11RbzEyw8BfSFS/CSI41qh9ksuwMiWrNkT
         AEVtIMvL8jpF9qM6FBEjIX5B/hKbpfd8xirYbl8mkAo1sQnyP+ps800CtFTodANB5hYR
         TYgaLzdfjPjpqG3dARsmFfKqZVW2cXTxSbf2NHOjReL8FPNWYdHU9FM+hL/4UEBetmmL
         r7BBPigv79TvYMN/7lc3sRtt0zAsks0cvMWSV39JZki4XSbS6/yDGURn49mLyg3OybRm
         I2LnreApafi8wVLdUV5eT2SaxR/NUVDaJJ5NX1Ra3E8a+6A/fyfdjfPAvcnWnYTPCJTI
         EqMg==
X-Forwarded-Encrypted: i=1; AKwUvBxeFcVDEQeMCFvdRVjEcV4FBF+HUGYOFCIaY9SSwK00EVyymyim0S/on/cq1fCdxjO7nHJrF94=@vger.kernel.org
X-Gm-Message-State: AFuF++nIijVmWDsocV2GUaLYbo5Dd9PVyQD1uSIBYHJp8aS22err5Itm
	jJYHla9Xsi1u8bdAcYgg/qX2LrGNgDjnNlxyyPcSN7HOE4umJAsGe0xP
X-Gm-Gg: AYBFou24Ye0JDhLTytl+xyMKlpwJLrK1tAB70gLyIdktqxc8J3CTZ6pXLTxpeKKbdFz
	0pnvfzHCUByKobUpodzUYfVGSlJoTrUSfVYmTt+CYjhPlFRCbjlQ8kixxIuSM4l7qtxN1Q8t5ly
	GR8EFFNFy39xRhVoliuswWCVF9xTCpwxWk9yT1H1b6cuqVnK7jyu2lHna8FdvyqCI25TMqvw7D9
	Z02nYTcHgiWaDcDt4Axsk0Zltyihd4tcTF+a5y3xigyFf9sdS1SFq4RY7zEQz4aVur6i+0QLNtA
	8X9kxfqNxRlbXmFQzvEyNpXtxTtwXCVBrlZzNPGcru9/Gqq5YA2Llcjwv7X3ORygIfA5JX8PUfy
	s8hJQxQUZh0Bhf+asxhQuH+E0P7ZzVrwJOWzPeBi8tNAHQ0d7nY9HvBGxnqWleiEMYdonMmrxBt
	/diTJgD+5SpgzMOJyYgucgWToNbsonKK1IeXqkeIN6ROrUVfIKZ3SkfQOum1OWzj9bSfqIGRMFN
	q6j1B0/eCgYG4hAxuI3FXJ5tdDMmTQnUD1uZBS5TuxsiFMdlOsd6VuZFNrMg9kJhWdBP2+kC+p3
	k7I5
X-Received: by 2002:a17:903:2302:b0:2db:39dc:48af with SMTP id d9443c01a7336-2dd8e752ec5mr159169715ad.17.1789664396054;
        Thu, 17 Sep 2026 09:59:56 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f244bdsm30194175ad.77.2026.09.17.09.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 09:59:55 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 16:59:55 +0000
Message-Id: <DLHR2X1P3BTT.HK3TEMB89P28@gmail.com>
To: "Ren Wei" <weir@nebusec.ai>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <martin.lau@linux.dev>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <m.xhonneux@gmail.com>,
 <dlebrun@google.com>, <vega@nebusec.ai>, <rakukuip@gmail.com>
Subject: Re: [PATCH 1/1] bpf: fix TOCTOU in IPv6 SRH encapsulation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20260917163408.252431-1-weir@nebusec.ai>
References: <cover.1789646866.git.rakukuip@gmail.com> <20260917163408.252431-1-weir@nebusec.ai>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 18, 2026 at 12:33 AM Ren Wei <weir@nebusec.ai> wrote:
> @@ -6706,16 +6706,22 @@ static const struct bpf_func_proto bpf_xdp_check_mtu_proto = {
>  #if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
>  static int bpf_push_seg6_encap(struct sk_buff *skb, u32 type, void *hdr, u32 len)
>  {
> -	int err;
> -	struct ipv6_sr_hdr *srh = (struct ipv6_sr_hdr *)hdr;
> +	struct ipv6_sr_hdr *srh;
> +	int err = -EINVAL;
> +
> +	srh = kmemdup(hdr, len, GFP_ATOMIC);
> +	if (!srh)
> +		return -ENOMEM;
>
>  	if (!seg6_validate_srh(srh, len, false))
> -		return -EINVAL;
> +		goto out;

Sorry. This TOCTOU issue applies to everything.
Patching it in one spot doesn't help.

pw-bot: cr
