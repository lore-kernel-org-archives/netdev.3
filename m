Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDDE3EA967
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900990; cv=none; b=tWEmfCy2rnh0IP7EV/hauJmqBLwSp3cBCJBBsE2lDjDOzLKXsy2jL3yANMQckIAQE3TMNz+qd1sFdnU129geO+rjnL/iNenN6a2GCB3/r/rbcNOx5rE0vLUhosGYF2QrF3FYoKNgYWojBvmCYmR3vZq3aKaLT5Ma4+FmSA6XsMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900990; c=relaxed/simple;
	bh=py4aDXmt5KI0m6G25QV5nv5VSfEcgQunBq9/JV87nRM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=IxIoj2ILM0C6zVrQTVZx9PNmkGg21y4do6WM+CsEAVSigImwNQ4sUJuXQSMJA7T6hzke0pQvWwVfGOhtEq/Ftj1Okh3phksxj7NbQvpXoSmB+pYBDc9qfqW0wRF+oGUyZszRXmBdLj38n3XUXMrbX86LBwZcEBzeA39vjpWnd+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WE0eqy+C; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE0eqy+C"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e8662d5e95so17001295ad.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791900989; x=1792505789; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=py4aDXmt5KI0m6G25QV5nv5VSfEcgQunBq9/JV87nRM=;
        b=WE0eqy+CKmO/K1YIEzPJDoHg1dRrN5B2lkASGhwPnz9Cs9c6yDzNY24ohZRgLN/GWP
         vx1xFHujbtmXw6Uje2qrvijclMf7fdgWszekSuN7lvpVLEGfYlwnoDxuXmazS3ezniYT
         8g+XrfwtdC1uCT5QDyWLU+jYVysR4dUBhMZGZIh/zIr9haKvSzMJ9t3YvKVNkrNciLTq
         QHpQj/nAKSh2o91rtB+IB0HbJWYOOZnohxaDnFw2hpV4339YavKjDRKWRIzmuoWEUVWz
         6Bm6b0cJLFBuftojbhg9wlWUJZ3lxOlFDmKd5N+jJObA5Z9FAc0fRZWRXTXflUEmoMjY
         gD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900989; x=1792505789;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=py4aDXmt5KI0m6G25QV5nv5VSfEcgQunBq9/JV87nRM=;
        b=sPICs9PFurAzd6VKmU5zLjTAltBc+fue6l8pO1W/Km6g7NqEi9Rk+j8MbEZG30shHe
         uZ8sQhnKT5NX8B+34JZC9vjxKUr4fiJHYQssipXc1qtvgdYyCGsJ4oNaCmsIzD/Sj3U9
         dDz8KnEIVEaB5Op3OjfLTpv3QJkSzTl5sB6aO2WsSrF+I5D7LTl+RybSVGPmdLnSE5l2
         LRcj9+8j0lyb0bN5oG/ivT0sPkqWp1TFTot/IzUsyyU4qBHz0uvb9FmGv62U4aXtJqq3
         r1A1YRa6nMHEuy1Vv+CkpwVNFZKMtyoxiJB6t2RKhnmMJo7TaGY//45PYv8pHV4kAcBg
         7ZxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwC+ugk1Y9sD5IreBuHLy1odsbjLupCPTEtqkXvHiK3+5+XtXMmvStsWiwqT88VaAiGZLc+HLQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLufgQWnh9/yddC0TkWtw/IMbmsU7MSWhw6OdQfVG5gG1OUnwGV
	egieJUamRVtVaqnhw789k5Rn2B6rgrjCxl1Jg3VxqDGky9RtwCe6nG/o
X-Gm-Gg: AYBFou3HJAPmlqB6U9fM8b42qhhk0msiAQ4MiFKN8/GRw2FLvjTI3Ke9wl2mpmGCHor
	UNQGlLORnKg4THafNMH/boDyaqqn8bJfUJ92xjChvR+Nwhmj1lRE/liVodNO4A3js/C+u830Iif
	tlqOG/mAoiwFADbtFpJQapeqH8seJK+8Svt8mycEbrQZgJr9IdObNOkBL8YJro0zFYa3q+Sh+7x
	AzpFAiEjnH12HaQ4hI2bTWnsgMV6fxhZ8X2ryXadSc9Gt6vFXeUBmxAHK78oPjwg+noRnc4rLRc
	LXxBpzM1mifmSgtZykt7VF85DqVPA5YIfU4vBLDzKe0soUl45QJY2e/HdjPo75Q0ODn/S2YdJM8
	QV6fS2/RqU55+fdI7lPgw44bY9yygLzWqM5Hb4J9pptxKwFGESJeiZiqyfu1gp4SLxgCa148z7V
	wXJYmsKlmoZmpxlrPok3wZnjNVl/IhWftOh3K91/w/cC/5TmHNKTUTC7DwFs9BggpkfsMZnilSy
	Q==
X-Received: by 2002:a17:903:2ecb:b0:2e8:6ae2:75db with SMTP id d9443c01a7336-2e86ae27819mr89626855ad.41.1791900988982;
        Tue, 13 Oct 2026 07:16:28 -0700 (PDT)
Received: from [10.1.21.151] ([116.98.134.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e90977deafsm12910845ad.68.2026.10.13.07.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:16:28 -0700 (PDT)
Message-ID: <6ace3d3c.c6d97709.27aae3.cbd7@mx.google.com>
Date: Tue, 13 Oct 2026 07:16:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Bui Viet Dung <dungvn2345@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: stephen@networkplumber.org, jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hagen@jauu.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net/sched: sch_netem: prevent packet length underflow with negative overhead
In-Reply-To: <179186709813.434549.16042014331752584322@kernel.org>
References: <20261012044322.503949-1-dungvn2345@gmail.com> <179186709813.434549.16042014331752584322@kernel.org>

SGksCgpUaGFua3MgZm9yIHRoZSBkZXRhaWxlZCByZXZpZXcuIEJvdGggcG9pbnRzIGFyZSB2YWxp
ZCBhbmQgY3JpdGljYWw6CgoxLiBtdWxfdTY0X3U2NF9kaXZfdTY0KCkgb24geDg2LTY0IHVzZXMg
J2RpdnEnIHdpdGhvdXQgb3ZlcmZsb3cgaGFuZGxpbmcsCiAgIHdoaWNoIHJhaXNlcyBhICNERSBk
aXZpZGUgZXhjZXB0aW9uIHdoZW4gKGxlbiAqIE5TRUNfUEVSX1NFQykgLyByYXRlCiAgIG92ZXJm
bG93cyB1NjQuCjIuIFJldHVybmluZyBTNjRfTUFYIGNhbiBvdmVyZmxvdyB0aGUgc3Vic2VxdWVu
dCAnbm93ICsgZGVsYXknIGFkZGl0aW9uIGluCiAgIG5ldGVtX2VucXVldWUoKS4KCkkgd2lsbCBy
ZXRyYWN0IHYyIGFuZCBwcmVwYXJlIGEgcHJvcGVyIHYzLgoKcHctYm90OiBjcgo=
