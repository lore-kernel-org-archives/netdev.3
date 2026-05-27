Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD5732470E;
	Wed, 27 May 2026 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779845903; cv=none; b=htv+gzadkolPP01ubB3PD8Pw4dhF+cepiEDosLbG6bHx0sAW2VHGP3Fd3GrUUtPwWu044JbhUd5+MSBBJ/jyvxMtdqLtxTrK6YEmWCtqKzIahHmljP2mbaa8lIfPHZ+yHk7HUsasQDFWo74HzQhZz89SN1/2FmdgB5tvCQroGEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779845903; c=relaxed/simple;
	bh=SkNI8P/58d3v6Ay2bk/nWH218JnJwz5keuZGest2BMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7TP7UpszPhAtlG6Pv6o0gePbmCavygIbkF8EXN22Px28AHzzq61Yt1+NHlciMj0XIEdrc9HDZTCTRmp+EASN8vrvF55H/2uzTmaC27lp7LhY5yef8YEbdSaes5avLz8ylrvbYQBm8vR7oSveXtXAAQYNiHQx+rGAxdWhOuwOoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlvUCH1q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlvUCH1q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7271F00A3A;
	Wed, 27 May 2026 01:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779845901;
	bh=SkNI8P/58d3v6Ay2bk/nWH218JnJwz5keuZGest2BMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BlvUCH1qabVdZy2AQhNHqSJkIOsH36RV+R6pXmWeQRczg6Hn/Uwl67r8Be7piTd0Z
	 A+8D0NLWpsBP0VqD8GcP7W5MDtSEBRIqGHo//PQ3ZWI0V985gAxPGzLc36g3fXCUHF
	 M2/pCpc5IGphGepXrqBY+QeM7hwrSgz+Cb0XSkuTBgXRNzN9bEhXeTmKBlL7hF1FJf
	 A79W4snEC5dK+3Kc1zL2c1QmiBXUxMUjLNLXEKvAkoaABk4v8GLckcoPeq5m3vAxpG
	 Kghx4EtP4M6756+cMZhDNFBZOGdN6xCGntecOHGN50NC17PT47fcFKPivUDOgkhdU9
	 uUagJoQCyfSuQ==
Date: Tue, 26 May 2026 18:38:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: carl.lee@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, krzk@kernel.org, peter.shen@amd.com,
 colin.huang2@amd.com, david@ixit.cz, luca.stefani.ge1@gmail.com,
 mpearson@squebb.ca, Mark Pearson <mpearson-lenovo@squebb.ca>, Bartosz
 Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5] nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI
 systems
Message-ID: <20260526183820.42cd7b6a@kernel.org>
In-Reply-To: <CAMRc=McK-AArPcrRc8rmotfoM8tSxyogGVVA3K9AcB0uG1szdQ@mail.gmail.com>
References: <20260519-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v5-1-1a826cfbc128@amd.com>
	<CAMRc=McK-AArPcrRc8rmotfoM8tSxyogGVVA3K9AcB0uG1szdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 10:58:39 +0200 Bartosz Golaszewski wrote:
> Can this be queued yet? The problem is still present in stable branches.

Sorry about the delays, teething issues.
It's in net now and will be in Linus's tree on Thu.
