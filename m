Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC8423E9F
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790337129; cv=none; b=lx9coD45B+ioZFX1Ixe/Zs40Dwzti2+jlJfPpN0zeAxUZy4VXnwO8AHegFdBdBnKgOnSoMHTmSE9aeAkgFWY+A9oZoacrLMJHQLiyM4HeHKOF6Ulqi2lUTOgNLTYp8zxBfeQPyn3REpItcu2MpzFPj90Z+YMOii8UfABDNFOE1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790337129; c=relaxed/simple;
	bh=NLMBqzMC1vbNSpj07NZ5D9sEF7hljwuw1qge4ogUXI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZazXrHab+7vRaFbktFmkQmkJPsWJ/Cn1SCy1P5cG2rIvS707X/TkQesweuhEyuw4sRi76hXMyf5ykHEMmVQXpSSkvybmNSYQYu+90cGAFQbYQ5ChdF+fKEEX5y66DpzpRtCulvJpYL32HaGWiRBxzbZhoudjnJq7mRvT7YgxgVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=varjosoft.com; spf=pass smtp.mailfrom=varjosoft.com; dkim=pass (1024-bit key) header.d=varjosoft.com header.i=@varjosoft.com header.b=DT0G69Wl; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=varjosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=varjosoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=varjosoft.com header.i=@varjosoft.com header.b="DT0G69Wl"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b8ea203e5bso300640e87.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 04:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=varjosoft.com; s=google; t=1790337125; x=1790941925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zSsqFN4w1HlV2DlahWQXBcRPSYvpwcfnASilh2E/Vww=;
        b=DT0G69WlCxE+9MMX7uTCqSG9jatDWdzbvn9FXBBR1UREAOB6qKYHIRx2UAqHKQPGRn
         kgOyasQitvVgOVFJGFZLBuMm6lakaBdcJ3A8zdUKVlmH0q+E+Uc2Cz3fULxWhRMWcRp4
         HZjz43GlUN6RB2S5TqrmYaMr2S+W8qUU6Swq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790337125; x=1790941925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zSsqFN4w1HlV2DlahWQXBcRPSYvpwcfnASilh2E/Vww=;
        b=j2tOk2V7M1iRcD1HMCdqa326Kof+KFxidii6Zm5qAhh0cl43ZVYRH0j80K3hFP3EWz
         EyFuidJSoeaqaoblXRR8DvNZIIYh/PonC3SpsX+JLuMpkAnuYVaSJQZ14VXGjtn2XNG9
         rMnnXxKhJcMirxEey+OAvsFhW/BEI+q43TqlJpgwUGU+qKE9phA68uuqSOZKjyOeDfET
         CRp0gAPie8mWaqc5rGREEvR3zKzLCQK0LFtznl/weYXleToVx3FYlcWuV12/mdN9n/kf
         rxkWKJLv364lYx4dhTTUimBJhJLoYQmBPLft98jQ1NHIJlzbfkrsRR/RQzCepRVFGDnJ
         ddHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDZuzuxmCZW4Ro0HeeBRE4+UQJZL+pKVgdpGahr1dYlMZigNcquNZb7728AoPgNtA4yYSS94I=@vger.kernel.org
X-Gm-Message-State: AFuF++m72jhIG+Xt9nopzyA+C1e0rBjHYIQ+GSJf4EJv+92S+rbcTMTe
	lBuU2kWj9GgWFAV3nGcrW4nGWEab8fBjXFnNPvvcb+IDzrnLUKrZRCDQwsG9PQPf0es=
X-Gm-Gg: AYBFou3WZYpkDDU6rnCV0hku3KoyAErhcUWO2GnUvQILn7uw8/tzetT6MIDWvz3cTvY
	K8qbpUmAp3Fd9+3J3rT8NDICr5fq1uiP7aa/24k/6zqmixOnmAxIGlAPeb1OlUjmLw6bNQZaKJb
	mhgkXuM4p0kkgGH0XEQUpHzkcetEgNs9zAaRyRiBvTPLVIfhPdpWY1ec4iNTRf1MQSKNPpWy6rW
	CbQ7sSl83siv4W9vysD7WNPGgZrbnljwvtnTBhuTNEzj6lG5P3M/NT+9qBR+pP5ZK6hefQIIazj
	0RTi6tZaZZHbISEsTp6QdxiHN09n3HmvIYCfVmo42Ptk0Pv4AvGOPhhofdPIPPikH+oCGX1Xxev
	u4s8EWpgYwsnoOGYixdUNuAC1aIgrLEGT6bL2ylo/L1s/8nWMd59TrwBeM2yHsl/7+6jRUA8pkg
	0ySSPbLxvX1B7zdWle74ZW8BX+gf5wVyYYJNeJ8MaQ2zUZWssHr6AmZf/xnlmVuf0wvQAuanR1L
	8BsCx9CArSYzbPWbhtvmiAxKlDP2HElvYq9k3Kl693jnT5+rdXLmvriMsugxiuJ
X-Received: by 2002:ac2:4354:0:b0:5b6:1a7c:fd91 with SMTP id 2adb3069b0e04-5b8df0e2abamr1584966e87.55.1790337124893;
        Fri, 25 Sep 2026 04:52:04 -0700 (PDT)
Received: from localhost.localdomain (91-157-138-212.elisa-laajakaista.fi. [91.157.138.212])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8e6afd398sm502024e87.49.2026.09.25.04.52.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Sep 2026 04:52:04 -0700 (PDT)
From: Hannu Varjoranta <hannu@varjosoft.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	nktgrg@google.com,
	willemb@google.com,
	pkaligineedi@google.com
Subject: Re: [PATCH net] gve: DQO: accept TSO packets with non-protocol gso_type bits
Date: Fri, 25 Sep 2026 14:51:22 +0300
Message-ID: <20260925115122.56321-1-hannu@varjosoft.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CANn89iLpkPN=qHkyse=Bdz9WvOgtgm1erL1fn=sYPRE7GSibjg@mail.gmail.com>
References: <20260923141047.14047-1-hannu@varjosoft.com> <179030240275.2160803.7121151150196393029@kernel.org> <CANn89iK7kacaAnx3nTCL8=OrCQF5kyojeoXkWU1Kq92n5gMyUA@mail.gmail.com> <CANn89iLpkPN=qHkyse=Bdz9WvOgtgm1erL1fn=sYPRE7GSibjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Sep 25, 2026 at 4:30 AM Eric Dumazet <edumazet@google.com> wrote:
> Typo,  this should have been:
>
>           shinfo = skb_shinfo(skb);

Thanks Eric, v2 with the reload squashed follows.

The other two Sashiko items are already handled in net, and v2 is
rebased on top of them:

- gso_size above the hardware limit: 296c83b5ccc8 ("gve: DQO: reject TSO
  packets with an out of range MSS").
- gve_can_send_tso() using the TCP header length for UDP GSO:
  83769c23fb18 ("gve: DQO: fix header length used by gve_can_send_tso()
  for UDP GSO").

pw-bot: cr
