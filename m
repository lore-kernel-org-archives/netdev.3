Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793551625;
	b=PuXs4icBBGdEiAo14Ig/oT7DBZFmDkNNITcWXe3zaDbd9Bq/PeHpw2qIJ06hc6OzyQ4v
	 dgZNeXOb9xZIzxBSMDiOjBhU0I5n5PHMyH/+SciVgSDdYKMr7O/Qg2+Xx8cCrIitlyHFI
	 Bg1ZSspmKc6k32KOtb2p+xOia9jfSuqwDEHgGE8zH4bXrvU6YErjKr3EqOHr52Gevc4q+
	 QwlbJNmhQFKpwDYBSCu1uZrWgzN8GodFJudiyHVM+sineIwKEjuAaG4rcqqV9Aml6cqX3
	 iZpO41KN9jcM4sHx3H4LVP+GrijRBB9nKTqVo+DIKG+ebXLiJ5BsU3wO3llwybamE9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793551625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yCpDQ9WkrXKZMxTqAyMxj1pgluHTummJfoylPYQEKjs=;
	b=BXi0TMSDOZ81NWujpPBkacJl7M4VwNqAuHkldQ/qwLvz59Ur5GP6sdRLnzc2tg6Ri5kO
	 g6mhxdMih0Wk1NB6CKvX25bQLVL6KNyLKltVpzLzmetaqoR6C5w+OwOc2W/nxwhi4E+Oj
	 +P4HbJfCUWzndr+LP5OdgBJ5AlvN1gZFUyeFeMIv0oTWuVrzSFIgiLabxgUTFL2TSGGzu
	 V/9jqb5CLpr8QFRAvTjR1wcUXN1Ozh6jmFhbdj0BnRkjlwAGURy0vPe/4yTCDsUV0EuJC
	 JCVTbIChiC95Lcg38CLw+3pSIlnZ0wT55D69dssq6sNL9z9a4Teekmm6ZCiJJJmPO7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=bLMS1MgL;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B919606A33A
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 16:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B919606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=bLMS1MgL
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so2875255a12.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 08:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1793551624; x=1794156424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yCpDQ9WkrXKZMxTqAyMxj1pgluHTummJfoylPYQEKjs=;
        b=bLMS1MgL33QmYJJZIpB4ajm+NZ+eU6AmPNtEFyOZBbZNN7BZa1Yu29rZnVHcF7n1IY
         EZ1b/nOWDaFwrJ69PnnvvS5Rr4eSaHM0cIuql4cr8BUTxtOT6py1mUGBu92y+XBlBUJt
         8ZO7RdkY25PlK7SgiG8y9wgXDY9kx+onmRcTynIkvDCedq0mzazX048IOYd1IHVvgBze
         1pvDzFVKQbvbHDW6S/FCI25uv5G/0NjM3jWXvyz8jB4eAdzw9+l0OuoXx7xPC+8A0m7S
         mBprsTHYaO6n0igll1j6jlqWCXlrsjweaZGlKkjLdK583BnS9n4i/zrfB2oDeBwUzRad
         kwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793551624; x=1794156424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yCpDQ9WkrXKZMxTqAyMxj1pgluHTummJfoylPYQEKjs=;
        b=Oh1Az8c7pyz84Wz91rk4zIT8GfJXS0HgEh5d/tR+YC4pZPThp1CGPpI5vnQRlDq/KV
         wgEgvINDteu94UTNouvwVQgtHz09tMY+se+agY2mIkPDp5X0YyhM+rLMR4wHUKiYZ//q
         V5zo+PL1n4kIqUQVSqWO/1Cf5QMX21oYjCbsMzuEAX4zyhzkF05f+yWiKQuQJ1p0sRKH
         0YiCqRXXl0MTDesVtE+oD7xtxS3auS7mxQuUwPMLvS3HGi6V2F9ph8YYL5s6f1lrPaBb
         kcdZzre0tOWa4/XidYb/NcAedxAO8/xBqesCzXPRbeKNkmnqwDZmczDxUS4/Zz5gup7l
         MGYQ==
X-Gm-Message-State: APuU4Z+4ebFuVa00WfPbhXcx8EwDGQoe1UTX3D0Okncs1jpfTv6HBaCs
	IhtWwVdwzO9QLuCHCuBO3BbUGdLOeE5bhmtwQy5ul7DSg5im7hbcAikRzWh2bJKAFg==
X-Gm-Gg: AYBFou1L+NRmHQtmqQGim+O40rBObuEsSxQh4Z0iwuW+pvQWA8D1tWTP5/6E8kYxlia
	rsmdzha1JjDqki8n+uvOTDwAmUc/xgt3SLwlzi0aUc9auwiWkRxYwijq34rAU1DZPwzvmNys6ct
	n7vDLlPqUHIUdGWV9BYeM6vu4vZDRUUc7b9TwcHsDk/xgCjtceY9wbhfW/orxW5b6CHOXOUlgEB
	llUkF0ZrvI0s8+U5vECldmgp7kONKx/00QNMPwbNBw5XyEXv9+1cyIxBhbrhIgk98IihYev8c1l
	NAhpq3oXLoa86kJfmyjRks+xp7MIn1qdcbV/Pe8pYpkahhox2gUz6t+zyY3+KeASKjxNueUxw0x
	2BwaOgGDhRxcvpoJmPZN2Gva+0T0lAtj6P4uxfALEbEftDIKgd3rIQ7evfTqTsU9cDRoOz3puFK
	noHRONn/jBZSS0PQhkIVIq6MpBQknm9BgyQbk3GSc3TQLDNgzRObqB/PmPMt2fovDoRCbHHvJnz
	Pk1VCAjv6ySWxDpjQH81AFrapRpFNUVU0DUDWS7c/vBtXnpMTlO9oxBUryL4+xmFgMxqbF+dyhI
	56tTjgcdiycjbwcM2awyYBH0t0Lom05vVPAQ2O3LZY5EYE6Lk51Z2sizt2m3VurCO9XvKoik4mO
	W74U6NrL+gJ1DWuRLwUXFewMmobwwdeAFgegE+wdSStvdKSU/TVsysAIa7oVPZ9tXb1ksjCxjU4
	aW+jJoigspo+9hFECoYt0QGzj4zGF4mAptOAY0JR/PDJwZldBhYIwCqCJLKWgzzZwwuEWLl++5I
	4qVCYusgUsI/q3Krxzr2eAQyE5qhjADrzs8WG8EHHxWJgFMX2UTifjWpb/O5oZicdlcdUsqcDWm
	I3N/NBFsNauVSH3xmSVd
X-Received: by 2002:aa7:d0d9:0:b0:6ac:5c83:bb9f with SMTP id 4fb4d7f45d1cf-6b4d46766e2mr3892238a12.9.1793551623964;
        Sun, 01 Nov 2026 08:47:03 -0800 (PST)
Received: from Desktop (p54aff790.dip0.t-ipconnect.de. [84.175.247.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4eca0f376sm2371052a12.26.2026.11.01.08.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:47:03 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	willemb@google.com,
	jiayuan.chen@linux.dev,
	mfleming@cloudflare.com,
	almasrymina@google.com,
	bigeasy@linutronix.de,
	richardbgobert@gmail.com,
	ecree.xilinx@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 3/4] ipmr: set up GSO state for tunnel vifs
Date: Sun,  1 Nov 2026 17:47:03 +0100
Message-ID: <20261101164703.302017-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179241582899.3135.13813714752467284187@kernel.org>
References: <179241582899.3135.13813714752467284187@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> What happens here if the GSO skb already has skb->encapsulation set?
[ ... ]
> Would it make sense to segment in software, or reject, GSO skbs that
> already have skb->encapsulation set before calling
> iptunnel_handle_offloads()?

Agreed. v4 drops such a packet in ip_encap() before touching its GSO
state. It was dropped in ipip_gso_segment() before this series as well,
so a GRE or VXLAN aggregate sent to a tunnel vif behaves as it did, and
the inner headers of its own tunnel stay intact for the other vifs.

> Should this use iph_set_totlen(iph, skb->len) instead?

Agreed, fixed in v4.
