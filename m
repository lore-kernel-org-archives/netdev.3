Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45E39448F
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581875; cv=none; b=S3/EJ0ZtwqWmWCNJomvwBW9eMbfQh3NaAVTe+xxbQ3tbofqNcAfewJVrDaHyVHP4KaNyyALaymR2bvA+NkX1utevc4O93kQemOvCECd7vCOmjE1MBqxNubMU+Yn8EwmA+FUjtaQ5EWtaWgKWqSwCCdIa7Rqb/YE8ESKZCjVfFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581875; c=relaxed/simple;
	bh=WFMQZ99UMpZplb7RsBAhDd2v9uvyJrKd1KhsSZExxLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLUEQTxNjlD1BkOtbaUe9D01GTFp9Z3e9ndeIz5lwHP5gcl2XSn9487U7bEJf73DCd4uyHq0oCVYZ6oiJdCe/Vq9bxGlOy/0ZbkBzR1gcaBiZ6UUuFrJhdKUoFtPsyPhZIrKTmzwiMffIoBIoYt8jiZ3B/+W4jaS6sYqQPKo2vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=TDMEy2zN; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="TDMEy2zN"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1419d3416ceso435840c88.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 14:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791581872; x=1792186672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LbJd+F8HdwB4ZwrQUMxv51nPVS5BB9PcOKCpwSnYCy4=;
        b=TDMEy2zNoZPUv16Zqvrc+uT5rbMCmZFayZU8eNiqvlmMds6vJlTrMjFNfegv1mZcVp
         KSn9kJaE6eYE11yEoOrXQulTTXAj9iIB8maBo8IYo7OqxpLp+ejuBM0jkerg6nuCN1d9
         4usbGW5cLooby4C7eYc8OKP1h9p/F1kTdMIGaL/T08Lfc5xdY6FJe/M2AC/8qxg5N5JH
         ATedJ/EekzRHJOjkqGwfb3kZICIxn0lmsJh9f1NBVcsBwjD2C0mscwf1wwx0vGzm5lzo
         fZLeOfw3xyBqpJHQzXf2IdUCrJGb36H4HFCyIztmeJ2bbjZCmljjfNHYWq8D4i7010/f
         0jAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791581872; x=1792186672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LbJd+F8HdwB4ZwrQUMxv51nPVS5BB9PcOKCpwSnYCy4=;
        b=DZ78fO7vFlZTjXZe4CcrPoLv1YVMhkSKQxoly72G0gOrDLzrhmzLpD5JRqwQmEDNJk
         09BcFXk500+GeoqrBrzYNbcVZGfOkANsOXSqPJFzvSZVMsOPlzGRRmKY3YM5nGLEEVhR
         9oB9aD9gFe+RwD7tQbW1366IYMAOl9nNwEoosa/d1f/i6Iy6+uuYbFSh3QGFoI2EMT0J
         1skiTGjdXSgxbvBRb/Rn5rv6wsuvncW/0x9UEBdbWLYbSCwtZ/HYdaEIkO2ryI62vrMq
         j7oKb0IJFBsoL6fQ7ivKkmLNc6d7GDL+bpwVWeJ9KcbFlEVMTmyy+t4zSaOB3if6/utJ
         9rbw==
X-Forwarded-Encrypted: i=1; AKwUvByowjHBbK2s+LdM2stiurVDS3ieRNzpA3Ng5+87M1s9HzHGOtCPNLR6ynkDExccEwZ4ZEfEmJ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCJCF6QFT8yeen0Ux886Nq4zzYGyCz970QEM/L/MckNks2lmal
	WvDT9IJmBmB3X/Ar2NXSG/FOo3Ysj6k6zf3/6rZxphp6gltMxcSsR35y6ocUr+jcve8=
X-Gm-Gg: AYBFou2aFPr7UA8T/NKFi6z/loGCs/zOOVMA4vfoY0ZgXwqscuXnnpufAI0uFTB0rSA
	9BmmQZY/9dByR+shfHcBo3DysfSGueWxskxZYn674tD9RAJLKS7TQ7CBJvwMnjQoTihR8gOcnnA
	OdaK3624/NcQ7JHWVl6rPhUTkWrxhxZIpm5bCZGleyxS8vhbqc8i21yhPr65MMuGiZ8HpJyrWM7
	i19n6cmqsvhYk86AC518TLIPHbd+NugzHvsb6EcliLW/Vyr71Vkr4eu1hW6cGnCfH1X3vp6IJkT
	a9FtTBRI93diqQWL9ED00tLQcJjlB4p1CLgfcn/ieWmHp/S8WTAC6+3n8oZeKq0jNY5tP9pp6IL
	qkITO05FM0PhowV/mbixw+iWy6YKR//XsiMzb8wZK/ej2MgJAPzTBqMUW80RMLmmwUKGguCqZo8
	sZICahEJSEmtzje1C+k3prRqNQ6Dlxi1uZUSJmp5MCooGr24hslQmbMnSVIMNz7dZw7az5he7qE
	U6oTkheMnj29zXyFu5XXuhUfij18jiTXTHVayJa2xrMPKxM574=
X-Received: by 2002:a05:701b:2412:b0:137:fa50:a242 with SMTP id a92af1059eb24-16a586a3183mr3726919c88.1.1791581872469;
        Fri, 09 Oct 2026 14:37:52 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becb11sm7720280c88.4.2026.10.09.14.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:37:51 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: netdev-bot+sinfo@kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 0/3] amt: fix relay tunnel keying and unauthenticated-Request DoS
Date: Fri,  9 Oct 2026 21:37:49 +0000
Message-ID: <20261009213749.2226283-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009201455.1904698-1-omar@blockcast.net>
References: <20261009201455.1904698-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks -- both are fair asks. Answers below; they are also reflected in
the v2 cover letter. v1 was generated against v7.1 and did not apply to
net, so this is answered against v2, which is posted against net with the
General Query patch dropped (that fix is already in net as afae89de73dd).
v2 is three patches.

How it was found
  Manual code inspection of the AMT relay path in drivers/net/amt.c, read
  against RFC 7450, with LLM assistance -- hence the Assisted-by: LLM
  trailer on patch 3/3. It was not a syzbot report or a static-analysis
  tool scan. Patch 1/3 (endpoint keying) came out of the same reading of
  amt_request_handler() and amt_update_handler() against RFC 7450 s4.2.2.

Whether it was triggered
  Found by inspection; not observed in production. These are availability
  and correctness defects, not memory-safety bugs, so there is no oops or
  stack trace to attach. The symptoms follow deterministically from the
  code the diffs change:

   - 3/3, exhaustion: amt_request_handler() allocated a tunnel before any
     validation of the source, so Relay Membership Requests from distinct
     spoofable source endpoints fill the table to max_tunnels (default
     128). Once full, further Requests are answered with ICMP_DEST_UNREACH
     to the (spoofed) source and genuine gateways are refused; re-sending
     once per amt_gmi() interval holds it full.
   - 3/3, desync: the pre-validation lookup jumped to the send path and
     overwrote an established tunnel's ->nonce/->mac, so a single spoofed
     Request carrying a known gateway's source endpoint made that
     gateway's next Membership Update fail the "Invalid MAC" check -- a
     silent one-packet denial that consumes no table slot.
   - 1/3, aliasing: address-only keying collapses two endpoints that share
     a source address (NAT, or one host using separate IPv4/IPv6 ports per
     RFC 7450 s4.2.2) onto one tunnel; the later Request wins and the
     earlier gateway silently stops receiving.

  I have not staged a live end-to-end exploit run -- the above is read
  from the code paths, not a captured trace.

Fix testing (this part is observed, not inferred)
  The three patches were applied to net and the kernel booted (arm64,
  QEMU via virtme-ng) with CONFIG_KASAN=y, CONFIG_PROVE_LOCKING=y,
  CONFIG_PROVE_RCU=y and CONFIG_DEBUG_LIST=y on top of
  tools/testing/selftests/net/config. tools/testing/selftests/net/amt.sh
  passes all six tests -- amt discovery, IPv4 and IPv6 multicast
  forwarding, and both IPv4/IPv6 traffic-forwarding torture cases all
  report [ OK ] -- with no KASAN, lockdep or RCU reports.
