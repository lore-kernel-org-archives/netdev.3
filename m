Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003581;
	b=bIJS5m9jXmAFp5mPTb+vOFpsiIcS3MtMQSs0K1a/6+d0bS+qOTh8NKGc0OD0vui/p0M+
	 M+lG0bvenl7SA6yFwbT6gTKhVkO5kPb3kquCvC3eIhPxc6iFOBJfmLSG8UkE1MkjlB7LT
	 qijisHLKfw7MTINo2WyYVVcNx/xiNtJGyaNRAxHGOlFVXzqFb463KbOZrK6tJCRn+ICYF
	 6LYCPc13K/Bal1AhrhZb8Pj7YLMlQ+5v3IHKmssshGWiAr8hneoJmC5OZ9oW9swl+wgAI
	 HqoeLXSDhRN4m3Dy085H79ClpzC8jUjZH6hD4SCvIBn0TNy/cdFfuEIkMlDR6PDdcBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gxLuux40dS5U1+s97ZRb1KBWoAfP3Bg8mTsdy7L+DkQ=;
	b=VkHTKnA0cF14gIs6fkY4uNAdKwKv9D5svGKASDjiJOnJBKgVnCb7KqmHLUnC6Rdpayun
	 1Unqb6XITOj7lsaUrqPJHvP6e5cUl6RATnYi/YwYp3yMUiN82N45Df+gtU4g91/6l3b/j
	 PcMT71wd70SxyQc1+mUPA3JzIsm3H3Jp20UOKCWS7vDDX9vHYMtccci6kVQ7Z2DbXZ2RT
	 e1RFdwJwhSip9LdPYGdCHcCZIkv81pYCUIzRZxgPxDYL97VQvlL/p0biTKzG+7P6wegoy
	 Htm/kQ0y0KBE+ytaAOOaII9ncAvdexOGh1q/Qy5xPbnV8dV32wWSF/rsfRNPtxOH6jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=okZ5GNhm;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA6606A320
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3FA6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=okZ5GNhm
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1273432a12.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 01:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793003580; x=1793608380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gxLuux40dS5U1+s97ZRb1KBWoAfP3Bg8mTsdy7L+DkQ=;
        b=okZ5GNhmhtYgoOZIaY3HkOlIYUrCG6S4yiVG3dOOPhCRBgSGNLbIW4TL7BWCZfpT8L
         WGOKra2B+26LTdWHFVQAt8rS/NP4LCxH2Mq+VfRyMV452NB5A66s3YSDsnguDLUsAkFV
         fGitArANeEv7uuK/l/HVheqFjwCWPBllFm6K4adYq1j+ZG0sz5Ck+fznUKDocqOqkcBE
         7tBcGh3UGEMKIwNrwcpLkew3jmPWJqF5AHYk0+ctsygfRhKXBVSGiVDY1dxKHFQ5HQ5k
         vDpdnhOxnqb0nLwAHTRnk610zKqNVOlV5TCLDPDi6YyLpjb+hR08ELX56ftrhUWfUace
         iGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003580; x=1793608380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gxLuux40dS5U1+s97ZRb1KBWoAfP3Bg8mTsdy7L+DkQ=;
        b=lJcMKaCfpZs0W1g1eAdfCcoQnfM8zVYuch1wQ/sZx8UqQlIyf5CXGwNZpB4Mzq67jk
         npv3C6JaT3l9X6mFpn2WzfEKLqRHDNJ6Q5EmUfRJK9HBIa2tWLFsl3Df2wsDVmMJ+m4v
         8R2wKLjHDC9s4uJLHHMXqyAdAhPm5j8DkvflTPSxKE6VuzSqaBH1hPmvqWsMtsqwuuRw
         xIV5NEuHnUBb2wpbnZTxCdZh9ny32qxadsI02qf2hZgBsI7OqkkdZizG40dG+NtNr7uM
         DRaxHeCovYgOPVTvnLT+eRef/IVWaSrXAQePCQd99ObwJSW4Uz0Y24z+6L8CisM5oRn2
         NNHQ==
X-Gm-Message-State: AFq9FYL8w0LATMIjEMUI3ShTbNKNKTCuRtPhkcjm0x09NJnUdvWQJmiz
	Es1bNTeVk/mun3ds3/03va5gXZ99ZqYnQpcUspN7oo4eDeKbI9QEkXdrix5BCa4E
X-Gm-Gg: AYBFou263DrC0x76pavj5vk9vaLM64rkLy5+apVdTcBj9Ty/UgaRMpnLISNiomi+yHf
	AaYrKl8vUz7ab0Yw5lsu+dRMjIVPeWC742C4S32q1lFb7ezntyHn/p0JK2C1j2wYiKRreyF30VI
	B5j8gwa5HgpgW3Y4tRCvx04YGYk+9amHaDUaXbzTbMTpi/57bH3FajqqvxarP+7IIFAfVvTHV3d
	uittu4zy38KiMWl/BdHrf2UJzAM2hZ7kDOc5PxHUSavxWVMdkEYUucWjUTof92l4O3COjNDC/LJ
	aBzroGTcWqBekjf8PXkOUst6Xt2H1Dj8yDyANH8/w3hUjq1Ad82r/jV4kUm7mOqrlUTX2YzcX0F
	ohOUo9K6BMs2v4WUnzdEyCiMMRgmQJ2glTpXichQ8+g1lyHBuPYkDTZX8YBE2YSmqK5luevx33s
	9LirBno5ZqfK4d+SjDYubX1QMPoVVZ/QoOoWdlQIruHcc9AqQYgLkrzTNxxQAm4nKIdPHcsY0/U
	0UVIfCxZavutkZePAv9ONrtJgrOUxI8HzG8CpBom0rnwif0QXIu0ewtDUIKCVfox5raaqduLfUw
	hSYpAzeaJe+2JLCWyIGrDJtStZM2/A==
X-Received: by 2002:a05:6a21:3b90:b0:3e2:78bf:63d6 with SMTP id adf61e73a8af0-3e7cd5509d6mr3746029637.46.1793003580167;
        Mon, 26 Oct 2026 01:33:00 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6212:1232::1d0:de])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc45146sm1234585a12.13.2026.10.26.01.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:32:59 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: motorcomm: Fix function parameter types
Date: Mon, 26 Oct 2026 16:32:48 +0800
Message-ID: <20261026083252.12684-1-mmyangfl@gmail.com>
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

yt921x_fdb_add_index_in12() mistakenly takes the two register images
as u16, while all registers are 32-bit wide, silently losing the upper
half. Widen the parameters to u32.

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 422b45085e7b..a7a9a7439304 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -679,8 +679,8 @@ yt921x_fdb_flush_port(struct yt921x_priv *priv, int port, bool flush_static)
 }
 
 static int
-yt921x_fdb_add_index_in12(struct yt921x_priv *priv, u16 index, u16 ctrl1,
-			  u16 ctrl2)
+yt921x_fdb_add_index_in12(struct yt921x_priv *priv, u16 index, u32 ctrl1,
+			  u32 ctrl2)
 {
 	u32 ctrl;
 	u32 val;
-- 
2.53.0

