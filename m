Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792451977;
	b=b/c6tzEzLV0yrupXkkCEVOfFcefQ2TM235qqAxbqu5fUh4e/+6LGdOT1H1rouppyc58m
	 IiI3cpihsQ57zhwHuQ22/FtXA1xAud+MHwM98UDeJRPQG3q1jHl+i+R34T2U51q6DeFQw
	 WyCn2Qy3BaKgAPsqwX5KscW51+GTUIJUqiiJ0328Nl35URzrQwe7cPqi0mTEs7f+2dlz6
	 a/+dG6TP/VXr+6qoMBwreYtIEeFQbfXYh43eD5H0WqVv+Nqs08Y0goEdyATJCtyVY2UZW
	 BWmqA/7VowVTD6v6lRAqj9RlH7mN3h+2IASzMG5R3CXgYiVYpHk2+fK/zKP/ZfM9K6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451977;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uDfMtRoZCH80axFWEKnZVBPQmCcG6I0J7UKe06Tt0rY=;
	b=dSK8I5QtKl03EJx+lPI44c4Rg7Qn8aCscRZGpyhR8i4r8Jh2i9qFEK0lf6StIlEbJpBh
	 u22zVHnwSY7YbUQ/cXvTlSN5EQrtsS3fzgqBG6MKMs2AZs4DhmFIokhj0xA8BQQOugj9G
	 qBEF47I4zNwHeKX1pYyWS3viBEYT9ZhOn9XRyBRa1HgQUrfanDghf9kdVrhmpwzulZXER
	 TPwUziu/hmMOywK1uzcvTgrePTgYpxYjpc3x9wySmja+m5pXsH8aLN9qdyuZ+I3GcC+KA
	 W1zfsVMvtthsZc77DaA7/zwHTyNYQMx4B+PtD/Ab75+Hn2DhcI8bbxcv1MzH+vVcNsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kx/wOj/I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AF5606A31B;
	Mon, 19 Oct 2026 23:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kx/wOj/I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E121F000C4;
	Mon, 19 Oct 2026 23:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792451977;
	bh=uDfMtRoZCH80axFWEKnZVBPQmCcG6I0J7UKe06Tt0rY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kx/wOj/INd8YymLTyweVrYqb1xOqMzmQEHZaAG4ilqRU1kxW/1UAlej3OzsVMJMbe
	 TE0zuI35zWzmOxaz5LahDgqeU70tdPTMN2CaYWUtxHbQ8q74J9/1sjIARpWzF9MOgI
	 +zN6Znw9aph7AmrkFqxLOhMQNcvBecoe0RnPJwLrJT8zA7aYLdRrMNJllttiL0JKpC
	 CZj8KaT6eK7MLmMTzBVxPidI1DaxNHArjaNwbBNohn6UG/tigt+FAGGwPI2PTN5Bvs
	 3fiFkSt89FGCtqxJODY22wJUNT0W26WU4x/wYzyvF9huWqpZQvuJKLWr/ri+sr+171
	 sQoTj+SEhDx2Q==
Date: Mon, 19 Oct 2026 16:19:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Subash Abhinov Kasiviswanathan
 <subash.a.kasiviswanathan@oss.qualcomm.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, corbet@lwn.net, horms@kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH net-next v3 0/8] Add HW GRO handling in rmnet
Message-ID: <20261019161935.742cd8d0@kernel.org>
In-Reply-To: <20261009084351.317632-1-subash.a.kasiviswanathan@oss.qualcomm.com>
References: <20261009084351.317632-1-subash.a.kasiviswanathan@oss.qualcomm.com>
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

On Fri,  9 Oct 2026 01:43:43 -0700 Subash Abhinov Kasiviswanathan wrote:
> This patch series adds downlink packet coalescing support to the rmnet driver.

AI review seems to raise some good points (I looked at patches 1 and 5).
We're expecting a respin addressing valid feedback.
Please note (1) that net-next is currently close, check
https://netdev.bots.linux.dev/net-next.html
before posting the next version,
Please note (2) that you are expected to respond to the AI feedback.
