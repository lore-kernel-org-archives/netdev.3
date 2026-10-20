Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514689;
	b=10I0Oaw+cckaeMKB0h3qaPFrkmGteNEPIf3JW61K6C1BKKgjWotsSfBna99vWVUaTnPi
	 CNEGlD0sBM3NnogBjPvabBxmAtKI/ivmaxqk5WxnMfQwd7Bxs1won/aI4eVlBQ2UGGbR4
	 p4cAW8YcE1UDUoClFzLVIHNMbFxvPbMbmAKvON8/v6KfSLbS0TpaiptzbkdmnryATdvep
	 d4UHFfi7NKn3yMknCz+m33rK4cSOBK96VaVPZYuXBDCXr1J/dYvhL9OLBcX/T6wdm1Df0
	 dP23FLBj6PBciUAWq1JqzBQ+DYOss3Vu1MGC5RKrXtjE7m9sZB1pWIwy4iySGdnwW9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514689;
	h=Received:Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CqKIBGk/9Zt8qYqwX+bCgBvYHW9KkNZ+f3CmQgw5FHY=;
	b=eqYVQLh8fmsLLNMKD+8+0fceJRkye+9T3Tr9VdYnwsnGvbc19dHZ0CnHiklC43iWoB0e
	 XsX6FOf2tiIyfKKKbTtvSeT/3OzPFFWtbmCI0y4AjtITTMzq9Xx6HChcGjx8uQIIgReVT
	 cqJsw//JXVFX3ZdALCLDa/YsVR7mfeS0NFEERBZxcotitpy0Z7eizcPFgslXkP8MMHjAY
	 EoKc+vfivtom8EIoP7kQ9a7fwvcl4DrHUw8uAkuU6CLDhBdZZjlcRTHsgVNyfd5HOJeCA
	 TwErB0zdfTuTbo0cWNDW5/0KWqBts4+OVv2YMVBiXB5BcL3DkK4/plmtO62XuxemwQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C37606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA961F000CA
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:44:49 +0000 (UTC)
Date: Tue, 20 Oct 2026 09:44:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev foundation TSC meeting notes - Oct 22nd
Message-ID: <20261020094418.1cf06514@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Present: Andrew, Jakub, Johannes, Kuniyuki, Paolo, Willem, Simon
Guest: Matthieu

Presentation by Matthieu Baerts
 - Update on 6 months of work
   1. Lab maintenance
   2. New features
 - https://docs.google.com/document/d/1XOP7DGSWSyEYR1u4plxIxck9FrnB54MTvnzY=
RE7y1-I/edit?usp=3Dsharing

Lab update
 - Have PO for next 2 HW testing machines, will submit order today
 - Need to purchase cables separately

Academic research program
 - CFP now open: https://sessionize.com/netdev-foundation-call-for-proposal=
s/=20

Merge window
 - May run for three weeks; if so, Netdev may reopen sooner, after 2 weeks

Patch Review
 - Jakub is concerned about patch merging in his absence
   (gotta take a break sometimes!)
 - Some discussion about extra help
 - Some discussion of AI/bot applying patches that are Acked and green

AI
 - Discussion of CC Sashiko emails: list + author
 - Fix clarification bot (series info)
   - Anecdotally seems to be working
   - Johannes feels the providence requested is important in the light
     of LLM assisted patches Test acceptance criteria
 - Testing
   - Before we begged for tests
   - Now we are overwhelmed by AI generated tests
   - Where to draw the line? What is of value?
   - An option is to add test-specific prompts to Sashiko (NIPA)

Patch =E2=80=9CTakeover=E2=80=9D
 - Jakub considers adding policy welcoming maintainers taking over
   submissions for LLM fixes E.g. for problems highlighted by Sashiko
 - Needs some nuance for non=E2=80=93drive-by case
