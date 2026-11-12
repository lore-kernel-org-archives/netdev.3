Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492146;
	b=gWiswQ0i5hePWAx0K7vHkDSxcP5yVAs4qGAqh+cpdvoW3GjkXFQjYZNuAh7Kmrvco68A
	 pRIYQEbBR3Fu2T/F8KpntyS2mU+dEZFv8H5Cu3zXeqVX3Dyel7EckiLVqBQ1K60EQ5SfT
	 a82gOyL+DtP/spbth6Ng2j/SbWnwCPwW9lVvsr5YGXn4ianoxp59znN90KWBX883amGGm
	 mU9Zru5Qi94oRyEiEx93QseaqBFhO/VzQm5BonzlFpwB71KMClzsXMdnT10z3EtkkXYsr
	 aY5G3JbXNTb0EPIQzrlz3yWdPnrmyfwxUkFgH/xQSal7GOMLC4dVtZ+BDz1N8DIRhhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492146;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=08bIgqau/6IPLSdfgW6uMCv61g+wTaACKHqgKiR/CK3yzRh51YNbq47XWnC4XbOrMuAl
	 tfOHHLdjf3czfBr+Yvh85uZu8xwAdRR1jiAX8p3jKL0KiPWmZIHhef2F/MmrxkjmUcjx2
	 Pqh+GPhkHV3HEj4Vg5VkLzBnfZ1EgLqNVg5MzQcn2mehkYu+2Ul41cvLBCEjAMJDxg/gy
	 cnB0b8eDatEu1L8ftPnHqHWstzbua4ncpMpn4ACq4y/m7BDspno7T7Srg/NyoYTvbfSlk
	 nn4ShcYvkei6/9ik7VdyG4f4Ou8WEVnBJaQXpzJXG7TjSMpe2O/OE2QPHWryjxZVGGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jlwJ39a1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C86606A330;
	Thu, 12 Nov 2026 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jlwJ39a1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75401F00A06;
	Thu, 12 Nov 2026 14:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492146;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jlwJ39a12n/heLpSgWcHBpjVT9mYI5SkK8C7DrOZFc3WyKQ0kpQMTx5nhJ6Tp6IX4
	 B6dIP5ckzBOfjO9SA7ct7vQwjrByJ/BSd6WbHVgsrc2pg5Rm5naTl44+Z9pr+4W+qP
	 YWfTZww+HsanluFclcz0CE/K8UekcMX8fqpIM2iaJZxFPN9Ro8AITvgaMKla2wcz9F
	 xtocuYddY99fKD14mmkGtaA8mHFRHvUVCfF03fBRVfCwnJ+SBBydkF+kBdjwwwNBhE
	 LxK/Ooh+zmMeyN/RJ1ZB0ZiH6Dh6aeXr6wyqQp0CFbWu9n3l5P/wiazlMIhO4TtwtU
	 ciW2e48/4W2QA==
From: netdev-bot+sinfo@kernel.org
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bnx2x: Fix potential IRO array leak on removal
Date: Thu, 12 Nov 2026 14:02:25 +0000
Message-ID: <179449214541.2168702.8243471976083576689@kernel.org>
In-Reply-To: <20261112-88a3a7ff32-net-bnx2x@mail.sdu.edu.cn>
References: <20261112-88a3a7ff32-net-bnx2x@mail.sdu.edu.cn>
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
