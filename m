Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614789;
	b=t+dz+OF/4TBFsPLuMCrLHJo0RpxmD8iza8n++UYAzMLCBCFSr2OgcNcwKb1cvWh7ZEFf
	 94URobkwXN7VA9e3wBQEvheKmMJj0E/h1TXCzktWCUmK9/du/KdH0ApbE68QyEhe/cbhW
	 T7vkkWP4+iwGqzXZA7tSUz5zjwb6QHnuo5erAbOCQ9NBq26XZZInI9JMbnAQnHa7ntI7f
	 lpeErhxhMhrZ5f1gaCQM9ogNMHOgfdwgTHg7Hzb8YIDDXIQsNrvW0BYuXCFmNsZgefs6C
	 UuJHH86fY73a3SSBi/djpjtPp5PY3r7LBfAzpGNm7Mq+bkuSJuN0YkFoY6G65+1v1SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614789;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=GyWx9E9Qnj1pRFzhoAZ+4m5P4NVN7Yi1au+ZSe4PpmKKvozaPSAlghNqOH/ipYax8uKu
	 tPDlbRh7P4ObJj2jDZn6M2X+bhQ+4BxxnHs6riBffJm83+TavQlyYxQKJmqLtTmd6IDjH
	 85JgJE8hCgOYvbhNthQjyEAfAjzFt2UNQyfApYlafh0FC5bVs7xCr+BH8iMtoooe7V8lv
	 OhEv2SECvFz+/hd1CguQvCelQtVNHnvfAG7ADOPGGHVpUBFGHtyaHPBtepg7phO5QuYgG
	 I6P8w2eSz+J9PI7pq3e8eZQ2PO/i7tL8Le6h+03lifoJVd4n6VlStrV/AcauCAo60Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LjfRv+8M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12413606A326;
	Mon,  2 Nov 2026 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LjfRv+8M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348BC1F000C1;
	Mon,  2 Nov 2026 10:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793614788;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LjfRv+8Migm9PT38EK1gcUxk5BhUA/yA7IKAheUtasQbmEjvB6k05LSKIcdp40RHL
	 DH34Pam6sIarhXUYEI7mraRPbA94Xur8Aw4lb4NZ6rU0qXgiB4g8xkYvbb1Wd2gCde
	 cnF74c8Hf6NQIaJF2ZjDGKi+Yq2WdwsWXtZKeb1/XTJPgtqn6UuqinaGdWJeX25waj
	 d4f3Bto+ukQy4iUYvNT+IPvJj41O0rNX1Klsh5rqLgaIzrvirn36cZUbkPKCwEQTzx
	 bgWh9J2o4OZkWPzdcZtPLhnORSxIjoTYZ0EjqenOjnY9hvMA9Hei9cPA/wKOoYVIrS
	 6a3W73zraUdnQ==
From: netdev-bot+sinfo@kernel.org
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] net: dsa: motorcomm: Do not publish partial MIB sample
Date: Mon, 02 Nov 2026 10:19:47 +0000
Message-ID: <179361478774.3286.6135052914469846414@kernel.org>
In-Reply-To: <20261102101334.3525485-1-mmyangfl@gmail.com>
References: <20261102101334.3525485-1-mmyangfl@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
