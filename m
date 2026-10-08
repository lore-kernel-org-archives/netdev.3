Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7D53328FD;
	Thu,  8 Oct 2026 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469157; cv=none; b=QOTbtqqiuj2DWtnlSFcYZ6NvrTsOIo41gn/ocfCpaJugtg0ARJiK3nz+/2tzaHNWIKmo4vGHx+AptuzMY8FWOj5J5/wPusKb+SHDzBm02hjNquYDq3Cet2UEhjfR1tnwd1Fk7UF6cgD8GjeQUa69RvK+2zc7FukCiOHA2WmC52s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469157; c=relaxed/simple;
	bh=+5RGssvc9D45JOYfE/hAmydJ9+Mwb2N4hypGNDqkb2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XoG0Ks1aMv4b9BjRGfUCAeJ5UKOtYEFolS3/Ov7eTENxwBExEsXOAC+Wj/mFmWsf5kSW+OXFhz1qioz+Q5zqc4MR+67glYM6voZqWSrXaj1z9wCFFgIrxIgpnlUAD77DKq493nHqc+ekQyjzUJU7ZFq/Z+wQKwmQj9U5JXwmWp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5kveWsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5kveWsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509CD1F000FF;
	Thu,  8 Oct 2026 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791469156;
	bh=gnzZocDc58pGi8A74Eaktq0CNcKrtOIGDjXGA3pwfqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=F5kveWsusKhpJAlQf9c7wPhZhDfWE0v1W1DPziRVSvanYT43u3QrxkMVjUM/dUiXt
	 XFBLvKtZd6pjamTBzvoYz7CG6g1fSdIRSoFC5MKKb63DJ6AofvH37X4FHpUl1rwLky
	 610uZ4qsqVIyGPOE3Rl5/7qZxixRAmfAdANrmOPtytLX5Gg/KwbzheBzVilwdzN4ek
	 yKPwEODf7HqVk/MumCHvtZVU11k2ndQN8YwVYjpCq4lYsAUc19WLsdC7culScJ0vmO
	 1t8v+9zvIWUKOWTbVetkxGw16J54hFsnfXhgJrn6htSdEFeZJ4ZZEviO0AoD44Jdik
	 TAbl3CKQ1dTHQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mike.marciniszyn@gmail.com,
 almasrymina@google.com, netdev-bot+sashiko@kernel.org
Subject: Re: [PATCH net v3 1/2] eth: fbnic: Preserve channels across resume
In-Reply-To: <179129269393.434549.14053731707723183539@kernel.org>
References: <20261002125617.409447-2-bjorn@kernel.org>
 <179129269393.434549.14053731707723183539@kernel.org>
Date: Thu, 08 Oct 2026 16:19:11 +0200
Message-ID: <87o6d41di8.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 2 =C2=B7 Medium: 0 (2) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] This patch makes resume fail outright when fewer MSI-X vectors
>   come back than before suspend, and the commit message describes that=E2=
=80=A6
> - [High] After one failed resume, num_napi stays 0 for good, and the next
>   open divides by zero and oopses.

Handling fewer IRQs is left for a separate patch, as noted in the commit
message and cover letter. I'll fix the "still fails" wording.

Hmm, you're right about num_napi. It now holds the configured channel
count, so clearing it on error is wrong. I'll drop that assignment. The
napi[0] check handles the freed vectors.

pw-bot: cr=20

> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but
>   __fbnic_pm_attach() calls fbnic_up() without holding rtnl or the=E2=80=
=A6
> - [Medium] This problem wasn't introduced by this patch, but
>   fbnic_service_task_stop() uses cancel_delayed_work(), which does not=E2=
=80=A6

Both medium issues are already present before this series. I'll keep
this series focused on the channel and queue-count fixes. These can be
handled separately.


Bj=C3=B6rn
