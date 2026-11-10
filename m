Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327127;
	b=Hl5VGvJ9AKqNNntQxrXs/fnVnxvcI9w1vhdteNrAhtrDtojikUuVahMnF2IKNh7pblxt
	 cs3KFmbX3O8MEW54xo+FH1DdorL6s4U6yh6FmHUPS64I3pBj6G+JC0eMyktpEKdqyhJQO
	 XDjASbz4pJs21ZCn1yYzZTnmPjDgRxHgoVkXIxS8P4bfnJx9YxgzUO2ImFIXmdqjL8/7a
	 tql1xU6rpSg8STWPHDgXw3Gey0MbDDZQViCniQ388j2eDL/8br9nufEr9Zf1FFcYijmME
	 mWFuv+4oB6M2HJ9ZDzbUTSvm7vTMHMwg/fCyx3t+ZElt0ICQR1UiPqNNcDXMYdlBLaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RSLplmlefCzlrzZekmOXD0yz8U/FyqcPjyO9JJ24e3g=;
	b=P4g0PeJI+Ahl9+FhrsJFzY9GhC6vR+CNtCDDjR6buZHfPCRE1llvCh5MubROxacZv9iO
	 nbkGsFELPNdk8a7CyktYJSoPRwLjQlOfiP5jOzN5NbqgyfhqRJ90YsHwLlC8NuPG37EVK
	 oUyo324ejBpKaj1ylPGsLQ9VhlbjZK9WoKKFhK3EGNP+8ZedXMjXwHwU4CiE460VotdP8
	 InIbiY2Ezaqc4maLpBf9CyzUYxe8a6cmY0rxJQpu9g75PYoPl+qE7BGZCcHBp3HtBGFit
	 R+h7B7t/b8oUvWAIlA7xmrUpeGlPYBXlUpRRP4RUQVXboqfbg8gcCue+JLZisSlAIvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rT1851wK;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C133060A2611
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C133060A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rT1851wK
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2119feee8so1690825e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794327125; x=1794931925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RSLplmlefCzlrzZekmOXD0yz8U/FyqcPjyO9JJ24e3g=;
        b=rT1851wKskl1h9ymNh8Xbol+PH9UppLA29igRFHTHd3eFBfaEobdNkisj4eq6NLoCJ
         iW6mkHMjfzEt3DomDzKW19n+/Q6ow/Qor3LjxEMpUQVg47KZ25vE0diQn5xg5ICcuBGg
         QCZOwflNYFooSOY6okpZsSNyxwaCtAmpuLswLPpSWVNNaouXHM/j0aXlqvfKdxNnIPTR
         ezfrSCPXgBm7pXfHKOgz5uEmkk5Kd8lAX7UAIdoaTt/9I4uq6xpJHAZGMb+Ep9mRqGBA
         Jthp1U5JDjizPbUn4dLi7NUU62IX7JBGG+3rkoTs+EZS+sm4XTBH6hllm1jFNqXj0xNI
         ClWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794327125; x=1794931925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RSLplmlefCzlrzZekmOXD0yz8U/FyqcPjyO9JJ24e3g=;
        b=hNzu6JZTILdjpr2eWDm7FNHUkAy0yFKBkavq8nKjqIi2B1H3ujh8wWanwoHlERTi+r
         5uXRsQ+mC5HDytOCdcewYLlVa69hf60u/CL5Y9Cxa/VSctjBWdUnOs/F47z+q86uWi0b
         6OB49C8E2yhDEzilm0l2uAtZxVGKBFWzRSyTnyl10Q2UuY74r0F/RcSXGOvIz0oFnnj/
         qbinbB+U7ngIUxci9DzKlB+Laq9xjlG+p+hWWufjThIvb/aezjEV+ZliMeKBxsRjgxss
         vreIrfblqJvhaePMSYGeX2c8B6MoRv592ZYTNJYwapzpUZ7Ukj4JYU4rfw3M1nS8vsnQ
         Kv6A==
X-Gm-Message-State: APuU4Z+dgUdl1fKfhMXab4Pza7BEIfca7YiJQK1VRggdOiPhYVDCTjp1
	KE00JcBmcFNy+uhMqthK1FQ9R1bNL23XwCVqQSjI3TGkXM60aIIJVXLH
X-Gm-Gg: AYBFou3j6TCWfjtLZDaIUqFNAyCv98QbA1uCR72brEuxt7JKEeiprf71HMqwlGZqmfw
	fFFzalqhx5kDX5rlHOpaxS1TdwnwK2lkpP9s5vpbUjXMXQnfKhDgL/6qzyL5xcwIo3w1eEWQj6e
	bQsagIJMgUFlmrzPlkF8fiAvqyxIUoy5lI45Nkint0yNH9zQU7/8UzLFzsfFtojQiF6vb2qxOtz
	CaBN5s2DjIk5FLJgS4zBuwPzeIMoIXkILUWWo9wC4HmHF1cDQy1mjHAn+wpxoiYSVomFXeo8ShW
	o3BwUU4fx6mgk8Bs7bXZg7S52upLStuJvMQ8U0evFcAZLNrjFxK5d9Avyu9OgVbMhCdcTjIHoxX
	WPbY2Io+/cSwiciDdzaWoYtS1CgACn/7qO285JqanrFpTkeSDXVxjlqn34JbEfdH/SgzthCjBMX
	JHNQzZZw49RWdBugCg8eh4P6Ri1bjztSv42jqRIe7TqI9ii9aGd1ety1rnzKvA3ZcUvRmC2/S8t
	sBix4THC5pl1ASWKWke6fTTLH3gafsziV7thUI+AZbdQKpIGVVaAiUdjSN2DwkxYl5FUKPaT8zg
	1ltUlvKMUXM96O2v1WqsQrHr7xj8yRnZnkGlpFGp7EmAVdt6bHS9cMvo3SPNuk0HFvB8C8Ep
X-Received: by 2002:a05:600c:350f:b0:4b2:3c81:103 with SMTP id 5b1f17b1804b1-4ba0233a711mr52624085e9.2.1794327125133;
        Tue, 10 Nov 2026 08:12:05 -0800 (PST)
Received: from localhost.localdomain ([95.183.147.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0235ef62sm46727135e9.2.2026.11.10.08.12.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 08:12:04 -0800 (PST)
From: =?UTF-8?q?Bilal=20Yaz=C4=B1c=C4=B1o=C4=9Flu?= <ahmetbilalyazicioglu@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Mohsin Bashir <hmohsin@meta.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] selftests: drv-net: ring_reconfig: handle devices without channel config
Date: Tue, 10 Nov 2026 19:12:02 +0300
Message-ID: <20261110161202.77549-1-ahmetbilalyazicioglu@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179432444472.994134.2763803571159924115@kernel.org>
References: <20261106150509.30458-2-ahmetbilalyazicioglu@gmail.com> <179432444472.994134.2763803571159924115@kernel.org>
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

On Tue, 10 Nov 2026, netdev-bot+sashiko@kernel.org wrote:
> This catches EOPNOTSUPP from channels_get, but what about drivers that
> implement get_channels but not set_channels?
[...]
> Could the channels_set call get the same handling, i.e. log with
> ksft_pr() and return on EOPNOTSUPP before registering the defer?

Good catch, that's a real gap. ethnl_set_channels_validate() rejects
the change with -EOPNOTSUPP when there is no set_channels, and a few
drivers only implement get_channels (vmxnet3, r8169, enic, octeon_ep
and others), so ringparam() still fails on them.

The upcoming v2 handles it the way you suggest. Looking at the same
drivers, channels() also fails there (its restore gets -EOPNOTSUPP),
and so does reconfig_tx_stall() when a driver reports spare combined
channels, so v2 skips those cases too. Other errors still fail.

I don't have any of those NICs, so that part is only tested against
an emulated ethtool family.

pw-bot: cr
