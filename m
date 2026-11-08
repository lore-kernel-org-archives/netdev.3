Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794120727;
	b=2XHsjipLedtYsSwS+X5H+z48aeBt7M+X35d4lZBtxxuiTWApFSzmdUrRR9NeFW6sPoT1
	 XO1VqX19Xw2RAybS0B/O7NXpQMUj+03F1F4tu4A5C5+RPZdEIQzCkQfJ/HfyojqqpAG60
	 Ufno4j3avvI0UX5xRrVFW5VjlzfMGWQP4cf9zwLAK3/dMe5TmGh49IqDf2F4oTpFODBkS
	 YlNkGKeHrGT34YN5azTMEnkI2GCbqTwbLUCkP8eqvVLUsDf0mkAJchR9dF5pjIFMwhmXP
	 AhYorTPzyVe7CvkQ6QtEfI0YekjvaGVyy5xX/hrA0vjKYpbcSK+Nl53uO2QaMnN3e/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794120727;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=du/wfY6jBc30yw5lIJv2gK/lDYaGLMGV6PahAqt6OvCKfntyajRFRslpVNCxbZGLL8Oa
	 lXKZcZopo6EPYpFqWCVc/xYKQTHk8r4M6psbXYUC/MlPrgGx2hlcJke3TEYmvU26ElwlI
	 MsmOvrM3I2eJByWhvf7skGK3OJ69dYBHSqpacJ3i6W0UlYiqNHj9zhO4ALnro/HyeEneH
	 lpuJzGJC0isC0TjDoTjAwH5ZWCD1DrMdYJ07NLOAEBmsyGfI5ngxHHTuPESSn4q9PcBEo
	 VRsG87L4rdshmqQvr37xRyvsSHePWYWw6uJTuD8c+ZlwOwabBLjZ8QHFTv4PZEgAqpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9Rc7Sx4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD110606A31A;
	Sun,  8 Nov 2026 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9Rc7Sx4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2B11F0089F;
	Sun,  8 Nov 2026 06:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794120726;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m9Rc7Sx49f157E+bckYEDJGdF7xS9i6MSxHxZJ9vPdPc5CjYIbT8t9sC/PHe/4U1c
	 HMSgQ8i0zqSiQXxhQ4kN75U3VWCABwdjDsicdq7IY85yXGMxbTz/IqD7BB1Hv2Qc7g
	 aKjCG1pdtg25xi8QwxhZ/8mNt5lFVZu6Ag0bCeYvd3FYmxaZBd/qYkN6STeQ5HQQEX
	 paP6V1UWgiqgul7JPEMI9HYLAQj2WCIMKhWd9HeWlBCxLOpQv3UyIWlCmssoM1HQYp
	 fURYeyl9T/K/A2xHqivCKH0NaCi2hj3kNhAdklddOjK3KI4Ss6U3a/2PCflP+P/hmV
	 zwcDf8guwntXg==
From: netdev-bot+sinfo@kernel.org
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org, horms@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, arnd@arndb.de, john.stultz@linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ptp: Report clock removal to poll waiters
Date: Sun, 08 Nov 2026 06:52:05 +0000
Message-ID: <179412072531.488859.17380146926813581221@kernel.org>
In-Reply-To: <20261108064928.1931917-2-thnkslprpt@gmail.com>
References: <20261108064928.1931917-2-thnkslprpt@gmail.com>
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
