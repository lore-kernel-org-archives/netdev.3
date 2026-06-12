Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4980C37AA99;
	Fri, 12 Jun 2026 23:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305854; cv=none; b=suaotCtmtLgOghH1jkQUDq4due96kEAZtMd6zWzITikAiIpGnHO8zHpS2SJIL20Cq8KiRKL4mAPpp/XWefcUdt0Huvj1jqEE4FJBRmOu1ODdC69avj58ggwn+HBoctwPI/QK1/Cn4NnxOy9yW4FjgDyr9IHCtIN+d10JP2krcUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305854; c=relaxed/simple;
	bh=owbNvnrYCanQAn9ZLd1/8iPxIPYaPz0E54tizm1FXhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Amr7evqbjf7tZfbSn7JbymIW0osSPcjI88e8D7Mpjkfe0t5PXGnPSVlxZrrm5OAYLr1OgcvA3UHoE5qzmFNJbBBZefKEnzxL6MH0+uO2wiquHQ3tiz3S9979I8ITjyGsTG+eAnSnXMFmu3w/QTXftUfG9q2bPUDzVzqpkSbyJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BalNfR+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BalNfR+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BC91F000E9;
	Fri, 12 Jun 2026 23:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781305853;
	bh=cxBR9HLfeEgeqLzp1jpM8Z3Rj7wdz+EEYvZpSqY6yT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BalNfR+Pd/9WHDKBqU9Q0EpoMTAoS4TOuwqUYmncVpyfFpZZ9+vjR0zqjxW/4f/Mm
	 Yr6pp/jLE8Z6xE2Di+rF0caZ6tLTZJ1wDwiz/xG1XvgbtfFHbVXVC9Pj1w3S6zvHX+
	 8qY6kH0Kj8eXGBh5sJW7Vlk6jbZi9/e9fFtY5CKWz3eixURVS04y/ID5l9sj643oM4
	 n/bnJZ7GOaznAd6I/oE0nYg3uQfJ+13meqr5n0qkLsKKy+04OV9n0Qe3PcJpFIH/5A
	 OvSqxemxzdQi4yCYXt+J9odIjxCiOj9wQllvPe8Dieb34NMmX/qF2t3rL0szR80RfE
	 B9AkVZy4dGnHw==
Date: Fri, 12 Jun 2026 16:10:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH v2] atm: fix use-after-free in sigd_put_skb()
Message-ID: <20260612161051.2d4df09b@kernel.org>
In-Reply-To: <20260609162107.2865310-2-bestswngs@gmail.com>
References: <20260609162107.2865310-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 00:21:08 +0800 Weiming Shi wrote:
> sigd_put_skb() delivers a signalling message to the daemon socket named
> by the global @sigd pointer, ending in a call to sk_data_ready(). It
> reads @sigd with no synchronisation, so it can race with a close of the
> daemon socket: sigd_close() clears @sigd and the socket is then torn
> down and freed.

Hm, we intend to only retain the portions of the ATM stack which are
still used in PPPoATM and ADSL. I don't believe the signaling stuff 
is used there. I will post a patch to delete this code.
-- 
pw-bot: nap
