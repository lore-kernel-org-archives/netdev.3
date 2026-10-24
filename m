Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792826499;
	b=iOXRgVat12F3R9ko/p3rslqtLzQ9C0XRf3gV7jO4D77c1mdkq17C7IwZp4zEb1mZBDNK
	 +b7kmF8TXslW51MMpum82HpkbNWRf9S6b/Mf5ND2Mo8V/tsRrUgttLA83Y1cZFnG1gdTG
	 8AplOa4lAtW/CSXgrYNwz1ADdPCYOhdxwdQ9IunoGQ1zaQGU7dtSEWtZaP7otwbLw/LIS
	 67yP0GWbmjr7kVn7x7b27IhsEW3zqazH3jw4mRzDswKfJvTJXzfmUjZ/ZAOsqH0ItGqKs
	 8muymXYAenAuYpqICaH7Wka6X/D4o0HCswP7c3b/TAUQj+G5KCzXKVfjlDjtMwmpr/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792826499;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=o+11J9clO7iNgqWYNgsFDJF48YSpd+T2r7WtRro+Z74OBJKXe/AgxCV9xN83TWjYFc6r
	 H9r6OHXBLye3nx4t+RESuKgmHqjRFFy3adaOJZxrriahZuHfFFSsmaXzCkmOH2+57Be/i
	 TC9Pv5IEEO6dNKFOpw+WqIVvQlLi0aamVULrcQEvqPejds32S57yOgGQ0ovWOZTALy/ZP
	 eJAC79p5BWr7PkqyztLAKRVm7TRMSMslpTgBxWnvECm1LTkjgU1w70eh9FKc57/i/cKH0
	 nKdqvZzEZM4Ptz2OLFtP4oU23iaOaYouIuSk0mf9xTPx+ea7i5EKrmck0uGb1o+MBeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iBWigBHB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E8C606A31A;
	Sat, 24 Oct 2026 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iBWigBHB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207941F01825;
	Sat, 24 Oct 2026 07:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792826499;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iBWigBHBG21tdZtS8kk5vcjXi+G9WA1kLv1LX1bnEdrXPOkIGWTZXLQ1zgUeR6yvk
	 6o1MF2Cm8UlEdlZItU5+PBrf4WOPeG1QvH5OGtJh6oiYz9Mn0o2NH9Mx21+KQ263aY
	 5IoUgY+IFAW6Gz+kNjU4x4PFPpPEL51eQZgataPfOmRM1qWbtEVgwHbDqcPgD3hRCM
	 cycFUQ0r6yQMZKAcEUctdcNMbjXH6GFTNAVW0zt0y7K4MSaQcWVp7K1IB8nXt3UluV
	 jfd1sNT1BtuP7WEcv0sJkkCEHtuV5AsuSjZAKSVyj1heyA4YG18Cxki5zIEzeRdN/E
	 rjIm2rZ3+yYWw==
From: netdev-bot+sinfo@kernel.org
To: Ding Hui <dinghui1111@163.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dinghui@lixiang.com, xiasanbo@lixiang.com, yangchen11@lixiang.com,
 liuxuanjun@lixiang.com
Subject: Re: [PATCH net-next v6 0/4] net: stmmac: fix DMA descriptor ring
 cleanup issues
Date: Sat, 24 Oct 2026 07:21:37 +0000
Message-ID: <179282649764.3327.4164483382685105604@kernel.org>
In-Reply-To: <20261024071319.875921-1-dinghui1111@163.com>
References: <20261024071319.875921-1-dinghui1111@163.com>
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
