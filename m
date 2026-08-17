Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF3B277C88
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981145; cv=none; b=i2BbEhKohZn9UOvQ6orIr43wynR4RB9GvS7XxIUQxByD+NERn1tw8Yl5hxylD7dJIIb8wBTYJhTbSmHs31zYhp1fgeqBniUdSXuEzrwFw085GwS6BluPZb0+QXwCXqae6uDQ6FckLZJJACT2ldJiLLxg73IhJLaDIR/s1yMKL7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981145; c=relaxed/simple;
	bh=dBoaxsGULJrnIG6OefojQ1lLrpjcfzweU9KLXfeCd6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QuIfxs97OFOcPnY+W+ovWqDa41FiCrLf1J0bVrbntwQr2tGQpnvxKfXE4OQZWkLHq/ZAtfJEaW6hXTUI3yrh0eVP+Ii/5SS8MhLRbllktTSzq5xgWOmkUD4mNATDaAqEFvColJU/PjHrT0xvODvmny4+u6ePXSN4/O4oKIJgflc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkURepkd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkURepkd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363E11F000E9;
	Mon, 17 Aug 2026 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786981144;
	bh=W4hkogDANb2jQOCGqM1nJcI725I6zlJEFF4JKWwsXCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TkURepkdkLWeefxlWBRC+TTcfMFi+ZuzsrdcgeXSuoa/JzvhsBH3o+z93wvyEEv1k
	 gtKGqM9LZ24XRQOxCMjwaGxfWm1O5OxZPiLESktDBYRPPA/z0+R6r8jrSkTDUdPrph
	 7txLfM1NzUTweLDe/HTwNj7SqrSzXAFyHjKQP/XGldCbxz5HOIr8YuwqBUCJJgR6t6
	 R49QXlf1hGKDLfxGbaDq4294rsHeNZp1nkUq1b01QGAgZqOPgjqlB59XYXI2dic5AE
	 K3mPjMXJqA2VcB/Mwqf/17lOtqkiy9yg9Dk7lEoYrh95VRIG5e+m/McqPc4R0pAyDm
	 5aGLm4aLoJmvA==
Date: Mon, 17 Aug 2026 08:39:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Kees Cook <kees@kernel.org>, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, "Uwe =?UTF-8?B?S2xlaW5lLUs=?=
 =?UTF-8?B?w7ZuaWc=?= (The Capable Hub)" <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH net-next] net: wangxun: refactor NCSI and WOL capability
 checks
Message-ID: <20260817083903.4c6b30c1@kernel.org>
In-Reply-To: <DA17DB365C525F7A+20260817065903.7428-1-jiawenwu@trustnetic.com>
References: <DA17DB365C525F7A+20260817065903.7428-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 14:59:02 +0800 Jiawen Wu wrote:
> Subject: [PATCH net-next] net: wangxun: refactor NCSI and WOL capability checks

## Form letter - net-next-closed

The merge window for v7.3 has started, and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We will only consider applying net-next patches which were posted
before the announcement:

https://lore.kernel.org/20260816155953.072d73da@kernel.org

Fixes are obviously welcome at any time. net-next patches may be sent
for review and discussion only with an RFC tag.

Please repost when net-next reopens.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

