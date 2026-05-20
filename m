Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112EA3BCD25
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315621; cv=none; b=VOBmB6cAFS3xie38KhzKTlJWE7r+vnPNxLBfE0trYsMfScPQ88IqnyrCbyBtyorGZQwzqVWTjHUZy1IECoFy0uWOR5sBqYpyAwMVwJ1Tcf/Sp/8uyv7WKHB6izrG1XwYEg9CTWCeZWcwBvbJCnk94gDV5/8PWfh7CzIUlWOuAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315621; c=relaxed/simple;
	bh=qdOJ45f2Y2Xyd3ErcriORmBDXVnX360+H3rW8kRv7qY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ns/zKRG7opsaggAt1PCdTfIef5thaLnAl4D9oFpWzqlQzKrRAy9Rp2Sv9QxTu6rTwjUtxLF51X9YqfrReT9SXSqBa5ANi0/HTtdf3dYVdpWBRZYL1248eYpAUGTDcSi9eb1GA7ObQzyqLe97nqv+wjh53uEUChlF9rtxQtyD+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIgwIZFt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIgwIZFt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8401F00A3D;
	Wed, 20 May 2026 22:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779315619;
	bh=ywskEYz6oKrn5jDQ55pCouuLncWvkhkp/plxmXN2OYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PIgwIZFtX9gmYS+YjWYYe3s7fzC3ooKgEuv5J3Vbb3JtWMLBtT9gobIJfbIe9a0Is
	 sPJ6fp/0sgrNrbw0GUQ7OV6hqO1SOGhiBf5nB5ecwQ2kZgNsXMsgxnSpw6v4/EyOMQ
	 PNAgT09foP3ZeOuI7lJmbaD6AI/dvSEeYS9ZLS8gMGmMfuyrdRR5ZUgnLtv+KLfvh7
	 5WyEI3h+kRJF+oxWvMxSBnK7pO5/n7dyTEaMeiQwDTf7B+Yv+9sIfsMpuTAqhJ6UZD
	 58lqMD7W0V49f8a/5eglR1ULmmauIU8Kr29umzbdsb0axCe9q51g8iwDRrouCv0ypQ
	 Y0UShlJohZ8Yg==
Date: Wed, 20 May 2026 15:20:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] net: team: fix NULL pointer dereference in
 team_xmit during mode change
Message-ID: <20260520152018.1098f9ed@kernel.org>
In-Reply-To: <ag1PTfcsbowK68g5@Air.local>
References: <20260509181825.1523951-2-bestswngs@gmail.com>
	<20260510082509.1530a1a3@kernel.org>
	<agCtGqWLK53TWCaS@Air.local>
	<20260510095937.598c27a6@kernel.org>
	<agrdjt6CjpJo3AYF@Air.local>
	<20260518142230.4403b3ce@kernel.org>
	<agwJNX-q0NmmrMpy@Air.local>
	<20260519162145.524da69e@kernel.org>
	<ag1PTfcsbowK68g5@Air.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 14:14:10 +0800 Weiming Shi wrote:
> > From looking at the repro it seems like you never add any ports?
> > I suspect that the author of this code assumed that if there are 
> > no ports there must be no traffic, so it's safe to be flipping the
> > modes. I'd rather prevent the race than make it safe. Could we defer
> > setting the real handler until after the first port is added?  
> 
> The next version will drops the release/acquire and replaces memset/memcpy 
> with per-field updates that skip transmit/receive entirely. They stay as dummies 
> throughout mode change since team_adjust_ops() already handles them based on port count.
> WRITE_ONCE/READ_ONCE for tearing, synchronize_net() before exit_op() to drain old readers.
> 
> Does that match what you had in mind, or would you prefer a different structure?

Please post it and we'll take it from there
