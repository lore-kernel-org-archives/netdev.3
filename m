Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439774;
	b=sIJg3BhvelKfiw+Kv6WoBhDI5ngf55jPQHDRXXwfO/g/0e7jGylcl1Rz8BZC0OLbD2fM
	 SA+iRHX4mrbiGa2C794Uz75YU5I6EAe2MnosGNsZ7MbkulgdAySvStyAwJQQfk4UIo0Fs
	 UJH3T3UcAStOMo4Sb8IUmzaP2wNjDX7EyMXry4Q7B2RD90mQDEXO6dvX4sR/Z+xqiB5g6
	 6QJtcoNqFtm5opVM/5ueUpG3DDr6K8uyw9Ysum47z+BObtEymWdwDhsA5RbrPj/cK94Vg
	 KTPHcyHRyKh++MHBd0XdU8+8bSWlWv5fRKrqVaxPgu08Dds8rj8Okaim+riGj/tsR9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=3ETVpawH8TGNqcJn+eA+c7nYtySgKc/TG+P1cZ3T8mY=;
	b=It8cOdF8kRmyOtDvdG/FOp3WC2ECsWzScNLkl11xuIQDWStI7uVHOxcIRX+V6+RFkoNj
	 XmKfn0VYkA5eN3DOmUvJYe045OVGxldBd74Y0/xwKGoCivtn/pibkIApUqoAw6pdImJBx
	 Mhm65/mFwTHiG0kAIaY8MNVRfs9ZMUrIHSb2yAv/Gkm6V7n9psdSTgeIbrhgDXdDMkc/o
	 USTGJGcGQV+qTwXeGXhfpQAerkyFNvDWPXDFxVu1DVf44Rem0DQsL5WtWjgT67HwIv2kC
	 +5bMS7//oaaMPYuv4REVAElYtt5zW+4uVt/hhwDFmx9R53nR419EiVJIOq61bvkMgrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=c5lDjmGH;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C75606A33E;
	Mon, 19 Oct 2026 19:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25C75606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=c5lDjmGH
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 4938EE83AA4;
	Mon, 19 Oct 2026 21:56:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792439772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ETVpawH8TGNqcJn+eA+c7nYtySgKc/TG+P1cZ3T8mY=;
	b=c5lDjmGHpIkFfadXsxjbwFjF1PUFGQEE0wDNPALe/F5H6lsIUPd180rrJCMLez+1WCCgz9
	BJrOAb4GVx5LrpSHyjUilMf0KKz29arjiTd1LuCMQ0lzq66WiZPHNP2H45Dy27zfHpm/lY
	+AcgYBKn/SKdHyiTvlYTz/dbQ8K6vFiEGVMwv6m51VnaskPD9uSS16Ll/drtaZMPpNBeyn
	tdR4tA/B1k0+ogHGx0FvW5v0Ud6rne7k46oD4EnwXAyAsgnm03dsKo25AgW1T512S18E6U
	o7JXxFREKqDdV2Oj1pxs+a94jq7iZ+hg3Z3QmJfzDHSD4rs2lhWhpyRM1LLElw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id Zoo4JnsoDhL2; Mon, 19 Oct 2026 21:56:11 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 19 Oct 2026 21:56:11 +0200 (CEST)
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
Subject: Re: [PATCH net-next 2/4] net: pse-pd: unwind allocations when controller registration fails
Date: Mon, 19 Oct 2026 21:56:09 +0200
Message-ID: <20261019195609.307868-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179239893785.3135.13786246432250454158@kernel.org>
References: <179239893785.3135.13786246432250454158@kernel.org>
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

On Mon, 19 Oct 2026 08:35:37 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> Do these goto free_kfifo paths leak the OF node references held in
> pcdev->pi[]?

Yes, and the commit message is wrong about that. The regulator core
takes its own reference on the PI node, so I will drop the references
on these paths and keep only the array. That goes into the next
version, in net.

> [Severity: Medium]
> This recheck covers pse_pi_update_pw_budget() itself. Doesn't
> pse_ethtool_set_pw_limit() still read pw_d and the PI state without
> pcdev->lock before it calls this function?

Yes. That is fixed in net by "net: pse-pd: check the PI state under
the lock when setting a power limit".

> [Severity: Low]
> Should this patch carry a Fixes: tag

Yes. The patch moves to net, where it gets Fixes tags.

> [Severity: High]
> This is a pre-existing issue, but it sits next to this teardown code.
> devm_pse_alloc_pw_d() still allocates the power domain against the
> controller that creates it

Older bug, fixed in net by "net: pse-pd: do not tie a shared power
domain to its creator's devres".

> [Severity: High]
> This is a pre-existing issue, but does the normal unregister path follow
> the rule in this comment?

No, an older bug. The PI regulator part is fixed by the second patch
of [1], which I will rework and fold into the net series. Ethtool
callers that still hold a handle are fixed by the PSE notifier series.

> [Severity: Medium]
> This is a pre-existing issue, but none of the error paths after a
> successful setup_pi_matrix() undo what the driver did in that callback.

Only pd692x0 leaves something behind there: its power budget. That is
fixed in net by "net: pse-pd: pd692x0: release the manager power
budget through devres". The other drivers only read the device tree
and write registers there, so nothing is left to undo.

[1] https://lore.kernel.org/netdev/20260813200653.980170-1-github@szelinsky.de/

Carlo
