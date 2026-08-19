Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91E33921E9;
	Wed, 19 Aug 2026 00:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787099301; cv=none; b=X6hq72KIETk/FJTOFY9ykjmyNvDYkCY37cXfT2mYl05xONMnUWQBrl0qVWi0yDrgeUvhkWGj5PYKWVremOthi/nXovAQe3jy0d6mhJyE5eNCeQbB/Mjih9/VNCdmmz67rWcQM7d54v7dEANMsw7RQY/SqctUpSEETL8XiU+dyFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787099301; c=relaxed/simple;
	bh=kv36DswoFlxv3TvSi8EtETmrfksSnjE5pjnUw2ijAuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1jY2+nba/Yv09VKaBZWC0VxZeg/qtIGT/LmnFzN/MrvKZrQlY4OGb8ZnIzohy3a/Q+j0jP5O4bOCWuetQjUSTK1WcuflzPsCUOJUQVSegE3SpixP7KVq3Y6NcLdJOGV/nLSUNQuMWZagdZPT7W3bogNPgJmy8Pf8xQx4SgT54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG0yCpWf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG0yCpWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175311F00A3A;
	Wed, 19 Aug 2026 00:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787099297;
	bh=lD2kirYp/t9LZ3alHnRberRGovRwNCftzBw42zPBJf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DG0yCpWffh37K0vzhQdyLQy7yIYrKihNwlRrUgBtoDecoCrAgxEfkZHSX/KGTMrgl
	 Jc/t/ySQy2oTa4el3NN6RMFoXBZE1NHDebZRgz//Cy97fIWQxXEAwRGMuYIOzH7+Ze
	 tssTT5uUOG9YNaPsqM5XCCRxxG07JKe+YDt1fQKBQp4P91qzJR4JX5w4ZO2DGCmCl2
	 xjHW9I+4NranEcMc4O7e688nh4E5046nW3njqzoOkGkBokstgONZnOwwNIb19bL0LN
	 PbhS3CIdeXXgPXiEzOLdDwR+Ob6DpA2PxByOjAQ0J8NpbvLnUPoiVtU3b3hhNGHJZ5
	 olCR1L0nKRXvQ==
Date: Tue, 18 Aug 2026 17:28:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v25 net-next 00/10] nbl driver for Nebulamatrix NICs
Message-ID: <20260818172815.5f2fc6b1@kernel.org>
In-Reply-To: <20260819001117.46785-1-illusion.wang@nebula-matrix.com>
References: <20260819001117.46785-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 08:11:02 +0800 illusion.wang wrote:
> This patch series represents the first phase. We plan to integrate it in
> two phases: the first phase covers mailbox and chip configuration,
> while the second phase involves net dev configuration.
> Together, they will provide basic PF-based Ethernet port transmission and
> reception capabilities.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.3,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed
