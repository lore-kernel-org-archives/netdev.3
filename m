Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368548;
	b=dWz2GXfUTPub3A1qLkOVkNkZhmFe5vXstOaHmPpM6bHfKWCs1hTFGTy3Ty2opz6les9D
	 zKrGTIoZKRMUB+aQCgqGTzSRhlndR4mEqrc8tlQ9Jnz0R7hvsKfS/rAx6AjbJGME/mBV5
	 Xqhd91h+ajKg1K0ShaVSmfR42sfyGg7G0Usxzjx5BYJCo7/EIgi7sYBzyNyVGPYgjNv+0
	 p4PkFnOawncQn282db8sk0V4ETOSAh+Z+mMRCKuigWtZdFwEdnAVG3IrCNt6CGCMFmoSW
	 mwYvRymC6BPl1gQYu1X/M61KAJuAo4wBB4V/1euTwziOI3tlqiSUIQ9f7yuNOI/m96w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UVNQuP3ondEntacxAyn3YMLLQbLDbNk3DgeuFYCFzxg=;
	b=cf8CujBnY+XUUCYToqVDZ3t9O9JWZFliymAZKlRrWHqG/+MuRlbX6G0VSsMs39XGsuky
	 MQp1WRJTRuLbl/aBVn1csU4+mfTPJAELbV2w+4ILsxyCutPdIjjOqn9lANfiWYfjZ8PYx
	 T0M7gwCSqxPYMllois97FOidFaIRX/Dit4IrwVO0Dy5n0vFayImfSzIE+/VMqWrq1GWvA
	 2vZ9TcU1HHV8ZA01Gb6Awx6QYGKUuUU32b6zIMJSaO/8g3ngihHoWPfDV3L5v/jWqHzoL
	 SoQGNd0O3Rz8ILygXc6pr/nxRYmfVtLXOjVv5fj2F5MFgLbPyftiPIj4et7xMn8vL5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UgtwSpk+;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DBD606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 13:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95DBD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UgtwSpk+
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9906870a9baso390798241.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 06:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793368546; x=1793973346; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UVNQuP3ondEntacxAyn3YMLLQbLDbNk3DgeuFYCFzxg=;
        b=UgtwSpk+Vszju5rSIWrcBMMpldmB+fO3mwRauUr12R80fzzKQp7e6NFOJ2goB2PZng
         s61f8Nd1rfz8u553K4l+79O2zgZgkZpGYEyF/DgS/J1a7gxtJxOQKKYI0SkuYYj/lJc6
         gpZV4c2q9zepLDwm5V9YYStrauNi89u7rb4ya7DUAWlhWvrCLl0AbunJKjJqfx+JWY6u
         j1BAqaKZobPZlO7v61FwZ8UqPApvctjRHsUCw9oaxyRPjGFOFsNjjXQkqNOshbmjjX3q
         JnCp53Am0vWZxV5h+aqLLXaonXznFraMCH5LhiFio3wXraKlHvPjSB9eCa6K/2CaE/1D
         augg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368546; x=1793973346;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UVNQuP3ondEntacxAyn3YMLLQbLDbNk3DgeuFYCFzxg=;
        b=UXmtXJ/xyOS0sH91TThIIQGTc0hRW8Heud4OhTonpFlz4oSEaqm+g237PRIoSRH7hz
         Ix4HRympUzLvWbyG5YImVgGj/iQnlpS8H8M8QBsG9idxAshViaFHbuWtFoTcowE5AKsw
         5KUeRB/e/dlZdtXDXiXfRUFf8p3KSOtjDKAAESr6V1TUgk/biSW//RihTdXht1P1wFgA
         TwWFloggdyR0UE2ZtP2jLbqtRnJTfxxJeBqdOWK2NiwMmSzI4OnxspxGibA/SQBPotul
         8llnxYcbsRbaOl+rXV29C39CXfhdsSue78An7nJ6iRZO03jPY9ZCj7KgKa8h7j1RgSiY
         IWog==
X-Forwarded-Encrypted: i=1; AKwUvBzhJ0+ByBdbxzMDLErfjSpudZNrAyizuibwXlmQh4HPCLxOLQjg/MGU6VGZ+qI9r82JpMn2ihw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwBgwDcgsZezBrBW/qtg88+hToqBt6PG5abtlLCw6AeOBsRBJ/
	snNZfce9mOtQXTaBjECc9GggviasTfelpA+tHjjsXpKzVvlVsLoXX4Ja
X-Gm-Gg: AYBFou0rCosZXohG/4UIxS3ArzDLZeFE47LMl8vwvC6AIH40cwRlzE2zJWlVpnrtAqg
	QNGejqfB+K1uxhEfPGTA/SsYvKS4C6dvp6TSp2NCCjMHsI7Y2Ymf9ri76zaCPO9Np7ZjkS91LI7
	/oGpZzKFPdMi9nynCA5TQFa1k8LZw2pNpdcw5md/XVCbY9tNUMPUSNjHhZ1ld8uG3Lsr/JuEnVk
	9yxyZS7oC7ILyxUa9lJz4X/qlVkphDQKV6wPCDjASHMgPC6U0+dLfC0rb3plAOWh1iStJJYCCok
	lTdBIHCTbdYR916aZ7HNcgFvMvnSfaGie/9dc7yY1l338E4y9y7HWwt6g6xaftriYKmapXc2h2C
	h2o2yXqh/QmxVtZVyoEZMcXWS2lI9cEM+eyuILdtSMG9b9irhtOoFAWHxkiK851g72jjxHu19Uf
	J5vxX46M4sU6U1sqVA03ZcO0tafyQM/+EmfUoFaFKM/T2HIk7RMUxVuaXRoTIhgFm2Oaf/pGfy3
	VLcHDkaIKXt+C0j8Rl5lke1FwsrDBneO/VI2NWGQ1NJFWooXsxEdWEut/x612S8ytwgJTA9oBx6
	t02+awHZmGVGy+DuW1CMA4j4QyHn/wxWUj6KjhFBb50ZyZjeQ/172BgOLlbuQlGQu9eWE/1F6R5
	E/FIkandBoJGrddU4ZvLOdpeA8FGzs7lDNLJRk5rfhP928pqxAHQ28A5rtdx2ILl4JBA5
X-Received: by 2002:a05:6102:4191:b0:7cb:fd69:4155 with SMTP id ada2fe7eead31-7d0728b1448mr1236984137.5.1793368546552;
        Fri, 30 Oct 2026 06:55:46 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee509f58sm2642250241.12.2026.10.30.06.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:55:45 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:55:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rongguang Wei <clementwei90@163.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 Rongguang Wei <weirongguang@kylinos.cn>
Message-ID: <willemdebruijn.kernel.20231bc67675b@gmail.com>
In-Reply-To: <20261030060043.94719-2-clementwei90@163.com>
References: <20261030060043.94719-1-clementwei90@163.com>
 <20261030060043.94719-2-clementwei90@163.com>
Subject: Re: [PATCH net v9 1/2] tun: keep a kernel copy of the socket filter
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
> anything is replaced: a TUNATTACHFILTER that the classic verifier rejects
> now fails early and leaves the previously attached filter in place.  The
> instructions are verified with the new bpf_prog_validate_classic(), which
> runs bpf_check_basics_ok() and bpf_check_classic() on the copied program.
> That does not cover the s16 check in bpf_convert_filter() or the runtime
> selection in bpf_prog_select_runtime(), so a program can still be refused
> when it is built for a queue. Such a late failure does not replace the
> saved program: the copy is committed to tun->fprog and tun->fprog_kern
> only after tun_attach_filter() installed it on every queue. A queue that
> already took the copy is rolled back, which leaves it without a filter,
> because the program it ran before was already released; restoring it
> would need an extra reference per queue.
> 
> The inverted check was discovered by manual code inspection first.
> 
> Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
> Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/

nit: customary instead is to have a changelog with links to the previous
     versions below the three-dash line.

> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>

Reviewed-by: Willem de Bruijn <willemb@google.com>

