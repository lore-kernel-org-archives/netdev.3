Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED32F4CEE4D
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405111; cv=pass; b=HLefws3JosUHRq0pqsNw5gVQWjUhrMQiJSvPzGPXPMSAAOAnJYXQpUj4BdeRl/8ctz+JvH9q/xYaKwQr2ltdvBnejs9nN9Wy7mA+8gt+5JuRqSNuOeXEeegov2tIEQD5BXiWOrQtYGWq9q11EsAfSyea46TgErg0ox1L1sQ2vXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405111; c=relaxed/simple;
	bh=0X5plGkx2cbkG2CtOVwpU5mD1drTa49dzUT6iJzQz9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZMu1Hz57TxWxa/wH/jPeHv7DuPbmRm73EV3Gw69hqGC83wu4y1TqnNb91WckxCcSuoERaCyA9hFzBdFLhDFETmmZ56T1u6+QuvoInQ58xQqEG1xZ7w52+nQrXUsZ3zscviXifEHZAeQmUddERfUEFFV96n6NA/qhWoKTCtOXeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b2nXhieO; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b2nXhieO"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be47159f2bso1496516e87.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:18:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792405108; cv=none;
        d=google.com; s=arc-20260327;
        b=qhEVFIqcgrp9tkeZbJMBnQJrGpB/r2qMtOj5WALFuV9fW6RaLDTM7t2rTytEfKBiiF
         toIE72HI7bNoisMGh38Pk6y+DTNPzWFWyD3SUffJBndVTuBKWKyXvEQdxoxXT3Lv4/+A
         9Akq5GZ1YkywyGfU+NVAxNX05j9owM+d1r6sv2vqfyJ6UK1U3+E694BaKQemyDdRlag0
         gOGISBGAS9tNsyQ8Zh4OD3iKFLIAJgFAdvx+s6a3g5Arzi5iGYEmuUvvmONsEfOksbL5
         5z9O2XrCuqOwlp/Al3R6xvaEB8HaPErnIiz7KlIEMemfrj2rfazUOrYLeJOOInXnbq7J
         yW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0X5plGkx2cbkG2CtOVwpU5mD1drTa49dzUT6iJzQz9I=;
        fh=DSnUwYt7miEvJ2V8r3uZSNntWmNV2kPVmQ5OQSKjW0w=;
        b=GHG1IZr+xzxQ0RUdkuOgaQW8yBzxb3joGce4DuZPi1mCGKd0924ct4JdG9hTdyzGbw
         eWOdfw1vSjAE6qzSNGNlKN1QxXmYC4oSdxiItp8tO45swKaZ4iosuA+Gtv14TSeuL7cg
         Xt5XL0W4bmUS72pecOnNI2afCgBE53qlwQ/Q2ecTEl05gRHZu+KBYim1PolI5yClg8Xu
         h30Epy4SHqxYrvKOUKCYOABLvmhE3iGj16JJz28J3bvdhfuIG3I0aPH76Co754ya/PpE
         NS5THVhzHhEm36+Uug6g4YzZADnbEapAk6eTxtwugs+mVjHg4WgxYFUTe/vTLhqaFUiu
         rLTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792405108; x=1793009908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0X5plGkx2cbkG2CtOVwpU5mD1drTa49dzUT6iJzQz9I=;
        b=b2nXhieOHRHMFL2rCXaJWL4epOElrY/WUDVe98SjLp/NKrjr4E89Ha/Ro9wT+O/hrN
         +dPfhRTEZ3MV+FeUUtzaRN5LiX4aLMRGJm0qWpCj3F21gZEIsgbO847vUwNxuJJb6meR
         R/fG2E6htgqJaEnwXsGDp0co+kg7OI6qjP+98UVbBO97PyiO8JUQdtSejkf7ZRC/uO1d
         aj1lt49vreqxahyUT5Jej6Tuymrp87uKZQvOPNXXgQKOZOATiuZoaX+y/Sble5jP0QP6
         Jujs1g2g/6GtLEPQMJfKJVSnQFI28wGvDN8NdAw+IBAfnDB126ApF1IHICA1xrql/Gbq
         Nsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792405108; x=1793009908;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0X5plGkx2cbkG2CtOVwpU5mD1drTa49dzUT6iJzQz9I=;
        b=0k2xat0Y54AJ5937KZd3cxg9ePeZzwudm3Bw7eXVVH/Zonzb2uA4eCdMnWLPQiIcQS
         DTW7/c8kvQZM5OV6aUTIbhOaabtsWLHE2hwMuB8fCv2IlicUeYx8fr8EwEru/rpqGpTd
         Wft1/+wtiDlw3hmYYvtXuIwAXjJnj59yr0m6mqTpqCflrzUzlPL9/iB2qI8KxMiLxbYm
         Im/1mHwvpmNxPwZEH/4IzsX8h4F6JuHN4UXZO8nbzXlNmQ5ZrjlHgo+CcMY4XF2GJGA9
         L+PDWWFjS/oGJ/b4e2ka72nN9XGwTJjJaUSEkEwepkkJkrXLYMWrf8aPxaXiDRelWkYu
         ndFg==
X-Forwarded-Encrypted: i=1; AKwUvBx7JvxCBHQk1NlOwvqyZnKH+JkRfFazQ7w09a0LdYpfWLNSaikSfhdGCkBlk9QvRDR0b3Z+zs8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVcFv5PLjHOzBlLu2R1LifascatpZxeClfkBBz9DFejrCqvEuC
	DP+3QBNFERgbXDC9DaVetOLcD+Q0PRfe2ImuIgDeY8uZfpRdJvOABTNyLgIEejQkfojOtaiHzrA
	HdP8C13B/ikn4wgtJKDA6CfCA5avfqog9eT/caAP3Nw==
X-Gm-Gg: AYBFou1cfBS/ihkSuQ6KGp6JZN6clFocpEsmHoXkXE4u7IAKrJI5fwuuvGd1KXzHdlD
	++ufHVK9kJF29LMZSq+vtLvVoBbINWrcDvtC0R3h7JLCJ2QWGmpcEjh8NPOFrfQcNHTxEoSQT+B
	CCsM64ehgrPoZ5zXrQO7EVrGdpHlj0gNBpMBrSpMQlyOfg7k8rHK+ybG9C8Hf/E1dZx4dGCKIHJ
	EqnkV2l3DX1SLe+RW3KElP8h43VnC2iCJfM3cFs5I/lm9QUYIoZG+C2pDeMLWkD3BXbuZGU3FRr
	A50QE3NbtglPTfp1kIUN1OdbWHLwG6DMfcquiM8Fwxc3Zi8i6ZEzT+TAH4nnGq9vXJmohgETcBp
	XOUgf5BhVz/6u
X-Received: by 2002:a05:6512:3b08:b0:5bb:7b64:340d with SMTP id
 2adb3069b0e04-5be50a73dbcmr2180517e87.28.1792405107931; Mon, 19 Oct 2026
 03:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012095452.135828-1-marco.crivellari@suse.com>
 <20261012095452.135828-2-marco.crivellari@suse.com> <de6d786b-fdbd-42f8-b2c9-b175a6a33c69@linux.ibm.com>
In-Reply-To: <de6d786b-fdbd-42f8-b2c9-b175a6a33c69@linux.ibm.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 19 Oct 2026 12:18:17 +0200
X-Gm-Features: AclHuK-BUw_TxfB1HhBk8jNSN8MxUezMM1hmofzvTqK6-PRot3PI1mJ4gMma7qc
Message-ID: <CAAofZF4XMmr9ajA=W7g4EHOSy8C_GRR1n_aK+BXTgM60onFVqw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/6] ibmvnic: Move long delayed work on system_dfl_long_wq
To: mingming cao <mmc@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Haren Myneni <haren@linux.ibm.com>, 
	Rick Lindsley <ricklind@linux.ibm.com>, Nick Child <nnac123@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 11:20=E2=80=AFPM mingming cao <mmc@linux.ibm.com> w=
rote:
> [...]
> I walked through the reset path and the conversion looks fine.
>
> All three system_long_wq users move together and there are no
> remaining users in the driver. The work items don't rely on per-CPU
> state, so system_dfl_long_wq seems appropriate here.
>
> Minor commit message nit: ibmvnic doesn't use mod_delayed_work(), and
> one of the conversions is queue_work() rather than delayed work.
>
> Acked-by: Mingming Cao <mmc@linux.ibm.com>

Thanks for your comment.

drivers/net/ethernet/ibm/ibmvnic.c uses queue_delayed_work() and as
you mentioned one queue_work(). The workqueue used here was also
migrated based on Sashiko's feedback received in v2:

https://lore.kernel.org/all/20260711164434.1691221-3-horms@kernel.org/

I will keep your Ack for this patch in v5.

Thanks!

--=20

Marco Crivellari

SUSE Labs
