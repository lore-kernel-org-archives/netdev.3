Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621637;
	b=k7nLvHfI3MHcYd4dxeoWQa6wJ3Qkm8bYzbC2KmenANdjlwk0+Dmh/BraF096uZlHvXyC
	 VqsFblv7cUBFlLSiHulesdoZHAWG08vOfhBIgB6wq32XBc10Av/D+9WvQa/wc6OYks/Im
	 NiAeYt/4B1NuS6DBVucadl+ccboYz8XvMjjRh2WtLPYIw0+HZl5sEfEAiao3r4dU5v+gl
	 S2R+x0VIM5OEQ4EBTDeIKxZc/2kAY5ljv5s3k4PYssPRytkcNJpXgYJ5aMtPpnVVBdtlf
	 Qk92miuwX6Pq22P2WBUwCOxqqsEY4SqKQvEfbTivyZlapD1rrZ2yPtUCdX3wvy6M/1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621637;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=UekXbYyXX+GYYjXkUqBPLGCb2rDd8YMuDFEwtH4svxGs9eXijELXlYQxtIG3DUEHY1PY
	 dPPT4kmv/e1pisUfwLIZBmz8ghGZXUTmksei2k70YxjOCIVkckB06eQIJ78m11fgDLa3h
	 W0sROOhSN0sXsEqB0vSbivvYEvNsBMjdYUuR0qwlwNodM5puicJLTMDKuICLTQjIhb0dI
	 vmr/ipDBlqvQFgfkrxTr3zFHzCArKnAND0xmkV79oh07b5NvOoFq1OvB2drN66yt5/TJO
	 pmn9o20EXrhn2PrQN2ws7eLPh5jgDPPO17kcoXCMV6vrpzpjwhOlk2cxz5OAjoE5slg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViWgjPLL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79BD606A329;
	Mon,  2 Nov 2026 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViWgjPLL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC201F00A16;
	Mon,  2 Nov 2026 12:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793621636;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ViWgjPLLaxPPt7HTHHiitkX7MD8rPKlprCO6qrxfqHVYOyw2G99Qld1fmE8AGHSof
	 NbqpVrGFt9ULLpQPtPOvNyDa+zhCxv0wEbCxrHKbNi6GmPFjb2PeIJ6spZGkAbqdEF
	 t3xM/HbRulgkb8JrwPxyKciyaoGRMDEt2l8AzhlSkVgsrMkcGdxtVerhlfkJ4rralr
	 5wV0EYwbhA4c4n+oYiBsNZ8wIfppMabFS+tOhPavUQ5LupIXIIBcxDQwQtfbSDmcmU
	 ZKqM23nd+R8kE8o9IzU6KKwgTysqT97AJM7MKlAjpsOKu3lVmLZ5Blt45HQp8UBfRK
	 M+3itdilB21gg==
From: netdev-bot+sinfo@kernel.org
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netlink: Do not call the unbind callback with the
 table locked
Date: Mon, 02 Nov 2026 12:13:55 +0000
Message-ID: <179362163558.3286.5335895869912806815@kernel.org>
In-Reply-To: <20261102120929.4077030-1-anilkaushikwireless@gmail.com>
References: <20261102120929.4077030-1-anilkaushikwireless@gmail.com>
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
