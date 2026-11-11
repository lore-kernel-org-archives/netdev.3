Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416482;
	b=EbFFbOv/efCqg+Su8intT5D5bc7xc9twLXl4IVO4le7C01pkvLQa6qE1HP5AldNFoE0s
	 vQqLKGQ25AjkZ8cyq/KBwbS36409HW4u92X3jpyp4N7pnTeXpOCegnJXabmtbZWz+0vy4
	 ricQDy/cW3rTBkTTPm9vvRdYOHoFGqqTcIAYCKw4o9jan/NbkWUuSfOgnoYqbeXtrclVN
	 y4nvWNSSDBLmzBVvlAK2EXLRA9IPLPrKLWyGjYuju+/H9PhHltxJQmPDCQEII1XoMU9l8
	 NmkadYtjGjm2hdGQ6UkzC3AUjttyZge5rSOL6eh4TTTeRyWvzg6rudiJ1WdqTZros6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=cNJr3c3uqZZVhSfWEr07FcVM+B83XjBK0ipGpurD8/w=;
	b=RWcvCPC5bsXAcZQ9MfQj2DPSu3Sadev11OO07m9kkEjmjA0CGrcv50moXnbVxbbLmz0W
	 CFzeSI5hkqWtvqytkwQZdkFKyTAw2oKcjsyhzIFSt4jg6fqwv4ZW23UakEsn5nR99jq3A
	 Rmc5x0+Igxt0d/i6kfjDfiK05hO7WBGFVJvq8214rQEHiSy2aHE5mCG42Z72DGj8ksZ4G
	 baRBIW8jRKlPdjlFsXVbmkNc2HwWgYR4FJ7J1kWyYNzJ/XMODfKO8ymweJiUFXp9TTVrk
	 s7z4Ju1Nb2WXzCmOiQq+rdc0w+uchuFumtQN6SNxhYoYIc89FZEgO/J7fXKyuu69dBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eV24wG6k;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73141606A326
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 17:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73141606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eV24wG6k
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-78fb1fb9508so18888137.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794416481; x=1795021281; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cNJr3c3uqZZVhSfWEr07FcVM+B83XjBK0ipGpurD8/w=;
        b=eV24wG6kUDKl/1BRzugsFu4O6Q8IMvuBMVX/hw3IwA8m/Qdq9KxFfGNdIwU/1eK/S/
         ryB9W0aiepskzNkxFtuLuS1B8mDbwU0HwpPUMSHmC1vGEAs3AcwgrIuW2dj/HE+iOpfC
         c2D/uE7ouHDAkBbJKtQh2hwdmG3Kxw5BCw6dYMAOxlPArZVX8CZnIRFqD41fzK06ZI1q
         GThZ1b4wU1om1c6zeGKhdtmLDrJKAvlzi1ckauC5O0yIfDFOTVBPJyXqT0g4guj/7j90
         CH18VtYry2bKaO8SsBtHxaYYhBDJn51m9CKVYwR7LJa5RW9yCa7mGQnRL7KBGekkvjZ2
         vXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794416481; x=1795021281;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cNJr3c3uqZZVhSfWEr07FcVM+B83XjBK0ipGpurD8/w=;
        b=u+itHQOFJJyGLNdUSoPYhQIbeip7hfN0L/0WdZDOYXEAFnWNsQqo0NbYqWhXfKv63A
         ZA7eGeXdCYmoJGmY49EmMwAPQ/JzXGKz40tWAIVG9oHpUwQU2CQTS42vKgsutt2hmfXK
         d5BScOw2hJ0jiayIt8K8ofWPIyEFXLCnyx7OLsRTyLtZf6hAS5UeYzN3l4rCuf2eC+7P
         pqZpO4V8pNMjIkgLJnAEizH3LGEb5YtaB5Ld9/4eiJnAWKWR+S5/+R2XdnuMmkgPS5Kv
         5FB0bqs7ZNQk+xyEPRASj886TSJGhyQgSOZZ+9R8zGIztL3niFj/KHnQ/1dlieWK/0yC
         1cTg==
X-Forwarded-Encrypted: i=1; AL+hErF8J/cGGlaCpt9kS49fHbp/TE1ouuNn95XVFuwLFZYvwZL0m2KPzp2JPktoEgmfOpB6B6AdLlA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5CvyUYPQ+Qo/HDuA3BNFqQrEfgP7RyaUOGOtOJMzJAuvVXf9z
	LrH+EFnkR+DyMpZYGthragM0tbEA3dSjlFqWaAEkx4+X02UIMdxZCKOm
X-Gm-Gg: AYBFou3IZq1wd3Pf9LL+JATNADD2fJQ4tKbp5jabqf2W20DBzgbTt3ZVgDziGytSIA4
	dLuIQd+PDyF5sqSqOYJyS+gec0G8szLIq3fGtSZgi4VO7xuMlciVnwnLSAbThPCINOEbAXyY/DQ
	J3lg73KC+GZFJUwdg48v0+z328p/UqvKGtWiaIZNureCuI4lrzphCxB2jUCCFsczVUp7/OolMI0
	z/JJ7DlnsFSeZgLf95Ee7ArlsU8Vsji4hXDvi8tIrSSdb4CqVCTNhMycyQ+pDJ1XPfA5SLHBcvm
	5v8QgpXz5da/bcb8Uvn6zTHpCaag/CBuE5l30n7t0LHZnRQb+yGtqaJ1dFHGOZoTnSeykSO23uw
	Xpw71CzIyqU/7O4j0cafUwPdok9VlcodnI9gR3x4zWb4uwDov54W8PJeGaMsD0Qilf6BDuD/7uu
	dK7Nc9lCCrJ1gdyAxk+LcS0CyRigtx0AgQfAOnKp0Cv10o/HWBVbzKRn5UccbdGKmu4aMJkKA4i
	KpHWL4VVCut3V8I3GHIvtoV5yieYdJ1Y6qgW9melUzYuKfG6XD5txMBUVuMuc8C2UZalg8eZ+yc
	wCd4JHGUJfPPNR1/
X-Received: by 2002:a05:6102:a4d:b0:7cc:905a:331a with SMTP id ada2fe7eead31-7d6316c856dmr19138137.14.1794416481052;
        Wed, 11 Nov 2026 09:01:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::6:868a])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302239188sm4078178137.2.2026.11.11.09.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 09:01:20 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 12:01:19 -0500
Message-Id: <DMSJJY9PLHSR.39PSNUXEC82J4@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?=
 <bjorn@kernel.org>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Daniel Zahka" <daniel.zahka@gmail.com>, "Donald
 Hunter" <donald.hunter@gmail.com>, "Eric Dumazet" <edumazet@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Jamal Hadi Salim" <jhs@mojatatu.com>,
 "Jiri Pirko" <jiri@resnulli.us>, "John Fastabend"
 <john.fastabend@gmail.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Paolo Abeni" <pabeni@redhat.com>, "Saeed Mahameed" <saeedm@nvidia.com>,
 "Simon Horman" <horms@kernel.org>, "Tariq Toukan" <tariqt@nvidia.com>, "Wei
 Wang" <weiwan@google.com>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v1 00/15] psp: introduce socket-less
 associations
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Todd Freed" <toddfreed@meta.com>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261111005533.6436-1-toddfreed@meta.com>
In-Reply-To: <20261111005533.6436-1-toddfreed@meta.com>

On Tue Nov 10, 2026 at 7:55 PM EST, Todd Freed wrote:
> psp associations today are bound to a tcp socket when created. traffic
> on that socket is encapsulated in transport-mode psp, and encrypted.
>

You can start sentences with capital letters in cover letters and commit
messages.

> this series adds associations which aren't bound to a socket, which
> allows psp encapsulation and encryption to be applied to forwarded
> traffic. you can use this to transparently apply psp tunnels to flows,
> with help from userspace to manage the tc rules and orchestrate key
> exchange.
>
> the lifecycle of socket-less associations is managed over the psp
> netlink family. socket-less associations are stored in a small registry,
> and are addressable by id. the registry does not contain socket
> associations.
>
> socket-less associations are on the device's association lists, like
> socket associations. rx ones are therefore marked stale by key rotation
> in the same way. in this series, nothing acts on socket-less rx
> associations on key rotation. instead, userspace should replace decap
> rules for a SPI before its device key has been rotated twice. a
> follow-up will bring enforcement.
>
> series structure,
>
> 1, 2/ prepares psp to work with non-tcp packets
>
> 3, 4/ adds the netlink commands for managing socket-less associations
>
> 5/ adds a METADATA_PSP dst which carries the socket-less psp association
> on an skb for tx, and the transmit checks for it
>
> 6, 7/ keep mirred and bpf from sending decrypted skbs from egress to
> ingress, since skb->decrypted depends on direction
>
> 8/ limit time-wait psp socket validator to sockets actually in
> time-wait. the new psp actions check for presence of the validator
>
> 9/ adds the act_psp tc actions, psp encap and psp decap. in software,
> encap is egress only.=20
>
> 10/ adds flower matches on psp header fields, for rx matching
>
> 11, 12/ add drv-net tests (netdevsim and hardware)
>
> 13/ makes tc-testing run dependsOn probes outside the test namespace,
> where they currently always fail
>
> 14/ adds tc-testing tests
>
> 15/ Documentation for socket-less psp associations
>

Some of these can probably stand alone like the bpf decrypted, psp encap
helper, and timewait validation, and be submitted first to shorten the
series. That's just a suggestion though. If there are dependencies on
the main series you can ignore.
