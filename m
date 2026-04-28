Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630534A35
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777409637; cv=none; b=KrZBdX+PR8VTUAa1eUH9dBtn00m0ioAkeGOdOmgpkyWKEcd2TAlvTx7eL28P+csYgwOybTQ0cYXCNNNUpPOsWVI5zkzZV/ccPh+Z1AwJYIjXe1L1xAygF0by01p3P1rZ0W+yen31cJUEkf/rT11r1Lg/+tETlqNIx7sP6V1PHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777409637; c=relaxed/simple;
	bh=IMLCwLEATMEpfj5w0tTt9weavcjT5AffFw/8eOy/8nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jzVTXB+PX+Xkre6To4tdGrH66nKXvxMQQdgM+up6cwhig14Gu40gl4Bf+nT1xzs3DbWJclZ51en6TNwDyeiqKqOvZuSRGRYGXFW/G4wjvdhB94/xa4oqXBaTTUp2bnBdAr19IlmtoCNyYjLqC4AUc5CQUjSsOK5xDt11MTVBRaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qohuYlnq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qohuYlnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9201CC2BCAF;
	Tue, 28 Apr 2026 20:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777409637;
	bh=IMLCwLEATMEpfj5w0tTt9weavcjT5AffFw/8eOy/8nc=;
	h=From:To:Cc:Subject:Date:From;
	b=qohuYlnqTQbeNpq/m6OxnIgqWwtoZtsoOdG/aqDHSgm0+iTVIO1n6YP+oSDfLXK7d
	 p+AVCOpC4TkhA783j471UOaS9wswgYy08pCBTe54x/E24f1M7HfBYy43r7rLo31Hpa
	 isHetW6LvcgsRyQ5XY0/UdSvxmrkNM2RP90E6OGKN8xQsHMpc2i9JItd6xZJ3bOuRo
	 IjrQOoPy9xdUuMBR6ifIwypzNxrygGkhp1L3iIlAGuOaE0jXUS5DVeiBwQvPmW9odM
	 I6Zfm9/EojOwivUCF7YTnW1S8TLyoE0/pIQj/5wztl2NeWibxdmmSs38t0N1yDWcWW
	 zXiINcZxKr7QQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	daniel.zahka@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] net: psp: add more validation
Date: Tue, 28 Apr 2026 13:53:49 -0700
Message-ID: <20260428205352.1247325-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address some AI code-scan issues with the PSP code.
I don't think any of these are real bugs, but they may
become bugs in the future. The two real bugs discovered
were posted separately for net. AI reports 3 more which
seem plain wrong (rx SPI "leak" on error etc.).

Jakub Kicinski (3):
  psp: validate protocol before mutating skb in psp_dev_encapsulate()
  psp: add a comment about a psp_dev add netlink notification
  psp: validate IPv4 header fields in psp_dev_rcv()

 net/psp/psp_main.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

-- 
2.54.0

