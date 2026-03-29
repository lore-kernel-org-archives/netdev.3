Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907331C8634
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774813664; cv=none; b=EBwKbupIO+akVz/NUZ2hUH9sWjX0JYHL0YNWToIxAVo7AjIRlLKZS62GkSQAZMRfCqXZZzgrYGuk6+drjkihlGAdSvYLKfpaRnLC6WIbK3pUaFUbhX7G6rpA6Gk6rwGHKZV+XzGZ+BAUpTMPyjayraO4vHlUASToI/L1NVt7WA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774813664; c=relaxed/simple;
	bh=ndlA4niNQM+1xuXcb2OMtxp9xaf3AM5hSCYo9sPDDIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1yqRRdVwirFAfoxe8+rnylEZuKk7r1f5BEbuWOwNSi8/nHY6rV5cJ7yG4WUKQfOdrSrXvp0hKDtV65yQxcSyp+9V5AB9CKOFSpB5YSXWfNKK25Y4PkfaRupRee9FGQ6dj6hYq+fxYt1l8NouWww0BEmxL7cKxv3ZtvbhHLIgrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8IpYZQJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8IpYZQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DE8C116C6;
	Sun, 29 Mar 2026 19:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774813664;
	bh=ndlA4niNQM+1xuXcb2OMtxp9xaf3AM5hSCYo9sPDDIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o8IpYZQJ6JLlJ01J1ZluWQivhVe5/H/WLJN3ca0oJXD7LmkF7CnH1bkUZuC7DHuKK
	 QFhXikX8TiKgCJ26hXNsOi5TwkbQlOZ/Xh/dDDCqDDjFi197+4V2s8J/BiKAwJggTV
	 eMG8wpyuokLqhWtT7cz0U31Nym5pCF7dvOs/zgzLBZVBCJjIdxDMBiKDtkzVK2ErlM
	 ErNbUfW0QJSCYecko/DrGfWrzMlLjZW+4/15Ch2mlYlb4Pok6W/AR/foYlIMWinMU6
	 seSOfJbO5qYgbut3vDi8i3xtI+aTj79NQjMtucsRN5HL7JJxIcSjd8yruBpvLdgXE8
	 OS8Y++uAmpjmA==
From: Jakub Kicinski <kuba@kernel.org>
To: pvalerio@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	lorenzo@kernel.org,
	theo.lebrun@bootlin.com,
	nb@tipi-net.de
Subject: Re: [PATCH net-next v6 2/7] net: macb: rename rx_skbuff into rx_buff
Date: Sun, 29 Mar 2026 12:47:42 -0700
Message-ID: <20260329194742.2781331-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323221047.2749577-3-pvalerio@redhat.com>
References: <20260323221047.2749577-3-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
No issues found.
