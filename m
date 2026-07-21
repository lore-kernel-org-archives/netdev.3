Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9749546C4B4
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649773; cv=none; b=mRfRbTDrEYz7t9314WrEFvThtREcHAIiabB6LMyWxNeh42XwjR92rm12byAe6UG6NezKPJkm6njNcYWS2iLUr2e2bGPw6KuwKGBquW8FyJ70+NwlUvhcvdQSfA6bZpSZhUVqXX14iulKwZQvVlyQSMrycKZdCkH9TD+T2MqXMkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649773; c=relaxed/simple;
	bh=vhhWzyN+I0N7rNZjufC3YRpB5qa/zvBfQPTyWRUEH6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1sz88v/a6FN7/5hqXSN7AIAupYhl9QjB7zTjpqUMkROoaB1cn8+qT+MjGX28j0tXhzwvt+ouY5ZefcbrwKKOjs931F+oIntmzVgeeuLyDsjoRMIYxamxyj2mi05VxXgHv/Hk/3zNjkKJpMLMZePHqM7f+xBjcFfsJNrD5ZsZ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaKWe8Ut; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaKWe8Ut"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-97715c7df46so333025241.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 09:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784649770; x=1785254570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wE5VX25D0QUPiT5vUwaJH5UHOU0aSZrWQyQNqql837I=;
        b=XaKWe8UtPYvooOlORnjrklQYM4/qHBwoyuJ4a9WPP73LKEQ7e5xmAdXiCccBgFW6Mi
         LKqzAUSxd96RLiVuFmxS7LegG5ZvH3EmItV/ruYT/s0t14mJIng9E/WPzR1fPZuR1W4F
         gt7DuTtgRw9SuDp9Ksh89K7zmg8KEW8RZbkVfXUSvJMiVQd3GoJuLJ7rj/411Ft0SVO+
         FoypJc3v6jFxUKwFF/5GACHnb7abPC7oqJCOUivgZhq8etwhN89iZ6xM1V60diLRSgSx
         f5kI1qdEVw4eZbPLMbraTktqJBIQwYoJjUij0KRXkkU6Vl4DK/DIwzviZ647gsP+cIkh
         BsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784649770; x=1785254570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wE5VX25D0QUPiT5vUwaJH5UHOU0aSZrWQyQNqql837I=;
        b=fwa1J0qOzdbGwZIi6C8p/9jGZkd/+L0fPIjMZHiARHrD7F6tCgetY7h2trRLFe/eUg
         GmucKm1xeIQSwVwM8mHYxAkF9za75I6xl4s3wXZixLany1SmC1XHxPiKKTDZ7wJBydIz
         dYtZw186db/fnDYkYfQQW9KfPOqPQ90EziRbIpqkZdCmQeZEHXTDweExBRcdAFX/RYgM
         c8D0PfwE7g8QvQiCrXHuFdkMAGOdKua8QP9BouNDRovcbvoxQPMecJ4psEbEgebTopvG
         FbW0z3yG3G2L5WZPIwyZmThIXZYztHQZpQ5plpp0K2Xi/ZzUPvP5mFtNGaM4QM4Gu8n3
         5WKA==
X-Forwarded-Encrypted: i=1; AHgh+RovZfRNWXBzemGdyM4q5g8EaB1Z6u238/phzkxOrt5D03HOYTYT0CATKGEijdUNTgYjDfzpQW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz23ll0JLeem7xQ7jkaXaJDNczLmbvzall7+u/6Ne85MJKkeW4B
	cUpUr7A5NNNvGibm6NiqWHgCHKJLTvezaHbxFMeqS9tPKN4cs8uT5tXvJH3yRfPILk0CRg==
X-Gm-Gg: AR+sD11fEUyzH5Ndw/QMI6xz6w/4+r9XfnM/cl2F6ZknTTaJ6wStHV4+2tApHNdjrJM
	5/p9RYCm5d9mFUeafacAReCrD89Nd2eQlIZXsmUFtqcxJV0dfcXRGQh80i/CP3jspsyWzk3BfyR
	EoHpPJCzpwYxO3Fc/LH37GlHySrIbzR2O//XVcmsFzxWBZuclZCZiHXTvIlf1LzMskK66XuDcCs
	EOWL1zMb0UWwdfUpHBOphoQSbzgSryDxabqKIAQJqBV6Sh//bnGfHOP/SOrHIfQqHnVfxXvhPDE
	pkS1cSv0x2tg7D2dPBqFz2ZVEnAxjJwrBpE3BzDSXSosFbcoFuzi4VoMVhivId06EL65SvQiVuL
	ohXvZXZpyqp/ozQHOweqvNCvPU8lb83QUNGjkUtgGqcnDdqiS/J7d4j4bWLJhhhLpgI5fdcjNPR
	W7+DNR5/9s2L67RAn2sNj/8MJVsUbQj9/zCTNEXKwgtAh1a+m5xy0Js7rnNFUPVa+vNG9tHm2m9
	eGeFaM=
X-Received: by 2002:a05:6102:4486:b0:739:4fa1:50af with SMTP id ada2fe7eead31-74753469470mr5448540137.2.1784649767844;
        Tue, 21 Jul 2026 09:02:47 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-74757fad039sm12389612137.5.2026.07.21.09.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 09:02:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-07-21
Date: Tue, 21 Jul 2026 12:02:40 -0400
Message-ID: <20260721160240.884274-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit e13caf1c26587434f0b768193100440939c0fb91:

  Merge tag 'net-7.2-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-07-17 10:25:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-07-21

for you to fetch changes up to df541cd485ff80a5ddc579d99687bc7506df9851:

  Bluetooth: btusb: validate Realtek vendor event length (2026-07-20 17:41:28 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: Protect UUID list traversal
 - RFCOMM: Fix session UAF in set_termios
 - btusb: validate Realtek vendor event length

----------------------------------------------------------------
Chengfeng Ye (2):
      Bluetooth: hci_sync: Protect UUID list traversal
      Bluetooth: RFCOMM: Fix session UAF in set_termios

Pengpeng Hou (1):
      Bluetooth: btusb: validate Realtek vendor event length

 drivers/bluetooth/btusb.c      |  4 +++-
 include/net/bluetooth/rfcomm.h |  3 +++
 net/bluetooth/hci_sync.c       | 13 +++++++++++--
 net/bluetooth/rfcomm/core.c    | 17 +++++++++++++++++
 net/bluetooth/rfcomm/tty.c     |  7 +++----
 5 files changed, 37 insertions(+), 7 deletions(-)
