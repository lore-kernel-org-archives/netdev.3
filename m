Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116013446CB;
	Sun, 26 Apr 2026 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777192856; cv=none; b=bOHb8j14V3Hb++PuCDUiWCXHa0MOtOJy+oKqBJ9F07KQIFUbaS10j7QanDigci8aTmrbLWI0hLWEbJcEGYefpIluUE6i2lHzsBFAEbYWXYkds9rxqs/irTamTvNKS8jbbnd+fvGVL0r+4Qjy29JdtskkOC8bHKoAY7Qzy8rD2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777192856; c=relaxed/simple;
	bh=jstE+0TWEHYXMbkodY9KAocX6uAwt25GVmCScLsb5g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVhiZodkXm0LO/PVm1vh5Fc+1+1t97sst9DIVKxuENfq3mwQbdNrGTUnJuDm/KzM39xtBt6PETn/dYpyyp9/QCOy1KTwAFyPcBa+8KKFH1J65aGn0Zv4iCX2bV2IbS5u3427TCgbc13XFcb+SlX8VyHPWmUxi8f6s4ur5PANqF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+zBZW8B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+zBZW8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0915DC2BCB4;
	Sun, 26 Apr 2026 08:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777192855;
	bh=jstE+0TWEHYXMbkodY9KAocX6uAwt25GVmCScLsb5g8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+zBZW8Bda8P2B2WpK7eAuG5myNURWpgSOhWRjUPtXGG+mcyzVniDLmsNYrahRTyb
	 Xf3u8IMsUFc75kTr3zoWcdp1uFS3TSkLG4Smc7Gt656V2NMv1ELN8kLQSkqBZ1Fqrf
	 rFGpi5KFjo3e01JsFbG1qFsGKAb0fgNuE4NhsNOAgRZdV/8Z6HdL38JqR2yom2kWQQ
	 eKMEGQSuefraPhbvSd9oF6nSi+cAmATGCVGW0qQcfaW1ZKbnQKs18/jgq/elTNJFJI
	 1UMpkM3qkB11XI71bGUmbuHTeuhm083CcWM2G0iFXpKGVU64K/U2uyYJtkh4mYpk8v
	 iAfJ30uTg3vMA==
From: Simon Horman <horms@kernel.org>
To: leitao@debian.org
Cc: 'Simon Horman' <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	k-keiichi@bx.jp.nec.com,
	satyam@infradead.org,
	akpm@linux-foundation.org,
	thepacketgeek@gmail.com,
	asantostc@gmail.com,
	gustavold@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net 3/3] netconsole: propagate device name truncation in dev_name_store()
Date: Sun, 26 Apr 2026 09:39:05 +0100
Message-ID: <20260426083904.1130399-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423-netconsole_ai_fixes-v1-3-92b8b7de9a2c@debian.org>
References: <20260423-netconsole_ai_fixes-v1-3-92b8b7de9a2c@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
netconsole: propagate device name truncation in dev_name_store()

This commit rejects interface name writes that exceed the size of the
destination buffer to avoid silently truncating names and binding to
unintended devices.

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 4bef003d9df64..3914fb90f9afd 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -816,6 +816,9 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
>  {
>  	struct netconsole_target *nt = to_target(item);
>  
> +	if (count >= IFNAMSIZ)
> +		return -ENAMETOOLONG;
> +

Does this check incorrectly reject valid maximum-length interface names when
written with a trailing newline?

Standard userspace tools like echo append a trailing newline when writing to
configfs attributes. If userspace writes a 15-character name, the count will
be exactly 16 bytes.

Since IFNAMSIZ is 16, the condition count >= IFNAMSIZ evaluates to true,
causing dev_name_store() to reject the valid input with -ENAMETOOLONG.

Prior to this patch, strscpy() safely truncated the trailing newline by
copying the 15 characters and a NUL terminator.
