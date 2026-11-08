Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136721;
	b=0GVshv20Md4a3W1pXCMmjwWY8U8l2YEwpf5Ct4M3l+I7j67oZRUoaLr+PA3iR63b5evJ
	 0ZmnW+e5ozAAJisfeT7Jh/Qr8O7EHY/BrJ55B5juPOp/M8w2rJpX4RPSYJMMZqccJFt/O
	 UqViKsAb7HjwEn307xL6lI6Cj4qGD2k2tihSQoZs5OeRwaqtD0KCfgEitOFlqW/I3j7i3
	 Kd9xK/sgpePMxeZGoi9ealXGGntGKYBf0WFxE1IMqnQSgP5ysHrI6rnwIzzIJOISML2Ve
	 edIBcRe2K3GfCwZXc/lGMXEkO5JpG1UJWiMsD6kQdHugX2amc/P3c963GqNlq6Iq9ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GFsYetGjQGfqyMGoMWETXho8ORP/Lahdw6Uraq41F9A=;
	b=NLXu2fXQqZP0QI/5vbW6ojBfZ+NZjM3nbWghn++NAubuXQL1+AoaSu5W/ukHlca8wXcE
	 g3+MAEBspaSn+/MhvHYYEkfSDphQUYz+O0AW9i57fTUHoEogPiK7xWqXkmrH+4H8gFB6o
	 lHDplL8IEnLCU1csuz3mY8GeQhIsrVSurni50aTVGrb/g6BRRcyInIpfdPf2eODayida2
	 tbAi5J9AfHNP2I/J5zSF6U46ipNrstxIeu+G8syi7zKH9d65j58klI6b6OF1UdiFv0k2W
	 80sr2dH3ktg4dpP87nlpeDCQYVv3ey8HHxe4mK/RGOgc5r3GB4/4SvVdaDOa/9DkUEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB81F606A322
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 11:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB81F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33fb4680717so110383eec.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 03:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1794136713; x=1794741513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GFsYetGjQGfqyMGoMWETXho8ORP/Lahdw6Uraq41F9A=;
        b=EJnjOekExMq+4XmCNDBgz8AvVL2Qyl/i2Lo1WR48gl6hs9cQXZzHDQ1HapMXFjF9kg
         CoWyta09y4OCZXpJ1mCMFiHQCHpxRgeO1BPT4fQo9F4HK5xVnbRZfQ1u75Df10xFHntL
         qKJvJDRq0PGo7Af196CHJ5IxuV4G8r1eq6+fJMI1l9wAciNP5ilv2Sf0PSZQoA/061tE
         Mc8DOjlRE7/X6Hirj2CZ5tLASWT8l7h1yVhcHydsQRDvUcE/8ioh+S1Dv9FPvtVKvhUM
         L81Dka+AVaT9V00BM5BBT/iwQEFM/WKWQMGpYprg89dAM7cXT3qn92RmeWeCWpOkeBHS
         /z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794136713; x=1794741513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GFsYetGjQGfqyMGoMWETXho8ORP/Lahdw6Uraq41F9A=;
        b=NzmuQIqvL7ZIkYq4JUlGng7FWU/1krJJPQejSxVh7+Ul+Uuf+0iGoHYiSBdZdn/rbR
         ujOu+cCdbAvFJiVf0UvUs4QrTHVxMGB0/Le9DDJyv8fpl8rTLq+2YmAUu2u1GgKMwDrJ
         DBVpM30LcwrSn2BiEyw0+VG8qAn+T5NNS8SmJxEDPwCK8XPUqsQV+3drsIbNWZPFbzDq
         zIyD4XrwnfjpQcLGIAnKtwK9SGaXdmBvIKNeBmm0Hq5lVsBEbdFrGIZM7y5/vPbGD3CE
         HAGSqY1UtS9nmfmfdR1GnY02/s4AozaROKfNq8qA+H1IV4mim0I4jwADgjOqQkET4m8U
         uoOQ==
X-Forwarded-Encrypted: i=1; AL+hErEJRqiT4YVjb8y3dme6JsQYJqtS9YXz+wX5GkzvJ1ekHW8XpDhFaWgJvcQM2Ft37HH07Ko8mzQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z949oCKdxxtFZRBlSt4qprNZ4IuQogW3u/yCxPmNxaIOHgBAvTO
	4kfzdjw5q06euO5Adeoerome9cHGi+xaKz7+KJ9eJivXnYMJGYGMrT7fxw62lfeg2FQ=
X-Gm-Gg: AYBFou3PfrxNSK4CCesO2P5WEgFrFXsBSZJacTSzx+acwbUlsFSM/ZjmBzGZ8M5nqLa
	jqOzFZ5+3U/HaMotPDRs6TUzvCi0Z17mGO5avBe859sAao/avaANqtFmqyW6hGvP6kbO6ZN7oEt
	SuMrs5AFnPcGdHX8H9qCyOFYEDe79GhJm2xWXZxbq30HMWw/XYzARrI/naeQ87LIwbL9NLoYL3/
	u7ujpZ3b2RVAryuwiBoqSCzlmBR0xntuHVHeY5FfB0/qg0LvwSiPbBvNLGGint2D4f4wQjmoMCy
	lotcMbj7q2OrN5UyfgUIoKubpUp29D55rEUGSi+Y2cUJJjGWw9KgDY3mnTBGqCHeMk+Fcpp/kI7
	nzFS9qAVmtTAXNqvr1KE+dz8ai7ueS0IKiR6OABWpntxsvB0qllI51/YnviNFL7wRJbqnX5PGKe
	SQ1fQqZ249BBlmJAre/nm/zgXKi2nisi1Z7PXXzLvSLYwXZPpOtAnnTFb38DhJ2UvMuR9q5YjAe
	7Nfs09FhgFTgfs3tyf+YDZxY6JVdEVJtK/9JrWIQ+ZnRxYa5n2YjBb+WKkYQOgGatqgU2LjswFF
	FfLBMmn+aEXcUJ0UILRWj1L1ej65zqLCFzwd5lWXIroR69AI4pZpH7OhF59JeMYzroVyC48BKVw
	Dk1mG3f5tDnnxYs/4S+8aergELCEm7g0Mkn/kWw==
X-Received: by 2002:a05:7022:2209:b0:1b3:2692:2274 with SMTP id a92af1059eb24-1b39ff060a8mr2675802c88.40.1794136713408;
        Sun, 08 Nov 2026 03:18:33 -0800 (PST)
Received: from localhost.localdomain ([2406:5900:1044:110c:9c49:6b89:2201:42e8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375728f8bsm4582119c88.15.2026.11.08.03.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 03:18:32 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: netdev-bot+sashiko@kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willemb@google.com,
	pkaligineedi@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] gve: bound the device reported rule count in the flow rules query
Date: Sun,  8 Nov 2026 20:18:23 +0900
Message-ID: <20261108111823.2803947-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179411928865.994134.15713036918131150201@kernel.org>
References: <20261104061329.1881388-1-yhlee@isslab.korea.ac.kr> <179411928865.994134.15713036918131150201@kernel.org>
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

> Could the commit message also
> mention the write overflow for more than 1024 ids and the multiply wrap on
> both paths?

All three points are correct.  1025 or more ids overrun the 4096 byte
rule_ids_cache, and 1 << 29 rules or 1 << 30 ids wrap rule_info_len to zero
while the count still reaches ETHTOOL_GRXCLSRULE and ETHTOOL_GRXCLSRLALL,
neither of which needs CAP_NET_ADMIN.  The bound in this patch rejects all
of them; only the description falls short.  I can send a v2 with it
corrected if the maintainers want one.

KUnit under KASAN, harness not in the patch: a bad count from the device is
a 4136 byte write into the 4048 byte rules_cache at 47 rules and a 4100 byte
write into the 4096 byte rule_ids_cache at 1025 ids; both are -EINVAL with
the patch.

> does gve_adminq_process_rss_query() in gve_adminq.c need the same kind of
> bound?

Yes, sent separately:
https://lore.kernel.org/all/20261104070041.1902653-1-yhlee@isslab.korea.ac.kr/

Yehyeong
