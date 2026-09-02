Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F54854FC
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350013; cv=none; b=ItEYJLMkF4r5ETECt+uZzuNAJUB8RcPyfrhxJcSvh36y8U92YVEAKmWDIhJrmtRulgoClZsY/+tCebWNNI/EWiT5SnfOIWDT+uzX6hLEao0yb/G3wsMUhnRuUoGo4AJ97LtVZekB9Pd4ReCiAT/D/QXXH7mSjpR8wr2NDQmf03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350013; c=relaxed/simple;
	bh=kQyWTKL+sEk361d+eKwwxIfLx9+6yokYO0HYcuHWLNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRiwuhDdi6XD8cS05S6JV/byF1mZSQIG+OwJe0aCt7jwKlFVzsc+eun2CiRX0wDAoTt0KAO9CXr1GbG7Pb6XoIliTvlHyDICTNL5BM1nitTOvum2J3nvLp8rNVmQci4UgbvQ6WDsY+bbc6k/jqnbszcTBRH5sn3BTY50jH7pgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bns+FcVl; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bns+FcVl"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so871307a91.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 04:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788349999; x=1788954799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kQyWTKL+sEk361d+eKwwxIfLx9+6yokYO0HYcuHWLNg=;
        b=Bns+FcVl4cBip5L8Ge7Ze2kHDKakek3TNswqeS7JuFoBSX1rkWVDXVv4qz7SzgTfpN
         iW4+12PLYkACGhxO87QyRQ/D/hxqMX/6U2MEsPeaC27H5kkhQjbu6nKeyLORyrDqt9ND
         ci9PEC5Ko7iL2kC5UDIm5fIqYIPUDWUE7Q22VNRHF+4y+j8oTBqIIpJZDLFj9y61j7NU
         99TTcUS3ypk4chghOSCm/Rj4W5LN85hkMbhAPM8lqlPSo0QH6AZy39huyzNh6IavPjN6
         /fcygmcmcRPF5QcOTw1Y2drwXsVvtv8t9sIWD9jsIVlxpv1w9ldyqwEFgaOFDu9hbTX8
         n1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788349999; x=1788954799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kQyWTKL+sEk361d+eKwwxIfLx9+6yokYO0HYcuHWLNg=;
        b=QKM3aAwd5imzhxXuqfQgZKenqwstoH1Bx50dUwoSFNT7g7DUvDxwhbXq16AtILEbCl
         aJ1EvJiSV1f3IEM6wlrmiTyjVcWZZ3t394G/B4riFXAzMug6e9LYooTqi5c2SSkLTRnz
         Y4Jc7A0lTXfwIQl6VPYkxmke+sojK2PYKzWbLy4e7BFl0NhwK0e4P03sVamE0rUZmRjU
         6Ic9gefyY/0QZj/qqlhrCUJth4dbfsHtRkFgNuZpvTysXkHc5FsPAZZLPyWQ8ng63Mjz
         vinEhLvR0+0+3hngoRuMf4d83PUiwoxB5EWgH60UKj60gbDkz5X3xPTvh6YeLSMjh/Rm
         gdcw==
X-Forwarded-Encrypted: i=1; AKwUvBwuHauvTO9ORzSfDC++D5mA8EESp1bt///+Yb/VFF1EeMJaC2KEKK/QaEN91g10YbSXkxibkmU=@vger.kernel.org
X-Gm-Message-State: AFuF++mfKhcYnZLq24ktwvGbHDSLmMqSvDbjcU4LbEaLu6rATRw7WTLS
	M8x6VjczvFiJT6hVBuHub9KwDdcJIC3rcia/OzYURaTBqtlh9Gzun7Nt
X-Gm-Gg: AYBFou1whXmvXHkID7hU7QJkeOxuPJwwOHtFL4tmM2XOrYFl5FZT57WbjH/W4VNjz6o
	q1/5bF6Dp5pSt5wb05Ajup3K0T1tRVDdJmKNCZklcraPHTYbt1V5nfmvPGroUFxrRoaU4Gzyexh
	scABu5g8QdtJVsQXu6Gy4Zj0KkP/puDrCy2KIhYRju2WP7GUWiDferJ5bVDwJnRWZ9+W75HXcQv
	MH4jBf+PN/qjF5DOPvSh6ChYlzN6pdw9d6tYGY4V3m9NfjL/wRQrQdiw3aVoB0N6huyy+00ejOj
	bTUaTNS565zLeJNd0s7UtgZs3AyK3BD0rTMtO9LfHTSo58ieTpbukKa7xFYNBbL02mdFn2tqHSB
	oKSie85cGo2ft+K42pNvROwJOoDl+JxOj25q7XdtZ+znJm0vsg7tb0pYcoC8xwAkPc/b7lF3nb1
	0S7/2zrzUIDKKemleY1Tac8iMs8DFqs6r36uRxaKt2Yqiryca9+KZkqFmCYdjRYgfJBcJYw4eom
	TY=
X-Received: by 2002:a17:90b:17cf:b0:398:d286:344d with SMTP id 98e67ed59e1d1-39aee178e92mr6171529a91.22.1788349999114;
        Wed, 02 Sep 2026 04:53:19 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1430e9ec9a3sm8352811c88.3.2026.09.02.04.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 04:53:18 -0700 (PDT)
From: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
To: kuniyu@google.com
Cc: hangbin.liu@linux.dev,
	liuhangbin@kylinos.cn,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: ipmr: Avoid memcpy() from NULL in nl_add_rtattr()
Date: Wed,  2 Sep 2026 11:52:54 +0000
Message-ID: <20260902115254.3544355-1-nagachaithanya9911@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAAVpQUDd-HeM4XTufJsBchZq_Lb0in188aawzZUYPjRAGEzZjQ@mail.gmail.com>
References: <CAAVpQUDd-HeM4XTufJsBchZq_Lb0in188aawzZUYPjRAGEzZjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Sep 01, 2026 at 11:49:46PM +0000, Kuniyuki Iwashima wrote:
> It's not flagged since NULL is passed via nl_add_rtattr(), not directly
> to memcpy().
>
> Also, the behaviour will be well-defined with N3322 in C2y.
>
> Given there is no real harm and we do not bother revisiting this,
> there is no need to change that.

You are right, and thanks for the correction. The NULL is laundered
through the function parameter, so it is not diagnosed at the call site
the way my changelog claimed. Together with N3322 making this
well-defined, I agree there is nothing worth changing here.

Dropping the patch.

Hangbin, thanks for the review as well; sorry for the churn.

Thanks,
Chaithanya
