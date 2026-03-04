Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDA23D34BF;
	Wed,  4 Mar 2026 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647565; cv=none; b=lAj1jg0h5D/77MzyT5+qmv5rDz/+i8Ps31MvyKQkyLaNHtl5b6/QgwXQmTDKt0mX2ZJce4G6w4kRkUP+WJXhfUTSFvnjNPyJbeitGNbOwVkKYQy4hSqtKEFkOrUdSD5cCiOaCmp84ncR4q0ICiFiEEeUjzMha+/ztg+o6iqQWNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647565; c=relaxed/simple;
	bh=ecBtvtst316K3uojHIX0kNZYf1XPkxz49GlOWwEqnlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCVWxzmvUSY6jmhwUBgAP5C516lnqpLK5gvNPaKRTl5v0L0TSP2Xf9XsFGVy3SmCufgvn9tW3z4yhnrTGGoUYVad0kRvLz+EZfjQJikP/9k3W+Yie8qZQO7FK1bvjVqff36jRSGU75MTBbqE6vBOBxAlkveqNhgrOdtvZFfOAHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc4g8VM8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc4g8VM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEE0C19425;
	Wed,  4 Mar 2026 18:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772647565;
	bh=ecBtvtst316K3uojHIX0kNZYf1XPkxz49GlOWwEqnlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tc4g8VM8qv0K7lUJQyxY/jtxpDmvpLq+JHQuRTqsSMQTPDJHATdE+idWJk5VfqCtq
	 NY6Vhku5/t6FPKLsN7T25Yd3RxkyZ0DKhv94UeNnrTszYcodvh81pO3n6b7PWoYUlI
	 b8XQoMlbeQA0zbQ4MTNTYGY6KzSx3ecDWAUC5ADxKQhLiEEgGYol8R+Vz/JnFfIxEV
	 MkQXLvI5QW8ErLfhXhPp3hNo9HFpHZuKBSCA4Xzjjl5jB1B1j8FJkxzHmsDHyNzbDn
	 TFKjMAPa+M18CT/DB9kjb75GgjGr9HtLGuSlwRwJV3VaUCQADZ4eKKiUWFnGVTErYv
	 mPamqB6y47pGw==
Date: Wed, 4 Mar 2026 10:06:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev foundation TSC meeting notes - Jan 13th
Message-ID: <20260304100604.65552d16@kernel.org>
In-Reply-To: <CAL+tcoB0GV3i7sQnLScHjAiRN8uxYYM6_mWR2=gZLj0qr_w23Q@mail.gmail.com>
References: <20260113084605.60d0fc56@kernel.org>
	<CAL+tcoB0GV3i7sQnLScHjAiRN8uxYYM6_mWR2=gZLj0qr_w23Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Mar 2026 14:28:20 +0800 Jason Xing wrote:
> I wonder if it's the reason why the link below seems invalid?
> 
> https://netdev.bots.linux.dev/netconf/2024/index.html

Fixed now, thanks!
