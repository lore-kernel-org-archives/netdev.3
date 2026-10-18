Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C017338939
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 02:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792292023; cv=none; b=mGWKGWpU94yrjTl8xxphK3uCVbc7Tt5PaftgmLwNDMQHNTN7kxfTBQ9TfzXkDk6qBZjHcKYVGVGhsc+Gzo8D3+8axB6KX4RcZZcrWWhetKxZqzvhMNpPShI6uQBEwaGNKdWoIHAC5SZOJyGFdZBNfaomIcFRoT7JamUefiFAejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792292023; c=relaxed/simple;
	bh=bBj6psTg0atPzJHuE/vK78ETes9bC48NNTa8QuWS9mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=in7DS/aHMLux4CVfKkIscVgKeK0sPqFq8S6sgXwU7WCboHHuzZQx4cYM5V/Do4XDnUOrVBWaMCry8A/Taf2E6XMNuBIKZ4JHwT9KaHARPIburiXvl9BXc1mrm+JgpmNFeHaPOXZJlmpNN/IeubuIuuY5sWSpLY5teQsH14qvfIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=G33JtO7H; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="G33JtO7H"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c40447e25e6so118526866b.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 19:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792292021; x=1792896821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bBj6psTg0atPzJHuE/vK78ETes9bC48NNTa8QuWS9mE=;
        b=G33JtO7HX1NIgkGhu7eqsVgRYNtzUYO2lJwKSOFS9D9F0duSq7RRJx2AAjKNiFNxDS
         cDL4OUX89+tSzNMux9OPBrN4JzZFaFmAeKy+lP4Cym+3Wb94d/v1YCcrT0YAXcrEdh3A
         wszy++el4FHMelOjSGFHsEl6ejjWTGcn9UXdFTggqFwn113CN2PrgVlmC7ZRWeSyOKBH
         h9vOMpvrsgHQpxVrKdpU7btFYR8tn7ng+vcI6WaU8I7zgp0owF9dN6EHwWWM2jIPEAUw
         fkA12AqYM2czRY+g07qXlbrB1XiJTm72Xyetd7+3RjZnrDkwjSOzZ/Lkjckj+nbCwi8w
         qWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792292021; x=1792896821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bBj6psTg0atPzJHuE/vK78ETes9bC48NNTa8QuWS9mE=;
        b=tV3BN50VVI/TXH6/f/o4IghM1PzZksbT/Rf3DV3kN+ajSdu0IZczxyFmgeE3rrcZVZ
         Em04XuKG5WVwOEVT+QMQwU/CuahhmVSb6vL/TbNKaOgKXMvtIodnFAJjvLHaqyDNey8k
         upwnEztGBSJXSwax0Jj3TTY02PbZ3ri62ZjKW5bv/VsoGde3lcrR0oKTLISLzjLXlQur
         qjvMRXPqM8hwvjGt2fEqXysrfWk/SRWZnwvvYwtxdQXFM4A5z/30BjMAN/U86qrh5Dl7
         p2S2XbdFU3WR1+QIH1sx31yoL7YM2qzbvAv3SG4TOats1VmAtQPrXpgz/6UO5SkNi/CT
         ZnOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCFvl1IbZK7GsKAA7ifp5bZA6AKYlGV90jBpgEyXwORkhYNeCCCuZgCdgl0ovGlLGFA2lilzM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJunAQSjAIMlWuIyXUjWQ5RiQYXsl+9vU9QjHoM8jjj4h2VoxDN
	GbB/77Atj3ztYlOfaY920OD3a1rVHBZb5U2sl3XwWP3bHrGjrsxYaFQTYn56H0vNCQ==
X-Gm-Gg: AYBFou3+SyI6DETJCjQlsNCkWmU5OVciUBlc+OwhwgLUd9Tv5pUI9dU25N/iSPTZE6G
	WO/6kOT0E8tA6MllZV2pna9KkYVbukXXnTHmaKAlOZtZyYHs8hY688WgBvUA4tPqtnyHq8LQz2s
	fDAwWgkDnZb6RoQdHpTdiVv7Bl1Maf6cpsToc0L7eaQ6qlQIps8oUdbikn4y2JLkWUHDo2605rc
	kkiTz3HqEUDw3j9sEP2t2ZIE1Ofm/R9vX+JfcXfDc1a4hkqVz0DgHVjWZxTekm8j8MMlf1wfcaU
	1JVJL6MQfbV4imym2PoPNI+bdWEGCkX3dNTHumxQiXxO+ZtrnyCSeyj40RsjmfSeJ+Yv82jL8M/
	/xccLUwaM2HwuO2EKaxikfrQFnsuiX0lk4TRhU9r0qNcIe0ULOQ0CE1TQyt6/6bblgt9Gggtd0o
	J/nigl3RL+TOzOqHPe/nraUKhk+thA/FyGi29lFJp+h1pJ4dwCuOBKtjPn334dlQfLNlftSw+DE
	wIGRgWo6iKPVBjXnzdIqho+ZHHHV4NAJS4wAVSU9BqXbYzrznrffcu624dYt6wmYdoaAM+/KPaH
	NYhGxxcfW9bymxu9+jtnVRKycDmOWUpPAYoLgngbtnSDsPeSUJBzRtN2FxD3O24vhKY92TD3NVV
	D8bTl+VH6BpN51XOAp8XPGjzFVawKlsKrNqn7yu7OhLghiDrJKasGnNm7HqfdBErbgJYcfWCtch
	DhrPCdSH6q+v1VmmW2DTTdG4DoOwSoxFwE0xVO2+tzoVzewV03ys0zAxasECDVdG3ztXK0
X-Received: by 2002:a17:907:94d0:b0:c41:285a:46a9 with SMTP id a640c23a62f3a-c41a08d9fc4mr265085666b.46.1792292004094;
        Sat, 17 Oct 2026 19:53:24 -0700 (PDT)
Received: from Desktop.fritz.box (p200300f24740ac10545cfe8be1a407c1.dip0.t-ipconnect.de. [2003:f2:4740:ac10:545c:fe8b:e1a4:7c1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4090dd1130sm227219666b.25.2026.10.17.19.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 19:53:22 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: pablo@netfilter.org
Cc: netfilter-devel@vger.kernel.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nbd@nbd.name
Subject: Re: [PATCH nf-next 2/3] netfilter: flowtable: update upper device stats in the fast path
Date: Sun, 18 Oct 2026 04:53:19 +0200
Message-ID: <20261018025319.1445197-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <atQmpPlfT_DSd9dq@chamomile>
References: <atQmpPlfT_DSd9dq@chamomile>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 18, 2026 at 03:53:40AM +0200, Pablo Neira Ayuso wrote:
> I mentioned it is a feature that these counters are not bumped,
> because packets are not passing through this devices in the bypass.
>
> This allows users to see what packets follow classic path?

OpenWrt users report it as a bug. On my router a 268 MB download moved
0.15 MB on br-lan, while the port below it counted all of it.
conntrack already shows which flows are offloaded.

> But if you insist, then explore a way to synchronize these counters
> offline (ie. not from packet path) to see how it looks like.

OK. The gc could add the conntrack counter delta to the upper devices,
which would also cover hardware offloaded flows. I will try it
downstream and post it after the fdb series.

Julius
