Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A82F3C18;
	Wed, 12 Aug 2026 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786578118; cv=none; b=pNH2cCNMHdD+tqdeaHyES3nyTNl9RtHsKS2EQNGVpFoj4pzd5dra/NPZyHz1CQK3Pus6l5cA86iy1dg4ZHsmd5yKYTiRbrt9OUQfMZyw5mdjAH7Ru6huKvkA1JgLw0Vh1CXOfDvJX5WKG6IJWLAFdLRtrBXb1iuHb/vXSAipB9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786578118; c=relaxed/simple;
	bh=xFnGrvCoC/YE2ei5ksOyWUjYhOiP6V931hhaVsasusw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWNDZhtWxzvgxNrGAB/LYl8067vZPmKewhZ9ESHjdzSvEV3un6+xJyaUpf1yxIiwaSinoyfPx+9rDfYgJ7a1KESGhq1spUfqw9vuBlhKp71jmqSv2IcC9Hc4rO8ACK8SHzNI9QxeslJZqn9PP0AldoLAaqJgwAaSuK883LSC0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETqMDDM5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETqMDDM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6F21F000E9;
	Wed, 12 Aug 2026 23:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786578117;
	bh=haeYXV0BtsjZPfFuDcwbMGXZizvy4myHK59C1/le4bE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ETqMDDM5XPE6jCcZGZO5dEQGSz2x+kQoWzDaxt+yDPtY02//AOdvg/+U0N4RcJzeY
	 cBTRGs7QGRW84SXppQ44l5T6vuOwrqRWjjniCfOZ7Tfhk+DFqGK9XZzJtbkdfTT+9u
	 0yCQ5PXcpCWJXMgzyG8LLmmcnWPT/o39ME7MQ4/OlOaMgVHesbywsnVXB1Pr3aPMCk
	 R/TZAqc8hirXxfK7A10mzy9QlajIrTdTETVM54ZH1W0fluS/yZFyVRBuhphBidrawY
	 HN+If4QlWTgd4p1qFzVYRSUjLFrRRhudJQCzyug1z6ct+tetod1J+h8unwbh39alYI
	 D/TOEIcrA5/ew==
Date: Wed, 12 Aug 2026 16:41:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wang Zhan <wang.zhan@smartx.com>
Cc: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, keyong.sun@smartx.com,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] openvswitch: enable ops lock for internal
 ports
Message-ID: <20260812164156.6bde8f4e@kernel.org>
In-Reply-To: <20260812123003.3634034-1-wang.zhan@smartx.com>
References: <20260812123003.3634034-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 20:30:03 +0800 Wang Zhan wrote:
> Open vSwitch internal ports currently use RTNL as their ops compatibility
> lock. Opt them in to netdev instance locking so eligible control operations
> can be serialized per device instead of contending on the global RTNL lock.
> 
> The internal port ethtool operations implement get_drvinfo and get_link.
> The latter uses ethtool_op_get_link(), which synchronizes linkwatch state
> and requires RTNL. Allow get_drvinfo to run under the instance lock, but
> set ETHTOOL_OP_NEEDS_RTNL_GLINK to retain RTNL for get_link.
> 
> Feature synchronization can acquire a lower device's ops lock while holding
> an internal port's lock. Assign these software upper devices a distinct
> lockdep class to describe the nesting.

Why are you sending this patch? Do you have an actual real life need
for unlocked get_drvinfo??
