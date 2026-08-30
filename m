Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B341DA57;
	Sun, 30 Aug 2026 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788054987; cv=none; b=DDMmCH66uwOHM82MwVJYuGwlt26eHEF+YapJg8l4eAPcEjUvMG5Shz0RPOlM+P7oswxs/3GNe3kIPwTAOAL8z0dUnE76nIUBT/m+PYX1xr8o4/7KTTxEVn2u7oVCZQ6EIvsBXozf10viQ/yW2PkD73MbXrmwueFfMUVWR+bXiSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788054987; c=relaxed/simple;
	bh=CI3CfKCAA8qfLBvlaXEg8ChdvQ5vJF5dvXsKkaG2aJU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Tn9OYI70UUGuMmicaZ1S+7avfc+65XG/zmbRM6FOoa3Bx1gRUEs/IUiPEukl8ILZB9BMPBFOPGeOmQRoT+eA6olfLHncZQADofU2XI73wGNoKI9wVZbL5F8ihuwb6T6jUK1HWMxIBRClYrmOJRTNJF95iZvaP9dkNrPN5ycoxFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Iby4Jm3r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Iby4Jm3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C20D1F000E9;
	Sun, 30 Aug 2026 01:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788054986;
	bh=ktLOUS2dthbwSMgKwyyKMwScfNeWqoT/1bLyJqBmlPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Iby4Jm3rsZ8tfSz3FvmKIHdQOgTxh6SIlBZ7J6BwALAyJrwJAuRuqcg7Yz2e05fke
	 fbkXbPsZDeq0rRI0NW3ngAbpSnaQlemg/NtRhK4nQEu3r+iRW2Q3fqPVMwPHmLt5nO
	 Kq++nDMnigZAdvVoMH0P9f/2f38+CSUZt8jlLAqk=
Date: Sat, 29 Aug 2026 18:56:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, ljs@kernel.org,
 david@redhat.com, willy@infradead.org, shakeel.butt@linux.dev,
 vbabka@kernel.org, jannh@google.com, aliceryhl@google.com,
 arve@android.com, cmllamas@google.com, christian@brauner.io,
 tkjos@android.com, dsahern@kernel.org, davem@davemloft.net,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 0/5] mm: Unconditional per-VMA locks and cleanups
Message-Id: <20260829185625.f5ee1b2931818843a78af88d@linux-foundation.org>
In-Reply-To: <20260813193433.3318288-1-surenb@google.com>
References: <20260813193433.3318288-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 12:34:28 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> v2 version of this patchset [1] was written by Dave Hansen and per his
> request, I'm taking over this series.
> 
> tl;dr: Make per-VMA locks available in all configs. Simplify some
> of the per-VMA lock users now that they can rely on them being
> always available.

It's been 2+ weeks so perhaps a refresh-and-remind would be helpful.

But it applies well enough and is adequately reviewed so I put it in
there for testing, thanks.

AI review might have found a couple of pre-existing binder bugs:

	https://sashiko.dev/#/patchset/20260813193433.3318288-1-surenb@google.com

and a small rusty thing which you might wish to attend to.

> Binder and networking folks: Your code is the target of the cleanups.
> I'm cc'ing you now on v2 because there's emerging consensus on the mm
> side that the approach here is sane. I'm not quite sure how this pile
> would get merged, but ack/review tags would be appreciated if this
> looks good to you.

As said, a resend might help with this.

More binder/net acks would be helpful, please.
