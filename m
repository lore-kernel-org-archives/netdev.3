Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756322;
	b=geM+/sFIQfZus11O9C8JziT3a3sxsNFd4QNz2/GzKA6OKu5vfGsN9+do0yo6f1xWoh77
	 sIIxnq1kOZR3BYk02CEXPogPhPhYI50u3fLiw+iw+JXxTNXC0bG5H7sVjINKsvE+61iM+
	 fUkcnQSIpI9GgSs8iB0cwbepb1FmYjuuzd1brccQBTRQ5B02vFPJfdA/lYVF0fRMVg428
	 nt8oALqgdghhyM46FToMHs2UfY9w9TOzSPxefWBzJFdnHV3W90wWRe9rCcm4H84gzc9zw
	 TuWjf9u0RiYTwTvbbOi8bfgk5POO6zQQqo3mo5Rx2Tyqb+14EFc0PihYxfdmhu2sAKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756322;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=yg1tZnsodtWIK9K9pb5rgHazh/5O0VVaRTx5XBs5DnfFNV7SsqNR8v0nZIZZMHmn8ewH
	 fSVNFHLXD8rxOArb+8OBOZ3Pwcvls2XQ6Sr9Vmj8TXpBW/CqkZYw+b502ndk5+7rK+rxf
	 XJDRf6Gn7YodG2E0k70wGTzLiHWDbJRN3/85mBWN2+megTXSMKwbjweYFwnZiYYF8lOoj
	 cSnEmGH1FJ6R2pyYrAXl7EdYruA3FJbUFjTu8q0kTg/CGgLYsCXY83oHu9R/n+eJjRBU3
	 RIR9k0TCLHfuvUPzdxuRgaxi4IeeZkjPl9ANhBS+/Ya4EvU/XsEwq9JmU7XzeoXR/pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3fibLOx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB531606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 01:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3fibLOx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54731F000C1;
	Wed,  4 Nov 2026 01:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793756321;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O3fibLOxv4KNPjesOeQDqOOwIG98LN+S5vFG+j7JHIzcNpoQX0wNyZDZEK0KeCQ6w
	 TPOX0YCqXFlABzQqBUX0dGQGXLv2uayJFVqgR93o70HZifbIaTGvFqFmtmWA7LVru/
	 LjsnpvKGwiJFyndC2HMswPJXT/nw0bd2QwwivQU4WcBlAK0jiqRr5DDXQd29asXPnO
	 vwNSo/DDv54uLqOawXU39FqJJL2ZxZdPiubnamG/386Vm2Iik7WQnpUH468kzKJc93
	 64xaArgGwtkk4n8bkzC4s92wXbsAU6fWwm5OxiGyZ6YnP+gTYf7zEUuKsWqDlK8fry
	 aUVfor2QGncyw==
From: netdev-bot+sinfo@kernel.org
To: Naman Gulati <namangulati@google.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH iwl-net] idpf: fix Rx payload buffer leak when header
 buffer allocation fails
Date: Wed, 04 Nov 2026 01:38:40 +0000
Message-ID: <179375632025.488859.9511320336418102727@kernel.org>
In-Reply-To: <20261104013606.1527767-1-namangulati@google.com>
References: <20261104013606.1527767-1-namangulati@google.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
