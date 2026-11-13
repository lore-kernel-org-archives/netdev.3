Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585079;
	b=qB/SnbQLBXznbegJes5PSkVk8fJz+305l4VsKm7HZ1tJs/5/nCYoDpO4URBu93OWmDzi
	 qDIuF6q7xwfi8sxGJz8B7DVgPyfamYhk5rtJh0f4Ne/1zmZBE6+F1sJ6z70vlufjZkVZb
	 gcE0x3Csl/qeRi1Fo1HqHGLoqG7p23yas5KqkVTs1It35Hcx72WOb6FuhRx3HQsPbN/dM
	 tbGxo1OINscgTo1Dc+pZFoN80KN5oAhPlRWJ3UtllGN/EldyFzQTGLixvz+1lGzSTio6d
	 XU2hsN/KVPryRxeTVnxCdaarqKRJSXgAECmNqFOGxPcQ9o/8snfebWobY2SysQJu9Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585079;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zUg4UZuNacMSahgcqJYGeF1Pp25v0I954U0ol41ajBY=;
	b=kBHCJD4f+dkjXCNWerxGXIZ1gqLkIzRIJTBZlJpBJzz7Uru8EdijJ+5Y28Jk473sWOE7
	 Lx50OsRvMxqZQMOU7nQ5JziYj7QMjaA4dlQzQeS+2g+wkBrBnobDkChCqtH0MxBZN+HXW
	 nufFC1FA18KNlABqoZJhuLSdPlBmmZhv9Mj1QYlZZ3DPNv6ZERNi4aenZyfbmPwm+DYPw
	 SwXXqUjOUyznPdPPehUT30K72d0pNIjEKTeevwhZQYLCQIzjKT2ScaGKfSMEfRa6Wo8rt
	 FoTjfY24bhdwIgZLd9P4v9URAFA8abrjK67Lh661a6kqlQaoig1XGlujxzxcKhrXSAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xUoi2DIU;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C109C606A330
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C109C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xUoi2DIU
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so635673b3a.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794585078; x=1795189878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zUg4UZuNacMSahgcqJYGeF1Pp25v0I954U0ol41ajBY=;
        b=xUoi2DIUlyrX5tqc1LVQ0zI9DuIZszlMX97dGdZvJaSW/KRiZ+PNkP8FCqRQM6/+ke
         eHQmhRuJDU8hx0keeID9qfB3kdKuRKQrEx41IJbGAzU6dXy6Nry0KkOYaL6oCiVxwurB
         xwyesTkDO6jfj99G00r6wy5D6AKH1NYd1WU8TDHeJaZZ+Y0+yVj0/qGqGK/yrNU4BUvP
         M3r5lZF3jhkixQqLU1PoKeuJCQHWxXfcvd1r96kpZNxaYE6dDHiTkKyvkr/O+7gKHXWN
         KLNgFO0zY/Plv53bJcmWQI8Eo+D/DVFypeHTDIbb5hiQlRzHAOj1ZzdXWGFiu1glIXNK
         +Rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585078; x=1795189878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zUg4UZuNacMSahgcqJYGeF1Pp25v0I954U0ol41ajBY=;
        b=w3rvFDULVrbq6JRUcOUHjireRSrWOJeNuruMGuNRCvpz2cEizho6O2AleWjsua53N9
         glWEjwIJdVbKQpmSQw7c1SB3zcTVSvZ9EzrxgxNz9p8ks2OKhE0GL+bkJiayZdnGnTDE
         Nb8wic75VzkbUysmNtJd5KWXJNZAegK0KioXJkzpzo+TffCkaj9WhXoRevqG+YiZST33
         qYEZUFsisn7mP5oygQ6M6jP7f0Jf997/c4sn9cz9Z5kfN4Xv3d53yG7kIyUBIQ87GKH8
         5j1M71ccePMaOrVa/tKVQCiD2QIn6VTx4cbdE4RxB+lT5R7zvtR1voVw3ndjZ8AnzDlY
         1MJw==
X-Gm-Message-State: APuU4Z89BF1dnHPc9IIyvWzJ6xuWJ5V8z1vZMl8g4VJVmLz7JOqBbiTu
	nGK1uHn17bzsl2E2Y05BobNZYue3ii8gf7I1IlLIoi/Z43sAyuKnBxNB
X-Gm-Gg: AYBFou3LBWQpgiDGd3b7ZPnqjTBky/alUSKV+21GLZJvtj3ErniM1SMZltahgpmrNER
	geXgIza+Z/ceN2o//9Bi45JFwyx8Lu6RqYDLnMErcVRei4xcGNqQrHnaGL+lVPUA9vR56GpA+XK
	qK/Ynm4+fwi2eLVsOd05vBgXRNltQG5CV7iubkEJAYBs08lPh9clxHMKWXa+Yuc3QoSdH8+jJVr
	6hVk5suypQL16MFgDBjSKAoNk2NniLHcRgifR0m55Z7KDflZ0b1whz7RP+RWiALLAFgwqGVkT49
	lULM0ZSqMHwmn1RYk4PgIei6lwpf+KKbL7g6ZGzjE7uMZMZXH8EWSHdIpEyNAdlXMT/PazARvNg
	aPBpZZ7oNa5oL09k6nfawO2T1VVQrL3pdDbwgVxlKu7H7a0q/8izqQyv+usrw9IJ8voJlIP6SCV
	5CX8epY5vD2GEUgXoiB6AK6Nal2VwZ/PEroSwP66J9heGEWlr+PPoNJT78SHh/CrOvJj3CGitOI
	eW5/EjLTcnJZj/X6X2qlBNocBfDDAM6rqgAG8wf+ekzgXY43jjjZ+G6em+liZkvCP8D6tCFZIIX
	4SXDSlsfkO69zTPdmmTHfPRnjn6leJbexKChYW66UkdAhNYkD+VsHET7O3fJnGtZYBDoumIKU84
	yqbo=
X-Received: by 2002:a05:6a20:734d:b0:3e2:b400:2b04 with SMTP id adf61e73a8af0-3f7a92edb38mr2747257637.45.1794585077819;
        Fri, 13 Nov 2026 07:51:17 -0800 (PST)
Received: from localhost.localdomain ([219.95.157.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc160a190sm1486575a12.2.2026.11.13.07.51.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 07:51:17 -0800 (PST)
From: Zhefu Peng <ilskdw@gmail.com>
To: nicolas.dichtel@6wind.com
Cc: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@google.com,
	mschiffer@universe-factory.net
Subject: Re: [PATCH net v3] vxlan: reset the remote's dst cache when snooping moves a MAC
Date: Fri, 13 Nov 2026 23:51:10 +0800
Message-ID: <20261113155110.75061-1-ilskdw@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <72d0afdb-c2c6-458f-9363-d16c32220a6a@6wind.com>
References: <20261111180001.2475-1-ilskdw@gmail.com> <72d0afdb-c2c6-458f-9363-d16c32220a6a@6wind.com>
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

On 13/11/2026 16:05, Nicolas Dichtel wrote:
> Maybe a selftest could be added to check this scenario?

Sure. v4 will add one under tools/testing/selftests/net that covers
both cases: the IPv4 move behind a router and the IPv6 link-local move.

pw-bot: cr
