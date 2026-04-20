Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C63A380B;
	Mon, 20 Apr 2026 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691284; cv=none; b=OwWPUV2nWj16oWT89Z+vcBj2aHpiS/yThgkcD+Z1C9/qAhBO5raJYgkNTMx/iP0SesHQbJafsSa9VUONMfAoH0Vsc2T5c1mbGEa+A2lTyxUSnwFkd6Gx8j0D4eItN5tmJRtnv5z5uiixWOmpg7vfWYMwGPjMlN0s/jAG0wjlB1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691284; c=relaxed/simple;
	bh=cJAqQnfgPXa28vqoxI/T0p+NIPE7QoumqsMgAEtT2cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFjoXVARHflfaSh0XT8l0AUpT5oJsTS2PYUq8phTwUQ7OX6VDcPVlbKzOxYntRiyQpexQyMNTGEzyRiYsEEr1aUfK3A+Ety8pfxzf6zjlxE5+qTJ8v2XRuhc9QfHcOGqBWB7XTT4pE05tGXjlOZFN+p3JvyMiHV9g+YWqYq685Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAu0hTTs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAu0hTTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11249C2BCB4;
	Mon, 20 Apr 2026 13:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691284;
	bh=cJAqQnfgPXa28vqoxI/T0p+NIPE7QoumqsMgAEtT2cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pAu0hTTsSWm9a96ekDPLeqXY7Iw2/rYkZ+Tx+Qd2/xcNf5nqQxJ3UqKbe3BoIXJTn
	 VFxFtQvdONvHrnbqhYjv/GetWNaolVdcgtpjsS3kR46zAa2sORAsdSQR6HqXG6XzuK
	 uz+s1bu1TrqtQTiDNcb32x5nMRe50bwBvsxGBFWrYAa85fUsgzExTYosGd/PbB5ktO
	 Dfd2ZtGe9SkMOFQrRXR4QwgALYWCUnHCcg/aS7D3AkNlve1I/zwD8lEr9xC0dbHKqO
	 PzmL+vM4SHlPavNjiQY/z+5jYktrGTDwSoqQdx3yPkAbhWUn1k1WAEcWMEnqB/c+Uf
	 mwe1MdQE3KY+w==
From: Sasha Levin <sashal@kernel.org>
To: XiaoHua Wang <561399680@139.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6.y/6.1.y] net: add proper RCU protection to /proc/net/ptype
Date: Mon, 20 Apr 2026 09:21:05 -0400
Message-ID: <20260420-stable-reply-net-ptype-6-6-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414121118.4227-1-561399680@139.com>
References: <20260414121118.4227-1-561399680@139.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Apr 14, 2026, XiaoHua Wang wrote:
> Backport of f613e8b4afea ("net: add proper RCU protection to
> /proc/net/ptype") to 6.6.y and 6.1.y.

Queued for 6.6 and 6.1, thanks.

--
Thanks,
Sasha
