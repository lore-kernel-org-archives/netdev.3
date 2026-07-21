Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97DC448383
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627442; cv=pass; b=qi2CibQq49vENoNgMUbwixX1ysxROjIUTuNCaYBbqyHAc/h4AywHb0rI+WXWhd780shYdPd06ifEZTnaG5I6TQs5hGnCHHoyCO2AHGByKPA3kCyXIWTR/XMviTWQkyo1/Di2rojcCJcINh4QaB78GFDP6TxjYuxAtApcv/CQtGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627442; c=relaxed/simple;
	bh=3KhgfGhG33n8XSEXtnim59QLFEx8zNRkmNvCLO70y14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhT8RFANMQs0SN9AL2/b4g+Hzjm91KGp5R/krYEGI4n8hkNZeHzM5d/8YdxPscbTVkh2vbmaGJlAEBVopq/EbohhnlvCwYyfJ2kxhKWnjulNzM2hksZovMPbhTDYwRibP1nm5qo/Er4SbnH6O0nK8urdfupM2uH6IHM5wJhLj8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+pnzIg0; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+pnzIg0"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1600d040e4so721962166b.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 02:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784627439; cv=none;
        d=google.com; s=arc-20260327;
        b=U7c6qzGyKXPoNX1c4BqsjapTRysVI+/4c4Gflnc0qZYcTWE4FPRPQGlBPU8KH5GZTn
         6/1pDTT2I5Gcsa9n1Q3qGya+xpTnKxedN3Mr9qCEWtHJW3iGZ6cyzfgDfKiBAZMzXBNI
         B9LEQgX+3vEkBQTY6OG9HfdWGs8PciK20pB3kxS82CBmpWd6H/4QNqFfrEcdkvPimkfl
         orOhCmxJjvASB/kLnc1LydcYKRkTWT3nVCPKuVcJRczziLWSIzzFKKcdKmUVce+s2SlH
         0BWEvkFoCyrQmyRznG9Qi5fv4Qp03xCojbEfBzo67QJS4gGFBx1lFh0NmOuXWmyD4YtU
         ezuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3KhgfGhG33n8XSEXtnim59QLFEx8zNRkmNvCLO70y14=;
        fh=W1aedOW0GuvFCjfLosAD/Q1s/KhX4I0skLIWXbPGU1U=;
        b=YC0TkaDVak/Jmdv13x36+AMQc4jioHE2uZudg5LhyoabCfc5e8PALJgKaVcjM7HBoL
         gMfjR2s0LhpeKQz1bwBpk4fZJsrjMFWmSJnxr1uDWD3LruTc6pd+197oThddjLthgHLz
         htjRK7DdKq/8oPmAMUKzRxqG5CIXZEsVD7WqUDBje17b6hf9mGKJBpzr3WuP4XVUF4Uk
         VfS7pilGGoKlRDeVRTJj3sTQ9JefqG/hJ7V/cZBbUEoA/weLO/+38CdpSJ87t5HHd8c8
         NsnTw6fHD4nyjDeLZgGu3g4pGIbkuEnkO3yyMxcW+gdRbqUW8pZy8yZjlFMwX50D9mTW
         vmfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784627439; x=1785232239; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3KhgfGhG33n8XSEXtnim59QLFEx8zNRkmNvCLO70y14=;
        b=W+pnzIg0TXdr1stBVWinrWOoXcy7IHhOEw5P/5g4Ti1TtAMt0vkjSAqv+WEaoHuS2I
         ZqBsQfgMg11Fzx+qCvVua0pAMMXtXn0xDNBfc/FK8wXDgJzYpEUUcsjoqiSI1vshGENJ
         25k0aJkyNIdWxkDk6EVnzW7KyXpBm+/ujsk+7EcggoLWCMdLYAoEp96LCbskmHo1ornH
         bu9U13BrtmMe7gMXk6KzC8L4T6adUK7Kj3Obhp/k7lOADizbVAC6mia8Rh2taFKIwSS3
         SKKLgRn2C00i0W5Tw4tP9yaxhou6qMe0Iw0XQR0XUhm88LxoXOlJMR0OmToMYLLi93rN
         GuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784627439; x=1785232239;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3KhgfGhG33n8XSEXtnim59QLFEx8zNRkmNvCLO70y14=;
        b=RNm5r0lhWEMU/iFsMxSBfYzVdFDQWgVCxcPaciInfssVPHp5Nx5o1KtaPNqxxDfT6Y
         7KpUnGTPcNgE4rtuKNI34eMKR4NHl2Uol1cGW8jgKTRhMbFk5P/2e5z9gFNqJLLpVp0M
         Jf7hQ5vJgZnyAZs4ar+9tuNcnrRFUa8GlP/KW8ZipXCAlTetwIxOomG9+g16TV0qwdTx
         tYfzNU3GoJcp1dQ5ylCjByPzHHsgob/RRJO14kiwHiL2PG1eFtkiOQmXvV2kemd5S0S6
         QfM8ssnE65py+6nHiythmepBjTpW6dgv25r7wnLCP+O6GSnfgiQvP35AY1v3OBB8e7g+
         beng==
X-Forwarded-Encrypted: i=1; AHgh+RpzanAzPbn2EPDOUKmoOIF6kO3R42186DPp74u9hvgZzsP80hFJ4n2kZhZyLwFXgx3dROy+1UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLGMX2oVdFJur+KywQ7Oy4hnRf2KON5hsFP3xJyQgoVMYsfkeZ
	Nlg1Nwbk2nYldwMtLgQi2stjC3EnIxUy3WUKRXrIFXN+UzdyTWeHmxtDfKZHn/hgdINNLi9fA/w
	sb2kqZRg4Mb+tibu6zh/HBba8HIad9TA=
X-Gm-Gg: AfdE7cmkudeXIpzTa0bHH5PMV5J2gNRoNgV8FNH0+XqZd4vqUDqM+MHraE2++bju7CM
	tIvC+U58LCigYbNgUtrgGJcSzCSCDGQlwRwViLaQGaeA+Qh4RkCDEvZZz0xGQatFWICcFx2x5mB
	xI/IOZ+YcstAWfkMPJmWYuFq/rWEBlAb/LkHD5P5iUlFcvZT6pjPcDiKJzWGhuYs49BSyBw+AN2
	ubUJcy18l2ptXsQOW6a1iEkP4YZREU+WZ+q2sx3EqmO/KJ1EUhAX60V2ZXRhUvKx2F8dHM=
X-Received: by 2002:a17:907:72c4:b0:c16:893d:b870 with SMTP id
 a640c23a62f3a-c16b416cacamr792581166b.30.1784627438745; Tue, 21 Jul 2026
 02:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708042244.120898-1-running910@gmail.com> <CAMyuFdVWgvx4yafBQfbTt4Do535p3PF0LCpZ6Gma0WZ-De2kyA@mail.gmail.com>
 <d6cab50d-dd90-4022-ae15-50df05b85556@redhat.com>
In-Reply-To: <d6cab50d-dd90-4022-ae15-50df05b85556@redhat.com>
From: Zhixing Chen <running910@gmail.com>
Date: Tue, 21 Jul 2026 17:50:27 +0800
X-Gm-Features: AUfX_mxaLLpeb_9QB0bQATZeFIGw-F98stjYM1vsW3bo3ksqSrESwGgg26szuYs
Message-ID: <CAMyuFdX8mnEnqt_1aL8+FfAqa=xpKwKxGQq080OnJS8hyJnfeQ@mail.gmail.com>
Subject: Re: [PATCH net v3] gtp: parse extension headers before reading inner protocol
To: Paolo Abeni <pabeni@redhat.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte <laforge@gnumonks.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> season interruption reduce the available time. While the patch is alive
> in PW and no comments from reviewer and/or sashiko are pending, no
> additional action is needed.

Thanks Pablo, understood. I just learned this workflow and will keep it in
mind next time.

I appreciate your review and help.

Best regards,
Zhixing
