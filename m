Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A781F3B85
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784987565; cv=none; b=KnYeiFt+fF9gfjC99uLGPXqrYeW1sm2DWSYrr1pgx24ZRslPilijAP2OsuPiXk/xX5vezXNV5FQ3T/JHrs7Vv3CXZ/O/fyFT2hDJ2zw3hmKeTRRnUjxhrelQb340RqzKlk8DjRtay6PLNXVwSkA6b71jKkhOC6Ey/qoz3hXzOPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784987565; c=relaxed/simple;
	bh=g5LygCgcH4XVoC4r7EilVVIaM9bbzUJaXaHV85t5jD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sl5akJSGUzVsAzkO2R22r9xP2Au0pRwmOm+rSP2vF9LxnsSEWJc9RdaoFMqADfkia3P/37gbquJsviYABHmWDLCagLwwru02lmifCO2iOGmw2nyC19ZJBBeOVYkHlhKXqtdUR/mEGrG7V51ObVnW9x+0tr4y/FPBBWAa4iRPq5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=yIuY1/5G; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="yIuY1/5G"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493f75f7172so11383765e9.1
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784987562; x=1785592362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g5LygCgcH4XVoC4r7EilVVIaM9bbzUJaXaHV85t5jD0=;
        b=yIuY1/5GWFl/8VQxQz9E0WGGe+Sp20VIxAHJhKedsldOErC3c9SN1w7qmHFbiAeyLk
         ban3HOXz0eIkqNc/54jDftwZhUnychSqna3jiyug/6xPjVSy/UPzMTEvS78leyAtNw6F
         uMAJ7WhFs3DIRQRWv6bj79j4O4HopOYgXQUZAoTunPzpFq3u7EqBAwQoV3/CbYMOZuPW
         9ykm7u2Ux5xeRYH7dvtn2+HCQYRgQbIiEWIJ9pmwqQ2AFbU+FGiiIqFSOvfUA1cTa+Mj
         MEmAPGzZITTYaBSf2CTPDGVUwmDJZDZ5H+q+na67n6g28x6bZd9c55z1UfKqi364qs+q
         BVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784987562; x=1785592362;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g5LygCgcH4XVoC4r7EilVVIaM9bbzUJaXaHV85t5jD0=;
        b=kVee6jZA7awOcVuOawJqNbU9h9l6/Jbzbjc+PCZT9XyVwHLYF6aK8DCCGfxitV7tHV
         dYlgPu6Uwj0yyCKKSavvPv382d5fBBXuHvqIkuAmmwvoNEmA4+6hGiI8RvQ/q7d/gFgM
         z9KQRfDXMnIqqNJlKbAnMt3LKH1cxAzKXXn4AR2gicWpzu35KiBdI05GSmpAR7LsMYmM
         1Ug6ydhsznYO40aIc4cc/av9k3sggnZLdmq0AVd9U3wC01KinrTJEyj21QzME2D9Hk90
         xbAOm0Fpwsexp04ka8vqGjTzCUzaqvFHOKPktr3W+14T82d5xFJ0iqDE0VXLk/kHANTW
         jS6w==
X-Forwarded-Encrypted: i=1; AHgh+RoYyUIJPHxwONj+8l27KlXafZzKv2+jUQ7yPUezxya360+SL8vIUuyGMU6SEZ2+vwpDj2P90Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH5ZJmNBs9PWxo17gcoxFlIr+zbrzFmk6NCDf7z6DDIzLPC0RH
	y6RJ7pa7h6AXpi2Q/fjYpU6NLLeNIV9U+tT3U+Wx0WHzU2m1S9U5pYXsXn4hY30UfYDH
X-Gm-Gg: AR+sD103e4pASvSwgehngSiLCbYP3egn0mCfdPN9PYuBd7jnweoUZwVZ0W17FDvoFku
	5JsTsvaVyMxlghZnl9wUpif5v5a1E0zjeiZ6Rbz9Vu6rgCWxjwrMq/5IVfnDsElPkqUfxu1azjd
	Q+tdYmM0yCO2Rtw0PJx6ZHEZ3NiRWzEDD1RXczIArlDBLFnGkrWwx9R7eKQmlrYgbHI4msaDoFy
	3jOHNVvwkVypsuaLotxzNGVrdI8bJbl2sl+PeooYWwqEFitGgtwbNRUSadOf/w2OYg/lU+fKNfA
	G31/gkevD4Bf+OSofTQaV/ZzOd5KOouPhJA/ZgIQICk1fqh/ZnTmXPY2PNH1par/qVfchbtrTqW
	ZCsYbNoTbx0lltvhP6i4YNtLni6D5qC1IPGKohlM528giiT58sXR0lS0b7CYgDCF3cLEJJm0Zmk
	i4qSBrqjhGPQCjQALqSfeZTLt6zsj9Ab3rXQQqxTGQI9Wx/da0pq36B5Nt4XsySB6/hwaJzu4ZC
	0/hlHlBVfTQz5//lTsigA6Vow==
X-Received: by 2002:a05:600c:6d83:b0:495:7d78:7fb2 with SMTP id 5b1f17b1804b1-496b570027amr17998615e9.27.1784987561680;
        Sat, 25 Jul 2026 06:52:41 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.219.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ee1d31sm74193595e9.5.2026.07.25.06.52.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 06:52:41 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Xiang Mei <xmei5@asu.edu>
Cc: Thomas Karlsson <thomas.karlsson@paneda.se>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: Re: [PATCH net] macvlan: cap IFLA_MACVLAN_BC_QUEUE_LEN to bound broadcast backlog
Date: Sat, 25 Jul 2026 15:52:39 +0200
Message-ID: <20260725135239.30427-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <OS4P279MB04037D97A6ECD2021F1675C9EAF12@OS4P279MB0403.NORP279.PROD.OUTLOOK.COM>
References: <20260706212556.3199234-1-xmei5@asu.edu> <OS4P279MB0403BDB88C2B7F4D4939DCC4EAF12@OS4P279MB0403.NORP279.PROD.OUTLOOK.COM> <CAPpSM+QjiZxUOqK6Aor6gLehVj=xGQ0uAcuPm089EuSNRFeynA@mail.gmail.com> <OS4P279MB04037D97A6ECD2021F1675C9EAF12@OS4P279MB0403.NORP279.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Like I said, we use 100k today and are currently running our
> workload extremely stable with that.

I independently looked at this path, and I think checking authority
over the lower device may avoid needing an arbitrary queue limit.

A macvlan moved into a child user and network namespace can change
BC_QUEUE_LEN and BC_CUTOFF even though both affect the shared
macvlan_port attached to the lower device. The child can also create a
nested macvlan that resolves back to the same lower device.

I reproduced both paths. Changing BC_QUEUE_LEN from the child changed
the value reported on a host sibling from 1000 to 65535. Creating a
nested macvlan changed it to 131072.

IPvlan handles the same namespace arrangement by requiring
CAP_NET_ADMIN in the physical device's namespace for changelink and
nested newlink operations. I have a small patch applying the analogous
check to macvlan, while leaving queue lengths unrestricted for callers
that administer the lower device.

Xiang, I am happy to send the patch or pass it to you for a v2,
whichever you prefer. I would preserve the report credit from your
original patch.

-Doruk
