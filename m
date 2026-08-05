Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210324399D6
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936926; cv=none; b=mGN9W+VoNmoKbf3tvvzg7r2cT1u635VK0bx5hdYm0I2Y+A7XXRDfnQjx0l6oAJMwluUUsFzaQGNTp+yaLKerUUvQYwRqDzmzCzg178fPB04NfBERINuN/3ZI7BPMdIq952TJ4RZv+7jPkjqgR8uVVY+g5jMwp4Q5KeJaRwLZ/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936926; c=relaxed/simple;
	bh=jxuQfWhpYl66LtBJmNq/vF46Y1oRiue7ltLsrXhWh/U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WpyPbmtF7Vin12BPR39G0JRJJU9YYhtGKfw8Ihba50mwrsHg2ku1BLN6MkLCjouDV4EHHm/lXTWeFiK97hiOX0IrS6cf8U+Y61id/HbPi9xqbuTmd7fQcABUL1IZsiqMg2LKSJoKl2iOdfO96SLcsfK7bM0QEjFc/MXsPsAfzgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pIhTG1yB; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIhTG1yB"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66804667af2so806630d50.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785936924; x=1786541724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C1nzsLI9q7XCEJsy4/q+r9IZRB1ZH+YkiVaabrqN9eo=;
        b=pIhTG1yBriM5SYeDCRFEKAlrNMPQgd2CvBU60wPD90/QGvESNAgNEPCONIQNOwSvNf
         hh3vQafJfeZxtZDTvqhBuz9UJaLGytFdZDYLf+ZmTFtj35cPhKo10Eis6OzHRNClz+6z
         iNFL3JYBVS+wXziRr1xk6EKMx6EiPTek5+RkDDrOXyL5nuypWjcUdtmuEJCiWjgrR72l
         J8FR+1NA4ruwHetyvQRHSWW21ZYwtjYVnhj8XUbySIRwX6JS5F7KK+wM+7MZTnSlDTtm
         +tvA4fXQSJa3dkh+ARNBEt3Ue/d8suvtFR1S5vKOUEvLLCaoLxDl781SAqgV6+nhwX6a
         Fy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785936924; x=1786541724;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C1nzsLI9q7XCEJsy4/q+r9IZRB1ZH+YkiVaabrqN9eo=;
        b=OmwcNNZLi5fyvg16NQJnhyzxl/5rFEr4KVMxoAQEGVraEYF9z1PJhetXSybc+X9XB6
         IRu7h1NmXySDmarvgWN4LfppoaIf5EUFm9bOjfdHoQfoZoSfPk9diYeKsoNRO502cFQS
         fHi2hJ2zXqPzPCKC1iFhNvTFlf662uI5YZgK0/UbwUSaI6ODRWik3FpetT6P8oShYhpi
         S3Mn/aip9GZ8e4WLlQwOqY/0KwjxUVwBLe6wjKzo7y1WT13HFkYY7jyksU7QiczNXDyY
         QU3OaompjlHy2m1X01vAudaLjtFkH+m1c/2j/fQP/0UoQPGMiu87y9/3TYzVd/pk91xN
         bh7g==
X-Forwarded-Encrypted: i=1; AHgh+RrJISPX8AUF5OUYQArSc/cBCU9BJlJdrG55GNobbsJ0vTJ4BIXifpqgFIwC/rAdgIdlFLyxrCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrAjYs1Sc8WXicTce2oWWcTZHwbF96nusYxNc/X7EhvC2x7MP1
	utyzCfdea++/4quKmlxNGON5e3d5FiNsQ6NX2anAdlKbWf/RE+eVCu6y
X-Gm-Gg: AR+sD10onaFi54QbL0T4bTVePzNwmS8B5bopyITObNyLdCN755fVYZ5neFkhCZrsCUW
	plWIM+CMKeKDeo6RZEEi9fpQRs0sQCgogjVOR2MQLt7Wqg1Jjfk31E4alSCfh0nYkSR+aCOgkiH
	MyIc1VuW9XgEJA3OBpeeH9oArzeAZcnaxcabsX1pIfx/16526ep4qA0asC5or2tg/ey35MzG8fd
	EgYjCH6ouPU5wjUCi7AW262D5qhEPG7JJfNj8bgMarfEqyoRskbgunlPy8qb+N/0HdBxO2/0JsJ
	u4rfYSxMPKHhC52aDbmmBMcJpHY6hVBXeYT1+mXQ0/l1g3vkJ3VAt9fVeUkYBf1Xchra9R2ce7v
	VokLAN1AzyqryKBUsi676rBf+yLnSJshpy96z5zmZDGIzFesP78dcDPCbKuKmhfIQUukyTakC8U
	dJSPz+1kWd8rLn0OjiEcKHAW7urNJpOlqFlYSCTTNssqR5QBB4fByzKlGVC94r3/ic17lX43LZk
	EJN9qXPG7OJUafshZu1/vA2rhmprrtMxYUa
X-Received: by 2002:a53:e30c:0:b0:668:9e51:5239 with SMTP id 956f58d0204a3-6699ab2455emr2737422d50.44.1785936924056;
        Wed, 05 Aug 2026 06:35:24 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-669915f5a6asm3005487d50.12.2026.08.05.06.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:35:23 -0700 (PDT)
Date: Wed, 05 Aug 2026 09:35:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Qihang <q.h.hack.winter@gmail.com>, 
 netdev@vger.kernel.org, 
 daniel.zahka@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.251660d5aa3e@gmail.com>
In-Reply-To: <20260804164324.49528d7c@kernel.org>
References: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
 <20260730082925.93759-3-q.h.hack.winter@gmail.com>
 <willemdebruijn.kernel.f39af6152c60@gmail.com>
 <20260803192228.49a49867@kernel.org>
 <willemdebruijn.kernel.ad7f187edf35@gmail.com>
 <20260804164324.49528d7c@kernel.org>
Subject: Re: [PATCH net v5 2/2] packet: use consistent hard_header_len in
 TX_RING send path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Mon, 03 Aug 2026 23:04:54 -0400 Willem de Bruijn wrote:
> > If I read Gemini feedback correctly, all reports are about the current
> > solution falling short of fixing the instance of this race condition
> > with dev_hard_header(), which reads dev->hard_header_len directly.
> > The patch indeed mentions this limitation.
> 
> To be clear -- prefer looking that the netdev-ai instance.
> It cross reviews the feedback with different LLMs
> 
> > As well as the same issue with dev_validate_header(), which the commit
> > does not list as limitation. But that one is only reached with variable
> > length L2 protocols.
> > 
> > Side note, in net-next I can probably remove header_ops.validate now
> > that ax25 is gone, and with that all of dev_validate_header. No other
> > variable length L2 protocol ever implemented that callback.
> 
> Let's do it.

Ack. Once this fix lands and makes its way to net-next.
