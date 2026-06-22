Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA331EEE6;
	Mon, 22 Jun 2026 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167974; cv=none; b=ILbKf8iJaYn47ctNIPvNvZtzAZE4sJA5M/4BpRyABDJJERMNy+kSz1ySipX1VPECcZXRMeW6bECQ5qUKTZ1LftLDVL8QrrGlmV2PKTaqUkAmd93+2D7W5oN2R3m2FSDi15vhkbfz+WHVh31ZvwNUWqIHV06RFdw6jXxxoj3wfUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167974; c=relaxed/simple;
	bh=0/OEe/QEc3h7DGHK14nkhOQy31GOGBBvKW82WWvhdbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xefdkj2aD9ahWQSCxrX0OfS9KF+8ZuCW5XxgTFIA5anXiGt5vXo8r8g8uKaDXUP97s5Aga+P+DJS0LKujRYG8j7xx4hesEiM43gRlRIHTy7FXzEQQsV5HFxXFPGhZlxNjLgE8c+Bb30RCI8EV2pzDVevoJ+3cur1HM5ZfXaMnN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTr+wqFe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTr+wqFe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFE81F000E9;
	Mon, 22 Jun 2026 22:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782167973;
	bh=0/OEe/QEc3h7DGHK14nkhOQy31GOGBBvKW82WWvhdbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bTr+wqFeVIJd2zyAA/DyfDxeephOei5nNn+Y71/KhxCam2xU18kXjdayS0bRhwXYD
	 3ZQgjxefUp5DlrapLsjqRwwZkzHSMRrrMVgAG7K9J6k5ncVveVTyB7nL6lGggABhIE
	 re2x7uvFuA24lv9xDgzTY8nAxyThQCtDqc7G9rRkZCqiNau5tgUAYVB0MpA9sr79SZ
	 q5uBX7bFXlT5m/mwtU3DsXW2XMRio91JF1HvGgFWlLPa9dJdqcK9rPUY0/U9dJKHl+
	 jx6796bcg+uXv2ZeRs1gl8r4tYFwHXTBKdk16H7iFk05rYRzIBkMiBUkNLewcZuzob
	 V1EK70anbgm5g==
Date: Mon, 22 Jun 2026 15:39:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 ecree.xilinx@gmail.com, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH net v2] sfc: Use acquire/release for irq_soft_enabled
Message-ID: <20260622153932.6a84a5d2@kernel.org>
In-Reply-To: <20260618091618.3874171-1-hanguidong02@gmail.com>
References: <20260618091618.3874171-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2026 17:16:18 +0800 Gui-Dong Han wrote:
> Subject: [PATCH net v2] sfc: Use acquire/release for irq_soft_enabled

Sorry, I'm not applying driver memory barrier ordering changes of this
complexity because some static analyzer thinks it's wrong. Please don't
repost this unless someone from solarflare asks you to.
