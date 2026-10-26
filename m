Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006189;
	b=fJc3BNQuUgjyaMTT/+zeKoXETlHBOx+5Mvg6VrK+CfLnMDR5zZOF5xlkeqBqmWjyiQIo
	 bt+6yq7BgSxSwCh/VYjrDDkAbYGRZJ20rsVih6hBzyn9LQxzrJ6jnw0iSxzviFRcX64cf
	 pdFqD6xTHie2FHRfko6pCTB5L/qXn3LO9kA7Sn/ink8y9orQ1TSVaDrjkrLduN71n9SZA
	 gl9yNR2oAezlCbmOc2SymyEPWt5xFP0niVmmCx82a3xWqZkPuGLPqJ3GpsjdiJ1qS4K5F
	 cHHgL56tQubdb/70vhx+3TUpru9/roB9USLXA9V3BWnJBLrKaczmxuqLHhsN4C2Sdnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006189;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=Xk5LEU0x99cnNLBXGfKdk4Yosgk9AmEf2tnV1dajken4dxwc0jhBgBLK5o8+MTF/58Af
	 /5gYg0M4YVYDDaOU4J6mHccxv1hB8UYe53yEYfSmJU+49v/Z840O6pTfNjOGVVXvOcZgb
	 bcA9ZxnZZgalUeGO21kTNuDnZKTX/bdsYJC9d7Kbbx2FBu8Qz3wUwExVRVXUopCZmCg8Q
	 GIaiGeJiEG6VxlqUbD/cE6VpQD+khn7bxScUgfCxQgYsZIEs/g8z0v8XRLFXZnKtRtV2/
	 rEF0CXx4FHM8NHUBBJ55r+JPWBRdt+WAPsBHxPj7XVd1xwAN9VZkCutVGX9Bx5f4/lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVWWicRZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E59606A31F;
	Mon, 26 Oct 2026 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVWWicRZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5EB1F01828;
	Mon, 26 Oct 2026 09:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793006188;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iVWWicRZh5AXFV8HqAEDLc6o6ZjSRoztjraKHKlcak/sf/WrmVhaVXcC/PQTMACmn
	 i2cE0TinVldvqrVRci0HKhfoAPboduBGKoNqCQZASj2d6S0d9d+eEEWJuOu4apakdD
	 e8z9FlJRdWPbJUHc7jNVHs6dxnSuukZhLbrgdvvdPZ75lT4oFx1kV0NMp6ZTs57WB6
	 rr7NNE5dQOaoltZ0Lt+rOFgA5dT8GSSuDo8xVUxeL0iD1xgZqAYxaNoscsIei6fxTb
	 LTxTwdpJxc9+3X5GHall/931POEYdAfr9HlZRdB+WwHIyldhAatPqXJAILPwFULAyh
	 82zcjOMFBnO3w==
From: netdev-bot+sinfo@kernel.org
To: kmahammadraf <kmahammadraf@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Sunil Goutham <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Srujana Challa <schalla@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: skip CPT ctx flush command when no CPT
 LFs are attached
Date: Mon, 26 Oct 2026 09:16:27 +0000
Message-ID: <179300618765.3327.9278981466861497682@kernel.org>
In-Reply-To: <20261026091001.3421476-1-kmahammadraf@marvell.com>
References: <20261026091001.3421476-1-kmahammadraf@marvell.com>
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
