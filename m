Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794072408;
	b=mSJDNK5PeR2VbOZa5zg5IsTzDnlnJvA51fE0ONZDMidwlyAeWkP7lzG3TXlrhJnnb089
	 mOEua8EdvD6JlwKbVpCatM9I9QOOjGmqF/NsPj9JmjNJ4lclzly7XrvwJNjRJvhVkwBwv
	 VkVy5U8ubFJGqhBaSOVoeSlIRo71ZPYbS4oSBgjdG8AYPxObO+NQ3Z60nvi6RJefWqnm0
	 z72HzGZBDwf2inoRPrPWSzvVe5AF7JLEFwMP6bfSRSOyqpT7O31+9v5zBFlhbUREFz29n
	 BGrfOK31NuwWUZ/B9NDmMojlucQVXHB7zOUBQmgyUos7CrOAW5hQeAX0oGqtc710ERw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794072408;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=QNkjpjOOZukafknHpjmjTlu7GYmPQ8lQhqnY2KVvK00=;
	b=n/Gt4eLsrrc3WL2rsGTdnczy4AHDorDZbFtheykOOTaoggEDU7I8eFqy0paWDzNgn735
	 KZBW3+M6f/eMw0jPeqBKP/ooiFutYo3QW2Y7glIU6LyEgKgCt2lFjk7n/wb1+t1j2KkUZ
	 zlSDBfja19YJj2HvdbXM/1a6zSMmwdEgppaagdVtnJjtrVOmmae6ylyAmHOiyyn+HjX//
	 ATV1x5GB6aGL8Y9mMB+0X/hRKC012jk1Q4/2HCkaDUoKirKl/Gx8WZXGDiKpLyT5MXXP+
	 guS7b8MyzjFfjDaxxYByymwPdeqpOZUg7JAiM/EAY/Y3HG2pVgZsWPFnQPccn9rXvHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=K259xF3G;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C58606A326;
	Sat,  7 Nov 2026 17:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16C58606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=K259xF3G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QNkjpjOOZukafknHpjmjTlu7GYmPQ8lQhqnY2KVvK00=; b=K259xF3GUjZv/2Mgu+KBvvS93b
	r6nA9Z7TW4BpFYmRFHui0XS48wjV+sY4uQ7cUEfXB9WdirONJEbzNOS7gBmtiZU8nv4vWSMuv6OB4
	kX4m8HOybHd1wcsCDnub/d0Ic3XnaENcuETe8ZytEhlMj/NSzpPbF/kc+9snKZxs2Jag=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPkBe-00Ez8f-MO; Sat, 07 Nov 2026 18:26:42 +0100
Date: Sat, 7 Nov 2026 18:26:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: dsa: motorcomm: Prevent rx_bytes/tx_bytes
 underflow
Message-ID: <91357461-8056-4b1d-a06e-6f1db5eeaaa4@lunn.ch>
References: <20261107015447.335056-1-mmyangfl@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107015447.335056-1-mmyangfl@gmail.com>

> +	if (res) {
> +		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
> +			port, res);

Please don't break strings like that. The reason we allow lines with
strings to be longer than 80 is because somebody is likely to grep the
error message in the code to find out why it is being printed.

grep -r "Failed to read stats for" is not going to match.

    Andrew

---
pw-bot: cr
