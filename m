Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B10306B08;
	Thu,  3 Sep 2026 02:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400871; cv=none; b=Ijz5IfW3IAhBa+scehCAlXZqVdnetAn4Eh4bon5ZkghiekzwdRSqto+QRDmFbl3Lc11RQJseUNCD2HJSGSD7fI4yLb6cqJTnU3K6/Ilo69ydnfZXN+ZDldBPQCbhpA631w3h2etdHxmMN+DE2fM9w0HMMEAEIOkk5b9lpMNsmBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400871; c=relaxed/simple;
	bh=yUH2xNpdl+ChGPP/maF0qiAar9P2aAjqcSFM1akDgYM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HnHK8OT19lraR1STCIif1d/kYc5pxRCHQ539ucPkycIhy0lvFaG7osYD7ONWsYlNWPX+v8aZUedJfw2WrvW3jcdWqYp2regxmJ4XOy1vT/QBD7xIPYNvfOBBqdZ9I6FYlKdQ8dxKk2pADJBgUFFIhSRbmo0r2x2oUlxDbhe7+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdCw1raw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdCw1raw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DB01F000E9;
	Thu,  3 Sep 2026 02:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788400869;
	bh=R0Uo4/9GjDR1PWmc347ih4GSH/zQlJOODlxRby8Goqo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IdCw1rawiRYc0trHWoNkiCpk/zJK4F75lPjA7InyzfRmdpSHE2q59RawIpPhsXm/D
	 fommiBLrqcyXLFZo0dhOBctX8YrlG6zpg7wNQYuiWDxP2bcxhEuHwckYUl8UectrnZ
	 V3gtwoNuWV8am13z6FumAmydzKUusIifsGuBCczVWASghzEpFWIazfs37dv0QtFXd/
	 2dQwQefezmLO2Bh7GCcJWLIp2I3odfpDUu2+q5cUjY2HIBEIZpULzlsAHv42P451rX
	 AMbzQcoo9i5yTqfrE66CChwm33KDOjwuDlJ7PQsrXj9zW1pBIIBRXAe8UM7dWEYmyt
	 p4WJHmaLqRm/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A2A3927056;
	Thu,  3 Sep 2026 02:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] USB: replace page allocator calls with kmalloc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178840081114.3041656.13596134068099743678.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 02:00:11 +0000
References: <20260830-usb-v1-0-aa349c302246@kernel.org>
In-Reply-To: <20260830-usb-v1-0-aa349c302246@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: 3chas3@gmail.com, duncan.sands@free.fr, gregkh@linuxfoundation.org,
 johan@kernel.org, akpm@linux-foundation.org, david@kernel.org,
 willy@infradead.org, vbabka@kernel.org,
 accessrunner-general@lists.sourceforge.net,
 linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 30 Aug 2026 11:10:36 +0300 you wrote:
> This is a (small) part of larger work of replacing page allocator calls
> with kmalloc.
> 
> My initial intention a few month ago was to remove ugly casts [1], but then
> willy pointed out that Linus objected to something like this [2] and it
> looks like more than a decade old technical debt.
> 
> [...]

Here is the summary with links:
  - [1/4] USB: usbfs: replace __get_free_page() with kmalloc()
    (no matching commit)
  - [2/4] USB: cxacru: replace __get_free_page() with kmalloc()
    https://git.kernel.org/netdev/net-next/c/a3b4826138d4
  - [3/4] USB: speedtch: replace __get_free_page() with kmalloc()
    https://git.kernel.org/netdev/net-next/c/534b18813974
  - [4/4] USB: serial: wwan: replace __get_free_page() with kmalloc()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


