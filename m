Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE16C1A9F83;
	Tue,  9 Jun 2026 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971527; cv=none; b=nFJf3jdOJe29ygB+XRjxJZVK/UEDjtfIufHrjxmvVjE9N58cGAwkbrMhlsByQ8siM+vqZuKUKfA7sCSivnyUkYfRb5DfwtzHZYdbHdOu1m9p9NlBBhHvNVY1KqJGvc2fq9RcBhXNsNYY2dau6mzIdnKRqIqEpBRmm0NpdrduGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971527; c=relaxed/simple;
	bh=I9U9k115McmluyRZ0AfqMeLOQM9cvy+nwwPqE5zOj3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvY6g9Jt+xmmxkqONeTos6UgMap4Jz3IxNJ1QjDo/5hyrl+SzWxzH2Dh/sD/ngixR3zoBFCvo+A/nPDn3uHoG41ccZlggEPw/PWK5TB7kxZ/hLaPSuApwKr1jClQ+LxhuOb7g7qs8JUfFnjBuEqiYmV8Y8AVprLRlDHQt8zqBuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djnXbKzf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djnXbKzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5771F00893;
	Tue,  9 Jun 2026 02:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971526;
	bh=JtOK+WsH59Rk12yQhjznrdMTBaRsxDtA5Omclm8PG6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=djnXbKzfJR1ud1CIL3l7DpjvCirULDD5+gqLNT+/faeWOf1sxmuHwgM+SydH3CFM7
	 86vAZRsqj6osWRQUcYujMXk06YwApWRCNlrC6bNMH9r8dqUK8g1lqjAJN/4YqAGOLj
	 ePA82mbs5rgA+gva4fhRqvi05uh1GlGuy3ncmblg40BfH3BJVZmP/IRddsxYiFwzg5
	 8HjtuHMAqw1eEGWra2waWqycISoa6a2y8e60mCm3NL/UVgfJRBLlfWOIKoD62/Pq0u
	 LzQyT7p2WFU2N4vIEN38WvfHLElBKN6ATTW0qs78KV1vU0XY/Rk3x7xQqhQfD8rl9/
	 elICtMxfkeSbw==
Date: Mon, 8 Jun 2026 19:18:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org (open list:TC subsystem),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] net/sched: act_pedit: require matching IPv4 L4
 protocol
Message-ID: <20260608191845.72e968b7@kernel.org>
In-Reply-To: <20260607193621.1057618-1-sam.moelius@trailofbits.com>
References: <20260607193621.1057618-1-sam.moelius@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Jun 2026 19:35:46 +0000 Samuel Moelius wrote:
> The extended IPv4 L4 header mode in act_pedit can select TCP or UDP
> header fields without confirming that the IPv4 protocol field matches
> the selected transport header.
> 
> That lets a rule written for TCP or UDP modify unrelated payload bytes
> in a packet carrying a different protocol.
> 
> Verify that the IPv4 header is long enough, that the protocol matches
> the selected TCP or UDP header, and that the packet is not a non-initial
> fragment before applying TCP or UDP extended header edits.

This is a hardening patch?

It doesn't apply to either networking tree cleanly, please rebase on
net (if it's a fix) and net-next (if it's hardening) and repost
-- 
pw-bot: cr
