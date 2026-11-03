Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714037;
	b=NzcBOLAiRVkuRINTdWLbm/5+lwxXDSHZduHwERaDi8Ln5i3ELqOfyvJfXHuRACj2KzLQ
	 GMdQ6TJEUEuBymx2H6pHePCS5G2EL+Ace4yOGd/R+PcvA89FBsjdJ6KyJ22F4DggqV0P/
	 5U1smjRtbSyq3TjhiDlNqFx3DPqVox8qcKj5B5KxFKDiNWjZNkIh9UvsJ36GjLjn3v7gn
	 XcInsujTFa1qKnr6Se2Q6qLMui+tG9/F1xmfVOJEYplnMzyq9v1aqOp45eYrMs+/aN/pw
	 A2vX+RGPGqu4shGzVntnpmgXiziJDioi7Zpg36h5IglHgSw+m8TtnwXiwVqNaDNTdow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714037;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=N1AaHj4H0wwl1znnxpGUt72D0gfXdjyUA5usDfS01nx5bnfl3R/C0MWTlACkcDspyRyk
	 4sEBpIx4inEdUa71jjE8W7GrtcnnzsaHa2LraK5NoqunpMeNPDAdaHZ35EdYqB/1D7BA9
	 SRW7p1NYynlGutLOGcRemAGgX5cSJmlu4xo3uZSC/vea0yEAY0Q6SL3m+CsGd8Xxpefq+
	 4Eb3YoJN/YFXAFP3OBor9ipUXKe/Ahv9yAnn/jC7hctQXIzJPCLBDdXwmC4WkdHIu/yw5
	 UmhwXBblj9rnHzkdciY1gdUT4upYA1xo8y2H56bougpcb7iGr8OYTRENyH7tkajPadg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dm4td2lc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B168606A326;
	Tue,  3 Nov 2026 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dm4td2lc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677E91F000C1;
	Tue,  3 Nov 2026 13:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793714036;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dm4td2lceM+OEFYpa2HlcCCcWCerEKhFKOZEm9m8L4iNZmD7yuDVp6Me/rJznZGvN
	 peF7dDMYY04AHW60r1WYu+IaB4uJH8rRvE6ekzRf0Y031Col3qhNu6UjVRH2FLKgtb
	 hD6bmNFaWYxYYwDsrBDlF+Gc/MvpF/8n6J5UE6elAZlmrczyD+E901bIqiG1tkySch
	 6oOFi68Jl9etoePheHw/08+2JKQGuefPIhvp6EAB2eZ9lzeM5V+BCOd9AGJWQWWOZv
	 cMnchHyZCWn3a47CmS2sYUpwiZl9TGAc5ZxgqDb1MqDtLEy1D6RT1LbixVXq8oK6gZ
	 z0qs5p/Z48aXw==
From: netdev-bot+sinfo@kernel.org
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v2] net: dsa: motorcomm: Publish a consistent MIB sample
Date: Tue, 03 Nov 2026 13:53:55 +0000
Message-ID: <179371403595.488859.12039825341832560119@kernel.org>
In-Reply-To: <20261103134705.867613-1-mmyangfl@gmail.com>
References: <20261103134705.867613-1-mmyangfl@gmail.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
