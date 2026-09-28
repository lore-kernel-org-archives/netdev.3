Received: from out-2z4y-a134.jellyfish.systems (out-2z4y-a134.jellyfish.systems [198.54.127.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4ED4B5150
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596779; cv=none; b=lj/57L/nfcfheI64X2yirK95LtUtHrlzky/dU4EujHQADJUB4F7hVeAzx+NOq91LPQ7MpmfggPP0+2j5sC0WzEHu+rmBxdYHdDnL7mOHQGRFrUaA0uTZ01GWHfpyrZGmE8WijW1LW5McqilAmB9SSsV7eyldi0aDd6yD+I25La8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596779; c=relaxed/simple;
	bh=w4HsxY3dGeAezAsukrb3WtQRlY86g+fCCtv9tIaQP3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6PIQm61L6M1Z0Emkffb0qU5DdfcfYVX9safF//Gf6xH8rq/KYj/ZRL3HmBP1xeUwBQP8CISz5RLNmNZZT7VeSyCFkodWa3yT6TXUR58rPLXGYMCokTA4xTwi4isnJt90BU0SdfwJ1dJSx+B+BlsmITzAJHoa2K52lx/T6yrOVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai; spf=pass smtp.mailfrom=rexion.ai; dkim=fail (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b=LfZASq11 reason="key not found in DNS"; arc=none smtp.client-ip=198.54.127.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rexion.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b="LfZASq11"
Received: from research-box.ec2.internal (ec2-3-80-226-50.compute-1.amazonaws.com [3.80.226.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4htfwy3nLnz8sX1;
	Mon, 28 Sep 2026 11:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rexion.ai;
	s=spacemail; t=1790596755;
	bh=5rrmQ/LoeD3Jwr2hCIGkoDHuo61v0Gd6NUeS7mYztVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LfZASq11SjmvJxZdND3YgzU5c+FqUYqpv8ASNeOft8rmXDVLNrNiYCHRp8ycmonZX
	 7v2ZYn7woktL3GUmuRTYcZ8ZLRo/jYTGZHZkwLKKp9NfgKxA39KqzGQpLF7cnAujgh
	 2VKyfGzL0cAKJzNifilyhZogEse+2CNhHZT6sSQEvDcJsotBY9fMBz0rCoRtWVqbUi
	 7Cp6kJ2l55JRI9xotDGZrXEz0jcRm++Cf+Kg+qo0pTLcv9nTZoRe9iqr+2keIZh17e
	 xzp47EAulOemUWm4u2A8IiEFDGAYOAd4EQzfySrXljHvZjxL8T2BNyfaS0OcgtyyZ2
	 q0LW5oZkf9ByQ==
From: Rahul Chandelkar <rc@rexion.ai>
To: netdev-bot+sashiko@kernel.org
Cc: Rahul Chandelkar <rc@rexion.ai>,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH nf-next v4 3/4] netfilter: nf_conntrack_amanda: use nf_ct_helper_parse_port()
Date: Mon, 28 Sep 2026 11:58:23 +0000
Message-ID: <20260928115911.4057824-1-rc@rexion.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179053062399.2160803.9591526412956900613@kernel.org>
References: <20260923151501.3093863-1-rc@rexion.ai> <179053062399.2160803.9591526412956900613@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: rc@rexion.ai

On Sun, 27 Sep 2026 17:37:03 +0000, netdev-bot+sashiko@kernel.org wrote:
> Can a port field with six or more digits still be truncated into a
> different valid port here?

Yes.  pbuf only holds five digits, so a field such as 123456 is parsed
as 12345, and on the NAT path only its first five bytes are mangled.
This predates the series, but the commit message wrongly claims that
the patch rejects every value above 65535.

v5 will make pbuf one byte larger so that a sixth digit is copied and
the field is rejected by nf_ct_helper_parse_port().

Thanks,
Rahul

pw-bot: cr
