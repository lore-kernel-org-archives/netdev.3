Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792539797;
	b=vspCryITRJ48RhwI5JN6sazE/pKTM6FVAXlAizumrlM4q+rpSDqdSMaP40Lm08lHktmW
	 AdLxEw7DByg3ElOuh2zvWX7Cs9EgKYonz+QZ4/cJ4oLGzkT3OhqmEuwE32BEsGFy63UA4
	 evcABox8vnyL8ylROEpzHKZYFmCODM2nAlLqD8YkwWqQO0B76rYfPWNHEzSM6WNQmln6b
	 +TprQXusrj7O5pKp06BhKXNXKXKU+0GLaZrKQG/7doznGc0xXWD8sA1+POCZtn6t/iHMo
	 HvHmoWTcydg9JXo7I2fw9MFn/2iSOptPu/d/B9uYEmDsxPzXhqm+qabo6zxKpN+RNWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792539797;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=tbGwQmVH+LbasTTjWkOfyT8s4+xofjtiIHJcVB04uMNRnszema84YOnfUgGehW0CdUYg
	 Us9psoRdPfGsNSuEg1C2R+1ImzvksZdNLNP0m7cmPKa2NeZatkKTI+Gn6WzS4twnW9sbk
	 qo26ARDJO7w6ffI68k7vbaxlpX8bJEkjM+jTH0TUsAisxLXMESLmvVrdh57deJhvip0xB
	 SI95Y9MNlKi01BbtJn3Hc6T+PQltBY1u1i/vdRxdYaNwkxoWL4+XutF82xRnN3bPW3qPX
	 Gr9UrZGvtazZmkWbPD2BuHqcuaYilxmjWS7dtfjusKiT5rC9Lo3TtKI4MJN2ehNrfhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JSZKlZcY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F596606A319;
	Tue, 20 Oct 2026 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JSZKlZcY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC60B1F000C9;
	Tue, 20 Oct 2026 23:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792539796;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JSZKlZcY48lK0Xxb9vMD5skTpzittkyWCm6Q978hpE7kn8ju8zRWxpw7oHAvtj1iY
	 4ZtDaKs1UV618GWOub5oaCS1I0ua7uGcIfrHjNDV/T7gnwVjlP/bsz8/IVkOiHMc7A
	 s0C8JGYEGe8WwbUkORvyT2hZ8/20aIn0BiqzTBYabrkkIqI6oBlTinC7ilG7tGrTlv
	 E/wITXnF1E0NssRUvdzKWnLG4U3+QlBPvmnqt/sw5rJFMa7GWt26p3GMGowIn70zlX
	 oxybvwrODp0r5pUMO/fZSkOXKdp1OVghkR67yrOz7eI0cGg540i21S88D1QCnW9P3/
	 9aJrfVoEsxvHA==
From: netdev-bot+sinfo@kernel.org
To: Akshay Ubale <akshay.ubale001@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
 Kees Cook <kees@kernel.org>, Matheos Worku <matheos.worku@sun.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] niu: bounds-check phy-type and model VPD strings
Date: Tue, 20 Oct 2026 23:43:15 +0000
Message-ID: <179253979539.3290.9924821446681218748@kernel.org>
In-Reply-To: <20261020233007.71945-1-akshay.ubale001@gmail.com>
References: <20261020233007.71945-1-akshay.ubale001@gmail.com>
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
