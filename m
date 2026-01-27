Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324530AAD4;
	Tue, 27 Jan 2026 03:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484373; cv=none; b=uKnpf3ZbqrAbNyO8LQfNg9P1WDl2aQTxfQF8WqNK5sW6sdlk+U04ndXyjJ2yLn2edUlB2C/Ff2YI2h5ltsvFn+gUIdQzvWcpTt+8sU2iNdJTZak9SDQKnfoFU9Yxrs8z9GQ8wwp75Lf+Kmi2luXUNpH8M88Li5NqfvA4bFDxZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484373; c=relaxed/simple;
	bh=VWFT2HK8lhAJqIqtWpl4sBYhEGC7xC+w6rj3d1c8KIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyA4YIQHFyf5sBNx8cd8qIy/1y7o45v7yYPp/2T+d2h23A5TP1dgJ7mPTkKFfaSsQ/66GV0OxVBEA9lVQ9uwKUrnEf2E8hwMynWgki2xgdpTW6ZhWzKl60fNyLYbNW+nkbqPmNOy6UqtgaE0TuGB1vWGy+IhAt5r8fs9V1JCQk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqBZJIAF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqBZJIAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1496C116C6;
	Tue, 27 Jan 2026 03:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769484373;
	bh=VWFT2HK8lhAJqIqtWpl4sBYhEGC7xC+w6rj3d1c8KIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rqBZJIAFP5v3VMNkgZuFc5mKGmCyWQ12gBSzz4Mi1I7XeDSJ6tbD3+JUNj89epI97
	 P/EniW5JbzPN2Y5hspUdPrsgv6Vcq6smVQFS8WDakcV/8NUkHQBBP5eIfqvhzJai7G
	 HBNqQyzjj+DifN3Z7hh8HZW9GcE3ZjHO1tWCaK8hbnv0nV2sokzFbsMf+7rkXewj/M
	 fX3/nepaPNLRalHv5lVURs/wOtT+ua4+rOlGWngg4UZ9BU2GttBpwjQwvKE3jfQKdb
	 L5bfLFtPpKdSWwqOZPvFmLqUUpDnPdO2TvHHWkLBURo5gaYZQuxERCG6NMFPMTuu1j
	 eA12odtD/H00A==
Date: Mon, 26 Jan 2026 19:26:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH net-next] net: usb: sr9700: remove code to drive
 nonexistent multicast filter
Message-ID: <20260126192611.5ca0e9f1@kernel.org>
In-Reply-To: <20260123065842.53669-1-enelsonmoore@gmail.com>
References: <20260123065842.53669-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 22:58:32 -0800 Ethan Nelson-Moore wrote:
> +	else if (netdev->flags & IFF_ALLMULTI || netdev_mc_count(netdev) > 0)

nit: netdev_mc_empty()
-- 
pw-bot: cr
