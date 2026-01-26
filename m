Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887132BD02A
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447132; cv=none; b=CD1iPvioNUe3TOs/Um2N6/bvyBE+/dBhk7LJntXK0/CPpyIVl8dvM5FkePkR4p2W6MF2bx+heTx51UfhL4l6548rRTsAyVb0qNOG3j98du7YPdEJmUzIeA2XfmJc632B+4Kc3Y8yG07tBkrlE9qKYeHfj0XsUt3Ev/BwGQjNwt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447132; c=relaxed/simple;
	bh=G6A6OEJCL8j3M7ufls0zWK9TTkkDIkhB2fxweN5h6Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PChrWQp9W49YiDZyJTQQ8mnu+zmjm8E7g4dUQST9PODDsb0bPAXDYrKu9Pw6b+nvxOBbqI2M6uC+MXYUEc8KmmuWLDhOY9NY4zGELUHAOv55bJwhO4fxr43X8o/NweU90rXy9eTJqhtrAYKAi5yHEScYxLdywlHL4CM/Gqgzbf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvv01XqX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvv01XqX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8AEC116C6;
	Mon, 26 Jan 2026 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769447132;
	bh=G6A6OEJCL8j3M7ufls0zWK9TTkkDIkhB2fxweN5h6Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lvv01XqXo1G6FipoHEov5b5sRqSayqhPvW0/DI5plRGd8YWfZK3zK5mNHFdxjo20+
	 QzP6IVQQv2epjqaCxwX6837oswMABam9f7CRFp+zuQhzFAhgX6KWqqijGSr71V0Hg9
	 qXH5aaOwP4SZ+04VIo5ud83vJVfQrUBa/MSo9ZGlJvPP9nhO7AtC7NamcO69XVGVam
	 4YICTi8vxxR1CB0kOzq8XuvrjmDzSkDwEE1vJehP+T2n/JHU9MXVYon7BbsVJkDMBJ
	 JOi+I+b6uK07eS7gSM8mXnDXKhp9yYh8ftZ5nool2ZH8CGpvaz38tCbp3gyolqzQ3Q
	 2Mq0w5zslWhpQ==
Date: Mon, 26 Jan 2026 17:05:28 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: remove optional size argument in calls
 to strscpy
Message-ID: <aXee2KLc9KTVWXhh@horms.kernel.org>
References: <d560ec66-848e-4290-818a-ce28f39de493@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d560ec66-848e-4290-818a-ce28f39de493@gmail.com>

On Sat, Jan 24, 2026 at 10:30:15PM +0100, Heiner Kallweit wrote:
> Minor simplification of the code by removing the optional size argument.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

