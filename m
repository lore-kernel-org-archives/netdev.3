Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63768453A50;
	Thu, 24 Sep 2026 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265647; cv=none; b=d2oYv08vUZqYK4RWXitvUM0GV1ZHPsz/D2QicHhM8ceVAmSNYmYwWBFyXSwtAMg7oy2BQdmUFsJGzGPVuxVZZuB5V5Q5/OHcFuXcaiuLxDtR0k9c973/6ZA9gWuoLdDu7WIn7tQswn1ncHqC2rVl5VPpg0qTGqvKzQbpAQ+hOyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265647; c=relaxed/simple;
	bh=o8Rc4nVq0uzStp8d5sRR8LoGhALtDQw4qdjWJe4FYIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gh1EQ2vLzjS/2hKymJWjxV1yKY9S+Qf4UckLS3w2/o+Xl0053RJzxJFLAWfpdPYo3K54TTimujXSRIQWqxLiSTU80APbUxfs9gD73/pE25UD84NBzAguG59+qWp+hk/PO/+su640KP577QiZjfwdBwLpIPyuY2WHIIbC2KG2ttY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqodDLbU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqodDLbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E431F000FF;
	Thu, 24 Sep 2026 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790265646;
	bh=o8Rc4nVq0uzStp8d5sRR8LoGhALtDQw4qdjWJe4FYIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bqodDLbU37tNOo0D0O5JncpPcTrujXdXbHHXQksBMxSyONCK/CMotYI2OmTPZX0Iy
	 ZGkH33EZV4JOsrRJ79UXYUhDi6wZ7H/NMl7mTFpOOrBOsYd50h35G7begyMj2NSf5s
	 BkKh2GxNaAWAYuQvoyQXafyDNHp4Oa/lqVv1LLFVYnF6kzL/TGefbFhXdJtaRIUg/b
	 eG+xs/TPddWTTaBqUdApJOTWd2uLnhFiMQ2YvSxdRQAPcunEUi2ANUSJW119preKLH
	 Bq6rtnXpucY+m/PvSfqi9nNoLQ4Ki6K11TBmaZ6et1JT1cDx6Pa8tIkH+QPP2a5t0b
	 3fZBEN6z53vJw==
Date: Thu, 24 Sep 2026 09:00:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: han.junyang@zte.com.cn, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, ran.ming@zte.com.cn, han.chengfei@zte.com.cn,
 zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v3 2/3] dinghai: add MSI-X interrupt pools
Message-ID: <20260924090045.39200ced@kernel.org>
In-Reply-To: <20260922100913.GA13925@horms.kernel.org>
References: <202609211451400236_aZ55Ox3y7NW8MQnYImM@zte.com.cn>
	<202609211459460680vBvKdpuZZ9yR4QVn3ONR@zte.com.cn>
	<20260922100913.GA13925@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 11:09:13 +0100 Simon Horman wrote:
> W=1 builds complain about this. E.g. GCC 16.2.0 on x86_64 says:

Hi Simon!

Thanks for the work! Would you mind sprinkling pw-bot tags more
liberally? Saves me a couple of clicks in (permanently slow)
patchwork UI.
