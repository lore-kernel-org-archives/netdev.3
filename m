Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794138457;
	b=y5rWNMbsjvf7GZhZVe8LxHwLCaWmgbpHJ4NhTn+x60h1v5YIIov718Kac2+ukhOxrVVR
	 nUj1jnL+CM+vYrbZZXpliE4OoOF3ASiz9MhI4o3AnFRHjxP3zuu6RdD4XJhIXA1+DuZmu
	 xnGUHa8SCQ7GL1vp/QEFvb2ftmuaVXuBT9HkbWNS5TThaJKgTPtjHZu+l5kRomJ/M5XAg
	 9jybw7w7hsm+4cXadf6SSloBJ+iKhYmk/762/IRPyVKls5Eh2KJNvCcxM++g7BVfFd7QX
	 Ku++z+Aa9g00PoZy3g+3Ih7zkVWD7oO/GlS002k6dP7unO/+A4C/C8oKpx82Ivujh4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794138457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lSSFytxtbJbtyMN9RV4GYLmhr+794g+CxDzHCGkwhLc=;
	b=NE0Rkj4XBRM+RmYR793/OO21lCSZbZAchRKZsbY/XScom41Bz/P/qgm6jewaePj+FBhP
	 dkVYY5LLVd+alTCb9uBz6IXpP98uNQ3j0i2qMkMzouDCzwPONKc8IYLmQgWNzTCbO5sni
	 29b4hjNRwuz6wDKs4HscdeZlimSkpPTJhmdXieV5Vq76BZYj3CQC2hGM6YlJswuVwsEmp
	 +czIKhGnmV6Ncljr7w0VT9OCAyg9aVKkqcu+A/+DnQsDhhf3EZU26MztZckE1sKqN8npZ
	 VATdyrHhuXA4ycOe/TZamMbxOazBxn2IQeUqk8Z6NJCPyFDh63KNg6WPZFgWFdGxZJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=Z57TF2JL;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55B7606A336
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 11:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D55B7606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=Z57TF2JL
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso152944a12.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 03:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794138455; x=1794743255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lSSFytxtbJbtyMN9RV4GYLmhr+794g+CxDzHCGkwhLc=;
        b=Z57TF2JLGRzKehJ8w25DcL9WIwuZYw8VvPJg3izSaGu7Hw0qY/tsbiMcqzEpvAxbYm
         FMoUwPa81R+EmeCD5GMfMhqzNzBX2CSVPpix6Gb/MgpFOpZYga40qbjiDWzOnwNwKHfJ
         5iIigxvEmJ5W0Hpag+A+y1OLQenf6QzXVT85rdXfzvdsGvhd45Iwhnw0dnwc6/Tl4oBj
         S76KW0HDDBTaZyvhlCXYYo8GpAErDZANe3LhCyp2A5+o63G32xHihYChakMwyk+9R3iM
         JNy/3F2zJgxWyp30enCygFyBTvXhjn8Jn4/5y46LwOgYeVWS2zWdBdxgHZo5XN0SOqWq
         BQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794138455; x=1794743255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lSSFytxtbJbtyMN9RV4GYLmhr+794g+CxDzHCGkwhLc=;
        b=hB/vSAAbJ9whGHICe4O/pplrAb78tfIQzCVRhV8FwGZUx343pQvm5x2fQwShlYp4zi
         Dtxf3o59zvknFknXswid6Y1NyN4SdYHV11vG9Fxd8g27MnMHFmO+BXmVtcayMH0KBpBZ
         qPPPvYmhF43UPIH7dUEJfu13QjyqI5+/atAam+vrGRlYrsSMZaRFPC/+PxwDGkyxWzo/
         0UO0zyCc7qz1BocU+yXe6TxtkTUfDuKy1xxWvA/0mG/EuDJihyGrcH/7ZOehazcKDj7x
         qMnrjW5xzLfr9AD1EeoOLM05ZlAVYxj//o9ePE9P3IaAxG/cvoGI3kgtWdzMpWxryzmG
         j4MA==
X-Forwarded-Encrypted: i=1; AL+hErGN2ppWeODR4fug9gkMn8GGpGGFnjLbE9DUSYaFLFEOsupVf8n8YcMda6oBowXZ0HsRTMl0SF4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+h2HvOwLcxkax/Y/GVFfxTrmwnlugAbCNpqtAdVTE2kSzHUOZT
	yiBx8T3tY372f9V/csozruaIW1hTyRu3p07uaqFYBO84R74GEueKZ1j+8ODcsdb+hg==
X-Gm-Gg: AYBFou3kDQgCrC+LBaMrly79uazWnYDLz0eLZR1+dyi0hHRHKufiCgFV+1DVuYkx/Ta
	WpssnQBdA2hbt5YwkeifxJLor7MIIjungEQSKwBj7sAUgTAB/0RRy2WEwA1c7UoYWZ90hCOKQeU
	y08QCfQ5ePC0jvs3a7rd1u6IEXDIBa2PvaB6VF+sV6W7BKYXH4ClZHH2LpTdLXJy2Y0SmMha+lj
	PvbEanGEadcTfjiSbtkI0qNS0XKSjRy05nbobnbl08cRZpil2ZD2koZubOBY0VnMyYyJE2HWc5E
	MEtY6+Fs45ctwIMriC36dsAcMuV0OeLGsnbAzZgolMnHoYdkT5qnSljNfYHo7d+LZjrcKLAOU0+
	q5Jgz2WbhVyy/wmyqIPGyk/Tlw2NQb0sz9ETMgoVhj6aNcOCLpK4Koc47ZTXbwVXsOCKRzm/1th
	VElTlrRX2IXm4DFqnoawYdJDJpWmuWnMUqfwtHtmn7x90bZTrLkNw2nudQd4N0ugQGCoC1Ajfka
	DnFQ89qQTs34dLoniM1fvDTpwyH3f0R7l+cYqo1SFZS6V/RtjF8mgam3LXbL5QrggO7tjHYafoQ
	XQzVeWSaGqb3oZT5RNOKOiyFXnt2wgVXAVWDNfc1gP0Vjc8Gb/dh5rBfaqAX9WcesNbYwH5jyO6
	eOko/AYXAaQnkcduimLJjP7FRksWRWtBCw06UpmuvXEq3BMwPCgE4t7SsvIHJwSumz8Vk9ANZ53
	IRtWIQkIFs17UuAkIO4C6IbkUz0uICt6u70M1gEfo/c0uaDiEexUX8ImnUaDXgZh7JCkX0+Fe7o
	kBpkQYKwZGPglpTHNUB/QDWX1tLbRr4dDk2Yednwa5jkYwrbIBumd7nYvp0mTZKnPtELQWcKbrN
	daYOKpS01ttuAD9Ebw==
X-Received: by 2002:a05:6402:84c:b0:6b1:8316:ba32 with SMTP id 4fb4d7f45d1cf-6b722462bdfmr945767a12.17.1794138455254;
        Sun, 08 Nov 2026 03:47:35 -0800 (PST)
Received: from Desktop (p54afff19.dip0.t-ipconnect.de. [84.175.255.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ea37e6sm471177a12.12.2026.11.08.03.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 03:47:34 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev-bot+sashiko@kernel.org
Cc: razor@blackwall.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	vladimir.oltean@nxp.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: fdb: hold hash_lock when an entry roams
Date: Sun,  8 Nov 2026 12:47:34 +0100
Message-ID: <20261108114734.123965-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179120418105.434549.6770789108608147842@kernel.org>
References: <20261004124254.3525496-1-julius@bairaktaris.de> <179120418105.434549.6770789108608147842@kernel.org>
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

(Resent with the lists on Cc; the first copy went to the To:
address only.)

On Mon, 05 Oct 2026, Sashiko wrote:
> - [High] br_fdb_update() looks up the entry with fdb_find_rcu() and
>   checks it without a lock, then takes br->hash_lock...

Agreed, the lock would also have needed a hlist_unhashed() check. The
patch is dropped: Nikolay rejected the lock in br_fdb_update(), and the
fix moved to DSA. DSA looks the entry up when it handles each event and
so treats a deleted entry as gone:

https://lore.kernel.org/netdev/cover.1794134495.git.julius@bairaktaris.de/

That series also handles the peer-site finding: a "bridge fdb replace"
that moves an entry onto a DSA user port notifies no deletion, and DSA
now releases the host address when it sees the addition there. The
MAB locked-port and BR_FDB_LOCAL findings are pre-existing bridge
issues that it does not touch.

Julius
