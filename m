Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463C73A254B
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422078; cv=none; b=S/oKrhqoOnPeV2ADeccfsEU3I5t9vxx4r9Q3jwPnr3Zxilu8JAFOnf/vMpA6isXJExwbvOuhn0IpROzePkRN8BTeCuLiOn2lQYXz5DzamkURzstA0fImGLQOox4hzxGw33VEQ6xnuVKbHmyALIN8ocTs7s3dJjqoZ1+Tq9q+Qyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422078; c=relaxed/simple;
	bh=JNT/aj+Ahw5peP+bjLczpr7em3lgaHUHuPuGgxCl4Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oF4ceDVWkYxRAIYdsVWvHCOeTZxHDYVxujPRiuLMBCbjwMya0MjFuRD5vYSMpjX+XadgPyQnVr0HJmlJLEt/asR/aiYl88aHSDJw8vRpinPizZ5LTU5Xc79tSFxq+PrPvtCbyBu2plZbQa05NgZ99VXUKOX+ZN0/xiWsTHJ6QbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kY/mjpFT; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY/mjpFT"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39f75e1e9d9so2849221fa.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 07:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785422075; x=1786026875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JNT/aj+Ahw5peP+bjLczpr7em3lgaHUHuPuGgxCl4Gw=;
        b=kY/mjpFTh3exREGgusu7qUxjFowuyYrURKKqdCFd0nYJPZT+Bohm8nKrvn8rlsT7ZG
         Z1AfTkMnCR+Z4cCiuMwTxboWFC9jmxw5zGRKiICl0jbqUjyyVcadtKB4dP5hnU0DGV9q
         weDK9GgVmYPvfga8XgbrB4z8JJsr39sGcNtzahK4yNVXIy/BeMPk5wu/pV6Md+7JeN2A
         zbTEN+nY13C0GISXfvoPNSdlfFldT1hNelNIhwtwmicehw4poPbKc8PgamG1qxgfdTvP
         yuPpu25QUZvVI9m77lF8l6VZoBQxHmGLiq/TNSF5rfvrJkCN2R4xsYMxubUhecZfIW4J
         EBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785422075; x=1786026875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JNT/aj+Ahw5peP+bjLczpr7em3lgaHUHuPuGgxCl4Gw=;
        b=lNKi6rmUdZ2ZhQ3L6BsBD9J9ik7CPuL4xSpv5KoNiXbNRV3C6nKf4ZAWaJzrNgRgrX
         AEp6Y1plLnOnTnea2lQ8pF5dzLqiQm90AeF+gqJV42R/vpEjlfuDdKdehh5mMBFpRFH7
         v3NXcbmNIhAurFicAULZtkiT5fQUz/ClhfQmnaoluHOMcg4G5odTvJ58PgagW8TNURIb
         Xv6Txy3HKlsKgwid42lluP6dUIQadAr2PcAuwg9+kFMpRmPi/b+UyoiG2HGKQQQoeug9
         TlHurGIuCjJS5AEwx+XEnIJ7x9vE6tMLhjGsIGz17Jua/zfUkJ6/73Fow/DUqf3kgsFs
         rnbQ==
X-Forwarded-Encrypted: i=1; AHgh+RoK/oO6LlBQIZIEm31D7O8CUoM4s7d+A3EXAlq6MM0hhmcaUzFio+n5yElJyR15p+PqGLQvK/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRs0A11ogMf0XJph0T7QLophB0oeEDnL1U+D5LsCjdCtkIoJ+
	mIXJL2r0g/JGbvzCeB1w9ot6Klc9u3RtSvaZNpAAaqDd1vdsWofIaB5b
X-Gm-Gg: AR+sD12vQOlkFXTpr8+40QojfkDDbuH9Wu/NASF/2bkTR8p8pdx+LGjQ33xX91Z6yzz
	QF1I8c6wrjV9o9WBF8ZaG535+GhpHbzJDsH5X8d7yWguRDVdyQj8nyOeZnZsKkHlRJyXfkuakcF
	lwDu5ez/135Sst6b8wI7W+idxWAr1h5ev5Vkq886n3D+K+yLtnGlPdVZA7RZgcI4i5XXMOwOesR
	LoU/Mfe5LZq/TGgi1U1xFsxmOoiTteADptjrWi0TS4iOmONzgGqpEDlD8S+nsoY+sddRnsu8OEK
	skqbvxBZ829aloLxmERQ9PrrPRaUlVNnnDvb/xS2BTB02TJ4cytkWKJ/L8HhLHinqIN2G0Amulw
	UYE3MRwmdvkAUVtImtEApMphJ6xXCxbxhccuLuKXfpjBzZBcAt9a+XPjl9pwscsItaEzfvlT0zy
	UNZVEQsKTuNTo+Wh8DOrIGIqCT6K6/A7v1q7hvD0B24ChOIUJkWnBwNcBPyZiv7IqKsl5H6Puky
	exY77CWRK7zWAk1VxqwUARqCbdWqgzUOA==
X-Received: by 2002:a2e:be27:0:b0:39c:92e0:528e with SMTP id 38308e7fff4ca-39f6b8171cdmr4553711fa.10.1785422075049;
        Thu, 30 Jul 2026 07:34:35 -0700 (PDT)
Received: from pc.tail250202.ts.net ([87.110.86.243])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f6acb4f93sm3300451fa.37.2026.07.30.07.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:34:34 -0700 (PDT)
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: milkory@outlook.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	enjou1224z@gmail.com,
	horms@kernel.org,
	janislacis06@gmail.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	vega@nebusec.ai
Subject: Re: [PATCH net 1/1] net/sched: reject overly deep qdisc hierarchies
Date: Thu, 30 Jul 2026 17:34:29 +0300
Message-ID: <20260730143429.209002-1-janislacis06@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <TYWPR01MB85592DA75CC2ED8B830D72ECBBC92@TYWPR01MB8559.jpnprd01.prod.outlook.com>
References: <TYWPR01MB85592DA75CC2ED8B830D72ECBBC92@TYWPR01MB8559.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Okay, got it! Thanks for the explanation
