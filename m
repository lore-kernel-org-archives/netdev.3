Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B451B2F532F;
	Fri, 13 Feb 2026 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000126; cv=none; b=nYxgIgiMybwmRrjbxFF+Voui0yQTvANjsol1x+pEq8zDBgL11Rgw9aQiZDI4RBxT7V/Tt0i59kWQKKRdNgFasKXKI92iq2KfIVCPwuIG8fltkV5hws1cycIg47v7JZDIKurReBJl3+FD+9B7O690uWDpCq1Ati+qN2rjCtk7q+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000126; c=relaxed/simple;
	bh=G/i9Z6NbJaws71HOluxVcnFjlNq9qHDbpPTSEx+Ppk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5Iz/0FQLoLL/VfX3Y2Uhe9P/oBFEnWE7tO4k7f64imz1YHk1JlvNd6j8kuZqt5cJyi6N8zPyoC6cZ0XzHy51NNxDh4rNTOViOvDlz++4eXDxTK/4uKpX80pFcQtGVUkwr+kDzpx5VR5SVBN/S0Lu2Z1PS9IZ60hRp3hwodSxXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8x6ZbCm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8x6ZbCm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAE2C19424;
	Fri, 13 Feb 2026 16:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771000126;
	bh=G/i9Z6NbJaws71HOluxVcnFjlNq9qHDbpPTSEx+Ppk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z8x6ZbCmyV5rIQkQdRdcmWFujqV86ZZpj69DAVkjb6aEM2P7RU1JjiQwx3fjl9Yrx
	 hztHlaA+my6EpQ+bGKhZ87wkYB3e6lsC9rZtMQ6BbV9Ed1U2ioyH0cvZEtEhH7pzcV
	 ck93NGXnNjHvFu9LHNOEW7xfCqJmyy+F0oUikLEQdtlMViU0KvqYNdMQIsTK2bVrho
	 GkXj+yj0MQgYeHmUAX97kUuZL4gGKfCWSzq8f6DhM/RyroG7QBP8rf6pzXCdiGBkDm
	 6jo3x4VBOJIfObi/4dFznxK0X/BwZGKuiJAxvR7J2sssvxpSPK9dP9qiT6afK3jyce
	 JNM3BrN9AFfWg==
Date: Fri, 13 Feb 2026 08:28:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cedric Jehasse via B4 Relay
 <devnull+cedric.jehasse.luminex.be@kernel.org>
Cc: cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Add partial support for
 TCAM entries
Message-ID: <20260213082845.65635296@kernel.org>
In-Reply-To: <20260213-net-next-mv88e6xxx-tcam-v1-1-051e552e2afc@luminex.be>
References: <20260213-net-next-mv88e6xxx-tcam-v1-1-051e552e2afc@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Feb 2026 13:48:00 +0100 Cedric Jehasse via B4 Relay wrote:
> This patch adds partial Ternary Content Addressable Memory (TCAM) for
> the mv88e6390 and mv88e6393 family of switches. TCAM entries allow the
> switch to match the first 48 or 96 bytes of a frame and take actions on
> matched frames.
> 
> This patch introduces a subset of the available TCAM functionality.
> Matching on ip addresses/protocol and trapping to the cpu.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.0,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 23rd.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

