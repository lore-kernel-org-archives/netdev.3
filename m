Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794106;
	b=ne2ddQuEvCnp7FxyuLB8eazFsvJEtH8Gr5VYp+LDi903T37KHDDE/IGxto2wnAkc1l64
	 JkMf2OaG766cgK0gn05M3WqlrqO9Np0Wba69h775dSmQeXRscvUTz+QyrjaIiwjiWi5sm
	 fvgneHueF6pEJivUFSARZDg5Z8iXYcgYOH+6q1Ae8csU5BM5mDUTD1GCSH9J8KLXO0S4E
	 fJSvUN+pYqm28coqBb4GNEwUsyC1r3Ws3No6DSB5B3SpSC0QMGbQRl3mGPTgVoqFoWYm6
	 DKAf4rtUsoydnZiLZDlU40tbVs1Y6ZjeHYajavbm4VyXH8g92zOWLHbiwii5e33w0cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IWBwMrXqNWCj4I6BbO1n05p76FpYZ/EMafoBUaFtezM=;
	b=CYzkvZyF3+l5wM89YIfpW2QKTBWtuS2MdUV+NnIwT/feWA45eV9CR25fgOaF9L0D84W1
	 tAb1S9hV5E3slTNifdGlG6S1p0eJ6tbxV/odh1hNemgTearjqrIKbSiJAOVnTBeaZso7p
	 gcRIvGrJSd48FOmHPYLq7k8xA0f7ekyGFr0QVmZb/UdHoCy544yuecfxbDQhiHEeHyPzn
	 jqo0RTXJDsP4iPXA2GrwRwbm2eZxKSa5PWnI51qWbjyrWfGLJJzjyiaoTY0cdGDUuNyV0
	 mkqroUzOrteXHxeq5x8zpf1CUUHSpH2CgJjar5qOCeE/Jp3n2wwmV//D+pByWFH31LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PufYFUDN;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E82606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 22:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2E82606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PufYFUDN
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7cc81984fceso449038137.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792794104; x=1793398904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IWBwMrXqNWCj4I6BbO1n05p76FpYZ/EMafoBUaFtezM=;
        b=PufYFUDNeX4ALEFqpZT/VxPm6/CdzqV9uR2+nCymKyY0UZdBxieol2SPIIriXTfTOn
         R0NEm/MqkmKEm/rC2j+Z4wsftgYjkzP1qMTwQ6eVXrRrEEdwEXZiYH2NBEDWkSCoUxav
         47boeX2hLMwI/pKiZ5TKpvWsZDkA22dw5MrquBN6YE5rmdcpc1rPsAi9WmwvGF4JCnPx
         JQd30VPqAWdfdS8vmkRhiwatYXg9ImsA9etrVmA0A4GawK+Sw+4nRS1jKpHcur9FqN/c
         3p6T6Pl2A3Ub/UqaUA8PHXq9K6MekMCYzxaGAHiV8HGZLV7r563FN7Aj6Al8gVbr4t/g
         UY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792794104; x=1793398904;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IWBwMrXqNWCj4I6BbO1n05p76FpYZ/EMafoBUaFtezM=;
        b=O5djUeDIIQQ2NFhaX6aY/V/oNc6IzDVhHLn7WYacVUPO538rUQQ6G9+pspxTIXBubv
         MO8Z/PiLEHdPi1oU73loTcVT8S8hpmcqUg8IwwO7JlEd+MS76osnNU1UcISdW6PHDSed
         bEyaQtP18Ij0Y1bCuc0JKpHVh0Ka7Fstf4dzCgsgehsOnCjPOADxGvKLAQ5ogOjbyubq
         869VlUo/rxJo5mCPTdHFfjsMx0LJmPiDF5D1TDn7HU16z00pYdo6ka6a501DL4E47VQl
         hj0NNI0zIu5k2xwNr1zybYvjCN3v7jqWP4/ddxW51gsc6a+aoRpKWV060oaBKPISPw93
         C/JA==
X-Forwarded-Encrypted: i=1; AKwUvBw4dz5S9taCaRx5t2coesNieS72uY6hPEoeUnpZV9Mm7dToHiF02VqGbelxZeDwv2V9MHgIsF4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/nLS2VdyDJRfg6rtmu0nhDnxZs2qYkIspFst9FwUpc6Ao6w62
	Xr+ciXvo2WplOTkXJ4Dn7MRedNANTzAY6fURL8rn/BkXux4g/xj/Xc5i
X-Gm-Gg: AYBFou0A/O7pGf9HoXxnOTtkoA9IIQgJ/VSsJ/hR84DogYkl+wUAl7NJrQr4cTSGmoq
	4mbxaTKBBwdgcgPaPC6rVzim5CxhbErDaHR57lzb78ALw3IriZ1MZQqzYqIx0sWUYnFJKk1hcTV
	YCByHoRc5iz0k4FzYWiFHmxMcg/aPwAOF+sKl5ya2tP/b+Ug5wPQIMFWJc9cc93+r9zmLoU/vr3
	sqo15A2g3xJS865f1b881k8THp7CjuWGMkl1VmJ+iwGiy8szMH1CzoAJbb2irT+vWOCihgdsvTX
	bQ1IDLRMsJUhQ2CfNDb7ZSYw5WHfBFeY5KWE5DxJxEjjjA49fZKr21sDkiBaTfPeRsXvYlAOJNC
	Tm4YlgqcnMIGgFoLdSqxbFITQEqgV7yTdqsHUQ/qYBEQZBWBbL0p+XSRFeeSjAPnNWSZVFzaHjP
	QFbpbA1umwPGuVTrmLN0vMcZmubEcHM2weqwYwLpMqe7t6XP1UV2ZBLcog2KiAxDu057cTJW6Qj
	21IXm11mOOHKB/J97iO5wUjX9UUAB4LiLHOS1dpjk8nUHGtoRxw7TOXVrtBKwLdlDa5K1DTr8Ys
	Sj4cguon0GTd6mdU56q1z+brTVWtx9fIW89X8UV9cmtqH31kG66jA+GvYoJq9/DWDH/SSRNJnXk
	auHuhgkh1rja9t6RRKTY=
X-Received: by 2002:a05:6102:f9e:b0:7bd:b263:14c8 with SMTP id ada2fe7eead31-7ce5ce55591mr182590137.30.1792794104502;
        Fri, 23 Oct 2026 15:21:44 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910e7d9dcesm791938241.6.2026.10.23.15.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 15:21:43 -0700 (PDT)
Date: Fri, 23 Oct 2026 18:21:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rongguang Wei <clementwei90@163.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 Rongguang Wei <weirongguang@kylinos.cn>
Message-ID: <willemdebruijn.kernel.195229eab691d@gmail.com>
In-Reply-To: <20261023092239.186665-2-clementwei90@163.com>
References: <20261023092239.186665-1-clementwei90@163.com>
 <20261023092239.186665-2-clementwei90@163.com>
Subject: Re: [PATCH net v7 1/2] tun: keep a kernel copy of the socket filter
 program
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> TUNATTACHFILTER copies only the sock_fprog header, so tun->fprog.filter
> stays a pointer into the address space of the process that issued the
> ioctl. tun_attach() reads it again whenever a queue is attached to the
> persistent device later on.
> 
> Rebuilding the filter from that pointer is not reliable. With the inverted
> check below, a failure of the attach was not fatal: -EFAULT for an unmapped
> address, -EINVAL for bytes that are not a valid classic BPF program, -EPERM
> for a locked filter and -ENOMEM all ended up in "err = 0" for a new tfile,
> so the queue was attached without a filter. And when the read succeeded,
> the early return meant the queue was never published at all.
> 
> Keep the program in the kernel instead: tun->fprog_kern holds the
> instructions, and each queue gets its own program built from it with the
> new sk_attach_filter_kern(), the kernel memory counterpart of
> sk_attach_filter(). The copy is freed when the filter is detached or
> replaced and with the device, and tun->fprog is left untouched so
> TUNGETFILTER keeps its uapi behaviour.
> 
> Also fix the inverted check, which made tun_attach() return early when
> sk_attach_filter_kern() succeeded instead of when it failed. Neither change
> works on its own: with only the kernel copy, every re-attach returns 0
> without publishing the queue; with only the check fixed, a re-attach that
> used to succeed without installing a filter would start to fail.
> 
> sk_attach_filter_kern() builds the program with bpf_prog_create(), which
> does not keep an original program, so SO_GET_FILTER returns -EACCES and
> sock_diag omits the filter for sockets that use it. tun sockets are not
> exposed as file descriptors, so this is not user visible.
> 
> The header and the instructions are checked in tun_copy_filter() before
> anything is replaced: a TUNATTACHFILTER that no verifier would accept now
> fails early and leaves the previously attached filter in place.  The
> instructions are verified with the new bpf_prog_validate_classic(), which
> runs the same checks as bpf_prog_create() on the copied program.  Before
> this series the check only happened per queue in tun_attach_filter(),
> which never ran when no queue was attached, so an invalid program could be
> stored; with the corrected error check, every later attach of such a
> program would then fail with -EINVAL.
> 
> The inverted check was discovered by manual code inspection first, and the
> review of v1 reported the other things.
> 
> Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
> Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>

Reviewed-by: Willem de Bruijn <willemb@google.com>
