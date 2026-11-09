Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264337;
	b=nVpBPMTuCIble53zE0LaW8X6C783m0M1Y3XH3BkaEogAZaGPIS5BXBLydbC2ZYPgXBbP
	 HefS0ka9UfStG78iPVMFvhbCvvP2Tee4JofCq1DER3ZS5cK3mSufcxAizmaZVsa1G3the
	 GeLktG1+Mr7RB+Es8WRoie5ol46oZsJCPOAnwL2yX1cyv8jVmqdHLD//xjV59rdvXzHt1
	 cj9H5nb+HbYLlWOtqu3W7LRxgJ/pC0g8HtAfWPZSHs33Nb8dab1fIBVwiP1gbnoEFekkl
	 /5HFrfI/lKqaL8+iloofgN7JFz9UPJT+D7HnCh2jAp27tC9EET2ZqmSnFT8HXh9s0mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264337;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=h6aeX/U1bnE7aB2pfkoQSmz3NsjDsVyll8Kpf4skhbg=;
	b=Pu+qhqw6HVgTKCW6vL2rd+G6+cGkoPa4dA1klJtb0L0fRnphmZnTvZiINVKHQHVWy2Pk
	 +9hI2Q8K/VW1lqlgyOnmLYHfDb5K+fCTBZ79kigUCMeeWBMVBmGijdhiSssD2XXFu/utp
	 sXe4Tw3GeqTABNAzaLegpDzLBjBGmH2KHdDHIFHLsrt59HApm1AsfXn2hEVP2r0QElDlw
	 ZR28h1Dyxbdi9WL1N32RkjVPBxJ3RsqQZ3wef0d8fSeTdKNBeBnZsG7LLfLLPAif46MBc
	 IdPxnVwppBIK2QXEv8OXK0rtga3jA/doYBRseXbmq4soRS/RYrtlu8TS130C+H6tuiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCnr9S7l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64482606A325;
	Mon,  9 Nov 2026 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCnr9S7l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5EA1F0089F;
	Mon,  9 Nov 2026 22:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794264337;
	bh=h6aeX/U1bnE7aB2pfkoQSmz3NsjDsVyll8Kpf4skhbg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fCnr9S7lymyWAdX0j3bsa+QM/WOfQ12kL7jS13+r/p68d2x1qHJU36Lwmj3524uCP
	 XfqRQ5cnT0NZ+hadFQ7vqeH0ufMrItzZn8u0vbKV5ivwYT7hZQn0KhW+FaXvoGx+lr
	 jPdmw5rtJzOnY6BBud7yh8y8AmxZD/6mId29pbbXJuRGQCoSA5eOydwwKnRSxYUNk4
	 ZcQmo4D3S9elP0cf2ZmzlClphs0D8JjJlB2R6Pi+4Vn0+hv/RIx65F99nOug08DB3P
	 dw36UQVy2RmfNg6/+QxqU2u0aH6oKUXj1YyHqrcUJ5dstjXlbdWg1MX66YeWBqacNO
	 Lz9Na0DELPK/A==
Subject:
 Re: [PATCH] wifi: nl80211: clear wdev before erroring out of station dump
From: netdev-bot+sashiko@kernel.org
To: NoahWeinberger2003@proton.me
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org,
 kuba@kernel.org
Date: Mon, 09 Nov 2026 22:45:36 +0000
Message-ID: <179426433619.994134.16946925386661612679@kernel.org>
In-Reply-To: <ltwfLZuSH-PEFdqMECEU8rHwZCjSL5--7RG-qrW8a-Fwezdgpb1QYiDm-8aCRNIgwY-laqSmHJWAqV4uI092NLEudhWEABdd3B5iGsV4jJ8=@proton.me>
References: <ltwfLZuSH-PEFdqMECEU8rHwZCjSL5--7RG-qrW8a-Fwezdgpb1QYiDm-8aCRNIgwY-laqSmHJWAqV4uI092NLEudhWEABdd3B5iGsV4jJ8=@proton.me>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message is still a draft report, not a submittable
  patch.
- [Low] The commit fixes a real ERR_PTR dereference in
  nl80211_dump_station() (net/wireless/nl80211.c), but it has no usable…

--

wifi: nl80211: clear wdev before erroring out of station dump

This patch sets wdev to NULL in the -EAGAIN retry path of
nl80211_dump_station() when __nl80211_lock_held_wdev() returns an error
pointer. Without it, out_err calls wdev_put() on ERR_PTR(-ENODEV) when the
interface is removed while the dump is running.

> Fixes: [fill in before sending - on a full clone run:
>   git log -S '__nl80211_lock_held_wdev' --oneline -- net/wireless/nl80211.c]

[Severity: Low]
This Fixes: tag is still the template placeholder. Could it be filled in?

According to git blame on nl80211_dump_station() in net/wireless/nl80211.c,
the whole -EAGAIN retry block came from commit 599b8a3c549b. That block is
the __nl80211_lock_held_wdev() call, the IS_ERR() check and the
goto out_err. So the tag would presumably be:

Fixes: 599b8a3c549b ("wifi: cfg80211: support unlocked station get/dump")

The one-line code change itself looks right to me.
nl80211_lock_and_recheck() already calls wiphy_unlock() and put_device()
before it returns ERR_PTR(-ENODEV). With wdev = NULL and locked = false,
out_err then has nothing left to do.

> Reported-by: [your name and email]

[Severity: Medium]
This Reported-by: is also an unfilled placeholder. The trailers also have
no Signed-off-by: line.

Documentation/process/submitting-patches.rst requires a sign-off. Can the
patch be applied as it stands?

The log also has text that reads like a cover letter rather than a commit
message:

> Hello,

[ ... ]

> This was found during an assisted (AI-supported) static source review of
> mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); every code path cited below was re-verified by the
> reporter against that tree. The patch below has NOT been compiled and has
> NOT been runtime tested, and no reproducer was produced - the triggering
> conditions are described above instead. Please treat this as a report for
> verification rather than a battle-tested fix.

Could this text be dropped, or moved below the --- line?

> Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07), net/wireless/nl80211.c:9023-9035 (EAGAIN path), nl80211.c:296-306 (__nl80211_lock_held_wdev), nl80211.c:9133-9137 (out_err).

These file:line references only match a single rc snapshot, so they will
go stale. Could they be replaced with function names, or dropped?

The message says the change has not been compiled or runtime tested. Could
the respin be build tested, and add the sign-off at the same time?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/ltwfLZuSH-PEFdqMECEU8rHwZCjSL5--7RG-qrW8a-Fwezdgpb1QYiDm-8aCRNIgwY-laqSmHJWAqV4uI092NLEudhWEABdd3B5iGsV4jJ8%3D%40proton.me
