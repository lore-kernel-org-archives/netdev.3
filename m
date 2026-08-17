Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7D3F12CC;
	Mon, 17 Aug 2026 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009645; cv=none; b=QZf+RpkAhj2V/tLS0MPi7m3TQKckqlvkHayyfF4CqeR8sSfKELj8qFbEPMfQVAhl1fj8uYgi3dwC6by46D0btX/fh3lblfFHgdsoa/QaJsxow2PcmxLuLNaLY8i7n7JgL53InwSzXkHbJVVed+w/Huna9+qyQF3uwGuDF6uPO7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009645; c=relaxed/simple;
	bh=r9npoOSorp4F4r1O3JL+MjqHVjqWQZlZmd06vomJ7KY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aPfeApvGxa5k+Xjuh9fWxCNqTiVl4RwPGeAP9ETJFbp9ChDUHabjH+5CU8d1sztCveo6vqH990XTOy79QI/HhWBMhjDX/FiSkV+9dJ6GN2VRSc4XejRf8m1MdxKPLKf7vzT4svugNwpfFa7Di7IC6COQNJtUiYu8bS+7XHN60U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMKouV/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMKouV/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BFE1F000E9;
	Mon, 17 Aug 2026 23:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787009643;
	bh=1008LVQIQBAiQv+62u5BaP3MfZ+crjWtIHG6o0LED3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GMKouV/JjieP8Jq2kImEO99ZzRzpkFFL6vct3B1mdYHMP7cX2YYVcr6gVW6rB/YoH
	 VW9tqMwgEwQTnC0tcTnvVpc7JIk7zq6ft/xOl83GX4mBi5gPzDDnmEHSMhgzIcWFqv
	 3L67jIhh2hRtnFgrsROp0ebNXTWMCwRRu02qRGwbyWtx4u+Nw/S/J/lLSDgFdunyVE
	 dY2bEKw17iPHz4UtRNy7RNgwYjUSctg9GR02e8hkbnKHB55Z6btW6sGYCwIMJiwfjq
	 IVmwXKoukEuHLHnt8fJhpfuedRx3n4TJQ9FMqiMCRq6CEETD5Puvg9eo3EWKvC+N6C
	 bexSyrpgoZRpg==
Date: Mon, 17 Aug 2026 16:34:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Subrat Pandey <subratp@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>, <rkannoth@marvell.com>,
 <gakula@marvell.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH net v3 1/2] octeontx2-pf: Fix aura BPID assignment when
 CONFIG_DCB is enabled
Message-ID: <20260817163402.2a4dd252@kernel.org>
In-Reply-To: <20260812115258.773319-2-subratp@marvell.com>
References: <20260812115258.773319-1-subratp@marvell.com>
	<20260812115258.773319-2-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 17:22:57 +0530 Subrat Pandey wrote:
> +static u8 otx2_get_bpid_idx(struct otx2_nic *pfvf, int qidx)

needs to be "static inline" since it's in a header file
-- 
pw-bot: cr
