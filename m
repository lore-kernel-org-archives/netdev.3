Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53223306B37
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786989430; cv=none; b=Te/xIv0eOXZj9ftP8IoGTqxdBmqWxQklcmEq2hp8v4UL2WFzlumynf8TnOljldMc60YVsKrXbPzEupphW8H/m6yIU6KUxV3VoDb1iV6Xv6hcRAqDVRJwHFxp1b4petRbivZZ0dQYsjbOJUxOw9HMrw6OpETRESYvFBhYhelvk20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786989430; c=relaxed/simple;
	bh=fMb3iO6Gegd3IqT1XSu045vQ/IdnhSzwp0OLNF8tbug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyW2JXA91VduxmEmWeYkuQ2GILNpk3GiXRXUfIY83DlTeXzFWp8lrbfL3Z9QHdJGcZ5dYXnXpmeFtKv8UYUhWVtQ6P4wW3LysUaJiGdBJtmmn9jWteLnticgqsRTzT7noSgzLvCLibJfFo8BZOd5bdbyyGFhcDebnxGIX1fULtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftXSdRKG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftXSdRKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2FC1F000E9;
	Mon, 17 Aug 2026 17:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786989428;
	bh=tNcQiYl4382MBaiRR7wSbYbqU5cd+R7xyN45aq+/DSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ftXSdRKG3h5oMNNIqBgYm6ZpKc+BRi9ADpUi3UghGIXvYoYycG4Y4KzqEIX15uls6
	 YM1Zo+iB/gvf2v4OhlQcTul+hENmo0cjEHTUwWjsRcbYPQpUQ5WhE2Bq0JRBfJCcoT
	 Mfvy7Soj6EYhrByH9Q4ZdS2h30taow6ttIy2aNEOGBtnEzAUYiHhgLWvCFFqSHOGZt
	 0O9+S/iApnh/V2nitVGINqVJx99Rt0UCEGfWZCx3x0i7+jHgvTjF8jJWBXSDvKME16
	 U//3c4BNgWAGq13o1W0zGJlGYVlDHL/XQZgwTGLctOipuRW1C1WLtGrklRw1U2zK1Z
	 6z7URCB/NK8dg==
Date: Mon, 17 Aug 2026 10:57:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 net-next 00/15] neighbour: Namespacify arp_tbl and
 nd_tbl.
Message-ID: <20260817105707.2c3a93ce@kernel.org>
In-Reply-To: <20260813080248.407680-1-kuniyu@google.com>
References: <20260813080248.407680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 08:02:14 +0000 Kuniyuki Iwashima wrote:
> Subject: [PATCH v4 net-next 00/15] neighbour: Namespacify arp_tbl and nd_tbl.

Looks like this has been conflicting with some change that's only
sitting in net/main, and CI could not test. Let's defer this for
after the merge window.
-- 
pw-bot: defer
