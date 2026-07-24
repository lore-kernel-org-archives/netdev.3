Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA339CD13;
	Fri, 24 Jul 2026 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930951; cv=none; b=qU+wdjb7zB5yXlkz4R/ntL5r2cpKNetsaxYkRidceL6jfAeU0zjKXyEfEpsziAt3k2L4pDXa2u+6d7maeFBbN9RC3AY6bBY/4+SsfK6pnAC0AERHDwOz7oZMA5dDIvZsyu68qIy4f9utfyTwwt5d3T/KwMRe5FIFmh+N9G1mm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930951; c=relaxed/simple;
	bh=W/Xax4YdnTaYindT7skaeKHkrDYt8TkwdjnQVq4tIQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPKjOHIz7rp842Fnr7dZQofazD3nDUpXgEpIfKgRkgoPqE9NUYktQAkYlAXJ9t40ZeeyLv50qBUyl5kL0FLqrLV7Yz4AVK7SIYbHKd+mzN6n/trNAPKWxfRkQQzkYwltYZzg0/AL3W4dZM04HZgR5nKqx1uOzVDUWrGjmq5Mzl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3nYRgcl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3nYRgcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0C41F000E9;
	Fri, 24 Jul 2026 22:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784930950;
	bh=r3rKYcDY3e+ceZrDHcSvFv8KJQEpIyzzAkMdzmsK0PM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f3nYRgclXL69xqzC1JjMoANHoASIsDSuXEkuECqQ/+E8TAuCsGvaDwMn9QEAs3c3l
	 fOP0akwqLDI00ya2/yNn+qRuJKnzcjLNQ/d2etzDljKejziXzTWZs9zs65HVA+lUmn
	 N4v6VSBzuRTzc6BxzGXckG9PwcUOddHcRpCUOQ+iRosidQ6VPxiUfJFUEIWkyO2SUo
	 P7S+ncqMbYJbdxkMmYnkMhXLbS124WkMAvz2XndD+Jm9Ep864ksbqvKBXs7gVm5iJP
	 GCqPsbtb780zZRaK3rMIvq+CwRJp0MV9juqCmnjgqexOELkldAriqob9OjT56unK8U
	 jXdyXVzuj5xyQ==
Date: Fri, 24 Jul 2026 15:09:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "John Ericson" <mail@johnericson.me>
Cc: "John Ericson" <John.Ericson@obsidian.systems>, "Kuniyuki Iwashima"
 <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Christian Brauner" <brauner@kernel.org>,
 "David Rheinsberg" <david@readahead.eu>, "Cong Wang"
 <cwang@multikernel.io>, "Sergei Zimmerman" <sergei@zimmerman.foo>, "network
 dev" <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 1/2] af_unix: fix listen() succeeding on sockets
 in the wrong state
Message-ID: <20260724150909.130726ef@kernel.org>
In-Reply-To: <acb8cc56-6473-4910-9367-8c3c0d75be78@app.fastmail.com>
References: <20260718182903.2295560-1-John.Ericson@Obsidian.Systems>
	<20260723091248.6acaa173@kernel.org>
	<acb8cc56-6473-4910-9367-8c3c0d75be78@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 16:58:16 -0400 John Ericson wrote:
> Ahahaha. I had the exact same thought!
> 
> The original revision of this [1] indeed had the error handling reworked
> like that, but Kuniyuki Iwashima asked me to submit the simple 1-line
> patch to "net" first, and only submit the cleanup to "net-next" later,
> so that is what I was doing.
> 
> Is that OK with you, too, I hope?

Oh, you should probably mention the net-next follow up under the ---
separator or in the cover letter next time.
