Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F75149AA32
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949108; cv=none; b=X9efoFVi81F7SZWhtAwdmDxgLDUgbiLklwRXsJe8KmbtuMIJIYZ7d+izZjL7GeBVLaG27i0MyJ5yupD5djgBbemQg5e0Ezn4U5DBGZkxxwMBOjS60ZmwRK4uYl4fsKTaG+S71ZQ/7XSWisNrYGSC/8JDCNsVAxmm7FCIRf5Jl8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949108; c=relaxed/simple;
	bh=NYdJer5cQWhQnRcGRgs3Z0R6cHyb7Q4nxL0oGzNbbq4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rhc21SOI3VHYf+/SbLlgrK69E0SyVHPsWUfoxND5dHpu/6A3BL1Ci/f1gG/ry/mfiA15nry6EytqnG+pGnduu30SLJvWgLThQ9c0fEq/eZ/68n1YhokStIGqejs4GUF+T6JODIrhQDIMfnS5SzmbmbaGlmsteCh2/bxSPwAze74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUMlsuws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUMlsuws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F9F1F00ACA;
	Wed,  9 Sep 2026 10:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788949103;
	bh=lA0XEuZ9dP0He4rq++c9mC1HdQfeJiCrdQXFt6m0Hho=;
	h=From:Subject:Date:To:Cc;
	b=TUMlsuwsYldE+/rghXrY/ZSAlGJtz2oBQStJWIK4LxDjhJ4TKr6yXcsINOqJSXrV8
	 sjTYNcBbENZHHg/22P4uuv8fk+csKtadQqPzjw4nTrswMNBi9cZORE2ldTVC2DlJVQ
	 gACSSCMvD5+Z7TCy6o3oWLo7MIyEaLeX6uW2wAIt0bSOSLY+Bj5BbXM4r4UVkpv0OU
	 j2Enunqe4s7itW9CMYMsIM72BNnL2Fo/Nic3ySQfJVNC1JsfStpRpgbgS8buHSkyWM
	 9saBEDRD9bv/ucnQN8VJJEHgDG1JUD6Yx4NpmL6au5U82/3m8iwJSrtlmbAUhHvfIC
	 bMbEpXQDs2v1w==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next 0/2] net: ethernet: cortina: Gemini Ethernet
 fixes, part 2
Date: Wed, 09 Sep 2026 12:18:18 +0200
Message-Id: <20260909-b4-gemini-ethernet-fixes-2-v1-0-5ea3aa393f41@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqEMBAEvyJzdiAJuuz6FfGgptU57ChJEEH8u
 9Fj0dV1UkQQRGqKkwJ2ibJqBlsWNC69zmDxmckZ9zE/8+Wh4hl/UWGkBUGReJIDkR37anSArb2
 1PeXAFvBO+d/SIyqORN113dfwyzZ2AAAA
X-Change-ID: 20260908-b4-gemini-ethernet-fixes-2-d4c2ee15d11a
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Fix two RX-path issues: acknowledge FIFO overruns with the correct status
bit and bound descriptor processing when malformed chains lack EOF.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (2):
      net: ethernet: cortina: Ack RX overrun interrupt correctly
      net: ethernet: cortina: Bound RX descriptor processing

 drivers/net/ethernet/cortina/gemini.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)
---
base-commit: c20065162307a94f88124f2adb00777a475ab4d7
change-id: 20260908-b4-gemini-ethernet-fixes-2-d4c2ee15d11a

Best regards,
--  
Linus Walleij <linusw@kernel.org>

