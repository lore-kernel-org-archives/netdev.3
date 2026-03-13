Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401A92E888C;
	Fri, 13 Mar 2026 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773369528; cv=none; b=R2U9YjzysvAlG0fzrPhP+nNxS8sevEd2ba4J/5+QzMo3S/IEZcvH6VrQp9Z/1ScHK2nn1yUm4Vm0j9JMvCev+Byx6x2I6xYOYavjmpIaqPwRQR+zU/aUhJfxpW5s34a890G3bWaTU0hcDs1qEn8Pe1SgCKnFHr9PDazSIg3bxnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773369528; c=relaxed/simple;
	bh=C4G5QcATYc857K9k9d1LJfEe5NvJWi99etFTtAlIS5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0PuF0/mdvvMT0v9TrzC0tJhHsyuEKc2FS9CHijGbse0HWVReTdqd3VsE6z7CTl202dMK3OBfumGzVh7uHGyr18NBBqs/Q930iPoo2ex+tyTOvANpmi+kRZxcVlhuLJuL5p+htZbRo9cpQfHAVFF538PyZFK6HILtUuQr34OcOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GR/p4dfj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR/p4dfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB31C4CEF7;
	Fri, 13 Mar 2026 02:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773369528;
	bh=C4G5QcATYc857K9k9d1LJfEe5NvJWi99etFTtAlIS5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GR/p4dfjO3QbiDm010q+B4PwtgdEKRdr98yKmBuAWwctVfYI7ySr33Zpo5vTG5/88
	 l1HbGaPXMs4rNlAQd7CRjlJazIfH8EreT9Orh2SLtGP7I+cKy6fDklRfizbKVvqwnz
	 wk4Jf3XZe1Voz6Z8HXqJsX0Xhn1fjcOYkBn6t0TMbRMdENrXS8GWq/hK5HY6yZ/2n8
	 zWWlWHSNgLjcAsKHerepgPuJNZH32JCQKlEWjpgzhTCVvYXp3Vm043O091md+wfCCg
	 Un28BASI5hYPdKfN3bnkJ7ovBqfVtTNrmozHFPB8ffnRS3raj+T4dSoFV0Rc3D173x
	 3NudnG5gDrEaQ==
Date: Thu, 12 Mar 2026 19:38:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Minhong He <heminhong@kylinos.cn>
Cc: edumazet@google.com, andrea.mayer@uniroma2.it, davem@davemloft.net,
 david.lebrun@uclouvain.be, dsahern@kernel.org, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v2] ipv6: sr: Add NULL check for idev in
 seg6_hmac_validate_skb
Message-ID: <20260312193846.59a2d5fd@kernel.org>
In-Reply-To: <20260313022634.51885-1-heminhong@kylinos.cn>
References: <CANn89iLBN-fxUQ11Txtn73XQ6M9mrpaWEfjK=EfMU8UO1yOdBw@mail.gmail.com>
	<20260313022634.51885-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 10:26:34 +0800 Minhong He wrote:
> In seg6_hmac_validate_skb(), the pointer returned by __in6_dev_get()
> can be NULL if the network device lacks proper IPv6 initialization
> or is being torn down. Add a NULL check to avoid potential NULL pointer
> dereference in subsequent code.

next time please start a new thread instead of replying to the previous
posting please.
