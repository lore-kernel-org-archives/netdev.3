Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792866089;
	b=rfPi7BKGKWTBfB6MKRSuUkWVIlkatgh/bQmrxsgfVd04X0zIC2K2QfEa5+7JT79IfviS
	 RdCGPDhz95a6/u/vmcufazVT8u0yGl9/psufVuG1QfIad/2OL5n/8mxHTfVC/C/veqrzm
	 6xZgFVU3MaqlSFpS1ZMnBNtYtOrUtneq4hpJBehaO6QKbn9r/Ru4SVdsysQcszB/Gn0Rl
	 s9WHTCOyPX/irJvUOhlFZIX0I/Xpw/hl7FMZKF75jGhRLKRZvMfLhS3CjbS6ncuIhsUBE
	 TJGYTIeK1RbtpnrQ6q1XGVQeVl5sMXsH3S75B71mP59ukl+IfYBV/GCydz3lOOpKnGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792866089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tnWMP+dPC4jAvQQAcsQzyieuynX50OBlfcZb/HMCvdc=;
	b=mc/5SsZbdm3mr2kgMhHqzMVXPmWQF18A8z8PxeZsoM3pjUxtKxcBf0rT1CCuEI+P29B6
	 XGFKQMvq6pBnI9lJPqmjD6n73CwoRtBSu6o6Cr5lNLIjSNrVdIUvT/dVlGMHubpON/UsY
	 ao7dHdrCLmO8C1EmNt/EgJA8+i1dDcNo1u5uEMBTdFGlbdcuuT7AACv2neGpKZifrLkW5
	 A4I1hQQ1yn4/ZLbxDUmhruHuUchuZJ/yDtiyDzBmXXfxr7tZEk9qrHV1Uk1O3FLAXgbNX
	 e+ozFA+/A464klIdFP0i+7sLRvOtMDTyAXoMg60tLldrCv9DhORk9OE9wY1qW67Aa7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EnrmlxZm;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8EA606A31B
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 18:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB8EA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EnrmlxZm
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15ea896ddc8so3102437c88.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 11:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792866088; x=1793470888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tnWMP+dPC4jAvQQAcsQzyieuynX50OBlfcZb/HMCvdc=;
        b=EnrmlxZmo6vlijW49ATP7KLoUG9bEwCrhuL99N4Qx5LWAiQmTJFDrg4x/P7hJxSiki
         JqjtcOqezLBkCyBdeW0aAqNN6r33SSLuhUXEADTOxrwn/xkPJ5A5PkcVNSN6wSEPlkzx
         eDdMH996EuWyZoUjMYkTVofhSk00izOTAyTv2+VVZ8gy+cLmFmnS8/CixMIS/ftejvlx
         v9//BsLUOVlbR/j3SsSjak/cI953bu6qe8JUmvoYs+4sBgkXcAkfMwtuuZAj+Cx+Kxn9
         JlvVaRqk1rqEdzN8Xi4KQ6QCYXsUn0hhnYpdufqMF5tle0+F3VbesQxA24/mIiw84jNg
         p3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792866088; x=1793470888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tnWMP+dPC4jAvQQAcsQzyieuynX50OBlfcZb/HMCvdc=;
        b=Dz5ZxrpvsAYgy53t75w7CbGx5ycRynLX+eiR8+xqankRUVQ87eM7L/CdtOq5E8jRPs
         WglhepZyu2bt3/Q/c0/yidh+GER8W9kHolrnVD6ETpqugJ+3LthWw082sCMi/LyA0DPs
         maJZu2o52WtfT61pthbzpudUYsqRkELMMI96xBGwZwzPi76iekzgj+lDsaiCuKQZvO4i
         kZl3JG4zFWLGG7Krhcj0TJ9ZxA/pCWfAP53DirnmYU5U+AIgUwWp7IWTuE4rzHIMt8c3
         2nEmPDxE3ZJejsQuhKY8nyhmdK5O/juVLodWXuaY32y/31Afc3AK9CREkEFVD1peA43z
         mqoA==
X-Gm-Message-State: AFq9FYJjdhKMqZdLeIHNzjFfC41WYnzkSPFBDPtK2ZQMGrR1M85KeBVu
	c2diUpshvm82uuJUOiDNIqCQpnhkuEKT5mn7jtwDCauuueBVZTDwpbEbgiRG8ew8
X-Gm-Gg: AYBFou0437dFQdASiVJfHk/wpOb1QJl/TI+EI8GUm0Zb8EZ214ZiBWH3hUbYU8xLSLM
	q1vbvQiKBBFy7kVjp/ZEZ1IC/4x0FWqiE3jF76DdPZZH9vhDKsSFSQS+eksLC2CSLPWdUf+fcuY
	etnRNeesvUrbTuMv8RWGmsdOQ0afFSFLH2qvjeTJ02HIlTHT/cqMxmkXQ7ZENy2ywIJ62IGdEX+
	tDkeAbUWjxJXeh2aeRbB/l+a80Ed9cgHUo3Cj2+yONK6MArWuv/KAPYIvOnlCkbBnIjrtyECFJY
	/RLjJHXAI2jNbaQ9oHwjjscfZ5NwVi9QeXo8guMoCI2ceKoCkfwruKgb4l9wbcHp7wLe5+1npkk
	f80M8DlnHy9Tv7L27Cbx4s+EL+52zmMHvYUyottgufbNtG0mHrkhewOBzloxLU2CbPYP5jI0PVP
	NCa3EwnTnVmBkRvjivh4QUCcmFqLITmoq0vQ4yZkPjSK6WbOkaJHoAfrqzyx0jpA12D62IVeXkK
	Oqhxx7+PgXmePN96pramjtTvayajIjCtIPw6Ne45yz0ytVsmZmzpXYb2KtY+rQWuBwoU8EOkjVb
	/xWX/g==
X-Received: by 2002:a05:7022:7e0b:b0:143:2982:1043 with SMTP id a92af1059eb24-1993639f0f2mr3810907c88.36.1792866087710;
        Sat, 24 Oct 2026 11:21:27 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm8174893c88.21.2026.10.24.11.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 11:21:27 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 0/2] net: dsa: mv88e6xxx: 88E6171 stats fixes
Date: Sat, 24 Oct 2026 11:21:22 -0700
Message-ID: <20261024182124.296988-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
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

These two patches fixes statistics on the 88E6171 present on the Linksys
EA4500 router. These changes were found during testing using a
resurrected version of Andrew's dsa-tests:

https://github.com/lunn/dsa-tests

Florian Fainelli (2):
  net: dsa: mv88e6xxx: fix 88E6171 statistics snapshot
  net: dsa: mv88e6xxx: fix 88E6171 statistics type

 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.53.0

