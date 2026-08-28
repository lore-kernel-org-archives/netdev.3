Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0593CEBBB
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927675; cv=pass; b=hNfcuVCg/Fi8LWAanqsuE1IxUjxHk/704CHQD27J/f0qVV+gDH1dOt4iwBnXEigo18AouHEE1NQ3gnrkJde4GCzdqHTSobRK0cNu6pBdFC1PlPz+B73/baFljHQ1qFi3V9+1tmSjUSPKmtoEniZupyAMwpWGAusBeYTqLsrRloc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927675; c=relaxed/simple;
	bh=xiyP8E4wV+sMaqs4B/yZCVYaphrCAtJm7nVSylquv8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8hUyar0EiFexpwJgmx2O36w1U2VcME6nc9iC/4JBpunLCK/BLuRFtcV8n5KH3ZVc5kqGlc+TvDnKCHaOrQ+Q36R48xJ1ZxIeLLGUFTi4zh/dzrvNFobBYNL8wwq05bcwlxBo6eYswkW0ngk/2c+drpayBeIVILa9KKNyPJy96U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A56I2pMP; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A56I2pMP"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-52eaeddc837so5912391cf.2
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 07:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787927673; cv=none;
        d=google.com; s=arc-20260327;
        b=Jf1Lct2PjStilBnv/5VF4tozgMUnC2NevVFZoz/5EF6ZD938Ye3vVFyJ27i4387ynp
         XkVZn+g0SsAZD6kO/GurfekVWD4vUFJLX4+dP+kGXiDTsLHxYTyz1w/+NvPlvHB3QtH2
         sHEnM4cdpGywXVi1tXfqzRTxMiSmX97mqd7Yjk31oGGZUcgbrp9xSdkBlxwoS9ctZ7kX
         /THZZIaSKbiFOEATfuvUg7v5gdjbbtaFSkT5W2bX4NN4hFipLWWGrUHk66N1bVAlGvku
         h9SyU3TtvZ7tV2tS4S/rknFb+fOqNTD/cfTcb6KLLlTY5C8klEKPIlR8QO2Ov4yiKhte
         2ECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gUsOtdOdvL1xoenFKHekMoY65j1FyFMLBu32Ho5vB90=;
        fh=oJ+ItFnDPrJ8g1+MA37Af47K3wDGGXPLDsPb3X9i7Ac=;
        b=MI9Zs7IoYbr9mC/unMfb7hCn6ChVxYLP7WACduJT+eQYJZYPbi6KvZ9DqfgMVT2la6
         ZzldP/R8H/TDpRM9SkGafC+kQO3OOImG5eLzLm41toTpw7T4rcLff5knCLEIxMieDlAt
         oGoVjfkL5qw3YJtlVjR19DjItXo59xfcb5B+qkraLS9BCErXCzySX/xUVlql8C/GzD4C
         pkfoihA0MNPDXUibx86A5DSpgw5nQpp5BiM1bydqZ9FIe2YGuvQz3j6RhHNFhiMU96fh
         URilC6Ay5EL2IopvnndUPwlBg44hv9Mspe7vcMF9LW4zjdA+BWCALWISEDkvfiP0UW2h
         yW+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787927673; x=1788532473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gUsOtdOdvL1xoenFKHekMoY65j1FyFMLBu32Ho5vB90=;
        b=A56I2pMPzIBPMpKduBgM6i7FC7hvNRoFv/w1mPNZ++j2gmaG64lBY6N8PZ7IcLgv9F
         IZpKKsKVKjna8J74R0pTOXWVEXU8K06cOtyQ+CGD+Tu7tRIS5PHPfjTobkGbMvznekic
         E5GrP8EI1wAEUmih8CuGMtCV67HeBy6zvAIqDaEgpI6pXv3KBBl1U+Keg8rLLtGNMJ5v
         M5ljjVMjWtH6D5aLyB+EGe/0HE5x0T3p9f/hnBm/yNwwhsFa6VBMVtkNTGY8zU/1qXD+
         EPhiTAJRkpbl5Re7Qx6V/erbO+eeLNfpjutd6MwMpIjaOnVKc2Of8tMk1PqPq+75Bfz0
         Fm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787927673; x=1788532473;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gUsOtdOdvL1xoenFKHekMoY65j1FyFMLBu32Ho5vB90=;
        b=RTUmUOSgcJbzIE+jmT9hAq6TPE+UV9YI6iCWFYFjpKmJ0xv7ce2rji43SB3r+N82P7
         9JIuL9ujXXFtnupkOOBBSiaMa5FYNcTKx11mMHiGJqcruufI0x3P6vH4wjxhkvi1ylGN
         KzM97OU9oyaNyA7LW4d11BToHEbtJIh9HwKay5jSsj3kHobnrh43frtlTwnyEvWzIWDO
         hAAyOPXxj1u9gO2tO0RBddayppaCr61w1lDF8Ktpx8VqJsj1WQJzakUs6sbUIKxOTYSY
         FJtOMQh6ZnBbOSOq2mkuCq9r5m47wdN8SKvi8XRlSrNGy2Qf36KN1FowAyi/XrePKQTr
         8EfQ==
X-Forwarded-Encrypted: i=1; AHgh+RoibQ+J8XPLpIG2gUtn2KRwDMDwwbPSsKU+iFxeiSi34H/rbC6v8LIlhr0L1zXBwiwmASeFdro=@vger.kernel.org
X-Gm-Message-State: AFuF++lJXX25Ut+0a4ohaBcp6q2JnvZuXgEi5rA2JkeJZLEeUOzMWIf3
	89MUtgXZfJly29NqOUnnC/6lN/jLLXyN5im+RLeFcwW0eCvODavRzE5zTsQjuLQ9/SJSJgV37VT
	KTVYnzo3nf6iqhmb190J3GgzouQzM7DGgBysgSq0e
X-Gm-Gg: AR+sD112gAe54T+bCUshfV3NcBorALpxlyQLjAOFahUMSL8/zBnjYcn4RffPcvJAq8a
	fXFGxIOZFO+KZrntuuqAMl+XxmKmvAeASJ2B1S0u0bgsmiKneSmLOqKCvd3NXEQP4HsBr7GcmYm
	WoM8wviQls1Y3vxxMx19yFzNAdsfbm5/f9+UuZuzooBfvlmTVLByG37tojOMcY1D+2J4PY/QAJq
	jEtgZ+16GeJpTkoTG23P2BucWDFSW6oik0xxi7yvYi4fbBXWBbb3cmvBjCCiwKLNr1Gc7zwm53C
	sUbyA1CI8ScDYWkIUhzwx6Wx7QJ/jieU9UNgbTvkRmwQ11xS6Qlq1cpmGKPznP7TunjSbUv7fOu
	u5yM7ApNUQpx/Qd7yvTV6yJYwr9iA7QjAbvPfmIvMEX774zPWCFgzXhx6j1Q=
X-Received: by 2002:ac8:7d8f:0:b0:52d:e425:9b83 with SMTP id
 d75a77b69052e-52fb97248b5mr88019541cf.32.1787927672410; Fri, 28 Aug 2026
 07:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828073245.126804-1-qingfang.deng@linux.dev> <20260828073245.126804-2-qingfang.deng@linux.dev>
In-Reply-To: <20260828073245.126804-2-qingfang.deng@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Aug 2026 16:34:20 +0200
X-Gm-Features: AcwNN1W8LMMtqWUv4J0NuOtodTTi0QjyatQ1yJx85V2-e2L7wFRRAVaSw3UfPsM
Message-ID: <CANn89iLKco6kcgFRa4PkOsk1TepnCZq6emG=QJdfN+LAWVBoOw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ppp: ppp_synctty: simplify tty disc_data access
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>, linux-ppp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+b503105c2410c3433459@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 9:33=E2=80=AFAM Qingfang Deng <qingfang.deng@linux.=
dev> wrote:
>
> Apply the same simplification as the preceding ppp_async change.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+b503105c2410c3433459@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=3Db503105c2410c3433459
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> ---
>  drivers/net/ppp/ppp_synctty.c | 83 +++--------------------------------
>  1 file changed, 7 insertions(+), 76 deletions(-)

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!
