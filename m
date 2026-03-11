Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F399B3E316B;
	Wed, 11 Mar 2026 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773249121; cv=none; b=ZxMpDtSfVaZVDRhX+YkncEeExOCTu3pQVgN9WazlPV3WPNEL/xG6jwUshYnE/UE0a7zSi8qU/fxvoi7qp4p41RekLEpXdE3JWmo1CYOkJ8LiHEe62u6BjfQ27vUzgMS8QYIPxQzU6P70VKs6cuDFapyxg/GkIPHmQZ4w6YkI6TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773249121; c=relaxed/simple;
	bh=V1uzSJ0tCjKMzhK/Uuev8cSulP2s1ap+6ngofvlD4cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFAbdbe8kiSa6eClP1AdtYNomN+S4K1t940vunKS1/lH9ZENgu99TP31q17Tp+BusUdzZyxugSFT8i7fSCMVlR+sHrYvidT0THIWrf9Eu8RRjlfrwXMTpJit/POWRrgWU+Kbz0Q/ZMZ2mfrcK9xqK8ZefobUHcebfcbvR0Dl8U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sz67wQls; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sz67wQls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EF0C4CEF7;
	Wed, 11 Mar 2026 17:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773249120;
	bh=V1uzSJ0tCjKMzhK/Uuev8cSulP2s1ap+6ngofvlD4cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sz67wQlsCrIaZhIUfl5sQE2iri+uIzl1hwAyVZ5rykIUTb1RzXT6WHzJS6djC9mBE
	 6YAkBD1xZ933dPi18lTB7uCQmy2eo2OJI7dr49chjotIiNYOXi/VRiEImiBISHa6ug
	 9N/xNvj2uYrRxYlcPtG2FYL8qTOh2doSuRP9oLf8XYzUXbWhrsjgT2nPgTiyLJGmqx
	 zr1x6emDjo0TH/my0phF5R0zY2HRmJtmLghdjj+tJFyueDx2Qprk7WwYD+w+Z8Yj0H
	 ID5WjvTnf0WqM44n5h+BAsvpVucjJcP1ehkFKuCTWUd/OncSNE1XxUARfAL7VDZ05E
	 pOlTesVQfqX1Q==
From: Simon Horman <horms@kernel.org>
To: p@1g4.org
Cc: Simon Horman <horms@kernel.org>,
	edumazet@google.com,
	stable@vger.kernel.org,
	herbert@gondor.apana.org.au,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	steffen.klassert@secunet.com,
	chopps@labn.net,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [net] xfrm: iptfs: only publish mode_data after clone setup
Date: Wed, 11 Mar 2026 17:11:34 +0000
Message-ID: <20260311171134.1134085-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309173033.537743-1-p@1g4.org>
References: <20260309173033.537743-1-p@1g4.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
xfrm: iptfs: only publish mode_data after clone setup

iptfs_clone_state() stores x->mode_data before allocating the reorder
window. If that allocation fails, the code frees the cloned state and
returns -ENOMEM, leaving x->mode_data pointing at freed memory. The xfrm
clone unwind later runs destroy_state() through x->mode_data, so the failed
clone path tears down IPTFS state that clone_state() already freed. Keep
the cloned IPTFS state private until all allocations succeed so failed
clones leave x->mode_data unset.

> Fixes: 4b3faf610cc63 ("xfrm: iptfs: add new iptfs xfrm mode impl")

Should this Fixes tag point to 6be02e3e4f37 instead?

The original commit 4b3faf610cc63 added a simple iptfs_clone_state() function
that did not have the buggy allocation pattern. Commit 6be02e3e4f37 ("xfrm:
iptfs: handle reordering of received packets") added the reorder window
allocation code (xtfs->w_saved) to iptfs_clone_state(), but set x->mode_data
BEFORE the allocation, creating a use-after-free bug when the allocation
fails.

Suggested: Fixes: 6be02e3e4f37 ("xfrm: iptfs: handle reordering of received
packets")
