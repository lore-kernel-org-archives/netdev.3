Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8D238DC47;
	Wed,  5 Aug 2026 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785974300; cv=none; b=i+0qsIE0TujnwV3dTmt2H9d/agZZ/Gqi58U/8M5sUhk/8F1/wT9kJzsoOGnOOXMZv7yxOqnT04Tj9hB6Gh9eQI/CcAMlNHUfQw6H8z5qJuQqhXg/NbkI/h3meo2CQC/tku1jzU5SzdK1qIMYJr+atrHeqEgDp0CKYNgJfbjaPtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785974300; c=relaxed/simple;
	bh=MIVuTk333BYqIbXd67FKdW/CrRrL1m38lPBg9y5T3vo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBtNpJUha8w/RGvQw8+S173znhCBsT3zHu+0rI/v/NEIUaYkc6IM7H/IOxKyiKpKHibu2y3LgysxQ828xyA3YuaJwKUgq7S2+QLIBaDzmkn6SRxhwUI0e1OakrB1iOjyUYsxeAbHoYjTPX8Wfkxg44OtlNU47oEXABG9UARY3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=defL41jO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="defL41jO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF7F1F000E9;
	Wed,  5 Aug 2026 23:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785974298;
	bh=LK3LpL5DIfHsv7p4kHelM9RD9rQo0Pv3wEFsj5+wCAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=defL41jOxBfreL/isZ+EY3kDdQazNw1iNl/M0QWeusMc9hLEOhpxd8c+Jxxpf5F79
	 to3zRiI1J7VpKA3vDpAGZnnBVi8lHEGz0hCkwPSGhWIu8Qb2oJb5+38DO2JT+9epiG
	 dPV+eLFjg5qRZ88Q06PZudU9aZr/vddI+sZrLlxJ0hgLijAHc4HGUygHsL7vidG45e
	 uIaVSXb6ifSB5h2tdxSUGe+nhxEoNB3M8p1FI3e2abcgS3xnTHb0BC2C1+re1uId0u
	 xbCvFt7wvkNubHGZqCsWlltAj6LzS1VTN96zjgGKuZqGSSMDmaOSvv1iHtKOFsVAsS
	 a9UQA6jSbgFRw==
Date: Wed, 5 Aug 2026 16:58:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: syzbot <syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in netdev_queue_get_dma_dev
Message-ID: <20260805165817.7e1fc367@kernel.org>
In-Reply-To: <0a419b0b-18d6-42a4-962d-301ddd9d4498@gmail.com>
References: <6a71f80c.40259c87.584f4.04b9.GAE@google.com>
	<20260804140006.0210f6ca@kernel.org>
	<0a419b0b-18d6-42a4-962d-301ddd9d4498@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Aug 2026 09:51:10 +0100 Pavel Begunkov wrote:
> On 8/4/26 22:00, Jakub Kicinski wrote:
> > Hi Pavel, could you TAL?  
> 
> It complains on not holding rtnl, so the netdev should be not
> qops-enabled, and we acquire it with netdev_get_by_index_lock().
> It's going to be rejected later, but not sure whether netdev->lock
> protects its device and leasing logic well in this case.

Hm, I see.
 
> As a quick fix, let's fail it early in zcrx if there is no qops.

I think we can switch the lockdep check in netdev_queue_get_dma_dev()
to netdev_assert_locked(dev)?  Nothing should be calling that function
under rtnl_lock so the _compat() is a brainfart.
