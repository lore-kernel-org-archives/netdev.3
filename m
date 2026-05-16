Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1072A632;
	Sat, 16 May 2026 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778890129; cv=none; b=h5iEZKoyiXalPnmM9Ml+UpSV9gvRdkja1TesXEEwBKF+B1ZsNjSs4sTiP4RoiNnZED/0yzX0cQbkbW9um25XKKRG9Yh4d3UYxzbVE/MwRknoQSvLPz6fCmXr8dXBJ0W/40M/PEW4y7aqS7Tp+ljHZ0JxW0EagVE0RVGn0/okjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778890129; c=relaxed/simple;
	bh=+rEMLvaJ/O1NBIlGLObcKcwAdS/IyXxZF2zKynfYMEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNOXJBAdLhFweymKO3MqIbxXGoDD+mmyx83KVAEt+LZyJjvYqa6VABD3qbNDnBbpcZ0+hJ/BzhGq9XkZgwJ6VebWILSEyxHAV0ZRl1tvZsIapA/BEZzo9Hsv5lGgjyt8A8C1kzymRzDYdsJp56uyDCyq4HYBVi3ldXzIEYZKmg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5LV9J3H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5LV9J3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45283C2BCB0;
	Sat, 16 May 2026 00:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778890128;
	bh=+rEMLvaJ/O1NBIlGLObcKcwAdS/IyXxZF2zKynfYMEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A5LV9J3H7g+P5ImyZESwq5dkSQ4P4/eKjjB5WGXATaKfcnGZrhp7v2rpGBIOQbDDX
	 67gM549VBrfRCo5wVGYh4i3RoNzHse0pXGMPM8B7LxW33b+/TgwrME5dP9G1jSIUVQ
	 WN5lKKYChFVjPZEqHluMCIierJu5aGLvR+uch7sSO0SFZDvSDdL6MoeYrw/pCMy2hD
	 0GIMUyvAvSuz+FcRZM1oBBfbf3X3Ddsb0dEXCoZ1FHdWL72nkt9FDG1yb0im54M6EM
	 xYXw7JRcSK0Ad8QbdkSkKUxXt+ifNWl/IsHf7olr0B7MaxdDDzqmpqM2cmONna2yeN
	 pE6i8b+pdNq4g==
Date: Fri, 15 May 2026 17:08:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Aaron Esau <aaron1esau@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 sultan@kerneltoast.com, sd@queasysnail.net, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, dsahern@kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH net v4] net: skbuff: propagate shared-frag marker
 through frag-transfer helpers
Message-ID: <20260515170847.254135ed@kernel.org>
In-Reply-To: <ageR2qzTRtpH8JGY@v4bel>
References: <aga1VyHpHaUhnGZa@v4bel>
	<20260515164121.2608076-1-aaron1esau@gmail.com>
	<ageAmZcEMu4Yjyyl@v4bel>
	<ageR2qzTRtpH8JGY@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 May 2026 06:36:26 +0900 Hyunwoo Kim wrote:
> In any case, v5 will be submitted shortly.

Slow down, follow the mailing list rules.
