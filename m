Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437514;
	b=sBQVnrTrwY6oc8c1UtnWEIV0N9nedU4I8JTExmlN30INrnVhpm6o1m+RwW7ZJFguoMpQ
	 +CZ5pglUQlxIjYO5PH/DiDpXj1cHbCVaZpAdKRqpw8QQhy1xhK3nx6Ua8IQLPhreVj9RI
	 hPCA1LWEEgtFJsAHEdLr5L3TO0ZtU3Okbrik3kBKvgThWRQvvptsYCn3AW7yZEF4Feqzg
	 4VVQWxptNuzgan1BrV+/RMgl3PYdrCVKcflPGOO19U9RoHVUZfi6BSRgxjECq87mUbhek
	 1MrpLA8X5uAwTrw9rTuogFtGBswWb7MDLPnFTgRyyUA0inXNASpk+henU+hdAPsaznA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=79ck1+vplnf+OrqiJIbR316gc5vOpfUXfVT8Q6jXBBg=;
	b=mZezuUEg6K4Cd6qKKaMFBfdHMok1zTXsoRdHUf0Aw9JEBAJZKghC3bhzeICa4ovUnvC9
	 4piNQkQ0gxjSH2MDdAlgCy3KrdQtNrVWl1YLn5YFkaonJU5e8uDn57VGSx5VPdWRfMOzS
	 MMNO1q/AiA9nttgqFHVV0srG/0NGqMd/UnzU7buKGZZSVj7RTpuyZk270+wR0D8R9NtsY
	 FndyyH2L2e8G24q/Et4oj9ynguBUMCmGeXc6oxhEoS7jbsgI9AzM1ij8yrLVXTf6tRWvw
	 PPgtOCLDXY0h1Z2e/Bn6ZXy6CmzN9LGXE2pcsNtkkpEdC/8WK9iG0awQc0WnFDNTcgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bmG84sQ6;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76364606A888
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76364606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bmG84sQ6
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b66d1a08ccso277064b3a.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437514; x=1795042314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=79ck1+vplnf+OrqiJIbR316gc5vOpfUXfVT8Q6jXBBg=;
        b=bmG84sQ6jOBx5Z1z9eiqgOqzF0G8a49vw2wPdyPszzMsTt7FCkfkAumUU54CrlrSDT
         PeLNPVl4JYb0ZWMpPKqjUnU5JGWs6hH1zxFRntKvVnT2MNYr+lmcstg/A8uXxtRP3rKG
         O3iMMDAOh+rRptveXwnFSlFHPOLBPayAvuBKwGm0bSZ1hUqAtoikIMAGfdXKSIPqq9jS
         mZITDYkY9hKvMztmURdKb2OUOt6LFgtuLdJS8Lq+JfoKBC85y8FGvpX/q3nsPhKilMla
         AQLn7aR1/8nqYxex0Ea9GCB3vrs7X8DvYYmNTMU1qa+KuaSfi8goilPXbxzJM5FOHHeD
         bH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437514; x=1795042314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=79ck1+vplnf+OrqiJIbR316gc5vOpfUXfVT8Q6jXBBg=;
        b=YO+xC4dRSHHA17VHBSauZuYZ1K+EVqU9XoxHuvo4K/pK/uTmhl3hNILXmrEsPhGnOr
         cn124nQOU+D9wrtFTRRn+FhXH0kejaaEDTysa1T7HS3ri4ZGLNdwmwfA8hz6M1HNgGBJ
         80NioqZtxLypTQSRmkklwVXsGhU6zs3PHdB20GF33L0wt1dzi3XXWfbwJ0e0itHh4+55
         SIa+a+2fB5zouwIwD0firmeywTDMidIhfME2riWV4sM83nAR8WlZK5eh2Rye88SQ9dLc
         BUTvRguF2I41e8xLaGGu+PVCkivXG5BPvwUTc90k0Pdq1c5JroBNCCyznYsUC5PLfQr5
         ppew==
X-Forwarded-Encrypted: i=1; AL+hErGL9FU3CSOQtjrAo1HhKEgAFC+WRSK3RlLoDsHsGmUg/Iuj+KosTer2kv7OOHtjJWH07RlJVT0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9R4Ly2f3pnAfibeyzearSfNlsA4iZIbNKJlu63sn8kvXp9a5An
	G9gWqLlciMvOqIId/PrBepLr366pHMHzT6WcF9T8o20jBCLJa490TLni
X-Gm-Gg: AYBFou2XmrE5pd8zm8AR92v8gM1iSB9iRGqryCb+W23ztgzS7qvO/McbJgsmTmmlCg5
	6HPg/m+QD73h0lGmrH/MsfLHElfPsC7cqiAyZz3Lb0ggEotzDFbd9upepUEXnNj+pcWXlk7Zg2w
	x+gcBBaLrHhITAKbJ4KS3BfRRn9c1OvDLQcLwppmNVWwug8C6oqyzYTdPm2rkxpsccKALZP0kPk
	bbGhVx9LX7NMlqaqA+5EbXFm8VVYKOB/jANevg0RsJZWer0P814rZ7RPF7D99GGIj74vjO1MYPu
	grM79bV4uzFpKUtvVrK8EdqFT0PyoAtIRM2YIm59FgEZ47naSh92siZGC8QQezGuXzf+WfoBhdQ
	unLS1si7IbOkA8rzR4r6i8CLZnMt/ReBES4shVe0FZf6QjBvZJgT49FMV9WIzCKLGhS8oa0oBai
	hn2wR2pSZhPE1fpELkczPRlX+FkRZDgwwJlzb6Im5mhs7uGnNow3JFdfZ7a+YvECtrtK2sWQViK
	+qhkKhFQJ8oOssKPBO/tw9MVkehVTigO8CIZXSE1BpWA28k5s4GupiGrhYxMsgNvrDmPsE0narY
	0dd9ynAlp4l/HEKIlNpRW37KvNgehiC1Wy6i49DN9xVIgz6Be6v4fn74hFW3l25mODmtcasFyhX
	845xKzXGBeeR4RQ80nB5tc/7j7IsaVX8dNUhQ++KWOxjrW599s7dVWxNXTwicgZaBGE4FDxJtzf
	TGJXkN4K2bnWG2ZqasQmMCznf180cN7ru++DX+Qtgw
X-Received: by 2002:a05:6a00:23c7:b0:89e:71df:d6da with SMTP id d2e1a72fcca58-8bc196faeafmr3981172b3a.5.1794437513734;
        Wed, 11 Nov 2026 14:51:53 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa86dd0fsm2471575b3a.22.2026.11.11.14.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:51:52 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Kirill Tkhai <tkhai@ya.ru>,
	apais@microsoft.com,
	hargar@linux.microsoft.com,
	rlmenge@gmail.com,
	egoriluk@gmail.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH net v2 0/2] af_unix: Fix scm_stat.nr_fds leak in unix_dgram_disconnected()
Date: Wed, 11 Nov 2026 22:51:46 +0000
Message-ID: <20261111225148.88506-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This series fixes a u->scm_stat.nr_fds accounting leak in
unix_dgram_disconnected() when purging queued skbs from
sk->sk_receive_queue on disconnect, along with a selftest:

- Patch 1 splices sk->sk_receive_queue onto a local list in
  unix_dgram_disconnected() and calls scm_stat_del() before freeing each
  purged skb.
- Patch 2 adds dgram_disconnect_fdinfo to scm_rights.c verifying scm_fds
  in /proc/self/fdinfo/<fd> across connect(AF_UNSPEC) and dead-peer
  send() disconnects.

Changes in v2:
- Drop MSG_OOB patches and tests per Kuniyuki Iwashima.
- Splice sk->sk_receive_queue onto a local list under the queue lock
  before freeing skbs so concurrent senders cannot extend the drain loop.
- Make dgram_disconnect_fdinfo a standalone TEST() instead of running
  no-op fixture variants, and also test dead-peer send() disconnect.
- Link to v1: https://lore.kernel.org/all/20261106051905.218638-1-sidchintamaneni@gmail.com/

Siddharth Chintamaneni (2):
  af_unix: Fix scm_stat.nr_fds leak in unix_dgram_disconnected().
  selftest: af_unix: Test scm_fds on dgram disconnect.

 net/unix/af_unix.c                            | 59 ++++++++------
 .../selftests/net/af_unix/scm_rights.c        | 79 +++++++++++++++++++
 2 files changed, 114 insertions(+), 24 deletions(-)

-- 
2.43.0

