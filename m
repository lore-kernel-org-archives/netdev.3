Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438936;
	b=UPWmf2Lyb3ywhteyGvzYvN9UfpojphMXkS6wCp16l/DUYVnA7dk+AnCueXnaTaZbyvP/
	 Po5x9ge0z0w8yTasgP4t2wJky2uTMSnU2YjaR1W1ne6JjMjq5GS9wDCBxG50HcSBH/D/S
	 SPCLlnDZqBKBwDHzM0Leot8caQSIAVV/W7pFwLMZgyB+dMgbEFi57gYZvdQcu7i+8K2FE
	 Grp3lb3TPrdseW1wDfUCwRLrysTX1Paok4ZooRferJTW9eKiUbGnYr2418I2ZIcbYKggP
	 p3lC8KjL+EEfGP8/xizXWYe2KKnm9BQas9CaSB+s1JUa/j8Ue/auqmlOwre1xsZ9kYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438936;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Ib3Jyrng3eMRwPlu4vvYbRPIULO3xoAFugNEwMFenwk=;
	b=H33Z6dzwO39yg5uQ9c5M7Gb3GrCfCVwUjFXhzv6vitZhz4W0GVDWW0eNU4+fuBlsnq0u
	 NptHCjzD8gkxhgEhvFwWd9A7MiJDpcrA5Sn8tM1R+IXM4XOz/yTk3cAcxthffNjH1xDNf
	 t99HjHEesUwsLOsMSJqwufAy9ODaVbtkOcezxmCT8gfDGUkDTWi3lgNYHWOTAkRK8cVj3
	 3mkgjUNzGRs3D5DCyLQLT+Kv5TIIGloyjD2tilC4pRzar/vNTJRFxVXmKuCI0Xk7+y62S
	 ymufirKjDoMUdDOLvqryw4DpXjRdCNzRMGScPuTuiQQoBxBlqp5H6HWp5+yLfN0OUPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F84606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63F84606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so1450923a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794438936; x=1795043736;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ib3Jyrng3eMRwPlu4vvYbRPIULO3xoAFugNEwMFenwk=;
        b=V+tjNFTOyifbWQ1QZfZ5UIV6PK06p4zquTaYIlFs629szV5qryPL7AkDnJ66s3pZV2
         RVfg+wtg+y65aysIFwPOUYxghqpBcUHpYURnP0/HM8Kt50N59GBsbKJTmDDs03XFpkrM
         1sE6KJjng05FH3/+8XqJ+ywSa28ADxy2VIE96n36NaRFTfpBWawqtVI/FkseWDVGlduk
         ZlVxtnAmJt+vjK9GZWOhk0jhiTeI5I4lf4tVYj24Ycl4HwUHdhzFVF8CjupurioO4fW9
         /3YFsvDGE5NzpMgljkthwu2FGcpOHk5N3ifiMKDuV8qP7vgjK/HdBKqOdnrIesNJAFVy
         g3pA==
X-Forwarded-Encrypted: i=1; AL+hErGAV/eaiNWHJwQAq1akp39gMahSa4ronsq09h+9PTDSShizYzOMw9WRlshJ+SxNDhtzugHfWBQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+48t0rCt5Jk30dq7AcT8DAl+AAf4sD8wCRsAQJESP7Ez1hr1NJ
	XyD1E8j8CD5P7/rIjK1n3DYfE2WR3AjziLGsC8rrbNO6aOpoctO/BHvH9xszdUT2
X-Gm-Gg: AYBFou1J142MakYnsXiWbz+A0ZbrBOu9mri5k0rohePS2Slt39hblj/iwKH41eqBeCG
	nN0UwEfXx4pMqGcVYGPHXZTbB+2e4clWPWVmi+R0YAxIC84izgIsppea/gmaCFGEWmRAGYt6Kum
	nWMZLC/rE7qEU2uUvsovv4ntcxQZG0LhHqPauHHiUBC2eO6KWuROka89VRD96JoVOhwPJbQnYJW
	xX3bx8SX1q4Gry+1tb82HuiPLKf7jIS4mMGSY+5LzTpnS7AD8ycTK7xc4vwTS1V248CaigWPNNB
	8H6pMIGRjos14owazsvKDDwaxg4BtTycpk+6JDg/bUhEq9i5viHRQUy51oktaOgASK+v7hayjyz
	gGWkcvXpAzR2kjLCSAo0jZmyy2o4vwCDGPW2Tz3rskas2GgKfPg5fHWBqBrlP2ntn1aJP8wnOcp
	ZT9oJb6qBHpd7Cs6VWcwKdv7y0fWP7xOa7iJYIkzSSpkTgMzGpT5ltSvS9ZWcCMHZouW/FvRtV7
	O7WBAFGAQo2bEvJu3szN/RyJWLOJA+B09ZJ5ISs5E2If+3hj2ak76Bc4F3tkUaDQaQOaBZcF77+
	JA41Lvs2yHjC8FM6cMBxiFSfymszs43Qz0SD3ykPUoAGf7ikQGNEtmwPy4gOVF9Vp5igYFJh3AR
	LTfis36JT9cJg1HuYTBjWiFmnZfEuwpXCwolGeNxR4PDi0JM3agkcQD2crMtuwQ==
X-Received: by 2002:a17:90b:3b84:b0:3a0:abc3:afb5 with SMTP id 98e67ed59e1d1-3b182ef35a3mr3957823a91.34.1794438935576;
        Wed, 11 Nov 2026 15:15:35 -0800 (PST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com. [74.125.82.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b181beffcfsm2514511a91.0.2026.11.11.15.15.34
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 15:15:35 -0800 (PST)
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3acec6677so5517629c88.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:15:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGIwdWuOrozfn0HAFBuzuGCda30fbCFuCli0GEjoN7TDjstSwCbD9wcyuPygJ/s1KKZLmEAO5Y=@vger.kernel.org
X-Received: by 2002:a05:701b:4301:b0:1b3:ae7e:c1af with SMTP id
 a92af1059eb24-1b3c02fd90bmr3524170c88.14.1794438934098; Wed, 11 Nov 2026
 15:15:34 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-b53-bpdu-mirror-v1-1-f9f32e9d25db@telaak.dev> <CAOiHx=kTUBtFVgFhNqGhP135CdUmK8imCE_+pdk7qsdZKMqByQ@mail.gmail.com>
In-Reply-To: <CAOiHx=kTUBtFVgFhNqGhP135CdUmK8imCE_+pdk7qsdZKMqByQ@mail.gmail.com>
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 11 Nov 2026 18:15:22 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ5mZTXQK99jv9-n4cRk1GfQWaJ+SqJWRB9UFuCcjJ_v0g@mail.gmail.com>
X-Gm-Features: AclHuK86_0OUm-XrVyjZYS_UH-BHfAyNuDZEiDXCKmytJxx7toAduKngN_4CdEM
Message-ID: <CAPY4CJ5mZTXQK99jv9-n4cRk1GfQWaJ+SqJWRB9UFuCcjJ_v0g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: b53: mirror BPDUs to CPU port 5 when
 port 8 is not a CPU port
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonas,

> So on your board only port 5 is wired up, and port 8 is unpopulated
> and no way to make it work?

Yes. The SoC has a single GbE MAC, wired to port 5 over RGMII, and
port 8 is not connected.

> Have you tried a catch-all port 8 egress to port 5 mirror? If that
> happens to work, it should catch any trapped traffic. May not work
> while the port is disabled in software though.

I tried it on the BCM53125 with a host sending test frames into a user
port:

- Standalone port: without a mirror nothing reaches the CPU, not even
  broadcast. With the port 8 egress mirror everything does except
  01:80:c2:00:00:03, but only with Rx/Tx enabled on port 8 and its
  link forced up in the IMP override register. EAPOL sent to the
  host's own MAC does get through.
- Bridged port: the egress mirror does not catch BPDUs, whatever the
  state of port 8. The DA mirror from v1 does. 01:80:c2:00:00:02/03/0d
  don't reach the CPU with either.
- IGMP: with the CPU copy bits from 3362cb822ea7 set by hand, reports
  for a group the bridge has offloaded reach the CPU only with the
  egress mirror. I couldn't test MLD, as the board's kernel has no
  IPv6.
- Both mirrors can run at once. Bridged BPDUs, IGMP reports and
  standalone traffic then reach the CPU, each frame once, and
  forwarding keeps working.

So for v2 I would set up both mirrors, enable port 8 and force its
link, on all dual IMP chips, and refuse tc mirroring with -EOPNOTSUPP.
Does that sound reasonable?

Joseph
