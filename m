Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3D4418A2D
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804358; cv=none; b=MwzaQ0qPbPCm8UXfVNQaUKrSdiGUtPBHjmMocQbnZtjl+2/U2ftkbKsTLqjnSY5R4F7TmalKuAjEAu6jWRFG59KPE+8vfSwQdrxUkgpx3oY4JdW37mg24yXolUI0lU9XEgwaM7XOSeI2sAZwKFEIlS9ZZVkRVw3hCV9XyyOLnJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804358; c=relaxed/simple;
	bh=jJZ2weKHhkNfXMFJ22b0RW7OCDsQCS4qAKK3lUmiR4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HS4O91p72Y7KDeNpZC8RZJ/k7CBbbPfydSC64DTTWx0lBHtJIqXODjS9UZhsL3mVQZFaT+soSv0ttVX2YxJfKZbfM4tMuWjOmUlFbkMXeLNpW2rM7zoZu6jUTc98VR7Q0J/SDlQFqdxwE1N2v+1iFRcZcfbpBVoJAdLjVeCDaVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIeYh1xA; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIeYh1xA"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so2344681a91.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 04:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791804356; x=1792409156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jJZ2weKHhkNfXMFJ22b0RW7OCDsQCS4qAKK3lUmiR4I=;
        b=JIeYh1xAiGNjN3AvWL5yfzL4h6yWxGfQ9uPB4TCUAM+4I6Czbd92KK/k5SRCsJSJ7F
         +Sf269kZD8JHzaXxFPfqGtgpsrDXvi8j5LvK98zEFbudKpPYNZcfSNjtCr5TkXcYtdJq
         5+yqVmD5mtpFwX/My0N02WK64WpE8UgcJ9SyzCoPLg8jjM1m3+wt1E9aP+vqwul4fk+b
         j+deKZCm1bWFXAPmiBN4LX5k8CqQdEb4ueotrF1rxUUuKwZ7SOtbKho3qrNKFJkzfVg+
         tzKHgzR4Houc6hGo0FQYDto2Gc/W3lfETkKkogUg0RgSzt1JklA6FKUHCYHp5OiQHsEL
         HwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791804356; x=1792409156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jJZ2weKHhkNfXMFJ22b0RW7OCDsQCS4qAKK3lUmiR4I=;
        b=IEaRXk3y8nalxY9Khrk2ta0tZL7dw9iLRR+I8yUiFofAQQdPB+FotUVqEFWjvXBYXZ
         0545RZgyqgV8UnJN9Q8BTtoM3WPrrDHIDo6JnWFCkZTLMEldL4zmsMQQa2CLacPx0H7r
         9ZWOYvsSvlz58HULyob7JzX9KLIoWJCqUWQ5YNT5gEIFuYS8d5c+tZTOpELB9Kw+v8yU
         BzGvcs/2Qns2uNwy0mBip4AerIOmOMOoLq4vbHTRMhulMD0OS0/zqJqVd2pqT324PJjI
         zBhISg1fow5v0ZmhPVKqr7k0teorKG/hA5R8Ddg8BMHxYvm06nWYIRAn7TXeRH2Fk1Qq
         QvZg==
X-Forwarded-Encrypted: i=1; AKwUvBycrQ52PI8r0E6W7ruFpTqsPWvSgw0beeBxAl54sPDm3x//YHVG0BGLgYLFo6Ihl+6o8zSCimM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHg2zT4bIM3t+51B2sQXDnrGvKJlyaiSRmHaioWsfEOM5ooqG0
	Nrpr1WuI7lj6nEf44vH2sVGgRj3eOJ61wSQ3gF1E/e3ceZSvblTPrAXA
X-Gm-Gg: AYBFou3nX1k96/T1DTzPYYBbfk1DUWgyytAfTM5piPjBRcmfYRTaD6a9jK+tQgfxT2H
	+owaiFPXkr8s9CJu+I+fcB8K0b00JPGtFqySK0H9PCOgmGsz5+34a5KDxYMLjjmJmeJ0UgTtbdm
	Ex3iWOSsUjyBwQJol07DczlwSUDRJhMd+AAHzexeQUf9aPwdc6v2U4qm0EMAhMGN6UySXqEZRGP
	UI5ytVwyBCo+rhoLHCSE56A3tXxa/TLt6/8Kzb5wwf7ZRyBF+eDhWDgYst4oUZEcQnf3HBdNCDS
	3nl8veFKHwDFpkekAnN1gthzYZOzOv4dYRH9LIW5+4EVzPoI7btmk8YvimMzvmItoYaycMBi+0i
	MO2R3jpBAJlzmptzz4j6hXfuIxSqDY/YRyRgiA7vQ0qvL0UtrmJw1YeMLOEgr2eE31PsMLdhJAx
	Jjnig/y28qtXrkeChmV3HfSXmV+UHVCxOGWv/7NtgOycGzc2iv72rsJBHI2eET8DWft3q2Ft4Lm
	LeB/eDuFB/LS0kAGW+Jy9LqfFo=
X-Received: by 2002:a17:90a:e70c:b0:3ab:1a5:cd2 with SMTP id 98e67ed59e1d1-3ab3ac9b310mr5103674a91.35.1791804356368;
        Mon, 12 Oct 2026 04:25:56 -0700 (PDT)
Received: from obadmin-Precision-3680.atlascopco.group ([167.103.3.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab396620e2sm9808526a91.3.2026.10.12.04.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:25:55 -0700 (PDT)
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: test tcp_rmem lower bound
Date: Mon, 12 Oct 2026 16:56:34 +0530
Message-ID: <20261012112634.3371756-1-sahaj123.sc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9b4b59ac-6e64-4dd2-88c1-c3f7844bbd36@kernel.org>
References: <20261007054508.1059927-1-sahaj123.sc@gmail.com> <9b4b59ac-6e64-4dd2-88c1-c3f7844bbd36@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eric,

Thanks for the review. I agree that a separate test for each sysctl bound
does not scale and that this focused tcp_rmem test is not the right fit. I
won't send a v2 of it.

Your points about the non-portable 4096 assumption and partial updates are
also noted. The generic network-sysctl test you described is broader work;
I'll treat it separately rather than expanding this patch.

Thanks,
Sahaj
