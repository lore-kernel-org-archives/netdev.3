Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E68923ED60;
	Mon, 28 Sep 2026 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621154; cv=none; b=czSNe619gX3fUTjHFsIfxGBmWo5b1DdoPGCm+XnKY2irpnbxdarU1S4hB+qT8vddWgf1pPn6q8r5ogMdBP7n21p0E5g6ao154CRXWmyDSSBnlobIFHQqbxOoCSkE7u/0rchVT0Rapzd8Rw6zNVnmH/ZD0gxFGE2GzRwjhYn9IPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621154; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qqT0IqoCsp7GILJVMCnWYWuNnJDs2eFIeuarFcjQlX52ewVNMfP5nt+27135Evu3BeUhU0osm227ZNAH1J0E+KREdA59V2Jhd92SEAJwWVx9WiOAP8v3epwyf4CnfM11bdF0YFv39BrydhPUgZxHkPr8P/o04zDCDVZtRCiC5n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jp81Qan8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jp81Qan8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668CB1F000FF;
	Mon, 28 Sep 2026 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790621153;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jp81Qan8MtJvuJKPQ1zFoDYsM55kGAplv5MMIxAV9NuE11nzbV1RquJfVJ7NJSBnR
	 nYOhvLZKC2XoxdxahYqLwLkwC6IsB32NF1PAV3K8eAmER5fk58cJewG/16yQoOR3HZ
	 YJ6AjHwzCV2gltbUUrToNXy9VGIRcULKYsgiS2bbM73pLphgkbHu50ij1KOjFufxAA
	 FprBXCW8l6vEzZ/9IgUoBpnbIk82zXUVQObNN6VjHwj5Hm3ASIwGsKSvsUz93vDbgJ
	 ekVv74LEfz0lyHjV7xB0OD98JfG7vwsFnIjNFLG3wx4r64Um3wwJBec5rq4vf3tuSF
	 3OFCiXowVRqKw==
From: netdev-bot+sinfo@kernel.org
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: xilinx: axienet: Free outstanding DMA buffers
 on dmaengine stop
Date: Mon, 28 Sep 2026 18:45:51 +0000
Message-ID: <179062115189.31693.10983859622988810787@kernel.org>
In-Reply-To: <20260928184207.2361931-1-suraj.gupta2@amd.com>
References: <20260928184207.2361931-1-suraj.gupta2@amd.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
