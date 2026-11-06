Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998790;
	b=fyVcwxW9uJEJGVtC/oGCuz0dYDqG7XP0Ob1gwRklZuEX0Fmviu4Xt8V79G4OjMtnj8T8
	 unP5lHTdboO7SD/ZoozsKPuHueys0PY+t+WdMR9U6P+KJcJ7+jwKcdaSKlsjJU7BwkXCY
	 eVw0qa9isy6HOkeCUfjV11NVtdzT1sLSa9/OAePKT0xdnw3yCv6/aTv2ryljsHIw1RdEz
	 pzgEdWOw6PHAo4yy/UhRQeVEh2wZuY6cf1Wzf0TZtxRjUkE0z0G3UMMblQl76RGeygi4S
	 OvvZN+GmfvcuIEJk4SzqZ1QM7NvHk+lmAt+5+CwYslE59sHNZ2EGKg/GncmtKtW/lGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eK9wS1PQJuaruDa8ED9WMpeIWcZDcL+VTSMog5FV1LQ=;
	b=0nYvbcqeTeFSdxaR+uuTiQsq2pifMhodbZd/S9hAO8RChiZonlze1kV7hYsiwjOjUzbM
	 x/HHx2HGUD9iey2z0sJ/C1373Y3Q4GmVcrvJfSDachbbw36WPM/YgOKd8ALdrrKzQLFLP
	 YB7ntIShVhQJ+epMmNvA4tsia9b+pTv5qlRE8zSZmVWgGkcUAlrU2uPAIUayXOuDdM5gm
	 eN6/9br+xW8iCA8qEyi8fi49hVxK7qQhumtpbBefK66ZVo4SEeGK/ZGqYdsqJdmf6jWB1
	 gRyQe3rff/fGV4z4V7iG6kyhdJYbJ+C9RmoTPFxy593wgBoi0UDQgS5zqHQbFUDmeJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Cwf6HK40;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA8606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 20:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1FA8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Cwf6HK40
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4ceb15dfd7so127896766b.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 12:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793998788; x=1794603588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eK9wS1PQJuaruDa8ED9WMpeIWcZDcL+VTSMog5FV1LQ=;
        b=Cwf6HK40lU7xC/Aq+E18OIAD4vMigdTT5o4cMnerIWvLp6TYoR4YiZDzRFG20v5bTY
         lAkRSHgBUUdyqkv8ESyzn9pkoupsyjlBLKAy39kY815zaoEuP8x3vYIGDHvSQD9AaLLi
         Ld/1vpDC4o4/INtn6eIgliShhRgPntP3gl6fR8v/+aPKjExsL7O69vz3BNsiS9p1EZn6
         1+Ca/O5dqSuQqc1ZDIhf2UxNI2VA36XwpJYr3orF49JaaGa4jjLCdr0tCsm2ZFre4sjJ
         UzjfZUVNHr+q/guLz9RPTQ44F4/mNcwG4YcJ8zfDiPaOC/4Sw5dZmVxETgTeEgIvOGES
         iSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793998788; x=1794603588;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eK9wS1PQJuaruDa8ED9WMpeIWcZDcL+VTSMog5FV1LQ=;
        b=y0GZPjy67a773C1rC5i0GQWCBX4xCULzBnqo+k3PJUR8FDleW/t/oz9i0+IlwKZ5VH
         28lHhHdD1mPxnGP5XvVeSKk+wbeki5v/F7gTNACA9H5n6skvFTq6K/7e/NRXEup3ELGP
         BY+gy0NWmY/CKt2TDGWnGehTY9yJYfvDOZEHuRz40H5ap5QGic2c1KWpezzbavACfzw6
         9Cyq2BAa3d/oxC/M5udjpquK0obS9Y8JYBJp3cSkr6J5KTVbJ0KuFvSfJ+4RpjPZDllW
         odjglB9sX0OVPuc9j5nP0ISO/T7G+xAdLMYTO0dMpjYnvBHW5Z2rQ+7zeAP8df34V272
         wbuA==
X-Forwarded-Encrypted: i=1; AL+hErEFRvCgz9W4eyCr9QSFj/x9U/yqBu6q2UftlpKP1vt8aL1Kvcb8Cmgl6VpSZ11Zh4HUpz2YflQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GWnUggH4mrin2grEq3ywkY9di9noon25tAsJhb1A7YIAWMGfI
	xNo45YuPQTONWhUE5xkmfmtkt9llvYQyfDBX9HktBHc5NOaYObDo2UhhgSKg+Brr8Jc=
X-Gm-Gg: AYBFou1KI4lHMeXBLwMg1SUu9LS/WD4CjUGbfQ/2lTuSZ5W8k9fZ+8X1pf3ox+QHVLR
	Zm1KD35VqcWa9OK+TVrS342RczrXC9iizrV0+kCLgP3NC2rAD7f9QhHz+dhoCbr8aP6DWJrplsd
	kHqRG2q6HdDZk4cSCzTKF92um8/7bQC0GmoJ0qKz6hGATdDWXRAIYeQXmU0eTnOVjx73ijhWoap
	Lz2PWkSbXWc9lUUlGb1wZbTKEssaBNkdM4rjnH2aU5+FdbT8X4dnznTO4suX7BpG2QfylVesX34
	AIYbychNszfw2jS8mv6tcg2MBNedl0PAnbZK8AjOCI+eD1jqKmkGJArxb8rFpuV8xcdqGav93nD
	D/embp/RkHhRRaVQ1Yx5i6l9QYhkqwUJ4FDdIcMqTGxLhpB/WL8N9Zjn71GVyKXD8LFJ75tTagW
	zCk0cSs+qyb6z67nVc6iCKCOXZoYloXpN5DGYZSqebJnEmtADJViOlEagcTSkgGwFAPzemV+1vs
	Ibd/YK/74C6J8+oTPzYhDSilsSimaAMla/5QDt/K4L3R4CgwUz5TkaPpJ7h9vwIlqFm7zXefIwy
	dOIFcwbbkxl3kD+AEiN8kuP3iL0h4m5yAf5CZPzoqUsMrhJeLeLIsrjQJlTt+6VYpxtZZ7ueefr
	KsiOXxu3n
X-Received: by 2002:a17:906:9c8a:b0:c4c:b4fe:c9e8 with SMTP id a640c23a62f3a-c4d35505ef1mr307307166b.38.1793998788172;
        Fri, 06 Nov 2026 12:59:48 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3562df86sm104305466b.24.2026.11.06.12.59.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 12:59:46 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: David Keogh <dkeogh@amazon.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	David Woodhouse <dwmw2@infradead.org>,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Alasdair McWilliam <alasdair@mcwilliam.dev>,
	bpf@vger.kernel.org,
	Nimrod Oren <noren@nvidia.com>,
	nh-open-source@amazon.com,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [RFC net-next 0/6] net: configurable extra TX headroom for local egress
Date: Fri,  6 Nov 2026 20:59:39 +0000
Message-ID: <20261106205939.95366-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <au4j2nQdOwr90ffh@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
References: <20261015235335.4162993-1-dkeogh@amazon.com> <b8914a523b4a6b80424c5001d3d8012c6a98fd04.camel@infradead.org> <bba453eb-769e-458b-88f7-8cc9bcafc1db@nvidia.com> <a8f2f84e-7dc0-473d-afb1-af710d621f69@iogearbox.net> <atW00dwVpYS4WO5a@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com> <au4j2nQdOwr90ffh@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Hi David,

Thanks for the review, and for testing it on x86_64 and arm64.

On Fri, Nov 06, 2026 at 07:00:42PM +0000, David Keogh wrote:
> Tianyi, you have a second use case for this: an XDP program on a veth
> peer. Please describe it here, as it bears directly on the points
> raised above.

At Cloudflare we run some services each in its own network namespace.
A veth pair connects the namespace to the host: veth0 is in the host
and veth1 is in the namespace, with an XDP program on veth1. XDP needs
XDP_PACKET_HEADROOM (256 bytes) in front of each packet. The packets
that the host sends into veth0 have much less: 2 bytes from a UDP
socket and 64 bytes from AF_XDP. So veth1 copies each of them into a
new buffer before the program runs.

Raising needed_headroom on veth0 is not an option. The v1 cover letter
has the details.

> I suggest you post v1, with patches 1-4 from me and 5-8 from you, and
> the cover letter under your own name, since the veth XDP case and the
> new measurements are yours.

I am happy to post v1 as you suggest. I will fold in the points
you listed and post it on the latest net-next. Thanks for the TCP test
as well.

Thanks,
Tianyi
