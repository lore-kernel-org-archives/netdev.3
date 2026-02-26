Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE57374180;
	Thu, 26 Feb 2026 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076693; cv=none; b=FxNuWfZlMTiMx9EF5zY/dJRBocXHwbCwoi5As04LSX9cfa0n48rkdNuPLCilaVb6HkSrsJO3mpyV0DE/jPDH2Bu2h76j3PfhY0hYPs2+4Q727d8LHo/+KQh3K3Ayesl3knuiftUoi/odtDKZU13vWAGuMQTULirHv7qH1ErKJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076693; c=relaxed/simple;
	bh=S9OWgfpyYGSyuYQoVFxt18Q6NmD4zFRCvKi1nyNjpts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+pWPIohxWAlhpWJThJkZa3XrSr4TNAMcKT4naPgq8ZXXQ6nqCguF8ATeFyFLbu46SJX0EkFLiUkODDiVhc0Whe2rQmRFFbEn+sajYJY9YYBoS/nOIBsehYTfPniOFDBnrNnST7cNtZ32KIg9MUQFC8sPgbUOJchtxkwvWPaneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyZ1IFKX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyZ1IFKX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F5FC116C6;
	Thu, 26 Feb 2026 03:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772076693;
	bh=S9OWgfpyYGSyuYQoVFxt18Q6NmD4zFRCvKi1nyNjpts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IyZ1IFKX+tqXGtMvnRwwweN+Qv/YPsMS5XTUU6N/3R+VQfxCRVi2YEXcN2skLR24j
	 o+exkEDzPWMXp+xDgJ4LPGAU2c/RpwhTDz3eNdf7wKntSO7nZ1ydNuaQKMrCbs9zB2
	 cOR3TR5BizlmWdFKGmNMJ/6aM7xf08pfaMEF5xfvdGOX6+drDUL9zNMEdtpm1Y5//8
	 zqH6XgwdknVxeP15aeN9W2DxrNSo9E2AW0DtpDTjZ3b0mqfxSxG/ZgbZcsqbSfk8DA
	 E7gTS0GeryXCkgDV3yNETXMeuUXOhCnT/WQ1M/b4L1Hn2PpgX9Z188wKspOoU2JgiA
	 z3IalCWEAgE3w==
Date: Wed, 25 Feb 2026 19:31:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][net-next] net/devlink: Move health recovery
 notification after abort check
Message-ID: <20260225193132.54bd2a34@kernel.org>
In-Reply-To: <20260225021003.1837-1-lirongqing@baidu.com>
References: <20260225021003.1837-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Feb 2026 21:10:03 -0500 lirongqing wrote:
> In devlink_health_report(), the DEVLINK_CMD_HEALTH_REPORTER_RECOVER
> notification is sent immediately after setting the error state, before
> checking if recovery should be aborted via devlink_health_recover_abort().
> 
> When devlink_health_recover_abort() returns true (e.g., due to rate
> limiting), the recovery process terminates early, but userspace has already
> received a notification implying that recovery is underway. This creates a
> misleading view of the reporter's activity.
> 
> Move the notification after the abort check, ensuring it is only sent when
> recovery will actually proceed. This aligns the notification with the
> actual recovery behavior.

Hm, we don't have solid documentation for this notification, but I
think it's supposed to be triggered on any change in the health state.
It's not just a notification that recovery has taken place.
devlink_health_reporter_state_update() for instance sends it whether
the update is healthy -> error or error -> healthy.
-- 
pw-bot: reject
