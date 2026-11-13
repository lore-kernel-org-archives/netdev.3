Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611896;
	b=C/VRPpQ3XTTXxdIIFdsmqEX4zUq1DIeXe6uEjrS2BntwirM6yw81Dh8Ti6iTZVEafhMF
	 v0Y92P4g44eKYLDPGB2MR7ARSPSCyXzIFeCRIED2oWzhCEkPHqVMfU/DqnIhsHqi1Mn5b
	 m1bPEJGp7K/LGrx8OmQt1FqggqTFG/hLPRIceuiqmcmOm+8dw46FmQQ5N/C3/u0JqTJCL
	 m5gcY1GQj+ZCpypvG5Bp0icNQFCP3vNZYqBYAEUHTK9V/m8ZaAcARQZXxqyFkU1qtjpEU
	 U8Hi1j6kMbV+sYtU492cV5CVMP9qitNu1JzCOgjdijxR/aAOoEFy0u6fxNwBA/NdAKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611896;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	b=cxAKsVB1GO3iitIbPEeQ8THd0oqnbpWMvO+nmhRp3EBUpyyLjhh+S3hW7ZpYhRUp0vgJ
	 LzyWtGlW60J7YTEiu9LZceKDlBJAdz+GXBZyX1n0MiMVo+tBvkYaAQmjbcycbAIK8kZ57
	 dWQccgdDHiTJg+3EMQlljUbl5CiLIU9AGYiJ/74ndQjuQeNqOmXn0UDH4rLnveEFm3Ub1
	 iC9oLi9Q8a9iWMQNlcZkxqVActKaBgDrN5rX4BxBwkrC6/4k8s5lB+lEvR/GEb1zr+vc8
	 CmZFHt9BBYOTcLIP0233MBYVgovDlJhXFfLtHWhN7T7388tlXrcpT+447iunOM81nZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYikHGBp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EB0606A338
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYikHGBp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2851F000C4;
	Fri, 13 Nov 2026 23:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794611896;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KYikHGBp/+bPif/TJRrK8A7fw+olegBF+qjvpxsIBKUYvgdyrSoAXWnXXCT422gHB
	 hrZkK1+1OHpYwzjxTSbUyahmdpIOil6TrCHEADfBO331kJg/cyeD/GPp6NqMqexts1
	 FWfzRi9H82uQktYD4ZHssXkaongGjn+5UDQrFR3JtRMCCM9yQfSWqYgGv5Ea34iZ3t
	 RrzFOsHTvMw3u8cuC8DG/M8mpagYf3McJD4fc9Dc9Yz5Xn8wAjJ9DzeDtT27/lwVnW
	 pcN6Ty5pfXf2S4FmmbKF390Gq1tNGcXxb4aUyzbtB2eFh9X2d4zEF/7sP/CC/YzYJE
	 Q+sx1VIG/H4HA==
From: netdev-bot+sinfo@kernel.org
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 michal.swiatkowski@linux.intel.com, poros@redhat.com,
 david.m.ertman@intel.com, pengpeng@iscas.ac.cn, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-11-13 (ice)
Date: Fri, 13 Nov 2026 23:18:15 +0000
Message-ID: <179461189531.2168702.16973424835691406701@kernel.org>
In-Reply-To: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
