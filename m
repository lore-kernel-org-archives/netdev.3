Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256157;
	b=QAPtLoHXXbGpSovuNBrOPxGQhi+3WsTKh+glf904TWEgcn4X1YN3YVoP8ctXELOxlYe7
	 Ckx9rOUsZzFF7yq33lR6AtgLTYTh3/ckWvi4sgRWi0VPd+DAwyQjE8qwpzROZyLyYqt5O
	 TUt58DSOB1vW3zsuhQc+eF/kFu3UiypHJuOidxngbf+iYYUCmpk7WkhbUWQ5rWgYaMrps
	 LyHggQH/Q/e6X3khp1cUN58RA0QmWDdyybCgLjeVrZ6WYSvpBfmA77mMUNYQrrNCItww9
	 HXaIs42TIFupxN6F5MYV7r5V4O/yDcTyDis/ehG6DLpB7H+mlARTgCEf5au3XSva1Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256157;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RJXpVdEQQ4k4fP/MJ0YE0BzV6lM556s8EF58JGKSn74=;
	b=bPnj72VMuI9T2KoA5kXo0qEL3uGOq+RZ4ICEO4UeirfRMDPnr7kWk76wLiDoUlVA0HaR
	 /iuT5YeAFMxDuUda8GjO9JdR7F0ge2uAPLOrVbtRd/AasKgbB+1HAOcbdH9ig2UiTEYDe
	 PequDu+0qK6qMh6Mby8CoYc+zyJfQaTkBk3a1Wd5rgVwWOaBTRrg9Df8B+C0rkhY5Mh3M
	 sDp6xiz4f887LUHZaswbt52bxH45Zx5yjLettQc1w2FVyMlcARS4UsZlR2feiO9RBPinl
	 kKBjt9/xbxVh/8wcM6SgviWNwbJaMxGh0dleNLU5dSmZJx6a0NVx3cw7mYShb8tMO1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jPtiJpkU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042E6606A333;
	Mon,  9 Nov 2026 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jPtiJpkU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384B21F0089F;
	Mon,  9 Nov 2026 20:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794256156;
	bh=RJXpVdEQQ4k4fP/MJ0YE0BzV6lM556s8EF58JGKSn74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jPtiJpkUnwmbTrw3uDWTqdZKfAzJA7qCw2SsFjA+wc5UpvWwtFwVOz5JbGNu0cBon
	 +pmCRCzP9IbGRqlxuZ3pl8N2b09yw0a8fV9eDAYaRR56XdvQjqVCSwTtLwHkltDfF5
	 cJUtwjSkjKnAgWbG8msbkf592oo0XvK6Tq1MCjro=
Date: Mon, 9 Nov 2026 15:29:12 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"security@kernel.org" <security@kernel.org>
Subject: Re: [PATCH] wifi: nl80211: clear wdev before erroring out of station
 dump
Message-ID: <2026110952-litter-haziness-bc23@gregkh>
References: <ltwfLZuSH-PEFdqMECEU8rHwZCjSL5--7RG-qrW8a-Fwezdgpb1QYiDm-8aCRNIgwY-laqSmHJWAqV4uI092NLEudhWEABdd3B5iGsV4jJ8=@proton.me>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ltwfLZuSH-PEFdqMECEU8rHwZCjSL5--7RG-qrW8a-Fwezdgpb1QYiDm-8aCRNIgwY-laqSmHJWAqV4uI092NLEudhWEABdd3B5iGsV4jJ8=@proton.me>

On Sun, Nov 08, 2026 at 09:57:39PM +0000, Noah Weinberger wrote:
> Hello,
> 
> In nl80211_dump_station(), the new -EAGAIN retry path calls
> __nl80211_lock_held_wdev(), which drops the reference we hold and then
> re-looks up the wdev under the wiphy mutex. If the wdev is being
> removed, that lookup returns ERR_PTR(-ENODEV).
> 
> The IS_ERR branch jumps to out_err with 'wdev' still set to the error
> pointer, and out_err then does:
> 
>     else if (wdev)
>             wdev_put(wdev);
> 
> i.e. wdev_put() is called on ERR_PTR(-ENODEV), dereferencing an
> unmapped kernel address (~0xd). The station dump requires no
> capabilities, so any local user can reach the trigger while a
> concurrent interface removal (admin action or unplug) closes the race.
> The result is a kernel oops in the dumping task, or a full panic with
> panic_on_oops.
> 
> The sibling handlers nl80211_get_station() and nl80211_tx_mgmt() never
> put the error pointer; the dump path is the only one that does. Clear
> wdev before jumping to the error label.
> 
> Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07), net/wireless/nl80211.c:9023-9035 (EAGAIN path), nl80211.c:296-306 (__nl80211_lock_held_wdev), nl80211.c:9133-9137 (out_err).
> Introduced in the v7.4 merge window (unlocked station-dump rework).
> 
> This was found during an assisted (AI-supported) static source review of
> mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); every code path cited below was re-verified by the
> reporter against that tree. The patch below has NOT been compiled and has
> NOT been runtime tested, and no reproducer was produced - the triggering
> conditions are described above instead. Please treat this as a report for
> verification rather than a battle-tested fix.
> 
> Fixes: [fill in before sending - on a full clone run:
>   git log -S '__nl80211_lock_held_wdev' --oneline -- net/wireless/nl80211.c]
> Reported-by: [your name and email]

I think you forgot to read the patch your LLM spit out :(

