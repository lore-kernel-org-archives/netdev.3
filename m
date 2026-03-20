Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49A137AA68
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001094; cv=none; b=UT4jv4pLa9B76kZI9dkdeWuLsCCfZnW+1dx8KALlzaTp5snmjebUvkvW4punfmRLLg8oYALZFOmMVN4cuyMlAwka9vHFlHMU5XM4VwTYWqKnNDXT7DXUvyVuKRXl+2jpoIHH+/QYoS9Kr74F/OvX7TXbbmxLk3pLAxxOC5pjHcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001094; c=relaxed/simple;
	bh=hQitmx9hqJWiEf6tonwwCW2373BW+aQyV2LdUwoaDgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8DKd2pRukjrMLaNsCdTYyhXJqU4krcxSbZWQxuj9LB889JAaMjXjY1Y/JswQ3GOOHjfZcmTqWerRUgSJIR4F9Utg/Aj40AuGpO2H1r6qurzYViJm/fa+r183BE9KRoPl6TbHmGWNTh8iSIRKK2ie3GK6mYHRi9dXt5NCVKNRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ctlAYRRk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ctlAYRRk"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so3499055e9.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 03:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1774001091; x=1774605891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6FMvJihxGWwcFH1zdT5Q4OUxqnDCZz29bla4g0kwy1U=;
        b=ctlAYRRkpD83mONyIVGcIUpb4Q8yzxPSDyHUj7kctBmLzwscw4Xk0zH7kAcVhkxn9Q
         8DQ9HXzl8bqBJEceTVbOhiAxY/zRHlgbOBJowhqjQAjuVnQRVXjq59oPYfe29+lSqWTn
         yuUjDU+IoqUcDYF5ygYxYTaZiLepFT7KSxSiwjCLzywogrfqQlX88uSVXQzoEt1/9AB+
         LxUM5MRAkxiMfmbqvWiaorA7fcpLzgp2Wpx3EI0TmxinuS9kj+wk9FNa8YsKUUIGTX6p
         2N4TjUJa9OlmfIpkOO/7TQsxObnLG7vPBRj2unOshh1Ml7+2mVvuquO5pkqWi4wudiYy
         zKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774001091; x=1774605891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FMvJihxGWwcFH1zdT5Q4OUxqnDCZz29bla4g0kwy1U=;
        b=LOB0H2dj+1eunu7CWQiyNTmNBBfOxF8lwpBd0NvoRp0WLSQhe8sfUbvocLYFjjOVG4
         rQZ2M7JqSxpp8c11c/bqLrgiJs8LXJdPBX0YYs//U54RHLsskWyDCyPi9ZZHcfbLyld1
         aiZPyLCFt1jTB9SdroNwrwc4oXeqqSyd+NbaIgL7tw7bmIytSM9Gs9+nqIl76s9N/1N2
         AwkK2eSoLMyNc95j6YoXEbItRTqVJzIdOrWz1964q3y1099axUM0r/TWtPh5AqkcNetq
         6+NNTpw1OtfaN0WZRpy7/kDtjFq2pOMdY/6xfpUtKQhb/ETydq787Wlg/G3mY1Z441Ww
         DfQg==
X-Gm-Message-State: AOJu0YxsNBfMEeCRaHo0V4iLb87O3OG3nuoqV0ZWsQ/V9wwhgJa51nFG
	sqN2ulYX6Y1N04mYdKXmHpwO3AGU8wKQcg4I4/HX7J0sWSrM3osAy/lxV0ocxNKxSX/3JwZEV5s
	8mMFAj43RuMmtS2DDcEX/K7C9jlDY9O6i9BJSOeEwqQaphx/p/aD4PpXz8YZjUN94
X-Gm-Gg: ATEYQzzfOYrZ4n0GvLHh7x4PsYgktooSQ8fpNanj70Mxr/hFi6pO6+nzA2WsR2ywWfw
	LyWqwy1ybsuDWkNpUjVLEhZDelRQYZx6JH76yzN0JKTBQabi/zZi7pMIOE6Go/ZIZdPAN8iL5W4
	ENvK9TtdoreZ28rcU1ur5yK4US4hmOnDWkePThvFVllLrS1wRsUCKhP4ksEIRPhhthYUnWhTBeo
	75CipgnZ8ny3nzy0oMoVLgL3C0PS4lHYfr9Kyrqa5LLYcGQ/SM9lMuHwjPXoNWjx5tvWFBCwHsl
	R3+uBvCcPU7BfA0YY8YkeyysIzjbLQbitYUD43JNQf1DB/vnPwdO+9y+IqxF03JY1jE5Q38kXXc
	C6MgL/M2uifpOTXSj96YRmZtIjniFRaDbOQZi/aQkD/e9ND43ne8BelwIoxQD8Qq4zFYVV4mef1
	tInITBnomkw5djtf8zw5X3tjfeWJpNK9NBWWYkAmADRuOnuRk=
X-Received: by 2002:a05:600c:8b24:b0:485:3dfc:57c with SMTP id 5b1f17b1804b1-486fee0fcf6mr33824545e9.21.1774001090559;
        Fri, 20 Mar 2026 03:04:50 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b932:6bec:9a0f:55df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff109b95sm30283915e9.1.2026.03.20.03.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 03:04:50 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 0/1] pull request: fixes for ovpn 2026-03-20
Date: Fri, 20 Mar 2026 11:03:50 +0100
Message-ID: <20260320100351.2283994-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello there!

This PR includes just one fix sparked by Hyunwoo's report (and fix
attempt).

Hyunwoo found out that adding a new peer while the ovpn interface is
being destroyed may lead to an interesting race condition.
The proposed fix is based on upon Sabrina's suggestion.

Please pull or let me know of any issue!

Thank you,
	Antonio

The following changes since commit e7577a06ae28287ca415aec5c12277e3a80ee372:

  Merge tag 'nf-26-03-19' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2026-03-19 15:39:33 +0100)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-20260320

for you to fetch changes up to 9d0bdffbb5d06fa2aaac59a479d9d288a4a1c7e7:

  ovpn: fix race between deleting interface and adding new peer (2026-03-20 10:50:47 +0100)

----------------------------------------------------------------
Included change:
* fix race condition between interface teardown and new peer being
  added via netlink

----------------------------------------------------------------
Antonio Quartulli (1):
      ovpn: fix race between deleting interface and adding new peer

 drivers/net/ovpn/main.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)
