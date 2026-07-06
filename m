Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325C6389471
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351636; cv=none; b=QDekXyUoJTb1kEIvwvhhgwKzCT7m8eZPtIzHhx0Mf/9Odr2bP1remCs+SNcpYBvzcf1yb1wKNeJNy3bjLLlTxd5IKQhDl+0LXaA8mGpmhiND/x14gxkzSjDBcen9xLZrL20ctcf2cj782YkOSK2cfl0FijuSbuQMtLTdtjVbsNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351636; c=relaxed/simple;
	bh=uLoqch9/c60sOgxm7nfgT7VWAe/wfBjsOiSuSTpNN38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2LRrt18PaSF9TKvSJfovBaPBhityq2ygneAL9Vj5/Cy8VRbAhb9PKSsqnzsXFhHomg3LRUSkotes5APol00zB7cdAJikM7OFmshO4jsKiqMKReb0qNGp+rdVhWJRkzXHDZPm6O7jPVFy8Pvht4NSJa4Xyb52W7U76MvjTFfh/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUlCz8yg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUlCz8yg"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so21208685e9.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783351633; x=1783956433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq7K8KruM3IJOWy2HE+UaBvcH61LEV5J6OZAeJrMC/k=;
        b=OUlCz8ygJ1R5xX7Jt7uFhjUS+bUAiFbi+D4xb15lUbVhu4Q9PgWKB1T/HAGQN3t+ca
         adMmIW4GNv/i2NRyFCNSff++NFLe1yga/VBg1EAi3EpcoYoZ1H0GbkP1xDjB+1+gMptU
         lBEP00OVBjn0vR5M1wML8eCePchUgiL7uqQ/Nx1yCmU4hoSLqC0qLgqL2dbk7ZfNEXdx
         gjHdoTIJBM8NfiCVXxX8gSSxssXLFDdtqrjZGdlfFAimaVZpWaaN5eIKPGplBHB4BXOd
         zw1iWpbjRVIjfkFz5r18BzovUmL2ew7QKufZivtIKDFavAGNiMBNSeO2z0pDb2eP+XCq
         CCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783351633; x=1783956433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xq7K8KruM3IJOWy2HE+UaBvcH61LEV5J6OZAeJrMC/k=;
        b=ObzP4ht3pS14FPoIB8H+T24yNFDcoSYbz92x+6QrSIpXFttyNXcWHiJh2wVOT06hXi
         he27RcB0HcMu6rSincOMM+sWqXcI9XKVBGfxbr8BuGyfChKegz8PxWD87gDGNMRs9t14
         gFTJhBY/z6hyb7YmDq4pFChjH6BTJGrYpDfaYQgUnGtmlRc8cxC2Hr6Vp5NDBHVLcpfN
         /qKZRN7t0oojpw6eX5U8KNIbRfx+nQ0xqbwWXX27OkmbKormdPJMICiKnpWQEgVdLufj
         jitMLQLnGfzuYFQUjxYsZl/QWWCIrriGsREQVUGjkIqsfr+/p/fdkNtLYAddkR3wyYU0
         3AlA==
X-Forwarded-Encrypted: i=1; AHgh+RrFo+D6/D/mqqnIcegaEuJhx08htinHeU/BSGz/RGx1LKYRR5I1AZP9QKmi9unawtDDyrpU+lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymgcR8cMETdMhfY927y3fqD1Ryb67KPmiRnv3qnSQrF6EoTo52
	ruQz48tzhx/QrMKxdKsWrYyPnYRERc9F8xkwvcqPSp9MERvxI11o6Ihy
X-Gm-Gg: AfdE7ckihDokKf+3wOoZuVb6Y3Of+OUZ6eQpiDljK1uzut27eU8054BwrTijBFuoNKa
	s2adZkIPKgyH2+HJqoc3xIx0NxfYnicQTYBspQL5rP0Mh2boG66MwsOPWwyImsXO85NaruLn2pO
	GnIfV4SeZxKFHXT9x9YtaYNXlx6XYFeoKL24v57DbAE0jReku9Gn5s1HcsqtyjlMGQmc4cm7QEz
	7CLxMQnC3YMZobyFpBwbVs+kUCPSy7oW/n5HlAPaFnWAK+fDH9mY9Me0Icgp3NVe52t3ZBILn0n
	XyVzNut5/Now5HFojF/LLEc7eiaKP6s0KGP3bRTqgv+0hiMg3EDWycf90LPt4gWj9q+0QUjfopx
	gC3Mn1mB0KOE1KU9yPM5uFSiSFJakLe2ZoR7+8BZWuLvoPT/cQBcZZt+/LDTxvGaKM8DO6Iisio
	QHQT55AKREg6LmEsfFrpjQC0ohAl1nhp9wqjhf0dlJzHcc
X-Received: by 2002:a05:600c:628d:b0:493:c2ac:58f with SMTP id 5b1f17b1804b1-493decbf152mr14148715e9.8.1783351633138;
        Mon, 06 Jul 2026 08:27:13 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6381e4fsm436227065e9.8.2026.07.06.08.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:27:12 -0700 (PDT)
Date: Mon, 6 Jul 2026 17:27:10 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 3/6] selftests/bpf: Add ksock kfunc test
Message-ID: <akvJTq3URZBpUTMh@gmail.com>
References: <20260706093525.13030-4-mahe.tardy@gmail.com>
 <d49e2fcbde106e80971b769793170fd479315d563d31bcaf6db33737c01c814c@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d49e2fcbde106e80971b769793170fd479315d563d31bcaf6db33737c01c814c@mail.kernel.org>

On Mon, Jul 06, 2026 at 10:16:33AM +0000, bot+bpf-ci@kernel.org wrote:
> > Add a selftest that exercises the ksock kfuncs end-to-end. One sycall
> > bpf setup program creates a ksock context and connect the socket.
> > Another syscall bpf program lookup the context and send test data.
> > The userspace harness create a network namespace and a new socket on
> > loopback, run the setup and send syscall bpf progs then check that the
> > userspace socket received the data from bpf.
> 
> This isn't a bug, but would a quick pass over the changelog wording help
> here?  A few spots read a little off:
> 
>   "One sycall" -> "One syscall"
>   "creates a ksock context and connect the socket" -> connects
>   "Another syscall bpf program lookup the context" -> looks up
>   "The userspace harness create a network namespace" -> creates

Will fix these typos in next iteration.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28783010022

