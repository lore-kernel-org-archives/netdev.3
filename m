Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381064;
	b=mvhR5XOf40zSwphyaVXjB4p/kqd8KUcMKOLB/a3XyETdENBNhaviE5YLRL/3VfLQPu07
	 FyBn1UE0hP9oM+nsGwPnLLkKmxzfsRYOcoaVxldIrvzpvExr4/t3+tQSnhhaFhOWB+fld
	 +sTh9OtpUfU3Wau00HMdruuGRRSxjS3tr7LtVYOpCz6AMecQP+J1znBn2MWpfJm9FT4H5
	 Xx8t1+zlEjWA2jAprZY9WXm1y40EHOquCwaASA2xEPnP1soFLuOdaEqm6/2P8G9AMromB
	 6ZGvym6AUvBskCBtFxNze77B/n0x2YkF6s0KH8YAPG/pTibY/s5s/xt3Do4sB0tLFzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=Mg6aSAW2nZlqKBjxYch0/lj+ItuvCiiIEV6k8koKlxI=;
	b=tw3Knf2Tt1JmqWu6P40ip3j0cpnySNpsifoFXA2L0DFJ03wMUBxuI4HUtVfIsxZZOhPL
	 PX5SXFIG2/wzQfvQcZrOWMFDlTw0KQfsSB70woZHe+a8sPl1LsrXprSFKLDpMjO24U+pN
	 E82jUORYkeyFZckQvuYhSNfQOuoyJltWgozxWC2WJQHjfe9jj0ri/H71Y+IlM7oEUOdbc
	 S72EAVapzrNousS/z0aT4tJBd/gjXDYvVJWSrPpO4zQ/YVsBNlF9hTvkMVQ0PVr/i4ylJ
	 7bLlpG3Z7yXJFDZpc1Bj1p2ywTiIHVeA9hs7rD3IKOmiUlySiTAAnZMUpJBP+NPXn9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q6QALrR2;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C5E606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 17:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2C5E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q6QALrR2
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7bec5112765so640637137.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793381063; x=1793985863; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mg6aSAW2nZlqKBjxYch0/lj+ItuvCiiIEV6k8koKlxI=;
        b=q6QALrR26xp1pZTmOjBiJQd/a5Lm6Yd5RIj414nvPbtFArwCkl4wUob15cgpXIyDRf
         9EknwI24ica7HnQO7BghZtSGSkaBZSJK+p7X6WBqw+bXQBoL1bBhv89fPR60Z4/Qi96a
         +bF5Lf+BMQWaAoXCHEmXvOz4vGc2+/sEcaiPbRTqIDMSsaSjAve7hszrtyf+0nKKSCxR
         NsIdPQLVMrvEd2eJ7LTgiSWGdBVliDx5BOsaMRKna+p/UhIzXUWRVFO/PTaJDZP829Mr
         vadxyEYXk3wGsiQp/pO/2kwKVC8NZFm19NaGDhhcrcJaWtLeYFS5MSIc09y0Z5y31+HL
         vFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793381063; x=1793985863;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mg6aSAW2nZlqKBjxYch0/lj+ItuvCiiIEV6k8koKlxI=;
        b=x0jWw/gO+yUw2RYO8N9gY1H6s+skiZW6b7jtoQkk9DOtU9sUytiGUL+ctli0EKcS9B
         IpTTk/vlq66ZO0lJ3DtPoOZeuYhdT+y1/L9OaG1zwTQrKXsI6nUeQO7Eo0XSB5HE3QYR
         Prhl1rIB8iKiu/R+B0K6CKbxWFT8hUf8z+lY1h0Fw2U9V9ZV3t7s1dG7u208BChU2ODA
         NO+fV9WDP//QusogP+ZjNsSbwPAJslwdkUidJtGENGV8dSohuWp12Ockgo+6VRDPHgUD
         xH7WZ1h5NixNxwA29U6mtRQWFM4gs4k/CYncq1aaz44LyU6Sf8h+pX+RAmymZuyrLWSa
         rvzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwU/e3CAGaTPRh6JkqRQo+0UJLW1LTcFQq0oJDt0WyKDR4T4eC9AoUoRKGRDg38AdqByyYJN0=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/iIiCAR0br7Hfc2UacogjputK4jUwhWBDVq7Kdd3MUbYgCpel
	Uzxu6oVBTBoX1wGnA38jHr9vzIVK6Fs58G0fAVfg4dMd1XkJ316DIYSL
X-Gm-Gg: AYBFou1RTRF6VD+k++rz/TaGHqrjFj4SADFBugIvxPoOZlHudw9tIvR9n5OUVgluycL
	Is7qXdnXHhXTtAehzBjNj4bhSQkm/t6DduyvVy2a0NhjotysOJq2Yo29TBq0rsXOBAT2nd7Fgrh
	31snVnJCCk+W9ywLgiy/uIjgwYDEtE/Nq8j4MYFSTOrTDN0lkc+A7F795OHZ+AjoPuH8W7/fdcG
	/x5odi6O2cAlsZy525RH07b3Nff1RBlNxcPtCiqqyfloZ7z4gqwJ3VvB0iscgyIjBB2ZEEpbp+e
	UYmjVXQ+sHJCt0a8nPoLzuCIFOt43ePEGP0V5hKiLXeJeVaw8SoaBI1fz24Sla4D+hyfX2lJM4r
	bFEpsmuUoMh0POkEjpcBHOrVdU0Ogl6vwosSLGAPZWt6Yqi+4Qf7EptYcEADiIVLfYv2p2fGQML
	9hOEfhN2Z8PnQTzJmqamQj55vk1RlL/TWj+Osjm2XnhQy9S0Dfy7y0p1Grne86ZLhatdNJmW+0M
	aMi4qyHk0Zax7tT8RX0aDYw+r2XXI2eok1BRvTE2UzQlSLq9QGvoKY3BHVwiDjy3C9YlzsRRrjE
	i9afOWgUyh1uoaj8EZVuN910DupT2LqAnF3R/41m3ycZjtjqv/MWJTRcvZxP3Edxkcp4OV78Ekl
	5wVJsCLV8UL1SaMOH5QcDbIokyZjlfRXnX1xaKuU2NYgFTKyFEx/TUFQp2EFaCAvqImUztWzG+g
	GP8hNiPVUGLcYpU40r4Q==
X-Received: by 2002:a05:6102:c01:b0:7d0:5688:f507 with SMTP id ada2fe7eead31-7d072c596c4mr1583521137.20.1793381062741;
        Fri, 30 Oct 2026 10:24:22 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:18:15f:b9ba:756b:b70a:a34a:8232])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d077393404sm2868377137.2.2026.10.30.10.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:24:22 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jon Maloy <jmaloy@redhat.com>,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] tipc: raise the minimum bearer MTU to fit tunnel
 and crypto overhead
Date: Fri, 30 Oct 2026 14:24:15 -0300
Message-ID: <179338105585.65961.17235832504055289741@gmail.com>
In-Reply-To: <AM7P189MB1137B1760C380E81E5A3CD8AC66D2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <179322942644.17111.4355153262478871713@gmail.com> <AM7P189MB1137B1760C380E81E5A3CD8AC66D2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="utf-8"
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

Hi Tung,

The only items in that checkpatch run are about the Assisted-by trailer:

  WARNING: Non-standard signature: Assisted-by:
  ERROR: Unrecognized email address: 'Claude:claude-opus-5-5'

That line is there on purpose: it discloses that an AI coding
assistant was used, in the "Assisted-by: AGENT:MODEL" form.  checkpatch
does not know the tag yet and parses its value as an email address.
There is nothing reported against the code or the rest of the commit
message.

Thanks,
Joas
