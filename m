Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697007;
	b=PT2bxAZsFuxQBtuuU5eymeAqyvxnJszjiwZRmCYQK2D/bguDeCq6WRcQNuK3d6uefSOI
	 Q8fMs779kS+rI1OG5RsGBFr0zs1Yiu3vE982UmP2cp3D2sd4uKRhL5h978ArW/3tgGTCx
	 9UjuFzMIpTLViLEfQcEHUYNnxYZ05eSu3dmOc7FIwaKxNzJwOqZ0J2jMcRDeYIpHQ5hpO
	 ijnwADZwjcCk/UqMZmH4/ZN5S2Zeo47svWa5q5ZX0Qnvi7efg/DYBrN48jCmOeEJ2G0mx
	 zSkTOQyO251U54lVoBw3inkndXE7vOWfbEryPBWqKmJZkB04k/TEWLmwEwr9kPWWNEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=tCEqWsU3QcFGknWYmMwa3J+M7JBpsbVMvPe9CER6ShM=;
	b=YA46Sinfd8lPlkI27eck5LxlLo0qGIcRL04xjEDfl1m+WGjqeotwXFXP+Up7ObIB27qy
	 L8XxnXQCM5P6qKdXSaJYGOhceTy/zu/m5sfEsOCLHz2zhmA1DY1Ce2UsLU9K/Z50Vr1YF
	 IR4kbb1AYfDQDENE8lb5DV40dIvU4J69ubpekbbjxQ/rEa+a0ybfwBc/lFqkO+KMIkc2U
	 6xkjANH9vTs9orX/c4kAjXNspNOh2JoHRzALAXJ1Ep5QcrxR1rlzkjUxIqOgAWkqKYIiO
	 aCcNUR6qPRDMlwqTIR7HkznmqGG+3RWaak+EqfQUVNXKyk/Yxjl79VFG1YeK6cr42/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8EsbRfC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81CA606A326;
	Tue,  3 Nov 2026 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8EsbRfC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0441F000C1;
	Tue,  3 Nov 2026 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793697006;
	bh=tCEqWsU3QcFGknWYmMwa3J+M7JBpsbVMvPe9CER6ShM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W8EsbRfCz1oQHaWOPN+Q60Mt+jBkW5HN8R6vxyWUH9TpSVxTockBera3JvzwkI7Rw
	 FbIIPezAhpcqqHbQmjaewKlpUFiyxr7FqsJpGGMQvy9/W2AkY9G67SinaXVVAPE4de
	 XmacR3sOUJClAq2jRjxv1aNO4c1gOe0K/FZg77+kh64iJDqUvpralwfb/Tv6XYC4Er
	 xafDZk9s4snhyxugW7lBf/7xmiqKM8NNDWQtx5YOenooKfa0opjIMX6vCgvhgeMk+1
	 6nptNGJKmF7i9whnCpzY0jnoWCv4hiJVYiFDMPtEZIuI7U1HL8ZeRZ5XYxl8D8n2Aw
	 Eg4snNfmpDvrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030E63805CC9;
	Tue,  3 Nov 2026 09:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] mctp i3c: Fix locking in an error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179369700480.967641.7293537756048057247.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 09:10:04 +0000
References: 
 <71e0a880ffe7a83237e501b07884bf54343e76ca.1793296780.git.bvanassche@acm.org>
In-Reply-To: 
 <71e0a880ffe7a83237e501b07884bf54343e76ca.1793296780.git.bvanassche@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, Leo-Yang@quantatw.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, nathan@kernel.org, leo.yang.sy0@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Oct 2026 11:00:39 -0700 you wrote:
> If netdev_alloc_skb() fails, mctp_i3c_read() jumps to a label that
> unlocks mi->lock although that mutex has not been locked yet. Fix this
> by returning -ENOMEM directly. This bug has been detected by the Clang
> thread-safety analyzer.
> 
> Cc: Leo Yang <Leo-Yang@quantatw.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Jeremy Kerr <jk@codeconstruct.com.au>
> Cc: Matt Johnston <matt@codeconstruct.com.au>
> Cc: netdev@vger.kernel.org
> Fixes: 2d2d4f60ed26 ("mctp i3c: fix MCTP I3C driver multi-thread issue")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> 
> [...]

Here is the summary with links:
  - [v2] mctp i3c: Fix locking in an error path
    https://git.kernel.org/netdev/net/c/750eb5ab457e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


