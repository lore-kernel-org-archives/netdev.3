Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439771;
	b=ybhwX3AbYq953Jya7CupvyB4vRdud3Qh2rawfo0Nch2/yKpVQa/XSPjcG6pVl1GXfSV4
	 LdCeVb9l8gk9HPn2VCHaNpAW7j04ntfd2F7/LoRfHMFtZnJQVA6XVHAhVBzHsfTYALtLC
	 L8UZ8HiTA0MpLt638ol/lTyT3tgGyLAaCZAK7wwmu/htPrVXJddw/cij4gK/3rLJVCY+U
	 6gz4isESH7BZc1tcaClZWNRL37jKXA07NIPt/NL/3uGcw4aAocPBgSfrcvmtQzqlEGnw8
	 geXlPNWPhrjTz7ISuAlyBnwBgumUFH0CxQk5yaWM6yCWWnjh+Zv/oNZXn1e0F9GHaVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=qULPWZzIsEM9YC7t8HZ+nATvnx0VppFSAZ2KI41+wsk=;
	b=HjBKBrW6iaO4vjyAhWfLagkGLDbNc7dGlqwbB75PWj62zy9uaLQmugN5bupD4kVAY8iT
	 Gh6G8uPih1pqKJKicDbOohSkS/yZGcGTiAH1TeWBFHV1BDvUjh9mReYpSBtt6g4nriqAR
	 fo1iHk6aT9N5PZPvJwZU/v6TmYTgrX8iL4/QDWMVljZsmuYh35EKYtO3a3YGdRG+xvcXj
	 04CmjffMneF86KDHV7mBnuo5srSkRVVuM7ckczCJMfbd1xbodC5Jb8Hv0UhmGq5vhswYj
	 y4YoZ23h7GpB6iqR5e1OVmUYFK7oE1WYsHESfRCz6LvuVN1AKsKg9JoAQ+CPwKmQVLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=kBxnjd7t;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCCA606A330;
	Mon, 19 Oct 2026 19:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DCCA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=kBxnjd7t
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 6DDA3E83A99;
	Mon, 19 Oct 2026 21:56:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792439769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qULPWZzIsEM9YC7t8HZ+nATvnx0VppFSAZ2KI41+wsk=;
	b=kBxnjd7tDEfXepBJWwz5tQf+tphbRdlZhDRelia6FrIwYsvBglQYzKtctmABQjwzNFLAHx
	dXutw5ycsZ1fM+UHq5Wn7O0Gd0MDtd1R1NBxhoMxRQTsjsOY12yMrDi94AtJOrRZU4eKo6
	Ep45VcVYwotX6JMqUXcwQQZST8R1o2eqsQrJxTVg0FZFj+5SMl0FXRGFudikQJtYi7y2BO
	c8mXU1NkXkK5EGHjsuL3GZdJJhc+ZruRULglPphKDA7Cqyvhbz14zmhc4a+kOm4CMbiSzJ
	CEZZfVXtwOJggUn7GFEinGU+wjIC2GwDuCh4AFBH80umUb6xpe1CbDinH8QapA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 3NtrYxtOi0Ys; Mon, 19 Oct 2026 21:56:09 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 19 Oct 2026 21:56:09 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: netdev-bot+sashiko@kernel.org
Cc: o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	corey@leavitt.info,
	kyle.swenson@est.tech,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH net-next 1/4] net: pse-pd: unlink the controller before freeing its PI data
Date: Mon, 19 Oct 2026 21:56:06 +0200
Message-ID: <20261019195606.307851-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179239893644.3135.4909831916521856844@kernel.org>
References: <179239893644.3135.4909831916521856844@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 19 Oct 2026 08:35:36 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> Should this have a Fixes: tag?

Yes. The patch moves to net, where it gets Fixes tags.

> [Severity: Medium]
> This isn't a bug introduced by this patch, but is the IRQ passed to
> disable_irq() here always one the controller owns?

No. That is an older bug, fixed in net by "net: pse-pd: do not keep a
failed IRQ in pcdev->irq".

> [Severity: High]
> Unlinking from pse_controller_list blocks new of_pse_control_get()
> lookups. What about the pse_control handles that consumers already hold?

Right, that is an older bug, and this commit message claims too much.
The PSE notifier series fixes it: there, the PHYs drop their handles
before the PI data is freed. In net, this patch is replaced by two
patches of [1]; the cover letter of [1] says that this case is not
fixed there.

> [Severity: High]
> Can ntf_work be queued again after this cancel_work_sync()?

Yes, through a handle that a consumer still holds, so this is the same
older bug as above. The notifier series cancels the work only after
all handles are dropped.

> [Severity: High]
> Can the PI regulators still use pcdev->pi after pse_release_pis() frees
> it here?

Yes, an older bug. It is fixed by the second patch of [1], which I
will rework and fold into the net series.

[1] https://lore.kernel.org/netdev/20260813200653.980170-1-github@szelinsky.de/

Carlo
