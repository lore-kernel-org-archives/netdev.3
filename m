Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618461;
	b=qa7jwqV+3HV4T517yCr+F/skyX+r49KYFCDpdXorT0YLQ4CrVXtkBivJMwcqf64GJvxP
	 5qoZVMr0CMFUa+34TF2HWe1zW5/ytAaXtqUE8XUrEh56PfWNlWKk/x3aIZ+NhKBDrhiYA
	 M2iUjo2LoyqI/HWmy26Tq+qQsM2P/R0XwdlgEnLarz6A/sVu4/a8XxNElqquiGI8ZTqAX
	 UmmCvU3qak/MXKcltsyFDldaMIGFy89elqN5hL7xfENmQEQrw10I3dXixVl9Ba8wMQK+p
	 kKPNX9cwTzvEWhEGAqlVgst+is7bBp4EjRSF8fiAxA+ruaSu2P/HiZgm3Tr1/6CTowg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618461;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TEyfm7BQkz3xsJB2bBQBoQAXF84CXluCzEAgd+Y9G0k=;
	b=O5Nd38Nb07yh5vkg+/DwBkOqsf5zx8VrQ32sXsmyNQoHzFTwkWzK/b7FEQWD7U5Qzofc
	 p6ARf7t7hmp+nCr+yD5jtsQ7lgCl7YAUgbVjYcFwan2ukW/GHFLWFmkNa2tovqd1m6XyC
	 CyctGBUIMsZLfLACSKSWboEQS69qbp58C1tk+LLz1cXwWwOtdEbcsjWXYaMSkrHTNiRQF
	 AS/fym/ZMeCDEeNFDlG1P71Srg17hudcQwPlE4AWqQ8oFMmHeH7EgUx03JUp8nkUoamVz
	 HdjqOOAGM3qPplhxT13mBRzMfkTv16Ih1ehc3FKvUFTTfaPruhcxZTU6I94ldTwzl6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKV3LCcM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31BC606A319;
	Wed, 21 Oct 2026 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKV3LCcM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148991F000C1;
	Wed, 21 Oct 2026 21:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618460;
	bh=TEyfm7BQkz3xsJB2bBQBoQAXF84CXluCzEAgd+Y9G0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QKV3LCcMB/U67gnyySXhkXMphhkMS9o+DwlqQgU5sEMJL3rjkqOYq4oSi7F/moNoM
	 7CEkB+W1WHlWPDWhzJ9ijLnpZaIWz2tpA6NI0K4zbfVfBUmCKjq723f3E0A8Go0j3h
	 ArrgAPEBjng7bGSe7FGANuHiuzdNjnrSNwQgTW9D/SwDMSdBHpZLa2y7wPjAmpTovT
	 JaxIKr111cyvQSpDRkETLOKvyJmwJ7QrCJUC2ZjbKwlffP89zIey4gO/H9iTZx8+sp
	 4dltL8ZJkqMngg3ethhfInC7rgeR0alBOSZ6JgvuAXbpYlEcZaww17fS024YEI7E0m
	 kOnMqgTdVL6AQ==
Date: Wed, 21 Oct 2026 14:34:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Cc: Stephan Gerhold <stephan@gerhold.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Loic
 Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov
 <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, Eric
 Dumazet <edumazet@kernel.org>, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Deepak Kumar Singh
 <deepak.singh@oss.qualcomm.com>
Subject: Re: [PATCH net-next v3 0/2] net: wwan: qcom_bam_dmux: Add
 restricted DMA pool support
Message-ID: <20261021143419.02709eab@kernel.org>
In-Reply-To: <20261021-qcom-bam-dmux-vmid-ext-v3-0-cedd1f681102@oss.qualcomm.com>
References: <20261021-qcom-bam-dmux-vmid-ext-v3-0-cedd1f681102@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 12:09:42 +0530 Vishnu Santhosh wrote:
> Some Qualcomm SoCs, such as Shikra, run the modem in a separate security
> domain with restricted access to system memory. BAM-DMUX DMA mappings
> and BAM descriptor FIFOs must therefore be constrained to a designated
> memory region that can be shared with the modem. Accesses outside that
> region can trigger an XPU violation.

## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

