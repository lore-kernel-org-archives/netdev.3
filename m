Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBC327BF93;
	Thu, 30 Apr 2026 02:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777514701; cv=none; b=e4ThLvEbvk9s51caGS4yERqY1O+3iI7/2/I3Wu3PZV4d6RtFNeUq2KyiEDTnnj4kCv9bnwY7/jkGzOGmHZTUiyaK37hXKDk4M2tzNHSwuqndmcbrteGLuqgEjUrhYyCvIc1uSmGTUrT+LF9HSELOIVtLB7vNyVVE6TBRbz8vXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777514701; c=relaxed/simple;
	bh=hRqndlOLDll9gScRv5wl9D6Ni7/C8bKxzDQkijRq88c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXidqwvMc13kjA/ud+QVaoiaC6v1Eho9eOLJd7PPPiuTkRm/VdbcQKeXJZ3lg2ZrpSWP+GSK2WO5fi24+/K2j40MtkFFhWOnt2c4MJ5vniM8TsVg+ITimPFAsrNp7+g3rilyQKxwn4RjvWquiaC7skLOQmvh2YEMkCptxBYjzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCBRm53K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCBRm53K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB86C19425;
	Thu, 30 Apr 2026 02:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777514700;
	bh=hRqndlOLDll9gScRv5wl9D6Ni7/C8bKxzDQkijRq88c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JCBRm53Kgcb5kXDIpsuTLji7Sf7w9JOA//nniSdeWBQqH4g9b8XZVsfFf4GsNpfIh
	 Vb1jKtcE4LKlhBYfhHBhbkYgz0DietnKs5jjx/w6Druhnd2O7gdkGzODXOatHE7IOx
	 kHQ711LQc3wZnfxDm5sq6Djj93G71Z7noMPqpcFxYUsZEBgEFlmEuGFvoOPiEKZo5Y
	 Ifdt6FpRMyUcLRbI//6HimGKDGueTtMmGbNwZ6w+zQkS5yO9mfeNLU2Ll/dIEFJT8Q
	 6rPrzvlBJkYLIL8sj76GDqolPCT3cUplgKbTPLwSDjTtP2X1mHN6Yka72twzpE7TQg
	 EGwOsS1L7kkCw==
Date: Wed, 29 Apr 2026 19:04:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 oe-linux-nfc@lists.linux.dev
Subject: Re: [PATCH net] MAINTAINERS: Add myself as NFC subsystem maintainer
Message-ID: <20260429190459.48c7b8be@kernel.org>
In-Reply-To: <20260428-nfc-maintainer-v1-1-4cb9d9e121f3@ixit.cz>
References: <20260428-nfc-maintainer-v1-1-4cb9d9e121f3@ixit.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 16:24:38 +0200 David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Add myself and update the mailing list.

Applied! :)
