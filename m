Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407826;
	b=on+eHIRIwo89KmiF8dBqklh/wom+2p7VRTeeqJgT9fkWhtMxdmHMVOE0uQ/Lcd2fDSaA
	 gX7wSmc1oTVrtDSmh1fZ+OEFE06aFCzcS0T4xM9mL+7NeJL1XuAF5Fh2YlKk+jb+TDOMb
	 vzVjd6xOdLPBwA0ZSSPcIyfwX4zgZ698zHyE3IYFLrFJ4k66wkfg8hxFc4FhVmniuk1Wg
	 SpCXvl2NZGL13SYV0+DktrbQUSu1rgN8rTKqwOeceZtuzEp7T2xDhlXsCjro2ngURqtCI
	 J7enxuEDxoWkj5kGWW7Y+vfLWZUppuO4xa5z7/sXDzWkj42R4HsJZ8K8DB/n9LHVcPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407826;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=GVoFEioih/SRKBJn1zZABV7EClBp3XO1bGsmqmXGkqRYAEnG91V1EiuTl9zXYK34XVR9
	 T5R5j/Cx9qfpAB+iCf5R+bFofnHxQanviogwfYap2WTYShINoOsMGhMvp5o/ipzRGLXQ5
	 5P/G2Hh/V6XR7l1DuEoGRZCiNbEO/Qmw06hW1a0/9xmrjpuFi1MPWGn0kf/Of0LBNx8bj
	 Bp4a+6NreTarJ6TUd2RLELjSGhmYqDugmOSN/Z2keaHkQmts3kk29vJagaKp7AYj70iCJ
	 pthnSChDyE/GPzNElkgCqVdg9amyanGd61OUEHBGwAcY3wvI3GnW2YmAb8XBim3E/kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VuwuVl9I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4AF606A32A;
	Wed, 11 Nov 2026 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VuwuVl9I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F411F00A05;
	Wed, 11 Nov 2026 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794407826;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VuwuVl9Ir+pxEDxIzsWkrE++elA9ahbE9R+qJ75k5x7aiIK0bv1S3pcsBxp5ba0kR
	 Uq24B0RN7/EyAXa33/t7V+NMnOIEkyIQ3DTWs9xsCZjh3Ch13q4yWDgDgRVPCX4P4k
	 JaTKxwTNp1Ep1Na8PExWLs4xH3UN5ZHy0udVFHYHwn7ulEGpAlmD7Q1ctYk9Evp+VV
	 Wp/+7xQoyL1DVoBsP0W4yn0OR4JbjiHkweh8OcUhsIvPxeJ8PXsAY4HFHRYTw0Y1KS
	 iENVs1/D+oxCw2PjIZcsj75ft1nEQAuK0+Q3/5A3/hbkoyp17/3l0uQeferNXtfucf
	 csVP7LrRZs9Cw==
From: netdev-bot+sinfo@kernel.org
To: Zxyan Zhu <zxyan0222@gmail.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rmk+kernel@armlinux.org.uk, Jose.Abreu@synopsys.com
Subject: Re: [PATCH] net: stmmac: program the FSM timeout timer
Date: Wed, 11 Nov 2026 14:37:04 +0000
Message-ID: <179440782487.2168702.18094491275794664305@kernel.org>
In-Reply-To: <20261111143322.2234321-1-zxyan0222@gmail.com>
References: <20261111143322.2234321-1-zxyan0222@gmail.com>
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
