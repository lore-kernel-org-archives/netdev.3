Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793239352;
	b=z06aIH5jif2Cr+Ap2A7/cRjheAsNkxBhRq+5TIxDM3AYxUMEP/p4IXh83UPN9eTb1aKf
	 kQaxOxwontPGXR5PmY80ulaTNI8mx8WguIC1m6M36OoNUsDswrAE0tIuI15Qm4FqkBPa/
	 RFU/T3sb+cElc9g0D0GY/8u/xQHN8dnITQ6xv8LZ6kNxrWSxxCTeV14FGyOTUDcvbZBnN
	 EqAXY/4+oVBxA/xcnYm+F5F2uvHJa4NUOZlhCFBveo1w3idWIsYeKdtL5QWE7QYFZX0xW
	 SJMYcnzl7hgOx/8SeM9HitMo5yOkMulycu75oM3TdwSmiCeNGcPf9t2cS9ypV1NHdMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239352;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MKYqxh4Pnlf5GqdIvfzsFyew54goPpWKbuqu5AnjV/I=;
	b=jJpQhqNU7XzbWzhIfST+5bLzsVx/H6pum1taCcBN8K6IuBjD0os7tNDeXQq0T76wWCBG
	 IQlW3IAQf2fFvBu1C4MoXLBp2zwdvG/srqH/DCg7HvN5TFx61sGnF53wrGIoOgtqca+Sg
	 VsNxfpib4+TaY6LiqzeR6TY1O6qSH8G1nIrrvlDxbfPTeAOO2gHvqB6dQCY9kLYGioXdF
	 AfNK9s7BEw2FA95zGVsYrk5nbwrIo9OCWdAtOKlqjQSKEm6p9prFui9SdiKurQVdtjkDy
	 DTxpcpKPMEhDheIuHciTg0Y5eq7tgrVBt8jX9iaa2v3sdpAoey5h8jEw+WoBVSxVTrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=d+h5ilqF;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F9F606A31A;
	Thu, 29 Oct 2026 02:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61F9F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=d+h5ilqF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=d+h5ilqFd0w/CpAtQIENbqwLhpjcysVU58twxhulV6102tW9pY4Q35jPQwtrkJ3FuX/Xo7EjnT8TH
	 Do2DVAWqTGjBlhF+J1afs12dVboLTh3MOw8d3RVDPWLBPf18fj15ucTyHLsFQi3dcsyW3bYjgEmL7i
	 85UaN7S87NRdFw5w=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56ae2a92cdad-62c16;
	Thu, 29 Oct 2026 10:02:20 +0800 (CST)
X-RM-TRANSID:2ee56ae2a92cdad-62c16
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96ae2a929ab1-1b73a;
	Thu, 29 Oct 2026 10:02:19 +0800 (CST)
X-RM-TRANSID:2ee96ae2a929ab1-1b73a
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	krzysztof.kozlowski@linaro.org,
	linux-kernel@vger.kernel.org,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>
Subject: Re: [PATCH v2 1/2] nfc: pn533: complete failed queued commands and keep queue moving
Date: Thu, 29 Oct 2026 10:02:15 +0800
Message-ID: <20261029020216.236-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261027070136.1339-2-zhaofeng2@cmss.chinamobile.com>
References: 
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

Hi Simon,

Thanks for the review and the Reviewed-by tags.

On the Fixes tag for patch 1/2: I traced the history as far as I can
from here.  The broken error path predates the 2013 split into
drivers/nfc/pn533/: commit 60ad07ab6bc8 ("NFC: pn533: Fix missing lock
while operating on commands list", 2012) already shows pn533_wq_cmd()
processing the queue in the original single-file driver, so the bug
goes back to the introduction of the command queue in the pre-split
drivers/nfc/pn533.c.  Unfortunately kernel.org and github are
unreachable from my current network, so I cannot verify the exact
introducing commit hash, and I would rather not guess at one.  If
someone with history access can pin it down (git log --follow on
drivers/nfc/pn533/pn533.c), I'm happy with whatever tag that yields;
otherwise leaving the tag out also seems reasonable for a bug this
old.

On the git am failure: the pn533_wq_cmd() region is byte-identical
between the tree I diffed against and current master (checked line by
line on codebrowser.dev), and the Media CI bot applied and processed
the sibling patch, generated the same way, without issues.  So I
suspect the fuzz comes from drift in the tree you applied to rather
than the patch itself.  If it still fails, let me know what it
conflicts with and I'll respin rebased against that.

Thanks,
Zhao Feng


