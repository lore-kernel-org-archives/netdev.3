Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132791;
	b=qp1IdsuXSPKm2b5gPTdUYb5uetpVG8kAj123DmxDm6MZAJzzvksuAH6cecJwHZNEGxFI
	 f/ADMP919E//qgTfFSp248pcGud5z/sfAHMlolmbGEJelJlhzlv1FVOGYA0/xiFfObQKF
	 BOnL9xkJFQ6bYsiSxBVHdIXKZsuXluK0ryo4F0C7KWDkpo97RgJonuaOcwA0VfZVHRXif
	 p8ZyjDDXibbROqAdVozJcAPQdO67jO0Ow0Y+2n3sui6WiV7ShtciGxdAcPHzq+S2mwBrI
	 N7A1O3BToGbiQbejY1L7KVIHnssrPtlvKvk5VgtLsmYNL/6B3dbvhL+WM69iUJqKBwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132791;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=DQArkEgZeF+iSQYiQjtyDDZNpQCG7+7U0bR894mkavjn+QAa1XHCcDEnKOznQb8t3C5j
	 lbmJ7OhxkyMKAJmsNhW3HgJhQpipFXWpQf0pXuDsR2fRbyEi3AKJ8UpBs+x0p4IP7WwGO
	 RlyM14CgVUTAmRkoaMZgzlkZkwyb4SE9qr5Ja85a3/wBbS/HIj340Ck6mw5x5ZbIk1Uef
	 rU+UuZxwoC8Wu7wbpTOUDtttLPjn6x7SjS89ish1exA7SA7CkmSeXvbJ5jBhpbKax8UN4
	 bzxw903UjM07cRBfAkPqs/Teh627TRnnXau9yJA2CWDt3jWQom2wI0A+aH/v+WSCZQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5u4u9kl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27857606A902;
	Tue, 27 Oct 2026 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5u4u9kl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC471F01340;
	Tue, 27 Oct 2026 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132790;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c5u4u9klUG6FNXshCg0Z+KbO8qjijqCFx2ZABT710igq5K39Kc53R6cDJgVPc9fes
	 D54bRLPvTQNOEfFV1ZkJbkrmhHN4mACbwG1h4OJh2ROD4GHHKMyZ2RiaJmw8NL5Ywg
	 AxEbQbt6z5+1uwwN8p9H8ZtPhEmiiwiLy+F+snvEK8SrNOwGEOynsNCpAaWFtUjpHr
	 7tc+IeSqXYf81KE2VMsQ9zG6xCOzxaYcVwN/UtC3IuEH86x+mTBhVx7dhR7bupAeIK
	 NLh0G6ZYvmvCWELn4V9/Kp30PMzcSoxZFqSf7TA7r+0e8rAqJBiaJ5ww6OdnSIjdf/
	 xzRVsKeC5uF5A==
From: netdev-bot+sinfo@kernel.org
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] net: dsa: b53: Preliminary fixes
Date: Tue, 27 Oct 2026 20:26:29 +0000
Message-ID: <179313278971.3327.16155760995395298868@kernel.org>
In-Reply-To: <20261027202230.3539646-1-florian.fainelli@broadcom.com>
References: <20261027202230.3539646-1-florian.fainelli@broadcom.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
