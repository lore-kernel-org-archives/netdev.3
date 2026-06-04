Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A63BBFC1
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615242; cv=none; b=cW/JX/R4xOB+W24HrddA2c4Fn+tmjLM247DuFaCmLlwy7bak4MLptE7+sEXog5xCjL1763Zc+mdSqo86HYd0XHaHIpBs87i6gr/MWyGixmIAyBu3sCAYhABfPKB6XRw156+Fq8uCwP9ygZdOuFkV1MeKwjuFTIXFeZQBQcOj0JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615242; c=relaxed/simple;
	bh=5KbGAQnU1LUTmYDxmqgD9KiE/ny5+U//DZK9fmTYErE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZASiQHJDVH/tj1nE9FLwRndfvpGK5Cimg7cUnwe33Qf+5tJ9nJiki1gYmPxsZGIrDkiN5HYiD272zfCQb7AD+8D7YPkzv1ackPLOLXM3GKY9M9V8nEApcmhhJXpyFbfnwbfddsV8Jb+y5ZacRJUa4dOfnUKme27AlNtQKwa6osQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=c3xSFLjQ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="c3xSFLjQ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef6565cfdso684797f8f.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 16:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1780615240; x=1781220040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OVg1AyRtjY/5nIONDyIpivos1vriwmOKtOXnyNgkiY=;
        b=c3xSFLjQsv6PpRfdZoG8PSbIHSrvKbv5ewshbDMRSpTCC8RPkt/S5m6aIImu+rXqgt
         hiza6JotKYjA1oYe10Np2zQfIJbS0H3ElwuwXO5EbdAuwkVE3occmrFwH+UfANnA6XU4
         WN3gyf2jkPxEl1BFQGuymQ2Z4o8qOsgQX7utZaqRj+N6s0EUeTn4+gXW57/TjF41kyfn
         I5SHwNY09Ee1RxaUWtdGpoCiF1FEuxY7LROGZMJxq9n0f3VwPRc5exPbZ1JA1pCC0PWN
         jBu6wrjtqd7NaCuE4n656vic2Q4dTTBtjeeUEhVSiuwqebVuMAwO8fxz+UXc89wfB3vV
         PUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780615240; x=1781220040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8OVg1AyRtjY/5nIONDyIpivos1vriwmOKtOXnyNgkiY=;
        b=FgehC8+33T20GLeI65x+vQGs44V0rNULLGF03vYK/7rCjX5OA8gf09rzk5JazZ+lgJ
         mClmQpcjukl8SjuQVdXl+3C/fMOtipssYYxWi1b9AqiTYDmqpeO1H107ABR96qehKvEv
         V8XQzPBb1Jxc2jV3AxVEX1nhDjG1eglXb5ZqaRZeiDh7bPaUpv8oX8lCCiW+PZRTKTK0
         IjvGQmQv5ApzTuWLHvEv1J7IM7r35mJpyAO1L52mdj8QIN55quJTbKNQpKEQyeVMrj8l
         tPMCxRDSKZQb2SUsjr0qgPgyYn+tIeriKcb8hkTW29xwRYc5+DIv67eVgE3EDmgpoyCd
         5CMw==
X-Forwarded-Encrypted: i=1; AFNElJ9oNsTElJNwwG239jFCeLUsxpYbaieVKNqTHKYOCCVpkJf0Y5j8dtPXql2CZeDZiBYvIx4KsOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS5KzQTCn1UNHOxcXc3xlzm6tvWJ44M+umvTcZHz8/0cv/bkOK
	VR4zPVEQloQwJUzreADAnlYrN+czEkmf4BJ5MFAkA2n8wdGGfGlSsBXmRh4eBwvOfIlmBb0cGld
	QsEZRvz5Ore7PZ4snovNSol3KIAVFHk6Pl7tcaUR4iMuNWNnpKM4=
X-Gm-Gg: Acq92OFc7k7EQ7bBE2D9hhUKnMGrgmCoPJLIYPg+6UrV4VaPtOyb0n1vW4MnZKZYO6r
	mbwwwjiONCbMCXqLvr1Cv/mjMGcViUQaOxN9Rx5gy+XpTQYmCqdyv99DzqTq1AGcNnFOux6kryJ
	XEvjwwgbXjlEcfls2tYn7vv3cBOBs3BQz/Fj6T9Fobgivp6PzWLtP8K9we3+oC3PO3PP7vUAX37
	9X0xSFYEW1BUI6+dwM0Ru+bUO0KiOfAvfuUzqVOymbsSrSqFOScS5KCaAITqxaeqhdO63e/1o7V
	zwMrFWYkPwFb8qWidapr8V52EB2bklrCGj6tAHb0Dr5u3I+hrNWFk9/fjgjDtbLMCwxb68ODPhO
	/kMiwHIYtVJIzMscil9vnXHQJjMYtyrUit97X4TBniyWGuUa5WPZ/e3K6TBh5P3/vJKvJsgAXmn
	30WvYHTFN1KJw0pbaWpRO0sItKgI22PW/Akoi+rgpwVARKrzYS0SzmDGM3
X-Received: by 2002:a05:600c:8216:b0:490:688b:f9f8 with SMTP id 5b1f17b1804b1-490c261ad21mr8824055e9.27.1780615239732;
        Thu, 04 Jun 2026 16:20:39 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:fa7c:9be:762e:2666])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b5b82sm113832875e9.1.2026.06.04.16.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:20:39 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: longlong yan <yanlonglong@kylinos.cn>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	sd@queasysnail.net,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	horms@kernel.org
Subject: Re: [PATCH] selftests/net: ovpn: fix getaddrinfo memory leak in ovpn_parse_remote()
Date: Fri,  5 Jun 2026 01:20:30 +0200
Message-ID: <178061521511.606049.9561679736600280727.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603072741.1097-1-yanlonglong@kylinos.cn>
References: <20260603072741.1097-1-yanlonglong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 03 Jun 2026 15:27:41 +0800, longlong yan wrote:
> The ovpn_parse_remote() function has two memory management issues:
> 
> 1. When both 'host' and 'vpnip' are non-NULL, the first getaddrinfo()
>    allocation is leaked because 'result' is overwritten by the second
>    getaddrinfo() call without freeing the first allocation.
> 
> 2. When both 'host' and 'vpnip' are NULL, 'result' is an uninitialized
>    stack variable passed to freeaddrinfo(), which is undefined behavior.
> 
> [...]

Applied, thanks!

[1/1] selftests/net: ovpn: fix getaddrinfo memory leak in ovpn_parse_remote()
      commit: 932f10d0ca3acec477a1e6d05d08dc933b27c89b

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>
