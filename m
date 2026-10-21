Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598300;
	b=13RWRvc/UTbLLI5lu7Gy9NBqF1U82sfnH69DzLB+83HoVX01fbnbNzVLbRMkoavOsuI/
	 TpAI1cCtHzZkXmnI6USjJ1a0Jie57j6FcBmvEqBfRSWjFPsSaEbdyy6EjZ7sLq8/6AyIH
	 ubYvtbSJdBftqoGc339+odLlT7ZBDi00UwpAZexJ8U2wB7nEmRWT4URnpxa+I93uuOTpq
	 wpB2KF57YHHzXLD3YJbECLU64DVi5ji9aZ6zEk74OMRpvk4Aszp3z9+N4iWf9x0GmDOiy
	 jixqD6ot/nggbOJQ8YWnXrmGTRn4GDxbjwUnlyS1rSNJbF2TNaRGibm/yX40+62+qRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598300;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=eazm6btI2SX0ZAf2FlERQV+dPkW2LEVtpdmhu3h1Ui6vtLUg5dxaZhlof8DrOsAr99aq
	 0FVu1bfIPsSGKos1cmPHMPDaC8KyTkZjfpvAxveN11+qWsb4NlpljWkwW5cczQOdh0Nul
	 8gV03H8QlwbToUJx/NDOgZT8y8ZI1MsUMKoFNQPLDif6YcH6j9Jq3YHXN+aoBYbNz7q0b
	 mw9sHTbIoSgZg71Id0QI3ClH6m1ZMcaBFeov5OUPAHk079HZRW+h5001cgPOhjoqRiYnw
	 44xe/JI9C/KseySu9grwEQJvmSKkN/Tx+rx3bSvwMIVHFoaAPatbSQenYfgTnt2htVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWMqWkgV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BDF606A323
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWMqWkgV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6991F000C6;
	Wed, 21 Oct 2026 15:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792598300;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OWMqWkgV3z6mLKd5uC6/j58IetnNmFCoxNc1IbX6c5tG+FWMWrqAL2MlvPuTGhbkZ
	 NraFBYb2MnMewviBcKhteMDdqj2p1mCX8q+AQ86ugSXVHKXMSw7iryrWOiLR7nYU3S
	 kZTHZcQCl8aVzb3sps3WRW3Q9vRAIXuB9FUTrZDJQMCfeBF8RNMj5WEsFmpolbWC0m
	 gAKY3uCiXYtsWCaN2JB856iwlPIw2Mtpqb08KCTjppDEdHO3+0YHDg0I9uqvBiYJuI
	 uwLyJahryCeBY6luLquLDmXLkVoypc10GQ3ft4+shGIYV4StV9DRkZZde0DqsJ4BPq
	 7SRHznvxph6XA==
From: netdev-bot+sinfo@kernel.org
To: Dudu Lu <phx0fer@gmail.com>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: taprio: unwind the netdevice notifier if
 register_qdisc() fails
Date: Wed, 21 Oct 2026 15:58:19 +0000
Message-ID: <179259829934.3290.5380861866339404482@kernel.org>
In-Reply-To: <20261021155417.66254-1-phx0fer@gmail.com>
References: <20261021155417.66254-1-phx0fer@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
