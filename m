Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B92D9EED;
	Sun, 30 Aug 2026 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123720; cv=none; b=OxIDvRg8fnWdHVoI+1fICjw38s9JXhIzo6QoC9VLRMvPtZ+fO6ZhlGY/JRGKJVTOorCxuwBNLZGI1J/lI6ovseF53Zh1+nmjVRoPEYxqimmg36PAa+Oarm1BrLpoiTQTGBRJ2UarSsXKfn/HTH7K2MmqXvKkCdqgp9fIhIEH3XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123720; c=relaxed/simple;
	bh=i0vSutcJOqVvvaTUul9QBwCduuTEQW+TygrzA2uq75Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EChGjg3YYewQzoW3fRnBIB2FRUBCB9n0v2h9pc21ckCBver/FRvmqqD7PsKcgyN068z5qws3febBgPYLUF1i7vwUfs62PFXiwhQN+BZiBOAZX+2EnltICYhRct8aILHl5QYPKuYac3oHisMbWQQ1Irkhxq3Eixjy+TKhjz08cuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhmnwR00; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhmnwR00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29E31F000E9;
	Sun, 30 Aug 2026 21:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788123718;
	bh=MXzghIUmgNd34BQfrUgvi7ZEPHjzVxB+L4fbNyof6pA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EhmnwR00DfQsZmKzIRdpzqjE4RF7Y2cHXHn6+e5WPTiViCQFgpPU5kGxe5IN8tSSg
	 ViaV3oPSwIgqpRnEnFh21LNtuolzZYUiG4w5XVsGcDoreiJqy3I9aP1Lr3koCxIfeV
	 zyoMCS9zMYGnzJm16piUXpGYpixgtJcahNhW0YYAs906ryyMQkseZu6JoHKtQhwPRF
	 HikhgGmX/JLddCALwuC6im3qA56gsrS88PUW/Sbr2M2r4ndEyKIO1x6vNryOvKxgUY
	 5cP2Z4kGgVIQQYyclolxK9TrLFr60KSbQaHsE8agvL9XIe2R9z20+kDuBDqTIP2oOi
	 ZTt06xiSk+twg==
Date: Sun, 30 Aug 2026 14:01:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Miguel Garcia <miguelgarciaroman8@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, jacob.e.keller@intel.com,
 syzbot+372a7d84708b07f64d9b@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net v2] devlink: request flash firmware without instance
 lock
Message-ID: <20260830140157.5de02f7e@kernel.org>
In-Reply-To: <20260830111700.1799255-1-miguelgarciaroman8@gmail.com>
References: <20260830111700.1799255-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Aug 2026 13:17:00 +0200 Miguel Garcia wrote:
> request_firmware() may enter the userspace fallback and call
> try_to_freeze(). Holding the devlink instance lock across that call
> triggers a lockdep warning and can block unregister for the duration of
> the firmware fallback.
> 
> Drop the instance lock around firmware loading in both flash update paths.
> The callers hold a devlink reference, which also pins the parent device.
> Recheck registration after reacquiring the lock before calling into the
> driver.

How did you find this issue? Nobody actually uses the user space
fallback, AFAIK? I'd just switch this to request_firmware_direct().
-- 
pw-bot: cr
