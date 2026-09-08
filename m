Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248623507B;
	Tue,  8 Sep 2026 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900037; cv=none; b=QRLxkDT/O0X+WP4rM0UUaulzcUBXvvlsK0SvZiXd5ij7eFkNJUrW3eN+NGHjLHfKciyadtG0epDqrxe9ZlvIcXdXNm0VkAhJQUxl2sLBzrjYX3IhxTE4G23sjIOVaMab/UDeXrV4LuMjs3zXPTtv+MeQCWY+BMK4JihFxn6TBWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900037; c=relaxed/simple;
	bh=Ss93J/8EbMVt2vkJwkChegaPEjEjz4i+QNqfsSn9gS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMSL2vdsLnt5GC3IT9XV2vmXy7Y//Z2tta6gwT04mLD+jPlf5DGqaCZb8bx3FvrVCLY6UyI7IJ0BLDgvUU8M0r2NCiJ7dfoN3kJwc/pw1T8ziDVwJKgJdW2RlDBm8jmkIi5FScY0y1ZBjgQnn2JgSLjUM5Lf6PKs8em2/KDu3k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Evdo/wa+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Evdo/wa+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6901F00A3A;
	Tue,  8 Sep 2026 20:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900035;
	bh=+nL20GL20N0hmfHYzmA3AYONzYIM2k86Zkd55y524x4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Evdo/wa+YMPnE1CPNuNIMJ2OYDKlKtod81MrMeARVK3RS0vFqs7FuD2SI4Kun8pyL
	 hQjnG/mAZmIL9hMLtSFJnxXf5uf2yOB3m2YP3+e0R6fnN7D4ZTAYUzKow8FoScvCMt
	 l9A/taFk2bMzTcOKurpwdtG9IN1HT22//jG/zBB1HTr1VDNbkMImTYKcJ5x57oBmzX
	 Mppr3aFckiQeNNTTOQpyPD7d7SYgISlYZGsUWIYIqpc0EE9wpinesXnStBYbgcNlbq
	 dQj6QtX5Z0Oxz3BdxB4V3oM/H6sbCSr5Eqj5vL4jvR7w4ro5+h7RDOI4TpzzxB+/Ah
	 /TO7PFPbZvm8w==
Date: Tue, 8 Sep 2026 13:40:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 oss-drivers@corigine.com, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfp: reject truncated hwinfo table
Message-ID: <20260908134034.792ea77f@kernel.org>
In-Reply-To: <20260908005437.11004-1-devnexen@gmail.com>
References: <20260908005437.11004-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Sep 2026 01:54:37 +0100 David Carlier wrote:
> hwinfo_db_validate() only bounds db->size from above, so a firmware
> table advertising size < sizeof(*db) + sizeof(u32) makes the following
> "size -= sizeof(u32)" underflow and crc32_posix() read far out of
> bounds. Reject such tables before the subtraction.

AFAIU it's okay to assume that PCIe devices are not malicious
Let's not waste time with these sort of "fixes"
-- 
pw-bot: reject
